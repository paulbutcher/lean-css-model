/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Gen.Emit
import Lean.Data.Json

/-! Generates `CssModel/Generated` from the vendored `@webref/css` data, and with `--check`
reports whether the checked-in files are what it would generate. -/

open Lean Gen Std

def dataPath : System.FilePath := "webref/css.json"

def outDir : System.FilePath := ".." / "CssModel" / "Generated"

def reportPath : System.FilePath := "untranslated.txt"

/-- Types the data defines only in prose, given the definitions their specifications state. -/
def proseOverrides : List (String × String) :=
  [("family-name", "<string> | <custom-ident>+"),
   ("top", "<length> | auto"), ("right", "<length> | auto"),
   ("bottom", "<length> | auto"), ("left", "<length> | auto"),
   ("margin-width", "<length-percentage> | auto"),
   ("padding-width", "<length-percentage [0,∞]>"),
   ("age", "child | young | old"), ("gender", "male | female | neutral"),
   ("font-src-list", "<font-src>#"),
   ("generic-family", "<generic-font-family>"),
   ("timeline-range-name", "normal | cover | contain | entry | exit | entry-crossing | exit-crossing"),
   ("id", "<id-selector>"),
   ("voice-family-name", "<string> | <custom-ident>+"),
   ("size-keyword", "auto | min-content | max-content | fit-content | stretch")]

/-- At-rules whose descriptors are typed as tables of their own; media and container features
are tables of their own too. -/
def descriptorRules : List String :=
  ["@font-face", "@counter-style", "@property", "@page", "@font-palette-values", "@color-profile",
    "@view-transition", "@font-feature-values", "@function"]

def str (j : Json) (k : String) : Option String := (j.getObjValAs? String k).toOption

def arr (j : Json) (k : String) : Array Json := (j.getObjValAs? (Array Json) k).toOption.getD #[]

def scopesOf (j : Json) : List String := ((j.getObjValAs? (Array String) "for").toOption.getD #[]).toList

def isObsolete (j : Json) : Bool := (str j "prose").any (·.contains "obsolete")

def stripParens (s : String) : String :=
  if s.endsWith "()" then String.ofList (s.toList.dropLast.dropLast) else s

structure Entry where
  css : String
  result : Except String V

structure Table where
  type : String
  doc : String
  entries : Array Entry
  ranges : Array Bool := #[]

def runM (env : Env) (st : State) (m : M α) : Except String (α × State) := (m.run env).run st

def main (args : List String) : IO UInt32 := do
  let check := args.contains "--check"
  let json ← IO.ofExcept (Json.parse (← IO.FS.readFile dataPath))
  let mut report : Array String := #[]
  let parseOr (s : Option String) : IO (Option Gen.Term) := do
    match s with
    | none => pure none
    | some s => match Gen.parse s with
      | .ok t => pure (some t)
      | .error _ => pure none
  -- Definitions.
  let mut types : HashMap String (List Def) := {}
  for t in arr json "types" do
    let name := (str t "name").getD ""
    let body ← parseOr (str t "syntax")
    types := types.insert name (types.getD name [] ++ [⟨name, scopesOf t, body⟩])
  let mut functions : HashMap String (List Def) := {}
  for f in arr json "functions" do
    let name := stripParens ((str f "name").getD "")
    let body ← parseOr (str f "syntax")
    functions := functions.insert name (functions.getD name [] ++ [⟨name, scopesOf f, body⟩])
  let mut properties : HashMap String Gen.Term := {}
  let mut propertyList : Array (String × Option String) := #[]
  for p in arr json "properties" do
    let name := (str p "name").getD ""
    propertyList := propertyList.push (name, str p "syntax")
    if let some t ← parseOr (str p "syntax") then properties := properties.insert name t
  let mut overrides : HashMap String Gen.Term := {}
  for (n, s) in proseOverrides do
    overrides := overrides.insert n (← IO.ofExcept (Gen.parse s))
  let env : Env := { types, functions, properties, overrides }
  let mut st : State := {}
  -- Properties.
  let mut propEntries : Array Entry := #[]
  for (name, syntax?) in propertyList do
    match syntax? with
    | none => report := report.push s!"property {name}: no syntax in the data"
    | some s =>
      match Gen.parse s with
      | .error e => report := report.push s!"property {name}: {e}"
      | .ok t =>
        let (r, st') ← IO.ofExcept (runM env st (translate name t))
        st := st'
        match r with
        | .ok v => propEntries := propEntries.push ⟨name, .ok v⟩
        | .error e => report := report.push s!"property {name}: {e}"
  -- Descriptors.
  let mut tables : Array Table := #[]
  for rule in arr json "atrules" do
    let rname := (str rule "name").getD ""
    let typeName? :=
      if rname == "@media" then some "MediaFeature"
      else if rname == "@container" then some "ContainerFeature"
      else if descriptorRules.contains rname then
        some (capitalize (camel (String.ofList (rname.toList.drop 1))) ++ "Descriptor")
      else none
    let descs := arr rule "descriptors"
    match typeName? with
    | none =>
      for d in descs do
        report := report.push s!"descriptor {rname} {(str d "name").getD ""}: at-rule not modelled"
    | some typeName =>
      let mut entries : Array Entry := #[]
      let mut ranges : Array Bool := #[]
      for d in descs do
        let dname := (str d "name").getD ""
        match str d "syntax" with
        | none => report := report.push s!"descriptor {rname} {dname}: no syntax in the data"
        | some s => match Gen.parse s with
          | .error e => report := report.push s!"descriptor {rname} {dname}: {e}"
          | .ok t =>
            let (r, st') ← IO.ofExcept (runM env st (translate s!"{rname}/{dname}" t))
            st := st'
            match r with
            | .ok v =>
              entries := entries.push ⟨dname, .ok v⟩
              ranges := ranges.push (str d "type" == some "range")
            | .error e => report := report.push s!"descriptor {rname} {dname}: {e}"
      tables := tables.push { type := typeName, doc := s!"A descriptor of `{rname}`.", entries, ranges }
  -- Function arguments, which may reach further functions.
  let (failures, st') ← IO.ofExcept (runM env st translateVariants)
  st := st'
  for (what, e) in failures do report := report.push s!"function {what}: {e}"
  -- Selectors.
  let mut pseudoClasses : Array String := #[]
  let mut pseudoElements : Array String := #[]
  let mut pcFunctions : Array String := #[]
  let mut peFunctions : Array String := #[]
  let elementNames := (arr json "selectors").filterMap fun s =>
    (str s "name").filter (·.startsWith "::") |>.map (String.ofList ∘ List.drop 2 ∘ String.toList)
  for s in arr json "selectors" do
    let name := (str s "name").getD ""
    if isObsolete s then
      report := report.push s!"selector {name}: marked obsolete"
    else if name.startsWith "::" then
      let n := String.ofList (name.toList.drop 2)
      if n.endsWith "()" then peFunctions := peFunctions.push (stripParens n)
      else pseudoElements := pseudoElements.push n
    else if name.startsWith ":" then
      let n := String.ofList (name.toList.drop 1)
      if elementNames.contains n then
        report := report.push s!"selector {name}: the legacy spelling of ::{n}"
      else if n.endsWith "()" then pcFunctions := pcFunctions.push (stripParens n)
      else pseudoClasses := pseudoClasses.push n
  -- Names. Keywords are ordered by name so that additions to the data move few indices.
  let kwKeys := st.keywordOrder.toList.mergeSort (· ≤ ·)
  let kwKeys := (kwKeys ++ (["inherit", "initial", "unset", "revert", "revert-layer"].filter
    (!kwKeys.contains ·))).mergeSort (· ≤ ·)
  let kwSpellings := kwKeys.map fun k => st.keywords.getD k k
  let kwLean := assignNames kwSpellings
  let kwMap : HashMap String String := (kwKeys.zip kwLean).foldl (fun m (k, l) => m.insert k l) {}
  -- Functions and blocks: plain names where a CSS name has one variant.
  let vs := st.variants
  let cssCount : HashMap String Nat := vs.foldl (fun m v => m.insert v.css (m.getD v.css 0 + 1)) {}
  let strip (s : String) : String := String.ofList (s.toList.filter fun c => c != '<' && c != '>' && c != '@' && c != '(' && c != ')' && c != '\'')
  let wanted := vs.toList.map fun v =>
    if v.css == "" then
      if v.whole then strip v.owner
      else strip v.owner ++ (if v.bracket == .brackets then "-brackets" else "-parens")
    else if cssCount.getD v.css 0 == 1 then v.css
    else if v.canonical then (if v.owner == "" then v.css else strip v.owner ++ "-" ++ v.css)
    else if v.whole then strip v.owner
    else if ((strip v.owner).splitOn v.css).length > 1 then strip v.owner
    else strip v.owner ++ "-" ++ v.css
  let fnLean := assignNames wanted
  -- Variants with equal arguments accept each other's components.
  let sameAs : Array (List Nat) := vs.mapIdx fun i v =>
    (List.range vs.size).filter fun j =>
      j == i || (vs[j]!.css == v.css && vs[j]!.bracket == v.bracket && vs[j]!.translated == v.translated)
  let expandAtom (a : Atom) : Atom :=
    { a with functions := (a.functions.flatMap fun i => sameAs[i]!).mergeSort (· ≤ ·) |>.eraseDups }
  let rec expand : V → V
    | .atom a => .atom (expandAtom a)
    | .seq xs => .seq (xs.attach.map fun ⟨x, _⟩ => expand x)
    | .oneOf xs => .oneOf (xs.attach.map fun ⟨x, _⟩ => expand x)
    | .allOf xs => .allOf (xs.attach.map fun ⟨x, _⟩ => expand x)
    | .someOf xs => .someOf (xs.attach.map fun ⟨x, _⟩ => expand x)
    | .opt x => .opt (expand x) | .star x => .star (expand x) | .plus x => .plus (expand x)
    | .rep lo hi x => .rep lo hi (expand x) | .atLeast lo x => .atLeast lo (expand x)
    | .commaList x => .commaList (expand x) | .commaRep lo hi x => .commaRep lo hi (expand x)
    | .nonEmpty x => .nonEmpty (expand x)
  -- Named symbols, for the types whose whole definition is one symbol.
  let namedAtoms := st.namedAtoms.toList.map fun (n, a) => (expandAtom a, n)
  let namedAtoms := namedAtoms.foldl (fun acc (a, n) =>
    if acc.any (·.1 == a) || a.keywords.length + a.functions.length < 3 then acc else acc ++ [(a, n)]) []
  let atomLean := assignNames (namedAtoms.map (·.2))
  let names : Names := {
    keywords := kwMap, functions := fnLean.toArray,
    atoms := namedAtoms.zip atomLean |>.map fun ((a, _), l) => (a, l) }
  -- Files.
  let mut files : Array (String × String) := #[]
  let kwExtra := s!"\n/-- Every keyword, as `Sym.keywords` holds them. -/\ndef allBits : Nat := 2 ^ {kwKeys.length} - 1\n"
  let brackets := vs.toList.map fun v => match v.bracket with
    | .function => ".function" | .parens => ".parens" | .brackets => ".brackets"
  let fnExtra := "\n/-- How the variant's arguments are enclosed. -/\ndef brackets : Array Bracket := #[\n  " ++
    ",\n  ".intercalate brackets ++ "]\n\ndef bracket (f : Func) : Bracket := brackets[f.id]?.getD .function\n"
  files := files.push ("Names.lean", header [] "Keywords and functions, generated from `@webref/css` by `gen`." ++
    "/-- How a function variant's arguments are enclosed: `name( ... )`, `( ... )`, or `[ ... ]`. -/\n" ++
    "inductive Bracket where\n  | function | parens | brackets\n  deriving DecidableEq, Repr\n\n" ++
    emitTable "Keyword" "A keyword some grammar admits. Keywords are ASCII case-insensitive; each is spelled as the data first spells it." kwSpellings kwLean kwExtra ++
    emitTable "Func" "A function or block, by its argument grammar. Where a function has one grammar it bears the function's name; where it has several, each is named after the definition it appears in, such as `trackSizeMinmax` for the `minmax()` of `<track-size>`." (vs.toList.map (·.css)) fnLean fnExtra ++ footer)
  -- Known ranges.
  let rangeFor (f : String) : List Range :=
    (st.ranges.toList.filter (·.1 == f)).map (·.2) |>.filter (· != allRange) |>.eraseDups
  let knownRanges := "/-- The ranges the grammars restrict each numeric type to, from which a literal's default\nrange is drawn. -/\ndef knownRanges : NumericKind → List Range\n" ++
    String.join (numericFields.map fun f => s!"  | .{f} => [{", ".intercalate ((rangeFor f).map rangeLit)}]\n")
  files := files.push ("Atoms.lean", header ["CssModel.Kind"] "Symbols for types whose whole definition is one, generated by `gen`." ++
    "namespace Atoms\n\n" ++ String.join (names.atoms.map fun (a, l) =>
      s!"def {l} : Sym := {atomLit { names with atoms := [] } a}\n\n") ++ "end Atoms\n\n" ++ knownRanges ++ "\n" ++ footer)
  -- Functions.
  let fnVs := vs.toList.map fun v => expand (v.translated.getD (.oneOf []))
  files := files.push ("Functions.lean", header ["CssModel.Vds", "CssModel.Generated.Atoms"]
    "The argument grammar of each function variant, generated by `gen`." ++
    emitSyntax "Func" names fnLean fnVs ++ footer)
  -- Properties.
  let propCss := propEntries.toList.map (·.css)
  let propLean := assignNames propCss
  let propVs := propEntries.toList.map fun e => match e.result with
    | .ok v => expand v
    | .error _ => .oneOf []
  files := files.push ("Properties.lean", header ["CssModel.Vds", "CssModel.Generated.Functions"]
    "Properties and their grammars, generated by `gen`." ++
    emitTable "Property" "A property whose grammar the data gives and `gen` could translate." propCss propLean ++
    emitSyntax "Property" names propLean propVs ++ footer)
  -- Descriptors.
  let mut descText := ""
  for t in tables do
    let css := t.entries.toList.map (·.css)
    let lean := assignNames css
    let vs := t.entries.toList.map fun e => match e.result with
      | .ok v => expand v
      | .error _ => .oneOf []
    let extra := if t.type == "MediaFeature" || t.type == "ContainerFeature" then
        "\n/-- Whether the feature is a range feature, which admits range syntax and `min-` and `max-`\nprefixes. -/\ndef ranges : Array Bool := #[" ++
          ", ".intercalate (t.ranges.toList.map toString) ++ "]\n\n" ++
          s!"def isRange (f : {t.type}) : Bool := ranges[f.id]?.getD false\n"
      else ""
    descText := descText ++ emitTable t.type t.doc css lean extra ++ emitSyntax t.type names lean vs
  files := files.push ("Descriptors.lean", header ["CssModel.Vds", "CssModel.Generated.Functions"]
    "At-rule descriptors, media features and container features, generated by `gen`." ++ descText ++ footer)
  -- Selectors.
  let pcl := pseudoClasses.toList
  let pel := pseudoElements.toList
  files := files.push ("Selectors.lean", header [] "Pseudo-classes and pseudo-elements, generated by `gen`." ++
    emitTable "PseudoClass" "A pseudo-class that takes no arguments." pcl (assignNames pcl) ++
    emitTable "PseudoElement" "A pseudo-element that takes no arguments." pel (assignNames pel) ++
    emitTable "PseudoClassFunction" "A functional pseudo-class." pcFunctions.toList (assignNames pcFunctions.toList) ++
    emitTable "PseudoElementFunction" "A functional pseudo-element." peFunctions.toList (assignNames peFunctions.toList) ++
    footer)
  report := report ++ st.notes.toList.eraseDups.toArray
  let reportText := "\n".intercalate report.toList ++ "\n"
  -- Write or compare.
  let mut stale := false
  for (name, text) in files.push ("../../gen/untranslated.txt", reportText) do
    let path := outDir / name
    if check then
      let current ← (IO.FS.readFile path).toBaseIO
      match current with
      | .ok c => if c != text then
          IO.eprintln s!"{path} is out of date"
          stale := true
      | .error _ =>
        IO.eprintln s!"{path} is missing"
        stale := true
    else
      IO.FS.writeFile path text
  IO.println s!"{propEntries.size} properties, {kwKeys.length} keywords, {vs.size} function variants; {report.size} entries reported in {reportPath}"
  return if stale then 1 else 0
