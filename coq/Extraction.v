Require Import Util.
Require May CoqList CoqStreams.

Extraction Language Ocaml.
Extraction "fromCoq" id const sum.
Recursive Extraction Library May.
Recursive Extraction Library CoqList.
Recursive Extraction Library CoqStreams.
