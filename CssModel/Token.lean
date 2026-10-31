/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Ident

@[expose] public section

namespace CssModel

/-- The delimiters a token sequence may hold: the characters that, followed by a space, tokenize
as a `<delim-token>` on their own. -/
inductive Delim where
  | plus | minus | dot | star | slash | lt | gt | eq | bang | question | amp | bar | tilde | caret
  | dollar | percent | hash | at
  deriving DecidableEq, Repr

def Delim.punct : Delim → Punct
  | .plus => .plus | .minus => .minus | .dot => .dot | .star => .star | .slash => .slash
  | .lt => .lt | .gt => .gt | .eq => .eq | .bang => .bang | .question => .question | .amp => .amp
  | .bar => .bar | .tilde => .tilde | .caret => .caret | .dollar => .dollar
  | .percent => .percent | .hash => .hash | .at => .at

/-- A token of CSS Syntax Level 3, with blocks and functions holding their contents, so that a
sequence of them is balanced by construction. Bad strings, bad URLs and comments have no
representation. -/
inductive Token where
  | ident (i : Ident)
  | function (name : Ident) (args : List Token)
  | atKeyword (name : Ident)
  | hash (name : Ident)
  | string (s : String)
  | url (s : String)
  | delim (d : Delim)
  | number (d : Decimal)
  | percentage (d : Decimal)
  | dimension (d : Decimal) (unit : Ident)
  | colon
  | semicolon
  | comma
  | parens (ts : List Token)
  | brackets (ts : List Token)
  | braces (ts : List Token)
  deriving Repr

namespace Token

/-- Tokens are separated by a space when serialized, so no two can run together into one, and
none of them can begin a comment. -/
def pieces : Token → List Piece
  | .ident i => i.pieces
  | .function name args => .ident name.name :: .punct .openParen :: listPieces args ++ [.punct .closeParen]
  | .atKeyword name => [.punct .at, .ident name.name]
  | .hash name => [.punct .hash, .name name.name]
  | .string s => [.string s]
  | .url s => [.punct .url, .string s, .punct .closeParen]
  | .delim d => [.punct d.punct]
  | .number d => [.number d]
  | .percentage d => [.number d, .punct .percent]
  | .dimension d unit => [.number d, .unit unit.name]
  | .colon => [.punct .colon]
  | .semicolon => [.punct .semicolon]
  | .comma => [.punct .comma]
  | .parens ts => .punct .openParen :: listPieces ts ++ [.punct .closeParen]
  | .brackets ts => .punct .openBracket :: listPieces ts ++ [.punct .closeBracket]
  | .braces ts => .punct .openBrace :: listPieces ts ++ [.punct .closeBrace]
where
  listPieces : List Token → List Piece
    | [] => []
    | [t] => pieces t
    | t :: ts => pieces t ++ .space :: listPieces ts

/-- Whether `t` may stand at the top level of a `<declaration-value>`, which excludes `;` and
`!`. -/
def topLevelOk : Token → Bool
  | .semicolon | .delim .bang => false
  | _ => true

end Token

/-- A `<declaration-value>`, or an empty one: any balanced sequence of tokens without a top-level
`;` or `!`. -/
structure TokenSeq where
  tokens : List Token
  valid : tokens.all Token.topLevelOk = true := by decide +kernel
  deriving Repr

def TokenSeq.pieces (s : TokenSeq) : List Piece := Token.pieces.listPieces s.tokens

end CssModel
