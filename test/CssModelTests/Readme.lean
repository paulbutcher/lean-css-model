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

#check_failure (decl .padding [px 10, px (-5)])

#guard (Value.explain .padding [px 10, px (-5)]).map (·.diagnosis) = some (.unexpected 1)

end CssModelTests.Readme
