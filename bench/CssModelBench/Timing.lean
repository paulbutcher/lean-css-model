/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public meta import Lean.Elab.Command

public section

open Lean Elab Command

/-- `#bench "name" cmd` elaborates `cmd`, kernel checks included, and logs how long it took. -/
syntax (name := bench) "#bench " str ppSpace command : command

@[command_elab bench]
meta def elabBench : CommandElab
  | `(#bench $name:str $cmd:command) =>
    withScope (fun s => { s with opts := Elab.async.set s.opts false }) do
      let t₀ ← IO.monoNanosNow
      elabCommand cmd
      let t₁ ← IO.monoNanosNow
      logInfo m!"{name.getString}: {(t₁ - t₀) / 1000000} ms"
  | _ => throwUnsupportedSyntax
