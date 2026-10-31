# CSS Model

A Lean 4 library that models CSS stylesheets, declaration lists and property values as typed Lean values, so that what it builds is valid CSS by construction, and serializes them to text. Each property's value is checked against its grammar at compile time by [lean-regular](https://github.com/paulbutcher/lean-regular), even when it is built from Lean variables, and `Stylesheet.serialize_safe` proves that, as long as you don't reach for verbatim text, the output is safe as the raw text of a `<style>` element.

It depends on no HTML library, and no HTML library depends on it: a consumer that wants typed `style` attributes or `<style>` elements depends on both and joins them.

## Installation

Add it to your `lakefile.toml`:

```toml
[[require]]
name = "css-model"
git = "https://github.com/paulbutcher/lean-css-model"
```

## Usage

```lean
import CssModel

open CssModel

-- A declaration whose value is checked against `margin`'s grammar when it is compiled.
def centred : Declaration := decl .margin [zero, kw .auto]

-- A value built from Lean variables: their kinds are known, so it is checked at compile time too.
def font (size : Decimal) (h : Range.nonneg.contains size = true) (families : List String) :
    Declaration :=
  decl .font [px size .nonneg h, .commaList1 (str "Inter") (families.map str)]

-- A property the data lacks, with any balanced tokens as its value, unchecked.
def tap : Declaration :=
  .unchecked ⟨"-webkit-tap-highlight-color", rfl⟩ ⟨[.ident ⟨"transparent", rfl⟩], rfl⟩

def card : Rule := .style (.one (.last (Compound.of none [.cls ⟨"card", rfl⟩]))) [
  .decl centred,
  .decl (decl .color [fn .rgb [num 0, num 128, num 255, slash, pct 50]]),
  .decl tap]

#eval card.serialize .compact
-- ".card{margin:0 auto;color:rgb(0 128 255 / 50%);-webkit-tap-highlight-color:transparent;}"
```

A value the grammar rejects is a compile-time error:

```lean
def bad : Declaration := decl .padding [px 10, px (-5)]
-- error: Tactic `decide` proved that the proposition
--   Admits Property.padding.syntax.toRegex Grammar.forProperty
--     ((sym (Kind.numeric NumericKind.length { lo := some 0 })).cat
--       ((sym (Kind.numeric NumericKind.length { })).cat eps))
-- is false
```

and `Value.explain` says which component is wrong, here the second, whose range is unbounded where `padding` needs it nonnegative:

```lean
#eval (Value.explain .padding [px 10, px (-5)]).map fun r => (r.counterexample, r.diagnosis)
-- some ([(0, Kind.numeric .length { lo := some 0 }), (1, Kind.numeric .length { })],
--   Regular.Diagnosis.unexpected 1)
```

- Components are `kw` for keywords, `ident`, `dashed`, `str`, `url`, `hex`, `num`, `int`, `pct`, the dimensions (`px`, `em`, `rem`, `vw`, `vh`, `deg`, `sec`, `ms`, `fr`, and `length` and `dim` for any unit), `zero` for a unitless `0`, `slash` and `comma`, `fn` for a function, `math` for a math function, and `var` for `var()`. A component's type records its kind, never its magnitude.
- A list of components may hold segments: `Seg.opt` for an optional component, `Seg.many` and `Seg.many1` for a list of unknown length, and `Seg.commaList`, `Seg.commaList1` and `Seg.groups` for comma-separated ones. Their lengths never enter the check.
- A number restricted to a range, as `padding` restricts lengths to `[0,∞]`, carries a proof that it lies there. A literal's range is inferred and its proof found by `decide`; a variable's range is given, with a proof, as in `font` above.
- A function's arguments are checked against its own grammar, as a level of their own. Where a function has several grammars by context, each has a name: `minmax()` in `<track-size>` is `.trackSizeMinmax`, `repeat()` in `<track-repeat>` is `.trackRepeat`, and `scale()` in `transform` is `.transformScale`.
- `math` takes a `CalcExpr`, typed by CSS Typed OM's type algebra as it is built, and is accepted wherever its resulting type is, range restrictions included: `calc(100% - 3em)` is a `<length-percentage>`, and `1px * 1px` is a length squared, which no property takes.
- A CSS-wide keyword is a value of every property, and any value containing `var()`, `env()` or `attr()` is accepted for any property, as browsers accept it; `Value.hasSubstitution` says whether one does.
- `Value p` is a property's value on its own, as an SVG presentation attribute takes it.

## Rules and stylesheets

- Selectors are Selectors Level 4's, with every attribute matcher and case flag, `:is()`, `:where()`, `:not()`, `:has()`, `:nth-child(An+B of S)`, namespaces and the nesting selector `&`. A pseudo-element ends its compound selector, followed only by the user action pseudo-classes, and `:has()` does not nest; breaking either is a type error. Type selectors are any identifier, for a consumer to check against its elements.
- Style rules nest, by CSS Nesting, with relative selectors and conditional group rules. Every at-rule in the data is modelled: `@media`, `@supports`, `@container`, `@layer`, `@scope`, `@starting-style`, `@keyframes`, `@font-face`, `@font-feature-values`, `@counter-style`, `@property`, `@page` with its margin rules, `@import`, `@namespace`, `@font-palette-values`, `@color-profile`, `@position-try`, `@view-transition`, `@custom-media`, `@custom-selector`, `@function`, `@mixin`, `@apply`, `@contents`, `@when`, `@else`, `@navigation`, `@location`, `@supports-condition` and `@private`.
- Media queries, with Level 4's range syntax, `@supports` conditions and container queries are typed, each feature's value by its grammar, and range syntax only for range features. Descriptors are typed by their at-rule's grammars, through `desc`.
- `Stylesheet` holds `@layer` statements and `@import` rules, then `@namespace` rules, then everything else, which is the order CSS requires. `@charset` is left to the transport.
- `serialize` lays a stylesheet, rule or declaration list out `.indented` or `.compact`. `Declaration.propertyName` and `Declaration.valueText` give a declaration's name and value as separate strings, as `style.setProperty` takes them, and `DeclarationList.properties` gives them for a whole `style` attribute.
- Identifiers and strings are escaped as CSSOM specifies, except that `<` is escaped as `\3c `.

## Escape hatches

- `Declaration.unchecked` takes any identifier as a property name and any balanced tokens as its value, for vendor-prefixed and experimental properties; `DeclValue.unchecked` does the same for an experimental value of a known property.
- `Rule.unchecked` and `NestedRule.unchecked` take a name, a prelude and a block of tokens, for at-rules the model lacks.
- `Declaration.verbatim`, `DeclValue.verbatim`, `Rule.verbatim` and `NestedRule.verbatim` take raw text, trusted as-is, which can break out of a `<style>` element.
- `hasUnchecked` and `hasVerbatim` on stylesheets, rules and declaration lists say whether either is used, so a consumer can refuse them.

## Data

The property, type, function, descriptor, media feature, pseudo-class and pseudo-element data is generated from [`@webref/css`](https://www.npmjs.com/package/@webref/css) 8.7.8, vendored as `gen/webref/css.json`. The generator in `gen` translates each grammar from Value Definition Syntax, inlining type references within a level and reporting any cycle that does not pass through a function, and checks in its output as `CssModel/Generated`, so that building the library needs neither the generator nor the network. `lake run generate` regenerates it, and `lake run generate --check` fails if the checked-in files are not what it would generate.

817 of the data's 822 properties are translated. What the generator cannot translate, such as types defined only in prose, is listed in `gen/untranslated.txt`; a grammar that refers to one leaves that part out, so it accepts less rather than more, and the rest is left to the escape hatches.

## Performance

One acceptance proof is elaborated per declaration, by `decide +kernel` on the value's shape, which is first reduced to normal form so that literals of the same kind share their proof. `lake run bench` times single declarations and a stylesheet of 425 declarations in 85 rules:

- `display: flex` and `margin: 0 auto` take under 10 ms, `color: rgb(...)` 35 ms, `font` 75 ms, and `background` with two layers, the slowest, about 280 ms.
- The stylesheet takes about 3.9 s as one term, about 9 ms a declaration. Defined a rule at a time, the same declarations take about 1.4 s.

## Formal verification

- `Vds.matches_toRegex_iff`: the translation of Value Definition Syntax to `Regular.Regex` is faithful to `Vds.Denotes`, a semantics of each combinator stated without reference to regular expressions.
- `render_safe`: rendered pieces without verbatim text never contain `</`, the one place `<` is written being range syntax's `<`, always followed by a space or `=`. `Stylesheet.serialize_safe`, `Rule.serialize_safe` and `DeclarationList.serialize_safe` follow from it.
- `serializeIdent_token` and `serializeString_token`: a serialized identifier is a single `<ident-token>`, and a serialized string a single `<string-token>`, by `TokenSpec`'s productions from CSS Syntax Level 3, written independently of the serializer; each decodes to the original, NUL being replaced by U+FFFD.
- The acceptance check itself is lean-regular's `accepts_iff`.

## License

This library is released under the Apache 2.0 license. See the LICENSE file for the complete license text.
