/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Gen.Translate

/-! Rendering translated grammars as Lean source. -/

namespace Gen

open Std

def header (imports : List String) (doc : String) : String :=
  "/-\nCopyright (c) 2026 Paul Butcher. All rights reserved.\n" ++
  "Released under Apache 2.0 license as described in the file LICENSE.\n-/\n" ++
  "module\n\n" ++ String.join (imports.map (s!"public import {·}\n")) ++
  "\n@[expose] public section\n\n" ++ s!"/-! {doc} -/\n\nnamespace CssModel\n\n"

def footer : String := "end CssModel\n"

def leanKeywords : List String :=
  ["from", "to", "at", "by", "in", "if", "then", "else", "do", "fun", "let", "have", "show",
    "match", "with", "where", "end", "open", "export", "import", "local", "private", "protected",
    "partial", "unsafe", "noncomputable", "return", "for", "unless", "try", "catch", "finally",
    "break", "continue", "mut", "nomatch", "nofun", "this", "Type", "Prop", "Sort", "forall",
    "exists", "deriving", "instance", "structure", "class", "inductive", "theorem", "def",
    "axiom", "example", "abbrev", "macro", "syntax", "namespace", "section", "variable",
    "universe", "mutual", "extends", "calc", "notation", "infix", "infixl", "infixr", "prefix",
    "postfix", "attribute", "using", "hiding", "renaming", "opaque", "suffices", "obtain",
    "sorry", "admit", "λ", "Π", "Σ", "omit", "include", "public", "meta", "module", "repeat",
    "while", "only", "generalizing", "says", "elab", "assert", "scoped", "set_option", "decreasing_by",
    "termination_by", "nonrec", "builtin_initialize", "initialize", "declare_syntax_cat", "macro_rules"]

/-- Names a table's own declarations use, which an entry's name must not shadow. -/
def tableNames : List String :=
  ["id", "valid", "mk", "names", "name", "allBits", "rec", "casesOn", "recOn", "noConfusion",
    "noConfusionType", "ctorIdx", "syntax", "ofName?", "count", "brackets", "bracket", "ranges",
    "isRange", "toCtorIdx", "ext", "ext_iff", "instRepr", "instDecidableEq", "repr"]

def capitalize (s : String) : String :=
  match s.toList with
  | c :: cs => String.ofList (c.toUpper :: cs)
  | [] => s

/-- `small-caps` as `smallCaps`. -/
def camel (s : String) : String :=
  match (s.splitOn "-").filter (· != "") with
  | [] => s
  | p :: ps => p ++ String.join (ps.map capitalize)

def isIdentStart (c : Char) : Bool := c.isAlpha || c == '_'

/-- A Lean identifier for `css`, not among `taken`. -/
def leanName (css : String) (taken : List String) : String :=
  let c := camel css
  let c := if tableNames.contains c then c ++ "_" else c
  let valid := (c.toList.head?.any isIdentStart) && c.toList.all fun x => x.isAlphanum || x == '_'
  let c := if !valid || leanKeywords.contains c then s!"«{c}»" else c
  if !taken.contains c then c
  else if !taken.contains s!"«{css}»" && css != camel css then s!"«{css}»"
  else (List.range 100).map (fun i => s!"{c}_{i}") |>.find? (!taken.contains ·) |>.getD c

/-- Whether `css` should have first claim on its name: those spelled as their Lean name, then
those without a leading `-`. -/
def priority (css : String) : Nat :=
  if camel css == css then 0 else if css.startsWith "-" then 2 else 1

/-- Unique Lean names for `items`, in order. -/
def assignNames (items : List String) : List String :=
  let order := (items.zipIdx.mergeSort fun (a, i) (b, j) => priority a < priority b || (priority a == priority b && i ≤ j))
  let named := order.foldl (fun (acc : List (Nat × String)) (css, i) => acc ++ [(i, leanName css (acc.map (·.2)))]) []
  (named.mergeSort (·.1 ≤ ·.1)).map (·.2)

def quote (s : String) : String := s!"\"{s}\""

def decimalLit (s : String) : String :=
  if s.startsWith "-" then s!"({s})" else s

def rangeLit (r : Range) : String :=
  match r.lo, r.hi with
  | none, none => ".all"
  | some "0", none => ".nonneg"
  | lo, hi =>
    let f := fun (n : String) (v : Option String) => match v with
      | some v => [s!"{n} := some {decimalLit v}"]
      | none => []
    "{ " ++ ", ".intercalate (f "lo" lo ++ f "hi" hi) ++ " }"

structure Names where
  keywords : HashMap String String
  functions : Array String
  atoms : List (Atom × String)
  /-- The Lean name of each entry's exclusions, by its key. -/
  exclusions : HashMap String String := {}

def atomLit (n : Names) (a : Atom) : String :=
  let kws := a.keywords.map fun k => "." ++ (n.keywords.getD k.toLower k)
  let fields :=
    (if a.allKeywords then ["keywords := Keyword.allBits"]
      else if kws.isEmpty then []
      else [s!"keywords := Sym.keywordSet [{", ".intercalate kws}]"]) ++
    (if a.functions.isEmpty then [] else
      [s!"functions := Sym.functionSet [{", ".intercalate (a.functions.map fun i => "." ++ (n.functions[i]?.getD s!"missingFunction{i}"))}]"]) ++
    (if a.seps.isEmpty then [] else
      [s!"seps := Sym.sepSet [{", ".intercalate (a.seps.map ("." ++ ·))}]"]) ++
    (if a.simple.isEmpty then [] else
      [s!"simple := Sym.simpleSet [{", ".intercalate (a.simple.map ("." ++ ·))}]"]) ++
    a.numeric.map (fun (f, r) => s!"{f} := some {rangeLit r}") ++
    (match a.customIdent with
      | some k => [s!"customIdent := some Exclusion.{n.exclusions.getD k s!"missing_{k}"}"]
      | none => [])
  "{ " ++ ", ".intercalate fields ++ " }"

def atomRef (n : Names) (a : Atom) : String :=
  match n.atoms.find? (·.1 == a) with
  | some (_, name) => s!"Atoms.{name}"
  | none =>
    if a == sepAtom "comma" then "Sym.comma" else atomLit n a

def V.render (n : Names) (indent : Nat) : V → String
  | .atom a => s!".atom {atomRef n a}"
  | .seq xs => list "seq" (xs.attach.map fun ⟨x, _⟩ => x.render n (indent + 2))
  | .oneOf xs => list "oneOf" (xs.attach.map fun ⟨x, _⟩ => x.render n (indent + 2))
  | .allOf xs => list "allOf" (xs.attach.map fun ⟨x, _⟩ => x.render n (indent + 2))
  | .someOf xs => list "someOf" (xs.attach.map fun ⟨x, _⟩ => x.render n (indent + 2))
  | .opt x => s!".opt ({x.render n indent})"
  | .star x => s!".star ({x.render n indent})"
  | .plus x => s!".plus ({x.render n indent})"
  | .rep lo hi x => s!".rep {lo} {hi} ({x.render n indent})"
  | .atLeast lo x => s!".atLeast {lo} ({x.render n indent})"
  | .commaList x => s!".commaList ({x.render n indent})"
  | .commaRep lo hi x => s!".commaRep {lo} {hi} ({x.render n indent})"
  | .nonEmpty x => s!".nonEmpty ({x.render n indent})"
where
  list (ctor : String) (items : List String) : String :=
    let pad := String.ofList (List.replicate (indent + 2) ' ')
    if items.isEmpty then s!".{ctor} []"
    else if (items.foldl (· + ·.length) 0) < 60 && items.all (!·.contains '\n') then
      s!".{ctor} [{", ".intercalate items}]"
    else s!".{ctor} [\n{pad}" ++ s!",\n{pad}".intercalate items ++ "]"

/-- `if i < mid then ... else ...` down to single entries, so that the kernel finds an entry in
logarithmically many comparisons. `below mid` is the test for entries before `mid`. -/
def dispatch (leaf : Nat → String) (lo hi : Nat) (indent : Nat)
    (below : Nat → String) : Nat → String
  | 0 => leaf lo
  | fuel + 1 =>
    if hi - lo ≤ 1 then leaf lo
    else
      let mid := (lo + hi) / 2
      let pad := String.ofList (List.replicate indent ' ')
      s!"if {below mid} then\n{pad}  " ++ dispatch leaf lo mid (indent + 2) below fuel ++
        s!"\n{pad}else\n{pad}  " ++ dispatch leaf mid hi (indent + 2) below fuel

/-- A type of named entries: an index proven in range, a constant for each entry, and its name.
`extra` adds definitions inside the namespace. -/
def emitTable (type doc : String) (cssNames : List String) (leanNames : List String)
    (extra : String := "") : String :=
  let n := cssNames.length
  s!"/-- {doc} -/\nstructure {type} where\n  id : Nat\n  valid : id < {n}\n" ++
  "  deriving DecidableEq, Repr\n\n" ++ s!"namespace {type}\n\n" ++
  String.join ((leanNames.zip cssNames).zipIdx.map fun ((l, c), i) =>
    s!"/-- `{c}` -/\ndef {l} : {type} := ⟨{i}, by decide⟩\n") ++
  "\ndef names : Array String := #[\n  " ++ ",\n  ".intercalate (cssNames.map quote) ++ "]\n\n" ++
  s!"def name (x : {type}) : String := names[x.id]?.getD \"\"\n\n" ++
  s!"def ofName? (s : String) : Option {type} :=\n" ++
  s!"  match names.findIdx? (· == s) with\n  | .some i => if h : i < {n} then .some ⟨i, h⟩ else .none\n  | .none => .none\n" ++
  extra ++ s!"\nend {type}\n\n"

/-- The syntax of each entry of a table, as a constant per entry and a dispatch on the index. -/
def emitSyntax (type : String) (n : Names) (leanNames : List String) (vs : List V) : String :=
  let defs := String.join ((leanNames.zip vs).map fun (l, v) =>
    s!"def {l} : Vds :=\n  {v.render n 2}\n\n")
  let count := leanNames.length
  let leaf := fun i => s!"{type}Syntax.{(leanNames[i]?.getD s!"missing{i}")}"
  s!"namespace {type}Syntax\n\n" ++ defs ++ s!"end {type}Syntax\n\n" ++
  let body := if count == 0 then ".oneOf []" else dispatch leaf 0 count 2 (s!"i < {·}") 64
  let param := if count ≤ 1 then "_" else "i"
  s!"def {type}.syntaxAt ({param} : Nat) : Vds :=\n  " ++ body ++ "\n\n" ++
  s!"def {type}.syntax (x : {type}) : Vds := {type}.syntaxAt x.id\n\n"

end Gen
