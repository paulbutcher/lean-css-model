/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Numeric
public import CssModel.Substitution

@[expose] public section

namespace CssModel

/-- The base types of CSS Typed OM's type algebra. -/
inductive BaseType where
  | length | angle | time | frequency | resolution | flex | percent
  deriving DecidableEq, Repr

def BaseType.ofDim : DimKind → BaseType
  | .length => .length | .angle => .angle | .time => .time | .frequency => .frequency
  | .resolution => .resolution | .flex => .flex

/-- A CSS type: an exponent for each base type, and the type percentages resolve against, if a
percentage has been combined with another dimension. -/
structure CalcType where
  length : Int := 0
  angle : Int := 0
  time : Int := 0
  frequency : Int := 0
  resolution : Int := 0
  flex : Int := 0
  percent : Int := 0
  hint : Option BaseType := none
  deriving DecidableEq, Repr

namespace CalcType

def number : CalcType := {}

def get (t : CalcType) : BaseType → Int
  | .length => t.length | .angle => t.angle | .time => t.time | .frequency => t.frequency
  | .resolution => t.resolution | .flex => t.flex | .percent => t.percent

def set (t : CalcType) (b : BaseType) (v : Int) : CalcType :=
  match b with
  | .length => { t with length := v } | .angle => { t with angle := v }
  | .time => { t with time := v } | .frequency => { t with frequency := v }
  | .resolution => { t with resolution := v } | .flex => { t with flex := v }
  | .percent => { t with percent := v }

def base (b : BaseType) : CalcType := ({} : CalcType).set b 1

def dims : List BaseType := [.length, .angle, .time, .frequency, .resolution, .flex]

def all : List BaseType := .percent :: dims

/-- Typed OM's "apply the percent hint": the percentage exponent moves onto `hint`. -/
def applyHint (t : CalcType) (hint : BaseType) : CalcType :=
  { (t.set hint (t.get hint + t.percent)).set .percent 0 with hint := some hint }

def sameEntries (a b : CalcType) : Bool := all.all fun x => a.get x == b.get x

def withHint (t : CalcType) (h : Option BaseType) : CalcType := { t with hint := h }

/-- Typed OM's "add two types", or `none` where they cannot be added. -/
def add (a b : CalcType) : Option CalcType :=
  let hinted : Option (CalcType × CalcType) := match a.hint, b.hint with
    | some x, some y => if x = y then some (a, b) else none
    | some x, none => some (a, b.applyHint x)
    | none, some y => some (a.applyHint y, b)
    | none, none => some (a, b)
  hinted.bind fun (a, b) =>
    if sameEntries a b then some a
    else if (a.percent != 0 || b.percent != 0) &&
        dims.any (fun x => a.get x != 0 || b.get x != 0) then
      dims.findSome? fun h =>
        let a' := a.applyHint h
        let b' := b.applyHint h
        if sameEntries a' b' then some a' else none
    else none

/-- Typed OM's "multiply two types". -/
def mul (a b : CalcType) : Option CalcType :=
  let hinted : Option (CalcType × CalcType) := match a.hint, b.hint with
    | some x, some y => if x = y then some (a, b) else none
    | some x, none => some (a, b.applyHint x)
    | none, some y => some (a.applyHint y, b)
    | none, none => some (a, b)
  hinted.map fun (a, b) =>
    all.foldl (fun t x => t.set x (t.get x + b.get x)) a

def invert (t : CalcType) : CalcType := all.foldl (fun u x => u.set x (-t.get x)) t

def isNumber (t : CalcType) : Bool := sameEntries t number && t.hint.isNone

/-- The only nonzero exponent is `b`'s, and it is 1. -/
def isSingle (t : CalcType) (b : BaseType) : Bool := sameEntries t (base b)

end CalcType

/-- The type of a math expression: a type of the algebra, or unknown because it contains an
arbitrary-substitution function, or invalid because two of its parts could not be combined.
Unknown wins over invalid, since a browser accepts any value containing a substitution. -/
inductive MathType where
  | known (t : CalcType)
  | unknown
  | invalid
  deriving DecidableEq, Repr

namespace MathType

def number : MathType := .known .number

def lift (f : CalcType → CalcType → Option CalcType) : MathType → MathType → MathType
  | .unknown, _ | _, .unknown => .unknown
  | .known a, .known b => match f a b with
    | some t => .known t
    | none => .invalid
  | _, _ => .invalid

def add : MathType → MathType → MathType := lift CalcType.add

def mul : MathType → MathType → MathType := lift CalcType.mul

def div (a b : MathType) : MathType :=
  mul a (match b with
    | .known t => .known t.invert
    | other => other)

/-- `a`, or `a` combined with `b` when `b` is present. -/
def addOpt (a : MathType) : Option MathType → MathType
  | none => a
  | some b => add a b

/-- Requires `a` to be a number, and yields `result`. -/
def numberTo (a : MathType) (result : MathType := number) : MathType :=
  match a with
  | .known t => if t.isNumber then result else .invalid
  | .unknown => .unknown
  | .invalid => .invalid

/-- `round()`'s interval may be omitted only when the value is a number. -/
def round (a : MathType) : Option MathType → MathType
  | none => a.numberTo
  | some b => add a b

/-- `sin()`, `cos()` and `tan()` take an angle or a number. -/
def trig : MathType → MathType
  | .known t => if t.isNumber || (t.isSingle .angle && t.hint.isNone) then number else .invalid
  | other => other

/-- `atan2()` and `sign()` take any consistent type. -/
def anyTo (result : MathType) : MathType → MathType
  | .known _ => result
  | other => other

end MathType

inductive CalcConstant where
  | e | pi | infinity | negInfinity | NaN
  deriving DecidableEq, Repr

def CalcConstant.name : CalcConstant → String
  | .e => "e" | .pi => "pi" | .infinity => "infinity" | .negInfinity => "-infinity"
  | .NaN => "NaN"

inductive RoundingStrategy where
  | nearest | up | down | toZero
  deriving DecidableEq, Repr

def RoundingStrategy.name : RoundingStrategy → String
  | .nearest => "nearest" | .up => "up" | .down => "down" | .toZero => "to-zero"

mutual
/-- A math expression of CSS Values and Units Level 4, indexed by its type, so that the type
algebra runs as the expression is built. -/
inductive CalcExpr : MathType → Type where
  | number (v : Decimal) : CalcExpr .number
  | dimension (d : DimKind) (v : Decimal) (u : d.Unit) : CalcExpr (.known (.base (.ofDim d)))
  | percentage (v : Decimal) : CalcExpr (.known (.base .percent))
  | constant (c : CalcConstant) : CalcExpr .number
  | substitution (s : Substitution) : CalcExpr .unknown
  | add {s t : MathType} (a : CalcExpr s) (b : CalcExpr t) : CalcExpr (s.add t)
  | sub {s t : MathType} (a : CalcExpr s) (b : CalcExpr t) : CalcExpr (s.add t)
  | mul {s t : MathType} (a : CalcExpr s) (b : CalcExpr t) : CalcExpr (s.mul t)
  | div {s t : MathType} (a : CalcExpr s) (b : CalcExpr t) : CalcExpr (s.div t)
  | min {t : MathType} (args : CalcArgs t) : CalcExpr t
  | max {t : MathType} (args : CalcArgs t) : CalcExpr t
  | hypot {t : MathType} (args : CalcArgs t) : CalcExpr t
  /-- `clamp()`, where a missing bound is `none`. -/
  | clamp {s t u : Option MathType} {v : MathType} (lo : CalcOpt s) (val : CalcExpr v)
      (hi : CalcOpt u) : CalcExpr ((v.addOpt s).addOpt u)
  | round {s : MathType} {t : Option MathType} (strategy : Option RoundingStrategy)
      (a : CalcExpr s) (b : CalcOpt t) : CalcExpr (s.round t)
  | mod {s t : MathType} (a : CalcExpr s) (b : CalcExpr t) : CalcExpr (s.add t)
  | rem {s t : MathType} (a : CalcExpr s) (b : CalcExpr t) : CalcExpr (s.add t)
  | sin {s : MathType} (a : CalcExpr s) : CalcExpr s.trig
  | cos {s : MathType} (a : CalcExpr s) : CalcExpr s.trig
  | tan {s : MathType} (a : CalcExpr s) : CalcExpr s.trig
  | asin {s : MathType} (a : CalcExpr s) : CalcExpr (s.numberTo (.known (.base .angle)))
  | acos {s : MathType} (a : CalcExpr s) : CalcExpr (s.numberTo (.known (.base .angle)))
  | atan {s : MathType} (a : CalcExpr s) : CalcExpr (s.numberTo (.known (.base .angle)))
  | atan2 {s t : MathType} (a : CalcExpr s) (b : CalcExpr t) :
      CalcExpr ((s.add t).anyTo (.known (.base .angle)))
  | pow {s t : MathType} (a : CalcExpr s) (b : CalcExpr t) : CalcExpr ((s.add t).numberTo)
  | sqrt {s : MathType} (a : CalcExpr s) : CalcExpr s.numberTo
  | exp {s : MathType} (a : CalcExpr s) : CalcExpr s.numberTo
  | log {s : MathType} {t : Option MathType} (a : CalcExpr s) (base : CalcOpt t) :
      CalcExpr (s.addOpt t).numberTo
  | abs {s : MathType} (a : CalcExpr s) : CalcExpr s
  | sign {s : MathType} (a : CalcExpr s) : CalcExpr (s.anyTo .number)

/-- One or more comma-separated arguments, whose types must add. -/
inductive CalcArgs : MathType → Type where
  | one {t : MathType} (a : CalcExpr t) : CalcArgs t
  | cons {s t : MathType} (a : CalcExpr s) (rest : CalcArgs t) : CalcArgs (s.add t)

/-- An optional argument; `none` is spelled as the keyword `none` in `clamp()`. -/
inductive CalcOpt : Option MathType → Type where
  | none : CalcOpt none
  | some {t : MathType} (a : CalcExpr t) : CalcOpt (some t)
end

namespace CalcExpr

/-- How tightly an operand must bind: a sum, a product's operand, or a product's right
operand, which a product must also be parenthesized in. -/
abbrev Prec := Nat

def wrap (need : Bool) (ps : List Piece) : List Piece :=
  if need then .punct .openParen :: ps ++ [.punct .closeParen] else ps

def fn (name : String) (args : List (List Piece)) : List Piece :=
  .ident name :: .punct .openParen ::
    joinPieces [.punct .comma, .space] args ++ [.punct .closeParen]

def binop (p : Punct) (a b : List Piece) : List Piece := a ++ .space :: .punct p :: .space :: b

mutual
def piecesAt {t : MathType} : CalcExpr t → Prec → List Piece
  | .number v, _ => [.number v]
  | .dimension d v u, _ => [.number v, .unit (d.unitName u)]
  | .percentage v, _ => [.number v, .punct .percent]
  | .constant c, _ => [.ident c.name]
  | .substitution s, _ => s.pieces
  | .add a b, p => wrap (p > 0) (binop .plus (piecesAt a 0) (piecesAt b 1))
  | .sub a b, p => wrap (p > 0) (binop .minus (piecesAt a 0) (piecesAt b 1))
  | .mul a b, p => wrap (p > 1) (binop .star (piecesAt a 1) (piecesAt b 2))
  | .div a b, p => wrap (p > 1) (binop .slash (piecesAt a 1) (piecesAt b 2))
  | .min args, _ => fn "min" (argsPieces args)
  | .max args, _ => fn "max" (argsPieces args)
  | .hypot args, _ => fn "hypot" (argsPieces args)
  | .clamp lo v hi, _ => fn "clamp" [optPieces lo, piecesAt v 0, optPieces hi]
  | .round s a b, _ =>
    fn "round" ((match s with | some s => [[.ident s.name]] | none => []) ++
      piecesAt a 0 :: optList b)
  | .mod a b, _ => fn "mod" [piecesAt a 0, piecesAt b 0]
  | .rem a b, _ => fn "rem" [piecesAt a 0, piecesAt b 0]
  | .sin a, _ => fn "sin" [piecesAt a 0]
  | .cos a, _ => fn "cos" [piecesAt a 0]
  | .tan a, _ => fn "tan" [piecesAt a 0]
  | .asin a, _ => fn "asin" [piecesAt a 0]
  | .acos a, _ => fn "acos" [piecesAt a 0]
  | .atan a, _ => fn "atan" [piecesAt a 0]
  | .atan2 a b, _ => fn "atan2" [piecesAt a 0, piecesAt b 0]
  | .pow a b, _ => fn "pow" [piecesAt a 0, piecesAt b 0]
  | .sqrt a, _ => fn "sqrt" [piecesAt a 0]
  | .exp a, _ => fn "exp" [piecesAt a 0]
  | .log a b, _ => fn "log" (piecesAt a 0 :: optList b)
  | .abs a, _ => fn "abs" [piecesAt a 0]
  | .sign a, _ => fn "sign" [piecesAt a 0]

def argsPieces {t : MathType} : CalcArgs t → List (List Piece)
  | .one a => [piecesAt a 0]
  | .cons a rest => piecesAt a 0 :: argsPieces rest

def optPieces {t : Option MathType} : CalcOpt t → List Piece
  | .none => [.ident "none"]
  | .some a => piecesAt a 0

def optList {t : Option MathType} : CalcOpt t → List (List Piece)
  | .none => []
  | .some a => [piecesAt a 0]
end

/-- A math function on its own: a function node as it stands, and anything else inside
`calc()`. -/
def pieces {t : MathType} (e : CalcExpr t) : List Piece :=
  match e with
  | .number _ | .dimension .. | .percentage _ | .constant _ | .substitution _ | .add .. | .sub ..
  | .mul .. | .div .. => fn "calc" [piecesAt e 0]
  | _ => piecesAt e 0

mutual
def hasSubstitution {t : MathType} : CalcExpr t → Bool
  | .substitution _ => true
  | .number _ | .dimension .. | .percentage _ | .constant _ => false
  | .add a b | .sub a b | .mul a b | .div a b | .mod a b | .rem a b | .atan2 a b | .pow a b =>
    hasSubstitution a || hasSubstitution b
  | .min args | .max args | .hypot args => argsHasSubstitution args
  | .clamp lo v hi => optHasSubstitution lo || hasSubstitution v || optHasSubstitution hi
  | .round _ a b | .log a b => hasSubstitution a || optHasSubstitution b
  | .sin a | .cos a | .tan a | .asin a | .acos a | .atan a | .sqrt a | .exp a | .abs a
  | .sign a => hasSubstitution a

def argsHasSubstitution {t : MathType} : CalcArgs t → Bool
  | .one a => hasSubstitution a
  | .cons a rest => hasSubstitution a || argsHasSubstitution rest

def optHasSubstitution {t : Option MathType} : CalcOpt t → Bool
  | .none => false
  | .some a => hasSubstitution a
end

end CalcExpr

end CssModel
