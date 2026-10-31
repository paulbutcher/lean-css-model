/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Escape

@[expose] public section

/-! The `<ident-token>` and `<string-token>` productions of CSS Syntax Level 3, as relations between
a token's text and the value the tokenizer decodes from it, stated without reference to the
serializer, and proofs that `serializeIdent` and `serializeString` produce single such tokens
whose values are their inputs. -/

namespace CssModel

namespace TokenSpec

def isHexDigit (c : Char) : Bool :=
  ('0' ≤ c && c ≤ '9') || ('a' ≤ c && c ≤ 'f') || ('A' ≤ c && c ≤ 'F')

def isNewline (c : Char) : Bool := c == '\n' || c == '\r' || c == '\x0c'

def isWhitespace (c : Char) : Bool := isNewline c || c == '\t' || c == ' '

def hexVal (c : Char) : Nat :=
  if c ≤ '9' then c.toNat - 48 else if c ≤ 'F' then c.toNat - 55 else c.toNat - 87

def hexValue (ds : List Char) : Nat := ds.foldl (fun acc d => acc * 16 + hexVal d) 0

/-- The code point an escape decodes to: U+FFFD for zero, a surrogate, or anything too large. -/
def codePoint (n : Nat) : Char :=
  if n = 0 ∨ (0xD800 ≤ n ∧ n ≤ 0xDFFF) ∨ 0x10FFFF < n then '�' else Char.ofNat n

/-- An escape and the code point it decodes to. A hex escape is taken only with the whitespace
that ends it, since without it how far the escape extends depends on what follows. -/
inductive Escape : List Char → Char → Prop where
  | hex {ds : List Char} {w : Char} (hne : ds ≠ []) (hlen : ds.length ≤ 6)
      (hd : ∀ d ∈ ds, isHexDigit d = true) (hw : isWhitespace w = true) :
      Escape ('\\' :: ds ++ [w]) (codePoint (hexValue ds))
  | char {c : Char} (hn : isNewline c = false) (hh : isHexDigit c = false) : Escape ['\\', c] c

def isIdentStart (c : Char) : Bool :=
  ('a' ≤ c && c ≤ 'z') || ('A' ≤ c && c ≤ 'Z') || c == '_' || c.toNat ≥ 0x80

def isIdentCode (c : Char) : Bool := isIdentStart c || ('0' ≤ c && c ≤ '9') || c == '-'

/-- A run of ident code points and escapes, as "consume an ident sequence" reads it. -/
inductive IdentRest : List Char → List Char → Prop where
  | nil : IdentRest [] []
  | char {c : Char} {t v : List Char} (h : isIdentCode c = true) (r : IdentRest t v) :
      IdentRest (c :: t) (c :: v)
  | escape {e t v : List Char} {c : Char} (he : Escape e c) (r : IdentRest t v) :
      IdentRest (e ++ t) (c :: v)

/-- An `<ident-token>`: a start that "would start an ident sequence", and the rest of it. -/
inductive IdentToken : List Char → List Char → Prop where
  | start {c : Char} {t v : List Char} (h : isIdentStart c = true) (r : IdentRest t v) :
      IdentToken (c :: t) (c :: v)
  | escape {e t v : List Char} {c : Char} (he : Escape e c) (r : IdentRest t v) :
      IdentToken (e ++ t) (c :: v)
  | dashDash {t v : List Char} (r : IdentRest t v) : IdentToken ('-' :: '-' :: t) ('-' :: '-' :: v)
  | dashStart {c : Char} {t v : List Char} (h : isIdentStart c = true) (r : IdentRest t v) :
      IdentToken ('-' :: c :: t) ('-' :: c :: v)
  | dashEscape {e t v : List Char} {c : Char} (he : Escape e c) (r : IdentRest t v) :
      IdentToken ('-' :: (e ++ t)) ('-' :: c :: v)

/-- The contents of a string between its quotes `q`. -/
inductive StringBody (q : Char) : List Char → List Char → Prop where
  | nil : StringBody q [] []
  | char {c : Char} {t v : List Char} (hq : c ≠ q) (hb : c ≠ '\\') (hn : isNewline c = false)
      (r : StringBody q t v) : StringBody q (c :: t) (c :: v)
  | escape {e t v : List Char} {c : Char} (he : Escape e c) (r : StringBody q t v) :
      StringBody q (e ++ t) (c :: v)

/-- A `<string-token>`, closed by the quote that opened it. -/
inductive StringToken : List Char → List Char → Prop where
  | mk {q : Char} {t v : List Char} (hq : q = '"' ∨ q = '\'') (b : StringBody q t v) :
      StringToken (q :: t ++ [q]) v

end TokenSpec

open TokenSpec

/-- What decoding makes of a character the serializers were given: NUL cannot be written, and
becomes U+FFFD. -/
def decodeNul (c : Char) : Char := if c.toNat = 0 then '�' else c

theorem hexVal_hexChar (n : Nat) : hexVal (hexChar n) = n % 16 := by
  have : n % 16 < 16 := Nat.mod_lt _ (by decide)
  unfold hexChar
  generalize n % 16 = k at this ⊢
  match k, this with
  | 0, _ | 1, _ | 2, _ | 3, _ | 4, _ | 5, _ | 6, _ | 7, _ | 8, _ | 9, _ | 10, _ | 11, _ | 12, _
  | 13, _ | 14, _ | 15, _ => decide
  | _ + 16, h => exact absurd h (by omega)

theorem isHexDigit_hexChar (n : Nat) : isHexDigit (hexChar n) = true := by
  unfold hexChar; split <;> decide

theorem hexValue_append (l : List Char) (d : Char) :
    hexValue (l ++ [d]) = hexValue l * 16 + hexVal d := by
  simp [hexValue, List.foldl_append]

theorem hexValue_hexDigits (n : Nat) : hexValue (hexDigits n) = n := by
  induction n using Nat.strongRecOn with
  | _ n ih =>
    unfold hexDigits
    split
    · simp [hexValue, hexVal_hexChar]; omega
    · rename_i hn
      rw [hexValue_append, ih (n / 16) (by omega), hexVal_hexChar]; omega

theorem hexDigits_ne_nil (n : Nat) : hexDigits n ≠ [] := by
  unfold hexDigits; split <;> simp

theorem isHexDigit_of_mem_hexDigits {n : Nat} {c : Char} (h : c ∈ hexDigits n) :
    isHexDigit c = true := by
  induction n using Nat.strongRecOn with
  | _ n ih =>
    unfold hexDigits at h
    split at h
    · simp only [List.mem_singleton] at h; exact h ▸ isHexDigit_hexChar n
    · simp only [List.mem_append, List.mem_singleton] at h
      rcases h with h | h
      · exact ih (n / 16) (by omega) h
      · exact h ▸ isHexDigit_hexChar n

theorem length_hexDigits_le (k n : Nat) (h : n < 16 ^ (k + 1)) :
    (hexDigits n).length ≤ k + 1 := by
  induction k generalizing n with
  | zero => unfold hexDigits; split <;> simp_all
  | succ k ih =>
    unfold hexDigits
    split
    · simp
    · simp only [List.length_append, List.length_singleton]
      have := ih (n / 16) (by rw [Nat.pow_succ] at h; omega)
      omega

theorem toNat_valid (c : Char) : c.toNat < 0xd800 ∨ (0xdfff < c.toNat ∧ c.toNat < 0x110000) := by
  have := c.valid
  unfold UInt32.isValidChar at this
  exact this

theorem codePoint_toNat {c : Char} (h : c.toNat ≠ 0) : codePoint c.toNat = c := by
  have := toNat_valid c
  unfold codePoint
  split
  · omega
  · exact Char.ofNat_toNat c

theorem escapeCodePoint_escape {c : Char} (h : c.toNat ≠ 0) : Escape (escapeCodePoint c) c := by
  have e := Escape.hex (ds := hexDigits c.toNat) (w := ' ') (hexDigits_ne_nil _)
    (length_hexDigits_le 5 _ (by have := toNat_valid c; omega))
    (fun _ hd => isHexDigit_of_mem_hexDigits hd) (by decide)
  rwa [hexValue_hexDigits, codePoint_toNat h] at e

theorem charLe {a b : Char} : a ≤ b ↔ a.toNat ≤ b.toNat := Iff.rfl

theorem isControl_of_isNewline {c : Char} (h : isNewline c = true) : isControl c = true := by
  simp only [isNewline, Bool.or_eq_true, beq_iff_eq] at h
  rcases h with (rfl | rfl) | rfl <;> decide

/-- The ASCII letters and digits, as `Char.isAlphanum` and both `isHexDigit` and `isIdentCode`
see them. -/
theorem isAlphanum_iff (c : Char) : c.isAlphanum = true ↔
    (65 ≤ c.toNat ∧ c.toNat ≤ 90 ∨ 97 ≤ c.toNat ∧ c.toNat ≤ 122) ∨ 48 ≤ c.toNat ∧ c.toNat ≤ 57 := by
  simp only [Char.isAlphanum, Char.isAlpha, Char.isUpper, Char.isLower, Char.isDigit,
    Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq, ge_iff_le, UInt32.le_iff_toNat_le]
  exact Iff.rfl

theorem passthrough_of_isHexDigit {c : Char} (h : isHexDigit c = true) :
    isIdentPassthrough c = true := by
  simp only [isHexDigit, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq, charLe] at h
  change (48 ≤ c.toNat ∧ c.toNat ≤ 57 ∨ 97 ≤ c.toNat ∧ c.toNat ≤ 102) ∨
    65 ≤ c.toNat ∧ c.toNat ≤ 70 at h
  simp only [isIdentPassthrough, Bool.or_eq_true, beq_iff_eq, decide_eq_true_eq, isAlphanum_iff]
  omega

theorem isIdentCode_of_passthrough {c : Char} (h : isIdentPassthrough c = true) :
    isIdentCode c = true := by
  simp only [isIdentPassthrough, Bool.or_eq_true, beq_iff_eq, decide_eq_true_eq,
    isAlphanum_iff] at h
  simp only [isIdentCode, isIdentStart, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq,
    beq_iff_eq, charLe]
  change ((((97 ≤ c.toNat ∧ c.toNat ≤ 122 ∨ 65 ≤ c.toNat ∧ c.toNat ≤ 90) ∨ c = '_') ∨
    c.toNat ≥ 128) ∨ 48 ≤ c.toNat ∧ c.toNat ≤ 57) ∨ c = '-'
  rcases h with ((h | h) | h) | h
  · omega
  · exact .inr h
  · exact .inl (.inl (.inl (.inr h)))
  · omega

theorem isIdentStart_of_passthrough {c : Char} (h : isIdentPassthrough c = true) (hd : c ≠ '-')
    (hn : c.isDigit = false) : isIdentStart c = true := by
  simp only [isIdentPassthrough, Bool.or_eq_true, beq_iff_eq, decide_eq_true_eq,
    isAlphanum_iff] at h
  simp only [Char.isDigit, Bool.and_eq_false_iff, decide_eq_false_iff_not, ge_iff_le,
    UInt32.le_iff_toNat_le] at hn
  change ¬48 ≤ c.toNat ∨ ¬c.toNat ≤ 57 at hn
  simp only [isIdentStart, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq,
    charLe]
  change (((97 ≤ c.toNat ∧ c.toNat ≤ 122) ∨ 65 ≤ c.toNat ∧ c.toNat ≤ 90) ∨ c = '_') ∨
    c.toNat ≥ 128
  rcases h with ((h | h) | h) | h
  · omega
  · exact absurd h hd
  · exact .inl (.inr h)
  · omega

theorem isIdentStart_fffd : isIdentStart '�' = true := by decide

/-- One character as `identChar` writes it: itself, an ident code point, or an escape of it. -/
theorem identChar_cases (c : Char) :
    (identChar c = [decodeNul c] ∧ isIdentCode (decodeNul c) = true ∧
      (decodeNul c ≠ '-' → c.isDigit = false → isIdentStart (decodeNul c) = true)) ∨
      Escape (identChar c) (decodeNul c) := by
  by_cases h0 : c.toNat = 0
  · have : decodeNul c = '\uFFFD' := by simp [decodeNul, h0]
    rw [this]; unfold identChar; simp only [h0, ↓reduceIte]
    exact .inl ⟨trivial, by decide, fun _ _ => by decide⟩
  have : decodeNul c = c := by simp [decodeNul, h0]
  rw [this]; unfold identChar; simp only [h0, ↓reduceIte]
  by_cases h1 : (isControl c || c == '<') = true
  · simp only [h1, ↓reduceIte]; exact .inr (escapeCodePoint_escape h0)
  simp only [h1, Bool.false_eq_true, ↓reduceIte]
  simp only [Bool.or_eq_true, beq_iff_eq, not_or, Bool.not_eq_true] at h1
  by_cases h2 : isIdentPassthrough c = true
  · simp only [h2, ↓reduceIte]
    exact .inl ⟨trivial, isIdentCode_of_passthrough h2, isIdentStart_of_passthrough h2⟩
  · simp only [h2, Bool.false_eq_true, ↓reduceIte]
    refine .inr (.char ?_ ?_)
    · cases hn : isNewline c
      · rfl
      · rw [isControl_of_isNewline hn] at h1; cases h1.1
    · cases hh : isHexDigit c
      · rfl
      · exact absurd (passthrough_of_isHexDigit hh) h2

theorem identRest_flatMap (l : List Char) : IdentRest (l.flatMap identChar) (l.map decodeNul) := by
  induction l with
  | nil => exact .nil
  | cons c l ih =>
    rw [List.flatMap_cons, List.map_cons]
    rcases identChar_cases c with ⟨he, hc, _⟩ | he
    · rw [he]; exact .char hc ih
    · exact .escape he ih

theorem decodeNul_eq {c : Char} (h : c.toNat ≠ 0) : decodeNul c = c := by simp [decodeNul, h]

theorem digit_toNat {c : Char} (h : c.isDigit = true) : c.toNat ≠ 0 := by
  simp only [Char.isDigit, Bool.and_eq_true, decide_eq_true_eq, ge_iff_le,
    UInt32.le_iff_toNat_le] at h
  change 48 ≤ c.toNat ∧ c.toNat ≤ 57 at h
  omega

/-- The rest of an identifier after its first character `first`. -/
theorem identRest_cases (first : Char) (l : List Char) :
    IdentRest (identRest first l) (l.map decodeNul) := by
  cases l with
  | nil => exact .nil
  | cons d rest =>
    simp only [identRest, List.map_cons]
    split
    · rename_i h
      simp only [Bool.and_eq_true, beq_iff_eq] at h
      have hd := digit_toNat h.2
      rw [decodeNul_eq hd]
      exact .escape (escapeCodePoint_escape hd) (identRest_flatMap rest)
    · rcases identChar_cases d with ⟨he, hc, _⟩ | he
      · rw [he]; exact .char hc (identRest_flatMap rest)
      · exact .escape he (identRest_flatMap rest)

/-- A serialized identifier is a single `<ident-token>`, which decodes to the identifier, NUL
aside. -/
theorem serializeIdent_token (s : String) (h : s ≠ "") :
    IdentToken (serializeIdent s).toList (s.toList.map decodeNul) := by
  simp only [serializeIdent, String.toList_ofList]
  have hl : s.toList ≠ [] := by simpa using h
  generalize s.toList = l at hl ⊢
  cases l with
  | nil => exact absurd rfl hl
  | cons c rest =>
    by_cases hc : c = '-'
    · subst hc
      cases rest with
      | nil => exact .escape (t := []) (.char (by decide) (by decide)) .nil
      | cons d rest =>
        have hm : decodeNul '-' = '-' := by decide
        simp only [serializeIdentChars, identRest, List.map_cons, hm]
        rw [show ('-' : Char).isDigit = false by decide, show identChar '-' = ['-'] by decide]
        simp only [Bool.false_eq_true, ↓reduceIte, beq_self_eq_true, Bool.true_and,
          List.cons_append, List.nil_append]
        split
        · rename_i h
          have hd := digit_toNat h
          rw [decodeNul_eq hd]
          exact .dashEscape (escapeCodePoint_escape hd) (identRest_flatMap rest)
        · rename_i h
          rcases identChar_cases d with ⟨he, hcode, hstart⟩ | he
          · rw [he]
            by_cases hdash : decodeNul d = '-'
            · rw [hdash]; exact .dashDash (identRest_flatMap rest)
            · exact .dashStart (hstart hdash (by simpa using h)) (identRest_flatMap rest)
          · exact .dashEscape he (identRest_flatMap rest)
    · rw [serializeIdentChars.eq_3 _ _ (by simp [hc])]
      simp only [List.map_cons]
      split
      · rename_i h
        have hd := digit_toNat h
        rw [decodeNul_eq hd]
        exact .escape (escapeCodePoint_escape hd) (identRest_cases c rest)
      · rename_i h
        rcases identChar_cases c with ⟨he, _, hstart⟩ | he
        · rw [he]
          refine .start (hstart ?_ (by simpa using h)) (identRest_cases c rest)
          unfold decodeNul; split <;> simp_all
        · exact .escape he (identRest_cases c rest)

/-- One character as `stringChar` writes it: itself, or an escape of it. -/
theorem stringChar_cases (c : Char) :
    (stringChar c = [decodeNul c] ∧ decodeNul c ≠ '"' ∧ decodeNul c ≠ '\\' ∧
      isNewline (decodeNul c) = false) ∨ Escape (stringChar c) (decodeNul c) := by
  by_cases h0 : c.toNat = 0
  · have : decodeNul c = '\uFFFD' := by simp [decodeNul, h0]
    rw [this]; unfold stringChar; simp only [h0, ↓reduceIte]
    exact .inl ⟨trivial, by decide, by decide, by decide⟩
  have : decodeNul c = c := by simp [decodeNul, h0]
  rw [this]; unfold stringChar; simp only [h0, ↓reduceIte]
  by_cases h1 : (isControl c || c == '<') = true
  · simp only [h1, ↓reduceIte]; exact .inr (escapeCodePoint_escape h0)
  simp only [h1, Bool.false_eq_true, ↓reduceIte]
  simp only [Bool.or_eq_true, beq_iff_eq, not_or, Bool.not_eq_true] at h1
  have hn : isNewline c = false := by
    cases hn : isNewline c
    · rfl
    · rw [isControl_of_isNewline hn] at h1; cases h1.1
  by_cases h2 : (c == '"' || c == '\\') = true
  · simp only [h2, ↓reduceIte]
    simp only [Bool.or_eq_true, beq_iff_eq] at h2
    rcases h2 with rfl | rfl
    · exact .inr (.char (by decide) (by decide))
    · exact .inr (.char (by decide) (by decide))
  · simp only [h2, Bool.false_eq_true, ↓reduceIte]
    simp only [Bool.or_eq_true, beq_iff_eq, not_or] at h2
    exact .inl ⟨trivial, h2.1, h2.2, hn⟩

theorem stringBody_flatMap (l : List Char) :
    StringBody '"' (l.flatMap stringChar) (l.map decodeNul) := by
  induction l with
  | nil => exact .nil
  | cons c l ih =>
    rw [List.flatMap_cons, List.map_cons]
    rcases stringChar_cases c with ⟨he, hq, hb, hn⟩ | he
    · rw [he]; exact .char hq hb hn ih
    · exact .escape he ih

/-- A serialized string is a single `<string-token>`, which decodes to the string, NUL aside. -/
theorem serializeString_token (s : String) :
    StringToken (serializeString s).toList (s.toList.map decodeNul) := by
  simp only [serializeString, String.toList_ofList]
  exact .mk (.inl rfl) (stringBody_flatMap s.toList)

end CssModel
