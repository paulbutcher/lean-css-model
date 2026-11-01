/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Lake
open Lake DSL

package «css-model» where
  version := v!"0.3.0"
  leanOptions := #[⟨`warningAsError, true⟩]

require regular from git "https://github.com/paulbutcher/lean-regular" @ "v0.2.1"

@[default_target]
lean_lib CssModel

/-- The `test`, `bench` and `gen` subprojects are deliberately not dependencies of this package,
so that downstream consumers don't inherit their tooling. Running them as child processes keeps
`lake test`, `lake run bench` and `lake run generate` working from the repo root regardless. -/
@[test_driver]
script tests do
  let child ← IO.Process.spawn { cmd := "lake", args := #["test"], cwd := __dir__ / "test" }
  child.wait

script bench do
  let child ← IO.Process.spawn { cmd := "lake", args := #["build"], cwd := __dir__ / "bench" }
  child.wait

/-- Regenerates `CssModel/Generated` from the vendored data; with `--check`, fails if the
checked-in files differ from what it would generate. -/
script generate (args) do
  let child ← IO.Process.spawn
    { cmd := "lake", args := #["exe", "generate"] ++ args.toArray, cwd := __dir__ / "gen" }
  child.wait
