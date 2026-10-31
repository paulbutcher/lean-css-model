/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

@[expose] public section

/-! CSSOM's "serialize an identifier" and "serialize a string", except that `<` is escaped as a
code point, `\3c `, rather than as `\<`, so that no serialized name or string can contain `<` and
so close the `<style>` element holding it. -/

namespace CssModel

def hexChar (n : Nat) : Char :=
  match n % 16 with
  | 0 => '0' | 1 => '1' | 2 => '2' | 3 => '3' | 4 => '4' | 5 => '5' | 6 => '6' | 7 => '7'
  | 8 => '8' | 9 => '9' | 10 => 'a' | 11 => 'b' | 12 => 'c' | 13 => 'd' | 14 => 'e' | _ => 'f'

/-- The lowercase hexadecimal digits of `n`, most significant first. -/
def hexDigits (n : Nat) : List Char :=
  if n < 16 then [hexChar n] else hexDigits (n / 16) ++ [hexChar n]
termination_by n
decreasing_by omega

/-- `c` escaped as a code point: a backslash, its hex digits, and the space that ends them. -/
def escapeCodePoint (c : Char) : List Char := '\\' :: hexDigits c.toNat ++ [' ']

def isIdentPassthrough (c : Char) : Bool :=
  c.toNat ≥ 0x80 || c == '-' || c == '_' || c.isAlphanum

def isControl (c : Char) : Bool := (c.toNat ≥ 1 && c.toNat ≤ 0x1f) || c.toNat == 0x7f

/-- One character of an identifier, away from the positions with rules of their own. -/
def identChar (c : Char) : List Char :=
  if c.toNat = 0 then ['�']
  else if isControl c || c == '<' then escapeCodePoint c
  else if isIdentPassthrough c then [c]
  else ['\\', c]

/-- The characters after the first: a digit straight after a leading `-` is escaped, since
`-1` would start a number. -/
def identRest (first : Char) : List Char → List Char
  | [] => []
  | d :: rest =>
    (if first == '-' && d.isDigit then escapeCodePoint d else identChar d) ++ rest.flatMap identChar

def serializeIdentChars : List Char → List Char
  | [] => []
  | ['-'] => ['\\', '-']
  | c :: rest => (if c.isDigit then escapeCodePoint c else identChar c) ++ identRest c rest

/-- CSSOM's "serialize an identifier". -/
def serializeIdent (s : String) : String := String.ofList (serializeIdentChars s.toList)

/-- The characters of an identifier with none of the rules for its start, as the name of a hash
token, which may begin with a digit. -/
def serializeName (s : String) : String := String.ofList (s.toList.flatMap identChar)

/-- A dimension's unit, which follows its number directly: as an identifier, except that a
leading `e` before a digit or a signed digit is escaped, since `1e3` would read as a number. -/
def serializeUnitChars : List Char → List Char
  | c :: d :: rest =>
    if (c == 'e' || c == 'E') && (d.isDigit || ((d == '+' || d == '-') && (rest.head?.any Char.isDigit)))
    then escapeCodePoint c ++ identRest c (d :: rest)
    else serializeIdentChars (c :: d :: rest)
  | l => serializeIdentChars l

def serializeUnit (s : String) : String := String.ofList (serializeUnitChars s.toList)

def stringChar (c : Char) : List Char :=
  if c.toNat = 0 then ['�']
  else if isControl c || c == '<' then escapeCodePoint c
  else if c == '"' || c == '\\' then ['\\', c]
  else [c]

/-- CSSOM's "serialize a string". -/
def serializeString (s : String) : String :=
  String.ofList ('"' :: s.toList.flatMap stringChar ++ ['"'])

theorem hexChar_ne_lt (n : Nat) : hexChar n ≠ '<' := by
  unfold hexChar; split <;> decide

theorem mem_hexDigits {n : Nat} {c : Char} (h : c ∈ hexDigits n) : c ≠ '<' := by
  induction n using Nat.strongRecOn with
  | _ n ih =>
    unfold hexDigits at h
    split at h
    · simp only [List.mem_singleton] at h
      exact h ▸ hexChar_ne_lt n
    · simp only [List.mem_append, List.mem_singleton] at h
      rcases h with h | h
      · exact ih (n / 16) (by omega) h
      · exact h ▸ hexChar_ne_lt n

theorem mem_escapeCodePoint {c d : Char} (h : d ∈ escapeCodePoint c) : d ≠ '<' := by
  simp only [escapeCodePoint, List.cons_append, List.mem_cons, List.mem_append,
    List.not_mem_nil, or_false] at h
  rcases h with rfl | h | rfl
  · decide
  · exact mem_hexDigits h
  · decide

theorem mem_identChar {c d : Char} (h : d ∈ identChar c) : d ≠ '<' := by
  unfold identChar at h
  split at h
  · simp only [List.mem_singleton] at h; subst h; decide
  split at h
  · exact mem_escapeCodePoint h
  · rename_i h₁
    simp only [Bool.or_eq_true, beq_iff_eq, not_or] at h₁
    split at h <;> simp only [List.mem_cons, List.not_mem_nil, or_false] at h
    · exact h ▸ h₁.2
    · rcases h with rfl | rfl
      · decide
      · exact h₁.2

theorem mem_identRest {c d : Char} {l : List Char} (h : d ∈ identRest c l) : d ≠ '<' := by
  cases l with
  | nil => simp [identRest] at h
  | cons e rest =>
    simp only [identRest, List.mem_append, List.mem_flatMap] at h
    rcases h with h | ⟨x, _, h⟩
    · split at h
      · exact mem_escapeCodePoint h
      · exact mem_identChar h
    · exact mem_identChar h

theorem mem_serializeIdentChars {d : Char} {l : List Char} (h : d ∈ serializeIdentChars l) :
    d ≠ '<' := by
  unfold serializeIdentChars at h
  split at h
  · simp at h
  · simp only [List.mem_cons, List.not_mem_nil, or_false] at h
    rcases h with rfl | rfl <;> decide
  · simp only [List.mem_append] at h
    rcases h with h | h
    · split at h
      · exact mem_escapeCodePoint h
      · exact mem_identChar h
    · exact mem_identRest h

theorem serializeIdent_no_lt (s : String) : '<' ∉ (serializeIdent s).toList := by
  simp only [serializeIdent, String.toList_ofList]
  exact fun h => mem_serializeIdentChars h rfl

theorem serializeName_no_lt (s : String) : '<' ∉ (serializeName s).toList := by
  simp only [serializeName, String.toList_ofList, List.mem_flatMap, not_exists, not_and]
  exact fun _ _ h => mem_identChar h rfl

theorem serializeUnit_no_lt (s : String) : '<' ∉ (serializeUnit s).toList := by
  simp only [serializeUnit, String.toList_ofList]
  intro h
  unfold serializeUnitChars at h
  split at h
  · split at h
    · simp only [List.mem_append] at h
      exact h.elim (fun h => mem_escapeCodePoint h rfl) (fun h => mem_identRest h rfl)
    · exact mem_serializeIdentChars h rfl
  · exact mem_serializeIdentChars h rfl

theorem mem_stringChar {c d : Char} (h : d ∈ stringChar c) : d ≠ '<' := by
  unfold stringChar at h
  split at h
  · simp only [List.mem_singleton] at h; subst h; decide
  split at h
  · exact mem_escapeCodePoint h
  · rename_i h₁
    simp only [Bool.or_eq_true, beq_iff_eq, not_or] at h₁
    split at h
    · simp only [List.mem_cons, List.not_mem_nil, or_false] at h
      rcases h with rfl | rfl
      · decide
      · rename_i h₂
        simp only [Bool.or_eq_true, beq_iff_eq] at h₂
        rcases h₂ with rfl | rfl <;> decide
    · simp only [List.mem_singleton] at h
      exact h ▸ h₁.2

theorem serializeString_no_lt (s : String) : '<' ∉ (serializeString s).toList := by
  simp only [serializeString, String.toList_ofList, List.mem_cons, List.mem_append,
    List.mem_flatMap, not_or, not_exists, not_and]
  exact ⟨⟨by decide, fun _ _ h => mem_stringChar h rfl⟩, by decide⟩

end CssModel
