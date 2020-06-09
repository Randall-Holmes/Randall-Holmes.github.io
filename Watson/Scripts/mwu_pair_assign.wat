(* load "omnibus"; *)
script "natorder";
script "algebra2";

(* implement pair assignment *)

(* Here are definition of "PAIR_ASSIGNDEF" *)

(*  BEGIN environment for development of pair assignment *)

(* the new definition of pair assignment in terms of single assignment *)

declareinfix ":,=";
axiom "PAIRASSIGN" "(?x,?y):,=(?a,?b)" "[[(((address:?x)=address:?y)|([error]=((?x:=?a)@state:?1))|([error]=((?y:=?b)@state:?1)))||error,((address:?x)=address:?2)||(((?x:=?a)@state:?1)@address:?2),((address:?y)=address:?2)||(((?y:=?b)@state:?1)@address:?2),(state:?1)@address:?2]]";

(* a perhaps enlightening calculation *)

(*

PAIRASSIGN_1:  

(((?x , ?y) :,= ?a , ?b) @ ?s) @ ?u  =  

(((state : ?s) = [error]) | (([error] = (?y := ?b) 
            @ state : ?s) | [error] = (?x := ?a) @ state 
               : ?s) | (address : ?x) = address : ?y) 
|| error , ((address : ?x) = address : ?u) || ((rexp 
            : ?a) @ state : ?s) , ((address : ?y) 
            = address : ?u) || ((rexp : ?b) @ state 
                  : ?s) , (state : ?s) @ address : ?u

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, HYP , NONTRIV , NOT1 , ODDCHOICE , ONEASSIGN , OR 
, PAIRASSIGN , REFLEX , TYPES , 0

*)

s "(((?x,?y):,=?a,?b)@?s)@?u";
ri "LEFT@LEFT@PAIRASSIGN"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE@REVPIVOT"; ex();
ri "EVERYWHERE@ONEASSIGN_1"; ex();
ri "EVERYWHERE2@TYPES**REFLEX**DSYM**DZER**CID**ASSERT_EXP"; ex();
ri "PCASEINTRO@ ~(state:?s)=[error]"; ri "EVERYWHERE@POP_CASE"; ex();
ri "TAB_NOT_2"; ex();
right(); left(); ri "EVERYWHERE2@(0|-|1)**EVAL"; ex();
ri "EVERYWHERE@ $CASEINTRO"; ex();
top(); rri "TAB_OR_2"; ex();
prove "PAIRASSIGN_1";

(* END  environment for development of pair assignment *)

(*****************************************************************************
PAIRASSIGNTYPE:  

(?u , ?v) :,= ?x , ?y  =  

command : ((address : ?u) , address : ?v) :,= (rexp 
      : ?x) , rexp : ?y

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , ERRORDATA 
, FNDIST , NONTRIV , NOT1 , ODDCHOICE , ONEASSIGN 
, OR , PAIRASSIGN , REFLEX , TYPES , command , rexp 
, state , 0
*)

s "(?u,?v) :,= ?x,?y";
ri "PAIRASSIGN";ex();
right();ri "PCASEINTRO@(state:?1)=[error]"; ex();
right();left();right();left();right();left();right();
ri "RIGHT@0|-|1";ex();
ri "LEFT@ONEASSIGNTYPE";ex();
ri "ERRORINVARIANCE";ex();
up();ri "REFLEX";ex();
up();ri "DSYM**DZER";ex();
up();ri "DZER";ex();
up();ex();
up();up();right();
downtoright "?v:=?y"; up();up(); 

saveenv "wp_pair_assign1";

(**************** prove lemma "ONEASSIGN_DATA"

ONEASSIGN_DATA:  

((?v := ?x) @ ?s) @ ?u  =  

data : ((?v := ?x) @ ?s) @ ?u

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , ERRORDATA 
, FNDIST , NONTRIV , NOT1 , ONEASSIGN , OR , REFLEX 
, TYPES , rexp , state , 0
*)

s "((?v:=?x)@?s)@?u";  
ri "ONEASSIGN_1";ex();
right();left();
ri "REXPTYPE";ex();
up();right();
ri "(LEFT@state)**EVAL";ex();
rri "TYPES";ex();
right();ri "BIND@address:?u";ex();
ri "LEFT@ $state";ex();
top();ri "ANTI_UNEVAL_TAC@[data:?1]";ex();
ri "EVERYWHERE2@TYPES";ex();
ri "RIGHT@ $ONEASSIGN_1";ex();

p "ONEASSIGN_DATA";

getenv "wp_pair_assign1";

ri "ONEASSIGN_DATA";ex();
up();right(); ri "(LEFT@state)**EVAL";ex();
rri "TYPES";ex();
ri "RIGHT@BIND@address:?2";ex();
right(); ri "LEFT@ $state";ex();
up();up();up(); ri "ANTI_UNEVAL_TAC@[data:?3]";ex();
up();left(); ri "ONEASSIGN_DATA";ex();
up();up(); ri "ANTI_UNEVAL_TAC@[data:?3]";ex();
up();left(); ri "ERRORDATA";ex();
up();up(); ri "ANTI_UNEVAL_TAC@[data:?3]";ex();
right(); ri "TYPEBIND@address:?2"; ex();
uptors "state"; rri "state"; ex();
right(); ri "TYPEBIND@state:?1"; ex();
uptors "command";rri "command"; ex();

downtoleft "(address:?x)=address:?y";
ri "RL@ $TYPES";ex();
up();right();right();right();
ri "LEFT@ONEASSIGNTYPE";ex();
left();right(); ri "RL@ $TYPES";ex();
up(); rri "ONEASSIGNTYPE";ex();
up();up();up();left();right();
ri "LEFT@ONEASSIGNTYPE";ex();
left();right(); ri "RL@ $TYPES";ex();
up(); rri "ONEASSIGNTYPE";ex();

top();right();right();right();right();right();
left(); ri "LEFT@ $TYPES";ex();
up();right();left();left();
ri "LEFT@ONEASSIGNTYPE";ex();
left();right(); ri "RL@ $TYPES";ex();
up(); rri "ONEASSIGNTYPE";ex();
up();up();up();right();
left(); ri "LEFT@ $TYPES";ex();
up();right();left();left();
ri "LEFT@ONEASSIGNTYPE";ex();
left();right(); ri "RL@ $TYPES";ex();
up(); rri "ONEASSIGNTYPE";ex();
top(); ri "RIGHT@ $PAIRASSIGN";ex();

p "PAIRASSIGNTYPE";

(* before I prove weakest precondition, I need to prove the following lemma *)

(****************************************************************
   FUNCTION_BOOL_EQ:  
   ([?p] = [?q]) == ?p = ?q   =
   true
   -----------------------------------------------
   BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST , IFF 
   , NONTRIV , ODDCHOICE , REFLEX , TYPES , 0
*)

s "([?p]=[?q])==?p=?q";
rri "3pt80";ex();
left(); ri "IMPTOCOND";ex();
right();right();left();left();
ri "BIND@?a";ex();
ri "(LEFT@0|-|1)**EVAL";ex();
up(); ri "REFLEX";ex();
up();up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();
up();right(); ri "IMPTOCOND";ex();
right();right();left();left();
left();ri "0|-|1";ex();
up();up(); ri "REFLEX";ex();
up();up(); rri "CASEINTRO";ex();
up(); ri "AT";ex();
up(); ri "CID**AT";ex();
 
p "FUNCTION_BOOL_EQ"; 

(****************************************************************
   FUNCTION_EQ:  
   [?p] = [?q]   =
   ?p = ?q
   -----------------------------------------------
   BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST , NONTRIV 
   , ODDCHOICE , REFLEX , TYPES , 0
*)

s "[?p]=[?q]";
ri "ASRTEQ** $BID2";ex();
initializecounter();
ri "RIGHT@ $FUNCTION_BOOL_EQ";ex();
assign "?p_4" "?p";
assign "?q_4" "?q";
rri "BASSOC";ex();
ri "LEFT@BID";ex();
ri "BSYM**BID2";ex();
rri "ASRTEQ";ex();

p "FUNCTION_EQ";


(* Now my weakest precondition for pair assignment *)

(**********************************************************************)

(* demo(); *)

s "(wp@[(?u,?v) :,= ?x,?y])@[?B@((state:?1)@?u),(state:?1)@?v]";
ri "wp";ex();
ri "EVERYWHERE2@EVAL";ex();
right();
ri "PCASEINTRO@(~(state:?1)=[error])&(~(address:?u)=address:?v)&(~[error]=(?u:=?x)@state:?1)&(~[error]=(?v:=?y)@state:?1)&(~error=((?u:=?x)@state:?1)@address:?u)&(~error=((?v:=?y)@state:?1)@address:?v)&?B@(((?u:=?x)@state:?1)@address:?u),((?v:=?y)@state:?1)@address:?v";ex();
ri "(LEFT@AND)**UNPACK";ex();
right();left(); ri "(LEFT@AND)**UNPACK";ex();
right();left(); ri "(LEFT@AND)**UNPACK";ex();
right();left(); ri "(LEFT@AND)**UNPACK";ex();
right();left(); ri "(LEFT@AND)**UNPACK";ex();
right();left(); ri "(LEFT@AND)**UNPACK";ex();
top();right();ri "(LEFT@NOT)**UNPACK";ex();
right();left();left();right();right(); ri "RIGHT@0|-|1";ex();
ri "ERRORINVARIANCE";ex();
up(); ri "REFLEX";ex();
up(); rri "FDEF";ex();
up(); ri "CSYM**CZER";ex();

up();right(); (* new case 1 *)
downtoleft "?x&?y";
left();right();right();
ri "LEFT@TREMTOP@PAIRASSIGNTYPE";ex();
ri "(LEFT@PAIRASSIGN)**EVAL**EVERYWHERE2@TYPES";ex();
downtoleft "?x=?y"; 
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();
up();right();left(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();
rri "FDEF";ex();
up();right(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();
up();up(); ri "EVERYWHERE2@ALTORDEF";ex();

saveenv "proof0";
getenv "proof0";

up();ex();
up();up(); ri "EQUATION";ex();
right();left(); ri "(!$REFLEX)@error";ex();
right(); ri "BIND@?u";ex();
ri "(LEFT@0|-|8)**EVAL";ex();
ri "LEFT@REFLEX";ex();
up(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|5";ex();
rri "FDEF";ex();
up();up(); rri "CASEINTRO";ex();
up(); ri "NEGF";ex();
up(); ri "CSYM**CID";ex();
right();right();left();
ri "(LEFT@state)**EVAL";ex();
right();left();
ri "LEFT@TREMTOP@PAIRASSIGNTYPE";ex();
ri "(LEFT@PAIRASSIGN)**EVAL**EVERYWHERE2@TYPES";ex();
right();left();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();

up();right();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();
rri "FDEF";ex();
up();right(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();
up();up(); ri "EVERYWHERE2@ALTORDEF";ex();   
up();ex();
up();up(); ri "EVAL";ex();
ri "EVERYWHERE2@TYPES";ex();
ri "LEFT@REFLEX";ex();
ri "ONEASSIGN_1";ex();
up(); ri "UNEVAL_TAC@[data:?2]";ex();
right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?u";ex();
ri "LEFT@ $state";ex();

saveenv "proof1";
getenv "proof1";

up();up(); rri "ONEASSIGN_1";ex();
up();right(); ri "(LEFT@state)**EVAL";ex();
right();left();
ri "LEFT@TREMTOP@PAIRASSIGNTYPE";ex();
ri "(LEFT@PAIRASSIGN)**EVAL**EVERYWHERE2@TYPES";ex();
right();left();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();
up();right();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();
rri "FDEF";ex();
up();right(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();

up();up(); ri "EVERYWHERE2@ALTORDEF";ex();
up();ex();
up();up(); ri "EVAL";ex();
ri "EVERYWHERE2@TYPES";ex();
left(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();  
rri "FDEF";ex();
up();ex();
ri "LEFT@REFLEX";ex();
ri "ONEASSIGN_1";ex();
up(); ri "UNEVAL_TAC@[data:?2]";ex();
right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?v";ex();
ri "LEFT@ $state";ex();
up();up(); rri "ONEASSIGN_1";ex();
up();up(); rri "0|-|7";ex();
up(); ri "AT";ex();

saveenv "proof2";
getenv "proof2";

up();right();right();right();left();
ri "(LEFT@state)**EVAL";ex();
right();left();
ri "LEFT@TREMTOP@PAIRASSIGNTYPE";ex();
ri "(LEFT@PAIRASSIGN)**EVAL**EVERYWHERE2@TYPES";ex();
right();left();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();
up();right();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();
rri "FDEF";ex();
up();right(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();

up();up(); ri "EVERYWHERE2@ALTORDEF";ex();
up();ex();
up();up(); ri "EVAL";ex();
ri "EVERYWHERE2@TYPES";ex();
ri "LEFT@REFLEX";ex();
ri "ONEASSIGN_1";ex();
up(); ri "UNEVAL_TAC@[data:?2]";ex();
right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?u";ex();
ri "LEFT@ $state";ex();
up();up(); rri "ONEASSIGN_1";ex();
up();right();
ri "(LEFT@state)**EVAL";ex();

saveenv "proof3";
getenv "proof3";

right();left();
ri "LEFT@TREMTOP@PAIRASSIGNTYPE";ex();
ri "(LEFT@PAIRASSIGN)**EVAL**EVERYWHERE2@TYPES";ex();
right();left();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();
up();right();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();
rri "FDEF";ex();
up();right(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();
up();up(); ri "EVERYWHERE2@ALTORDEF";ex();
up();ex();
up();up(); ri "EVAL";ex();
ri "EVERYWHERE2@TYPES";ex();
left(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();  
rri "FDEF";ex();
up();ex();
ri "LEFT@REFLEX";ex();

ri "ONEASSIGN_1";ex();
up(); ri "UNEVAL_TAC@[data:?2]";ex();
right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?v";ex();
ri "LEFT@ $state";ex();
up();up(); rri "ONEASSIGN_1";ex();
up();up();up(); ri "TAB_AND";ex();
right();left(); ri "1|-|7";ex();
up();up(); rri "CASEINTRO";ex();
up();up();up();right();left();right();right();
ri "LEFT@TREMTOP@PAIRASSIGNTYPE"; ex();
ri "LEFT@PAIRASSIGN"; ri "EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();

saveenv "proof4";
getenv "proof4";

left(); left(); left(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();
up();right();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();
rri "FDEF";ex(); 
up();right(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();
up();up(); ri "EVERYWHERE2@ALTORDEF";ex();
up();ex();
up();up(); ri "EQUATION";ex();    
right();left(); ri "(!$REFLEX)@error";ex();
right(); ri "BIND@?u";ex();
ri "(LEFT@0|-|7)**EVAL";ex();
ri "LEFT@REFLEX";ex();
up(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|5";ex();
rri "FDEF";ex();
up();up(); rri "CASEINTRO";ex();
up(); ri "NEGF";ex();
up(); ri "TAB_AND";ex();
left();right();left();

ri "(LEFT@state)**EVAL";ex();
right();left();
ri "LEFT@TREMTOP@PAIRASSIGNTYPE";ex();
ri "(LEFT@PAIRASSIGN)**EVAL**EVERYWHERE2@TYPES";ex();
right();left();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();
up();right();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();
rri "FDEF";ex();
up();right(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();
up();up(); ri "EVERYWHERE2@ALTORDEF";ex();
up();ex();
up();up(); ri "EVAL";ex();
ri "EVERYWHERE2@TYPES";ex();
ri "LEFT@REFLEX";ex();

saveenv "proof5";
getenv "proof5";

ri "ONEASSIGN_1";ex();
up(); ri "UNEVAL_TAC@[data:?2]";ex();
right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?u";ex();
ri "LEFT@ $state";ex();
up();up(); rri "ONEASSIGN_1";ex();
up();right();
ri "(LEFT@state)**EVAL";ex();
right();left();
ri "LEFT@TREMTOP@PAIRASSIGNTYPE";ex();
ri "(LEFT@PAIRASSIGN)**EVAL**EVERYWHERE2@TYPES";ex();
right();left();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();

up();right();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();
rri "FDEF";ex();
up();right(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();
up();up(); ri "EVERYWHERE2@ALTORDEF";ex();
up();ex();
up();up(); ri "EVAL";ex();
ri "EVERYWHERE2@TYPES";ex();
left(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();  
rri "FDEF";ex();
up();ex();
ri "LEFT@REFLEX";ex();
ri "ONEASSIGN_1";ex();
up(); ri "UNEVAL_TAC@[data:?2]";ex();

right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?v";ex();
ri "LEFT@ $state";ex();
up();up(); rri "ONEASSIGN_1";ex();
up();up();up();up();up(); rri "CASEINTRO";ex();
up();right();

saveenv "proof6";
getenv "proof6";

ri "BIND@(command:(?u,?v):,=?x,?y)@state:?1"; ex();
right(); ri "LEFT@TREMTOP@PAIRASSIGNTYPE"; ex();
ri "LEFT@PAIRASSIGN"; ri "EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
left(); left(); left(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();
up();right();left();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|3";ex();  
rri "FDEF";ex();
up();right();
ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|4";ex();
rri "FDEF";ex();
up();up(); ri "EVERYWHERE2@ALTORDEF";ex();
up();ex();
up();up(); ri "EVAL";ex();

saveenv "proof7";
getenv "proof7";

downtoright "(state:?f)@?x";
upto "(state:?f)@?x"; 
ri "(LEFT@state)**(EVERYWHERE2@EVAL)**(EVERYWHERE2@TYPES)"; ex();
ri "EVERYWHERE2@REFLEX";ex();
right();left(); ri "ASRTEQ** $DUBNEG2";ex();
ri "RIGHT@ $0|-|2";ex();
rri "FDEF";ex();
up();ex();
ri "ONEASSIGN_1";ex();
up(); ri "UNEVAL_TAC@[data:?2]";ex();
right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?v";ex();
ri "LEFT@ $state";ex();
up();up(); rri "ONEASSIGN_1";ex(); 

saveenv "proof8";
getenv "proof8";

up();left();
ri "(LEFT@state)**(EVERYWHERE2@EVAL)**(EVERYWHERE2@TYPES)"; ex();
ri "EVERYWHERE2@REFLEX";ex();
right(); ri "ONEASSIGN_1";ex();
up(); ri "UNEVAL_TAC@[data:?2]";ex();
right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?u";ex();
ri "LEFT@ $state";ex();
up();up(); rri "ONEASSIGN_1";ex(); 

top();right();right();right(); ri "NOT_EXP";ex();
right();left();left();right();right(); ri "LEFT@TREMTOP@PAIRASSIGNTYPE"; ex();
ri "LEFT@PAIRASSIGN"; ri "EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
left(); left(); left(); 
ri "RIGHT@ $0|-|2";ex();
ri "REFLEX";ex();
up(); ri "DSYM**DZER";ex();
up();ex();
up();up(); ri "REFLEX";ex();
up();rri "FDEF";ex();
up(); ri "CSYM**CZER";ex();

up();right(); ri "NOT_EXP";ex();
right();left();left();right();right(); ri "LEFT@TREMTOP@PAIRASSIGNTYPE"; ex();
ri "LEFT@PAIRASSIGN"; ri "EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
left();left();right();left(); 
ri "RIGHT@ $0|-|3";ex();
ri "REFLEX";ex();
up(); ri "DSYM**DZER";ex();
up(); ri "DZER";ex();
up();ex();
up();up(); ri "REFLEX";ex();
up();rri "FDEF";ex();
up(); ri "CSYM**CZER";ex();

saveenv "proof9";
getenv "proof9";

up();right(); ri "NOT_EXP";ex();
right();left();left();right();right(); ri "LEFT@TREMTOP@PAIRASSIGNTYPE"; ex();
ri "LEFT@PAIRASSIGN"; ri "EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
left();left();right();right(); 
ri "RIGHT@ $0|-|4";ex();
ri "REFLEX";ex();
up(); ri "DZER";ex();
up(); ri "DZER";ex();
up();ex();
up();up(); ri "REFLEX";ex();
up();rri "FDEF";ex();
up(); ri "CSYM**CZER";ex();
up();right();left();right();right();
ri "ONEASSIGN_1";ex();
ri "EVERYWHERE2@TYPES"; ex();
left();left(); ri "TAB_NOT**1|-|1";ex();
up(); ri "CSYM**CID**DRULE1";ex();
ri "LEFT@REFLEX";ex();
ri "DSYM**DZER";ex();
up();ex();
up();up();up();up();right();right();left();
ri "ASSERT_UNEXP";ex();
up();up(); ri "NOT_EXP";ex();
right();left();

left();right();right();right();right();left(); ri "RIGHT@ $0|-|6";ex();
ri "ONEASSIGN_1";ex();
ri "EVERYWHERE2@TYPES";ex();
left();left(); ri "TAB_NOT**1|-|1";ex();
up(); ri "CSYM**CID**DRULE1";ex();
ri "LEFT@REFLEX";ex();
ri "DSYM**DZER";ex();
up();ex();
up();right();right();left(); ri "RIGHT@ $0|-|7";ex();
ri "ONEASSIGN_1";ex();
ri "EVERYWHERE2@TYPES";ex();
left();left(); ri "TAB_NOT**1|-|1";ex();
up(); ri "CSYM**CID**DRULE1";ex();
ri "LEFT@REFLEX";ex();
ri "DSYM**DZER";ex();
up();ex();
up();up();

saveenv "proof10";
getenv "proof10";

up();up();up();up();up();up();right();right();left();
ri "ONEASSIGN_1";ex();
ri "EVERYWHERE2@TYPES";ex();
left();left(); ri "TAB_NOT**1|-|1";ex();
up(); ri "CSYM**CID**DRULE1";ex();
ri "LEFT@REFLEX";ex();
ri "DSYM**DZER";ex();
up();ex();
up();right();
ri "ONEASSIGN_1";ex();
ri "EVERYWHERE2@TYPES";ex();
left();left(); ri "TAB_NOT**1|-|1";ex();
up(); ri "CSYM**CID**DRULE1";ex();
ri "LEFT@REFLEX";ex();
ri "DSYM**DZER";ex();
up();ex();

up();up();up();up();right();right();right();left();
ri "ONEASSIGN_1";ex();
ri "EVERYWHERE2@TYPES";ex();
left();left(); ri "TAB_NOT**1|-|1";ex();
up(); ri "CSYM**CID**DRULE1";ex();
ri "LEFT@REFLEX";ex();
ri "DSYM**DZER";ex();
up();ex();
up();right();
ri "ONEASSIGN_1";ex();
ri "EVERYWHERE2@TYPES";ex();
left();left(); ri "TAB_NOT**1|-|1";ex();
up(); ri "CSYM**CID**DRULE1";ex();
ri "LEFT@REFLEX";ex();
ri "DSYM**DZER";ex();
up();ex();

saveenv "proof11";
getenv "proof11";

up();up();up();up();up();
ri "PCASEINTRO@[address:?u]=[address:?2]";ex();
right();left();right();left();left();right();right();right();left();
right(); ri "BIND@?2";ex();
ri "LEFT@ $0|-|5";ex();
ri "EVAL";ex();
up(); ri "REFLEX";ex();
up();ex();
up();up(); ri "FUNCTION_EQ";ex();
ri "LEFT@0|-|6";ex();
ri "REFLEX";ex();
up(); rri "FDEF";ex();
up(); ri "CSYM**CZER";ex();
up();up();up();up();

ri "PCASEINTRO@error=(rexp:?x)@state:?1";ex();
right();left();

p "TEMP";

getrightside "TEMP";

(* careful here *)
right();right();right();right();right();
right();right();right();right();right();
right();right();left();
ri "EQUATION**1|-|5";ex();
up();right(); ri "LEFT@EQUATION**1|-|5";ex();
up();up(); rri "CASEINTRO";ex();
up();left();
right();left();left(); ri "LEFT@0|-|5";ex();
ri "REFLEX";ex();
up();ex();
up();right();left(); ri "LEFT@0|-|5";ex();

ri "REFLEX";ex();
up();ex();
left();right();right();right();left();

saveenv "PROOF1";
getenv "PROOF1";

top();right();right();right();right();right();right();right();right();right();right();left();
ri "PCASEINTRO@?B@((rexp:?x)@state:?1),(rexp:?y)@state:?1";ex();
right();left();
right();right(); ri "RIGHT@ $0|-|6";ex();
ri "CID";ex();
ri "NRULE1";ex();
up();up();right();
right();right(); ri "TAB_AND";ex();
ri "EVERYWHERE2@1|-|6";ex();
ri "EVERYWHERE2@ $CASEINTRO";ex();
up();up(); rri "CASEINTRO";ex();
up();left();
right();right();right();
up();up();up();

quit();

(* now I got the form *)

Global term display:

   [((state : ?1) = [error]) || false , ((address : ?u) 
            = address : ?v) || false , ([error] = (?u 
                  := ?x) @ state : ?1) || false , ([error] 
                  = (?v := ?y) @ state : ?1) || false 
                  , (error = (rexp : ?x) @ state : ?1) 
                  || ((?B @ ((rexp : ?x) @ state : ?1) 
                           , (rexp : ?y) @ state : ?1) 
                        || ({[address : ?u] = [address 
                                    : ?2]} || false 
                              , ~ [error] = [((address 
                                       : ?u) = address 
                                       : ?2) || ((rexp 
                                          : ?x) @ state 
                                          : ?1) , ((address 
                                             : ?v) 
                                          = address 
                                             : ?2) 
                                       || ((rexp : ?y) 
                                             @ state 
                                                : ?1) 
                                          , (state 
                                                : ?1) 
                                             @ address 
                                                : ?2]) 
                           , false) , |- ?B @ ((rexp 
                              : ?x) @ state : ?1) 
                        , (rexp : ?y) @ state : ?1]

Local term display:

   [address : ?u] = [address : ?2]
val it = () : unit
- 

(* then I type srt(); I got *)
val it = () : unit
- srt();

   ASRTEQ:  
   ?e = ?f   =
   |- ?e = ?f
   -----------------------------------------------
   ASSERT , EQBOOL , 0


   EQBOOL:  
   ?x = ?y   =
   bool : ?x = ?y
   -----------------------------------------------
   EQBOOL , 0


   EQSYMM:  
   ?x = ?y   =
   ?y = ?x
   -----------------------------------------------
   CASEINTRO , EQUATION , REFLEX , 0


   EQUATION:  
   ?a = ?b   =
   (?a = ?b) || true , false
   -----------------------------------------------
   EQUATION , 0


   FUNCTION_EQ:  
   [?p] = [?q]   =
   ?p = ?q
   -----------------------------------------------
   BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST , NONTRIV 
   , ODDCHOICE , REFLEX , TYPES , 0

val it = () : unit
- 

(* but when I use ri "FUNCTION_EQ";ex() *)

val it = () : unit
- ri "FUNCTION_EQ";ex();

Global term display:

   [((state : ?1) = [error]) || false , ((address : ?u) 
            = address : ?v) || false , ([error] = (?u 
                  := ?x) @ state : ?1) || false , ([error] 
                  = (?v := ?y) @ state : ?1) || false 
                  , (error = (rexp : ?x) @ state : ?1) 
                  || ((?B @ ((rexp : ?x) @ state : ?1) 
                           , (rexp : ?y) @ state : ?1) 
                        || ({FUNCTION_EQ => [address 
                                    : ?u] = [address 
                                    : ?2]} || false 
                              , ~ [error] = [((address 
                                       : ?u) = address 
                                       : ?2) || ((rexp 
                                          : ?x) @ state 
                                          : ?1) , ((address 
                                             : ?v) 
                                          = address 
                                             : ?2) 
                                       || ((rexp : ?y) 
                                             @ state 
                                                : ?1) 
                                          , (state 
                                                : ?1) 
                                             @ address 
                                                : ?2]) 
                           , false) , |- ?B @ ((rexp 
                              : ?x) @ state : ?1) 
                        , (rexp : ?y) @ state : ?1]

Local term display:

   FUNCTION_EQ => [address : ?u] = [address : ?2]
val it = () : unit

Global term display:

   [((state : ?1) = [error]) || false , ((address : ?u) 
            = address : ?v) || false , ([error] = (?u 
                  := ?x) @ state : ?1) || false , ([error] 
                  = (?v := ?y) @ state : ?1) || false 
                  , (error = (rexp : ?x) @ state : ?1) 
                  || ((?B @ ((rexp : ?x) @ state : ?1) 
                           , (rexp : ?y) @ state : ?1) 
                        || ({[address : ?u] = [address 
                                    : ?2]} || false 
                              , ~ [error] = [((address 
                                       : ?u) = address 
                                       : ?2) || ((rexp 
                                          : ?x) @ state 
                                          : ?1) , ((address 
                                             : ?v) 
                                          = address 
                                             : ?2) 
                                       || ((rexp : ?y) 
                                             @ state 
                                                : ?1) 
                                          , (state 
                                                : ?1) 
                                             @ address 
                                                : ?2]) 
                           , false) , |- ?B @ ((rexp 
                              : ?x) @ state : ?1) 
                        , (rexp : ?y) @ state : ?1]

Local term display:

   [address : ?u] = [address : ?2]
val it = () : unit
- 

(* It didn't do anything! I expected the form (address:?u) = address:?2 *)

quit();





right();left(); ri "EVERYWHERE2@ $0|-|5";ex();
right();right(); ri "AT";ex();
up();left(); ri "CID**NRULE1";ex();
right(); ri "EQUATION";ex();
right();left(); ri "(!$REFLEX)@error";ex();
right(); ri "BIND@?u";ex();
ri "LEFT@0|-|7";ex();
ri "EVAL";ex();
ri "LEFT@REFLEX";ex();
up(); ri "PCASEINTRO@~error=(rexp:?x)@state:?1";ex();
right();left();left();right(); ri "LEFT@0|-|5";ex();
ri "REFLEX";ex();
up(); rri "FDEF";ex();
up();ex();
saveenv "proof10";
getenv "proof10";
left();right(); ri "EQUATION";ex();
right();left(); ri "(!$REFLEX)@error";ex();
right(); ri "BIND@?u";ex();
ri "LEFT@0|-|6";ex();
ri "EVAL";ex();
ri "LEFT@REFLEX";ex();
up();up(); ri "UNEVAL_TAC@[data:?2]";ex();
right();left(); rri "REXPTYPE";ex();
ri "RIGHT@ $TYPES";ex();
up();right();right();
ri "(LEFT@state)**EVAL";ex();
up(); ri "TYPES";ex();
ri "BIND@address:address:?v";ex();
ri "LEFT@ $state";ex();
up();up(); rri "ONEASSIGN_1";ex(); 

quit();