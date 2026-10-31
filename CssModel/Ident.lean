/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Piece

@[expose] public section

/-! Any nonempty string serializes to a single identifier token, by escaping, so these types
constrain only what the token means, not how it is spelled. -/

namespace CssModel

structure Ident where
  name : String
  nonempty : name.isEmpty = false := by decide +kernel
  deriving Repr

instance : DecidableEq Ident := fun a b =>
  if h : a.name = b.name then isTrue (by cases a; cases b; simp_all) else isFalse (by intro e; simp_all)

def Ident.pieces (i : Ident) : List Piece := [.ident i.name]

/-- The CSS-wide keywords, which every property accepts as its whole value. -/
def cssWideKeywords : List String := ["inherit", "initial", "unset", "revert", "revert-layer"]

/-- Whether `s` is, ignoring ASCII case, one of `names`. It compares characters, which the
kernel reduces where it cannot reduce `String.map`. -/
def caselessIn (s : String) (names : List String) : Bool :=
  names.any fun n => s.toList.map Char.toLower == n.toList

def CustomIdent.allowed (name : String) : Bool :=
  !name.isEmpty && !caselessIn name ("default" :: cssWideKeywords)

/-- A `<custom-ident>`: an identifier that is not, ignoring ASCII case, a CSS-wide keyword or
`default`. -/
structure CustomIdent where
  name : String
  valid : CustomIdent.allowed name = true := by decide +kernel
  deriving Repr

def CustomIdent.toIdent (i : CustomIdent) : Ident :=
  ⟨i.name, by
    have h := i.valid
    cases he : i.name.isEmpty
    · rfl
    · simp [CustomIdent.allowed, he] at h⟩

def DashedIdent.allowed (name : String) : Bool := name.toList.take 2 == ['-', '-'] && name.length > 2

/-- A `<dashed-ident>`: an identifier starting with `--`, such as a custom property's name. `--`
alone is reserved. -/
structure DashedIdent where
  name : String
  valid : DashedIdent.allowed name = true := by decide +kernel
  deriving Repr

def DashedIdent.toIdent (i : DashedIdent) : Ident :=
  ⟨i.name, by
    have h := i.valid
    cases he : i.name.isEmpty
    · rfl
    · rw [String.isEmpty_iff.1 he] at h; simp [DashedIdent.allowed] at h⟩

end CssModel
