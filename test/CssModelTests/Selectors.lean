/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

import CssModel
meta import CssModel

namespace CssModelTests.Selectors

open CssModel

def tag (name : String) (h : name.isEmpty = false := by decide +kernel) : Option TypeSelector :=
  some (.tag name h)

def i (name : String) (h : name.isEmpty = false := by decide +kernel) : Ident := ⟨name, h⟩

def ser {has pe : Bool} (l : ComplexList has pe) : String := render l.pieces

def one {has pe : Bool} (c : Compound has pe) : ComplexList has pe := .one (.last c)

#guard ser (one (Compound.of (tag "a") [.cls (i "nav"), .pseudo .hover]) : SelectorList) = "a.nav:hover"
#guard ser (one (Compound.of none [.id (i "1st")]) : SelectorList) = "#\\31 st"
#guard ser (one (Compound.of none [.attrMatch { name := i "lang" } .dashMatch "en" (some .i)]) : SelectorList) =
  "[lang|=\"en\" i]"
#guard ser (one (Compound.of (some (.universal (some (.named (i "svg"))))) []) : SelectorList) = "svg|*"
#guard ser (.one (Complex.ofList [(Compound.of (tag "ul") [], .child)] (Compound.of (tag "li") [])) :
  SelectorList) = "ul > li"
#guard render (ComplexList.pieces (.one (Complex.ofList [(Compound.of (tag "ul") [], .child)]
  (Compound.of (tag "li") [])) : SelectorList)) .compact = "ul>li"
#guard ser (one (Compound.withElement (tag "p") [] (.simple .firstLine)) : SelectorList) = "p::first-line"
#guard ser (one (Compound.withElement none [.cls (i "btn")] (.simple .before) [.hover]) : SelectorList) =
  ".btn::before:hover"
#guard ser (one (Compound.of none [.nthOf false ⟨2, 1⟩ (one (Compound.of none [.cls (i "item")]))]) :
  SelectorList) = ":nth-child(2n+1 of .item)"
#guard ser (one (Compound.of none [.nth .lastOfType ⟨-1, 3⟩]) : SelectorList) = ":nth-last-of-type(-n+3)"
#guard ser (one (Compound.of none [.nth .child ⟨0, 5⟩]) : SelectorList) = ":nth-child(5)"
#guard ser (one (Compound.of (tag "a") [.has (.one (.mk (some .child) (.last (Compound.of (tag "img") []))))]) :
  SelectorList) = "a:has(> img)"
#guard ser (one (Compound.of none [.is (.cons (.last (Compound.of (tag "h1") []))
  (.one (.last (Compound.of (tag "h2") []))))]) : SelectorList) = ":is(h1, h2)"
#guard ser (one (Compound.of none [.nesting, .cls (i "active")]) : SelectorList) = "&.active"
#guard ser (one (Compound.of none [.lang "en" ["fr-CA"]]) : SelectorList) = ":lang(\"en\", \"fr-CA\")"
#guard ser (one (Compound.withElement none [] (.part (i "label") [i "icon"])) : SelectorList) =
  "::part(label icon)"

-- `:has()` does not nest: its argument's selectors are typed without it.
#check_failure (Subclass.has (.one (.mk none (.last (Compound.of none
  [Subclass.has (.one (.mk none (.last (Compound.of (tag "b") []))))])))) : Subclass true)

-- Pseudo-elements are not allowed within `:is()`.
#check_failure (Subclass.is (one (Compound.withElement none [] (.simple .before))) : Subclass true)

-- After a pseudo-element come only the pseudo-classes it admits.
#check_failure (Compound.withElement none [] (.simple .before) [.firstChild] : Compound true true)

end CssModelTests.Selectors
