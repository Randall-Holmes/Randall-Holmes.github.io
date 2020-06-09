(* declarations organized and commented and computation axioms added
May 22 *)

(* modified May 17 to exploit UNEVAL *)

(* modified further May 18-19 during Moscow visit *)

(* comment, May 18:  write a tactic to change ?1 to Nat:?1 so that
INDUCTION can be applied --done? *)

(* file for Peano arithmetic *)

(* now contains most basic axioms of algebra of natural numbers *)



script "new.quantifiers";

script "typestuff";



(* type of natural numbers *)

declareconstant "Nat";

declareinfix "+";

declareinfix "*";

declareinfix "-";

(* type axioms for constants and operations *)

axiom "ZERONAT" "0" "Nat:0";

axiom "ONENAT" "1" "Nat:1";

axiom "PLUSTYPE" "?x+?y" "Nat:(Nat:?x)+Nat:?y";

axiom "TIMESTYPE" "?x*?y" "Nat:(Nat:?x)*Nat:?y";

axiom "MINUSTYPE" "?x-?y" "Nat:(Nat:?x)-Nat:?y";

(* computation axioms *)

axiom "PLUSCOMP" "?x+?y" "?x+!?y";

axiom "TIMESCOMP" "?x*?y" "?x*!?y";

axiom "MINUSCOMP" "?x-?y" "?x-!?y";

(* zero is not a successor *)

axiom "SUCCNOTZERO" "0=?x+1" "false";

(* recursive definition of addition *)

axiom "PLUSID" "?x+0" "Nat:?x";

axiom "PLUSSUCC" "?x+?y+1" "(?x+?y)+1";

(* recursive definition of multiplication *)

axiom "TIMESZERO" "?x*0" "0";

axiom "TIMESSUCC" "?x*?y+1" "(?x*?y)+?x";

(* recursive definition of predecessor *)

axiom "ZEROMINUS" "0-1" "0";

axiom "PLUSMINUS" "(?x+1)-1" "Nat:?x";

(* recursive definition of natural number subtraction *)

axiom "MINUSZERO" "?x-0" "Nat:?x";

axiom "MINUSSUCC" "?x-?y+1" "(?x-?y)-1";

(* the induction axiom *)

axiom "INDUCTION" "forall@[?P@Nat:?1]" "(?P@0)&forall@[(?P@Nat:?1)->?P@?1+1]";

(* typing tactic -- type the parameter where found as a Nat *)

dpt "TYPEX";

s "?x+?y";
ri "TADDLEFT@PLUSTYPE"; ex();
p "TYPEXPLUSLEFT@?x";

s "?x*?y";
ri "TADDLEFT@TIMESTYPE"; ex();
p "TYPEXTIMESLEFT@?x";

s "?x-?y";
ri "TADDLEFT@MINUSTYPE"; ex();
p "TYPEXMINUSLEFT@?x";

s "?x+?y";
ri "TADDRIGHT@PLUSTYPE"; ex();
p "TYPEXPLUSRIGHT@?y";

s "?x*?y";
ri "TADDRIGHT@TIMESTYPE"; ex();
p "TYPEXTIMESRIGHT@?y";

s "?x-?y";
ri "TADDRIGHT@MINUSTYPE"; ex();
p "TYPEXMINUSRIGHT@?y";

s "?y";
ri "RL@EVERYWHERE2@TYPEX@?x";
ri "VALUE@[EVERYWHERE2@TYPEX@?x]";
ri "TYPEXPLUSLEFT@?x";
ri "TYPEXTIMESLEFT@?x";
ri "TYPEXMINUSLEFT@?x";
ri "TYPEXPLUSRIGHT@?x";
ri "TYPEXTIMESRIGHT@?x";
ri "TYPEXMINUSRIGHT@?x";
p "TYPEX@?x";

(* induction setup *)

s "forall@[?P@?1]";
right(); right(); ri "TYPEX@?1";
ri "BIND@Nat:?1";
p "INDSETUP";

(* completed induction tactic *)

s "forall@[?P@?1]";
ri "INDSETUP";
ri "INDUCTION";
ri "EVERYWHERE2@EVAL";
p "IND_TAC";

(* originally an axiom; proved when predecessor was introduced
as an operation *)

(*

SAMESUCC:

(?x + 1) = ?y + 1 = 

(Nat : ?x) = Nat : ?y

["CASEINTRO","EQUATION","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]

*)

s "(?x+1)=?y+1";
ri "PCASEINTRO@(Nat:?x)=Nat:?y"; ex();
right();left(); 
ri "LEFT@(TADDLEFT@PLUSTYPE)**(LEFT@0|-|1)**TREMLEFT@PLUSTYPE"; ex();
ri "REFLEX"; ex();
up(); right(); ri "EQUATION"; ex();
right(); left();
rri "(2|-|1)@false"; ex();
left(); ri "LEFT@($PLUSMINUS)**(LEFT@0|-|2)**PLUSMINUS"; ex();
ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); rri "EQUATION"; ex();
prove "SAMESUCC";


(*

ZEROCOMM:

?x + 0 = 

0 + ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TYPES","XOR","forall"]

*)

s "?x+0";
ri "PCASEINTRO@forall@[(?1+0)=(0+?1)]"; ex();
(* ri "LEFT@forall"; ex();
right();left(); ri "PCASEINTRO@(?x+0)=0+?x"; ex();
ri "PIVOT"; ex();
left(); ri "BIND@?x"; ri "LEFT@0|-|1"; ri "EVAL"; ex();
top(); ri "LEFT@ $forall"; ex(); *)
ri "UNIV_EQ_TAC"; ex(); (* this replaces the commented lines *)
left();
(* left();right();right();
ri "(LEFT@TADDLEFT@PLUSTYPE)**(RIGHT@TADDRIGHT@PLUSTYPE)"; ex();
ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ex();  
ri "EVERYWHERE2@EVAL"; ex(); *)
ri "IND_TAC"; ex();
ri "LEFT@REFLEX"; ex();
ri "CSYM**CID"; ex();
right();right();right();
ri "EVERYWHERE@PLUSID"; ri "EVERYWHERE@TYPES"; ex();
ri "TAB_IF"; ex();
right();left();left();right();
ri "PLUSSUCC"; ex();
up(); ri "LEFT@TREMTOP@PLUSTYPE"; ri "SAMESUCC"; ex();
ri "RIGHT@(TREMTOP@PLUSTYPE)**TADDRIGHT@PLUSTYPE"; ex();
up(); ri "1|-|1"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); up(); ri "forall**REFLEX"; ex();
up(); ri "AT"; up(); ex();
p "ZEROCOMM";

(*

TIMESID:

?x * 1 = 

Nat : ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","ONENAT","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TIMESSUCC","TIMESZERO","TYPES","XOR","forall"]

*)

s "?x*1";
right();
ri "ONENAT"; ex();
rri "PLUSID"; ex();
ri "ZEROCOMM"; ex();
up(); ri "TIMESSUCC"; ex();
ri "LEFT@TIMESZERO"; ex();
ri "($ZEROCOMM)**PLUSID"; ex();
prove "TIMESID";


(*

ONECOMM:

?x + 1 = 

1 + ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TYPES","XOR","forall"]

*)

s "?x+1";
ri "PCASEINTRO@forall@[(?1+1)=(1+?1)]"; ex();
(* ri "LEFT@forall"; ex();
right();left(); ri "PCASEINTRO@(?x+1)=1+?x"; ex();
ri "PIVOT"; ex();
left(); ri "BIND@?x"; ri "LEFT@0|-|1"; ri "EVAL"; ex();
top(); ri "LEFT@ $forall"; ex(); *)
ri "UNIV_EQ_TAC"; ex();
left();right();right();
ri "(LEFT@TADDLEFT@PLUSTYPE)**(RIGHT@TADDRIGHT@PLUSTYPE)"; ex();
ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "LEFT@(RIGHT@ZEROCOMM)**REFLEX"; ex();
ri "CSYM**CID"; ex();
right();right();right();
ri "TAB_IF"; ex();
right();left();left();right();
ri "PLUSSUCC"; ex();
up(); ri "SAMESUCC"; ex();
ri "(RL@(TREMTOP@PLUSTYPE))**(LEFT@TADDLEFT@PLUSTYPE)**RIGHT@TADDRIGHT@PLUSTYPE"; ex();
up(); ri "1|-|1"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); up(); ri "forall**REFLEX"; ex();
up(); ri "AT"; up(); ex();
p "ONECOMM";

(*

ONEASSOC:

(?x + 1) + ?y = 

?x + ?y + 1

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TYPES","XOR","forall"]

*)

s "(?x+1)+?y";
ri "PCASEINTRO@((?x+1)+?y)=?x+(?y+1)"; ri "PIVOT"; ex();
ri "PCASEINTRO@forall@[((?x+1)+?1)=?x+(?1+1)]"; ri "LEFT@forall"; ex();
right(); left(); left(); ri "BIND@?y"; ri "(LEFT@0|-|1)**EVAL"; ex(); 
up(); ex();
top(); left(); rri "forall"; ex();
right(); right();ri "LEFT@TADDRIGHT@PLUSTYPE"; ex();
ri "RIGHT@RIGHT@TADDLEFT@PLUSTYPE"; ri "BIND@Nat:?1"; ex();
up();up(); ri "INDUCTION"; ex();
ri "EVERYWHERE2@EVAL"; ex();
left(); ri "EVERYWHERE2@($ZEROCOMM)**PLUSID"; ex();
ri "(EVERYWHERE@PLUSTYPE)**(EVERYWHERE@TYPES)**REFLEX"; ex();
up(); ri "CSYM**CID"; ex();
right();right();right(); ri "TAB_IF"; ex();
right(); left(); left(); ri "RL@PLUSSUCC"; ex();
left(); left(); ri "TADDRIGHT@PLUSTYPE"; ri "0|-|1"; ex();
ri "RIGHT@TREMLEFT@PLUSTYPE"; ex();
up();up(); ri "REFLEX"; ex();
up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "forall"; ri "forall**REFLEX"; ex();
up(); ri "AT"; ex();
up(); ex();
p "ONEASSOC";

(*

PLUSCOMM:

?x + ?y = 

?y + ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TYPES","XOR","forall"]

*)

s "?x+?y";

(* set up for induction proof *)

ri "PCASEINTRO@forall@[forall@[(?1+?2)=?2+?1]]"; ex();
ri "LEFT@forall"; ex();
right(); left();
ri "PCASEINTRO@forall@[(?x+?1)=?1+?x]"; ex();
ri "LEFT@forall"; ex();
right(); left();
ri "PCASEINTRO@(?x+?y)=?y+?x"; ex();
right(); left();
ri "0|-|3"; ex();
up();up();left();
ri "BIND@?y"; ri "LEFT@0|-|2"; ri "EVAL"; ex();
up(); ex();
up(); up(); left(); rri "forall"; ri "BIND@?x"; 
ri "LEFT@0|-|1"; ri "EVAL"; ex();
up(); ex(); up(); up(); left(); rri "forall"; ex();

(* the actual induction proof starts here *)

ri "EVERYWHERE2@(TADDBOTH@PLUSTYPE)"; ex();
right(); right(); ri "BIND@Nat:?1"; ex();
up(); up(); ri "INDUCTION"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@(RIGHT@ZEROCOMM)**REFLEX"; ex();
ri "EVERYWHERE2@forall**REFLEX"; ex();
ri "EVERYWHERE@CSYM**CID"; ex();
right();left();right(); ri "TAB_IF"; ex();
right();left();left();left();right();right(); ri "PLUSSUCC"; ex();
left();ri "TADDRIGHT@PLUSTYPE"; ex();
ri "PCASEINTRO@((Nat:?1)+Nat:?2)=(Nat:?2)+Nat:?1"; ri "REVPIVOT"; ex();
left(); ri "BIND@?2"; ri "(LEFT@0|-|1)**EVAL"; up(); ex();
up(); up(); left(); ri "ONEASSOC"; ex();
ri "TADDLEFT@PLUSTYPE"; ri "PLUSSUCC"; ex();
up(); ri "REFLEX"; ex();
uptols "REFLEX"; ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "REFLEX"; ri "REFLEX"; up(); ex();
ri "AT"; up(); ex();
p "PLUSCOMM";

(*

PLUSASSOC:

(?x + ?y) + ?z = 

?x + ?y + ?z

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TYPES","XOR","forall"]

*)

s "(?x+?y)+?z";
ri "PCASEINTRO@((?x+?y)+?z)=?x+?y+?z"; ri "PIVOT"; ex();
ri "PCASEINTRO@forall@[((?x+?1)+?z)=?x+?1+?z]"; ri "LEFT@forall"; ex();
right();left();left(); ri "BIND@?y"; ri "(LEFT@0|-|1)**EVAL"; up(); ex();
top(); left(); rri "forall"; ex();
right();right(); ri "LEFT@LEFT@TADDRIGHT@PLUSTYPE"; ex();
ri "RIGHT@RIGHT@TADDLEFT@PLUSTYPE"; ex();
ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
left(); ri "EVERYWHERE2@($ZEROCOMM)**PLUSID"; ex();
ri "(EVERYWHERE@PLUSTYPE)**(EVERYWHERE@TYPES)**REFLEX"; ex();
up(); ri "CSYM**CID"; ex();
right();right();right(); ri "TAB_IF"; ex();
left(); ri "EVERYWHERE@(TREMLEFT@PLUSTYPE)**(TREMRIGHT@PLUSTYPE)"; ex();
up();right();left();left();
ri "EVERYWHERE@PLUSSUCC"; ex();
ri "EVERYWHERE@ONEASSOC"; ex();
ri "EVERYWHERE@PLUSSUCC"; ex();
ri "EVERYWHERE@0|-|1"; ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "forall"; ri "forall**REFLEX"; ex();
up(); ri "AT"; up(); ex();
p "PLUSASSOC";

(*

DIST:

?x * ?y + ?z = 

(?x * ?y) + ?x * ?z

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMES
*)

s "?x*?y+?z";
ri "PCASEINTRO@(?x*?y+?z)=(?x*?y)+?x*?z"; ri "PIVOT"; ex();
ri "PCASEINTRO@forall@[(?x*?y+?1)=(?x*?y)+?x*?1]"; ri "LEFT@forall"; ex();
right();left();left(); ri "BIND@?z"; ri "(LEFT@0|-|1)**EVAL"; up(); ex();
top(); left(); rri "forall"; ex();
right(); right(); ri "LEFT@RIGHT@TADDRIGHT@PLUSTYPE"; ex();
ri "RIGHT@RIGHT@TADDRIGHT@TIMESTYPE"; ex();
ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
left(); ri "EVERYWHERE@TIMESZERO"; ri "EVERYWHERE@PLUSID"; ex();
ri "EVERYWHERE@TIMESTYPE"; ri "EVERYWHERE@TYPES"; ri "REFLEX"; ex();
up(); ri "TAB_AND"; ex();
left();right(); right(); ri "TAB_IF"; ex();
left(); ri "EVERYWHERE@(TREMRIGHT@PLUSTYPE)**TREMRIGHT@TIMESTYPE"; ex();
up(); right(); left();left();
ri "EVERYWHERE@PLUSSUCC"; ex();
ri "EVERYWHERE@TIMESSUCC"; ex();
ri "RIGHT@ $PLUSASSOC"; ex();
ri "EVERYWHERE@0|-|1"; ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "forall"; ri "forall**REFLEX"; up(); up(); ex();
prove "DIST";

(*

COMMDIST:

(?y + ?z) * ?x = 

(?y * ?x) + ?z * ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TIMESSUCC","TIMESTYPE","TIMESZERO","TYPES","XOR","ZERONAT","forall"]

*)

s "(?y+?z)*?x";
ri "PCASEINTRO@((?y+?z)*?x)=(?y*?x)+?z*?x"; ri "PIVOT"; ex();
ri "PCASEINTRO@forall@[((?y+?z)*?1)=(?y*?1)+?z*?1 ]"; ri "LEFT@forall"; ex();
right();left();left(); ri "BIND@?x"; ri "(LEFT@0|-|1)**EVAL"; up(); ex();
top(); left(); rri "forall"; ex();
right(); right(); ri "LEFT@TADDRIGHT@TIMESTYPE"; ex();
ri "RIGHT@RL@TADDRIGHT@TIMESTYPE"; ex();
ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
left(); ri "EVERYWHERE@TIMESZERO"; ri "EVERYWHERE@PLUSID"; ex();
ri "EVERYWHERE@ZERONAT**TYPES"; ri "REFLEX"; ex();
up(); ri "TAB_AND"; ex();
left();right(); right(); ri "TAB_IF"; ex();
left(); ri "EVERYWHERE@(TREMRIGHT@PLUSTYPE)**TREMRIGHT@TIMESTYPE"; ex();
up(); right(); left();left();
ri "EVERYWHERE@TIMESSUCC"; ex();
ri "EVERYWHERE@0|-|1"; ex();
right(); ri "PLUSASSOC"; ex();
right(); ri "PLUSCOMM"; ri "PLUSASSOC"; ex();
right(); ri "PLUSCOMM"; ex();
up();up(); rri "PLUSASSOC"; ex();
up(); ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "forall"; ri "forall**REFLEX"; up(); up(); ex();
prove "COMMDIST";

(*

COMMTIMESZERO:

0 * ?x = 

0

["AND","BOOLDEF","CASEINTRO","EQUATION","IF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","REFLEX","TIMESSUCC","TIMESTYPE","TIMESZERO","TYPES","ZERONAT","forall"]

*)

s "0*?x";
ri "PCASEINTRO@(0*?x)=0"; ri "PIVOT"; ex();
ri "PCASEINTRO@forall@[(0*?1)=0]"; ri "LEFT@forall"; ex();
right(); left(); left(); ri "BIND@?x"; ri "(LEFT@0|-|1)**EVAL"; up(); ex();
top(); left(); rri "forall"; ex();
right(); right(); ri "LEFT@TADDRIGHT@TIMESTYPE"; ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@TIMESSUCC"; ri "EVERYWHERE@TIMESZERO"; ex();
ri "EVERYWHERE@REFLEX"; ri "TAB_AND"; ex();
left(); right(); right(); ri "TAB_IF"; ex();
ri "LEFT@LEFT@TREMRIGHT@TIMESTYPE"; ex();
ri "PIVOT"; ex();
ri "EVERYWHERE2@PLUSID"; ex();
ri "EVERYWHERE2@ZERONAT**TYPES**REFLEX"; ex();
rri "CASEINTRO"; ex();
uptols "forall"; ri "forall**REFLEX"; up(); up(); ex();
p "COMMTIMESZERO";

(*

COMMTIMESID:

1 * ?x = 

Nat : ?x

["AND","BOOLDEF","CASEINTRO","EQUATION","IF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE","REFLEX","TIMESSUCC","TIMESTYPE","TIMESZERO","TYPES","ZERONAT","forall"]

*)

s "1*?x";
ri "PCASEINTRO@(1*?x)=Nat:?x"; ri "PIVOT"; ex();
ri "PCASEINTRO@forall@[(1*?1)=Nat:?1]"; ri "LEFT@forall"; ex();
right(); left(); left(); ri "BIND@?x"; ri "(LEFT@0|-|1)**EVAL"; up(); ex();
top(); left(); rri "forall"; ex();
ri "EVERYWHERE2@ $TYPES"; ex();
ri "EVERYWHERE2@TADDRIGHT@TIMESTYPE"; ex();
right(); right(); ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE@TIMESZERO"; ex();
ri "EVERYWHERE@ZERONAT**TYPES**REFLEX"; ex();
ri "TAB_AND"; ex();
left(); right(); right(); ri "EVERYWHERE@TYPES**TREMRIGHT@TIMESTYPE"; ex();
ri "TAB_IF"; ri "EVERYWHERE2@TIMESSUCC"; ex();
ri "PIVOT"; ri "EVERYWHERE2@PLUSTYPE"; 
ri "EVERYWHERE2@TYPES"; ri "EVERYWHERE2@REFLEX"; ex();
rri "CASEINTRO"; up(); ex();
uptols "forall"; ri "forall**REFLEX"; up(); up(); ex();
p  "COMMTIMESID"; 

(*

TIMESCOMM:

?x * ?y = 

?y * ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","ONENAT","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TIMESSUCC","TIMESTYPE","TIMESZERO","TYPES","XOR","ZERONAT","forall"]

*)

s "?x*?y";
ri "PCASEINTRO@(?x*?y)=?y*?x"; ri "PIVOT"; ex();
ri "PCASEINTRO@forall@[(?x*?1)=?1*?x]"; ri "LEFT@forall"; ex();
right(); left(); left(); ri "BIND@?y"; ri "(LEFT@0|-|1)**EVAL"; up(); ex();
top(); left(); rri "forall"; ex();
right(); right(); ri "LEFT@TADDRIGHT@TIMESTYPE"; ex();
ri "RIGHT@TADDLEFT@TIMESTYPE"; ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE@TIMESZERO**COMMTIMESZERO**REFLEX"; ex();
ri "TAB_AND"; ex();
left(); right(); right(); ri "TAB_IF"; ex();
ri "LEFT@RL@(TREMLEFT@TIMESTYPE)**(TREMRIGHT@TIMESTYPE)"; ex();
right();left();left();
ri "RL@DIST**COMMDIST"; ex();
ri "EVERYWHERE@0|-|1"; ex();
ri "RL@RIGHT@TIMESID**COMMTIMESID"; ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; up();ex();
uptols "forall"; ri "forall**REFLEX"; up(); up(); ex();
p "TIMESCOMM"; 

(*

TIMESASSOC:

(?x * ?y) * ?z = 

?x * ?y * ?z

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","ONENAT","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SAMESUCC","TIMESSUCC","TIMESTYPE","TIMESZERO","TYPES","XOR","ZERONAT","forall"]

*)

s "(?x*?y)*?z";
ri "PCASEINTRO@((?x*?y)*?z)=?x*?y*?z"; ri "PIVOT"; ex();
ri "PCASEINTRO@forall@[((?x*?1)*?z)=?x*?1*?z]"; ri "LEFT@forall"; ex();
right(); left(); left(); ri "BIND@?y"; ri "(LEFT@0|-|1)**EVAL"; up(); ex();
top(); left(); rri "forall"; ex();
right(); right(); ri "LEFT@LEFT@TADDRIGHT@TIMESTYPE"; ex();
ri "RIGHT@RIGHT@TADDLEFT@TIMESTYPE"; ex();
ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
left(); ri "EVERYWHERE@TIMESZERO**COMMTIMESZERO"; ri "REFLEX"; ex();
up(); ri "TAB_AND"; ex();
left(); right();right(); ri "TAB_IF"; ex();
ri "LEFT@EVERYWHERE@(TREMRIGHT@TIMESTYPE)**TREMLEFT@TIMESTYPE"; ex();
right(); left(); left();
ri "EVERYWHERE@DIST**COMMDIST"; ex();
ri "EVERYWHERE@TIMESID**COMMTIMESID"; ex();
ri "EVERYWHERE@(TREMRIGHT@TIMESTYPE)**TREMLEFT@TIMESTYPE"; ex();
ri "EVERYWHERE@0|-|1"; ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; up();ex();
uptols "forall"; ri "forall**REFLEX"; up(); up(); ex();
p "TIMESASSOC";

(*

PLUSMINUS2:

(?x + ?y) - ?y = 

Nat : ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSSUCC","MINUSTYPE","MINUSZERO","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSMINUS","PLUSSUCC","PLUSTYPE","REFLEX","TYPES","XOR","forall"]

*)

s "(?x+?y)-?y";
ri "PCASEINTRO@forall@[((?1+?y)-?y)=Nat:?1]"; ri "LEFT@forall"; ex();
right(); left(); ri "PCASEINTRO@((?x+?y)-?y)=Nat:?x"; ri "PIVOT"; ex();
left(); ri "(BIND@?x)**(LEFT@0|-|1)**EVAL"; up(); ex();
top(); ri "PCASEINTRO@forall@[forall@[((?2+?1)-?1)=Nat:?2]]"; 
 	ri "LEFT@EVERYWHERE2@forall"; ex();
right(); left(); left(); ri "(BIND@?y)**(LEFT@0|-|1)**EVAL"; up(); ex();
top(); left(); rri "forall"; ex();
right(); right(); 
ri "EVERYWHERE2@(TADDRIGHT@PLUSTYPE)**TADDRIGHT@MINUSTYPE"; ex();
ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
ri "LEFT@EVERYWHERE2@MINUSZERO**PLUSID**TYPES**REFLEX"; ex();
ri "TAB_AND"; ex();
left(); right(); right(); ri "TAB_IF"; ex();
ri "LEFT@EVERYWHERE2@(TREMRIGHT@PLUSTYPE)**TREMRIGHT@MINUSTYPE"; ex();
right(); left(); left();left();left();left();
ri "MINUSSUCC"; ex();
left();left();rri "PLUSASSOC"; ri "PLUSCOMM"; rri "PLUSASSOC"; ex();
up(); ri "PCASEINTRO@(((1 + ?2) + ?1) - ?1)=Nat:1+?2"; ri "PIVOT"; ex();
left(); ri "BIND@1+?2"; ri "LEFT@0|-|1"; ri "EVAL"; up(); ex();
ri "TREMTOP@PLUSTYPE"; ri "PLUSCOMM"; ex();
up(); ri "PLUSMINUS"; ex();
up(); ri "REFLEX"; ex();
uptols "REFLEX"; ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; up(); ex();
uptols "forall"; ri "forall**REFLEX"; up(); up(); ex();
prove "PLUSMINUS2";

(*

SELFMINUS:

?x - ?x = 

0

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSSUCC","MINUSTYPE","MINUSZERO","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSMINUS","PLUSSUCC","PLUSTYPE","REFLEX","TYPES","XOR","ZERONAT","forall"]

*)

s "?x-?x";
ri "TADDLEFT@MINUSTYPE"; ex();
left(); ri "($PLUSID)**ZEROCOMM"; ex();
top(); ri "PLUSMINUS2** $ZERONAT"; ex();
p "SELFMINUS";


(* order relations *)

defineinfix "NOT_EQ" "?x<>?y" "~(Nat:?x)=Nat:?y";
defineinfix "LESS" "?x<?y" "~(?y-?x)=0";

axiom "LESSCOMP" "?x<?y" "?x<!?y";

s "?x<?y";
ri "LESS"; ri "EVERYWHERE@TADDBOTH@MINUSTYPE"; 
ri "NOTBOOL"; ri "RIGHT@ $LESS"; ex();
p "LESSTYPE";

s "?x<?y";
ri "TADDBOTH@LESSTYPE"; ex();
p "LESSSCIN";

makescin "<" "LESSSCIN";

(* update the TYPEX tactic *)

s "?x<?y";
ri "TADDLEFT@LESSTYPE"; ex();
p "TYPEXLESSLEFT@?x";

s "?x<?y";
ri "TADDRIGHT@LESSTYPE"; ex();
p "TYPEXLESSRIGHT@?y";

ae "TYPEX";
ri "TYPEXLESSLEFT@?x";
ri "TYPEXLESSRIGHT@?x";
reprove "TYPEX@?x";

(*

ZEROMINUS2:

0 - ?x = 

0

*)

s"0-?x";
ri "PCASEINTRO@forall@[(0-?1)=0]"; ex();
ri "UNIV_EQ_TAC"; ex();
left(); right(); right(); ri "LEFT@TADDRIGHT@MINUSTYPE"; ex();
ri "BIND@Nat:?1"; ex();
uptols "INDUCTION"; ri "INDUCTION"; ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE@(LEFT@SELFMINUS)**REFLEX"; ex();
right();right();right(); ri "LEFT@LEFT@TREMRIGHT@MINUSTYPE"; ex();
ri "TAB_IF"; ex();
right();left();left();left();ri "MINUSSUCC"; ri "LEFT@0|-|1";
ri "ZEROMINUS"; up(); ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "CIDEM**AT"; up(); ex();
p "ZEROMINUS2";

(*

ZEROMIN:

?x < 0 = 

false

*)

s "?x<0";
ri "LESS"; ex();
right(); left(); ri "ZEROMINUS2"; ex();
up(); ri "REFLEX"; ex();
up(); rri "FDEF"; ex();
p "ZEROMIN";

(*

PLUSCANCEL:

(?x + ?z) = ?y + ?z = 

(Nat : ?x) = Nat : ?y

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSSUCC","MINUSTYPE","MINUSZERO","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSMINUS","PLUSSUCC","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","forall"]

*)

s "(?x+?z) = ?y+?z";
ri "PCASEINTRO@(Nat:?x)=Nat:?y"; ex();
ri "LEFT_CASE@RL@TADDLEFT@PLUSTYPE"; ex();
ri "PIVOT"; ri "EVERYWHERE@REFLEX"; ex();
right(); right();
ri "EQUATION"; ex();
right(); left();
initializecounter(); rri "REFLEX"; ex();
assign "?a_1" "(?x+?z)-?z";
ri "RIGHT@LEFT@0|-|2"; ex();
ri "RL@PLUSMINUS2"; ex();
ri "EQUATION**1|-|1"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptors "EQUATION"; rri "EQUATION"; ex();
p "PLUSCANCEL";

(*

LESSLEMMA1:

?x < ?y = 

~ ((?y - ?x) + ?x) = Nat : ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS","MINUSSUCC","MINUSTYPE","MINUSZERO","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSMINUS","PLUSSUCC","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","ZERONAT","forall"]

*)

s "?x<?y";
ri "LESS"; ex();
right();
ri "(LEFT@TADDTOP@MINUSTYPE)**(RIGHT@ZERONAT)"; ex();
initializecounter();
rri "PLUSCANCEL"; ex();
assign "?z_1" "?x";
ri "RIGHT@PLUSCOMM**PLUSID"; ex();
p "LESSLEMMA1"; 

(*

ZEROORSUCC:

forall 
@ [((Nat : ?1) = 0) | forsome 
   @ [(Nat : ?1) = ?2 + 1]] = 

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","forall","forsome"]

*)

s "forall@[((Nat:?1)=0)|forsome@[(Nat:?1)=?2+1]]";
ri "IND_TAC"; ex();
ri "EVERYWHERE@REFLEX**DSYM**DZER**DSYM"; ex();
downtoright "forsome@?P";
ri "DINSTANTIATEF1@?1"; ex();
ri "EVERYWHERE2@EVAL**REFLEX"; ex();
ri "DSYM**DZER"; ex();
up(); ri "DZER"; ex();
up(); ri "IRZER"; ex();
up();up(); ri "FORALLDROP**AT"; ex();
up(); ri "CID**AT"; ex();
p "ZEROORSUCC";

(*

MINUSPLUS1:

(?x - 1) + 1 = 

((Nat : ?x) = 0) || 1 , Nat : ?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","ONENAT","OR","PLUSID","PLUSMINUS","PLUSSUCC","PLUSTYPE","REFLEX","SUCCNOTZERO","TIMESTYPE","TYPES","XOR","ZEROMINUS","forall"]

*)

s "((?x-1)+1)";
ri "PCASEINTRO@forall@[((?1 - 1) + 1) = ((Nat : ?1) = 0) || 1 , Nat:?1]";ex();
ri "UNIV_EQ_TAC"; ex();
left(); ri "IND_TAC"; ex();
left(); ri "EVERYWHERE2@REFLEX**ZEROMINUS"; ex();
ri "EVERYWHERE@PLUSCOMM**PLUSID"; ex();
ri "(RIGHT@ONENAT)**REFLEX"; ex();
up(); ri "CSYM**CID"; ex();
right();right();right(); ri "EVERYWHERE2@EQSYMM**SUCCNOTZERO**EQSYMM"; ex();
ri "EVERYWHERE@PLUSMINUS"; ex();
ri "EVERYWHERE@(RIGHT@TADDLEFT@PLUSTYPE)**REFLEX**(RIGHT@TREMLEFT@PLUSTYPE)"; ex();
ri "IRZER"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "AT"; up(); ex();
p "MINUSPLUS1";



(*

MINUSSUM:

?x - ?y + ?z = 

(?x - ?y) - ?z

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSSUCC","MINUSTYPE","MINUSZERO","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","forall"]

*)

s "?x-(?y+?z)";
ri "PCASEINTRO@forall@[(?x-(?y+?1))=(?x-?y)-?1]"; ex();
ri "UNIV_EQ_TAC"; ex();
left(); ri "IND_TAC"; ex();
ri "LEFT@EVERYWHERE@PLUSID**(TREMTOP@MINUSTYPE)**MINUSZERO**(TREMRIGHT@MINUSTYPE)**(TREMTOP@MINUSTYPE)**REFLEX"; ex();
right();right();right();
ri "EVERYWHERE@(TREMRIGHT@PLUSTYPE)**TREMRIGHT@MINUSTYPE"; ex();
ri "TAB_IF"; ex();
right();left();left(); ri "(LEFT@RIGHT@PLUSSUCC)**RIGHT@MINUSSUCC"; ex();
ri "LEFT@MINUSSUCC"; ex();
ri "EVERYWHERE@0|-|1"; ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "TAB_AND"; up(); ex();
p "MINUSSUM";


(*

LESS_THAN_ONE:

?x < 1 = 

(Nat : ?x) = 0

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS","MINUSSUCC","MINUSTYPE","MINUSZERO","NONTRIV","NOT","ODDCHOICE","ONENAT","OR","PLUSID","PLUSMINUS","PLUSSUCC","PLUSTYPE","REFLEX","SUCCNOTZERO","TIMESTYPE","TYPES","XOR","ZEROMINUS","ZERONAT","forall"]

*)

s "?x<1";
ri "LESS"; ex();
ri "NOT"; ex();
rri "ODDCHOICE"; ex();
ri "PCASEINTRO@(Nat:?x)=0"; ex();
right(); left();
left(); left();
ri "TADDRIGHT@MINUSTYPE"; ex();
ri "RIGHT@0|-|1"; ex();
ri "MINUSZERO"; ex();
rri "PLUSID"; ri "PLUSCOMM"; ex();
up(); ri "EQSYMM**SUCCNOTZERO"; up(); ex();
up(); right(); downtoleft "true";
initializecounter(); rri "REFLEX"; ex(); assign "?a_1" "1-?x";
right(); ri "TADDRIGHT@MINUSTYPE"; ex();
right(); rri "(2|-|1)@1"; ex();
rri "MINUSPLUS1"; ex();
ri "PLUSCOMM"; ex();
up(); ri "MINUSSUM"; ex();
ri "(LEFT@SELFMINUS)**ZEROMINUS2"; ex();
up(); ri "EQUATION**1|-|2"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptors "EQUATION"; rri "EQUATION"; ex();
p "LESS_THAN_ONE";



(*

BOTHZERO:

(?x + ?y) = 0 = 

((Nat : ?x) = 0) & (Nat : ?y) = 0

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSID","PLUSSUCC","PLUSTYPE","REFLEX","SUCCNOTZERO","TIMESTYPE","TYPES","XOR","forall"]

*)

s "(?x+?y)=0";
ri "PCASEINTRO@forall@[((?x+?1)=0)=((Nat:?x)=0)&(Nat:?1)=0]"; ex();
ri "UNIV_EQ_TAC"; ex();
left(); ri "IND_TAC"; ex();
left(); ri "EVERYWHERE@PLUSID**REFLEX**CID"; ex();
ri "(LEFT@ASRTEQ)**REFLEX"; ex();
up(); ri "CSYM**CID"; ex();
right(); right(); right(); right();
left(); ri "(LEFT@PLUSSUCC)**EQSYMM**SUCCNOTZERO"; ex();
up(); right(); right(); ri "EQSYMM**SUCCNOTZERO"; ex();
up(); ri "CZER"; ex(); up(); ri "REFLEX"; ex(); up(); ri "IRZER"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "AT"; up(); ex();
p "BOTHZERO";

(*

SUB_SUCCS:

(?x + 1) - ?y + 1 = 

?x - ?y

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSSUCC","MINUSTYPE","MINUSZERO","NONTRIV","NOT","ODDCHOICE","ONENAT","OR","PLUSID","PLUSMINUS","PLUSSUCC","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","forall"]

*)

s "(?x+1)-(?y+1)";
ri "PCASEINTRO@forall@[((?x + 1) - ?1+1)=?x-?1]";ex();
ri "UNIV_EQ_TAC"; ex();
left(); ri "IND_TAC"; ex();
left(); downtoleft "0+1";
ri "PLUSCOMM"; ri "PLUSID"; rri "ONENAT"; ex();
up();ri "PLUSMINUS2"; ex();
up(); ri "RIGHT@MINUSZERO"; ri "REFLEX"; ex();
up(); ri "CSYM**CID"; ex();
right(); right(); right();
ri "LEFT@EVERYWHERE@TREMLEFT@PLUSTYPE"; ex();
ri "LEFT@EVERYWHERE@TREMRIGHT@MINUSTYPE"; ex();
ri "TAB_IF"; ex();
right(); left(); left(); left(); ri "MINUSSUCC"; ex();
ri "LEFT@0|-|1"; ex();
upto "?x=?y"; ri "RIGHT@MINUSSUCC"; ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "AT"; up(); ex();
p "SUB_SUCCS";

(*

SUB_SUCC_LEMMA:

(?x + 1) - ?y = 

(((?x + 1) - ?y) = 0) || ((?x + 1) - ?y) 
, (?x - ?y) + 1

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSSUCC","MINUSTYPE","MINUSZERO","NONTRIV","NOT","ODDCHOICE","ONENAT","OR","PLUSID","PLUSMINUS","PLUSSUCC","PLUSTYPE","REFLEX","SUCCNOTZERO","TIMESTYPE","TYPES","XOR","ZEROMINUS","forall"]

*)

s "(?x+1)-?y";
ri "PCASEINTRO@(Nat:(?x + 1) - ?y)=0"; ex();
right(); right();ri "TADDTOP@MINUSTYPE"; ex();
rri "(2|-|1)@1"; rri "MINUSPLUS1"; ex();
left(); rri "MINUSSUCC"; ri "SUB_SUCCS"; ex();
top(); ri "LEFT@LEFT@TREMTOP@MINUSTYPE"; ex();
p "SUB_SUCC_LEMMA";

(* it is possible to simplify the statement of this result
(some of the assumptions are redundant) and one hopes that the 
proof can be improved!  I was working in the dark on this! *)

(*


*)

s "|-(((?x+(?y-?x))=Nat:?y)&(?x-?y)=0)|(((?y+(?x-?y))=Nat:?x)&(?y-?x)=0)";
ri "PCASEINTRO@forall@[(((?x+(?1-?x))=Nat:?1)&(?x-?1)=0)|(((?1+(?x-?1))=Nat:?x)&(?1-?x)=0)]";
ri "UNIV_TAC"; ex();  (* fails right here *)
left(); ri "IND_TAC"; ex();
left();right(); ri "EVERYWHERE@MINUSZERO**ZEROMINUS2";
ri "EVERYWHERE @ PLUSCOMM ** PLUSID"; ex();
ri "EVERYWHERE@TYPES**REFLEX**CID**AT"; ex();
up(); ri "DZER"; ex();
up(); ri "CSYM**CID"; ex();
right(); right(); right();
ri "IDIS1"; ex();
left();ri "LEFT@EVERYWHERE@(TREMBOTH@PLUSTYPE)**TREMBOTH@MINUSTYPE"; ex();
ri "TAB_IF**TAB_AND_2"; ex();
right(); left(); right(); left(); left();
ri "PCASEINTRO@((?1+1)-?x)=0"; ex();
right(); right(); left(); right();
ri "(LEFT@MINUSSUCC**(LEFT@0|-|2)**ZEROMINUS)**REFLEX"; ex();
up(); ri "CID** $ASRTEQ"; ex();
left(); right(); ri "SUB_SUCC_LEMMA**1|-|3"; ex();
up(); rri "PLUSASSOC"; ex();
ri "LEFT@0|-|1"; ri "TREMLEFT@PLUSTYPE"; ex();
up(); ri "REFLEX"; ex();
up(); ri "DSYM**DZER"; ex();
up();up();left();left();left();ri "TADDLEFT@PLUSTYPE"; ex();
left(); rri "0|-|1"; ex();
up();ri "PLUSASSOC"; ex();
up(); ri "(LEFT@PLUSCOMM)**PLUSMINUS2"; ri "TREMTOP@PLUSTYPE"; ex();
up(); ri "EQSYMM**SUCCNOTZERO"; up(); up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); ri "CSYM**CID"; ex();
right();ri "LEFT@EVERYWHERE@(TREMBOTH@PLUSTYPE)**TREMBOTH@MINUSTYPE"; ex();
ri "TAB_IF**TAB_AND_2"; ex();
right(); left(); right(); left(); left();
ri "PCASEINTRO@(Nat:?x)=Nat:?1"; ex();
right(); left(); left();ri "TYPEX@?x"; ex();
ri "EVERYWHERE@0|-|3"; ex();
ri "EVERYWHERE@(TREMBOTH@PLUSTYPE)**TREMBOTH@MINUSTYPE"; ex();
downtoleft "(?x+?y)-?x"; ri "(LEFT@PLUSCOMM)**PLUSMINUS2"; rri "ONENAT"; ex();
up(); up(); ri "REFLEX"; ex();
up(); ri "CSYM**CID"; ex();
right(); left(); ri "MINUSSUCC"; ex();
ri "(LEFT@SELFMINUS)**ZEROMINUS"; ex();
up(); ri "REFLEX"; up(); ri "AT"; ex();
up(); ri "DSYM**DZER"; ex();
up(); right();
ri "PCASEINTRO@((?1 + 1) - ?x)=0"; ex();  
right();left(); ri "EVERYWHERE@0|-|4"; ex();
right(); ri "(RIGHT@REFLEX)**CID** $ASRTEQ"; ex();
ri "RIGHT@ $0|-|1"; ex();
ri "LEFT@PLUSASSOC"; ri "RL@PLUSCOMM"; ri "PLUSCANCEL"; ex();
ri "(RIGHT@TREMTOP@MINUSTYPE)**(LEFT@TREMTOP@PLUSTYPE)"; ex();
left(); ri "PLUSCOMM"; ri "LEFT@MINUSSUCC"; ri "MINUSPLUS1"; ex();
left(); ri "EQUATION"; ex();
right(); left(); rri "(2|-|3)@false"; ex();
left(); left(); rri "0|-|1"; ex();
ri "TADDRIGHT@PLUSTYPE"; ri "RIGHT@0|-|5"; ri "PLUSID"; ex();
up(); ri "REFLEX"; up(); ex();
up(); up(); rri "CASEINTRO"; ex();
up(); ex();
up(); ri "(RIGHT@TADDTOP@MINUSTYPE)**REFLEX"; ex();
up(); ri "DZER"; ex();
up(); up(); left(); ri "EQUATION"; ex(); 
rri "NOT_EXP"; ex();
left(); right(); left();
ri "TADDRIGHT@MINUSTYPE"; ri "RIGHT@ $0|-|1"; ex();
ri "MINUSSUM"; ex();
ri "LEFT@(LEFT@PLUSCOMM)**PLUSMINUS2"; ri "LEFT@ $ONENAT"; ex();
uptors "LESS"; ex(); rri "LESS"; ri "LESS_THAN_ONE"; ex();
ri "LEFT@TREMTOP@MINUSTYPE"; ex();
up(); right(); left(); rri "(2|-|3)@true"; ex();
left(); ri "LEFT@ $0|-|1"; ri "LEFT@RIGHT@0|-|4"; 
ri "(LEFT@PLUSID)**REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); ri "AT"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "AT"; up(); ex();
ri "AT"; ex();
prove "PRETRICHOTOMY"; 


(* goal is least number principle *)

(* lemma needed *)

(* sublemma needed *)

(*

ZERONOTONE:  

0 = 1  =  

false

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , NONTRIV , NOT1 , ODDCHOICE 
, ONENAT , OR , PLUSID , PLUSMINUS , PLUSSUCC , PLUSTYPE 
, REFLEX , SUCCNOTZERO , TYPES , forall , 0

*)

s "0=1";
ri "RIGHT@ONENAT** ($PLUSID)**PLUSCOMM"; ex();
ri "SUCCNOTZERO"; ex();
p "ZERONOTONE";

(*

MINUSDIFFS:  

(?x + ?z) - ?y + ?z  =  

?x - ?y

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , MINUSSUCC , MINUSTYPE , MINUSZERO 
, NONTRIV , NOT1 , ODDCHOICE , OR , PLUSID , PLUSMINUS 
, PLUSSUCC , PLUSTYPE , REFLEX , TYPES , forall , 0

*)

s "(?x+?z)-?y+?z";
ri "RIGHT@PLUSCOMM"; ri "MINUSSUM"; ex();
left(); ri "PLUSMINUS2"; ex();
up(); ri "TREMLEFT@MINUSTYPE"; ex();
p "MINUSDIFFS";

(*

LESS_MONOTONE:  

(?x + ?z) < ?y + ?z  =  

?x < ?y

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , LESS , MINUSSUCC , MINUSTYPE 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , OR , PLUSID 
, PLUSMINUS , PLUSSUCC , PLUSTYPE , REFLEX , TYPES 
, forall , 0

*)

s "(?x+?z)<?y+?z";
ri "LESS"; ex();
right(); left(); ri "MINUSDIFFS"; ex();
top(); rri "LESS"; ex();
p "LESS_MONOTONE";

(*

ZERO_LESS_SUCC:  

0 < ?x + 1  =  

true

BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST , LESS 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , PLUSTYPE 
, REFLEX , SUCCNOTZERO , TYPES , 0

*)

s "0<?x+1";
ri "LESS"; ex();
right(); left(); ri "MINUSZERO"; ri "TREMTOP@PLUSTYPE"; ex();
up(); ri "EQSYMM**SUCCNOTZERO"; ex();
up(); ri "NEGF"; ex();
p "ZERO_LESS_SUCC";

(*

LESS_SUCC:  

?x < ?y + 1  =  

((Nat : ?x) = Nat : ?y) | ?x < ?y

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , LESS , MINUSSUCC , MINUSTYPE 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , ONENAT 
, OR , PLUSID , PLUSMINUS , PLUSSUCC , PLUSTYPE , REFLEX 
, SUCCNOTZERO , TYPES , ZEROMINUS , ZERONAT , forall 
, 0

*)

s "?x<?y+1";
ri "TADDLEFT@LESSTYPE"; ex();
ri "RIGHT@TADDLEFT@PLUSTYPE"; ex();
ri "PCASEINTRO@forall@[((Nat:?1)<(Nat:?y)+1) = ((Nat:?1)=(Nat:?y))|((Nat:?1)<(Nat:?y))]";ex();
ri "UNIV_EQ_TAC";
ri "PCASEINTRO@forall@[forall@[((Nat : ?2) < (Nat : ?1) + 1)=((Nat:?2)=(Nat:?1))|(Nat:?2)<Nat:?1]]"; ex();
ri "UNIV_TAC"; ex();
left(); ri "IND_TAC"; ex();
left(); right(); right();
ri "EVERYWHERE2@ZEROMIN**PLUSCOMM**PLUSID** $ONENAT";ex();
ri "LEFT@LESS_THAN_ONE"; ex();
ri "RIGHT@DID** $ASRTEQ"; ex();
ri "(EVERYWHERE@TYPES)**REFLEX"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); right(); right(); right(); ri "TAB_IF"; ex();
right(); left(); left(); right(); right(); ri "PCASEINTRO@(Nat:?2)=0"; ex();
right(); left(); ri "EVERYWHERE@0|-|2"; ex();
ri "EVERYWHERE@ZERO_LESS_SUCC"; ex();
ri "(RIGHT@DZER)**REFLEX"; ex();
up(); right();
ri "LABELTERM@Nat:?2";ri "APPLYATLABELS@($(2|-|2)@1),4,12,14,0"; ex();
ri "EVERYWHERE@ $MINUSPLUS1"; ex();
ri "EVERYWHERE@SAMESUCC**LESS_MONOTONE"; ex();
ri "EVERYWHERE@TADDLEFT@LESSTYPE"; ex();
ri "LEFT@RIGHT@TADDLEFT@PLUSTYPE"; ex();
right(); right(); ri "TADDRIGHT@LESSTYPE"; ex();
uptols "UNIV_TAC";uptols "UNIV_TAC";ri "UNIV_TAC"; ex();
drrs "CASEINTRO"; rri "CASEINTRO"; ex();
up(); up(); ri "FORALLDROP**AT"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "CID**AT"; up(); ex();
ri "RIGHT@TREMBOTH@LESSTYPE"; ex();
p "LESS_SUCC";

(* work on properties of order *)

(*

TRICHOTOMY1:  

((Nat : ?x) = Nat : ?y) | (?x < ?y) | ?y < ?x  =  

true

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , LESS , MINUSSUCC , MINUSTYPE 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , ONENAT 
, OR , PLUSID , PLUSMINUS , PLUSSUCC , PLUSTYPE , REFLEX 
, SUCCNOTZERO , TYPES , ZEROMINUS , ZERONAT , forall 
, 0


*)

s "((Nat:?x)=Nat:?y)|(?x<?y)|(?y<?x)";
ri "PCASEINTRO@forall@[((Nat:?1)=Nat:?y)|(?1<?y)|(?y<?1)]";ex();
ri "LEFT_CASE@ $DRULE1"; ri "UNIV_TAC"; ri "LEFT_CASE@AT"; ex();
left(); ri "IND_TAC"; ex();
left(); ri "EVERYWHERE@ZEROMIN**DID**DRULE3"; ex();
ri "RIGHT@LESS"; ex();
ri "EVERYWHERE@MINUSZERO"; ex();
ri "(LEFT@EQSYMM)**DXM"; ex();
up(); right(); right(); right(); ri "TOPDOWN@IDIS1"; ex();
left(); ri "TAB_IF"; ex();
right(); left(); left(); right(); right(); ri "LESS"; ex();
right(); left(); ri "TYPEX@?y"; ri "TYPEX@?1"; ex();
ri "EVERYWHERE@0|-|1"; ex();
ri "LEFT@PLUSCOMM"; ri "PLUSMINUS2"; rri "ONENAT"; ex();
up(); ri "EQSYMM"; ri "ZERONOTONE"; ex();
up(); ri "NEGF"; ex();
upto "?x||?y,?z"; ri "EVERYWHERE2@DZER"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); right(); left(); ri "TAB_IF"; ex();
right(); left(); left(); rri "DASSOC"; ex();
left(); rri "(2|-|1)@true"; ex();
left(); ri "TREMLEFT@LESSTYPE"; ex();
ri "(!$LESS_MONOTONE)@1"; ex();
ri "LESS_SUCC"; ex();
up(); right(); left(); ri "LEFT@LEFT@TADDTOP@PLUSTYPE"; rri "0|-|2"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
upto "?x||?y,?z"; ri "EVERYWHERE2@DSYM**DZER"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); right(); ri "TAB_IF"; ex();
right(); left(); left(); right(); right(); ri "LESS"; ex();
ri "TAB_NOT"; ex();
right(); left(); rri "(2|-|1)@true"; ex();
left(); ri "LESS"; ex();
right(); left(); ri "TREMLEFT@MINUSTYPE"; ex();
ri "(!$MINUSDIFFS)@1"; ex();
ri "MINUSSUCC**LEFT@0|-|2"; ex();
ri "ZEROMINUS2"; ex();
up(); ri "REFLEX"; up(); rri "FDEF"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
upto "?x||?y,?z"; ri "EVERYWHERE2@DZER"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up();up();ri "EVERYWHERE@CID**AT"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
top(); ri "EVERYWHERE2@CID**AT"; ex();
p "TRICHOTOMY1";

(*

NOT_LESS_THAN_SELF:  

?x < ?x  =  

false

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , LESS , MINUSSUCC , MINUSTYPE 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , OR , PLUSID 
, PLUSMINUS , PLUSSUCC , PLUSTYPE , REFLEX , TYPES 
, ZERONAT , forall , 0

*)

s "?x<?x";
ri "LESS"; ri "EVERYWHERE@SELFMINUS**REFLEX** $FDEF"; ex();
p "NOT_LESS_THAN_SELF";

(*

TRICHOTOMY2:  

(?x < ?y) -> ~ ?y < ?x  =  

true

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , LESS , MINUSSUCC , MINUSTYPE 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , ONENAT 
, OR , PLUSID , PLUSMINUS , PLUSSUCC , PLUSTYPE , REFLEX 
, SUCCNOTZERO , TYPES , ZEROMINUS , ZERONAT , forall 
, 0

*)

s "(?x<?y)-> ~?y<?x";
ri "PCASEINTRO@forall@[(?1<?y)-> ~?y<?1]"; ex();
ri "(LEFT_CASE@ $IRULE1)**UNIV_TAC**LEFT_CASE@AT"; ex();
left(); ri "IND_TAC"; ex();
left(); ri "RIGHT@RIGHT@ZEROMIN"; ex();
ri "RIGHT@NEGF"; ri "IRZER"; ex();
up(); right(); right(); right();
left(); left(); ri "TREMLEFT@LESSTYPE"; ex();
ri "(!$LESS_MONOTONE)@1"; ex();
ri "LESS_SUCC"; ex();
ri "LEFT@LEFT@TREMTOP@PLUSTYPE"; ex();
up(); ri "IDIS1"; ex();
up(); ri "IDIS2"; ex();
right(); ri "EVERYWHERE@TREMRIGHT@LESSTYPE"; ex();
ri "PROVETAUT2@((?1 + 1) < ?y)->(?y < ?1 + 1)->(?y<?1)"; ex();
dlls "LESS_SUCC"; ri "LESS_SUCC"; ex();
up();ri "IDIS1"; ri "RIGHT@IREF"; ex();
up(); ri "TAB_IF"; ex();
right(); left(); left(); left(); left(); ri "EQUATION"; ex();
right(); left(); rri "(2|-|1)@false"; ex();
left(); ri "LESS"; ex();
right(); left(); ri "TYPEX@?1"; ri "TYPEX@?y"; ex();
ri "EVERYWHERE@0|-|2"; ri "MINUSSUCC**(LEFT@SELFMINUS)**ZEROMINUS2"; ex();
up(); ri "REFLEX"; ex();
up(); rri "FDEF"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); ri "3pt75"; ex();
up(); up(); ri "EVERYWHERE2@CID**AT"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "DZER"; ri "DZER"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); up(); ri "EVERYWHERE2@CID**AT"; ex();
p "TRICHOTOMY2";


(* complete induction *)

(*

COMPLETE_INDUCTION:  

forall @ [?P @ Nat : ?1]  =  

forall @ [(forall @ [(?2 < ?1) -> ?P @ Nat : ?2]) 
   -> ?P @ Nat : ?1]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , LESS , MINUSSUCC , MINUSTYPE 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , ONENAT 
, OR , PLUSID , PLUSMINUS , PLUSSUCC , PLUSTYPE , REFLEX 
, SUCCNOTZERO , TYPES , ZEROMINUS , ZERONAT , forall 
, 0

*)

s "forall@[(forall@[(?2<?1)->?P@Nat:?2])->?P@Nat:?1]";
ri "PCASEINTRO@forall@[?P@Nat:?1]";ex();
ri "UNIV_TAC"; ex();
right(); left(); right(); right(); ri "TAB_IF"; rri "CASEINTRO"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); right(); ri "FORALLBOOL**BOOLDEF0"; ex();
right(); left(); rri "(2|-|1)@false"; ex();
left();  (* we need to strengthen the inductive hypothesis *)
ri "PCASEINTRO@forall@[(?P@Nat:?1)&forall@[(?2<Nat:?1)->?P@Nat:?2]]"; ex();
right(); left(); rri "FORALLBOOL2"; ex();
right(); right(); ri "ASSERT2"; rri "CID"; ex();
right(); ri "DXMF@forall@[(?2<Nat:?1)->?P@Nat:?2]"; ex();
up(); ri "CDISD"; ex();
uptols "UNIV_TAC"; ri "UNIV_TAC"; ex();
downtoright "true|?x"; ri "DSYM**DZER"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); up(); left(); ri "IND_TAC"; ex();
left(); drls "ZEROMIN"; ri "ZEROMIN"; ex();
up(); ri "3pt75"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); left();
ri "PCASEINTRO@(forall @ [(?1 < 0) -> ?P @ Nat:?1]) -> ?P @ Nat:0"; ex();
right(); left(); rri "(2|-|3)@true"; ex();
left(); dlls "ZEROMIN";ri "ZEROMIN"; ex();
up(); ri "3pt75"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "TAB_IF"; ex();
rri "BOOLDEF0"; ri "ASSERT2"; ex();
up(); ri "ASSERT_EXP"; ri "LEFT@RIGHT@ $ZERONAT"; ex();
right(); left(); rri "0|-|4"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); up(); uptols "UNIV_TAC"; ri "UNIV_TAC"; ex();
downtoright "true&true"; ri "CID**AT"; ex();
up(); right(); right(); right(); ri "TAB_IF"; ri "TAB_AND_2"; ex();
right(); left(); right(); left(); left();
drls "LESS_SUCC"; ri "LESS_SUCC"; ex();
up(); ri "IDIS1"; ex();
left(); ri "TAB_IF**PIVOT"; ex();
ri "EVERYWHERE2@($0|-|3)**($CASEINTRO)"; ex();
up(); right(); ri "EVERYWHERE@TADDRIGHT@LESSTYPE"; ex();
uptols "UNIV_TAC"; ri "UNIV_TAC"; ex();
downtoright "true&true"; ri "CID**AT"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; up(); ex();
left();
ri "PCASEINTRO@(forall @ [(?2 < ?1+1) -> ?P @ Nat:?2]) -> ?P @ Nat:?1+1"; ex();
right(); left(); rri "(2|-|5)@true"; ex();
dlls "LESS_SUCC";ri "LESS_SUCC"; ex();
up(); ri "IDIS1"; ex();
left(); ri "TAB_IF**PIVOT"; ex();
ri "EVERYWHERE2@($0|-|3)**($CASEINTRO)"; ex();
up(); right(); ri "EVERYWHERE@TADDRIGHT@LESSTYPE"; ex();
uptols "UNIV_TAC"; ri "UNIV_TAC"; ex();
downtoright "true&true"; ri "CID**AT"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
up(); ri "TAB_IF"; ex();
rri "BOOLDEF0"; ri "ASSERT2"; ex();
up(); ri "ASSERT_EXP"; ex();
ri "LEFT@RIGHT@TREMTOP@PLUSTYPE"; ex();
right(); left(); rri "0|-|6"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); up(); uptols "UNIV_TAC";uptols "UNIV_TAC";ri "UNIV_TAC"; ex();
downtoright "true&true"; ri "CID**AT"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
uptols "CID"; ri "CID**AT"; up(); up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); rri "forallcase"; ex();
wb();
p "COMPLETE_INDUCTION";

s "forall@[?P@?1]";
right(); right(); ri "BIND@Nat:?1";
top(); ri "INDSETUP";ri "COMPLETE_INDUCTION"; ri "EVERYWHERE2@EVAL";
p "CI_TAC";

s "~?p->?q";
right(); ri "IDEF2"; ex();
top(); rri "DEMb"; ex();
ri "LEFT@DUBNEG2"; ri "CRULE2"; ex();
p "NOT_IMP";

(* least number principle *)

(*

LNP:  

forsome @ [?P @ Nat : ?1]  =  

forsome @ [(?P @ Nat : ?1) & forall @ [(?2 < ?1) -> ~ ?P 
            @ Nat : ?2]]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , LESS , MINUSSUCC , MINUSTYPE 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , ONENAT 
, OR , PLUSID , PLUSMINUS , PLUSSUCC , PLUSTYPE , REFLEX 
, SUCCNOTZERO , TYPES , ZEROMINUS , ZERONAT , forall 
, forsome , 0

*)

s "forsome@[?P@Nat:?1]";
ri "forsome"; ex();
right(); ri "CI_TAC"; ex();
top(); ri "FORSOME_NOTFORALL"; ex();
right(); right(); ri "NOT_IMP"; ex();
ri "CSYM"; ri "LEFT@DUBNEG2"; ri "CRULE2"; ex();
p "LNP";

s "forsome@[?P@?1]";
right(); right(); ri "BIND@Nat:?1"; 
top(); ri "LNP"; ri "EVERYWHERE2@EVAL";
p "LNP_TAC";


(* method of descent *)

(*

DESCENT:  

forall @ [~ ?P @ Nat : ?1]  =  

forall @ [(?P @ Nat : ?1) -> forsome @ [(?P @ Nat 
            : ?2) & ?2 < ?1]]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , IF , INDUCTION , LESS , MINUSSUCC , MINUSTYPE 
, MINUSZERO , NONTRIV , NOT1 , ODDCHOICE , ONENAT 
, OR , PLUSID , PLUSMINUS , PLUSSUCC , PLUSTYPE , REFLEX 
, SUCCNOTZERO , TYPES , ZEROMINUS , ZERONAT , forall 
, forsome , 0

*)

s "forall@[~?P@Nat:?1]";
ri "CI_TAC"; ex();
right(); right(); ri "CONTP"; ex();
ri "LEFT@DUBNEG2"; ri "IRULE2"; ex();
right(); ri "FORSOME_NOTFORALL"; ex();
right(); right(); ri "NOT_IMP"; ex();
ri "CSYM**(LEFT@DUBNEG2)**CRULE2"; ex();
p "DESCENT";

(* another purely logical lemma *)

s "(?P@?x)&forsome@[?P@?1]";
right(); ri "(!$DINSTANTIATE)@?x"; ex();
ri "LEFT@EVAL"; ex();
top(); ri "PROVETAUT2@ ?P@?x"; ex();
wb();
p "WITNESSED";

quit();

(* another note -- does trichotomy get easier?  I think that trouble
with LESS_SUCC may have been the main problem *)

(* now that I have LNP, my next aim is to prove the division algorithm
theorem *)

(* a lemma *)

s "(?x-?y)<?x";
ri "PCASEINTRO@(~?x=0)| ~?y=0"; ex();
ri "TAB_OR_2"; ri "EVERYWHERE2@TAB_NOT_2"; ex();
ri "PIVOT"; ex();
ri "EVERYWHERE2@ZEROMINUS2**ZEROMIN"; ex();
right(); right(); ri "LESS"; ex();

(* some rough calculations *)

s "forsome@[forsome@[(?1+?2*?x)=(Nat:?y)]]";
ri "EVERYWHERE2@TADDLEFT@PLUSTYPE"; ex();
ri "LNP_TAC"; ex();
right(); right(); right();
ri "(!$INSTANTIATE)@?1-?x"; ex();
ri "EVERYWHERE2@EVAL"; ex();
right(); right();

(*

(* setup for export from peano to omnibus *)

(* declare a view *)

declareview "test";

(* logical notions shared by peano and omnibus *)

addtoview "test" "AND" "AND";
addtoview "test" "BOOLDEF" "BOOLDEF";
addtoview "test" "EQBOOL" "EQBOOL";
addtoview "test" "IF" "IF";
addtoview "test" "NOT1" "NOT1";
addtoview "test" "OR" "OR";
addtoview "test" "forall" "forall";

(* theorems that are analogous in omnibus (actually in algebra2)
or which have been specially proved in algebra2 to support the view *)

addtoview "test" "LESS" "NATLESS";
addtoview "test" "ONENAT" "ONENAT";
addtoview "test" "ZERONAT" "ZERONAT";
addtoview "test" "MINUSTYPE" "MINUSTYPE";
addtoview "test" "SUCCNOTZERO" "SUCCNOTZERO_NAT";
addtoview "test" "PLUSID" "PLUSID_NAT";
addtoview "test" "MINUSZERO" "MINUSZERO_NAT";
addtoview "test" "PLUSMINUS" "PLUSMINUS_NAT";
addtoview "test" "PLUSSUCC" "PLUSSUCC_NAT";
addtoview "test" "PLUSTYPE" "PLUSTYPE_NAT";
addtoview "test" "INDUCTION" "INDUCTION_NAT";

*)

quit();









