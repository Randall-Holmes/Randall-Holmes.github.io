(* August 19, 1997 (as part of general overhaul) *)

script "logic_tools";
script "tableau2";

(* this file begins the development of Gries chapter 9 *)

(* quantifiers with range *)

defineconstant "forallr@?x" "forall@[((P1@?x)@?1)->((P2@?x)@?1)]";

(* the definition has to have universal range to be made scout *)

s "forallr@?x";
ri "forallr";
ri "FORALLBOOL"; ex();
right();
rri "forallr"; ex();
p "FORALLRBOOL";

makescout "forallr" "FORALLRBOOL";

(* version of forallr with pairs and which won't pop brackets off *)

(*

forallr2:

forallr @ [?R @ ?1] , [?P @ ?1] = 

forall @ [(?R @ ?1) -> ?P @ ?1]

["BOOLDEF","CASEINTRO","EQBOOL","EQUATION","IF","NONTRIV","NOT","OR","P1","P2","REFLEX","forallr"]

*)

s "forallr@[?R@?1],[?P@?1]";
ri "forallr"; ex();
right();right();
ri "EVERYWHERE@PI1**PI2**EVAL"; ex();
p "forallr2";

defineconstant "forsomer@?x" "~forallr@(P1@?x),[~(P2@?x)@?1]";

(* the definition has to have universal range to be made scout *)

s "forsomer@?x";
ri "forsomer";
ri "NOTBOOL"; ex();
right();
rri "forsomer"; ex();
p "FORSOMERBOOL";

makescout "forsomer" "FORSOMERBOOL";

(* version of forsomer with pairs and which won't pop brackets off *)

(*

forsomer2:

forsomer @ [?R @ ?1] , [?P @ ?1] = 

~forallr @ [?R @ ?1] , [~?P @ ?1]

["CASEINTRO","EQBOOL","NONTRIV","NOT","P1","P2","REFLEX","forsomer"]

*)

s "forsomer@[?R@?1],[?P@?1]";
ri "forsomer"; ex();
ri "EVERYWHERE@PI1**EVAL"; ex();
right();right();right();right();
ri "EVERYWHERE@PI2**EVAL"; ex();
p "forsomer2";

(* the natural theorem for ranged existential quantification *)

(*

forsomer3:

forsomer @ [?R @ ?1] , [?P @ ?1] = 

forsome @ [(?R @ ?1) & ?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forallr","forsome","forsomer"]

*)

s "forsomer@[?R@?1],[?P@?1]";
ri "forsomer2"; ex();
right();
ri "forallr2"; ex();
right();right();
ri "IDEF2"; ex();
ri "DEMa"; ex();
uptors "forsome2";
rri "forsome2"; ex();
p "forsomer3";

(* [true] is the universal range *)

(*

UNIV_RANGE_1:

forallr @ [true] , [?P @ ?1] = 

forall @ [?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","P1","P2","REFLEX","TYPES","XOR","forall","forallr"]

*)

s "forallr@[true],[?P@?1]";
ri "forallr2"; ex();
right();right();
ri "ILID"; ex();
ri "ASSERT"; ex();
top();
ri "FORALLBOOL2"; ex();
p "UNIV_RANGE_1";

(* a proof of Gries's One-Point Rule for universal quantification;
there really ought to be a shorter proof! *)

(*

ONEPOINT:

forallr @ [?1 = ?e] , [?P @ ?1] = 

|-EVAL => ?P @ ?e

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","P1","P2","REFLEX","TYPES","XOR","forall","forallr"]

*)

s "forallr@[?1=?e],[?P@?1]";
ri "forallr2"; ex();
right();right();
ri "TAB_IF"; ex();
right();left();left();right();
ri "0|-|1"; ex();
upto "[?P@?1]"; right();
rri "TAB_IF"; ex();
top();
ri "PCASEINTRO@(true=?P@?e)"; ex();
right();left();
right();right();right();
rri "0|-|1"; ex();
up();
ri "TAB_IF** $CASEINTRO"; ex();
up();up();
ri "FORALLDROP**AT"; ex();
up();right();
initializecounter();
rri "INSTANTIATE"; ex();
assign "?x_1" "?e";
left();
ri "EVAL"; ex();
ri "(LEFT@REFLEX)**TAB_IF"; ex();
ri "ODDCHOICE"; ex();
ri "1|-|1"; ex();
up();
ri "TAB_AND"; ex();
up();up();
rri "ODDCHOICE"; ex();
ri "ASSERT_UNEXP"; ex();
right(); ri "EVAL";
p "ONEPOINT";

(* tactics which convert between theorems of the forms
(|-?p) = ?p&?q and (?p->?q)=true *)

(* ?thm is expected to be of the form (|-?p) = ?p&?q *)

s "?p->?q";
ri "$IRULE2";
ri "LEFT@?thm";
ri "3pt76b";
prove "CONVERT_IMP_1@?thm";

(* ?thm is expected to be of the form (?p->?q) = true
Note that ?q needs to be supplied as a parameter along with ?thm *)

s "|-?p";
rri "CID"; ex();
right();
ri "DXMF@?q"; ex();
top();
ri "CDISD"; ex();
right();
rri "CRULE2"; ex(); 
ri "LEFT@ $DUBNEG2"; ex();
ri "DEMb"; ex();
right();
rri "IDEF2"; ex();
ri "?thm";
up();
rri "FDEF";
up();
ri "DID";
ri "CRULE1";
p "CONVERT_IMP_2@?thm,?q";

(* I will prove the "range free" form of Gries's theorem 9.12 *)

(*

PRE9pt12:

(forall @ [(?P @ ?1) -> ?Q @ ?1]) 
-> (forall @ [?P @ ?1]) -> forall @ [?Q @ ?1] = 

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall"]

*)

s "(forall@[(?P@?1)->?Q@?1])->(forall@[?P@?1])->forall@[?Q@?1]";
ri "3pt65"; ex();
left();
rri "FORALLDIST"; ex();
right();right();
ri "CSYM";
ri "3pt66"; ex();
up();up();
ri "FORALLDIST"; ex();
up();
ri "(LEFT@CSYM)**3pt76b"; ex();
p "PRE9pt12";

(* implementation of Gries metatheorem 9.16 as a pair of tactics *)

(* here is a tactic for one direction of 9.16;
?thm is presumed to be a theorem of the form forall@[?P@?1] = true *)

(* 9pt16a1 is a subtactic of 9pt16a (and does most of its work) *)

(*

9pt16a1 @ ?thm:

?P @ ?x = 

(LEFT @ ?thm) => (forall @ [?P @ ?1]) || true 
, [?P @ ?1] @ ?x

["CASEINTRO","forall"]

*)

s "?P@?x";
ri "BIND@?x"; ex();
ri "PCASEINTRO@[?P@?1]=[true]"; ex();
right();left();
ri "(LEFT@0|-|1)**EVAL"; ex();
top();
ri "LEFT@ $forall2"; ex();
ri "LEFT@?thm";
prove "9pt16a1@?thm";

(*

9pt16a @ ?x , ?thm:

?y = 

(9pt16a1 @ ?thm) => (BIND @ ?x) => ?y

["CASEINTRO","forall"]

*)

s "?y";
ri "BIND@?x";
ri "9pt16a1@?thm";
prove "9pt16a@?x,?thm";

(* the first parameter is the variable on which we are to quantify *)

(* the other direction of 9.16; here ?thm is assumed to be of the form
?P@?x = true *)

(*

9pt16b @ ?thm:

forall @ [?P @ ?1] = 

(FORALLDROP ** AT) => forall @ [?thm => ?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall"]

*)

s "forall@[?P@?1]";
right();right();
ri "?thm";
top();
ri "FORALLDROP**AT"; 
p "9pt16b@?thm";


(* tactics implementing Gries 9.30 *)

(* we assume that ?thm is a theorem of the form (forsome @ [?P @ ?1])
-> ?Q = true *)

s "(?P@?x)->?Q";
ri "BIND@?x"; ex();
ri "PCASEINTRO@[(?P @ ?1) -> ?Q]=[true]";ex();
right();left();
ri "(LEFT@0|-|1)**EVAL"; ex();
top();left();
rri "forall"; ex();
ri "FORALL_IMP_FORSOME_EQ"; ex();
top();
ri "LEFT@?thm";
p "9pt30a@?thm";

(* here, we assume that ?thm is a theorem of the form ((?P@?x)->?Q)=true *)

s "(forsome @ [?P @ ?1]) -> ?Q";
rri "FORALL_IMP_FORSOME_EQ"; ex();
right();right();
ri "?thm";
top();
ri "FORALLDROP**AT";
p "9pt30b@?thm";

(* the point is that the tactics allow theorems of each of these
forms to be converted to theorems of the other form *)

quit();







