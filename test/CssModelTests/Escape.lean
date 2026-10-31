/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

import CssModel
meta import CssModel

namespace CssModelTests

open CssModel

-- CSSOM's "serialize an identifier".
#guard serializeIdent "foo-bar_baz" = "foo-bar_baz"
#guard serializeIdent "1a" = "\\31 a"
#guard serializeIdent "-1a" = "-\\31 a"
#guard serializeIdent "-" = "\\-"
#guard serializeIdent "--x" = "--x"
#guard serializeIdent "a b" = "a\\ b"
#guard serializeIdent "a\nb" = "a\\a b"
#guard serializeIdent "a\x00b" = "a�b"
#guard serializeIdent "é" = "é"
#guard serializeIdent "a<b" = "a\\3c b"
#guard serializeIdent "a.b#c" = "a\\.b\\#c"

-- CSSOM's "serialize a string".
#guard serializeString "it's" = "\"it's\""
#guard serializeString "say \"hi\"" = "\"say \\\"hi\\\"\""
#guard serializeString "a\\b" = "\"a\\\\b\""
#guard serializeString "</style>" = "\"\\3c /style>\""
#guard serializeString "tab\there" = "\"tab\\9 here\""

-- A unit after a number must not read as an exponent.
#guard serializeUnit "e3" = "\\65 3"
#guard serializeUnit "e-2" = "\\65 -2"
#guard serializeUnit "em" = "em"

#guard toString (1.25 : Decimal) = "1.25"
#guard toString (-0.05 : Decimal) = "-0.05"
#guard toString (100 : Decimal) = "100"
#guard toString (-3 : Decimal) = "-3"

end CssModelTests
