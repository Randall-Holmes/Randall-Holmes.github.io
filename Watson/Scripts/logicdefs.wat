
(* August 18, 1997 (as part of general overhaul) *)

(* this file includes definitions and scin/scout results for the
logical connectives and the quantifiers--it also includes some very
simple basic theorems about these operators, proven "by hand" *)

(* include prerequisite files *)

script "structural";

script "lambda"; 

(* symmetry of equality -- one of those basic results! *)

(*

EQSYMM:

?x = ?y = 

?y = ?x

["CASEINTRO","EQUATION","REFLEX"]

*)

initializecounter();
s "?x=?y";
ri "CASEINTRO"; ex();
assign "?y_1" "?y=?x";
right();left();right();
ri "0|-|1"; ex();
up();
ri "REFLEX"; ex();
up();right();
ri "EQUATION"; ex();
right();left();
rri "REFLEX";ex();
assign "?a_4" "?x";
left();
ri "0|-|2"; ex();
up();
ri "EQUATION";
ri "1|-|1"; ex();
up();up();
rri "CASEINTRO"; ex();
top();
rri "EQUATION";ex();
p "EQSYMM";


(* definition of the boolean type *)

declareconstant "bool";
axiom "EQBOOL" "?x=?y" "bool:?x=?y";
makescout "=" "EQBOOL";

(* quantifiers *)

defineconstant "forall@?P" "[?P@?1] = [true]";
s "forall@?P";
ri "forall";ex();
ri "EQBOOL";ex();
right();
rri "forall";ex();
p "FORALLBOOL";
makescout "forall" "FORALLBOOL";

(* forall2 is used to prevent "losing the brackets"
when the theorem is applied in reverse *)

(*

forall2:

forall @ [?P @ ?1] = 

[?P @ ?1] = [true]

["forall"]

*)

s "forall@[?P@?1]";
ri "forall"; ex();
p "forall2";



(* ODDCHOICE fix *)
(* defineinfix "NOT1" "~?y" "(true = ?y)||false,true"; *)

defineinfix "NOT1" "~?y" "(?y)||false,true";

(*

NOT1:

~?y = 

(true = ?y) || false , true

["NOT"]

*)

initializecounter();
s "~?y";
ri "NOT1"; ex();
right();left();
rri "NONTRIV"; ri "EQBOOL"; ex();
right(); ri "NONTRIV"; ex();
up(); ri "BIND@false"; ex();
up();right();
rri "REFLEX"; ri "EQBOOL"; ex();
right(); ri "REFLEX"; ex();
up(); ri "BIND@true"; ex();
top(); rri "FNDIST"; ex();
ri "EVAL";ex();
right(); rri "NOT1"; ex();
(* assign "?x_9" "?x"; *)
p "NOTBOOL";
makescout "~" "NOTBOOL";


(* The point here is to tell the prover that ~ has "output" in the boolean
type *)

defineconstant "forsome@?P" "~forall@[~?P@?1]";
s "forsome@?P";
ri "forsome";
ri "NOTBOOL";
ex();
right();
rri "forsome";
ex();
p "FORSOMEBOOL";
makescout "forsome" "FORSOMEBOOL";

(* used to prevent loss of brackets, as "forall2" *)

(*

forsome2:

forsome @ [?P @ ?1] = 

 ~forall @ [ ~?P @ ?1]


*)

s "forsome@[?P@?1]";
ri "forsome"; ex();
p "forsome2";

(* "true" and "false" are boolean *)

s "true";
rri "REFLEX"; ri "EQBOOL"; ex();
right(); ri "REFLEX"; ex();
p "TRUEBOOL";

s "false";
rri "NONTRIV"; ri "EQBOOL"; ex();
right(); ri "NONTRIV"; ex();
p "FALSEBOOL";

axiom "BOOLDEF" "bool:?x" "true=?x";

(* the axiom EQBOOL is redundant, given BOOLDEF *)

s "?x=?y";
ri "EQUATION";
ri "ODDCHOICE";
rri "EQUATION";
rri "BOOLDEF"; ex();
(* proveanaxiom "EQBOOL"; *)

defineinfix "AND" "?x&?y" "(?x)||(true=?y),false"; (* ODDCHOICE fix *)
s "?x&?y";
ri "AND"; ex();
right();left(); ri "EQBOOL"; ri "BIND@true=?y"; ex();
up();right();ri "FALSEBOOL"; ri "BIND@false"; ex();
top(); rri "FNDIST"; ri "EVAL"; ex();
right(); rri "AND"; ex();
p "ANDBOOL";
makescout "&" "ANDBOOL";

(* After this, the typing declarations get easier *)

defineinfix "OR" "?x|?y" "~(~?x)& ~?y";
s "?x|?y";
ri "OR";ex();
ri "NOTBOOL";ex();
right(); rri "OR";ex();
p "ORBOOL";
makescout "|" "ORBOOL";

(* an alternative definition of "or", more similar to that of "and" *)

(*

ALTORDEF:

?x | ?y = 

(true = ?x) || true , true = ?y

["AND","CASEINTRO","EQUATION","NONTRIV","NOT","OR","REFLEX"]

*)

ae "NOT1"; p "NOT";  (* deals with repeated declaration problems *)



initializecounter();
s "?x|?y";
ri "OR"; ex();
ri "CASEINTRO"; ex();
assign "?y_2" "?x";
right(); left();
right();left();right();
rri "0|-|1"; ex();
up();
ri "NOT1"; (* ri "LEFT@REFLEX"; *)  ex();
up();
ri "NOT1"; (* ri "LEFT@NONTRIV"; *) ex();
ri "AND"; (* ri "LEFT@NONTRIV"; *) ex();
up();
ri "NOT1"; (* ri "LEFT@NONTRIV"; *) ex();
up(); right();
right();left();
ri "NOT1"; ri "1|-|1"; ex();
up();
ri "AND"; (* ri "LEFT@REFLEX"; *) ex();
up();
ri "CASEINTRO"; ex();
assign "?y_9" "?y";
right();left();
right();right();
ri "NOT1"; ri "1|-|2"; ex();
up();
ri "NONTRIV"; ex();
up();
ri "NOT1"; (* ri "LEFT@NONTRIV"; *) ex();
up(); right();
right(); right();
ri "NOT1"; ri "1|-|2"; ex();
up();
ri "REFLEX"; ex();
up();
ri "NOT1"; (* ri "LEFT@REFLEX"; *)  ex();
up();up();
rri "EQUATION"; ex();
p "ALTORDEF";


defineinfix "IF" "?x->?y" "(~?x)|?y";
s "?x->?y";
ri "IF"; ri "ORBOOL"; ex();
right(); rri "IF"; ex();
p "IFBOOL";
makescout "->" "IFBOOL";

defineinfix "IFF" "?x==?y" "(bool:?x)=(bool:?y)";
s "?x==?y";
ri "IFF"; ri "EQBOOL"; ex();
right(); rri "IFF"; ex();
p "IFFBOOL";
makescout "==" "IFFBOOL";

(*

(* the basic set notion *)

defineconstant "Set@?x" "[bool:?x@?1]";

(* prove that the set operator is a retraction, and so can
be used as a sort of type label *)

(*

SETRETRACT:

Set @ Set @ ?x = 

Set @ ?x

["Set","TYPES"]

*)

s "Set@Set@?x";
ri "EVERYWHERE@Set"; ex();
ri "EVERYWHERE2@TYPES"; ex();
rri "Set"; ex();
p "SETRETRACT";

(* this is a new definition of the membership relation (Aug 20th) *)

definetypedinfix "IN" 0 1 "?x<<?y" "(?y@?x)&bool:?y=Set@?y";

(* the explicit typing of the equation using bool: is needed
for the definition of the membership relation (that's what << is) to
be recognized as being stratified. *)

(* note that the definition facility is more finicky than the 
facility which checks function abstraction terms; the reason is that
it does not use scin/scout information *)

(* example: *)

s "[[((?1@?2) = true) & forall@[(?1@?3)=bool:?1@?3]]]";

(* this abstraction term defines a (curried) function IN such that
(IN@?x)@?y = ?x<<?y; notice that the abstraction term does NOT need
the bool: in front of forall, because the fact that forall is "scout"
allows the system to tell that a type label could be put there *)

(* this term is also a good target for the LAMBDAINTRO and LAMBDAREMOVE
tactics from lambda.mk2 included above *)

ri "LAMBDAINTRO"; ex();
ri "LAMBDAREMOVE"; ex();

(* proof that ?x << ?y is boolean *)

s "?x<<?y";
ri "IN"; ri "ANDBOOL"; ex();
ri "RIGHT@ $IN"; ex();
p "INBOOL";
makescout "<<" "INBOOL";

*)

(* other forms of definitions need to be shown to be equivalent, of course *)
(* the propositional connectives are actually "scin", of course, but this
takes more work to demonstrate *)

(* the basic "scin" result is the one for conjunction, which should now
follow *)

initializecounter();
s "(bool:?x)&(bool:?y)";
ri "CASEINTRO"; ex();
assign "?y_1" "(?x)";  (* ODDCHOICE fix *)
right();left();  (* case where ?x is true *)
left();right();
rri "0|-|1"; ex();  (* replace ?x with true as allowed by context *)
up(); rri "TRUEBOOL"; ex();
up();ri "AND";ex();
left(); ri "REFLEX"; up(); ex();
rri "BOOLDEF"; ri "TYPES"; ex(); ri "BOOLDEF"; ex();  

(* done with case ?x=true *)

up();right();
left(); ri "BOOLDEF"; ex();
ri "EQUATION"; ex();
ri "1|-|1"; ex();  (* use the local hypothesis 
to resolve the case expression *)

up(); ri "AND"; ex();
(* left(); ri "NONTRIV"; up(); *) ex(); (* ODDCHOICE fix *)
top(); rri "AND"; ex();
p "ANDSCIN";
makescin "&" "ANDSCIN";

(* the difference between ANDBOOL and ANDSCIN is that ANDSCIN demonstrates
that the two inputs of & are each typable, whereas ANDBOOL only shows that
the output is typable.  The "scin" property allows more powerful subversions
of stratification *)

initializecounter();
s "~bool:?x";
ri "CASEINTRO";ex();
assign "?y_1" "true=?x";

(* case 1 *)

right();left();  (* get to case *)
right();right();  (* get to ?x *)
rri "0|-|1"; ex();
up();rri "TRUEBOOL"; ex();
up();ri "NOT";ex();
(* left();ri"REFLEX";up(); *) ex();  (* ODDCHOICE fix *)

(* case 2 *)

up();right();
right(); ri "BOOLDEF"; ex();
ri "EQUATION"; ri "1|-|1"; ex();
up();ri "NOT"; ex();
(* left();ri"NONTRIV";up(); *) ex();  (* ODDCHOICE fix *)
top(); rri "NOT"; ex();
p "NOTBOOLDROP";

(* because ~ is used as a unary operation, there is no advantage to 
establishing that it is "scin" *)

s "(bool:?x)|(bool:?y)";
ri "OR"; ex();
dlls "NOTBOOLDROP"; ri "NOTBOOLDROP"; ex();
top(); dlls "NOTBOOLDROP"; ri "NOTBOOLDROP"; ex();
top(); rri "OR";ex();
p "ORSCIN";
makescin "|" "ORSCIN";

s "(bool:?x)->(bool:?y)";
ri "IF";ex();
dlls "NOTBOOLDROP"; ri "NOTBOOLDROP"; ex();
ri "NOTBOOL"; ex();
top(); ri "ORSCIN"; ex();
rri "IF"; ex();
p "IFSCIN";
makescin "->" "IFSCIN";

s "(bool:?x)==(bool:?y)";
ri "IFF"; ex();
dlls "TYPES"; ri "TYPES"; ex();
top(); dlls "TYPES"; ri "TYPES"; ex();
top(); rri "IFF"; ex();
p "IFFSCIN";
makescin "==" "IFFSCIN";

(* define the assertion operator *)
defineinfix "ASSERT" "|-?x" "bool:?x";

(* show that the assertion operator is "scout" *)
initializecounter();
 s "|-?x";
ri "ASSERT"; ex();
rri "TYPES"; ex();
ri "RIGHT@ $ASSERT"; ex();
p "ASSERTSCOUT";
makescout "|-" "ASSERTSCOUT";

(* the assert symbol is a retraction *)

(*

TWOASSERTS:

|-|-?p = 

|-?p

["ASSERT","TYPES"]

*)

initializecounter();
s "|- |- ?p";
ri "(RIGHT@ASSERT)**ASSERT"; ex();
ri "TYPES"; ex();
rri "ASSERT"; ex();
p "TWOASSERTS";

(*

ASSERT2:

bool : ?x = 

|-?x

["ASSERT"]

*)

s "|-?x";
ri "ASSERT";ex();
workback();
p "ASSERT2";

(* typing lemmas for propositional connectives *)

s "?p==?q";
ri "IFF"; ex();
ri "RL@ $TYPES"; ex();
ri "EQBOOL"; ex();
ri "RIGHT@ $IFF"; ex();
ri "(RIGHT@RL@ASSERT2)**ASSERT2"; ex();
p "BTYPE";

dpt "ALLASSERTS"; 
s "|- |-?x"; ri "TWOASSERTS"; ex();
ri "ALLASSERTS"; p "ALLASSERTS";

defineinfix "XOR" "?x =/= ?y" "~?x==?y";

s "?x=/=?y";
ri "XOR"; ex();
ri "RIGHT@ $IFFSCIN"; ex();
ri "NOTBOOL"; ex();
 ri "RIGHT@ $XOR"; ex();
ri "(RIGHT@RL@ASSERT2)**ASSERT2"; ex();
p "XORTYPE";

(* new on March 9; make =/= "scin" *)

s "(bool:?x)=/=(bool:?y)";
ri "RL@ASSERT2";
ri "XORTYPE"; ex();
right();
ri "RL@TWOASSERTS";
up();
rri "XORTYPE";
ex();
p "XORSCIN";
makescin "=/=" "XORSCIN";

s "?x=/=?y";
ri "XOR**NOTBOOL**RIGHT@ $XOR"; ex();
p "XORBOOL";


s "~?p";
ri "NOTBOOL**ASSERT2"; ex();
right();
ri "($NOTBOOLDROP)**RIGHT@ASSERT2"; ex();
p "NTYPE"; 

s "?p|?q";
ri "($ORSCIN)**RL@ASSERT2"; ex();
ri "ORBOOL**ASSERT2"; ex();
p "DTYPE";

s "?p&?q";
ri "($ANDSCIN)**RL@ASSERT2"; ex();
ri "ANDBOOL**ASSERT2"; ex();
p "CTYPE";

s "?p->?q";
rri "IFSCIN";
ri "RL@ASSERT2"; ex();
ri "IFBOOL";
ri "ASSERT2"; ex();
p "IMPTYPE";

defineinfix "CONVIF" "?p<-?q" "?q->?p";

s "?p<-?q";
ri "CONVIF";
ri "IMPTYPE";
ri "RIGHT@ $CONVIF"; ex();
p "CONTYPE";

(* new March 9:  show that <- is scin *)

s "(bool:?x)<-(bool:?y)";
ri "RL@ASSERT2";
ri "CONTYPE"; ex();
right();
ri "RL@TWOASSERTS";
up();
rri "CONTYPE";
ex();
p "CONSCIN";
makescin "<-" "CONSCIN";

s "?x<-?y";
ri "CONVIF**IFBOOL**RIGHT@ $CONVIF"; ex();
p "CNBOOL";

(* an example with quantifiers *)

s "forall@[forsome@[?1=?2]]";  (* this is "for all x, for some y, x=y" *)

(* this would not be stratified without the assistance of the scin/scout
feature *)

(* start with definitional expansions *)

ri "forall"; ex();
dlls "forsome"; ri "forsome"; ex();
dlls "forall"; ri "forall"; ex();
ri "NOT"; ex();

ri "EQUATION"; ex();
right();left();
ri "BIND@?1"; ex();
ri "LEFT@ $0|-|1"; ex();
ri "EVAL"; ex();
ri "RIGHT@REFLEX"; ex();
ri "NOT"; ex();
ri "LEFT@REFLEX"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); ri "NOT"; ri "LEFT@NONTRIV"; ex();
top(); ri "REFLEX"; ex();
p "EXAMPLE1";




(* some frequently used utilities for dealing with nested case expressions *)

(*

UNPACK:

(?x || ?y , ?z) || ?u , ?v = 

?x || (?y || ?u , ?v) , ?z || ?u , ?v

["CASEINTRO"]

*)


initializecounter();
start "(?x||?y,?z)||?u,?v";
ri "CASEINTRO";ex();
assign "?y_1" "?x";
right(); left();
ri "LEFT@1|-|1"; ex();
up();right();
ri "LEFT@1|-|1"; ex();
p "UNPACK";

(*

BOOLDEF0:  

bool : ?p  =  

?p || true , false

*)

s "bool:?p";
ri "BOOLDEF"; ex();
ri "EQUATION"; ex();
p "BOOLDEF0";

(* double negation result *)

(* completely new proof for Baby *)

(*

DUBNEG:

~~?p = 

bool : ?p

["BOOLDEF","CASEINTRO","EQUATION","NONTRIV","NOT","REFLEX"]

*)

initializecounter();
s "~ ~?p";
ri "RIGHT@NOT"; ex();
ri "NOT"; ex();
right();left(); ri "EVERYWHERE@1|-|1"; ex();
up(); left(); ri "EVERYWHERE@1|-|1"; ex();
top(); ri "UNPACK"; ex();
rri "BOOLDEF0"; ex();

p "DUBNEG";


(*

ANDUNPACK:

(?P & ?Q) || ?x , ?y = 

(true = ?P) || ((true = ?Q) || ?x , ?y) , ?y

["AND","CASEINTRO"]

*)


s "(?P&?Q)||?x,?y";
ri "(LEFT@AND)**UNPACK"; ex();
p "ANDUNPACK";

(*

ASSERT_UNEXP:

?p || true , false = 

|-?p

["ASSERT","BOOLDEF","EQUATION","ODDCHOICE"]


*)

s "?p||true,false";
rri "BOOLDEF0"; ri "ASSERT2"; ex();
p "ASSERT_UNEXP";

(* allows application of type label on left of case expression;
BOOLDEF itself can't be used because of automatic implementation of
ODDCHOICE *)

(*

BOOLDEF2:  

(bool : ?x) || ?y , ?z  =  

?x || ?y , ?z

*)

s "(bool:?x)||?y,?z";
ri "LEFT@BOOLDEF"; ex();
p "BOOLDEF2";

(* the arguments of forall and forsome2 can be labelled as boolean *)

(*

FORALLBOOL2:

forall @ [bool : ?P @ ?1] = 

forall @ [?P @ ?1]

["BOOLDEF","CASEINTRO","EQBOOL","EQUATION","REFLEX","forall"]

*)

initializecounter();
start "forall@[bool:?P@?1]";
ri "forall"; ex();
ri "CASEINTRO"; ex();
assign "?y_2" "[?P@?1]=[true]";
right();left();
left();right();right();
ri "BIND@?1";ex();
ri "LEFT@0|-|1"; ex();
ri "EVAL"; ex();
up();
rri "TRUEBOOL"; ex();
up();up();
ri "REFLEX"; ex();
up();right();
ri "EQUATION"; ex();
right();left();
rri "1|-|1"; ex();
assign "?x_8" "false";
left();left();left();
ri "PCASEINTRO@?P@?1"; ex();  (* Baby is more finicky than Mark2 about
					introducing new variables as funs *)
right();left();
rri "0|-|3"; ex();
ri "TRUEBOOL"; ri "RIGHT@0|-|3"; ex();
up();up();left();up();
rri "BOOLDEF2"; ex();
left(); ri "(BIND@?1)**(LEFT@0|-|2)**EVAL"; ex();
up();ex();
up();up();up();
ri "1|-|2"; ex();
up();up();
rri "CASEINTRO"; ex();
top();
ri "($EQUATION)**($forall)"; ex();
assign "?P" "[?P@?1]";
p "FORALLBOOL2";

(*

FORSOMEBOOL2:

forsome @ [bool : ?P @ ?1] = 

forsome @ [?P @ ?1]

*)

s "forsome@[bool:?P@?1]";
ri "forsome"; ex();
right();right();right();
ri "NOTBOOLDROP";ex();
top();
rri "forsome2"; ex();
p "FORSOMEBOOL2";

quit();




















