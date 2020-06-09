(* basic declarations and definitions for Math 387 labs *)

(* structural tactics *)

declareopaque "^+";

declareunaryopaque "^-";

(* tactic for application to left subterm *)

s "?x ^+ ?y";
left(); ri "?thm";
p "LEFT1@?thm";

s "?x || ?y , ?z";
left(); ri "?thm";
p "LEFT2@?thm";

s "?x";
ri "LEFT1@?thm";
ari "LEFT2@?thm";
p "LEFT@?thm";

(* tactic for application to right subterm *)

s "?x ^+ ?y";
right(); ri "?thm";
p "RIGHT1@?thm";

s "^- ?x";
right(); ri "?thm";
p "RIGHT2@?thm";

s "?x";
ri "RIGHT1@?thm";
ari "RIGHT2@?thm";
p "RIGHT@?thm";

(* tactic for application to both subterms *)

s "?x^+?y";
right(); ri "?thm";
up();left(); ri "?thm";
p "RL@?thm";

(* tactic for application to left case *)

s "?x || ?y,?z";
right(); left(); ri "?thm";
p "LEFT_CASE@?thm";

(* tactic for application to right case *)

s "?x || ?y , ?z";
right(); right(); ri "?thm";
p "RIGHT_CASE@?thm";

(* tactic for application to both cases *)

s "?x || ?y,?z";
right(); left(); ri "?thm";
top(); right(); right(); ri "?thm";
p "BOTH_CASES@?thm";

(* application inside brackets *)

s "[?P@!?1]";
right(); ri "?thm@?1";
p "VALUE@?thm";

(* composition of theorems *)

s "?x";
ri "?thm1";
ri "?thm2";
p "?thm1**?thm2";

(* conversion of theorems *)

s "?x";
rri "?thm";
p "$?thm";

(* bottom-up aggressive rewriting *)

dpt "EVERYWHERE";

s "?x ^+ ?y";
right(); ri "EVERYWHERE@?thm";
up(); left(); ri "EVERYWHERE@?thm";
top(); ri "?thm";
p "EVERYWHERE_INFIX@?thm";

s "^- ?x";
right(); ri "EVERYWHERE@?thm";
top(); ri "?thm";
p "EVERYWHERE_PREFIX@?thm";

s "[?P@!?1]";
right(); ri "EVERYWHERE@?thm";
top(); ri "?thm";
p "EVERYWHERE_ABSTRACT@?thm";

s "?x||?y,?z";
left(); ri "EVERYWHERE@?thm";
up(); right(); left(); ri "EVERYWHERE@?thm";
up(); right(); ri "EVERYWHERE@?thm";
top(); ri "?thm";
p "EVERYWHERE_CASES@?thm";

s "?x";
ri "EVERYWHERE_INFIX@?thm";
ari "EVERYWHERE_PREFIX@?thm";
ari "EVERYWHERE_ABSTRACT@?thm";
ari "EVERYWHERE_CASES@?thm";
ari "?thm";
p "EVERYWHERE@?thm";

(* top-down aggressive rewriting *)
(* upgraded to work inside abstracts *)

dpt "TOPDOWN";

s "?a||?x,?y";
ri "?thm";
ri "LEFT@?thm";
ri "BOTH_CASES@TOPDOWN@?thm";
prove "TOPDOWN_CASE@?thm";

s "?x^+?y";
ri "?thm";
ri "RL@TOPDOWN@?thm";
prove "TOPDOWN_INFIX@?thm";

s "^-?x";
ri "?thm";
ri "RIGHT@TOPDOWN@?thm";
prove "TOPDOWN_PREFIX@?thm";

s "[?P@!?1]";
ri "?thm";
ri "VALUE@[?thm]";
prove "TOPDOWN_ABSTRACT@?thm";

s "?x";
ri "TOPDOWN_CASE@?thm";
ari "TOPDOWN_INFIX@?thm";
ari "TOPDOWN_PREFIX@?thm";
ari "TOPDOWN_ABSTRACT@?thm";
ari "?thm";
prove "TOPDOWN@?thm";

(* conditional rewriting tools *)

dpt "ALT_PUSH";

s "?x||?y,?z";
right(); left(); ri "ALT_PUSH"; ri "EVERYWHERE@1|-|1";
up(); right(); ri "ALT_PUSH"; ri "EVERYWHERE@1|-|1";
prove "ALT_PUSH";

s "?x||?y,?z";
right(); left(); ri "EVERYWHERE@0|-|1"; 
prove "PIVOT";

s "?x||?y,?z";
right(); left(); ri "EVERYWHERE@ $0|-|1"; 
prove "REVPIVOT";

(* definitions of logical connectives *)

defineinfix "ASSERT" "|-?p" "?p||true,false";

defineinfix "NOT" "~?p" "?p||false,true";

defineinfix "AND" "?p&?q" "?p||(?q||true,false),false";

defineinfix "OR" "?p|?q" "?p||true,?q||true,false";

defineinfix "IF" "?p->?q" "?p||(?q||true,false),true";

defineinfix "CONVIF" "?p<-?q" "?p||true,?q||false,true";

defineinfix "IFF" "?p<->?q" "?p||(?q||true,false),?q||false,true";

defineinfix "XOR" "?p<+>?q" "?p||(?q||false,true),?q||true,false";

(* precedence of logical connectives *)

(* negation  and assertion *)

setprecedence "~" 6;

setprecedence "|-" 6;

(* conjunction and disjunction *)

setprecedence "&" 4;

setprecedence "|" 4;

(* implication and converse implication *)

setprecedence "->" 2;

setprecedence "<-" 2;

(* biconditional and xor *)

setprecedence "<->"  0;

setprecedence "<+>"  0;

(* definition of inequality *)

defineinfix "NEQ" "?x<>?y" "(?x=?y)||false,true";

(* definitions of quantifiers *)

defineconstant "forall@?P" "?P = [true]";
defineconstant "forsome@?P" "?P <> [false]";

(* note for students:  the definition of the existential
quantifier is rather odd for technical reasons *)

(* the deMorgan theorem would be forsome@[?P@!?1] =
~forall@[false=?P@!?1], which is technically weird --
better is ~forall@[~?P@!?1] = forsome@[|-?P@!?1] *)

(* since these are the right quantifiers for the unstratified theory,
let's try doing the development from these and see how it goes. *)

quit();



