/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Calc
public import CssModel.Generated.Names

@[expose] public section

namespace CssModel

/-- A separator or delimiter between components. -/
inductive Sep where
  | comma | slash | colon | semicolon | plus | minus | star | eq | lt | gt | dot | bar | dollar
  deriving DecidableEq, Repr

def Sep.index : Sep → Nat
  | .comma => 0 | .slash => 1 | .colon => 2 | .semicolon => 3 | .plus => 4 | .minus => 5
  | .star => 6 | .eq => 7 | .lt => 8 | .gt => 9 | .dot => 10 | .bar => 11 | .dollar => 12

def Sep.punct : Sep → Punct
  | .comma => .comma | .slash => .slash | .colon => .colon | .semicolon => .semicolon
  | .plus => .plus | .minus => .minus | .star => .star | .eq => .eq | .lt => .lt | .gt => .gt
  | .dot => .dot | .bar => .bar | .dollar => .dollar

/-- Kinds of component known by their kind alone. -/
inductive SimpleKind where
  | dashedIdent | string | url | hexColor | unicodeRange | hash
  /-- A `<declaration-value>`: a balanced sequence of tokens. -/
  | tokens
  /-- A unitless `0`, which is also a `<length>`. -/
  | zero
  /-- An arbitrary-substitution function. -/
  | substitution
  deriving DecidableEq, Repr

def SimpleKind.index : SimpleKind → Nat
  | .dashedIdent => 0 | .string => 1 | .url => 2 | .hexColor => 3 | .unicodeRange => 4
  | .hash => 5 | .tokens => 6 | .zero => 7 | .substitution => 8

/-- What is known of a component at compile time: its kind, the identity of a keyword or
function, the range a number was proven to lie in and the keywords a custom identifier was
proven not to be, but never a magnitude or a name. These are the letters of a value's shape. -/
inductive Kind where
  | keyword (k : Keyword)
  /-- A function or block, by the variant whose argument grammar it was checked against. -/
  | function (f : Func)
  | sep (s : Sep)
  | numeric (n : NumericKind) (r : Range)
  | simple (s : SimpleKind)
  /-- A `<custom-ident>`, by the bit set of keywords it was proven not to be. -/
  | customIdent (excluded : Nat)
  /-- A math function, by the type it resolves to. -/
  | math (t : CalcType)
  /-- A math function whose parts could not be combined. -/
  | mathInvalid
  deriving DecidableEq, Repr

/-- A grammar symbol: a set of kinds, each a single component. Keywords, functions, separators
and simple kinds are bit sets, numeric types the range each accepts. -/
structure Sym where
  keywords : Nat := 0
  functions : Nat := 0
  seps : Nat := 0
  simple : Nat := 0
  number : Option Range := none
  integer : Option Range := none
  percentage : Option Range := none
  length : Option Range := none
  angle : Option Range := none
  time : Option Range := none
  frequency : Option Range := none
  resolution : Option Range := none
  flex : Option Range := none
  /-- The keywords a `<custom-ident>` must be proven not to be, if one is admitted. -/
  customIdent : Option Nat := none
  /-- Matches every component. -/
  any : Bool := false
  deriving DecidableEq, Repr

namespace Sym

def bits (l : List Nat) : Nat := l.foldl (fun acc i => acc ||| (1 <<< i)) 0

def keywordSet (l : List Keyword) : Nat := Keyword.bits l

def functionSet (l : List Func) : Nat := bits (l.map Func.id)

def sepSet (l : List Sep) : Nat := bits (l.map Sep.index)

def simpleSet (l : List SimpleKind) : Nat := bits (l.map SimpleKind.index)

def numeric (s : Sym) : NumericKind → Option Range
  | .number => s.number | .integer => s.integer | .percentage => s.percentage
  | .length => s.length | .angle => s.angle | .time => s.time | .frequency => s.frequency
  | .resolution => s.resolution | .flex => s.flex

def dim (s : Sym) : BaseType → Option Range
  | .length => s.length | .angle => s.angle | .time => s.time | .frequency => s.frequency
  | .resolution => s.resolution | .flex => s.flex | .percent => s.percentage

def ofSep (x : Sep) : Sym := { seps := 1 <<< x.index }

def comma : Sym := ofSep .comma

def ofSimple (x : SimpleKind) : Sym := { simple := 1 <<< x.index }

end Sym

/-- Whether a math function of type `t` is valid where `s` is: by CSS Values and Units Level 4,
wherever its resulting type is, whatever range restriction applies, since the result is clamped.
A length with a percent hint needs both `<length>` and `<percentage>`, as in
`<length-percentage>`. -/
def CalcType.conforms (t : CalcType) (s : Sym) : Bool :=
  if t.isNumber then s.number.isSome || s.integer.isSome
  else CalcType.all.any fun b =>
    t.isSingle b && (s.dim b).isSome &&
      (match t.hint with
        | none => true
        | some h => h == b && b != .percent && s.percentage.isSome)

def Kind.conforms (k : Kind) (s : Sym) : Bool :=
  s.any || match k with
  | .keyword k => s.keywords.testBit k.id
  | .function f => s.functions.testBit f.id
  | .sep x => s.seps.testBit x.index
  | .numeric .integer r => [s.integer, s.number].any fun x => x.any r.subset
  | .numeric n r => (s.numeric n).any r.subset
  | .simple .zero =>
    s.simple.testBit SimpleKind.zero.index ||
      [s.length, s.number, s.integer].any fun r => r.any (·.contains 0)
  | .simple x => s.simple.testBit x.index
  | .customIdent x => s.customIdent.any fun e => e &&& x == e
  | .math t => t.conforms s
  | .mathInvalid => false

end CssModel
