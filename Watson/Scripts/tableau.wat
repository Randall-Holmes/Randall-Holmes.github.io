(* August 19, 1997 (as part of general overhaul) *)

(* this script develops the tautology checker NEWTAUT
and proves the Gries axioms for propositional logic using the checker *)

(* being redone for Baby *)

script "logicdefs";  (* basic logic definitions *)

(* convert any propositional expression to a true/false case expression *)

(* MAKE_CASE:

?p = 

ODDCHOICE <= EQUATION => BOOLDEF 
=> (?p = bool : ?p) => ?p

["BOOLDEF","EQUATION","ODDCHOICE"]  *)

s "?p";
ri "(?p=bool:?p)";  (* uses theorem lookup *)
ri "BOOLDEF";
ri "EQUATION";
rri "ODDCHOICE";
p "MAKE_CASE";

(* case expansions for propositional connectives *)

(* assertion *)

(*

ASSERT_EXP:

(|-?p) || ?x , ?y = 

?p || ?x , ?y

["ASSERT","BOOLDEF","ODDCHOICE"]

*)

s "(|-?p)||?x,?y";
ri "(LEFT@ASSERT**BOOLDEF)** $ODDCHOICE"; ex();
p "ASSERT_EXP";

(* negation *)

(* NOT_EXP:

( ~?p) || ?a , ?b = 

?p || ?b , ?a

["CASEINTRO","NOT","ODDCHOICE"] *)

s "(~?p)||?a,?b";
left();
ri "NOT"; ex();
top();
ri "UNPACK"; ex();
rri "ODDCHOICE"; ex();
p "NOT_EXP";

(* conjunction *)

(* AND_EXP:

(?p & ?q) || ?a , ?b = 

?p || (?q || ?a , ?b) , ?b

["AND","CASEINTRO","ODDCHOICE"] *)


s "(?p&?q)||?a,?b";
ri "LEFT@AND"; ex();
ri "UNPACK"; ex();
ri "EVERYWHERE@ $ODDCHOICE"; ex();
p "AND_EXP";

(* disjunction *)

(* OR_EXP:

(?p | ?q) || ?a , ?b = 

?p || ?a , ?q || ?a , ?b

["AND","CASEINTRO","NOT","ODDCHOICE","OR"] *)

s "(?p|?q)||?a,?b";
ri "LEFT@OR"; ex();
ri "NOT_EXP";ex();
ri "AND_EXP"; ex();
ri "EVERYWHERE@NOT_EXP"; ex();
p "OR_EXP";

(* implication *)

(* IF_EXP:

(?p -> ?q) || ?a , ?b = 

?p || (?q || ?a , ?b) , ?a

["AND","CASEINTRO","IF","NOT","ODDCHOICE","OR"] *)

s "(?p->?q)||?a,?b";
ri "LEFT@IF"; ex();
ri "OR_EXP"; ex();
ri "NOT_EXP"; ex();
p "IF_EXP";

(* a silly lemma *)

s "false=true";
ri "EQUATION"; ex();
right();left(); rri "0|-|1"; ex();
top(); rri "CASEINTRO"; ex();
p "NONTRIV2a";

(* it's called NONTRIV2a because this is already present in logicdefs2 *)

(* equivalence *)

(* IFF_EXP:

(?p == ?q) || ?a , ?b = 

?p || (?q || ?a , ?b) , ?q || ?b , ?a

["BOOLDEF","CASEINTRO","EQUATION","IFF","NONTRIV","ODDCHOICE","REFLEX"]  *)

s "(?p==?q)||?a,?b";
ri "LEFT@IFF"; ex();
ri "PCASEINTRO@?q"; ex();
ri "ODDCHOICE"; ex();
ri "EVERYWHERE@LEFT@RL@BOOLDEF"; ex();
ri "EVERYWHERE@LEFT@RIGHT@EQUATION"; ex();
right();left(); ri "EVERYWHERE@LEFT@RIGHT@1|-|1"; ex();
up();right(); ri "EVERYWHERE@LEFT@RIGHT@1|-|1"; ex();
top();
ri "PCASEINTRO@?p"; ex();
ri "ODDCHOICE"; ex();
ri "EVERYWHERE@LEFT@LEFT@EQUATION"; ex();
right();left(); ri "EVERYWHERE@LEFT@LEFT@1|-|1"; ex();
up();right(); ri "EVERYWHERE@LEFT@LEFT@1|-|1"; ex();
top();
ri "EVERYWHERE@LEFT@RL@REFLEX**NONTRIV**NONTRIV2a"; ex();
ri "EVERYWHERE@LEFT@REFLEX**NONTRIV**NONTRIV2a"; ex();
ri "EVERYWHERE@ $ODDCHOICE"; ex();
p "IFF_EXP";

(* exclusive or/inequivalence *)

(*  XOR_EXP:

(?p =/= ?q) || ?a , ?b = 

?p || (?q || ?b , ?a) , ?q || ?a , ?b

["BOOLDEF","CASEINTRO","EQUATION","IFF","NONTRIV","NOT","ODDCHOICE","REFLEX","XOR"] *)

s "(?p=/=?q)||?a,?b";
ri "LEFT@XOR"; ex();
ri "NOT_EXP"; ex();
ri "IFF_EXP"; ex();
p "XOR_EXP";

(* converse implication *)

(* CN_EXP:

(?p <- ?q) || ?a , ?b = 

?q || (?p || ?a , ?b) , ?a

["AND","CASEINTRO","CONVIF","IF","NOT","ODDCHOICE","OR"]  *)

s "(?p<-?q)||?a,?b";
ri "LEFT@CONVIF"; ex();
ri "IF_EXP"; ex();
p "CN_EXP";


(* The case reasoning tool used in the tautology checker *)

dpt "ALT_PUSH";

(* ALT_PUSH:

?p || ?a , ?b = 

CASEINTRO <= ?p 
|| (ALT_PUSH => (EVERYWHERE @ 1 |-| 1) => ?a) 
, ALT_PUSH => (EVERYWHERE @ 1 |-| 1) => ?b

["CASEINTRO"]  *)

s "?p||?a,?b";
right();left(); ri "EVERYWHERE@1|-|1"; ri "ALT_PUSH";
up();right(); ri "EVERYWHERE@1|-|1"; ri "ALT_PUSH";
top(); rri "CASEINTRO";
p "ALT_PUSH";

(* procedure for carrying out expansions *)

(* ALL_EXP:

?p || ?a , ?b = 

CN_EXP =>> XOR_EXP =>> IFF_EXP =>> IF_EXP 
=>> OR_EXP =>> AND_EXP =>> NOT_EXP => ?p || ?a 
, ?b

["AND","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","XOR"]
  *)

dpt "ALL_EXP";

s "?p||?a,?b";
(* right();left(); ri "ALL_EXP";
up();right(); ri"ALL_EXP";
top(); *)
ri "ASSERT_EXP*>ALL_EXP"; ari "NOT_EXP*>ALL_EXP"; ari "AND_EXP*>ALL_EXP"; 
ari "OR_EXP*>ALL_EXP"; ari "IF_EXP*>ALL_EXP"; ari "IFF_EXP*>ALL_EXP"; ari "XOR_EXP*>ALL_EXP"; ari "CN_EXP*>ALL_EXP";
prove "ALL_EXP";

(* the tautology checker -- a loop tactic *)

(* NEWTAUT:

?x = 

ALL_STEPS => STARTLOOP => MAKE_CASE => ?x

["AND","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","XOR"]
  *)

s "?x";
ri "MAKE_CASE";
ri "TOPDOWN@ALL_EXP";
ri "ALT_PUSH";
prove "NEWTAUT";

(* typing lemmas needed for propositional logic *)

(* used by PROVETAUT tactics below *)

s "|-?p==?q";
ri "RIGHT@BTYPE"; ri "TWOASSERTS"; rri "BTYPE"; ex();
p "BRULE1";

s "(|-?p)==?q";
ri "BTYPE"; ri "RIGHT@LEFT@TWOASSERTS"; rri "BTYPE"; ex();
p "BRULE2";

s "?p== |-?q";
ri "BTYPE"; ri "RIGHT@RIGHT@TWOASSERTS"; rri "BTYPE"; ex();
p "BRULE3";

s "|-?p|?q";
ri "RIGHT@DTYPE"; ri "TWOASSERTS"; rri "DTYPE"; ex();
p "DRULE1";

s "(|-?p)|?q";
ri "DTYPE"; ri "RIGHT@LEFT@TWOASSERTS"; rri "DTYPE"; ex();
p "DRULE2";

s "?p| |-?q";
ri "DTYPE"; ri "RIGHT@RIGHT@TWOASSERTS"; rri "DTYPE"; ex();
p "DRULE3";

s "|-?p&?q";
ri "RIGHT@CTYPE"; ri "TWOASSERTS"; rri "CTYPE"; ex();
p "CRULE1";

s "(|-?p)&?q";
ri "CTYPE"; ri "RIGHT@LEFT@TWOASSERTS"; rri "CTYPE"; ex();
p "CRULE2";

s "?p& |-?q";
ri "CTYPE"; ri "RIGHT@RIGHT@TWOASSERTS"; rri "CTYPE"; ex();
p "CRULE3";

s "|-?p=/=?q";
ri "RIGHT@XORTYPE"; ri "TWOASSERTS"; rri "XORTYPE"; ex();
p "XRULE1";

s "(|-?p)=/=?q";
ri "XORTYPE"; ri "RIGHT@LEFT@TWOASSERTS"; rri "XORTYPE"; ex();
p "XRULE2";

s "?p=/= |-?q";
ri "XORTYPE"; ri "RIGHT@RIGHT@TWOASSERTS"; rri "XORTYPE"; ex();
p "XRULE3";

s "|- ~?p";
ri "RIGHT@NTYPE"; ri "TWOASSERTS"; rri "NTYPE"; ex();
p "NRULE1";

s "~ |-?p";
ri "NTYPE"; ri "RIGHT@RIGHT@TWOASSERTS"; rri "NTYPE"; ex();
p "NRULE2";

s "|-?p->?q";
ri "RIGHT@IMPTYPE"; ri "TWOASSERTS"; rri "IMPTYPE"; ex();
p "IRULE1";

s "(|-?p)->?q";
ri "IMPTYPE"; ri "RIGHT@LEFT@TWOASSERTS"; rri "IMPTYPE"; ex();
p "IRULE2";

s "?p-> |-?q";
ri "IMPTYPE"; ri "RIGHT@RIGHT@TWOASSERTS"; rri "IMPTYPE"; ex();
p "IRULE3";

s "|-?p<-?q";
ri "RIGHT@CONTYPE"; ri "TWOASSERTS"; rri "CONTYPE"; ex();
p "CNRULE1";

s "(|-?p)<-?q";
ri "CONTYPE"; ri "RIGHT@LEFT@TWOASSERTS"; rri "CONTYPE"; ex();
p "CNRULE2";

s "?p<- |-?q";
ri "CONTYPE"; ri "RIGHT@RIGHT@TWOASSERTS"; rri "CONTYPE"; ex();
p "CNRULE3";


(* Needed:  tactic for converting case expressions to a more readable form *)

(* Alves-Foss theorem CONDCASES could be part of such a procedure *)

(* tactic for applying NEWTAUT *)

initializecounter();
s "bool:?x";
ri "CASEINTRO"; ex();
assign "?y_1" "(bool:?x)=bool:?y";
right();left();
ri "0|-|1"; ex();
top();left();
rri "IFF"; ri "NEWTAUT";
top();
prove "PROVETAUT@?y";


s "?x";
rri "BRULE1"; arri "CRULE1"; arri "DRULE1"; arri "NRULE1"; arri "XRULE1";
arri "IRULE1"; arri "CNRULE1";
ri "ASSERT";
ri "PROVETAUT@?y";
ri "ASSERT2";
ri "BRULE1"; ari "CRULE1"; ari "DRULE1"; ari "NRULE1"; ari "XRULE1";
ari "IRULE1"; ari "CNRULE1"; 
prove "PROVETAUT2@?y";

(* proofs of Gries propositional axioms *)

(*

BASSOC:

(?p == ?q) == ?r = 

?p == ?q == ?r

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "(?p==?q)==?r";
ri "PROVETAUT2@?p==?q==?r"; ex();
p "BASSOC";

(*

BSYM:

?p == ?q = 

?q == ?p

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p==?q";
ri "PROVETAUT2@?q==?p"; ex();
p "BSYM";

(*

BID:

?p == ?p = 

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","XOR"]

*)

s "?p==?p";
ri "NEWTAUT"; ex();
p "BID";

(*

BID2:

?p == true = 

|-?p

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p==true";
ri "PROVETAUT2@ ?p"; ex();
p "BID2";

(* the argument of PROVETAUT2 above is ?p, not |-?p *)

(*

FDEF:

false = 

~true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","XOR"]

*)

s "~true";
ri "NEWTAUT"; ex();
workback();
p "FDEF";

(*

BDIS:

~?p == ?q = 

(~?p) == ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "~?p==?q";
ri "PROVETAUT2@(~?p)==?q"; ex();
p "BDIS"; 

(*

XORDEF:

?p =/= ?q = 

~?p == ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p=/=?q";
ri "PROVETAUT2@ ~?p==?q"; ex();
p "XORDEF";

(*

DASSOC:

(?p | ?q) | ?r = 

?p | ?q | ?r

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "(?p|?q)|?r";
ri "PROVETAUT2@?p|?q|?r"; ex();
p "DASSOC";


(*

DSYM:

?p | ?q = 

?q | ?p

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p|?q";
ri "PROVETAUT2@?q|?p";ex();
p "DSYM";

(*

DIDEM:

?p | ?p = 

|-?p

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p|?p";
ri "PROVETAUT2@?p"; ex();
p "DIDEM";


(*

DDIS:

?p | ?q == ?r = 

(?p | ?q) == ?p | ?r

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p|?q==?r";
ri "PROVETAUT2@(?p|?q)==?p|?r";ex();
p "DDIS"; 

(*

DXM:

?p | ~?p = 

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","XOR"]

*)

s "?p| ~?p";
ri "NEWTAUT"; ex();
p "DXM";

(* converse forms of Gries axioms which destroy information *)

ae "BID"; wb(); p "BIDF@?p";
ae "DXM"; wb(); p "DXMF@?p";

(*

GR:

(?p & ?q) == ?p | ?q = 

?p == ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "(?p&?q)==?p|?q";
ri "PROVETAUT2@?p==?q"; ex();
p "GR";

(*

IDEF:

?p -> ?q = 

(?p | ?q) == ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]


*)

s "?p->?q";
ri "PROVETAUT2@(?p|?q)==?q"; ex();
p "IDEF";

(*

CONS:

?p -> ?q = 

?q <- ?p

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p->?q";
ri "PROVETAUT2@?q<-?p"; ex();
p"CONS";

(*

LZ:

(?e = ?f) & ?F @ ?e = 

(?e = ?f) & ?F @ ?f

["AND","BOOLDEF","EQUATION","ODDCHOICE"]

*)

s "(?e=?f)&?F@?e";
ri "AND"; ex();
ri "LEFT@ $BOOLDEF"; ex();
ri "LEFT@ $EQBOOL"; ex();
right();left();
ri "EVERYWHERE@0|-|1"; ex();
up();up();
ri "LEFT@EQBOOL"; ri "LEFT@BOOLDEF"; rri "AND"; ex();
p "LZ";


(*

ASRTEQ:

?e = ?f = 

|-?e = ?f

["ASSERT","BOOLDEF","EQUATION","ODDCHOICE"]

*)

s "?e=?f";
ri "EQBOOL"; ri "ASSERT2"; ex();
p "ASRTEQ";


(*

BCONV:

?e == ?f = 

(|-?e) = |-?f

["ASSERT","IFF"]

*)

s "?e==?f";
ri "IFF"; ri "RL@ASSERT2"; ex();
p "BCONV";

(*

EQT:

(|-?p) = true = 

?p = true

["ASSERT","BOOLDEF","CASEINTRO","EQUATION","REFLEX","TYPES"]

*)

s "(|-?p)=true";
ri "EQSYMM"; rri "BOOLDEF"; ri "RIGHT@ASSERT"; ri "TYPES"; ex();
ri "BOOLDEF"; ri "EQSYMM"; ex();
p "EQT";

quit();