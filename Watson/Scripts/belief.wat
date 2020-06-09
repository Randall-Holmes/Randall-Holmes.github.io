(* a file implementing a logic of belief -- connected to Shankar's 
work *)

(* notation brought into line with his -- I hope! *)

script "typestuff";
script "prop_logic";

declareinfix "`BELIEVES";

declareconstant "Principal";

(* typing axiom for belief statements *)

axiom "BELIEVE_TYPE" "?x `BELIEVES ?y" "prop:(Principal:?x)`BELIEVES prop:?y";

(* logical closure of beliefs *)

axiom "BELIEVE_AXIOM" "(?x `BELIEVES ?p)&?x `BELIEVES ?q" "?x `BELIEVES ?p&?q";

(* introspection *)

axiom "AXIOM_02" "(?x `BELIEVES ?p) -> (?x `BELIEVES ?x `BELIEVES ?p)" "true";

(* this theorem verifies that the "conjunction" axiom above is
enough for logical closure *)

(*

AXIOM_01:  

((?x `BELIEVES ?p) & ?x `BELIEVES ?p -> ?q) -> ?x 
   `BELIEVES ?q  =  

true

BASSOC , BDIS , BELIEVE_AXIOM , BID , BID2 , BSYM , BTYPE 
, CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , IDEF , NTYPE , PROP , TYPES , 0

*)

s "((?x `BELIEVES ?p)& ?x `BELIEVES ?p->?q) -> ?x `BELIEVES ?q";
left(); ri "BELIEVE_AXIOM"; ex();
right(); ri "3pt66"; ex();
up(); rri "BELIEVE_AXIOM"; ex();
top(); ri "(LEFT@CSYM)**3pt76b"; ex();
p "AXIOM_01";  (* so this axiom can be proved as a theorem *)

(* but it is an open question in my mind whether the logical closure
axiom AXIOM_01 implies the conjunction-unpacking axiom that I take as
primitive here.  I think that we ought to believe the conjunction
unpacking axiom; a notion of belief that does not satisfy
BELIEVE_AXIOM is very weak indeed! *)

(*

BELIEVE_TRUE:  

(?x `BELIEVES ?p) -> ?x `BELIEVES true  =  

true

BASSOC , BDIS , BELIEVE_TYPE , BELIEVE_AXIOM , BID , BID2 , BSYM 
, BTYPE , CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE 
, DXM , FDEF , GR , IDEF , NTYPE , PROP , TYPES , 0

*)

s "(?x `BELIEVES ?p) -> ?x `BELIEVES true";
left(); ri "BELIEVE_TYPE"; ex();
right(); right(); rri "PROP"; rri "CID"; ex();
uptors "BELIEVE_AXIOM"; rri "BELIEVE_AXIOM"; ex();
right(); ri "BELIEVE_TYPE**(EVERYWHERE@TYPES)** $BELIEVE_TYPE"; ex();
upto "prop:?x"; rri "PROP"; ri "CRULE1"; ex();
up(); ri "(LEFT@CSYM)**3pt76b"; ex();
p "BELIEVE_TRUE";

(*

BELIEVE_FALSE_0:  

?x `BELIEVES false  =  

(?x `BELIEVES ?p) & ?x `BELIEVES false

BASSOC , BDIS , BELIEVE_AXIOM , BID , BID2 , BSYM 
, BTYPE , CTYPE , DDIS , DIDEM , DSYM , DTYPE , DXM 
, FDEF , GR , NTYPE , PROP , TYPES , 0

*)

s "?x `BELIEVES false";
right(); ri "(!$CZER)@?p"; ex();
up(); rri "BELIEVE_AXIOM"; ex();
p "BELIEVE_FALSE_0";

(*

BELIEVE_FALSE_1:  

(?x `BELIEVES false) -> ?x `BELIEVES ?p  =  

true

BASSOC , BDIS , BELIEVE_AXIOM , BID , BID2 , BSYM 
, BTYPE , CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE 
, DXM , FDEF , GR , IDEF , NTYPE , PROP , TYPES , 0

*)

s "(?x `BELIEVES false)->?x `BELIEVES ?p";
ri "LEFT@(!@BELIEVE_FALSE_0)@?p"; ri "3pt76b"; ex();
p "BELIEVE_FALSE_1";

(*

BELIEVE_FALSE:  

(~ ?x `BELIEVES ?p) -> ~ ?x `BELIEVES false  =  

true

BASSOC , BDIS , BELIEVE_AXIOM , BID , BID2 , BSYM 
, BTYPE , CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE 
, DXM , FDEF , GR , IDEF , NTYPE , PROP , TYPES , 0

*)

wb(); ri "CONTP"; ex(); wb();
p "BELIEVE_FALSE";

(* it might be reasonable (I think it would be reasonable) to adopt as an
axiom the assertion that every Principal believes True *)

(* but Shankar's additional axiom which I give below is too strong *)

axiom "BELIEVE_AXIOM1" "?P `BELIEVES (?x -> ?y)" "((?P `BELIEVES ?x) -> (?P `BELIEVES ?y))";

(* I prove a theorem from this which we should not believe *)

(*

UNCONVINCED:  

(~ ?x `BELIEVES ?p) -> ?x `BELIEVES ~ ?p  =  

true

BASSOC , BDIS , BELIEVE_AXIOM1 , BID , BID2 , BSYM 
, BTYPE , CTYPE , DASSOC , DDIS , DIDEM , DSYM , DTYPE 
, DXM , FDEF , GR , IDEF , NTYPE , PROP , TYPES , 0

*)

s "(~?x `BELIEVES ?p) -> ?x `BELIEVES ~?p";
right(); right(); rri "3pt74"; ex();
up(); ri "BELIEVE_AXIOM1"; ex();
top(); ri "3pt65"; ex();
left(); ri "CSYM"; ri "CCON"; ex();
up(); ri "3pt75"; ex();
p "UNCONVINCED";

(* we should _not_ find this convincing; it is quite possible that 
a principal may not believe ?p without believing ~?p -- thus we should
not adopt the axiom "BELIEVE_AXIOM1" *)

(* Jim Alves-Foss necessitation proposal *)

axiom "JIMS_NEC" "(?x=true)->?B `BELIEVES ?x" "true";

(* my necessitation proposal proved from his *)

(*

RANDALLS_NEC:  

?B `BELIEVES true  =  

true

BDIS , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , DDIS 
, DIDEM , DSYM , DXM , FDEF , IDEF , JIMS_NEC , NTYPE 
, PROP , REFLEX , TYPES , 0


*)

s "?B `BELIEVES true";
ri "BELIEVE_TYPE"; ex();
rri "TYPES"; ex();
rri "PROP"; ex();
ri "RIGHT@ $BELIEVE_TYPE"; ex();
rri "ILID"; ex();
ri "LEFT@(!$REFLEX)@true"; ex();
ri "JIMS_NEC"; ex();
p "RANDALLS_NEC";

(* here I prove Jim's version from mine -- but notice that Watson's
built-in knowledge about equality plays an essential role.  An equation
must be equal to either "true" or "false"; if there were a notion of
equality in the belief logic itself, it would have to be distinguished
from Watson's notion of equality *)

(*

JIMS_NEC_AGAIN:  

(?x = true) -> ?B `BELIEVES ?x  =  

true

BDIS , BELIEVE_TYPE , BID , BID2 , BSYM , BTYPE , CASEINTRO 
, DDIS , DIDEM , DSYM , DXM , EQUATION , FDEF , HYP 
, IDEF , JIMS_NEC , NTYPE , PROP , REFLEX , TYPES 
, 0

*)

getleftside "JIMS_NEC";
left(); ri "EQUATION"; ex();
top(); ri "PCASEINTRO@?x=true"; ex();
ri "PIVOT"; ex();
dlls "RANDALLS_NEC"; ri "RANDALLS_NEC"; ex();
up(); ri "IREF"; ex();
up(); right(); left(); ri "1|-|1"; ex();
up(); ri "3pt75"; ex();
top(); rri "CASEINTRO"; ex();
p "JIMS_NEC_AGAIN";

quit();








