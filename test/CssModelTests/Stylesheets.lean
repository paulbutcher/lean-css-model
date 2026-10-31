/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

import CssModel
meta import CssModel

namespace CssModelTests.Stylesheets

open CssModel

def i (name : String) (h : name.isEmpty = false := by decide +kernel) : Ident := ⟨name, h⟩

def cls (name : String) (h : name.isEmpty = false := by decide +kernel) : SelectorList :=
  .one (.last (Compound.of none [.cls ⟨name, h⟩]))

def width (v : Comp (.numeric .length .nonneg)) : FeatureValue MediaFeature.width :=
  GrammarValue.of [v]

/-! Queries. -/

def wide : MediaQuery := .condition (.test (.compare .width .ge (width (px 600 .nonneg))))
def between : MediaQuery := .condition (.test (.between .width (width (px 400 .nonneg)) false true (width (px 700 .nonneg))))
def print : MediaQuery := .type .print (some true)
  [.test (.min .width (width (px 10 .nonneg))), .not (.test (.boolean .hover))]
def either : MediaQuery := .condition (.or (.test (.boolean .hover)) (.test (.plain .orientation (GrammarValue.of [kw .landscape]))) [])

#guard render (MediaQueryList.pieces [wide, print]) = "(width >= 600px), only print and (min-width: 10px) and (not (hover))"
#guard render between.pieces = "(400px <= width < 700px)"
#guard render either.pieces = "(hover) or (orientation: landscape)"
#guard render (Cond.pieces SupportsTest.pieces (.not (.test (.declaration (decl .display [kw .grid]))))) =
  "not (display: grid)"
#guard render (ContainerCondition.pieces {
    name := some ⟨"sidebar", by decide +kernel⟩,
    query := some (.test (.size (.compare .inlineSize .gt (GrammarValue.of [px 400])))) }) =
  "sidebar (inline-size > 400px)"

-- `width` is a range feature and `hover` is not, so only `width` takes range syntax.
#check_failure (FeatureTest.compare MediaFeature.hover .lt (GrammarValue.of [kw .none]))

def stuck : FeatureTest ContainerFeature := .plain .stuck (GrammarValue.of [kw .top])
def scrolled : ContainerTest := .scrollState (.test stuck)

-- Size features and scroll-state features each belong to their own query.
#check_failure (ContainerTest.size stuck)
#check_failure (ContainerTest.scrollState (.test (.boolean ContainerFeature.width)))

/-! Rules and stylesheets. -/

def card : Rule := .style (cls "card") [
  .decl (decl .padding [rem 1]),
  .decl (decl .color [kw .red] (important := true)),
  .rule (.style (.one (.mk (some .child) (.last (Compound.of none [.cls (i "title")])))) [
    .decl (decl .fontWeight [kw .bold])]),
  .rule (.media [wide] [.decl (decl .padding [rem 2])])]

def sheet : Stylesheet := {
  preamble := [.layer { first := i "base" } [{ first := i "components" }],
    .import { url := "reset.css", layer := some none }]
  namespaces := [{ pre := some (i "svg"), url := "http://www.w3.org/2000/svg" }]
  rules := [card,
    .keyframes (.ident ⟨"spin", by decide +kernel⟩) [
      { selector := .from, decls := [decl .transform [fn .rotate [deg 0]]] },
      { selector := .to, decls := [decl .transform [fn .rotate [deg 360]]] }],
    .fontFace [desc FontFaceDescriptor.fontFamily [str "Inter"],
      desc FontFaceDescriptor.fontDisplay [kw .swap]],
    .property ⟨"--angle", by decide +kernel⟩ [desc PropertyDescriptor.syntax_ [str "<angle>"],
      desc PropertyDescriptor.inherits [kw .false]],
    .layerStatement { first := i "utilities" } []] }

#guard sheet.serialize .compact ==
  "@layer base,components;@import url(\"reset.css\") layer;@namespace svg url(\"http://www.w3.org/2000/svg\");" ++
  ".card{padding:1rem;color:red!important;>.title{font-weight:bold;}@media (width>=600px){padding:2rem;}}" ++
  "@keyframes spin{from{transform:rotate(0deg);}to{transform:rotate(360deg);}}" ++
  "@font-face{font-family:\"Inter\";font-display:swap;}" ++
  "@property --angle{syntax:\"\\3c angle>\";inherits:false;}@layer utilities;"

#guard card.serialize == ".card {
  padding: 1rem;
  color: red !important;
  > .title {
    font-weight: bold;
  }
  @media (width >= 600px) {
    padding: 2rem;
  }
}"

#guard !sheet.hasUnchecked && !sheet.hasVerbatim

/-! Escape hatches. -/

def vendor : Declaration := .unchecked (i "-webkit-tap-highlight-color") ⟨[.ident (i "transparent")], rfl⟩
def raw : Rule := .verbatim "a{color:red}"
def custom : Declaration := .custom ⟨"--gap", by decide +kernel⟩ ⟨[.dimension 4 (i "px")], rfl⟩

#guard ({ rules := [.style (cls "x") [.decl vendor]] } : Stylesheet).hasUnchecked
#guard !({ rules := [.style (cls "x") [.decl vendor]] } : Stylesheet).hasVerbatim
#guard ({ rules := [raw] } : Stylesheet).hasVerbatim
#guard !({ rules := [.style (cls "x") [.decl custom]] } : Stylesheet).hasUnchecked
#guard ({ rules := [.navigation (.unchecked ⟨[.ident (i "x")], rfl⟩) []] } : Stylesheet).hasUnchecked
#guard ({ rules := [.unchecked {
    name := i "-moz-document", prelude := [.function (i "url-prefix") []],
    block := some [] }] } : Stylesheet).serialize .compact == "@-moz-document url-prefix(){}"

/-! A `style` attribute, and lasm's properties. -/

def style : DeclarationList := { decls := [decl .margin [zero, kw .auto], custom, vendor] }

#guard style.serialize = "margin: 0 auto; --gap: 4px; -webkit-tap-highlight-color: transparent"
#guard style.properties = [("margin", "0 auto", false), ("--gap", "4px", false),
  ("-webkit-tap-highlight-color", "transparent", false)]

/-- Nothing a style sheet holds, a string included, can close the `<style>` element. -/
example : ∀ a b, (({ rules := [.style (cls "x") [.decl (decl .content [str "</style>"])]] } :
    Stylesheet).serialize .compact).toList ≠ a ++ ['<', '/'] ++ b :=
  Stylesheet.serialize_safe _ _ (by decide +kernel)

end CssModelTests.Stylesheets
