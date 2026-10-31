/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel.Kind
public import Regular

@[expose] public section

namespace CssModel

open Regular Regex

/-- A term of CSS's Value Definition Syntax with its type references already inlined, so that
each term describes one level of a value, function arguments being levels of their own. -/
inductive Vds where
  /-- One component of the kinds `s` admits. -/
  | atom (s : Sym)
  /-- Juxtaposition. -/
  | seq (xs : List Vds)
  /-- `|` -/
  | oneOf (xs : List Vds)
  /-- `&&` -/
  | allOf (xs : List Vds)
  /-- `||` -/
  | someOf (xs : List Vds)
  /-- `?` -/
  | opt (x : Vds)
  /-- `*` -/
  | star (x : Vds)
  /-- `+` -/
  | plus (x : Vds)
  /-- `{lo,hi}` -/
  | rep (lo hi : Nat) (x : Vds)
  /-- `{lo,}` -/
  | atLeast (lo : Nat) (x : Vds)
  /-- `#` -/
  | commaList (x : Vds)
  /-- `#{lo,hi}`, for `1 ≤ lo`. -/
  | commaRep (lo hi : Nat) (x : Vds)
  /-- `!` -/
  | nonEmpty (x : Vds)
  deriving Repr, Inhabited

namespace Vds

/-- An induction principle that reaches the members of lists, which `induction` cannot. -/
@[elab_as_elim]
theorem ind {motive : Vds → Prop} (atom : ∀ s, motive (.atom s))
    (seq : ∀ xs, (∀ x ∈ xs, motive x) → motive (.seq xs))
    (oneOf : ∀ xs, (∀ x ∈ xs, motive x) → motive (.oneOf xs))
    (allOf : ∀ xs, (∀ x ∈ xs, motive x) → motive (.allOf xs))
    (someOf : ∀ xs, (∀ x ∈ xs, motive x) → motive (.someOf xs))
    (opt : ∀ x, motive x → motive (.opt x)) (star : ∀ x, motive x → motive (.star x))
    (plus : ∀ x, motive x → motive (.plus x))
    (rep : ∀ lo hi x, motive x → motive (.rep lo hi x))
    (atLeast : ∀ lo x, motive x → motive (.atLeast lo x))
    (commaList : ∀ x, motive x → motive (.commaList x))
    (commaRep : ∀ lo hi x, motive x → motive (.commaRep lo hi x))
    (nonEmpty : ∀ x, motive x → motive (.nonEmpty x)) (v : Vds) : motive v :=
  Vds.rec (motive_1 := motive) (motive_2 := fun xs => ∀ x ∈ xs, motive x)
    atom seq oneOf allOf someOf opt star plus rep atLeast commaList commaRep nonEmpty
    (fun _ h => nomatch h)
    (fun _ _ ih ihs _ h => by
      cases h with
      | head => exact ih
      | tail _ h => exact ihs _ h)
    v

mutual
def toRegex : Vds → Regex Sym
  | .atom s => .sym s
  | .seq xs => Regex.seq (toRegexList xs)
  | .oneOf xs => Regex.oneOf (toRegexList xs)
  | .allOf xs => .allOf (toRegexList xs)
  | .someOf xs => Regex.someOf (toRegexList xs)
  | .opt x => Regex.opt (toRegex x)
  | .star x => .star (toRegex x)
  | .plus x => Regex.plus (toRegex x)
  | .rep lo hi x => Regex.rep lo hi (toRegex x)
  | .atLeast lo x => Regex.atLeast lo (toRegex x)
  | .commaList x => Regex.sepBy1 (toRegex x) (.sym Sym.comma)
  | .commaRep lo hi x =>
    .cat (toRegex x) (Regex.rep (lo - 1) (hi - 1) (.cat (.sym Sym.comma) (toRegex x)))
  | .nonEmpty x => .nonEmpty (toRegex x)

def toRegexList : List Vds → List (Regex Sym)
  | [] => []
  | x :: xs => toRegex x :: toRegexList xs
end

theorem toRegexList_eq (xs : List Vds) : toRegexList xs = xs.map toRegex := by
  induction xs with
  | nil => rfl
  | cons x xs ih => simp [toRegexList, ih]

/-- What a term means, stated without reference to `Regex`: the sequences of components it
admits, where a component is admitted by an atom when `m` says it conforms. -/
inductive Denotes (m : Kind → Sym → Bool) : Vds → List Kind → Prop where
  | atom {s : Sym} {k : Kind} : m k s = true → Denotes m (.atom s) [k]
  | seqNil : Denotes m (.seq []) []
  | seqCons {x : Vds} {xs : List Vds} {u v : List Kind} : Denotes m x u → Denotes m (.seq xs) v →
      Denotes m (.seq (x :: xs)) (u ++ v)
  | oneOf {x : Vds} {xs : List Vds} {w : List Kind} : x ∈ xs → Denotes m x w →
      Denotes m (.oneOf xs) w
  /-- One word from each member, concatenated in some order. -/
  | allOf {xs : List Vds} (ps : List (Vds × List Kind)) : (ps.map Prod.fst).Perm xs →
      (∀ p ∈ ps, Denotes m p.1 p.2) → Denotes m (.allOf xs) (ps.map Prod.snd).flatten
  /-- At most one word from each member, in some order, and not nothing at all. -/
  | someOf {xs : List Vds} (ps : List (Vds × List Kind)) : (ps.map Prod.fst).Perm xs →
      (∀ p ∈ ps, p.2 ≠ [] → Denotes m p.1 p.2) → (ps.map Prod.snd).flatten ≠ [] →
      Denotes m (.someOf xs) (ps.map Prod.snd).flatten
  | optNone {x : Vds} : Denotes m (.opt x) []
  | optSome {x : Vds} {w : List Kind} : Denotes m x w → Denotes m (.opt x) w
  | star {x : Vds} (ws : List (List Kind)) : (∀ v ∈ ws, Denotes m x v) →
      Denotes m (.star x) ws.flatten
  | plus {x : Vds} (ws : List (List Kind)) : ws ≠ [] → (∀ v ∈ ws, Denotes m x v) →
      Denotes m (.plus x) ws.flatten
  | rep {lo hi : Nat} {x : Vds} (ws : List (List Kind)) : lo ≤ ws.length → ws.length ≤ hi →
      (∀ v ∈ ws, Denotes m x v) → Denotes m (.rep lo hi x) ws.flatten
  | atLeast {lo : Nat} {x : Vds} (ws : List (List Kind)) : lo ≤ ws.length →
      (∀ v ∈ ws, Denotes m x v) → Denotes m (.atLeast lo x) ws.flatten
  /-- A first word, then each further one after a component conforming to a comma. -/
  | commaList {x : Vds} {v : List Kind} (ps : List (Kind × List Kind)) : Denotes m x v →
      (∀ p ∈ ps, m p.1 Sym.comma = true) → (∀ p ∈ ps, Denotes m x p.2) →
      Denotes m (.commaList x) (v ++ (ps.map fun p => p.1 :: p.2).flatten)
  /-- As `commaList`, with between `lo` and `hi` words in all. -/
  | commaRep {lo hi : Nat} {x : Vds} {v : List Kind} (ps : List (Kind × List Kind)) :
      lo - 1 ≤ ps.length → ps.length ≤ hi - 1 → Denotes m x v →
      (∀ p ∈ ps, m p.1 Sym.comma = true) → (∀ p ∈ ps, Denotes m x p.2) →
      Denotes m (.commaRep lo hi x) (v ++ (ps.map fun p => p.1 :: p.2).flatten)
  | nonEmpty {x : Vds} {w : List Kind} : w ≠ [] → Denotes m x w → Denotes m (.nonEmpty x) w

variable {m : Kind → Sym → Bool}

/-- `p.1 :: p.2` for a pair of a separator and a word, as `matches_sepBy1` and `matches_rep`
present them. -/
private theorem sep_pairs {r : Regex Sym} {ws : List (List Kind)} :
    (∀ v ∈ ws, Matches m (.cat (.sym Sym.comma) r) v) ↔
      ∃ ps : List (Kind × List Kind), ws = ps.map (fun p => p.1 :: p.2) ∧
        ∀ p ∈ ps, m p.1 Sym.comma = true ∧ Matches m r p.2 := by
  induction ws with
  | nil => exact ⟨fun _ => ⟨[], rfl, by simp⟩, fun _ => by simp⟩
  | cons v ws ih =>
    simp only [List.mem_cons, forall_eq_or_imp]
    constructor
    · rintro ⟨hv, hws⟩
      obtain ⟨_, u, rfl, hs, hu⟩ := matches_cat_iff.1 hv
      obtain ⟨k, rfl, hk⟩ := matches_sym_iff.1 hs
      obtain ⟨ps, rfl, hps⟩ := ih.1 hws
      exact ⟨(k, u) :: ps, rfl, by simp only [List.mem_cons, forall_eq_or_imp]; exact ⟨⟨hk, hu⟩, hps⟩⟩
    · rintro ⟨_ | ⟨⟨k, u⟩, ps⟩, h, hps⟩
      · simp at h
      · simp only [List.map_cons, List.cons.injEq] at h
        obtain ⟨rfl, rfl⟩ := h
        simp only [List.mem_cons, forall_eq_or_imp] at hps
        exact ⟨matches_cat_iff.2 ⟨[k], u, rfl, .sym hps.1.1, hps.1.2⟩, ih.2 ⟨ps, rfl, hps.2⟩⟩

private theorem sepBy_pairs {r : Regex Sym} {qs : List (List Kind × List Kind)}
    (h : ∀ q ∈ qs, Matches m (.sym Sym.comma) q.1 ∧ Matches m r q.2) :
    ∃ ps : List (Kind × List Kind), (qs.map fun q => q.1 ++ q.2) = ps.map (fun p => p.1 :: p.2) ∧
      ∀ p ∈ ps, m p.1 Sym.comma = true ∧ Matches m r p.2 := by
  induction qs with
  | nil => exact ⟨[], rfl, by simp⟩
  | cons q qs ih =>
    simp only [List.mem_cons, forall_eq_or_imp] at h
    obtain ⟨k, hk, hkm⟩ := matches_sym_iff.1 h.1.1
    obtain ⟨ps, hps, hm⟩ := ih h.2
    refine ⟨(k, q.2) :: ps, by simp [hk, hps], ?_⟩
    simp only [List.mem_cons, forall_eq_or_imp]
    exact ⟨⟨hkm, h.1.2⟩, hm⟩

/-- The translation is faithful: a regular expression matches exactly what its term denotes. -/
theorem matches_toRegex_iff {e : Vds} {w : List Kind} :
    Matches m (toRegex e) w ↔ Denotes m e w := by
  induction e using ind generalizing w with
  | atom s =>
    simp only [toRegex, matches_sym_iff]
    constructor
    · rintro ⟨k, rfl, hk⟩; exact .atom hk
    · intro h; cases h with | atom hk => exact ⟨_, rfl, hk⟩
  | seq xs ih =>
    simp only [toRegex]
    induction xs generalizing w with
    | nil =>
      simp only [toRegexList, Regex.seq, List.foldr_nil, matches_eps_iff]
      exact ⟨fun h => h ▸ .seqNil, fun h => by cases h; rfl⟩
    | cons x xs ihs =>
      simp only [toRegexList, Regex.seq, List.foldr_cons] at ihs ⊢
      have ihx := @ih x (by simp)
      have ihs : ∀ {w}, Matches m (List.foldr cat eps (toRegexList xs)) w ↔ Denotes m (.seq xs) w :=
        ihs (fun y hy => ih y (by simp [hy]))
      rw [matches_cat_iff]
      constructor
      · rintro ⟨u, v, rfl, hu, hv⟩; exact .seqCons (ihx.1 hu) (ihs.1 hv)
      · intro h; cases h with | seqCons hu hv => exact ⟨_, _, rfl, ihx.2 hu, ihs.2 hv⟩
  | oneOf xs ih =>
    simp only [toRegex, toRegexList_eq, matches_oneOf, List.mem_map]
    constructor
    · rintro ⟨_, ⟨x, hx, rfl⟩, h⟩; exact .oneOf hx ((ih x hx).1 h)
    · intro h; cases h with | oneOf hx h => exact ⟨_, ⟨_, hx, rfl⟩, (ih _ hx).2 h⟩
  | allOf xs ih =>
    simp only [toRegex, toRegexList_eq, matches_allOf_map]
    constructor
    · rintro ⟨ps, hps, hm, rfl⟩
      exact .allOf ps hps fun p hp => (ih p.1 (hps.subset (List.mem_map_of_mem hp))).1 (hm p hp)
    · intro h
      cases h with
      | allOf ps hps hm =>
        exact ⟨ps, hps, fun p hp => (ih p.1 (hps.subset (List.mem_map_of_mem hp))).2 (hm p hp), rfl⟩
  | someOf xs ih =>
    simp only [toRegex, toRegexList_eq, Regex.someOf, List.map_map, matches_nonEmpty_iff,
      matches_allOf_map, Function.comp_def, matches_opt]
    constructor
    · rintro ⟨hne, ps, hps, hm, rfl⟩
      exact .someOf ps hps (fun p hp hne => ((hm p hp).resolve_left hne |>
        (ih p.1 (hps.subset (List.mem_map_of_mem hp))).1)) hne
    · intro h
      cases h with
      | someOf ps hps hm hne =>
        refine ⟨hne, ps, hps, fun p hp => ?_, rfl⟩
        by_cases he : p.2 = []
        · exact .inl he
        · exact .inr ((ih p.1 (hps.subset (List.mem_map_of_mem hp))).2 (hm p hp he))
  | opt x ih =>
    simp only [toRegex, matches_opt, ih]
    constructor
    · rintro (rfl | h)
      · exact .optNone
      · exact .optSome h
    · intro h; cases h with
      | optNone => exact .inl rfl
      | optSome h => exact .inr h
  | star x ih =>
    simp only [toRegex, matches_star_iff_flatten]
    constructor
    · rintro ⟨ws, hws, rfl⟩; exact .star ws fun v hv => ih.1 (hws v hv)
    · intro h; cases h with | star ws hws => exact ⟨ws, fun v hv => ih.2 (hws v hv), rfl⟩
  | plus x ih =>
    simp only [toRegex, matches_plus]
    constructor
    · rintro ⟨ws, hne, hws, rfl⟩; exact .plus ws hne fun v hv => ih.1 (hws v hv)
    · intro h; cases h with | plus ws hne hws => exact ⟨ws, hne, fun v hv => ih.2 (hws v hv), rfl⟩
  | rep lo hi x ih =>
    simp only [toRegex, matches_rep]
    constructor
    · rintro ⟨ws, hlo, hhi, hws, rfl⟩; exact .rep ws hlo hhi fun v hv => ih.1 (hws v hv)
    · intro h
      cases h with | rep ws hlo hhi hws => exact ⟨ws, hlo, hhi, fun v hv => ih.2 (hws v hv), rfl⟩
  | atLeast lo x ih =>
    simp only [toRegex, matches_atLeast]
    constructor
    · rintro ⟨ws, hlo, hws, rfl⟩; exact .atLeast ws hlo fun v hv => ih.1 (hws v hv)
    · intro h
      cases h with | atLeast ws hlo hws => exact ⟨ws, hlo, fun v hv => ih.2 (hws v hv), rfl⟩
  | commaList x ih =>
    simp only [toRegex, matches_sepBy1]
    constructor
    · rintro ⟨v, qs, hv, hqs, rfl⟩
      obtain ⟨ps, hps, hm⟩ := sepBy_pairs hqs
      rw [hps]
      exact .commaList ps (ih.1 hv) (fun p hp => (hm p hp).1) fun p hp => ih.1 (hm p hp).2
    · intro h
      cases h with
      | commaList ps hv hseps hps =>
        refine ⟨_, ps.map fun p => ([p.1], p.2), ih.2 hv, ?_, by simp [Function.comp_def]⟩
        simp only [List.mem_map, forall_exists_index, and_imp]
        rintro _ p hp rfl
        exact ⟨.sym (hseps p hp), ih.2 (hps p hp)⟩
  | commaRep lo hi x ih =>
    simp only [toRegex]
    constructor
    · intro h
      obtain ⟨v, u, rfl, hv, hu⟩ := matches_cat_iff.1 h
      obtain ⟨ws, hlo, hhi, hws, rfl⟩ := matches_rep.1 hu
      obtain ⟨ps, rfl, hps⟩ := sep_pairs.1 hws
      simp only [List.length_map] at hlo hhi
      exact .commaRep ps hlo hhi (ih.1 hv) (fun p hp => (hps p hp).1) fun p hp => ih.1 (hps p hp).2
    · intro h
      cases h with
      | commaRep ps hlo hhi hv hseps hps =>
        refine matches_cat_iff.2 ⟨_, _, rfl, ih.2 hv, matches_rep.2 ⟨ps.map fun p => p.1 :: p.2,
          by simpa using hlo, by simpa using hhi,
          sep_pairs.2 ⟨ps, rfl, fun p hp => ⟨hseps p hp, ih.2 (hps p hp)⟩⟩, rfl⟩⟩
  | nonEmpty x ih =>
    simp only [toRegex, matches_nonEmpty_iff, ih]
    constructor
    · rintro ⟨hne, h⟩; exact .nonEmpty hne h
    · intro h; cases h with | nonEmpty hne h => exact ⟨hne, h⟩

end Vds

end CssModel
