/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Decimal

@[expose] public section

namespace CssModel

/-- The dimensions of CSS Values and Units Level 4, with `<flex>` from Grid Layout. -/
inductive DimKind where
  | length | angle | time | frequency | resolution | flex
  deriving DecidableEq, Repr

/-- The numeric types a component can have: its kind before any range. -/
inductive NumericKind where
  | number | integer | percentage | length | angle | time | frequency | resolution | flex
  deriving DecidableEq, Repr

def DimKind.numeric : DimKind → NumericKind
  | .length => .length | .angle => .angle | .time => .time | .frequency => .frequency
  | .resolution => .resolution | .flex => .flex

inductive LengthUnit where
  | em | rem | ex | rex | cap | rcap | ch | rch | ic | ric | lh | rlh
  | vw | vh | vi | vb | vmin | vmax | svw | svh | svi | svb | svmin | svmax
  | lvw | lvh | lvi | lvb | lvmin | lvmax | dvw | dvh | dvi | dvb | dvmin | dvmax
  | cqw | cqh | cqi | cqb | cqmin | cqmax | cm | mm | Q | «in» | pt | pc | px
  deriving DecidableEq, Repr

inductive AngleUnit where
  | deg | grad | rad | turn
  deriving DecidableEq, Repr

inductive TimeUnit where
  | s | ms
  deriving DecidableEq, Repr

inductive FrequencyUnit where
  | Hz | kHz
  deriving DecidableEq, Repr

inductive ResolutionUnit where
  | dpi | dpcm | dppx | x
  deriving DecidableEq, Repr

inductive FlexUnit where
  | fr
  deriving DecidableEq, Repr

def DimKind.Unit : DimKind → Type
  | .length => LengthUnit | .angle => AngleUnit | .time => TimeUnit
  | .frequency => FrequencyUnit | .resolution => ResolutionUnit | .flex => FlexUnit

def DimKind.unitName : (d : DimKind) → d.Unit → String
  | .length, u => match u with
    | .em => "em" | .rem => "rem" | .ex => "ex" | .rex => "rex" | .cap => "cap"
    | .rcap => "rcap" | .ch => "ch" | .rch => "rch" | .ic => "ic" | .ric => "ric" | .lh => "lh"
    | .rlh => "rlh" | .vw => "vw" | .vh => "vh" | .vi => "vi" | .vb => "vb" | .vmin => "vmin"
    | .vmax => "vmax" | .svw => "svw" | .svh => "svh" | .svi => "svi" | .svb => "svb"
    | .svmin => "svmin" | .svmax => "svmax" | .lvw => "lvw" | .lvh => "lvh" | .lvi => "lvi"
    | .lvb => "lvb" | .lvmin => "lvmin" | .lvmax => "lvmax" | .dvw => "dvw" | .dvh => "dvh"
    | .dvi => "dvi" | .dvb => "dvb" | .dvmin => "dvmin" | .dvmax => "dvmax" | .cqw => "cqw"
    | .cqh => "cqh" | .cqi => "cqi" | .cqb => "cqb" | .cqmin => "cqmin" | .cqmax => "cqmax"
    | .cm => "cm" | .mm => "mm" | .Q => "Q" | .in => "in" | .pt => "pt" | .pc => "pc"
    | .px => "px"
  | .angle, u => match u with
    | .deg => "deg" | .grad => "grad" | .rad => "rad" | .turn => "turn"
  | .time, u => match u with
    | .s => "s" | .ms => "ms"
  | .frequency, u => match u with
    | .Hz => "Hz" | .kHz => "kHz"
  | .resolution, u => match u with
    | .dpi => "dpi" | .dpcm => "dpcm" | .dppx => "dppx" | .x => "x"
  | .flex, u => match u with
    | .fr => "fr"

/-- `v` in the unit its kind's ranges are written in: degrees, seconds, hertz, or `dppx`.
Lengths are left as written, which is exact against a bound of zero, the only bound any length
range has; `rad` uses ten significant digits of `180 / π`. -/
def DimKind.canonical : (d : DimKind) → Decimal → d.Unit → Decimal
  | .angle, v, u => match u with
    | .deg => v | .grad => v.mulRatio 9 10 1 | .turn => v.mulRatio 360 1
    | .rad => v.mulRatio 5729577951 100000000 8
  | .time, v, u => match u with
    | .s => v | .ms => v.mulRatio 1 1000 3
  | .frequency, v, u => match u with
    | .Hz => v | .kHz => v.mulRatio 1000 1
  | .resolution, v, u => match u with
    | .dppx | .x => v | .dpi => v.mulRatio 1 96 6 | .dpcm => v.mulRatio 254 9600 6
  | .length, v, _ | .flex, v, _ => v

/-- A closed range of numbers, as in `<length [0,∞]>`; `none` is unbounded on that side. -/
structure Range where
  lo : Option Decimal := none
  hi : Option Decimal := none
  deriving DecidableEq, Repr

namespace Range

def all : Range := {}

def nonneg : Range := { lo := some 0 }

def contains (r : Range) (v : Decimal) : Bool :=
  r.lo.all (decide <| · ≤ v) && r.hi.all (decide <| v ≤ ·)

/-- Every number in `r` is in `r'`. -/
def subset (r r' : Range) : Bool :=
  (match r'.lo with
    | none => true
    | some l' => r.lo.any (decide <| l' ≤ ·)) &&
  (match r'.hi with
    | none => true
    | some h' => r.hi.any (decide <| · ≤ h'))

def maxLo : Option Decimal → Option Decimal → Option Decimal
  | none, b => b
  | a, none => a
  | some a, some b => some (if decide (a ≤ b) then b else a)

def minHi : Option Decimal → Option Decimal → Option Decimal
  | none, b => b
  | a, none => a
  | some a, some b => some (if decide (a ≤ b) then a else b)

def inter (r r' : Range) : Range := ⟨maxLo r.lo r'.lo, minHi r.hi r'.hi⟩

/-- The intersection of those of `known` that contain `v`: the range a literal is given when
none is asked for, so that it meets whichever restriction its grammar has. -/
def tightest (known : List Range) (v : Decimal) : Range :=
  known.foldl (fun acc r => if r.contains v then acc.inter r else acc) all

end Range

end CssModel
