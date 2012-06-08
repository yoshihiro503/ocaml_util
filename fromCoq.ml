type ('a, 'b) sum =
| Inl of 'a
| Inr of 'b

(** val id : 'a1 -> 'a1 **)

let id x =
  x

(** val const : 'a1 -> 'a2 -> 'a1 **)

let const x x0 =
  x

