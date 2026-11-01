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

/-- What every `<custom-ident>` excludes, by CSS Values and Units Level 4 §4.2. -/
def customIdentBase : List String := ["default", "inherit", "initial", "revert", "revert-layer", "unset"]

/-- Where a specification's prose states a `<custom-ident>`'s exclusions other than the keywords of
its entry's grammar, keyed as `gen/exclusions.txt` lists entries. -/
structure ExclusionOverride where
  entry : String
  /-- The whole exclusion set, in place of the grammar's keywords and `customIdentBase`. -/
  only : Option (List String) := none
  /-- Keywords excluded besides the grammar's. -/
  add : List String := []
  source : String

/-- Generic and system family names, which no unquoted `<font-family-name>` may be. -/
def familyNameKeywords : List String :=
  ["cursive", "fantasy", "math", "monospace", "sans-serif", "serif", "system-ui", "ui-monospace",
    "ui-rounded", "ui-sans-serif", "ui-serif", "caption", "icon", "menu", "message-box",
    "small-caption", "status-bar"]

/-- The counter styles `@counter-style` may not define. -/
def nonOverridableCounterStyles : List String :=
  ["decimal", "disc", "square", "circle", "disclosure-open", "disclosure-closed"]

def exclusionOverrides : List ExclusionOverride :=
  [{ entry := "container-name", add := ["and", "not", "or"], source := "css-conditional-5 §5.2" },
   { entry := "container", add := ["and", "not", "or"], source := "css-conditional-5 §5.2" },
   { entry := "@container", add := ["none"], source := "css-conditional-5 §5.4" },
   { entry := "will-change", add := ["will-change", "none", "all"], source := "css-will-change-1 §2" },
   { entry := "view-transition-name", add := ["auto", "match-element"],
     source := "css-view-transitions-2 §3.1" },
   { entry := "flow-into", add := ["auto"], source := "css-regions-1 §3.1" },
   { entry := "font-family", add := familyNameKeywords, source := "css-fonts-4 §2.1.1" },
   { entry := "@font-face/font-family", add := familyNameKeywords, source := "css-fonts-4 §2.1.1" },
   { entry := "@font-palette-values/font-family", add := familyNameKeywords,
     source := "css-fonts-4 §2.1.1" },
   { entry := "@font-feature-values", add := familyNameKeywords, source := "css-fonts-4 §2.1.1" },
   { entry := "function local", add := familyNameKeywords, source := "css-fonts-4 §2.1.1, §4.3.3.1" },
   -- `cyclic` and the rest are valid counter style names; only `extends` precedes the name.
   { entry := "@counter-style/system", only := some (customIdentBase ++ ["none"]),
     source := "css-counter-styles-3 §2.1" },
   { entry := "@counter-style/fallback", add := ["none"], source := "css-counter-styles-3 §2.1" },
   { entry := "@counter-style/speak-as", add := ["none"], source := "css-counter-styles-3 §2.1" },
   { entry := "@counter-style", add := "none" :: nonOverridableCounterStyles,
     source := "css-counter-styles-3 §2.1, §3" },
   { entry := "@keyframes", add := ["none"], source := "css-animations-1 §3" },
   { entry := "function counter", add := ["none"], source := "css-lists-3 §4" },
   { entry := "function counters", add := ["none"], source := "css-lists-3 §4" },
   { entry := "function reversed", add := ["none"], source := "css-lists-3 §4" },
   { entry := "function targetCounter", add := ["none"], source := "css-lists-3 §4" },
   { entry := "function targetCounters", add := ["none"], source := "css-lists-3 §4" },
   { entry := "function lineNames", add := ["span", "auto"], source := "css-grid-2 §7.2.2" },
   -- A layer name is any `<ident>`, keywords included.
   { entry := "@layer", only := some ["inherit", "initial", "revert", "revert-layer", "unset"],
     source := "css-cascade-5 §6.4.2" }]


/-- At-rules whose preludes `CssModel.Rule` models with a `<custom-ident>`, whose exclusions are
drawn from the prelude's grammar. -/
def preludeRules : List String :=
  ["@keyframes", "@counter-style", "@container", "@layer", "@font-feature-values"]

/-- The prelude of an at-rule's syntax: what follows its name, up to its block or `;`. -/
def preludeOf (rname text : String) : String :=
  let rest := (text.drop rname.length).toString
  String.ofList (rest.toList.takeWhile fun c => c != '{' && c != ';')

/-- At-rules whose descriptors are typed as tables of their own; media and container features
are tables of their own too. -/
def descriptorRules : List String :=
  ["@font-face", "@counter-style", "@property", "@page", "@font-palette-values", "@color-profile",
    "@view-transition", "@font-feature-values", "@function"]

/-- At-rules `CssModel.Rule` models by hand, so that one the data adds is reported. `@charset` is
left to the transport. -/
def handModelledRules : List String :=
  ["@charset", "@import", "@namespace", "@layer", "@supports", "@scope", "@starting-style",
    "@keyframes", "@-webkit-keyframes", "@position-try", "@custom-media", "@custom-selector",
    "@mixin", "@apply", "@contents", "@when", "@else", "@navigation", "@location",
    "@supports-condition", "@private",
    "@top-left-corner", "@top-left", "@top-center", "@top-right", "@top-right-corner",
    "@bottom-left-corner", "@bottom-left", "@bottom-center", "@bottom-right",
    "@bottom-right-corner", "@left-top", "@left-middle", "@left-bottom", "@right-top",
    "@right-middle", "@right-bottom",
    "@stylistic", "@historical-forms", "@styleset", "@character-variant", "@swash", "@ornaments",
    "@annotation"]

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
  rule : String
  doc : String
  entries : Array Entry
  ranges : Array Bool := #[]

def runM (env : Env) (st : State) (m : M α) : Except String (α × State) := (m.run env).run st

def main (args : List String) : IO UInt32 := do
  let check := args.contains "--check"
  let json ← IO.ofExcept (Json.parse (← IO.FS.readFile dataPath))
  let mut report : Array String := #[]
  -- Definitions.
  let mut types : HashMap String (List Def) := {}
  for t in arr json "types" do
    let name := (str t "name").getD ""
    let body := (str t "syntax").map Gen.parse
    if let some (.error e) := body then report := report.push s!"type <{name}>: {e}"
    types := types.insert name (types.getD name [] ++ [⟨name, scopesOf t, body⟩])
  let mut functions : HashMap String (List Def) := {}
  for f in arr json "functions" do
    let name := stripParens ((str f "name").getD "")
    let body := (str f "syntax").map Gen.parse
    if let some (.error e) := body then report := report.push s!"function {name}(): {e}"
    functions := functions.insert name (functions.getD name [] ++ [⟨name, scopesOf f, body⟩])
  let mut properties : HashMap String Gen.Term := {}
  let mut propertyList : Array (String × Option String) := #[]
  let mut longhands : HashMap String (List String) := {}
  for p in arr json "properties" do
    let name := (str p "name").getD ""
    propertyList := propertyList.push (name, str p "syntax")
    longhands := longhands.insert name ((arr p "longhands").toList.filterMap (·.getStr?.toOption))
    if let some (.ok t) := (str p "syntax").map Gen.parse then properties := properties.insert name t
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
    if typeName?.isNone && !handModelledRules.contains rname then
      report := report.push s!"at-rule {rname}: not modelled"
    match typeName? with
    | none =>
      for d in descs do
        report := report.push s!"descriptor {rname} {(str d "name").getD ""}: no descriptor table for its at-rule"
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
      tables := tables.push { type := typeName, rule := rname, doc := s!"A descriptor of `{rname}`.", entries, ranges }
  -- Function arguments, which may reach further functions.
  let (failures, st') ← IO.ofExcept (runM env st translateVariants)
  st := st'
  for (what, e) in failures do report := report.push s!"function {what}: {e}"
  -- Preludes, for their keywords only.
  let mut preludes : Array (String × V) := #[]
  for rname in preludeRules do
    let some rule := (arr json "atrules").find? (str · "name" == some rname)
      | report := report.push s!"prelude {rname}: not in the data"
    let prelude := preludeOf rname ((str rule "syntax").getD "")
    match Gen.parse prelude with
    | .error e => report := report.push s!"prelude {rname}: {e}"
    | .ok t =>
      let (r, st') ← IO.ofExcept (runM env st (translatePrelude rname t))
      st := st'
      match r with
      | .ok v => preludes := preludes.push (rname, v)
      | .error e => report := report.push s!"prelude {rname}: {e}"
  -- Keywords that only an exclusion names, which `Keyword.ofNameCaseless?` must still find.
  let extraKeywords := customIdentBase ++ exclusionOverrides.flatMap fun o => o.add ++ o.only.getD []
  let (_, st') ← IO.ofExcept (runM env st (extraKeywords.forM fun k => discard (recordKeyword k)))
  st := st'
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
  let sameAs : Array (List Nat) := vs.map fun v =>
    (vs.toList.zipIdx.filter fun (w, _) =>
      w.css == v.css && w.bracket == v.bracket && w.translated == v.translated).map (·.2)
  let expandAtom (a : Atom) : Atom :=
    { a with functions := (a.functions.flatMap fun i => sameAs[i]?.getD [i]).mergeSort (· ≤ ·) |>.eraseDups }
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
  -- Exclusions: an entry's `<custom-ident>` excludes the keywords of its grammar, and a
  -- shorthand's those of its longhands too, unless an override says otherwise.
  let lower (l : List String) : List String := unionSorted [] (l.map String.toLower)
  let levelOf : HashMap String (Option (List String)) := propEntries.foldl (fun m e =>
    match e.result with
    | .ok v => m.insert e.css (v.keywords.map lower)
    | .error _ => m) {}
  let rec withLonghands : Nat → String → Option (List String)
    | 0, p => levelOf.getD p (some [])
    | fuel + 1, p => (longhands.getD p []).foldl (fun acc l => do
        unionSorted (← acc) (← withLonghands fuel l)) (levelOf.getD p (some []))
  let exclusionOf (key : String) (level : Option (List String)) :
      Option (List String) × Option String :=
    let fromGrammar := level.map (unionSorted customIdentBase ·)
    match exclusionOverrides.find? (·.entry == key) with
    | some o => ((o.only.map (some ∘ lower) |>.getD fromGrammar).map (unionSorted · (lower o.add)), some o.source)
    | none => (fromGrammar, none)
  -- Each entry with a `<custom-ident>`: its key, how the report names it, the name it wants in
  -- Lean, its exclusions (`none` for every keyword) and the section of an override.
  let mut exclusions : Array (String × String × String × Option (List String) × Option String) := #[]
  let mut propEntries' : Array Entry := #[]
  for e in propEntries do
    match e.result with
    | .ok v =>
      if v.hasCustomIdent then
        let (set, source) := exclusionOf e.css (withLonghands 8 e.css)
        exclusions := exclusions.push (e.css, s!"property {e.css}", e.css, set, source)
        propEntries' := propEntries'.push ⟨e.css, .ok (v.withExclusion e.css)⟩
      else propEntries' := propEntries'.push e
    | .error _ => propEntries' := propEntries'.push e
  propEntries := propEntries'
  let mut tables' : Array Table := #[]
  for t in tables do
    let mut entries : Array Entry := #[]
    for e in t.entries do
      let key := s!"{t.rule}/{e.css}"
      match e.result with
      | .ok v =>
        if v.hasCustomIdent then
          let (set, source) := exclusionOf key (v.keywords.map lower)
          exclusions := exclusions.push (key, s!"descriptor {key}", s!"{(t.rule.drop 1).toString}-{e.css}", set, source)
          entries := entries.push ⟨e.css, .ok (v.withExclusion key)⟩
        else entries := entries.push e
      | .error _ => entries := entries.push e
    tables' := tables'.push { t with entries }
  tables := tables'
  let mut vsx : Array V := #[]
  for (v, i) in vs.toList.zipIdx do
    let x := v.translated.getD (.oneOf [])
    if x.hasCustomIdent then
      let fn := String.ofList ((fnLean[i]?.getD "").toList.filter (· ∉ ['«', '»']))
      let key := s!"function {fn}"
      let (set, source) := exclusionOf key (x.keywords.map lower)
      exclusions := exclusions.push (key, key, s!"fn-{fn}", set, source)
      vsx := vsx.push (x.withExclusion key)
    else vsx := vsx.push x
  for (rname, v) in preludes do
    let (set, source) := exclusionOf rname (v.keywords.map lower)
    exclusions := exclusions.push (rname, s!"prelude {rname}", s!"at-{(rname.drop 1).toString}", set, source)
  for o in exclusionOverrides do
    unless exclusions.any (·.1 == o.entry) do
      report := report.push s!"exclusion override {o.entry}: no such entry with a <custom-ident>"
  let exclusionLean := assignNames (exclusions.toList.map (·.2.2.1))
  let names : Names := {
    keywords := kwMap, functions := fnLean.toArray,
    atoms := namedAtoms.zip atomLean |>.map fun ((a, _), l) => (a, l),
    exclusions := (exclusions.toList.zip exclusionLean).foldl (fun m (e, l) => m.insert e.1 l) {} }
  -- Files.
  let mut files : Array (String × String) := #[]
  -- The same code as `CssModel.keywordCode`, which keyword names, all ASCII, never reduce to 0.
  let kwCode (k : String) : Nat := k.toList.foldl (fun acc c => acc * 128 + c.toNat + 1) 0
  for k in kwKeys do
    unless k.toList.all (·.toNat < 127) do throw (IO.userError s!"keyword {k} is not ASCII")
  let byCode := (kwKeys.map fun k => (kwCode k, kwMap.getD k k)).toArray.qsort (·.1 < ·.1)
  let codeLeaf := fun i => match byCode[i]? with
    | some (c, l) => s!"if c = {c} then .some .{l} else .none"
    | none => ".none"
  let kwExtra := s!"\n/-- Every keyword, as `Sym.keywords` holds them. -/\ndef allBits : Nat := (1 <<< {kwKeys.length}) - 1\n" ++
    "\n/-- The keyword whose `keywordCode` is `c`. -/\ndef ofCode? (c : Nat) : Option Keyword :=\n  " ++
    dispatch codeLeaf 0 byCode.size 2 (fun mid => s!"c < {(byCode[mid]?.map (·.1)).getD 0}") 64 ++ "\n"
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
  let keywordList (l : List String) : String :=
    let items := l.map fun k => "." ++ kwMap.getD k k
    let lines := items.foldl (fun (acc : List String) i => match acc with
      | line :: rest => if line.length + i.length + 2 > 96 then i :: line :: rest else s!"{line}, {i}" :: rest
      | [] => [i]) []
    "Sym.keywordSet [\n    " ++ ",\n    ".intercalate lines.reverse ++ "]"
  files := files.push ("Exclusions.lean", header ["CssModel.Kind"]
    "The keywords each entry's `<custom-ident>` excludes, generated by `gen`, which lists them in\n`gen/exclusions.txt`." ++
    "namespace Exclusion\n\n" ++ String.join ((exclusions.toList.zip exclusionLean).map fun ((_, label, _, set, _), l) =>
      let (what, name) := match label.splitOn " " with
        | w :: rest => (w, " ".intercalate rest)
        | [] => ("", label)
      s!"/-- The {what} `{name}`. -/\ndef {l} : Nat :=\n  {(set.map keywordList).getD "Keyword.allBits"}\n\n") ++
    "end Exclusion\n\n" ++ footer)
  let exclusionsText := "Each entry whose grammar admits a <custom-ident>, with the keywords it excludes besides " ++
    " ".intercalate customIdentBase ++ ", and the section of any override.\n\n" ++
    String.join (exclusions.toList.map fun (_, label, _, set, source) =>
      let kws := match set with
        | none => "every keyword"
        | some l =>
          let admitted := customIdentBase.filter (!l.contains ·)
          " ".intercalate (l.filter (!customIdentBase.contains ·)) ++
            (if admitted.isEmpty then "" else s!"; admits {" ".intercalate admitted}")
      s!"{label}: {kws}" ++ (source.map (s!" [{·}]")).getD "" ++ "\n")
  files := files.push ("Atoms.lean", header ["CssModel.Generated.Exclusions"] "Symbols for types whose whole definition is one, generated by `gen`." ++
    "namespace Atoms\n\n" ++ String.join (names.atoms.map fun (a, l) =>
      s!"def {l} : Sym := {atomLit { names with atoms := [] } a}\n\n") ++ "end Atoms\n\n" ++ knownRanges ++ "\n" ++ footer)
  -- Functions.
  let fnVs := vsx.toList.map expand
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
  for (name, text) in files ++ #[("../../gen/untranslated.txt", reportText),
      ("../../gen/exclusions.txt", exclusionsText)] do
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
