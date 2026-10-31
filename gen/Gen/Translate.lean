/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Gen.Syntax
import Std.Data.HashMap

/-! Translation of parsed Value Definition Syntax to the library's `Vds`, with type references
inlined within a level and functions split off into levels of their own. -/

namespace Gen

open Std

structure Range where
  lo : Option String
  hi : Option String
  deriving BEq, Repr, Inhabited, Hashable

/-- A grammar symbol, as `CssModel.Sym` will hold it. Lists are kept sorted, so that equal
symbols compare equal. -/
structure Atom where
  keywords : List String := []
  allKeywords : Bool := false
  functions : List Nat := []
  seps : List String := []
  simple : List String := []
  numeric : List (String × Range) := []
  deriving BEq, Repr, Inhabited, Hashable

inductive V where
  | atom (a : Atom)
  | seq (xs : List V)
  | oneOf (xs : List V)
  | allOf (xs : List V)
  | someOf (xs : List V)
  | opt (x : V)
  | star (x : V)
  | plus (x : V)
  | rep (lo hi : Nat) (x : V)
  | atLeast (lo : Nat) (x : V)
  | commaList (x : V)
  | commaRep (lo hi : Nat) (x : V)
  | nonEmpty (x : V)
  deriving BEq, Repr, Inhabited

def insertSorted [Ord α] (x : α) : List α → List α
  | [] => [x]
  | y :: ys => match compare x y with
    | .lt => x :: y :: ys
    | .eq => y :: ys
    | .gt => y :: insertSorted x ys

def unionSorted [Ord α] (a b : List α) : List α := b.foldl (fun acc x => insertSorted x acc) a

/-- The union of two symbols, unless a numeric type has a different range in each, which no one
range could express. -/
def Atom.union (a b : Atom) : Option Atom :=
  let clash := a.numeric.any fun (f, r) => b.numeric.any fun (g, s) => f == g && !(r == s)
  if clash then none else some {
    keywords := unionSorted a.keywords b.keywords
    allKeywords := a.allKeywords || b.allKeywords
    functions := unionSorted a.functions b.functions
    seps := unionSorted a.seps b.seps
    simple := unionSorted a.simple b.simple
    numeric := (b.numeric.foldl (fun acc (f, r) =>
      if acc.any (·.1 == f) then acc else acc ++ [(f, r)]) a.numeric).mergeSort (·.1 ≤ ·.1) }

def Atom.withRange (a : Atom) (r : Range) : Atom := { a with numeric := a.numeric.map (·.1, r) }

def numericFields : List String :=
  ["number", "integer", "percentage", "length", "angle", "time", "frequency", "resolution", "flex"]

def allRange : Range := ⟨none, none⟩

def sepAtom (s : String) : Atom := { seps := [s] }

def V.nullable : V → Bool
  | .atom _ => false
  | .seq xs => xs.attach.all fun ⟨x, _⟩ => x.nullable
  | .oneOf xs => xs.attach.any fun ⟨x, _⟩ => x.nullable
  | .allOf xs => xs.attach.all fun ⟨x, _⟩ => x.nullable
  | .someOf _ | .nonEmpty _ => false
  | .opt _ | .star _ => true
  | .plus x | .commaList x | .commaRep _ _ x => x.nullable
  | .rep lo _ x | .atLeast lo x => lo == 0 || x.nullable

def V.isComma : V → Bool
  | .atom a => a == sepAtom "comma"
  | _ => false

def nonEmptyOf (x : V) : V := if x.nullable then .nonEmpty x else x

def seqOf : List V → V
  | [x] => x
  | xs => .seq xs

/-- Segments split at top-level commas. -/
def splitCommas (xs : List V) : List (List V) :=
  xs.foldr (fun x acc => if x.isComma then [] :: acc else
    match acc with
    | s :: rest => (x :: s) :: rest
    | [] => [[x]]) [[]]

/-- Value Definition Syntax's comma elision: a comma between two parts is written only when
neither is omitted. The result is nonempty. -/
def joinNonEmpty : List V → V
  | [] => .oneOf []
  | [s] => nonEmptyOf s
  | s :: rest =>
    let tail := V.seq [.atom (sepAtom "comma"), joinNonEmpty rest]
    let withFirst := V.seq [nonEmptyOf s,
      if rest.all V.nullable then .opt tail else tail]
    if s.nullable then .oneOf [withFirst, joinNonEmpty rest] else withFirst

def elideCommas (xs : List V) : V :=
  let segs := splitCommas xs
  if segs.length < 2 || segs.any List.isEmpty || !(segs.any fun s => (seqOf s).nullable) then
    seqOf xs
  else
    let parts := segs.map seqOf
    if parts.all V.nullable then .opt (joinNonEmpty parts) else joinNonEmpty parts

/-- Flattens nested alternatives and merges each run of atoms into as few atoms as their ranges
allow, so that, for instance, `<length> | <percentage>` is the one symbol a math function with
a percent hint can match. -/
def mergeAlts (xs : List V) : List V :=
  let flat := xs.flatMap fun
    | .oneOf ys => ys
    | x => [x]
  let (atoms, rest) := flat.partition fun | .atom _ => true | _ => false
  let merged := atoms.foldl (fun (acc : List Atom) x =>
    match x with
    | .atom a =>
      match acc.findIdx? (fun b => (b.union a).isSome) with
      | some i => acc.modify i fun b => (b.union a).getD b
      | none => acc ++ [a]
    | _ => acc) []
  merged.map .atom ++ rest

def V.applyRange (r : Range) : V → V
  | .atom a => .atom (a.withRange r)
  | .seq xs => .seq (xs.attach.map fun ⟨x, _⟩ => x.applyRange r)
  | .oneOf xs => .oneOf (xs.attach.map fun ⟨x, _⟩ => x.applyRange r)
  | .allOf xs => .allOf (xs.attach.map fun ⟨x, _⟩ => x.applyRange r)
  | .someOf xs => .someOf (xs.attach.map fun ⟨x, _⟩ => x.applyRange r)
  | .opt x => .opt (x.applyRange r)
  | .star x => .star (x.applyRange r)
  | .plus x => .plus (x.applyRange r)
  | .rep lo hi x => .rep lo hi (x.applyRange r)
  | .atLeast lo x => .atLeast lo (x.applyRange r)
  | .commaList x => .commaList (x.applyRange r)
  | .commaRep lo hi x => .commaRep lo hi (x.applyRange r)
  | .nonEmpty x => .nonEmpty (x.applyRange r)

/-- A definition from the data, with the features it is scoped to. Its body is `none` when the
data gives it only in prose, and an error when its syntax does not parse. -/
structure Def where
  name : String
  scopes : List String
  body : Option (Except String Term)
  deriving Inhabited

inductive Bracket where
  | function | parens | brackets
  deriving BEq, Repr, Inhabited, Hashable

/-- One argument grammar for a function or block: a level of its own. -/
structure Variant where
  css : String
  bracket : Bracket
  /-- Where it was defined: the function's own entry, or the definition holding it inline. -/
  owner : String
  /-- The function's own entry, rather than an inline use. -/
  canonical : Bool
  /-- The whole of `owner`'s definition. -/
  whole : Bool
  scope : List String
  args : Term
  translated : Option V := none
  deriving Inhabited

structure State where
  keywords : HashMap String String := {}
  keywordOrder : Array String := #[]
  variants : Array Variant := #[]
  variantKeys : HashMap String Nat := {}
  /-- Symbols that are the whole of a named type, to name them after it. -/
  namedAtoms : Array (String × Atom) := #[]
  ranges : Array (String × Range) := #[]
  /-- The entry being translated, and what of it was left untranslated. -/
  entry : String := ""
  notes : Array String := #[]
  deriving Inhabited

structure Env where
  types : HashMap String (List Def)
  functions : HashMap String (List Def)
  properties : HashMap String Term
  overrides : HashMap String Term

abbrev M := ReaderT Env (StateT State (Except String))

structure Ctx where
  scope : List String
  /-- The definitions being inlined at this level, for finding cycles. -/
  stack : List String
  owner : String
  whole : Bool

def mathFunctions : List String :=
  ["calc", "min", "max", "clamp", "round", "mod", "rem", "sin", "cos", "tan", "asin", "acos",
    "atan", "atan2", "pow", "sqrt", "hypot", "log", "exp", "abs", "sign"]

def substitutionFunctions : List String := ["var", "env", "attr"]

def numericAtom (field : String) (r : Range := allRange) : Atom := { numeric := [(field, r)] }

def calcSumAtom : Atom := { numeric := numericFields.map (·, allRange) }

/-- Types the library represents directly rather than by their definitions. -/
def terminal : String → Option Atom
  | "number" | "integer" | "percentage" | "length" | "angle" | "time" | "frequency"
  | "resolution" | "flex" => none
  | "dimension" => some { numeric := ["length", "angle", "time", "frequency", "resolution", "flex"].map (·, allRange) }
  | "zero" => some { simple := ["zero"] }
  | "string" | "string-token" => some { simple := ["string"] }
  | "url" => some { simple := ["url"] }
  | "custom-ident" => some { simple := ["customIdent"] }
  | "dashed-ident" | "custom-property-name" => some { simple := ["dashedIdent"] }
  | "ident" | "ident-token" => some { simple := ["customIdent", "dashedIdent"], allKeywords := true }
  | "hex-color" => some { simple := ["hexColor"] }
  | "declaration-value" | "any-value" | "whole-value" => some { simple := ["tokens"] }
  | "unicode-range-token" => some { simple := ["unicodeRange"] }
  | "id-selector" | "hash-token" => some { simple := ["hash"] }
  | "calc-sum" => some calcSumAtom
  | _ => none

def stripUnit (s : String) : Option String :=
  if s == "∞" || s == "+∞" || s == "-∞" then none
  else some (String.ofList (s.toList.takeWhile fun c => c.isDigit || c == '-' || c == '.'))

def recordKeyword (k : String) : M String := do
  let key := k.toLower
  match (← get).keywords.get? key with
  | some spelling =>
    -- Keywords ignore ASCII case; the lowercase spelling, where the data has one, is the usual.
    if k == key && spelling != k then
      modify fun s => { s with keywords := s.keywords.insert key k }
      return k
    return spelling
  | none =>
    modify fun s => { s with keywords := s.keywords.insert key k, keywordOrder := s.keywordOrder.push key }
    return k

def sepName : String → Option String
  | "," => some "comma" | "/" => some "slash" | ":" => some "colon" | ";" => some "semicolon"
  | "+" => some "plus" | "-" => some "minus" | "*" => some "star" | "=" => some "eq"
  | "<" => some "lt" | ">" => some "gt" | "." => some "dot" | "|" => some "bar"
  | "$" => some "dollar"
  | _ => none

/-- Chooses among scoped definitions the one whose scope is in `scope`, or else an unscoped
one. -/
def choose (defs : List Def) (scope : List String) : Option Def :=
  match defs.find? fun d => d.scopes.any scope.contains with
  | some d => some d
  | none => match defs.find? (·.scopes.isEmpty) with
    | some d => some d
    | none => defs.head?

def variantKey (css : String) (b : Bracket) (owner : String) (canonical : Bool) : String :=
  s!"{css}|{repr b}|{owner}|{canonical}"

def addVariant (v : Variant) : M Nat := do
  let key := variantKey v.css v.bracket v.owner v.canonical
  match (← get).variantKeys.get? key with
  | some i =>
    let some existing := (← get).variants[i]? | throw s!"variant {key} has no entry"
    -- Two inline uses in one definition, as in `minmax(A) | minmax(B)`, share a variant whose
    -- arguments are either.
    if existing.args != v.args && !v.canonical then
      modify fun s => { s with variants := s.variants.modify i fun e => { e with
        args := .oneOf [e.args, v.args], whole := false } }
    return i
  | none =>
    let i := (← get).variants.size
    modify fun s => { s with variants := s.variants.push v, variantKeys := s.variantKeys.insert key i }
    return i

/-- The argument grammars of the uses of `css` that a function's definition comes down to,
through types defined as alternatives of them. -/
def fnArgsOf (css : String) : Nat → Term → M (List (String × Term))
  | 0, _ => throw s!"definition of {css}() nests too deeply"
  | fuel + 1, t => do
    match t with
    | .fn n a => return [(n, a)]
    | .oneOf ts => return (← ts.mapM (fnArgsOf css fuel)).flatten
    | .ref name none =>
      match (← read).types.get? name with
      | some defs => match choose defs [] with
        | some ⟨_, _, some (.ok t)⟩ => fnArgsOf css fuel t
        | some ⟨_, _, some (.error e)⟩ => throw s!"{css}() is defined by <{name}>, whose syntax does not parse: {e}"
        | _ => throw s!"{css}() is defined by <{name}>, which has no syntax"
      | none => throw s!"{css}() is defined by unknown <{name}>"
    | _ => throw s!"{css}() has a definition other than alternatives of {css}( ... )"

/-- Leaves out a part that cannot be translated, so that the grammar admits less rather than
more, and records it. -/
def narrow (msg : String) : M V := do
  modify fun s => { s with notes := s.notes.push s!"{s.entry}: {msg}; left to unchecked declarations" }
  return .oneOf []

def atomOf (x : V) : Option Atom := match x with
  | .atom a => some a
  | _ => none

mutual
def tr (ctx : Ctx) : Nat → Term → M V
  | 0, _ => throw "translation nests too deeply"
  | fuel + 1, t => do
    match t with
    | .kw n =>
      if n.toList.head?.any Char.isDigit then
        return ← narrow s!"the literal number {n}"
      let k ← recordKeyword n
      return .atom { keywords := [k] }
    | .lit s => match sepName s with
      | some n => return .atom (sepAtom n)
      | none => throw s!"unsupported literal '{s}'"
    | .ref name range => trRef ctx fuel name range
    | .prop name =>
      if ctx.stack.contains s!"'{name}'" then throw s!"cycle through <'{name}'>"
      match (← read).properties.get? name with
      | some t =>
        let inner : Ctx := { scope := name :: ctx.scope, stack := s!"'{name}'" :: ctx.stack, owner := name, whole := true }
        tr inner fuel t
      | none => throw s!"unknown property <'{name}'>"
    | .fnRef name =>
      if mathFunctions.contains name then return .atom calcSumAtom
      else if substitutionFunctions.contains name then return .atom { simple := ["substitution"] }
      else if name == "url" then return .atom { simple := ["url"] }
      else
        match (← read).functions.get? name with
        | some defs => match choose defs ctx.scope with
          | some ⟨_, _, some (.error e)⟩ => narrow s!"<{name}()>'s syntax does not parse: {e}"
          | some ⟨_, scopes, some (.ok t)⟩ =>
            let args ← try fnArgsOf name 20 t catch e => do
              let _ ← narrow e
              pure []
            if args.isEmpty then return .oneOf []
            let css := match args with
              | (n, _) :: _ => n
              | [] => name
            let owner := match scopes with
              | [] => ""
              | s :: _ => s
            let i ← addVariant { css, bracket := .function, owner, canonical := true, whole := true, scope := s!"{name}()" :: ctx.scope, args := .oneOf (args.map (·.2)) }
            return .atom { functions := [i] }
          | _ => narrow s!"<{name}()> has no syntax"
        | none => narrow s!"unknown function <{name}()>"
    | .fn name args =>
      if mathFunctions.contains name || substitutionFunctions.contains name then
        throw s!"inline {name}()"
      let i ← addVariant { css := name, bracket := .function, owner := ctx.owner, canonical := false, whole := ctx.whole, scope := s!"{name}()" :: ctx.scope, args }
      return .atom { functions := [i] }
    | .block bracket body =>
      let i ← addVariant { css := "", bracket := if bracket then .brackets else .parens, owner := ctx.owner, canonical := false, whole := ctx.whole, scope := ctx.scope, args := body }
      return .atom { functions := [i] }
    | .seq ts =>
      let inner := { ctx with whole := false }
      return elideCommas (← ts.mapM (tr inner fuel))
    | .oneOf ts =>
      let inner := if ts.length == 1 then ctx else { ctx with whole := false }
      let xs ← ts.mapM (tr inner fuel)
      return match mergeAlts xs with
        | [x] => x
        | xs => .oneOf xs
    | .allOf ts => return .allOf (← ts.mapM (tr { ctx with whole := false } fuel))
    | .someOf ts => return .someOf (← ts.mapM (tr { ctx with whole := false } fuel))
    | .mult t m =>
      let x ← tr { ctx with whole := false } fuel t
      match m with
      | .opt => return .opt x
      | .star => return .star x
      | .plus => return .plus x
      | .nonEmpty => return .nonEmpty x
      | .hash => return .commaList x
      | .rep lo hi => return .rep lo hi x
      | .atLeast lo => return .atLeast lo x
      | .hashRep lo hi =>
        if lo == 0 then throw "unsupported multiplier #{0,B}" else return .commaRep lo hi x

def trRef (ctx : Ctx) (fuel : Nat) (name : String) (range : Option (String × String)) : M V := do
  let range := range.map fun (lo, hi) => Range.mk (stripUnit lo) (stripUnit hi)
  if numericFields.contains name then
    let r := range.getD allRange
    modify fun s => { s with ranges := s.ranges.push (name, r) }
    return .atom (numericAtom name r)
  if let some a := terminal name then
    return .atom (match range with
      | some r => a.withRange r
      | none => a)
  if ctx.stack.contains s!"<{name}>" then throw s!"cycle through <{name}> within one level"
  let body ← match (← read).overrides.get? name with
    | some t => pure t
    | none => match (← read).types.get? name with
      | some defs => match choose defs ctx.scope with
        | some ⟨_, _, some (.ok t)⟩ => pure t
        | some ⟨_, _, some (.error e)⟩ => return ← narrow s!"<{name}>'s syntax does not parse: {e}"
        | some ⟨_, _, none⟩ => return ← narrow s!"<{name}> is defined in prose"
        | none => return ← narrow s!"unknown type <{name}>"
      | none => return ← narrow s!"unknown type <{name}>"
  let inner : Ctx := { scope := s!"<{name}>" :: ctx.scope, stack := s!"<{name}>" :: ctx.stack, owner := name, whole := true }
  let x ← tr inner fuel body
  match range, x with
  | some r, x =>
    for (f, _) in (atomOf x).map (·.numeric) |>.getD [] do
      modify fun s => { s with ranges := s.ranges.push (f, r) }
    return x.applyRange r
  | none, .atom a =>
    unless (← get).namedAtoms.any (·.1 == name) do
      modify fun s => { s with namedAtoms := s.namedAtoms.push (name, a) }
    return x
  | none, x => return x
end

def topCtx (name : String) : Ctx := { scope := [name], stack := [], owner := name, whole := true }

/-- Translates a top-level entry, leaving the state as it was if it fails. -/
def translate (name : String) (t : Term) : M (Except String V) := do
  modify fun s => { s with entry := name }
  let saved ← get
  try
    return .ok (← tr (topCtx name) 200 t)
  catch e =>
    set saved
    return .error e

/-- Translates the argument grammars of variants, which may add more. Returns the variants that
could not be translated. -/
def translateVariants : M (List (String × String)) := do
  let mut failures := []
  let mut i := 0
  for _ in [0:100000] do
    let s ← get
    if h : i < s.variants.size then
      let v := s.variants[i]
      if v.translated.isNone then
        let ctx : Ctx := { scope := v.scope, stack := [], owner := if v.canonical then v.css else v.owner, whole := false }
        modify fun s => { s with entry := s!"function {v.css}()" }
        let saved ← get
        try
          let x ← tr ctx 200 v.args
          modify fun s => { s with variants := s.variants.modify i fun v => { v with translated := some x } }
        catch e =>
          set saved
          modify fun s => { s with variants := s.variants.modify i fun v => { v with translated := some (.oneOf []) } }
          failures := failures ++ [(s!"{v.css}() in {v.owner}", e)]
      i := i + 1
    else break
  return failures

end Gen
