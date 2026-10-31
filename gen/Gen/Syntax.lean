/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/

/-! A parser for CSS's Value Definition Syntax, as the strings of `@webref/css` spell it. -/

namespace Gen

inductive Mult where
  | opt | star | plus | nonEmpty | hash
  | rep (lo hi : Nat)
  | atLeast (lo : Nat)
  | hashRep (lo hi : Nat)
  deriving Repr, BEq, Inhabited

inductive Term where
  | kw (name : String)
  /-- A literal delimiter, quoted or not: `,`, `/`, `'+'`, ... -/
  | lit (c : String)
  /-- `<name>` or `<name [lo,hi]>`. -/
  | ref (name : String) (range : Option (String × String))
  /-- `<'name'>`, a property's grammar. -/
  | prop (name : String)
  /-- `<name()>`, a function's grammar. -/
  | fnRef (name : String)
  /-- `name( args )`. -/
  | fn (name : String) (args : Term)
  /-- `( body )`, or `'[' body ']'`. -/
  | block (bracket : Bool) (body : Term)
  | seq (ts : List Term)
  | oneOf (ts : List Term)
  | allOf (ts : List Term)
  | someOf (ts : List Term)
  | mult (t : Term) (m : Mult)
  deriving Repr, BEq, Inhabited

inductive Tok where
  | ident (s : String)
  | fnOpen (s : String)
  | ref (name : String) (range : Option (String × String))
  | prop (name : String)
  | quoted (s : String)
  | openGroup | closeGroup | openParen | closeParen
  | bar | barBar | ampAmp
  | question | star | plus | hash | bang
  | braces (lo : Nat) (hi : Option Nat) (open_ : Bool)
  | lit (s : String)
  deriving Repr, BEq, Inhabited

def isNameChar (c : Char) : Bool := c.isAlphanum || c == '-' || c == '_'

/-- Splits `s` into the first run of characters satisfying `p` and the rest. -/
def spanChars (p : Char → Bool) (s : List Char) : List Char × List Char :=
  (s.takeWhile p, s.dropWhile p)

/-- The contents of `<...>`: a name, maybe with a range such as `[0,∞]`. -/
def parseRef (body : String) : Except String Tok := do
  let body := body.trimAscii.toString
  match body.splitOn "[" with
  | [name] => return .ref name.trimAscii.toString none
  | [name, range] =>
    let range := String.ofList (range.toList.filter (· != ']'))
    match range.splitOn "," with
    | [lo, hi] => return .ref name.trimAscii.toString (some (lo.trimAscii.toString, hi.trimAscii.toString))
    | _ => throw s!"unsupported range in <{body}>"
  | _ => throw s!"unsupported reference <{body}>"

def tokenize (s : String) : Except String (List Tok) :=
  go s.toList [] (s.length + 1)
where
  go : List Char → List Tok → Nat → Except String (List Tok)
    | _, _, 0 => throw "tokenizer ran out of fuel"
    | [], acc, _ => return acc.reverse
    | c :: rest, acc, fuel + 1 =>
      if c.isWhitespace then go rest acc fuel
      else if c == '<' then
        match rest with
        | '\'' :: rest' =>
          let (name, after) := spanChars (· != '\'') rest'
          match after with
          | '\'' :: '>' :: after => go after (.prop (String.ofList name) :: acc) fuel
          | _ => throw s!"unterminated property reference in {s}"
        | _ =>
          -- A reference may hold a bracketed range, but not another reference.
          let (body, after) := spanChars (· != '>') rest
          match after with
          | '>' :: after =>
            if body.contains '<' then throw s!"unsupported nested reference in {s}"
            else do
              let t ← parseRef (String.ofList body)
              go after (t :: acc) fuel
          | _ => throw s!"unterminated reference in {s}"
      else if c == '\'' then
        let (body, after) := spanChars (· != '\'') rest
        match after with
        | '\'' :: after => go after (.quoted (String.ofList body) :: acc) fuel
        | _ => throw s!"unterminated quote in {s}"
      else if c == '[' then go rest (.openGroup :: acc) fuel
      else if c == ']' then go rest (.closeGroup :: acc) fuel
      else if c == '(' then go rest (.openParen :: acc) fuel
      else if c == ')' then go rest (.closeParen :: acc) fuel
      else if c == '|' then
        match rest with
        | '|' :: rest => go rest (.barBar :: acc) fuel
        | _ => go rest (.bar :: acc) fuel
      else if c == '&' then
        match rest with
        | '&' :: rest => go rest (.ampAmp :: acc) fuel
        | _ => throw s!"lone & in {s}"
      else if c == '?' then go rest (.question :: acc) fuel
      else if c == '*' then go rest (.star :: acc) fuel
      else if c == '+' then go rest (.plus :: acc) fuel
      else if c == '#' then go rest (.hash :: acc) fuel
      else if c == '!' then go rest (.bang :: acc) fuel
      else if c == '{' then
        let (body, after) := spanChars (· != '}') rest
        match after with
        | '}' :: after =>
          match (String.ofList body).splitOn "," with
          | [n] => match n.trimAscii.toString.toNat? with
            | some n => go after (.braces n (some n) false :: acc) fuel
            | none => throw s!"bad multiplier in {s}"
          | [lo, hi] =>
            match lo.trimAscii.toString.toNat?, hi.trimAscii.toString with
            | some lo, "" => go after (.braces lo none true :: acc) fuel
            | some lo, hi => match hi.toNat? with
              | some hi => go after (.braces lo (some hi) false :: acc) fuel
              | none => throw s!"bad multiplier in {s}"
            | none, _ => throw s!"bad multiplier in {s}"
          | _ => throw s!"bad multiplier in {s}"
        | _ => throw s!"unterminated multiplier in {s}"
      else if c == ',' || c == '/' || c == ':' || c == ';' || c == '=' then
        go rest (.lit (String.singleton c) :: acc) fuel
      else if isNameChar c then
        let (name, after) := spanChars isNameChar (c :: rest)
        match after with
        | '(' :: after => go after (.fnOpen (String.ofList name) :: acc) fuel
        | _ => go after (.ident (String.ofList name) :: acc) fuel
      else throw s!"unexpected character {c} in {s}"

abbrev Parser := StateT (List Tok) (Except String)

def peek : Parser (Option Tok) := do return (← get).head?

def advance : Parser Unit := modify List.tail

def expect (t : Tok) : Parser Unit := do
  match ← peek with
  | some t' => if t' == t then advance else throw s!"expected {repr t}, found {repr t'}"
  | none => throw s!"expected {repr t}, found the end"

def isTermStart : Tok → Bool
  | .ident _ | .fnOpen _ | .ref .. | .prop _ | .quoted _ | .openGroup | .openParen | .lit _ => true
  | _ => false

def flat (mk : List Term → Term) : List Term → Term
  | [t] => t
  | ts => mk ts

def litOf (s : String) : Term := .lit s

mutual
/-- Parses alternatives, `fuel` bounding the nesting depth. -/
def parseAlt : Nat → Parser Term
  | 0 => throw "parser ran out of fuel"
  | fuel + 1 => do
    let first ← parseSomeOf fuel
    let rec more : Nat → List Term → Parser (List Term)
      | 0, acc => return acc.reverse
      | n + 1, acc => do
        if (← peek) == some .bar then
          advance
          more n ((← parseSomeOf fuel) :: acc)
        else return acc.reverse
    return flat .oneOf (← more 1000 [first])

def parseSomeOf : Nat → Parser Term
  | 0 => throw "parser ran out of fuel"
  | fuel + 1 => do
    let first ← parseAllOf fuel
    let rec more : Nat → List Term → Parser (List Term)
      | 0, acc => return acc.reverse
      | n + 1, acc => do
        if (← peek) == some .barBar then
          advance
          more n ((← parseAllOf fuel) :: acc)
        else return acc.reverse
    return flat .someOf (← more 1000 [first])

def parseAllOf : Nat → Parser Term
  | 0 => throw "parser ran out of fuel"
  | fuel + 1 => do
    let first ← parseSeq fuel
    let rec more : Nat → List Term → Parser (List Term)
      | 0, acc => return acc.reverse
      | n + 1, acc => do
        if (← peek) == some .ampAmp then
          advance
          more n ((← parseSeq fuel) :: acc)
        else return acc.reverse
    return flat .allOf (← more 1000 [first])

/-- Juxtaposed terms; empty where a group or function has no arguments. -/
def parseSeq : Nat → Parser Term
  | 0 => throw "parser ran out of fuel"
  | fuel + 1 => do
    let rec more : Nat → List Term → Parser (List Term)
      | 0, acc => return acc.reverse
      | n + 1, acc => do
        match ← peek with
        | some t =>
          -- A quoted `]` closes a bracket block rather than starting a term.
          if t == .quoted "]" then return acc.reverse
          else if isTermStart t then more n ((← parsePostfix fuel) :: acc)
          else return acc.reverse
        | none => return acc.reverse
    return flat .seq (← more 1000 [])

def parsePostfix : Nat → Parser Term
  | 0 => throw "parser ran out of fuel"
  | fuel + 1 => do
    let base ← parsePrimary fuel
    let rec more : Nat → Term → Parser Term
      | 0, t => return t
      | n + 1, t => do
        match ← peek with
        | some .question => advance; more n (.mult t .opt)
        | some .star => advance; more n (.mult t .star)
        | some .plus => advance; more n (.mult t .plus)
        | some .bang => advance; more n (.mult t .nonEmpty)
        | some .hash =>
          advance
          match ← peek with
          | some (.braces lo (some hi) false) => advance; more n (.mult t (.hashRep lo hi))
          | some (.braces _ none true) => throw "unsupported multiplier #{A,}"
          | _ => more n (.mult t .hash)
        | some (.braces lo (some hi) false) => advance; more n (.mult t (.rep lo hi))
        | some (.braces lo none true) => advance; more n (.mult t (.atLeast lo))
        | _ => return t
    more 10 base

def parsePrimary : Nat → Parser Term
  | 0 => throw "parser ran out of fuel"
  | fuel + 1 => do
    match ← peek with
    | some .openGroup =>
      advance
      let t ← parseAlt fuel
      expect .closeGroup
      return t
    | some (.fnOpen name) =>
      advance
      let t ← parseAlt fuel
      expect .closeParen
      return .fn name t
    | some .openParen =>
      advance
      let t ← parseAlt fuel
      expect .closeParen
      return .block false t
    | some (.quoted "[") =>
      advance
      let t ← parseAlt fuel
      expect (.quoted "]")
      return .block true t
    | some (.quoted s) => advance; return .lit s
    | some (.lit s) => advance; return .lit s
    | some (.ident s) => advance; return .kw s
    | some (.ref name range) =>
      advance
      if name.endsWith "()" then return .fnRef (String.ofList (name.toList.dropLast.dropLast))
      else return .ref name range
    | some (.prop name) => advance; return .prop name
    | some t => throw s!"unexpected {repr t}"
    | none => throw "unexpected end"
end

def parse (s : String) : Except String Term := do
  let toks ← tokenize s
  let (t, rest) ← (parseAlt 200).run toks
  if rest.isEmpty then return t else throw s!"trailing tokens {repr rest} in {s}"

end Gen
