/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

import CssModel
meta import CssModel

namespace CssModelTests.Values

open CssModel

/-! Values the specifications give as valid. -/

def margin1 : Value .margin := .of .margin [zero]
def margin2 : Value .margin := .of .margin [em 1, kw .auto]
def padding : Value .padding := .of .padding [pct 10]
def color1 : Value .color := .of .color [kw .transparent]
def color2 : Value .color := .of .color [hex "ff0000"]
def color3 : Value .color := .of .color [fn .rgb [num 0, num 128, num 255, slash, pct 50]]
def color4 : Value .color := .of .color [fn .hsl [deg 120, pct 100, pct 50]]
def color5 : Value .color := .of .color [fn .rgb [num 255, comma, num 0, comma, num 0]]
def font1 : Value .font := .of .font [px 12, slash, px 30, ident "Georgia", comma, kw .serif]
def font2 : Value .font := .of .font [kw .bold, kw .italic, kw .large, ident "Palatino", comma, kw .serif]
def font3 : Value .font := .of .font [kw .menu]
def background : Value .background :=
  .of .background [url "chess.png", kw .gray, pct 50, kw .repeat, kw .fixed]
def transform : Value .transform :=
  .of .transform [fn .translate [px 10, comma, px 20], fn .rotate [deg 45]]
def grid : Value .gridTemplateColumns := .of .gridTemplateColumns
  [fn .lineNames [ident "full-start"], fn .trackSizeMinmax [em 1, comma, fr 1],
   fn .lineNames [ident "main-start"], fn .trackSizeMinmax [zero, comma, em 40],
   fn .lineNames [ident "main-end"], fn .trackSizeMinmax [em 1, comma, fr 1],
   fn .lineNames [ident "full-end"]]
def opacity : Value .opacity := .of .opacity [pct 50]
def zIndex : Value .zIndex := .of .zIndex [kw .auto]

/-- A CSS-wide keyword is a value of every property. -/
def wide : Value .gridTemplateAreas := .of .gridTemplateAreas [kw .revertLayer]

/-- A value with an arbitrary-substitution function is accepted for any property. -/
def subst : Value .margin := .of .margin [px 10, var { name := "--x" }, kw .auto, kw .auto, kw .auto]

/-- A math function is valid wherever its type is, range restrictions included, since its
result is clamped. -/
def calc1 : Value .width := .of .width [math (.sub (.percentage 100) (.dimension .length 3 .em))]
def calc2 : Value .padding := .of .padding [math (.mul (.number (-10)) (.dimension .length 1 .px))]
def calc3 : Value .width := .of .width
  [math (.min (.cons (.dimension .length 10 .px) (.one (.dimension .length 5 .vw))))]

/-- A length times a length divided by a length is a length. -/
def calc4 : Value .width := .of .width
  [math (.div (.mul (.dimension .length 1 .px) (.dimension .length 2 .px)) (.dimension .length 1 .px))]

/-- An integer is also a number. -/
def opacityInt : Value .opacity := .of .opacity [int 1]

/-- `round()` may omit its interval when rounding a number. -/
def round1 : Value .opacity := .of .opacity [math (.round none (.number 0.5) .none)]
def round2 : Value .width := .of .width
  [math (.round (some .up) (.dimension .length 10 .px) (.some (.dimension .length 3 .px)))]

/-- A value built from Lean variables, checked at compile time. -/
def fromVariables (x : Decimal) (h : Range.nonneg.contains x = true) (families : List String) :
    Value .font :=
  .of .font [px x .nonneg h, .commaList1 (str "Inter") (families.map str)]

/-! Values the grammars must reject, decided at compile time. -/

example : ¬ Admits Property.padding.syntax.toRegex Grammar.forProperty (Seg.shapeOf [px (-1)]) := by
  decide +kernel

example : ¬ Admits Property.margin.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [kw .auto, kw .auto, kw .auto, kw .auto, kw .auto]) := by decide +kernel

example : ¬ Admits Property.margin.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [kw .inherit, px 10]) := by decide +kernel

example : ¬ ArgsAccepted .rotate (Seg.shapeOf [px 10]) := by decide +kernel

/-- `1px * 1px` is a length squared, which no property takes. -/
example : ¬ Admits Property.width.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [math (.mul (.dimension .length 1 .px) (.dimension .length 1 .px))]) := by
  decide +kernel

/-- Rounding a length needs an interval. -/
example : ¬ Admits Property.width.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [math (.round none (.dimension .length 10 .px) .none)]) := by
  decide +kernel

/-! The same, explained at run time. -/

#guard (Value.explain .color [px 10]).isSome
#guard (Value.explain .font [kw .serif]).isSome
#guard (Value.explain .zIndex [num 1.5]).isSome
#guard (Value.explain .opacity [kw .red]).isSome
#guard (Value.explain .width [math (.add (.dimension .length 1 .px) (.dimension .time 1 .s))]).isSome
#guard (Value.explain .margin [px 1, px 2]).isNone

-- The rejected component is the `-1px`, at position 1, where a nonnegative length was expected.
#guard (Value.explain .padding [px 1, px (-1), px 1]).map (fun r => (r.position, r.expected)) =
  some (some 1, ["<percentage [0,∞]>", "<length [0,∞]>"])

-- Five margins are one too many: every component is acceptable but the last, where only the
-- end could come.
#guard (Value.explain .margin [px 1, px 1, px 1, px 1, px 1]).map (fun r => (r.position, r.expected)) =
  some (some 4, [])

-- A value that ends too soon.
#guard (Value.explain .gridArea [ident "a", slash]).map (fun r => (r.position, r.expected.contains "<custom-ident>")) =
  some (none, true)

/-! Serialization. -/

#guard color3.serialize = "rgb(0 128 255 / 50%)"
#guard color5.serialize = "rgb(255, 0, 0)"
#guard font1.serialize = "12px / 30px Georgia, serif"
#guard calc1.serialize = "calc(100% - 3em)"
#guard calc2.serialize = "calc(-10 * 1px)"
#guard calc3.serialize = "min(10px, 5vw)"
#guard calc4.serialize = "calc(1px * 2px / 1px)"
#guard grid.serialize =
  "[full-start] minmax(1em, 1fr) [main-start] minmax(0, 40em) [main-end] minmax(1em, 1fr) [full-end]"
#guard (fromVariables 2 rfl ["Roboto", "sans"]).serialize = "2px \"Inter\", \"Roboto\", \"sans\""
#guard subst.serialize = "10px var(--x) auto auto auto"
#guard subst.hasSubstitution
#guard !margin2.hasSubstitution

/-! The type algebra of CSS Typed OM. -/

#guard CalcType.add (.base .length) (.base .percent) = some { length := 1, hint := some .length }
#guard CalcType.add (.base .length) (.base .time) = none
#guard CalcType.mul (.base .length) (.base .length) = some { length := 2 }
#guard (CalcType.base .length).invert = { length := -1 }
#guard CalcType.add { length := 1, hint := some .length } (.base .percent) =
  some { length := 1, hint := some .length }

end CssModelTests.Values
