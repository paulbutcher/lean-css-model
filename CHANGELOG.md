# Changelog

## [0.3.1] - 2026-11-06

* Requires lean-regular 0.2.1

## [0.3.0] - 2026-11-01

* A `<custom-ident>` excludes the keywords of the grammar it appears in, or those its specification's prose names, so `CustomIdent` and `Kind.customIdent` are indexed by the keywords excluded
* `@layer` names exclude the CSS-wide keywords

## [0.2.0] - 2026-10-31

* `hasUnchecked` sees unchecked parts of `@navigation` conditions
* An integer is accepted where a number is
* `round()` without an interval is accepted only for a number, as Values 4 requires
* Container features are tested only by their own kind of query, with `anchored()` added for `fallback`
* `Rejection.position` and `Rejection.expected` say where a value goes wrong and what its grammar expected there, and `Rejection.diagnosis` is lean-regular 0.2.0's `Diagnosis Sym`
* Pseudo-elements follow one another only as CSS allows, by an index on `PseudoTail`, and `::part()` admits any pseudo-class that does not depend on the tree, `:state()` included

## [0.1.0] - 2026-10-31

* Typed CSS values, declarations, selectors, media, supports and container queries, rules and stylesheets, each value checked against its grammar at compile time, with grammars generated from `@webref/css` 8.7.8
* Unchecked declarations and at-rules and verbatim text as escape hatches, with decidable checks for each
* Compact and indented serialization, proven never to produce `</` without verbatim text, with identifiers and strings proven to serialize to single tokens
