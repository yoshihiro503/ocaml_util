include FromCoq

let ( @@ ) f x = f x
let ($) g f = fun x -> g (f x)
let (|>) x f = f x
let println = print_endline
let tee f x = ignore (f x); x
let (!%) = Printf.sprintf
let slist delim f xs = String.concat delim @@ List.map f xs

type 'a may = 'a May.t
let may f x = try Inl (f x) with e -> Inr e
  
let using x close f =
  let res = may f x in
  close x;
  match res with
  | Inl x -> x
  | Inr e -> raise e

let using_in ch  f = using ch close_in f
let using_out ch f = using ch close_out f
  
