(* example of implementation of a type of syntactical objects
for Schneider *)

script "new.quantifiers"; (* lots of logic *)

(* the syntax 

term = variable | - term | term + term

variable = v | variable '

*)

(* consideration:  I do not use operations + (binary) - (unary) or
' (unary) (the last isn't compatible with Watson); I could, but if
I did I would need to add operations for extracting right and left terms,
for determining what kind of term I was looking at, and so forth; pairing
already has suitable properties *)

declareconstant "Plus";

declareconstant "Minus"; 

declareconstant "Prime";

declareconstant "V";

declareconstant "term";

declareconstant "variable";

(* tags on different kinds of structure can be told apart! *)

(* the proliferation of little axioms could be avoided here
by defining the tags as natural numbers, which can be proved
distinct *)

axiom "PlusnotMinus" "Plus=Minus" "false";

axiom "PlusnotPrime" "Plus=Prime" "false";

axiom "MinusnotPrime" "Minus=Prime" "false";

axiom "VnotPlus" "V=Plus" "false";

axiom "VnotMinus" "V=Minus" "false";

axiom "VnotPrime" "V=Prime" "false";

(* axioms for the variable subtype *)

(* the atomic variable is treated as a tagged object 
in spite of the fact that there is nothing to tag *)

axiom "VTYPE" "V,0" "variable:V,0";

(* all tags are put in front to facilitate proofs of disjointness *)

axiom "PRIMETYPE" "Prime,variable:?x" "variable:Prime,?x";

(* closure principle for variable type *)

axiom "VARIABLE_CLOSURE" "forall@[?P@variable:?1]" 
"(?P@V,0)&forall@[(?P@variable:?1)->?P@variable:Prime,?1]";

(* axioms for the term type *)

axiom "VARIABLE_IS_TERM" "variable:?x" "term:variable:?x";

axiom "MINUS_IS_TERM" "Minus,term:?x" "term:Minus,?x";

axiom "PLUS_IS_TERM" "Plus,(term:?x),term:?y" "term:Plus,?x,?y";

(* closure principle for the term type *)

axiom "TERM_CLOSURE" "forall@[?P@term:?1]" "forall@[?P@variable:?1]&
forall@[(?P@term:?1)->?P@Minus,?1]&forall@[(?P@term:P1@?1)->(?P@term:P2@?1)->
?P@Plus,(P1@?1),P2@?1]";

(* one can make things look nicer *)

defineconstant "v" "V,0";
defineinfix "prime_def" "` ?v" "Prime,variable:?v";

(* ` must be separated by a space from anything that follows it! *)

defineinfix "minus_def" "-?x" "Minus,term:?x";
defineinfix "plus_def" "?x+?y" "Plus,(term:?x),term:?y";


(* tactic for showing that differently tagged terms are different *)

(*

DIFFERENT_TAGS @ ?different:  

(?x , ?y) = ?z , ?w  =  

CASEINTRO <= ((?x , ?y) = ?z , ?w) || (?different 
      => ?x = ?z) , false

EQUATION , REFLEX , 0

*)

s "(?x,?y)=(?z,?w)";
ri "EQUATION"; ex();
right(); left(); ri "(!$REFLEX)@P1@?x,?y"; ex();
right(); right(); ri "0|-|1"; ex();
up(); up(); ri "RL@P1"; ex();
ri "?different";
top(); rri "CASEINTRO";
prove "DIFFERENT_TAGS@?different";

(*

VARNOTMINUS:  

~ (variable : ?x) = Minus , term : ?y  =  

true

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , MinusnotPrime , NONTRIV , NOT1 , ODDCHOICE 
, OR , PRIMETYPE , REFLEX , TYPES , VARIABLE_CLOSURE 
, VnotMinus , forall , 0


*)

start "~(variable:?x)=Minus,term:?y";
ri "BIND@?x"; ex();
left(); left(); ri "BIND@variable:?1"; ex();
up(); ri "PCASEINTRO@[[~?2 = Minus , term : ?y] @ variable : ?1] = [true]"; 
	ex();
right(); left(); ri "0|-|1"; ex();
up(); up(); left(); rri "forall"; ex();
ri "VARIABLE_CLOSURE"; ex();
ri "EVERYWHERE2@EVAL"; ex();
left(); ri "RIGHT@DIFFERENT_TAGS@VnotMinus"; ri "NEGF"; ex();
up(); right(); right(); right(); right(); right(); ri "LEFT@ $PRIMETYPE"; ex();
ri "DIFFERENT_TAGS@EQSYMM**MinusnotPrime"; ex();
up(); ri "NEGF"; ex();
up(); ri "IRZER"; ex();
up(); up(); ri "FORALLDROP**AT"; ex();
up(); ri "CID**AT"; up(); ex();
up(); ri "EVAL"; ex();
prove "VARNOTMINUS";

(*

VARNOTPLUS:  

~ (variable : ?x) = Plus , (term : ?y) , term : ?z  =  

true

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , NONTRIV , NOT1 , ODDCHOICE , OR , PRIMETYPE 
, PlusnotPrime , REFLEX , TYPES , VARIABLE_CLOSURE 
, VnotPlus , forall , 0

*)

start "~(variable:?x)=Plus,(term:?y),term:?z";
ri "BIND@?x"; ex();
left(); left(); ri "BIND@variable:?1"; ex();
up();ri "PCASEINTRO@[[~ ?2 = Plus , (term : ?y) , term : ?z] @ variable: ?1]=[true]";
	 ex();
right(); left(); ri "0|-|1"; ex();
up(); up(); left(); rri "forall"; ex();
ri "VARIABLE_CLOSURE"; ex();
ri "EVERYWHERE2@EVAL"; ex();
left(); ri "(RIGHT@DIFFERENT_TAGS@VnotPlus)**NEGF"; ex();
up(); drrs "PRIMETYPE"; rri "PRIMETYPE"; ex();
up();up();ri "(RIGHT@DIFFERENT_TAGS@EQSYMM**PlusnotPrime)**NEGF"; ex();
up(); ri "IRZER"; ex();
up(); up(); ri "FORALLDROP**AT"; ex();
up(); ri "CID**AT"; up(); ex();
up(); ri "EVAL"; ex();
prove "VARNOTPLUS";

quit();

