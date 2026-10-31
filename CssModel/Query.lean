/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Declaration
public import CssModel.Selector
public import CssModel.Generated.Descriptors

@[expose] public section

/-! Media queries, `@supports` conditions and container queries. -/

namespace CssModel

/-- `not`, `and` and `or` over tests of type `α`, as each kind of query combines them. `and` and
`or` take at least two operands, and cannot be mixed without parentheses. -/
inductive Cond (α : Type) where
  | test (a : α)
  | not (c : Cond α)
  | and (first second : Cond α) (rest : List (Cond α))
  | or (first second : Cond α) (rest : List (Cond α))
  /-- `<general-enclosed>`: a parenthesized sequence of tokens no test describes, unchecked. -/
  | unchecked (t : TokenSeq)
  deriving Repr

/-- `a and b`, or of more operands. -/
def Cond.all {α : Type} (a b : Cond α) (rest : List (Cond α) := []) : Cond α := .and a b rest

/-- `a or b`, or of more operands. -/
def Cond.any {α : Type} (a b : Cond α) (rest : List (Cond α) := []) : Cond α := .or a b rest

namespace Cond

def wrap (paren : Bool) (ps : List Piece) : List Piece :=
  if paren then .punct .openParen :: ps ++ [.punct .closeParen] else ps

mutual
/-- `test` gives a test as it stands in parentheses, which each kind of query writes its own
way; `paren` says whether an operator needs parentheses here. -/
def piecesAt {α : Type} (test : α → List Piece) (paren : Bool) : Cond α → List Piece
  | .test a => test a
  | .not c => wrap paren (.ident "not" :: .space :: piecesAt test true c)
  | .and a b rest =>
    wrap paren (piecesAt test true a ++ [.space, .ident "and", .space] ++ piecesAt test true b ++
      operands test "and" rest)
  | .or a b rest =>
    wrap paren (piecesAt test true a ++ [.space, .ident "or", .space] ++ piecesAt test true b ++
      operands test "or" rest)
  | .unchecked t => .punct .openParen :: t.pieces ++ [.punct .closeParen]

def operands {α : Type} (test : α → List Piece) (op : String) : List (Cond α) → List Piece
  | [] => []
  | c :: cs => [.space, .ident op, .space] ++ piecesAt test true c ++ operands test op cs
end

def pieces {α : Type} (test : α → List Piece) (c : Cond α) : List Piece := piecesAt test false c

/-- The condition as an operand: in parentheses unless it is a test. -/
def inParens {α : Type} (test : α → List Piece) (c : Cond α) : List Piece := piecesAt test true c

mutual
def hasUnchecked {α : Type} (test : α → Bool) : Cond α → Bool
  | .test a => test a
  | .not c => hasUnchecked test c
  | .and a b rest | .or a b rest => hasUnchecked test a || hasUnchecked test b || anyUnchecked test rest
  | .unchecked _ => true

def anyUnchecked {α : Type} (test : α → Bool) : List (Cond α) → Bool
  | [] => false
  | c :: cs => hasUnchecked test c || anyUnchecked test cs
end

mutual
/-- Whether every test satisfies `p`. -/
def allTests {α : Type} (p : α → Bool) : Cond α → Bool
  | .test a => p a
  | .not c => allTests p c
  | .and a b rest | .or a b rest => allTests p a && allTests p b && allTestsList p rest
  | .unchecked _ => true

def allTestsList {α : Type} (p : α → Bool) : List (Cond α) → Bool
  | [] => true
  | c :: cs => allTests p c && allTestsList p cs
end

end Cond

/-- A comparison in range syntax. -/
inductive Cmp where
  | lt | le | gt | ge | eq
  deriving DecidableEq, Repr

def Cmp.punct : Cmp → Punct
  | .lt => .lt | .le => .le | .gt => .gt | .ge => .ge | .eq => .eq

def Cmp.pieces : Cmp → List Piece
  -- `Punct.lt` carries its own following space.
  | .lt => [.gap, .punct .lt]
  | c => [.gap, .punct c.punct, .gap]

/-- A table of features: media or container features. -/
class FeatureTable (F : Type) where
  name : F → String
  grammar : F → Vds
  isRange : F → Bool

instance : FeatureTable MediaFeature := ⟨MediaFeature.name, MediaFeature.syntax, MediaFeature.isRange⟩

instance : FeatureTable ContainerFeature :=
  ⟨ContainerFeature.name, ContainerFeature.syntax, ContainerFeature.isRange⟩

/-- A value of feature `f`, accepted by its grammar. -/
abbrev FeatureValue {F : Type} [FeatureTable F] (f : F) := GrammarValue (FeatureTable.grammar f).toRegex

/-- A test of one feature, written in parentheses. Range syntax and the `min-` and `max-`
prefixes are for range features only. -/
inductive FeatureTest (F : Type) [FeatureTable F] where
  | plain (f : F) (v : FeatureValue f)
  | min (f : F) (v : FeatureValue f) (h : FeatureTable.isRange f = true := by decide)
  | max (f : F) (v : FeatureValue f) (h : FeatureTable.isRange f = true := by decide)
  | boolean (f : F)
  /-- `(f op v)`. -/
  | compare (f : F) (op : Cmp) (v : FeatureValue f) (h : FeatureTable.isRange f = true := by decide)
  /-- `(v op f)`. -/
  | compareRev (f : F) (v : FeatureValue f) (op : Cmp) (h : FeatureTable.isRange f = true := by decide)
  /-- `(lo < f < hi)`, or with `descending`, `(lo > f > hi)`; each comparison strict or not. -/
  | between (f : F) (lo : FeatureValue f) (loStrict : Bool) (hiStrict : Bool) (hi : FeatureValue f)
      (descending : Bool := false) (h : FeatureTable.isRange f = true := by decide)

def FeatureTest.pieces {F : Type} [FeatureTable F] : FeatureTest F → List Piece
  | .plain f v => paren ([.ident (FeatureTable.name f), .punct .colon, .gap] ++ v.pieces)
  | .min f v _ => paren ([.ident ("min-" ++ FeatureTable.name f), .punct .colon, .gap] ++ v.pieces)
  | .max f v _ => paren ([.ident ("max-" ++ FeatureTable.name f), .punct .colon, .gap] ++ v.pieces)
  | .boolean f => paren [.ident (FeatureTable.name f)]
  | .compare f op v _ => paren (.ident (FeatureTable.name f) :: op.pieces ++ v.pieces)
  | .compareRev f v op _ => paren (v.pieces ++ op.pieces ++ [.ident (FeatureTable.name f)])
  | .between f lo loStrict hiStrict hi descending _ =>
    let op := fun (strict : Bool) => if descending then (if strict then Cmp.gt else .ge) else if strict then .lt else .le
    paren (lo.pieces ++ (op loStrict).pieces ++ .ident (FeatureTable.name f) :: (op hiStrict).pieces ++ hi.pieces)
where
  paren (ps : List Piece) : List Piece := .punct .openParen :: ps ++ [.punct .closeParen]

def FeatureTest.feature {F : Type} [FeatureTable F] : FeatureTest F → F
  | .plain f _ | .min f _ _ | .max f _ _ | .boolean f | .compare f _ _ _ | .compareRev f _ _ _
  | .between f .. => f

/-! ## Media queries -/

inductive MediaType where
  | all | print | screen
  /-- Any other identifier, which matches nothing; not `only`, `not`, `and`, `or` or `layer`. -/
  | other (name : Ident) (h : caselessIn name.name ["only", "not", "and", "or", "layer"] = false := by decide +kernel)

def MediaType.name : MediaType → String
  | .all => "all" | .print => "print" | .screen => "screen" | .other n _ => n.name

abbrev MediaCondition := Cond (FeatureTest MediaFeature)

inductive MediaQuery where
  | condition (c : MediaCondition)
  /-- `[not | only]? type [and condition]?`, where the condition has no `or` at its top. -/
  | type (t : MediaType) (modifier : Option Bool := none) (conditions : List MediaCondition := [])
      (noOr : conditions.all (fun | .or .. => false | _ => true) = true := by decide)

def MediaQuery.pieces : MediaQuery → List Piece
  | .condition c => c.pieces FeatureTest.pieces
  | .type t modifier conditions _ =>
    (match modifier with
      | some true => [.ident "only", .space]
      | some false => [.ident "not", .space]
      | none => []) ++ .ident t.name ::
      conditions.flatMap fun c => [.space, .ident "and", .space] ++ Cond.inParens FeatureTest.pieces c

def MediaQuery.hasUnchecked : MediaQuery → Bool
  | .condition c => c.hasUnchecked fun _ => false
  | .type _ _ cs _ => cs.any (Cond.hasUnchecked fun _ => false)

/-- A media query list; empty, it matches everything. -/
abbrev MediaQueryList := List MediaQuery

def MediaQueryList.pieces (l : MediaQueryList) : List Piece :=
  joinPieces [.punct .comma, .gap] (l.map MediaQuery.pieces)

/-! ## `@supports` -/

inductive SupportsTest where
  | declaration (d : Declaration)
  | selector (s : Complex true true)
  | fontTech (tech : Ident)
  | fontFormat (format : Ident)
  | atRule (name : Ident)
  | namedFeature (name : Ident)
  | env (name : Ident)

def SupportsTest.pieces : SupportsTest → List Piece
  | .declaration d => .punct .openParen :: d.pieces ++ [.punct .closeParen]
  | .selector s => fn "selector" s.pieces
  | .fontTech t => fn "font-tech" [.ident t.name]
  | .fontFormat f => fn "font-format" [.ident f.name]
  | .atRule n => fn "at-rule" [.punct .at, .ident n.name]
  | .namedFeature n => fn "named-feature" [.ident n.name]
  | .env n => fn "env" [.ident n.name]
where
  fn (name : String) (args : List Piece) : List Piece :=
    .ident name :: .punct .openParen :: args ++ [.punct .closeParen]

def SupportsTest.hasUnchecked : SupportsTest → Bool
  | .declaration d => d.hasUnchecked
  | .selector s => s.hasUnchecked
  | _ => false

abbrev SupportsCondition := Cond SupportsTest

/-! ## Container queries -/

/-- A test in a style query: a declaration, or a custom property's name alone, true when it has
a value. -/
inductive StyleTest where
  | declaration (d : Declaration)
  | defined (name : DashedIdent)

def StyleTest.pieces : StyleTest → List Piece
  | .declaration d => .punct .openParen :: d.pieces ++ [.punct .closeParen]
  | .defined n => [.punct .openParen, .ident n.name, .punct .closeParen]

def StyleTest.hasUnchecked : StyleTest → Bool
  | .declaration d => d.hasUnchecked
  | .defined _ => false

/-- Which kind of container query tests a feature: a size query in bare parentheses,
`scroll-state()` or `anchored()`. The data does not say. -/
inductive ContainerQueryType where
  | size | scrollState | anchored
  deriving DecidableEq, Repr

def ContainerFeature.queryType (f : ContainerFeature) : ContainerQueryType :=
  if f.name ∈ ["scrollable", "scrolled", "snapped", "stuck"] then .scrollState
  else if f.name == "fallback" then .anchored
  else .size

/-- Whether every feature `q` tests is of type `t`. -/
def Cond.testsOnly (t : ContainerQueryType) (q : Cond (FeatureTest ContainerFeature)) : Bool :=
  q.allTests fun x => x.feature.queryType == t

inductive ContainerTest where
  /-- A size feature, in parentheses. -/
  | size (t : FeatureTest ContainerFeature) (h : t.feature.queryType = .size := by decide)
  | style (q : Cond StyleTest)
  | scrollState (q : Cond (FeatureTest ContainerFeature)) (h : q.testsOnly .scrollState := by decide)
  | anchored (q : Cond (FeatureTest ContainerFeature)) (h : q.testsOnly .anchored := by decide)

def ContainerTest.pieces : ContainerTest → List Piece
  | .size t _ => t.pieces
  | .style q => fn "style" (q.pieces StyleTest.pieces)
  | .scrollState q _ => fn "scroll-state" (q.pieces FeatureTest.pieces)
  | .anchored q _ => fn "anchored" (q.pieces FeatureTest.pieces)
where
  fn (name : String) (args : List Piece) : List Piece :=
    .ident name :: .punct .openParen :: args ++ [.punct .closeParen]

def ContainerTest.hasUnchecked : ContainerTest → Bool
  | .size .. => false
  | .style q => q.hasUnchecked StyleTest.hasUnchecked
  | .scrollState q _ | .anchored q _ => q.hasUnchecked fun _ => false

/-- `<container-condition>`: a container's name, a query, or both. -/
structure ContainerCondition where
  name : Option CustomIdent := none
  query : Option (Cond ContainerTest) := none
  nonempty : (name.isSome || query.isSome) = true := by decide

def ContainerCondition.pieces (c : ContainerCondition) : List Piece :=
  let name : List Piece := match c.name with
    | some n => [.ident n.name]
    | none => []
  let query : List Piece := match c.query with
    | some q => q.pieces ContainerTest.pieces
    | none => []
  joinPieces [.space] ([name, query].filter (!·.isEmpty))

def ContainerCondition.hasUnchecked (c : ContainerCondition) : Bool :=
  c.query.any (Cond.hasUnchecked ContainerTest.hasUnchecked)

end CssModel
