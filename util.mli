include module type of FromCoq

val (@@) : ('a -> 'b) -> 'a -> 'b
val ($) : ('b -> 'c) -> ('a -> 'b) -> ('a -> 'c)
val (|>) : 'a -> ('a -> 'b) -> 'b
val println : string -> unit
val tee : ('a -> 'b) -> 'a -> 'a
