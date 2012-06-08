open Datatypes

type 'a t = ('a, exn) sum

(** val map : ('a1 -> 'a2) -> 'a1 t -> 'a2 t **)

let map f = function
| Coq_inl x -> Coq_inl (f x)
| Coq_inr e -> Coq_inr e

(** val get_or_else : 'a1 -> 'a1 t -> 'a1 **)

let get_or_else default = function
| Coq_inl x -> x
| Coq_inr e -> default

(** val dmap : 'a2 -> ('a1 -> 'a2) -> 'a1 t -> 'a2 **)

let dmap default f = function
| Coq_inl x -> f x
| Coq_inr e -> default

