/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Query

@[expose] public section

/-! Rules, at-rules and stylesheets. -/

namespace CssModel

/-! ## Descriptors -/

/-- The descriptors of one at-rule. -/
class DescriptorTable (D : Type) where
  name : D → String
  grammar : D → Vds

instance : DescriptorTable FontFaceDescriptor := ⟨FontFaceDescriptor.name, FontFaceDescriptor.syntax⟩
instance : DescriptorTable CounterStyleDescriptor := ⟨CounterStyleDescriptor.name, CounterStyleDescriptor.syntax⟩
instance : DescriptorTable PropertyDescriptor := ⟨PropertyDescriptor.name, PropertyDescriptor.syntax⟩
instance : DescriptorTable PageDescriptor := ⟨PageDescriptor.name, PageDescriptor.syntax⟩
instance : DescriptorTable FontPaletteValuesDescriptor :=
  ⟨FontPaletteValuesDescriptor.name, FontPaletteValuesDescriptor.syntax⟩
instance : DescriptorTable ColorProfileDescriptor := ⟨ColorProfileDescriptor.name, ColorProfileDescriptor.syntax⟩
instance : DescriptorTable ViewTransitionDescriptor :=
  ⟨ViewTransitionDescriptor.name, ViewTransitionDescriptor.syntax⟩
instance : DescriptorTable FontFeatureValuesDescriptor :=
  ⟨FontFeatureValuesDescriptor.name, FontFeatureValuesDescriptor.syntax⟩
instance : DescriptorTable FunctionDescriptor := ⟨FunctionDescriptor.name, FunctionDescriptor.syntax⟩

/-- A descriptor declaration in an at-rule whose descriptors are `D`. -/
inductive Descriptor (D : Type) [DescriptorTable D] where
  | checked (d : D) (v : GrammarValue (DescriptorTable.grammar d).toRegex)
  /-- A descriptor the data lacks, with any balanced tokens as its value. -/
  | unchecked (name : Ident) (v : TokenSeq)
  /-- A value written as raw text, trusted as-is. -/
  | verbatim (name : Ident) (text : String)

/-- A checked descriptor, its value accepted by its grammar at compile time. -/
def desc {D : Type} [DescriptorTable D] (d : D) (segs : List Seg)
    (h : Admits (DescriptorTable.grammar d).toRegex id (Seg.shapeOf segs) := by
      (conv => arg 3; reduce); decide +kernel) : Descriptor D :=
  .checked d (GrammarValue.of segs h)

namespace Descriptor

def pieces {D : Type} [DescriptorTable D] : Descriptor D → List Piece
  | .checked d v => .ident (DescriptorTable.name d) :: .punct .colon :: .gap :: v.pieces
  | .unchecked n v => .ident n.name :: .punct .colon :: .gap :: v.pieces
  | .verbatim n text => [.ident n.name, .punct .colon, .gap, .verbatim text]

def hasUnchecked {D : Type} [DescriptorTable D] : Descriptor D → Bool
  | .unchecked .. => true
  | _ => false

end Descriptor

/-! ## Preludes -/

/-- A cascade layer's name: identifiers joined by `.`. -/
structure LayerName where
  first : CustomIdent Exclusion.atLayer
  rest : List (CustomIdent Exclusion.atLayer) := []
  deriving Repr

def LayerName.pieces (n : LayerName) : List Piece :=
  joinPieces [.punct .dot] ((n.first :: n.rest).map fun i => [.ident i.name])

/-- `@scope`'s bounds: `(start)`, `to (end)`, or both. -/
structure ScopeBounds where
  start : Option SelectorList := none
  stop : Option SelectorList := none

def ScopeBounds.pieces (b : ScopeBounds) : List Piece :=
  let start : List Piece := match b.start with
    | some s => .punct .openParen :: s.pieces ++ [.punct .closeParen]
    | none => []
  let stop : List Piece := match b.stop with
    | some s => [.ident "to", .space, .punct .openParen] ++ s.pieces ++ [.punct .closeParen]
    | none => []
  joinPieces [.space] ([start, stop].filter (!·.isEmpty))

def ScopeBounds.hasUnchecked (b : ScopeBounds) : Bool :=
  b.start.any (·.hasUnchecked) || b.stop.any (·.hasUnchecked)

/-- A selector in `@keyframes`: `from`, `to`, or a percentage. -/
inductive KeyframeSelector where
  | «from»
  | to
  | percent (p : Decimal) (h : (decide (0 ≤ p) && decide (p ≤ 100)) = true := by decide)

def KeyframeSelector.pieces : KeyframeSelector → List Piece
  | .from => [.ident "from"]
  | .to => [.ident "to"]
  | .percent p _ => [.number p, .punct .percent]

inductive KeyframesName where
  | ident (n : CustomIdent Exclusion.atKeyframes)
  | string (s : String)

def KeyframesName.pieces : KeyframesName → List Piece
  | .ident n => [.ident n.name]
  | .string s => [.string s]

/-- A keyframe: its selectors and declarations, which may not be `!important`. -/
structure Keyframe where
  selector : KeyframeSelector
  more : List KeyframeSelector := []
  decls : List Declaration
  notImportant : decls.all (!·.important) = true := by decide

inductive PagePseudo where
  | left | right | first | blank
  deriving DecidableEq, Repr

def PagePseudo.name : PagePseudo → String
  | .left => "left" | .right => "right" | .first => "first" | .blank => "blank"

/-- A page selector: a page type, pseudo-pages, or both. -/
structure PageSelector where
  type : Option Ident := none
  pseudos : List PagePseudo := []
  nonempty : (type.isSome || !pseudos.isEmpty) = true := by decide

def PageSelector.pieces (s : PageSelector) : List Piece :=
  (match s.type with
    | some t => [.ident t.name]
    | none => []) ++ s.pseudos.flatMap fun p => [.punct .colon, .ident p.name]

inductive MarginBox where
  | topLeftCorner | topLeft | topCenter | topRight | topRightCorner
  | bottomLeftCorner | bottomLeft | bottomCenter | bottomRight | bottomRightCorner
  | leftTop | leftMiddle | leftBottom | rightTop | rightMiddle | rightBottom
  deriving DecidableEq, Repr

def MarginBox.name : MarginBox → String
  | .topLeftCorner => "top-left-corner" | .topLeft => "top-left" | .topCenter => "top-center"
  | .topRight => "top-right" | .topRightCorner => "top-right-corner"
  | .bottomLeftCorner => "bottom-left-corner" | .bottomLeft => "bottom-left"
  | .bottomCenter => "bottom-center" | .bottomRight => "bottom-right"
  | .bottomRightCorner => "bottom-right-corner" | .leftTop => "left-top"
  | .leftMiddle => "left-middle" | .leftBottom => "left-bottom" | .rightTop => "right-top"
  | .rightMiddle => "right-middle" | .rightBottom => "right-bottom"

inductive PageItem where
  | decl (d : Declaration)
  | descriptor (d : Descriptor PageDescriptor)
  | margin (box : MarginBox) (decls : List Declaration)

/-- The feature value blocks of `@font-feature-values`. -/
inductive FeatureValueType where
  | stylistic | historicalForms | styleset | characterVariant | swash | ornaments | annotation
  deriving DecidableEq, Repr

def FeatureValueType.name : FeatureValueType → String
  | .stylistic => "stylistic" | .historicalForms => "historical-forms" | .styleset => "styleset"
  | .characterVariant => "character-variant" | .swash => "swash" | .ornaments => "ornaments"
  | .annotation => "annotation"

/-- A name for one or more feature indices, as `@styleset { fancy: 2 4; }` gives. -/
structure FontFeatureValue where
  name : CustomIdent CustomIdent.reserved
  index : Nat
  more : List Nat := []

inductive FeatureValuesItem where
  | block (type : FeatureValueType) (values : List FontFeatureValue)
  | descriptor (d : Descriptor FontFeatureValuesDescriptor)

inductive FamilyName where
  | string (s : String)
  /-- An unquoted family name: one or more identifiers. -/
  | idents (first : CustomIdent Exclusion.atFontFeatureValues)
      (rest : List (CustomIdent Exclusion.atFontFeatureValues) := [])

def FamilyName.pieces : FamilyName → List Piece
  | .string s => [.string s]
  | .idents f rest => joinPieces [.space] ((f :: rest).map fun i => [.ident i.name])

inductive ColorProfileName where
  | dashed (n : DashedIdent)
  | deviceCmyk

/-- `@custom-media`'s value. -/
inductive CustomMediaValue where
  | queries (q : MediaQueryList)
  | always
  | never

/-- `@import`'s `supports()`: a condition, or a declaration on its own. -/
inductive ImportSupports where
  | condition (c : SupportsCondition)
  | declaration (d : Declaration)

/-- An `@import` rule. -/
structure Import where
  url : String
  /-- `layer`, or `layer(name)`. -/
  layer : Option (Option LayerName) := none
  scope : Option ScopeBounds := none
  supports : Option ImportSupports := none
  media : MediaQueryList := []

/-- An `@namespace` rule. -/
structure Namespace where
  pre : Option Ident := none
  url : String

/-- A test in `@when` or `@else`. -/
inductive WhenTest where
  | media (c : MediaCondition)
  | supports (c : SupportsCondition)

def WhenTest.pieces : WhenTest → List Piece
  | .media c => .ident "media" :: .punct .openParen :: c.pieces FeatureTest.pieces ++ [.punct .closeParen]
  | .supports c =>
    .ident "supports" :: .punct .openParen :: c.pieces SupportsTest.pieces ++ [.punct .closeParen]

def WhenTest.hasUnchecked : WhenTest → Bool
  | .media c => c.hasUnchecked fun _ => false
  | .supports c => c.hasUnchecked SupportsTest.hasUnchecked

/-- A location in `@navigation`. -/
inductive NavigationLocation where
  | url (u : String)
  | named (n : DashedIdent)
  | pattern (p : String)

def NavigationLocation.pieces : NavigationLocation → List Piece
  | .url u => [.punct .url, .string u, .punct .closeParen]
  | .named n => [.ident n.name]
  | .pattern p => [.ident "url-pattern", .punct .openParen, .string p, .punct .closeParen]

inductive NavigationRelation where
  | at | «from» | to
  deriving DecidableEq, Repr

inductive NavigationType where
  | traverse | back | forward | reload
  deriving DecidableEq, Repr

inductive NavigationPhase where
  | loading | ready | committed
  deriving DecidableEq, Repr

inductive NavigationTest where
  | location (r : NavigationRelation) (l : NavigationLocation)
  | between (a b : NavigationLocation)
  | history (t : NavigationType)
  | phase (p : NavigationPhase)

def NavigationTest.pieces (t : NavigationTest) : List Piece :=
  .punct .openParen :: (match t with
    | .location r l =>
      .ident (match r with | .at => "at" | .from => "from" | .to => "to") :: .punct .colon :: .gap ::
        l.pieces
    | .between a b => [.ident "between", .punct .colon, .gap] ++ a.pieces ++
        [.space, .ident "and", .space] ++ b.pieces
    | .history h => [.ident "history", .punct .colon, .gap, .ident (match h with
        | .traverse => "traverse" | .back => "back" | .forward => "forward" | .reload => "reload")]
    | .phase p => [.ident "phase", .punct .colon, .gap, .ident (match p with
        | .loading => "loading" | .ready => "ready" | .committed => "committed")]) ++
    [.punct .closeParen]

/-- A `@location` descriptor. -/
inductive LocationDescriptor where
  | pattern (p : String)
  | init (part : String) (value : String)
    (h : part ∈ ["protocol", "hostname", "port", "pathname", "search", "hash"] := by decide)
  | baseDocument
  | baseStylesheet
  | baseUrl (u : String)

def LocationDescriptor.pieces : LocationDescriptor → List Piece
  | .pattern p => [.ident "pattern", .punct .colon, .gap, .ident "url-pattern", .punct .openParen,
      .string p, .punct .closeParen]
  | .init part v _ => [.ident part, .punct .colon, .gap, .string v]
  | .baseDocument => [.ident "base-url", .punct .colon, .gap, .ident "document"]
  | .baseStylesheet => [.ident "base-url", .punct .colon, .gap, .ident "stylesheet"]
  | .baseUrl u => [.ident "base-url", .punct .colon, .gap, .punct .url, .string u, .punct .closeParen]

/-- A parameter of `@function` or `@mixin`: a name, a type given as a syntax string, and a default
value. -/
structure Parameter where
  name : DashedIdent
  type : Option String := none
  default : Option TokenSeq := none

def Parameter.pieces (p : Parameter) : List Piece :=
  .ident p.name.name :: (match p.type with
    | some t => [.space, .ident "type", .punct .openParen, .string t, .punct .closeParen]
    | none => []) ++ (match p.default with
    | some d => .punct .colon :: .gap :: d.pieces
    | none => [])

/-- An at-rule the model lacks: a name, a prelude, and a block or none, all unchecked. -/
structure UncheckedAtRule where
  name : Ident
  prelude : List Token := []
  block : Option (List Token) := none
  /-- A `;` or `{}` block at the top of the prelude would end it early. -/
  valid : prelude.all (fun | .semicolon | .braces _ => false | _ => true) = true := by decide

/-! ## Rules -/

mutual
/-- Something in a style rule's block, or a group rule's nested within one. -/
inductive BlockItem where
  | decl (d : Declaration)
  | rule (r : NestedRule)

/-- A rule nested in a style rule, by CSS Nesting. -/
inductive NestedRule where
  | style (selectors : RelativeSelectorList) (body : List BlockItem)
  | media (q : MediaQueryList) (body : List BlockItem)
  | supports (c : SupportsCondition) (body : List BlockItem)
  | container (c : ContainerCondition) (more : List ContainerCondition) (body : List BlockItem)
  | layer (name : Option LayerName) (body : List BlockItem)
  | scope (bounds : ScopeBounds) (body : List BlockItem)
  | startingStyle (body : List BlockItem)
  | unchecked (r : UncheckedAtRule)
  | verbatim (text : String)

/-- A rule at the top of a stylesheet, or in a group rule there. -/
inductive Rule where
  | style (selectors : SelectorList) (body : List BlockItem)
  | media (q : MediaQueryList) (rules : List Rule)
  | supports (c : SupportsCondition) (rules : List Rule)
  | container (c : ContainerCondition) (more : List ContainerCondition) (rules : List Rule)
  | layer (name : Option LayerName) (rules : List Rule)
  | layerStatement (name : LayerName) (more : List LayerName)
  /-- `@scope`, whose block holds declarations and rules relative to the scope. -/
  | scope (bounds : ScopeBounds) (body : List BlockItem)
  | startingStyle (rules : List Rule)
  | keyframes (name : KeyframesName) (frames : List Keyframe) (webkit : Bool := false)
  | fontFace (descriptors : List (Descriptor FontFaceDescriptor))
  | fontFeatureValues (family : FamilyName) (more : List FamilyName) (items : List FeatureValuesItem)
  | counterStyle (name : CustomIdent Exclusion.atCounterStyle)
      (descriptors : List (Descriptor CounterStyleDescriptor))
  | property (name : DashedIdent) (descriptors : List (Descriptor PropertyDescriptor))
  | page (selectors : List PageSelector) (items : List PageItem)
  | fontPaletteValues (name : DashedIdent) (descriptors : List (Descriptor FontPaletteValuesDescriptor))
  | colorProfile (name : ColorProfileName) (descriptors : List (Descriptor ColorProfileDescriptor))
  | positionTry (name : DashedIdent) (decls : List Declaration)
  | viewTransition (descriptors : List (Descriptor ViewTransitionDescriptor))
  | customMedia (name : DashedIdent) (value : CustomMediaValue)
  /-- `@custom-selector :--name selectors;` -/
  | customSelector (name : DashedIdent) (selectors : SelectorList)
  | function (name : DashedIdent) (params : List Parameter) (returns : Option String)
      (result : List (Descriptor FunctionDescriptor)) (body : List BlockItem)
  | mixin (name : DashedIdent) (params : Option (List Parameter)) (body : List BlockItem)
  | apply (name : DashedIdent) (args : Option (List TokenSeq)) (contents : Option (List Declaration))
  | contents (fallback : Option (List Declaration))
  | when (c : Cond WhenTest) (rules : List Rule)
  | «else» (c : Option (Cond WhenTest)) (rules : List Rule)
  | navigation (c : Cond NavigationTest) (rules : List Rule)
  | location (name : DashedIdent) (descriptors : List LocationDescriptor)
  /-- `@supports-condition`, naming a condition for `@supports` to test. -/
  | supportsCondition (name : DashedIdent) (c : SupportsCondition)
  | «private» (body : List BlockItem)
  | unchecked (r : UncheckedAtRule)
  | verbatim (text : String)
end

/-! ## Serialization -/

def blockPieces (depth : Nat) (items : List (List Piece)) : List Piece :=
  [.gap, .punct .openBrace] ++ items.flatMap (fun i => .line (depth + 1) :: i) ++
    [.line depth, .punct .closeBrace]

def statement (ps : List Piece) : List Piece := ps ++ [.punct .semicolon]

def atRule (name : String) (prelude : List Piece) : List Piece :=
  .punct .at :: .ident name :: (if prelude.isEmpty then [] else .space :: prelude)

def Declaration.item (d : Declaration) : List Piece := statement d.pieces

def UncheckedAtRule.pieces (r : UncheckedAtRule) : List Piece :=
  atRule r.name.name (Token.pieces.listPieces r.prelude) ++ match r.block with
    | some ts => [.gap, .punct .openBrace] ++ Token.pieces.listPieces ts ++ [.punct .closeBrace]
    | none => [.punct .semicolon]

def commaList (ps : List (List Piece)) : List Piece := joinPieces [.punct .comma, .gap] ps

mutual
def BlockItem.pieces (depth : Nat) : BlockItem → List Piece
  | .decl d => d.item
  | .rule r => NestedRule.pieces depth r

def BlockItem.items (depth : Nat) : List BlockItem → List (List Piece)
  | [] => []
  | i :: is => BlockItem.pieces depth i :: BlockItem.items depth is

def NestedRule.pieces (depth : Nat) : NestedRule → List Piece
  | .style s body => s.pieces ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .media q body => atRule "media" (MediaQueryList.pieces q) ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .supports c body =>
    atRule "supports" (c.pieces SupportsTest.pieces) ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .container c more body =>
    atRule "container" (commaList ((c :: more).map ContainerCondition.pieces)) ++
      blockPieces depth (BlockItem.items (depth + 1) body)
  | .layer name body =>
    atRule "layer" ((name.map LayerName.pieces).getD []) ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .scope b body => atRule "scope" b.pieces ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .startingStyle body => atRule "starting-style" [] ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .unchecked r => r.pieces
  | .verbatim text => [.verbatim text]
end

def descriptorItems {D : Type} [DescriptorTable D] (ds : List (Descriptor D)) : List (List Piece) :=
  ds.map fun d => statement d.pieces

def PageItem.pieces (depth : Nat) : PageItem → List Piece
  | .decl d => d.item
  | .descriptor d => statement d.pieces
  | .margin box decls => atRule box.name [] ++ blockPieces depth (decls.map Declaration.item)

def FeatureValuesItem.pieces (depth : Nat) : FeatureValuesItem → List Piece
  | .descriptor d => statement d.pieces
  | .block type values => atRule type.name [] ++ blockPieces depth (values.map fun v =>
      statement (.ident v.name.name :: .punct .colon :: .gap ::
        joinPieces [.space] ((v.index :: v.more).map fun (n : Nat) => [.number ((n : Int) : Decimal)])))

def Import.pieces (i : Import) : List Piece :=
  let layer : List Piece := match i.layer with
    | none => []
    | some none => [.ident "layer"]
    | some (some n) => .ident "layer" :: .punct .openParen :: n.pieces ++ [.punct .closeParen]
  let scope : List Piece := match i.scope with
    | none => []
    | some b => .ident "scope" :: .punct .openParen :: b.pieces ++ [.punct .closeParen]
  let supports : List Piece := match i.supports with
    | none => []
    | some (.condition c) =>
      .ident "supports" :: .punct .openParen :: c.pieces SupportsTest.pieces ++ [.punct .closeParen]
    | some (.declaration d) =>
      .ident "supports" :: .punct .openParen :: d.pieces ++ [.punct .closeParen]
  statement (atRule "import" (joinPieces [.space]
    ([[.punct .url, .string i.url, .punct .closeParen], layer, scope, supports,
      MediaQueryList.pieces i.media].filter (!·.isEmpty))))

def Namespace.pieces (n : Namespace) : List Piece :=
  statement (atRule "namespace" ((match n.pre with
    | some p => [.ident p.name, .space]
    | none => []) ++ [.punct .url, .string n.url, .punct .closeParen]))

def paramList (ps : List Parameter) : List Piece :=
  .punct .openParen :: commaList (ps.map Parameter.pieces) ++ [.punct .closeParen]

def declBlock (depth : Nat) (decls : List Declaration) : List Piece :=
  blockPieces depth (decls.map Declaration.item)

mutual
def Rule.pieces (depth : Nat) : Rule → List Piece
  | .style s body => s.pieces ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .media q rules => atRule "media" (MediaQueryList.pieces q) ++ blockPieces depth (Rule.items (depth + 1) rules)
  | .supports c rules =>
    atRule "supports" (c.pieces SupportsTest.pieces) ++ blockPieces depth (Rule.items (depth + 1) rules)
  | .container c more rules =>
    atRule "container" (commaList ((c :: more).map ContainerCondition.pieces)) ++
      blockPieces depth (Rule.items (depth + 1) rules)
  | .layer name rules =>
    atRule "layer" ((name.map LayerName.pieces).getD []) ++ blockPieces depth (Rule.items (depth + 1) rules)
  | .layerStatement n more => statement (atRule "layer" (commaList ((n :: more).map LayerName.pieces)))
  | .scope b body => atRule "scope" b.pieces ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .startingStyle rules => atRule "starting-style" [] ++ blockPieces depth (Rule.items (depth + 1) rules)
  | .keyframes name frames webkit =>
    atRule (if webkit then "-webkit-keyframes" else "keyframes") name.pieces ++
      blockPieces depth (frames.map fun f =>
        commaList ((f.selector :: f.more).map KeyframeSelector.pieces) ++ declBlock (depth + 1) f.decls)
  | .fontFace ds => atRule "font-face" [] ++ blockPieces depth (descriptorItems ds)
  | .fontFeatureValues f more items =>
    atRule "font-feature-values" (commaList ((f :: more).map FamilyName.pieces)) ++
      blockPieces depth (items.map (FeatureValuesItem.pieces (depth + 1)))
  | .counterStyle name ds => atRule "counter-style" [.ident name.name] ++ blockPieces depth (descriptorItems ds)
  | .property name ds => atRule "property" [.ident name.name] ++ blockPieces depth (descriptorItems ds)
  | .page sels items =>
    atRule "page" (commaList (sels.map PageSelector.pieces)) ++
      blockPieces depth (items.map (PageItem.pieces (depth + 1)))
  | .fontPaletteValues name ds =>
    atRule "font-palette-values" [.ident name.name] ++ blockPieces depth (descriptorItems ds)
  | .colorProfile name ds =>
    atRule "color-profile" (match name with
      | .dashed n => [.ident n.name]
      | .deviceCmyk => [.ident "device-cmyk"]) ++ blockPieces depth (descriptorItems ds)
  | .positionTry name decls => atRule "position-try" [.ident name.name] ++ declBlock depth decls
  | .viewTransition ds => atRule "view-transition" [] ++ blockPieces depth (descriptorItems ds)
  | .customMedia name v =>
    statement (atRule "custom-media" (.ident name.name :: .space :: match v with
      | .queries q => MediaQueryList.pieces q
      | .always => [.ident "true"]
      | .never => [.ident "false"]))
  | .customSelector name s =>
    statement (atRule "custom-selector" ([.punct .colon, .ident name.name, .space] ++ s.pieces))
  | .function name params returns result body =>
    atRule "function" (.ident name.name :: paramList params ++ (match returns with
      | some t => [.space, .ident "returns", .space, .ident "type", .punct .openParen, .string t, .punct .closeParen]
      | none => [])) ++
      blockPieces depth (descriptorItems result ++ BlockItem.items (depth + 1) body)
  | .mixin name params body =>
    atRule "mixin" (.ident name.name :: (params.map paramList).getD []) ++
      blockPieces depth (BlockItem.items (depth + 1) body)
  | .apply name args inner =>
    atRule "apply" (.ident name.name :: (args.map fun as =>
        .punct .openParen :: commaList (as.map TokenSeq.pieces) ++ [.punct .closeParen]).getD []) ++
      match inner with
      | some decls => declBlock depth decls
      | none => [.punct .semicolon]
  | .contents fallback =>
    atRule "contents" [] ++ match fallback with
      | some decls => declBlock depth decls
      | none => [.punct .semicolon]
  | .when c rules => atRule "when" (c.pieces WhenTest.pieces) ++ blockPieces depth (Rule.items (depth + 1) rules)
  | .else c rules =>
    atRule "else" ((c.map (·.pieces WhenTest.pieces)).getD []) ++ blockPieces depth (Rule.items (depth + 1) rules)
  | .navigation c rules =>
    atRule "navigation" (c.pieces NavigationTest.pieces) ++ blockPieces depth (Rule.items (depth + 1) rules)
  | .location name ds =>
    atRule "location" [.ident name.name] ++ blockPieces depth (ds.map fun d => statement d.pieces)
  | .supportsCondition name c =>
    atRule "supports-condition" [.ident name.name] ++ blockPieces depth [c.pieces SupportsTest.pieces]
  | .private body => atRule "private" [] ++ blockPieces depth (BlockItem.items (depth + 1) body)
  | .unchecked r => r.pieces
  | .verbatim text => [.verbatim text]

def Rule.items (depth : Nat) : List Rule → List (List Piece)
  | [] => []
  | r :: rs => Rule.pieces depth r :: Rule.items depth rs
end

/-! ## Unchecked parts -/

def descriptorsUnchecked {D : Type} [DescriptorTable D] (ds : List (Descriptor D)) : Bool :=
  ds.any (·.hasUnchecked)

def declsUnchecked (ds : List Declaration) : Bool := ds.any (·.hasUnchecked)

def MediaQueryList.hasUnchecked (q : MediaQueryList) : Bool := q.any (·.hasUnchecked)

def ImportSupports.hasUnchecked : ImportSupports → Bool
  | .condition c => c.hasUnchecked SupportsTest.hasUnchecked
  | .declaration d => d.hasUnchecked

def Import.hasUnchecked (i : Import) : Bool :=
  i.scope.any (·.hasUnchecked) || i.supports.any (·.hasUnchecked) || MediaQueryList.hasUnchecked i.media

mutual
def BlockItem.hasUnchecked : BlockItem → Bool
  | .decl d => d.hasUnchecked
  | .rule r => NestedRule.hasUnchecked r

def BlockItem.anyUnchecked : List BlockItem → Bool
  | [] => false
  | i :: is => BlockItem.hasUnchecked i || BlockItem.anyUnchecked is

def NestedRule.hasUnchecked : NestedRule → Bool
  | .style s body => s.hasUnchecked || BlockItem.anyUnchecked body
  | .media q body => MediaQueryList.hasUnchecked q || BlockItem.anyUnchecked body
  | .supports c body => c.hasUnchecked SupportsTest.hasUnchecked || BlockItem.anyUnchecked body
  | .container c more body =>
    (c :: more).any (·.hasUnchecked) || BlockItem.anyUnchecked body
  | .layer _ body | .startingStyle body => BlockItem.anyUnchecked body
  | .scope b body => b.hasUnchecked || BlockItem.anyUnchecked body
  | .unchecked _ => true
  | .verbatim _ => false
end

mutual
def Rule.hasUnchecked : Rule → Bool
  | .style s body => s.hasUnchecked || BlockItem.anyUnchecked body
  | .media q rules => MediaQueryList.hasUnchecked q || Rule.anyUnchecked rules
  | .supports c rules => c.hasUnchecked SupportsTest.hasUnchecked || Rule.anyUnchecked rules
  | .container c more rules => (c :: more).any (·.hasUnchecked) || Rule.anyUnchecked rules
  | .layer _ rules | .startingStyle rules => Rule.anyUnchecked rules
  | .navigation c rules => c.hasUnchecked (fun _ => false) || Rule.anyUnchecked rules
  | .when c rules => c.hasUnchecked WhenTest.hasUnchecked || Rule.anyUnchecked rules
  | .else c rules => c.any (·.hasUnchecked WhenTest.hasUnchecked) || Rule.anyUnchecked rules
  | .scope b body => b.hasUnchecked || BlockItem.anyUnchecked body
  | .keyframes _ frames _ => frames.any fun f => declsUnchecked f.decls
  | .fontFace ds => descriptorsUnchecked ds
  | .fontFeatureValues _ _ items => items.any fun
    | .descriptor d => d.hasUnchecked
    | .block .. => false
  | .counterStyle _ ds => descriptorsUnchecked ds
  | .property _ ds => descriptorsUnchecked ds
  | .page _ items => items.any fun
    | .decl d => d.hasUnchecked
    | .descriptor d => d.hasUnchecked
    | .margin _ decls => declsUnchecked decls
  | .fontPaletteValues _ ds => descriptorsUnchecked ds
  | .colorProfile _ ds => descriptorsUnchecked ds
  | .positionTry _ decls => declsUnchecked decls
  | .viewTransition ds => descriptorsUnchecked ds
  | .customMedia _ (.queries q) => MediaQueryList.hasUnchecked q
  | .customSelector _ s => s.hasUnchecked
  | .function _ _ _ result body => descriptorsUnchecked result || BlockItem.anyUnchecked body
  | .mixin _ _ body | .private body => BlockItem.anyUnchecked body
  | .apply _ _ (some decls) => declsUnchecked decls
  | .contents (some decls) => declsUnchecked decls
  | .supportsCondition _ c => c.hasUnchecked SupportsTest.hasUnchecked
  | .unchecked _ => true
  | _ => false

def Rule.anyUnchecked : List Rule → Bool
  | [] => false
  | r :: rs => Rule.hasUnchecked r || Rule.anyUnchecked rs
end

/-! ## Stylesheets -/

/-- What may stand before `@namespace` rules: `@layer` statements and `@import` rules. -/
inductive Preamble where
  | layer (name : LayerName) (more : List LayerName := [])
  | «import» (i : Import)

def Preamble.pieces : Preamble → List Piece
  | .layer n more => Rule.pieces 0 (.layerStatement n more)
  | .import i => i.pieces

/-- A stylesheet, whose order is CSS's: `@layer` statements and `@import` rules, then
`@namespace` rules, then everything else. `@charset` is a matter for the transport. -/
structure Stylesheet where
  preamble : List Preamble := []
  namespaces : List Namespace := []
  rules : List Rule := []

namespace Stylesheet

def pieces (s : Stylesheet) : List Piece :=
  joinPieces [.line 0] (s.preamble.map Preamble.pieces ++ s.namespaces.map Namespace.pieces ++
    Rule.items 0 s.rules)

def serialize (s : Stylesheet) (layout : Layout := .indented) : String := render s.pieces layout

def hasUnchecked (s : Stylesheet) : Bool :=
  s.preamble.any (fun
    | .import i => i.hasUnchecked
    | .layer .. => false) || Rule.anyUnchecked s.rules

def hasVerbatim (s : Stylesheet) : Bool := s.pieces.any Piece.isVerbatim

/-- Without verbatim text, a serialized stylesheet never contains `</`, so it is safe as the
raw text of a `<style>` element. -/
theorem serialize_safe (s : Stylesheet) (layout : Layout) (h : s.hasVerbatim = false) :
    ∀ a b, (s.serialize layout).toList ≠ a ++ ['<', '/'] ++ b :=
  render_safe _ layout h

end Stylesheet

def Rule.serialize (r : Rule) (layout : Layout := .indented) : String := render (r.pieces 0) layout

def Rule.hasVerbatim (r : Rule) : Bool := (r.pieces 0).any Piece.isVerbatim

theorem Rule.serialize_safe (r : Rule) (layout : Layout) (h : r.hasVerbatim = false) :
    ∀ a b, (r.serialize layout).toList ≠ a ++ ['<', '/'] ++ b :=
  render_safe _ layout h

end CssModel
