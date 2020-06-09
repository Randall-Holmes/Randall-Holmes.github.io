(* exponential calculator for Jonny *)

(* EXP3s and SPLITCOMP are both exponential calculators.
*`2 is exponentiation. *)

(* certainly ought to have more general interest, as well *)

load "peano";

declareinfix "*`2";  (* the exponential operator *)

axiom "EQ_COMP" "?x=!?y" "(Nat:?x)=Nat:?y";

axiom "EXP0" "?x*`2 0" "1";

axiom "EXP1" "?x*`2 1" "Nat:?x";

axiom "EXP2" "?x*`2 ?y+?z" "(?x*`2 ?y)*?x*`2 ?z";

(*

EXP3:  

?x *`2  1 + ?y  =  

?x * ?x *`2  ?y

EXP1 , EXP2 , TIMESTYPE , TYPES , 0

*)

s "?x*`2 1+?y";
ri "EXP2"; ex();
ri "LEFT@EXP1"; ex();
ri "TREMLEFT@TIMESTYPE"; ex();
p "EXP3";

(* utility for converting a numeral to the form Nat:?n *)

s "?n";
ri "PCASEINTRO@?n=Nat:?n"; ri "PIVOT"; ex();
left(); right(); rri "PLUSID"; ri "PLUSCOMP"; ex();
up(); ri "REFLEX";
top(); ri "LEFT@RIGHT@($PLUSCOMP)**PLUSID"; ri "REVPIVOT"; rri "CASEINTRO";
p "TYPENUMERAL";

(* utility for converting a numeral to the form 1+?x *)

s "Nat:?n";
ri "PCASEINTRO@(Nat:?n)=1+?n-1"; ri "PIVOT"; ex();
left(); right(); ri "TADDTOP@PLUSTYPE"; ex();
up(); rri "EQ_COMP"; ex();
ri "EVERYWHERE@PLUSCOMP**MINUSCOMP"; ex();
top(); drls "MINUSCOMP"; ri "MINUSCOMP"; ex();
p "MAKESUCC0";

s "?n";
ri "TYPENUMERAL";
ri "MAKESUCC0";
p "MAKESUCC";

dpt "EXP3s";

s "?x*`2 ?y";
ri "(RIGHT@MAKESUCC)**EXP3";
ri "(RIGHT@ $ZERONAT)**EXP0";
ri "RIGHT@EXP3s";
ri "TIMESCOMP";
p "EXP3s";

(* further project: develop a tactic for splitting a number into
x + x or x+x+1 and use EXP2 instead of EXP3; this should be faster *)

(* axiom capturing builtin div and mod functions *)

axiom "DIVMOD" "Nat:?n" "((?n/!?m)*?m)+?n%!?m";

s "Nat:?n";
ri "(!@DIVMOD)@2"; ex();
left(); right(); ri "MAKESUCC"; ex();
up(); ri "DIST"; ex();
ri "RL@TIMESID"; ri "TREMBOTH@PLUSTYPE"; ex();
up(); ri "PLUSASSOC"; ri "RIGHT@PLUSCOMP"; ex();
p "PLUSSPLIT0";

s "?n";
ri "TYPENUMERAL";
ri "PLUSSPLIT0";
p "PLUSSPLIT";

s "Nat:?n";
rri "PLUSID";
ri "PLUSCOMP"; ex();
rri "PLUSCOMP";
ri "PLUSID";
p "UNTYPENUMERAL";

dpt "SPLITCOMP";

s "?m^^?n";
ri "EXP0";
ari "EXP1*>UNTYPENUMERAL";
ari "(RIGHT@PLUSSPLIT)**EXP2";
ri "(RL@SPLITCOMP)**TIMESCOMP";
p "SPLITCOMP";

(* just a joke :-) *)

(* a version of the Ackermann function, implementing the whole
hierarchy of ridiculous operations *)

declareinfix "+++";

axiom "ACK1" "?m+++0,?n" "?m+?n";

axiom "ACK2" "?m+++1,0" "0";

axiom "ACK3" "?m+++(?n+2),0" "1";

axiom "ACK4" "?m+++(?n+1),?p+1" "?m+++?n,?m+++(?n+1),?p";

(* should I complete the joke and fix this up with a calculator? *)

quit();
