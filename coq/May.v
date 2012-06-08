Parameter exn : Set.
Extract Inlined Constant exn => "exn".

Definition t (A : Set): Set := sum A exn.

Definition map {A B:Set} (f : A -> B) (m : t A) : t B :=
  match m with
    | inl x => inl _ (f x)
    | inr e => inr _ e
  end.

Definition get_or_else {A : Set} (default : A) (m : t A) : A :=
  match m with
    | inl x => x
    | inr _ => default
  end.

Definition dmap {A B:Set} (default : B) (f : A -> B) (m : t A) : B :=
  match m with
    | inl x => f x
    | inr _ => default
  end.

Lemma dmap_map_get_or_else : forall (A B:Set) (default : B) (f: A -> B) (m : t A),
  dmap default f m = get_or_else default (map f m).
Proof.
  intros. case m; auto.
Qed.
