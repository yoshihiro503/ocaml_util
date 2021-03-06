include module type of FromCoq

val (@@) : ('a -> 'b) -> 'a -> 'b
val ($) : ('b -> 'c) -> ('a -> 'b) -> ('a -> 'c)
val (|>) : 'a -> ('a -> 'b) -> 'b
val println : string -> unit
val tee : ('a -> 'b) -> 'a -> 'a
val (!%) : ('a, unit, string) format -> 'a
val slist : string -> ('a -> string) -> 'a list -> string

type 'a may = 'a May.t
val may : ('a -> 'b) -> 'a -> ('b, exn) sum
  
val using : 'a -> ('a -> unit) -> ('a -> 'b) -> 'b
val using_in : in_channel -> (in_channel -> 'a) -> 'a
val using_out : out_channel -> (out_channel -> 'a) -> 'a

