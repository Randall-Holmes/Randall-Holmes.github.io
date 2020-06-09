(* another refinement *)

(* April 15, 1999:  error in LOOP axiom corrected.  if and loop
shown to be commands and wp theorem for if proved *)


(* April 12, 1999:  alternative version programs2.wat in which 
right expressions are required to send [error] to error *)

(* April 9, 1999:  wp theorem for composition added.  Documentation
added in a comment after the version stuff *)

(* April 8, 1999:  corrected definition of Htriple *)

(* April 7, 1999:  new theorems about wp; new version := of single
assignment command *)

(* April 6, 1999 -- corrected error in "decreasing" function used
in the loop invariance axiom *)

(* version of March 24, 1999; takes an extensional approach almost
everywhere.  totally different treatment of loops and conditionals.
extensive use of type definitions (so a version of Watson dated
March 14, 1999 or later is needed). *)

script "simplesets";  (* lots of logic *)
script "algebra2";  (* lots of arithmetic and algebra *)

(* this file begins to implement a theory of programming 
similar to that in Cohen's 
Programming in the 90's *)

(* this should be considerably improved; it has a type of expressions
with the correct relationship to assignment (the original version of
assignment only allowed assignments of data constants to variables). *)

(* an important point is that function application in the Mark2 logic
is not extensional; forall@[(?f@?1)=?g@?1] does not necessarily imply
?f = ?g.  This means that the representation of programs and
expressions as "functions" does not wipe out structural information
about programs and expressions if it is done right.  Extensionality
does hold for functions built with brackets ([?P@?1]), so if we want
functions to be nonextensional, we do not define them using bracket
abstraction *)

(* this file begins to implement a theory of programming *)

(* DOCUMENTATION as of April 9, 1999:

The intention of this file is to implement reasoning about programs
in the style presented in Cohen's Programming in the 90's (and other
places).

There are essential differences between Cohen's approach and ours.  Cohen
attempts to avoid the dependency of expressions and predicates on states
in a way which complete formalization renders unavoidable.  There are
errors in Cohen's book caused by this; see the theorem WP_MONOTONE
and compare with Cohen.

We describe our model of programming via its data types.

there are base types of addresses and data.

The type address has a little structure which we won't go into, as
we have not done anything with arrays yet.

The type data includes natural numbers and booleans (these are just
samples of useful kinds of data); it also includes a special item error
which does not belong to any of the useful kinds of data.

The type state consists of states of our machine; these are functions from
addresses to data.  An address mapped to error is considered not to be
in use.  The special state [error] in which no address is allocated is
regarded as the state in which the machine has crashed.

The type command consists of programs on our machine.  These are functions
from type state to type state which fix the value [error].

The type rexp consists of expressions.  These are functions from states to
data.  It might be advisable to stipulate that rexp's send [error] to
error, but we have not done this.  When a rexp sends a particular state
to error, it is regarded as undefined in that state.

The type rexp_state is used in the multiple assignment command, which
probably will not be used in its current form.  It consists of functions
from addresses to rexp's.

The type statepred consists of predicates of states (functions from states
to booleans) which are false of [error].

In the definitions of wp and Htriple (weakest preconditions and Hoare 
triples) it has been necessary to take explicit account of the special
role of the state [error].  wp.S.R (using Cohen's notation) is true
if the state after execution of S will not be [error] (the machine will
not crash) and the predicate R will be true of that state.  {P} S {Q}
(again using Cohen's notation) will be true if in any situation where
the predicate P holds of the current state and the current state is not
[error], execution of the command S will lead to a situation where the
predicate Q holds of the state and the state is not [error] (if the machine
has not crashed and P is true, execution of the program S will not cause the
machine to crash and will cause Q to become true).

*)

declareconstant "data";  (* the type of storable data *)

axiom "NATDATA" "data:Nat:?x" "Nat:?x";  (* natural numbers can be data *)

axiom "BOOLDATA" "data:bool:?x" "bool:?x";  (* truth values can be data *)

declareconstant "error";  (* a data value signalling error *)

axiom "ERRORDATA" "error" "data:error";

axiom "ERRORNOTNAT" "error=Nat:error" "false";

axiom "ERRORNOTBOOL"  "error=bool:error" "false";

declareconstant "address";  (* the type of addresses *)

(* begin environment for development of pair and list data types

(* development of Minglong's pair_data type; I don't know if this type
is really useful, but it is a nice example of the type definition function *)

s "(data:P1@?x),data:P2@?x";
assign "?x" "(data:P1@?x),data:P2@?x";
ri "EVERYWHERE2@P1**P2**TYPES"; ex();
p "PAIRDATARETRACT";

defineconstanttype "PAIRDATARETRACT" "pair_data:?x" "(data:P1@?x),data:P2@?x";

s "pair_data:?x,?y";
ri "pair_data"; ex();
ri "EVERYWHERE2@P1**P2";
p "PAIR_DATA";

(* basic declarations for lists *)

declareconstant "nil";

declareconstant "list";

axiom "LIST0" "nil" "(list@?type):nil";

axiom "LIST" "(?type:?x),(list@?type):?y" "(list@?type):?x,?y";

(* it's an interesting project actually to define
list types? *)

(* datatype is a type of types permissible as data *)

declareconstant "datatype";

axiom "DATATYPE" "(datatype:?type):?x" "data:(datatype:?type):?x";

axiom "NATDATATYPE" "Nat" "datatype:Nat";

axiom "BOOLDATATYPE" "bool" "datatype:bool";

axiom "ERRORNOTDATATYPE" "error = (datatype:?type):error" "false";

(* this allows proof of ERRORNOTNAT and the like, and also
allows proof that data itself is not a data type! *)

(* the preceding axioms allow proofs of NATDATA, BOOLDATA *)

axiom "LISTDATATYPE" "list@datatype:?type" "datatype:list@datatype:?type";

(* think about developing reference types; then arrays can be
lists of references? *)

end environment for development of pair and list data types *)

declareinfix "+++";  (* the operation of shifting addresses up *)

(* this will be used in defining arrays *)

axiom "SHIFTUPTYPE" "?address +++ ?nat" "address:(address:?address)+++(Nat:?nat)";

axiom "SHIFTUPASSOC" "(?address +++ ?nat1) +++ ?nat2" "?address +++ ?nat1 + ?nat2";

axiom "SHIFTSHIFTS" "(address:?address) = address+++?n" "?n=0";

(* it may also be advisable to have "shift down"; more axioms may be needed *)

(* declareconstant "state";  (* states are functions from addresses to data *)

axiom "STATETYPE" "state:?s" "[data:?s@address:?1]"; *)

(* introduce the state type via type definition commands *)

s "[data:?s@address:?1]";
assign "?s" "[data:?s@address:?1]";
rri "ARROWRETRACT"; ex();
wb();
prove "STATERETRACT";

defineconstanttype "STATERETRACT" "state:?s" "[data:?s@address:?1]";

(* reverse engineer the old theorem *)

ae "state";
p "STATETYPE";

(* prove that the error state is a state *)

s "state:[error]";
ri "state"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "VALUE@[$ERRORDATA]"; ex();
wb();
p "BADSTATE";

(* note that equality between states is extensional *)

(* declareconstant "command";*) (* commands are functions from states to states *)

(* this type could also be called "program" *)

(* but equality between commands is not necessarily extensional,
which allows commands to be treated as "text" objects where appropriate
(as in the definition of "allguards" below *)

(* I'd like to avert this; see what I can do later to get this
to be extensional *)

(* axiom "COMMANDTYPE" "(command:?c)@?s" "state:?c@state:?s"; *)

s "[((state:?1)=[error])||[error],state:?c@state:?1]";
assign "?c" "[((state:?1)=[error])||[error],state:?c@state:?1]";
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
right(); ri "ALT_PUSH"; ex();
ri "EVERYWHERE2@TYPES"; ex();
wb();
p "COMMANDRETRACT";

defineconstanttype "COMMANDRETRACT" "command:?c" 
	"[((state:?1)=[error])||[error],state:?c@state:?1]";

(* we need to reconstruct the old theorems *)

(* this is not quite the same! *)

s "(command:?c)@?s";
ri "LEFT@command"; ri "EVAL"; ex();
p "COMMANDEVAL";

s "state:(command:?c)@state:?s";
ri "RIGHT@COMMANDEVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
ri "UNEVAL_TAC@[state:?1]"; ex();
ri "LEFT_CASE@ $BADSTATE"; ex();
ri "RIGHT_CASE@TYPES"; ex();
rri "COMMANDEVAL"; ex();
wb();
p "COMMANDTYPE";


(* we'll have to see what is needed as the new COMMANDTYPE *)

(* we introduce basic commands *)

(* the "skip" command does nothing *)

(* declareconstant "skip"; *)

defineconstant "skip" "[state:?1]";

(* axiom "SKIPTYPE" "skip" "command:skip"; *)

s "command:skip";
ri "command"; ex();
right(); ri "REVPIVOT"; ex();
drls "skip"; ri "skip"; up(); ri "EVAL"; ex();
up(); ri "EVERYWHERE@TYPES"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptors "skip"; rri "skip"; ex();
wb();
p "SKIPTYPE";

(* axiom "SKIP" "skip@?s" "state:?s"; *)

s "skip@?s";
ri "(LEFT@skip)**EVAL"; ex();
p "SKIP";

(* the "abort" command throws us into total error *)

(* declareconstant "abort";

axiom "ABORTTYPE" "abort" "command:abort";

axiom "ABORT" "abort@?s" "[error]";  (* [error] is a completely useless state *)

*)

defineconstant "abort" "[[error]]";

s "command:abort";
ri "command"; ex();
dlls "abort"; ri "abort"; up(); ri "EVAL"; ex();
uptors "BADSTATE"; rri "BADSTATE"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptors "abort"; rri "abort"; ex();
wb();
p "ABORTTYPE";

s "abort@?s";
ri "(LEFT@abort)**EVAL"; ex();
p "ABORT";

(* axiom "ERRORINVARIANCE" "(command:?c)@[error]" "[error]"; *)

s "(command:?c)@[error]";
ri "(LEFT@command)**EVAL"; ex();
ri "LEFT@LEFT@ $BADSTATE"; ex();
ri "LEFT@REFLEX"; ex();
p "ERRORINVARIANCE";

(* this theorem expresses the uselessness of the state [error] *)

(* composition of programs *)

(* BEGIN declarations and axioms of the old version redone below

declareinfix ";";

axiom "PCOMPTYPE" "?c1;?c2" "command:(command:?c1);(command:?c2)";

axiom "PCOMP" "(?c1;?c2)@?s" "(command:?c2)@(command:?c1)@?s"; 

END declarations and axioms of the old version redone below *)

defineinfix "PCOMPDEF" "?c1;?c2" "[(command:?c2)@(command:?c1)@?1]";

s "command:(command:?c1);(command:?c2)";
right(); ri "PCOMPDEF"; ri "EVERYWHERE2@TYPES"; rri "PCOMPDEF"; ex();
top(); ri "command"; ex();
dlls "PCOMPDEF"; ri "PCOMPDEF"; up(); ri "EVAL"; ex();
right(); ri "TREMRIGHT@COMMANDTYPE"; ex();
upto "state:?x"; ri "TREMTOP@COMMANDTYPE"; ex();
up(); left(); ri "(!$ERRORINVARIANCE)@?c2"; ex();
right(); ri "(!$ERRORINVARIANCE)@?c1"; ex();
right(); rri "0|-|1"; ex();
up(); ri "TREMRIGHT@COMMANDTYPE"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); rri "PCOMPDEF"; ex();
wb();
p "PCOMPTYPE";

s "(?c1;?c2)@?s";
ri "(LEFT@PCOMPDEF)**EVAL"; ex();
p "PCOMP";

(* multiple assignment *)

(* implemented very abstractly; values at addresses satisfying a predicate
are copied from a given state; the state [error] cannot be modified *)

(* we develop a "left expression" type of predicates which can be
domains of multiple assignments *)

(* it might be simpler to allow any set to be the domain of a 
multiple assignment? *)

(* declareconstant "lexp"; *)

(* type lexp is defined as sets of addresses *)

(* the same approach using arrow types could have been used
with earlier types in this file *)

defineconstant "lexp" "address->>bool";

s "lexp:?x";
ri "(LEFT@lexp)**ARROWTYPE"; ex();
p "LEXP";

defineinfix "DISJ_SUM" "?R,,?S" "[(~forsome@[bool:(?R@?2)&(?S@?2)])&(?R@?1)|?S@?1]";

(*

DISJ_SUM_1:

?R ,, [?1 = ?u] = 

[( ~?R @ ?u) & (?R @ ?1) | ?1 = ?u]

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","DISJ_SUM0","EQBOOL","EQUATION","FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR","forall","forsome"]

*)

s "?R,,[?1=?u]";
ri "DISJ_SUM"; ex();
left();left();
dlls "CSYM";
ri "CSYM"; ex();
ri "LZ"; ex();
up();
rri "ANDBOOL"; ex();
up();up();
ri "FORSOMEDIST2"; ex();
left();
ri "DINSTANTIATEF1@?u"; ex();
ri "LEFT@EVAL**REFLEX"; ex();
ri "DSYM**DZER"; ex();
up();
ri "CSYM**CID"; ex();
up();
ri "NRULE2"; ex();
p "DISJ_SUM_1";

(*  BEGIN old axioms replaced immediately below 

axiom "LEXP1" "[?1=address:?u]" "lexp:[?1=address:?u]";

axiom "LEXP2" "(lexp:?R),,(lexp:?S)" "lexp:(lexp:?R),,(lexp:?S)"; 

END old axioms replaced immediately below *)

s "lexp:[(address:?1)=address:?u]";
ri "LEXP"; ex();
ri "EVERYWHERE2@EVAL"; ex();
right(); rri "EQBOOL"; ex();
ri "LEFT@TYPES"; ex();
wb();
p "LEXP1";  (* this is slightly different from the old LEXP1 *)

s "lexp:(lexp:?R),,(lexp:?S)";
ri "LEXP"; ex();
dlls "DISJ_SUM"; ri "DISJ_SUM"; ex();
upto "[?P@?1]@?x"; ri "EVAL"; ex();
up(); rri "ANDBOOL"; ex();
right(); ri "RL@(LEFT@LEXP)**EVAL"; ri "EVERYWHERE@TYPES"; ex();
ri "RL@(BIND@?1)**LEFT@ $LEXP"; ex();
up();up(); rri "DISJ_SUM"; ex();
wb();
p "LEXP2";



(* develop types "rexp" (right expression) and "rexp_state"
for assignment *)

(* axiom "REXP_STATETYPE" "rexp_state:?x" "[rexp:?x@address:?1]"; *)

(* type of right expressions introduced by type definition commands;
functions from states to data *)

s "[((state:?1)=[error])||error,data:?x@state:?1]";
assign "?x" "[((state:?1)=[error])||error,data:?x@state:?1]";
ri "EVERYWHERE2@EVAL"; ri "EVERYWHERE2@TYPES"; ex();
ri "EVERYWHERE2@ALT_PUSH"; ex();
ri "EVERYWHERE2@TYPES"; ex();
wb();
p "REXPRETRACT";

defineconstanttype "REXPRETRACT" "rexp:?x" 
"[((state:?1)=[error])||error,data:?x@state:?1]";

(* reverse engineer the old theorem *)

ae "rexp";
p "REXP00";

start "(rexp:?x)@?s";
left(); ri "REXP00"; ex();
up(); ri "EVAL"; ex();
p "REXP0";

start "(rexp:?x)@state:?s";
ri "REXP0"; ex();
ri "EVERYWHERE2@TYPES"; ex();
p "REXP0a";

s "(rexp:?x)@?s";
ri "REXP0"; ex();
ri "(LEFT_CASE@ERRORDATA)**(EVERYWHERE2@ $TYPES)**ANTI_UNEVAL_TAC@[data:?1]"; ex();
right(); ri "(LEFT_CASE@ $ERRORDATA)** $REXP0"; ex();
p "REXPTYPE";

(* axiom "REXP_STATETYPE" "rexp_state:?x" "[rexp:?x@address:?1]"; *)

s "[rexp:?x@address:?1]";
assign "?x" "[rexp:?x@address:?1]";
rri "ARROWRETRACT"; ex();
wb();
p "REXP_STATE_RETRACT";

defineconstanttype "REXP_STATE_RETRACT" "rexp_state:?x" "[rexp:?x@address:?1]";

(* reverse engineer the old theorem *)

ae "rexp_state";
p "REXP_STATETYPE";

defineconstant "con@?x" "rexp:[data:?x]";

(* axiom "REXP1" "con@?x" "rexp:con@?x";  (* data constants *) *)

s "rexp:con@?x";
ri "(RIGHT@con)**TYPES** $con"; ex();
wb();

p "REXP1";

defineconstant "var@?u" "[(state:?1)@(address:?u)]";

(* axiom "REXP2" "var@?u" "rexp:var@?u"; *)

s "rexp:var@?u";
ri "rexp"; ex();
right(); right(); left(); ri "ERRORDATA"; ex();
right(); ri "BIND@address:?u"; ri "LEFT@ $0|-|1"; ex();
ri "TYPEBIND@state:?1"; ri "LEFT@ $var"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
ri "EVERYWHERE2@var**EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
ri "TYPEBIND@address:?u"; ex();
ri "LEFT@ $STATETYPE"; ex();
ri "LEFT@TYPES"; ex();
top(); rri "var"; ex();
wb();
p "REXP2";

defineinfix "EXPPLUS" "(?x!+!?y)" "rexp:[(Nat:(rexp:?x)@?1)+Nat:(rexp:?y)@?1]";

(* axiom "REXP3" "?x!+!?y" "rexp:?x!+!?y"; *)

	(* sums of expressions *)
	
s "rexp:?x!+!?y";
ri "(RIGHT@EXPPLUS)**TYPES** $EXPPLUS";ex();
wb();
p "REXP3";


defineinfix "ARRAYSUB" "(?v..?i)" "[(state:?1)@(address:?v)+++(rexp:?i)@(state:?1)]";

(* BEGIN REXP4 commented out for now

	(* array subscripting -- C style *)

(* axiom "REXP4" "?v..?i" "rexp:(address:?v)..(rexp:?i)"; *)

s "rexp:(address:?v)..(rexp:?i)";
ri "REXP00"; ex();
dlls "ARRAYSUB"; ri "ARRAYSUB"; ex();
ri "EVERYWHERE2@TYPES"; ex();
up(); ri "EVAL"; ri "EVERYWHERE@TYPES"; ex();
ri "(LEFT@STATETYPE)**EVAL"; ex();
up(); ri "TYPES"; ex();
ri "BIND@(address : ?v) +++ (rexp : ?i) @ state : ?1";ex();
ri "LEFT@ $STATETYPE"; ex();
top(); rri "ARRAYSUB"; ex();
wb();
p "REXP4";

END REXP4 commented out for now *)

(* I can change names to := and ::= now because Watson doesn't reserve
initial colons *)

(*  BEGIN old axioms to be replaced below  

declareinfix "=::";  (* := cannot be used because initial colon is meaningful
			to Mark2 *)

axiom "MASSIGNTYPE" "?a =:: ?s" "command:(lexp:?a)=::rexp_state:?s"; 

axiom "MASSIGN" "(?a=::?s)@?t" 
"[((~(state:?t)=[error])&(lexp:?a)@address:?1)||(((rexp_state:?s)@(address:?1))@?t),(state:?t)@?1]"; 

END old axioms to be replaced below *)

(* stuff about old versions of assignment commented out 

defineinfix "MASSIGNDEF" "?a=::?s" 
"[((state:?1)=[error])||[error],[((lexp:?a)@address:?2)||(((rexp_state:?s)@address:?2)@(state:?1)),(state:?1)@address:?2]]";

s "command:(lexp:?a)=::rexp_state:?s";
right(); ri "MASSIGNDEF"; ex();
up(); ri "command"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
right(); right(); right(); ri "STATETYPE"; ex();
ri "EVERYWHERE2@1|-|1"; ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
right(); ri "UNEVAL_TAC@[data:?3]"; ex();

saveenv "MASSIGNTYPE";  (* save this proof to resume below *)

(* prove a lemma *)

s "data : ((rexp_state : ?s) @ address : ?a) @ state : ?x";
right(); ri "EVERYWHERE@REXP_STATETYPE**EVAL"; ex();
ri "EVERYWHERE@rexp**EVAL"; ex();
up(); ri "EVERYWHERE@TYPES"; ex();
rri "REXP0a"; ex();
downtoleft "address:?a"; rri "TYPES"; ex();
upto "?x@state:?y";
ri "LEFT@BIND@address:?a"; ex();
ri "EVERYWHERE@ $REXP_STATETYPE"; ex();
p "REXPSTATEDATA";

getenv "MASSIGNTYPE";   (* resume main proof *)

right(); left(); ri "REXPSTATEDATA"; ex();
up(); right(); ri "RIGHT@(LEFT@STATETYPE)**EVAL"; ex();
ri "TYPES"; ex();
ri "BIND@address:?2"; ex();
ri "LEFT@ $STATETYPE"; ex();

top(); rri "MASSIGNDEF"; ex();
wb();
p "MASSIGNTYPE";

(* next we need to prove the old axiom MASSIGN *)

s "[((~(state:?t)=[error])&(lexp:?a)@address:?1)||(((rexp_state:?s)@(address:?1))@?t),(state:?t)@?1]";

drls "STATETYPE"; ri "STATETYPE"; up(); ri "EVAL"; ex();
ri "TYPEBIND@address:?1"; ri "LEFT@ $STATETYPE"; ex();
up(); left(); ri "EVERYWHERE@REXP_STATETYPE**EVAL"; ex();
ri "REXP0"; ex();
downtoright "state:?t"; rri "TYPES"; ex();
uptors "REXP0"; rri "REXP0"; ex();
left(); ri "BIND@address:?1"; ex();
left(); rri "REXP_STATETYPE"; ex();

top(); ri "PCASEINTRO@(state:?t)=[error]"; ex();
right(); left(); right(); ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
ri "1|-|1"; ex();
ri "(LEFT@0|-|1)**EVAL"; ex();
up(); up(); right(); right(); ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
ri "1|-|1"; ex();
top(); ri "BIND@?t"; ri "LEFT@ $MASSIGNDEF"; ex();
wb();
p "MASSIGN";


(* single assignment *)

defineinfix "ONE_ASSIGN" "?v =: ?x" "[(address:?1)=address:?v]=::[rexp:?x]";

end old assigment stuff commented out *)

(* new definition as primitive forbidding assignment of error values *)

(* uses different notation, so no conflict! *)

(* this definition forbids assignment of error values *)

defineinfix "ONEASSIGN" "?v:=?x" "[[((~(state:?1)=[error])&((address:?2)=address:?v)|(error=(rexp:?x)@(state:?1)))||((rexp:?x)@state:?1),(state:?1)@(address:?2)]]";

(*

s "(?v=:?x)@?s";
ri "(LEFT@ONE_ASSIGN)**MASSIGN"; ex();
dlrs "LEXP1";
rri "LEXP1"; ex();
up();
ri "EVAL"; ex();
ri "LEFT@TYPES"; ex();
top();
right();right();left();left();left();
ri "TYPES**REXP_STATETYPE"; ex();
up();
ri "EVAL**EVERYWHERE@TYPES"; ex();
ri "(RIGHT@EVAL)**TYPES"; ex();
assigninto "?U" "?U@?u"; (* apply both sides of equation to ?u *)
ri "EVAL"; ex();
p "ONE_ASSIGN_1";

*)

(* similar theorem for new version *)

s "(?v:=?x)@?s";
ri "LEFT@ONEASSIGN"; ri "EVAL"; ex();
assigninto "?U" "?U@?u";
ri "EVAL"; ex();
p "ONEASSIGN_1";


(* typing theorem for the new single assignment command *)

(*

ONEASSIGNTYPE:  

?v := ?x  =  

command : (address : ?v) := rexp : ?x

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, NONTRIV , NOT1 , ODDCHOICE , ONEASSIGN , OR , REFLEX 
, TYPES , command , rexp , state , 0

*)

s "?v:=?x";
ri "ONEASSIGN"; ex();
right(); ri "PCASEINTRO@(state:?1)=[error]"; ex();
right(); left(); left();left();left();right(); ri "EQUATION**1|-|1"; ex();
up(); rri "FDEF"; ex();
up(); ri "CSYM**CZER"; ex();
up(); ex(); ri "(LEFT@0|-|1)**EVAL"; ex();
up(); up(); right(); right(); right(); left(); 
	ri "TADDTOP@REXPTYPE"; ex();
up(); right();ri "(LEFT@state)**EVAL"; rri "TYPES"; ex();
right(); ri "BIND@address:?2"; ri "LEFT@ $state"; ex();
upto "?x||?y,?z"; ri "BOTH_CASES@UNEVAL@[data:?3]"; 
	rri "FNDIST"; ri "EVAL"; ex();
right(); ri "TYPEBIND@address:?2"; ex();
uptors "state"; rri "state"; ex();
right(); ri "TYPEBIND@state:?1"; ex();
uptors "command";rri "command"; ex();
saveenv "undo";
rri "TYPES"; ex();
right(); applyconvenv "undo";
saveenv "backup"; dropenv "undo";
ri "ONEASSIGN"; ex();
ri "TYPEBIND@rexp:?x"; ri "EVAL"; ex();
ri "BIND@address:?v"; ri "RIGHT@ $TYPES"; ri "EVAL"; ex();
rri "ONEASSIGN"; ex();
p "ONEASSIGNTYPE";

(* commented out

(* typing theorem for the old single assignment command *)

(*


ONE_ASSIGN_TYPE:  

?v =: ?x  =  

command : (address : ?v) =: rexp : ?x

EQBOOL , FNDIST , MASSIGNDEF , ONE_ASSIGN , TYPES 
, command , rexp , rexp_state , state , 0

*)

s "?v=:?x";
ri "ONE_ASSIGN"; ex();
ri "EVERYWHERE2@ $TYPES"; ex();
ri "TADDTOP@MASSIGNTYPE"; ex();
dlls "TYPES"; ri "TYPES"; ex();
top(); right(); rri "ONE_ASSIGN"; ex();
p "ONE_ASSIGN_TYPE";

end commented out *)


(* BEGIN PAIR_ASSIGN skipped -- errors in this definition! 

(* pair assignment *)

defineinfix "PAIR_ASSIGN" "(?u,?v) =,: ?x,?y" "(([?1=address:?u]),,([?1=address:?v]))=::[(?1=address:?u)||(rexp:?x),rexp:?y]";

(* this is much prettier than the previous version of pair assignment *)

(* the definition of ,, ensures that pair assignment will only have an effect
if the two addresses are distinct *)

(* real list assignment requires development *)

(* the next refinement needed here is the development of an expression type
to serve as the right side type of assignment statements instead of "state" *)

END PAIR_ASSIGN skipped -- errors in this definition! *)

(*  BEGIN environment for development of pair and list assignment

(* the new definition of pair assignment in terms of single assignment *)

defineinfix "PAIRASSIGN" "(?x,?y):,=(?a,?b)"

"[[(((address:?x)=address:?y)|([error]=((?x:=?a)@state:?1))|([error]=((?y:=?b)@state:?1)))||error,((address:?x)=address:?2)||(((?x:=?a)@state:?1)@address:?2),((address:?y)=address:?2)||(((?y:=?b)@state:?1)@address:?2),(state:?1)@address:?2]]";


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

(* development of list assignment *)

(* multiple assignment in its set form seems not to be needed *)

(* note that repeated addresses on the left do not cause crashes;
the first one is used; this may turn out to be a problem! *)

declareinfix "::=";

axiom "LASSIGN0" "nil::=?x" "skip";

axiom "LASSIGN" "(?x,?y)::=(?a,?b)"

"[[(([error]=((?x:=?a)@state:?1))|([error]=((?y::=?b)@state:?1)))||error,((address:?x)=address:?2)||(((?x:=?a)@state:?1)@address:?2),((?y::=?b)@(state:?1))@address@?2]]";

END  environment for development of pair and list assignment *)

(* treatment of loops will be completely different *)

(* BEGIN old treatment of loops skipped

(* alternation *)

declareinfix "|:|";  (* links a guarded subcommand to a command *)

(* alternative commands will have a final "otherwise" clause *)

axiom "IFFITYPE" "(?b,?c)|:|?x" 
"command:([bool:?b@state:?1],command:?c)|:|command:?x";

(* the "execution behaviour" axiom given here is deterministic;
a nondeterministic axiom is harder to write, but certainly desirable *)

(* a pseudo-nondeterministic approach using choice operators would
go partway -- a better but more expensive idea is to use priority
functions which determine which guard is considered first *)

axiom "IFFI" "((?b,?c)|:|?x)@?s" "(?b@state:?s)||((command:?c)@?s),((command:?x)@?s)";

(* axioms for a function which extracts the "disjunction of the guards"
from a complex alternative statement.  Notice that the fact that commands
are _not_ treated as extensional functions from states to states means that we
can allow the extraction of structural information from commands = programs *)

declareconstant "allguards";

axiom "ALLGUARDS0" "allguards@abort" "[false]";

axiom "ALLGUARDS" "allguards@(?b,?c)|:|?x" "[(?b@state:?1)|((allguards@?x)@state:?1)]";

(* the use of allguards allows the definition of a guarded do loop
as an operation on the alternative statement expressing one step *)

(* allguards could be replaced by "the program doesn't produce [error]" *)
(* not really -- this would have unanticipated effects if component programs
crashed *)

declareconstant "loop";  (* transforms alternative statement into loop
statement *)

axiom "LOOPTYPE" "loop@?x" "command:loop@command:?x";

axiom "LOOP" "(loop@?c)@?s" "((allguards@?c)@state:?s)||((loop@?c)@(command:?c)@state:?s),state:?s";

axiom "TERMINATOR" "((allguards@?c)@(loop@?c)@?s)->[error]=(loop@?c)@?s" "true";

(* the axiom TERMINATOR guarantees that a loop either satisfies the
expected exit condition or aborts *)

axiom "INVARIANCE" "((?P @ state : ?s) & forall @ [(?P @ state : ?1) -> ?P @ (command : ?c) @ state : ?1]) -> (?P @ (loop @ ?c) @ ?s) | [error] = (loop @ ?c) @ ?s" "true";

(* the axiom INVARIANCE ensures that loop invariants hold when the
loop stops, unless it aborts *)

END old treatment of loops skipped *)

(*

ABORTCOMP1:

(?c ; abort) @ ?s = 

abort @ ?s

["ABORT","ABORTTYPE","PCOMP"]

*)

s "(?c;abort)@?s";
ri "PCOMP"; ex();
ri "LEFT@ $ABORTTYPE"; ex();
ri "ABORT"; ex();
initializecounter();
rri "ABORT"; ex();
assign "?s_1" "?s";
p "ABORTCOMP1";

(*

(abort ; ?c) @ ?s = 

abort @ ?s

["ABORT","ABORTTYPE","ERRORINVARIANCE","PCOMP"]

*)

s "(abort;?c)@?s";
ri "PCOMP"; ex();
ri "RIGHT@LEFT@ $ABORTTYPE"; ex();
ri "RIGHT@ABORT"; ex();
ri "ERRORINVARIANCE"; ex();
initializecounter();
rri "ABORT"; ex();
assign "?s_1" "?s";
p "ABORTCOMP2";

(*

SKIPCOMP1:

(skip ; ?c) @ ?s = 

(command : ?c) @ ?s

["COMMANDTYPE","PCOMP","SKIP","SKIPTYPE","TYPES"]

*)

s "(skip;?c)@?s";
ri "PCOMP"; ex();
ri "(RIGHT@LEFT@ $SKIPTYPE)**RIGHT@SKIP"; ex();
ri "COMMANDEVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
rri "COMMANDEVAL"; ex();
p "SKIPCOMP1";

(*

SKIPCOMP2:

(?c ; skip) @ ?s = 

(command : ?c) @ ?s

["COMMANDTYPE","PCOMP","SKIP","SKIPTYPE","TYPES"]

*)

 
s "(?c;skip)@?s";
ri "PCOMP"; ex();
ri "(LEFT@ $SKIPTYPE)**SKIP"; ex();
ri "(RIGHT@COMMANDTYPE) ** (EVERYWHERE@TYPES) ** $COMMANDTYPE"; ex();
p "SKIPCOMP2";

(* the preceding theorems are not strict equalities between programs because
programs are not extensional functions ; in latest version they are,
because programs now _are_ extensional *)

(* we give a sample of a different kind of theorem *)

defineconstant "behaviour@?P" "[(command:?P)@?1]";

(* with new extensional program treatment, this operation is now
trivial: *)

s "behaviour@?P";
ri "behaviour"; ex();
dlls "command"; ri "command"; ex();
up(); ri "EVAL"; ex();
up(); rri "command"; ex();
p "BEHAV_TRIV";

(* the behaviour operator gives the canonical function corresponding to
a program *)

(*

SKIPCOMP1a:

behaviour @ skip ; ?c = 

behaviour @ ?c

["COMMANDTYPE","PCOMP","PCOMPTYPE","SKIP","SKIPTYPE","TYPES","behaviour"]

*)

s "behaviour@skip;?c";
ri "behaviour"; ex();
ri "VALUE@[(EVERYWHERE@PCOMPTYPE) ** (EVERYWHERE@TYPES) ** (EVERYWHERE@ $PCOMPTYPE)]"; ex();
ri "VALUE@[SKIPCOMP1]"; ex();
rri "behaviour"; ex();
p "SKIPCOMP1a";

(*

PCOMPASSOC:

behaviour @ (?P ; ?Q) ; ?R = 

behaviour @ ?P ; ?Q ; ?R

["PCOMP","PCOMPTYPE","TYPES","behaviour"]

*)

s "behaviour@(?P;?Q);?R";
ri "behaviour"; ex();
right();left();
ri "(RIGHT@PCOMPTYPE)**TYPES** $PCOMPTYPE"; ex();
up();
ri "PCOMP"; ex();
right();left();
ri "(RIGHT@PCOMPTYPE)**TYPES** $PCOMPTYPE"; ex();
up();
ri "PCOMP"; ex();
top();right();
rri "PCOMP"; ex();
ri "(LEFT@TADDTOP@PCOMPTYPE)** $PCOMP"; ex();
up();
ri "VALUE@[LEFT@TADDTOP@PCOMPTYPE]"; ex();
rri "behaviour"; ex();
p "PCOMPASSOC";

(* BEGIN old definitions of Htriple and wp omitted

(* definition of Hoare triple *)

defineconstant "Htriple@?P,?Q,?R" "forall@[(?P@state:?1)->?R@(command:?Q)@state:?1]";

(* definition of weakest precondition *)

(* the fact that the argument is a constant function is needed 
for stratification *)

defineconstant "(wp@[?S])@?R" "[?R@(command:?S)@(state:?1)]";

END old definitions of Htriple and wp omitted *)

(* definition of weakest precondition *)

defineconstant "(wp@[?S])@?R"
"[(~[error]=(command:?S)@(state:?1))&?R@(command:?S)@(state:?1)]";

(* definition of Hoare triple in terms of wp *)

(* definition has to be changed as it is always false as written! *)

defineconstant "Htriple@?P,?Q,?R"
	"[(~[error]=state:?1)&?P@state:?1] |= (wp @ [?Q]) @ ?R";

(*

Htriple2:  

Htriple @ ?P , ?Q , ?R  =  

(forall @ [(?P @ state : ?1) -> ~ [error] = (command 
         : ?Q) @ state : ?1]) & forall @ [(?P @ state 
      : ?1) -> ?R @ (command : ?Q) @ state : ?1]

AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
, FNDIST , Htriple , IF , IN , NONTRIV , NOT1 , ODDCHOICE 
, OR , REFLEX , Subset , TYPES , forall , wp , 0

*)

ae "Htriple";
ri "Subset2"; ex();
drls "wp"; ri "wp"; ex();
up(); ri "EVAL"; ex();
uptols "IDIS3"; ri "IDIS3"; ex();
top(); ri "FORALLDIST"; ex();
p "Htriple2";

(*

EXCLUDED_MIRACLE:

(wp @ [?S]) @ [false] = 

[false]

["wp"]

*)

s "(wp@[?S])@[false]";
ri "wp"; ex();
right(); right(); ri "EVAL"; ex();
up(); ri "CZER"; ex();

p "EXCLUDED_MIRACLE";


(* this uses union instead of conjunction, because we must
be explicit about abstraction in Mark2 *)

(*

CONJUNCTIVITY:

(wp @ [?S]) @ [(?P @ ?1) & ?Q @ ?1] = 

((wp @ [?S]) @ ?P) && (wp @ [?S]) @ ?Q

["AND","ASSERT","BOOLDEF","CASEINTRO","EQUATION","IN","Intersection","NONTRIV","ODDCHOICE","REFLEX","TYPES","wp"]

*)

s "(wp@[?S])@[(?P@?1)&?Q@?1]";
ri "wp"; ex();
right(); ri "EVERYWHERE2@EVAL"; ex();
ri "DUAL@DDISD"; ex();
ri "RL@BIND@?1"; ri "RL@LEFT@ $wp"; ex();
up(); rri "Intersection2"; ex();
p "CONJUNCTIVITY";

(* 


*)

s "Htriple@((wp@[?S])@?R),?S,?R";
ri "Htriple"; ex();
ri "EVERYWHERE2@wp**EVAL"; ex();
ri "Subset2"; ex();
right();right(); ri "EVERYWHERE2@TYPES"; ri "NEWTAUT"; ex();
top(); ri "FORALLDROP**AT"; ex();
p "TRIV_WP";


(* this theorem as stated in Cohen is false; the replacement of ->
with |= is important *)

(* in both monotonicity and the postcondition rule, I can probably
get much more economical proofs by using Cohen's proofs as models *)

(*

WP_MONOTONE:

(?X |= ?Y) -> ((wp @ [?S]) @ ?X) |= (wp @ [?S]) 
@ ?Y = 

true

["AND","ASSERT","BOOLDEF","CASEINTRO","EQUATION","IF","IN","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","Subset","TYPES","forall","wp"]

*)

s "(?X|=?Y)->((wp@[?S])@?X)|=(wp@[?S])@?Y";
 ri "TAB_IF"; ex();
ri "LEFT@Subset2**forall"; ex();
right();left();left();
ri "Subset2"; ex();
right();right();
ri "EVERYWHERE@wp"; ex();
ri "EVERYWHERE@EVAL"; ex();
ri "IDIS3"; ex();
left(); ri "3pt76b"; ex();
up(); right(); ri "IDIS2"; ex();
right(); ri "BIND@(command : ?S) @ state : ?1"; ex();
ri "LEFT@0|-|1"; ri "EVAL"; ex();
up(); ri "DZER"; ex();
up(); ri "AND**REFLEX"; ex();
up(); up(); ri "FORALLDROP**AT"; ex();
up(); ex();
top(); rri "CASEINTRO"; ex();

p "WP_MONOTONE";

(* Postcondition Rule *)

(*

POST_RULE:

(Htriple @ ?Q , ?S , ?R) 
<- (Htriple @ ?Q , ?S , ?A) & ?A |= ?R = 

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQUATION","Htriple","IF","IFF","IN","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","Subset","TYPES","XOR","forall"]


*)

(* note the use of the tactic CONVERT_IMP_2 in this proof;
also note the use of NEWTAUT at the end when it has become
a tautology *)

s "(Htriple@?Q,?S,?R)<-(Htriple@?Q,?S,?A)&?A|=?R";
ri "EVERYWHERE@Htriple"; ex();
ri "CONVIF"; ex();
left(); right(); ri "Subset"; ri "FORALLBOOL"; ri "RIGHT@ $Subset"; 
ri "ASSERT2"; ex();
ri "CONVERT_IMP_2@WP_MONOTONE,((wp @ [?S]) @ ?A) |= (wp @ [?S]) @ ?R"; ex();
ri "CSYM"; ex();
up(); rri "CASSOC"; ex();
left(); rri "CRULE1"; ex();
ri "CONVERT_IMP_2@SubsetTrans,[(~ [error] = state : ?1) & ?Q @ state : ?1] |= (wp @ [?S]) @ ?R"; ex();
top(); ri "NEWTAUT"; ex();

p "POST_RULE";

(* reimplementation of conditionals and loops *)

(* guarded commands abandoned in favor of if-then-else for now *)

(* these definitions have NOT yet been put to the test of use and should
not be regarded as reliable; they may have bugs! *)

defineconstant "if@?test,?command1,?command2" "[(?test@(state:?1))||((command:?command1)@state:?1),(command:?command2)@state:?1]";

(* defining loop would be hard work! *)

declareconstant "loop";

axiom "LOOP" "loop@?test,?command"  
"if@?test,(?command;loop@?test,?command),skip";

defineconstant "decreases@?f,?test,?command" "forall@[(?test@state:?1) -> (Nat:?f@(command:?command)@state:?1)<Nat:?f@state:?1]";

axiom "LOOP_INVARIANT"
"((decreases@?f,?test,?command)&(Htriple@?P,?command,?P))->Htriple@?P,(loop@?test,?command),?P&&[~?test@state:?1]"
"true";

(* theorems about wp *)

(*

ABORT_WP:  

(wp @ [abort]) @ ?B  =  

[false]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , ERRORDATA 
, FNDIST , NONTRIV , NOT1 , ODDCHOICE , REFLEX , TYPES 
, abort , command , state , wp , 0

*)

s "(wp @ [abort]) @ ?B";
ri "wp"; ex();
ri "EVERYWHERE2@($ABORTTYPE)**ABORT**TYPES"; ex();
ri "EVERYWHERE2@REFLEX"; ex();
ri "EVERYWHERE2@ $FDEF"; ex();
ri "EVERYWHERE2@CSYM**CZER"; ex();
p "ABORT_WP";

(* the weakest precondition of skip takes a peculiar form, 
which can be turned into a virtue *)

(*

SKIP_WP_0:  

(wp @ [skip]) @ ?B  =  

[~ [error] = state : ?1] && [?B @ state : ?1]

AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
, FNDIST , HYP , IN , Intersection , NONTRIV , NOT1 
, REFLEX , TYPES , command , skip , wp , 0

*)

s "(wp@[skip])@?B";
ri "wp"; ex();
ri "EVERYWHERE2@($SKIPTYPE)**SKIP**TYPES"; ex();
rri "Intersection2"; ex();
p "SKIP_WP_0";

(* We define a new type:

a state predicate is a predicate of states which is not true
of [error] *)

(*

STATEPREDRETRACT:  

[~ [error] = state : ?1] && [?B @ state : ?1]  =  

[~ [error] = state : ?1] && [([~ [error] = state : ?2] 
      && [?B @ state : ?2]) @ state : ?1]

AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
, FNDIST , IN , Intersection , NONTRIV , NOT1 , ODDCHOICE 
, REFLEX , TYPES , 0

*)

getrightside "SKIP_WP_0";
assign "?B" "[~ [error] = state : ?1] && [?B @ state : ?1]";
ri "EVERYWHERE2@Intersection2"; ri "EVERYWHERE2@EVAL"; ex();
right(); rri "CASSOC"; ex();
ri "EVERYWHERE@TYPES"; ex();
ri "LEFT@CIDEM"; ri "CRULE2"; ex();
top(); rri "Intersection2"; ex();
wb();
p "STATEPREDRETRACT";

defineconstanttype "STATEPREDRETRACT" "statepred:?B" 
"[~ [error] = state : ?1] && [?B @ state : ?1]";

(*

SKIP_WP:  

(wp @ [skip]) @ ?B  =  

statepred : ?B

AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
, FNDIST , HYP , IN , Intersection , NONTRIV , NOT1 
, ODDCHOICE , REFLEX , TYPES , command , skip , statepred 
, wp , 0

*)

s "(wp@[skip])@?B";
ri "wp"; ex();
ri "EVERYWHERE2@($SKIPTYPE)**SKIP**TYPES"; ex();
rri "Intersection2"; ex();
rri "statepred";ex();
p "SKIP_WP";

(* the real reason why statepred is interesting *)

(*

WPTYPE:  

(wp @ [?S]) @ ?R  =  

(wp @ [command : ?S]) @ statepred : ?R

AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
, ERRORDATA , FNDIST , IN , Intersection , NONTRIV 
, NOT1 , ODDCHOICE , REFLEX , TYPES , command , state 
, statepred , wp , 0

*)

s "(wp@[?S])@?R";
ri "wp"; ex();
right(); rri "CRULE2"; ri "LEFT@ $CIDEM"; ri "CASSOC"; ex();
right(); ri "EVERYWHERE2@TADDTOP@COMMANDTYPE"; 
ri "BIND@(command:?S)@state:?1"; ex();
left(); rri "Intersection2"; rri "statepred"; ex();
top(); downtoleft "command:?S"; rri "TYPES"; ex(); 
top(); downtoright "command:?S"; rri "TYPES"; ex();
top(); rri "wp"; ex();
p "WPTYPE";

(* theorems on weakest preconditions of assignments *)

(*

ASSIGN_WP_0:  

(wp @ [?v := ?E]) @ [?B @ (state : ?1) @ ?v]  =  

[(~ (state : ?1) = [error]) & (?B @ (rexp : ?E) @ state 
            : ?1) & ~ ((rexp : ?E) @ state : ?1) = error]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , ERRORDATA 
, FNDIST , HYP , NONTRIV , NOT1 , ODDCHOICE , ONEASSIGN 
, OR , REFLEX , TYPES , command , rexp , state , wp 
, 0

*)

(*

ASSIGN_WP:  

(wp @ [?v := ?E]) @ [?B @ (state : ?1) @ ?v]  =  

statepred : [?B @ (rexp : ?E) @ state : ?1] && [~ ((rexp 
         : ?E) @ state : ?1) = error]

AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
, ERRORDATA , FNDIST , HYP , IN , Intersection , NONTRIV 
, NOT1 , ODDCHOICE , ONEASSIGN , OR , REFLEX , TYPES 
, command , rexp , state , statepred , wp , 0

*)



start "(wp@[?v:=?E])@[?B@((state:?1)@?v)]";
ri "wp"; ex();
ri "EVERYWHERE2@EVAL"; ex();
right(); 
ri "PCASEINTRO@(~(state:?1)=[error])&(?B@(rexp:?E)@(state:?1)) & ~((rexp:?E)@(state:?1))=error"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
right(); left(); ri "(LEFT@AND)**UNPACK"; ex();
right(); left(); ri "(LEFT@NOT)**UNPACK"; ex();
right(); left(); left(); right(); right(); 
	ri "LEFT@TREMTOP@ONEASSIGNTYPE"; ex();
	ri "(LEFT@ONEASSIGN)**EVAL**EVERYWHERE2@TYPES"; ex();
	ri "EVERYWHERE2@ (0|-|3)"; ex();
left();left();right();ri "RIGHT@REFLEX"; ri "DZER"; ex();
up(); ri "CID"; ri "NRULE1"; ex();
up(); ri "(LEFT@NOT)**UNPACK"; ex();
right(); left(); ri "(LEFT@0|-|4)**EVAL"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "REFLEX"; ri "REFLEX"; ex();
up(); rri "FDEF"; ex();
up(); ri "CSYM**CZER"; ex();
up(); right();  (* new case *)
downtoleft "command:?x"; up();	ri "LEFT@TREMTOP@ONEASSIGNTYPE"; ex();
	ri "(LEFT@ONEASSIGN)**EVAL**EVERYWHERE2@TYPES"; ex();
	ri "EVERYWHERE2@EQSYMM**EQUATION**1|-|3"; ex();
	ri "EVERYWHERE2@ $EQUATION";
	ri "EVERYWHERE2@ EQSYMM** $0|-|1"; ex();
	ri "EVERYWHERE2@DID** $ASRTEQ"; ex();
	ri "EVERYWHERE2@CSYM**CID** $ASRTEQ"; ex();
upto "?x=?y"; 

ri "EQUATION"; ex();
right(); left(); ri "(!$REFLEX)@error"; ex();
left();ri "BIND@?v"; ri "LEFT@0|-|4"; ri "EVAL"; ri "LEFT@REFLEX"; ex();
up(); ri "EQUATION**1|-|3"; ex();

uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); ri "NEGF"; ex();
up(); ri "CSYM**CID"; ex();
drrs "COMMANDTYPE"; rri "COMMANDTYPE"; ex();
ri "LEFT@TREMTOP@ONEASSIGNTYPE"; ex();  
(* this repetition is ugly and could be avoided *)
	ri "(LEFT@ONEASSIGN)**EVAL**EVERYWHERE2@TYPES"; ex();
	ri "EVERYWHERE2@EQSYMM**EQUATION**1|-|3"; ex();
	ri "EVERYWHERE2@ $EQUATION";
	ri "EVERYWHERE2@ EQSYMM** $0|-|1"; ex();
	ri "EVERYWHERE2@DID** $ASRTEQ"; ex();
	ri "EVERYWHERE2@CSYM**CID** $ASRTEQ"; ex();
up(); ri "EVAL"; ex();
ri "LEFT@REFLEX"; ex();
up(); rri "0|-|2"; ex();
up(); ri "AT"; ex();  (* another case done *)
up();up();up();right();


 ri "BIND@(command:?v:=?E)@state:?1"; ex();
right();ri "LEFT@TREMTOP@ONEASSIGNTYPE"; ex();
ri "LEFT@ONEASSIGN"; ri "EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
left(); left(); left(); rri "NRULE1"; ex();
ri "ASSERT**BOOLDEF0"; ri "1|-|1"; ex();
up(); ri "CSYM**CID**DRULE1"; ex();
up(); ri "(LEFT@ALTORDEF)**TOPDOWN@UNPACK"; ex();
ri "RIGHT_CASE@REVPIVOT"; ex();
upto "[?P@?1]@?x"; ri "EVAL"; ex();
downtoright "(state:?f)@?x";
upto "(state:?f)@?x"; 
ri "(LEFT@state)**(EVERYWHERE2@EVAL)**(EVERYWHERE2@TYPES)"; ex();
ri "EVERYWHERE2@REFLEX"; ri "TREMTOP@REXPTYPE"; ex();
up(); up(); rri "CRULE3"; ex();
right(); ri "ASSERT**BOOLDEF0"; ri "1|-|2"; ex();
up(); ri "CZER"; ex();  (* another case bites the dust *)


top(); right(); right(); right();
ri "BIND@(command:?v:=?E)@state:?1"; ex();
right();ri "LEFT@TREMTOP@ONEASSIGNTYPE"; ex();
ri "LEFT@ONEASSIGN"; ri "EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
left(); left(); left(); rri "NRULE1"; ex();
ri "ASSERT**BOOLDEF0"; ri "1|-|1"; ex();
up(); ri "CSYM**CID**DRULE1"; ex();
ri "CZER"; ex(); up(); ex();
upto "[?P@?1]@?x"; ri "EVAL"; ri "EVERYWHERE2@EVAL"; ex();
left(); right();right();left(); left(); rri "(2|-|1)@[error]"; ex();

ri "(LEFT@NOT)**UNPACK"; ex();
ri "PIVOT** $CASEINTRO"; ex();
up(); ri "EVAL"; ex();
uptols "REFLEX"; ri "REFLEX"; ex();
up(); rri "FDEF"; ex();
up(); ri "CSYM**CZER"; ex();
top(); right(); right(); left();right();left();rri "TAB_NOT_2"; ex();
rri "BOOLDEF0"; ri "BOOLDEF"; ex();
uptors "AND"; rri "AND"; ex();
ri "ANDBOOL"; ri "BOOLDEF"; ex();
uptors "AND"; rri "AND"; ex();

(* the quick and dirty version *)

p "ASSIGN_WP_0";

top(); rri "Intersection2"; ex();
right(); right(); ri "TYPEBIND@state:?1"; ex();
top(); left(); left();right(); ri "EQSYMM"; ex();
top(); rri "statepred"; ex();
right(); rri "Intersection2"; ex();

(* the fancy version *)

p "ASSIGN_WP";

(* the special case which was proved earlier (approximately) *)

(*

ASSIGN_WP_EXAMPLE:  

(wp @ [?v := ?E]) @ [((state : ?1) @ ?v) = ?a]  =  

[(~ (state : ?1) = [error]) & (((rexp : ?E) @ state 
               : ?1) = ?a) & ~ ((rexp : ?E) @ state 
               : ?1) = error]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , ERRORDATA 
, FNDIST , HYP , NONTRIV , NOT1 , ODDCHOICE , ONEASSIGN 
, OR , REFLEX , TYPES , command , rexp , state , wp 
, 0

*)

s "(wp@[?v:=?E])@[((state:?1)@?v)=?a]";
downtoright "?x=?y"; ri "BIND@(state:?1)@?v"; ex();
top(); ri "ASSIGN_WP_0"; ex();
ri "EVERYWHERE2@EVAL"; ex();

p "ASSIGN_WP_EXAMPLE";

(* BEGIN example in a comment
(* calculation on p. 109, Cohen *)


(*

Htriple @ [true] , (?v := ?x) , [((state : ?1) @ ?v) 
      = 4]  =  

(rexp : ?x) = con @ 4

*)

s "Htriple@[true],(?v:=?x),[((state:?1)@?v)=4]";
ri "Htriple"; ex();
left();right();ri "(RIGHT@EVAL)**CID**NRULE1"; ex();
up();up();
ri "Subset2"; ex();

right(); right(); right();ri "EVERYWHERE2@TYPENUMERAL** $NATDATA"; ex();
ri "(LEFT@ASSIGN_WP_EXAMPLE)**EVAL"; ex();
right(); ri "AND**PIVOT"; rri "AND";
up(); ri "EVERYWHERE@NATDATA"; ex();
right(); right(); right(); ri "EQUATION"; ex();
right(); left(); ri "(!$REFLEX)@error"; ex();
right(); rri "0|-|1"; rri "TYPES"; ri "RIGHT@0|-|1"; ex();
up(); ri "ERRORNOTNAT"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); ri "NEGF"; up(); ri "CID"; rri "ASRTEQ"; ri "RIGHT@ $BUILTIN"; ex();
up();up(); ri "LEFT@EVERYWHERE@EQSYMM"; ex();
ri "IDIS3"; ri "LEFT@IREF"; ri "CSYM**CID**IRULE1"; ex();
ri "TAB_IF"; ri "TAB_NOT_2"; ex();
right(); left(); ri "(!$REFLEX)@error"; ex();
left(); rri "(2|-|1)@data:?x@state:?1"; ex();
rri "REXP0"; ri "REXPTYPE"; ri "TREMTOP@REXPTYPE"; ex();
top(); right(); right(); right(); right(); rri "EQUATION"; ex();
top(); right(); right(); 
	ri "ANTI_UNEVAL_TAC@[(((rexp : ?x) @ state : ?1)) =?2]";ex();
top(); ri "UNIV_EQ"; ex();
left();left(); ri "REXP0"; ri "EVERYWHERE2@TYPES"; ex();
up(); rri "rexp"; ex();
up(); right(); right(); right(); right(); ri "TYPENUMERAL";
	rri "NATDATA"; ex();
right(); rri "BUILTIN"; ri "BIND@state:?1"; ex();
uptors "rexp"; rri "rexp"; ex();
right(); right(); ri "TYPENUMERAL"; rri "NATDATA"; ri "RIGHT@ $BUILTIN"; ex();
uptors "con"; rri "con"; ex();


END example in a comment *)

(* a lemma for the proof of the wp theorem for command composition *)

(*

NOT_ERROR_RED:  

(~ [error] = state : ?x) & ~ [error] = (command : ?P) 
   @ state : ?x  =  

~ [error] = (command : ?P) @ state : ?x

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , ERRORDATA 
, FNDIST , NONTRIV , NOT1 , ODDCHOICE , REFLEX , TYPES 
, command , state , 0

*)

s "(~[error]=state:?x)&(~[error]=(command:?P)@(state:?x))";
ri "AND"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
downtoleft "true= ~?x"; ri "($BOOLDEF)**ASSERT2**NRULE1"; ex();
drls "COMMANDEVAL"; ri "COMMANDEVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
ri "LEFT@EQSYMM"; ri "1|-|1"; ex();
up();up();up();left(); ri "FDEF"; ex();
right(); ri "(!$REFLEX)@[error]"; ex();
top(); ri "BOTH_CASES@UNEVAL@[~[error]=?1]"; ri "($FNDIST)**EVAL"; ex();
right(); right(); ri "(LEFT@EQSYMM)** $COMMANDEVAL"; ex();
ri "COMMANDTYPE**TREMTOP@COMMANDTYPE"; ex();
p "NOT_ERROR_RED";

(*

PCOMP_WP:  

(wp @ [?P ; ?Q]) @ ?B  =  

(wp @ [?P]) @ (wp @ [?Q]) @ ?B

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , ERRORDATA 
, FNDIST , NONTRIV , NOT1 , ODDCHOICE , PCOMPDEF , REFLEX 
, TYPES , command , state , wp , 0

*)

s "(wp@[?P])@(wp@[?Q])@?B";
ri "EVERYWHERE2@wp**EVAL"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@ $COMMANDTYPE"; ex();
right(); rri "CASSOC"; ex();
downtoleft "command:?x"; up(); ri "TADDTOP@COMMANDTYPE"; ex();
upto "?x&?y"; downtoright "command:?x"; up(); ri "COMMANDTYPE"; ex();
upto "?x&?y"; ri "NOT_ERROR_RED"; ex();
ri "EVERYWHERE2@ $COMMANDTYPE"; ex();
top();
ri "EVERYWHERE2@ $PCOMP"; ex();
ri "EVERYWHERE2@TADDTOP@PCOMPTYPE"; ex();
ri "EVERYWHERE2@COMMANDTYPE**TREMTOP@COMMANDTYPE"; ex();
rri "wp"; ex();
wb();
p "PCOMP_WP";

(* next we need to prove that if and loop are commands, and
prove a wp theorem for if *)

(*

IFCOMMAND:  

if @ ?test , ?c1 , ?c2  =  

command : if @ ?test , ?c1 , ?c2

CASEINTRO , EQBOOL , ERRORDATA , FNDIST , TYPES , command 
, if , state , 0

*)

s "if@?test,?c1,?c2";
ri "if"; ex();
right(); ri "PCASEINTRO@(state:?1)=[error]"; ex();
right(); left(); 
	ri "BOTH_CASES@COMMANDEVAL**(LEFT@LEFT@TYPES)**POP_CASE"; ex();
	rri "CASEINTRO"; ex(); 
up(); right(); ri "BOTH_CASES@TADDTOP@COMMANDTYPE"; ex();
	ri "ANTI_UNEVAL_TAC@[state:?2]"; ex();
right(); ri "TYPEBIND@state:?1"; ri "LEFT@ $if"; ex();
top(); rri "command"; ex();
p "IFCOMMAND";

(*

LOOPCOMMAND:  

loop @ ?test , ?command  =  

command : loop @ ?test , ?command

CASEINTRO , EQBOOL , ERRORDATA , FNDIST , LOOP , TYPES 
, command , if , state , 0

*) 

s "loop@?test,?command";
ri "LOOP"; ri "IFCOMMAND"; ri "RIGHT@ $LOOP"; ex();
p "LOOPCOMMAND";

(*

IF_WP_0:  

(wp @ [if @ ?test , ?c1 , ?c2]) @ ?B  =  

[((?test @ state : ?1) & ((wp @ [?c1]) @ ?B) @ ?1) 
   | (~ ?test @ state : ?1) & ((wp @ [?c2]) @ ?B) @ ?1]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , ERRORDATA 
, FNDIST , NONTRIV , NOT1 , ODDCHOICE , OR , REFLEX 
, TYPES , command , if , state , wp , 0

*)


(*

IF_WP:  

(wp @ [if @ ?test , ?c1 , ?c2]) @ ?B  =  

([?test @ state : ?1] && (wp @ [?c1]) @ ?B) ++ (^ [?test 
         @ state : ?1]) && (wp @ [?c2]) @ ?B

AND , ASSERT , BOOLDEF , CASEINTRO , Complement , EQBOOL 
, EQUATION , ERRORDATA , FNDIST , IN , Intersection 
, NONTRIV , NOT1 , ODDCHOICE , OR , REFLEX , TYPES 
, Union , command , if , state , wp , 0


*)

s "(wp@[if@?test,?c1,?c2])@?B";
ri "wp"; ex();
ri "EVERYWHERE2@ $IFCOMMAND"; ri "EVERYWHERE2@if"; ex();
ri "EVERYWHERE2@EVAL";ex();
ri "EVERYWHERE2@TYPES"; ex();
right(); ri "PCASEINTRO@?test@state:?1"; ex();
ri "EVERYWHERE2@POP_CASE"; ex();
ri "BOTH_CASES@($CRULE1)**RIGHT@(BIND@?1)**(LEFT@ $wp)"; 
	ri "CONDCASES2"; ex();
p "IF_WP_0";
top(); rri "Union2"; ex();
ri "RL@ $Intersection2"; ex();
ri "EVERYWHERE@ $Complement2"; ex();
p "IF_WP";


(* note to myself:  this is the first truly complex type environment
I have constructed.  I should write type algorithms for it as tactics *)

quit();








