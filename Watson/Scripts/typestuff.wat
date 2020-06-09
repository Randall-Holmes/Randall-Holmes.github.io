(* adapted to use type definitions, March 19, 1999 *)

(* August 19, 1997 (as part of general overhaul) *)

(* Feb. 26, 1999:  the type constructor part is completely rewritten
in terms of type definitions, which are now supported *)

(* utilities for manipulating type labels plus definitions of
type constructors.  Subtyping requires the axiom of choice, so is deferred
to the file tableau2.mk2 *)

script "structural";  (* basic structural tactics *)

(* a parameter theorem ?thm is expected to be of the form
?x + ?y = t1: (t2:?x)+t3:?y *)

(* remove type label on right *)

start "?x^+?y";
ri "?thm*>((RIGHT@LEFT@TYPES)** $?thm)";
prove "TREMLEFT@?thm";

(* remove type label on left *)

start "?x^+?y";
ri "?thm*>((RIGHT@RIGHT@TYPES)** $?thm)";
prove "TREMRIGHT@?thm";

(* remove type labels on both sides *)

start "?x^+?y";
ri "?thm*>((RIGHT@(RIGHT@TYPES)**(LEFT@TYPES))** $?thm)";
prove "TREMBOTH@?thm";

(* remove type label at top *)

(* changed June 26th to prevent unintended side-effects *)

start "?t:?x";
ri "RIGHT@?thm"; ri "TYPES"; rri "?thm";
prove "TREMTOP@?thm";

(* add type label on left *)

start "?x";
ri "?thm*>((RIGHT@LEFT@ $TYPES)** $?thm)"; rri "?thm";
prove "TADDLEFT@?thm";


(* add type label on right *)

start "?x";
ri "?thm*>((RIGHT@RIGHT@ $TYPES)** $?thm)"; rri "?thm";
prove "TADDRIGHT@?thm";

(* add type labels on both sides *)

start "?x";
ri "?thm*>((RIGHT@(RIGHT@ $TYPES)**(LEFT@ $TYPES))** $?thm)"; rri "?thm";
prove "TADDBOTH@?thm";

(* add type label at top *)

start "?x";
ri "?thm*>(($TYPES)**RIGHT@ $?thm)";
prove "TADDTOP@?thm";

(* axioms for type constructors (June 19, 1997) *)

s "[?t2:?f@?t1:?1]";
assign "?f" "[?t2:?f@?t1:?1]";
ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@TYPES"; ex();
wb();
p "ARROWRETRACT";

defineinfixtype "ARROWTYPE" "ARROWRETRACT" "(?t1->>?t2):?f" "[?t2:?f@?t1:?1]";

s "(?t1:P1@?x),?t2:P2@?x"; 
assign "?x" "(?t1:P1@?x),?t2:P2@?x";
ri "EVERYWHERE@PI1"; ex();
ri "EVERYWHERE@PI2"; ex();
ri "EVERYWHERE@TYPES"; ex();
wb();
p "PRODRETRACT"; 

defineinfixtype  "PRODTYPE" "PRODRETRACT" 
	"(?t1 <*> ?t2):?x" "(?t1:P1@?x),?t2:P2@?x";

s "(?x=?t1:?x)||(?t1:?x),?t2:?x";
assign "?x" "(?x=?t1:?x)||(?t1:?x),?t2:?x";
ri "PCASEINTRO@?x=?t1:?x"; ex();
right(); left(); ri "EVERYWHERE2@1|-|1"; ex();
ri "EVERYWHERE2@TYPES"; ri "LEFT@REFLEX"; ex();
up(); right(); ri "EVERYWHERE2@1|-|1"; ex();
ri "EVERYWHERE2@TYPES"; ex();
right(); left(); rri "0|-|2"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
wb();
p "UNIONRETRACT";

defineinfixtype "UNIONTYPE" "UNIONRETRACT" "(?t1 <+> ?t2):?x" "(?x=?t1:?x)||(?t1:?x),?t2:?x";

(* one element types *)

axiom "POINTTYPE" "[?x]:?y" "?x";

(*  Modification of quantifiers.mk2 should be projected 

(* This is not a satisfactory definition, because it puts the same error
object in every subtype of type ?t; the official definition will appear
after the axiom of choice in quantifiers.mk2 *)

declareinfix "|/";

declareconstant "error";

axiom "SUBTYPE"  "(?t |/ ?P):?x" "(?P@?t:?x)||(?t:?x),?t:error";

*)

s "?x||true,false";
assign "?x" "?x||true,false";
ri "PCASEINTRO@?x"; ex();
right(); left(); ri "EVERYWHERE2@1|-|1"; ex();
up(); right(); ri "EVERYWHERE2@1|-|1"; ex();
wb();
p "BOOL_RETRACT";

defineconstanttype "BOOL_RETRACT" "Bool:?x" "?x||true,false";

s "true";
p "TRUERETRACT";

defineconstanttype "TRUERETRACT" "True:?x" "true";

quit();






