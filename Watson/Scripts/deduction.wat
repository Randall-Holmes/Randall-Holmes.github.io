(* movement commands simulated *)

(* a simulation of a natural deduction prover using the INPUT
command; to supersede the very rough geb.wat treatment *)

script "sequent";  (* incorporate all available logic *)

(* develop a tactic INPUTS for repeated application of theorems
until a goal is reached *)

(* add an INPUT driven sequent prover as well *)

defineconstant "breakout@?x" "?x";

ae "breakout";
wb();
p "BREAKOUT";

s "?x.?x";
ri "IGNOREFIRST";
p "GOAL_DONE";

s "?x.breakout@?y";
ri "(RIGHT@breakout)**IGNOREFIRST";
p "GOAL_ABORTED";

dpt "INPUTS";

s "?x.?y";
ri "RIGHT@INPUT";
ri "GOAL_DONE"; ari "GOAL_ABORTED"; ari "INPUTS";
p "INPUTS";

s "true";
ri "OUTPUT@?x";
p "ANNOUNCE@?x";

(* convenient form for hypotheses *)

s "?x";
rri "0|-|?n";
p "PREMISE@?n";

(* labels for communication with user *)

defineconstant "done@?x" "?x";

defineconstant "halfdone@?x" "?x";

(* tactics for handling logical connectives *)

(* tactics for proving goals with various connectives;
the term we look at will always have |- at the front *)

(* conjunction *)

s "|-?x&?y";
right(); rri "CRULE2"; rri "CRULE3"; ex();
left(); ri "(!$IGNOREFIRST)@true";  ex(); ri "INPUTS";
ri "ANNOUNCE@halfdone@?x&?y";
up(); right(); ri "(!$IGNOREFIRST)@true"; ex(); ri "INPUTS";
ri "ANNOUNCE@done@?x&?y";
up(); ri "CID**AT";
up(); ri "AT";
p "ANDGOAL";

(* implication *)

s "|-?x->?y";
right(); rri "IRULE2"; rri "IRULE3"; ex();
ri "TAB_IF"; ex();
right(); left(); ri "ASSERT_UNEXP**TWOASSERTS"; ex();
ri "(!$IGNOREFIRST)@true"; ex();
ri "INPUTS";
ri "ANNOUNCE@done@?x->?y";
top(); right(); rri "CASEINTRO";
top(); ri "AT";
p "IFGOAL";

(* negation *)

s "|- ~?p";
right(); rri "3pt74"; ex();
top(); ri "IFGOAL";
ri "ANNOUNCE@done@ ~?p";
p "NOTGOAL";

(* disjunction *)

s "|-?x|?y";
right();ri "PROVETAUT2@(~?x)->?y"; ex();
ri "(LEFT@DUBNEG2)**IRULE2";
up(); ri "IFGOAL";
ri "ANNOUNCE@done@?x|?y";
p "ORGOAL";

(* biequivalence *)

s "|-?x==?y";
right(); rri "3pt80"; ex();
top(); ri "ANDGOAL";
ri "ANNOUNCE@done@?x==?y";
p "IFFGOAL";

(* structural maneuvers *)

(* swapping disjuncts *)

s "|-?x|?y";
ri "RIGHT@DSYM"; ex();
p "SWAP_DISJUNCTS";

(* double negation *)

s "|- ~ ~?p";
ri "(RIGHT@DUBNEG2)**TWOASSERTS"; ex();
p "DOUBLE_NEGATION";

(* negations of complex terms *)

s "|- ~?x&?y";
right(); rri "DEMa"; ex();
p "NOTAND";

s "|- ~?x|?y";
right(); rri "DEMb"; ex();
p "NOTOR";

s "|- ~?x->?y";
right(); ri "PROVETAUT2@?x & ~?y"; ex();
p "NOTIF";

(* contrapositive *)

s "|-?x->?y";
right(); ri "CONTP"; ex();
ri "RL@DUBNEG2";
ri "IRULE2**IRULE3";
p "CONTRAPOSITIVE";

(* modus ponens *)

s "|-?x";
ri "PROVETAUT2@?x|?y&?y->?x"; ex();
right(); rri "CRULE2"; rri "CRULE3"; ex(); left(); 
ri "(!$IGNOREFIRST)@true";
ri "INPUTS";
ri "ANNOUNCE@done@?y";
up(); right(); 
ri "(!$IGNOREFIRST)@true";
ri "INPUTS";
ri "ANNOUNCE@done@?y->?x";
top(); ri "(RIGHT@CID**AT)**DZER";
p "MODUS_PONENS@?y";

(* using hypotheses with given connectives *)

(* conjunction *)

s "|-?x";
rri "(2|-|?n)@true";
ri "LEFT@CRULE1";
ri "TAB_AND_2";
ari "1|-|?n";  (* undoes things if form was wrong *)
ri "ASRTCOND"; ri "LEFT_CASE@ASRTCOND";
ri "LEFT_CASE@LEFT_CASE@(!$IGNOREFIRST)@true";
ri "LEFT_CASE@LEFT_CASE@INPUTS";
ri "LEFT_CASE@ $CASEINTRO";
rri "CASEINTRO";
p "ANDHYP@?n";

(* disjunction *)

s "|-?x";
rri "(2|-|?n)@true";
ri "LEFT@DRULE1";
ri "OR_EXP"; ari "1|-|?n"; ri "ASRTCOND";
ri "LEFT_CASE@(!$IGNOREFIRST)@true";
ri "LEFT_CASE@INPUTS";
rri "ASRTCOND"; rri "TAB_NOT_2"; ri "LEFT@DUBNEG2"; rri "ASRTCOND";
	ri "ASRTCOND"; ri "LEFT_CASE@ASRTCOND";
ri "LEFT_CASE@LEFT_CASE@(!$IGNOREFIRST)@true";
ri "LEFT_CASE@LEFT_CASE@INPUTS";
ri "LEFT_CASE@ $CASEINTRO";
rri "CASEINTRO";
p "ORHYP@?n";

(* negation *)

(* this is a funny maneuver *)

s "|-?x";
rri "ASSERT_UNEXP"; rri "TAB_NOT_2"; ri "ASRTCOND"; ex();
right(); left(); rri "(2|-|?n)@true"; rri "ASRTCOND"; ri "TAB_NOT_2";
	ri "ASRTCOND";
ri "1|-|?n"; ari "LEFT@((!$IGNOREFIRST)@true)**INPUTS";
rri "CASEINTRO";
top(); rri "CASEINTRO"; 
rri "ASRTCOND"; ri "TAB_NOT_2"; ri "ASSERT_UNEXP";
p "NEGHYP@?n";

(* IFHYP is handled by modus ponens *)

(* biequivalence *)

s "|-?x";
rri "(2|-|?n)@true"; rri "ASRTCOND"; ri "LEFT@ $3pt80"; 
ri "ASRTCOND"; ri "1|-|?n"; rri "ASRTCOND";
ri "TAB_AND_2";
ri "ASRTCOND"; ri "LEFT_CASE@ASRTCOND";
ri "LEFT_CASE@LEFT_CASE@(!$IGNOREFIRST)@true";
ri "LEFT_CASE@LEFT_CASE@INPUTS";
ri "LEFT_CASE@ $CASEINTRO";
rri "CASEINTRO";
p "IFFHYP@?n";

(* now for quantifiers! *)

s "|-forall@[?P@?1]";
right(); rri "FORALLBOOL2"; ex();
right(); right(); ri "ASSERT2"; ex();
ri "(!$IGNOREFIRST)@true"; ex();
ri "INPUTS";
ri "ANNOUNCE@done@forall@[?P@?1]";
top(); right(); ri "FORALLDROP**AT";
top(); ri "AT";
p "UNIV_GOAL";

s "|-forsome@[?P@?1]";
right(); ri "(!$DINSTANTIATE)@?x";
ri "LEFT@EVAL"; ri "DSYM"; rri "DRULE3"; ex();
right(); ri "RIGHT@EVAL"; ri "(!$IGNOREFIRST)@true"; ri "INPUTS";
ri "ANNOUNCE@done@forsome@[?P@?1]";
top(); right(); ri "DZER";
top(); ri "AT";
p "EXIST_GOAL@?x";

(* 

s "?x||?y,?z";
right(); left(); ri "LEFT@0|-|1";
p "TWIDDLE";

s "(|-forall@[?P@?1])||?x,?y";
right(); left(); ri "UNEVAL@[?P@?1]";
p "TWIDDLE2"; 

s "|-?x";
right(); 
rri "(2|-|?n)@true"; ri "TWIDDLE2";
rri "ASRTCOND";
ri "LEFT@forall"; ri "TWIDDLE";
ri "ASRTCOND"; ri "1|-|?n"; rri "ASRTCOND";
ri "LEFT_CASE@EVAL";
rri "CASEINTRO";
ri "LEFT@ $forall2"; ri "ASRTCOND"; ri "1|-|?n";
top(); ri "AT";
p "UNIV_HYP@?n";

*)

(* How to fix this to make iterated universal quantifiers work? *)

s "([?P@?1]=[true])||?x,true";
right(); left(); ri "UNEVAL@[?P@?1]"; ri "LEFT@0|-|1"; ri "EVAL";
rri "CASEINTRO";
p "NEWTWIDDLE";

s "|-?x";
right(); rri "(2|-|?n)@true";
rri "ASRTCOND"; ri "LEFT@forall";
ri "NEWTWIDDLE";
ri "LEFT@ $forall2"; ri "ASRTCOND"; ri "1|-|?n";
top(); ri "AT";
p "UNIV_HYP@?n";

(* subtactic to apply a universal hypothesis 
with arbitrarily many quantifiers, given the instantiations *)

dpt "FORALLCHECK";

s "(forall@[?P@?1])||?x,?y";
ri "LEFT@forall"; ex();
right(); left(); ri "BIND@?a"; ri "LEFT@0|-|1";
ri "LEFT@VALUE@[PCASEINTRO@?P@?1]"; ri "LEFT@VALUE@[FORALLCHECK@?L]"; 
ri "LEFT@VALUE@[LEFT@(BIND@?1)**(LEFT@0|-|1)**EVAL]";
ri "EVAL";
top(); ri "LEFT@ $forall";
p "FORALLCHECK@?a,?L";

s "|-?x";
right(); rri "(2|-|?n)@true";
rri "ASRTCOND"; ri "FORALLCHECK@?L"; ri "ASRTCOND"; ri "1|-|?n";
top(); ri "AT";
p "NESTED_UNIV_HYP@?n,?L";

s "|-?x";
rri "(2|-|?n)@true"; 
rri "ASRTCOND"; 
ri "LEFT_CASE@ $ASSERT_UNEXP";
rri "TAB_IF";
rri "FORALL_IMP_FORSOME_EQ"; 
ari "TAB_IF**(LEFT_CASE@ASSERT_UNEXP)**ASRTCOND**1|-|?n";
rri "FORALLBOOL2";
ri "RIGHT@VALUE@[ASSERT2**IFGOAL]";
ri "FORALLDROP**AT";
p "EXIST_HYP@?n";

(* negations of quantifiers *)

s "|- ~forall@[?P@?1]";	
right(); ri "FORSOME_NOTFORALL"; ex();
p "NOT_UNIV";

s "|- ~forsome@[?P@?1]";
right(); ri "FORALL_NOTFORSOME"; ex();
p "NOT_EXIST";

(* tactics for use of equations needed *)

s "|-?p";
rri "(2|-|?n)@false";
rri "ASRTCOND";
ri "PIVOT";
ri "ASRTCOND";
ri "1|-|?n";
p "HYP_PIVOT@?n";

s "|-?p";
rri "(2|-|?n)@false";
rri "ASRTCOND";
ri "REVPIVOT";
ri "ASRTCOND";
ri "1|-|?n";
p "HYP_REVPIVOT@?n";

(* use a theorem *)

s "|-?p";
right(); ri "?thm";
up(); ri "AT";
p "USE_THM@?thm";

(* a sample proof using the tools developed here *)

(* the funny text at the end is read at INPUT prompts --
you need a recent version of the prover to handle this input *)

s "|- (forsome @ [(?P @ ?1) | ?Q @ ?1]) == (forsome @ [?P @ ?1]) | forsome @ [?Q @ ?1]";
ri "IFFGOAL"; ex();

IFGOAL
EXIST_HYP@1
ORHYP@2
ORGOAL
NEGHYP@4
EXIST_GOAL@?1
PREMISE@3
ORGOAL
EXIST_GOAL@?1
PREMISE@4
IFGOAL
ORHYP@1
EXIST_HYP@2
EXIST_GOAL@?1
ORGOAL
NEGHYP@4
PREMISE@3
EXIST_HYP@3
EXIST_GOAL@?1
ORGOAL
PREMISE@4


quit();

















