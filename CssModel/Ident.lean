/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Piece
public import CssModel.Generated.Names

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

/-- Whether `s` is, ignoring ASCII case, one of `names`. It compares characters, which the
kernel reduces where it cannot reduce `String.map`. -/
def caselessIn (s : String) (names : List String) : Bool :=
  names.any fun n => s.toList.map Char.toLower == n.toList

def keywordCodeAux : List Char → Nat → Nat
  | [], acc => acc
  | c :: cs, acc => if c.toNat < 127 then keywordCodeAux cs (acc * 128 + c.toNat + 1) else 0

/-- A name as a number, ignoring ASCII case: its characters as digits in base 128, each one more
than its lowercase code point, or 0 if one is not ASCII, as no keyword's is. Comparing numbers
lets the kernel find a keyword in logarithmically many steps. -/
def keywordCode (s : String) : Nat := keywordCodeAux (s.toList.map Char.toLower) 0

/-- The keyword `s` is, ignoring ASCII case. -/
def Keyword.ofNameCaseless? (s : String) : Option Keyword := Keyword.ofCode? (keywordCode s)

/-- A set of keywords, as a bit set of their ids. -/
def Keyword.bits (l : List Keyword) : Nat := l.foldl (fun acc k => acc ||| (1 <<< k.id)) 0

/-- Whether `name` is nonempty and not, ignoring ASCII case, a keyword in the bit set
`excluded`. -/
def CustomIdent.admits (excluded : Nat) (name : String) : Bool :=
  !name.isEmpty && (Keyword.ofNameCaseless? name).all fun k => !excluded.testBit k.id

/-- Every keyword `name` is not, which a literal identifier is proven to exclude. -/
def CustomIdent.excludable (name : String) : Nat :=
  match Keyword.ofNameCaseless? name with
  | some k => Keyword.allBits ^^^ (1 <<< k.id)
  | none => Keyword.allBits

/-- A `<custom-ident>`, proven not to be, ignoring ASCII case, any keyword in the bit set
`excluded`. It is valid wherever the keywords excluded are among those. -/
structure CustomIdent (excluded : Nat) where
  name : String
  valid : CustomIdent.admits excluded name = true := by decide +kernel
  deriving Repr

/-- The CSS-wide keywords and `default`, which every `<custom-ident>` excludes. -/
def CustomIdent.reserved : Nat :=
  Keyword.bits [.default, .inherit, .initial, .revert, .revertLayer, .unset]

def CustomIdent.toIdent {x : Nat} (i : CustomIdent x) : Ident :=
  ⟨i.name, by
    have h := i.valid
    cases he : i.name.isEmpty
    · rfl
    · simp [CustomIdent.admits, he] at h⟩


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
