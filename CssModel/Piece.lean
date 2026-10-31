/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Decimal
public import CssModel.Escape

@[expose] public section

/-! Every serializer in this library produces a list of `Piece`s, and only `render` turns them
into text. A piece is either escaped on the way out or drawn from a fixed table, so the one way
to emit text that is not checked is `Piece.verbatim`, and `render_safe` shows that without it the
output never contains `</`. -/

namespace CssModel

/-- How serialized blocks are laid out. -/
inductive Layout where
  /-- No whitespace that is not needed. -/
  | compact
  /-- A declaration or rule per line, nested blocks indented by two spaces a level. -/
  | indented
  deriving DecidableEq, Repr

inductive Punct where
  | space | newline | comma | semicolon | colon | openBrace | closeBrace | openParen
  | closeParen | openBracket | closeBracket | slash | star | plus | minus | gt | ge | tilde | bar
  | eq | dot | hash | at | bang | important | percent | dollar | caret | amp | question
  | url | unicodePrefix
  /-- `<` and the space after it, which keeps `<` from ever standing before `/`. -/
  | lt
  | le
  deriving DecidableEq, Repr

def Punct.text : Punct → String
  | .space => " " | .newline => "\n" | .comma => "," | .semicolon => ";" | .colon => ":"
  | .openBrace => "{" | .closeBrace => "}" | .openParen => "(" | .closeParen => ")"
  | .openBracket => "[" | .closeBracket => "]" | .slash => "/" | .star => "*" | .plus => "+"
  | .minus => "-" | .gt => ">" | .ge => ">=" | .tilde => "~" | .bar => "|" | .eq => "="
  | .dot => "." | .hash => "#" | .at => "@" | .bang => "!" | .important => "!important"
  | .percent => "%" | .dollar => "$" | .caret => "^" | .amp => "&" | .question => "?"
  | .url => "url(" | .unicodePrefix => "U+" | .lt => "< " | .le => "<="

inductive Piece where
  /-- An identifier, escaped by `serializeIdent`. -/
  | ident (s : String)
  /-- A dimension's unit, escaped by `serializeUnit`. -/
  | unit (s : String)
  /-- The name of a hash token, escaped by `serializeName`. -/
  | name (s : String)
  | string (s : String)
  | number (d : Decimal)
  /-- Lowercase hexadecimal digits, for a unicode range. -/
  | hex (n : Nat)
  | punct (p : Punct)
  /-- A space, in the indented layout only. -/
  | gap
  /-- A line break and two spaces of indent for each level, in the indented layout only. -/
  | line (depth : Nat)
  /-- Text trusted as-is. -/
  | verbatim (s : String)
  deriving Repr

namespace Piece

def chars (layout : Layout) : Piece → List Char
  | .ident s => (serializeIdent s).toList
  | .unit s => (serializeUnit s).toList
  | .name s => (serializeName s).toList
  | .string s => (serializeString s).toList
  | .number d => d.toChars
  | .hex n => hexDigits n
  | .punct p => p.text.toList
  | .gap => if layout = .indented then [' '] else []
  | .line depth => if layout = .indented then '\n' :: List.replicate (2 * depth) ' ' else []
  | .verbatim s => s.toList

def isVerbatim : Piece → Bool
  | .verbatim _ => true
  | _ => false

def space : Piece := .punct .space

end Piece

def render (ps : List Piece) (layout : Layout := .indented) : String :=
  String.ofList (ps.flatMap (Piece.chars layout))

/-- Pieces joined by `sep`. -/
def joinPieces (sep : List Piece) : List (List Piece) → List Piece
  | [] => []
  | [p] => p
  | p :: ps => p ++ sep ++ joinPieces sep ps

/-- Every `<` is followed at once by a space or `=`. -/
inductive Guarded : List Char → Prop where
  | nil : Guarded []
  | cons {c : Char} {l : List Char} (hc : c ≠ '<') (h : Guarded l) : Guarded (c :: l)
  | lt {d : Char} {l : List Char} (hd : d = ' ' ∨ d = '=') (h : Guarded l) :
      Guarded ('<' :: d :: l)

namespace Guarded

theorem append {a b : List Char} (ha : Guarded a) (hb : Guarded b) : Guarded (a ++ b) := by
  induction ha with
  | nil => exact hb
  | cons hc _ ih => exact .cons hc ih
  | lt hd _ ih => exact .lt hd ih

theorem of_no_lt {l : List Char} (h : '<' ∉ l) : Guarded l := by
  induction l with
  | nil => exact .nil
  | cons c l ih =>
    simp only [List.mem_cons, not_or] at h
    exact .cons (Ne.symm h.1) (ih h.2)

theorem flatMap {α : Type} {f : α → List Char} {l : List α} (h : ∀ x ∈ l, Guarded (f x)) :
    Guarded (l.flatMap f) := by
  induction l with
  | nil => exact .nil
  | cons x l ih =>
    rw [List.flatMap_cons]
    exact append (h x (by simp)) (ih fun y hy => h y (by simp [hy]))

theorem no_closeTag {l : List Char} (h : Guarded l) : ∀ s t, l ≠ s ++ ['<', '/'] ++ t := by
  induction h with
  | nil => intro s t h; cases s <;> simp at h
  | @cons c l hc _ ih =>
    intro s t h
    cases s with
    | nil => simp at h; exact hc h.1
    | cons x s =>
      simp only [List.cons_append, List.cons.injEq] at h
      exact ih s t (by simpa using h.2)
  | @lt d l hd _ ih =>
    intro s t h
    match s with
    | [] => simp at h; rcases hd with rfl | rfl <;> simp at h
    | [_] => simp at h; rcases hd with rfl | rfl <;> simp at h
    | _ :: _ :: s =>
      simp only [List.cons_append, List.cons.injEq] at h
      exact ih s t (by simpa using h.2.2)

end Guarded

theorem Piece.guarded (layout : Layout) (p : Piece) (h : p.isVerbatim = false) :
    Guarded (p.chars layout) := by
  cases p with
  | ident s => exact .of_no_lt (serializeIdent_no_lt s)
  | unit s => exact .of_no_lt (serializeUnit_no_lt s)
  | name s => exact .of_no_lt (serializeName_no_lt s)
  | string s => exact .of_no_lt (serializeString_no_lt s)
  | number d =>
    refine .of_no_lt fun hm => ?_
    rcases Decimal.mem_toChars hm with h | h | h <;> revert h <;> decide
  | hex n => exact .of_no_lt fun hm => mem_hexDigits hm rfl
  | punct p =>
    simp only [Piece.chars]
    cases p <;> first
      | exact .of_no_lt (by decide)
      | exact .lt (by decide) .nil
      | exact .lt (by decide) (.cons (by decide) .nil)
  | gap => exact .of_no_lt (by simp only [Piece.chars]; split <;> simp)
  | line depth => exact .of_no_lt (by simp only [Piece.chars]; split <;> simp [List.mem_replicate])
  | verbatim s => simp [Piece.isVerbatim] at h

/-- Without verbatim text, rendered output never contains `</`, so it is safe as the raw text
of a `<style>` element. -/
theorem render_safe (ps : List Piece) (layout : Layout) (h : ps.any Piece.isVerbatim = false) :
    ∀ s t, (render ps layout).toList ≠ s ++ ['<', '/'] ++ t := by
  simp only [render, String.toList_ofList]
  simp only [List.any_eq_false, Bool.not_eq_true] at h
  exact Guarded.no_closeTag (Guarded.flatMap fun p hp => p.guarded layout (h p hp))

end CssModel
