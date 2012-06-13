open Datatypes
open Specif

type __ = Obj.t
let __ = let rec f _ = Obj.repr f in Obj.repr f

(** val hd : 'a1 -> 'a1 list -> 'a1 **)

let hd default = function
| Coq_nil -> default
| Coq_cons (x, l0) -> x

(** val hd_error : 'a1 list -> 'a1 option **)

let hd_error = function
| Coq_nil -> error
| Coq_cons (x, l0) -> value x

(** val tl : 'a1 list -> 'a1 list **)

let tl = function
| Coq_nil -> Coq_nil
| Coq_cons (a, m) -> m

(** val destruct_list : 'a1 list -> ('a1, 'a1 list) sigT sumor **)

let destruct_list = function
| Coq_nil -> Coq_inright
| Coq_cons (y, l0) -> Coq_inleft (Coq_existT (y, l0))

(** val in_dec : ('a1 -> 'a1 -> sumbool) -> 'a1 -> 'a1 list -> sumbool **)

let rec in_dec h a = function
| Coq_nil -> Coq_right
| Coq_cons (y, l0) ->
  let s = h y a in
  (match s with
   | Coq_left -> Coq_left
   | Coq_right -> in_dec h a l0)

(** val nth : nat -> 'a1 list -> 'a1 -> 'a1 **)

let rec nth n l default =
  match n with
  | O ->
    (match l with
     | Coq_nil -> default
     | Coq_cons (x, l') -> x)
  | S m ->
    (match l with
     | Coq_nil -> default
     | Coq_cons (x, t) -> nth m t default)

(** val nth_ok : nat -> 'a1 list -> 'a1 -> bool **)

let rec nth_ok n l default =
  match n with
  | O ->
    (match l with
     | Coq_nil -> Coq_false
     | Coq_cons (x, l') -> Coq_true)
  | S m ->
    (match l with
     | Coq_nil -> Coq_false
     | Coq_cons (x, t) -> nth_ok m t default)

(** val nth_in_or_default : nat -> 'a1 list -> 'a1 -> sumbool **)

let rec nth_in_or_default n l d =
  match l with
  | Coq_nil -> Coq_right
  | Coq_cons (y, l0) ->
    (match n with
     | O -> Coq_left
     | S n1 -> nth_in_or_default n1 l0 d)

(** val nth_error : 'a1 list -> nat -> 'a1 coq_Exc **)

let rec nth_error l = function
| O ->
  (match l with
   | Coq_nil -> error
   | Coq_cons (x, l0) -> value x)
| S n0 ->
  (match l with
   | Coq_nil -> error
   | Coq_cons (a, l0) -> nth_error l0 n0)

(** val nth_default : 'a1 -> 'a1 list -> nat -> 'a1 **)

let nth_default default l n =
  match nth_error l n with
  | Some x -> x
  | None -> default

(** val remove : ('a1 -> 'a1 -> sumbool) -> 'a1 -> 'a1 list -> 'a1 list **)

let rec remove eq_dec x = function
| Coq_nil -> Coq_nil
| Coq_cons (y, tl0) ->
  (match eq_dec x y with
   | Coq_left -> remove eq_dec x tl0
   | Coq_right -> Coq_cons (y, (remove eq_dec x tl0)))

(** val last : 'a1 list -> 'a1 -> 'a1 **)

let rec last l d =
  match l with
  | Coq_nil -> d
  | Coq_cons (a, l0) ->
    (match l0 with
     | Coq_nil -> a
     | Coq_cons (a0, l1) -> last l0 d)

(** val removelast : 'a1 list -> 'a1 list **)

let rec removelast = function
| Coq_nil -> Coq_nil
| Coq_cons (a, l0) ->
  (match l0 with
   | Coq_nil -> Coq_nil
   | Coq_cons (a0, l1) -> Coq_cons (a, (removelast l0)))

(** val exists_last : 'a1 list -> ('a1 list, 'a1) sigT **)

let rec exists_last = function
| Coq_nil -> assert false (* absurd case *)
| Coq_cons (y, l0) ->
  (match l0 with
   | Coq_nil -> Coq_existT (Coq_nil, y)
   | Coq_cons (a0, l1) ->
     let Coq_existT (l', s) = exists_last l0 in
     Coq_existT ((Coq_cons (y, l')), s))

(** val count_occ : ('a1 -> 'a1 -> sumbool) -> 'a1 list -> 'a1 -> nat **)

let rec count_occ eq_dec l x =
  match l with
  | Coq_nil -> O
  | Coq_cons (y, tl0) ->
    let n = count_occ eq_dec tl0 x in
    (match eq_dec y x with
     | Coq_left -> S n
     | Coq_right -> n)

(** val rev : 'a1 list -> 'a1 list **)

let rec rev = function
| Coq_nil -> Coq_nil
| Coq_cons (x, l') -> app (rev l') (Coq_cons (x, Coq_nil))

(** val rev_append : 'a1 list -> 'a1 list -> 'a1 list **)

let rec rev_append l l' =
  match l with
  | Coq_nil -> l'
  | Coq_cons (a, l0) -> rev_append l0 (Coq_cons (a, l'))

(** val rev' : 'a1 list -> 'a1 list **)

let rev' l =
  rev_append l Coq_nil

(** val list_eq_dec :
    ('a1 -> 'a1 -> sumbool) -> 'a1 list -> 'a1 list -> sumbool **)

let rec list_eq_dec eq_dec l l' =
  match l with
  | Coq_nil ->
    (match l' with
     | Coq_nil -> Coq_left
     | Coq_cons (y, l'0) -> Coq_right)
  | Coq_cons (y, l0) ->
    (match l' with
     | Coq_nil -> Coq_right
     | Coq_cons (y0, l'0) ->
       let s = eq_dec y y0 in
       (match s with
        | Coq_left -> list_eq_dec eq_dec l0 l'0
        | Coq_right -> Coq_right))

(** val map : ('a1 -> 'a2) -> 'a1 list -> 'a2 list **)

let rec map f = function
| Coq_nil -> Coq_nil
| Coq_cons (a, t) -> Coq_cons ((f a), (map f t))

(** val flat_map : ('a1 -> 'a2 list) -> 'a1 list -> 'a2 list **)

let rec flat_map f = function
| Coq_nil -> Coq_nil
| Coq_cons (x, t) -> app (f x) (flat_map f t)

(** val fold_left : ('a1 -> 'a2 -> 'a1) -> 'a2 list -> 'a1 -> 'a1 **)

let rec fold_left f l a0 =
  match l with
  | Coq_nil -> a0
  | Coq_cons (b, t) -> fold_left f t (f a0 b)

(** val fold_right : ('a2 -> 'a1 -> 'a1) -> 'a1 -> 'a2 list -> 'a1 **)

let rec fold_right f a0 = function
| Coq_nil -> a0
| Coq_cons (b, t) -> f b (fold_right f a0 t)

(** val list_power : 'a1 list -> 'a2 list -> ('a1, 'a2) prod list list **)

let rec list_power l l' =
  match l with
  | Coq_nil -> Coq_cons (Coq_nil, Coq_nil)
  | Coq_cons (x, t) ->
    flat_map (fun f -> map (fun y -> Coq_cons ((Coq_pair (x, y)), f)) l')
      (list_power t l')

(** val existsb : ('a1 -> bool) -> 'a1 list -> bool **)

let rec existsb f = function
| Coq_nil -> Coq_false
| Coq_cons (a, l0) ->
  (match f a with
   | Coq_true -> Coq_true
   | Coq_false -> existsb f l0)

(** val forallb : ('a1 -> bool) -> 'a1 list -> bool **)

let rec forallb f = function
| Coq_nil -> Coq_true
| Coq_cons (a, l0) ->
  (match f a with
   | Coq_true -> forallb f l0
   | Coq_false -> Coq_false)

(** val filter : ('a1 -> bool) -> 'a1 list -> 'a1 list **)

let rec filter f = function
| Coq_nil -> Coq_nil
| Coq_cons (x, l0) ->
  (match f x with
   | Coq_true -> Coq_cons (x, (filter f l0))
   | Coq_false -> filter f l0)

(** val find : ('a1 -> bool) -> 'a1 list -> 'a1 option **)

let rec find f = function
| Coq_nil -> None
| Coq_cons (x, tl0) ->
  (match f x with
   | Coq_true -> Some x
   | Coq_false -> find f tl0)

(** val partition :
    ('a1 -> bool) -> 'a1 list -> ('a1 list, 'a1 list) prod **)

let rec partition f = function
| Coq_nil -> Coq_pair (Coq_nil, Coq_nil)
| Coq_cons (x, tl0) ->
  let Coq_pair (g, d) = partition f tl0 in
  (match f x with
   | Coq_true -> Coq_pair ((Coq_cons (x, g)), d)
   | Coq_false -> Coq_pair (g, (Coq_cons (x, d))))

(** val split : ('a1, 'a2) prod list -> ('a1 list, 'a2 list) prod **)

let rec split = function
| Coq_nil -> Coq_pair (Coq_nil, Coq_nil)
| Coq_cons (p, tl0) ->
  let Coq_pair (x, y) = p in
  let Coq_pair (g, d) = split tl0 in
  Coq_pair ((Coq_cons (x, g)), (Coq_cons (y, d)))

(** val combine : 'a1 list -> 'a2 list -> ('a1, 'a2) prod list **)

let rec combine l l' =
  match l with
  | Coq_nil -> Coq_nil
  | Coq_cons (x, tl0) ->
    (match l' with
     | Coq_nil -> Coq_nil
     | Coq_cons (y, tl') -> Coq_cons ((Coq_pair (x, y)), (combine tl0 tl')))

(** val list_prod : 'a1 list -> 'a2 list -> ('a1, 'a2) prod list **)

let rec list_prod l l' =
  match l with
  | Coq_nil -> Coq_nil
  | Coq_cons (x, t) ->
    app (map (fun y -> Coq_pair (x, y)) l') (list_prod t l')

(** val firstn : nat -> 'a1 list -> 'a1 list **)

let rec firstn n l =
  match n with
  | O -> Coq_nil
  | S n0 ->
    (match l with
     | Coq_nil -> Coq_nil
     | Coq_cons (a, l0) -> Coq_cons (a, (firstn n0 l0)))

(** val skipn : nat -> 'a1 list -> 'a1 list **)

let rec skipn n l =
  match n with
  | O -> l
  | S n0 ->
    (match l with
     | Coq_nil -> Coq_nil
     | Coq_cons (a, l0) -> skipn n0 l0)

(** val seq : nat -> nat -> nat list **)

let rec seq start = function
| O -> Coq_nil
| S len0 -> Coq_cons (start, (seq (S start) len0))

(** val coq_Forall_rect :
    'a2 -> ('a1 -> 'a1 list -> __ -> 'a2) -> 'a1 list -> 'a2 **)

let coq_Forall_rect h h' = function
| Coq_nil -> h
| Coq_cons (y, l0) -> h' y l0 __

