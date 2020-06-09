s "forsome@[forall@[(?1@?2)=(?P@!?2)@0]]";
ri "DINSTANTIATEF1@[(?P@!?1)@0]"; ex();
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@REFLEX**FORALLDROP**AT"; ex();
ri "TAB_OR"; ex();

(* this looks very dangerous, but the proof does not go through! *)

(* is it possible that it really is secure? *)

(* our security here is that unstratified comprehension axioms cannot even
be stated!!! *)

s "[[(?P@!?1)@!?2]]@?x"; 

s "[~(?P@!?1)@?P@!?1]";

s "[~(?P@!?1)@?P@!?1]@[~(?P@!?1)@?P@!?1]";
ri "PCASEINTRO@(?P @! [~ (?P @! ?1) @ ?P @! ?1])=[~(?P@!?1)@?P@!?1]";ex();
ri "BOTH_CASES@EVAL"; ex();
right(); left(); ri "EVERYWHERE2@0|-|1"; ex();

(* from here down is the proof that it does not work *)

s "?x= ~?x";
ri "PCASEINTRO@?x";
ri "EVERYWHERE@NOT"; ex();
ri "ALT_PUSH"; ex();
right(); left(); ri "(LEFT@ $0|-|1)**NONTRIV"; ex();
up(); right();ri "EQSYMM**EQUATION**1|-|1"; ex();
top(); rri "CASEINTRO"; ex();
prove "NOFIXEDPOINT";


s "([~(?P@!?1)@?P@!?1]) = ?P@![~(?P@!?1)@?P@!?1]";
ri "EQUATION"; ex();
right(); left(); ri "(!$REFLEX)@[~(?P@!?1)@?P@!?1]@[~(?P@!?1)@?P@!?1]"; ex();
ri "RIGHT@EVAL"; ex(); ri "RIGHT@RIGHT@RL@ $0|-|1"; ex();
ri "NOFIXEDPOINT"; ex();
top(); rri "CASEINTRO"; ex();
wb(); ri "RIGHT@BIND@[~(?P@!?1)@?P@!?1]";ex(); wb();
p "LEMMA1";

s "forsome@[~?1=?P@!?1]";
ri "DINSTANTIATEF1@[~(?P@!?1)@?P@!?1]"; ex();
left(); ri "EVAL"; ex();
right();ri "RIGHT@BIND@[~(?P@!?1)@?P@!?1]";ex();ri "LEMMA1"; ex();
up(); ri "NEGF"; up(); ri "TAB_OR"; ex();
p "NONSENSE";
assign "?P" "[?1]";
p "MORE_NONSENSE";
wb();ri "EVERYWHERE2@REFLEX**($FDEF)**FORSOMEDROP**AF"; ex();
p "COMPLETE_NONSENSE";

(* somehow I have to make sure that only "possible" abstracts
are permitted in some sense *)

(* require somehow that ?P@!?1 must have a "floating" type? *)

(* require that ?n must have  floating type, to allow ?P@!?n ?*)

Is it sufficient for ?P@!?n to type with two different assignments of
type characteristics to @! ?