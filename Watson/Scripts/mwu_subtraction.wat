(* theorems about natural number subtraction by Minglong Wu *)

(*
PRE0:

Pred @ 0 = 

0
*)

s "Pred@0";
ri "Pred**NAT__SUB";ex();
ri "LEFT@LESSCOMP";ex();

p "PRE0";

(*

PRESUC:  

Pred @ 1 + Nat : ?m  =  

Nat : ?m

PLUSTYPE , PLUSCOMP , BUILTIN , TYPES , PLUSID , PLUSCOMM 
, REFLEX , CASEINTRO , PLUSMINUS , PLUSASSOC , MINUSTYPE 
, PLUSTYPE2 , NOT1 , EQUATION , BOOLDEF , FNDIST , EQBOOL 
, NONTRIV , ASSERT , ODDCHOICE , IFF , AND , OR , LESSTYPE 
, forall , IF , forsome , LESS1 , INDUCTION , XOR 
, SAMESUCC , LESSCOMP , NAT_SUB , NATMINUSCOMP , MINUSCOMP 
, Pred , 0

*)

s "Pred@(1+Nat:?m)";
ri "Pred**NAT__SUB";ex();
left();
right();ri "REALNAT** $COMMPLUSID";ex();
ri "(LEFT@ $ONENAT)**RIGHT@ZERONAT";ex();
up();
left(); ri "EVERYWHERE@ONENAT";ex();
ri "TREMTOP@PLUSTYPE2";ex();
ri "LEFT@ $ONENAT";ex();
up(); rri "LESS_MONO_EQ";ex();
ri "(RIGHT@ $ZERONAT)**LESS_0_FALSE";ex();
up();ex();

(*up(); rri "NOT_EXP";ex();
ri "LEFT@NOT_LESS_0";ex();
*)

ri "EVERYWHERE@ONENAT**TREMTOP@PLUSTYPE2";ex();
ri "(LEFT@PLUSCOMM)**MINUSPLUS";ex();
rri "REALNAT";ex();

p "PRESUC";

(*


NAT0_SUB:  

0 .-. ?x  =  

0

CASEINTRO , BUILTIN , PLUSTYPE , PLUSCOMP , TYPES 
, REFLEX , PLUSMINUS , PLUSCOMM , MINUSTYPE , PLUSASSOC 
, PLUSID , ASSERT , EQBOOL , EQUATION , ODDCHOICE 
, BOOLDEF , IFF , NOT1 , AND , OR , FNDIST , NONTRIV 
, LESSTYPE , forall , IF , forsome , PLUSTYPE2 , LESS1 
, INDUCTION , LESS_EQ_REAL , XOR , SAMESUCC , LESSCOMP 
, NAT_SUB , NATMINUSCOMP , MINUSCOMP , 0

*)

s "0 .-. ?x";
ri "NAT__SUB";ex();
rri "NOT_EXP";ex();
left(); ri "NOT_LESS";ex();
ri "LESS_OR_EQ";ex();
ri "EVERYWHERE@ $ZERONAT";ex();
rri "DRULE2";ex();
left(); rri "DUBNEG2";ex();
ri "RIGHT@NOT_LESS_0";ex();
rri "FDEF";ex();
up(); ri "DSYM**DID";ex();
rri "ASRTEQ";ex();
up(); right();left(); 
ri "(LEFT@ $ZERONAT)**RIGHT@0|-|1";ex();
ri "MINUSZERO";ex();
top(); rri "CASEINTRO";ex();

p "NAT0_SUB";

(*

SUB_0:  

?x - 0  =  

Real : ?x

PLUSID , PLUSCOMM , BUILTIN , PLUSTYPE , PLUSCOMP 
, TYPES , REFLEX , CASEINTRO , PLUSMINUS , MINUSTYPE 
, PLUSASSOC , 0

*)

s "?x - 0";
ri "BREAKMINUS";ex();
ri "RIGHT@MINUSZERO";ex();
ri "PLUSCOMM**PLUSID";ex();

p "SUB_0";

(*

NATSUB_0:  

?x .-. 0  =  

Nat : ?x

PLUSTYPE , PLUSCOMP , BUILTIN , TYPES , PLUSID , PLUSCOMM 
, REFLEX , CASEINTRO , PLUSMINUS , MINUSTYPE , PLUSASSOC 
, NOT1 , FNDIST , EQBOOL , NONTRIV , ASSERT , EQUATION 
, ODDCHOICE , BOOLDEF , IFF , AND , OR , LESSTYPE 
, forall , IF , forsome , PLUSTYPE2 , LESS1 , INDUCTION 
, NAT_SUB , NATMINUSCOMP , LESSCOMP , MINUSCOMP , 0

*)


s "?x .-. 0";
ri "NAT__SUB";ex();
ri "LEFT@RIGHT@ $ZERONAT";ex();
rri "NOT_EXP";ex();
ri "LEFT@NOT_LESS_0";ex();
ri "RIGHT@ $ZERONAT";ex();
ri "SUB_0** $REALNAT";ex();
p "NATSUB_0";

(* the next theorem SUB_REFL in the original text is already present *)

(*

NATSUB_REFL:  

?x .-. ?x  =  

0

PLUSCOMM , PLUSTYPE , TYPES , PLUSMINUS , MINUSTYPE 
, PLUSASSOC , BUILTIN , PLUSCOMP , REFLEX , CASEINTRO 
, PLUSID , EQBOOL , EQUATION , BOOLDEF , NOT1 , ODDCHOICE 
, IFF , ASSERT , FNDIST , NONTRIV , forall , forsome 
, AND , OR , IF , LESS1 , NAT_SUB , NATMINUSCOMP , LESSCOMP 
, MINUSCOMP , 0

*)

s "?x.-.?x";
ri "NAT__SUB ** $NOT_EXP";ex();
ri "LEFT@LESS_NOT_REFL";ex();
ri "SUB_REFL";ex();

p "NATSUB_REFL";

(* LEQ_ADD_TRUE is provable; in fact, that's the form LEQ_ADD
takes in the new file natorder.mk2; the point is that it's fairly easy
to prove that ?x=< ?y = bool:?x=<?y *)

(*

NATMINUSPLUS:  

((Nat : ?x) + Nat : ?y) .-. ?y  =  

Nat : ?x

PLUSTYPE , PLUSCOMP , BUILTIN , TYPES , PLUSID , PLUSCOMM 
, REFLEX , CASEINTRO , PLUSMINUS , PLUSASSOC , MINUSTYPE 
, PLUSTYPE2 , LESS_EQ_REAL , OR , NOT1 , FNDIST , EQBOOL 
, NONTRIV , ASSERT , EQUATION , ODDCHOICE , BOOLDEF 
, IFF , AND , forall , LESSTYPE , LESS1 , forsome 
, IF , SAMESUCC , LESSCOMP , INDUCTION , XOR , NAT_SUB 
, NATMINUSCOMP , MINUSCOMP , 0

*)

(* this is only for the old prover *)

s "(bool:?x)||?y,?z";
ri "(LEFT@BOOLDEF)** $ODDCHOICE"; ex();
wb();
p "CASE_BOOL";

s "((Nat:?x) + Nat:?y) .-. ?y";
ri "NAT__SUB";ex();
rri "NOT_EXP";ex();
left(); ri "NOT_LESS";ex();
ri "RIGHT@(TREMTOP@PLUSTYPE2)**PLUSCOMM";ex();
up(); (* ri "CASE_BOOL"; *) ri "LEFT@LEQ_ADD";ex();
ri "(LEFT@TREMTOP@PLUSTYPE2)**MINUSPLUS";ex();
rri "REALNAT";ex();

p "NATMINUSPLUS";

(*

NATPLUSMINUS:  

(?x .-. ?y) + Nat : ?y  =  

((Nat : ?x) < Nat : ?y) || (Nat : ?y) , Nat : ?x

PLUSTYPE , PLUSCOMP , BUILTIN , TYPES , PLUSMINUS 
, ODDCHOICE , PLUSID , CASEINTRO , NAT_SUB , NATMINUSCOMP 
, LESSCOMP , MINUSCOMP , 0

*)

s "(?x .-. ?y) + Nat:?y";
ri "LEFT@NAT__SUB";ex();
ri "PCASEINTRO@(Nat:?x)<Nat:?y";ex();
ri "ODDCHOICE";ex();
right();left();
left(); ri "LEFT@ $0|-|1";ex();
up(); ri "PLUSID** $REALNAT";ex();
up(); right();
left(); ri "ODDCHOICE";ex();
ri "1|-|1";ex();
up(); ri "PLUSMINUS** $REALNAT";ex();
top(); rri "ODDCHOICE";ex();

p "NATPLUSMINUS";

(*

NATPLUSMINUS_2:  

(?x .-. ?y) + Nat : ?z  =  

((Nat : ?x) < Nat : ?y) || (Nat : ?z) , ((Nat : ?x) 
   - Nat : ?y) + Nat : ?z

ODDCHOICE , PLUSTYPE , PLUSCOMP , BUILTIN , TYPES 
, PLUSID , CASEINTRO , NAT_SUB , NATMINUSCOMP , LESSCOMP 
, MINUSCOMP , 0

*)

s "(?x .-. ?y) + Nat:?z";
ri "LEFT@NAT__SUB";ex();
ri "PCASEINTRO@(Nat:?x)<Nat:?y";ex();
ri "ODDCHOICE";ex();
right();left();
left(); ri "LEFT@ $0|-|1";ex();   
up(); ri "PLUSID** $REALNAT";ex();
up(); right();
left(); ri "ODDCHOICE";ex();
ri "1|-|1";ex();
up(); ri "PLUSMINUS** $REALNAT";ex();
top(); rri "ODDCHOICE";ex();
p "NATPLUSMINUS_2"; 

(*

SUB_EQ_0:  

(?m .-. ?n) = 0  =  

(Nat : ?m) =< Nat : ?n

ASSERT , OR , NOT1 , FNDIST , REFLEX , EQBOOL , NONTRIV 
, EQUATION , BOOLDEF , CASEINTRO , TYPES , AND , ODDCHOICE 
, IFF , PLUSTYPE , PLUSCOMP , BUILTIN , LESS_EQ_REAL 
, PLUSCOMM , PLUSMINUS , MINUSTYPE , PLUSASSOC , PLUSID 
, NAT_SUB , NATMINUSCOMP , LESSCOMP , MINUSCOMP , forall 
, forsome , IF , LESS1 , 0

*) 
 
s "(?m .-. ?n) = 0";
ri "PCASEINTRO@ (Nat:?m) =< Nat:?n";ex();
ri "LEFT@LESS_OR_EQ";ex();
ri "OR_EXP**ODDCHOICE";ex();
right();left();
left(); ri "NAT__SUB";ex();
ri "LEFT@ $0|-|1";ex();
up(); ri "REFLEX";ex();
up(); right(); right();left();
left(); ri "NATMINUSSCIN**LEFT@0|-|2";ex();
ri "($NATMINUSSCIN)**NATSUB_REFL";ex();
up(); ri "REFLEX";ex();
up(); right();
left(); ri "NAT__SUB**ODDCHOICE";ex();
ri "1|-|1";ex();
up(); rri "EQUATION_TO_DIFFERENCE";ex();
ri "RL@ $REALNAT";ex();
ri "EQUATION**1|-|2";ex();
top(); rri "ODDCHOICE";ex();
rri "TAB_OR";ex();
rri "LESS_OR_EQ";ex();

     
p "SUB_EQ_0";

(*

INV_PRE_EQ:  

((0 < Nat : ?m) & 0 < Nat : ?n) -> ((Pred @ ?m) = Pred 
   @ ?n) = (Nat : ?m) = Nat : ?n  =  

true

CASEINTRO , REFLEX , EQUATION , ODDCHOICE , BOOLDEF 
, IFF , EQBOOL , ASSERT , TYPES , NOT1 , FNDIST , NONTRIV 
, PLUSTYPE , PLUSCOMP , BUILTIN , PLUSID , PLUSMINUS 
, PLUSASSOC , PLUSCOMM , MINUSTYPE , PLUSTYPE2 , LESS1 
, forsome , IF , OR , forall , AND , XOR , LESSTYPE 
, SAMESUCC , LESSCOMP , INDUCTION , LESS_EQ_REAL , NAT_SUB 
, NATMINUSCOMP , MINUSCOMP , Pred , 0

*)


s "((0<Nat:?m) & 0<Nat:?n) -> ((Pred@?m)=Pred@?n) = (Nat:?m) = Nat:?n";
ri "IMPTOCOND";ex();
right(); ri "ANDUNPACK";ex();
right();left();right();left();
left(); ri "RL@Pred**NAT__SUB";ex();
ri "RL@ $NOT_EXP";ex();
ri "RL@LEFT@NOT_LESS";ex();
ri "RL@LEFT@LEFT@REALNAT** $PLUSID";ex();
ri "RL@LEFT@LEFT@(LEFT@ZERONAT)**PLUSCOMM";ex();
ri "RL@LEFT@LEFT@LEFT@ $ONENAT";ex();
ri "RL@LEFT@LESS_EQ";ex();
ri "RL@LEFT@LEFT@ $ZERONAT";ex();
ri "(LEFT@LEFT@ $0|-|1)**RIGHT@LEFT@ $0|-|2";ex();
ri "RL@BREAKMINUS**PLUSCOMM";ex();
ri "ADD_CANCEL";ex();
ri "RL@ $REALNAT";ex();
up(); ri "REFLEX";ex();
up(); up(); rri "CASEINTRO";ex();
up(); up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();

p "INV_PRE_EQ";ex();

(*

PRE_SUC_EQ:  

(0 < Nat : ?n) -> ((Nat : ?m) = Pred @ ?n) = (1 + Nat 
   : ?m) = Nat : ?n  =  

true

CASEINTRO , REFLEX , EQUATION , ODDCHOICE , BOOLDEF 
, IFF , EQBOOL , ASSERT , TYPES , NOT1 , FNDIST , NONTRIV 
, BUILTIN , PLUSTYPE2 , PLUSTYPE , PLUSCOMP , PLUSCOMM 
, PLUSMINUS , MINUSTYPE , PLUSASSOC , PLUSID , LESS1 
, forsome , IF , OR , forall , AND , XOR , LESSTYPE 
, SAMESUCC , LESSCOMP , INDUCTION , LESS_EQ_REAL , NAT_SUB 
, NATMINUSCOMP , MINUSCOMP , Pred , 0

*)


s "(0 < Nat:?n) -> ((Nat:?m) = Pred@?n) = (1+Nat:?m) = Nat:?n";
ri "IMPTOCOND";ex();
right(); ri "ODDCHOICE";ex();
right();left();
left(); right();
ri "Pred**NAT__SUB";ex();
rri "NOT_EXP";ex();
left(); ri "NOT_LESS";ex();
left(); ri "REALNAT** $PLUSID";ex();
ri "(LEFT@ZERONAT)**PLUSCOMM";ex();
ri "LEFT@ $ONENAT";ex();
up(); ri "LESS_EQ";ex();
ri "LEFT@ $ZERONAT";ex();
up(); ri "LEFT@ $0|-|1";ex();
ri "MINUSTYPE";ex();
up(); ri "LEFT@REALNAT";ex();
ri "EQUATION_TO_DIFFERENCE";ex();
left(); ri "EVERYWHERE@ $REALNAT";ex();
ri "SUBTRACT_DIFF";ex();
rri "PLUSASSOC";ex();
ri "PLUSCOMM** $PLUSASSOC";ex();
ri "LEFT@TADDTOP@PLUSTYPE2";ex();
rri "BREAKMINUS";ex();
up(); rri "EQUATION_TO_DIFFERENCE";ex();
ri "RL@ $REALNAT";ex();
ri "LEFT@(TREMTOP@PLUSTYPE2)**LEFT@ $ONENAT";ex();
up(); ri "REFLEX";ex();
up(); up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();

p "PRE_SUC_EQ";

(*

SUB_COMM:  

(?x - ?y) - ?z  =  

(?x - ?z) - ?y

PLUSCOMM , PLUSTYPE , TYPES , PLUSMINUS , MINUSTYPE 
, PLUSASSOC , BUILTIN , PLUSCOMP , REFLEX , CASEINTRO 
, PLUSID , 0

*)

s "(?x - ?y) - ?z";
ri "EVERYWHERE@BREAKMINUS";ex();
ri "PLUSASSOC**RIGHT@PLUSCOMM";ex();
rri "PLUSASSOC";ex();
ri "EVERYWHERE@ $BREAKMINUS";ex();

p "SUB_COMM";


(*

LESS_ADD_LESS:  

((Nat : ?m) < Nat : ?n) -> (Nat : ?m) < Nat : (Nat 
   : ?n) + Nat : ?p  =  

true

CASEINTRO , IF , OR , NOT1 , FNDIST , REFLEX , EQBOOL 
, NONTRIV , ASSERT , TYPES , EQUATION , ODDCHOICE 
, BOOLDEF , IFF , AND , LESSTYPE , forall , BUILTIN 
, PLUSTYPE2 , LESS1 , forsome , PLUSTYPE , XOR , SAMESUCC 
, LESSCOMP , PLUSCOMP , INDUCTION , PLUSASSOC , PLUSCOMM 
, SUCCNOTZERO , PLUSID , 0

*)

s "((Nat : ?m) < Nat : ?n) -> (Nat : ?m) < Nat : (Nat : ?n) + Nat : ?p";
ri "PCASEINTRO@(Nat:?p)=0";ex();
right();left();right();right();right();right();ri "0|-|1";ex();
up();ri "COMMPLUSID** $REALNAT";ex();
up();ri "TYPES";ex();
up();up();ri "IREF";ex();
up();right();rri "IRULE2";ex();
left();rri "CID";ex();
right();initializecounter();
rri "LESS_ADD_NZ";ex();
assign "?n_1" "?p";
assign "?m_1" "?n";
left();right();ri "EQUATION** 1|-|1";ex();
up();ri "NEGF";ex();
up();ri "ILID";ex();
ri "RIGHT@RIGHT@PLUSTYPE2";ex();
up();ri "CRULE3";ex();
up();ri "LESS_TRANS";ex();
up();up();rri "CASEINTRO";ex();

p "LESS_ADD_LESS";

(*

NAT_SUB_LESS_INV:  

(((Nat : ?m) .-. Nat : ?n) < Nat : ?p) -> (Nat : ?m) 
< Nat : (Nat : ?n) + Nat : ?p  =  

true

CASEINTRO , NOT1 , AND , OR , EQUATION , BOOLDEF , FNDIST 
, REFLEX , EQBOOL , NONTRIV , ASSERT , TYPES , ODDCHOICE 
, IFF , IF , PLUSTYPE2 , PLUSCOMM , PLUSTYPE , PLUSCOMP 
, BUILTIN , PLUSMINUS , LESS_EQ_REAL , LESS1 , forsome 
, forall , LESSTYPE , XOR , SAMESUCC , LESSCOMP , INDUCTION 
, NAT_SUB , NATMINUSCOMP , MINUSCOMP , PLUSASSOC , PLUSID 
, SUCCNOTZERO , 0

*)

s "(((Nat:?m).-.Nat:?n)<Nat:?p)->(Nat:?m)<Nat:(Nat:?n)+Nat:?p";
ri "PCASEINTRO@(Nat:?m)<Nat:?n";ex();
ri "ODDCHOICE";ex();
right();left();rri "IRULE3";ex();
right();rri "ILID";ex();
ri "LEFT@0|-|1";ex();
ri "LESS_ADD_LESS";ex();
up();ri"IRZER";ex();
up();right();left();left();ri "NAT_SUB";ex();
left();ri "EVERYWHERE@TYPES";ex();
ri "LESSBOOL**BOOLDEF**EQUATION**1|-|1";ex();
up();ex();
ri "EVERYWHERE@TYPES";ex();
up();initializecounter();
ri "LESS_MONO_ADD_EQ";ex();
assign "?p_1" "?n";
left();left();
ri "REALSUBNATTYPE";ex();
ri "ODDCHOICE**1|-|1";ex();
up();ri "PLUSMINUS** $REALNAT";ex();
up();ri "RIGHT@PLUSCOMM**PLUSTYPE2";ex();
up();ri "IREF";ex();
up();up();rri "CASEINTRO";ex();

p "NAT_SUB_LESS_INV";

(* quit(); *)

(* BEGIN weird theorem commented out

(*


*)

s "((?m .-. ?n) .-. ?p)->(?m .-. (Nat:?n)+Nat:?p)";
ri "(PCASEINTRO@(Nat:?m)<Nat:?n)**ODDCHOICE";ex();
right();left();left();left();ri "NAT_SUB";ex();
ri "LEFT@ $0|-|1";ex();
up();ri "NAT0_SUB";ex();
up();right();ri "NAT_SUB";ex();
left();ri "LESSBOOL**ASSERT2** $ILID";ex();
ri "LEFT@0|-|1";ex();
ri "PCASEINTRO@(Nat:?p)=0";ex();
right();left();right();right();right();right();ri "0|-|2";ex();
up();ri "COMMPLUSID** $REALNAT";ex();
up();ri "TYPES";ex();
up();up();ri "IREF";ex();
up();right();rri "IRULE2";ex();
left();rri "CID";ex();
right();initializecounter();
rri "LESS_ADD_NZ";ex();
assign "?n_1" "?p";
assign "?m_1" "?n";
left();right();ri "EQUATION** 1|-|2";ex();
up();ri "NEGF";ex();
up();ri "ILID";ex();

ri "RIGHT@RIGHT@PLUSTYPE2";ex();
up();ri "CRULE3";ex();
up();ri "LESS_TRANS";ex();
up();up();rri "CASEINTRO";ex();
up();ex();
up();ri "IREF";ex();
up();right();
ri "PCASEINTRO@((Nat:?m).-.Nat:?n)<Nat:?p";ex();
ri "ODDCHOICE";ex();
right();left();left();left();ri "NATMINUSSCIN";ex();
up();ri "NAT_SUB";ex();
left();left();rri "NATMINUSTYPE";ex();
ri "NATMINUSSCIN";ex();
up();up();ri "LEFT@ $0|-|2";ex();
up();right();ri "NAT_SUB";ex();
ri "ASRTCOND";ex();
left();rri "ILID";ex();
ri "LEFT@0|-|2";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
right();ri "RIGHT@PLUSTYPE2";ex();
up();ri "NAT_SUB_LESS_INV";ex();
up();ex();
up();ri "IREF";ex();

up();right();ri "EVERYWHERE@NAT_SUB";ex();
left();left();left();right();
ri "ODDCHOICE**1|-|1";ex();
up();ri "TYPES";ex();
up();up();right();right();right();left();right();
ri "ODDCHOICE**1|-|1";ex();
up();ri "TYPES";ex();
top();right();right();left();right();left();
ri "NAT_SUB";ex();
left();ri "RL@TYPES";ex();
up();ri "ODDCHOICE**1|-|1";ex();
ri "EVERYWHERE@TYPES";ex();
up();up();up();right();right();left();
ri "ODDCHOICE**1|-|2";ex();
up();right();left();initializecounter();
rri "REAL_LESS_CANCEL";ex();
assign "?z_1" "-Nat:?n";
left();ri "PLUSCOMM** $BREAKMINUS";ex();
up();right();ri "RIGHT@ $PLUSTYPE2";ex();
rri "PLUSASSOC";ex();
ri "LEFT@ALL_CANCEL_1";ex();
ri "PLUSID** $REALNAT";ex();
top();right();right();left();right();left();
ri "REALSUBNATTYPE";ex();
ri "ODDCHOICE**1|-|1";ex();
top();right();right();right();right();right();
ri "ODDCHOICE**1|-|2";ex();
up();left();right();left();
ri "REALSUBNATTYPE";ex();
ri "ODDCHOICE**1|-|1";ex();
up();rri "SUBTRACT_SUM";ex();
ri "RIGHT@PLUSTYPE2";ex();
up();up();ri "IREF";ex();
top();ri "EVERYWHERE@ $CASEINTRO";ex();

p "SUB_RIGHT_SUB_1";

END weird theorem commented out *)

(* BEGIN block of unused stuff commented out

(*

*)

s "(?x .-. ?y) .-. ?z";
ri "EVERYWHERE@NAT__SUB";ex();
ri "PCASEINTRO@ ~(Nat:?x)<Nat:?y";ex();
ri "NOT_EXP";ex();
ri "ODDCHOICE";ex();
right();left();
left();left();right();
ri "LEFT@ $0|-|1";ex();
up(); rri "ZERONAT";ex();
up();
up();right();right();
left();right();
ri "LEFT@ $0|-|1";ex();
up(); rri "ZERONAT";ex();
up();up();up();up();
right(); left();left();
right(); ri "ODDCHOICE";ex();
ri "LEFT@EQUATION**1|-|1";ex();
up();up();up();right();right();
left();right();
ri "ODDCHOICE";ex();
ri "LEFT@EQUATION**1|-|1";ex();


(* _______________________________________________________________
   _______________________________________________________________ *)

s "(Pred@?m).-.?n";
ri "(LEFT@Pred)**NAT__SUB";ex();


s "Pred@(?m.-.?n)";
ri "Pred";ex();
ri "EVERYWHERE@NAT__SUB";ex();



p "PRE_SUB";

END block of unused stuff commented out *)


(* _______________________________________________________________
	MINUSREAL:
	=========
	- ?a = 

	- Real : ?a
   _______________________________________________________________ *)

s "-?a";
ri "MINUSSCIN"; ex();
ri "LEFT@ $REALZERO";ex();

p "MINUSREAL";


(* _______________________________________________________________

	SUB_REFLF @ ?x:
	==============
	0 = 

	?x - ?x
   _______________________________________________________________ *)

ae "SUB_REFL"; wb();
p "SUB_REFLF@?x";


(* _______________________________________________________________
	ADD_EQ_0:
	========
	(?x + ?y) = 0 = 

	(Real : ?x) = Real : - ?y
   _______________________________________________________________ *)

s "(?x + ?y) = 0";
right();
ri "SUB_REFLF@?y";ex();
ri "BREAKMINUS";ex();
up();
ri "LEFT@PLUSCOMM";ex();
ri "ADD_CANCEL";ex();

p "ADD_EQ_0";


(* _______________________________________________________________
	RIGHT_SUBDIST:
	=============
	(?m - ?n) * ?p = 

	(?m * ?p) - ?n * ?p
   _______________________________________________________________ *)

s "(?m - ?n) * ?p";
ri "LEFT@BREAKMINUS";ex();
ri "COMMDIST";ex();
ri "RIGHT@TIMESCOMM**SIGNPULL";ex();
ri "RIGHT@RIGHT@TIMESCOMM";ex();
rri "BREAKMINUS";ex();

p "RIGHT_SUBDIST";


(* _______________________________________________________________
	LEFT_SUBDIST:
	============
	?p * ?m - ?n = 

	(?p * ?m) - ?p * ?n
   _______________________________________________________________ *)

s "?p * (?m - ?n)";
ri "RIGHT@BREAKMINUS";ex();
ri "DIST";ex();
ri "RIGHT@SIGNPULL";ex();
rri "BREAKMINUS";ex();

p "LEFT_SUBDIST";


(* _______________________________________________________________
	SUB_CANCEL:
	==========
	(1 + ?a) - 1 + ?b = 

	?a - ?b
   _______________________________________________________________ *)

s "(1+?a) - (1+?b)";
ri "ALL_CANCEL";ex();
rri "BREAKMINUS";ex();

p "SUB_CANCEL";


(* _______________________________________________________________
	ADD_INV_0:
	=========
	((?x + ?y) = Real : ?x) -> (Real : ?y) = 0 = 

	true
   _______________________________________________________________ *)

initializecounter();
s "((?x + ?y) = Real:?x) -> ((Real:?y) = 0)";
ri "PCASEINTRO@(Real: ?y) = 0"; ex();
right(); left(); right(); ri "(LEFT@0|-|1)**REFLEX";ex();
up(); ri "IRZER";ex();

(* left(); left();
ri "PLUSSCIN"; ex();
right(); ri "0|-|1"; ex();       (* 0|-|1: (Real : ?y) = 0 *)
ri "REALZERO"; ex();
up(); rri "PLUSSCIN"; ex();
ri "PLUSCOMM ** PLUSID"; ex();
up(); ri "REFLEX"; ex();
up(); ri "ILID"; ex();
rri "ASRTEQ"; ex();
ri "LEFT @ 0|-|1"; ex();
ri "REFLEX"; ex();
*)

up(); right(); left(); ri "EQUATION"; ex();
right(); left(); initializecounter();
rri "REFLEX"; ex();
assign "?a_1" "(?x + ?y) - ?x"; 
right(); ri "LEFT @ 0|-|2"; ex(); (* 0|-|2: (?x + ?y) = Real : ?x *)
ri "MINUSSCIN ** LEFT @ TYPES"; ex();
rri "MINUSSCIN"; ex();
ri "SUB_REFL"; ex();
up(); left(); 
ri "LEFT @ PLUSCOMM"; ex();
ri "MINUSPLUS"; ex(); up();
ri "EQUATION ** 1|-|1"; ex();
up(); up(); rri "CASEINTRO"; ex();
up(); ri "3pt75"; ex();
top(); rri "CASEINTRO"; ex();

p "ADD_INV_0";
(* test
(*

(* First proof of "ADD_INV_0_EQ" *)
*)

s "((Nat:?m)+Nat:?n)=Nat:?m";
ri "EVERYWHERE@PLUSTYPE2";ex();
ri "RL@REALNAT";ex();
initializecounter();
rri "ADD_CANCEL";ex();
assign "?z_1" "-Nat:?m";
ri "RIGHT@ALL_CANCEL_1";ex();
left(); ri "RIGHT@ $PLUSTYPE2";ex();
rri "PLUSASSOC";ex();
ri "LEFT@ALL_CANCEL_1";ex();
ri "LEFT@PLUSID** $REALNAT";ex();
p "ADD_INV_0_EQ";
========================================================== *)
(* _______________________________________________________________
	ADD_INV_0_EQ:
	============
	((Nat : ?m) + Nat : ?n) = Nat : ?m = 

	(Nat : ?n) = 0
   _______________________________________________________________ *)
s "((Nat:?m)+Nat:?n)=Nat:?m";
initializecounter();
ri "PCASEINTRO@(Nat:?n)=0";ex();
right();left();
ri "EVERYWHERE@0|-|1";ex();
ri "LEFT@PLUSCOMM**PLUSID";ex();
ri "LEFT@ $REALNAT";ex();
ri "REFLEX";ex();
up();right();
ri "EQUATION"; ex();
right(); left(); rri "REFLEX"; ex();
assign "?a_29" "((Nat:?m) + Nat:?n) - Nat:?m"; 
right(); ri "LEFT @ 0|-|2"; ex(); 
ri "SUB_REFL"; ex();
up(); left(); 
ri "LEFT @ PLUSCOMM"; ex();
ri "MINUSPLUS"; ex(); up();
ri "LEFT@ $REALNAT";ex();
ri "EQUATION ** 1|-|1"; ex();
up(); up(); rri "CASEINTRO"; ex();
top();
rri "EQUATION";ex();

p "ADD_INV_0_EQ";

(*


*)

s "((Nat:?m)-Nat:?n)=Nat:?m";
ri "PCASEINTRO@(Nat:?n)=0";ex();  
right();left();
ri "EVERYWHERE@0|-|1";ex();  
ri "LEFT@SUB_0** $REALNAT";ex();
ri "REFLEX";ex();
up();right();
ri "EQUATION"; ex();
right(); left(); 
initializecounter();
rri "REFLEX"; ex();
assign "?a_1" "((Nat:?m) - Nat:?n) - Nat:?m";
right(); ri "LEFT @ 0|-|2"; ex();
ri "SUB_REFL"; ex();
up(); left();
ri "LEFT@BREAKMINUS";ex();
ri "LEFT @ PLUSCOMM"; ex();
ri "MINUSPLUS"; ex(); up();
left(); rri "MINUSMINUS";ex();
right(); ri "MINUSMINUS"; ex();
rri "REALNAT";ex();
up();up(); rri "EQUATION_TO_DIFFERENCE";ex();
ri "EVERYWHERE@ ($REALZERO)**EQSYMM** $REALNAT";ex();
ri "EQUATION ** 1|-|1"; ex();
up(); up(); rri "CASEINTRO"; ex();
up();up();rri "EQUATION";ex();

p "SUB_INV_0_EQ";

(*
(*

ADD_BOTH_0:

((Nat : ?m) + Nat : ?n) = 0 =

((Nat : ?m) = 0) & (Nat : ?n) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMP","PLUSID","PLUSTYPE","PLUSTYPE2","REFLEX","SUCCNOTZERO","TYPES","XOR","forall"]
*)

s "((Nat : ?m) + Nat : ?n) = 0";
ri "PCASEINTRO@(Nat:?m)=0";ex();
right();left();left();ri "LEFT@0|-|1";ex();
ri "PLUSID** $REALNAT";ex();
up();ri "EQUATION";ex();
up();right();ri "EQUATION";ex();
right();left();initializecounter();
rri "REFLEX";ex();
assign "?a_1" "((Nat:?m)+Nat:?n).-.Nat:?n";
right();left();ri "0|-|2";ex();
up();ri "NAT0_SUB";ex();
up();left();ri "NATMINUSPLUS";ex();
up();ri "EQUATION** 1|-|1";ex();
top();ri "EVERYWHERE@ ($CASEINTRO)** $TAB_AND";ex();
p "ADD_BOTH_0":
*)
(* _______________________________________________________________
	ADD_BOTH_0:
	==========
	((Nat : ?m) + Nat : ?n) = 0 = 

	((Nat : ?m) = 0) & (Nat : ?n) = 0
   _______________________________________________________________ *)

s "((Nat : ?m) + Nat : ?n) = 0";
ri "PCASEINTRO@forall@[(((Nat:?1)+Nat:?n)=0) = ((Nat:?1)=0) &(Nat:?n)=0]";ex();
ri "UNIV_EQ_TAC";ex();
left();ri "INDUCT_TAC";ex();
left();left();
ri "LEFT@PLUSID** $REALNAT";ex();
up();right();
ri "LEFT@REFLEX";ex();
ri "CSYM**CID** $ASRTEQ";ex();
up(); ri "REFLEX";ex();
up();right();right();right();
right();left();
ri "(LEFT@PLUSASSOC)**EQSYMM";ex();
ri "RIGHT@RIGHT@TADDTOP@PLUSTYPE2";ex();
up();ri "RIGHT@LEFT@EQSYMM";ex();
ri "EVERYWHERE@SUCCNOTZERO";ex();
ri "RIGHT@CSYM**CZER";ex();
ri "REFLEX";ex();
up(); ri "IRZER";ex();
up();up(); ri "FORALLDROP**AT";ex();
top(); ri "LEFT@CID**AT";ex();

p "ADD_BOTH_0";


(*

SUB_EQ_EQ_0:

((Nat : ?m) .-. Nat : ?n) = Nat : ?m =

((Nat : ?n) = 0) | (Nat : ?m) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSCOMP","MINUSTYPE","NATMINUSCOMP","NAT_SUB","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
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

(* not needed with Baby
(* fix inserted by Holmes *)

downtoleft "(?x-?y)=?z";
ri "EVERYWHERE@ $ZERONAT"; ex();
left(); ri "SUB_0** $REALNAT"; ex();
up(); ri "REFLEX"; top(); 

(* end of fix *)
*)

rri "TAB_OR";ex();

p "SUB_EQ_EQ_0";


(* 

SUB_PLUS_REFL:

(Nat : ?m) .-. (Nat : ?m) + Nat : ?n =

0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","NAT_SUB","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REAL_LESS_DEF","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "(Nat:?m).-.(Nat:?m)+Nat:?n";
ri "NAT_SUB";ex();
left();ri "EVERYWHERE@TYPES";ex();
initializecounter();
rri "REAL_LESS_CANCEL";ex();
assign "?z_1" "-Nat:?m";
ri "LEFT@ALL_CANCEL_1";ex();
right(); ri "RIGHT@ $PLUSTYPE2";ex();
rri "PLUSASSOC";ex();
ri "LEFT@ALL_CANCEL_1";ex();
ri "PLUSID** $REALNAT";ex();
up();ri "LEFT@ZERONAT";ex();
top();rri "NOT_EXP";ex();
left();ri "NOT_LESS";ex();
ri "LESS_OR_EQ";ex();
ri "EVERYWHERE@ $ZERONAT";ex();
rri "DRULE2";ex();
left(); rri "DUBNEG2";ex();
ri "RIGHT@NOT_LESS_0";ex();
rri "FDEF";ex();
up(); ri "DSYM**DID";ex();
rri "ASRTEQ";ex();
up(); right();left();ri "EVERYWHERE@TYPES** $PLUSTYPE2";ex();
right();right();ri "RIGHT@0|-|1";ex();
ri "COMMPLUSID** $REALNAT";ex();
up();ri "SUB_REFL";ex();
up();rri "ZERONAT";ex();
top();rri "CASEINTRO";ex();
p "SUB_PLUS_REFL";

(*

GREAT_NOT_EQ_0:

0 < Nat : ?x =

~ (Nat : ?x) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","POSPLUS","POSTYPE","REAL_LESS_DEF","REFLEX","SAMESUCC","TRICHOTOMY","TYPES","XOR","forall","forsome"]
*)

s "0<Nat:?x";
ri "(LEFT@ZERONAT)**LESSBOOL";ex();
rri "DUBNEG";ex();
right();ri "TAB_NOT";ex();
rri "NOT_EXP";ex();
left();ri "REAL_NOT_LESS";ex();
ri "LESS_OR_EQ";ex();
left();ri "NOT_LESS";ex();
ri "LESSBOOL";ex();
rri "DUBNEG";ex();
ri "EVERYWHERE@ $ZERONAT";ex();
ri "RIGHT@NOT_LESS_0";ex();
rri "FDEF";ex();
up(); ri "DSYM**DID";ex();
rri "ASRTEQ";ex();
up();rri "EQUATION";ex();
ri "RIGHT@ $ZERONAT";ex();
p "GREAT_NOT_EQ_0";

(*
 
NEG_NOT_GREATER_0:

(- Nat : ?x) =< 0 =

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","LESS1","LESSCOMP","LESSTYPE","LESS_EQ_REAL","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REAL_LESS_DEF","REFLEX","SAMESUCC","TYPES","XOR","forall","forsome"]
*)

s "(-Nat:?x)=<0";
ri "LESS_EQ_REAL";ex();
left();initializecounter();
rri "ADD_CANCEL";ex();
assign "?z_1" "Nat:?x";
ri "RIGHT@COMMPLUSID** $REALNAT";ex();
ri "LEFT@ ($BREAKMINUS)**SUB_REFL";ex();
up();right();initializecounter();
rri "REAL_LESS_CANCEL";ex();
assign "?z_1" "Nat:?x";
ri "RIGHT@COMMPLUSID** $REALNAT";ex();
ri "LEFT@ ($BREAKMINUS)**SUB_REFL";ex();
up();ri "DSYM";ex();
ri "EVERYWHERE@ZERONAT";ex();
rri "LESS_OR_EQ";ex();
rri "NOT_LESS";ex();
ri "EVERYWHERE@ $ZERONAT";ex();
ri "NOT_LESS_0";ex();
p "NEG_NOT_GREATER_0";

(*

EQ_NEG_BOTH_0:

(Nat : ?m) = - Nat : ?m =

(Nat : ?m) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SUCCNOTZERO","TYPES","XOR","forall"]
*)

s "(Nat:?m) = -(Nat:?m)";
ri "PCASEINTRO@(Nat:?m)=0";ex();
right();left();left();ri "0|-|1";ex();
up();right();right();ri "0|-|1";ex();
up();ri "MINUSZERO";ex();
up();ri "REFLEX";ex();
up();right();ri "EQUATION";ex();
right();left();initializecounter();
rri "REFLEX";ex();
assign "?a_1" "(Nat:?m)+Nat:?m";
right();right();ri "0|-|2";ex();
up();ri "ALL_CANCEL_2";ex();
up();ri "ADD_BOTH_0";ex();
left();ri "EQUATION**1|-|1";ex();
up();ri "CSYM**CZER";ex();
up();up();rri "CASEINTRO";ex();
up();up();rri "EQUATION";ex();
p "EQ_NEG_BOTH_0";

(*

NEG_EQ_BOTH_0:

(Nat : ?m) = - Nat : ?n =

((Nat : ?m) = 0) & (Nat : ?n) = 0

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","INDUCTION","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","PLUSTYPE2","REFLEX","SUCCNOTZERO","TYPES","XOR","forall"]
*)

s "(Nat:?m) = -(Nat:?n)";
ri "PCASEINTRO@(Nat:?m)=0";ex();
right();left();left();ri "0|-|1";ex();
up();ri "DIFF_EQ";ex();
right();right();ri "ZERONAT";ex();
up();rri "REALNAT";ex();
rri "ZERONAT";ex();
up();left();rri "REALNAT";ex();
up();ri "EQUATION";ex();
up();right();ri "EQUATION";ex();
right();left();initializecounter();
rri "REFLEX";ex();
assign "?a_1" "(Nat:?m)+Nat:?n";
right();left();ri "0|-|2";ex();
up();ri "ALL_CANCEL_1";ex();
up();ri "ADD_BOTH_0";ex();
left();ri "EQUATION**1|-|1";ex();
up();ri "CSYM**CZER";ex();
up();up();rri "CASEINTRO";ex();
top();rri "TAB_AND";ex();
p "NEG_EQ_BOTH_0";


quit();
