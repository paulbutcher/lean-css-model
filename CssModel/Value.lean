/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Vds
public import CssModel.Generated.Functions
public import CssModel.Generated.Properties

@[expose] public section

namespace CssModel

open Regular Regex

/-! ## Acceptance -/

/-- Every component. -/
def Sym.anything : Sym := { any := true }

def Sym.cssWide : Sym :=
  { keywords := Sym.keywordSet [.inherit, .initial, .unset, .revert, .revertLayer] }

/-- `g`, or anything containing an arbitrary-substitution function. -/
def Grammar.withSubstitution (g : Regex Sym) : Regex Sym :=
  .alt g (.cat (.star (.sym .anything))
    (.cat (.sym (Sym.ofSimple .substitution)) (.star (.sym .anything))))

/-- A property's grammar, with a CSS-wide keyword alone and anything containing an
arbitrary-substitution function. -/
def Grammar.forProperty (g : Regex Sym) : Regex Sym :=
  .alt (Grammar.withSubstitution g) (.sym .cssWide)

/-- Every value of shape `s` is in the language of `g`, where `g` is a grammar widened by
`extend`. Deciding it tries `g` itself first, which is all most values need. -/
def Admits (g : Regex Sym) (extend : Regex Sym → Regex Sym) (s : Regex Kind) : Prop :=
  Accepts Kind.conforms (extend g) s

/-- An extension of a grammar that keeps every word of it. -/
class Widens (extend : Regex Sym → Regex Sym) : Prop where
  widens : ∀ g w, Matches Kind.conforms g w → Matches Kind.conforms (extend g) w

instance : Widens id := ⟨fun _ _ h => h⟩

instance : Widens Grammar.withSubstitution := ⟨fun _ _ h => .altLeft h⟩

instance : Widens Grammar.forProperty := ⟨fun _ _ h => .altLeft (.altLeft h)⟩

instance {g : Regex Sym} {extend : Regex Sym → Regex Sym} [Widens extend] {s : Regex Kind} :
    Decidable (Admits g extend s) :=
  if h : accepts Kind.conforms g s = true then
    isTrue fun w hw => Widens.widens g w (accepts_iff.1 h w hw)
  else decidable_of_iff _ (accepts_iff (m := Kind.conforms) (g := extend g) (s := s))

/-- Whether a function's arguments of shape `s` are accepted. -/
abbrev ArgsAccepted (f : Func) (s : Regex Kind) : Prop :=
  Admits f.syntax.toRegex Grammar.withSubstitution s

/-! ## Components -/

/-- A `<hex-color>`: 3, 4, 6 or 8 hexadecimal digits. -/
structure HexColor where
  digits : String
  valid : (digits.length ∈ [3, 4, 6, 8] && digits.toList.all Char.isHexDigit) = true := by
    decide +kernel
  deriving Repr

/-- A `<unicode-range-token>`, `U+lo-hi`. -/
structure UnicodeRange where
  lo : Nat
  hi : Nat
  valid : (lo ≤ hi && hi ≤ 0x10FFFF) = true := by decide +kernel
  deriving Repr

/-- The kind of a math function: its resolved type, or a substitution when it contains one. -/
def MathType.kind : MathType → Kind
  | .known t => .math t
  | .unknown => .simple .substitution
  | .invalid => .mathInvalid

mutual
/-- A component value, indexed by its kind. -/
inductive Comp : Kind → Type where
  | keyword (k : Keyword) : Comp (.keyword k)
  | ident (i : CustomIdent) : Comp (.simple .customIdent)
  | dashed (i : DashedIdent) : Comp (.simple .dashedIdent)
  | string (s : String) : Comp (.simple .string)
  | url (s : String) : Comp (.simple .url)
  | hex (c : HexColor) : Comp (.simple .hexColor)
  | unicodeRange (r : UnicodeRange) : Comp (.simple .unicodeRange)
  | hash (name : Ident) : Comp (.simple .hash)
  | tokens (t : TokenSeq) : Comp (.simple .tokens)
  | zero : Comp (.simple .zero)
  | substitution (s : Substitution) : Comp (.simple .substitution)
  | number (r : Range) (v : Decimal) (h : r.contains v = true) : Comp (.numeric .number r)
  | integer (r : Range) (v : Int) (h : r.contains v = true) : Comp (.numeric .integer r)
  | percentage (r : Range) (v : Decimal) (h : r.contains v = true) :
      Comp (.numeric .percentage r)
  | dimension (d : DimKind) (r : Range) (v : Decimal) (u : d.Unit)
      (h : r.contains (d.canonical v u) = true) : Comp (.numeric d.numeric r)
  | math {t : MathType} (e : CalcExpr t) : Comp t.kind
  | sep (s : Sep) : Comp (.sep s)
  /-- A function or block, whose arguments were checked against its own grammar. -/
  | function (f : Func) {s : Regex Kind} (args : Segs s) (h : ArgsAccepted f s) :
      Comp (.function f)

/-- A run of components whose kinds are known: one, an optional one, a list of unknown length,
or comma-separated groups. Indexed by its shape. -/
inductive Segment : Regex Kind → Type where
  | one {k : Kind} (c : Comp k) : Segment (Shape.one k)
  | opt {k : Kind} (c : OptComp k) : Segment (Shape.opt k)
  | many {k : Kind} (cs : Comps k) : Segment (Shape.many k)
  | many1 {k : Kind} (c : Comp k) (cs : Comps k) : Segment (Shape.many1 k)
  | groups {ks : List Kind} (gs : Groups ks) : Segment (Shape.groups ks (.sep .comma))
  | groups1 {ks : List Kind} (g : Group ks) (gs : Groups ks) :
      Segment (Shape.groups1 ks (.sep .comma))

inductive OptComp : Kind → Type where
  | none {k : Kind} : OptComp k
  | some {k : Kind} (c : Comp k) : OptComp k

inductive Comps : Kind → Type where
  | nil {k : Kind} : Comps k
  | cons {k : Kind} (c : Comp k) (cs : Comps k) : Comps k

/-- Components of the kinds `ks`, in order. -/
inductive Group : List Kind → Type where
  | nil : Group []
  | cons {k : Kind} {ks : List Kind} (c : Comp k) (g : Group ks) : Group (k :: ks)

inductive Groups : List Kind → Type where
  | nil {ks : List Kind} : Groups ks
  | cons {ks : List Kind} (g : Group ks) (gs : Groups ks) : Groups ks

/-- Segments in order, indexed by the concatenation of their shapes. -/
inductive Segs : Regex Kind → Type where
  | nil : Segs .eps
  | cons {r t : Regex Kind} (s : Segment r) (ss : Segs t) : Segs (.cat r t)
end

/-! ## Building values -/

/-- A segment with its shape, for lists of segments of different shapes. -/
structure Seg where
  {shape : Regex Kind}
  seg : Segment shape

instance {k : Kind} : CoeOut (Comp k) Seg := ⟨fun c => ⟨.one c⟩⟩

def Seg.shapeOf : List Seg → Regex Kind
  | [] => .eps
  | s :: ss => .cat s.shape (shapeOf ss)

def Seg.toSegs : (l : List Seg) → Segs (Seg.shapeOf l)
  | [] => .nil
  | s :: ss => .cons s.seg (toSegs ss)

def Comps.ofList {k : Kind} : List (Comp k) → Comps k
  | [] => .nil
  | c :: cs => .cons c (ofList cs)

def Groups.ofList {ks : List Kind} : List (Group ks) → Groups ks
  | [] => .nil
  | g :: gs => .cons g (ofList gs)

namespace Seg

/-- An optional component; `k` is needed when `c` is `none`. -/
def opt {k : Kind} (c : Option (Comp k)) : Seg :=
  ⟨.opt (match c with | .none => .none | .some c => .some c)⟩

/-- Any number of components of the kind `k`. -/
def many {k : Kind} (cs : List (Comp k)) : Seg := ⟨.many (Comps.ofList cs)⟩

def many1 {k : Kind} (c : Comp k) (cs : List (Comp k)) : Seg := ⟨.many1 c (Comps.ofList cs)⟩

/-- Any number of components of the kind `k`, separated by commas. -/
def commaList {k : Kind} (cs : List (Comp k)) : Seg :=
  ⟨.groups (ks := [k]) (Groups.ofList (cs.map fun c => .cons c .nil))⟩

/-- One or more components of the kind `k`, separated by commas. -/
def commaList1 {k : Kind} (c : Comp k) (cs : List (Comp k)) : Seg :=
  ⟨.groups1 (ks := [k]) (.cons c .nil) (Groups.ofList (cs.map fun c => .cons c .nil))⟩

/-- Any number of groups of components, separated by commas. -/
def groups {ks : List Kind} (gs : List (Group ks)) : Seg := ⟨.groups (Groups.ofList gs)⟩

def groups1 {ks : List Kind} (g : Group ks) (gs : List (Group ks)) : Seg :=
  ⟨.groups1 g (Groups.ofList gs)⟩

end Seg

/-- The value of a property, accepted by its grammar. A CSS-wide keyword on its own is accepted,
as is any value containing an arbitrary-substitution function. -/
structure Value (p : Property) where
  {shape : Regex Kind}
  segs : Segs shape
  accepted : Admits p.syntax.toRegex Grammar.forProperty shape

/-- The value of an at-rule descriptor, media feature, or anything else with a grammar `g` but
none of a property's extensions. -/
structure GrammarValue (g : Regex Sym) where
  {shape : Regex Kind}
  segs : Segs shape
  accepted : Admits g id shape

/-- A property's value from a list of segments, checked at compile time. Kinds must be known,
so a component built from a variable needs its range given rather than inferred. -/
def Value.of (p : Property) (segs : List Seg)
    (h : Admits p.syntax.toRegex Grammar.forProperty (Seg.shapeOf segs) := by
      (conv => arg 3; reduce); decide +kernel) : Value p :=
  ⟨Seg.toSegs segs, h⟩

def GrammarValue.of {g : Regex Sym} (segs : List Seg)
    (h : Admits g id (Seg.shapeOf segs) := by
      (conv => arg 3; reduce); decide +kernel) : GrammarValue g :=
  ⟨Seg.toSegs segs, h⟩

/-! ## Component constructors -/

def kw (k : Keyword) : Comp (.keyword k) := .keyword k

def ident (name : String)
    (h : CustomIdent.allowed name = true := by decide +kernel) : Comp (.simple .customIdent) := .ident ⟨name, h⟩

def dashed (name : String) (h : DashedIdent.allowed name = true := by decide +kernel) :
    Comp (.simple .dashedIdent) := .dashed ⟨name, h⟩

def str (s : String) : Comp (.simple .string) := .string s

def url (s : String) : Comp (.simple .url) := .url s

def hex (digits : String)
    (h : (digits.length ∈ [3, 4, 6, 8] && digits.toList.all Char.isHexDigit) = true := by
      decide +kernel) : Comp (.simple .hexColor) := .hex ⟨digits, h⟩

def zero : Comp (.simple .zero) := .zero

def slash : Comp (.sep .slash) := .sep .slash

def comma : Comp (.sep .comma) := .sep .comma

def var (name : DashedIdent) (fallback : Option TokenSeq := none) : Comp (.simple .substitution) :=
  .substitution (.var name fallback)

/-- A number. Its range defaults to the tightest of the ranges grammars restrict numbers to that
contains it, so that a literal meets whichever restriction applies; a number held in a variable
needs its range given, with a proof. -/
def num (v : Decimal) (r : Range := Range.tightest (knownRanges .number) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .number r) :=
  .number r v h

def int (v : Int) (r : Range := Range.tightest (knownRanges .integer) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .integer r) :=
  .integer r v h

def pct (v : Decimal) (r : Range := Range.tightest (knownRanges .percentage) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .percentage r) :=
  .percentage r v h

/-- A dimension, its range chosen as `num`'s is. -/
def dim (d : DimKind) (v : Decimal) (u : d.Unit)
    (r : Range := Range.tightest (knownRanges d.numeric) (d.canonical v u))
    (h : r.contains (d.canonical v u) = true := by decide +kernel) : Comp (.numeric d.numeric r) :=
  .dimension d r v u h

def length (v : Decimal) (u : LengthUnit)
    (r : Range := Range.tightest (knownRanges .length) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .length r) :=
  .dimension .length r v u h

def px (v : Decimal) (r : Range := Range.tightest (knownRanges .length) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .length r) :=
  .dimension .length r v .px h

def em (v : Decimal) (r : Range := Range.tightest (knownRanges .length) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .length r) :=
  .dimension .length r v .em h

def rem (v : Decimal) (r : Range := Range.tightest (knownRanges .length) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .length r) :=
  .dimension .length r v .rem h

def vw (v : Decimal) (r : Range := Range.tightest (knownRanges .length) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .length r) :=
  .dimension .length r v .vw h

def vh (v : Decimal) (r : Range := Range.tightest (knownRanges .length) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .length r) :=
  .dimension .length r v .vh h

def deg (v : Decimal) (r : Range := Range.tightest (knownRanges .angle) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .angle r) :=
  .dimension .angle r v .deg h

def sec (v : Decimal) (r : Range := Range.tightest (knownRanges .time) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .time r) :=
  .dimension .time r v .s h

def ms (v : Decimal) (r : Range := Range.tightest (knownRanges .time) (v.mulRatio 1 1000 3))
    (h : r.contains (v.mulRatio 1 1000 3) = true := by decide +kernel) : Comp (.numeric .time r) :=
  .dimension .time r v .ms h

def fr (v : Decimal) (r : Range := Range.tightest (knownRanges .flex) v)
    (h : r.contains v = true := by decide +kernel) : Comp (.numeric .flex r) :=
  .dimension .flex r v .fr h

/-- A function or block, its arguments checked against its own grammar. -/
def fn (f : Func) (args : List Seg)
    (h : ArgsAccepted f (Seg.shapeOf args) := by
      (conv => arg 2; reduce); decide +kernel) : Comp (.function f) :=
  .function f (Seg.toSegs args) h

/-- A math function, valid wherever the type it resolves to is. -/
def math {t : MathType} (e : CalcExpr t) : Comp t.kind := .math e

/-! ## Serialization -/

/-- A component's pieces, and whether it is a comma, which takes no space before it. -/
structure Rendered where
  pieces : List Piece
  isComma : Bool := false

def joinRendered : List Rendered → List Piece
  | [] => []
  | [r] => r.pieces
  | r :: (s :: rest) =>
    r.pieces ++ (if s.isComma then [] else [Piece.space]) ++ joinRendered (s :: rest)

mutual
def Comp.render {k : Kind} : Comp k → List Rendered
  | .keyword k => [⟨[.ident k.name], false⟩]
  | .ident i => [⟨[.ident i.name], false⟩]
  | .dashed i => [⟨[.ident i.name], false⟩]
  | .string s => [⟨[.string s], false⟩]
  | .url s => [⟨[.punct .url, .string s, .punct .closeParen], false⟩]
  | .hex c => [⟨[.punct .hash, .name c.digits], false⟩]
  | .unicodeRange r =>
    [⟨[.punct .unicodePrefix, .hex r.lo] ++ (if r.hi == r.lo then [] else [.punct .minus, .hex r.hi]), false⟩]
  | .hash name => [⟨[.punct .hash, .name name.name], false⟩]
  | .tokens t => [⟨t.pieces, false⟩]
  | .zero => [⟨[.number 0], false⟩]
  | .substitution s => [⟨s.pieces, false⟩]
  | .number _ v _ => [⟨[.number v], false⟩]
  | .integer _ v _ => [⟨[.number (v : Decimal)], false⟩]
  | .percentage _ v _ => [⟨[.number v, .punct .percent], false⟩]
  | .dimension d _ v u _ => [⟨[.number v, .unit (d.unitName u)], false⟩]
  | .math e => [⟨e.pieces, false⟩]
  | .sep s => [⟨[.punct s.punct], s == .comma⟩]
  | .function f args _ =>
    let inner := joinRendered (Segs.render args)
    let (o, c) : Punct × Punct := match f.bracket with
      | .function | .parens => (.openParen, .closeParen)
      | .brackets => (.openBracket, .closeBracket)
    let pre : List Piece := match f.bracket with
      | .function => [.ident f.name]
      | _ => []
    [⟨pre ++ .punct o :: inner ++ [.punct c], false⟩]

def Segment.render {r : Regex Kind} : Segment r → List Rendered
  | .one c => c.render
  | .opt c => OptComp.render c
  | .many cs => Comps.render cs
  | .many1 c cs => c.render ++ Comps.render cs
  | .groups gs => Groups.render gs true
  | .groups1 g gs => Group.render g ++ Groups.render gs false

def OptComp.render {k : Kind} : OptComp k → List Rendered
  | .none => []
  | .some c => c.render

def Comps.render {k : Kind} : Comps k → List Rendered
  | .nil => []
  | .cons c cs => c.render ++ Comps.render cs

def Group.render {ks : List Kind} : Group ks → List Rendered
  | .nil => []
  | .cons c g => c.render ++ Group.render g

/-- Groups, each after a comma unless it is the first. -/
def Groups.render {ks : List Kind} : Groups ks → Bool → List Rendered
  | .nil, _ => []
  | .cons g gs, first =>
    (if first then [] else [⟨[.punct .comma], true⟩]) ++ Group.render g ++ Groups.render gs false

def Segs.render {r : Regex Kind} : Segs r → List Rendered
  | .nil => []
  | .cons s ss => s.render ++ Segs.render ss
end

def Segs.pieces {r : Regex Kind} (s : Segs r) : List Piece := joinRendered s.render

def Comp.pieces {k : Kind} (c : Comp k) : List Piece := joinRendered c.render

def Value.pieces {p : Property} (v : Value p) : List Piece := v.segs.pieces

def Value.serialize {p : Property} (v : Value p) : String := render v.pieces

def GrammarValue.pieces {g : Regex Sym} (v : GrammarValue g) : List Piece := v.segs.pieces

instance {p : Property} : ToString (Value p) := ⟨Value.serialize⟩

/-! ## Inspection -/

mutual
def Comp.hasSubstitution {k : Kind} : Comp k → Bool
  | .substitution _ => true
  | .math e => e.hasSubstitution
  | .function _ args _ => Segs.hasSubstitution args
  | _ => false

def Segment.hasSubstitution {r : Regex Kind} : Segment r → Bool
  | .one c => c.hasSubstitution
  | .opt c => OptComp.hasSubstitution c
  | .many cs => Comps.hasSubstitution cs
  | .many1 c cs => c.hasSubstitution || Comps.hasSubstitution cs
  | .groups gs => Groups.hasSubstitution gs
  | .groups1 g gs => Group.hasSubstitution g || Groups.hasSubstitution gs

def OptComp.hasSubstitution {k : Kind} : OptComp k → Bool
  | .none => false
  | .some c => c.hasSubstitution

def Comps.hasSubstitution {k : Kind} : Comps k → Bool
  | .nil => false
  | .cons c cs => c.hasSubstitution || Comps.hasSubstitution cs

def Group.hasSubstitution {ks : List Kind} : Group ks → Bool
  | .nil => false
  | .cons c g => c.hasSubstitution || Group.hasSubstitution g

def Groups.hasSubstitution {ks : List Kind} : Groups ks → Bool
  | .nil => false
  | .cons g gs => Group.hasSubstitution g || Groups.hasSubstitution gs

def Segs.hasSubstitution {r : Regex Kind} : Segs r → Bool
  | .nil => false
  | .cons s ss => s.hasSubstitution || Segs.hasSubstitution ss
end

/-- Whether the value contains an arbitrary-substitution function, at any depth. -/
def Value.hasSubstitution {p : Property} (v : Value p) : Bool := v.segs.hasSubstitution

/-! ## Explaining a rejection -/

/-- Why a shape was rejected: a shortest sequence of kinds the shape admits and the grammar does
not, each tagged with the position of the segment-level component that produced it, numbered
from 0, and how that sequence goes wrong. -/
structure Rejection where
  shape : Regex Kind
  counterexample : List (Nat × Kind)
  diagnosis : Diagnosis

/-- `none` when `extend g` accepts the shape. The diagnosis is against `g` itself, since a
property's extensions accept any prefix, which a substitution could complete. -/
def explain (g : Regex Sym) (extend : Regex Sym → Regex Sym) (s : Regex Kind) : Option Rejection := do
  let w ← counterexample (fun (p : Nat × Kind) sym => p.2.conforms sym) (extend g) (Shape.indexed s)
  return ⟨s, w, diagnose Kind.conforms g (w.map Prod.snd)⟩

/-- Why the segments are not a value of `p`, if they are not. -/
def Value.explain (p : Property) (segs : List Seg) : Option Rejection :=
  CssModel.explain p.syntax.toRegex Grammar.forProperty (Seg.shapeOf segs)

end CssModel
