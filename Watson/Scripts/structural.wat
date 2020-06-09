(* August 13, 1999-- added navigation tactics for INPUT 
environment *)

(* May 21, 1999  New tactics added (actually, several added before
May 21 and not noted here). *)

(* March 19, 1999 -- last revised *)

(* August 20th, 1997 (added more comments) *)

(* this file contains "structural" tactics; these tactics enable
applications of theorems and tactics to subexpressions of expressions
under consideration, and allow program constructions such as composition
and looping to be applied to tactics *)

(* this construction is used to attach labels to terms and to
make copies of terms *)

(* there is also a development of abstraction algorithms and
algorithms for manipulation of case expressions predating the development
of hard-wired abstraction and local hypothesis manipulation *)

defineinfix "IGNOREFIRST" "?x.?y" "?y";

(* adapts to change in preamble; proves redundant "axioms"
in preamble *)

ae "P1";  prove "PI1";

ae "P2"; prove "PI2";

ae "Id"; prove "ID";

(* parameterized "CASEINTRO" *)

initializecounter();
s "?x";
ri "CASEINTRO"; ex();
assign "?y_1" "?p";
prove "PCASEINTRO@?p";

(* elimination of FNDIST *)

s "?f@?x||?y,?z";
ri "PCASEINTRO@?x"; ex();
right();left();right();
ri "1|-|1"; ex();
up();up();right();right();
ri "1|-|1"; ex();
(* proveanaxiom "FNDIST"; *)  (* Baby doesn't know this command *)

(* elimination of HYP *)

s "(?a=?b)||(?f@?a),?c";
right();left();right();
ri "0|-|1"; ex();
(* proveanaxiom "HYP"; *)  (* Nor does Baby know this *)


(* Structural tactics taken from Parvin's file *)

(* these allow application of theorems to left and right subterms,
reversal of the direction of a theorem, and composition of theorems *)

(* ************************ methods ****************************** *)

(* theorem/tactic composition *)

(*

?thm1 ** ?thm2:

?x = 

?thm2 => ?thm1 => ?x

[]

*)

s "?x"; ri "?thm1"; ri "?thm2"; p "?thm1**?thm2";

(* reverse direction of theorem *)

(*

$?thm:

?x = 

?thm <= ?x

*)

s "?x"; rri "?thm"; p "$?thm";

(* apply theorem to left subterm *)

(*

LEFT @ ?thm:

?p ^+ ?q = 

(?thm => ?p) ^+ ?q

[]

*)

(* LEFT is ramified to handle case expressions as well *)

s "?p ^+ ?q"; left(); ri "?thm"; p "LEFT1@?thm";

s "?x||?y,?z"; left(); ri "?thm"; p "LEFT2@?thm";

s "?x"; ri "LEFT1@?thm"; ari "LEFT2@?thm"; p "LEFT@?thm";

(* apply theorem to right subterm *)

(*

RIGHT @ ?thm:

?p ^+ ?q = 

?p ^+ ?thm => ?q

[]

*)

(* RIGHT is ramified to handle strict prefixes *)

declareunaryopaque "^-";

s "?p ^+ ?q"; right(); ri "?thm"; p "RIGHT1@?thm";
s "^-?x"; right(); ri "?thm"; p "RIGHT2@?thm";
s "?x"; ri "RIGHT1@?thm"; ari "RIGHT2@?thm"; p "RIGHT@?thm";

(* apply theorem to both left and right subterms *)

(*

RL @ ?thm:

?p ^+ ?q = 

(?thm => ?p) ^+ ?thm => ?q

[]

*)

s "?p ^+ ?q"; left(); ri "?thm"; up(); right(); ri "?thm"; p "RL@?thm";

s "?x||?y,?z";
right();left(); ri "?thm";

(* LEFT_CASE and RIGHT_CASE are needed because Baby is finicky 
about case expressions *)

(*

LEFT_CASE @ ?thm:  

?x || ?y , ?z  =  

?x || (?thm => ?y) , ?z

*)

p "LEFT_CASE@?thm";

(*

RIGHT_CASE @ ?thm:  

?x || ?y , ?z  =  

?x || ?y , ?thm => ?z

*)

s "?x||?y,?z";
right();right(); ri "?thm";
p "RIGHT_CASE@?thm";

(*

BOTH_CASES @ ?thm:  

?x || ?y , ?z  =  

?x || (?thm => ?y) , ?thm => ?z

*)

s "?x||?y,?z";
right(); left(); ri "?thm";
up(); right(); ri "?thm";
p "BOTH_CASES@?thm";

(* this section develops tactics for implementation of aggressive rewriting *)

(* development of EVERYWHERE tactic *)

(* this tactic does not rewrite inside abstractions or inside the
defining equation or other proposition of a case expression *)

(* EVERYWHERE rewrites from the bottom up, while the new TOPDOWN
rewrites from the top down; this distinction can be important *)

(* EVERYWHERE comes in two flavors: EVERYWHERE itself does not rewrite
into defining equations of case expressions or into brackets, while
EVERYWHERE2 rewrites into these contexts as well *)

(* the structure of EVERYWHERE and EVERYWHERE2 exemplifies a way that
recursively defined tactics can share code *)

(* subtactics of EVERYWHERE and EVERYWHERE2 *)

s "?a||?x,?y";  (* changed Apr. 17 *)
right();left();
ri "?EVERYWHERE@?thm";
up();right();
ri "?EVERYWHERE@?thm";
top();
ri "?thm";
prove "EVERYWHERE_CASE@?EVERYWHERE,?thm";

s "?a||?x,?y";  (* new Aug. 15 '97 *)
right();left();
ri "?EVERYWHERE@?thm";
up();right();
ri "?EVERYWHERE@?thm";
top();
left(); ri "?EVERYWHERE@?thm"; up();
ri "?thm";
p "STRONG_EVERYWHERE_CASE@?EVERYWHERE,?thm";

s "[?f@?1]";
right(); ri "?EVERYWHERE@?thm";
up(); 
ri "?thm";
p "EVERYWHERE_ABS@?EVERYWHERE,?thm";

declareunaryopaque "^--";

s "^--?x";
right(); ri "?EVERYWHERE@?thm";
up(); ri "?thm";
p "EVERYWHERE_PREFIX@?EVERYWHERE,?thm";
 

declareopaque "^+";

s "?x^+?y";
right();
ri "?EVERYWHERE@?thm";
up();left();
ri "?EVERYWHERE@?thm";
top();
ri "?thm";
p "EVERYWHERE_INFIX@?EVERYWHERE,?thm";

dpt "EVERYWHERE";

(* apply theorem to all subterms, bottom-up,
excluding defining equations of case expressions
and innards of abstraction terms *)

(*

EVERYWHERE @ ?thm:

?x = 

?thm =>> (EVERYWHERE_INFIX @ EVERYWHERE , ?thm) 
=>> (EVERYWHERE_CASE @ EVERYWHERE , ?thm) => ?x

[]


*)

s "?x";
ri "EVERYWHERE_CASE@EVERYWHERE,?thm";
ari "EVERYWHERE_INFIX@EVERYWHERE,?thm";
ari "EVERYWHERE_PREFIX@EVERYWHERE,?thm";
ari "?thm";  (* changed from ri on June 24th *)
prove "EVERYWHERE@?thm";

dpt "EVERYWHERE2";

(* as EVERYWHERE, without subterm restriction *)

(*

EVERYWHERE2 @ ?thm:

?x = 

?thm =>> (EVERYWHERE_ABS @ EVERYWHERE2 , ?thm) 
=>> (EVERYWHERE_INFIX @ EVERYWHERE2 , ?thm) 

=>> (STRONG_EVERYWHERE_CASE @ EVERYWHERE2 , ?thm) 
=> ?x

[]

*)

s "?x";
ri "STRONG_EVERYWHERE_CASE@EVERYWHERE2,?thm";
ari "EVERYWHERE_INFIX@EVERYWHERE2,?thm";
ari "EVERYWHERE_PREFIX@EVERYWHERE2,?thm";
ari "EVERYWHERE_ABS@EVERYWHERE2,?thm";
ari "?thm";
prove "EVERYWHERE2@?thm";

(* apply theorem everywhere, top-down, restricted as EVERYWHERE *)

(* development of TOPDOWN tactic *)

dpt "TOPDOWN";

s "?a||?x,?y";
ri "?thm";
ri "BOTH_CASES@TOPDOWN@?thm";
prove "TOPDOWN_CASE@?thm";

s "?x^+?y";
ri "?thm";
ri "RL@TOPDOWN@?thm";
prove "TOPDOWN_INFIX@?thm";

s "^--?x";
ri "?thm";
ri "RIGHT@TOPDOWN@?thm";
prove "TOPDOWN_PREFIX@?thm";

s "?x";
ri "TOPDOWN_CASE@?thm";
ari "TOPDOWN_INFIX@?thm";
ari "TOPDOWN_PREFIX@?thm";
ari "?thm";
prove "TOPDOWN@?thm";

(*
(* development of a synthetic abstraction algorithm *)

(* this is what I used to use before introducing variable binding *)

axiom "RSFN" "?f:^+?g" "[(?f:^+?g)@?1]";

(* this axiom ensures that objects introduced by RAISE are functions *)

(* I might not necessarily want this to be true; in some contexts, it is
better to suppose that the raised abstractions are intensional objects *)

declaretypedinfix 0 0 "^&";

(*

RAISE0:

(?f @ ?x) ^& ?g @ ?x = 

(?f :^& ?g) @ ?x

[]

*)

s "(?f@?x)^&(?g@?x)";
ri "RAISE"; ex();
p "RAISE0";

dpt "ABSTRACT";

(*

ABSTRACT1 @ ?x:

?x = 

Id @ ?x

["ID"]

*)

s "?x";
rri "ID";ex();
p "ABSTRACT1@?x";

(*

ABSTRACT2 @ ?x:

?f @ ?a = 

COMP <= ?f @ (ABSTRACT @ ?x) => ?a

["COMP"]

*)

s "?f@?a";
rri "COMP";
right(); right(); ri "ABSTRACT@?x";
prove "ABSTRACT2@?x";

(*

ABSTRACT3 @ ?x:

?a ^& ?b = 

RAISE0 => ((ABSTRACT @ ?x) => ?a) 
^& (ABSTRACT @ ?x) => ?b

[]

*)

s "?a^&?b";
right();
ri "ABSTRACT@?x";
up();left();
ri "ABSTRACT@?x";
top();
ri "RAISE0";
prove "ABSTRACT3@?x";

(*

ABSTRACT4 @ ?x:

?a = 

[?a] @ ?x

[]

*)

s "?a";
ri "BIND@?x"; ex();
p "ABSTRACT4@?x";

(* ABSTRACT@term will (attempt to) express a target term as a function
of its parameter "term" *)

(*

ABSTRACT @ ?x:

?a = 

(ABSTRACT4 @ ?x) =>> (ABSTRACT3 @ ?x) 
=>> (ABSTRACT2 @ ?x) =>> (ABSTRACT1 @ ?x) => ?a

["COMP","ID"]

*)

s "?a";
ri "ABSTRACT1@?x";
ari "ABSTRACT2@?x";
ari "ABSTRACT3@?x";
ari "ABSTRACT4@?x";
p "ABSTRACT@?x";

(* REDUCE will reverse the effect of ABSTRACT; it will "evaluate"
functions built by ABSTRACT *)

(*

REDUCE:

?f @ ?x = 

(ABSTRACT4 @ ?x) <<= ((RL @ REDUCE) *> RAISE0) 
<<= ((RIGHT @ REDUCE) *> COMP) =>> ID => ?f @ ?x

["COMP","ID"]

*)

dpt "REDUCE";
s "?f@?x";
ri "ID";
ari "(RIGHT@REDUCE)*>COMP";
arri "(RL@REDUCE)*>RAISE0";
arri "ABSTRACT4@?x";
prove "REDUCE";

(* impredicative synthetic abstraction and reduction is 
under development in the file lambda.mk2 *)
*)
(* old approach to hypotheses *)

(*

PIVOT:

(?a = ?b) || ?T , ?U = 

(RIGHT @ LEFT @ EVAL) => HYP => (?a = ?b) 
|| ((BIND @ ?a) => ?T) , ?U

["HYP"]

*)

s "(?a=?b)||?T,?U";
right();left();
ri "BIND@?a";
top();
ri "HYP";
ri "LEFT_CASE@EVAL";
p "PIVOT";

(*

REVPIVOT:

(?a = ?b) || ?T , ?U = 

(LEFT_CASE @ EVAL) => HYP <= (?a = ?b) 
|| ((BIND @ ?b) => ?T) , ?U

["HYP"]

*)

s "(?a=?b)||?T,?U";
right();left();
ri "BIND@?b";
top();
rri "HYP";
ri "LEFT_CASE@EVAL";
p "REVPIVOT";

(* reverse forms of projection axioms *)

s "?x"; 
initializecounter();
rri "PI1"; ex();
assign "?y_1" "?y";
p "PI1F@?y";

s "?x"; 
initializecounter();
rri "PI2"; ex();
assign "?x_1" "?y";
p "PI2F@?y";

s "[?P@?1]";
right(); ri "?thm";
p "VALUE0@?thm";

s "[?P@?1]";
right(); ri "?thm@?1";
p "VALUE@?thm";



(* tool for expressing a term as a function of a pair *)

s "?t";
ri "BIND@?x,?y";
ri "LEFT@VALUE@[BIND@?x]";
ri "LEFT@VALUE@[RIGHT@PI1F@?y]";
ri "LEFT@VALUE@[LEFT@VALUE@[BIND@?y]]";
ri "LEFT@VALUE@[LEFT@VALUE@[RIGHT@PI2F@?x]]";
ri "LEFT@VALUE@[LEFT@VALUE@[EVAL]]";
ri "LEFT@VALUE@[EVAL]";
ri "EVAL";
ri "BIND@?x,?y";
prove "PAIRBIND@?x,?y";

(* example *)

s "(?f@?x)=(?g@?y)=(?h@?x,?y)";
ri "PAIRBIND@?x,?y"; ex();

(* tool for expressing a term as a function of a list *)

(* Baby doesn't handle this perfectly *)

dpt "LISTBIND";

s "?t";
ri "(LISTBIND@?y)*>EVAL";
ri "(PAIRBIND@?y)*>EVAL";
ri "PAIRBIND@?x,?y";
p "LISTBIND@?x,?y";

(* example -- note the format of the argument list *)

s "?x=?y=?z";
ri "LISTBIND@?x,?y,?z,0"; ex();

(* development of loop tactic *)


(* STARTLOOP:

?x = 

?x . ?x

["IGNOREFIRST"]
  *)


initializecounter();
s "?x";
rri "IGNOREFIRST"; ex();
assign "?x_1" "?x";
p "STARTLOOP";


(* STOPLOOP:

?x . ?x = 

?x

["IGNOREFIRST"]
  *)

s "?x.?x";
ri "IGNOREFIRST"; ex();
p "STOPLOOP";

(* the loop body *)

dpt "ALL_STEPS";

(* ALL_STEPS:

?x . ?y = 

ALL_STEPS =>> STOPLOOP => (RIGHT @ ?ONE_STEP) 
=> STARTLOOP => IGNOREFIRST => ?x . ?y

["AND","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","XOR"]
  *)

s "?x.?y";
ri "IGNOREFIRST";
ri "STARTLOOP";
ri "RIGHT@?ONE_STEP";
ri "STOPLOOP";
ari "ALL_STEPS@?ONE_STEP";
prove "ALL_STEPS@?ONE_STEP";

(* the loop itself *)

s "?x";
ri "STARTLOOP";
ri "ALL_STEPS@?ONE_STEP";
p "LOOP_TAC@?ONE_STEP";

(* new stuff requiring new features of Watson *)

(* tool for viewing cases of complex case expressions *)

dpt "VIEWCASES";

s "?x||?y,?z";
right(); left(); ri "VIEWCASES";  ari "INPUT";
up(); right(); ri "VIEWCASES";  ari "INPUT";
p "VIEWCASES";


(* BEGIN moved to structural.wat from algebra2.wat *)

(* examples commented out because won't work in this context *)

(* some general purpose tactics; good examples of the programming power
of the tactic language *)

(* generalized associativity tactic *)

(* ASSOCS is actually an iterator for any theorem whatsoever *)

(* *> is the "on-success" control structure of the tactic language;
see the documentation or ask me *)

(*

ASSOCS @ ?thm:

?x = 

((ASSOCS @ ?thm) *> ?thm) => ?x

[]

*)

dpt "ASSOCS";
s "?x";
ri "?thm*>(ASSOCS@?thm)";
p "ASSOCS@?thm";

(*

ALLASSOCS @ ?thm:

?x = 

(RIGHT @ ALLASSOCS @ ?thm) => (ASSOCS @ ?thm) 
=> ?x

[]

*)

dpt "ALLASSOCS";
s "?x";
ri "ASSOCS@?thm";
ri "RIGHT@ALLASSOCS@?thm";
p "ALLASSOCS@?thm";
(*
(* example *)

s "(?x|?y)|((?z|?w)|?u)|?q";
ri "ALLASSOCS@DASSOC"; ex();
*)
(* get desired term using associative and commutative laws *)

s "?x ^+ ?y";
p "GET0@?x";

s "?y ^+ ?x";
ri "?comm";
p "GET1@?x,?comm";

s "?y ^+ ?x ^+ ?z";
rri "?assoc";
ri "LEFT@?comm";
ri "?assoc";
p "GET2@?x,?comm,?assoc";

dpt "GET";
s "?x";
ri "ASSOCS@?assoc";
ri "GET0@?y";
ari "RIGHT@GET@?y,?comm,?assoc";
ri "GET1@?y,?comm";
ari "GET2@?y,?comm,?assoc";
prove "GET@?y,?comm,?assoc";
(*
(* example *)

s "?x + (?u + ?v + (?w+?e)+?f+?g) + ?q";
ri "GET@?e,PLUSCOMM,PLUSASSOC"; ex();
*)
(* GET does not carry out all possible applications of associativity;
it only does enough applications to find its target *)

(* END moved to structural.wat from algebra2.wat *)

(* a frequently used maneuver *)

s "?x";
ri "UNEVAL@?f";
ri "FNDIST";
ri "BOTH_CASES@EVAL";
p "UNEVAL_TAC@?f";

(* a trick for use with BIND *)

s "?x";
ri "EVERYWHERE2@ $TYPES";
ri "BIND@?t";
ri "EVERYWHERE2@ TYPES";
p "TYPEBIND@?t";

(* another maneuver *)

s "?x||?y,?z";
ri "BOTH_CASES@UNEVAL@?f";
rri "FNDIST";
ri "EVAL";
p "ANTI_UNEVAL_TAC@?f";

(* tactic for collapsing case expressions if any local hyp will do it *)

(* stop if $1|-|?n has no effect *)

dpt "POP_CASE_2";

(* POP_CASE_1 modified June 10 to avoid problems with new variables
and stratification *)

s "?n.?x||?y,?z";
right(); rri "((2|-|?n)@0)*>POP_CASE_2@?n";
top(); ri "IGNOREFIRST";
p "POP_CASE_1";

s "?x||?y,?z";
ri "1|-|?n";
ri "1|-|?n";
ari "((!$IGNOREFIRST)@1+!?n)**POP_CASE_1";
p "POP_CASE_2@?n";

s "?x||?y,?z";
ri "((!$IGNOREFIRST)@1)**POP_CASE_1";
p "POP_CASE";

(* project: write a new one which will scan 0|-|n's as this one
scans 1|-|n's *)

(* tactic for labelling subterms identical to a given term
with unique labels *)

(* this should help with use of special movement commands in a situation
where many identical terms appear *)

(* also see applications below -- these are powerful tools! *)

dpt "LABELTERMS";

s "?a";
ri "(!$IGNOREFIRST)@?no";
p "LABELTERMS_FOUND@?a,?no";

s "?x^+?y";
left(); ri "LABELTERMS@?a,2*!?no"; 
up(); right(); ri "LABELTERMS@?a,1+!2*!?no";
p "LABELTERMS_SPLIT@?a,?no";

s "[?x@?1]";
right(); ri "LABELTERMS@?a,?no";
prove "LABELTERMS_ABSTRACT@?a,?no";

s "^--?x";
right(); ri "LABELTERMS@?a,?no";
prove "LABELTERMS_UNARY@?a,?no";

s "?x||?y,?z";
left(); ri "LABELTERMS@?a,2*!?no";
top(); right(); left(); ri "LABELTERMS@?a,2*!1+!2*!?no";
top(); right(); right(); ri "LABELTERMS@?a,1+!2*!1+!2*!?no";
p "LABELTERMS_CASE@?a,?no";

s "?x";
ri "LABELTERMS_FOUND@?a,?no";
ari "LABELTERMS_SPLIT@?a,?no";
ari "LABELTERMS_ABSTRACT@?a,?no";
ari "LABELTERMS_UNARY@?a,?no";
ari "LABELTERMS_CASE@?a,?no";
p "LABELTERMS@?a,?no";

s "?x";
ri "LABELTERMS@?a,1";
p "LABELTERM@?a";

s "?label.?x";
ri "IGNOREFIRST";
ri "?thm";
p "APPLYATLABEL0@?thm,?label";

s "?x";
ri "EVERYWHERE2@APPLYATLABEL0@?thm,?label";
p "APPLYATLABEL@?thm,?label";

(* with APPLYATLABELS, we can apply a theorem to all and only
those terms with a given label *)

dpt "APPLYATLABELS";

s "?x";
ri "APPLYATLABEL@?thm,?first";
ri "APPLYATLABELS@?thm,?rest";
p "APPLYATLABELS@?thm,?first,?rest";

(* in combination with LABELTERMS, this allows binding on selected
occurrences of a term! *)

s "?x";
ri "APPLYATLABELS@($ID),?list";
ri "BIND@Id@?y";
ri "RIGHT@ID";
ri "LEFT@EVERYWHERE2@IGNOREFIRST"; 
p "BINDLABELS@?y,?list";

(* movement tactics for the INPUT environment *)

(* be careful not to put in a final "up",
or use INPUTS2 to enter this state *)

defineconstant "upfun@?x" "?x";

s "?x";
rri "upfun"; ex();
p "up";

dpt "INPUTS2";

s "?x";
ri "upfun"; ari "INPUT**INPUTS2";
p "INPUTS2";

(* the idea is that INPUTS2 puts one in an environment where one can
use the right left up commands at the INPUT prompt much as one is used
to and apply theorems as one usually does to subterms.  One also needs
left_case, right_case and value to move into branches of case expressions
and function terms.  up is used to break out of the INPUTS2
environment as well as to simulate moving up in terms. *)

s "?x";
ri "(RIGHT@INPUTS2)**INPUT";
p "right";

s "?x";
ri "(LEFT@INPUTS2)**INPUT";
p "left";

s "?x";
ri "(RIGHT_CASE@INPUTS2)**INPUT";
p "right_case";

s "?x";
ri "(LEFT_CASE@INPUTS2)**INPUT";
p "left_case";


s "?x";
ri "(VALUE@INPUTS2)**INPUT";
p "value";

s "?x";
ri "INPUTS2**upfun";
p "INPUT_AT@?x";

s "?x";
ri "EVERYWHERE2@INPUT_AT@?a";
p "goto@?a";

(* visits all instances of argument, exits to where it was called  *)


quit();










