(* August 19, 1997 (as part of general overhaul) *)

script "logicdefs2"; (* basic logic definitions, tautology checker
and Gries chapter 3 *)

(* this file includes a selection of logical tools: Parvin tactics for
conversion of "implication" theorems from one form to another,
Alves-Foss theorems about case expressions, and basic results about
quantifiers proved "by hand" *)

(* Parvin's tactics for converting between different forms of
"implication" theorems *)

(*
"?p -> ?q" = "true"
"?p & ?q" = "?p"
"?p | ?q" = "?q";
*)

(* if ?thm is "?p->?q"="true" then "?p&?q"="|-?p" *)

(*

CONVIMPAND @ ?thm:

?p & ?q = 

CID => ?p & ?thm => ?p -> ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p & ?q";
rri "3pt44a"; ex();
right();
rri "IF";ex();
ri "?thm";
up();
ri "CID";
p "CONVIMPAND@?thm";

(* if ?thm is "?p->?q"="true" then "?p|?q"="|-?q" *)

(*

CONVIMPOR @ ?thm:

?p | ?q = 

DID => ?q | FDEF <= ~?thm => ?p -> ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p | ?q";
ri "DSYM"; ex();
rri "3pt44b"; ex();
right();
ri "ANDBOOL";ex();
rri "DUBNEG"; ex();
right();
rri "DEMa";ex();
rri "IF"; ex();
rri "CONTP";ex();
ri "?thm";
up();
rri "FDEF";
up();
ri "DID";
p "CONVIMPOR@?thm";

(* if ?thm is "?p&?q"="|-?p" then "?p->?q"="true" *)

(*

CONVANDIMP @ ?thm:

?p -> ?q = 

BID => BRULE2 => (?thm => ?p & ?q) == ?p

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p -> ?q";
ri "IDEF3"; ex();
left();
ri "?thm";
up();
ri "BRULE2";
ri "BID";
p "CONVANDIMP@?thm";

(* if ?thm is "?p&?q"="|-?p" then "?p|?q"="|-?q" *)

(*

CONVANDOR @ ?thm:

?p | ?q = 

DID => ?q | FDEF 
<= ~(CONVANDIMP @ ?thm) => ?p -> ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p | ?q";
ri "DSYM";ex();
rri "3pt44b"; ex();
right();
ri "CSYM"; ex();
ri "ANDBOOL"; ex();
rri "DUBNEG"; ex();
right();
rri "DEMa"; ex();
ri "(RIGHT@DUBNEG2)**DRULE3"; ex();
rri "IF"; ex();
ri "CONVANDIMP@?thm";
up();
rri "FDEF";
up();
ri "DID";
p "CONVANDOR@?thm";

(* if ?thm is "?p|?q"="|-?q" then "?p->?q"="true" *)

(*

CONVORIMP @ ?thm:

?p -> ?q = 

BID => BRULE2 => (?thm => ?p | ?q) == ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p -> ?q";
ri "IDEF"; ex();
left();
ri "?thm";
up();
ri "BRULE2";
ri "BID";
p "CONVORIMP@?thm";

(* if ?thm is "?p|?q"="|-?q" then "?p&?q"="|-?p" *)

(*

CONVORAND @ ?thm:

?p & ?q = 

BID2 => (RIGHT @ BID) => BASSOC => BRULE3 
=> (?p == ?q) == ?thm => ?p | ?q

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?p & ?q";
rri "GR2"; ex();
right();
ri "?thm";
up();
ri "BRULE3";
ri "BASSOC";
ri "RIGHT@BID";
ri "BID2";
p "CONVORAND@?thm";

(* new theorem as a fix for EQSYMM when top involves true *)

s "(?x=true)||?y,?z";
ri "LEFT@EQSYMM"; ex();
wb();
p "EQSYMM2";

(* Alves-Foss case expression results *)

(* ************************************
- ASRTCOND:
===========
?a || ?b , ?c = 

( |-?a) || ?b , ?c

["BCONV","BDIS","BID","BID2","BSYM","EQT","FDEF","NTYPE","ODDCHOICE","SYM","TWOASSERTS"]
*************************************** *)

start "(?a || ?b, ?c)";
ri "EQSYMM2"; ex();
left(); rri "EQT"; ex(); right(); rri "AT"; ex();
up(); rri "BCONV"; ri "BID2"; ex();
p "ASRTCOND";

(* ***************************************
- BEQSUBS:
========== 
(?a == ?b) -> ?a = 
 
(?a == ?b) -> ?b
 
["ASRTEQ","BASSOC","BCONV","BDIS","BID","BID2","BSYM","BTYPE","CONTYPE","CTYPE","DDIS","DIDEM","DSYM","DTYPE","DXM","FDEF","GR","IDEF","IMPTYPE","LZ","NTYPE","TWOASSERTS","XORDEF","XORTYPE"]

*************************************** *)
start "(?a == ?b) -> ?a";

ri "MKASRT@?a"; ex();
right(); ri "BIND@ |-?a"; ex();
top(); left(); ri "GCLEAN"; ri "BCONV"; ex();
up(); ri "3pt84b"; ex();
right(); ri "EVAL"; ex();
top(); left(); rri "BCONV"; ex();
top(); ri "GCLEAN"; ex();
p "BEQSUBS"; 

(* *************************************** 
- CONDCASESL1:
=============
(?a || ?b , ?c) == (?a & ?b) | ( ~?a) & ?c = 

true

["ASRTEQ","BASSOC","BCONV","BDIS","BID","BID2","BSYM","BTYPE","CONTYPE","CTYPE","DASSOC","DDIS","DIDEM","DSYM","DTYPE","DXM","EQT","FDEF","GR","IMPTYPE","LZ","NTYPE","ODDCHOICE","SYM","TWOASSERTS","XORDEF","XORTYPE"]
*************************************** *)

start "(?a || ?b,?c) == (?a & ?b) | ((~?a) & ?c)";

(* ** Introduce ?a | ~?a ** *)
ri "BTYPE"; rri "CID"; ex();
right(); ri "DXMF @ ?a"; ex();
ri "DTYPE"; ex();

(* ** Change to ?a = true or ?a = false ** *)
right(); left(); rri "BID2"; ex();
up(); right(); rri "3pt15a"; ex();
rri "BID2"; ex();
ri "3pt11"; ex();
right(); rri "FDEF"; ex();

(* ** Distribute this as an option ** *)
top();ri "GCLEAN"; ri "CDISD"; ex();

(* ** Now get left side ready for LZ ** *)

top(); left(); ri "CSYM"; ri "CDISD"; ex();
right();right();right();left();rri"NRULE2";ex();
up();up();left();ri "MKASRT@?a"; ex();
up(); up(); left(); ri"ASRTCOND"; ex();
up(); ri "BIND@ |-?a"; ex();

(* ** Apply LZ ** *)
up(); left(); ri "BCONV"; ex();
up(); ri "LZ"; ex();
right(); ri "EVAL"; ex();

(* ** Simplify out the conditions ** *)


left(); left(); ri "AT"; ex();
up(); ri "EVAL"; ex();
up(); right(); left(); left(); ri "AT"; ex();
up(); ri "CSYM"; ri "CID"; ex();
up(); right(); left(); rri "REMA"; ex();
right(); rri "FDEF"; ex();
up(); ri "AF"; ex();
up(); ri "CSYM"; ri "CZER"; ex();
up(); ri "GCLEAN"; ri "DID"; ex();
up(); ri "GCLEAN"; ri "BID"; ri "GCLEAN"; ex();
up(); ri "CID"; ex();
rri"ASRTEQ"; rri" BCONV"; ex();
ri "BID2"; ex();

(* ** Now get right side ready for LZ ** *)
top(); right(); ri "CSYM"; ri "CDISD"; ex();
right();right();right();left();
rri"NRULE2";ex();
up();up();left();ri "MKASRT@?a"; ex();
up(); up(); left(); ri"ASRTCOND"; ex();
up(); ri "BIND@ |-?a"; ex();

(* ** Apply LZ ** *)
up(); left(); ri "BCONV"; ex();
up(); ri "LZ"; ex();
right(); ri "EVAL"; ex();

(* ** Simplify out the conditions ** *)
left(); left(); ri "AF"; ex();
up(); ri "EVAL"; ex();
up(); right(); left(); left(); ri "AF"; ex();
up(); ri "CSYM"; ri "CZER"; ex();
up(); right(); left(); rri "REMA"; ex();

right(); ri "NEGF"; ex();
up(); ri "AT"; ex();
up(); ri "CSYM"; ri "CID"; ex();
up(); ri "GCLEAN"; ri"DSYM"; ri "DID"; ex();
up(); ri "GCLEAN"; ri "BID"; ri "GCLEAN"; ex();
up(); ri "CID"; ex();
rri"ASRTEQ"; rri" BCONV"; ex();
ri "3pt15a"; ex();
up(); ri "GCLEAN"; ri "DXM"; ex();
prove "CONDCASESL1";


(* *** Set up theorem for distruction of information *** *)
ae "CONDCASESL1"; wb(); p "CONDCASESL1F@?a,?b,?c";

(* ***************************************
- CONDCASES:  create an equation from a == b = true to a = b
============
 
(?a & ?b) | ( ~?a) & ?c =

  |-?a || ?b , ?c 

["ASRTEQ","BASSOC","BCONV","BDIS","BID","BID2","BSYM","BTYPE","CONTYPE","CTYPE","DASSOC","DDIS","DIDEM","DSYM","DTYPE","DXM","EQT","FDEF","GR","IDEF","IMPTYPE","LZ","NTYPE","ODDCHOICE","SYM","TWOASSERTS","XORDEF","XORTYPE"]
*************************************** *) 

start "(?a & ?b) | (~?a) & ?c";

ri "DTYPE"; ex();
rri "ILID"; ex();
left(); ri "CONDCASESL1F@?a,?b,?c"; ri "BSYM"; ex();
top(); right(); ri "GCLEAN"; ex();
top(); ri "BEQSUBS"; ex();
top(); left(); ri "BSYM"; ri "CONDCASESL1"; ex();
top(); ri "ILID"; ex();
p "CONDCASES";

(* ***************************************
- IMPTOCOND:
============
?a -> ?b = 
 
 |-?a || ?b , true
 
["ASRTEQ","BASSOC","BCONV","BDIS","BID","BID2","BSYM","BTYPE","CONTYPE","CTYPE","DASSOC","DDIS","DIDEM","DSYM","DTYPE","DXM","EQT","FDEF","GR","IDEF","IMPTYPE","LZ","NTYPE","ODDCHOICE","SYM","TWOASSERTS","XORDEF","XORTYPE"]
*************************************** *)
start "(?a -> ?b)";

(* ** Introduce ?a | ~?a and distribute  ** *)
ri "IMPTYPE"; ex();
rri "CID"; ex();
right(); ri "DXMF@?a"; ex();
top(); ri "CDISD"; ex();

(* ** Work left side ** *)
top(); ri "GCLEAN"; ex();
left(); ri "CSYM"; ri "3pt66"; ex();

(* ** Work right side ** *)
top(); right(); ri "CSYM"; ex();
right(); ri "IDEF2"; ex();
up(); ri "3pt43a"; ex();
rri "CID"; ex();

(* Now get into form for CONDCASES *)
top(); ri "GCLEAN"; ex();
ri "CONDCASES"; ex();
p "IMPTOCOND";

(* an application of CONDCASES *)
(* an algorithm which converts case expressions to propositional logic 
notation *)

(* still slow! *)

(* I think that Parvin has developed better algorithms of this kind
which will become publicly available *)

(*

CONDCASES2:

?a || (|-?b) , |-?c = 

(?a & ?b) | (~?a) & ?c

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?a||(|-?b), (|-?c)";
right();left();
ri "BIND@?b";
up();right();
ri "BIND@?c";
top();
rri "FNDIST";
ri "EVAL";
rri "CONDCASES";ex();
prove "CONDCASES2";

s "?a||?b,?c";
right();left(); ri "?b= |-?b"; ri "ALLASSERTS";
up();right(); ri "?c= |-?c"; ri "ALLASSERTS";
prove "CASEPREP";

s "(?a & ~?b) | (~?a) & ?b";
ri "PROVETAUT2@ ~?a==?b"; ex();
prove "XORALTDEF";

s "?a||(|-?b),(|-?c)";
ri "CONDCASES2"; ex();
ri "RL@CRULE1**CRULE2**CID**CZER";
ri "DRULE1**DRULE2";
rri "BALTDEF"; ri "XORALTDEF";
ri "DID**DZER";
ri "DSYM";
ri "DID";
ari "DZER";
ari "DSYM";
prove "CONDSIMP";

(* this is the main procedure *)

start "?a||?b,?c";
ri "EVERYWHERE@CASEPREP**CONDSIMP";
ri "EVERYWHERE@ $IDEF2";
ri "EVERYWHERE@ $XOR";
prove "TESTSIMP";

(* basic results about quantifiers *)

(*

INSTANTIATE:

(?P @ ?x) & forall @ [?P @ ?1] = 

forall @ [?P @ ?1]

["AND","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","NONTRIV","REFLEX","forall"]

*)

initializecounter();
s "(?P@?x)&forall@[?P@?1]";
ri "CASEINTRO"; ex();
assign "?y_1" "forall@[?P@?1]";
ri "LEFT@forall"; ex();
right(); left(); left();
ri "BIND@?x"; ex();
 ri "(LEFT@0|-|1)**EVAL"; ex();
up();
ri "AND"; ex();
ri "LEFT@REFLEX"; ex();
rri "BOOLDEF"; ex(); rri "FORALLBOOL"; ex();
up();right();right();
ri "forall"; ex(); ri "EQUATION"; ex();
ri "1|-|1"; ex();
up();
ri "AND"; ex(); ri "LEFT_CASE@NONTRIV"; ex(); rri "CASEINTRO"; ex(); 
rri "1|-|1"; ex();
assign "?x_20" "true";
rri "EQUATION"; ex(); 
left();right();
ri "BIND@?1"; ex();
up();up();
rri "forall"; ex();
top(); rri "CASEINTRO"; ex();
p "INSTANTIATE";

(* dual basic theorem about existential quantifier *)

(*

DINSTANTIATE:

(?P @ ?x) | forsome @ [?P @ ?1] = 

forsome @ ?P

["AND","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","OR","REFLEX","forall","forsome"]

*)

s "(?P@?x)|forsome@[?P@?1]";
ri "OR"; ex();
right();left();
ri "BIND@?x"; ex();
up();right(); right();
ri "forsome"; ex();
up();
ri "DUBNEG"; rri "FORALLBOOL"; ex();
up();
ri "INSTANTIATE"; ex();
top(); rri "forsome"; ex();
p "DINSTANTIATE";

ae "DINSTANTIATE";wb();p "DINSTANTIATEF1@?x";

(* proof of distributivity of universal quantification over
conjunction *)

(* brand new proof *)

(*

FORALLDIST:

forall @ [(?P @ ?1) & ?Q @ ?1] = 

(forall @ [?P @ ?1]) & forall @ [?Q @ ?1]

["AND","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","NONTRIV","ODDCHOICE","REFLEX","TYPES","forall"]

*)

s "forall @ [(?P @ ?1) & ?Q @ ?1]";
ri "PCASEINTRO@(forall @ [?P @ ?1]) & forall @ [?Q @ ?1]"; ex();
ri "ANDUNPACK"; ex();
ri "LEFT@forall"; ex();
right(); left(); ri "LEFT@forall"; ex();
right(); left(); right(); right();
left(); ri "BIND@?1"; ri "LEFT@0|-|1"; ri "EVAL"; ex();
up(); right(); ri "BIND@?1"; ri "LEFT@0|-|2"; ri "EVAL"; ex();
up(); ri "AND"; ri "REFLEX"; ex();
up(); up(); ri "forall**REFLEX"; ex();
upto "?x||?y,?z";ri "LEFT@($forall2)**($FORALLBOOL2)**forall"; ex();
right(); right();
ri "forall"; ri "EQUATION"; ex();
right(); left(); rri "(2|-|2)@false"; ex();
initializecounter();
left(); left(); left(); ri "ASSERT2"; ri "3pt43bF@?P@?1"; ex();
right(); ri "CSYM"; ri "BIND@?1"; ri "LEFT@0|-|3"; ri "EVAL"; ex();
up(); ri "DZER"; ex();
up(); up(); ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); ri "LEFT@($forall2)**($FORALLBOOL2)**forall"; ex();
right(); right(); ri "forall**EQUATION"; ex();
right(); left(); rri "(2|-|1)@false"; ex();
left(); left(); left(); ri "ASSERT2"; ri "3pt43bF@?Q@?1"; ex();
right(); ri "BIND@?1"; ri "LEFT@0|-|2"; ri "EVAL"; ex();
up(); ri "DZER"; ex();
up(); up(); ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); rri "ANDUNPACK"; rri "BOOLDEF0"; ex();
ri "EVERYWHERE@ $forall"; ex();
rri "ANDBOOL"; ri "ANDSCIN"; ex();
ri "RL@FORALLBOOL2"; ex();

prove "FORALLDIST";

(* commutativity of quantifiers -- this comes in different versions
depending on stratification! *)

(* development of this proof demonstrated to me that using theorems
which introduce new variables where stratification is involved is not
desirable; that's why the parameterized PCASEINTRO was proved above *)

initializecounter();
s "forall@[forall@[?P@?1,?2]]";
ri "PCASEINTRO@forall@[forall@[?P@?2,?1]]";ex();
left();right();right();
ri "($FORALLBOOL2)**forall"; ex();
up();up();
ri "forall"; ex();
up();
right();left();
right();right();
rri "FORALLBOOL2"; ex();
right();right();
ri "BIND@?1"; ex();
ri "PCASEINTRO@[bool : ?P @ ?3 , ?2]=[true]";ex();
right();left();
ri "(LEFT@0|-|2)**EVAL";ex();
up();up();
left();
ri "BIND@?2"; ex();
ri "(LEFT@0|-|1)**EVAL"; ex();
up();ex();
up();up();ri "forall**REFLEX"; ex();
up();up();ri "forall**REFLEX"; ex();
up();right();
right();right();
ri "($FORALLBOOL2)**forall"; ex();
up();up();
ri "forall"; ex();
ri "EQUATION"; ex();
right();left();
rri "1|-|1"; ex();
assign "?x_27" "false";
left();left();left();left();left();
ri "BIND@?1"; ex();
ri "PCASEINTRO@[bool : ?P @ ?2 , ?3]=[true]";ex();
right();left();
ri "(LEFT@0|-|3)**EVAL"; ex();
up();up();
left();
ri "BIND@?2"; ex();
ri "(LEFT@0|-|2)**EVAL";ex();
up();ex();
up();up();ri "REFLEX";ex();
up();up();ri "REFLEX";ex();
up();ex();
up();up();rri "CASEINTRO"; ex();
top(); rri "EQUATION"; ex();
rri "forall"; ex();
right();right();
rri "forall"; ex();
ri "FORALLBOOL2"; ex();
p "FORALLSWITCH";


(* FORALLDROP:

forall @ [?x] = 

 |-?x

["ASSERT","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","REFLEX","forall"]  *)

start "forall@[?x]";
ri "PCASEINTRO@(true=?x)"; ex();
right();left();  (* first case *)
ri "forall"; ex();
left();left();
rri "0|-|1"; ex();
up();up();
ri "REFLEX"; ex();
up();right();  (* second case *)
rri "FORALLBOOL2"; ex();
right();right();
ri "BOOLDEF"; ri "EQUATION"; ri "1|-|1"; ex();
up();up();
ri "forall"; ri "EQUATION"; ex();
right();left();
ri "(BIND@?x)**(LEFT@ $0|-|2)**EVAL"; ex();
up();up();
rri "CASEINTRO"; ex();
top();
rri "BOOLDEF0"; ri "ASSERT2"; ex();
p "FORALLDROP";

(*

FORSOMEDROP:

forsome @ [?x] = 

 |-?x

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall","forsome"]

*)

s "forsome@[?x]";
ri "forsome"; ex();
right();
ri "FORALLDROP"; ex();
ri "NRULE1"; ex();
top();
ri "DUBNEG2"; ex();
p "FORSOMEDROP";

(* another case of quantifier switching *)

(* this is a nasty proof, very sensitive to stratification considerations *)

(* FORALLSWITCH2:

forall @ [forall @ [(?P @ ?1) @ ?2]] = 

forall @ [forall @ [bool : (?P @ ?2) @ ?1]]

["AND","ASSERT","BINDTYPE","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall"]  *)

s "forall@[forall@[(?P@?1)@?2]]";
ri "PCASEINTRO@forall@[forall@[bool:(?P@?2)@?1]]";
ri "LEFT@forall";ex();
right();left();  (* the positive case *)
right();right();  rri "FORALLBOOL2"; ex();
right();right();  rri "TYPES"; ex();
right();
ri "BIND@?1"; ex();
left();
ri "PCASEINTRO@[bool : (?P @ ?3) @ ?2]=[true]"; ex();
right();left();
ri "0|-|2"; ex();
up();up();
left();
ri "EQBOOL"; ex();
right();
ri "BIND@?2"; ex();
left();left();
rri "forall"; ex();
up();
ri "0|-|1"; ex();
up();
ri "EVAL"; ex();
up();
rri "TRUEBOOL"; ex();
up(); ex();
up();
ri "EVAL"; ex();

up();
rri "TRUEBOOL"; ex();
up();up();
ri "FORALLDROP**AT"; ex();
up();up();
ri "FORALLDROP**AT"; ex();
up();right();  (* enter the negative case *)
ri "forall"; ex();
ri "EQUATION"; ex();
right();left();  (* enter the contradictory case *)
initializecounter();
rri "1|-|1"; ex();
assign "?x_1" "false";
left();left();right();right();right();right();
ri "BIND@?1"; ex();
left();
ri "PCASEINTRO@[(?P @ ?2) @ ?3]=[true]";ex();
right();left();
ri "0|-|3"; ex();
up();up();
left();rri "forall2"; ex();
ri "BIND@?2"; ex();
ri "LEFT@0|-|2"; ex();
ri "EVAL"; ex();
up();up();ex();
ri "EVAL"; ex();
up(); rri "TRUEBOOL"; ex();
up();up();ri "FORALLDROP**AT"; ex();
up();up();up();ri "LEFT@REFLEX"; ex();

up();up();rri "CASEINTRO";ex();
up();up();ri "LEFT@ $forall";ex();
rri "BOOLDEF0"; rri "FORALLBOOL"; ex();
p "FORALLSWITCH2";

(* NOTFORALL:

 ~forall @ [?P @ ?1] = 

(forall @ [ ~?P @ ?1]) |  ~forall @ [?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall"]  *)

s "~forall@[?P@?1]";
ri "PCASEINTRO@forall@[~?P@?1]"; ex();
ri "LEFT@forall"; ex();
right();left();  (* go to the case of interest *)
right();
rri "FORALLBOOL2"; ex();
right();right();
rri "DUBNEG"; ex();
right();
ri "BIND@?1"; ri "LEFT@ 0|-|1"; ri "EVAL"; ex();
up();
rri "FDEF"; ex();
up();up();
ri "FORALLDROP"; ex();
ri "AF"; ex();
up();
ri "NEGF"; ex();
top();
right();right();
ri "MAKE_CASE"; ex();
top();
rri "OR_EXP"; ex();
rri "BOOLDEF0";  rri "ORBOOL"; ex();
ri "LEFT@ $forall"; ex();
p "NOTFORALL";


(* FORALLNOT:

forall @ [ ~?P @ ?1] = 

(forall @ [ ~?P @ ?1]) &  ~forall @ [?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall"]  *)

s "forall @ [ ~?P @ ?1]";
ri "FORALLBOOL"; ex();
ri "ASSERT2"; ex();
ri "3pt43aF@ ~forall@[?P@?1]"; ex();
right();
rri "NOTFORALL"; ex();
p "FORALLNOT";

(* FORALLOR:

forall @ [(?P @ ?1) | ?Q @ ?1] = 

(forall @ [?P @ ?1]) | forall 
@ [(?P @ ?1) | ?Q @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall"]  *)

s "forall@[(?P@?1)|?Q@?1]";
ri "PCASEINTRO@forall@[?P@?1]"; ex();
ri "LEFT@forall"; ex();
right();left();  (* proceed to the interesting case *)
right();right();left();
ri "(BIND@?1)**(LEFT@0|-|1)**EVAL"; ex();
up();
ri "DSYM"; ex();
ri "DZER"; ex();
up();up();
ri "FORALLDROP**AT"; ex();
top();
right();right();
ri "MAKE_CASE"; ex();
top();
right();right();
ri "MAKE_CASE"; ex();
top();
rri "OR_EXP"; ex();
rri "BOOLDEF0"; rri "ORBOOL"; ex();
ri "LEFT@ $forall";ex();
assign "?P" "[?P@?1]";
p "FORALLOR";

(* FORALLORDIST:

forall @ [?P | ?Q @ ?1] = 

?P | forall @ [?Q @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall"]  *)

s "forall@[?P|?Q@?1]";
ri "PCASEINTRO@(true=?P)"; ex();
right();left();  (* first case *)
right();right();left();
rri "0|-|1"; ex();
up();
ri "DSYM**DZER"; ex();
up();up();
ri "FORALLDROP**AT"; ex();
up();right();  (* enter the other case *)
right();right();
rri "DRULE2"; ex();
left();
rri "ASSERT2"; ri "BOOLDEF"; ri "EQUATION"; ri "1|-|1"; ex();
up();
ri "DSYM**DID"; ex();
rri "ASSERT2";ex();
up();up();
ri "FORALLBOOL2"; ex();
top();
right();right();
ri "MAKE_CASE"; ex();
top();
right();right();
ri "MAKE_CASE"; ex();
top();
rri "OR_EXP"; ex();
ri "($BOOLDEF0) ** ($ORBOOL)"; ex();
(* left();
rri "BOOLDEF"; ex();
ri "ASSERT2"; ex();
up();
ri "DRULE2"; ex(); *)
p "FORALLORDIST";

initializecounter();
s "forsome@[(?P@?1)&?Q]";
ri "forsome"; ex();
right();right();right();
rri "DEMa"; ex();
ri "DSYM";ex();
up();up();
ri "FORALLORDIST"; ex();
right();
ri "FORALLBOOL"; ex();
rri "DUBNEG"; ex();
ri "RIGHT@ $forsome2"; ex();
top();
rri "DEMb"; ex();
ri "(RL@DUBNEG**ASSERT2)**GCLEAN"; ex();
ri "CSYM";ex();
prove "FORSOMEDIST2"; 

(* popular Alves-Foss quantification theorems *)

(*

FORALL_NOTFORSOME:

~forsome @ ?P = 

forall @ [~?P @ ?1]

*)

s "~forsome @?P";
right();ri"forsome";ex();
top();ri "DUBNEG";ex();
rri "FORALLBOOL"; ex();
p "FORALL_NOTFORSOME";

(*

FORSOME_NOTFORALL:

~forall @ ?P = 

forsome @ [~?P @ ?1]

["BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","REFLEX","forall","forsome"]

*)

s "~forall @?P";
right(); ri "forall";  rri "forall2"; ex();
rri"FORALLBOOL2";ex();
right();right();
rri "DUBNEG";ex();
top();
rri "forsome";
ex();
p "FORSOME_NOTFORALL";


s "forall @ [(?P@?1)->?Q]";
right();right();ri "IF";ex();
ri "OR"; ex();
top();
rri"FORALL_NOTFORSOME";ex();
right();right();right();left();
ri "DUBNEG";ex();
up();right();
ri "NOTBOOL";ex();
up();
ri"ANDSCIN";ex();
up();up();
ri"FORSOMEDIST2";ex();
up();
rri"DEMa";ex();
right();
ri"DUBNEG";ex();
up();
left();
ri "NOTBOOL";ex();
up();
ri"ORSCIN";ex();
rri"IF";ex();
p "FORALL_IMP_FORSOME_EQ";

quit();
















