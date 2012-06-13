open Datatypes
open Specif

type __ = Obj.t

val hd : 'a1 -> 'a1 list -> 'a1

val hd_error : 'a1 list -> 'a1 option

val tl : 'a1 list -> 'a1 list

val destruct_list : 'a1 list -> ('a1, 'a1 list) sigT sumor

val in_dec : ('a1 -> 'a1 -> sumbool) -> 'a1 -> 'a1 list -> sumbool

val nth : nat -> 'a1 list -> 'a1 -> 'a1

val nth_ok : nat -> 'a1 list -> 'a1 -> bool

val nth_in_or_default : nat -> 'a1 list -> 'a1 -> sumbool

val nth_error : 'a1 list -> nat -> 'a1 coq_Exc

val nth_default : 'a1 -> 'a1 list -> nat -> 'a1

val remove : ('a1 -> 'a1 -> sumbool) -> 'a1 -> 'a1 list -> 'a1 list

val last : 'a1 list -> 'a1 -> 'a1

val removelast : 'a1 list -> 'a1 list

val exists_last : 'a1 list -> ('a1 list, 'a1) sigT

val count_occ : ('a1 -> 'a1 -> sumbool) -> 'a1 list -> 'a1 -> nat

val rev : 'a1 list -> 'a1 list

val rev_append : 'a1 list -> 'a1 list -> 'a1 list

val rev' : 'a1 list -> 'a1 list

val list_eq_dec : ('a1 -> 'a1 -> sumbool) -> 'a1 list -> 'a1 list -> sumbool

val map : ('a1 -> 'a2) -> 'a1 list -> 'a2 list

val flat_map : ('a1 -> 'a2 list) -> 'a1 list -> 'a2 list

val fold_left : ('a1 -> 'a2 -> 'a1) -> 'a2 list -> 'a1 -> 'a1

val fold_right : ('a2 -> 'a1 -> 'a1) -> 'a1 -> 'a2 list -> 'a1

val list_power : 'a1 list -> 'a2 list -> ('a1, 'a2) prod list list

val existsb : ('a1 -> bool) -> 'a1 list -> bool

val forallb : ('a1 -> bool) -> 'a1 list -> bool

val filter : ('a1 -> bool) -> 'a1 list -> 'a1 list

val find : ('a1 -> bool) -> 'a1 list -> 'a1 option

val partition : ('a1 -> bool) -> 'a1 list -> ('a1 list, 'a1 list) prod

val split : ('a1, 'a2) prod list -> ('a1 list, 'a2 list) prod

val combine : 'a1 list -> 'a2 list -> ('a1, 'a2) prod list

val list_prod : 'a1 list -> 'a2 list -> ('a1, 'a2) prod list

val firstn : nat -> 'a1 list -> 'a1 list

val skipn : nat -> 'a1 list -> 'a1 list

val seq : nat -> nat -> nat list

val coq_Forall_rect :
  'a2 -> ('a1 -> 'a1 list -> __ -> 'a2) -> 'a1 list -> 'a2

