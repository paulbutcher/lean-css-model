/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

@[expose] public section

namespace CssModel

/-- An exact decimal, `mantissa × 10 ^ -scale`. A literal such as `1.25` keeps the digits it was
written with, and comparisons reduce under `decide`, which a `Float` would not. -/
structure Decimal where
  mantissa : Int
  scale : Nat
  deriving DecidableEq, Repr, Inhabited

namespace Decimal

instance : OfNat Decimal n := ⟨⟨n, 0⟩⟩

instance : OfScientific Decimal where
  ofScientific m neg e := if neg then ⟨m, e⟩ else ⟨m * 10 ^ e, 0⟩

instance : Neg Decimal := ⟨fun d => ⟨-d.mantissa, d.scale⟩⟩

instance : IntCast Decimal := ⟨fun i => ⟨i, 0⟩⟩

/-- `d` scaled to `scale + extra` decimal places. -/
def widen (d : Decimal) (extra : Nat) : Int := d.mantissa * ((10 ^ extra : Nat) : Int)

def le (a b : Decimal) : Prop := a.widen b.scale ≤ b.widen a.scale

def lt (a b : Decimal) : Prop := a.widen b.scale < b.widen a.scale

instance : LE Decimal := ⟨le⟩

instance : LT Decimal := ⟨lt⟩

instance (a b : Decimal) : Decidable (a ≤ b) :=
  inferInstanceAs (Decidable (a.widen b.scale ≤ b.widen a.scale))

instance (a b : Decimal) : Decidable (a < b) :=
  inferInstanceAs (Decidable (a.widen b.scale < b.widen a.scale))

/-- `d × p / q`, rounded towards zero at `extra` further decimal places, for converting between
units whose ratio is not a power of ten. -/
def mulRatio (d : Decimal) (p q : Nat) (extra : Nat := 0) : Decimal :=
  ⟨d.widen extra * p / q, d.scale + extra⟩

/-- Whether `d` is a whole number. -/
def isInteger (d : Decimal) : Bool := d.mantissa % ((10 ^ d.scale : Nat) : Int) == 0

def digitChar (n : Nat) : Char :=
  match n % 10 with
  | 0 => '0' | 1 => '1' | 2 => '2' | 3 => '3' | 4 => '4'
  | 5 => '5' | 6 => '6' | 7 => '7' | 8 => '8' | _ => '9'

theorem digitChar_isDigit (n : Nat) : (digitChar n).isDigit := by
  unfold digitChar; split <;> decide

/-- The decimal digits of `n`, most significant first. -/
def digits (n : Nat) : List Char :=
  if n < 10 then [digitChar n] else digits (n / 10) ++ [digitChar n]
termination_by n
decreasing_by omega

/-- `n` as at least `width` digits, padded with leading zeros. -/
def padDigits (n width : Nat) : List Char :=
  List.replicate (width - (digits n).length) '0' ++ digits n

/-- The digits of `d` as a CSS `<number-token>`: an optional `-`, digits, and an optional `.` with
`scale` digits after it, never an exponent. -/
def toChars (d : Decimal) : List Char :=
  let sign := if d.mantissa < 0 then ['-'] else []
  let all := padDigits d.mantissa.natAbs (d.scale + 1)
  let whole := all.take (all.length - d.scale)
  let frac := all.drop (all.length - d.scale)
  sign ++ whole ++ (if d.scale = 0 then [] else '.' :: frac)

instance : ToString Decimal := ⟨fun d => String.ofList d.toChars⟩

theorem mem_digits {n : Nat} {c : Char} (h : c ∈ digits n) : c.isDigit := by
  induction n using Nat.strongRecOn with
  | _ n ih =>
    unfold digits at h
    have hd := digitChar_isDigit
    split at h
    · simp only [List.mem_singleton] at h
      exact h ▸ hd n
    · simp only [List.mem_append, List.mem_singleton] at h
      rcases h with h | h
      · exact ih (n / 10) (by omega) h
      · exact h ▸ hd n

theorem mem_padDigits {n width : Nat} {c : Char} (h : c ∈ padDigits n width) : c.isDigit := by
  simp only [padDigits, List.mem_append, List.mem_replicate] at h
  rcases h with ⟨_, rfl⟩ | h
  · decide
  · exact mem_digits h

theorem mem_toChars {d : Decimal} {c : Char} (h : c ∈ d.toChars) :
    c.isDigit ∨ c = '-' ∨ c = '.' := by
  have hp : ∀ x ∈ padDigits d.mantissa.natAbs (d.scale + 1), x.isDigit := fun _ => mem_padDigits
  simp only [toChars, List.mem_append] at h
  rcases h with (h | h) | h
  · split at h <;> simp_all
  · exact .inl (hp _ (List.mem_of_mem_take h))
  · split at h
    · simp at h
    · rcases List.mem_cons.1 h with rfl | h
      · simp
      · exact .inl (hp _ (List.mem_of_mem_drop h))

end Decimal

end CssModel
