include String (* the original *)

let of_list cs =
  let s = String.create (List.length cs) in
  let _ = List.fold_left (fun i c -> String.set s i c; succ i) 0 cs in
  s

let to_list s =
  let len = String.length s in
  let rec iter i =
    if i >= len then []
    else s.[i] :: iter (i+1)
  in 
  iter 0
    
