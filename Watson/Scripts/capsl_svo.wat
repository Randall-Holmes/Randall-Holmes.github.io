(* mark2 representation of CAPSL *)
(* Implementation of modal logic *)
(* This file contains axioms from SVO paper *)



script "capsl_capstuff";




(*axioms from paper *)

axiom "AXIOM_01" "(((?P `BELIEVES (?si)) & (?P `BELIEVES ((?si) -> (?delta)))) -> (?P `BELIEVES (?delta)))" "true";

axiom "AXIOM_02" "((?P `BELIEVES ?si) -> (?P `BELIEVES (?P `BELIEVES ?si)))" "true"; 

a "AXIOM_03A" "(((shared_key@(?P,?Q,?k)) & (?R `RECEIVED_FROM (?Q,(?k `se ?x)))) -> ((?Q `SAID ?x) & (?Q `SEES ?k)))" "true";

a "AXIOM_03B" "(((shared_key@(?P,?Q,?k)) & (?R `RECEIVED_FROM (?Q,(?k `se ?x)))) -> ((?Q `SAID ?x) & (?Q `SEES ?k)))" "true";

axiom "AXIOM_04" "((pks@?Q,?k) & (?R `RECEIVED ?x) & (sv@?x,?k,?y)) -> ?Q `SAID ?y" "true";

axiom "AXIOM_7A" "(?P `RECEIVED (?x,?y)) -> (?P `RECEIVED ?x)" "true";

axiom "AXIOM_7B" "(?P `RECEIVED (?x,?y)) -> (?P `RECEIVED ?y)" "true";

(* HOLMES:  2 additional axioms for analysis of composite messages
with known senders *)

axiom "AXIOM_7C" "(?P `RECEIVED_FROM (?z,?x,?y)) -> (?P `RECEIVED_FROM ?z,?x)" "true";

axiom "AXIOM_7D" "(?P `RECEIVED_FROM (?z,?x,?y)) -> (?P `RECEIVED_FROM ?z,?y)" "true";


axiom "AXIOM_08" "(((keypair@?pk,?sk) -> (?P `RECEIVED (?pk `pe ?x)) & (?P `SEES `INV(Pkey:?pk))) -> (?P `RECEIVED ?x))" "true";

a "AXIOM_09" "(?P `RECEIVED (?sk `pe ?x)) -> (?P `RECEIVED ?x)" "true";

a "AXIOM_10" "((?P `RECEIVED ?x) ->( ?P `SEES ?x))" "true";


a "AXIOM_11A" "(?P `SEES (?x,?y)) -> (?P `SEES ?x)" "true";

a "AXIOM_11B" "(?P `SEES (?x,?y)) -> (?P `SEES ?y)" "true";

(*  axiom12 needs function declaration *)

(*  axiom13 needs function declaration *)

a "AXIOM_14A" "(?P `SAID (?x,?y)) -> ((?P `SAID ?x) & (?P `SEES ?x))" "true";

a "AXIOM_14B" "(?P `SAID (?x,?y)) -> ((?P `SAID ?y) & (?P `SEES ?y))" "true";

axiom "AXIOM_15A" "(?P `SAYS (?x,?y)) -> ((?P `SAID (?x,?y)) & (?P `SAYS ?x))" "true";

axiom "AXIOM_15B" "(?P `SAYS (?x,?y)) -> ((?P `SAID (?x,?y)) & (?P `SAYS ?y))" "true";

axiom "AXIOM_16" "(((?P `CONTROLS ?si) & (?P `SAYS ?si)) -> ?si)" "true";

axiom "AXIOM_17A" "(Fresh@(?x)) -> (Fresh@(?x,?y))" "true";

axiom "AXIOM_17B" "(Fresh@(?y)) -> (Fresh@(?x,?y))" "true";

(* axiom18 needs function declaration *)

axiom "AXIOM_19" "((Fresh@?x) & (?P `SAID ?x)) -> (?P `SAYS ?x)" "true";

axiom "AXIOM_20" "shared_key@?x,?y,?k" "shared_key@?y,?x,?k";

quit();



