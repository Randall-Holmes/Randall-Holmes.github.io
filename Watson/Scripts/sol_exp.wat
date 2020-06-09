(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	Author: Sol Espinosa
	Date:   7/13/98
	Exponentiation

 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

declareconstant "exp";

axiom "EXP0" "exp@?m,0" "1";
axiom "EXP" "exp@?m,1+Nat:?n" "(Nat:?m) * exp@?m,?n";

axiom "EXPTYPE" "exp@?m,?n" "exp@(Nat:?m),Nat:?n";
axiom "EXPTYPE2" "exp@?m,?n" "Nat:exp@?m,?n";


(* to simplify my proofs a little I define two simple tactics:

 NATSUC will convert something of the form (1 + Nat:?x) into something 
 of the form:  Nat: (Nat:1) + Nat:?x 

 INV_NATSUC does the inverse.

*) 
                             
s "1+Nat:?x";
ri "LEFT@ONENAT";
ri "PLUSTYPE2";

p "NATSUC";

s "Nat:(Nat:1)+Nat:?x";
rri "PLUSTYPE2";
ri "LEFT@ $ONENAT";

p "INV_NATSUC";
 

(* I need the following lemmas - they should be in another file *)

(* _______________________________________________________________
	MULT_SUC_EQ:
	-----------
	((1 + Nat : ?z) * Nat : ?p) = (1 + Nat : ?z) * Nat : ?q =

	(Nat : ?p) = Nat : ?q
   _______________________________________________________________ *)

s "((1+Nat:?z)*Nat:?p)=(1+Nat:?z)*Nat:?q";
(* set up for induction proof *)
ri "PCASEINTRO@forall@[forall@[(((1+Nat:?z)*Nat:?1)=(1+Nat:?z)*Nat:?2) = (Nat:?1)=Nat:?2]]";ex();
ri "LEFT@forall"; ex();
right(); left();
ri "PCASEINTRO@forall@[(((1+Nat:?z)*Nat:?p)=(1+Nat:?z)*Nat:?1) = (Nat:?p)=Nat:?1]";ex();
ri "LEFT@forall"; ex();
right(); left();
ri "PCASEINTRO@(((1+Nat:?z)*Nat:?p)=(1+Nat:?z)*Nat:?q) = (Nat:?p)=Nat:?q";ex();
right(); left(); ri "0|-|3"; ex();
up();up();left();
ri "BIND@?q"; ri "LEFT@0|-|2"; ri "EVAL"; ex();
up(); ex();
up(); up(); left(); rri "forall"; ri "BIND@?p";
ri "LEFT@0|-|1"; ri "EVAL"; ex();
up(); ex(); up(); up(); left(); rri "forall"; ex();

(* the induction proof starts here *)

ri "INDUCT_TAC";ex();
left(); right(); right();
left(); ri "LEFT@TIMESCOMM**TIMESZERO";ex();
ri "FACTORZERO";ex();
left(); right(); ri "RIGHT@NATSUC";ex();
rri "REALNAT";ex();
ri "INV_NATSUC";ex();
up(); ri "SUCCNOTZERO";ex();
up(); ri "DSYM**DID";ex();
rri "ASRTEQ";ex();
ri "RIGHT@ $REALNAT";ex();
up(); ri "REFLEX";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); right(); right(); right();
ri "RL@INDUCT_TAC";ex();
left(); left(); left(); ri "RIGHT@TIMESCOMM**TIMESZERO";ex();
ri "EQSYMM**FACTORZERO";ex();
left(); right(); ri "RIGHT@NATSUC";ex();
rri "REALNAT";ex();
ri "INV_NATSUC";ex();
up(); ri "SUCCNOTZERO";ex();
up(); ri "DSYM**DID";ex();
rri "ASRTEQ";ex();
ri "RIGHT@ $REALNAT";ex();
up(); ri "(RIGHT@EQSYMM)**REFLEX";ex();
up(); ri "CSYM**CID";ex();
up(); ri "IRULE2";ex();
ri "IMPTOCOND";ex();
right(); ri "LEFT@forall";ex();
right(); left();
left(); left(); ri "RIGHT@TIMESCOMM**TIMESZERO";ex();
ri "LEFT@RL@NATSUC";ex();
ri "EQSYMM**FACTORZERO";ex();
ri "RL@RIGHT@ $REALNAT";ex();
ri "RL@RIGHT@INV_NATSUC";ex();
ri "RL@SUCCNOTZERO";ex();
ri "DID**AF";ex();
up(); ri "RIGHT@EQSYMM**SUCCNOTZERO";ex();
ri "REFLEX";ex();
up(); right(); 
ri "INDUCT_TAC";ex();
left(); right(); ri "RIGHT@(RIGHT@RIGHT@ZERONAT)** $SAMESUCC";ex();
ri "RIGHT@RIGHT@ $ZERONAT";ex();
left(); ri "RL@DIST";ex();
ri "RIGHT@RIGHT@TIMESCOMM**TIMESZERO";ex();
ri "ADD_CANCEL";ex();
ri "RIGHT@ $REALZERO";ex();
left(); right();
ri "LEFT@NATSUC";ex();
ri "TIMESTYPE2";ex();
up(); rri "REALNAT";ex();
rri "TIMESTYPE2";ex();
up(); ri "EQSYMM**FACTORZERO";ex();
ri "RL@RIGHT@ $REALNAT";ex();
ri "LEFT@(RIGHT@INV_NATSUC)**SUCCNOTZERO";ex();
ri "DSYM**DID** $ASRTEQ";ex();
up(); ri "(RIGHT@EQSYMM)**REFLEX";ex();
up(); ri "IRZER";ex();
up(); right(); right(); right();
right(); left(); ri "RIGHT@ $SAMESUCC";ex();
left(); ri "RL@DIST";ex();
ri "ADD_CANCEL";ex();
ri "RL@RIGHT@(LEFT@NATSUC)**TIMESTYPE2";ex();
ri "RL@ ($REALNAT)** $TIMESTYPE2";ex();
ri "RL@LEFT@INV_NATSUC";ex();
up(); up(); right(); right(); 
ri "RIGHT@RIGHT@NATSUC";ex();
rri "SAMESUCC";ex();
ri "RIGHT@INV_NATSUC";ex();
up(); left(); ri "RL@DIST";ex();
ri "ADD_CANCEL";ex();
ri "RL@RIGHT@LEFT@NATSUC";ex();
ri "RIGHT@RIGHT@RIGHT@NATSUC";ex();
ri "RL@(RIGHT@TIMESTYPE2)** $REALNAT";ex();
ri "RL@ $TIMESTYPE2";ex();
ri "RL@LEFT@INV_NATSUC";ex();
ri "RIGHT@RIGHT@INV_NATSUC";ex();
up(); up(); ri "BIND@?2";ex();
ri "LEFT@0|-|1";ex();
ri "EVAL";ex();
up(); ri "IRZER";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); ri "CID**AT";ex();
up(); up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); ex();

p "MULT_SUC_EQ";


(* _______________________________________________________________
	LESS_MONO_EQ0:
	-------------
	((1 + Nat : ?z) * Nat : ?p) < 1 + Nat : ?z =

	(Nat : ?p) = 0
   _______________________________________________________________ *)

s "((1+Nat:?z)*Nat:?p)<1+Nat:?z";
(* set up for induction proof *)
ri "PCASEINTRO@forall@[(((1+Nat:?z)*Nat:?1)<1+Nat:?z) = (Nat:?1)=0]";ex();
ri "UNIV_EQ_TAC";ex();

(* the induction proof starts here *)

left(); ri "INDUCT_TAC";ex();
left(); ri "RIGHT@REFLEX";ex();
ri "LEFT@(LEFT@TIMESCOMM**TIMESZERO)**LESS_0";ex();
ri "REFLEX";ex();
up(); right(); right(); right();
right(); ri "RIGHT@EQSYMM**SUCCNOTZERO";ex();
left(); left(); ri "DIST";ex();
ri "LEFT@(LEFT@NATSUC)**TIMESCOMM**TIMESID";ex();
ri "LEFT@ $REALNAT";ex();
up(); ri "RIGHT@NATSUC**REALNAT";ex();
ri "RIGHT@ $PLUSID";ex();
ri "LEFT@PLUSCOMM";ex();
ri "RIGHT@LEFT@ZERONAT";ex();
ri "LEFT@LEFT@(LEFT@NATSUC)**TIMESTYPE2";ex();
rri "LESS_MONO_ADD_EQ";ex();
ri "LESSBOOL2** $DUBNEG2";ex();
ri "RIGHT@(RIGHT@RIGHT@ $ZERONAT)**NOT_LESS_0";ex();
rri "FDEF";ex();
up(); ri "REFLEX";ex();
up(); ri "IRZER";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); ex();

p "LESS_MONO_EQ0";


(* _______________________________________________________________
	LESS_MULT_MONO:
	--------------
	((1 + Nat:?z) * Nat:?p) < (1 + Nat:?z) * Nat:?q =

	(Nat : ?p) < Nat : ?q
   _______________________________________________________________ *)

s "((1+Nat:?z)*Nat:?p)<(1+Nat:?z)*Nat:?q";
(* set up for induction proof *)
ri "PCASEINTRO@forall@[forall@[(((1+Nat:?z)*Nat:?1)<(1+Nat:?z)*Nat:?2) = (Nat:?1)<Nat:?2]]";ex();
ri "LEFT@forall"; ex();
right(); left();
ri "PCASEINTRO@forall@[(((1+Nat:?z)*Nat:?p)<(1+Nat:?z)*Nat:?1) = (Nat:?p)<Nat:?1]";ex();
ri "LEFT@forall"; ex();
right(); left();
ri "PCASEINTRO@(((1+Nat:?z)*Nat:?p)<(1+Nat:?z)*Nat:?q) = (Nat:?p)<Nat:?q";ex();
right(); left(); ri "0|-|3"; ex();
up();up();left();
ri "BIND@?q"; ri "LEFT@0|-|2"; ri "EVAL"; ex();
up(); ex();
up(); up(); left(); rri "forall"; ri "BIND@?p";
ri "LEFT@0|-|1"; ri "EVAL"; ex();
up(); ex(); up(); up(); left(); rri "forall"; ex();

(* the induction proof starts here *)

ri "INDUCT_TAC";ex();
left(); ri "INDUCT_TAC";ex();
left(); ri "LEFT@RL@TIMESCOMM**TIMESZERO";ex();
ri "REFLEX";ex();
up(); right(); right(); right();
right(); ri "RIGHT@LESS_0";ex();
left(); ri "LEFT@TIMESCOMM**TIMESZERO";ex();
right(); ri "DIST";ex();
left(); ri "(LEFT@NATSUC)**TIMESCOMM**TIMESID";ex();
rri "REALNAT";ex();
ri "INV_NATSUC";ex();
up(); ri "PLUSASSOC";ex();
ri "RIGHT@(RIGHT@(LEFT@NATSUC)**TIMESTYPE2)**PLUSTYPE2";ex();
up(); ri "LESS_0";ex();
up(); ri "REFLEX";ex();
up(); ri "IRZER";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); right(); right(); right();
ri "IMPTOCOND";ex();
right(); ri "LEFT@forall";ex();
right(); left(); ri "INDUCT_TAC";ex();
left(); left(); ri "RIGHT@TIMESCOMM**TIMESZERO";ex();
ri "LEFT@(RL@NATSUC)**TIMESTYPE2";ex();
up(); ri "RIGHT@LEFT@NATSUC";ex();
ri "RL@(RIGHT@ZERONAT)**LESSBOOL2";ex();
ri "RL@ $DUBNEG2";ex();
ri "RL@RIGHT@(RIGHT@RIGHT@ $ZERONAT)**NOT_LESS_0";ex();
ri "REFLEX";ex();
up(); right(); right(); right();
right(); ri "RIGHT@ $LESS_MONO_EQ";ex();
left(); ri "RL@DIST";ex();
ri "RL@LEFT@(LEFT@NATSUC)**TIMESCOMM**TIMESID** $REALNAT";ex();
ri "RL@RIGHT@(LEFT@NATSUC)**TIMESTYPE2";ex();
ri "RL@PLUSCOMM";ex();
rri "LESS_MONO_ADD_EQ";ex();
ri "RL@ ($TIMESTYPE2)**LEFT@INV_NATSUC";ex();
up(); ri "BIND@?2";ex();
ri "LEFT@0|-|1";ex();
ri "EVAL";ex();
up(); ri "IRZER";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); ex();

p "LESS_MULT_MONO";



(* ____________________________________________________
	EXP_ADD:
	-------
	exp @ ?m , (Nat : ?p) + Nat : ?q =

	(exp @ ?m , ?p) * exp @ ?m , ?q
   ____________________________________________________ *)

s "exp@?m,(Nat:?p)+Nat:?q";
ri "PCASEINTRO@forall@[(exp@?m,(Nat:?1)+Nat:?q)=(exp@?m,?1)*exp@?m,?q]"; ex();
ri "UNIV_EQ_TAC";ex();
left(); right(); right(); 
right(); left(); ri "EXPTYPE";ex();
ri "RIGHT@RIGHT@ $TYPES";ex();
rri "EXPTYPE";ex();
up(); up(); up(); up();
(* starting induction *)

ri "INDUCT_TAC";ex();
left(); left(); ri "RIGHT@RIGHT @ PLUSID** $REALNAT";ex();
ri "EXPTYPE";ex();
ri "RIGHT@RIGHT@TYPES";ex();
rri "EXPTYPE";ex();
up(); right(); ri "LEFT@EXP0";ex();
ri "TIMESID";ex();
ri "(RIGHT@EXPTYPE2)** $REALNAT";ex();
rri "EXPTYPE2";ex();
up(); ri "REFLEX";ex();
up(); right(); right(); right();
ri "IMPTOCOND";ex();
right(); right(); left();
left(); ri "RIGHT@RIGHT@PLUSASSOC**RIGHT@PLUSTYPE2";ex();
ri "EXP";ex();
up(); ri "RIGHT@(LEFT@EXP)**TIMESASSOC";ex();
left(); right(); ri "0|-|1";ex();
ri "LEFT@EXPTYPE";ex();
ri "LEFT@(RIGHT@RIGHT@TYPES)** $EXPTYPE";ex();
up(); up(); ri "REFLEX";ex();
up(); up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); ex();

p "EXP_ADD";

 
(* ________________________________________________
	MULT_EXP_MONO:
	-------------
	 ((Nat : ?n) * exp @ (1 + Nat : ?q) , ?p)
	= (Nat : ?m) * exp @ (1 + Nat : ?q) , ?p =

	(Nat : ?n) = Nat : ?m
   ________________________________________________ *)

s "((Nat:?n)*exp@(1+Nat:?q),?p) = (Nat:?m)*exp@(1+Nat:?q),?p";
ri "PCASEINTRO@forall@[(((Nat:?n)*exp@(1+Nat:?q),?1) = (Nat:?m)*exp@(1+Nat:?q),?1)=(Nat:?n)=Nat:?m]"; ex();
ri "UNIV_EQ_TAC";ex();
left(); ri "EVERYWHERE2@EXPTYPE";ex();
(* starting induction *)
ri "INDUCT_TAC";ex();
left(); left(); ri "RL@RIGHT@EXP0";ex();
ri "RL@TIMESCOMM**TIMESID** $REALNAT";ex();
up(); ri "REFLEX";ex();
up(); right(); right(); right();
ri "IMPTOCOND";ex();
right(); right(); left();
left(); ri "RL@RIGHT@EXP";ex();
ri "RL@ $TIMESASSOC";ex();
ri "RL@(LEFT@TIMESCOMM)**TIMESASSOC";ex();
ri "RL@LEFT@TYPES";ex();
ri "RL@LEFT@(RIGHT@LEFT@ONENAT)** $PLUSTYPE2";ex();
ri "RL@LEFT@LEFT@ $ONENAT";ex();
ri "RL@RIGHT@(RIGHT@EXPTYPE2)**TIMESTYPE2";ex();
ri "MULT_SUC_EQ";ex();
ri "RL@ ($TIMESTYPE2)**RIGHT@ $EXPTYPE2";ex();
ri "RL@RIGHT@EXPTYPE";ex();
ri "RL@RIGHT@(RIGHT@RIGHT@ $TYPES)** $EXPTYPE";ex();
ri "0|-|1";ex();
up(); ri "REFLEX";ex();
up(); up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); ex();

p "MULT_EXP_MONO";


(* ________________________________________________
	NOT_EXP0:
	--------
	~ (exp @ (1 + Nat : ?n) , ?m) = 0 =

	true
   ________________________________________________ *)

s "~(exp@(1+Nat:?n),?m) = 0";
ri "PCASEINTRO@forall@[(~(exp@(1+Nat:?n),?1)=0)=true]"; ex();
ri "UNIV_EQ_TAC";ex();
left();
right(); right();  ri "EQSYMM** $BOOLDEF";ex();
rri "NOTBOOL";ex();
right(); left(); ri "EXPTYPE**RIGHT@RIGHT@ $TYPES";ex();
rri "EXPTYPE";ex();
up(); up(); up(); up();
(* starting induction *)
ri "INDUCT_TAC";ex();
left(); right(); ri "LEFT@EXP0";ex();
ri "EQSYMM**ZERONOTONE";ex();
up(); ri "NEGF";ex();
up(); right(); right(); right();
left(); rri "3pt15a";ex();
ri "BCONV";ex();
ri "(LEFT@ $ASRTEQ)**RIGHT@AF";ex();
up(); ri "IMPTOCOND";ex();
right(); right(); left();
right(); left(); ri "EXP";ex();
up(); ri "EQSYMM**FACTORZERO";ex();
left(); ri "RIGHT@ ($REALNAT)**(RIGHT@LEFT@ONENAT)**INV_NATSUC";ex();
ri "SUCCNOTZERO";ex();
up(); right(); right(); ri "(RIGHT@EXPTYPE2)** $REALNAT";ex();
rri "EXPTYPE2";ex();
ri "EXPTYPE**RIGHT@RIGHT@ $TYPES";ex();
rri "EXPTYPE";ex();
up(); ri "EQSYMM**0|-|1";ex();
up(); ri "DID**AF";ex();
up(); ri "NEGF";ex();
up(); up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); ex();

p "NOT_EXP0";


ae "LESS_0_CASES"; wb(); p "LESS_0_CASESF@?m";

(* ________________________________________________
	ZERO_LESS_EXP:
	-------------
	0 < exp @ (1 + Nat : ?n) , ?m =
	
	true
   ________________________________________________ *)

s "0 < exp@(1+Nat:?n),?m";
ri "(LEFT@ZERONAT)**RIGHT@EXPTYPE2";ex();
ri "LESSBOOL2";ex();
rri "ILID";ex();
left(); ri "LESS_0_CASESF@exp@(1+Nat:?n),?m";ex();
ri "RL@RIGHT@ $EXPTYPE2";ex();
left(); ri "EQSYMM**ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@NOT_EXP0";ex();
rri "FDEF";ex();
up(); ri "DSYM**DID";ex();
up(); ri "IRULE2";ex();
ri "RIGHT@(LEFT@ $ZERONAT)**RIGHT@ $EXPTYPE2";ex();
ri "IREF";ex();

p "ZERO_LESS_EXP";


(* ________________________________________________
	LESS_EXP_SUC:
	------------
	(exp @ (1 + 1 + Nat : ?m) , ?n) < 
         exp @ (1 + 1 + Nat : ?m) , 1 + Nat : ?n =

	true
   ________________________________________________ *)

(* to ensure that the first parameter to the function exp
   is greater than 1, we express it as: 1 + 1 + m *)

s "(exp@(1+1+Nat:?m),?n) < exp@(1+1+Nat:?m),1+Nat:?n";
(* set up for induction proof *)
ri "PCASEINTRO@forall@[((exp@(1+1+Nat:?m),?1)<exp@(1+1+Nat:?m),1+Nat:?1) = true]";ex();
ri "UNIV_EQ_TAC";ex();
left(); right(); right(); ri "EQSYMM** $BOOLDEF";ex();
ri "RIGHT@LEFT@EXPTYPE**(RIGHT@RIGHT@ $TYPES)** $EXPTYPE";ex();
up(); up(); ri "FORALLBOOL2";ex();

(* the induction proof starts here *)

ri "INDUCT_TAC";ex();
left(); ri "LEFT@EXP0";ex();
right(); ri "RIGHT@RIGHT@RIGHT@ZERONAT";ex();
ri "EXP";ex(); ri "RIGHT@EXP0";ex();
ri "TIMESCOMM**TIMESID";ex();
rri "REALNAT";ex();
ri "RIGHT@(LEFT@ONENAT)**RIGHT@NATSUC";ex();
ri "INV_NATSUC";ex();
up(); ri "LEFT@ONENAT**REALNAT** $PLUSID";ex();
ri "LEFT@(LEFT@ZERONAT)**(RIGHT@ $ONENAT)**PLUSCOMM";ex();
rri "LESS_MONO_EQ";ex();
ri "LEFT@ $ZERONAT";ex();
ri "RIGHT@INV_NATSUC";ex();
ri "LESS_0";ex();
up(); right(); right(); right();
right(); ri "RIGHT@RIGHT@RIGHT@RIGHT@NATSUC";ex();
ri "RL@EXP";ex();
ri "RL@RIGHT@EXPTYPE2";ex();
ri "RL@LEFT@RIGHT@RIGHT@NATSUC";ex();
ri "RL@LEFT@(RIGHT@LEFT@ONENAT)**INV_NATSUC";ex();
ri "LESS_MULT_MONO";ex();
ri "RL@ $EXPTYPE2";ex();
left(); ri "EXPTYPE**(RIGHT@RIGHT@ $TYPES)** $EXPTYPE";ex();
up(); ri "RIGHT@RIGHT@RIGHT@LEFT@ $ONENAT";ex();
up(); ri "IREF";ex();
up(); up(); ri "FORALLDROP**AT";ex();
up(); ri "CID**AT";ex();
up(); ex();

p "LESS_EXP_SUC";

quit();
