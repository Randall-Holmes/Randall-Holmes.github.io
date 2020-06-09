(* demonstration for Pentico *)

declareinfix "+";

axiom "PLUSCOMM" "?x+?y" "?y+?x";

axiom "PLUSASSOC" "(?x+?y)+?z" "?x+?y+?z";

declareopaque "^+";

s "?x^+?y";
right(); ri "?thm";
p "RIGHT@?thm";

(* develop associativity tactic *)

dpt "PLUSASSOCS"; 
s "(?x+?y)+?z";
ri "PLUSASSOC"; ex();
ri "PLUSASSOCS";
prove "PLUSASSOCS";

dpt "ALLPLUSASSOCS";
s "?x+?y";
ri "PLUSASSOCS";
ri "RIGHT@ALLPLUSASSOCS";
p "ALLPLUSASSOCS";

defineinfix "AND" "?x&?y" "?x||(?y||true,false),false";
defineinfix "ASSERT" "|-?x" "?x||true,false";

s "?p&?p";
ri "AND"; ex();
right(); left(); ri "1|-|1"; ex();
top(); rri "ASSERT"; ex();
p "CONJ_IDEM";

s "?x";
initializecounter();
ri "CASEINTRO"; ex();
assign "?y_1" "?y";
p "PCASEINTRO@?y";

s "?p&?q";
ri "AND"; ex();
ri "PCASEINTRO@?q"; ex();
right(); left(); right(); left(); ri "1|-|1"; ex();
top(); right(); right(); right(); left(); ri "1|-|1"; ex();
up(); up(); rri "CASEINTRO"; ex();
top(); rri "AND"; ex();
p "CONJ_COMM"; 

(* load a pre-existing theory with a complete tautology checker *)

load "logicdefs2";

s "(?p&?q&?r)->?q";
ri "NEWTAUT"; ex();

startover();
ri "NEWTAUT"; steps();