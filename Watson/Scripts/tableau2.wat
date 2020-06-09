(* August 19, 1997 (as part of general overhaul) *)

script "logicdefs2";

(* this "package" implements a complete style of reasoning for
predicate logic (tableau proofs) *)

(* The strategy is to use the TAB_??? commands to expand logical
assertions into cases (at the moment, I only provide TAB_??? commands
for a subset of the connectives, but this is easily corrected);
the TAB_ALL and TAB_SOME commands require parameters, which represent
counterexamples or witnesses, respectively.  Use the TAB_ALL_2 and
TAB_SOME_2 commands when it is necessary to reuse a statement
(when it is already the defining proposition of a case expression);
actually, it is the _2 commands which will usually be used! *)

(*

TAB_NOT:

 ~?p = 

?p || false , true

["NOT","ODDCHOICE"]

*)

s "~?p";
ri "NOT"; ex();
rri "ODDCHOICE"; ex();
p "TAB_NOT";

(*

TAB_NOT_2:

( ~?p) || ?a , ?b = 

?p || ?b , ?a

["CASEINTRO","NOT","ODDCHOICE"]

*)

s "(~?p)||?a,?b";
ri "LEFT@TAB_NOT"; ex();
ri "UNPACK"; ex();
p "TAB_NOT_2";

(*

TAB_AND:

?p & ?q = 

?p || (?q || true , false) , false

["AND","EQUATION","ODDCHOICE"]

*)

s "?p&?q";
ri "AND"; ex();
rri "ODDCHOICE"; ex();
right();left();
ri "EQUATION** $ODDCHOICE"; ex();
p "TAB_AND";

(*

TAB_AND_2:

(?p & ?q) || ?a , ?b = 

?p || (?q || ?a , ?b) , ?b

["AND","CASEINTRO","EQUATION","ODDCHOICE"]


*)

s "(?p&?q)||?a,?b";
ri "(LEFT@TAB_AND)**UNPACK"; ex();
ri "EVERYWHERE@UNPACK"; ex();
p "TAB_AND_2";


(*

TAB_OR:

?p | ?q = 

?p || true , ?q || true , false

["AND","CASEINTRO","EQUATION","NONTRIV","NOT","ODDCHOICE","OR","REFLEX"]

*)

s "?p|?q"; 
ri "ALTORDEF"; ex();
rri "ODDCHOICE"; ex();
right();right();
ri "EQUATION** $ODDCHOICE"; ex();
p "TAB_OR";

(*
TAB_OR_2:

(?p | ?q) || ?a , ?b = 

?p || ?a , ?q || ?a , ?b

["AND","CASEINTRO","EQUATION","NONTRIV","NOT","ODDCHOICE","OR","REFLEX"]


*)

s "(?p|?q)||?a,?b";
ri "(LEFT@TAB_OR)**UNPACK"; ex();
ri "EVERYWHERE@UNPACK"; ex();
p "TAB_OR_2";


(*

TAB_IF:

?p -> ?q = 

?p || (?q || true , false) , true

["AND","CASEINTRO","EQUATION","IF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX"]

*)

s "?p->?q";
ri "IF"; ex();
ri "TAB_OR"; ex();
left();
ri "TAB_NOT"; ex();
up();
ri "UNPACK"; ex();
p "TAB_IF";

(*
TAB_IF_2:

(?p -> ?q) || ?a , ?b = 

?p || (?q || ?a , ?b) , ?a

["AND","CASEINTRO","EQUATION","IF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX"]


*)

s "(?p->?q)||?a,?b";
ri "(LEFT@TAB_IF)**UNPACK"; ex();
ri "EVERYWHERE@UNPACK"; ex();
p "TAB_IF_2";

(*

TAB_IFF:

?x == ?y = 

?x || (?y || true , false) , ?y || false , true

*)

s "?x==?y";
ri "NEWTAUT"; ex();
p "TAB_IFF";

(*

TAB_IFF_2:

(?x == ?y) || ?a , ?b = 

?x || (?y || ?a , ?b) , ?y || ?b , ?a

["AND","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","XOR"]

*)

s "(?x==?y)||?a,?b";
ri "LEFT@TAB_IFF";
ri "UNPACK";
ri "EVERYWHERE@UNPACK"; ex();
p "TAB_IFF_2";

(*
TAB_XOR:

?x =/= ?y = 

?x || (?y || false , true) , ?y || true , false

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]

*)

s "?x=/=?y";
tri "(~?x)==?y";
ri "NEWTAUT"; ex();
p "TAB_XOR";

(*

TAB_XOR_2:

(?x =/= ?y) || ?a , ?b = 

?x || (?y || ?b , ?a) , ?y || ?a , ?b

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","TYPES","XOR"]


*)

s "(?x=/=?y)||?a,?b";
ri "LEFT@TAB_XOR";
ri "UNPACK";
ri "EVERYWHERE@UNPACK"; ex();
p "TAB_XOR_2";

(*

TAB_ALL @ ?x:

forall @ [?P @ ?1] = 

(forall @ [?P @ ?1]) 
|| ((EVAL => ?P @ ?x) || true , false) , false

["CASEINTRO","EQUATION","forall"]

*)




initializecounter();
s "forall@[?P@?1]";
ri "forall**EQUATION"; ex();
right();left();
ri "PCASEINTRO@?P@?x"; ex();
right();right();
rri "1|-|2"; ex();
assign "?x_5" "false";
left();
ri "(BIND@?x)**(LEFT@0|-|1)**EVAL"; ex();
up();ex();
top();
ri "LEFT@ $forall2";ex();
top();right();left();left();
ri "EVAL";
prove "TAB_ALL@?x";


(*

TAB_SOME @ ?x:

forsome @ [?P @ ?1] = 

(forsome @ [?P @ ?1]) || true , (EVAL => ?P @ ?x) 
|| true , false

["CASEINTRO","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","ODDCHOICE","REFLEX","forall","forsome"]



*)



s "forsome@[?P@?1]";
ri "forsome"; ex();
right();
ri "TAB_ALL@?x"; ex();
drls "TAB_NOT";
ri "TAB_NOT"; up(); ri "UNPACK"; ex();
top();
ri "TAB_NOT"; ex();
ri "UNPACK"; ex();
ri "EVERYWHERE@UNPACK"; ex();
rri "NOT_EXP"; ex();
left();
rri "forsome2"; ex();
top();
right();right();left();
ri "EVAL";
prove "TAB_SOME@?x";


(*

TAB_ALL_2 @ ?x:

(forall @ [?P @ ?1]) || ?a , ?b = 

(forall @ [?P @ ?1]) 
|| ((EVAL => ?P @ ?x) || ?a , ?b) , ?b

["CASEINTRO","EQUATION","forall"]


*)


s "(forall@[?P@?1])||?a,?b";
ri "LEFT@TAB_ALL@?x"; ex();
ri "EVERYWHERE@UNPACK"; ex();
ri "EVERYWHERE@UNPACK"; ex();
right();left();left();
ri "EVAL";
prove "TAB_ALL_2@?x";

(*

TAB_SOME_2 @ ?x:

(forsome @ [?P @ ?1]) || ?a , ?b = 

(forsome @ [?P @ ?1]) || ?a , (EVAL => ?P @ ?x) 
|| ?a , ?b

["CASEINTRO","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","ODDCHOICE","REFLEX","forall","forsome"]


*)

s "(forsome@[?P@?1])||?a,?b";
ri "LEFT@TAB_SOME@?x"; ex();
ri "EVERYWHERE@UNPACK"; ex();
ri "EVERYWHERE@UNPACK"; ex();
right();right();left();
ri "EVAL";
prove "TAB_SOME_2@?x";

(* an example *)


initializecounter();
s "(forall@[?P@?1])->forsome@[?P@?1]";
ri "TAB_IF"; ex();
ri "TAB_ALL_2@?x"; ex();
dlls "TAB_SOME_2";
ri "TAB_SOME_2@?x"; ex();
downtoleft "false";
rri "1|-|2"; ex(); ri "1|-|4"; ex();
assign "?x_4" "true";
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();  

(* notice the extreme effectiveness of this command!!! *)

(* a propositional example *)


initializecounter();
s "(?x&?y&?z)->?y";
ri "TAB_IF"; ex();
ri "TAB_AND_2"; ex();
right(); left();
ri "TAB_AND_2"; ex();
downtoleft "false";

(*

- lookhyps();
1 (positive):

?x


2 (positive):

?y


3 (positive):

?z


4 (negative):

?y

*)

rri "1|-|2"; ex(); ri "1|-|4"; ex();
assign "?x_4" "true";
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();

(* we now introduce the tactics which were missing in the premature release:
these implement reasoning with "new" witnesses or counterexamples.  They
involve abstraction, and the setup is more complicated!  I don't think
that it will be at all transparent what is going on here *)

(* this theorem sets up a context with a "new" witness for 
reasoning under an existential hypothesis *)

(* the ugly part is that one needs to know which context to move to
after this setup (the leftmost ?a of the pair ?a,?a, the context in which
one has the hypothesis ?P @ ?1) ); the strategy is to convert this
expression to "true", return to the top, and apply the theorem
TAB_SOME_NEW_2 given below *)

(* the movement problems are soluble:

as in the example, use downtoright "?x,?x"; left(); (after
TAB_SOME_NEW_1; right(); after TAB_ALL_NEW_1) to get to the right
subexpression; use uptols "TAB_SOME_NEW_2" to get back up to the place
where TAB_SOME_NEW_2 can be applied (for example). *)

(* this movement advice will not work in Watson *)

(*

TAB_SOME_NEW_1:

(forsome @ [?P @ ?1]) || ?a , ?b = 

(forsome @ [?P @ ?1]) 
|| (([?a] = [(EVAL => ?P @ ?1) || ?a , ?a]) || ?a 
   , true) , ?b

["CASEINTRO","REFLEX"]

*)

initializecounter();
s "(forsome@[?P@?1])||?a,?b";
right();left();
ri "PCASEINTRO@[?a]=[?a]"; ex();
right();right();
rri "1|-|2"; ex();
ri "LEFT@REFLEX"; ex();
assign "?x_2" "true";
up();up();left();right();right();
ri "PCASEINTRO@?P@?1"; ex();
left();
ri "EVAL"; 
p "TAB_SOME_NEW_1";

(* this is the setup for the theorem which is used to "finish up"
reasoning about "new" witnesses *)

(*

TAB_SOME_NEW_2:

(forsome @ [?P @ ?1]) 
|| (([?a] = [(?P @ ?1) || true , ?a]) || ?a , true) 
, ?b = 

(forsome @ [?P @ ?1]) || true , ?b

["CASEINTRO","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","ODDCHOICE","REFLEX","forall","forsome"]


*)

initializecounter();
s "(forsome@[?P@?1])||(([?a]=[(?P@?1)||true,?a])||?a,true),?b";
ri "LEFT@forsome"; ex();
ri "TAB_NOT_2"; ex();
ri "LEFT@forall"; ex();
right();right();
right();left();
ri "PCASEINTRO@?a=true"; ex();
right();left();
ri "0|-|3"; ex();
up();right();
rri "1|-|1"; ex();
left();left();left();
ri "NOT"; ex();
right();left();
rri "NONTRIV"; ex();
left();
rri "REFLEX"; ex();
assign "?a_12" "?a";
ri "RL@BIND@?1";ex();
right();left();
ri "0|-|2"; ex();
up();up();
ri "RL@EVAL"; ex();
right();left();
rri "0|-|4"; ex();
up();ex();
up();
ri "EQUATION"; ex();
ri "1|-|3"; ex();
up();
ri "REFLEX"; ex();
up();up();
rri "CASEINTRO"; ex();
up();up();up();
ri "LEFT@REFLEX"; ex();
assign "?x_9" "true";
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();
ri "LEFT@ $forall";ex();
rri "NOT_EXP"; ex();
ri "LEFT@ $forsome2"; ex();
prove "TAB_SOME_NEW_2";

(* setup for the universal quantifier: introducing a "new"
counterexample when a universal statement is assumed to be false *)

(* the strategy is to move into the rightmost of the pair ?b,?b which
is created, the context in which the hypothesis ?P@?1 is available in
the _negative_ sense, convert that to "true", then return to the top
of the expression and apply TAB_ALL_NEW_2 below *)

(*

TAB_ALL_NEW_1:

(forall @ [?P @ ?1]) || ?a , ?b = 

(forall @ [?P @ ?1]) || ?a 
, ([?b] = [(EVAL => ?P @ ?1) || ?b , ?b]) || ?b 
, true

["BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","ODDCHOICE","REFLEX","forall","forsome"]

*)

s "(forall@[?P@?1])||?a,?b";
left();
rri "FORALLBOOL2"; ex();
right();right();
rri "DUBNEG"; ex();
top();
rri "NOT_EXP"; ex();
ri "LEFT@ $forsome"; ex();
ri "TAB_SOME_NEW_1"; ex();
ri "LEFT@forsome"; ex();
ri "NOT_EXP"; ex();
left();right();right();
ri "DUBNEG"; ex();
up();up();
ri "FORALLBOOL2"; ex();
top();
dlls "NOT_EXP";
ri "NOT_EXP"; ex();
left();
ri "EVAL";
p "TAB_ALL_NEW_1";

(* theorem for finishing up reasoning using a "new" counterexample *)

(*

TAB_ALL_NEW_2:

(forall @ [?P @ ?1]) || ?a 
, ([?b] = [(?P @ ?1) || ?b , true]) || ?b , true = 

(forall @ [?P @ ?1]) || ?a , true

["BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","ODDCHOICE","REFLEX","forall","forsome"]


*)

s "(forall @ [?P @ ?1]) || ?a , ([?b] = [(?P @ ?1) || ?b , true]) || ?b , true";
left();
rri "FORALLBOOL2"; ex();
right();right();
rri "DUBNEG"; ex();
top();
rri "NOT_EXP"; ex();
ri "LEFT@ $forsome"; ex();
right();left();left();right();right();
rri "NOT_EXP"; ex();
top();
ri "TAB_SOME_NEW_2"; ex();

ri "LEFT@forsome"; ex();
ri "NOT_EXP"; ex();
left();right();right();
ri "DUBNEG"; ex();
up();up();
ri "FORALLBOOL2"; ex();

p "TAB_ALL_NEW_2";

(* a tactic for cleanup (automatic application of the NEW_2 tactics and
of $CASEINTRO) seems both necessary and possible *)


(* example *)

(* a narrative description of what happens in the following proof would be
useful!!! (now provided) *)

(*

ALT_QUANT_IMP:

(forsome @ [forall @ [?P @ ?1 , ?2]]) -> forall 
@ [forsome @ [?P @ ?2 , ?1]] = 

true

["AND","BOOLDEF","CASEINTRO","EQBOOL","EQUATION","FNDIST","IF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","forall","forsome"]


*)

initializecounter();
s "(forsome@[forall@[?P@?1,?2]]) -> (forall@[forsome@[?P@?2,?1]])";
ri "TAB_IF"; ex();  (* expand the implication into cases *)
ri "TAB_SOME_NEW_1"; ex();  (* set up "new" witness for existential *)
downtoright "?x,?x"; left();  (* go to environment with "new" witness ?1 *)
ri "TAB_ALL_NEW_1"; ex();  (* set up "new" counterexample ?2 for universal *)
downtoright "?x,?x"; right();  (* go to environment with "new" 
	counterexample *)
rri "1|-|2"; ex();  (* use hypothesis 2 (view with lookhyps) *)
rri "ODDCHOICE"; ex();
assign "?x_4" "[true]";
ri "TAB_ALL_2@?2"; ex(); (* instantiate hypothesis 2 with the counterexample *)
downtoleft "false";
rri "1|-|4"; ex();  (* use hypothesis 4 (view with lookhyps) *)
assign "?x_7" "[true]";
rri "ODDCHOICE"; ex();
ri "TAB_SOME_2@?1"; ex(); (* use witness ?1 as counterexample to hyp 4 *)
downtoright "false";  (* here we can see a contradiction (use lookhyps) *)
ri "($1|-|6)**1|-|8"; ex();  (* clinch the deal *)
assign "?x_12" "[true]";
up();up();  (* continue going up as long as all cases are true *)
up();up();
up();up();
up();up();
up();up();
ri "EVERYWHERE@ $CASEINTRO"; ex();  (* collapse true cases together *)
uptols "TAB_ALL_NEW_2"; (* go up to the place where the universal statement
     can be proved *)
ri "TAB_ALL_NEW_2"; ex();  (* prove it *)
up();up();
ri "EVERYWHERE@ $CASEINTRO"; ex();  (* collapse true cases together *)
uptols "TAB_SOME_NEW_2";  (* go up to the place where the existential statement
     can be proved *)
ri "TAB_SOME_NEW_2";ex();  (* prove it *)
rri "CASEINTRO"; ex();  (* collapse true cases together *)
p "ALT_QUANT_IMP";

(* an alternate approach to quantification involves the use of choice to
build explicit witnesses *)

declaretypedunary 1 "!!!";

axiom "CHOICE" "forsome@[?P@?1]" "?P@ !!![?P@?1]";

(* this really is the axiom of choice! *)

definetypedinfix "COUNTER1" 0 1 "***?P" "!!![~?P@?1]";
s "***[?P@?1]";ri "COUNTER1";ex();p "COUNTER";

(* deferred from typestuff.mk2:  the official definition of the subtype
constructor *)

declareinfix "|/";

axiom "SUBTYPE" "(?t |/ ?P):?x" "(?P@?t:?x)||(?t:?x),?t: !!![?P@?t:?1]";

(* theorem for introduction of counterexamples *)

(*

CEX:

forall @ [?P @ ?1] = 

bool : ?P @  ***[?P @ ?1]

["BOOLDEF","CASEINTRO","CHOICE","COUNTER1","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","REFLEX","forall","forsome"]


*)

s "forall@[?P@?1]";
ri "($FORALLBOOL2)** RIGHT@VALUE@[$DUBNEG]"; ex();
ri "FORALLBOOL** $DUBNEG"; ex();
ri "RIGHT@ $forsome2"; ex();
ri "RIGHT@CHOICE"; ex();
ri "RIGHT@RIGHT@ $COUNTER"; ex();
ri "RIGHT@EVAL"; ex();
ri "DUBNEG"; ex();
p "CEX";

s "forsome@[?P@?1]";
ri "CHOICE"; ex();
ri "EVAL";
p "CHOICE_TAC";

s "forall@[?P@?1]";
ri "CEX"; ex();
right(); ri "EVAL";
p "CEX_TAC";


(* an omission rectified; simple case introduction for quantifiers *)

(*

forsomecase:

forsome @ [?P @ ?1] = 

(forsome @ [?P @ ?1]) || true , false

["BOOLDEF","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","ODDCHOICE","REFLEX","forsome"]

*)

s "forsome@[?P@?1]";
ri "FORSOMEBOOL**BOOLDEF**EQUATION** $ODDCHOICE"; ex();
p "forsomecase";

(*

forallcase:

forall @ [?P @ ?1] = 

(forall @ [?P @ ?1]) || true , false

["BOOLDEF","EQBOOL","EQUATION","ODDCHOICE","forall"]

*)

s "forall@[?P@?1]";
ri "FORALLBOOL**BOOLDEF**EQUATION** $ODDCHOICE"; ex();
prove "forallcase";

(*

ANY_INSTANCE:

(?P @ ?x) -> ?P @  !!![?P @ ?1] = 

true

["AND","CASEINTRO","CHOICE","EQBOOL","EQUATION","FNDIST","IF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","forall","forsome"]

*)

initializecounter();
s "(?P@?x)->?P@ !!![?P@?1]";
ri "TAB_IF"; ex();
downtoleft "false";
rri "1|-|2"; rri "ODDCHOICE"; ex();
ri "LEFT@ $CHOICE"; ex();
ri "LEFT@forsome"; ex();
ri "TAB_NOT_2"; ex();
ri "LEFT@forall"; ex();
downtoleft "false";
rri "1|-|1"; ex();
rri "ODDCHOICE"; ex();
rri "TAB_NOT_2"; ex();
left();
ri "BIND@?x"; ex();
ri "(LEFT@0|-|3)**EVAL"; ex();
up();ex();
assign "?x_2" "true";
assign "?x_15" "true";
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();
p "ANY_INSTANCE";

(* tableau proof tactics using choice *)

(*

TAB_WITNESS:

(forsome @ [?P @ ?1]) || ?a , ?b = 

(forsome @ [?P @ ?1]) 
|| ((CHOICE_TAC => forsome @ [?P @ ?1]) || ?a , ?b) 
, ?b

["CHOICE"]

*)

initializecounter();
s "(forsome@[?P@?1])||?a,?b"; 
right();left();
rri "1|-|1"; rri "ODDCHOICE"; ex();
assign "?x_1" "?b";
left();
ri "CHOICE_TAC";
p "TAB_WITNESS";

(*

TAB_CEX:

(forall @ [?P @ ?1]) || ?a , ?b = 

(forall @ [?P @ ?1]) || ?a , ODDCHOICE 
<= (BOOLDEF => CEX_TAC => forall @ [?P @ ?1]) 
|| ?a , ?b

["BOOLDEF","CASEINTRO","CHOICE","COUNTER1","EQBOOL","EQUATION","FNDIST","NONTRIV","NOT","ODDCHOICE","REFLEX","forall","forsome"]

*)

initializecounter();
s "(forall@[?P@?1])||?a,?b"; 
right();right();
rri "1|-|1"; rri "ODDCHOICE"; ex();
assign "?x_1" "?a";
left();
ri "CEX_TAC";ri "BOOLDEF";up();rri "ODDCHOICE";
prove "TAB_CEX";

(* another stab at alternating quantifiers *)

(*

ALT_QUANT_AGAIN:

(forsome @ [forall @ [?P @ ?1 , ?2]]) -> forall 
@ [forsome @ [?P @ ?2 , ?1]] = 

true

["AND","BOOLDEF","CASEINTRO","CHOICE","COUNTER1","EQBOOL","EQUATION","FNDIST","IF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","forall","forsome"]

*)

initializecounter();
s "(forsome@[forall@[?P@?1,?2]]) -> (forall@[forsome@[?P@?2,?1]])";
ri "TAB_IF"; ex();
ri "TAB_WITNESS"; ex();
downtoleft "false";
upto "?x||?y,?z";
ri "TAB_CEX"; ex();
 downtoleft "false";
rri "1|-|2"; rri "ODDCHOICE"; ex();
ri "TAB_ALL_2@ ***[forsome @ [?P@?2,?1]]";ex();
downtoleft "false";
rri "1|-|4"; rri "ODDCHOICE"; ex();
ri "TAB_SOME_2@ !!![forall @ [?P @ ?1,?2]]";ex();
downtoleft "false";
ri "($1|-|6)**1|-|8"; ex();
assign "?x_8" "true";
assign "?x_11" "true";
assign "?x_16" "true";
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();
p "ALT_QUANT_AGAIN";

(* this style is much better; no need for special cleanup for the 
TAB_WITNESS and TAB_CEX tactics!!!  There is a syntactical cost:  the
witnesses have long names with bound variables in them.  It might
be a good idea to introduce definitions in long proofs, though this
would require a little work after the proof was done to get rid of the
definition deps *)


(* Alex's example *)

(*

COMMUTE_LEVEL_QUANT:

(forall @ [forall @ [?P @ ?1 , ?2]]) == forall 
@ [forall @ [?P @ ?2 , ?1]] = 

true

["AND","BOOLDEF","CASEINTRO","CHOICE","CONVIF","COUNTER1","EQBOOL","EQUATION","FNDIST","IF","IFF","IGNOREFIRST","NONTRIV","NOT","ODDCHOICE","OR","REFLEX","XOR","forall","forsome"]

*)

s "(forall@[forall@[?P@?1,?2]]) == forall@[forall@[?P@?2,?1]]";
ri "TAB_IFF"; ex();
downtoleft "false";
rri "(2|-|2)@true"; rri "ODDCHOICE"; ex();
ri "TAB_CEX"; ex();
right();right();
ri "TAB_CEX"; ex();
downtoright "false";
rri "(2|-|1)@true"; rri "ODDCHOICE"; ex();
ri "TAB_ALL_2@ ***[?P @ ?1 ,  ***[forall @ [?P @ ?3 , ?2]]]";ex();
right();left();
ri "TAB_ALL_2@ ***[forall @ [?P @ ?2 , ?1]]"; ex(); 
downtoright "false";
ri "($(2|-|8)@true)**1|-|5"; ex();
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();
downtoright "false"; (* the second part used cut and paste a lot *)
rri "(2|-|1)@true"; rri "ODDCHOICE"; ex();
ri "TAB_CEX"; ex();
right();right();
ri "TAB_CEX"; ex();
downtoright "false";
rri "(2|-|2)@true"; rri "ODDCHOICE"; ex();
ri "TAB_ALL_2@ ***[?P @ ( ***[forall @ [?P @ ?2 , ?3]]) , ?1] "; ex();
right();left();
ri "TAB_ALL_2@ ***[forall @ [?P @ ?1 , ?2]] "; ex(); 
downtoright "false";
ri "($(2|-|8)@true)**1|-|5"; ex();
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();
p "COMMUTE_LEVEL_QUANT";

(* a handy result *)

(*

EQ_TRANS:

((?x = ?y) & ?y = ?z) -> ?x = ?z = 

true

["AND","CASEINTRO","EQUATION","IF","NONTRIV","NOT","ODDCHOICE","OR","REFLEX"]

*)

s "((?x=?y)&(?y=?z))->?x=?z";
ri "TAB_IF"; ex();
ri "TAB_AND_2"; ex();
right();left();
ri "EVERYWHERE@LEFT@EVERYWHERE@0|-|1"; ex();
right();left();
ri "1|-|2"; ex();
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();
prove "EQ_TRANS";

quit();