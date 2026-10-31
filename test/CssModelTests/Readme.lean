/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

import CssModel
meta import CssModel

/-! The README's examples. -/

namespace CssModelTests.Readme

open CssModel

def centred : Declaration := decl .margin [zero, kw .auto]

def font (size : Decimal) (h : Range.nonneg.contains size = true) (families : List String) :
    Declaration :=
  decl .font [px size .nonneg h, .commaList1 (str "Inter") (families.map str)]

def tap : Declaration :=
  .unchecked ⟨"-webkit-tap-highlight-color", rfl⟩ ⟨[.ident ⟨"transparent", rfl⟩], rfl⟩

def card : Rule := .style (.one (.last (Compound.of none [.cls ⟨"card", rfl⟩]))) [
  .decl centred,
  .decl (decl .color [fn .rgb [num 0, num 128, num 255, slash, pct 50]]),
  .decl tap]

#guard card.serialize .compact ==
  ".card{margin:0 auto;color:rgb(0 128 255 / 50%);-webkit-tap-highlight-color:transparent;}"

#guard (font 12 rfl ["Roboto"]).serialize == "font: 12px \"Inter\", \"Roboto\""

/--
error: could not synthesize default value for parameter 'h' using tactics
---
error: Tactic `decide` proved that the proposition
  Admits Property.padding.syntax.toRegex Grammar.forProperty
    ((Regular.Regex.sym (Kind.numeric NumericKind.length { lo := some { mantissa := Int.ofNat 0, scale := 0 } })).cat
      ((Regular.Regex.sym (Kind.numeric NumericKind.length { })).cat Regular.Regex.eps))
is false
-/
#guard_msgs in
def bad : Declaration := decl .padding [px 10, px (-5)]

/-- info: some (some 1, ["<percentage [0,∞]>", "<length [0,∞]>"]) -/
#guard_msgs in
#eval (Value.explain .padding [px 10, px (-5)]).map fun r => (r.position, r.expected)

end CssModelTests.Readme
