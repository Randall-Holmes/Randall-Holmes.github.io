(* Mar. 3, 1998 *)

(* sample application of UNEVAL added May 14, 1998 *)

(* more applications added May 17 *)

(* more quantifier theorems; calls the old total logic file *)

(* script with all earlier logic *)

script "gries9";

ae "ONEPOINT"; p "8pt14U";
ae "RIGHT"; p "R@?thm";
ae "LEFT"; p "L@?thm";

(*
******************************************************************
theorems below this point were proved by me (Michael Parvin)
******************************************************************
*)

(*
******************************************************************
8pt14E:

forsomer @ [?1 = ?e] , [?P @ ?1] =

 |-EVAL => ?P @ ?e

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsomer"]
******************************************************************
*)
s "forsomer@[?1=?e],[?P@?1]";
ri "forsomer2**(R@8pt14U)**NRULE2**DUBNEG2"; ex();
right();
ri "EVAL";
p "8pt14E";


(*
******************************************************************
UNIV_RANGE_2:

forsomer @ [true] , [?p @ ?1] =

forsome @ [?p @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsome",
"forsomer"]
******************************************************************
*)
s "forsomer@[true],[?P@?1]";
ri "forsomer2**(R@UNIV_RANGE_1)** $forsome2";ex();
p "UNIV_RANGE_2";

(* other theorems to introduce or strip bool: lables from ranged quantifiers *)


(*
******************************************************************
FORALLRBOOL2:

forallr @ [?R @ ?1] , [?P @ ?1] =

forallr @ [bool : ?R @ ?1] , [?P @ ?1]

["ASSERT","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","IF",
"NONTRIV","NOT","OR","PI1","PI2","REFLEX","TYPES","forallr"]
******************************************************************
*)
s "forallr@[?R@?1],[?P@?1]";
ri "forallr2**(R@VALUE@[($IRULE2)**L@ASSERT])** $forallr2";ex();
p "FORALLRBOOL2";


(*
******************************************************************
FORALLRBOOL3:

forallr @ [?R @ ?1] , [?P @ ?1] =

forallr @ [?R @ ?1] , [bool : ?P @ ?1]

["ASSERT","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","IF",
"NONTRIV","NOT","OR","PI1","PI2","REFLEX","TYPES","forallr"]
******************************************************************
*)
s "forallr@[?R@?1],[?P@?1]";
ri "forallr2**(R@VALUE@[($IRULE3)**R@ASSERT])** $forallr2";ex();
p "FORALLRBOOL3";


(*
******************************************************************
FORSOMERBOOL2:

forsomer @ [?R @ ?1] , [?P @ ?1] =

forsomer @ [bool : ?R @ ?1] , [?P @ ?1]

["ASSERT","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","IF",
"NONTRIV","NOT","OR","PI1","PI2","REFLEX","TYPES","forallr",
"forsomer"]
******************************************************************
*)
s "forsomer@[?R@?1],[?P@?1]";
ri "forsomer2**(R@FORALLRBOOL2)** $forsomer2"; ex();
p "FORSOMERBOOL2";


(*
******************************************************************
FORSOMERBOOL3:

forsomer @ [?R @ ?1] , [?P @ ?1] =

forsomer @ [?R @ ?1] , [bool : ?P @ ?1]

["BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT",
"PI1","PI2","REFLEX","forsomer"]
******************************************************************
*)
s "forsomer@[?R@?1],[?P@?1]";
ri "forsomer2**(R@R@R@VALUE@[$NOTBOOLDROP])** $forsomer2"; ex();
p "FORSOMERBOOL3";


(*
******************************************************************
8pt13U:

forallr @ [false] , [?P @ ?1] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "forallr@[false],[?P@?1]";
ri "forallr2**(R@VALUE@[3pt75])**FORALLDROP**AT";ex();
p "8pt13U";


(*
******************************************************************
8pt13E:

forsomer @ [false] , [?P @ ?1] =

false

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsomer"]
******************************************************************
*)
s "forsomer@[false],[?P@?1]";
ri "forsomer2**(R@8pt13U)** $FDEF"; ex();
p "8pt13E";


(*
******************************************************************
8pt15U:

(forallr @ [?R @ ?1] , [?P @ ?1]) & forallr
@ [?R @ ?1] , [?Q @ ?1] =

forallr @ [?R @ ?1] , [(?P @ ?1) & ?Q @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "(forallr@[?R@?1],[?P@?1])&forallr@[?R@?1],[?Q@?1]";
ri "(RL@forallr2)** $FORALLDIST"; ex();
ri "(R@VALUE@[(RL@IF)**($DDISC)** $IF])** $forallr2";ex();
p "8pt15U";


(*
******************************************************************
8pt15E:

(forsomer @ [?R @ ?1] , [?P @ ?1]) | forsomer
@ [?R @ ?1] , [?Q @ ?1] =

forsomer @ [?R @ ?1] , [(?P @ ?1) | ?Q @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsomer"]
******************************************************************
*)
s "(forsomer@[?R@?1],[?P@?1])|forsomer@[?R@?1],[?Q@?1]";
ri "(RL@forsomer2)**DEMa**R@8pt15U**R@R@VALUE@[DEMb]"; ex();
rri "forsomer2"; ex();
p "8pt15E";


(*
******************************************************************
8pt16U:

forallr @ [(?R @ ?1) | ?S @ ?1] , [?P @ ?1] =

(forallr @ [?R @ ?1] , [?P @ ?1]) & forallr
@ [?S @ ?1] , [?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "forallr@[(?R@?1)|?S@?1],[?P@?1]";
ri "forallr2**(R@VALUE@[$3pt78])**FORALLDIST**RL@ $forallr2"; ex();
p "8pt16U";


(*
******************************************************************
8pt16E:

forsomer @ [(?R @ ?1) | ?S @ ?1] , [?P @ ?1] =

(forsomer @ [?R @ ?1] , [?P @ ?1]) | forsomer
@ [?S @ ?1] , [?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsomer"]
******************************************************************
*)
s "forsomer@[(?R@?1)|?S@?1],[?P@?1]";
ri "forsomer2**(R@8pt16U)**($DEMa)**RL@ $forsomer2"; ex();
p "8pt16E";


(*
******************************************************************
8pt19U:

forallr @ [?R @ ?1]
, [forallr @ [?Q @ ?2] , [?P @ ?1 , ?2]] =

forallr @ [?Q @ ?1]
, [forallr @ [?R @ ?2] , [?P @ ?2 , ?1]]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "forallr@[?R@?1],[forallr@[?Q@?2],[?P@?1,?2]]";
ri "forallr2"; ex();
right();right();
ri "(R@forallr2)**IDEF2** $FORALLORDIST"; ex();
right();right();
ri "(R@IDEF2)**($DASSOC)**(L@DSYM)**PAIRBIND@?1,?2"; ex();
top();
ri "FORALLSWITCH"; ex();
right();right();right();right();
ri "EVAL**(L@RL@R@R@PI1**PI2)**DASSOC**R@ $IDEF2";ex();
up();up();
ri "FORALLORDIST**(R@ $forallr2)** $IDEF2"; ex();
top();
rri "forallr2"; ex();
p "8pt19U";


(*
******************************************************************
8pt19E:

forsomer @ [?R @ ?1]
, [forsomer @ [?Q @ ?2] , [?P @ ?1 , ?2]] =

forsomer @ [?Q @ ?1]
, [forsomer @ [?R @ ?2] , [?P @ ?2 , ?1]]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsomer"]
******************************************************************
*)
s "forsomer@[?R@?1],[forsomer@[?Q@?2],[?P@?1,?2]]";
ri "(R@R@VALUE@[forsomer2])**forsomer2"; ex();
right();right();right();right();
ri "DUBNEG**($FORALLRBOOL)**R@R@VALUE@[BIND@?1,?2]";ex();
top();right();
ri "8pt19U";ex();
right();right();
ri "VALUE@[(R@R@VALUE@[EVAL])**FORALLRBOOL** $DUBNEG]"; ex();
ri "VALUE@[R@ $forsomer2]";ex();
top();
rri "forsomer2";ex();
p "8pt19E";


(*
******************************************************************
9pt3a:

forallr @ [?R @ ?1] , [?P @ ?1] =

forall @ [( ~?R @ ?1) | ?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forallr"]
******************************************************************
*)
s "forallr@[?R@?1],[?P@?1]";
ri "forallr2**R@VALUE@[IDEF2]"; ex();
p "9pt3a";


(*
******************************************************************
9pt3b:

forallr @ [?R @ ?1] , [?P @ ?1] =

forall @ [((?R @ ?1) & ?P @ ?1) == ?R @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forallr"]
******************************************************************
*)
s "forallr@[?R@?1],[?P@?1]";
ri "forallr2**R@VALUE@[IDEF3]"; ex();
p "9pt3b";


(*
******************************************************************
9pt3c:

forallr @ [?R @ ?1] , [?P @ ?1] =

forall @ [((?R @ ?1) | ?P @ ?1) == ?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forallr"]
******************************************************************
*)
s "forallr@[?R@?1],[?P@?1]";
ri "forallr2**R@VALUE@[IDEF]"; ex();
p "9pt3c";


(*
******************************************************************
9pt4a:

forallr @ [(?Q @ ?1) & ?R @ ?1] , [?P @ ?1] =

forallr @ [?Q @ ?1] , [(?R @ ?1) -> ?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forallr"]
******************************************************************
*)
s "forallr@[(?Q@?1)&?R@?1],[?P@?1]";
ri "forallr2**(R@VALUE@[$3pt65])** $forallr2"; ex();
p "9pt4a";


(*
******************************************************************
9pt4b:

forallr @ [(?Q @ ?1) & ?R @ ?1] , [?P @ ?1] =

forallr @ [?Q @ ?1] , [( ~?R @ ?1) | ?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forallr"]
******************************************************************
*)
s "forallr@[(?Q@?1)&?R@?1],[?P@?1]";
ri "9pt4a**R@R@VALUE@[IDEF2]";ex();
p "9pt4b";


(*
******************************************************************
9pt4c:

forallr @ [(?Q @ ?1) & ?R @ ?1] , [?P @ ?1] =

forallr @ [?Q @ ?1]
, [((?R @ ?1) & ?P @ ?1) == ?R @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forallr"]
******************************************************************
*)
s "forallr@[(?Q@?1)&?R@?1],[?P@?1]";
ri "9pt4a**R@R@VALUE@[IDEF3]";ex();
p "9pt4c";


(*
******************************************************************
9pt4d:

forallr @ [(?Q @ ?1) & ?R @ ?1] , [?P @ ?1] =

forallr @ [?Q @ ?1]
, [((?R @ ?1) | ?P @ ?1) == ?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forallr"]
******************************************************************
*)
s "forallr@[(?Q@?1)&?R@?1],[?P@?1]";
ri "9pt4a**R@R@VALUE@[IDEF]";ex();
p "9pt4d";


(*
******************************************************************
9pt5:

?P | forallr @ [?R @ ?1] , [?Q @ ?1] =

forallr @ [?R @ ?1] , [?P | ?Q @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "?P|forallr@[?R@?1],[?Q@?1]";
ri "(R@forallr2)** $FORALLORDIST"; ex();
right();right();
ri "(R@IDEF2)**($DASSOC)**(L@DSYM)**DASSOC** $IDEF2";ex();
top();
rri "forallr2"; ex();
p "9pt5";


(*
******************************************************************
9pt6:

forallr @ [?R @ ?1] , [?P] =

?P | forall @ [ ~?R @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "forallr@[?R@?1],[?P]";
ri "9pt3a**(R@VALUE@[DSYM])**FORALLORDIST"; ex();
p "9pt6";


(*
******************************************************************
9pt7:

( ~forall @ [ ~?R @ ?1])
-> (forallr @ [?R @ ?1] , [?P & ?Q @ ?1]) == ?P
& forallr @ [?R @ ?1] , [?Q @ ?1] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "(~forall@[~?R@?1])->(forallr@[?R@?1],[?P&?Q@?1])==?P&forallr@[?R@?1],[?Q@?1]";
ri "(R@L@($8pt15U)**L@9pt6)**3pt62";ex();
left();
ri "($CASSOC)**L@(R@DSYM**L@FORALLBOOL** $DUBNEG)**3pt44a"; ex();
ri "CASSOC";ex();
up();
ri "($3pt62)**(R@BID)**IRZER"; ex();
p "9pt7";


(*
******************************************************************
9pt8:

forallr @ [?R @ ?1] , [true] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "forallr@[?R@?1],[true]";
ri "forallr2**(R@VALUE@[IRZER])**FORALLDROP**AT"; ex();
p "9pt8";


(*
******************************************************************
9pt10:

(forallr @ [(?Q @ ?1) | ?R @ ?1] , [?P @ ?1])
-> forallr @ [?Q @ ?1] , [?P @ ?1] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "(forallr@[(?Q@?1)|?R@?1],[?P@?1])->forallr@[?Q@?1],[(?P@?1)]";
ri "(L@8pt16U)**3pt76b";ex();
p "9pt10";


(*
******************************************************************
9pt11:

(forallr @ [?R @ ?1] , [(?P @ ?1) & ?Q @ ?1])
-> forallr @ [?R @ ?1] , [?P @ ?1] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr"]
******************************************************************
*)
s "(forallr@[?R@?1],[(?P@?1)&?Q@?1])->forallr@[?R@?1],[(?P@?1)]";
ri "(L@ $8pt15U)**3pt76b";ex();
p "9pt11";



(*
******************************************************************
9pt18a:

 ~forsomer @ [?R @ ?1] , [ ~?P @ ?1] =

forallr @ [?R @ ?1] , [?P @ ?1]

["ASSERT","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","IF",
"NONTRIV","NOT","OR","PI1","PI2","REFLEX","TYPES","forall",
"forallr","forsomer"]
******************************************************************
*)
s "~forsomer@[?R@?1],[~?P@?1]";
ri "(R@forsomer2)**DUBNEG** $FORALLRBOOL"; ex();
ri "(R@R@VALUE@[DUBNEG])** $FORALLRBOOL3"; ex();
p "9pt18a";


(*
******************************************************************
9pt18b:

 ~forsomer @ [?R @ ?1] , [?P @ ?1] =

forallr @ [?R @ ?1] , [ ~?P @ ?1]

["BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","IF","NONTRIV",
"NOT","OR","P
I1","PI2","REFLEX","forall","forallr","forsomer"]
******************************************************************
*)
s "~forsomer@[?R@?1],[?P@?1]";
ri "(R@forsomer2)**DUBNEG** $FORALLRBOOL"; ex();
p "9pt18b";


(*
******************************************************************
9pt18c:

forsomer @ [?R @ ?1] , [ ~?P @ ?1] =

 ~forallr @ [?R @ ?1] , [?P @ ?1]

["ASSERT","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","IF",
"NONTRIV","NOT","OR","PI1","PI2","REFLEX","TYPES","forallr",
"forsomer"]
******************************************************************
*)
s "forsomer@[?R@?1],[~?P@?1]";
ri "forsomer2**(R@R@R@VALUE@[DUBNEG])**R@ $FORALLRBOOL3"; ex();
p "9pt18c";


(*
******************************************************************
9pt20:

forsomer @ [(?Q @ ?1) & ?R @ ?1] , [?P @ ?1] =

forsomer @ [?Q @ ?1] , [(?R @ ?1) & ?P @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forallr","forsome","forsomer"]
******************************************************************
*)
s "forsomer@[(?Q@?1)&?R@?1],[?P@?1]";
ri "forsomer3**(R@VALUE@[CASSOC])** $forsomer3"; ex();
p "9pt20";


(*
******************************************************************
9pt21:

forsomer @ [?R @ ?1] , [?P & ?Q @ ?1] =

?P & forsomer @ [?R @ ?1] , [?Q @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsomer"]
******************************************************************
*)
s "forsomer@[?R@?1],[?P&?Q@?1]";
ri "forsomer2**R@(R@R@VALUE@[$DEMa])** $9pt5"; ex();
ri "($DEMb)**(L@DUBNEG2)**CRULE2**R@ $forsomer2"; ex();
p "9pt21";


(*
******************************************************************
9pt22:

forsomer @ [?R @ ?1] , [?P] =

?P & forsome @ [?R @ ?1]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsome",
"forsomer"]
******************************************************************
*)
s "forsomer@[?R@?1],[?P]";
ri "forsomer3**FORSOMEDIST2**CSYM"; ex();
p "9pt22";


(*
******************************************************************
9pt23:

(forsome @ [?R @ ?1])
-> (forsomer @ [?R @ ?1] , [?P | ?Q @ ?1]) == ?P
| forsomer @ [?R @ ?1] , [?Q @ ?1] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsome",
"forsomer"]
******************************************************************
*)
s "(forsome@[?R@?1])->(forsomer@[?R@?1],[?P|?Q@?1])==?P|forsomer@[?R@?1],[?Q@?1]";
ri "L@forsome2"; ex();
ri "R@(L@forsomer2)**(R@R@forsomer2)**L@R@R@R@VALUE@[$DEMb]"; ex();
ri "(R@3pt11**R@($DEMb)**R@DUBNEG** $FORALLRBOOL)**9pt7";ex();
p "9pt23";


(*
******************************************************************
9pt24:

forsomer @ [?R @ ?1] , [false] =

false

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsomer"]
******************************************************************
*)
s "forsomer@[?R@?1],[false]";
ri "forsomer2**(R@R@R@VALUE@[NEGF])**(R@9pt8)** $FDEF"; ex();
p "9pt24";


(*
******************************************************************
9pt25:

(forsomer @ [?R @ ?1] , [?P @ ?1]) -> forsomer
@ [(?Q @ ?1) | ?R @ ?1] , [?P @ ?1] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsomer"]
******************************************************************
*)
s "(forsomer@[?R@?1],[?P@?1])->forsomer@[(?Q@?1)|?R@?1],[?P@?1]";
ri "(RL@forsomer2)**($CONTP)**L@R@L@VALUE@[DSYM]"; ex();
ri "(RL@RIGHT@RIGHT@VALUE@[BIND@?1])**9pt10";ex();
p "9pt25";


(*
******************************************************************
9pt26:

(forsomer @ [?R @ ?1] , [?P @ ?1]) -> forsomer
@ [?R @ ?1] , [(?P @ ?1) | ?Q @ ?1] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION",
"FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR",
"PI1","PI2","REFLEX","TYPES","XOR","forall","forallr","forsome",
"forsomer"]
******************************************************************
*)
s "(forsomer@[?R@?1],[?P@?1])->forsomer@[?R@?1],[(?P@?1)|?Q@?1]";
ri "RL@forsomer3**(R@VALUE@[CSYM])** $forsomer3"; ex();
ri "(R@R@L@VALUE@[DSYM])**9pt25"; ex();
p "9pt26";

(* application of the new built-in tactic UNEVAL *)

s "(forall@?t)||?x,?y";
ri "LEFT@forall";
ri "LEFT_CASE@EVERYWHERE2@UNEVAL@?t";
ri "PIVOT";
ri "LEFT_CASE@EVERYWHERE2@EVAL";
ri "LEFT@ $forall";
p "UNIV_TAC";

s "(forall@[(?P@?1)=?Q@?1])";
ri "forall"; ri "EQUATION"; ex();
ri "PCASEINTRO@[?P@?1]=[?Q@?1]"; ex();
right(); left(); ri "EVERYWHERE2@UNEVAL@[?P@?1]"; ex();
ri "EVERYWHERE2@0|-|1"; ex();
ri "EVERYWHERE2@EVAL**REFLEX"; ex();
up(); right(); right(); left(); rri "(2|-|1)@false"; ex(); 
left(); left(); left(); ri "PCASEINTRO@(?P@?1)=?Q@?1"; ri "PIVOT"; ex();
left(); ri "BIND@?1"; ri "LEFT@0|-|2"; ri "EVAL"; up();ex();
up();up(); ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); rri "EQUATION"; ex();
p "UNIV_EQ";

s "(forall@[(?P@?1)=?Q@?1])||?t,?u";
ri "LEFT@UNIV_EQ"; ex();
right(); left(); ri "EVERYWHERE@UNEVAL@[?P@?1]"; ri "EVERYWHERE@0|-|1";
	ri "EVERYWHERE@EVAL";
top(); ri "LEFT@ $UNIV_EQ";
p "UNIV_EQ_TAC";

(* development of rewriting tools like those in HOL *)

(* this is a dirty trick, and not really analogous to the HOL stuff *)

(* will not work with versions before Aug 13, 1999 *)

s "?x";
ri "?a=?a";
left(); ri "REFLEX** $?thm";
p "STRONG_REWRITE_WITH_EQUATION@?thm";

(* is there a way to do this without the trick?  Probably not without
addition of something like unification, or without giving ?y
as a parameter. *)

(* design a REWRITE_TAC *)



quit();
