Definition const {A B:Set} (x:A) := fun (_:B) => x. 

Extraction Language Ocaml.
Extraction "fromCoq" id const.
