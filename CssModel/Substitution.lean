/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Token

@[expose] public section

namespace CssModel

/-- The `<attr-type>` of an `attr()`: `type(<syntax>)`, `raw-string`, `number`, or a unit. -/
inductive AttrType where
  | type (s : TokenSeq)
  | rawString
  | number
  | unit (u : Ident)
  deriving Repr

/-- An arbitrary-substitution function. Whether the value it yields suits its context is known
only at computed-value time, so a value containing one is accepted for any property, as
browsers accept it. -/
inductive Substitution where
  | var (name : DashedIdent) (fallback : Option TokenSeq := none)
  /-- `env(name index*, fallback?)`. -/
  | env (name : CustomIdent CustomIdent.reserved) (indices : List Nat := []) (fallback : Option TokenSeq := none)
  | attr (name : Ident) (type : Option AttrType := none) (fallback : Option TokenSeq := none)
  deriving Repr

namespace Substitution

def fallbackPieces : Option TokenSeq → List Piece
  | none => []
  | some f => .punct .comma :: .space :: f.pieces

def pieces : Substitution → List Piece
  | .var name fallback =>
    [.ident "var", .punct .openParen, .ident name.name] ++ fallbackPieces fallback ++
      [.punct .closeParen]
  | .env name indices fallback =>
    [.ident "env", .punct .openParen, .ident name.name] ++
      indices.flatMap (fun i => [.space, .number (i : Int)]) ++ fallbackPieces fallback ++
      [.punct .closeParen]
  | .attr name type fallback =>
    let type : List Piece := match type with
      | none => []
      | some (.type s) => [.space, .ident "type", .punct .openParen] ++ s.pieces ++ [.punct .closeParen]
      | some .rawString => [.space, .ident "raw-string"]
      | some .number => [.space, .ident "number"]
      | some (.unit u) => [.space, .ident u.name]
    [.ident "attr", .punct .openParen, .ident name.name] ++ type ++ fallbackPieces fallback ++
      [.punct .closeParen]

end Substitution

end CssModel
