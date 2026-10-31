/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel
meta import CssModelBench.Timing

/-! Single declarations, from the simplest to the largest shorthands. -/

namespace CssModelBench.Shorthands

open CssModel

#bench "display: flex"
  def display : Declaration := decl .display [kw .flex]

#bench "color: rgb(255 0 0 / 0.5)"
  def color : Declaration := decl .color [fn .rgb [num 255, num 0, num 0, slash, num 0.5]]

#bench "margin: 0 auto"
  def margin : Declaration := decl .margin [zero, kw .auto]

#bench "font: italic small-caps bold condensed 16px / 1.5 \"Inter\", system-ui, sans-serif"
  def font : Declaration := decl .font [kw .italic, kw .smallCaps, kw .bold, kw .condensed, px 16,
    slash, num 1.5, str "Inter", comma, kw .systemUi, comma, kw .sansSerif]

#bench "font: 12px <family>, from a list"
  def fontList (first : String) (rest : List String) : Declaration :=
    decl .font [px 12, .commaList1 (str first) (rest.map str)]

#bench "background: two layers, then a color"
  def background : Declaration := decl .background [url "a.png", kw .noRepeat, kw .left, kw .top,
    comma, fn .linearGradient [kw .to, kw .right, comma, kw .red, comma, kw .blue], kw .center,
    slash, kw .cover, kw .fixed, kw .borderBox, kw .white]

#bench "grid-template: \"a a\" 40px \"b c\" 1fr / [left] 1fr [right] 2fr"
  def gridTemplate : Declaration := decl .gridTemplate [str "a a", px 40, str "b c", fr 1, slash,
    fn .lineNames [ident "left"], fr 1, fn .lineNames [ident "right"], fr 2]

#bench "grid-template-columns: repeat(auto-fill, minmax(10rem, 1fr))"
  def gridColumns : Declaration := decl .gridTemplateColumns
    [fn .autoRepeat [kw .autoFill, comma, fn .trackSizeMinmax [rem 10, comma, fr 1]]]

#bench "transition: three transitions"
  def transition : Declaration := decl .transition [ident "opacity", sec 0.2, kw .ease, comma,
    ident "transform", ms 300, fn .cubicBezier [num 0.2, comma, num 0, comma, num 0, comma, num 1],
    comma, kw .all, sec 1, kw .linear, sec 0.5]

#bench "box-shadow: two shadows"
  def boxShadow : Declaration := decl .boxShadow [zero, px 1, px 3, hex "0003", comma, kw .inset,
    zero, zero, zero, px 1, kw .red]

#bench "animation: spin 1s linear infinite"
  def animation : Declaration := decl .animation [ident "spin", sec 1, kw .linear, kw .infinite]

#bench "width: calc(100% - 2rem)"
  def width : Declaration := decl .width
    [math (.sub (.percentage 100) (.dimension .length 2 .rem))]

end CssModelBench.Shorthands
