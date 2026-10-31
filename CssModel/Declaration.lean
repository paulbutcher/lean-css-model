/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Value

@[expose] public section

namespace CssModel

/-- The value of a known property. -/
inductive DeclValue (p : Property) where
  | checked (v : Value p)
  /-- Any balanced tokens, unchecked, such as an experimental value the data lacks. -/
  | unchecked (t : TokenSeq)
  /-- Raw text, trusted as-is. -/
  | verbatim (text : String)

inductive Declaration where
  | property (p : Property) (v : DeclValue p) (important : Bool := false)
  /-- A custom property, whose value is any balanced tokens, so is checked by construction. -/
  | custom (name : DashedIdent) (v : TokenSeq) (important : Bool := false)
  /-- A property the data lacks, such as a vendor-prefixed or experimental one. -/
  | unchecked (name : Ident) (v : TokenSeq) (important : Bool := false)
  /-- A value written as raw text, trusted as-is. -/
  | verbatim (name : Ident) (text : String) (important : Bool := false)

/-- A checked declaration of `p`, its value accepted by `p`'s grammar at compile time. -/
def decl (p : Property) (segs : List Seg) (important : Bool := false)
    (h : Admits p.syntax.toRegex Grammar.forProperty (Seg.shapeOf segs) := by
      (conv => arg 3; reduce); decide +kernel) : Declaration :=
  .property p (.checked (Value.of p segs h)) important

namespace DeclValue

def pieces {p : Property} : DeclValue p → List Piece
  | .checked v => v.pieces
  | .unchecked t => t.pieces
  | .verbatim text => [.verbatim text]

def hasUnchecked {p : Property} : DeclValue p → Bool
  | .unchecked _ => true
  | _ => false

def hasSubstitution {p : Property} : DeclValue p → Bool
  | .checked v => v.hasSubstitution
  | _ => false

end DeclValue

namespace Declaration

/-- The property's name as written, unescaped, as `style.setProperty` takes it. -/
def propertyName : Declaration → String
  | .property p .. => p.name
  | .custom name .. => name.name
  | .unchecked name .. | .verbatim name .. => name.name

def important : Declaration → Bool
  | .property _ _ i | .custom _ _ i | .unchecked _ _ i | .verbatim _ _ i => i

def valuePieces : Declaration → List Piece
  | .property _ v _ => v.pieces
  | .custom _ v _ => v.pieces
  | .unchecked _ v _ => v.pieces
  | .verbatim _ text _ => [.verbatim text]

/-- The value as CSS text, without `!important`, as `style.setProperty` takes it. -/
def valueText (d : Declaration) : String := render d.valuePieces

def pieces (d : Declaration) : List Piece :=
  .ident d.propertyName :: .punct .colon :: .gap :: d.valuePieces ++
    (if d.important then [.gap, .punct .important] else [])

def serialize (d : Declaration) (layout : Layout := .indented) : String := render d.pieces layout

def hasUnchecked : Declaration → Bool
  | .property _ v _ => v.hasUnchecked
  | .unchecked .. => true
  | _ => false

def hasVerbatim (d : Declaration) : Bool := d.pieces.any Piece.isVerbatim

def hasSubstitution : Declaration → Bool
  | .property _ v _ => v.hasSubstitution
  | _ => false

end Declaration

/-- A list of declarations, as a `style` attribute holds. -/
structure DeclarationList where
  decls : List Declaration := []

namespace DeclarationList

/-- `color: red; margin: 0`, or with `.compact`, `color:red;margin:0`. -/
def pieces (l : DeclarationList) : List Piece :=
  joinPieces [.punct .semicolon, .gap] (l.decls.map Declaration.pieces)

def serialize (l : DeclarationList) (layout : Layout := .indented) : String :=
  render l.pieces layout

def hasUnchecked (l : DeclarationList) : Bool := l.decls.any (·.hasUnchecked)

def hasVerbatim (l : DeclarationList) : Bool := l.pieces.any Piece.isVerbatim

/-- Each declaration's property name and value text, as lasm's `Attr.style` takes them, with
whether it is `!important`. -/
def properties (l : DeclarationList) : List (String × String × Bool) :=
  l.decls.map fun d => (d.propertyName, d.valueText, d.important)

theorem serialize_safe (l : DeclarationList) (layout : Layout) (h : l.hasVerbatim = false) :
    ∀ s t, (l.serialize layout).toList ≠ s ++ ['<', '/'] ++ t :=
  render_safe _ layout h

end DeclarationList

end CssModel
