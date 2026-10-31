# Changelog

## [0.1.0] - 2026-10-31

* Typed CSS values, declarations, selectors, media, supports and container queries, rules and stylesheets, each value checked against its grammar at compile time, with grammars generated from `@webref/css` 8.7.8
* Unchecked declarations and at-rules and verbatim text as escape hatches, with decidable checks for each
* Compact and indented serialization, proven never to produce `</` without verbatim text, with identifiers and strings proven to serialize to single tokens
