open Datatypes

type 'a t = ('a, exn) sum

val map : ('a1 -> 'a2) -> 'a1 t -> 'a2 t

val get_or_else : 'a1 -> 'a1 t -> 'a1

val dmap : 'a2 -> ('a1 -> 'a2) -> 'a1 t -> 'a2

