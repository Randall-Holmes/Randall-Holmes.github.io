(* version of June 4, 1999 -- restored natural treatment of
recursive tactics.  May 26 version of Watson needed for this to work well.

June 4 update is addtion of continued fraction construction for irrationals,
plus integration into the omnibus theory
 *)

(* some proofs in this file will not work without Watson dated
at least May 18, 1999, when a bug was fixed *)

(* file for development of computations with integers and rationals *)

(* incremental development of typing algorithms is being added *)

(* a possibly distracting fact is that all of the components of
the mutually recursive algorithms are defined with parameters instead
the explicit recursive calls one might expect; this is because
the dependency updating features of the prover take an extremely long
time to handle tactics with complex mutual recursions; I hope to
solve this problem by examination of the code *)

script "natorder";

dpt "MAKEREAL";  (* add real type label *)

dpt "HIDEREAL";  (* remove real type label *)

dpt "MAKENAT";   (* add natural type label *)

dpt "HIDENAT";   (* remove natural type label *)

(* a utility *)

(* TYPECONTROL@t,thm applies theorem thm just in case the target
term is of the form t:?x *)

s "?t:?x";
ri "?thm";
p "TYPECONTROL@?t,?thm";

(* this theorem does nothing but applies only to terms
with a given type label; this can be used with =>> and <<=
to prevent the application of theorems to terms with a certain type *)

s "?t:?x";
p "TYPETRIV@?t";

(* reals are (at the outset) natural numbers plus sums, products,
quotients, and differences *)

(* development of tactic MAKEREAL which will attach a Real: type label
to a term if it can infer that this is correct and tactic HIDEREAL which
will remove a Real: type label if it can infer that this is correct.
These tactics are mutually recursive with many subtactics covering terms
of different forms.  They look ahead to tactics MAKENAT and HIDENAT
which do the same thing for natural numbers. *)

(* it is worth noting that one could readily add the ability to type
case expressions to all these algorithms; use UNEVAL_TAC and
ANTI_UNEVAL_TAC *)

s "Real:?x";
right(); ri "HIDEREAL";
p "MAKEREAL_REAL";

s "Nat:?x";
ri "REALNAT"; ex();
right(); ri "HIDENAT";
p "MAKEREAL_NAT";

s "?x+?y";
ri "TADDTOP@PLUSTYPE"; ex();
right(); right(); ri "HIDEREAL";
up(); left(); ri "HIDEREAL";
p "MAKEREAL_PLUS";

s "?x*?y";
ri "TADDTOP@TIMESTYPE"; ex();
right(); right(); ri "HIDEREAL";
up(); left(); ri "HIDEREAL";
p "MAKEREAL_TIMES";

s "?x-?y";
ri "TADDTOP@MINUSTYPE"; ex();
right(); right(); ri "HIDEREAL";
up(); left(); ri "HIDEREAL";
p "MAKEREAL_MINUS";

s "?x/?y";
ri "TADDTOP@DIVTYPE"; ex();
right(); right(); ri "HIDEREAL";
up(); left(); ri "HIDEREAL";
p "MAKEREAL_DIV";

s "?x";
ri "MAKEREAL_REAL";
ari "MAKEREAL_PLUS";
ari "MAKEREAL_MINUS";
ari "MAKEREAL_TIMES";
ari "MAKEREAL_DIV";
ri "MAKENAT";
ri "MAKEREAL_NAT";
p "MAKEREAL";

s "Real:Real:?x";
ri "TYPES"; ex();
ri "HIDEREAL";
p "HIDEREAL_REAL";

s "Real:Nat:?x";
rri "REALNAT"; ex();
ri "HIDENAT";
p "HIDEREAL_NAT";

s "Real:?x+?y";
ri "TREMTOP@PLUSTYPE"; ex();
right(); ri "HIDEREAL";
up(); left(); ri "HIDEREAL";
p "HIDEREAL_PLUS";

s "Real:?x-?y";
ri "TREMTOP@MINUSTYPE"; ex();
right(); ri "HIDEREAL";
up(); left(); ri "HIDEREAL";
p "HIDEREAL_MINUS";

s "Real:?x*?y";
ri "TREMTOP@TIMESTYPE"; ex();
right(); ri "HIDEREAL";
up(); left(); ri "HIDEREAL";
p "HIDEREAL_TIMES";

s "Real:?x/?y";
ri "TREMTOP@DIVTYPE"; ex();
right(); ri "HIDEREAL";
up(); left(); ri "HIDEREAL";
p "HIDEREAL_DIV";

s "Real:?x";
right(); ri "MAKENAT";
top();
ri "HIDEREAL_REAL";
ri "HIDEREAL_NAT";
ari "HIDEREAL_PLUS";
ari "HIDEREAL_MINUS";
ari "HIDEREAL_TIMES";
ari "HIDEREAL_DIV";
p "HIDEREAL";

(* tactics MAKENAT and HIDENAT developed below are analogous to 
MAKEREAL and HIDEREAL for the Nat: type label *)

(* natural numbers are numerals, and also sums and products of natural
numbers *)

(* we will use TYPENUMERAL from algebra2.wat to type numerals as
naturals and BUILTIN to untype them *)

s "Nat:?x";
right(); ri "HIDENAT";
p "MAKENAT_NAT";

s "?x+?y";
right(); ri "MAKENAT";
up(); left(); ri "MAKENAT";
top(); ri "PLUSTYPE2";
ri "TYPECONTROL@Nat,RIGHT@RL@HIDENAT";
ari "RL@HIDENAT";
p "MAKENAT_PLUS";

s "?x*?y";
right(); ri "MAKENAT";
up(); left(); ri "MAKENAT";
top(); ri "TIMESTYPE2";
ri "TYPECONTROL@Nat,RIGHT@RL@HIDENAT";
ari "RL@HIDENAT";
p "MAKENAT_TIMES";

s "?x";
ri "TYPENUMERAL";
ri "TYPETRIV@Nat";
ri "MAKENAT_NAT";
ari "MAKENAT_PLUS";
ari "MAKENAT_TIMES";
p "MAKENAT";

s "Nat:Nat:?x";
ri "TYPES"; ex();
ri "HIDENAT";
p "HIDENAT_NAT";

s "Nat:?x+?y";
right(); right(); ri "MAKENAT";
up(); left(); ri "MAKENAT";
top(); rri "PLUSTYPE2";
ri "TYPECONTROL@Nat,RIGHT@RL@HIDENAT";
ari "RL@HIDENAT";
p "HIDENAT_PLUS";

s "Nat:?x*?y";
right(); right(); ri "MAKENAT";
up(); left(); ri "MAKENAT";
top(); rri "TIMESTYPE2";
ri "TYPECONTROL@Nat,RIGHT@RL@HIDENAT";
ari "RL@HIDENAT";
p "HIDENAT_TIMES";

s "Nat:?x";
rri "BUILTIN";
ri "BUILTIN";
ri "HIDENAT_NAT@HIDENAT";
ari "HIDENAT_PLUS";
ari "HIDENAT_TIMES";
p "HIDENAT";

(* development of integer type *)

(* retraction theorem for integer type *)

(*

INTRETRACT:  

(?x = Nat : ?x) || (Nat : ?x) , - Nat : - ?x  =  

(((?x = Nat : ?x) || (Nat : ?x) , - Nat : - ?x) = Nat 
      : (?x = Nat : ?x) || (Nat : ?x) , - Nat : - ?x) 
|| (Nat : (?x = Nat : ?x) || (Nat : ?x) , - Nat : - ?x) 
   , - Nat : - (?x = Nat : ?x) || (Nat : ?x) , - Nat 
            : - ?x

CASEINTRO , COMP_NAT , COMP_PLUS , HYP , MINUSTYPE 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX 
, TYPES , 0

*)

s "(?x=Nat:?x)||(Nat:?x), -Nat: -?x";
assign "?x" "(?x=Nat:?x)||(Nat:?x), -Nat: -?x";
ri "PCASEINTRO@?x=Nat:?x"; ex();
right(); left(); ri "EVERYWHERE2@1|-|1"; ri "EVERYWHERE2@TYPES**REFLEX"; ex();
up(); right();ri "EVERYWHERE2@1|-|1"; ex();
ri "REVPIVOT"; ex();
right(); right(); right(); right(); ri "MINUSMINUS** $REALNAT"; ex();
up(); ri "TYPES"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
wb(); p "INTRETRACT";

(* definition of integer type *)

defineconstanttype "INTRETRACT" "Int:?x" "(?x=Nat:?x)||(Nat:?x), -Nat: -?x";

(* integers are a subtype of reals *)

(*

REALINT:  

Int : ?x  =  

Real : Int : ?x

CASEINTRO , COMP_NAT , COMP_PLUS , FNDIST , HYP , Int 
, MINUSTYPE , PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE 
, PM , REFLEX , TYPES , 0


*)

s "Real:Int:?x";
right(); ri "Int"; ex();
top(); ri "UNEVAL_TAC@[Real:?1]"; ex();
right(); left(); rri "REALNAT"; ex();
up(); right(); ri "TREMTOP@MINUSTYPE"; ex();
top(); rri "Int"; ex();
wb(); p "REALINT";

(* incremental work on typing algorithms *)

(* integer type algorithms to come *)

dpt "MAKEINT";

dpt "HIDEINT";

(* whenever new information relating to a type becomes available,
modifications to its typing and untyping algorithms become appropriate.
MAKEREAL and HIDEREAL need to be told that integers are reals *)

(* update the MAKEREAL tactic *)

s "Int:?x";
ri "REALINT"; ex();
right(); ri "HIDEINT";
p "MAKEREAL_INT";

s "Real:Int:?x";
rri "REALINT"; ex();
ri "HIDEINT";
p "HIDEREAL_INT";

ae "MAKEREAL";
ri "MAKEINT";
ri "MAKEREAL_INT";
autoreprove();

(* update the HIDEREAL tactic *)

ae "HIDEREAL";
downtoright "Real:?x";
right(); ri "TYPETRIV@Nat"; ari "MAKEINT";
top(); ari "HIDEREAL_INT";
autoreprove();

(* naturals are a subtype of integers *)

(*

INTNAT:  

Nat : ?x  =  

Int : Nat : ?x

CASEINTRO , COMP_NAT , COMP_PLUS , HYP , Int , MINUSTYPE 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX 
, TYPES , 0

*)

s "Int:Nat:?x";
ri "Int**EVERYWHERE2@TYPES**REFLEX"; ex();
wb(); p "INTNAT";

(* theorems on typing of operations on integers *)

(* negative integers are integers *)

(*

INTMINUSNAT:  

- Nat : ?x  =  

Int : - Nat : ?x

CASEINTRO , COMP_NAT , COMP_PLUS , HYP , Int , MINUSTYPE 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX 
, TYPES , 0

*)

s "Int: -Nat:?x";
ri "Int"; ex();
ri "REVPIVOT"; ex();
right(); right(); right(); right(); ri "MINUSMINUS** $REALNAT"; ex();
up(); ri "TYPES"; ex();
top(); rri "CASEINTRO"; ex();
wb(); p "INTMINUSNAT";

(* differences of naturals are integers *)

(*

INTDIFFNAT:  

(Nat : ?x) - Nat : ?y  =  

Int : (Nat : ?x) - Nat : ?y

CASEINTRO , COMPMINUSTYPE , COMP_MINUS , COMP_NAT 
, COMP_PLUS , FNDIST , HYP , Int , MINUSTYPE , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX , TYPES 
, 0

*)

s "(Nat:?x)-Nat:?y";
ri "COMP_MINUS"; ex();
right(); left(); ri "COMPMINUSTYPE"; ex();
ri "INTNAT"; ex();
ri "RIGHT@ $COMPMINUSTYPE"; ex();
up(); right(); ri "RIGHT@COMPMINUSTYPE"; ri "INTMINUSNAT"; 
	ri "RIGHT@RIGHT@ $COMPMINUSTYPE"; ex();
top(); ri "ANTI_UNEVAL_TAC@[Int:?1]"; ex();
ri "RIGHT@ $COMP_MINUS"; ex();
p "INTDIFFNAT";

(* addition of integers *)

s "(Int:?x)+Int:?y";
ri "RL@Int"; ex();
ri "PCASEINTRO@?x=Nat:?x"; ex();
ri "PCASEINTRO@?y=Nat:?y"; ex();
ri "EVERYWHERE2@POP_CASE"; ex();
right(); left();right(); right();
ri "PLUSCOMM** $BREAKMINUS"; ex();
top(); right(); right(); right(); left(); rri "BREAKMINUS"; ex();
up(); right(); rri "PLUSINVDIST"; ri "RIGHT@PLUSTYPE2"; ex();
top(); right(); left(); right(); left(); ri "PLUSTYPE2"; ex();

saveenv "Lemma";

top(); ri "BOTH_CASES@BOTH_CASES@INTNAT**INTMINUSNAT**INTDIFFNAT"; ex();
ri "EVERYWHERE2@ANTI_UNEVAL_TAC@[Int:?1]"; ex();
right(); applyconvenv "Lemma";
p "PLUSTYPEINT";

saveenv "backup"; dropenv "Lemma";

(* subtraction of integers *)

s "(Int:?x)-Int:?y";
ri "BREAKMINUS"; ex();
right(); right();ri "Int"; ex();
up(); ri "UNEVAL_TAC@[-?1]"; ex();
right(); left(); ri "INTMINUSNAT"; ex();
up(); right();ri "MINUSMINUS** $REALNAT"; ex();
ri "INTNAT"; ex();
right(); ri "REALNAT** $MINUSMINUS"; ex();
upto "?x||?y,?z";
ri "ANTI_UNEVAL_TAC@[Int: -?1]"; ex();
ri "RIGHT@RIGHT@ $Int"; ex();

saveenv "Lemma";

top(); ri "PLUSTYPEINT"; ex();
right(); applyconvenv "Lemma";
p "MINUSTYPEINT";

saveenv "backup"; dropenv "Lemma";

(* multiplication of integers *)

(*

TIMESTYPEINT:  

(Int : ?x) * Int : ?y  =  

Int : (Int : ?x) * Int : ?y

CASEINTRO , COMPTIMESTYPE , COMP_NAT , COMP_PLUS , COMP_TIMES 
, DIST , FNDIST , HYP , Int , MINUSTYPE , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX , TIMESCOMM 
, TIMESTYPE , TYPES , 0

*)

s "(Int:?x)*Int:?y";
ri "RL@Int"; ex();
ri "PCASEINTRO@?x=Nat:?x"; ex();
ri "PCASEINTRO@?y=Nat:?y"; ex();
ri "EVERYWHERE2@POP_CASE"; ex();
right(); left(); right(); left(); ri "TIMESTYPE2"; ex();
up(); right(); ri "TIMESCOMM**SIGNPULL**RIGHT@TIMESTYPE2"; ex();
up(); up(); up(); right(); right(); left();
	ri "SIGNPULL**RIGHT@TIMESTYPE2"; ex();
up(); right(); ri "SIGNPULL"; ex();
right(); ri "TIMESCOMM**SIGNPULL**RIGHT@TIMESTYPE2"; ex();
up(); ri "MINUSMINUS** $REALNAT"; ex();

saveenv "Lemma";

top(); ri "BOTH_CASES@BOTH_CASES@INTNAT**INTMINUSNAT"; ex();
ri "EVERYWHERE2@ANTI_UNEVAL_TAC@[Int:?1]"; ex();
right(); applyconvenv "Lemma";
p "TIMESTYPEINT";

saveenv "backup"; dropenv "Lemma";

(* development of the integer type algorithms MAKEINT and HIDEINT *)

s "Int:?x";
right(); ri "HIDEINT";
p "MAKEINT_INT";

s "?x+?y";
right(); ri "MAKEINT";
up(); left(); ri "MAKEINT";
top(); ri "PLUSTYPEINT";
ri "TYPECONTROL@Int,RIGHT@RL@HIDEINT";
ari "RL@HIDEINT";
p "MAKEINT_PLUS";

s "?x-?y";
right(); ri "MAKEINT";
up(); left(); ri "MAKEINT";
top(); ri "MINUSTYPEINT";
ri "TYPECONTROL@Int,RIGHT@RL@HIDEINT";
ari "RL@HIDEINT";
p "MAKEINT_MINUS";

s "?x*?y";
right(); ri "MAKEINT";
up(); left(); ri "MAKEINT";
top(); ri "TIMESTYPEINT";
ri "TYPECONTROL@Int,RIGHT@RL@HIDEINT";
ari "RL@HIDEINT";
p "MAKEINT_TIMES";

s "Nat:?x";
ri "INTNAT"; ex();
right(); ri "HIDENAT";
p "MAKEINT_NAT";

s "?x";

ri "MAKEINT_INT";
ari "MAKEINT_PLUS";
ari "MAKEINT_MINUS";
ari "MAKEINT_TIMES";
ri "MAKENAT";
ri "MAKEINT_NAT";
p "MAKEINT";

s "Int:Int:?x";
ri "TYPES"; ex();
ri "HIDEINT";
p "HIDEINT_INT";

s "Int:Nat:?x";
rri "INTNAT"; ri "HIDENAT";
p "HIDEINT_NAT";

s "Int:?x+?y";
right(); right(); ri "MAKEINT";
up(); left(); ri "MAKEINT";
top(); rri "PLUSTYPEINT";
ri "TYPECONTROL@Int,RIGHT@RL@HIDEINT";
ari "RL@HIDEINT";
p "HIDEINT_PLUS";

s "Int:?x*?y";
right(); right(); ri "MAKEINT";
up(); left(); ri "MAKEINT";
top(); rri "TIMESTYPEINT";
ri "TYPECONTROL@Int,RIGHT@RL@HIDEINT";
ari "RL@HIDEINT";
p "HIDEINT_TIMES";

s "Int:?x-?y";
right(); right(); ri "MAKEINT";
up(); left(); ri "MAKEINT";
top(); rri "MINUSTYPEINT";
ri "TYPECONTROL@Int,RIGHT@RL@HIDEINT";
ari "RL@HIDEINT";
p "HIDEINT_MINUS";

s "Int:?x";
right(); ri "MAKENAT";
top();
ri "HIDEINT_INT";
ri "HIDEINT_NAT";
ari "HIDEINT_PLUS";
ari "HIDEINT_TIMES";
ari "HIDEINT_MINUS";
p "HIDEINT";


(* integers are either naturals or the additive inverses of naturals *)

(*

INTPOSORNEG:  

((Int : ?x) = Nat : Int : ?x) | (- Int : ?x) = Nat 
      : - Int : ?x  =  

true

AND , BOOLDEF , CASEINTRO , COMP_NAT , COMP_PLUS , EQBOOL 
, EQUATION , FNDIST , HYP , Int , MINUSTYPE , NONTRIV 
, NOT1 , ODDCHOICE , OR , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TYPES , 0

*)

s "((Int:?x) = Nat:Int:?x)|(-Int:?x) = Nat: -Int:?x";

ri "EVERYWHERE2@Int";
ri "PCASEINTRO@?x=Nat:?x";
ri "EVERYWHERE2@POP_CASE"; ex();

right(); left(); ri "EVERYWHERE2@TYPES**REFLEX"; ri "NEWTAUT"; ex();

up(); right(); right(); 
ri "EVERYWHERE@MINUSMINUS** $REALNAT";ri "EVERYWHERE2@TYPES**REFLEX"; ex();

up(); ri "NEWTAUT"; ex();

top(); rri "CASEINTRO"; ex();

p "INTPOSORNEG";

(* development of type of rationals follows *)

(* some lemmas *)

s "(?x=?x)||?a,?b";
ri "LEFT@REFLEX"; ex();
wb(); p "TRUECASE@?x,?b";

s "0/1";
ri "TRUECASE@((0/1)*1),0"; ex();
left(); left(); ri "TIMESDIV"; ex();
right(); right(); rri "REALZERO"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "FACTORZERO"; ri "FACTORZERO"; ex();
right(); right(); ri "REALNUMERAL2"; ex();
up(); ri "ZERONOTONE"; up(); ex();
ri "DID"; rri "ASRTEQ"; ex();
right(); ri "TREMTOP@DIVTYPE"; ex();
top(); ri "REVPIVOT"; rri "CASEINTRO"; ex();
p "ZEROFRACT";

s "Int:?n";
ri "Int"; ex();
left(); right(); rri "BUILTIN";
up(); ri "REFLEX";
top(); rri "BUILTIN"; rri "Int";
p "INTNUMERAL";

(* develop a type of nonzero integers for denominators *)

(* retraction theorem *)

(*

NZINTRETRACT:  

(0 = Int : ?x) || 1 , Int : ?x  =  

(0 = Int : (0 = Int : ?x) || 1 , Int : ?x) || 1 , Int 
   : (0 = Int : ?x) || 1 , Int : ?x

CASEINTRO , COMP_NAT , COMP_PLUS , HYP , Int , MINUSTYPE 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX 
, TYPES , 0

*)

s "(0=Int:?x)||1,Int:?x";
assign "?x" "(0=Int:?x)||1,Int:?x";
ri "PCASEINTRO@0=Int:?x"; ri "EVERYWHERE2@POP_CASE"; ex();
ri "EVERYWHERE2@TYPES"; ri "EVERYWHERE2@POP_CASE"; ex();
right(); left(); ri "(RIGHT_CASE@INTNUMERAL)** $CASEINTRO"; ex();
wb(); prove "NZINTRETRACT";

(* definition of nonzero integer type *)

defineconstanttype "NZINTRETRACT" "Nzint:?x" "(0=Int:?x)||1,Int:?x";

(* one is a nonzero integer *)

s "Nzint:1";
ri "Nzint"; ex();
ri "RIGHT_CASE@INTNUMERAL"; rri "CASEINTRO"; ex();
p "NZINTONE";

(* nonzero integers are integers *)

(*

INTNZINT:  

Nzint : ?y  =  

Int : Nzint : ?y

CASEINTRO , COMP_NAT , COMP_PLUS , FNDIST , HYP , Int 
, MINUSTYPE , Nzint , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TYPES , 0

*)

s "Int:Nzint:?y";
ri "RIGHT@Nzint"; ex();
ri "UNEVAL_TAC@[Int:?1]"; ex();
ri "LEFT_CASE@INTNUMERAL"; ex();
ri "RIGHT_CASE@TYPES"; ex();
rri "Nzint"; ex();
wb(); p "INTNZINT";

(* update the integer type algorithms *)

ae "MAKEINT";
ri "INTNZINT";
autoreprove();

ae "HIDEINT";
arri "INTNZINT";
autoreprove();

(*

REALNZINT:  

Nzint : ?y  =  

Real : Nzint : ?y

CASEINTRO , COMP_NAT , COMP_PLUS , FNDIST , HYP , Int 
, MINUSTYPE , Nzint , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TYPES , 0

*)

s "Real:Nzint:?y";
ri "RIGHT@Nzint"; ex();
ri "UNEVAL_TAC@[Real:?1]"; ex();
ri "PIVOT"; ri "RIGHT_CASE@ $REALINT"; ex();
ri "LEFT_CASE@REALNUMERAL2"; ex();
rri "Nzint"; ex();
wb(); p "REALNZINT";

(* zero is not a nonzero integer :-) *)

(*

ZERONOTNZINT:  

0 = Nzint : ?y  =  

false

CASEINTRO , COMP_NAT , COMP_PLUS , EQUATION , EQ_COMP 
, HYP , Int , MINUSTYPE , Nzint , PLUSASSOC , PLUSCOMM 
, PLUSID , PLUSTYPE , PM , REFLEX , TYPES , 0

*)

s "0=Nzint:?y";
ri "RIGHT@Nzint"; ex();
ri "PCASEINTRO@0=Int:?y"; ri "EVERYWHERE2@POP_CASE"; ex();
ri "LEFT_CASE@ZERONOTONE";ex();
right(); right(); ri "EQUATION**1|-|1"; ex();
top(); rri "CASEINTRO"; ex();
p "ZERONOTNZINT";




(* products of nonzero integers are nonzero integers *)

(*

TIMESTYPENZINT:  

(Nzint : ?x) * Nzint : ?y  =  

Nzint : (Nzint : ?x) * Nzint : ?y

BOOLDEF , CASEINTRO , COMPTIMESTYPE , COMP_NAT , COMP_PLUS 
, COMP_TIMES , DIST , DIVTYPE , EQBOOL , EQUATION 
, EQ_COMP , FNDIST , HYP , Int , MINUSTYPE , NONTRIV 
, Nzint , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TD , TIMESASSOC , TIMESCOMM 
, TIMESTYPE , TYPES , 0

*)

s "Nzint:(Nzint:?x)*Nzint:?y";
ri "Nzint"; ex();
left();right(); 
ri "RIGHT@RL@INTNZINT"; ri "TREMTOP@TIMESTYPEINT";  ri "RL@ $INTNZINT"; ex();
up(); ri "FACTORZERO"; ex();
ri "EVERYWHERE2@($REALNZINT)**ZERONOTNZINT"; ri "NEWTAUT"; up(); ex();
ri "RIGHT@RL@INTNZINT"; ri "TREMTOP@TIMESTYPEINT";  ri "RL@ $INTNZINT"; ex();
wb(); p "TIMESTYPENZINT";

(* a special (very restricted) type algorithm for nonzero integers:
products of nonzero integers are nonzero integers *)

(* also a procedure for typing numerals as Nzints *)

s "?x";
ri "PCASEINTRO@0=Nat:?x"; ex();
right(); right(); ri "PCASEINTRO@?x=Nat:?x"; ex();
ri "PIVOT"; ex();
right(); left();rri "(2|-|1)@1"; ex();
ri "EVERYWHERE2@INTNAT"; ex();
rri "Nzint"; ex();
right(); rri "BUILTIN";
upto "?x||?y,?z"; left();
right(); rri "BUILTIN";
up(); ri "REFLEX";
top(); left(); left(); ri "MAKENAT"; ex();
up(); ri "EQ_COMP"; ex();
p "NZINTNUMERAL";

dpt "MAKENZINT";

dpt "HIDENZINT";

s "?x*?y";
right(); ri "MAKENZINT";
up(); left(); ri "MAKENZINT";
top(); ri "TIMESTYPENZINT";
ri "TYPECONTROL@Nzint,RIGHT@RL@HIDENZINT";
ari "RL@HIDENZINT";
p "MAKENZINT";

s "Nzint:?x*?y";
right(); right(); ri "MAKENZINT";
up(); left(); ri "MAKENZINT";
top(); rri "TIMESTYPENZINT";
ri "TYPECONTROL@Nzint,RIGHT@RL@HIDENZINT";
ari "RL@HIDENZINT";
p "HIDENZINT";



(* retraction theorem for the type of rationals *)

(*

RATRETRACT:  

(forsome @ [forsome @ [(Real : (forsome @ [forsome 
                  @ [(Real : ?x) = (Int : ?3) / Int 
                           : ?4]]) || (Real : ?x) 
               , 0) = (Int : ?1) / Int : ?2]]) || (Real 
      : (forsome @ [forsome @ [(Real : ?x) = (Int 
                     : ?1) / Int : ?2]]) || (Real 
            : ?x) , 0) , 0  =  

(forsome @ [forsome @ [(Real : ?x) = (Int : ?1) / Int 
               : ?2]]) || (Real : ?x) , 0

BOOLDEF , CASEINTRO , COMP_NAT , COMP_PLUS , DIST 
, DIVTYPE , EQBOOL , EQUATION , EQ_COMP , FNDIST , HYP 
, Int , MINUSTYPE , NONTRIV , NOT1 , ODDCHOICE , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX , TD 
, TIMESASSOC , TIMESCOMM , TIMESTYPE , TYPES , forall 
, forsome , 0


*)

start "(forsome@[forsome@[(Real:?x)=(Int:?1)/Nzint:?2]])||(Real:?x),0";
assign "?x" "(forsome@[forsome@[(Real:?x)=(Int:?1)/Nzint:?2]])||(Real:?x),0";
ri "PCASEINTRO@forsome@[forsome@[(Real:?x)=(Int:?1)/Nzint:?2]]"; ex();
ri "EVERYWHERE2@POP_CASE"; ex();
ri "EVERYWHERE2@TYPES"; ex();
ri "EVERYWHERE2@POP_CASE"; ex();
right(); right(); left();
ri "DINSTANTIATEF1@0"; ex();
left(); ri "EVAL"; ri "DINSTANTIATEF1@1"; ex();
left(); ri "EVAL"; ex();
ri "EVERYWHERE2@ $REALZERO"; ex();
right(); ri "LEFT@INTNUMERAL"; ex();
right(); ri "NZINTONE"; ex();
uptols "ZEROFRACT"; ri "ZEROFRACT"; ex();
uptols "REFLEX"; ri "REFLEX"; ex();
up(); up(); ri "NEWTAUT"; up(); ex();
rri "REALZERO"; ex();
wb(); prove "RATRETRACT";

(* definition of the type of rationals *)

(* this may need to be refined to avoid zero denominators in
order to prove closure under operations; we know nothing about what
real might be 1/0, for example, and this definition makes 1/0 rational *)

(* the refinement is now complete; use of Nzint solves it and
one should expect a type Nzrat to be used in the typing theorem
for division. *)

defineconstanttype "RATRETRACT" "Rat:?x" 
"(forsome@[forsome@[(Real:?x)=(Int:?1)/Nzint:?2]])||(Real:?x),0";

(* subtyping theorems *)

(* integers are rational *)

(*

RATINT:  

Int : ?x  =  

Rat : Int : ?x

BOOLDEF , CASEINTRO , COMP_NAT , COMP_PLUS , DIST 
, DIVTYPE , EQBOOL , EQUATION , EQ_COMP , FNDIST , HYP 
, Int , MINUSTYPE , NONTRIV , NOT1 , Nzint , ODDCHOICE 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX 
, Rat , TD , TIMESASSOC , TIMESCOMM , TIMESID , TIMESTYPE 
, TYPES , forall , forsome , 0

*)

s "Rat:Int:?x";
ri "Rat"; ex();
ri "EVERYWHERE2@ $REALINT"; ex();
left();ri "DINSTANTIATEF1@?x"; ex();
left(); ri "EVAL"; ri "DINSTANTIATEF1@1"; ex();
left(); ri "EVAL"; ex();
right();ri "TADDTOP@DIVTYPE"; rri "TIMESID"; ri "TIMESCOMM"; ex();
dlls "Nzint"; ri "NZINTONE"; ex();
uptols "TIMESDIV"; ri "TIMESDIV"; ex();
ri "LEFT@(RIGHT@REALNUMERAL2)**ZERONOTONE"; rri "REALINT"; ex();
top(); ri "LEFT@(EVERYWHERE@REFLEX)**NEWTAUT"; ex();
wb(); p "RATINT";

(* rationals are real *)

s "Real:Rat:?x";
ri "RIGHT@Rat"; ex();
ri "UNEVAL_TAC@[Real:?1]"; ex();
ri "(LEFT_CASE@TYPES)**(RIGHT_CASE@ $REALZERO)** $Rat"; ex();
wb(); p "REALRAT";

(* naturals are rational *)

s "Nat:?x";
ri "INTNAT**RATINT**RIGHT@ $INTNAT"; ex();
p "RATNAT";

(* typing theorems for operations *)

(* computations with fractions *)

(* nonzero integers are reals *)



(* a variation on TIMESDIV *)

(*

TIMESDIV2 @ ?y:  

Real : ?x  =  

(0 = Real : ?y) || (Real : ?x) , (?x / ?y) * ?y

CASEINTRO , TD , TIMESCOMM , 0

*)

s "Real:?x";
ri "PCASEINTRO@0=Real:?y"; ex();
right(); right(); rri "(2|-|1)@0"; rri "TIMESDIV"; ex();
p "TIMESDIV2@?y";


(* a further variation on TIMESDIV *)

(*

TIMESDIV2a @ ?y:  

Real : ?x  =  

(?x / Nzint : ?y) * Nzint : ?y

CASEINTRO , COMP_NAT , COMP_PLUS , EQUATION , EQ_COMP 
, FNDIST , HYP , Int , MINUSTYPE , Nzint , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX , TD 
, TIMESCOMM , TYPES , 0

*)

s "Real:?x";
ri "TIMESDIV2@Nzint:?y"; ex();
ri "EVERYWHERE2@ $REALNZINT"; ex();
ri "LEFT@ZERONOTNZINT"; ex();
p "TIMESDIV2a@?y";

(* typing algorithms  for fractions *)

s "?x/?y";
right(); ri "MAKENZINT";
up(); left(); ri "MAKEINT";
p "MAKEFRACTION";

s "?x/?y";
right(); ri "MAKENZINT**HIDENZINT";
up(); left(); ri "MAKEINT**HIDEINT";
p "HIDEFRACTION";

(* in HIDEFRACTION, MAKEINT followed by HIDEINT gives a better
simplified form than HIDEINT by itself *)

(* fractions can be turned into products with reciprocals *)

(*

BREAKFRACTION:  

(Int : ?x) / Nzint : ?y  =  

(Int : ?x) * 1 / Nzint : ?y

CASEINTRO , COMP_NAT , COMP_PLUS , DIVTYPE , EQUATION 
, EQ_COMP , FNDIST , HYP , Int , MINUSTYPE , Nzint 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX 
, TD , TIMESASSOC , TIMESCOMM , TIMESID , TYPES , 0

*)

s "(Int:?x)*1/Nzint:?y";
left(); ri "REALINT"; ri "TIMESDIV2a@?y"; ex();
up(); ri "TIMESASSOC"; ex();
right(); ri "TD"; ex();
ri "EVERYWHERE2@($REALNZINT)**ZERONOTNZINT"; ex();
ri "REALNUMERAL2"; ex();
up(); ri "TIMESCOMM**TIMESID"; ex();
ri "TREMTOP@DIVTYPE"; ex();
wb(); p "BREAKFRACTION";



(* BF_TAC is BREAKFRACTION with automated type inference and simplification *)

s "?x/?y";
ri "MAKEFRACTION";
ri "BREAKFRACTION";
ri "(LEFT@HIDEINT)**RIGHT@RIGHT@HIDENZINT";
p "BF_TAC";

(* tactic for grabbing a factor *)

s "?x*?y";
ri "GET@?z,TIMESCOMM,TIMESASSOC";
p "GETTIMES@?z";

(* tactic for cancelling product of a nonzero integer factor and its
reciprocal *)

s "?x*?y";
ri "GETTIMES@Nzint:?z";
ri "GETTIMES@1/Nzint:?z";
rri "TIMESASSOC";
ri "LEFT@TIMESDIV";
ri "LEFT@LEFT@(RIGHT@ $REALNZINT)**ZERONOTNZINT";
ri "LEFT@HIDEREAL";
ri "TIMESID";
ri "HIDEREAL";
p "CANCEL_TAC@?z";

(* products of reciprocals are reciprocals of products *)

(*

TIMESINVS:  

1 / (Nzint : ?x) * Nzint : ?y  =  

(1 / Nzint : ?x) * 1 / Nzint : ?y

BOOLDEF , CASEINTRO , COMPTIMESTYPE , COMP_NAT , COMP_PLUS 
, COMP_TIMES , DIST , DIVTYPE , EQBOOL , EQUATION 
, EQ_COMP , FNDIST , HYP , Int , MINUSTYPE , NONTRIV 
, Nzint , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TD , TIMESASSOC , TIMESCOMM 
, TIMESID , TIMESTYPE , TYPES , 0

*)

s "1/(Nzint:?x)*Nzint:?y";
ri "MAKEREAL"; rri "TIMESID"; ex();
right();ri "MAKEREAL"; rri "TIMESID"; ex();
top(); left(); ri "MAKEREAL"; ex();
ri "TIMESDIV2a@?x"; ex();
top(); right();left();ri "MAKEREAL"; ex();
ri "TIMESDIV2a@?y"; ex();
top();  (* one would like to use CANCEL_TAC here, but one can't because
	the parameter would be a product, which does not work right
	(GETTIMES can't grab a factor which is itself a product) *)
ri "GETTIMES@Nzint:?y";
ri "GETTIMES@Nzint:?x";
ri "GETTIMES@1/(Nzint:?x)*Nzint:?y"; ex();
rri "TIMESASSOC"; ex();
rri "TIMESASSOC"; ex();
ri "LEFT@TIMESASSOC"; ex();
ri "LEFT@TIMESDIV"; ex();
ri "LEFT@TIMESDIV";
dlls "TIMESTYPENZINT"; ex(); ri "TIMESTYPENZINT"; ex();
uptors "REALNZINT"; rri "REALNZINT"; ex();
uptols "ZERONOTNZINT"; ri "ZERONOTNZINT"; up(); ex();
ri "HIDEREAL";
up(); ri "TIMESID"; ri "HIDEREAL"; ex();

p "TIMESINVS";

(* cancellation of like factors from numerator and denominator of
a fraction *)

(*

FRACTIONCANCEL:  

((Int : ?x) * Nzint : ?z) / (Nzint : ?y) * Nzint : ?z  =  

(Int : ?x) / Nzint : ?y

BOOLDEF , CASEINTRO , COMPTIMESTYPE , COMP_NAT , COMP_PLUS 
, COMP_TIMES , DIST , DIVTYPE , EQBOOL , EQUATION 
, EQ_COMP , FNDIST , HYP , Int , MINUSTYPE , NONTRIV 
, Nzint , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TD , TIMESASSOC , TIMESCOMM 
, TIMESID , TIMESTYPE , TYPES , 0

*)

s "((Int:?x)*Nzint:?z)/(Nzint:?y)*Nzint:?z";
ri "BF_TAC"; ex();  (* BF_TAC saved several lines over old version *)
right(); ri "TIMESINVS"; ex();
top(); ri "CANCEL_TAC@?z"; ex();  (* CANCEL_TAC also saves lines here *)
rri "BREAKFRACTION"; ex();
p "FRACTIONCANCEL";

(* addition *)

(* the addition algorithm for fractions *)

(* the case of like denominators *)

(*

SAMEDENOM:  

((Int : ?x) / Nzint : ?z) + (Int : ?y) / Nzint : ?z  =  

((Int : ?x) + Int : ?y) / Nzint : ?z

CASEINTRO , COMPMINUSTYPE , COMPPLUSTYPE , COMP_MINUS 
, COMP_NAT , COMP_PLUS , DIST , DIVTYPE , EQUATION 
, EQ_COMP , FNDIST , HYP , Int , MINUSTYPE , Nzint 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX 
, TD , TIMESASSOC , TIMESCOMM , TIMESID , TYPES , 0

*)

s "((Int:?x)/Nzint:?z)+((Int:?y)/Nzint:?z)";
ri "RL@BREAKFRACTION"; ex();
rri "COMMDIST"; ex();
ri "LEFT@MAKEINT"; ex();
rri "BREAKFRACTION"; ex();
ri "HIDEFRACTION"; ex();
p "SAMEDENOM";

(* the general addition algorithm for fractions *)

(*

ADDFRACT:  

((Int : ?x) / Nzint : ?y) + (Int : ?z) / Nzint : ?w  =  

(((Int : ?x) * Nzint : ?w) + (Int : ?z) * Nzint : ?y) 
/ (Nzint : ?y) * Nzint : ?w

BOOLDEF , CASEINTRO , COMPMINUSTYPE , COMPPLUSTYPE 
, COMPTIMESTYPE , COMP_MINUS , COMP_NAT , COMP_PLUS 
, COMP_TIMES , DIST , DIVTYPE , EQBOOL , EQUATION 
, EQ_COMP , FNDIST , HYP , Int , MINUSTYPE , NONTRIV 
, Nzint , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TD , TIMESASSOC , TIMESCOMM 
, TIMESID , TIMESTYPE , TYPES , 0

*)

s "((Int:?x)/Nzint:?y)+((Int:?z)/Nzint:?w)";
left(); ri "(!$FRACTIONCANCEL)@?w"; ex();
ri "MAKEFRACTION"; ex();
up(); right(); ri "(!$FRACTIONCANCEL)@?y"; ex();
ri "RIGHT@TIMESCOMM"; ex();
ri "MAKEFRACTION"; ex();
top(); ri "SAMEDENOM"; ex();
ri "HIDEFRACTION"; ex();
p "ADDFRACT";

(* closure under addition for the rationals *)

(*

PLUSTYPERAT:  

(Rat : ?x) + Rat : ?y  =  

Rat : (Rat : ?x) + Rat : ?y

BOOLDEF , CASEINTRO , COMPMINUSTYPE , COMPPLUSTYPE 
, COMPTIMESTYPE , COMP_MINUS , COMP_NAT , COMP_PLUS 
, COMP_TIMES , DIST , DIVTYPE , EQBOOL , EQUATION 
, EQ_COMP , FNDIST , HYP , Int , MINUSTYPE , NONTRIV 
, NOT1 , Nzint , ODDCHOICE , PLUSASSOC , PLUSCOMM 
, PLUSID , PLUSTYPE , PM , REFLEX , Rat , TD , TIMESASSOC 
, TIMESCOMM , TIMESID , TIMESTYPE , TYPES , forall 
, forsome , 0

*)

s "Rat:(Rat:?x)+Rat:?y";
ri "EVERYWHERE2@Rat"; ex();
ri "PCASEINTRO@forsome@[forsome@[(Real:?x)=(Int:?1)/Nzint:?2]]";
ri "PCASEINTRO@forsome@[forsome@[(Real:?y)=(Int:?1)/Nzint:?2]]";
ri "EVERYWHERE2@POP_CASE"; ex();

(* deal with the cases where either Rat:?x or Rat:?y is zero *)

right(); left(); right(); right();
	ri "LEFT@EVERYWHERE2@($REALZERO)**PLUSID**TYPES"; ex();
	ri "1|-|1"; ex();
right(); left(); rri "(2|-|2)@Real:?x"; rri "Rat"; ex();
up(); right(); rri "(2|-|1)@0"; rri "Rat"; ex();
up();up();up();up();up();right();right(); left();

ri "LEFT@EVERYWHERE2@($REALZERO)**COMMPLUSID**TYPES"; ex();
ri "1|-|2"; ex();
right();left(); rri "(2|-|2)@0"; rri "Rat"; ex();
up();right(); rri "(2|-|1)@Real:?y"; rri "Rat"; ex();
up();up();up();right();ri "EVERYWHERE2@PLUSID** $REALZERO"; ex();
	rri "CASEINTRO"; ex();
	ri "REALZERO"; ex(); right(); ri "REALZERO"; rri "PLUSID";ex();
left(); rri "(2|-|2)@Real:?x"; rri "Rat"; ex();
up(); right();rri "(2|-|1)@Real:?y"; rri "Rat"; ex();
top(); ri "EVERYWHERE2@TREMTOP@PLUSTYPE"; ex();

right(); left(); right(); left();

(* this is the only interesting case *)

left();  (* the goal is to show that this existential statement is true *)

(* the logical form of this proof will be hard to follow because
of the use of TAB_SOME_NEW_1 and TAB_SOME_NEW_2; these implement
tableau reasoning for existential quantifiers, but they are rather
hard to understand!  These tactics are developed in tableau2.wat *)

(* I need to develop a slicker treatment of existential
hypotheses! *)

(* introduce witnesses to existential hypotheses *)

rri "(2|-|1)@(Rat:?x)+Rat:?y"; ex();
ri "TAB_SOME_NEW_1"; ex();
dlrs "CASEINTRO"; right(); left();
rri "(2|-|4)@(Rat:?x)+Rat:?y"; ex();
ri "TAB_SOME_NEW_1"; ex();
dlrs "CASEINTRO"; right(); left();
rri "(2|-|2)@(Rat:?x)+Rat:?y"; ex();
ri "TAB_SOME_NEW_1"; ex();
dlrs "CASEINTRO"; right(); left();
rri "(2|-|8)@(Rat:?x)+Rat:?y"; ex();
ri "TAB_SOME_NEW_1"; ex();
dlrs "CASEINTRO"; right(); left();

(* at this point the total term is monstrous and incomprehensible,
but the local term and the hypotheses should be possible to understand *)

right(); right(); right(); right(); left();
ri "(LEFT@0|-|10)**RIGHT@0|-|6"; ex();
up(); up();up();up();up();

(* here we use the addition algorithm proved above *)

dlls "ADDFRACT"; ex();
ri "ADDFRACT"; ex();
upto "forsome@?x"; upto "forsome@?x";
ri "DINSTANTIATEF1@((Int : ?3) * Nzint : ?2) + (Int : ?1) * Nzint : ?4"; ex();
left(); ri "EVAL"; ex();
ri "DINSTANTIATEF1@(Nzint : ?4) * Nzint : ?2"; ex();
left(); ri "EVAL"; ex();
right();left();ri "EVERYWHERE2@INTNZINT"; ex();
ri "EVERYWHERE2@TIMESTYPEINT"; ex();
ri "$PLUSTYPEINT"; ex();
ri "TOPDOWN@($INTNZINT)**($TIMESTYPEINT)"; ex();
up(); ri "RIGHT@ $TIMESTYPENZINT"; ex();
up(); ri "REFLEX"; ex();
up();up(); ri "NEWTAUT"; ex();

(* discharge all our existential hypotheses *)

uptols "TAB_SOME_NEW_2"; ri "TAB_SOME_NEW_2"; ex();
ri "POP_CASE"; ex();
uptols "TAB_SOME_NEW_2"; ri "TAB_SOME_NEW_2"; ex();
ri "POP_CASE"; ex();
uptols "TAB_SOME_NEW_2"; ri "TAB_SOME_NEW_2"; ex();
ri "POP_CASE"; ex();
uptols "TAB_SOME_NEW_2"; ri "TAB_SOME_NEW_2"; ex();
ri "POP_CASE"; up(); ex();

left(); rri "(2|-|2)@0"; rri "Rat"; ex();
up(); right(); rri "(2|-|1)@0"; rri "Rat"; ex();
top(); ri "EVERYWHERE2@ $CASEINTRO"; ex();

wb(); p "PLUSTYPERAT";

(* new stuff under construction -- working on subtraction of fractions *)

(* a simple result *)

s "(-1)*?x";
ri "MAKEREAL"; ri "(!$PLUSMINUS)@ -?x"; ex();
left(); ri "BREAKMINUS"; ex();
right(); ri "MINUSMINUS"; ex();
rri "TIMESID"; ex();
up(); rri "COMMDIST"; ex();
ri "LEFT@PLUSMINUS**HIDEREAL"; ri "TIMESZERO"; ex();
up(); ri "PLUSID**HIDEREAL"; ex();
p "MINUSFACTOR";

(* -1 is a nonzero integer *)

s "Nzint: -1";
ri "Nzint"; ex();
left(); right(); ri "Int"; ex();
left(); ri "EQUATION"; ex();
right(); left(); ri "(!$REFLEX)@0"; ex();
right(); ri "(!$ALL_CANCEL_2)@1"; ex();
ri "RIGHT@0|-|1"; ex(); 
uptols "SUCCNOTZERO"; ri "SUCCNOTZERO"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; up(); ex();
ri "EVERYWHERE@MINUSMINUS**HIDEREAL**HIDENAT"; ex();
up(); ri "(RL@MAKEREAL)** (!$ADD_CANCEL)@1"; ex();
ri "LEFT@COMMPLUSID**HIDEREAL"; ex();
ri "RIGHT@ALL_CANCEL_2"; ex();
ri "EQSYMM**ZERONOTONE"; up(); ex();
ri "HIDEINT"; ex();
wb(); p "NZINTMINUSONE";

(* reciprocals of additive inverses *)

s "1/ -Nzint:?x";
ri "RIGHT@ $MINUSFACTOR"; ex();
ri "EVERYWHERE2@NZINTMINUSONE"; ex();
ri "TIMESINVS"; ex();
left(); ri "EVERYWHERE2@ $NZINTMINUSONE"; ex();

(* subtraction of fractions *)

s "((Int:?x)/Nzint:?y)-(Int:?z)/Nzint:?w";

(* still lots more work to do on rationals! *)

(* a section on analysis *)

(* a construction for irrationals *)

(* CF@s, where s is a sequence of natural numbers, represents
(1+s_0)+1/(1+s_1)+1/(1+s_2)+1/...  Every irrational number greater
than 1 has a unique representation in this form.

This then gives us canonical representations for every real number:

rationals as fractions, irrationals > 1 as CF@s, irrationals in (0,1)
as 1/CF@s, and negative irrationals as -(positive irrational).

*)

declareconstant "CF";  (* continued fraction constructor *)

(* CFTYPE is actually provable *)

axiom "CFTYPE" "CF@?s" "Real:CF:(Nat->>Nat):?s";

axiom "CF_EVAL" "CF@?s" "1+(Nat:?s@0)+1/CF@[Nat:?s@1+Nat:?1]";

axiom "CF_ORDER" "1<CF@?s" "true";

(* program:  can we prove the following theorems:  

least upper bound axiom

any real > 1 is either a rational or a continued fraction

do we need an Archimedean axiom:  each real greater than some natural
number?

The proposal below will work:

*)

axiom "ARCHIMEDEAN" "(Nat:Real:?r) >= Real:?r" "true";

(*

DIFFSQ:  

(?x * ?x) - ?y * ?y  =  

(?x - ?y) * ?x + ?y

CASEINTRO , COMP_NAT , COMP_PLUS , DIST , HYP , MINUSTYPE 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX 
, TIMESCOMM , TIMESTYPE , TYPES , 0

*)

s "(?x-?y)*(?x+?y)";
ri "LEFT@BREAKMINUS"; ri "X"; ex();
ri "EVERYWHERE@TIMESCOMM**SIGNPULL"; ex();
right(); rri "PLUSASSOC"; ex();
left(); ri "(RIGHT@TIMESCOMM)**ALL_CANCEL"; ex();
up(); ri "PLUSID**HIDEREAL"; ex();
up(); rri "BREAKMINUS"; ex();
wb(); p "DIFFSQ";

(*

CFNOTZERO:  

0 = CF @ ?s  =  

false

CASEINTRO , CF_ORDER , COMP_NAT , EQUATION , LESS_COMP 
, REFLEX , 0

*)

s "0=CF@?s";
ri "EQUATION"; ex();
right(); left(); ri "(!$CF_ORDER)@?s"; ex();
ri "RIGHT@ $0|-|1"; ex();
ri "(RL@MAKENAT)**LESSCOMP"; ex();
top(); rri "CASEINTRO"; ex();
p "CFNOTZERO";

(* this is not quite as mysterious as it looks:  sqrt(2) = 1 + 1/1+sqrt(2),
from which it follows that sqrt(2) = 1+2/2+1/2+1/2+1/2+....,
which is CF applied to the sequence 0,1,1,1,1,...
and the rest of the proof is some simple algebra. *)

(*

SQRT_OF_2:  

(CF @ [(?1 = 0) || 0 , 1]) * CF @ [(?1 = 0) || 0 , 1]  =  

2

CASEINTRO , CFTYPE , CF_EVAL , CF_ORDER , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , HYP 
, LESS_COMP , MINUSTYPE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , SUCCNOTZERO , TD , TIMESCOMM 
, TIMESID , TIMESTYPE , TYPES , 0

*)

s "(CF@[(?1=0)||0,1])*CF@[(?1=0)||0,1]";
ri "MAKEREAL"; ex();
ri "(!$PLUSMINUS)@1"; ex();
left(); right(); ri "MAKEREAL** $TIMESID"; ex();
uptols "DIFFSQ"; ri "DIFFSQ"; ex();
left(); left(); ri "CF_EVAL"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@REFLEX** $ZERONAT"; ex();
ri "EVERYWHERE2@EQSYMM**SUCCNOTZERO** $ONENAT"; ex();
ri "EVERYWHERE@PLUSID**HIDEREAL"; ex();

up(); ri "ALL_CANCEL"; ri "PLUSID**HIDEREAL"; ex();
up(); right();left();ri "CF_EVAL"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@REFLEX** $ZERONAT"; ex();
ri "EVERYWHERE2@EQSYMM**SUCCNOTZERO** $ONENAT"; ex();
ri "EVERYWHERE@PLUSID**HIDEREAL"; ex();
up(); ri "PLUSCOMM"; ex();
right(); left(); ri "ONENAT"; ex();
right(); ri "BIND@0"; ex();
up(); up(); right(); right(); right(); right(); ri "ONENAT"; ex();
right(); ri "BIND@1+Nat:?1"; ex();
uptors "CF_EVAL"; rri "CF_EVAL"; ex();
up(); ri "TIMESDIV"; ex();
ri "LEFT@RIGHT@TREMTOP@CFTYPE"; ex();
ri "LEFT@CFNOTZERO"; ex();
ri "HIDEREAL"; ex();
top(); ri "(RL@MAKENAT)**PLUSCOMP"; ex();
p "SQRT_OF_2";



quit();















