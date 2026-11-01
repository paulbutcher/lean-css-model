/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

import CssModel
meta import CssModel

namespace CssModelTests.CustomIdent

open CssModel Regular

/-! A `<custom-ident>` excludes the keywords its slot's grammar names. -/

example : ¬ Admits Property.gridRowStart.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [ident "span"]) := by decide +kernel
example : ¬ Admits Property.gridRowStart.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [kw .span]) := by decide +kernel
example : ¬ Admits Property.animationName.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [ident "none"]) := by decide +kernel
-- A keyword of a longhand is not the name in the shorthand.
example : ¬ Admits Property.animation.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [ident "infinite", sec 1]) := by decide +kernel
-- Excluded by the prose, not the grammar.
example : ¬ Admits Property.containerName.syntax.toRegex Grammar.forProperty
    (Seg.shapeOf [ident "and"]) := by decide +kernel
example : CustomIdent.admits Exclusion.atCounterStyle "Disc" = false := by decide +kernel

def span2 : Value .gridRowStart := .of .gridRowStart [kw .span, int 2]
def spanFoo : Value .gridRowStart := .of .gridRowStart [kw .span, ident "foo"]
def foo2 : Value .gridRowStart := .of .gridRowStart [ident "foo", int 2]

/-- A keyword the slot does not exclude is a name like any other. -/
def ease : Value .animationName := .of .animationName [ident "ease"]

def layerAuto : LayerName := { first := ⟨"auto", by decide +kernel⟩ }

/-- A name held in a variable, with its proof. -/
def animated (name : String) (h : CustomIdent.admits Exclusion.animationName name = true) :
    Value .animationName :=
  .of .animationName [ident name Exclusion.animationName h]

def checkedName (name : String) : Option (Value .animationName) :=
  if h : CustomIdent.admits Exclusion.animationName name then some (animated name h) else none

#guard span2.serialize = "span 2"
#guard ease.serialize = "ease"
#guard (checkedName "Spin").map (·.serialize) = some "Spin"
#guard (checkedName "NONE").isNone
#guard render layerAuto.pieces = "auto"

/-! A custom identifier in an accepted value is never a keyword its slot excludes. -/

/-- The keyword lookup finds every keyword by its name. -/
theorem ofNameCaseless?_name (k : Keyword) : Keyword.ofNameCaseless? k.name = some k := by
  obtain ⟨i, h⟩ := k
  revert i
  decide +kernel

theorem conforms_not_excluded {x : Nat} (i : CustomIdent x) {s : Sym} (hany : s.any = false)
    (hc : Kind.conforms (.customIdent x) s = true) {e : Nat} (hs : s.customIdent = some e)
    (k : Keyword) (hk : e.testBit k.id = true) :
    i.name.toList.map Char.toLower ≠ k.name.toList.map Char.toLower := by
  intro heq
  simp only [Kind.conforms, hany, hs, Bool.false_or, Option.any_some, beq_iff_eq] at hc
  have hx : x.testBit k.id = true := by
    have := congrArg (Nat.testBit · k.id) hc
    simp only [Nat.testBit_and, hk, Bool.true_and] at this
    exact this
  have hlook : Keyword.ofNameCaseless? i.name = some k := by
    rw [← ofNameCaseless?_name k]
    simp only [Keyword.ofNameCaseless?, keywordCode, heq]
  have hv := i.valid
  simp [CustomIdent.admits, hlook, hx] at hv

/-- `s` occurs in a regular expression. -/
inductive Occurs (s : Sym) : Regex Sym → Prop where
  | sym : Occurs s (.sym s)
  | catLeft {r t} : Occurs s r → Occurs s (.cat r t)
  | catRight {r t} : Occurs s t → Occurs s (.cat r t)
  | altLeft {r t} : Occurs s r → Occurs s (.alt r t)
  | altRight {r t} : Occurs s t → Occurs s (.alt r t)
  | star {r} : Occurs s r → Occurs s (.star r)
  | interleaveLeft {r t} : Occurs s r → Occurs s (.interleave r t)
  | interleaveRight {r t} : Occurs s t → Occurs s (.interleave r t)
  | nonEmpty {r} : Occurs s r → Occurs s (.nonEmpty r)
  | allOf {r rs} : r ∈ rs → Occurs s r → Occurs s (.allOf rs)

theorem shuffle_mem {u v w : List α} {a : α} (h : Shuffle u v w) (ha : a ∈ w) : a ∈ u ∨ a ∈ v := by
  induction h with
  | nil => simp at ha
  | left _ ih =>
    rcases List.mem_cons.1 ha with rfl | ha
    · exact .inl (List.mem_cons_self ..)
    · exact (ih ha).imp (List.mem_cons_of_mem _) id
  | right _ ih =>
    rcases List.mem_cons.1 ha with rfl | ha
    · exact .inr (List.mem_cons_self ..)
    · exact (ih ha).imp id (List.mem_cons_of_mem _)

/-- Each letter of a word a grammar matches conforms to a symbol of the grammar. -/
theorem matches_conforms {g : Regex Sym} {w : List Kind} (h : Matches Kind.conforms g w)
    {a : Kind} (ha : a ∈ w) : ∃ s, Occurs s g ∧ a.conforms s = true := by
  induction h with
  | eps => simp at ha
  | sym hm =>
    rw [List.mem_singleton] at ha
    exact ⟨_, .sym, ha ▸ hm⟩
  | cat _ _ ih₁ ih₂ =>
    rcases List.mem_append.1 ha with ha | ha
    · obtain ⟨s, ho, hs⟩ := ih₁ ha; exact ⟨s, .catLeft ho, hs⟩
    · obtain ⟨s, ho, hs⟩ := ih₂ ha; exact ⟨s, .catRight ho, hs⟩
  | altLeft _ ih => obtain ⟨s, ho, hs⟩ := ih ha; exact ⟨s, .altLeft ho, hs⟩
  | altRight _ ih => obtain ⟨s, ho, hs⟩ := ih ha; exact ⟨s, .altRight ho, hs⟩
  | starNil => simp at ha
  | starCons _ _ ih₁ ih₂ =>
    rcases List.mem_append.1 ha with ha | ha
    · obtain ⟨s, ho, hs⟩ := ih₁ ha; exact ⟨s, .star ho, hs⟩
    · exact ih₂ ha
  | interleave _ _ hsh ih₁ ih₂ =>
    rcases shuffle_mem hsh ha with ha | ha
    · obtain ⟨s, ho, hs⟩ := ih₁ ha; exact ⟨s, .interleaveLeft ho, hs⟩
    · obtain ⟨s, ho, hs⟩ := ih₂ ha; exact ⟨s, .interleaveRight ho, hs⟩
  | nonEmpty _ ih => obtain ⟨s, ho, hs⟩ := ih ha; exact ⟨s, .nonEmpty ho, hs⟩
  | allOfNil => simp at ha
  | allOfCons _ _ hp ih₁ ih₂ =>
    rcases List.mem_append.1 ha with ha | ha
    · obtain ⟨s, ho, hs⟩ := ih₁ ha
      exact ⟨s, .allOf (hp.subset (List.mem_cons_self ..)) ho, hs⟩
    · obtain ⟨s, ho, hs⟩ := ih₂ ha
      cases ho with
      | allOf hr ho => exact ⟨s, .allOf (hp.subset (List.mem_cons_of_mem _ hr)) ho, hs⟩

/-- In every word of an accepted shape, a custom identifier is matched by a symbol of the
grammar, and its name is not, ignoring ASCII case, any keyword that symbol excludes. -/
theorem admits_not_excluded {g : Regex Sym} {extend : Regex Sym → Regex Sym} {shape : Regex Kind}
    (h : Admits g extend shape) {w : List Kind} (hw : Matches (· == ·) shape w) {x : Nat}
    (hx : Kind.customIdent x ∈ w) (i : CustomIdent x) :
    ∃ s, Occurs s (extend g) ∧ ∀ e (k : Keyword), s.any = false → s.customIdent = some e →
      e.testBit k.id = true → i.name.toList.map Char.toLower ≠ k.name.toList.map Char.toLower := by
  obtain ⟨s, ho, hc⟩ := matches_conforms (h w hw) hx
  exact ⟨s, ho, fun e k hany hs hk => conforms_not_excluded i hany hc hs k hk⟩

end CssModelTests.CustomIdent
