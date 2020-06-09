(* mark2 representation of CAPSL *)
(* Implementation of modal logic *)

(* Needham-Schroeder Protocol *)

script "capsl_ns_axioms";


(* The Messages *)
(* 1. A->S: A,B,Na                        *)
(* 2. S->A: {Na,B,Kab,{Kab,A}Kbs}Kas      *)
(* 3. A->B: {Kab,A}Kbs                    *)
(* 4: B->A: {Nb}Kab                       *)
(* 5: A->B: {Nb-1}Kab                     *)



(* Theorems *)


(*
BELIEVE_IS_BELIEVE_TRUE:  

(?P `BELIEVES ?x) -> ?P `BELIEVES true  =  

true

BASSOC , BDIS , BELIEVES_BELIEVES_IS_BELIEVES , BELIEVE_AND 
, BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , IDEF , NTYPE , PROP , TYPES , 0

*)

initializecounter();
s "(?P `BELIEVES ?x)->?P `BELIEVES true";
left(); ri "BELIEVE_TYPE"; ex();
rri "BELIEVE_TYPE"; ex();
rri "BELIEVES_BELIEVES_IS_BELIEVES";ex();
ri "BELIEVE_TYPE"; ex();
right();right();right();
ri "BELIEVE_TYPE"; ex();
rri "PROP";ex();
rri "CID"; ex();
ri "AND_TYPE";ex();
right();left();
rri "TYPES";ex();
right();
rri "BELIEVE_TYPE";ex();
up();up();up();
rri "AND_TYPE";ex();
up();up();up();
rri "BELIEVE_TYPE";ex();
ri "BELIEVE_AND";ex();
left();
ri "BELIEVES_BELIEVES_IS_BELIEVES";ex();
top();
rri "3pt65";ex();
ri "RIGHT@IREF";ex();
ri "IRZER";ex();
p "BELIEVE_IS_BELIEVE_TRUE";


(* SHORTER PROOF FOR THE ABOVE *)

(*
BELIEVE_IS_BELIEVE_TRUE1:  

(?P `BELIEVES ?x) -> ?P `BELIEVES true  =  

true

BDIS , BID , BID2 , BSYM , BTYPE , DDIS , DIDEM , DSYM 
, DXM , FDEF , IDEF , NECESSITATION , NTYPE , PROP 
, TYPES , 0

*)
initializecounter();
s "(?P `BELIEVES ?x)->?P `BELIEVES true";
ri "RIGHT@NECESSITATION";ex();
ri "IRZER";ex();
p "BELIEVE_IS_BELIEVE_TRUE1";

(* 
Some useful tactics needed for proofs 
*)

(*
TACTIC_IMP_BELIEF:  

?x `BELIEVES ?y  =  

true -> ?x `BELIEVES ?y

BDIS , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , DDIS 
, DIDEM , DSYM , DXM , FDEF , IDEF , NTYPE , PROP 
, TYPES , 0
*)
initializecounter();
s "?x `BELIEVES ?y";
ri "BELIEVE_TYPE";ex();
rri "TYPES";ex();
rri "IMP_TRUE";ex();
right();
rri "BELIEVE_TYPE";ex();
top();
p "TACTIC_IMP_BELIEF";


(*
TACTIC_AND_BELIEF:  

?x `BELIEVES ?y  =  

true & ?x `BELIEVES ?y

BASSOC , BDIS , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , NTYPE , PROP , TYPES , 0

*)
initializecounter();
s "?x `BELIEVES ?y";
ri "BELIEVE_TYPE";ex();
rri "TYPES";ex();
rri "AND_TRUE";ex();
right();
rri "BELIEVE_TYPE";ex();
top();
p "TACTIC_AND_BELIEF";


(*
TACTIC_IMP:  

?x -> ?y  =  

true -> ?x -> ?y

BDIS , BID , BID2 , BSYM , BTYPE , DDIS , DIDEM , DSYM 
, DXM , FDEF , IDEF , IMPTYPE , NTYPE , PROP , TYPES 
, 0

*)
initializecounter();
s "?x -> ?y";
ri "IMP_TYPE";ex();
rri "TYPES";ex();
rri "IMP_TRUE";ex();
right();
rri "IMP_TYPE";ex();
top();
p "TACTIC_IMP";


(*
SAID_REM_TLABEL:  

?x `SAID Message : ?y  =  

?x `SAID ?y

SAID_TYPE , TYPES , 0
*)
initializecounter();
s "?x `SAID Message:?y";
ri "SAID_TYPE";ex();
right();right();right();
ri "TYPES";ex();
top();
rri "SAID_TYPE";ex();
p "SAID_REM_TLABEL";


(*
SAYS_REM_TLABEL:  

?x `SAYS Message : ?y  =  

?x `SAYS ?y

SAYS_TYPE , TYPES , 0
*)
initializecounter();
s "?x `SAYS Message:?y";
ri "SAYS_TYPE";ex();
right();right();right();
ri "TYPES";ex();
top();
rri "SAYS_TYPE";ex();
p "SAYS_REM_TLABEL";


(******************)
(* Theorems for A *)
(******************)



(*
NS_A_THEOREM1:  

A `BELIEVES A `RECEIVED Kas `se Na , (Principal : B) 
, ((shared_key @ A , B , Kab) , Fresh @ Skey : Kab) 
   , Message : ?y  =  

true

AXIOM_01 , BASSOC , BDIS , BELIEVE_TYPE , BID , BID2 
, BSYM , BTYPE , CTYPE , DDIS , DIDEM , DSYM , DTYPE 
, DXM , FDEF , GR , IDEF , NTYPE , PROP , P_12A , P_9 
, TYPES , 0

*)

initializecounter();
s "true";
rri "AXIOM_01";ex();
left();left();right();
assign "?si_1" "(A `RECEIVED (Kas `se Na , (Principal : B), (Message : ?x) , Message : ?y))";
assign "?P_1" "A";
up();
ri "P_9";ex();
up();right();
assign "?delta_1" "(A `RECEIVED Kas `se ((Na) , (Principal : B) , ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y))";
ri "P_12A";ex();
top();

ri "LEFT@CID**AT"; ex();
ri "IMP_TRUE"; ex();
ri "TREMTOP@BELIEVE_TYPE"; ex();
wb();
p "NS_A_THEOREM1";


axiom "NS_A_TH2" "A `BELIEVES (S `SAID (Na , (Principal : B) , (shared_key @ A , B , Kab) , (Fresh @ Skey : Kab) , Message : ?y))" "true";
  
(* Proof for this Axiom *)
(* We need to add an axiom for proving the above *)

axiom "P_15" "A `BELIEVES (A `RECEIVED Kas `se Na , ?x) -> A `RECEIVED_FROM S , Kas `se Na , ?x" "true";

(* a lemma *)

(*

BELIEVE2LEMMA:  

?A `BELIEVES ?x  =  

(?A `BELIEVES ?x) & ?A `BELIEVES ?A `BELIEVES ?x

AXIOM_02 , BASSOC , BDIS , BELIEVE_TYPE , BID , BID2 
, BSYM , BTYPE , CTYPE , DASSOC , DDIS , DIDEM , DSYM 
, DTYPE , DXM , FDEF , GR , IDEF , NTYPE , PROP , TYPES 
, 0

*)

s "?A `BELIEVES ?x";
ri "TADDTOP@BELIEVE_TYPE"; rri "PROP"; rri "CID"; ex();
right(); initializecounter(); rri "AXIOM_02"; ex();
assign "?P_1,?si_1" "?A,?x";
top(); ri "3pt66"; ex();
p "BELIEVE2LEMMA";



(*
GOAL_2:  

A `BELIEVES (S `SAID Na , (Principal : B) , ((shared_key 
            @ A , B , Kab) , Fresh @ Skey : Kab) , Message 
         : ?y) & S `SEES Kas  =  

true

AXIOM_01 , AXIOM_03A , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , IDEF , NTYPE , PROP , P_12A , P_15 , P_4A , P_9 
, TYPES , 0


*)

getleftside "NS_A_THEOREM1";

ri "TADDTOP@BELIEVE_TYPE"; ex();
rri "PROP"; ex();
rri "CID"; ex();

right(); initializecounter(); rri "P_15"; ex();

top();left(); right(); right(); right(); right(); assignit "?x_1";

top(); rri "BELIEVE_AND"; ex();

right(); ri "3pt66"; ex();

top(); ri "BELIEVE_AND"; ri "LEFT@NS_A_THEOREM1"; ex();

ri "CSYM**CID**PROP**TREMTOP@BELIEVE_TYPE"; ex();
saveenv "Useful_Lemma";

ri "TADDTOP@BELIEVE_TYPE"; rri "PROP"; rri "CID"; ri "CSYM"; ex();
left(); rri "P_4A"; ex();
up(); rri "BELIEVE_AND"; ex();
right(); rri "CRULE1"; rri "CID"; ex();
right(); initializecounter(); rri "AXIOM_03A"; ex();
assign "?P_1,?Q_1,?R_1,?k_1,?x_1" "A,S,A,Kas,Na , (Principal : B) , ((shared_key @ A , B , Kab) , Fresh @ Skey : Kab) , Message : ?y";
uptols "3pt66"; ri "3pt66"; ex();
uptols "BELIEVE_AND"; ri "BELIEVE_AND"; ex();
ri "LEFT@BELIEVE_AND"; ex();
left();left();ri "P_4A"; ex();
up();ri "CSYM**CID**PROP**TREMTOP@BELIEVE_TYPE"; ex();
applyconvenv "Useful_Lemma"; ri "NS_A_THEOREM1"; ex();
up(); ri "CSYM**CID**PROP**TREMTOP@BELIEVE_TYPE"; ex();
wb(); ri "NS_A_THEOREM1"; ex();
p "GOAL_2";

saveenv "backup";
dropenv "Useful_Lemma";




(*
NS_A_THEOREM2:  

A `BELIEVES S `SAID Na , (Principal : B) , ((shared_key 
         @ A , B , Kab) , Fresh @ Skey : Kab) , Message 
      : ?y  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , NECESSITATION , NTYPE 
, PROP , P_12A , P_15 , P_4A , P_9 , SHARED_KEY_IMP_SEES_KEY 
, TYPES , 0

*)
initializecounter();
s "true";
rri "GOAL_2";ex();
assign "?y_1" "?y";
ri "BELIEVE_AND";ex();
right();
ri "TACTIC_IMP_BELIEF";ex();
left();
rri "P_4A";ex();
right();
rri "AXIOM_20";ex();
up();up();
ri "TACTIC_IMP";ex();
left();
rri "NECESSITATION";ex();
assign "?A_7" "A";
right();
rri "SHARED_KEY_IMP_SEES_KEY";ex();

assign "?x_8" "S";
assign "?y_8" "A";
assign "?k_8" "Kas";
up();up();
ri "BELIEVE_IMP";ex();
up();ri "AND_COMM";ex();
rri "TACTIC_AND_BELIEF";ex();
wb();
p "NS_A_THEOREM2";



(*
NS_A_THEOREM3:  

A `BELIEVES Fresh @ Na , (Principal : B) , ((shared_key 
         @ A , B , Kab) , Fresh @ Skey : Kab) , Message 
      : ?y  =  

true

AXIOM_01 , AXIOM_17A , BASSOC , BDIS , BELIEVE_TYPE 
, BID , BID2 , BSYM , BTYPE , CTYPE , DDIS , DIDEM 
, DSYM , DTYPE , DXM , FDEF , GR , IDEF , NECESSITATION 
, NTYPE , PROP , P_1A , TYPES , 0
*)

initializecounter();
s "true";
rri "AXIOM_01";ex();
assign "?P_1" "A";
assign "?si_1" "Fresh@(Na)";
left();left();
ri "P_1A";ex();
top();left();
rri "TACTIC_AND_BELIEF";ex();

top();
assign "?delta_1" "Fresh@(Na , (Principal : B) , ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y)";
left();right();
ri "AXIOM_17A";ex();
up();
ri "NECESSITATION";ex();
top();
rri "TACTIC_IMP_BELIEF";ex();
wb();
p "NS_A_THEOREM3";


(* 
NS_A_THEOREM4:  

A `BELIEVES S `SAYS Na , (Principal : B) , ((shared_key 
         @ A , B , Kab) , Fresh @ Skey : Kab) , Message 
      : ?y  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_17A , AXIOM_19 , AXIOM_20 
, BASSOC , BDIS , BELIEVE_AND , BELIEVE_IMP , BELIEVE_TYPE 
, BID , BID2 , BSYM , BTYPE , CTYPE , DASSOC , DDIS 
, DIDEM , DSYM , DTYPE , DXM , FDEF , GR , IDEF , IMPTYPE 
, NECESSITATION , NTYPE , PROP , P_12A , P_15 , P_1A 
, P_4A , P_9 , SHARED_KEY_IMP_SEES_KEY , TYPES , 0
*)

initializecounter();
s "true";
rri "AXIOM_01";ex();
assign "?P_1" "A";
assign "?si_1" "((Fresh @ Na , (Principal : B) , ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y) & (S `SAID (Na , (Principal : B) , ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y)))";
left();left();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM3";ex();
ri "RIGHT@NS_A_THEOREM2";ex();
ri "AND_TRUE";ex();
up();right();
assign "?delta_1" "S `SAYS (Na , (Principal : B) , ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y)";
right();
ri "AXIOM_19";ex();
up();
ri "NECESSITATION";ex();
up();
ri "AND_COMM**AND_TRUE**TYPES";ex();
top();
ri "IMP_TYPE";ex();
right();left();
ri "TYPES";ex();
top();
rri "IMP_TYPE";ex();
rri "TACTIC_IMP_BELIEF";ex();
wb();
prove "NS_A_THEOREM4";



(*
NS_A_THEOREM5A:  

A `BELIEVES S `SAYS Na  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_15A , AXIOM_17A , AXIOM_19 
, AXIOM_20 , BASSOC , BDIS , BELIEVE_AND , BELIEVE_IMP 
, BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , IDEF , IMPTYPE , NECESSITATION , NTYPE , PROP 
, P_12A , P_15 , P_1A , P_4A , P_9 , SHARED_KEY_IMP_SEES_KEY 
, TYPES , 0

*)
initializecounter();
s "A `BELIEVES (S `SAYS Na)";
ri "TACTIC_AND_BELIEF";ex();
left();
rri "NS_A_THEOREM2";ex();
top();
rri "BELIEVE_AND";ex();
ri "TACTIC_IMP_BELIEF";ex();
left();
rri "NS_A_THEOREM4";ex();
assign "?y_5" "?y_2";
top();          
ri "TACTIC_IMP";ex();

left();
rri "NECESSITATION";ex();
assign "?A_7" "A";
right();
rri "AXIOM_15A";ex();
assign "?P_8" "S";
assign "?x_8" " Na";
assign "?y_8" "(Principal : B) , ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y_2";
top();
ri "BELIEVE_IMP";ex();
prove "NS_A_THEOREM5A";


(*
NS_A_THEOREM5B:  

A `BELIEVES S `SAID Na  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , NECESSITATION , NTYPE 
, PROP , P_12A , P_15 , P_4A , P_9 , SAID_IMP1 , SHARED_KEY_IMP_SEES_KEY 
, TYPES , 0

*)
initializecounter();
s "A `BELIEVES (S `SAID Na)";
ri "TACTIC_IMP_BELIEF";ex();
left();
rri "NS_A_THEOREM2";ex();
top();
ri "TACTIC_IMP";ex();

left();
rri "NECESSITATION";ex();
assign "?A_4" "A";
right();
rri "SAID_IMP1";ex();
assign "?P_5" "S";
assign "?x_5" "Na"; 
assign "?y_5" "(Principal : B) , ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y_2";
top();
ri "BELIEVE_IMP";ex();
prove "NS_A_THEOREM5B";



(* 
NS_A_THEOREM5C:  

A `BELIEVES S `SAYS Principal : B  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_15A , AXIOM_17A , AXIOM_19 
, AXIOM_20 , BASSOC , BDIS , BELIEVE_AND , BELIEVE_IMP 
, BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , IDEF , IMPTYPE , NECESSITATION , NTYPE , PROP 
, P_12A , P_15 , P_1A , P_4A , P_9 , SAID_AXIOM , SAID_IMP1 
, SAYS_AXIOM , SHARED_KEY_IMP_SEES_KEY , TYPES , 0

*)

initializecounter();
s "A `BELIEVES (S `SAYS Principal:B)";
ri "TACTIC_AND_BELIEF";ex();
left();
rri "NS_A_THEOREM2";ex();
right();
ri "SAID_AXIOM";ex();
up();
ri "BELIEVE_AND";ex();
left();
ri "NS_A_THEOREM5B";ex();
up();
rri "TACTIC_AND_BELIEF";ex();

top();
rri "BELIEVE_AND";ex();
ri "TACTIC_IMP_BELIEF";ex();
left();
rri "NS_A_THEOREM4";ex();
assign "?y_9" "?y_2";
right();
ri "SAYS_AXIOM";ex();
up();
ri "BELIEVE_AND";ex();
left();
ri "NS_A_THEOREM5A";ex();
up();
rri "TACTIC_AND_BELIEF";ex();
top();
ri "TACTIC_IMP";ex();

left();
rri "NECESSITATION";ex();
assign "?A_15" "A";
right();
rri "AXIOM_15A";ex();
assign "?P_16" "S";
assign "?x_16" "Principal : B";
assign "?y_16" "((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y_2";
top();
ri "BELIEVE_IMP";ex();
prove "NS_A_THEOREM5C";



(*   
NS_A_THEOREM5D:  

A `BELIEVES S `SAID Principal : B  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , NECESSITATION , NTYPE 
, PROP , P_12A , P_15 , P_4A , P_9 , SAID_AXIOM , SAID_IMP1 
, SHARED_KEY_IMP_SEES_KEY , TYPES , 0

*)
initializecounter();
s "A `BELIEVES (S `SAID Principal : B)";
ri "TACTIC_IMP_BELIEF";ex();
left();
rri "NS_A_THEOREM2";ex();
ri "RIGHT@SAID_AXIOM";ex();

ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5B";ex();
rri "TACTIC_AND_BELIEF";ex();
top();
ri "TACTIC_IMP";ex();
left();
rri "NECESSITATION";ex();
assign "?A_12" "A";
right();
rri "SAID_IMP1";ex();
assign "?P_13" "S";
assign "?x_13" "Principal : B";
assign "?y_13" "((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Message : ?y_2";
top();
ri "BELIEVE_IMP";ex();
prove "NS_A_THEOREM5D";



(*
PRE_NS_A_THM5E_SAID:  

S `SAID ((shared_key @ A , B , Kab) , Fresh @ Skey 
      : Kab) , Message : ?y_5  =  

S `SAID (shared_key @ A , B , Kab) , (Fresh @ Skey 
      : Kab) , Message : ?y_5

BASSOC , BDIS , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , MESSAGE_TYPE , NTYPE , PROP , SAID_AXIOM , SAID_TYPE 
, TYPES , 0

*)
initializecounter();
s "S `SAID ((shared_key @ A , B , Kab) , Fresh @ Skey : Kab) , Message : ?y_5";
ri "SAID_AXIOM";ex();
left();
ri "SAID_TYPE";ex();
right();right();right();
ri "MESSAGE_TYPE";ex();
up();up();up();
rri "SAID_TYPE";ex();

ri "SAID_AXIOM";ex();
ri "LEFT@SAID_REM_TLABEL";ex();
ri "RIGHT@SAID_REM_TLABEL";ex();
top();

rri "AND_ASSOC";ex();
right();
rri "SAID_AXIOM";ex();
top();
rri "SAID_AXIOM";ex();
p "PRE_NS_A_THM5E_SAID";



(*
PRE_NS_A_THM5E_SAYS:  

S `SAYS ((shared_key @ A , B , Kab) , Fresh @ Skey 
      : Kab) , Message : ?y_2  =  

S `SAYS (shared_key @ A , B , Kab) , (Fresh @ Skey 
      : Kab) , Message : ?y_2

BASSOC , BDIS , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , MESSAGE_TYPE , NTYPE , PROP , SAYS_AXIOM , SAYS_TYPE 
, TYPES , 0

*)
initializecounter();
s "S `SAYS ((shared_key @ A , B , Kab) , Fresh @ Skey : Kab) , Message : ?y_2";
ri "SAYS_AXIOM";ex();
left();
ri "SAYS_TYPE";ex();
right();right();right();
ri "MESSAGE_TYPE";ex();
up();up();up();
rri "SAYS_TYPE";ex();

ri "SAYS_AXIOM";ex();
ri "LEFT@SAYS_REM_TLABEL";ex();
ri "RIGHT@SAYS_REM_TLABEL";ex();
top();

rri "AND_ASSOC";ex();
right();
rri "SAYS_AXIOM";ex();
top();
rri "SAYS_AXIOM";ex();
p "PRE_NS_A_THM5E_SAYS";


(*    
NS_A_THEOREM5E:  

A `BELIEVES S `SAYS shared_key @ A , B , Kab  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_15A , AXIOM_17A , AXIOM_19 
, AXIOM_20 , BASSOC , BDIS , BELIEVE_AND , BELIEVE_IMP 
, BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , IDEF , IMPTYPE , MESSAGE_TYPE , NECESSITATION 
, NTYPE , PROP , P_12A , P_15 , P_1A , P_4A , P_9 
, SAID_AXIOM , SAID_IMP1 , SAID_TYPE , SAYS_AXIOM 
, SAYS_TYPE , SHARED_KEY_IMP_SEES_KEY , TYPES , 0


*)

initializecounter();
s "A `BELIEVES (S `SAYS (shared_key @ A , B , Kab))";
ri "TACTIC_AND_BELIEF";ex();
left();
rri "NS_A_THEOREM2";ex();
ri "RIGHT@SAID_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5B";ex();
rri "TACTIC_AND_BELIEF";ex();
ri "RIGHT@SAID_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5D";ex();
rri "TACTIC_AND_BELIEF";ex();

ri "RIGHT@PRE_NS_A_THM5E_SAID";ex();
top();
rri "BELIEVE_AND";ex();
ri "TACTIC_IMP_BELIEF";ex();
left();
rri "NS_A_THEOREM4";ex();
assign "?y_24" "?y_2";
ri "RIGHT@SAYS_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5A";ex();
rri "TACTIC_AND_BELIEF";ex();
ri "RIGHT@SAYS_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5C";ex();
rri "TACTIC_AND_BELIEF";ex();
ri "RIGHT@PRE_NS_A_THM5E_SAYS";ex();

top();
ri "TACTIC_IMP";ex();
left();
rri "NECESSITATION";ex();
assign "?A_45" "A";
right();
rri "AXIOM_15A";ex();
assign "?P_46" "S";
assign "?x_46" "shared_key @ A , B , Kab ";
assign "?y_46" "(Fresh @ Skey : Kab) , Message : ?y_2";
top();
ri "BELIEVE_IMP";ex();
prove "NS_A_THEOREM5E";

(*
NS_A_THEOREM5:  

A `BELIEVES shared_key @ A , B , Kab  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_15A , AXIOM_16 , AXIOM_17A 
, AXIOM_19 , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , MESSAGE_TYPE , NECESSITATION 
, NTYPE , PROP , P_12A , P_15 , P_1A , P_2A , P_4A 
, P_9 , SAID_AXIOM , SAID_IMP1 , SAID_TYPE , SAYS_AXIOM 
, SAYS_TYPE , SHARED_KEY_IMP_SEES_KEY , TYPES , 0

*)
initializecounter();
s "true";
rri "AXIOM_01";ex();
assign "?P_1" "A";
assign "?si_1" "(S `CONTROLS (shared_key @ A , B , Kab)) & (S `SAYS (shared_key @ A , B , Kab))";
left();left(); 
ri "BELIEVE_AND";ex();
ri "LEFT@P_2A";ex();
ri "RIGHT@NS_A_THEOREM5E";ex();
ri "AND_TRUE";ex();
up();right();
assign "?delta_1" "shared_key @ A , B , Kab";
ri "RIGHT@AXIOM_16";ex();
ri "NECESSITATION";ex();
up();
ri "AND_COMM**AND_TRUE";ex();

ri "TYPES";ex();
top();
ri "IMP_TYPE";ex();
ri "RIGHT@LEFT@TYPES";ex();
rri "IMP_TYPE";ex();
rri "TACTIC_IMP_BELIEF";ex();
wb();
p "NS_A_THEOREM5";



(*    
NS_A_THEOREM6A:  

A `BELIEVES S `SAID shared_key @ A , B , Kab  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , MESSAGE_TYPE , NECESSITATION 
, NTYPE , PROP , P_12A , P_15 , P_4A , P_9 , SAID_AXIOM 
, SAID_IMP1 , SAID_TYPE , SHARED_KEY_IMP_SEES_KEY 
, TYPES , 0

*)
initializecounter();
s "A `BELIEVES (S `SAID (shared_key @ A , B , Kab))";
ri "TACTIC_IMP_BELIEF";ex();
left();
rri "NS_A_THEOREM2";ex();
ri "RIGHT@SAID_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5B";ex();
rri "TACTIC_AND_BELIEF";ex();

ri "RIGHT@SAID_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5D";ex();
rri "TACTIC_AND_BELIEF";ex();
ri "RIGHT@PRE_NS_A_THM5E_SAID";ex();

top();
ri "TACTIC_IMP";ex();
left();
rri "NECESSITATION";ex();
assign "?A_23" "A";
right();
rri "SAID_IMP1";ex();
assign "?P_24" "S";
assign "?x_24" "shared_key @ A , B , Kab";
assign "?y_24" "(Fresh @ Skey : Kab) , Message : ?y_2";
top();
ri "BELIEVE_IMP";ex();
prove "NS_A_THEOREM6A";



(*   
NS_A_THEOREM6B:  

A `BELIEVES S `SAYS Fresh @ Skey : Kab  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_15A , AXIOM_17A , AXIOM_19 
, AXIOM_20 , BASSOC , BDIS , BELIEVE_AND , BELIEVE_IMP 
, BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , IDEF , IMPTYPE , MESSAGE_TYPE , NECESSITATION 
, NTYPE , PROP , P_12A , P_15 , P_1A , P_4A , P_9 
, SAID_AXIOM , SAID_IMP1 , SAID_TYPE , SAYS_AXIOM 
, SAYS_TYPE , SHARED_KEY_IMP_SEES_KEY , TYPES , 0

*)
initializecounter();
s "A `BELIEVES (S `SAYS (Fresh @ (Skey : Kab)))";
ri "TACTIC_AND_BELIEF";ex();
left();
rri "NS_A_THEOREM2";ex();
ri "RIGHT@SAID_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5B";ex();
rri "TACTIC_AND_BELIEF";ex();
ri "RIGHT@SAID_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5D";ex();
rri "TACTIC_AND_BELIEF";ex();

ri "RIGHT@PRE_NS_A_THM5E_SAID";ex();
ri "RIGHT@SAID_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM6A";ex();
rri "TACTIC_AND_BELIEF";ex();

top();
rri "BELIEVE_AND";ex();
ri "TACTIC_IMP_BELIEF";ex();

left();
rri "NS_A_THEOREM4";ex();
assign "?y_32" "?y_2";
ri "RIGHT@SAYS_AXIOM";ex();

ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5A";ex();
rri "TACTIC_AND_BELIEF";ex();
ri "RIGHT@SAYS_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5C";ex();
rri "TACTIC_AND_BELIEF";ex();

ri "RIGHT@PRE_NS_A_THM5E_SAYS";ex();
ri "RIGHT@SAYS_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_A_THEOREM5E";ex();
rri "TACTIC_AND_BELIEF";ex();

top();
ri "TACTIC_IMP";ex();
left();
rri "NECESSITATION";ex();
assign "?A_61" "A";
right();
rri "AXIOM_15A";ex();
assign "?P_62" "S";
assign "?x_62" "Fresh @ Skey : Kab";
assign "?y_62" "Message : ?y_2";
top();
ri "BELIEVE_IMP";ex();
prove "NS_A_THEOREM6B";


(*    
NS_A_THEOREM6:  

A `BELIEVES Fresh @ Skey : Kab  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_15A , AXIOM_16 , AXIOM_17A 
, AXIOM_19 , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , MESSAGE_TYPE , NECESSITATION 
, NTYPE , PROP , P_12A , P_15 , P_1A , P_3A , P_4A 
, P_9 , SAID_AXIOM , SAID_IMP1 , SAID_TYPE , SAYS_AXIOM 
, SAYS_TYPE , SHARED_KEY_IMP_SEES_KEY , TYPES , 0


*)
initializecounter();
s "true";
rri "AXIOM_01";ex();
assign "?P_1" "A";
assign "?si_1" "(S `CONTROLS (Fresh @ (Skey : Kab))) & (S `SAYS Fresh @ (Skey : Kab))";
left();left(); 
ri "BELIEVE_AND";ex();
ri "LEFT@P_3A";ex();
ri "RIGHT@NS_A_THEOREM6B";ex();
ri "AND_TRUE";ex();
top();
assign "?delta_1" "Fresh @ (Skey : Kab)";
left();right();

ri "RIGHT@AXIOM_16";ex();
ri "NECESSITATION";ex();
up();
ri "AND_COMM**AND_TRUE";ex();

ri "TYPES";ex();
top();
ri "IMP_TYPE";ex();
ri "RIGHT@LEFT@TYPES";ex();
rri "IMP_TYPE";ex();
rri "TACTIC_IMP_BELIEF";ex();
wb();
p "NS_A_THEOREM6";




(******************)
(* Theorems for B *)
(******************)


(* 
NS_B_THEOREM1:  

B `BELIEVES B `RECEIVED Kbs `se ((shared_key @ A , B 
      , Kab) , Fresh @ Skey : Kab) , Principal : A  =  

true

AXIOM_01 , BASSOC , BDIS , BELIEVE_TYPE , BID , BID2 
, BSYM , BTYPE , CTYPE , DDIS , DIDEM , DSYM , DTYPE 
, DXM , FDEF , GR , IDEF , NTYPE , PROP , P_10 , P_13B 
, TYPES , 0

*)

initializecounter();
s "true";
rri "AXIOM_01";ex();
assign "?P_1" "B";
left();left();right();
assign "?si_1" "B `RECEIVED (Kbs `se (Message : ?z) , Principal : A)";
up();
ri "P_10";ex();
up();right();
assign "?delta_1" "(B `RECEIVED Kbs `se ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Principal : A)";
ri "P_13B";ex();
top();
ri "LEFT@CID**AT"; ex();
ri "IMP_TRUE"; ex();
ri "TREMTOP@BELIEVE_TYPE"; ex();
wb();
p "NS_B_THEOREM1";


(* Need to prove this. For time being taking it as a AXIOM *)
axiom "NS_B_THM2" "B `BELIEVES (S `SAID ((shared_key @ (A , B , Kab)) , (Fresh @ Skey : Kab) , Principal : A))" "true";

(* To prove the above axiom we need another axiom *)

a "P_16A" "B `BELIEVES (B `RECEIVED Kbs `se ((shared_key @ A , B , Kab) , Fresh @ Skey : Kab) , ?x) -> B `RECEIVED_FROM S , Kbs `se ((shared_key @ A , B , Kab) , Fresh @ Skey : Kab) , ?x" "true";

(*  
GOAL_2_B:  

B `BELIEVES (S `SAID ((shared_key @ A , B , Kab) , Fresh 
         @ Skey : Kab) , Principal : A) & S `SEES Kbs  =  

true

AXIOM_01 , AXIOM_03A , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , IDEF , NTYPE , PROP , P_10 , P_13B , P_16A 
, P_4B , TYPES , 0

*)

getleftside "NS_B_THEOREM1";

ri "TADDTOP@BELIEVE_TYPE"; ex();
rri "PROP"; ex();
rri "CID"; ex();
right(); initializecounter(); rri "P_16A"; ex();
assign "?x_1" "Principal : A";
top(); rri "BELIEVE_AND"; ex();
right(); ri "3pt66"; ex();
top(); ri "BELIEVE_AND"; ri "LEFT@NS_B_THEOREM1"; ex();
ri "CSYM**CID**PROP**TREMTOP@BELIEVE_TYPE"; ex();
saveenv "Useful_Lemma";

ri "TADDTOP@BELIEVE_TYPE"; rri "PROP"; rri "CID"; ri "CSYM"; ex();
left(); rri "P_4B"; ex();
up(); rri "BELIEVE_AND"; ex();
right(); rri "CRULE1"; rri "CID"; ex();
right(); initializecounter(); rri "AXIOM_03A"; ex();
assign "?P_1,?Q_1,?R_1,?k_1,?x_1" "B,S,B,Kbs,(((shared_key @ A , B , Kab) , Fresh @ Skey : Kab) , Principal : A)";
uptols "3pt66"; ri "3pt66"; ex();
uptols "BELIEVE_AND"; ri "BELIEVE_AND"; ex();
ri "LEFT@BELIEVE_AND"; ex();
left();left();ri "P_4B"; ex();
up();ri "CSYM**CID**PROP**TREMTOP@BELIEVE_TYPE"; ex();
applyconvenv "Useful_Lemma"; ri "NS_B_THEOREM1"; ex();
up(); ri "CSYM**CID**PROP**TREMTOP@BELIEVE_TYPE"; ex();
wb(); ri "NS_B_THEOREM1"; ex();
p "GOAL_2_B";

saveenv "backup";
dropenv "Useful_Lemma";



(*
NS_B_THEOREM2:  

B `BELIEVES S `SAID ((shared_key @ A , B , Kab) , Fresh 
      @ Skey : Kab) , Principal : A  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , NECESSITATION , NTYPE 
, PROP , P_10 , P_13B , P_16A , P_4B , SHARED_KEY_IMP_SEES_KEY 
, TYPES , 0

*)

initializecounter();
s "true";
rri "GOAL_2_B";ex();
ri "BELIEVE_AND";ex();
right();
ri "TACTIC_IMP_BELIEF";ex();

left();
rri "P_4B";ex();
up();
ri "TACTIC_IMP";ex();
left();
rri "BELIEVE_IS_BELIEVE_TRUE1";ex();

assign "?P_6" "B";
assign "?x_6" "shared_key @ B , S , Kbs";ex();
ri "LEFT@P_4B";ex();
rri "TACTIC_IMP_BELIEF";ex();
right();
rri "SHARED_KEY_IMP_SEES_KEY";ex();

assign "?x_11" "S";
assign "?y_11" "B";
assign "?k_11" "Kbs";

left();
ri "AXIOM_20";ex();
up();up();up();
ri "BELIEVE_IMP";ex();
up();
ri "AND_COMM**AND_TRUE";ex();
ri "RIGHT@BELIEVE_TYPE";ex();
ri "TYPES";ex();
rri "BELIEVE_TYPE";ex();
wb();
p "NS_B_THEOREM2";



(*  
PRE_NS_B_THEOREM3:  

S `SAID ((shared_key @ A , B , Kab) , Fresh @ Skey 
      : Kab) , Principal : A  =  

S `SAID (shared_key @ A , B , Kab) , (Fresh @ Skey 
      : Kab) , Principal : A

BASSOC , BDIS , BID , BID2 , BSYM , BTYPE , CTYPE 
, DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM , FDEF 
, GR , NTYPE , PROP , SAID_AXIOM , TYPES , 0

*)

initializecounter();
s "S `SAID ((shared_key @ A , B , Kab) , Fresh @ Skey : Kab) , Principal : A";
ri "SAID_AXIOM";ex();
left();right();right();right();
ri "MESSAGE_TYPE";ex();
up();up();up();
rri "SAID_TYPE";ex();
ri "SAID_AXIOM";ex();
ri "LEFT@SAID_REM_TLABEL";ex();
ri "RIGHT@SAID_REM_TLABEL";ex();
up();

rri "AND_ASSOC";ex();
right();
rri "SAID_AXIOM";ex();
up();
rri "SAID_AXIOM";ex();
p "PRE_NS_B_THEOREM3";


(*   
NS_B_THEOREM3:  

B `BELIEVES S `SAID shared_key @ A , B , Kab  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , NECESSITATION , NTYPE 
, PROP , P_10 , P_13B , P_16A , P_4B , SAID_AXIOM 
, SAID_IMP1 , SHARED_KEY_IMP_SEES_KEY , TYPES , 0

*)

initializecounter();
s "true";
rri "AXIOM_01";ex();
assign "?P_1" "B"; 
assign "?si_1" "S `SAID ((shared_key @ A , B , Kab) , (Fresh @ Skey : Kab)) , Principal : A";
left();left();      
ri "NS_B_THEOREM2";ex();
up();
rri "TACTIC_AND_BELIEF";ex();

right();left();
ri "PRE_NS_B_THEOREM3";ex();
assign "?delta_1" "S `SAID (shared_key @ (A , B , Kab))";
up();
ri "SAID_IMP1";ex();
up();ri "NECESSITATION";ex();
top();
rri "TACTIC_IMP_BELIEF";ex();
wb();
p "NS_B_THEOREM3";



(*
NS_B_THEOREM4A:  

B `BELIEVES S `SAID (Fresh @ Skey : Kab) , Principal 
   : A  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , NECESSITATION , NTYPE 
, PROP , P_10 , P_13B , P_16A , P_4B , SAID_AXIOM 
, SAID_IMP1 , SHARED_KEY_IMP_SEES_KEY , TYPES , 0

*)
initializecounter();
s "true";
rri "NS_B_THEOREM2";ex();
ri "RIGHT@PRE_NS_B_THEOREM3";ex();
ri "RIGHT@SAID_AXIOM";ex();
ri "BELIEVE_AND";ex();
ri "LEFT@NS_B_THEOREM3";ex();
rri "TACTIC_AND_BELIEF";ex();
wb();
prove "NS_B_THEOREM4A";


(*  
NS_B_THEOREM4:  

B `BELIEVES S `SAID Fresh @ Skey : Kab  =  

true

AXIOM_01 , AXIOM_03A , AXIOM_20 , BASSOC , BDIS , BELIEVE_AND 
, BELIEVE_IMP , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , IMPTYPE , NECESSITATION , NTYPE 
, PROP , P_10 , P_13B , P_16A , P_4B , SAID_AXIOM 
, SAID_IMP1 , SHARED_KEY_IMP_SEES_KEY , TYPES , 0

*)

initializecounter();
s "true";
rri "AXIOM_01";ex();
assign "?P_1" "B"; 
assign "?si_1" "S `SAID ((Fresh @ Skey : Kab) , Principal : A)";
left();     
ri "LEFT@NS_B_THEOREM4A";ex();
rri "TACTIC_AND_BELIEF";ex();

assign "?delta_1" "S `SAID (Fresh @ (Skey : Kab))";
right();
ri "SAID_IMP1";ex();
up();ri "NECESSITATION";ex();
up();
rri "TACTIC_IMP_BELIEF";ex();
wb();
p "NS_B_THEOREM4";



(*   
NS_B_THEOREM5:  

B `BELIEVES B `RECEIVED Kab `se Nb - 1  =  

true

AXIOM_01 , BASSOC , BDIS , BELIEVE_AND , BELIEVE_TYPE 
, BID , BID2 , BSYM , BTYPE , CTYPE , DDIS , DIDEM 
, DSYM , DTYPE , DXM , FDEF , GR , IDEF , IMPTYPE 
, NTYPE , PROP , P_10 , P_11 , P_14 , TYPES , 0

*)

initializecounter();
s "true";
rri "AXIOM_01";ex();
assign "?P_1" "B";
assign "?si_1" "((B `RECEIVED Kbs `se (Message : ?z) , Principal : A) & (B `RECEIVED (Message : ?z) `se Nb - 1))";
left();left();
ri "BELIEVE_AND";ex();
ri "LEFT@P_10";ex();
ri "RIGHT@P_11";ex();
up();right();
assign "?delta_1" "(B `RECEIVED (Kab `se (Nb - 1)))";
ri "P_14";ex();
up();
ri "AND_COMM**AND_TRUE";ex();
ri "RIGHT@AND_TRUE";ex();
ri "TYPES";ex();
top();
ri "IMP_TYPE";ex();
ri "RIGHT@LEFT@TYPES";ex();
rri "IMP_TYPE";ex();
rri "TACTIC_IMP_BELIEF";ex();
wb();
p "NS_B_THEOREM5";



quit();
