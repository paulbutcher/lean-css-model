/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Token
public import CssModel.Generated.Selectors

@[expose] public section

/-! Selectors Level 4. The types carry two flags: whether `:has()` may appear, which it may not
within its own argument, and whether pseudo-elements may, which they may not within `:is()`,
`:where()`, `:not()`, `:has()` or an `of S` clause. A pseudo-element ends its compound selector
by construction, followed only by the pseudo-classes and pseudo-elements it admits. -/

namespace CssModel

/-- A namespace prefix: `ns|`, `*|`, or `|` for no namespace. -/
inductive NsPrefix where
  | named (ns : Ident)
  | any
  | none
  deriving Repr

def NsPrefix.pieces : Option NsPrefix → List Piece
  | .none => []
  | .some (.named ns) => [.ident ns.name, .punct .bar]
  | .some .any => [.punct .star, .punct .bar]
  | .some .none => [.punct .bar]

/-- A name with an optional namespace prefix, as a type or attribute selector holds. Checking it
against an element vocabulary is left to a consumer. -/
structure WqName where
  ns : Option NsPrefix := .none
  name : Ident
  deriving Repr

def WqName.pieces (n : WqName) : List Piece := NsPrefix.pieces n.ns ++ [.ident n.name.name]

inductive TypeSelector where
  | name (n : WqName)
  | universal (ns : Option NsPrefix := .none)
  deriving Repr

def TypeSelector.pieces : TypeSelector → List Piece
  | .name n => n.pieces
  | .universal ns => NsPrefix.pieces ns ++ [.punct .star]

inductive AttrMatcher where
  /-- `=` -/
  | exact
  /-- `~=` -/
  | includes
  /-- `|=` -/
  | dashMatch
  /-- `^=` -/
  | prefix
  /-- `$=` -/
  | suffix
  /-- `*=` -/
  | substring
  deriving DecidableEq, Repr

def AttrMatcher.pieces : AttrMatcher → List Piece
  | .exact => [.punct .eq]
  | .includes => [.punct .tilde, .punct .eq]
  | .dashMatch => [.punct .bar, .punct .eq]
  | .prefix => [.punct .caret, .punct .eq]
  | .suffix => [.punct .dollar, .punct .eq]
  | .substring => [.punct .star, .punct .eq]

/-- An attribute selector's case flag: `i` to match ASCII case-insensitively, `s` sensitively. -/
inductive CaseFlag where
  | i | s
  deriving DecidableEq, Repr

/-- `An+B`. -/
structure AnB where
  a : Int
  b : Int
  deriving DecidableEq, Repr

def AnB.odd : AnB := ⟨2, 1⟩

def AnB.even : AnB := ⟨2, 0⟩

/-- CSSOM's serialization of `<an+b>`, which runs `2n` and `+1` together into one token pair. -/
def AnB.pieces (x : AnB) : List Piece :=
  if x.a = 0 then [.number (x.b : Decimal)]
  else
    let aPart : List Piece :=
      if x.a = 1 then [.ident "n"] else if x.a = -1 then [.ident "-n"]
      else [.number (x.a : Decimal), .ident "n"]
    let bPart : List Piece :=
      if x.b > 0 then [.punct .plus, .number (x.b : Decimal)]
      else if x.b < 0 then [.number (x.b : Decimal)] else []
    aPart ++ bPart

inductive Combinator where
  /-- Whitespace. -/
  | descendant
  /-- `>` -/
  | child
  /-- `+` -/
  | nextSibling
  /-- `~` -/
  | subsequentSibling
  /-- `||` -/
  | column
  deriving DecidableEq, Repr

def Combinator.pieces : Combinator → List Piece
  | .descendant => [.space]
  | .child => [.gap, .punct .gt, .gap]
  | .nextSibling => [.gap, .punct .plus, .gap]
  | .subsequentSibling => [.gap, .punct .tilde, .gap]
  | .column => [.gap, .punct .bar, .punct .bar, .gap]

/-- Which of the `:nth-` pseudo-classes. Only `child` and `lastChild` take `of S`. -/
inductive Nth where
  | child | lastChild | ofType | lastOfType | col | lastCol
  deriving DecidableEq, Repr

def Nth.name : Nth → String
  | .child => "nth-child" | .lastChild => "nth-last-child" | .ofType => "nth-of-type"
  | .lastOfType => "nth-last-of-type" | .col => "nth-col" | .lastCol => "nth-last-col"

/-- The user action pseudo-classes, which any pseudo-element admits after it. -/
def PseudoClass.afterElement (p : PseudoClass) : Bool :=
  p.name ∈ ["hover", "active", "focus", "focus-visible", "focus-within"]

/-- The pseudo-classes that match by an element's place in the tree, which `::part()` never
matches. -/
def PseudoClass.structural (p : PseudoClass) : Bool :=
  p.name ∈ ["root", "empty", "first-child", "last-child", "only-child", "first-of-type",
    "last-of-type", "only-of-type", "scope", "host", "has-slotted"]

/-- What a pseudo-element is, for what may follow it. -/
inductive ElementKind where
  | before | after | marker | part | slotted | other
  deriving DecidableEq, Repr

def ElementKind.ofSimple (p : PseudoElement) : ElementKind :=
  if p.name == "before" then .before
  else if p.name == "after" then .after
  else if p.name == "marker" then .marker
  else .other

/-- Whether a pseudo-element of kind `k` admits the pseudo-classes `classes` and `:state()`s
`states` after it: `::part()` any that match by the element alone, by CSS Shadow Parts, and the
rest only the user action pseudo-classes. -/
def ElementKind.admits (k : ElementKind) (classes : List PseudoClass) (states : List Ident) : Bool :=
  if k == .part then classes.all (!·.structural)
  else classes.all PseudoClass.afterElement && states.isEmpty

/-- Whether a pseudo-element of kind `k` may follow `prev`, or start the tail if there is none:
`::marker` after `::before` or `::after`, by CSS Pseudo-Elements; any but `::part()` after
`::part()`, by CSS Shadow Parts; and `::before`, `::after` or `::marker` after `::slotted()`, by
CSS Scoping. -/
def ElementKind.follows : Option ElementKind → ElementKind → Bool
  | none, _ => true
  | some .before, .marker | some .after, .marker => true
  | some .part, k => k != .part
  | some .slotted, k => k == .before || k == .after || k == .marker
  | _, _ => false

inductive ViewTransitionPart where
  | group | imagePair | old | new | groupChildren
  deriving DecidableEq, Repr

def ViewTransitionPart.name : ViewTransitionPart → String
  | .group => "view-transition-group" | .imagePair => "view-transition-image-pair"
  | .old => "view-transition-old" | .new => "view-transition-new"
  | .groupChildren => "view-transition-group-children"

mutual
/-- A simple selector other than a type selector. `has` says whether `:has()` may appear. -/
inductive Subclass : Bool → Type where
  | id {has : Bool} (name : Ident) : Subclass has
  | cls {has : Bool} (name : Ident) : Subclass has
  | attr {has : Bool} (name : WqName) : Subclass has
  | attrMatch {has : Bool} (name : WqName) (m : AttrMatcher) (value : String)
      (flag : Option CaseFlag := none) : Subclass has
  /-- The nesting selector `&`. -/
  | nesting {has : Bool} : Subclass has
  | pseudo {has : Bool} (p : PseudoClass) : Subclass has
  | is {has : Bool} (l : ComplexList has false) : Subclass has
  | «where» {has : Bool} (l : ComplexList has false) : Subclass has
  | not {has : Bool} (l : ComplexList has false) : Subclass has
  | has (l : RelativeList false false) : Subclass true
  | nth {has : Bool} (n : Nth) (anb : AnB) : Subclass has
  /-- `:nth-child(An+B of S)` or `:nth-last-child(An+B of S)`. -/
  | nthOf {has : Bool} (last : Bool) (anb : AnB) (of : ComplexList has false) : Subclass has
  /-- `:lang()`, each range as a string. -/
  | lang {has : Bool} (range : String) (more : List String := []) : Subclass has
  | dir {has : Bool} (rtl : Bool) : Subclass has
  | host {has : Bool} (c : OptCompound has) : Subclass has
  | hostContext {has : Bool} (c : Compound has false) : Subclass has
  | state {has : Bool} (name : Ident) : Subclass has
  | heading {has : Bool} (level : Nat) (more : List Nat := []) : Subclass has
  /-- A functional pseudo-class whose argument is not modelled, so is unchecked. -/
  | functional {has : Bool} (f : PseudoClassFunction) (args : TokenSeq) : Subclass has

inductive Subclasses : Bool → Type where
  | nil {has : Bool} : Subclasses has
  | cons {has : Bool} (s : Subclass has) (rest : Subclasses has) : Subclasses has

/-- A pseudo-element, indexed by its kind. -/
inductive PseudoElementSelector : Bool → ElementKind → Type where
  | simple {has : Bool} (p : PseudoElement) : PseudoElementSelector has (.ofSimple p)
  | slotted {has : Bool} (c : Compound has false) : PseudoElementSelector has .slotted
  | part {has : Bool} (name : Ident) (more : List Ident := []) : PseudoElementSelector has .part
  | highlight {has : Bool} (name : CustomIdent) : PseudoElementSelector has .other
  /-- A view transition pseudo-element, of a named group or of every group. -/
  | viewTransition {has : Bool} (part : ViewTransitionPart) (name : Option CustomIdent) :
      PseudoElementSelector has .other
  /-- A functional pseudo-element whose argument is not modelled, so is unchecked. -/
  | functional {has : Bool} (f : PseudoElementFunction) (args : TokenSeq) :
      PseudoElementSelector has .other

/-- The pseudo-elements that end a compound selector, each with the pseudo-classes after it,
indexed by the kind of the one before, if any. Only where pseudo-elements are allowed can there
be any. -/
inductive PseudoTail : Bool → Bool → Option ElementKind → Type where
  | nil {has pe : Bool} {prev : Option ElementKind} : PseudoTail has pe prev
  | cons {has : Bool} {prev : Option ElementKind} {k : ElementKind}
      (e : PseudoElementSelector has k) (classes : List PseudoClass) (states : List Ident)
      (ok : k.admits classes states = true) (follows : ElementKind.follows prev k = true)
      (rest : PseudoTail has true (some k)) : PseudoTail has true prev

/-- A compound selector: an optional type selector, then subclass selectors, then
pseudo-elements. -/
inductive Compound : Bool → Bool → Type where
  | mk {has pe : Bool} (type : Option TypeSelector) (subclasses : Subclasses has)
      (tail : PseudoTail has pe none) : Compound has pe

inductive OptCompound : Bool → Type where
  | none {has : Bool} : OptCompound has
  | some {has : Bool} (c : Compound has false) : OptCompound has

/-- Compounds joined by combinators; only the last may hold pseudo-elements. -/
inductive Complex : Bool → Bool → Type where
  | last {has pe : Bool} (c : Compound has pe) : Complex has pe
  | cons {has pe : Bool} (c : Compound has false) (comb : Combinator) (rest : Complex has pe) :
      Complex has pe

inductive ComplexList : Bool → Bool → Type where
  | one {has pe : Bool} (c : Complex has pe) : ComplexList has pe
  | cons {has pe : Bool} (c : Complex has pe) (rest : ComplexList has pe) : ComplexList has pe

/-- A complex selector with an optional leading combinator, as `:has()` and nested style rules
take. -/
inductive Relative : Bool → Bool → Type where
  | mk {has pe : Bool} (comb : Option Combinator) (c : Complex has pe) : Relative has pe

inductive RelativeList : Bool → Bool → Type where
  | one {has pe : Bool} (r : Relative has pe) : RelativeList has pe
  | cons {has pe : Bool} (r : Relative has pe) (rest : RelativeList has pe) : RelativeList has pe
end

/-- A selector list as a style rule takes. -/
abbrev SelectorList := ComplexList true true

/-- A relative selector list as a nested style rule takes. -/
abbrev RelativeSelectorList := RelativeList true true

/-! ## Building selectors -/

def Subclasses.ofList {has : Bool} : List (Subclass has) → Subclasses has
  | [] => .nil
  | s :: ss => .cons s (ofList ss)

/-- A compound selector without pseudo-elements. -/
def Compound.of {has pe : Bool} (type : Option TypeSelector := none) (subclasses : List (Subclass has) := []) :
    Compound has pe :=
  .mk type (Subclasses.ofList subclasses) .nil

/-- A compound selector ending in a pseudo-element. -/
def Compound.withElement {has : Bool} {k : ElementKind} (type : Option TypeSelector)
    (subclasses : List (Subclass has)) (e : PseudoElementSelector has k)
    (classes : List PseudoClass := []) (states : List Ident := [])
    (ok : k.admits classes states = true := by decide) : Compound has true :=
  .mk type (Subclasses.ofList subclasses) (.cons e classes states ok rfl .nil)

/-- A type selector without a namespace. -/
def TypeSelector.tag (name : String) (h : name.isEmpty = false := by decide +kernel) : TypeSelector :=
  .name { name := ⟨name, h⟩ }

def Complex.ofList {has pe : Bool} (init : List (Compound has false × Combinator)) (last : Compound has pe) :
    Complex has pe :=
  init.foldr (fun (c, comb) rest => .cons c comb rest) (.last last)

def ComplexList.ofList {has pe : Bool} (first : Complex has pe) : List (Complex has pe) → ComplexList has pe
  | [] => .one first
  | c :: cs => .cons first (ofList c cs)

def RelativeList.ofList {has pe : Bool} (first : Relative has pe) :
    List (Relative has pe) → RelativeList has pe
  | [] => .one first
  | r :: rs => .cons first (ofList r rs)

/-! ## Serialization -/

def listPieces {α : Type} (f : α → List Piece) (xs : List α) : List Piece :=
  joinPieces [.punct .comma, .gap] (xs.map f)

def pseudoFn (colons : List Piece) (name : String) (args : List Piece) : List Piece :=
  colons ++ .ident name :: .punct .openParen :: args ++ [.punct .closeParen]

mutual
def Subclass.pieces {has : Bool} : Subclass has → List Piece
  | .id n => [.punct .hash, .ident n.name]
  | .cls n => [.punct .dot, .ident n.name]
  | .attr n => .punct .openBracket :: n.pieces ++ [.punct .closeBracket]
  | .attrMatch n m v flag =>
    .punct .openBracket :: n.pieces ++ m.pieces ++ [.string v] ++
      (match flag with
        | none => []
        | some .i => [.space, .ident "i"]
        | some .s => [.space, .ident "s"]) ++ [.punct .closeBracket]
  | .nesting => [.punct .amp]
  | .pseudo p => [.punct .colon, .ident p.name]
  | .is l => pseudoFn [.punct .colon] "is" (ComplexList.pieces l)
  | .where l => pseudoFn [.punct .colon] "where" (ComplexList.pieces l)
  | .not l => pseudoFn [.punct .colon] "not" (ComplexList.pieces l)
  | .has l => pseudoFn [.punct .colon] "has" (RelativeList.pieces l)
  | .nth n anb => pseudoFn [.punct .colon] n.name anb.pieces
  | .nthOf last anb of =>
    pseudoFn [.punct .colon] (if last then "nth-last-child" else "nth-child")
      (anb.pieces ++ .space :: .ident "of" :: .space :: ComplexList.pieces of)
  | .lang r more => pseudoFn [.punct .colon] "lang" (listPieces (fun s => [.string s]) (r :: more))
  | .dir rtl => pseudoFn [.punct .colon] "dir" [.ident (if rtl then "rtl" else "ltr")]
  | .host c => match c with
    | .none => [.punct .colon, .ident "host"]
    | .some c => pseudoFn [.punct .colon] "host" (Compound.pieces c)
  | .hostContext c => pseudoFn [.punct .colon] "host-context" (Compound.pieces c)
  | .state n => pseudoFn [.punct .colon] "state" [.ident n.name]
  | .heading l more =>
    pseudoFn [.punct .colon] "heading" (listPieces (fun (n : Nat) => [.number ((n : Int) : Decimal)]) (l :: more))
  | .functional f args => pseudoFn [.punct .colon] f.name args.pieces

def Subclasses.pieces {has : Bool} : Subclasses has → List Piece
  | .nil => []
  | .cons s rest => Subclass.pieces s ++ Subclasses.pieces rest

def PseudoElementSelector.pieces {has : Bool} {k : ElementKind} : PseudoElementSelector has k →
    List Piece
  | .simple p => [.punct .colon, .punct .colon, .ident p.name]
  | .slotted c => pseudoFn [.punct .colon, .punct .colon] "slotted" (Compound.pieces c)
  | .part n more => pseudoFn [.punct .colon, .punct .colon] "part"
      (joinPieces [.space] ((n :: more).map fun i => [.ident i.name]))
  | .highlight n => pseudoFn [.punct .colon, .punct .colon] "highlight" [.ident n.name]
  | .viewTransition part name =>
    pseudoFn [.punct .colon, .punct .colon] part.name (match name with
      | some n => [.ident n.name]
      | none => [.punct .star])
  | .functional f args => pseudoFn [.punct .colon, .punct .colon] f.name args.pieces

def PseudoTail.pieces {has pe : Bool} {prev : Option ElementKind} : PseudoTail has pe prev →
    List Piece
  | .nil => []
  | .cons e classes states _ _ rest =>
    PseudoElementSelector.pieces e ++ classes.flatMap (fun p => [.punct .colon, .ident p.name]) ++
      states.flatMap (fun n => pseudoFn [.punct .colon] "state" [.ident n.name]) ++
      PseudoTail.pieces rest

def Compound.pieces {has pe : Bool} : Compound has pe → List Piece
  | .mk type subclasses tail =>
    let typePieces := match type, subclasses, tail with
      | some t, _, _ => t.pieces
      -- An empty compound selector is written as the universal selector.
      | none, .nil, .nil => [.punct .star]
      | none, _, _ => []
    typePieces ++ Subclasses.pieces subclasses ++ PseudoTail.pieces tail

def Complex.pieces {has pe : Bool} : Complex has pe → List Piece
  | .last c => Compound.pieces c
  | .cons c comb rest => Compound.pieces c ++ comb.pieces ++ Complex.pieces rest

def ComplexList.pieces {has pe : Bool} : ComplexList has pe → List Piece
  | .one c => Complex.pieces c
  | .cons c rest => Complex.pieces c ++ .punct .comma :: .gap :: ComplexList.pieces rest

def Relative.pieces {has pe : Bool} : Relative has pe → List Piece
  | .mk none c => Complex.pieces c
  | .mk (some comb) c =>
    (match comb with
      | .descendant => []
      | _ => (comb.pieces.drop 1)) ++ Complex.pieces c

def RelativeList.pieces {has pe : Bool} : RelativeList has pe → List Piece
  | .one r => Relative.pieces r
  | .cons r rest => Relative.pieces r ++ .punct .comma :: .gap :: RelativeList.pieces rest
end

mutual
def Subclass.hasUnchecked {has : Bool} : Subclass has → Bool
  | .functional .. => true
  | .is l | .where l | .not l | .nthOf _ _ l => ComplexList.hasUnchecked l
  | .has l => RelativeList.hasUnchecked l
  | .host (.some c) | .hostContext c => Compound.hasUnchecked c
  | _ => false

def Subclasses.hasUnchecked {has : Bool} : Subclasses has → Bool
  | .nil => false
  | .cons s rest => Subclass.hasUnchecked s || Subclasses.hasUnchecked rest

def PseudoElementSelector.hasUnchecked {has : Bool} {k : ElementKind} :
    PseudoElementSelector has k → Bool
  | .functional .. => true
  | .slotted c => Compound.hasUnchecked c
  | _ => false

def PseudoTail.hasUnchecked {has pe : Bool} {prev : Option ElementKind} :
    PseudoTail has pe prev → Bool
  | .nil => false
  | .cons e _ _ _ _ rest => PseudoElementSelector.hasUnchecked e || PseudoTail.hasUnchecked rest

def Compound.hasUnchecked {has pe : Bool} : Compound has pe → Bool
  | .mk _ subclasses tail => Subclasses.hasUnchecked subclasses || PseudoTail.hasUnchecked tail

def Complex.hasUnchecked {has pe : Bool} : Complex has pe → Bool
  | .last c => Compound.hasUnchecked c
  | .cons c _ rest => Compound.hasUnchecked c || Complex.hasUnchecked rest

def ComplexList.hasUnchecked {has pe : Bool} : ComplexList has pe → Bool
  | .one c => Complex.hasUnchecked c
  | .cons c rest => Complex.hasUnchecked c || ComplexList.hasUnchecked rest

def Relative.hasUnchecked {has pe : Bool} : Relative has pe → Bool
  | .mk _ c => Complex.hasUnchecked c

def RelativeList.hasUnchecked {has pe : Bool} : RelativeList has pe → Bool
  | .one r => Relative.hasUnchecked r
  | .cons r rest => Relative.hasUnchecked r || RelativeList.hasUnchecked rest
end

end CssModel
