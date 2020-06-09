script "mwu_subtraction";

(* this file consists of more theorems about subtraction and theorems
about div and mod by Minglong Wu *)

(* this theorem was not found in Wu's old file? *)

(* 

NATMINUSPLUS_1:

((Nat : ?x) + Nat : ?y) .-. Nat : ?y =

Nat : ?x

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LEQ_ADD_TRUE","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSCOMP","MINUSTYPE","NATMINUSCOMP","NAT_SUB","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM"

,"PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?x) + Nat:?y) .-. Nat:?y";
ri "NAT_SUB";ex();
ri "EVERYWHERE@TYPES";ex();
left();ri "EVERYWHERE@TYPES";ex();
top(); rri "NAT_SUB";ex();
ri "NATMINUSPLUS";ex();
p "NATMINUSPLUS_1";

(*
ZERO_IMP_ADD_INV:

((Real : ?y) = 0) -> (?x + ?y) = Real : ?x =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","PLUSCOMM","PLUSID","PLUSTYPE","REFLEX","TYPES","XOR"]
*)

s "((Real:?y) = 0)->(?x + ?y) = Real:?x";
ri "IMPTOCOND";ex();
right();right();left();ri "LEFT@PLUSSCIN";ex();
ri "LEFT@RIGHT@0|-|1";ex();
ri "LEFT@COMMPLUSID**TYPES";ex();
ri "REFLEX";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "ZERO_IMP_ADD_INV";

(*

ADD_INV_BEQ_0:

((Real : ?y) = 0) == (?x + ?y) = Real : ?x =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES","XOR"]
*)

s "((Real:?y) = 0)==(?x + ?y) = Real:?x";
rri "3pt80";ex();
ri "LEFT@ZERO_IMP_ADD_INV";ex();
ri "RIGHT@ADD_INV_0";ex();
ri "CID**AT";ex();

p "ADD_INV_BEQ_0";

(*

ADD_INV_EQ_0:

(?x + ?y) = Real : ?x =

(Real : ?y) = 0

["BUILTIN","CASEINTRO","EQUATION","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]
*)

s "(?x + ?y) = Real:?x";
ri "ASRTEQ";ex();
rri "BID2";ex();
right();initializecounter();
rri "ADD_INV_BEQ_0";ex();
assign "?x_1" "?x";
assign "?y_1" "?y";
up();ri "BSYM**BASSOC";ex();
ri "RIGHT@BID";ex();
ri "BID2** $ASRTEQ";ex();

p "ADD_INV_EQ_0";

(*

(* there is another way to prove this theorem *)
(*
ADD_INV_EQ_0:

(?x + ?y) = Real : ?x =

(Real : ?y) = 0

["BUILTIN","CASEINTRO","EQUATION","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]
*)

s "(?x+?y)=Real:?x";
ri "LEFT@PLUSSCIN";ex();
ri "LEFT@PLUSTYPE";ex();initializecounter();
rri "ADD_CANCEL";ex();
assign "?z_1" "-?x";
ri "RIGHT@PLUSCOMM** ($BREAKMINUS)**SUB_REFL";ex();
left();ri "RIGHT@ ($PLUSSCIN)** $PLUSSCIN";ex();
rri "PLUSASSOC";ex();
ri "LEFT@PLUSCOMM** ($BREAKMINUS)**SUB_REFL";ex();
ri "PLUSID";ex();

p "ADD_INV_EQ_0";

*)

(* following described by Wu as practice exercises *)

s "(?m+?m)=0";
ri "LEFT@PLUSSCIN";ex();
left();ri "RL@ $TIMESID";ex();
rri "COMMDIST";ex();
 (*This theorem is in even-odd file *)
up();ri "EQSYMM**FACTORZERO";ex();
left();right();right();ex();
ri "RL@ONENAT";ex();
ri "PLUSTYPE2";ex();
up();rri "REALNAT";ex();
rri "PLUSTYPE2";ex();
ri "LEFT@ $ONENAT";ex();
up();ri "SUCCNOTZERO";ex();
up();ri "DSYM**DID** ($ASRTEQ)**EQSYMM";ex();
p "REAL_SAME_ADD_0";

(* _______________________________________________________________
	MINUS_TIMESID:
	=============
	- ?a = 

	(- 1) * ?a
   _______________________________________________________________ *)

s "-?a";
ri "MINUSSCIN"; ex();
ri "LEFT@ $REALZERO";ex();
right();
rri "TIMESID";ex();
ri "TIMESCOMM";ex();
up();
rri "SIGNPULL";ex();
ri "TIMESCOMM";ex();

p "MINUS_TIMESID";

(* you put these two out of order! *)

(*

REAL_MINUS_EQ_0:

(- ?m) = 0 =

(Real : ?m) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REALDIVTYPE","REFLEX","SUCCNOTZERO","TIMESASSOC","TIMESCO

MM","TIMESDIV","TIMESID","TIMESTYPE","TYPES","XOR"]
*)

s "(-?m)=0";
ri "LEFT@MINUS_TIMESID";ex();
ri "EQSYMM**FACTORZERO";ex();
left();ri "LEFT@REALZERO";ex();
initializecounter();
rri "ADD_CANCEL";ex();
assign "?z_1" "1";
ri "RIGHT@ ($BREAKMINUS)**SUB_REFL";ex();
ri "EQSYMM**(RIGHT@RIGHT@ZERONAT)";ex();
ri "SUCCNOTZERO";ex();
up();ri "DSYM**DID** ($ASRTEQ)**EQSYMM";ex();

p "REAL_MINUS_EQ_0";

(*

NEG_REAL_0_REFL:

(- Real : ?m) = 0 =

(Real : ?m) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REALDIVTYPE","REFLEX","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TYPES","XOR"]
*)

s "(-Real:?m)=0";
ri "LEFT@ $MINUSREAL";ex();
ri "REAL_MINUS_EQ_0";ex();

p "NEG_REAL_0_REFL";

(*

REAL_MINUS:

Real : - ?m =

- ?m

["BUILTIN","CASEINTRO","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]
*)

s "Real: -?m";
rri "PLUSID";ex();
rri "BREAKMINUS";ex();

p "REAL_MINUS";

(*

REAL_0_IMP_NEG_EQ:

((Real : ?m) = 0) -> (Real : ?m) = Real : - ?m =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REALDIVTYPE","REFLEX","SUCCNOTZERO","TIMESASSOC","TIMESCO

MM","TIMESDIV","TIMESID","TIMESTYPE","TYPES","XOR"]
*)

s "((Real:?m)=0)->(Real:?m)= Real: -?m";
ri "IMPTOCOND";ex();
right();right();left();ri "LEFT@0|-|1";ex();
ri "RIGHT@REAL_MINUS";ex();
up();up();ri "LEFT@ $REAL_MINUS_EQ_0";ex();
right();left();ri "RIGHT@0|-|1";ex();
ri "REFLEX";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "REAL_0_IMP_NEG_EQ";
 
(*

MINUS_0_IMP_REAL_0:

((- ?m) = 0) -> (Real : ?m) = 0 = 

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES","XOR"]
*)

s "((-?m)=0)->(Real:?m)=0";
ri "LEFT@ $EQUATION_TO_DIFFERENCE";ex();
ri "LEFT@EQSYMM";ex();
ri "LEFT@RIGHT@ $REALZERO";ex();
ri "IREF";ex();

p "MINUS_0_IMP_REAL_0";

(* _______________________________________________________________
	ADD_CANCELF @ ?z:
	================
	(Real : ?x) = Real : ?y = 

	(?z + ?x) = ?z + ?y
   _______________________________________________________________ *)

ae "ADD_CANCEL"; wb();
p "ADD_CANCELF@?z";


(*

REAL_0_IMP_MINUS_0:

((Real : ?m) = 0) -> (- ?m) = 0 = 

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES","XOR"]
*)
s "((Real:?m)=0)->(-?m)=0";
left();ri "RIGHT@REALZERO";ex();
ri "ADD_CANCELF@(-?m)";ex();
ri "LEFT@PLUSCOMM** ($BREAKMINUS)**SUB_REFL";ex();
ri "RIGHT@PLUSCOMM** $BREAKMINUS";ex();
ri "EQSYMM";ex();
up();ri "IREF";ex();

p "REAL_0_IMP_MINUS_0";



(*

LESS_0_ADD_INV:

(?m < 0) -> (?m + ?m) < 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","POSPLUS","REAL_LESS_DEF","REFLEX","TYPES","XOR"]
*)


s "(?m<0)->(?m+?m)<0";
rri "IRULE2";ex();
left();rri "CIDEM";ex();
left();initializecounter();
rri "REAL_LESS_CANCEL";ex();
assign "?z_1" "?m";
up();right();
initializecounter();
rri "REAL_LESS_CANCEL";ex();
assign "?z_1" "0";
ri "RIGHT@PLUSID** $REALZERO";ex();
ri "LEFT@PLUSCOMM";ex();
up();ri "REAL_LESS_TRANS";ex();
up();rri "3pt65";ex();
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();right();
rri "0|-|1";ex();
up();ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "LESS_0_ADD_INV";

(*

ADD_LESS_0_IMP_LESS_0:

((?m + ?m) < 0) -> (Real : ?m) < 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TRICHOTOMY","TYPES","XOR"]
*)

s "((?m+?m)<0)->(Real:?m)<0";
ri "PCASEINTRO@(Real:?m)=0";ex();
ri "LEFT@ $REAL_SAME_ADD_0";ex();
right();left();left();ri "LEFT@0|-|1";ex();
ri "REAL_LESS_DEF";ex();
ri "RIGHT@MINUSZERO";ex();
ri "POS_ZERO";ex();
up();ri "3pt75";ex();
top();ri "LEFT@REAL_SAME_ADD_0";ex();
rri "NOT_EXP";ex();
left();ri "RIGHT@EQSYMM";ex();
rri "TRICHOTOMY";ex();
top();ri "OR_EXP";ex();
ri "LEFT@ALT_POS_DEF";ex();
ri "ODDCHOICE";ex();
right();left();rri "IRULE2";ex();
left();rri "CID";ex();
ri "RIGHT@0|-|1";ex();
ri "REAL_LESS_TRANS";ex();
left();initializecounter();
rri "REAL_LESS_CANCEL";ex();
assign "?z_1" "-?m";

ri "RIGHT@PLUSCOMM** ($BREAKMINUS)**SUB_REFL";ex();
left();ri "PLUSCOMM**PLUSASSOC";ex();
ri "RIGHT@ ($BREAKMINUS)**SUB_REFL";ex();
ri "COMMPLUSID";ex();
up();up();up();rri "3pt65";ex();
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();right();rri "0|-|2";ex();
up();ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();right();left();ri "ALT_POS_DEF";ex();
initializecounter();
rri "REAL_LESS_CANCEL";ex();
assign "?z_1" "?m";
ri "RIGHT@ ($BREAKMINUS)**SUB_REFL";ex();
ri "LEFT@COMMPLUSID";ex();
up();ri "ODDCHOICE";ex();
right();left();ri "RIGHT@ $0|-|2";ex();
ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();
up();up();rri "CASEINTRO";ex();

p "ADD_LESS_0_IMP_LESS_0";




(*

ZERO_IMP_NEG_0:

(?m = 0) -> (- ?m) = 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES","XOR"]
*)

s "(?m=0)->(-?m)=0";
ri "IMPTOCOND";ex();
right();right();left();
left();right();ri "0|-|1";ex();
up();ri "MINUSZERO";ex();
up();ri "REFLEX";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "ZERO_IMP_NEG_0";

(*

(*

SUB_EQ_EQ_0:

((Nat : ?m) .-. Nat : ?n) = Nat : ?m =

((Nat : ?n) = 0) | (Nat : ?m) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSCOMP","MINUSTYPE","NATMINUSCOMP","NAT_SUB","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PL

USID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?m).-.Nat:?n)=Nat:?m";
initializecounter();
ri "PCASEINTRO@(Nat:?n)=0";ex();
right();left();
ri "EVERYWHERE@0|-|1";ex();
ri "LEFT@NATSUB_0";ex();
ri "EVERYWHERE@TYPES**REFLEX";ex();
up();right();
ri "PCASEINTRO@(Nat:?m)=0";ex();
right();left();
ri "EVERYWHERE@0|-|2";ex();
ri "LEFT@NAT0_SUB";ex();
ri "REFLEX";ex();
up();right();
ri "PCASEINTRO@(Nat:?m)<Nat:?n";ex();
right();left();left();ri "NAT_SUB";ex();
left();ri "EVERYWHERE@TYPES";ex();
up();up();up();up();ri "ODDCHOICE";ex();
right();left();left();left();rri "0|-|3";ex();
up();ex();
up();ri "EQSYMM";ex();
ri "EQUATION** 1|-|2";ex();
up();right();
ri "PCASEINTRO@(Nat:?n)=<Nat:?m";ex();
ri "ODDCHOICE";ex();
right();left();left();ri "NAT_SUB";ex();
left();ri "EVERYWHERE@TYPES";ex();
rri "NOT_LEQ";ex();
right();rri "0|-|4";ex();
up();rri "FDEF";ex();
up();ex();
ri "EVERYWHERE@TYPES";ex();
ri "REALSUBNATTYPE";ex();
ri "ODDCHOICE";ex();
ri "1|-|3";ex();
up();ri "SUB_INV_0_EQ";ex();
ri "EQUATION** 1|-|1";ex();
up();right();left();ri "NAT_SUB";ex();
left();ri "RL@TYPES";ex();
up();ri "ODDCHOICE";ex();
ri "1|-|3";ex();
ri "EVERYWHERE@TYPES";ex();
ri "REALSUBNATTYPE";ex();
ri "ODDCHOICE";ex();
ri "1|-|3";ex();
up();ri "SUB_INV_0_EQ";ex();
ri "EQUATION** 1|-|1";ex();
top();ri "EVERYWHERE@ $CASEINTRO";ex();
rri "TAB_OR";ex();

p "SUB_EQ_EQ_0";

*)

(*

LEQ_DUB_ADD_IMP_LEQ:

((Nat : ?m) =< Nat : ?n)
-> ((Nat : ?m) + Nat : ?m) =< (Nat : ?n) + Nat
: ?n =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?m)=<Nat:?n)->(((Nat:?m)+Nat:?m)=<(Nat:?n)+Nat:?n)";
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();ri "RL@PLUSTYPE2";ex();
ri "LESS_OR_EQ";ex();
rri "DRULE1";ex();
rri "ILID";ex();
right();rri "LESS_OR_EQ";ex();
ri "RL@ $PLUSTYPE2";ex();
up();left();ri "($AT)** $CID";ex();
ri "RL@0|-|1";ex();
up();ri "LEQ_LEQ_MONO";ex();
top();ri "EVERYWHERE@ ($CASEINTRO)**AT";ex();

p "LEQ_DUB_ADD_IMP_LEQ";

(* another order inversion! *)

(*

LEQ_LESS_MONO:

(((Nat : ?m) =< Nat : ?p) & (Nat : ?n) < Nat : ?q)
-> ((Nat : ?m) + Nat : ?n) < (Nat : ?p) + Nat : ?q =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","
INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s
"(((Nat:?m)=<Nat:?p)&(Nat:?n)<Nat:?q)->((Nat:?m)+Nat:?n)<(Nat:?p)+Nat:?q";
left();ri "(LEFT@LEQ_MONO_ADD_EQF@?n)";ex();
right();initializecounter();
ri "LESS_MONO_ADD_EQ";ex();
assign "?p_1" "?p";
ri "LEFT@PLUSCOMM";ex();
ri "RIGHT@PLUSCOMM";ex();
top();ri "EVERYWHERE@PLUSTYPE2";ex();
ri "LEQ_LESS_TRANS";ex();

p "LEQ_LESS_MONO";


(*

DUB_ADD_LEQ_IMP_LEQ:

(((Nat : ?m) + Nat : ?m) =< (Nat : ?n) + Nat : ?n)
-> (Nat : ?m) =< Nat : ?n =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "(((Nat:?m)+Nat:?m)=<(Nat:?n)+Nat:?n)->(Nat:?m)=<Nat:?n";
ri "PCASEINTRO@(Nat:?m)=<Nat:?n";ex();
ri "ODDCHOICE";ex();
right();left();ri "RIGHT@ $0|-|1";ex();
ri "IRZER";ex();
top();rri "NOT_EXP";ex();
left();right();rri "BOOLDEF";ex();
up();ri "NOTBOOLDROP";ex();
ri "NOT_LEQ";ex();
up();ri "ODDCHOICE";ex();
right();left();right();rri "NOT_LESS";ex();
ri "RIGHT@ $0|-|1";ex();
rri "FDEF";ex();
up();ri "3pt74";ex();
right();ri "RL@PLUSTYPE2";ex();
up();ri "NOT_LEQ";ex();
ri "LESSBOOL**ASSERT2";ex();
rri "ILID";ex();
right();ri "RL@ $PLUSTYPE2";ex();
up();left();ri "($AT)** $CID";ex();
ri "RL@0|-|1";ex();
rri "CRULE2";ex();
ri "LEFT@ $CID";ex();
left();right();initializecounter();
rri "LESS_IMP_LEQ";ex();
assign "?m_1" "?n";
assign "?n_1" "?m";
up();ri "3pt66";ex();
up();up();ri "IDIS2";ex();
left();left();ri "CSYM";ex();
up();ri "LEQ_LESS_MONO";ex();
up();ri "DSYM**DZER";ex();
top();rri "CASEINTRO";ex();

p "DUB_ADD_LEQ_IMP_LEQ";

(*

(*  this very large proof does not appear to work under new 
prover:  best thing to do is to come up with a short proof (and
of a simpler theorem!) *)

(*

SUB_LEFT_ADD:

((Nat : ?m) + ?n .-. ?p)
= ((Nat : ?n) =< Nat : ?p) || (Nat : ?m)
, ((Nat : ?m) + Nat : ?n) .-. ?p =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSCOMP","MINUSTYPE","NATMINUSCOMP","NAT_SUB","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s
"((Nat:?m)+?n.-.?p)=((Nat:?n)=<Nat:?p)||(Nat:?m),((Nat:?m)+Nat:?n).-.?p";
ri "PCASEINTRO@(Nat:?n)<Nat:?p";ex();
ri "ODDCHOICE";ex();
right();left();left();right();ri "NAT_SUB";ex();
ri "LEFT@ $0|-|1";ex();
up();ri "COMMPLUSID** $REALNAT";ex();
up();right();left();ri "LESS_OR_EQ";ex();
ri "LEFT@ $0|-|1";ex();
ri "DSYM**DZER";ex();
up();ex();
up();ri "REFLEX";ex();
up();right();ri "PCASEINTRO@(Nat:?n)=Nat:?p";ex();
right();left();left();right();ri "NAT_SUB";ex();
right();right();right();ri "LEFT@0|-|2";ex();
ri "SUB_REFL";ex();
up();rri "ZERONAT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "COMMPLUSID** $REALNAT";ex();
up();right();left();ri "LESS_OR_EQ";ex();
ri "RIGHT@LEFT@0|-|2";ex();
ri "(RIGHT@REFLEX)**DZER";ex();
up();ex();
up();ri "REFLEX";ex();

up();up();ri "ODDCHOICE";ex();
right();right();left();right();ri "NAT_SUB";ex();
ri "ODDCHOICE**1|-|1";ex();
ri "REALSUBNATTYPE";ex();
ri "ODDCHOICE**1|-|1";ex();
up();up();right();left();ri "LESS_OR_EQ";ex();
ri "($DRULE2)** $DRULE3";ex();
ri "RL@ ($ASSERT2)**BOOLDEF";ex();
left();ri "EQUATION**1|-|1";ex();
up();right();ri "EQUATION**1|-|2";ex();
up();ri "DID**AF";ex();
up();ex();
ri "NAT_SUB**ASRTCOND";ex();
left();rri "CID";ex();
right();initializecounter();
rri "LEQ_ADD";ex();   (* from web page,but I have to remove bool *)
ri "RIGHT@RIGHT@PLUSTYPE2";ex();
ri "RIGHT@LESS_OR_EQ";ex();
ri "($ORBOOL)** $LESS_OR_EQ";ex();
assign "?m_1" "?n";
assign "?n_1" "?m";
ri "RIGHT@RIGHT@PLUSCOMM";ex();
up();ri "CSYM** $CRULE1";ex();
rri "CID";ex();
right();initializecounter();
rri "LEQ_LESS_TRANS";ex(); 
assign "?m_1" "?n";
assign "?n_1" "(Nat:?m)+Nat:?n";
assign "?p_1" "?p";
up();ri "3pt66";ex();
rri "CRULE3";ex();
right();ri "($ASSERT2)**BOOLDEF";ex();
ri "EQUATION**1|-|1";ex();
up();ri "CZER";ex();
up();ex();
ri "REALSUBNATTYPE**ASRTCOND";ex();
left();rri "CID";ex();
right();initializecounter();

rri "LEQ_ADD";ex();   (* from web page,but I have to remove bool *)
ri "RIGHT@RIGHT@PLUSTYPE2";ex();
ri "RIGHT@LESS_OR_EQ";ex();
ri "($ORBOOL)** $LESS_OR_EQ";ex();
assign "?m_1" "?n";
assign "?n_1" "?m";
ri "RIGHT@RIGHT@PLUSCOMM";ex();
up();ri "CSYM** $CRULE1";ex();
rri "CID";ex();
right();initializecounter();
rri "LEQ_LESS_TRANS";ex(); 
assign "?m_1" "?n";
assign "?n_1" "(Nat:?m)+Nat:?n";
assign "?p_1" "?p";
up();ri "3pt66";ex();
rri "CRULE3";ex();
right();ri "($ASSERT2)**BOOLDEF";ex();
ri "EQUATION**1|-|1";ex();
up();ri "CZER";ex();
up();ex();
ri "LEFT@ $PLUSTYPE2";ex();
ri "BREAKMINUS**PLUSASSOC";ex();
ri "RIGHT@ $BREAKMINUS";ex();
up();ri "REFLEX";ex();
top();ri "EVERYWHERE@ $CASEINTRO";ex();

p "SUB_LEFT_ADD";

*)

(* a lemma for proving theorems for which Wu gives very long proofs *)

(*

HOLMES_SUB:  

(Nat : ?m) + ?n .-. ?p  =  

((Nat : ?n) =< Nat : ?p) || (Nat : ?m) , (Nat : ?m) 
+ (Nat : ?n) - Nat : ?p

AND , BUILTIN , CASEINTRO , HYP , LESSCOMP , LESS_EQ_REAL 
, MINUSCOMP , MINUSTYPE , NATMINUSCOMP , NAT_SUB , NONTRIV 
, NOT1 , ODDCHOICE , OR , PLUSASSOC , PLUSCOMM , PLUSCOMP 
, PLUSID , PLUSMINUS , PLUSTYPE , REFLEX , TYPES , 0

*)



s "((Nat : ?m) + ?n .-. ?p)";
ri "PCASEINTRO@(Nat:?n)=<Nat:?p"; ex();
ri "EVERYWHERE@NAT__SUB"; ex();
ri "(LEFT@LESS_EQ_REAL)**TAB_OR_2"; ex();
ri "LEFT@EVERYWHERE@ $REALNAT"; ex();
ri "PIVOT"; ex();
dlls "SUB_REFL"; ri "SUB_REFL"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); ri "COMMPLUSID** $REALNAT"; ex();
up(); right();
right(); left(); ri "EVERYWHERE@1|-|2"; ex();
ri "COMMPLUSID** $REALNAT"; ex();
up(); right(); ri "EVERYWHERE@1|-|2"; ex();
top();
rri "TAB_OR_2"; ex();
left(); ri "LEFT@RL@REALNAT"; ex();
rri "LESS_EQ_REAL"; ex();

p "HOLMES_SUB";

(*

SUB_LEFT_SUC:

(1 + ?m .-. ?n) = ((Nat : ?m) =< Nat : ?n) || 1
, (1 + Nat : ?m) .-. ?n =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSCOMP","MINUSTYPE","NATMINUSCOMP","NAT_SUB","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "(1+?m.-.?n)=((Nat:?m)=<Nat:?n)||1,(1+Nat:?m).-.?n";
ri "PCASEINTRO@(Nat:?m)<Nat:?n";ex();
ri "ODDCHOICE";ex();
right();left();left();right();ri "NAT_SUB";ex();
ri "LEFT@ $0|-|1";ex();
up();ri "COMMPLUSID**REALNUMERAL2";ex();
up();right();left();ri "LESS_OR_EQ";ex();
ri "LEFT@ $0|-|1";ex();
ri "DSYM**DZER";ex();
up();ex();
up();ri "REFLEX";ex();
up();right();ri "PCASEINTRO@(Nat:?m)=Nat:?n";ex();
right();left();left();right();ri "NAT_SUB";ex();
right();right();right();ri "LEFT@0|-|2";ex();
ri "SUB_REFL";ex();
up();rri "ZERONAT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "COMMPLUSID**REALNUMERAL2";ex();
up();right();left();ri "LESS_OR_EQ";ex();
ri "RIGHT@LEFT@0|-|2";ex();
ri "(RIGHT@REFLEX)**DZER";ex();
up();ex();
up();ri "REFLEX";ex();

up();up();ri "ODDCHOICE";ex();
right();right();left();right();ri "NAT_SUB";ex();
ri "ODDCHOICE**1|-|1";ex();
ri "REALSUBNATTYPE";ex();
ri "ODDCHOICE**1|-|1";ex();
up();up();right();left();ri "LESS_OR_EQ";ex();
ri "($DRULE2)** $DRULE3";ex();
ri "RL@ ($ASSERT2)**BOOLDEF";ex();
left();ri "EQUATION**1|-|1";ex();
up();right();ri "EQUATION**1|-|2";ex();
up();ri "DID**AF";ex();
up();ex();
ri "NAT_SUB**ASRTCOND";ex();
left();rri "CID";ex();
right();initializecounter();
rri "LESS_SUC_REFL";ex();
assign "?x_1" "?m";
ri "RIGHT@LEFT@ONENAT";ex();
right();ri "PLUSTYPE2";ex();
ri "RIGHT@LEFT@ $ONENAT";ex();
up();up();ri "CSYM** $CRULE1";ex();
rri "CID";ex();
right();initializecounter();
rri "LESS_TRANS";ex();
assign "?m_1" "?m";
assign "?n_1" "1+Nat:?m";
assign "?p_1" "?n";
up();ri "3pt66";ex();
rri "CRULE3";ex();
right();ri "($ASSERT2)**BOOLDEF";ex();
ri "EQUATION**1|-|1";ex();
up();ri "CZER";ex();
up();ex();
ri "REALSUBNATTYPE**ASRTCOND";ex();
left();rri "CID";ex();
right();initializecounter();
rri "LESS_SUC_REFL";ex();
assign "?x_1" "?m";
ri "RIGHT@LEFT@ONENAT";ex();
right();ri "PLUSTYPE2";ex();
ri "RIGHT@LEFT@ $ONENAT";ex();
up();up();ri "CSYM** $CRULE1";ex();
rri "CID";ex();
right();initializecounter();
rri "LESS_TRANS";ex();
assign "?m_1" "?m";
assign "?n_1" "1+Nat:?m";
assign "?p_1" "?n";
up();ri "3pt66";ex();
rri "CRULE3";ex();
right();ri "($ASSERT2)**BOOLDEF";ex();
ri "EQUATION**1|-|1";ex();
up();ri "CZER";ex();
up();ex();
left();right();ri "LEFT@ONENAT";ex();
up();rri "PLUSTYPE2";ex();
ri "LEFT@ $ONENAT";ex();
up();ri "BREAKMINUS**PLUSASSOC";ex();
ri "RIGHT@ $BREAKMINUS";ex();
up();ri "REFLEX";ex();
top();ri "EVERYWHERE@ $CASEINTRO";ex();

p "SUB_LEFT_SUC";

(* The following is the well-known Euclidean theorem, the proof is based
on thetheorem "DINSTANTIATE" and the relations between quotient and
remainder *)
(*
DA:

forall
@ [forall
   @ [forsome
      @ [forsome
         @ [((Nat : ?1) > 0)
            -> ((Nat : ?2)
               = ((Nat : ?3) * Nat : ?1) + Nat
               : ?4)
            & (Nat : ?4) < Nat : ?1]]]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REALDIVTYPE","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s
"forall@[forall@[forsome@[forsome@[((Nat:?1)>0)->((Nat:?2)=(((Nat:?3)*Nat:?1)+Nat:?4))&(Nat:?4)<Nat:?1]]]]";
right();right();ri "INDUCT_TAC";ex();
left();right();right();right();right();right();left();
ri "RIGHT@LEFT@TIMESTYPE2";ex();
ri "EQSYMM**ADD_BOTH_0";ex();
left();ri "LEFT@ $TIMESTYPE2";ex();
ri "EQSYMM**FACTORZERO";ex();
ri "EVERYWHERE@ $REALNAT";ex();
up();up();up();up();up();
ri "DINSTANTIATEF1@0";ex();
left();ri "EVAL";ex();
ri "IMPTOCOND";ex();

right();ri "ODDCHOICE";ex();
right();left();right();ri "LEFT@ $ZERONAT";ex();
rri "GREATER";ex();
rri "0|-|1";ex();
up();left();right();ri "(LEFT@ $ZERONAT)**REFLEX";ex();
up();up();up();up();up();up();up();up();
ri "DINSTANTIATEF1@0";ex();
left();ri "EVAL";ex();
left();right();right();left();left();
ri "LEFT@LEFT@RIGHT@ $ZERONAT";ex();
ri "LEFT@LEFT@REFLEX";ex();
ri "LEFT@DSYM**DZER";ex();
ri "CID**AT";ex();
up();ri "CID**AT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();ri "DSYM**DZER";ex();
up();ri "DSYM**DZER";ex();

up();right();right();right();
rri "FORALL_IMP_FORSOME_EQ";ex();
right();right();rri "FORALL_IMP_FORSOME_EQ";ex();
right();right();ri "PCASEINTRO@((Nat:?4)+1)<Nat:?1";ex();
ri "ODDCHOICE";ex();
right();left();right();
ri "DINSTANTIATEF1@?3";ex();
left();ri "EVAL";ex();
ri "DINSTANTIATEF1@(Nat:?4)+Nat:1";ex();
left();ri "EVAL";ex();
right();left();right();ri "RIGHT@ $PLUSTYPE2";ex();
rri "PLUSASSOC";ex();
ri "RIGHT@ $ONENAT";ex();
ri "PLUSCOMM";ex();
right();ri "(LEFT@TIMESTYPE2)**(RIGHT@ $TYPES)**PLUSTYPE2";ex();
up();up();rri "SAMESUCC";ex();

ri "RIGHT@ $PLUSTYPE2";ex();
right();ri "LEFT@ $TIMESTYPE2";ex();
ri "RIGHT@TYPES";ex();
up();up();right();left();rri "PLUSTYPE2";ex();
ri "RIGHT@ $ONENAT";ex();
up();rri "0|-|1";ex();
up();ri "CID** $ASRTEQ";ex();
up();up();up();up();
ri "IDIS4";ex();
left();ri "IDIS4";ex();
left();ri "LEFT@IDIS3**CSYM";ex();
rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();ri "DSYM**DZER";ex();
up();ri "DSYM**DZER";ex();

up();right();ri "PCASEINTRO@((Nat:?4)+1)=Nat:?1";ex();
right();left();left();right();left();right();
ri "(LEFT@TIMESTYPE2)**PLUSTYPE2";ex();
up();ri "SAMESUCC";ex();
right();ri "RIGHT@ $PLUSTYPE2";ex();
ri "PLUSCOMM**PLUSASSOC";ex();
ri "RIGHT@0|-|2";ex();
ri "LEFT@ $TIMESTYPE2";ex();
right();ri "REALNAT** $TIMESID";ex();
up();rri "COMMDIST";ex();
up();up();up();up();right();
ri "DINSTANTIATEF1@(Nat:?3)+Nat:1";ex();
left();ri "EVAL";ex();
ri "DINSTANTIATEF1@0";ex();
left();ri "EVAL";ex();
ri "IDIS3";ex();
right();right();ri "(LEFT@ $ZERONAT)** $GREATER";ex();
up();ri "IREF";ex();
up();ri "CID**IRULE1";ex();
right();ri "RIGHT@RIGHT@ $ZERONAT";ex();
ri "RIGHT@COMMPLUSID";ex();
right();ri "(RIGHT@TIMESTYPE2)** $REALNAT";ex();
rri "TIMESTYPE2";ex();
left();rri "PLUSTYPE2";ex();
ri "RIGHT@ $ONENAT";ex();

up();up();up();up();up();up();
ri "IDIS4";ex();
left();ri "IDIS4";ex();
left();left();ri "IDIS3";ex();
ri "CSYM";ex();
up();rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();ri"DSYM**DZER";ex();
up();ri"DSYM**DZER";ex();
up();right();left();right();right();
rri "LESS_EQ_SUC_LESS";ex();
ri "EVERYWHERE@PLUSCOMM";ex();
ri "ALTORDEF";ex();
ri "1|-|1";ex();
ri "EQUATION** $ODDCHOICE";ex();
ri "1|-|2";ex();
up();ri "CZER";ex();
up();ri "3pt74";ex();

up();ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();right();right();right();right();
rri "IRULE2";ex();
ri "LEFT@ $DUBNEG2";ex();
ri "LEFT@RIGHT@ $0|-|3";ex();
ri "(LEFT@ $FDEF)**3pt75";ex();
up();up();ri "FORSOMEDROP**AT";ex();
up();up();ri "FORSOMEDROP**AT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();up();rri "CASEINTRO";ex();
up();up();rri "CASEINTRO";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();
up();ri "CID**AT";ex();
up();up();ri "FORALLDROP**AT";ex();

p "DA"; 

s "(?a - ?b) = ?c - ?d";
ri "RL@TADDTOP@MINUSTYPE";ex();
ri "ADD_CANCELF@?d+?b";ex();
ri "RL@ALL_CANCEL";ex();
ri "RL@PLUSCOMM";ex();

p "MINUS_FLIPADD";


(* GEQ_1_EQ_GREATER_0 *)

(* I had to prove this myself -- it isn't in any file you have sent me! *)

s "(Nat:?x)>=1";
ri "RIGHT@ONENAT"; ex();
ri "GREATER_EQ"; ex();
rri "NOT_SUC_LEQ"; ex();
ri "EVERYWHERE@ONENAT**PLUSTYPE2"; ex();
ri "NOT_LEQ"; ex();
ri "EVERYWHERE@TYPES** $PLUSTYPE2"; ex();
left(); ri "REALNAT** $COMMPLUSID"; ex();
ri "RIGHT@ZERONAT"; ex();
top(); ri "REAL_LESS_CANCEL"; ex();
rri "GREATER"; ri "RIGHT@ $ZERONAT"; ex();
p "GEQ_1_EQ_GREATER_0";


(*

EQ_IMP_LEQ:

((Nat : ?m) = Nat : ?n) -> (Nat : ?m) =< Nat : ?n =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSCOMP","PLUSTYPE","REFLEX","TYPES","XOR"]
*)

s "((Nat:?m)=Nat:?n)->(Nat:?m)=<Nat:?n";
ri "RIGHT@LESS_OR_EQ";ex();
ri "IDIS4";ex();
ri "RIGHT@IREF";ex();
ri "DZER";ex();

p "EQ_IMP_LEQ";

(*

LESS_ONE_EQ_0:

(Nat : ?x) < 1 =

(Nat : ?x) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","EVALEQ","IF","IFF","INDUCTION","LESS1","LESSTYPE","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSTI
MES","POSTYPE","REAL_LESS_DEF","REFLEX","TIMESCOMM","TIMESID","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "(Nat:?x)<1";
ri "RIGHT@ONENAT"; ex();
ri "LESSBOOL";ex();
ri "ASSERT2** $CID";ex();
right();initializecounter();
rri "LESS_LEMMA1";ex();
assign "?x_1" "?x";
assign "?y_1" "0";
ri "EVERYWHERE@ $ZERONAT";ex();
ri "EVERYWHERE@ONENAT**COMMPLUSID** $REALNAT";ex();
up();ri "3pt66";ex();
right();right();ri "RIGHT@ZERONAT";ex();
ri "LESSBOOL** $DUBNEG";ex();
right();ri "RIGHT@RIGHT@ $ZERONAT";ex();
ri "NOT_LESS_0";ex();
up();rri "FDEF";ex();
up();ri "DID";ex();
up();ri "CRULE3";ex();
ri "CSYM";ex();
ri "TAB_AND";ex();
right();left();left();left();ri "0|-|1";ex();
up();ri "RIGHT@ $ONENAT";ex();
rri "ALT_POS_DEF";ex(); (* Web Page "realorder.mk2 *)
ri "POS_ONE";ex(); (* Web Page "realorder.mk2 *)
up();ex();
up();up();rri "EQUATION";ex();

p "LESS_ONE_EQ_0";

(* The following is the well-known Euclidean theorem, the proof is based
on thetheorem "DINSTANTIATE" and the relations between quotient and
remainder *)
(*
DA_1:

forall
@ [forsome
   @ [forsome
      @ [((Nat : ?x) > 0)
         -> ((Nat : ?1) = ((Nat : ?2) * Nat : ?x)
            + Nat : ?3)
         & (Nat : ?3) < Nat : ?x]]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REALDIVTYPE","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s
"forall@[forsome@[forsome@[((Nat:?x)>0)->((Nat:?1)=((Nat:?2)*Nat:?x)+Nat:?3)&(Nat:?3)<Nat:?x]]]";
ri "INDUCT_TAC";ex();
left();right();right();right();right();right();left();
ri "RIGHT@LEFT@TIMESTYPE2";ex();
ri "EQSYMM**ADD_BOTH_0";ex();
left();ri "LEFT@ $TIMESTYPE2";ex();
ri "EQSYMM**FACTORZERO";ex();
ri "EVERYWHERE@ $REALNAT";ex();
up();up();up();up();up();
ri "DINSTANTIATEF1@0";ex();
left();ri "EVAL";ex();
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();right();ri "LEFT@ $ZERONAT";ex();
rri "GREATER";ex();
rri "0|-|1";ex();
up();left();right();ri "(LEFT@ $ZERONAT)**REFLEX";ex();
up();up();up();up();up();up();up();up();
ri "DINSTANTIATEF1@0";ex();
left();ri "EVAL";ex();
left();right();right();left();left();
ri "LEFT@LEFT@RIGHT@ $ZERONAT";ex();
ri "LEFT@LEFT@REFLEX";ex();
ri "LEFT@DSYM**DZER";ex();
ri "CID**AT";ex();
up();ri "CID**AT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();ri "DSYM**DZER";ex();
up();ri "DSYM**DZER";ex();

up();right();right();right();
rri "FORALL_IMP_FORSOME_EQ";ex();
right();right();rri "FORALL_IMP_FORSOME_EQ";ex();
right();right();ri "PCASEINTRO@((Nat:?3)+1)<Nat:?x";ex();
ri "ODDCHOICE";ex();
right();left();right();
ri "DINSTANTIATEF1@?2";ex();
left();ri "EVAL";ex();
ri "DINSTANTIATEF1@(Nat:?3)+Nat:1";ex();
left();ri "EVAL";ex();
right();left();right();ri "RIGHT@ $PLUSTYPE2";ex();
rri "PLUSASSOC";ex();
ri "RIGHT@ $ONENAT";ex();
ri "PLUSCOMM";ex();
right();ri "(LEFT@TIMESTYPE2)**(RIGHT@ $TYPES)**PLUSTYPE2";ex();
up();up();rri "SAMESUCC";ex();
ri "RIGHT@ $PLUSTYPE2";ex();
right();ri "LEFT@ $TIMESTYPE2";ex();
ri "RIGHT@TYPES";ex();
up();up();right();left();rri "PLUSTYPE2";ex();
ri "RIGHT@ $ONENAT";ex();
up();rri "0|-|1";ex();
up();ri "CID** $ASRTEQ";ex();
up();up();up();up();
ri "IDIS4";ex();
left();ri "IDIS4";ex();
left();ri "LEFT@IDIS3**CSYM";ex();
rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();ri "DSYM**DZER";ex();
up();ri "DSYM**DZER";ex();

up();right();ri "PCASEINTRO@((Nat:?3)+1)=Nat:?x";ex();
right();left();left();right();left();right();
ri "(LEFT@TIMESTYPE2)**PLUSTYPE2";ex();
up();ri "SAMESUCC";ex();
right();ri "RIGHT@ $PLUSTYPE2";ex();
ri "PLUSCOMM**PLUSASSOC";ex();
ri "RIGHT@0|-|2";ex();
ri "LEFT@ $TIMESTYPE2";ex();
right();ri "REALNAT** $TIMESID";ex();
up();rri "COMMDIST";ex();
up();up();up();up();right();
ri "DINSTANTIATEF1@(Nat:?2)+Nat:1";ex();
left();ri "EVAL";ex();
ri "DINSTANTIATEF1@0";ex();
left();ri "EVAL";ex();
ri "IDIS3";ex();
right();right();ri "(LEFT@ $ZERONAT)** $GREATER";ex();
up();ri "IREF";ex();
up();ri "CID**IRULE1";ex();
right();ri "RIGHT@RIGHT@ $ZERONAT";ex();
ri "RIGHT@COMMPLUSID";ex();
right();ri "(RIGHT@TIMESTYPE2)** $REALNAT";ex();
rri "TIMESTYPE2";ex();
left();rri "PLUSTYPE2";ex();
ri "RIGHT@ $ONENAT";ex();
up();up();up();up();up();up();

ri "IDIS4";ex();
left();ri "IDIS4";ex();
left();left();ri "IDIS3";ex();
ri "CSYM";ex();
up();rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();ri"DSYM**DZER";ex();
up();ri"DSYM**DZER";ex();
up();right();left();right();right();
rri "LESS_EQ_SUC_LESS";ex();
ri "EVERYWHERE@PLUSCOMM";ex();
ri "ALTORDEF";ex();
ri "1|-|1";ex();
ri "EQUATION** $ODDCHOICE";ex();
ri "1|-|2";ex();
up();ri "CZER";ex();
up();ri "3pt74";ex();

up();ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();right();right();right();right();
rri "IRULE2";ex();
ri "LEFT@ $DUBNEG2";ex();
ri "LEFT@RIGHT@ $0|-|3";ex();
ri "(LEFT@ $FDEF)**3pt75";ex();
up();up();ri "FORSOMEDROP**AT";ex();
up();up();ri "FORSOMEDROP**AT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();up();rri "CASEINTRO";ex();
up();up();rri "CASEINTRO";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();
up();ri "CID**AT";ex();

p "DA1";

(*

(*
DA:

forall
@ [forall
   @ [forsome
      @ [forsome
         @ [((Nat : ?1) > 0)
            -> ((Nat : ?2)
               = ((Nat : ?3) * Nat : ?1) + Nat
               : ?4)
            & (Nat : ?4) < Nat : ?1]]]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REALDIVTYPE","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s
"forall@[forall@[forsome@[forsome@[((Nat:?1)>0)->((Nat:?2)=(((Nat:?3)*Nat:?1)+Nat:?4))&(Nat:?4)<Nat:?1]]]]";
right();right();ri "DA1";ex();
up();up();ri "FORALLDROP**AT";ex();

p "DA";

*)

(*
DA2:

forsome
@ [forsome
   @ [((Nat : ?x) > 0)
      -> ((Nat : ?y) = ((Nat : ?1) * Nat : ?x)
         + Nat : ?2)
      & (Nat : ?2) < Nat : ?x]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REALDIVTYPE","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s "true";
initializecounter();
rri "DA1";ex();
assign "?x_1" "?x";
initializecounter();
rri "INSTANTIATE";ex();
ri "(RIGHT@DA1)**CID";ex();
right();ri "EVAL";ex();
assign "?x_1" "?y";
up();rri "ASSERT2";ex();
rri "FORSOMEBOOL";ex();
wb();

p "DA2";

(* I give axiom(definition) "DIVISION" *)

axiom "DIVISION"
"forall@[forall@[(0<Nat:?1)->(((Nat:?2)=(((Nat:?2)/Nat:?1)*Nat:?1)+(Nat:?2)%Nat:?1)&((Nat:?2)%Nat:?1)<Nat:?1)]]"
"true";

axiom "DIVISION1"
"(0<Nat:?n)->((Nat:?k)=(((Nat:?k)/Nat:?n)*Nat:?n)+(Nat:?k)%Nat:?n)&((Nat:?k)%Nat:?n)<Nat:?n"
"true";

(* use axioms "DIVISION" or "DIVIDION1", I can get the general form
"DIVISION_3", so the two theorems above are equivalent *)
(* 
DIVISION_3:

(0 < Nat : ?n)
-> ((Nat : ?k)
   = (((Nat : ?k) / Nat : ?n) * Nat : ?n)
   + (Nat : ?k) % Nat : ?n)
& ((Nat : ?k) % Nat : ?n) < Nat : ?n =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","DIVISION1","DIVTYPE","EQUATION","IF","IFF","LESSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","forall"]
*)


s "true";
initializecounter();
rri "DIVISION1";ex();
assign "?n_1" "?n";
right();initializecounter();
rri "INSTANTIATE";ex();
assign "?x_1" "?k";
ri "LEFT@EVAL";ex();
up();ri "IDIS3";ex();
ri "RIGHT@DIVISION1";ex();
ri "CID**IRULE1";ex();
wb();

p "DIVISION_3";

(*

(* Now use axiom "DIVISION" to give a short proof of "DA" *)
(*
DA:

forall
@ [forall
   @ [forsome
      @ [forsome
         @ [(0 < Nat : ?1)
            -> ((Nat : ?2)
               = ((Nat : ?3) * Nat : ?1) + Nat
               : ?4)
            & (Nat : ?4) < Nat : ?1]]]] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION","IF","IFF","LESSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","forall","forsome"]
*)

s
"forall@[forall@[forsome@[forsome@[(0<Nat:?1)->((Nat:?2)=(((Nat:?3)*Nat:?1)+Nat:?4))&(Nat:?4)<Nat:?1]]]]";
right();right();right();right();
ri "DINSTANTIATEF1@(Nat:?2)/Nat:?1";ex();
left();ri "EVAL";ex();
ri "DINSTANTIATEF1@(Nat:?2)%Nat:?1";ex();
left();ri "EVAL";ex();
right();right();left();right();ri "RL@ $TYPES";ex();
up();rri "MODTYPE";ex();
up();up();left();right();right();right();ri "RL@ $TYPES";ex();
up();rri "MODTYPE";ex();
up();left();left();right();ri "RL@ $TYPES";ex();
up();rri "DIVTYPE";ex();
up();up();up();up();up();up();up();
ri "DASSOC";ex();
up();up();ri "FORALLOR";ex();
up();up();ri "FORALLOR";ex();
ri "LEFT@DIVISION";ex();
ri "DSYM**DZER";ex();

p "DA";

*)

(*
DA3:

(0 < Nat : ?n) -> forsome
@ [forsome
   @ [((Nat : ?k) = ((Nat : ?1) * Nat : ?n) + Nat
         : ?2)
      & (Nat : ?2) < Nat : ?n]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REALDIVTYPE","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s
"(0<Nat:?n)->forsome@[forsome@[((Nat:?k)=(((Nat:?1)*Nat:?n)+Nat:?2))&(Nat:?2)<Nat:?n]]";
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();right();right();right();right();
rri "CRULE1";ex();
rri "ILID";ex();
ri "LEFT@0|-|1";ex();
ri "LEFT@ $GREATER";ex();
up();up();up();up();ri "DA2";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "DA3";

(*
DIVISION_1:

forall
@ [(0 < Nat : ?x)
   -> ((Nat : ?1)
      = (((Nat : ?1) / Nat : ?x) * Nat : ?x)
      + (Nat : ?1) % Nat : ?x)
   & ((Nat : ?1) % Nat : ?x) < Nat : ?x] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION","IF","IFF","LESSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","forall"]
*)

s
"forall@[(0<Nat:?x)->(((Nat:?1)=(((Nat:?1)/Nat:?x)*Nat:?x)+(Nat:?1)%Nat:?x)&((Nat:?1)%Nat:?x)<Nat:?x)]";
ri "FORALLBOOL**ASSERT2";ex();
rri "CID";ex();
ri "RIGHT@ $DIVISION";ex();
ri "LEFT@BIND@?x";ex();
ri "INSTANTIATE";ex();
ri "DIVISION";ex();

p "DIVISION_1";


(*
DIVISION_2:

(0 < Nat : ?n)
-> ((Nat : ?k)
   = (((Nat : ?) / Nat : ?x) * Nat : ?x)
   + (Nat : ?y) % Nat : ?x)
& ((Nat : ?y) % Nat : ?x) < Nat : ?x =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION","IF","IFF","LESSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE","REFLEX","TIMESTYPE","TYPES","XOR","forall"]
*)

s
"(0<Nat:?n)->((Nat:?k)=(((Nat:?k)/Nat:?n)*Nat:?n)+(Nat:?k)%Nat:?n)&((Nat:?k)%Nat:?n)<Nat:?n";
rri "IRULE1";ex();
rri "CID";ex();
initializecounter();
ri "RIGHT@ $DIVISION_1";ex();
assign "?x_4" "?n";
ri "LEFT@BIND@?k";ex();
ri "INSTANTIATE";ex();
ri "DIVISION_1";ex();

p "DIVISION_2";



(*
MOD_LESS:

true =

(0 < Nat : ?n) -> ((Nat : ?k) % Nat : ?n) < Nat
: ?n

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION","IF","IFF","LESSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSCOMM","PLUSCOMP","PLUSTYPE","REFLEX","TIMESINTDIV","TIMESTYPE","TYPES","XOR","forall"]
*)

s "true";
initializecounter();
rri "DIVISION_2";ex();
assign "?n_1" "?n";
assign "?k_1" "?k";
right();left();
right();
ri "PLUSCOMM"; ex();
ri "RIGHT@RIGHT@ $TYPES"; ex();
ri "TIMESINTDIV"; ex();
ri "TYPES"; up();
ri "REFLEX";ex();
up();ri "CSYM**CID";ex();
up();ri "IRULE3";ex();
wb();

p "MOD_LESS";

(*

(*another proof of "DA3" *)
(*
DA3:

(0 < Nat : ?n) -> forsome
@ [forsome
   @ [((Nat : ?k) = ((Nat : ?1) * Nat : ?n) + Nat
         : ?2)
      & (Nat : ?2) < Nat : ?n]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIVISION","DIVTYPE","
EQUATION","IF","IFF","LESSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLU
SCOMM","PLUSCOMP","PLUSTYPE","REFLEX","TIMESINTDIV","TIMESTYPE","TYPES","XOR","
forall","forsome"]
*)

s
"(0<Nat:?n)->forsome@[forsome@[((Nat:?k)=(((Nat:?1)*Nat:?n)+Nat:?2))&(Nat:?2)<Nat:?n]]";
right();ri "DINSTANTIATEF1@(Nat:?k)/Nat:?n";ex();
left();ri "EVAL";ex();
ri "DINSTANTIATEF1@(Nat:?k)%Nat:?n";ex();
left();ri "EVAL";ex();
right();left();ri "RIGHT@MODTYPE";ex();
ri "TYPES";ex();
rri "MODTYPE";ex();
up();up();left();right();right();ri "RIGHT@MODTYPE";ex();
ri "TYPES";ex();
rri "MODTYPE";ex();
up();left();left();ri "RIGHT@DIVTYPE";ex();
ri "TYPES";ex();
rri "DIVTYPE";ex();
up();up();up();left();ri "REALNAT";ex();
initializecounter();
rri "TIMESINTDIV";ex(); (*web page naturals *)
assign "?y_1" "Nat:?n";
ri "PLUSCOMM";ex();
up();ri "REFLEX";ex();
up();ri "CSYM**CID";ex();

top();ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();left();left();
rri "ILID";ex();
ri "LEFT@0|-|1";ex();
ri "MOD_LESS";ex();
up();ri "DSYM**DZER";ex();
up();ri "DSYM**DZER";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "DA3";
*)

(*
DA4:

forsome
@ [forsome
   @ [(Nat : ?k) = ((Nat : ?1) * Nat : ?n) + Nat
      : ?2]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIVTYPE","EQUATION","
IF","IFF","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSCOMM","PLUSCOMP","PLU
STYPE","REFLEX","TIMESINTDIV","TIMESTYPE","TYPES","XOR","forall","forsome"]
*)

s "forsome@[forsome@[(Nat:?k)=((Nat:?1)*Nat:?n)+Nat:?2]]";
ri "DINSTANTIATEF1@(Nat:?k)/Nat:?n";ex();
left();ri "EVAL";ex();
ri "DINSTANTIATEF1@(Nat:?k)%Nat:?n";ex();
left();ri "EVAL";ex();
right();right();ri "RIGHT@MODTYPE";ex();
ri "TYPES";ex();
rri "MODTYPE";ex();
up();left();left();ri "RIGHT@DIVTYPE";ex();
ri "TYPES";ex();
rri "DIVTYPE";ex();
up();up();up();left();
initializecounter();
rri "TIMESINTDIV";ex(); (*web page naturals *)
assign "?y_1" "Nat:?n";
ri "PLUSCOMM";ex();
ri "EVERYWHERE@TADDLEFT@DIVTYPE"; 
ri "EVERYWHERE@TADDLEFT@MODTYPE";
ri "EVERYWHERE@TYPES"; ex();
up();ri "REFLEX";ex();
up();ri "DSYM**DZER";ex();
up();ri "DSYM**DZER";ex();

p "DA4";



(*


(* Here I am using axim "DIVISION_2" directly *)
(*
DA3:

(0 < Nat : ?n) -> forsome
@ [forsome
   @ [((Nat : ?k) = ((Nat : ?1) * Nat : ?n) + Nat
         : ?2)
      & (Nat : ?2) < Nat : ?n]] =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION",
"IF","IFF","LESSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE","RE
FLEX","TIMESTYPE","TYPES","XOR","forall","forsome"]
*)

s
"(0<Nat:?n)->forsome@[forsome@[((Nat:?k)=(((Nat:?1)*Nat:?n)+Nat:?2))&(Nat:?2)<Nat:?n]]";
right();ri "DINSTANTIATEF1@(Nat:?k)/Nat:?n";ex();
ri "LEFT@EVAL";ex();
up();ri "IDIS4";ex();
left();right();ri "DINSTANTIATEF1@(Nat:?k)%Nat:?n";ex();
ri "LEFT@EVAL";ex();
up();ri "IDIS4";ex();
left();right();right();left();ri "RIGHT@MODTYPE";ex();
ri "TYPES** $MODTYPE";ex();
up();up();left();right();right();ri "RIGHT@MODTYPE";ex();
ri "TYPES** $MODTYPE";ex();
up();left();left();
ri "RIGHT@DIVTYPE";ex();
ri "TYPES** $DIVTYPE";ex();
up();up();up();up();up();
ri "DIVISION_2";ex();
up();ri "DSYM**DZER";ex();
up();ri "DSYM**DZER";ex();

p "DA3";

*)

(*
MOD_ONE:

forall @ [((Nat : ?1) % 1) = 0] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","EVALEQ","GREATER","IF","IFF","INDUCTION","LESS1","LESSTYPE","MINUSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSTIMES","POSTYPE","REAL_LESS_DEF","REFLEX","TIMESCOMM","TIMESID","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "forall@[((Nat:?1)%1)=0]";
ri "FORALLBOOL**ASSERT2";ex();
rri "ILID";ex();
left();rri "DIVISION";ex();
initializecounter();
rri "INSTANTIATE";ex();
assign "?x_1" "1";
ri "LEFT@EVAL";ex();
ri "RIGHT@DIVISION";ex();
ri "CID** ($ASSERT2)** $FORALLBOOL";ex();
right();right();left();ri "GREATER";ex();
ri "RIGHT@ $ONENAT";ex();
ri "($ALT_POS_DEF)**POS_ONE";ex();
up();ri "ILID**CRULE1";ex();
ri "RIGHT@RIGHT@ $ONENAT";ex();
ri "RIGHT@LEFT@MODTYPE";ex();
ri "RIGHT@LESS_ONE_EQ_0";ex();
ri "RIGHT@LEFT@ $MODTYPE";ex();
ri "RIGHT@LEFT@RIGHT@ $ONENAT";ex();
up();up();ri "FORALLDIST";ex();
up();rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();

p "MOD_ONE";


(*
MOD_ONE_1:

((Nat : ?x) % 1) = 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","EVALEQ","GREATER","IF","IFF","INDUCTION","LESS1","LESSTYPE","MINUSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSTIMES","POSTYPE","REAL_LESS_DEF","REFLEX","TIMESCOMM","TIMESID","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?x)%1)=0";
ri "ASRTEQ** $CID";ex();
ri "RIGHT@ $MOD_ONE";ex();
ri "LEFT@BIND@?x";ex();
ri "INSTANTIATE";ex();
ri "MOD_ONE";ex();

p "MOD_ONE_1";


(*the following several theorems used for "DIV_LESS_EQ" *)
(*
LEQ_LEQ_MULT_MONO:

(((Nat : ?m) =< Nat : ?n) & (Nat : ?p) =< Nat : ?q)
-> ((Nat : ?m) * Nat : ?p) =< (Nat : ?n) * Nat
: ?q =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s
"(((Nat:?m)=<Nat:?n)&(Nat:?p)=<Nat:?q)->((Nat:?m)*Nat:?p)=<(Nat:?n)*Nat:?q";
left();rri "CRULE2";ex();
ri "LEFT@ $CID";ex();
left();right();initializecounter();
rri "LESS_MONO_MULT";ex();
assign "?m_1" "?m";
assign "?n_1" "?n";
assign "?p_1" "?p";
up();ri "3pt66";ex();
up();rri "CRULE3";ex();
right();rri "CID";ex();
right();initializecounter();
rri "LESS_MONO_MULT";ex();
assign "?m_1" "?p";
assign "?n_1" "?q";
assign "?p_1" "?n";
up();ri "3pt66";ex();
up();ri "CASSOC";ex();
right();ri "CSYM**CASSOC";ex();
up();rri "CASSOC";ex();
up();rri "3pt65";ex();
right();left();ri "CSYM";ex();
right();ri "RL@TIMESCOMM";ex();
up();up();ri "EVERYWHERE@TIMESTYPE2";ex();
ri "LEQ_TRANS";ex();
up();ri "IRZER";ex();

p "LEQ_LEQ_MULT_MONO";



(*
FLEQ_LEQ_MULT_MONO:

forall
@ [forall
   @ [(((Nat : ?m) =< Nat : ?n) & (Nat : ?1)
         =< Nat : ?2) -> ((Nat : ?m) * Nat : ?1)
      =< (Nat : ?n) * Nat : ?2]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s
"forall@[forall@[(((Nat:?m)=<Nat:?n)&(Nat:?1)=<Nat:?2)->((Nat:?m)*Nat:?1)=<(Nat:?n)*Nat:?2]]";
right();right();right();right();ri "LEQ_LEQ_MULT_MONO";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();

p "FLEQ_LEQ_MULT_MONO";


(*
SUM_IMP_GEQ:

((Nat : ?x) = (Nat : ?y) + Nat : ?z) -> (Nat : ?x)
>= Nat : ?y =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","LEQ_ADD","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSCOMP","PLUSTYPE","PLUSTYPE2","REFLEX","TYPES","XOR"]
*)

s "((Nat:?x)=(Nat:?y)+Nat:?z)->(Nat:?x)>=Nat:?y";
ri "IMPTOCOND";ex();
right();right();left();
ri "LEFT@0|-|1";ex();
ri "LEFT@PLUSTYPE2";ex();
ri "GREATER_EQ";ex();
ri "RIGHT@ $PLUSTYPE2";ex();
ri "LEQ_ADD";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "SUM_IMP_GEQ";


(*
LEQ_MONO_MULT:

((Nat : ?x) > 0) -> ((Nat : ?y) / Nat : ?x)
=< ((Nat : ?y) / Nat : ?x) * Nat : ?x =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVTYPE","EQUATION","EVALEQ","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTIMES","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?x)>0)->((Nat:?y)/Nat:?x)=<((Nat:?y)/Nat:?x)*Nat:?x";
ri "IMPTOCOND";ex();
right();ri "LEFT@ $GEQ_1_EQ_GREATER_0";ex();
ri "LEFT@RIGHT@ONENAT";ex();
ri "LEFT@GREATER_EQ";ex();
ri "ODDCHOICE";ex();
right();left();ri "EVERYWHERE@DIVTYPE";ex();
ri "RIGHT@TIMESTYPE2";ex();
ri "LESS_OR_EQ** $DRULE1";ex();
ri "RIGHT@ $LESS_OR_EQ";ex();
right();left();ri "REALNAT** $TIMESID";ex();
ri "TIMESCOMM** (RIGHT@ONENAT)";ex();
up();ri "RIGHT@ $TIMESTYPE2";ex();
ri "RL@TIMESCOMM";ex();
up();rri "ILID";ex();
ri "LEFT@0|-|1";ex();
ri "LESS_MONO_MULT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "LEQ_MONO_MULT";


(*
LEQ_ADD_MULT_TRUE:

(((Nat : ?y) / Nat : ?x) * Nat : ?x)
=< (((Nat : ?y) / Nat : ?x) * Nat : ?x) + Nat : ?z =

true

["DIVTYPE","LEQ_ADD","TIMESTYPE2"]
*)

s "(((Nat:?y)/Nat:?x)*Nat:?x)=<(((Nat:?y)/Nat:?x)*Nat:?x)+Nat:?z";
ri "LEFT@LEFT@DIVTYPE";ex();
ri "LEFT@TIMESTYPE2";ex();
right();ri "LEFT@LEFT@DIVTYPE";ex();
ri "LEFT@TIMESTYPE2";ex();
up();ri "LEQ_ADD";ex();

p "LEQ_ADD_MULT_TRUE";


(*
DIV_LESS_EQ_3:

((Nat : ?x) > 0)
-> ((Nat : ?y)
   = (((Nat : ?y) / Nat : ?x) * Nat : ?x)
   + (Nat : ?y) % Nat : ?x)
-> (Nat : ?y) >= (Nat : ?y) / Nat : ?x =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVTYPE","EQUATION","EVALEQ","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LEQ_ADD","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTIMES","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s
"((Nat:?x)>0)->((Nat:?y)=(((Nat:?y)/Nat:?x)*Nat:?x)+(Nat:?y)%Nat:?x)->(Nat:?y)>=(Nat:?y)/Nat:?x";
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();ri "IMPTOCOND";ex();
right();right();left();ri "LEFT@0|-|2";ex();
ri "RIGHT@DIVTYPE";ex();
left();ri "RIGHT@MODTYPE";ex();
ri "LEFT@LEFT@DIVTYPE";ex();
ri "LEFT@TIMESTYPE2";ex();
ri "PLUSTYPE2";ex();
up();ri "GREATER_EQ";ex();
ri "LESS_OR_EQ** $DRULE1";ex();
rri "ILID";ex();
ri "RIGHT@ $LESS_OR_EQ";ex();
left();initializecounter();
rri "LEQ_MONO_MULT";ex();
assign "?x_1" "?x";
assign "?y_1" "?y";
ri "LEFT@ $0|-|1";ex();
ri "ILID";ex();
rri "CID";ex();
right();initializecounter();
rri "LEQ_ADD_MULT_TRUE";ex();
assign "?y_1" "?y";
assign "?x_1" "?x";
assign "?z_1" "(Nat:?y)%Nat:?x";
right();ri "RIGHT@RIGHT@MODTYPE";ex();
ri "RIGHT@TYPES";ex();
ri "LEFT@LEFT@DIVTYPE";ex();
ri "LEFT@TIMESTYPE2";ex();
ri "PLUSTYPE2";ex();
up();ri "LEFT@LEFT@DIVTYPE";ex();
ri "LEFT@TIMESTYPE2";ex();
up();left();ri "LEFT@DIVTYPE";ex();
ri "RIGHT@LEFT@DIVTYPE";ex();
ri "RIGHT@TIMESTYPE2";ex();
up();up();ri "LEQ_TRANS";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "DIV_LESS_EQ_3";


(*
DIV_LESS_EQ_4:

(0 < Nat : ?x) -> ((Nat : ?y) / Nat : ?x) =< Nat
: ?y =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","EVALEQ","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LEQ_ADD","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTIMES","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]DIV_LESS_EQ:
*)

s "(0<Nat:?x)->((Nat:?y)/Nat:?x)=<Nat:?y";
ri "($IRULE3)** $IRULE3";ex();
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();right();rri "ILID";ex();
initializecounter();ri "LEFT@ $DIV_LESS_EQ_3";ex();
assign "?x_4" "?x";
assign "?y_4" "?y";
left();ri "LEFT@GREATER** $0|-|1";ex();
ri "ILID**IRULE1";ex();
up();up();rri "ILID";ex();
initializecounter();ri "LEFT@ $DIVISION_2";ex();
assign "?n_4" "?x";
assign "?k_4" "?y";
left();ri "LEFT@ $0|-|1";ex();
ri "ILID**CRULE1";ex();
ri "CSYM";ex();
up();rri "3pt65";ex();
right();ri "IMPTOCOND";ex();
right();right();left();left();left();ri "LEFT@0|-|2";ex();
ri "REFLEX";ex();
up();ri "ILID";ex();
up();ri "IRULE2";ex();
ri "EVERYWHERE@DIVTYPE";ex();
ri "(LEFT@GREATER_EQ)**IREF";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "DIV_LESS_EQ_4";


(*
DIV_LESS_EQ:

forall
@ [forall
   @ [(0 < Nat : ?1) -> ((Nat : ?2) / Nat : ?1)
      =< Nat : ?2]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","EVALEQ","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LEQ_ADD","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTIMES","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "forall@[forall@[(0<Nat:?1)->((Nat:?2)/Nat:?1)=<Nat:?2]]";
right();right();right();right();ri "DIV_LESS_EQ_4";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();

p "DIV_LESS_EQ";


(*
DIV_LESS_EQ_5:

(0 < Nat : ?n) -> forall
@ [((Nat : ?1) / Nat : ?n) =< Nat : ?1] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","EVALEQ","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LEQ_ADD","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTIMES","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "(0<Nat:?n)->forall@[((Nat:?1)/Nat:?n)=<Nat:?1]";
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();rri "FORALLBOOL2";ex();
right();right();ri "ASSERT2";ex();
rri "ILID";ex();
ri "LEFT@0|-|1";ex();
ri "DIV_LESS_EQ_4";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "DIV_LESS_EQ_5";


(* Now I change the form of "DIV_UNIQUE", I was wondering if it should be!
Because change general Nat:?r to specific (Nat:?k)%Nat:?n,I can apply
axiom "DIVISION_2" *)
(*
DIV_UNIQUE_3:

(((Nat : ?k) = ((Nat : ?q) * Nat : ?n)
      + (Nat : ?k) % Nat : ?n)
   & ((Nat : ?k) % Nat : ?n) < Nat : ?n)
-> ((Nat : ?k) / Nat : ?n) = Nat : ?q =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s
"(((Nat:?k)=((Nat:?q)*Nat:?n)+(Nat:?k)%Nat:?n)&((Nat:?k)%Nat:?n)<Nat:?n)->((Nat:?k)/Nat:?n)=Nat:?q";
ri "PCASEINTRO@0=Nat:?n";ex();
right();left();left();right();ri "RIGHT@ $0|-|1";ex();
ri "LEFT@MODTYPE";ex();
ri "LESS_0_FALSE";ex();
up();ri "CZER";ex();
up();ri "3pt75";ex();
up();up();rri "NOT_EXP";ex();
left();ri "RIGHT@EQSYMM";ex();
rri "GREAT_NOT_EQ_0";ex();
up();ri "ODDCHOICE";ex();

right();left();rri "IRULE1";ex();
rri "ILID";ex();
left();initializecounter(); (* here I can use "DIVISION_2" *)
rri "DIVISION_2";ex();
assign "?n_1" "?n";
assign "?k_1" "?k";
ri "LEFT@ $0|-|1";ex();
ri "ILID**CRULE1";ex();
ri "CSYM";ex();
up();rri "3pt65";ex();
right();ri "IMPTOCOND";ex();
right();right();left();left();left();ri "LEFT@0|-|2";ex();

ri "RIGHT@PLUSCOMM";ex();

rri "MINUS_FLIPADD";ex();
ri "RIGHT@SUB_REFL";ex();
left();ri "BREAKMINUS";ex();
ri "RIGHT@MINUS_TIMESID** $TIMESASSOC";ex();
rri "COMMDIST";ex();
left();ri "RIGHT@ $MINUS_TIMESID";ex();
rri "BREAKMINUS";ex();
up();up();ri "EQSYMM**FACTORZERO";ex();
ri "EVERYWHERE@ $REALNAT";ex();
rri "DRULE3";ex();
ri "RIGHT@ $DUBNEG2";ex();
right();ri "RIGHT@RIGHT@EQSYMM";ex();
ri "RIGHT@ $GREAT_NOT_EQ_0";ex();
ri "RIGHT@ $0|-|1";ex();
rri "FDEF";ex();
up();ri "DID";ex();
rri "ASRTEQ";ex();
ri "EQSYMM";ex();
rri "REAL_MINUS_EQ_0";ex();
left();ri "SUBTRACT_DIFF";ex();
ri "PLUSCOMM**PLUSASSOC";ex();
ri "RIGHT@COMMPLUSID** $REALNAT";ex();

ri "PLUSCOMM** $BREAKMINUS";ex();
up();rri "EQUATION_TO_DIFFERENCE";ex();
ri "LEFT@ $REALNAT";ex();
ri "RIGHT@RIGHT@DIVTYPE";ex();
ri "RIGHT@ $REALNAT";ex();
ri "RIGHT@ $DIVTYPE";ex();
ri "EQSYMM";ex();
up();ri "CSYM";ex();
up();rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();

p "DIV_UNIQUE_3";


(*
DIV_UNIQUE_4:

(forall
   @ [((Nat : ?k) = ((Nat : ?q) * Nat : ?n) + Nat
         : ?1)
      & (Nat : ?1) < Nat : ?n])
-> ((Nat : ?k) / Nat : ?n) = Nat : ?q =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s
"(forall@[(((Nat:?k)=((Nat:?q)*Nat:?n)+Nat:?1)&(Nat:?1)<Nat:?n)])->((Nat:?k)/Nat:?n)=Nat:?q";
left();initializecounter();
rri "INSTANTIATE";ex();
assign "?x_1" "?n";
ri "LEFT@EVAL";ex();
left();right();rri "NOT_LEQ";ex();
ri "RIGHT@LEQ_REFL";ex();
rri "FDEF";ex();
up();ri "CZER";ex();
up();ri "CSYM**CZER";ex();
up();ri "3pt75";ex();

p "DIV_UNIQUE_4";




(* Since it is tough for me to prove this theorem, I will temporarily
declare it as an axiom, after I figure it out, I will remove it *)
(* The following is procedure of proof *)

(*
s
"forall@[((((Nat:?k)=((Nat:?q)*Nat:?n)+Nat:?1)&(Nat:?1)<Nat:?n))->((Nat:?k)/Nat:?n)=Nat:?q]"; 
ri "PCASEINTRO@0=Nat:?n";ex();
right();left();right();right();left();right();ri "RIGHT@ $0|-|1";ex();
ri "LESS_0_FALSE";ex();
up();ri "CZER";ex();
up();ri "3pt75";ex();
up();up();ri "FORALLDROP**AT";ex();
top();rri "NOT_EXP";ex();
left();ri "RIGHT@EQSYMM";ex();
rri "GREAT_NOT_EQ_0";ex();
up();ri "ODDCHOICE";ex();

right();left();rri "forallr2";ex();
ri "9pt3b";ex();
right();right();left();
ri "CSYM**TAB_AND";ex();
right();left();left();left();right();left();ri "LEFT@ $0|-|2";ex();
up();up();left();ri "REALNAT";ex();
initializecounter();
rri "TIMESINTDIV";ex();
assign "?y_1" "[Nat:?n]";
ri "PLUSCOMM";ex();
up();ri "ADD_CANCEL";ex();

ri "RIGHT@ $REALNAT";ex();
ri "LEFT@RIGHT@MODTYPE";ex();
ri "LEFT@ $REALNAT";ex();
ri "LEFT@ $MODTYPE";ex();
up();ri "TAB_AND";ex();
right();left();left();ri "LEFT@ $0|-|3";ex();

up();ri "ASRTCOND";ex();
left();rri "ILID";ex();
ri "LEFT@0|-|1";ex();
ri "MOD_LESS";ex();
up();ex();
up();up();rri "EQUATION";ex();
up();rri "EQUATION";ex();

up();up();up();ri "PCASEINTRO@((Nat:?k)%Nat:?n)=Nat:?1";ex();
right();left();left();right();left();ri "LEFT@0|-|2";ex();
ri "REFLEX";ex();
up();up();rri "EQUATION";ex();

up();right();rri "CRULE3";ex();
right();rri "ILID";ex();
ri "LEFT@0|-|1";ex();
ri "RIGHT@LEFT@ $0|-|2";ex();
ri "MOD_LESS";ex();
up();ri "CID";ex();
rri "ASRTEQ";ex();
ri "RIGHT@RIGHT@ $0|-|2";ex();
left();ri "REALNAT";ex();
initializecounter();
rri "TIMESINTDIV";ex();
assign "?y_1" "[Nat:?n]";
up();up();ri "RIGHT@PLUSCOMM";ex();
ri "ADD_CANCEL";ex();
ri "EQUATION_TO_DIFFERENCE";ex();
left();ri "BREAKMINUS";ex();
right();ri "MINUS_TIMESID";ex();
rri "TIMESASSOC";ex();
ri "LEFT@ $MINUS_TIMESID";ex();
up();rri "COMMDIST";ex();
up();ri "EQSYMM**FACTORZERO";ex();
right();ri "RIGHT@ $REALNAT";ex();
ri "ASRTEQ** $DUBNEG2";ex();
right();ri "RIGHT@EQSYMM";ex();
rri "GREAT_NOT_EQ_0";ex();
rri "0|-|1";ex();

up();rri "FDEF";ex();
up();ri "DID";ex();
rri "ASRTEQ";ex();
ri "EQSYMM";ex();
rri "REAL_MINUS_EQ_0";ex();
left();ri "RIGHT@ $BREAKMINUS";ex();
ri "SUBTRACT_DIFF";ex();
ri "PLUSCOMM**PLUSASSOC";ex();
ri "RIGHT@COMMPLUSID** $REALNAT";ex();
ri "PLUSCOMM** $BREAKMINUS";ex();
rri "EQUATION_TO_DIFFERENCE";ex();
ri "LEFT@ $REALNAT";ex();
right();ri "RIGHT@DIVTYPE";ex();
rri "REALNAT";ex();
rri "DIVTYPE";ex();
up();ri "EQSYMM";ex();
up();ri "BID";ex();

up();right();left();right();left();
ri "EQUATION**1|-|2";ex();
up();up();rri "CASEINTRO";ex();
up();ri "BSYM";ex();
ri "3pt15a";ex();

*)


(* I temporarily put axiom to "DIV_UNIQUE"(DIV_UNIQUE_3) *)

a "DIV_UNIQUE_1"
"(((Nat:?k)=((Nat:?q)*Nat:?n)+Nat:?r)&(Nat:?r)<Nat:?n)->((Nat:?k)/Nat:?n)=Nat:?q"
"true";

(* changed form begin ... *)

(*
DIV_UNIQUE:

forall
@ [forall
   @ [forall
      @ [forsome
         @ [(((Nat : ?2) = ((Nat : ?3) * Nat : ?1)
                  + Nat : ?4)
               & (Nat : ?4) < Nat : ?1)
            -> ((Nat : ?2) / Nat : ?1) = Nat : ?3]]]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","GREATER","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)
(*

s
"forall@[forall@[forall@[forsome@[(((Nat:?2)=((Nat:?3)*Nat:?1)+Nat:?4)&(Nat:?4)<Nat:?1)->((Nat:?2)/Nat:?1)=Nat:?3]]]]";
right();right();right();right();
ri "DIV_UNIQUE_1";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();

p "DIV_UNIQUE";

*)
(* 
MOD_UNIQUE_2:

forall
@ [forsome
   @ [(((Nat : ?y) = ((Nat : ?2) * Nat : ?x) + Nat
            : ?1)
         & (Nat : ?1) < Nat : ?x)
      -> ((Nat : ?y) % Nat : ?x) = Nat : ?1]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s
"forall@[forsome@[(((Nat:?y)=((Nat:?2)*Nat:?x)+Nat:?1)&(Nat:?1)<Nat:?x)->((Nat:?y)%Nat:?x)=Nat:?1]]";
ri "PCASEINTRO@0=Nat:?x";ex();
right();left();right();right();right();right();left();right();
ri "RIGHT@ $0|-|1";ex();
ri "LESS_0_FALSE";ex();
up();ri "CZER";ex();
up();ri "3pt75";ex();
up();up();ri "FORSOMEDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();
top();rri "NOT_EXP";ex();
ri "LEFT@RIGHT@EQSYMM";ex();
ri "LEFT@ $GREAT_NOT_EQ_0";ex();
ri "ODDCHOICE";ex();

right();left();right();right();ri "DINSTANTIATEF1@(Nat:?y)/Nat:?x";ex();
ri "LEFT@EVAL";ex();
up();up();ri "FORALLOR";ex();
left();right();right();rri "IRULE2";ex();
left();rri "ILID";ex();
left();initializecounter();
rri "DIVISION_2";ex();
assign "?n_1" "?x";
assign "?k_1" "?y";
ri "LEFT@ $0|-|1";ex();
ri "ILID**CRULE1**CSYM";ex();
up();rri "3pt65";ex();
right();ri "IMPTOCOND";ex();
right();right();left();left();
ri "LEFT@0|-|2";ex();
left();left();ri "LEFT@DIVTYPE";ex();
ri "EVERYWHERE@TYPES";ex();
up();ri "PLUSCOMM";ex();
up();rri "MINUS_FLIPADD";ex();
ri "RIGHT@SUB_REFL";ex();
rri "EQUATION_TO_DIFFERENCE";ex();
ri "RIGHT@ $REALNAT";ex();
left();ri "RIGHT@MODTYPE";ex();
rri "REALNAT";ex();
rri "MODTYPE";ex();

up();up();up();up();up();rri "IMPTOCOND";ex();
up();ri "3pt65";ex();
rri "IRULE2";ex();
left();rri "ILID";ex();
ri "LEFT@0|-|1";ex();
ri "RIGHT@CSYM";ex();
ri "DIVISION_2";ex();
up();ri "ILID**CRULE1";ex();
ri "CSYM";ex();
up();rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();up();ri "FORALLDROP**AT";ex();
up();ri "DSYM**DZER";ex();
up();up();rri "CASEINTRO";ex();

p "MOD_UNIQUE_2";


(*
MOD_UNIQUE:

forall
@ [forall
   @ [forall
      @ [forsome
         @ [(((Nat : ?1) = ((Nat : ?4) * Nat : ?2)
                  + Nat : ?3)
               & (Nat : ?3) < Nat : ?2)
            -> ((Nat : ?1) % Nat : ?2) = Nat : ?3]]]] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s
"forall@[forall@[forall@[forsome@[(((Nat:?1)=((Nat:?4)*Nat:?2)+Nat:?3)&(Nat:?3)<Nat:?2)->((Nat:?1)%Nat:?2)=Nat:?3]]]]";
right();right();right();right();ri "MOD_UNIQUE_2";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();ri "FORALLDROP**AT";ex();

p "MOD_UNIQUE";


(*
MOD_UNIQUE_1:

forsome
@ [(((Nat : ?x) = ((Nat : ?1) * Nat : ?y) + Nat
         : ?z)
      & (Nat : ?z) < Nat : ?y)
   -> ((Nat : ?x) % Nat : ?y) = Nat : ?z] =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","GREATER","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODDEF","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s
"forsome@[(((Nat:?x)=((Nat:?1)*Nat:?y)+Nat:?z)&(Nat:?z)<Nat:?y)->((Nat:?x)%Nat:?y)=Nat:?z]";
ri "FORSOMEBOOL**ASSERT2";ex();
rri "CID";ex();
right();initializecounter();
rri "MOD_UNIQUE_2";ex();
assign "?x_1" "?y";
assign "?y_1" "?x";
up();ri "LEFT@BIND@?z";ex();
ri "INSTANTIATE";ex();
ri "MOD_UNIQUE_2";ex();

p "MOD_UNIQUE_4";
	

(*Likewise, I change the form of "MOD_UNIQUE" in order to apply
"DIVISION_2" *)
(*
MOD_UNIQUE:

(((Nat : ?k)
      = (((Nat : ?k) / Nat : ?n) * Nat : ?n) + Nat
      : ?r)
   & (Nat : ?r) < Nat : ?n)
-> ((Nat : ?k) % Nat : ?n) = Nat : ?r =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s
"(((Nat:?k)=(((Nat:?k)/Nat:?n)*Nat:?n)+Nat:?r)&(Nat:?r)<Nat:?n)->((Nat:?k)%Nat:?n)=Nat:?r";
ri "PCASEINTRO@0=Nat:?n";ex();
right();left();left();right();ri "RIGHT@ $0|-|1";ex();
ri "LEFT@MODTYPE";ex();
ri "LESS_0_FALSE";ex();
up();ri "CZER";ex();
up();ri "3pt75";ex();
up();up();rri "NOT_EXP";ex();
left();ri "RIGHT@EQSYMM";ex();
rri "GREAT_NOT_EQ_0";ex();
up();ri "ODDCHOICE";ex();

right();left();rri "IRULE1";ex();
rri "ILID";ex();
left();initializecounter(); (* here I can use "DIVISION_2" *)
rri "DIVISION_2";ex();
assign "?n_1" "?n";
assign "?k_1" "?k";
ri "LEFT@ $0|-|1";ex();
ri "ILID**CRULE1";ex();
ri "CSYM";ex();
up();rri "3pt65";ex();
right();ri "IMPTOCOND";ex();
right();right();left();left();left();ri "LEFT@0|-|2";ex();

ri "LEFT@PLUSCOMM";ex();
rri "MINUS_FLIPADD";ex();
ri "RIGHT@SUB_REFL";ex();
rri "EQUATION_TO_DIFFERENCE";ex();
ri "RIGHT@ $REALNAT";ex();
ri "LEFT@RIGHT@MODTYPE";ex();
ri "LEFT@ $REALNAT";ex();
ri "LEFT@ $MODTYPE";ex();
up();ri "CSYM";ex();
up();rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();

rp "MOD_UNIQUE";



(* following three theorem are used for proof of "DIV_MULT_1" *)
(*
POS_0_MULT_GEQ:

((Nat : ?x) > 0) -> ((Nat : ?x) * Nat : ?y) >= Nat
: ?y =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"
*)

s "((Nat:?x)>0)->((Nat:?x)*Nat:?y)>=Nat:?y";
left();ri "GREATER";ex();
ri "LEFT@ZERONAT";ex();
ri "LESS_MONO_EQ";ex();
left();ri "RIGHT@ $ZERONAT";ex();
ri "COMMPLUSID**REALNUMERAL2**ONENAT";ex();
up();ri "LESS_THM**DSYM** $LESS_OR_EQ";ex();
up();ri "RIGHT@LEFT@TIMESTYPE2";ex();
ri "RIGHT@GREATER_EQ";ex();
ri "RIGHT@LEFT@REALNAT** $TIMESID";ex();
ri "RIGHT@LEFT@LEFT@ONENAT";ex();
ri "RIGHT@RIGHT@ $TIMESTYPE2";ex();
ri "LESS_MONO_MULT";ex();

p "POS_0_MULT_GEQ";


(*
LEQ_LEQ_ADD:

((Nat : ?x) =< Nat : ?y) -> (Nat : ?x)
=< (Nat : ?y) + Nat : ?z =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?x)=<Nat:?y)->(Nat:?x)=<(Nat:?y)+Nat:?z";
rri "IRULE2";ex();
left();rri "CID";ex();
right();initializecounter();
rri "ALL_GEQ_0";ex();
assign "?x_1" "?z";
ri "LEFT@ZERONAT";ex();
up();up();right();ri "LEFT@REALNAT** $COMMPLUSID";ex();
ri "LEFT@RIGHT@ZERONAT";ex();
top();ri "LEQ_LEQ_MONO";ex();

p "LEQ_LEQ_ADD";


(*
POS_0_MULT_ADD_GEQ:

((Nat : ?x) > 0)
-> (((Nat : ?x) * Nat : ?y) + Nat : ?z) >= Nat
: ?y =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?x)>0)->(((Nat:?x)*Nat:?y)+Nat:?z)>=Nat:?y";
rri "IRULE1";ex();
rri "ILID";ex();
rri "IRULE2";ex();
left();rri "CID";ex();
left();initializecounter();
rri "POS_0_MULT_GEQ";ex();
assign "?x_1" "?x";
assign "?y_1" "?y";
up();right();initializecounter();
rri "LEQ_LEQ_ADD";ex();
assign "?x_1" "?y";
assign "?y_1" "(Nat:?x)*Nat:?y";
assign "?z_1" "?z";
ri "EVERYWHERE@PLUSTYPE2";ex();
ri "EVERYWHERE@ $GREATER_EQ";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $TIMESTYPE2";ex();
top();ri "3pt82a";ex();

p "POS_0_MULT_ADD_GEQ";

(*

(* The following theorem is used for the next following theorem
"DIV_MULT",thisis also simple form *)
(*
DIV_MULT_1:

((Nat : ?m) < Nat : ?n)
-> ((((Nat : ?p) * Nat : ?n) + Nat : ?m) / Nat
   : ?n) = Nat : ?p =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVDEF1","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?m)<Nat:?n)->((((Nat:?p)*Nat:?n)+Nat:?m)/Nat:?n)=Nat:?p";
ri "PCASEINTRO@(Nat:?p)=0";ex();
right();left();ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();ri "EVERYWHERE@0|-|1";ex();
left();left();ri "LEFT@TIMESZERO";ex();
ri "PLUSID** $REALNAT";ex();
up();initializecounter();
ri "DIVDEF1";ex();
assign "?z_1" "0";
right();left();rri "ZERONAT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "REFLEX";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();up();rri "NOT_EXP";ex();
ri "LEFT@ $GREAT_NOT_EQ_0";ex();
ri "LEFT@ $GREATER";ex();
ri "ODDCHOICE";ex();
right();left();ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();left();left();
ri "(LEFT@TIMESTYPE2)**PLUSTYPE2";ex();
up();initializecounter();
ri "DIVDEF1";ex();
assign "?z_1" "?p";
assign "?w_1" "?m";

left();rri "CRULE2";ex();
left();rri "ILID";ex();
ri "LEFT@0|-|1";ex();
right();ri "LEFT@ $PLUSTYPE2";ex();
ri "LEFT@LEFT@ $TIMESTYPE2";ex();
up();ri "POS_0_MULT_ADD_GEQ";ex();
up();ri "CSYM**CID**CRULE1";ex();
left();ri "LEFT@ $PLUSTYPE2";ex();
ri "LEFT@LEFT@ $TIMESTYPE2";ex();
ri "REFLEX";ex();
up();ri "RIGHT@ $0|-|2";ex();
ri "CID**AT";ex();
up();ex();
up();ri "REFLEX";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();
up();up();rri "CASEINTRO";ex();

p "DIV_MULT_1";

*)


(* ... changed form end *)



(*
MOD_UNIQUE:

(((Nat : ?k) = ((Nat : ?q) * Nat : ?n) + Nat : ?r)
   & (Nat : ?r) < Nat : ?n)
-> ((Nat : ?k) % Nat : ?n) = Nat : ?r =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVTYPE","DIV_UNIQUE_3","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESINTDIV","TIMESTYPE","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)


(* Holmes's attempt at this *)
(* s
"(((Nat:?k)=(((Nat:?q)*Nat:?n)+Nat:?r))&(Nat:?r)<Nat:?n)->((Nat:?k)%Nat:?n)=Nat:?r";
left(); left(); right(); left(); left();
initializecounter();
rri "TIMESINTDIV"; ex();
assign "?y_1" "Nat:?n";
ri "EVERYWHERE@TYPES"; ex();
*)
s
"(((Nat:?k)=(((Nat:?q)*Nat:?n)+Nat:?r))&(Nat:?r)<Nat:?n)->((Nat:?k)%Nat:?n)=Nat:?r";
ri "PCASEINTRO@0=Nat:?n";ex();
right();left();left();right();ri "RIGHT@ $0|-|1";ex();
ri "LEFT@MODTYPE";ex();
ri "LESS_0_FALSE";ex();
up();ri "CZER";ex();
up();ri "3pt75";ex();
up();up();rri "NOT_EXP";ex();
left();ri "RIGHT@EQSYMM";ex();
rri "GREAT_NOT_EQ_0";ex();
up();ri "ODDCHOICE";ex();

right();left();right();ri "RIGHT@REALNAT";ex();
ri "LEFT@MODTYPE**REALNAT";ex();
initializecounter();
rri "ADD_CANCEL";ex();
assign "?z_1" "((Nat:?k)/Nat:?n)*Nat:?n";
left();ri "RIGHT@ $MODTYPE";ex();
(* ri "PLUSCOMM**TIMESINTDIV** $REALNAT";ex(); *)
ri "PLUSCOMM"; ex();
ri "RIGHT@RIGHT@ $TYPES"; ex();

ri "TIMESINTDIV"; ex();
ri "TYPES"; ex();
up();up();ri "IMPTOCOND";ex();
right();ri "AND_EXP";ex();
right();left();right();left();
ri "LEFT@0|-|2";ex();

ri "LEFT@PLUSCOMM";ex();
rri "MINUS_FLIPADD";ex();
ri "LEFT@SUB_REFL";ex();
right();ri "BREAKMINUS";ex();
right();ri "MINUS_TIMESID";ex();
rri "TIMESASSOC";ex();
ri "LEFT@ $MINUS_TIMESID";ex();
up();rri "COMMDIST";ex();
ri "LEFT@ $BREAKMINUS";ex();
up();ri "FACTORZERO";ex();

right();ri "RIGHT@ $REALNAT";ex();
ri "ASRTEQ";ex();
rri "DUBNEG2";ex();
right();ri "RIGHT@EQSYMM";ex();
rri "GREAT_NOT_EQ_0";ex();
rri "0|-|1";ex();
up();rri "FDEF";ex();
up();ri "DID";ex();
rri "ASRTEQ";ex();

ri "EQSYMM";ex();
rri "REAL_MINUS_EQ_0";ex();
left();ri "SUBTRACT_DIFF";ex();
ri "PLUSCOMM**PLUSASSOC";ex();
ri "RIGHT@COMMPLUSID** $REALNAT";ex();
ri "PLUSCOMM** $BREAKMINUS";ex();
up();rri "EQUATION_TO_DIFFERENCE";ex();
ri "LEFT@ $REALNAT";ex();
ri "RIGHT@RIGHT@DIVTYPE";ex();
ri "RIGHT@ ($REALNAT)** $DIVTYPE";ex();
ri "EQSYMM";ex();
up();up();up();up();rri "AND_EXP";ex();
up();rri "IMPTOCOND";ex();
ri "DIV_UNIQUE_1";ex();(* This has to be proved *)
up();up();rri "CASEINTRO";ex();

rp "MOD_UNIQUE";

(*

(* following three theorem are used for proof of "DIV_MULT_1" *)
(*
POS_0_MULT_GEQ:

((Nat : ?x) > 0) -> ((Nat : ?x) * Nat : ?y) >= Nat
: ?y =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"
*)

s "((Nat:?x)>0)->((Nat:?x)*Nat:?y)>=Nat:?y";
left();ri "GREATER";ex();
ri "LEFT@ZERONAT";ex();
ri "LESS_MONO_EQ";ex();
left();ri "RIGHT@ $ZERONAT";ex();
ri "COMMPLUSID**REALNUMERAL2**ONENAT";ex();
up();ri "LESS_THM**DSYM** $LESS_OR_EQ";ex();
up();ri "RIGHT@LEFT@TIMESTYPE2";ex();
ri "RIGHT@GREATER_EQ";ex();
ri "RIGHT@LEFT@REALNAT** $TIMESID";ex();
ri "RIGHT@LEFT@LEFT@ONENAT";ex();
ri "RIGHT@RIGHT@ $TIMESTYPE2";ex();
ri "LESS_MONO_MULT";ex();

p "POS_0_MULT_GEQ";


(*
LEQ_LEQ_ADD:

((Nat : ?x) =< Nat : ?y) -> (Nat : ?x)
=< (Nat : ?y) + Nat : ?z =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?x)=<Nat:?y)->(Nat:?x)=<(Nat:?y)+Nat:?z";
rri "IRULE2";ex();
left();rri "CID";ex();
right();initializecounter();
rri "ALL_GEQ_0";ex();
assign "?x_1" "?z";
ri "LEFT@ZERONAT";ex();
up();up();right();ri "LEFT@REALNAT** $COMMPLUSID";ex();
ri "LEFT@RIGHT@ZERONAT";ex();
top();ri "LEQ_LEQ_MONO";ex();

p "LEQ_LEQ_ADD";


(*
POS_0_MULT_ADD_GEQ:

((Nat : ?x) > 0)
-> (((Nat : ?x) * Nat : ?y) + Nat : ?z) >= Nat
: ?y =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?x)>0)->(((Nat:?x)*Nat:?y)+Nat:?z)>=Nat:?y";
rri "IRULE1";ex();
rri "ILID";ex();
rri "IRULE2";ex();
left();rri "CID";ex();
left();initializecounter();
rri "POS_0_MULT_GEQ";ex();
assign "?x_1" "?x";
assign "?y_1" "?y";
up();right();initializecounter();
rri "LEQ_LEQ_ADD";ex();
assign "?x_1" "?y";
assign "?y_1" "(Nat:?x)*Nat:?y";
assign "?z_1" "?z";
ri "EVERYWHERE@PLUSTYPE2";ex();
ri "EVERYWHERE@ $GREATER_EQ";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $TIMESTYPE2";ex();
top();ri "3pt82a";ex();

p "POS_0_MULT_ADD_GEQ";

*)

(*
DIV_MULT:

((Nat : ?r) < Nat : ?n)
-> ((((Nat : ?q) * Nat : ?n) + Nat : ?r) / Nat
   : ?n) = Nat : ?q =

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","DIV_UNIQUE_3","EQUATION","IF","IFF","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE2","REFLEX","TIMESTYPE2","TYPES","XOR"]
*)

s "((Nat:?r)<Nat:?n)->((((Nat:?q)*Nat:?n)+Nat:?r)/Nat:?n)=Nat:?q";
rri "IRULE3";ex();
right();rri "ILID";ex();
left();initializecounter();
rri "DIV_UNIQUE_1";ex();
assign "?n_1" "?n";
assign "?q_1" "?q";
assign "?r_1" "?r";
assign "?k_1" "((Nat:?q)*Nat:?n)+Nat:?r";
left();left();left();ri "RIGHT@LEFT@TIMESTYPE2";ex();
rri "PLUSTYPE2";ex();
ri "LEFT@ $TIMESTYPE2";ex();
up();ri "REFLEX";ex();
up();ri "CSYM**CID";ex();
up();ri "IRULE2";ex();
top();ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();ri "LEFT@LEFT@ $0|-|1";ex();
ri "LEFT@ILID";ex();
ri "IRULE2";ex();
left();left();ri "LEFT@RIGHT@LEFT@TIMESTYPE2";ex();
ri "LEFT@ $PLUSTYPE2";ex();
ri "LEFT@LEFT@ $TIMESTYPE2";ex();
up();up();ri "IREF";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "DIV_MULT";


(*
LESS_DIV:

((Nat : ?k) < Nat : ?n) -> ((Nat : ?k) / Nat : ?n)
= 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVTYPE","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESCOMM","TIMESID","TIMESINTDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?k)<Nat:?n)->((Nat:?k)/Nat:?n)=0";
ri "PCASEINTRO@((Nat:?k)/Nat:?n)=0";ex();
right();left();right();ri "RIGHT@ $0|-|1";ex();
ri "REFLEX";ex();
up();ri "IRZER";ex();
top();rri "NOT_EXP";ex();
left();ri "RIGHT@LEFT@DIVTYPE";ex();
rri "GREAT_NOT_EQ_0";ex();
rri "GREATER";ex();
up();ri "ODDCHOICE";ex();

right();left();rri "IRULE2";ex();
left();rri "CID";ex();
right();initializecounter();
rri "POS_0_MULT_ADD_GEQ";ex();
assign "?x_1" "(Nat:Nat:?k)/Nat:Nat:?n";
assign "?y_1" "?n";
assign "?z_1" "(Nat:Nat:?k)%Nat:Nat:?n";
ri "LEFT@ $0|-|1";ex();
ri "ILID";ex();
right();left();ri "EVERYWHERE@ ($MODTYPE)** $DIVTYPE";ex();
ri "PLUSCOMM**(RIGHT@RIGHT@ $TYPES)**TIMESINTDIV**TYPES";ex();
up();up();up();ri "CRULE3";ex();
ri "RIGHT@GREATER_EQ** $NOT_GREATER";ex();
ri "LEFT@ $GREATER";ex();
ri "CCON";ex();
up();ri "3pt75";ex();
up();up();rri "CASEINTRO";ex();

p "LESS_DIV";


(*
LESS_MOD:

((Nat : ?k) < Nat : ?n) -> ((Nat : ?k) % Nat : ?n)
= Nat : ?k =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVTYPE","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESINTDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?k)<Nat:?n)->((Nat:?k)%Nat:?n)=Nat:?k";
ri "PCASEINTRO@0=Nat:?n";ex();
right();left();left();ri "RIGHT@ $0|-|1";ex();
ri "LESS_0_FALSE";ex();
up();ri "3pt75";ex();
top();rri "NOT_EXP";ex();
ri "LEFT@RIGHT@EQSYMM";ex();
ri "LEFT@ $GREAT_NOT_EQ_0";ex();
ri "ODDCHOICE";ex();

right();left();right();right();
initializecounter();
rri "TIMESINTDIV";ex();
assign "?y_1" "Nat:?n";
up();left();ri "MODTYPE";ex();
ri "REALNAT** $COMMPLUSID";ex();
ri "LEFT@ $MODTYPE";ex();
up();ri "RIGHT@LEFT@TADDLEFT@MODTYPE"; ri "ADD_CANCEL";ex();
ri "LEFT@REALNUMERAL2";ex();
ri "RIGHT@RIGHT@LEFT@DIVTYPE";ex();
ri "RIGHT@RIGHT@TIMESTYPE2";ex();
ri "RIGHT@ ($REALNAT)** $TIMESTYPE2";ex();
ri "FACTORZERO";ex();
right();ri "RIGHT@ $REALNAT";ex();
ri "ASRTEQ";ex();
rri "DUBNEG2";ex();
right();ri "RIGHT@EQSYMM";ex();
rri "GREAT_NOT_EQ_0";ex();
ri "RIGHT@TYPES";
rri "0|-|1";ex();
up();rri "FDEF";ex();
up();ri "DID";ex();
rri "ASRTEQ";ex();
ri "RIGHT@ ($REALNAT)** $DIVTYPE";ex();
ri "EQSYMM";ex();
ri "LEFT@TADDLEFT@DIVTYPE"; ex();
up();ri "LESS_DIV";ex();
up();up();rri "CASEINTRO";ex();

p "LESS_MOD";



(*
ZERO_MOD:

(0 < Nat : ?n) -> (0 % Nat : ?n) = 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIVISION","DIVTYPE","EQUATION","IF","IFF","INDUCTION","LESSTYPE","MODTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMP","PLUSID","PLUSTYPE","PLUSTYPE2","REFLEX","SUCCNOTZERO","TIMESTYPE","TIMESTYPE2","TYPES","XOR","forall"]
*)

s "(0<Nat:?n)->(0%Nat:?n)=0";
rri "IRULE3";ex();
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();rri "ILID";ex();
left();initializecounter();
rri "DIVISION_2";ex();
assign "?n_1" "?n";
assign "?k_1" "0";
ri "LEFT@ $0|-|1";ex();
ri "ILID";ex();
ri "CRULE1";ex();
left();ri "(LEFT@ $ZERONAT)**EQSYMM";ex();
left();ri "EVERYWHERE@MODTYPE**DIVTYPE**TIMESTYPE2";ex();
up();ri "ADD_BOTH_0";ex();
right();ri "LEFT@ $MODTYPE";ex();
ri "LEFT@LEFT@ $ZERONAT";ex();
up();ri "CSYM";ex();
up();ri "CASSOC**CSYM";ex();
up();rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "ZERO_MOD";


(*
ZERO_DIV:

(0 < Nat : ?n) -> (0 / Nat : ?n) = 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "(0<Nat:?n)->(0/Nat:?n)=0";
rri "IRULE3";ex();
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();rri "ILID";ex();
left();initializecounter();
rri "DIVISION_2";ex();
assign "?n_1" "?n";
assign "?k_1" "0";
ri "LEFT@ $0|-|1";ex();
ri "ILID";ex();
ri "CRULE1";ex();
left();ri "(LEFT@ $ZERONAT)**EQSYMM";ex();
left();ri "EVERYWHERE@MODTYPE**DIVTYPE**TIMESTYPE2";ex();
up();ri "ADD_BOTH_0";ex();

left();ri "EQSYMM";ex();
ri "(RIGHT@ $TIMESTYPE2)**FACTORZERO";ex();
right();ri "RIGHT@ $REALNAT";ex();
ri "ASRTEQ";ex();
rri "DUBNEG2";ex();
right();ri "RIGHT@EQSYMM";ex();
rri "GREAT_NOT_EQ_0";ex();
rri "0|-|1";ex();
up();rri "FDEF";ex();
up();ri "DID";ex();
rri "ASRTEQ";ex();
ri "RIGHT@ ($REALNAT)** $DIVTYPE";ex();
ri "RIGHT@LEFT@ $ZERONAT";ex();
ri "EQSYMM";ex();
up();up();ri "CASSOC**CSYM";ex();
up();rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "ZERO_DIV";


(*
MOD_MULT:

((Nat : ?r) < Nat : ?n)
-> ((((Nat : ?q) * Nat : ?n) + Nat : ?r) % Nat
   : ?n) = Nat : ?r =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVTYPE","DIV_UNIQUE_3","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESINTDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "((Nat:?r)<Nat:?n)->((((Nat:?q)*Nat:?n)+Nat:?r)%Nat:?n)=Nat:?r";
rri "IRULE3";ex();
right();rri "ILID";ex();
left();initializecounter();
rri "MOD_UNIQUE";ex();
assign "?n_1" "?n";
assign "?q_1" "?q";
assign "?r_1" "?r";
assign "?k_1" "((Nat:?q)*Nat:?n)+Nat:?r";
left();left();left();ri "RIGHT@LEFT@TIMESTYPE2";ex();
rri "PLUSTYPE2";ex();
ri "LEFT@ $TIMESTYPE2";ex();
up();ri "REFLEX";ex();
up();ri "CSYM**CID";ex();
up();ri "IRULE2";ex();
top();ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();ri "LEFT@LEFT@ $0|-|1";ex();
ri "LEFT@ILID";ex();
ri "IRULE2";ex();
left();left();ri "LEFT@RIGHT@LEFT@TIMESTYPE2";ex();
ri "LEFT@ $PLUSTYPE2";ex();
ri "LEFT@LEFT@ $TIMESTYPE2";ex();
up();up();ri "IREF";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "MOD_MULT";


(*
MOD_EQ_0:

(0 < Nat : ?n)
-> (((Nat : ?q) * Nat : ?n) % Nat : ?n) = 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVTYPE","DIV_UNIQUE_3","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESINTDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "(0<Nat:?n)->(((Nat:?q)*Nat:?n)%Nat:?n)=0";
rri "IRULE3";ex();
ri "IMPTOCOND";ex();
right();ri "ODDCHOICE";ex();
right();left();rri "ILID";ex();
left();initializecounter();
rri "MOD_MULT";ex();
assign "?k_1" "?k";
assign "?n_1" "?n";
assign "?q_1" "?q";
assign "?r_1" "0";
ri "LEFT@LEFT@ $ZERONAT";ex();
ri "LEFT@ $0|-|1";ex();
ri "ILID";ex();
rri "ASRTEQ";ex();
ri "RIGHT@ $ZERONAT";ex();
left();left();ri "RIGHT@ $ZERONAT";ex();
ri "LEFT@TIMESTYPE2";ex();
ri "COMMPLUSID** $REALNAT";ex();
rri "TIMESTYPE2";ex();
up();up();up();ri "IREF";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "MOD_EQ_0";


(*
DIV_TIMES:

(0 < Nat : ?n)
-> ((((Nat : ?q) * Nat : ?n) + Nat : ?r) / Nat
   : ?n) = (Nat : ?q) + (Nat : ?r) / Nat : ?n =

(0 < Nat : ?n) -> true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","DIV_UNIQUE_3","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESINTDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s
"(0<Nat:?n)->((((Nat:?q)*Nat:?n)+Nat:?r)/Nat:?n)=(Nat:?q)+(Nat:?r)/Nat:?n";
rri "IRULE2";ex();
left();rri "CID";ex();
right();initializecounter();
rri "MOD_LESS";ex();
assign "?n_1" "?n";
assign "?k_1" "?r";
up();ri "3pt66";ex();
up();rri "3pt65";ex();
right();right();left();left();right();
initializecounter();rri "TIMESINTDIV";ex();
assign "?y_1" "Nat:?n";
ri "RIGHT@RIGHT@TYPES"; ri "EVERYWHERE@TADDLEFT@DIVTYPE";
ri "EVERYWHERE@TADDLEFT@MODTYPE";ex();
ri "PLUSCOMM";ex();
up();rri "PLUSASSOC";ex();
ri "LEFT@ $COMMDIST";ex();
ri "RIGHT@MODTYPE";ex();
left();left();ri "(RIGHT@DIVTYPE)**PLUSTYPE2";ex();
up();up();up();up();right();ri "(RIGHT@DIVTYPE)**PLUSTYPE2";ex();
up();up();ri "LEFT@LEFT@MODTYPE";ex();
ri "DIV_MULT";ex();up();
ri "IRZER";ex();

p "DIV_TIMES";


(*
MOD_TIMES:

(0 < Nat : ?n)
-> ((((Nat : ?q) * Nat : ?n) + Nat : ?r) % Nat
   : ?n) = (Nat : ?r) % Nat : ?n =

(0 < Nat : ?n) -> true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","DIV_UNIQUE_3","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESINTDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "(0<Nat:?n)->((((Nat:?q)*Nat:?n)+Nat:?r)%Nat:?n)=(Nat:?r)%Nat:?n";
rri "IRULE2";ex();
left();rri "CID";ex();
right();initializecounter();
rri "MOD_LESS";ex();
assign "?n_1" "?n";
assign "?k_1" "?r";
up();ri "3pt66";ex();
up();rri "3pt65";ex();
right();right();left();left();right();
initializecounter();rri "TIMESINTDIV";ex();
assign "?y_1" "Nat:?n";
ri "RIGHT@RIGHT@TYPES"; ri "EVERYWHERE@TADDLEFT@DIVTYPE";
ri "EVERYWHERE@TADDLEFT@MODTYPE"; ex();
ri "PLUSCOMM";ex();
up();rri "PLUSASSOC";ex();
ri "LEFT@ $COMMDIST";ex();
ri "RIGHT@MODTYPE";ex();
left();left();ri "(RIGHT@DIVTYPE)**PLUSTYPE2";ex();
up();up();up();up();ri "RIGHT@MODTYPE";ex();
up();ri "LEFT@LEFT@MODTYPE";ex();
ri "MOD_MULT";ex();
up();ri "IRZER";ex();

p "MOD_TIMES";



(*
MOD_PLUS:

(0 < Nat : ?n)
-> ((((Nat : ?j) % Nat : ?n) + (Nat : ?k) % Nat
      : ?n)
   % Nat : ?n) = ((Nat : ?j) + Nat : ?k) % Nat
: ?n =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","DIV_UNIQUE_3","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","SUCCNOTZERO","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESINTDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "true";
initializecounter();
rri "MOD_TIMES";ex();
assign "?n_1" "?n";
assign "?r_1" "((Nat:?j)%Nat:?n)+(Nat:?k)%Nat:?n";
assign "?q_1" "((Nat:?j)/Nat:?n)+(Nat:?k)/Nat:?n";
right();right();left();right();ri "RL@MODTYPE";ex();
up();rri "PLUSTYPE2";ex();
ri "RL@ $MODTYPE";ex();
up();up();ri "EQSYMM";ex();
right();left();right();right();ri "RL@MODTYPE";ex();
up();rri "PLUSTYPE2";ex();
ri "RL@ $MODTYPE";ex();
up();left();left();right();ri "RL@DIVTYPE";ex();
up();rri "PLUSTYPE2";ex();
ri "RL@ $DIVTYPE";ex();
up();ri "COMMDIST";ex();
up();rri "PLUSASSOC";ex();
left();ri "PLUSCOMM** $PLUSASSOC";ex();
left(); ri "RIGHT@RIGHT@ $TYPES"; ri "TIMESINTDIV"; ri "TYPES"; ex(); up();
up();ri "PLUSASSOC";ex();
right(); ri "PLUSCOMM"; 
ri "RIGHT@RIGHT@ $TYPES"; ri "TIMESINTDIV"; ri "TYPES"; ex(); up();
wb();

p "MOD_PLUS";



(*
MOD_MOD:

(0 < Nat : ?n)
-> (((Nat : ?k) % Nat : ?n) % Nat : ?n)
= (Nat : ?k) % Nat : ?n =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","DIVISION","DIVTYPE","EQUATION","GREATER","GREATER_EQ_REAL","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","MODTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REALDIVTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESID","TIMESINTDIV","TIMESTYPE","TIMESTYPE2","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "(0<Nat:?n)->(((Nat:?k)%Nat:?n)%Nat:?n)=(Nat:?k)%Nat:?n";
rri "IRULE2";ex();
left();rri "CID";ex();
right();initializecounter();
rri "MOD_LESS";ex();
assign "?n_1" "?n";
assign "?k_1" "?k";
up();ri "3pt66";ex();
up();rri "3pt65";ex();
right();left();ri "LEFT@MODTYPE";ex();
up();right();ri "RIGHT@MODTYPE";ex();
ri "LEFT@LEFT@MODTYPE";ex();
up();ri "LESS_MOD";ex();
up();ri "IRZER";ex();

p "MOD_MOD";



quit();


quit();