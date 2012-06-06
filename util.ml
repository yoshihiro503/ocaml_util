include FromCoq

let ( @@ ) f x = f x
let ($) g f = fun x -> g (f x)
let (|>) x f = f x
let println = print_endline
let tee f x = ignore (f x); x
