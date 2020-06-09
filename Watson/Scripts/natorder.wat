(* Sol Espinosa's script on order properties of the natural numbers *)

(* received May 18, 1998 *)

(* modified May 29, 1998, when realorder.mk2 was incorporated *)

(* requires further modification for correct treatment of 
=< and >=; these corrections made May 29 as well *)

(* LESS_EQ_ADD, LESS_OR_ADD for example, still to be repaired *)

script "sequent";
script "simplesets";
script "algebra2";


(* 
   __________________________________________________________________

	natorder.mk2
   __________________________________________________________________

*)

(* these declarations are now found in realorder.mk2 *)

(* declareinfix ">=";
declareinfix "=<";
declareinfix ">"; *)

(* axiom "GREATER" "?m > ?n" "?n < ?m";	 *)

(* axiom "GREATER_OR_EQ" "?m >= ?n" "(?m > ?n) | (?m = ?n)";
axiom "LESS_OR_EQ" "?m =< ?n" "(?m < ?n) | (?m = ?n)"; *)

(* _______________________________________________________________
	LESSBOOL:
	========
	(Nat : ?x) < Nat : ?y = 
	
	bool : (Nat : ?x) < Nat : ?y
   _______________________________________________________________ *)


s "(Nat:?x) < (Nat:?y)";
ri "LESS1 ** FORSOMEBOOL"; ex();
right();
rri "LESS1"; ex();

p "LESSBOOL"; 


(* _______________________________________________________________
	LESSBOOL2:
	=========
	(Nat : ?x) < Nat : ?y = 

	|- (Nat : ?x) < Nat : ?y
  _______________________________________________________________ *)


s "(Nat:?x) < (Nat:?y)";
ri "LESSBOOL";ex();
ri "ASSERT2";ex();

p "LESSBOOL2"; 


(* __________________________________________________________________  
	LESS_NOT_REFL:
	=============
	~ (Nat : ?x) < Nat : ?x = 

	true
   __________________________________________________________________ *)

s"~((Nat:?x)<Nat:?x)";
right();
ri "LESS1";ex();
right();right();right();
ri "CCON"; ex();
up();
ri "CZER"; ex();
up(); up();
ri "forsome"; ex();
right();
ri "forall";ex();
left();left();
ri "NEGF"; ex();
up();up();
ri "REFLEX"; ex();
top();
ri "DUBNEG"; ex();
rri "TRUEBOOL"; ex();

p "LESS_NOT_REFL";


(* __________________________________________________________________  
	MP_THM:
	======
	((?P @ ?x) & forall @ [(?P @ ?1) -> ?Q @ ?1]) 
	-> ?Q @ ?x = 

	true
   __________________________________________________________________ *)

s "((?P@?x) & forall @ [(?P@?1) -> (?Q@?1)])->?Q@?x ";
initializecounter();
left();right();
rri "INSTANTIATE";ex();
left();
assign "?x_1" "?x";
ri "EVAL"; ex();
top();
ri "IMPTOCOND";ex();
right();
ri "ANDUNPACK";ex();
right();left();left();
(* rri"BOOLDEF";ex();
rri"ANDBOOL";ex(); *)
up();
ri "ANDUNPACK";ex();
left();left();
rri"0|-|1";ex(); (* 0|-|1: true = ?P @ ?x  *)
up();
ri "ILID";ex();
ri "ASSERT";ex();
ri "BOOLDEF";ex();
up();ex();
up();left();right();left();right();left();
rri"0|-|2";ex();  (* 0|-|2: true = ?Q @ ?x  *)  
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();ri"AT";ex();

p "MP_THM";ex();

ae "MP_THM";wb();p "MP_THMF@?P,?Q,?x";


(* __________________________________________________________________  
	SUC_LESS:
	========
	((1 + Nat:?x) < Nat:?y) -> (Nat:?x) < Nat:?y = 

	true
   __________________________________________________________________ *)


s "((1+Nat:?x) < Nat:?y) -> (Nat:?x) < Nat:?y";
left();left();
ri "LEFT@ONENAT";ex();
ri "PLUSTYPE2";ex();
ri "RIGHT@LEFT@ $ONENAT";ex();
top();
ri "EVERYWHERE@LESS1"; ex();
rri "FORALL_IMP_FORSOME_EQ";ex();
right();right();
ri "BIND@?1";ex();
top();
ri "forall";ex();
left();left();
ri "EVAL** IMPTOCOND"; ex();
right();
ri "ANDUNPACK";ex();
right();left();
(* rri "ODDCHOICE";ex(); *)
ri "ANDUNPACK";ex();
right();left();right();left();
ri "DINSTANTIATEF1@?1"; ex();
left();ri"EVAL";ex();
left();
rri "0|-|1";ex(); (* 0|-|1: true=forall@[(?1@1+Nat:?2)->?1@Nat:?2] *)
up();right();right();
rri "0|-|3";ex(); (* 0|-|3: true = ~ ?1 @ Nat : ?y *)
up();
ri "CID";ex();
ri "ASSERTSCOUT ** BOOLDEF";ex();
left();
ri"MP_THMF@[?1@1+Nat:?2],[?1@Nat:?2],?x";ex();
left();left();ri"EVAL";ex();
right();
ri "LEFT@ONENAT";ex();
ri "PLUSTYPE2";ex();
ri "RIGHT@LEFT@ $ONENAT";ex();
up();
rri"0|-|2";ex(); (* 0|-|2: true = ?1 @ Nat : 1 + Nat : ?x  *)
up();right();
rri"0|-|1";ex();
up();
ri"CID ** AT";ex();
up();ri"ILID";ex();
ri "RIGHT@EVAL";ex();
up();
ri"REFLEX";ex();
up();
ri"CID ** AT";ex();
up();
ri"DSYM ** DZER";ex();
up();up();
rri"CASEINTRO";ex();
up();up();
rri"CASEINTRO";ex();
up();up();
rri"CASEINTRO";ex();
up();ri"AT";ex();
up();up();ri"REFLEX";ex();

p "SUC_LESS";


(* ___________________________________________________________________
	INSTANTIATEF @ ?x:
	=================
	forall @ [?P @ ?1] = 

	(?P @ ?x) & forall @ [?P @ ?1]
   ___________________________________________________________________ *)

ae "INSTANTIATE"; wb();
p "INSTANTIATEF@?x"; 


(* ___________________________________________________________________
	ElimForall @ ?thm , ?x:
	======================
	true = 
	
	ASSERT2 <= CID => (LEFT @ EVAL) => (RIGHT @ ?thm) 
	=> (INSTANTIATEF @ ?x) => ?thm <= true
  ___________________________________________________________________ *)

s "true";
rri "?thm";
ri "INSTANTIATEF@?x"; 
ri "RIGHT@?thm"; 
ri "LEFT@EVAL"; 
ri "CID"; 
rri "ASSERT2"; 

p "ElimForall@?thm,?x";


(* __________________________________________________________________  
	
	FNOT_LESS_0:
	===========
	forall @ [~ (Nat : ?1) < 0] = 

	true
  __________________________________________________________________ *)


s "forall@[~(Nat:?1) < 0]";
ri "INDUCT_TAC";ex();
left();
ri "EVERYWHERE@ZERONAT";ex();
ri "LESS_NOT_REFL";ex();
up(); right();
right();right();
rri "CONTP";ex();
ri "EVERYWHERE@ZERONAT";ex();
ri "SUC_LESS";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "FNOT_LESS_0";


(* __________________________________________________________________  
	NOT_LESS_0:
	==========
	~ (Nat : ?x) < 0 = 

	true	
  __________________________________________________________________ *)

s "true";
ri "ElimForall@FNOT_LESS_0,?x"; ex();
rri "NOTBOOL"; ex();
wb();

p "NOT_LESS_0";

ae "NOT_LESS_0"; wb();
p "NOT_LESS_0F@?x"; 


(* __________________________________________________________________    
	LEQ_0:
	=====
	(Nat : ?n) =< 0 = 

	(Nat : ?n) = 0
   __________________________________________________________________ *)

s "(Nat: ?n) =< 0";
ri "RIGHT@ZERONAT"; ex();
ri "LESS_OR_EQ"; ex();
ri "EVERYWHERE@ $ZERONAT";
rri "DRULE2";ex();
left();
rri "DUBNEG2";ex();
ri "RIGHT @ NOT_LESS_0"; ex();
rri "FDEF";ex();
up();
ri "DSYM ** DID"; ex();
rri "ASRTEQ"; ex();

p "LEQ_0"; 


(* __________________________________________________________________    
	LESS_0_0:
	========
	0 < 1 + 0 = 

	true
   __________________________________________________________________ *)

s "0 < 1 + 0";
right(); 
ri "LEFT @ ONENAT"; ex();
ri "RIGHT @ ZERONAT"; ex();
ri "PLUSCOMP"; ex();
up(); 
ri "LEFT @ ZERONAT"; ex();
ri "RIGHT @ ONENAT"; ex();
ri "LESSCOMP"; ex();

p "LESS_0_0";


(* __________________________________________________________________    
	SUB_REFL:
	========
	?x - ?x = 

	0
   __________________________________________________________________ *)

s "0";
ri "REALZERO"; ex();
initializecounter();
rri "PLUSMINUS"; ex();
assign "?y_1" "?x";
ri "PLUSCOMM";ex();
rri "BREAKMINUS";ex();
wb();

p "SUB_REFL";


(* __________________________________________________________________    
	SUC_ID:
	======
	(1 + Nat : ?x) = Nat : ?x = 

	false
   __________________________________________________________________ *)

initializecounter();
s "(1 + Nat:?x) = Nat:?x";
ri "EQUATION";ex();
right(); left();
rri "REFLEX";ex();
assign "?a_2" "(1 + Nat:?x) - Nat:?x";
left(); left();
ri "0|-|1";ex();   (* 0|-|1: (1 + Nat : ?x) = Nat : ?x  *)
up(); 
ri "SUB_REFL";ex();
up(); 
right();
ri "MINUSPLUS";ex();
rri "PLUSID";ex();
ri "PLUSCOMM";ex();
ri "RIGHT @ ZERONAT";ex();
up(); 
ri "SUCCNOTZERO";ex();
up(); up();
rri "CASEINTRO";ex();

p "SUC_ID";


ae "SUC_ID"; wb();
p "SUC_IDF@?x";


(* ___________________________________________________________________   
	SAMESUCC:
	========
	(Nat : ?m) = Nat : ?n = 

	(1 + Nat : ?m) = 1 + Nat : ?n

   ___________________________________________________________________ *)

s "(1 + Nat:?m) = 1 + Nat:?n";
initializecounter();
ri "PCASEINTRO@(Nat:?m) = Nat:?n"; ex();
right(); left(); left();
ri "RIGHT @ 0|-|1"; ex();      (* 0|-|1: (Nat : ?m) = Nat : ?n *)
up(); ri "REFLEX"; ex();
up(); right();
ri "EQUATION"; ex();
right(); left(); rri "REFLEX"; ex();
assign "?a_5" "(1 + Nat : ?m) - 1";
right(); 
ri "LEFT @ 0|-|2"; ex();      (* 0|-|2: (1 + Nat : ?m) = 1 + Nat : ?n *)
ri "(LEFT @ PLUSCOMM) ** MINUSPLUS ** $REALNAT"; ex();
up(); left();
ri "(LEFT @ PLUSCOMM) ** MINUSPLUS ** $REALNAT"; ex();
up(); ri "EQUATION ** 1|-|1"; ex();
up(); up(); rri "CASEINTRO"; ex();
top(); rri "EQUATION"; ex();
wb();

(* p "SAMESUCC"; *) 


(* ___________________________________________________________________   
	LESS_MONO:
	=========
	((Nat : ?m) < Nat : ?n) -> (1 + Nat : ?m) < 1 + Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "((Nat:?m) < Nat:?n) -> (1+Nat:?m) < 1+Nat:?n";
ri "EVERYWHERE @ ONENAT ** PLUSTYPE2 ** LESS1";ex();
rri "FORALL_IMP_FORSOME_EQ";ex();
right();right();
ri "IMPTOCOND";ex();
right();
ri "ANDUNPACK";ex();
right();left();
rri "ODDCHOICE";ex();
ri "ANDUNPACK";ex();
right();left();right();left();
ri "DINSTANTIATEF1@[(?2=1+Nat:?m)|?1@?2]";ex();
left();
ri "EVAL";ex();
left(); right(); right();
ri "RL@EVAL";ex();
up();up();up();
right();
ri "EVERYWHERE@EVAL";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
left();
ri "LEFT@REFLEX";ex();
ri "DSYM**DZER";ex();
up();
ri "CSYM**CID**NRULE1";ex();
rri "DEMb";ex();
right();
rri "NRULE1";ex();
rri "ILID";ex();
left();
ri "0|-|1";ex();  (* true = forall @ [(?1 @ 1 + Nat:?2) -> ?1 @ Nat:?2] *)
ri "INSTANTIATEF@?n";ex();
ri "RIGHT@ $0|-|1";ex();
ri "LEFT@EVAL";ex();
ri "CID**IRULE1";ex();
ri "CONTP";ex();
ri "LEFT@ $0|-|3";ex();  (* true = ~ ?1 @ Nat : ?n *)
ri "ILID";ex();
ri "NRULE1";ex();
up();
ri "IREF";ex();
up();
ri "CID**NRULE1";ex();
up();
left();right();right();
rri "3pt78";ex();
left();left();
rri "SAMESUCC";ex();
up();
ri "IMPTOCOND";ex();
right();right();left();
right();
ri "RIGHT@0|-|4";ex(); (* (Nat : ?2) = Nat : ?m *)
rri "0|-|2";ex();      (* true = ?1 @ Nat : ?m *)
up();
ri "DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();
right();
ri "IMPTOCOND";ex();
right();
ri "ODDCHOICE";ex();
right();left();
rri "DRULE3";ex();
right();
rri "TWOASSERTS";ex();
ri "ASSERT";ex();
ri "BOOLDEF";ex();
left();
ri "MP_THMF@[?1@1+Nat:?3],[?1@Nat:?3],?2";ex();
ri "EVERYWHERE@EVAL";ex();
left();
ri "RIGHT@ $0|-|1";ex(); (* true = forall @ [(?1 @ 1+Nat:?3) -> ?1 @ Nat:?3] *)
ri "CID";ex();
up();
ri "IRULE2";ex();
ri "LEFT@ $0|-|4";ex(); (* true = ?1 @ 1 + Nat : ?2 *)
ri "ILID";ex();
up();
ri "REFLEX";ex();
up();
ri "DZER";ex();
up(); up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();
ri "CID**AT";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
right(); right();
rri "SAMESUCC";ex();
ri "EQUATION";ex();
right();left();
ri "TRUEBOOL";ex();
ri "BOOLDEF";ex();
ri "RL@ $AT";ex();
rri "BCONV";ex();
(* 0|-|2 : true = ?1 @ Nat : ?m
   0|-|3 : true = ~ ?1 @ Nat : ?n  
*)
ri "(LEFT@0|-|2)**RIGHT@0|-|3";ex();
ri "EVERYWHERE@0|-|4";ex(); (* (Nat : ?n) = Nat : ?m *)
ri "BSYM ** $BDIS";ex();
ri "RIGHT@BID";ex();
rri "FDEF";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "NEGF";ex();
up();
ri "CID**AT";ex();
up();
ri "DSYM**DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();up();
ri "FORALLDROP**AT";ex();

p "LESS_MONO";

ae "LESS_MONO"; wb();
p "LESS_MONOF@?m,?n";


(* ___________________________________________________________________   
	LESS_SUC:
	========
	((Nat : ?x) < Nat : ?y) -> (Nat : ?x) < 1 + Nat : ?y = 

	true
   ___________________________________________________________________ *)

s "((Nat:?x)<Nat:?y)->((Nat:?x)<(1+Nat:?y))";
ri "EVERYWHERE @ ONENAT ** PLUSTYPE2 ** LESS1";ex();
rri "FORALL_IMP_FORSOME_EQ";ex();
right();right();
ri "BIND@?1";ex();
top(); 
ri "forall";ex();
left();left();
ri "EVAL ** IMPTOCOND";ex();
right();
ri "ANDUNPACK";ex();
right();left();
rri "ODDCHOICE";ex();
ri "ANDUNPACK";ex();
right();left();right();left();
ri "DINSTANTIATEF1@?1";ex();
left();
ri "EVAL";ex();
left();
rri "0|-|1";ex();	(* 0|-|1: true = forall@[(?1@1+Nat:?2)->?1@Nat:?2] *)
up();right();left();
rri "0|-|2";ex();       (* 0|-|2: true = ?1 @ Nat : ?x  *)
up();
ri "CSYM**CID";ex();
ri "ASSERTSCOUT ** BOOLDEF";ex();
left();
ri "MP_THMF@[?1@1+Nat:?2],[?1@Nat:?2],Nat:?y";ex();
ri "CONTP";ex();
ri "EVERYWHERE@EVAL"; ex();
ri "EVERYWHERE@TYPES"; ex();
ri "LEFT@ $0|-|3";ex();  (* 0|-|3: true =  ~?1 @ Nat : ?y  *)
ri "ILID";ex();
right();right();right();
rri "0|-|1";ex();
up();
ri "CID";ex();
up();
ri "NRULE2";ex();
up();up();
ri "EVERYWHERE @ $PLUSTYPE2"; ex();
ri "EVERYWHERE @ $ONENAT"; ex();
ri "REFLEX";ex();
up();
ri "CID**AT";ex();
up();
ri "ALTORDEF";ex();
ri "LEFT@REFLEX";ex();
up();up();
rri"CASEINTRO";ex();
up(); up();
rri"CASEINTRO";ex();
up();up();
rri"CASEINTRO";ex();
up();
ri "AT";ex();
top();
ri "REFLEX";ex();

p "LESS_SUC";


ae "LESS_SUC"; wb();
p "LESS_SUCF@?x,?y";


(* ___________________________________________________________________   
	FORALL_LESS_SUC_REFL:
	====================
	forall @ [(Nat : ?1) < 1 + Nat : ?1] = 

	true
   ___________________________________________________________________ *)

s "forall@[(Nat:?1) < 1+Nat:?1]";
ri "INDUCT_TAC"; ex();
ri "LEFT@LESS_0_0"; ex();
right(); right(); right();
ri "EVERYWHERE@ONENAT"; ex();
left(); 
ri "RIGHT@PLUSTYPE2"; ex();
up(); right(); right();
ri "RIGHT@PLUSTYPE2"; ex();
up(); up(); 
ri "EVERYWHERE@ $ONENAT"; ex();
ri "LESS_MONO"; ex();
up(); up();
ri "FORALLDROP ** AT"; ex();
up(); 
ri "CID ** AT"; ex();

p "FORALL_LESS_SUC_REFL";


(* ___________________________________________________________________   
	LESS_SUC_REFL:
	=============
	(Nat : ?x) < 1 + Nat : ?x = 

	true
   ___________________________________________________________________ *)

s "true";
ri "ElimForall@FORALL_LESS_SUC_REFL,?x"; ex();
ri "EVERYWHERE@(ONENAT ** PLUSTYPE2)"; ex();
rri "LESSBOOL"; ex();
ri "LEFT @ $ZERONAT"; ex(); 
ri "RIGHT @ $PLUSTYPE2"; ex();
ri "EVERYWHERE @ $ONENAT"; ex();
wb();

p "LESS_SUC_REFL";


ae "LESS_SUC_REFL"; wb();
p "LESS_SUC_REFLF@?x"; 


(* ___________________________________________________________________   
	LESS_LEMMA2:
	===========
	(((Nat : ?x) = Nat : ?y) | (Nat : ?x) < Nat : ?y) 
	-> (Nat : ?x) < 1 + Nat : ?y = 

	true
   ___________________________________________________________________ *)

s "(((Nat:?x)=Nat:?y)|(Nat:?x)<Nat:?y) -> (Nat:?x)<1+Nat:?y";
rri "3pt78";ex();
ri "RIGHT@LESS_SUC"; ex();
left(); 
ri "IMPTOCOND";ex();
right(); right(); left(); 
ri "LEFT @ 0|-|1";ex();    (* 0|-|1: (Nat : ?x) = Nat : ?y  *)
ri "LESS_SUC_REFL"; ex();
up(); up();
rri "CASEINTRO"; ex();
up(); 
ri "AT"; ex();
up(); 
ri "CID ** AT"; ex();

p "LESS_LEMMA2";

ae "LESS_LEMMA2"; wb();
p "LESS_LEMMA2F@?x,?y";


(* ___________________________________________________________________   
	LESS_LEMMA1:
	===========
	((Nat : ?x) < 1 + Nat : ?y) 
	-> ((Nat : ?x) = Nat : ?y) | (Nat : ?x) < Nat : ?y = 

	true
   ___________________________________________________________________ *)

s "((Nat :?x) < 1+Nat:?y) -> ((Nat:?x) = Nat:?y) | (Nat:?x) < Nat:?y";
ri "EVERYWHERE @ ONENAT ** PLUSTYPE2 ** LESS1"; ex();
rri "FORALL_IMP_FORSOME_EQ"; ex();
right();right();
ri "BIND@?1";ex();
top(); 
ri "forall";ex();
left(); right();
ri "EVAL**IMPTOCOND";ex();
right();
ri "ANDUNPACK";ex();
right();left();
rri "ODDCHOICE";ex();
ri "ANDUNPACK";ex();
right();left();right();left();
ri "PCASEINTRO@(Nat:?x)=Nat:?y";ex();
right();left();left();
ri "LEFT@0|-|4";ex();  (* (Nat : ?x) = Nat : ?y *)
ri "REFLEX";ex();
up();
ri "DSYM**DZER";ex();
up(); right();right(); 
ri "DINSTANTIATEF1@[(~ ?2=Nat:?y)&?1@?2]";ex();
left();
ri "EVAL";ex();
ri "EVERYWHERE@EVAL";ex();
right();
ri "EVERYWHERE@ $0|-|2";ex(); (* true = ?1 @ Nat : ?x *)
right();right();
ri "LEFT@RIGHT@REFLEX";ex();
ri "LEFT@ $FDEF";ex();
ri "CSYM**CZER";ex();
up();
ri "NEGF";ex();
up();
ri "CID";ex();
ri "RIGHT@CID";ex();
ri "TWOASSERTS**NRULE1";ex();
right();
ri "EQUATION**1|-|4";ex(); (* (Nat : ?x) = Nat : ?y *)
up();
ri "NEGF";ex();
up();left();right();right();
ri "RL@EVAL";ex();
ri "CONTP";ex();
ri "RL@ $DEMa";ex();
ri "EVERYWHERE@DUBNEG2 ** DRULE2";ex();
rri "3pt78";ex();
ri "RL@IMPTOCOND";ex();
left(); right(); right(); left();right();right();right();
ri "RIGHT@0|-|5";ex(); (* (Nat : ?2) = Nat : ?y *)
ri "LEFT@ONENAT";ex();
ri "PLUSTYPE2";ex();
up();up();
rri "0|-|3";ex(); (* true = ~ ?1 @ Nat : (Nat : 1) + Nat : ?y *)
up();
ri "DZER";ex();
up(); up();
rri "CASEINTRO";ex();
up(); up(); right(); right();
ri "ODDCHOICE";ex();
right();left();
rri "DRULE3";ex();
right();
rri "ILID";ex();
left();
ri "0|-|1";ex(); (* true = forall @ [(?1 @ 1 + Nat:?3) -> ?1 @ Nat:?3] *)
ri "INSTANTIATEF@?2";ex();
ri "LEFT@EVAL";ex();
ri "RIGHT@ $0|-|1";ex();
ri "CID**IRULE1";ex();
ri "CONTP";ex();
ri "LEFT@ $0|-|5";ex(); (* true = ~ ?1 @ Nat : ?2 *)
ri "ILID**NRULE1";ex();
up();
ri "IREF";ex();
up();
ri "DZER";ex();
up(); up();
rri "CASEINTRO";ex();
up();up();
ri "CIDEM";ex();
ri "TWOASSERTS**AT";ex();
up(); up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();
up();
ri "DSYM**DZER";ex();
up(); 
ri "DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();up();
ri "REFLEX";ex();

p "LESS_LEMMA1";


ae "LESS_LEMMA1"; wb();
p "LESS_LEMMA1F@?x,?y";


(* ___________________________________________________________________   
	LESS_THM:
	========
	(Nat : ?x) < 1 + Nat : ?y = 

	((Nat : ?x) = Nat : ?y) | (Nat : ?x) < Nat : ?y
   ___________________________________________________________________ *)

s "(Nat:?x)<1+Nat:?y";
right(); 
ri "(LEFT @ ONENAT) ** PLUSTYPE2"; ex();
up();
ri "LESSBOOL ** BOOLDEF"; ex();
left(); 
rri "AT"; ex();
rri "CID"; ex();
ri "LEFT @ LESS_LEMMA2F@?x,?y"; ex();
ri "RIGHT @ LESS_LEMMA1F@?x,?y"; ex();
ri "3pt80"; ex();
rri "BRULE1"; ex();
up(); 
ri "RIGHT @ (LESSBOOL ** ASSERT2)"; ex();
rri "BCONV"; ex();
right(); right();
rri "PLUSTYPE2"; ex();
ri "LEFT @ $ONENAT"; ex();
up(); up();
ri "BASSOC ** (RIGHT @ BID) ** BID2"; ex();
ri "DRULE1"; ex();

p "LESS_THM"; 


(* ___________________________________________________________________   
	LESS_SUC_IMP:
	============
	((Nat : ?m) < 1 + Nat : ?n) 
	-> ( ~(Nat : ?m) = Nat : ?n) -> (Nat : ?m) < Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "((Nat:?m) < 1+Nat:?n) -> (~(Nat:?m)=Nat:?n) -> (Nat:?m) < Nat:?n";
left(); 
ri "LESS_THM"; ex();
up(); right(); 
ri "IDEF2"; ex();
ri "LEFT @ DUBNEG2"; ex();
ri "DRULE2"; ex();
up(); 
ri "IREF"; ex();

p "LESS_SUC_IMP";


ae "LESS_SUC_IMP"; wb();
p "LESS_SUC_IMPF@?m,?n";


(* ___________________________________________________________________   
	FORALL_LESS_0:
	=============
	forall @ [0 < 1 + Nat : ?1] = 

	true
   ___________________________________________________________________ *)

s "forall @ [0 < 1 + Nat:?1]";
ri "INDUCT_TAC"; ex();
ri "LEFT @ LESS_0_0"; ex();
right(); right(); right();
right(); right(); right();
ri "LEFT @ ONENAT"; ex();
ri "PLUSTYPE2"; ex();
up(); up(); up();
ri "EVERYWHERE @ ZERONAT"; ex();
ri "RL @ LESS_THM"; ex();
ri "IDEF2"; ex();
right(); right(); right();
rri "PLUSTYPE2"; ex();
ri "LEFT @ $ONENAT"; ex();
up(); 
ri "LESS_THM"; ex();
up(); up(); 
ri "EVERYWHERE @ $ZERONAT"; ex();
right(); left(); right();
rri "PLUSTYPE2"; ex();
ri "LEFT @ $ONENAT"; ex();
up(); up(); up();
ri "LEFT @ $DEMb"; ex();
ri "DSYM ** DDISC"; ex();
left(); left();
ri "GET @ (0 = Nat : ?1), DSYM, DASSOC"; ex();
up(); 
ri "GET @ (~0 = Nat : ?1), DSYM, DASSOC"; ex();
rri "DASSOC"; ex();
ri "LEFT @ (DSYM ** DXM)"; ex();
ri "DSYM ** DZER"; ex();
up(); right();
ri "DASSOC"; ex();
right(); 
ri "DASSOC"; ex();
ri "RIGHT @ DXM"; ex();
ri "DZER"; ex();
up(); 
ri "DZER"; ex();
up(); 
ri "CID ** AT"; ex();
up(); up(); 
ri "FORALLDROP ** AT"; ex();
up(); 
ri "CID ** AT"; ex();

p "FORALL_LESS_0";


(* ___________________________________________________________________   
	LESS_0:
	======
	0 < 1 + Nat : ?x = 

	true
   ___________________________________________________________________ *)

s "true";
ri "ElimForall @ FORALL_LESS_0,?x"; ex();
ri "EVERYWHERE @ (ONENAT ** ZERONAT ** PLUSTYPE2)"; ex();
rri "LESSBOOL"; ex();
ri "LEFT @ $ZERONAT"; ex(); 
ri "RIGHT @ $PLUSTYPE2"; ex();
ri "EVERYWHERE @ $ONENAT"; ex();
wb();

p "LESS_0";


ae "LESS_0"; wb();
p "LESS_0F@?x";


(* ___________________________________________________________________   
	SUC_EQ_LESS:
	===========
	((1 + Nat : ?x) = Nat : ?y) -> (Nat : ?x) < Nat : ?y = 

	true
   ___________________________________________________________________ *)

s "((1+Nat:?x) = Nat: ?y) -> ( Nat:?x) <  Nat:?y";
ri "EVERYWHERE @ (ONENAT ** PLUSTYPE2)"; ex();
ri "EVERYWHERE @ LESS1"; ex();
ri "IMPTOCOND"; ex();
right(); right(); left(); 
right(); right(); right(); right(); right(); right();
rri "0|-|1";ex();   (* 0|-|1: (Nat : (Nat : 1) + Nat : ?x) = Nat : ?y *)
top(); right(); right(); left();
rri "LESS1"; ex();
ri "RIGHT @ $PLUSTYPE2"; ex();
ri "EVERYWHERE @ $ONENAT"; ex();
ri "LESS_SUC_REFL"; ex();
up(); up(); 
rri "CASEINTRO"; ex();
up(); 
ri "AT"; ex();

p "SUC_EQ_LESS";


ae "SUC_EQ_LESS"; wb();
p "SUC_EQ_LESSF@?x,?y";


(* ___________________________________________________________________   
	EQ_NOT_LESS:
	===========
	((Nat : ?x) = Nat : ?y) ->  ~(Nat : ?x) < Nat : ?y = 

	true
   ___________________________________________________________________ *)

s "((Nat:?x) = Nat:?y) -> ~(Nat:?x) < Nat:?y";
ri "IMPTOCOND";ex();
right(); right(); left(); right();
ri "LEFT @ 0|-|1";ex();   (* 0|-|1: (Nat : ?x) = Nat : ?y *)
up(); 
ri "LESS_NOT_REFL";ex();
up(); up(); 
rri "CASEINTRO";ex();
up(); 
ri "AT"; ex();

p "EQ_NOT_LESS";


ae "EQ_NOT_LESS"; wb();
p "EQ_NOT_LESSF@?x,?y";


(* ___________________________________________________________________   
	LESS_NOT_EQ:
	===========
	((Nat : ?x) < Nat : ?y) ->  ~(Nat : ?x) = Nat : ?y = 

	true
   ___________________________________________________________________ *)

s "((Nat:?x) < Nat:?y) -> ~(Nat:?x) = Nat:?y";
ri "CONTP"; ex();
left(); 
ri "DUBNEG";ex();
rri "EQBOOL";ex();
up(); 
ri "EQ_NOT_LESS";ex();

p "LESS_NOT_EQ";


ae "LESS_NOT_EQ"; wb();
p "LESS_NOT_EQF@?x,?y";


(* ___________________________________________________________________   
	LESS_SUC_SUC:
	============
	(Nat : ?x) < 1 + 1 + Nat : ?x = 

	true
   ___________________________________________________________________ *)

s "(Nat : ?x) < 1 + 1 + Nat : ?x";
right(); right();
ri "LEFT @ ONENAT"; ex();
ri "PLUSTYPE2"; ex();
up(); up();
ri "LESS_THM"; ex();
right(); right();
rri "PLUSTYPE2"; ex();
ri "LEFT @ $ONENAT"; ex();
up(); 
ri "LESS_SUC_REFL"; ex();
up(); 
ri "DZER"; ex();

p "LESS_SUC_SUC";


ae "LESS_SUC_SUC"; wb();
p "LESS_SUC_SUCF@?x";


(* ___________________________________________________________________   
	LEQ_SUC:
	=======
	(Nat : ?n) =< 1 + Nat : ?m = 

	((Nat : ?n) =< Nat : ?m) | (Nat : ?n) = 1 + Nat : ?m
   ___________________________________________________________________ *)

s "(Nat:?n) =< 1 + Nat:?m";
ri "EVERYWHERE@ONENAT"; ex();
ri "RIGHT@PLUSTYPE2";
ri "LESS_OR_EQ"; ex();
ri "EVERYWHERE@ $PLUSTYPE2"; ri "EVERYWHERE@ $ONENAT"; ex();
left();
ri "LESS_THM ** DSYM"; ex();
rri "LESS_OR_EQ"; ex();

p "LEQ_SUC";


(* ___________________________________________________________________   
	LESS_MONO_REV:
	=============
	((1 + Nat : ?m) < 1 + Nat : ?n) -> (Nat : ?m) < Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "((1+Nat:?m) < 1+Nat:?n) -> (Nat:?m) < Nat:?n";
left(); left();
ri "LEFT @ ONENAT"; ex();
ri "PLUSTYPE2"; ex();
up(); 
ri "LESS_THM"; ex();
ri "EVERYWHERE @ $PLUSTYPE2"; ex();
ri "EVERYWHERE @ $ONENAT"; ex();
up(); 
rri "3pt78"; ex();
ri "RIGHT @ SUC_LESS"; ex();
ri "CID ** IRULE1"; ex();
ri "SUC_EQ_LESS"; ex();

p "LESS_MONO_REV";

ae "LESS_MONO_REV"; wb();
p "LESS_MONO_REVF@?m,?n";


(* ___________________________________________________________________   
	LESS_MONO_EQ:
	============
	(Nat : ?m) < Nat : ?n = 

	(1 + Nat : ?m) < 1 + Nat : ?n
   ___________________________________________________________________ *)

s "(Nat:?m) < Nat:?n";
ri "LESSBOOL ** BOOLDEF"; ex();
left(); 
rri "AT"; ex();
rri "CID"; ex();
ri "LEFT @ LESS_MONOF@?m,?n"; ex();
ri "RIGHT @ LESS_MONO_REVF@?m,?n"; ex();
ri "3pt80 ** BSYM"; ex();
rri "BRULE1"; ex();
up(); 
ri "RIGHT @ (LESSBOOL ** ASSERT2)"; ex();
rri "BCONV"; ex();
ri "BASSOC ** (RIGHT @ BID) ** BID2"; ex();
rri "ASSERT2"; ex();
ri "EVERYWHERE @ (ONENAT ** PLUSTYPE2)"; ex();
rri "LESSBOOL"; ex();
ri "RL @ $PLUSTYPE2"; ex();
ri "EVERYWHERE @ $ONENAT"; ex();

p "LESS_MONO_EQ";

(* ___________________________________________________________________   
	LESS_EQ_SUC_LESS:
	================
	((1 + Nat : ?n) < Nat : ?m) | (1 + Nat : ?n) = Nat : ?m = 

	(Nat : ?n) < Nat : ?m
   ___________________________________________________________________ *)

s "((1+Nat:?n) < Nat:?m) | (1+Nat:?n) = Nat:?m";
ri "EVERYWHERE @ (ONENAT ** PLUSTYPE2)"; ex();
ri "DSYM ** $LESS_THM"; ex();
left(); 
rri "PLUSTYPE2"; ex();
ri "LEFT @ $ONENAT"; ex();
up();
rri "LESS_MONO_EQ"; ex();

p "LESS_EQ_SUC_LESS";

(* ___________________________________________________________________   
	LESS_0_CASES:
	============
	(0 = Nat : ?m) | 0 < Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "(0 = Nat:?m) | 0 < Nat:?m";
ri "EVERYWHERE @ ZERONAT"; ex();
rri "LESS_THM"; ex();
ri "LEFT @ $ZERONAT"; ex();
ri "LESS_0"; ex();

p "LESS_0_CASES";


(* ___________________________________________________________________   
	LESS_0_CASES_INV:
	================
	(0 < Nat : ?m) | 0 = Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "(0 < Nat:?m) | 0 = Nat:?m";
ri "DSYM ** LESS_0_CASES"; ex();

p "LESS_0_CASES_INV";


(* ___________________________________________________________________   
	FORALL_LESS_CASES:
	=================
	forall 
	@ [((Nat : ?1) < Nat : ?m) 
	   | ((Nat : ?1) = Nat : ?m) | (Nat : ?m) < Nat : ?1] = 

	true
   ___________________________________________________________________ *)


s "forall@[((Nat:?1)<Nat:?m) | ((Nat:?1)=Nat:?m) | (Nat:?m)<Nat:?1]";
ri "INDUCT_TAC";ex();
left();
rri "DASSOC";ex();
ri "LEFT@LESS_0_CASES_INV";ex();
ri "DSYM**DZER";ex();
up();
right();right();right();
ri "IMPTOCOND";ex();
right();
ri "OR_EXP";ex();
ri "ODDCHOICE";ex();
right();right();
ri "ODDCHOICE";ex();
right();left();
right();right();
ri "LESS_THM";ex();
ri "LEFT@EQSYMM";ex();
rri "0|-|2";ex();  (* 0|-|2: true = ((Nat:?1)=Nat:?m)|(Nat:?m)<Nat:?1 *)
up();
ri "DZER";ex();
up();
ri "DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();left();
rri "DASSOC";ex();
left();
ri "LESS_EQ_SUC_LESS";ex();
rri "0|-|1";ex();  (* 0|-|1: true = (Nat : ?1) < Nat : ?m  *)
up();
ri "DSYM**DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "FORALL_LESS_CASES";


(* ___________________________________________________________________   
	LESS_CASES:
	==========
	((Nat : ?n) < Nat : ?m) | ((Nat : ?n) = Nat : ?m) 
	| (Nat : ?m) < Nat : ?n = 

	true
   ___________________________________________________________________ *)

initializecounter();
s "true";
ri "ElimForall @ FORALL_LESS_CASES,?n"; ex();
assign "?m_2" "?m";
rri "ORBOOL"; ex();
wb();

p "LESS_CASES";

ae "LESS_CASES"; wb();
p "LESS_CASESF@?n,?m";


(* ___________________________________________________________________   
	LESS_CASES_IMP:
	==============
	(~ ((Nat : ?m) < Nat : ?n) | (Nat : ?m) = Nat : ?n) 
	-> (Nat : ?n) < Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "(~ ((Nat:?m) < Nat:?n) | (Nat:?m) = Nat:?n) -> (Nat:?n) < Nat:?m";
ri "IF";ex();
ri "LEFT@DUBNEG2**DRULE1";ex();
ri "DASSOC";ex();
ri "LESS_CASES";ex();

p "LESS_CASES_IMP";


(* ___________________________________________________________________   
	LESS_OR:
	=======
	((Nat : ?m) < Nat : ?n) -> (1 + Nat : ?m) =< Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "((Nat:?m) < Nat:?n) -> (1+Nat:?m) =< Nat:?n";
right(); ri "EVERYWHERE@ONENAT"; ri "EVERYWHERE@PLUSTYPE2"; ex();
ri "LESS_OR_EQ ** DSYM"; ex();
(* ri "EVERYWHERE @ (ONENAT ** PLUSTYPE2)"; ex(); *)
rri "LESS_THM"; ex();
left(); 
rri "PLUSTYPE2"; ex();
ri "LEFT @ $ONENAT"; ex();
top(); 
ri "LESS_MONO"; ex();

p "LESS_OR";


(* ___________________________________________________________________   
	OR_LESS:
	=======
	((1 + Nat : ?m) =< Nat : ?n) -> (Nat : ?m) < Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "((1+Nat:?m) =< Nat:?n) -> (Nat:?m) < Nat:?n";
ri "LEFT@EVERYWHERE@ONENAT**PLUSTYPE2"; ex();
ri "LEFT @ LESS_OR_EQ"; ex();
ri "TOPDOWN@($PLUSTYPE2)**($ONENAT)"; ex();
rri "3pt78"; ex();
ri "LEFT @ SUC_LESS"; ex();
ri "RIGHT @ SUC_EQ_LESS"; ex();
ri "CID ** AT"; ex();

p "OR_LESS";


(* ___________________________________________________________________   
	LESS_EQ:
	=======
	(1 + Nat : ?m) =< Nat : ?n = 

	(Nat : ?m) < Nat : ?n
   ___________________________________________________________________ *)

s "(1+Nat:?m) =< Nat:?n";
ri "EVERYWHERE@ONENAT**PLUSTYPE2"; ex();
ri "LESS_OR_EQ ** DSYM"; ex();
(* ri "EVERYWHERE @ (ONENAT ** PLUSTYPE2)"; ex(); *)
rri "LESS_THM"; ex();
left(); 
rri "PLUSTYPE2"; ex();
ri "LEFT @ $ONENAT"; ex();
up(); 
rri "LESS_MONO_EQ"; ex();

p "LESS_EQ";


(* ___________________________________________________________________   
	LEQ_SUC_REFL:
	============
	(Nat : ?m) =< 1 + Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "(Nat:?m) =< 1 + Nat:?m";
ri "EVERYWHERE@ONENAT**PLUSTYPE2"; ex();
ri "LESS_OR_EQ"; ex();
ri "TOPDOWN@($PLUSTYPE2)**($ONENAT)"; ex();
ri "LEFT @ LESS_SUC_REFL"; ex();
ri "DSYM ** DZER"; ex();

p "LEQ_SUC_REFL";


(* ___________________________________________________________________   
	ALL_GEQ_0:
	=========
	0 =< Nat : ?x = 

	true
   ___________________________________________________________________ *)

s "0 =< Nat:?x";
ri "LEFT@ZERONAT"; ex();
ri "LESS_OR_EQ"; ex();
ri "EVERYWHERE@ $ZERONAT"; ex();
ri "DSYM ** LESS_0_CASES"; ex();

p "ALL_GEQ_0";


(* ___________________________________________________________________   
	LESS_EQ_MONO:
	============
	(1 + Nat : ?n) =< 1 + Nat : ?m = 

	(Nat : ?n) =< Nat : ?m
   ___________________________________________________________________ *)

s "(1+Nat:?n) =< 1+Nat:?m";
ri "EVERYWHERE@ONENAT**PLUSTYPE2"; ex();
ri "LESS_OR_EQ"; ex();
ri "TOPDOWN@($PLUSTYPE2)**($ONENAT)"; ex();
right(); 
rri "SAMESUCC"; ex();
up(); 
ri "LEFT @ $LESS_MONO_EQ"; ex();
rri "LESS_OR_EQ"; ex();

p "LESS_EQ_MONO";



(* ___________________________________________________________________   
	LESS_SUC_EQ_COR:
	===============
	(((Nat : ?m) < Nat : ?n) &  ~(1 + Nat : ?m) = Nat : ?n) 
	-> (1 + Nat : ?m) < Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "(((Nat:?m) < Nat:?n) & ~(1+Nat:?m) = Nat:?n) -> (1+Nat:?m) < Nat:?n";
ri "IDEF2"; ex();
left(); 
rri "DEMa"; ex();
ri "(RIGHT @ DUBNEG2) ** DRULE3"; ex();
up(); 
ri "DASSOC"; ex();
rri "IDEF2"; ex();
right();
ri "DSYM"; ex();
ri "EVERYWHERE@ONENAT**PLUSTYPE2"; ex();
rri "LESS_OR_EQ"; ex();
ri "TOPDOWN@($PLUSTYPE2)**($ONENAT)"; ex();
up();
ri "LESS_OR"; ex();

p "LESS_SUC_EQ_COR";


(* ___________________________________________________________________   
	LESS_NOT_SUC:
	============
	(((Nat : ?m) < Nat : ?n) &  ~(Nat : ?n) = 1 + Nat : ?m) 
	-> (1 + Nat : ?m) < Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "(((Nat:?m) < Nat:?n) & ~(Nat:?n) = 1+Nat:?m) -> (1+Nat:?m) < Nat:?n";
left(); right(); 
ri "RIGHT @ EQSYMM"; ex();
top();
ri "LESS_SUC_EQ_COR"; ex();

p "LESS_NOT_SUC";


(* ___________________________________________________________________   
	NOT_ADD_LESS:	
	============
	forall @ [~ ((Nat : ?x) + Nat : ?1) < Nat : ?1] = 

	true
   ___________________________________________________________________ *)

s "forall@[~((Nat : ?x) +  Nat : ?1) < Nat: ?1]";
ri "INDUCT_TAC"; ex();
left(); right(); left(); 
ri "PLUSCOMM ** PLUSID ** $REALNAT"; ex();
up();up();
ri "NOT_LESS_0"; ex();
up();
right(); right(); right();
rri "CONTP";ex();
left(); left();
ri "PLUSCOMM";ex();
ri "PLUSASSOC";ex();
ri "RIGHT@PLUSCOMM**PLUSTYPE2";ex();
up();up();
right();
ri "LEFT@PLUSTYPE2";ex();
up();
ri "LESS_MONO_REV";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "NOT_ADD_LESS";


ae "NOT_ADD_LESS"; wb();
p "NOT_ADD_LESSF@?x"; 


(* ___________________________________________________________________   
	LEQ_REFL:
	========
	(Nat : ?m) =< Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "(Nat:?m) =< Nat:?m";
ri "LESS_OR_EQ"; ex();
ri "RIGHT @ REFLEX"; ex();
ri "DZER"; ex();

p "LEQ_REFL";


(* ___________________________________________________________________   
	LESS_IMP_LEQ:
	============
	((Nat : ?m) < Nat : ?n) -> (Nat : ?m) =< Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "((Nat:?m) < Nat:?n) -> (Nat:?m) =< Nat:?n";
ri "RIGHT @ LESS_OR_EQ"; ex();
ri "3pt76a"; ex();

p "LESS_IMP_LEQ";


(* ___________________________________________________________________   
	FORALL_LESS_TRANS:
	=================
	forall @ [(((Nat:?m) < Nat:?n) & (Nat:?n) < Nat:?1) 
	   -> (Nat:?m) < Nat:?1] = 

	true
__________________________________________________________________ *)

s "forall@[(((Nat:?m) < Nat:?n) & (Nat:?n) < Nat:?1) -> (Nat:?m) < Nat:?1]";
ri "INDUCT_TAC";ex();
left();left();
rri "CRULE3";ex();
right();
rri "DUBNEG2";ex();
ri "RIGHT@NOT_LESS_0"; ex();
rri "FDEF";ex();
up();
ri "CZER";ex();
up();
ri "3pt75"; ex();
up(); right(); right(); right();
ri "IMPTOCOND";ex();
right();
ri "ODDCHOICE";ex();
right();left();
ri "EVERYWHERE@LESS_THM";ex();
ri "IMPTOCOND";ex();
right();
ri "ANDUNPACK";ex();
right();left();
rri "ODDCHOICE";ex();
ri "OR_EXP";ex();
right();left();
right();
ri "RIGHT@ $0|-|3";ex(); (* 0|-|3: (Nat : ?n) = Nat : ?1  *)
rri "0|-|2";ex();  (* 0|-|2: true = (Nat : ?m) < Nat : ?n  *)
up();
ri "DZER";ex();
up();right();
ri "ODDCHOICE";ex();
right();left();
rri "DRULE3";ex();
right();
rri "ILID";ex();
left();
(* 0|-|1:  true = (((Nat:?m) < Nat:?n) & (Nat:?n) < Nat:?1) 
		-> (Nat:?m) < Nat:?1
*)
ri "0|-|1";ex(); 
left();
ri "LEFT@ $0|-|2";ex();
ri "RIGHT@ $0|-|4";ex(); (* 0|-|4: true = (Nat : ?n) < Nat : ?1  *)
ri "CID**AT";ex();
up();
ri "ILID";ex();
up();
ri"IRULE2";ex();
ri "IREF";ex();
up();
ri "DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "FORALL_LESS_TRANS";


(* ___________________________________________________________________   
	LESS_TRANS:
	==========
	(((Nat : ?m) < Nat : ?n) & (Nat : ?n) < Nat : ?p) 
	-> (Nat : ?m) < Nat : ?p = 

	true
   ___________________________________________________________________ *)

initializecounter();
s "true";
ri "ElimForall@FORALL_LESS_TRANS,?p";ex();
assign "?m_2" "?m";
assign "?n_2" "?n";
rri "IFBOOL";ex();
wb();

p "LESS_TRANS";

ae "LESS_TRANS"; wb();
p "LESS_TRANSF@?m,?n,?p";


(* ___________________________________________________________________   
	FORALL_LESS_ANTISYM:
	===================
	forall @ [~ ((Nat:?m) < Nat:?1) & (Nat:?1) < Nat:?m] = 

	true
   ___________________________________________________________________ *)


s "forall@[~((Nat:?m) < Nat:?1) & (Nat:?1) < Nat:?m]";
ri "INDUCT_TAC"; ex();
left(); right();
rri "CRULE2";ex();
left();
rri "DUBNEG2";ex();
ri "RIGHT@NOT_LESS_0"; ex();
rri "FDEF";ex();
up();
ri "CSYM**CZER"; ex();
up();
ri "NEGF"; ex();
up();
right(); right(); right(); 
rri "CONTP"; ex();
ri "IMPTOCOND";ex();
right();
ri "ANDUNPACK";ex();
right();left();right();left();
rri "CRULE1";ex();
rri "ILID";ex();
left();
ri "LESS_TRANSF@?m,((Nat:1)+Nat:?1),?m";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
left();
(* 0|-|1: true = (Nat : ?m) < 1 + Nat : ?1
   0|-|2: true = (1 + Nat : ?1) < Nat : ?m
*)	
ri "(LEFT@ $0|-|1)**RIGHT@ $0|-|2";ex();
ri "CID**AT";ex();
up();
ri "CONTP";ex();
ri "LEFT@LESS_NOT_REFL";ex();
ri "ILID";ex();
ri "(RIGHT@ $FDEF)**AF";ex();
up();
ri "3pt75";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "FORALL_LESS_ANTISYM";


(* ___________________________________________________________________   
	LESS_ANTISYM:
	============
	~ ((Nat : ?m) < Nat : ?n) & (Nat : ?n) < Nat : ?m = 

	true
   ___________________________________________________________________ *)

initializecounter();
s "true";
ri "ElimForall@FORALL_LESS_ANTISYM,?n";ex();
assign "?m_2" "?m";
rri "NOTBOOL";ex();
wb();

p "LESS_ANTISYM";

ae "LESS_ANTISYM"; wb();
p "LESS_ANTISYMF@?m,?n";


(* ___________________________________________________________________   
	LESS_LESS_SUC:
	=============
	~ ((Nat:?m) < Nat:?n) & (Nat:?n) < 1 + Nat:?m = 

	true
   ___________________________________________________________________ *)

s "~((Nat:?m) < Nat:?n) & (Nat:?n) < 1+Nat:?m";
right();
ri "RIGHT@LESS_THM";ex();
ri "CDISD";ex();
left();
ri "CSYM**AND";ex();
rri "ODDCHOICE";ex();
right();left();
rri "BOOLDEF";ex();
rri "DUBNEG";ex();
right();
ri "RIGHT@RIGHT@0|-|1";ex(); (* 0|-|1: (Nat : ?n) = Nat : ?m  *)
ri "LESS_NOT_REFL";ex();
up();
rri "FDEF";ex();
up();up();
rri "CASEINTRO";ex();
up(); 
rri "DRULE3";ex();
right();
rri "DUBNEG2";ex();
ri "RIGHT@LESS_ANTISYM";ex();
rri "FDEF";ex();
up();
ri "DID**AF";ex();
up();
ri "NEGF";ex();

p "LESS_LESS_SUC";


(* ___________________________________________________________________   
	BOUNDED_N:
	=========
	(((Nat : ?m) < Nat : ?n) & (Nat : ?n) =< 1 + Nat : ?m) 
	-> (Nat : ?n) = 1 + Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "(((Nat:?m) < Nat:?n) & (Nat:?n) =< 1+Nat:?m) -> (Nat:?n) = 1+Nat:?m";
left();
ri "RIGHT@EVERYWHERE@ONENAT**PLUSTYPE2"; ex(); 
ri "RIGHT@LESS_OR_EQ"; ex();
ri "RIGHT@TOPDOWN@($PLUSTYPE2)**($ONENAT)"; ex();
ri "CDISD"; ex();
rri "DRULE2";ex();
left();
rri "DUBNEG2";ex();
ri "RIGHT@LESS_LESS_SUC"; ex();
rri "FDEF";ex();
up();
ri "DSYM**DID";ex();
ri "CRULE1";ex();
up();
rri "3pt65"; ex();
ri "RIGHT@IREF"; ex();
ri "IRZER"; ex();

p "BOUNDED_N";


(* ___________________________________________________________________   
	FORALL_LESS_MONO_ADD:
	====================
	forall @ [((Nat : ?m) < Nat : ?n) 
	-> ((Nat : ?m) + Nat : ?1) < (Nat : ?n) + Nat : ?1] = 

	true
   ___________________________________________________________________ *)

s "forall@[((Nat:?m)<Nat:?n) -> ((Nat:?m)+Nat:?1) < (Nat:?n)+Nat:?1]";
ri "INDUCT_TAC"; ex();
left(); right();
ri "RL @ PLUSCOMM ** PLUSID"; ex();
ri "RL @ $REALNAT"; ex();
up();
ri "IREF"; ex();
up(); right();
right(); right();
ri "3pt64"; ex();
right(); right();
ri "RL @ $PLUSASSOC"; ex();
ri "(LEFT@LEFT@PLUSCOMM) ** RIGHT@LEFT@PLUSCOMM"; ex();
ri "RL @ PLUSASSOC"; ex();
ri "(LEFT@RIGHT@PLUSTYPE2) ** RIGHT@RIGHT@PLUSTYPE2"; ex();
rri "LESS_MONO_EQ"; ex();
ri "RL @ $PLUSTYPE2"; ex();
up(); 
ri "IREF"; ex();
up();
ri "IRZER"; ex();
up(); up(); 
ri "FORALLDROP ** AT"; ex();
up();
ri "CID ** AT"; ex();

p "FORALL_LESS_MONO_ADD";


ae "FORALL_LESS_MONO_ADD"; wb();
p "FORALL_LESS_MONO_ADDF@?m,?n"; 


(* ___________________________________________________________________   
	LESS_MONO_ADD:
	=============
	((Nat : ?m) < Nat : ?n) 
	  -> ((Nat : ?m) + Nat : ?p) < (Nat : ?n) + Nat : ?p = 

	true
   ___________________________________________________________________ *)

s "true";
ri "FORALL_LESS_MONO_ADDF@?m,?n"; ex();
ri "INSTANTIATEF@?p"; ex();
ri "RIGHT @ FORALL_LESS_MONO_ADD"; ex();
ri "CID"; ex();
ri "RIGHT @ EVAL"; ex();
ri "IRULE1"; ex();
wb();

p "LESS_MONO_ADD";

ae "LESS_MONO_ADD"; wb();
p "LESS_MONO_ADDF@?m,?n,?p";


(* ___________________________________________________________________   
	FORALL_LESS_MONO_ADD_INV:
	========================
	forall @ [(((Nat : ?m) + Nat : ?1) < (Nat : ?n) + Nat : ?1) 
	-> (Nat : ?m) < Nat : ?n] = 

	true
   ___________________________________________________________________ *)

s "forall@[(((Nat:?m)+Nat:?1) < (Nat:?n)+Nat:?1) -> (Nat:?m) < Nat:?n]";
ri "INDUCT_TAC"; ex();
left(); left();
ri "RL @ PLUSCOMM ** PLUSID"; ex();
ri "RL @ $REALNAT"; ex();
up();
ri "IREF"; ex();
up(); right();
right(); right(); right(); left();
ri "RL @ $PLUSASSOC"; ex();
ri "(LEFT@LEFT@PLUSCOMM) ** RIGHT@LEFT@PLUSCOMM"; ex();
ri "RL @ PLUSASSOC"; ex();
ri "(LEFT@RIGHT@PLUSTYPE2) ** RIGHT@RIGHT@PLUSTYPE2"; ex();
rri "LESS_MONO_EQ"; ex();
ri "RL @ $PLUSTYPE2"; ex();
up(); up(); 
ri "IREF"; ex();
up(); up(); 
ri "FORALLDROP ** AT"; ex();
up();
ri "CID ** AT"; ex();

p "FORALL_LESS_MONO_ADD_INV";


ae "FORALL_LESS_MONO_ADD_INV"; wb();
p "FORALL_LESS_MONO_ADD_INVF@?m,?n"; 

(* ___________________________________________________________________   
	LESS_MONO_ADD_INV:
	=================
	(((Nat : ?m) + Nat : ?p) < (Nat : ?n) + Nat : ?p) 
	-> (Nat : ?m) < Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "true";
ri "FORALL_LESS_MONO_ADD_INVF@?m,?n"; ex();
ri "INSTANTIATEF@?p"; ex();
ri "RIGHT @ FORALL_LESS_MONO_ADD_INV"; ex();
ri "CID"; ex();
ri "RIGHT @ EVAL"; ex();
ri "IRULE1"; ex();
wb();

p "LESS_MONO_ADD_INV";


ae "LESS_MONO_ADD_INV"; wb();
p "LESS_MONO_ADD_INVF@?m,?n,?p";


(* ___________________________________________________________________   
	LESS_MONO_ADD_EQ:
	================
	(Nat : ?m) < Nat : ?n = 

	((Nat : ?m) + Nat : ?p) < (Nat : ?n) + Nat : ?p
   ___________________________________________________________________ *)

s "(Nat:?m) < Nat:?n";
ri "LESSBOOL ** BOOLDEF"; ex();
left(); 
rri "AT"; ex();
rri "CID"; ex();
ri "LEFT @ LESS_MONO_ADDF@?m,?n,?p"; ex();
ri "RIGHT @ LESS_MONO_ADD_INVF@?m,?n,?p"; ex();
ri "3pt80 ** BSYM"; ex();
rri "BRULE1"; ex();
up(); 
ri "RIGHT @ (LESSBOOL ** ASSERT2)"; ex();
rri "BCONV"; ex();
ri "BASSOC ** (RIGHT @ BID) ** BID2"; ex();
rri "ASSERT2"; ex();
ri "EVERYWHERE @ PLUSTYPE2"; ex();
rri "LESSBOOL"; ex();
ri "EVERYWHERE @ $PLUSTYPE2"; ex();

p "LESS_MONO_ADD_EQ";


(* ___________________________________________________________________   
	LEQ_MONO_ADD_EQ:
	===============
	((Nat : ?m) + Nat : ?p) =< (Nat : ?n) + Nat : ?p = 
	
	(Nat : ?m) =< Nat : ?n
   ___________________________________________________________________ *)

s "((Nat:?m) + Nat:?p) =< (Nat:?n) + Nat:?p";
ri "RL@PLUSTYPE2";ex();
ri "LESS_OR_EQ"; ex();
ri "EVERYWHERE@ $PLUSTYPE2"; ex();
ri "LEFT @ $LESS_MONO_ADD_EQ"; ex();
right();
ri "RL@PLUSCOMM";ex();
ri "ADD_CANCEL"; ex();
ri "EVERYWHERE @ $REALNAT"; ex();
top();
rri "LESS_OR_EQ"; ex();

p "LEQ_MONO_ADD_EQ";


ae "LEQ_MONO_ADD_EQ"; wb();
p "LEQ_MONO_ADD_EQF@?p";

ae "SUC_LESS"; wb();
p "SUC_LESSF@?x,?y";


(* ___________________________________________________________________   
	LEQ_ANTISYM:
	===========
	~ ((Nat : ?m) < Nat : ?n) & (Nat : ?n) =< Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "~((Nat:?m) < Nat:?n) & (Nat:?n) =< Nat:?m";
right();
ri "RIGHT@LESS_OR_EQ";ex();
ri "CDISD";ex();
rri "DRULE2";ex();
left();
rri "DUBNEG2";ex();
ri "RIGHT@LESS_ANTISYM";ex();
rri "FDEF";ex();
up();right();
ri "CSYM**AND";ex();
right();left();
left();
ri "EQ_NOT_LESSF@?m,?n";ex();
ri "LEFT@EQSYMM** (LEFT@ 0|-|1)**REFLEX";ex(); (* 0|-|1: true = (Nat : ?n) = Nat : ?m  *)
ri "ILID";ex();
up();
ri "RIGHT@LESSBOOL2";ex();
rri "BCONV";ex();
ri "3pt15b";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "DID**AF";ex();
up();
ri "NEGF";ex();

p "LEQ_ANTISYM";

(* added by Holmes *)

s "bool:?x=<?y";
right(); ri "LESS_EQ_REAL"; ex();
up(); rri "ORBOOL"; ex();
rri "LESS_EQ_REAL"; ex();
p "LESS_EQ_BOOL";

(* ___________________________________________________________________   
	NOT_LESS:
	========
	~ (Nat : ?m) < Nat : ?n = 

	(Nat : ?n) =< Nat : ?m
  ___________________________________________________________________ *)

s "~(Nat:?m)<Nat:?n";
ri "PCASEINTRO@(Nat:?n)=<Nat:?m";ex();
ri "ODDCHOICE";ex();
right();left();
right();
ri "LESSBOOL2";ex();
rri "CID";ex();
ri "RIGHT@0|-|1";ex(); (* 0|-|1: true = (Nat : ?n) =< Nat : ?m  *)
up();
ri "LEQ_ANTISYM";ex();
up();right();
rri "NRULE1";ex();
rri "CID";ex();
right();
ri "LESS_CASESF@?n,?m";ex();
rri "DASSOC";ex();
left();
ri "ORBOOL";ex();
ri "RIGHT@ $LESS_OR_EQ";ex();
ri "BOOLDEF";ex();
ri "EQUATION";ex();
ri "1|-|1";ex();
up();
ri "DSYM**DID";ex();
rri "LESSBOOL2";ex();
up();
ri "CSYM**CCON";ex();
top();
rri "BOOLDEF0"; ri "LESS_EQ_BOOL"; ex();

p "NOT_LESS";


(* ___________________________________________________________________   
	NOT_SUC_LESS:
	============
	~ (1 + Nat : ?m) < Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "~(1 + Nat : ?m) < Nat: ?m";
ri "EVERYWHERE@ONENAT**PLUSTYPE2";ex();
ri "NOT_LESS";ex();
(* ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex(); *)
ri "LESS_OR_EQ";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
ri "LEFT@LESS_SUC_REFL";ex();
ri "DSYM**DZER";ex();

p "NOT_SUC_LESS";


(* ___________________________________________________________________   
	FLESS_ADD_NZ:
	============
	forall @ [(~ (Nat:?1) = 0) -> (Nat:?m) < (Nat:?m) + Nat:?1] = 

	true
   ___________________________________________________________________ *)

s "forall@[( ~(Nat:?1)=0) -> (Nat:?m)<(Nat:?m) + Nat:?1]";
ri "INDUCT_TAC";ex();
left();left();
ri "RIGHT@REFLEX";ex();
rri "FDEF";ex();
up();
ri "3pt75";ex();
up();right();right();right();
ri "PCASEINTRO@(Nat:?1)=0";ex();
right();left();
ri "EVERYWHERE@0|-|1";ex();
left();left();
ri "RIGHT@REFLEX";ex();
rri "FDEF";ex();
up();
ri "3pt75";ex();
up();
ri "ILID ** IRULE1";ex();
right(); right();
ri "PLUSCOMM";ex();
ri "LEFT@PLUSCOMM";ex();
ri "PLUSASSOC";ex();
ri "PLUSID";ex();
ri "RIGHT@(LEFT@ONENAT)**PLUSTYPE2";ex();
rri "REALNAT";ex();
rri "PLUSTYPE2";ex();
ri "LEFT@ $ONENAT";ex();
up();
ri "LESS_SUC_REFL";ex();
up();
ri "IRZER";ex();
up();right();
left();left();right();
ri "EQUATION";ex();
ri "1|-|1";ex();
up();
ri "NEGF";ex();
up();
ri "ILID";ex();
up();
ri "IRULE2";ex();
right();left();
ri "RIGHT@EQSYMM**SUCCNOTZERO";ex();
ri "NEGF";ex();
up();
ri "ILID";ex();
up();
ri "IRULE3";ex();
right();right();
rri "PLUSASSOC";ex();
ri "LEFT@PLUSCOMM";ex();
ri "PLUSASSOC";ex();
up();up();
ri "EVERYWHERE@PLUSTYPE2";ex();
ri "LESS_SUC";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "FLESS_ADD_NZ";


(* ___________________________________________________________________   
	LESS_ADD_NZ:
	===========
	(~ (Nat:?n) = 0) -> (Nat:?m) < (Nat:?m) + Nat:?n = 

	true
  ___________________________________________________________________ *)

s "true";
initializecounter();
ri "ElimForall @ FLESS_ADD_NZ,?n"; ex();
assign "?m_2" "?m";
rri "IFBOOL"; ex();
wb();

p "LESS_ADD_NZ";

ae "LESS_ADD_NZ"; wb();
p "LESS_ADD_NZF@?n,?m";


(* ___________________________________________________________________   
	FLEQ_ADD:
	========
	forall @ [(Nat : ?m) =< (Nat : ?m) + Nat : ?1] = 

	true
   ___________________________________________________________________ *)

s "forall@[(Nat:?m) =< (Nat:?m) + Nat:?1]";
right();right();
ri "RIGHT@PLUSTYPE2"; ex();
ri "LESS_OR_EQ";ex();
ri "TOPDOWN@ $PLUSTYPE2"; ex();
top();
ri "INDUCT_TAC";ex();
left();right();
ri "RIGHT@PLUSCOMM**PLUSID";ex();
ri "RIGHT@ $REALNAT";ex();
ri "REFLEX";ex();
up();
ri "DZER";ex();
up();
right();right();right();
ri "IMPTOCOND";ex();
right();
ri "OR_EXP**ODDCHOICE";ex();
right();left();
rri "DRULE2";ex();
left();
rri "ILID";ex();
ri "LEFT@0|-|1";ex(); (* 0|-|1: true = (Nat:?m) < (Nat:?m) + Nat:?1 *)
right();right();
rri "PLUSASSOC";ex();
ri "LEFT@PLUSCOMM";ex();
ri "PLUSASSOC";ex();
up();up();
ri "EVERYWHERE@PLUSTYPE2";ex();
ri "LESS_SUC";ex();
up();
ri "DSYM**DZER";ex();
up();right();
right();left();
left();
ri "LEFT@0|-|2";ex(); (* 0|-|2: (Nat : ?m) = (Nat : ?m) + Nat : ?1 *)
right();
rri "PLUSASSOC";ex();
ri "LEFT@PLUSCOMM";ex();
ri "PLUSASSOC";ex();
up();
ri "EVERYWHERE@PLUSTYPE2";ex();
ri "LESS_SUC_REFL";ex();
up();
ri "DSYM**DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "FLEQ_ADD";


(* ___________________________________________________________________   
	LEQ_ADD:
	=======
	(Nat : ?m) =< (Nat : ?m) + Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "true";
initializecounter();
ri "ElimForall @ FLEQ_ADD,?n"; ex();
assign "?m_2" "?m";
ri "RIGHT@LESS_OR_EQ";ex();
rri "ORBOOL"; ex();
ri "EVERYWHERE@PLUSTYPE2";
rri "LESS_OR_EQ";ex();
ri "TOPDOWN@ $PLUSTYPE2"; ex();
ri "LESS_EQ_BOOL"; ex();
wb();

p "LEQ_ADD";

ae "LEQ_ADD"; wb();
p "LEQ_ADDF@?m,?n";


(* ___________________________________________________________________   
	LESS_SUC_NOT:
	============
	((Nat:?m) < Nat:?n) -> ~ (Nat:?n) < 1 + Nat:?m = 

	true
   ___________________________________________________________________ *)

s "((Nat:?m) < Nat:?n) -> ~(Nat:?n) < 1 + Nat:?m";
ri "EVERYWHERE@ONENAT**PLUSTYPE2";ex();
ri "RIGHT@NOT_LESS";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
ri "LESS_OR";ex();

p "LESS_SUC_NOT";


(* ___________________________________________________________________   
	LEQ_TRANS:
	=========
	(((Nat:?m) =< Nat:?n) & (Nat:?n) =< Nat:?p) 
	-> (Nat:?m) =< Nat:?p = 

	true
   ___________________________________________________________________ *)

s "(((Nat:?m) =< Nat:?n) & (Nat:?n) =< Nat:?p) -> (Nat:?m) =< Nat:?p";
ri "EVERYWHERE@LESS_OR_EQ";ex();
ri "IMPTOCOND";ex();
right();
ri "ANDUNPACK";ex();
(* ri "EVERYWHERE@ $ODDCHOICE";ex(); *)
ri "EVERYWHERE@OR_EXP";ex();
(* ri "ODDCHOICE";ex(); *)
right();left();
(* ri "ODDCHOICE";ex(); *)
right();left();
rri "DRULE2";ex();
left();
rri "ILID";ex();
left();
rri "AT";ex();
rri "CID";ex();
(*	0|-|1: true = (Nat : ?m) < Nat : ?n
	0|-|2: true = (Nat : ?n) < Nat : ?p
*)
ri "(LEFT@0|-|1)**RIGHT@0|-|2";ex();
up();
ri "LESS_TRANS";ex();
up();
ri "DSYM**DZER";ex();
up();right();
right();left();
left();
ri "RIGHT@ $0|-|3";ex();  (* 0|-|3: (Nat:?n) = Nat:?p  *)
rri "0|-|1";ex();
up();
ri "DSYM**DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();right();
right();left();
(* ri "ODDCHOICE";ex(); *)
right();left();
left();
ri "LEFT@0|-|2";ex(); (* 0|-|2: (Nat : ?m) = Nat : ?n  *)
rri "0|-|3"; ex(); (* 0|-|3: true = (Nat : ?n) < Nat : ?p *)
up();
ri "DSYM**DZER";ex();
up();right();
(* ri "ODDCHOICE";ex(); *)
right();left();
right();
ri "LEFT@0|-|2";ex(); (* 0|-|2: (Nat : ?m) = Nat : ?n *)
ri "EQUATION**1|-|4";ex(); (* 0|-|4: true = (Nat : ?n) = Nat : ?p *)
up();
ri "DZER";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();

p "LEQ_TRANS";


(* ___________________________________________________________________   
	LEQ_LEQ_MONO:
	============
	(((Nat:?m) =< Nat:?p) & (Nat:?n) =< Nat:?q) 
	-> ((Nat:?m) + Nat:?n) =< (Nat:?p) + Nat:?q = 

	true
   ___________________________________________________________________ *)

s "(((Nat:?m)=<Nat:?p)&(Nat:?n)=<Nat:?q)->((Nat:?m)+Nat:?n)=<(Nat:?p)+Nat:?q";
left();
ri "(LEFT@LEQ_MONO_ADD_EQF@?n)**RIGHT@LEQ_MONO_ADD_EQF@?p";ex();
ri "RIGHT@RL@PLUSCOMM";ex();
up();
ri "EVERYWHERE@PLUSTYPE2";ex();
ri "LEQ_TRANS";ex();

p "LEQ_LEQ_MONO";


(* ___________________________________________________________________   
	MULT_SUC:
	========
	(Nat : ?x) * 1 + Nat : ?y = 

	(Nat : ?x) + (Nat : ?x) * Nat : ?y
   ___________________________________________________________________ *)

s "(Nat:?x) * 1 + Nat: ?y";
ri "TIMESCOMM ** COMMDIST"; ex();
ri "LEFT @ TIMESID"; ex();
ri "LEFT@ $REALNAT";ex();
ri "RIGHT@TIMESCOMM";ex();

p "MULT_SUC";


(* ___________________________________________________________________   
	FLESS_MONO_MULT:
	===============
	forall @ [((Nat:?m) =< Nat:?n) 
	   -> ((Nat:?m) * Nat:?1) =< (Nat:?n) * Nat:?1] = 

	true
   ___________________________________________________________________ *)

s "forall@[((Nat:?m) =< Nat:?n) -> ((Nat:?m)*Nat:?1) =< (Nat:?n)*Nat:?1]";
ri "INDUCT_TAC";ex();
left();right();
ri "RL@TIMESCOMM**TIMESZERO**ZERONAT";ex();
ri "LEQ_REFL";ex();
up();
ri "IRZER";ex();
up();right();
right();right();
ri "3pt65";ex();
left();
ri "CSYM";ex();
ri "3pt66";ex();
up();right();
ri "RL@MULT_SUC";ex();
up();
ri "EVERYWHERE@TIMESTYPE2";ex();
ri "LEQ_LEQ_MONO";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "FLESS_MONO_MULT";


(* ___________________________________________________________________   
	LESS_MONO_MULT:
	==============
	((Nat:?m) =< Nat:?n) 
	-> ((Nat:?m) * Nat:?p) =< (Nat:?n) * Nat:?p = 

	true
   ___________________________________________________________________ *)

s "true";
initializecounter();
ri "ElimForall @ (FLESS_MONO_MULT),?p"; ex();
assign "?m_2" "?m";
assign "?n_2" "?n";
rri "IFBOOL"; ex();

wb();

p "LESS_MONO_MULT";

ae "LESS_MONO_MULT"; wb();
p "LESS_MONO_MULTF@?m,?n,?p";


(* ___________________________________________________________________   
	LESS_EQ_ANTISYM:
	===============
	(((Nat : ?n) =< Nat : ?m) & (Nat : ?m) =< Nat : ?n) 
	-> (Nat : ?n) = Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "(((Nat:?n)=<Nat:?m) & (Nat:?m)=<Nat:?n) -> (Nat:?n) = Nat:?m";
left();
ri "RL@LESS_OR_EQ";ex();
ri "RIGHT@RIGHT@EQSYMM";ex();
ri "RL@DSYM";ex();
rri "DDISC";ex();
right();
rri "CRULE1";ex();
rri "DUBNEG2";ex();
ri "RIGHT@LESS_ANTISYM";ex();
rri "FDEF";ex();
up();
ri "DID";ex();
up();
ri "IRULE2";ex();
ri "IREF";ex();

p "LESS_EQ_ANTISYM";


(* ___________________________________________________________________   
	FLESS_ADD_SUC:
	=============
	forall @ [(Nat : ?1) < (Nat : ?1) + 1 + Nat : ?n] = 
	
	true
   ___________________________________________________________________ *)

s "forall@[(Nat:?1) < (Nat:?1) + 1 + Nat:?n]";
ri "INDUCT_TAC";ex();
left();
ri "EVERYWHERE@ONENAT**PLUSTYPE2";ex();
ri "RIGHT@PLUSID";ex();
ri "RIGHT@ $REALNAT";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
ri "LESS_0";ex();
up();right();right();right();
right();right();
ri "PLUSASSOC";ex();
right();
ri "EVERYWHERE@ONENAT**PLUSTYPE2";ex();
up();up();
rri "LESS_MONO_EQ";ex();
ri "RIGHT@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
up();
ri "IREF";ex();
up();up();
ri "FORALLDROP**AT";ex();
up();
ri "CID**AT";ex();

p "FLESS_ADD_SUC";


(* ___________________________________________________________________   
	LESS_ADD_SUC:
	============
	(Nat : ?m) < (Nat : ?m) + 1 + Nat : ?n = 

	true
   ___________________________________________________________________ *)

s "true";
initializecounter();
ri "ElimForall @ FLESS_ADD_SUC,?m"; ex();
assign "?n_2" "?n";
ri "EVERYWHERE@ONENAT**PLUSTYPE2";ex();
rri "LESSBOOL"; ex();
ri "RIGHT@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
wb();

p "LESS_ADD_SUC";

ae "LESS_ADD_SUC"; wb();
p "LESS_ADD_SUCF@?m,?n";


(* ___________________________________________________________________   
	NOT_SUC_LEQ:
	===========
	~ (1 + Nat : ?n) =< Nat : ?m = 

	(Nat : ?m) =< Nat : ?n
   ___________________________________________________________________ *)

s " ~(1 + Nat:?n) =< Nat:?m";
ri "RIGHT@LESS_EQ";ex();
ri "NOT_LESS";ex();

p "NOT_SUC_LEQ";


(* ___________________________________________________________________   
	LEQ_IMP_LESS_SUC:
	================
	((Nat : ?n) =< Nat : ?m) -> (Nat : ?n) < 1 + Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "((Nat:?n) =< Nat:?m) -> (Nat:?n) < 1 + Nat:?m";
ri "LEFT@LESS_OR_EQ";ex();
ri "IMPTOCOND";ex();
right();
ri "OR_EXP";ex();
ri "ODDCHOICE";ex();
right();left();
ri "EVERYWHERE@ONENAT**PLUSTYPE2";ex();
ri "LESSBOOL2";ex();
ri "EVERYWHERE@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
rri "ILID";ex();
ri "LEFT@ 0|-|1";ex(); (* 0|-|1: true = (Nat : ?n) < Nat : ?m  *)
ri "LESS_SUC";ex();
up();right();
right();left();
right();
ri "RIGHT@ $0|-|2";ex();  (* 0|-|2: (Nat : ?n) = Nat : ?m *)
up();
ri "LESS_SUC_REFL";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();

p "LEQ_IMP_LESS_SUC";


(* ___________________________________________________________________   
	LESS_LESS_CASES:
	===============
	((Nat : ?m) = Nat : ?n) | ((Nat : ?m) < Nat : ?n) 
	| (Nat : ?n) < Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "((Nat:?m)=Nat:?n) | ((Nat:?m) < Nat:?n) | (Nat:?n) < Nat:?m";
rri "DASSOC";ex();
ri "DSYM";ex();
ri "RIGHT@LEFT@EQSYMM";ex();
ri "LESS_CASES";ex();

p "LESS_LESS_CASES";


(* ___________________________________________________________________   
	GREATER_EQ:
	==========
	(Nat : ?n) >= Nat : ?m = 

	(Nat : ?m) =< Nat : ?n
   ___________________________________________________________________ *)

s "(Nat:?n) >= Nat:?m";
ri "GREATER_OR_EQ";ex();
ri "LEFT@GREATER";ex();
ri "RIGHT@EQSYMM";ex();
rri "LESS_OR_EQ";ex();

p "GREATER_EQ";


(* ___________________________________________________________________   
	LEQ_CASES:
	=========
	((Nat : ?m) =< Nat : ?n) | (Nat : ?n) =< Nat : ?m = 

	true
   ___________________________________________________________________ *)

s "((Nat:?m) =< Nat:?n) | (Nat:?n) =< Nat:?m";
ri "RL@LESS_OR_EQ";ex();
ri "RIGHT@DSYM";ex();
rri "DASSOC";ex();
left();
ri "RIGHT@EQSYMM";ex();
ri "DASSOC";ex();
ri "RIGHT@DIDEM";ex();
ri "DRULE3**DSYM";ex();
up();
ri "DASSOC";ex();
ri "LESS_LESS_CASES";ex();

p "LEQ_CASES";


(* ___________________________________________________________________   
	NOT_LEQ:
	=======
	~ (Nat : ?m) =< Nat : ?n = 

	(Nat : ?n) < Nat : ?m
   ___________________________________________________________________ *)

s " ~ (Nat:?m) =< Nat:?n";
ri "RIGHT@ $NOT_LESS";ex();
ri "DUBNEG ** $LESSBOOL";ex();

p "NOT_LEQ";


(* ___________________________________________________________________   
	LESS_0_FALSE:
	============
	(Nat : ?n) < 0 = 

	false
   ___________________________________________________________________ *)

s "(Nat:?n) < 0";
ri "RIGHT@ZERONAT";ex();
ri "LESSBOOL";ex();
rri "DUBNEG";ex();
ri "EVERYWHERE@ $ZERONAT";ex();
ri "RIGHT@NOT_LESS_0";ex();
rri "FDEF";ex();

p "LESS_0_FALSE";


(* ___________________________________________________________________   
	LESS_MULT2:
	==========
	((0 < Nat:?m) & 0 < Nat:?n) -> 0 < (Nat:?m) * Nat:?n = 

	true
   ___________________________________________________________________ *)

s "((0 < Nat:?m) & 0 < Nat:?n) -> 0 < (Nat:?m)*Nat:?n";
ri "CONTP";ex();
ri "RIGHT@ $DEMa";ex();
ri "EVERYWHERE@TIMESTYPE2**ZERONAT";ex();
ri "EVERYWHERE@NOT_LESS";ex();
ri "EVERYWHERE@ $ZERONAT";ex();
ri "EVERYWHERE@LEQ_0";ex();
ri "LEFT@LEFT@ $TIMESTYPE2";ex();
right();
ri "EVERYWHERE@REALNAT";ex();
ri "RL@EQSYMM";ex();
rri "FACTORZERO";ex();
ri "EQSYMM";ex();
up();
ri "IREF";ex();

p "LESS_MULT2";


(* ___________________________________________________________________   
	LEQ_LESS_TRANS:
	==============
	(((Nat : ?m) =< Nat : ?n) & (Nat : ?n) < Nat : ?p) 
	-> (Nat : ?m) < Nat : ?p = 

	true  
   ___________________________________________________________________ *)

s "(((Nat:?m) =< Nat:?n) & (Nat:?n) < Nat:?p) -> (Nat:?m) < Nat:?p";
ri "LEFT@LEFT@LESS_OR_EQ";ex();
rri "3pt65";ex();
ri "IMPTOCOND";ex();
right();
ri "OR_EXP";ex();
ri "ODDCHOICE";ex();
right();left();
rri "IRULE2";ex();
left();
rri "CID";ex();
ri "CSYM**LEFT@0|-|1";ex(); (* 0|-|1: true = (Nat : ?m) < Nat : ?n *)
up();
ri "LESS_TRANS";ex();
up();right();
right();left();
ri "RIGHT@LEFT@0|-|2";ex(); (* 0|-|2: (Nat : ?m) = Nat : ?n *)
ri "IREF";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();

p "LEQ_LESS_TRANS";


(* ___________________________________________________________________   
	LESS_LEQ_TRANS:
	==============
	(((Nat : ?m) < Nat : ?n) & (Nat : ?n) =< Nat : ?p) 
	-> (Nat : ?m) < Nat : ?p = 

	true
   ___________________________________________________________________ *)

s "(((Nat:?m) < Nat:?n) & (Nat:?n) =< Nat:?p) -> (Nat:?m) < Nat:?p";
ri "LEFT@RIGHT@LESS_OR_EQ";ex();
ri "LEFT@CSYM";ex();
rri "3pt65";ex();
ri "IMPTOCOND";ex();
right();
ri "OR_EXP";ex();
ri "ODDCHOICE";ex();
right();left();
rri "IRULE2";ex();
left();
rri "CID";ex();
ri "RIGHT@0|-|1";ex(); (* 0|-|1: true = (Nat : ?n) < Nat : ?p *)
up();
ri "LESS_TRANS";ex();
up();right();
right();left();
ri "LEFT@RIGHT@0|-|2";ex(); (* 0|-|2: (Nat : ?n) = Nat : ?p *)
ri "IREF";ex();
up();up();
rri "CASEINTRO";ex();
up();up();
rri "CASEINTRO";ex();
up();
ri "AT";ex();

p "LESS_LEQ_TRANS";


(* ___________________________________________________________________   
	EQ_LEQ:
	======
	((Nat : ?m) =< Nat : ?n) & (Nat : ?n) =< Nat : ?m = 

	(Nat : ?m) = Nat : ?n
   ___________________________________________________________________ *)

s "((Nat:?m) =< Nat:?n) & (Nat:?n) =< Nat:?m";
ri "RL@LESS_OR_EQ";ex();
ri "RIGHT@RIGHT@EQSYMM";ex();
ri "RL@DSYM";ex();
rri "DDISC";ex();
rri "DRULE3";ex();
right();
rri "DUBNEG2";ex();
ri "RIGHT@LESS_ANTISYM";ex();
rri "FDEF";ex();
up();
ri "DID";ex();
rri "ASRTEQ";ex();

p "EQ_LEQ";


(* ___________________________________________________________________   
	ADD_MONO_LEQ:
	============
	((Nat : ?m) + Nat : ?n) =< (Nat : ?m) + Nat : ?p = 

	(Nat : ?n) =< Nat : ?p
   ___________________________________________________________________ *)

s "((Nat:?m) + Nat:?n) =< (Nat:?m) + Nat:?p";
ri "RL@PLUSCOMM";ex();
ri "LEQ_MONO_ADD_EQ";ex();

p "ADD_MONO_LEQ";


(* ___________________________________________________________________   
	NOT_SUC_LEQ_0:
	=============
	~ (1 + Nat : ?n) =< 0 = 

	true
   ___________________________________________________________________ *)

s " ~ (1 + Nat:?n) =< 0";
ri "RIGHT@RIGHT@ZERONAT";ex();
ri "EVERYWHERE@ONENAT**PLUSTYPE2";ex();
ri "NOT_LEQ";ex();
ri "LEFT@ $ZERONAT";ex();
ri "RIGHT@ $PLUSTYPE2";ex();
ri "EVERYWHERE@ $ONENAT";ex();
ri "LESS_0";ex();

p "NOT_SUC_LEQ_0";


(* ___________________________________________________________________   
	NOT_LEQ_SUC:
	===========
	~ (Nat : ?m) =< Nat : ?n = 

	(1 + Nat : ?n) =< Nat : ?m
   ___________________________________________________________________ *)

s " ~(Nat:?m) =< Nat:?n";
ri "RIGHT@ $NOT_LESS";ex();
ri "DUBNEG** $LESSBOOL";ex();
rri "LESS_EQ";ex();

p "NOT_LEQ_SUC";


(* ___________________________________________________________________   
	NOT_NUM_EQ:
	==========
	((1 + Nat : ?m) =< Nat : ?n) | (1 + Nat : ?n) =< Nat : ?m = 

	~ (Nat : ?m) = Nat : ?n
   ___________________________________________________________________ *)

s "((1+Nat:?m) =< Nat:?n) | (1 + Nat:?n) =< Nat:?m";
ri "RL@ $NOT_LEQ_SUC";ex();
ri "DEMa";ex();
ri "RIGHT@EQ_LEQ";ex();
ri "RIGHT@EQSYMM";ex();

p "NOT_NUM_EQ";


(* ___________________________________________________________________   
	NOT_GREATER:
	===========
	~ (Nat : ?m) > Nat : ?n = 
		
	(Nat : ?m) =< Nat : ?n
   ___________________________________________________________________ *)

s " ~(Nat:?m) > Nat:?n";
ri "RIGHT@GREATER";ex();
ri "NOT_LESS";ex();

p "NOT_GREATER";


(* ___________________________________________________________________   
	NOT_GREATER_EQ:
	==============
	~ (Nat : ?m) >= Nat : ?n = 

	(1 + Nat : ?m) =< Nat : ?n
   ___________________________________________________________________ *)

s " ~(Nat:?m) >= Nat:?n";
ri "RIGHT@GREATER_EQ";ex();
ri "NOT_LEQ_SUC";ex();

p "NOT_GREATER_EQ";


(* ___________________________________________________________________   
	NOT_SUC_ADD_LEQ:
	===============
	~ (1 + (Nat : ?m) + Nat : ?n) =< Nat : ?m = 

	true
   ___________________________________________________________________ *)

s " ~ (1 + (Nat:?m) + Nat:?n) =< Nat:?m";
ri "EVERYWHERE@PLUSTYPE2";ex();
ri "RIGHT@LESS_EQ";ex();
ri "NOT_LESS";ex();
ri "RIGHT@ $PLUSTYPE2";ex();
ri "LEQ_ADD";ex();

p "NOT_SUC_ADD_LEQ";

(* this is a nice theorem, but the proof is very ad hoc because of the
weirdness of naturals.mk2 *)

(*

REALSUBNATTYPE:

Nat : (Nat : ?m) - Nat : ?n = 

((Nat : ?m) < Nat : ?n) 
|| (Nat : - (Nat : ?n) - Nat : ?m) , (Nat : ?m) 
- Nat : ?n

*)

(* Type properties of real subtraction on natural numbers *)

s "Nat:(Nat:?m)-Nat:?n";
right(); ri "MINUSCOMP"; ex();
ri "LEFT@ $LESSCOMP"; ex();
ri "EVERYWHERE@ $NATMINUSCOMP"; ex();
up(); ri "UNEVAL@[Nat:?1]"; ex();
ri "FNDIST**EVERYWHERE@EVAL"; ex();
ri "EVERYWHERE@TREMBOTH@NATMINUSTYPE"; ex();
ri "RIGHT_CASE@TREMTOP@NATMINUSTYPE"; ex();
ri "EVERYWHERE@NAT__SUB"; ex();
right(); right(); ri "EVERYWHERE@1|-|1"; ex();
up(); left(); dlrs "NOT_EXP"; rri "NOT_EXP"; ex();
ri "LEFT@NOT_LESS"; ex();
ri "LEFT@LESS_OR_EQ"; ex();
ri "TAB_OR_2"; ex();
ri "1|-|1"; ex();
p "REALSUBNATTYPE"; 

(* repaired May 29 -- binding on ?1 instead of Nat:?1 made this result
trivially true *)

(* ___________________________________________________________________   
	LESS_ADD:
	========
	((Nat : ?n) < Nat : ?m) -> 
		forsome @ [(Nat:?1) + Nat : ?n) = Nat : ?m] = 

	true
   ___________________________________________________________________ *)

s "((Nat:?n)<Nat:?m)->forsome@[((Nat:?1)+Nat:?n)=Nat:?m]";
ri "TAB_IF";ex();
right();left();left();
ri "DINSTANTIATEF1@Nat:(Nat:?m)-Nat:?n";ex();
left();
ri "EVAL";ex();
left();left(); ri "TYPES"; ex();
ri "REALSUBNATTYPE"; ex();
rri "NOT_EXP"; ri "LEFT@NOT_LESS"; ri "LEFT@LESS_OR_EQ"; 
ri "TAB_OR_2"; ri "1|-|1"; ex();
up(); ri "PLUSMINUS";ex();
rri "REALNAT";ex();
up();
ri "REFLEX";ex();
up();
ri "DSYM**DZER";ex();
up();
ri "IRZER";ex();
top(); rri "CASEINTRO"; ex();

p "LESS_ADD";

(* still to be repaired *)

(* this is a bi-equivalence once ?1 is replaced by Nat:?1 *)

(* ___________________________________________________________________   
	LESS_ADD1:
	=========
	((Nat : ?n) < Nat : ?m) -> 
		forsome @ [(Nat : ?m) = (Nat : ?n) + (?1) + 1] = 

	true
   ___________________________________________________________________ *)

s "((Nat:?n)<Nat:?m) -> forsome@[(Nat:?m)=(Nat:?n)+(?1)+1]";
right();
ri "DINSTANTIATEF1@((Nat:?m)-(Nat:?n))-1";ex();
left();
ri "EVAL";ex();
right();
ri "RIGHT@PLUSMINUS";ex();
ri "(LEFT@REALNAT)** $PLUSSCIN";ex();
ri "PLUSCOMM**PLUSMINUS";ex();
rri "REALNAT";ex();
up();
ri "REFLEX";ex();
up();
ri "DSYM**DZER";ex();
up();
ri "IRZER";ex();

p "LESS_ADD1";

(* still to be repaired *)

(* ___________________________________________________________________   
	LESS_OR_ADD:
	===========
	((Nat : ?n) < Nat : ?m) | 
	forsome @ [(Nat : ?n) = ?1 + Nat : ?m] = 

	true
   ___________________________________________________________________ *)

s "((Nat:?n)<Nat:?m) | forsome@[(Nat:?n)=?1+Nat:?m]";
rri "DRULE2";ex();
ri "LEFT@ $DUBNEG2";ex();
rri "IF";ex();
ri "LEFT@NOT_LESS**LESS_OR_EQ";ex();
rri "3pt78";ex();
left();
right();right();right();
ri "EQSYMM";ex();
up();up();up();
ri "LESS_ADD";ex();
up();right();
ri "IMPTOCOND";ex();
right();right();left();
ri "DINSTANTIATEF1@0";ex();
left(); ri "EVAL";ex();
ri "RIGHT@PLUSID** $REALNAT";ex();
ri "RIGHT@ 0|-|1";ex();
ri "REFLEX";ex();
up();
ri "DSYM**DZER";ex();
up();up();
rri "CASEINTRO";ex();
up(); ri "AT";ex();
up(); ri "CID**AT";ex();

p "LESS_OR_ADD";

(* still to be repaired *)

(* this will be a bi-equivalence once ?1 is replaced by Nat:?1 *)

(* ___________________________________________________________________   
	LESS_EQ_ADD:
	===========
	((Nat : ?m) =< Nat : ?n) -> 
		forsome @ [(Nat : ?n) = (Nat : ?m) + ?1] = 
	
	true
   ___________________________________________________________________ *)

s "((Nat:?m)=<Nat:?n) -> forsome@[(Nat:?n)=(Nat:?m)+?1]";
ri "LEFT@LESS_OR_EQ";ex();
rri "3pt78";ex();
left();
right();right();right();
ri "(RIGHT@PLUSCOMM)**EQSYMM";ex();
up();up();up();
ri "LESS_ADD";ex();
up();right();
ri "IMPTOCOND";ex();
right();right();left();
ri "DINSTANTIATEF1@0";ex();
left(); ri "EVAL";ex();
ri "RIGHT@PLUSCOMM**PLUSID** $REALNAT";ex();
ri "RIGHT@ 0|-|1";ex();
ri "REFLEX";ex();
up();
ri "DSYM**DZER";ex();
up();up();
rri "CASEINTRO";ex();
up(); ri "AT";ex();
up(); ri "CID**AT";ex();

p "LESS_EQ_ADD";

quit();






