(* additional theorems about implication added June 3, 1998 *)

(* August 19th, 1997 as part of general rebuild *)

(* Michael Parvin's development of chapter 3 of Gries and Schneider *)

(* redone for Baby *)

script "tableau";

(* typing  axioms *)

(* proved elsewhere -- in logicdefs.mk2 *)

(* a "TWOASSERTS" "|- |-?p" "|-?p";
a "BTYPE" "?p==?q" "|-(|-?p)== |-?q";
a "XORTYPE" "?p=/=?q" "|-(|-?p)=/= |-?q"; (* can be proved as theorem *)
a "NTYPE" "~?p" "|- ~ |-?p";
a "DTYPE" "?p|?q" "|-(|-?p)| |-?q";
a "CTYPE" "?p&?q" "|-(|-?p)& |-?q"; (* can be proved as theorem *)
a "IMPTYPE" "?p->?q" "|-(|-?p)-> |-?q";
a "CONTYPE" "?p<-?q" "|-(|-?p)<- |-?q";
a "EQSYMM" "?x=?y" "?y=?x";
 *)

(*

(* typing lemmas needed for propositional logic *)

(* used by PROVETAUT tactics in tableau.mk2, so already proved there *)

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

*)

(* theorem and tactic list *)

(*

////////////////////////  thms.lst  ////////////////////////////



?thm1**?thm2
$?thm
LEFT@?thm
RIGHT@?thm
RL@?thm
TWOASSERTS       "|- |-?p"                     "|-?p"
BTYPE            "?p==?q"                      "|-(|-?p)== |-?p"
XORTYPE          "?p=/=?q"                     "|-(|-?p)=/= |-?p"
NTYPE            "~?p"                         "|- ~ |-?p"
DTYPE            "?p|?q"                       "|-(|-?p)| |-?p"
CTYPE            "?p&?q"                       "|-(|-?p)& |-?p"
IMPTYPE          "?p->?q"                      "|-(|-?p)-> |-?q"
CONTYPE          "?p<-?q"                      "|-(|-?p)<- |-?q"
ALLASSERTS
BRULE1           "|-?p==?q"                    "?p==?q"
BRULE2           "(|-?p)==?q"                  "?p==?q"
BRULE3           "?p== |-?q"                   "?p==?q"
DRULE1           "|-?p|?q"                     "?p|?q"
DRULE2           "(|-?p)|?q"                   "?p|?q"
DRULE3           "?p| |-?q"                    "?p|?q"
CRULE1           "|-?p&?q"                     "?p&?q"
CRULE2           "(|-?p)&?q"                   "?p&?q"
CRULE3           "?p& |-?q"                    "?p&?q"
XRULE1           "|-?p=/=?q"                   "?p=/=?q"
XRULE2           "(|-?p)=/=?q"                 "?p=/=?q"
XRULE3           "?p=/= |-?q"                  "?p=/=?q"
NRULE1           "|- ~?q"                      "~?q"
NRULE2           "~ |-?q"                      "~?q"
IRULE1           "|-?p->?q"                    "?p->?q"
IRULE2           "(|-?p)->?q"                  "?p->?q"
IRULE3           "?p-> |-?q"                   "?p->?q"
CNRULE1          "|-?p<-?q"                    "?p<-?q"
CNRULE2          "(|-?p)<-?q"                  "?p<-?q"
CNRULE3          "?p<- |-?q"                   "?p<-?q"
GCLEAN
CLEAN1
CLEAN2
CLEAN
ASSRTBOTH@?p
ASRTLEFT@?p
ASRTRIGHT@?p
MKASRT@?p
THMAP@?dir,?astrm,?thm
BASSOC           "(?p==?q)==?r"                "?p==?q==?r"
BSYM             "?p==?q"                      "?q==?p"
BID              "?p==?p"                      "true"
BID2             "?p==true"                    "|-?p"
FDEF             "false"                       "~true"
BDIS             "~?p==?q"                     "(~?p)==?q"
XORDEF           "?p=/=?q"                     "~?p==?q"
DSYM             "?p|?q"                       "?q|?p"
DASSOC           "(?p|?q)|?r"                  "?p|?q|?r"
DIDEM            "?p|?p"                       "|-?p"
DDIS             "?p|?q==?r"                   "(?p|?q)==?p|?r"
DXM              "?p| ~?p"                     "true"
GR               "(?p&?q)==?p|?q"              "?p==?q"
IDEF             "?p->?q"                      "(?p|?q)==?q"
CONS             "?p->?q"                      "?q<-?p"
LZ               "(?e=?f)&?F@?e"               "(?e=?f)&?F@?f";
ASRTEQ           "?e=?f"                       "|-?e=?f";
BCONV            "?e==?f"                      "(|-?e)= |-?f"
EQT              "(|-?p)=true"                 "?p=true"
BIDF@?p          "true"                        "?p==?p"
DXMF@?p          "true"                        "?p| ~?p"
APLZ
3pt11            "(~?p)==?q"                   "?p== ~?q"
3pt14            "?p=/=?q"                     "(~?p)==?q"
3pt15a           "?p==false"                   "~?p"
3pt15b           "(~?p)==?p"                   "false"
3pt15bF@?p       "false"                       "(~?p)==?p"
NEGF             "~false"                      "true"
DUBNEG2           "~ ~?p"                       "|-?p"
NEQ              "?p==?q"                      "(~?p)== ~?q"
XORSYM           "?p=/=?q"                     "?q=/=?p"
XORASSOC         "(?p=/=?q)=/=?r"              "?p=/=?q=/=?r"
MUTASSOC         "(?p=/=?q)==?r"               "?p=/=?q==?r"
MUTINT           "?p=/=?q==?r"                 "?p==?q=/=?r"
DZER             "?p|true"                     "true"
DZERF@?p         "true"                        "?p|true"
DDISD            "?p|?q|?r"                    "(?p|?q)|?p|?r"
DID              "?p|false"                    "|-?p"
3pt32            "(?p|?q)==?p| ~?q"            "|-?p"
3pt32F@?q        "|-?p"                        "(?p|?q)==?p| ~?q"
GR2              "(?p==?q)==?p|?q"             "?p&?q"
GR3              "(?p==?q)==?p&?q"             "?p|?q"
DEMb             "(~?p)& ~?q"                  "~?p|?q"
DEMa             "(~?p)| ~?q"                  "~?p&?q"
BFLIP            "~?p==?q"                     "(~?p)=/= ~?q"
XORFLIP          "~?p=/=?q"                    "(~?p)== ~?q"
FLIPPASTA
FLIPPASTN
FLIPPASTB
FLIPPASTX
FLIPPASTD
FLIPPASTC
SFLIPALL
FLIPALL
AT               "|-true"                      "true"
AF               "|-false"                     "false"
REMA             "|- ~?p"                      "~ |-?p"
SREMFLIP
REMFLIP
DUAL@?thm
CSYM             "?p&?q"                       "?q&?p"
CASSOC           "(?p&?q)&?r"                  "?p&?q&?r"
CIDEM            "?p&?p"                       "|-?p"
CID              "?p&true"                     "|-?p"
CZER             "?p&false"                    "false"
CZERF@?p         "false"                       "?p&false"
CDISC            "?p&?q&?r"                    "(?p&?q)&?p&?r"
CCON             "?p& ~?p"                     "false"
3pt43a           "?p&?p|?q"                    "|-?p"
3pt43aF@?q       "|-?p"                        "?p&?p|?q"
3pt43b           "?p|?p&?q"                    "|-?p"
3pt43bF@?q       "|-?p"                        "?p|?p&?q"
L3pt43           "?p==(~?p)|?q"                "?p&?q"
3pt44a           "?p&(~?p)|?q"                 "?p&?q"
3pt44b           "?p|(~?p)&?q"                 "?p|?q"
DDISC            "?p|?q&?r"                    "(?p|?q)&?p|?r"
CDISD            "?p&?q|?r"                    "(?p&?q)|?p&?r"
3pt48            "(?p& ~?q)== ~?p"             "?p&?q"
3pt49            "(?p&?q)==(?p&?r)==?p"        "?p&?q==?r"
3pt50            "?p&?q==?p"                   "?p&?q"
REPL             "(?p==?q)&?r==?p"             "(?p==?q)&?r==?q"
BALTDEF          "?p==?q"                      "(?p&?q)|(~?p)& ~?q"
XALTDEF          "?p=/=?q"                     "((~?p)&?q)|?p& ~?q"
IDEF2            "?p->?q"                      "(~?p)|?q"
IDEF3            "?p->?q"                      "(?p&?q)==?p"
CONTP            "?p->?q"                      "(~?q)-> ~?p"
IDISB            "?p->?q==?r"                  "(?p->?q)==?p->?r" 
3pt62            "?p->?q==?r"                  "(?p&?q)==?p&?q"
3pt65            "?p->?q->?r"                  "(?p&?q)->?r"
3pt64            "(?p->?q)->?p->?r"            "?p->?q->?r"           
3pt66            "?p&?p->?q"                   "?p&?q"
3pt67            "?p&?q->?p"                   "|-?p"
3pt67F@?q        "|-?p"                        "?p&?q->?p"
3pt68            "?p|?p->?q"                   "true"
3pt68F@?p,?q     "true"                        "?p|?p->?q"
3pt69            "?p|?q->?p"                   "?q->?p"
3pt70            "(?p|?q)->?p&?q"              "?p==?q"
IREF             "?p->?p"                      "true"
IREFF@?p         "true"                        "?p->?p"
IRZER            "?p->true"                    "true"
IRZERF@?p        "true"                        "?p->true"
ILID             "true->?p"                    "|-?p"
3pt74            "?p->false"                   "~?p"
3pt75            "false->?p"                   "true"
3pt75F@?p        "true"                        "false->?p"
3pt76a           "?p->?p|?q"                   "true"
3pt76aF@?p,?q    "true"                        "?p->?p|?q"
3pt76b           "(?p&?q)->?p"                 "true"
3pt76bF@?p,?q    "true"                        "(?p&?q)->?p"
3pt76c           "(?p&?q)->?p|?q"              "true"
3pt76cF@?p,?q    "true"                        "(?p&?q)->?p|?q"
3pt76d           "(?p|?q&?r)->?p|?q"           "true"
3pt76dF@?p,?q,?r "true"                        "(?p|?q&?r)->?p|?q"
3pt76e           "(?p&?q)->?p&?q|?r"           "true"
3pt76eF@?p,?q,?r "true"                        "(?p&?q)->?p&?q|?r"
MOP              "(?p&?p->?q)->?q"             "true"
MOPF@?p,?q       "true"                        "(?p&?p->?q)->?q"
3pt78            "(?p->?r)&?q->?r"             "(?p|?q)->?r"
3pt79            "(?p->?r)&(~?p)->?r"          "|-?r"
3pt79F@?p        "|-?r"                        "(?p->?r)&(~?p)->?r"
3pt80            "(?p->?q)&?q->?p"             "?p==?q"
3pt81            "((?p->?q)&?q->?p)->?p==?q"   "true"
3pt81F@?p,?q     "true"                        "((?p->?q)&?q->?p)->?p==?q"
3pt82a           "((?p->?q)&?q->?r)->?p->?r"   "true"
3pt82aF@?p,?q,?r "true"                        "((?p->?q)&?q->?r)->?p->?r"
3pt82b           "((?p==?q)&?q->?r)->?p->?r"   "true"
3pt82bF@?p,?q,?r "true"                        "((?p==?q)&?q->?r)->?p->?r"
3pt82c           "((?p->?q)&?q==?r)->?p->?r"   "true"
3pt82cF@?p,?q,?r "true"                        "((?p->?q)&?q==?r)->?p->?r"
3pt83            "(?e=?f)->(?F@?e)=?F@?f"      "true"
3pt83F@?F,?e,?f  "true"                        "(?e=?f)->(?F@?e)=?F@?f"
3pt84b           "(?e=?f)->?F@?e"              "(?e=?f)->?F@?f"
3pt84c           "(?q&?e=?f)->?F@?e"           "(?q&?e=?f)->?F@?f"
3pt85a           "?p->?F@?p"                   "?p->?F@true"
3pt85b           "(?q&?p)->?F@?p"              "(?q&?p)->?F@true"
3pt86a           "(?F@ |-?p)->?p"              "(?F@false)->?p"
AP3pt86a
3pt86b           "(?F@ |-?p)->?p|?q"           "(?F@false)->?p|?q"
AP3pt86b
3pt87            "?p&?F@?p"                    "?p&?F@true"
3pt88            "?p|?F@ |-?p"                 "?p|?F@false"
AP3pt88
3pt89            "(?p&?F@true)|(~?p)&?F@false" "|-?F@ |-?p"

*)

(* my (MP's) version of clean *)


s "?x ^+ |-?y";
ri "(?p ^+ |-?q)= ?p ^+ ?q";
p "STL";

s "(|-?x) ^+ ?y";
ri "((|-?p) ^+ ?q)= ?p ^+ ?q";
p "STR";

s "|-?x ^+ ?y";
ri "(|-?p ^+ ?q)= ?p ^+ ?q";
p "STT";

dpt "GCLEAN";
s "?x";
ri "ALLASSERTS**RIGHT@(RIGHT@ALLASSERTS)**LEFT@ALLASSERTS";
(* rri "BTYPE"; ari "BRULE1"; ari "BRULE2"; ari "BRULE3";
arri "CTYPE"; ari "CRULE1"; ari "CRULE2"; ari "CRULE3"; 
arri "DTYPE"; ari "DRULE1"; ari "DRULE2"; ari "DRULE3";
arri "NTYPE"; ari "NRULE1"; ari "NRULE2";
arri "XORTYPE"; ari "XRULE1"; ari "XRULE2"; ari "XRULE3";
arri "IMPTYPE"; ari "IRULE1"; ari "IRULE2"; ari "IRULE3"; 
arri "CONTYPE"; ari "CNRULE1"; ari "CNRULE2"; ari "CNRULE3";
*)
ri "STT"; ri "STR"; ri "STL"; ri "NRULE1"; ri "NRULE2";

(*
rri "(?p ^+ ?q)= |-(|-?p) ^+ |-?q"; rri "NTYPE";
ri "(|-?p ^+ ?q)= ?p ^+ ?q"; ri "NRULE1";
ri "((|-?p) ^+ ?q)= ?p ^+ ?q";
ri "(?p ^+ |-?q)= ?p ^+ ?q"; ri "NRULE2";
*)
ri "RL@GCLEAN";
p "GCLEAN"; 


(* ************************** all ?p assertion *********************** *)
dpt "MKASRT";

s "?p ^+ ?p";
rri "((|-?r) ^+ ?s)=?r ^+ ?s";
rri "(?r ^+ |-?s)=?r ^+ ?s";
p "ASSRTBOTH@?p";

s "?p ^+ ?q";
rri "((|-?r) ^+ ?s)=?r ^+ ?s";
ri "RIGHT@MKASRT@?p";
p "ASRTLEFT@?p";

s "?q ^+ ?p";
rri "(?r ^+ |-?s)=?r ^+ ?s";
ri "LEFT@MKASRT@?p";
p "ASRTRIGHT@?p";

s "?r ^+ ?s";
ri "ASSRTBOTH@?p";
ari "ASRTLEFT@?p";
ari "ASRTRIGHT@?p";
ari "RL@MKASRT@?p";
p "MKASRT@?p";

(* general purpose application for theorems that require a functional 
assertion on one of their sides. *)
s "?x ^+ ?y";
ri "?dir@(MKASRT@?astrm)**BIND@ |-?astrm"; ri "?thm"; ri "?dir@EVAL";
p "THMAP@?dir,?astrm,?thm";

(* the Gries axioms are actually proved using the tactic NEWTAUT in
tableau.mk2 *)

(* axioms
(* ******************** axioms for biequivalence ********************* *)
a "BASSOC" "(?p==?q)==?r" "?p==?q==?r";
a "BSYM" "?p==?q" "?q==?p";
a "BID" "?p==?p" "true";
a "BID2" "?p==true" "|-?p";


(* ********************** axioms for negation ************************ *)
a "FDEF" "false" "~true";
a "BDIS" "~?p==?q" "(~?p)==?q";

(* ************************* axioms for xor ************************** *)
a "XORDEF" "?p=/=?q" "~?p==?q";



(* ********************* axioms for disjunction ********************** *)
a "DSYM" "?p|?q" "?q|?p";
a "DASSOC" "(?p|?q)|?r" "?p|?q|?r";
a "DIDEM" "?p|?p" "|-?p";
a "DDIS" "?p|?q==?r" "(?p|?q)==?p|?r";
a "DXM" "?p| ~?p" "true";

(* ********************* axioms for conjunction ********************** *)
a "GR" "(?p&?q)==?p|?q" "?p==?q";

(* ********************* axioms for implication ********************** *)
a "IDEF" "?p->?q" "(?p|?q)==?q";

(* ********************* axioms for consequence ********************** *)
a "CONS" "?p->?q" "?q<-?p";



(* ********************* axioms for substitution ********************* *)
a "LZ" "(?e=?f)&?F@?e" "(?e=?f)&?F@?f";
a "ASRTEQ" "?e=?f" "|-?e=?f";
a "BCONV" "?e==?f" "(|-?e)= |-?f";
a "EQT" "(|-?p)=true" "?p=true";


*)


(* ///////////////// the following is the theory section ////////////////// *)

(* theorem to apply LZ *)
s "(?e=?f)&?x";
ri "(RIGHT@BIND@?e)**LZ**RIGHT@EVAL";
p "APLZ";



(* ******************* "(~?p)==?q" is "?p== ~?q" ********************* *) 



s "(~?p)==?q";



rri "BDIS";



(* thmdisplay "BDIS"; *)



 ex();



right();



ri "BSYM"; 

up();




ri "BDIS"; ri "BSYM";





execute();

p "3pt11";





(* ******************* "?p=/=?q" is "(~?p)==?q" ********************** *)
s "?p=/=?q";
ri "XORDEF"; ri "BDIS"; ex();
p "3pt14";

(* ********************* "?p==false" is "~?p" ************************ *)
s "?p==false";
ri "(RIGHT@FDEF)**($3pt11)**BID2**NRULE1"; ex();
p "3pt15a";

(* ******************* "(~?p)==?p" is "false" ************************ *)
s "(~?p)==?p";
rri "BDIS"; ex();
ri "RIGHT@BID"; rri "FDEF"; ex();
p "3pt15b";

(* ****** reverse theorem for 3pt15b due to destruction of info ****** *)
ae "3pt15b"; wb(); p "3pt15bF@?p";

(* ********************** "~false" is "true" ************************* *)
s "~false";
ri "RIGHT@ $3pt15b"; ri "RIGHT@BSYM"; ri "BDIS"; ri "BID"; ex();
p "NEGF";

(* *********************** "~ ~?p" is "|-?p" ************************* *)
s "~ ~?p";
right(); rri "3pt15a"; ri "BSYM"; ex();
up(); ri "BDIS"; ex();
ri "LEFT@NEGF"; ri "BSYM"; ri "BID2"; ex();
p "DUBNEG2";



(* ******************* "?p==?q" is "(~?p)== ~?q" ********************* *) 
s "?p==?q";



ri "($BRULE1)**($DUBNEG2)**(RIGHT@BDIS)**BDIS**3pt11";





ex();
p "NEQ";





(* ********************* "?p=/=?q" is "?q=/=?p" ********************** *)
s "?p=/=?q";
ri "XORDEF"; ex();
ri "RIGHT@BSYM"; rri "XORDEF"; ex();
p "XORSYM";

(* ************** "(?p=/=?q)=/=?r" is "?p=/=?q=/=?r" ***************** *)
s "(?p=/=?q)=/=?r";
ri "XORSYM"; ri "3pt14"; ex();
ri "RIGHT@3pt14"; ri "BSYM"; ri "BASSOC"; rri "3pt14"; ex();
ri "RIGHT@ $3pt11"; ri "RIGHT@ $3pt14"; ex();
p "XORASSOC";

(* *************** "(?p=/=?q)==?r" is "?p=/=?q==?r" ****************** *)
s "(?p=/=?q)==?r";
ri "LEFT@3pt14"; ri "BASSOC"; rri "3pt14"; ex();
p "MUTASSOC";



(* ****************  "?p=/=?q==?r" is "?p==?q=/=?r" ****************** *)
s "?p=/=?q==?r";
ri "3pt14"; ri "3pt11"; ex();
ri "RIGHT@ $XORDEF"; ex();
p "MUTINT";

(* ********************** "?p|true" is "true" ************************ *)
s "?p|true";
ri "RIGHT@ $BID"; ex();
ri "DDIS"; ri "BID"; ex();
p "DZER";

(* ******* reverse theorem for DZER due to destruction of info ******* *)
ae "DZER"; wb(); p "DZERF@?p";

(* ***************** "?p|?q|?r" is "(?p|?q)|?p|?r" ******************* *)
s "?p|?q|?r";
rri "DASSOC"; ex();
left(); ri "DSYM"; rri "DRULE3"; ex();
right(); rri "DIDEM"; ex();
up(); rri "DASSOC"; ex();
up(); ri "DASSOC"; ex();
ri "LEFT@DSYM"; ex();
p "DDISD";

(* ******************** "?p|false" is "|-?p" ************************* *)
s "?p|false";
ri "RIGHT@3pt15bF@?p"; ex();
ri "DDIS"; ex();
ri "LEFT@DXM"; ex();
ri "RIGHT@DIDEM"; ex();
ri "BSYM"; ri "BID2"; ri "TWOASSERTS"; ex();
prove "DID";

(* ***************** "(?p|?q)==?p| ~?q" is "|-?p" ******************** *)
s "(?p|?q)==?p| ~?q";
rri "DDIS"; ri "RIGHT@BSYM"; ri "RIGHT@3pt15b"; ruleintro "DID"; ex();
p "3pt32";

(* ******* reverse theorem for 3pt32 due to destruction of info ****** *)
ae "3pt32"; wb(); p "3pt32F@?q";

(* **************** "(?p==?q)==?p|?q" is "?p&?q" ********************* *) 



s "(?p==?q)==?p|?q";



ri "LEFT@ $GR";ri "BASSOC";ri "RIGHT@BID";ri "BID2";ri "CRULE1";





ex();

p "GR2";



(* **************** "(?p==?q)==?p&?q" is "?p|?q" ********************* *) 
s "(?p==?q)==?p&?q";
ri "LEFT@ ($GR)**BSYM"; ri "BASSOC"; ri "RIGHT@BID"; ri"BID2"; ri "DRULE1"; 
ex();
p "GR3";





(* ****************** "(~?p)& ~?q" is "~?p|?q" *********************** *)



s "(~?p)& ~?q";



rri "GR2";ex();



left(); rri "BDIS"; ex();



right(); ri "BSYM"; rri "BDIS"; ex();



up();ri "DUBNEG2";ri "BRULE1";ex();



up(); right(); ri "LEFT@ $3pt15a"; ri "RIGHT@ $3pt15a";ri "DDIS"; ex();




ri "LEFT@DSYM**DDIS"; ri "RIGHT@DSYM**DDIS";ri "LEFT@(RIGHT@DID)**BRULE3";ex();



ri "RIGHT@((LEFT@DSYM**DID)**BRULE2)**(RIGHT@DID)**BRULE3";ex();



ri "BASSOC**BSYM";ri "LEFT@ $BASSOC";ri "BASSOC";ex();



up(); rri "BASSOC";ri "LEFT@BID";ex();



ri "RIGHT@BSYM**3pt15a";ri "BSYM**BID2";ri "NRULE1";ri "RIGHT@DSYM"; ex();



p "DEMb";



(* ****************** "(~?p)| ~?q" is "~?p&?q" ********************** *)



s "(~?p)| ~?q";



rri "DRULE1";rri "DUBNEG2";ex();



ri "RIGHT@ ($DEMb)**(RIGHT@DUBNEG2)**(LEFT@DUBNEG2)**($CRULE1)** $CTYPE";



ex();





p "DEMa";





(* **************** "~?p==?q" is "(~?p)=/= ~?q" ********************** *)
s "~?p==?q";
rri "NRULE1"; rri "DUBNEG2"; ex();
ri "(RIGHT@(RIGHT@BDIS**BSYM)**BDIS**BSYM)** $XORDEF"; ex();
p "BFLIP";


(* **************** "~?p=/=?q" is "(~?p)== ~?q" ********************** *)
s "~?p=/=?q";
rri "NRULE1"; rri "DUBNEG2"; ex();
ri "RIGHT@RIGHT@RIGHT@XORDEF"; ex();
ri "DUBNEG2**NRULE1**(RIGHT@BDIS**BSYM)**BDIS**BSYM"; ex();
p "XORFLIP"; 

(* ** the following flips all operators to move the negative inside ** *) 
dpt "SFLIPALL";

s "~ |-?p";
ri "NRULE2"; rri "NRULE1"; ex();
right(); ri "SFLIPALL";
p "FLIPPASTA";

s "~ ~?x";
right();ri "SFLIPALL";
p "FLIPPASTN";

s "~?x==?y";
ri "BFLIP"; ex();
left(); ri "SFLIPALL"; up(); right(); ri "SFLIPALL";
p "FLIPPASTB";

s "~?x=/=?y";
ri "XORFLIP"; ex();
left(); ri "SFLIPALL"; up(); right(); ri "SFLIPALL";
p "FLIPPASTX";

s "~?x|?y";
rri "DEMb"; ex();
left(); ri "SFLIPALL"; up(); right(); ri "SFLIPALL";
p "FLIPPASTD"; 

s "~?x&?y";
rri "DEMa"; ex();
left(); ri "SFLIPALL"; up(); right(); ri "SFLIPALL";
p "FLIPPASTC";

s "?x";
ri "FLIPPASTA"; ari "FLIPPASTN"; ari "FLIPPASTB"; ari "FLIPPASTX";
ari "FLIPPASTD"; ari "FLIPPASTC"; arri "FDEF"; ari "NEGF";
p "SFLIPALL"; 

s "?x";
rri "BRULE1"; arri "XRULE1"; arri "DRULE1"; arri "CRULE1"; rri "DUBNEG2"; 
ri "SFLIPALL";
p "FLIPALL";

(* ************* the following removes the effects of FLIPALL *********** *) 
s "|-true";
rri "DUBNEG2"; ri "RIGHT@ $FDEF"; ri "NEGF"; ex();
p "AT";

s "|-false";
rri "DUBNEG2"; ri "RIGHT@NEGF"; rri "FDEF"; ex();
p "AF";

s "|- ~?p";
ri "NRULE1"; rri "NRULE2"; ex();
p "REMA";

(* redundant theorems due to fact that these were not exclusive
prefixes before *)

s "|-?y";
ri "ASSERT";
ri "ASSERT2"; ex();
p "ASSERTCLEAN";

s "~?y";
ri "NOT";  rri "NOT1";ex();
p "NOTCLEAN";

dpt "SREMFLIP";
s "?x";
ri "RIGHT@SREMFLIP"; ri "LEFT@SREMFLIP";ri
"ASSERTCLEAN"; ri "NOTCLEAN"; ri "FDEF"; arri "NEGF";
arri "BFLIP"; arri "XORFLIP"; ari "DEMa"; ari "DEMb"; ari "REMA";
p "SREMFLIP";

dpt "REMFLIP";
s "?x";
ri "SREMFLIP"; ri "DUBNEG2"; ri "TWOASSERTS"; ri "BRULE1";
ari "CRULE1"; ari "DRULE1"; ari "NRULE1"; ari "XRULE1";ari "AT"; ari "AF";  
p "REMFLIP"; 

(* ******************* dualizing metatheorem ************************ *)
s "?x";
ri "FLIPALL"; ri "RIGHT@?thm"; ri "REMFLIP";
p "DUAL@?thm";



(* ********************* "?p&?q" is "?q&?p" ************************* *)



s "?p&?q";



ri "DUAL@DSYM";





ex();



(* rri "GR2"; ri "LEFT@BSYM"; ri "RIGHT@DSYM"; ri "GR2"; ex(); *)
p "CSYM";



(* **************** "(?p&?q)&?r" is "?q&?p&?r" ********************** *)
s "(?p&?q)&?r";
ri "DUAL@DASSOC";ex();
p "CASSOC";


(* "?p&?p" is "|-?p" *)
s "?p&?p";
ri "DUAL@DIDEM"; ex();
p "CIDEM";

(* "?p&true" is "|-?p" *)
s "?p&true";
ri "DUAL@DID"; ex();
p "CID";


(* **************** "?p&false" is "false" ********************** *)
s "?p&false";
ri "DUAL@DZER";ex();
p "CZER";

(* ******** to counter destructive nature of CZER ************* *)
ae "CZER"; wb(); p "CZERF@?p";

(* ************ "?p&?q&?r" is "(?p&?q)&?p&?r" ****************** *)
s "?p&?q&?r";
ri "DUAL@DDISD"; ex();
p "CDISC";

(* **************** "?p& ~?p" is "false" *********************** *)
s "?p& ~?p";
ri "DUAL@DXM"; ex();
p "CCON";

(* **************** "?p&?p|?q" is "|-?p" *********************** *)
s "?p&?p|?q";
rri "GR2"; ex();
ri "RIGHT@ ($DASSOC)**(LEFT@DIDEM)**DRULE2"; ex();
ri "BASSOC**(RIGHT@BID)**BID2"; ex();
p "3pt43a";

(* ******** to counter destructive nature of 3pt43a ************* *)
ae "3pt43a"; wb(); p "3pt43aF@?q";

(* ***************** "?p|?p&?q" is "|-?p" *********************** *)
s "?p|?p&?q";
ri "DUAL@3pt43a";ex();
p "3pt43b";

(* ******** to counter destructive nature of 3pt43b ************* *)
ae "3pt43b"; wb(); p "3pt43bF@?q";

(* ************** "?p==(~?p)|?q" is "?p&?q" ****************** *)
s "?p==(~?p)|?q";
ri "RIGHT@(LEFT@ $3pt15a)**DSYM**DDIS**BSYM**(LEFT@DID)**BRULE2"; ex();
ri "($BASSOC)**(RIGHT@DSYM)**GR2"; ex();
p "L3pt43";

(* **************** "?p&(~?p)|?q" is "?p&?q" ******************** *)
s "?p&(~?p)|?q";
rri "GR2"; ex();
ri "LEFT@L3pt43";ex();
ri "RIGHT@DDISD**(LEFT@DXM)**DSYM**DZER"; ex();
ri "BID2**CRULE1";ex();
p "3pt44a";

(* **************** "?p|(~?p)&?q" is "?p|?q" ******************** *)
s "?p|(~?p)&?q";
ri "DUAL@3pt44a"; ex();
p "3pt44b";

(* "?p|?q&?r" is "(?p|?q)&?p|?r" *)
s "?p|?q&?r";
ri "RIGHT@ $GR2";ex();
ri "DDIS**(LEFT@DDIS)**RIGHT@DDISD";ex();
ri "GR2";ex();
p "DDISC";

(* "?p&?q|?r" is "(?p&?q)|?p&?r" *)
s "?p&?q|?r";
ri "DUAL@DDISC"; ex();
p "CDISD";

(* "(?p& ~?q)== ~?p" is "?p&?q" *)
s "(?p& ~?q)== ~?p";
ri "BSYM**($3pt14)**FLIPALL**BDIS**(LEFT@DUBNEG2)**BRULE2**L3pt43"; ex();
ri "(RIGHT@DUBNEG2)**CRULE3"; ex();
p "3pt48";

(* "(?p&?q)==(?p&?r)==?p" is "?p&?q==?r" *)
s "(?p&?q)==(?p&?r)==?p";
rri "BASSOC"; ex();
ri "LEFT@ ($BRULE1)** $DUBNEG2"; ex();
ri "LEFT@(RIGHT@BDIS**BSYM)**BDIS**BSYM**(LEFT@ $DEMa)**RIGHT@ $DEMa"; ex();
ri "LEFT@ $DDIS"; ex();
ri "LEFT@RIGHT@ ($BDIS)**(RIGHT@BSYM**($BDIS)**RIGHT@BSYM)**DUBNEG2**BRULE1"; 
ex();
ri "BSYM**L3pt43"; ex();
p "3pt49";

(* "?p&?q==?p" is "?p&?q" *)
s "?p&?q==?p";
rri "GR2"; ex();
ri "LEFT@(RIGHT@BSYM)**($BASSOC)**(LEFT@BID)**BSYM**BID2"; ex();
ri "BRULE2**RIGHT@DDIS**(RIGHT@DIDEM)**BSYM**BRULE2"; ex();
ri "($BASSOC)**(LEFT@BSYM)**GR2"; ex();
p "3pt50";

(* "(?p==?q)&?r==?p" is "(?p==?q)&?r==?q" *)
s "(?p==?q)&?r==?p";
ri "(RL@BCONV)**APLZ**RL@ $BCONV"; ex();
p "REPL";

(* "?p==?q" "(?p&?q)|(~?p)& ~?q" *)
s "?p==?q";
ri "($BRULE1)**($CID)**CSYM**(LEFT@DXMF@?p)**CSYM**CDISD";ex();
ri 
"RIGHT@CSYM**(RIGHT@($BRULE1)**($DUBNEG2)**(RIGHT@BDIS**BSYM)**BDIS)**3pt50";ex()
;
ri "LEFT@CSYM**(RIGHT@BSYM)**3pt50";ex();
p "BALTDEF";

(* "?p=/=?q" "((~?p)&?q)|?p& ~?q" *)
s "?p=/=?q";
ri "3pt14**BALTDEF**RIGHT@(LEFT@DUBNEG2)**CRULE2";ex();
p "XALTDEF";

(* "?p->?q" "(~?p)|?q" *)
s "?p->?q";
ri "IDEF**(LEFT@DSYM)**($BRULE3)**(RIGHT@ $DID)**($DDIS)**(RIGHT@3pt15a)**DSYM";ex();
p "IDEF2";

(* "?p->?q" "(?p&?q)==?p" *)
s "?p->?q";
ri "IDEF"; ri "LEFT@($GR3)**BSYM"; ri "BASSOC"; ex(); 
ri "(RIGHT@BASSOC**(RIGHT@BID)**BID2)**BRULE3"; ex(); 
p "IDEF3";

(* "?p->?q" "(~?q)-> ~?p" *)
s "?p->?q";
ri "IDEF3**($BRULE1)**($DUBNEG2)**(RIGHT@BDIS)**BDIS**3pt11"; ex(); 
ri "(LEFT@($DEMa)**DSYM)** $IDEF"; ex();
p "CONTP";

(* "?p->?q==?r" "(?p->?q)==?p->?r" *)
s "?p->?q==?r";
ri "IDEF**(LEFT@DDIS**BSYM)**($BASSOC)**LEFT@BASSOC**(RIGHT@ $IDEF)**BSYM";ex();
ri "BASSOC**RIGHT@ $IDEF"; ex();
p "IDISB";

(* "?p->?q==?r" "(?p&?q)==?p&?r" *)
s "?p->?q==?r";
ri "(RIGHT@NEQ)**IDISB**(RL@IDEF2**DEMa)** $NEQ"; ex();
p "3pt62";

(* "?p->?q->?r" "(?p&?q)->?r" *)
s "?p->?q->?r";
ri "IDEF2**(RIGHT@IDEF2)**($DASSOC)**(LEFT@DEMa)** $IDEF2"; ex();
p "3pt65";

(* "(?p->?q)->?p->?r" "?p->?q->?r" *)
s "(?p->?q)->?p->?r";
ri "(RL@IDEF2)**IDEF2** $DASSOC"; ex();
ri "LEFT@LEFT@($DEMb)**(LEFT@DUBNEG2)**CRULE2"; ex();
ri "LEFT@DSYM**DDISC**(LEFT@DSYM)**(LEFT@DXM)**CSYM**CID**DRULE1**DEMa"; ex();
ri "($IDEF2)**($3pt65)"; ex();
p "3pt64";

(* "?p&?p->?q" "?p&?q" *)
s "?p&?p->?q";
ri "(RIGHT@IDEF2)**CDISD**(LEFT@CCON)**DSYM**DID**CRULE1"; ex();
p "3pt66";

(* "?p&?q->?p" "|-?p" *)
s "?p&?q->?p";
ri "(RIGHT@IDEF2)**CDISD**(RIGHT@CIDEM)**DRULE3**FLIPALL**RIGHT@CSYM**3pt43a"; 
ex();
ri "NRULE2**DUBNEG2"; ex();
p "3pt67";

(* to counter destruction of info by 3pt67 *)
ae "3pt67"; wb(); prove "3pt67F@?q";

(* "?p|?p->?q" "true" *)
s "?p|?p->?q";
ri "(RIGHT@IDEF2)**DDISD**(LEFT@DXM)**DSYM**DZER"; ex();
p "3pt68";

(* to counter destruction of info by 3pt68 *)
ae "3pt68"; wb(); p "3pt68F@?p,?q";

(* "?p|?q->?p" "?q->?p" *)
s "?p|?q->?p";
ri "(RIGHT@IDEF)**DDIS**(LEFT@(RIGHT@DSYM)**($DASSOC)**DSYM)"; ex();
ri "($IDEF)**(RIGHT@DIDEM)**IRULE3"; ex();
p "3pt69";

(* "(?p|?q)->?p&?q" "?p==?q" *)
s "(?p|?q)->?p&?q";
ri "IDEF2**(LEFT@ $DEMb)**DSYM** $BALTDEF"; ex();
p "3pt70";

(* "?p->?p" "true" *)
s "?p->?p";
ri "IDEF2**DSYM**DXM"; ex();
p "IREF";

(* to counter destruction of info by IREF *)
ae "IREF"; wb(); p "IREFF@?p";

(* "?p->true" "true" *)
s "?p->true";
ri "IDEF2**DZER";ex();
p "IRZER";

(* to counter destruction of info by IRZER *)
ae "IRZER"; wb(); p "IRZERF@?p";

(* "true->?p" "|-?p" *)
s "true->?p";
ri "IDEF2**(LEFT@ $FDEF)**DSYM**DID";ex();
p "ILID";

(* "?p->false" "~?p" *)
s "?p->false";
ri "IDEF2**DID**NRULE1";ex();
p "3pt74";

(* "false->?p" "true" *)
s "false->?p";
ri "IDEF2**(LEFT@NEGF)**DSYM**DZER"; ex();
p "3pt75";

(* to counter destruction of info by 3pt75 *)
ae "3pt75"; wb(); p "3pt75F@?p";

(* WEAKENING/STRENGTHENING *)
(* "?p->?p|?q" "true" *)
s "?p->?p|?q";
ri "IDEF2**($DASSOC)**(LEFT@DSYM**DXM)**DSYM**DZER";ex();
p "3pt76a";

(* to counter destruction of info by 3pt76a *)
ae "3pt76a"; wb(); p "3pt76aF@?p,?q";

(* "(?p&?q)->?p" "true" *)
s "(?p&?q)->?p";
ri "CONTP**(RIGHT@ $DEMa)**3pt76a";ex();
p "3pt76b";

(* to counter destruction of info by 3pt76b *)
ae "3pt76b"; wb(); p "3pt76bF@?p,?q";

(* "(?p&?q)->?p|?q" "true" *)
s "(?p&?q)->?p|?q";
ri "IDEF2**(LEFT@ $DEMa)**DDISD"; ex();
ri "(RIGHT@DASSOC**(RIGHT@DSYM**DXM)**DZER)**DZER"; ex();
p "3pt76c";

(* to counter destruction of info by 3pt76c *)
ae "3pt76c"; wb(); p "3pt76cF@?p,?q";

(* "(?p|?q&?r)->?p|?q" "true" *)
s "(?p|?q&?r)->?p|?q";
ri "IDEF2**(LEFT@FLIPALL**CDISD**LEFT@DEMb)**DSYM**($DASSOC)**LEFT@DXM"; ex();
ri "DSYM**DZER"; ex();
p "3pt76d";

(* to counter destruction of info by 3pt76d *)
ae "3pt76d"; wb(); p "3pt76dF@?p,?q,?r";

(* "(?p&?q)->?p&?q|?r" "true" *)
s "(?p&?q)->?p&?q|?r";
ri "CONTP**(LEFT@FLIPALL)**(RIGHT@ $DEMa)**3pt76d"; ex();
p "3pt76e";

(* to counter destruction of info by 3pt76e *)
ae "3pt76e"; wb(); p "3pt76eF@?p,?q,?r";

(* MODUS PONENS *)
(* "(?p&?p->?q)->?q" "true" *)
s "(?p&?p->?q)->?q";
ri "(LEFT@(RIGHT@IDEF2)**3pt44a**CSYM)**3pt76b"; ex();
p "MOP";

(* to counter destruction of info by MOP *)
ae "MOP"; wb(); p "MOPF@?p,?q";

(* "(?p->?r)&?q->?r" "(?p|?q)->?r" *)
s "(?p->?r)&?q->?r";
ri "(RL@IDEF2**DSYM)**($DDISC)**(RIGHT@DEMb)**DSYM** $IDEF2"; ex();
p "3pt78";

(* "(?p->?r)&(~?p)->?r" "|-?r" *)
s "(?p->?r)&(~?p)->?r";
ri "3pt78**(LEFT@DXM)**ILID"; ex();
p "3pt79";

(* to counter destruction of info by 3pt79 *)
ae "3pt79"; wb(); p "3pt79F@?p";

(* "(?p->?q)&?q->?p" "?p==?q" *)
s "(?p->?q)&?q->?p";
ri "(RL@IDEF2)**(RIGHT@DSYM)**FLIPALL**(RIGHT@ $XALTDEF)**REMFLIP"; ex();
p "3pt80";

(* "((?p->?q)&?q->?p)->?p==?q" "true" *)
s "((?p->?q)&?q->?p)->?p==?q";
ri "(RIGHT@ $3pt80)**IREF"; ex();
p "3pt81";

(* to counter destruction of info by 3pt81 *)
ae "3pt81"; wb(); p "3pt81F@?p,?q";

(* "((?p->?q)&?q->?r)->?p->?r" "true" *)
s "((?p->?q)&?q->?r)->?p->?r";
ri "$3pt65"; ex();
ri "RIGHT@(RL@CONTP)**3pt64**(RIGHT@ $CONTP)**IDEF2**(LEFT@DUBNEG2)**DRULE2"; 
ex();
ri "IDEF2**DSYM**DASSOC**(RIGHT@DXM)**DZER"; ex();
p "3pt82a";

(* to counter destruction of info by 3pt82a *)
ae "3pt82a"; wb(); p "3pt82aF@?p,?q,?r";

(* "((?p==?q)&?q->?r)->?p->?r" "true" *)
s "((?p==?q)&?q->?r)->?p->?r";
ri "(LEFT@(LEFT@($3pt80)**CSYM)**CASSOC)**($3pt65)**(RIGHT@3pt82a)**IRZER"; 
ex();
p "3pt82b";

(* to counter destruction of info by 3pt82b *)
ae "3pt82b"; wb(); p "3pt82bF@?p,?q,?r";

(* "((?p->?q)&?q==?r)->?p->?r" "true" *)
s "((?p->?q)&?q==?r)->?p->?r";
ri "(LEFT@CSYM**(RIGHT@CONTP)**LEFT@NEQ**BSYM)**(RIGHT@CONTP)**3pt82b"; ex();
p "3pt82c";

(* to counter destruction of info by 3pt82c *)
ae "3pt82c"; wb(); p "3pt82cF@?p,?q,?r";

(* "(?e=?f)->(?F@?e)=?F@?f" "true" *)
s "(?e=?f)->(?F@?e)=?F@?f";
ri "IDEF2**FLIPALL"; ex();
ri "RIGHT@(LEFT@DUBNEG2** $ASRTEQ)**APLZ**(RIGHT@(RIGHT@REFLEX)** $FDEF)**CZER";
ri "NEGF"; ex();
p "3pt83";

(* to counter destruction of info by 3pt83 *)
ae "3pt83"; wb(); p "3pt83F@?F,?e,?f";

(* "(?e=?f)->?F@?e" "(?e=?f)->?F@?f" *)
s "(?e=?f)->?F@?e";
ri "IDEF2**FLIPALL";ex();
ri "RIGHT@(LEFT@DUBNEG2** $ASRTEQ)**APLZ**(LEFT@ASRTEQ** $DUBNEG2)";ex();
ri "REMFLIP** $IDEF2"; ex();
p "3pt84b";

(* "(?q&?e=?f)->?F@?e" "(?q&?e=?f)->?F@?f" *)
s "(?q&?e=?f)->?F@?e";
ri "($3pt65)**(RIGHT@3pt84b)**3pt65"; ex();
p "3pt84c";

(* "?p->?F@?p" "?p->?F@true" *)
s "?p->?F@?p";
ri "IDEF2**($DRULE3)**(RIGHT@ $DUBNEG2)**DEMa"; ex();
right(); 
ri "($CRULE2)**(LEFT@($BID2)**BCONV**(RIGHT@AT)**EQT)**APLZ"; ex();
ri "(LEFT@($EQT)**(RIGHT@ $AT)**($BCONV)**BID2)**CRULE2"; ex();
up(); 
ri "($DEMa)**(RIGHT@DUBNEG2)**DRULE3** $IDEF2";ex(); 
p "3pt85a"; 

(* "(?q&?p)->?F@?p" "(?q&?p)->?F@true" *)
s "(?q&?p)->?F@?p";
ri "($3pt65)**(RIGHT@3pt85a)**3pt65"; ex();
p "3pt85b";

(* "(?F@ |-?p)->?p" "(?F@false)->?p" *)
s "(?F@ |-?p)->?p";
ri "CONTP**IDEF2**DEMa"; ex();
right();
ri "LEFT@($3pt15a)**BCONV**RIGHT@AF"; ex();
ri "APLZ**LEFT@(RIGHT@ $AF)**($BCONV)**3pt15a"; ex();
up(); 
ri "($DEMa)**($IDEF2)** $CONTP"; ex();
p "3pt86a";

(* for applying 3pt86a to an actual function of ?p *)
s "?x->?p";
ri "THMAP@LEFT,?p,3pt86a";
p "AP3pt86a";

(* "(?F@ |-?p)->?p|?q" "(?F@false)->?p|?q" *)
s "(?F@ |-?p)->?p|?q";
ri "IDEF2**($DASSOC)**(LEFT@($IDEF2)**3pt86a**IDEF2)**DASSOC** $IDEF2"; ex();
p "3pt86b";

(* for applying 3pt86b to an actual function of ?p *)
s "?x->?p|?q";
ri "THMAP@LEFT,?p,3pt86b";
p "AP3pt86b";

(* "?p&?F@?p" "?p&?F@true" *)
s "?p&?F@?p";
ri "($CRULE1)** $DUBNEG2"; ex();
right();
ri "($DEMa)**($IDEF2)**(RIGHT@BIND@?p)**3pt85a**(RIGHT@EVAL)**IDEF2**DEMa"; 
ex();
up();
ri "DUBNEG2**CRULE1"; ex();
p "3pt87";

(* "?p|?F@ |-?p" "?p|?F@false" *)
s "?p|?F@ |-?p";
ri "($DRULE3)**(RIGHT@ $DUBNEG2)**DSYM** $IDEF2"; ex();
ri "(LEFT@BIND@ |-?p)**3pt86a**(LEFT@EVAL)"; ex();
ri "IDEF2**DSYM**(RIGHT@DUBNEG2)**DRULE3"; ex();
p "3pt88";

(* for applying 3pt88 to an actual function of ?p *)
s "?p|?x";
ri "THMAP@RIGHT,?p,3pt88";
p "AP3pt88";

(* "(?p&?F@true)|(~?p)&?F@false" "|-?F@ |-?p" *)
s "(?p&?F@true)|(~?p)&?F@false";
ri "(LEFT@($CRULE2)**($3pt87)**CRULE2)**RIGHT@FLIPALL";ex();
ri "RIGHT@(RIGHT@($IDEF2)**($CONTP)**($3pt86a)**IDEF2**DSYM)";ex();
ri "RIGHT@($DEMb)**(RIGHT@DUBNEG2)**CRULE3"; ex();
ri "(RL@CSYM)**($CDISD)**(RIGHT@DXM)**CID"; ex();
p "3pt89";

(* some unaccountably missing principles
added by Holmes, June 3, 1998 *)

s "(?p|?q)->?r";
ri "IDEF2"; ex();
left(); rri "DEMb"; ex();
up(); ri "DSYM**DDISC**RL@DSYM"; ex();
ri "RL@ $IDEF2"; ex();
p "IDIS1";

s "(?p&?q)->?r";
ri "IDEF2"; ex();
left(); rri "DEMa"; ex();
up(); ri "DSYM**DDISD**RL@DSYM** $IDEF2"; ex();
p "IDIS2";

s "?p->?q&?r";
ri "IDEF2"; ex();
ri "DDISC**RL@ $IDEF2"; ex();
p "IDIS3"; 

s "?p->?q|?r";
ri "IDEF2**DDISD**RL@ $IDEF2"; ex();
p "IDIS4";


(* sp "|" 2;
sp "&" 4;
sp "~" 6;
sp "|-" 6; *)


quit();