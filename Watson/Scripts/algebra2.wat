(* expanded July 2, 1999.

There is an extended comment at the end containing a demonstration of
theorem export.  If you have run the current version of the script
peano.wat (i.e., the file peano.sav.wat needs to exist) then you can
uncomment this block and the theorems on complete induction, least
number principle, and method of descent will be imported from peano.

The view "test" defined in the export block will need to be extended
as more theorems are imported; for example, it contains no axioms
about multiplication.

The idea behind the view is that one needs theorems in algebra2
matching each axiom and each definition used in the proofs in peano.
Each defined notion used in peano must match a defined notion in
algebra2 with a precisely matching definition (this is the reason
that a new relation .<. was introduced, exactly analogous to the
relation < defined in peano); also, each scin or scout notion in
the source theory (peano here) must match a scin or scout notion
in the target theory whose scin/scout theorem matches precisely.

Notice that the primitive addition + in peano (which is addition
of natural numbers) translates to a new defined notion .+. in algebra2
(where our + is addition of reals and so cannot be the same as peano's
+).  The operation .-. of natural number subtraction was already
available, and is used to translate the primitive - in peano.
Extension of the view will cause us to introduce an operation .*.
of natural number multiplication, but we have not needed this yet.

Development of the view involved proving new theorems in algebra2
which translate the axioms of peano; these are found just before
the extended comment.

If one does not know the definition, scin or scout theorems,
one can use the functions definitionof, scinleftof (not scinof!)
and scoutof (which take string arguments) to get the names of the
theorems.

for example, definitionof "&" = "AND".

The exportthm command sends error messages which can often tell
you in detail what changes in a view you need to make it work.

*)

(* posted as new algebra2.wat, March 19, 1999 *)

(* file for computational work, aiming at fraction computations
started March 10, 1999 *)

(* idea: use this (hopefully better organized) file to rebuild
naturals.wat *)

(* 

a conceptual point about this file (which now subsumes old naturals,
algebra2, realorder:  this is not a theory of Peano arithmetic but a theory
of the type of natural numbers for which the prover supports built-in
computations as embedded in the type of reals (or of rationals; there's
nothing in the file which isn't true in the rationals, so far.

It's a theory of elementary computational mathematics.  I hope to
continue it with standard algorithms for computations with fractions,
among other related topics.

*)

script "structural";
script "typestuff";
script "new.quantifiers";

(* the type of natural numbers for which Watson supports
built in computation, to be identified with the Peano natural numbers
as embedded in the reals or rationals *)

declareconstant "Nat";

axiom "COMP_NAT" "Nat:?x" "?x+!0";

(* COMP_NAT_2 strips the type label from numerals and
leaves other terms unaffected *)

s "?x";
ri "COMP_NAT";
rri "COMP_NAT";
p "COMP_NAT_2";

(* tactic for attaching Nat type label to numerals *)

(*

MAKE_NAT_1:  

?x  =  

(REFLEX => ?x = ?x +! 0) || (Nat : ?x) , ?x

CASEINTRO , COMP_NAT , 0

*)

s "?x";
ri "PCASEINTRO@?x=?x+!0"; ex();
right(); left(); ri "0|-|1"; rri "COMP_NAT"; ex();
top(); left(); ri "REFLEX";
p "MAKE_NAT_1";

(* remove garbage if MAKE_NAT_1 fails *)

(*

MAKE_NAT_2:  

(?x = ?x +! 0) || (Nat : ?x) , ?x  =  

?x

CASEINTRO , COMP_NAT , 0

*)

s "(?x=?x+!0)||(Nat:?x),?x";
right();left();ri "COMP_NAT";rri "0|-|1";ex();
top(); rri "CASEINTRO"; ex();
p "MAKE_NAT_2";

(* complete tactic *)

(*

MAKE_NAT:  

?x  =  

MAKE_NAT_2 => MAKE_NAT_1 => ?x

0

*)

s "?x";
ri "MAKE_NAT_1"; ri "MAKE_NAT_2"; 
p "MAKE_NAT";

(* type axioms for builtin operations *)
(* note that the defined type Bool from new_typestuff is used *)

axiom "COMPPLUSTYPE" "?x+!?y" "Nat:(Nat:?x)+!Nat:?y";
axiom "COMPMINUSTYPE" "?x-!?y" "Nat:(Nat:?x)-!Nat:?y";
axiom "COMPTIMESTYPE" "?x*!?y" "Nat:(Nat:?x)*!Nat:?y";
axiom "COMPDIVTYPE" "?x/!?y" "Nat:(Nat:?x)/!Nat:?y";
axiom "COMPMODTYPE" "?x%!?y" "Nat:(Nat:?x)%!Nat:?y";
axiom "COMPEQTYPE" "?x=!?y" "Bool:(Nat:?x)=!Nat:?y";
axiom "COMPLESSTYPE" "?x<!?y" "Bool:(Nat:?x)<!Nat:?y";

declareinfix "+";

axiom "COMP_PLUS" "(Nat:?x)+Nat:?y" "?x+!?y";

declareinfix "-";
declareprefix "-" "0";

axiom "COMP_MINUS" "(Nat:?x)-Nat:?y" "(0=!(?y-!?x))||(?x-!?y), -?y-!?x";

declareinfix "*";

axiom "COMP_TIMES" "(Nat:?x)*Nat:?y" "?x*!?y";

declareinfix "/";

axiom "COMP_DIV" "(Nat:?x)/Nat:?y" "(?x/!?y)+(?x%!?y)/Nat:?y";

(* the general type of reals (nothing in this file precludes the
type of rationals, so far *)

declareconstant "Real";

(* axioms of addition/subtraction *)

axiom "PLUSTYPE" "?x+?y" "Real:(Real:?x)+Real:?y";
axiom "MINUSTYPE" "?x-?y" "Real:(Real:?x)-Real:?y";
axiom "PLUSCOMM" "?x+?y" "?y+?x";
axiom "PLUSASSOC" "(?x+?y)+?z" "?x+?y+?z";
axiom "PLUSID" "0+?x" "Real:?x";
axiom "PM" "?x+?y-?x" "Real:?y";

(* form of axiom from naturals *)

s "(?x-?y)+?y";
ri "PLUSCOMM"; ri "PM"; ex();
p "PLUSMINUS";

(* axioms of multiplication/division *)

axiom "TIMESTYPE" "?x*?y" "Real:(Real:?x)*Real:?y";
axiom "DIVTYPE" "?x/?y" "Real:(Real:?x)/Real:?y";
axiom "TIMESCOMM" "?x*?y" "?y*?x";
axiom "TIMESASSOC" "(?x*?y)*?z" "?x*?y*?z";
axiom "TIMESID" "1*?x" "Real:?x";
axiom "TD" "?x*?y/?x" "(0=Real:?x)||0,Real:?y";

(* this is the old form of the axiom in naturals;
the new axiom seems syntactically prettier *)

s "(?x/?y)*?y";
ri "TIMESCOMM";ex();
ri "TD"; ex();
p "TIMESDIV";

(* distributive law *)

axiom "DIST" "?x*?y+?z" "(?x*?y)+?x*?z";

(* axioms of order (for reals) using absolute value function *)
(* agenda: use this axiomatization to reconstruct realorder *)

declareconstant "Absolute";  (* type of non-negative reals *)

axiom "PLUS_POS" "(Absolute:?x)+Absolute:?y" 
	"Absolute:(Absolute:?x)+Absolute:?y";
axiom "TIMES_POS" "(Absolute:?x)*Absolute:?y" 
	"Absolute:(Absolute:?x)*Absolute:?y";
axiom "ABSOLUTE" "Absolute:?x" 
	"((Real:?x)=Absolute:Real:?x)||(Real:?x), -Real:?x";
axiom "ABSOLUTE2" "Absolute: -?x" "Absolute:?x";

(* this should be simplified! *)

defineinfix "LESS" "?x<?y" "~(?x-?y)=Absolute:?x-?y";

axiom "LESS_COMP" "(Nat:?x)<Nat:?y" "?x<!?y";

ae "LESS_COMP";
p "LESSCOMP";

axiom "EQ_COMP" "(Nat:?x)=Nat:?y" "?x=!?y";

(* reconstruction of naturals.wat *)

s "0+!?x";
rri "COMP_PLUS"; ex();
ri "PLUSCOMM"; ex();
ri "COMP_PLUS"; ex();
rri "COMP_NAT"; ex();
p "BUILTIN";

s "1";
ri "MAKE_NAT"; ex();
p "ONENAT";

s "0";
ri "MAKE_NAT"; ex();
p "ZERONAT";

s "(Nat:?x)+Nat:?y";
ri "COMP_PLUS"; ex();
ri "COMPPLUSTYPE"; ex();
rri "TYPES"; ex();
right(); rri "COMPPLUSTYPE"; rri "COMP_PLUS"; ex();
p "PLUSTYPE2";

ae "COMP_PLUS";
p "PLUSCOMP";

ae "PLUSTYPE";
ri "TREMTOP@PLUSTYPE"; ex();
p "PLUSSCIN";
makescin "+" "PLUSSCIN";

s "(Nat:?x)-Nat:?y";

ae "MINUSTYPE";
ri "TREMTOP@MINUSTYPE"; ex();
p "MINUSSCIN"; 
makescin "-" "MINUSSCIN";

s "Nat:?x";
rri "BUILTIN";ex();
rri "PLUSCOMP"; ex();
ri "PLUSTYPE"; ex();
saveenv "SubtypeLemma";
rri "TYPES"; ex();
right(); applyconvenv "SubtypeLemma";
saveenv "scratch";
dropenv "SubtypeLemma";
p "REALNAT";

s "(Nat:?x)*Nat:?y";
ri "COMP_TIMES"; ex();
ri "COMPTIMESTYPE"; ex();
rri "TYPES"; ex();
right(); rri "COMPTIMESTYPE"; rri "COMP_TIMES"; ex();
p "TIMESTYPE2";

ae "COMP_TIMES";
p "TIMESCOMP";

s "?x*?y";
ri  "TIMESTYPE"; ex();
right(); left();
rri "TYPES"; ex();
up();right();rri "TYPES"; ex();
top();rri "TIMESTYPE"; ex();
p "TIMESSCIN"; makescin "*" "TIMESSCIN";

(* I abandon the use of / for integer division *)

defineinfix "INT_DIV" "?x./.?y" "?x/!?y";

s "Nat:(Nat:?x)./.Nat:?y";
ri "EVERYWHERE@INT_DIV"; ex();
rri "COMPDIVTYPE"; ex();
rri "INT_DIV"; ex();
wb();
p "INT_DIVTYPE";

ae "INT_DIVTYPE";
ri "TREMTOP@INT_DIVTYPE";ex();
p "INT_DIVSCIN";

makescin "./." "INT_DIVSCIN";

defineinfix "MOD_DEF" "?x%?y" "?x%!?y";

ae "MOD_DEF";
p "MODCOMP";

s "Nat:(Nat:?x)%Nat:?y";
ri "EVERYWHERE@MODCOMP"; ex();
rri "COMPMODTYPE"; ex();
rri "MODCOMP"; ex();
wb();
p "MODTYPE";

ae "MODTYPE";
ri "TREMTOP@MODTYPE";ex();
p "MODSCIN";

makescin "%" "MODSCIN";

s "(Real:?x)<Real:?y";
ri "LESS"; ex();
ri "EVERYWHERE2@TREMBOTH@MINUSTYPE"; ex();
rri "LESS"; ex();
wb();
p "LESSTYPE";

ae "EQ_COMP";
wb();
p "EVALEQ";

(*

ZERONOTONE:

0 = 1 = 

false

*)

s "0=1";
ri "(LEFT@ZERONAT)**RIGHT@ONENAT";
rri "EVALEQ"; ex();
p "ZERONOTONE";

(* remember that / is now real division *)

ae "DIVTYPE";
ri "TREMTOP@DIVTYPE"; ex();
p "DIVSCIN"; 
makescin "/" "DIVSCIN";

ae "MAKE_NAT";
p "NATCALC";

(* algebra axioms are the same with the following exception
(and TIMESDIV dealt with above) *)

(* It ought to be possible to prove this as a theorem! *)

axiom "TIMESINTDIV" "(?x%?y)+(?x./.?y)*Nat:?y" "Nat:?x";

(* some basic algebra theorems *)

(*

REALZERO:

0 = 

Real : 0

["BUILTIN","CASEINTRO","PLUSCOMP","PLUSTYPE","REFLEX","TYPES"]

*)

s "0";
ri "NATCALC"; ri "REALNAT"; ri "RIGHT@ $BUILTIN"; ex();
p "REALZERO";

(*

COMMPLUSID:

?x + 0 = 

Real : ?x

["PLUSCOMM","PLUSID"]

*)

s "?x+0";
ri "PLUSCOMM"; ri "PLUSID"; ex();
p "COMMPLUSID";

(*

EPLUSID:

?x + ?y = 

COMMPLUSID =>> PLUSID => ?x + ?y

["PLUSCOMM","PLUSID"]

*)

s "?x+?y";
ri "PLUSID"; ari "COMMPLUSID";
p "EPLUSID";

(*

COMMDIST:

(?x + ?y) * ?z = 

(?x * ?z) + ?y * ?z

*)

s "(?x+?y)*?z";
ri "TIMESCOMM"; ri "DIST"; ex();
ri "RL@TIMESCOMM"; ex();
p "COMMDIST";


(*

TIMESZERO:

0 * ?x = 

0

["BUILTIN","CASEINTRO","DIST","PLUSASSOC","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TIMESCOMM","TIMESTYPE","TYPES"]

*)

initializecounter();
s "0";
ri "REALZERO"; ex();
rri "PLUSMINUS";ex();
assign "?y_2" "0*?x";
right();left();
ri "REALZERO";
rri "PLUSID"; ex();
up();
ri "COMMDIST"; ex();
top();
rri "PLUSASSOC"; ex();
ri "LEFT@PLUSMINUS"; ex();
ri "LEFT@ $REALZERO";ex();
ri "PLUSID"; ex();
ri "TREMTOP@TIMESTYPE"; ex();
workback();
p "TIMESZERO";


(*

FACTORZERO:

0 = ?y * ?z = 

(0 = Real : ?y) | 0 = Real : ?z

["AND","BUILTIN","CASEINTRO","DIST","EQUATION","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REALDIVTYPE","REFLEX","TIMESASSOC","TIMESCOMM","TIMESDIV","TIMESTYPE","TYPES"]

*)

initializecounter();
s "0=?y*?z";
ri "CASEINTRO";ex();
assign "?y_1" "0=Real:?y";
right();left();right();
ri "TADDBOTH@TIMESTYPE"; ex();
left();
rri "0|-|1"; ex();
up(); 
ri "TIMESZERO"; ex();
up();
ri "REFLEX"; ex();
up();right();
ri "CASEINTRO"; ex();
assign "?y_21" "0=Real:?z";
right();left();right();
ri "TADDRIGHT@TIMESTYPE"; ex();
right();
rri "0|-|2"; ex();
up(); 
ri "TIMESCOMM"; ri "TIMESZERO"; ex();
up();
ri "REFLEX"; ex();
up();right();
ri "EQUATION"; ex();
right();left();  (* always work in the impossible case! *)
rri "REFLEX"; ex();
assign "?a_38" "(((?y/?y)/?z)*?z)*?y";
left(); 
ri "TIMESASSOC"; ex(); right(); ri "TIMESCOMM"; ex();
rri "0|-|3"; ex();up();
ri "TIMESCOMM**TIMESZERO";ex();
up();right();left();
ri "TIMESDIV"; ex();
ri "1|-|2"; ex();
ri "TREMTOP@DIVTYPE"; ex();
up();
ri "TIMESDIV"; ex();
ri "1|-|1"; ex();
up();
ri "EQUATION**1|-|1"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); rri "ALTORDEF"; ex();
p "FACTORZERO";

(* Peano axioms *)

axiom "SUCCNOTZERO" "0=1+Nat:?x" "false";
axiom "SAMESUCC" "(Nat:?x)=(Nat:?y)" "(1+Nat:?x)=(1+Nat:?y)";
axiom "INDUCTION" "forall@[?P@Nat:?1]" 
	"(?P@0)&forall@[(?P@Nat:?1)->(?P@1+Nat:?1)]";

(* develop induction tactic *)

s "forall@[?P@?1]";
right();right();
ri "BIND@Nat:?1";
p "INDUCT_TAC_1";

s "forall@[?P@Nat:?1]";
ri "INDUCTION"; ex();
left();
ri "EVAL";
up();right();
right();right();
left();ri "EVAL";
up();right();ri "EVAL";
p "INDUCT_TAC_2";

s "forall@[?P@?1]";
ri "INDUCT_TAC_1";
ri "INDUCT_TAC_2";
p "INDUCT_TAC";

(* define the notions "even" and "odd" *)

defineconstant "even@?x" "forsome@[(Nat:?x)=(Nat:?1)+(Nat:?1)]";
defineconstant "odd@?x" "forsome@[(Nat:?x)=1+(Nat:?1)+(Nat:?1)]";

(* "axioms" for greatest common denominator *)

declareconstant "gcd";
axiom "GCD1" "gcd @ ?a,0" "Nat:?a";
axiom "GCD2" "gcd @ ?a,?b"  "gcd @?b,?a%?b";
axiom "GCDTYPE" "gcd @ ?a,?b" "gcd@(Nat:?a),Nat:?b";

(*

EQEVAL2:

(Nat : ?a) = 0 = 

?a =! 0

["BUILTIN","EVALEQ"]

*)

s "Nat:0"; rri "BUILTIN"; ex(); saveenv "ZeroLemma";
s "(Nat:?a)=0"; right(); applyconvenv "ZeroLemma"; top(); rri "EVALEQ"; ex();
p "EQEVAL2"; dropenv "ZeroLemma";

(* algorithm for computing GCD's *)

initializecounter();

s "gcd@?a,?b";
ri "GCDTYPE"; ex();
ri "CASEINTRO"; ex();
assign "?y_2" "(Nat:?b)=0";
right();left();right();right();
ri "0|-|1"; ex();
up();up();
ri "GCD1"; ri "TYPES"; rri "BUILTIN"; ri "BUILTIN";
up();right();
rri "GCDTYPE"; ex(); ri "GCD2";ex();
dpt "GCD"; ri "GCD"; right();right();right();ri "MODCOMP"; up();up();up();
top();left();ri "EQEVAL2";
p "GCD";

ae "MAKE_NAT";
p "TYPENUMERAL";

(*

REALNUMERAL:

?n = 

(RIGHT @  $BUILTIN) => REALNAT => TYPENUMERAL 
=> ?n

["BUILTIN","CASEINTRO","PLUSCOMP","PLUSTYPE","REFLEX","TYPES"]

*)

s "?n";
ri "TYPENUMERAL";
ri "REALNAT";
ri "RIGHT@ $BUILTIN";
p "REALNUMERAL";

(*

REALNUMERAL2:

Real : ?n = 

BUILTIN <= REALNAT <= (RIGHT @ TYPENUMERAL) 
=> Real : ?n

["BUILTIN","CASEINTRO","PLUSCOMP","PLUSTYPE","REFLEX","TYPES"]

*)

s "Real:?n";
ri "RIGHT@TYPENUMERAL";
rri "REALNAT";
rri "BUILTIN";
p "REALNUMERAL2";

(* a new GCD tactic from Parvin *)

dpt "FINDGCD";
s "gcd @ ?a,?b";
ri "GCD1";ari "GCD2**(RIGHT@RIGHT@MODCOMP)**FINDGCD";
p "FINDGCD";

(* definition of "less than"; beginning of theory of order
on naturals found in natorder *)

axiom "LESS1" "(Nat:?x) < Nat:?y" "forsome @ [ (forall @ [(?1@1+Nat:?2) -> ?1@Nat:?2]) & (?1@Nat:?x) & ~(?1@Nat:?y)]";


(* definition of natural number subtraction *)

defineinfix "NAT__SUB" "?x.-.?y" "((Nat:?x)<Nat:?y)||0,(Nat:?x)-Nat:?y";

(* this should be provable as a theorem *)

axiom "NATMINUSCOMP" "(Nat:?x).-.(Nat:?y)" "?x-!?y";

s "?x.-.?y";
ri "NAT__SUB"; ex();
ri "EVERYWHERE2@ $TYPES"; ex();
top(); rri "NAT__SUB"; ex();
ri "NATMINUSCOMP"; ex();
ri "TADDTOP@COMPMINUSTYPE"; ex();
ri "RIGHT@ $NATMINUSCOMP"; ex();
p "NATMINUSTYPE";

s "?x.-.?y";
ri "TADDTOP@NATMINUSTYPE"; ex();
ri "RIGHT@NAT__SUB"; ex();

s "?x.-.?y";
ri "TADDTOP@NATMINUSTYPE"; ex();
ri "RIGHT@NAT__SUB"; ex();
ri "UNEVAL_TAC@[Nat:?1]"; ex();
ri "EVERYWHERE@ $ZERONAT"; ex();
p "NAT_SUB";


s "(Nat:?x).-.Nat:?y";
ri "NAT_SUB"; ex();
ri "EVERYWHERE2@TYPES"; ex();
rri "NAT_SUB"; ex();
wb();
p "NATMINUSSCIN";
makescin ".-." "NATMINUSSCIN";

(* s "Nat:(Nat:?x).-.(Nat:?y)";
ri "RIGHT@NAT_SUB"; ex();
ri "EVERYWHERE2@TYPES"; ex();
ri "PCASEINTRO@((Nat : ?x) < Nat : ?y)";ex();
right(); left(); ri "RIGHT@1|-|1"; ex();
up(); right(); ri "RIGHT@1|-|1"; ex();
ri "TYPES"; ex();
up(); left(); rri "ZERONAT"; ex();
top(); rri "NAT_SUB"; ex();
wb();
p "NATMINUSTYPE"; *)

(* The old version of NAT_SUB *)

(*  commented out; NAT__SUB is the definition again

s "((Nat:?x)<Nat:?y)||0,(Nat:?x)-Nat:?y";
drls "MINUSCOMP"; ri "MINUSCOMP"; ex();
ri "LEFT@ $LESSCOMP"; ri "1|-|1"; ex();
rri "NATMINUSCOMP"; ri "NAT_SUB"; ex();
ri "EVERYWHERE2@TYPES"; ri "1|-|1"; ex();
top(); rri "NAT_SUB"; ex();
wb();
p "NAT__SUB";

*)

defineconstant "Pred@?x" "?x.-.1";
s "Pred@?x";
ri "Pred"; ex();
ri "NATMINUSSCIN"; ri "RIGHT@ $ONENAT"; rri "Pred"; ex();
p "PREDSCIN";
makescin "Pred" "PREDSCIN";

s "Pred@?x";
ri "PREDSCIN"; ex();
ri "Pred"; ex();
ri "TADDTOP@NATMINUSTYPE"; ex();
ri "RIGHT@ $Pred"; ex();
p "PREDTYPE";

(* end of material from naturals *)

(* reconstruction of realorder *)

(* this will need to be pulled out of algebra2 if it is left here *)

(*

SIGNPULL:

?x * -?y = 

-?x * ?y

["BUILTIN","CASEINTRO","DIST","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TIMESCOMM","TIMESTYPE","TYPES"]

*)

s "?x* -?y";
ri "TADDTOP@TIMESTYPE"; ex();
rri "PLUSID"; ex();
left();
initializecounter();
ri "REALZERO";
rri "PLUSMINUS"; ex();
assign "?y_2" "?x*?y";
top();
ri "PLUSASSOC"; ex();
right();
rri "DIST"; ex();
right();
ri "PLUSCOMM**PLUSMINUS** $REALZERO"; ex();
up();
ri "TIMESCOMM**TIMESZERO"; ex();
up();
ri "COMMPLUSID**TREMTOP@MINUSTYPE"; ex();
prove "SIGNPULL";

(*

BREAKMINUS:

?x - ?y = 

?x +  -?y

["BUILTIN","CASEINTRO","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]


*)

initializecounter();
s "?x-?y";
ri "MINUSTYPE"; ex();
rri "PLUSID"; ex();
left();
ri "REALZERO"; ex();
rri "PLUSMINUS"; ex();
assign "?y_4" "?y";
up();
ri "PLUSASSOC"; ex();
right();
ri "PLUSCOMM"; ex();
ri "PLUSTYPE"; ex();
ri "EVERYWHERE@ $MINUSTYPE"; ex();
right();
ri "PLUSTYPE**(EVERYWHERE@TYPES)** $PLUSTYPE";ex();
ri "PLUSMINUS"; ex();
up();
ri "TYPES"; ex();
up();
ri "PLUSTYPE**(EVERYWHERE@TYPES)** $PLUSTYPE";ex();
ri "PLUSCOMM"; ex();
p "BREAKMINUS";

(*

MINUSPLUS:

(?x + ?y) - ?y = 

Real : ?x

["BUILTIN","CASEINTRO","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]

*)

s "(?x+?y)-?y";
ri "BREAKMINUS"; ex();
ri "PLUSASSOC"; ex();
right();
ri "PLUSCOMM**PLUSMINUS** $REALZERO"; ex();
up();
ri "COMMPLUSID"; ex();
p "MINUSPLUS";

(* a sublemma *)


(*

ADD_CANCEL:

(?z + ?x) = ?z + ?y = 

(Real : ?x) = Real : ?y


*)
initializecounter();
s "(?z+?x)=(?z+?y)";
ri "PCASEINTRO@(Real:?x)=Real:?y";ex();
right();left();
ri "RL@PLUSTYPE";
ri "EVERYWHERE@0|-|1"; ex();
ri "REFLEX"; ex();
up();right();
ri "EQUATION"; ex();
right();left();
ri "PCASEINTRO@((?z+?x) + -?z) = (?z+?y) + -?z"; ex();
right();left();
rri "1|-|3"; ex();
left();
ri "RL@PLUSCOMM**($PLUSASSOC)**(LEFT@PLUSMINUS** $ REALZERO)**PLUSID";ex();
ri "EQUATION**1|-|1"; ex();
up();ex();
up();up();left();
ri "EVERYWHERE@0|-|2"; ex();
up();
ri "LEFT@REFLEX"; ex();
assign "?x_36" "false";
up();up();
rri "CASEINTRO"; ex();
up();up();
rri "EQUATION"; ex();
p "ADD_CANCEL";


(*

SUBTRACT_SUM:

?x - ?y + ?z = 

(?x - ?y) - ?z

["BUILTIN","CASEINTRO","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]

*)

initializecounter();
s "?x-?y+?z";
ri "MINUSTYPE"; ex();
rri "PLUSID"; ex();
right();
ri "TADDTOP@MINUSTYPE"; ex();
rri "MINUSTYPE"; ex();
ri "BREAKMINUS"; ex();
ri "PLUSCOMM"; ex();
top();
rri "PLUSASSOC"; ex();
left();left();
ri "REALNUMERAL"; ex();
rri "PLUSID";
ri "RL@REALNUMERAL** $PLUSMINUS"; ex();
assign "?y_40" "?y"; assign "?y_53" "?z";
ri "PLUSASSOC";ex(); right();
rri "PLUSASSOC"; ri "LEFT@PLUSCOMM"; ex();
ri "PLUSASSOC"; ex();
up();
rri "PLUSASSOC"; ex();
up();
ri "PLUSASSOC"; ex(); right();
ri "PLUSCOMM**PLUSMINUS";ex();
ri "REALNUMERAL2"; ex();
up();
ri "COMMPLUSID"; ex();
ri "TREMTOP@PLUSTYPE"; ex();
up();
ri "PLUSCOMM** $PLUSASSOC"; ex();
ri "(LEFT@ $BREAKMINUS)** $BREAKMINUS"; ex();
p "SUBTRACT_SUM";

s "-?x+?y";
ri "SUBTRACT_SUM"; ex();
ri "BREAKMINUS"; ex();
p "PLUSINVDIST";

dpt "PLUSINVDISTS";
s "-?x+?y";
ri "PLUSINVDIST"; ex();
right();ri "PLUSINVDISTS";
up();left();ri "PLUSINVDISTS";
p "PLUSINVDISTS";

(*

MINUSMINUS:

 - -?x = 

Real : ?x

["BUILTIN","CASEINTRO","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]

*)

initializecounter();
s "- -?x";
ri "MINUSTYPE"; ex();
rri "PLUSID"; ex();
ri "RIGHT@(TADDTOP@MINUSTYPE)** $MINUSTYPE"; ex();
left();
ri "REALNUMERAL";
rri "PLUSMINUS";ex();
assign "?y_27" "?x";
ri "PLUSCOMM"; ex();
top();
ri "PLUSASSOC"; ex();
right();
ri "PLUSCOMM**PLUSMINUS**REALNUMERAL2"; ex();
up();
ri "COMMPLUSID"; ex();
p "MINUSMINUS";

s "-0";
ri "BREAKMINUS**PLUSCOMM**PLUSMINUS"; ex();
ri "REALNUMERAL2"; ex();
p "MINUSZERO";

(*

SUBTRACT_DIFF:

?x - ?y - ?z = 

?x + ( -?y) + ?z

["BUILTIN","CASEINTRO","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]

*)

s "?x-(?y-?z)";
ri "BREAKMINUS"; ex();
right();right();
ri "BREAKMINUS"; ex();
up();
ri "PLUSINVDIST"; ex();
ri "RIGHT@MINUSMINUS"; ex();
ri "TREMRIGHT@PLUSTYPE"; ex();
p "SUBTRACT_DIFF";

(* there is an important fact about this proof:  the built in arithmetic
is used to determine that the field we are in is not of characteristic
2 (in which case the absolute value function could be the identity);
the fact that 2 is not equal to 0 is computed via the arithmetic functions *)

(*

ZEROSELFINV:  

(Real : ?x) = - ?x  =  

0 = Real : ?x

CASEINTRO , COMP_NAT , COMP_PLUS , DIST , DIVTYPE 
, EQUATION , EQ_COMP , MINUSTYPE , NONTRIV , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX , TD 
, TIMESASSOC , TIMESCOMM , TIMESID , TIMESTYPE , TYPES 
, 0

*)

s "(Real:?x) = -?x";
ri "PCASEINTRO@0=Real:?x";ex();
right(); left();
ri "RIGHT@TADDRIGHT@MINUSTYPE"; ex();
ri "EVERYWHERE@ $0|-|1"; ex();
ri "(RIGHT@MINUSZERO)**REFLEX"; ex();
up(); right(); ri "RIGHT@TADDTOP@MINUSTYPE"; ex();
ri "(!$ADD_CANCEL)@?x"; ex();
right(); ri "PM"; rri "REALZERO"; ex();
up(); left(); ri "TADDBOTH@PLUSTYPE"; ri "RL@ $TIMESID"; ex();
rri "COMMDIST"; ex();
ri "LEFT@(RL@MAKE_NAT)**COMP_PLUS"; ex();
up(); ri "EQSYMM"; ex();
ri "FACTORZERO"; ex();
ri "EVERYWHERE@MAKE_NAT** $REALNAT"; ex();
ri "LEFT@EQ_COMP"; ex();
ri "RIGHT@LEFT@COMP_NAT"; ex();
ri "RIGHT@EQUATION**1|-|1"; ex();
ri "OR**EVERYWHERE@NOT**AND"; ex();
top(); rri "EQUATION"; ex();
p "ZEROSELFINV";

defineconstant "Positive@?x" "(~(0=Real:?x))&(Real:?x)=Absolute:?x";

s "Absolute:Real:?x";
ri "ABSOLUTE"; ex();
ri "EVERYWHERE2@TYPES"; ex();
rri "ABSOLUTE"; ex();
p "ABSREAL";

s "Real:Absolute:?x";
ri "RIGHT@ABSOLUTE"; ex();
ri "UNEVAL@[Real:?1]"; ex();
ri "FNDIST"; ex();
ri "BOTH_CASES@EVAL"; ex();
ri "LEFT_CASE@TYPES"; ex();
ri "RIGHT_CASE@TREMTOP@MINUSTYPE"; ex();
rri "ABSOLUTE"; ex();
p "REALABS";

s "bool:Positive@Real:?x";
ri "EVERYWHERE@Positive"; ex();
ri "EVERYWHERE@TYPES"; ex();
rri "ANDBOOL"; ex();
rri "Positive"; ex();
dlls "ABSREAL"; ri "ABSREAL"; ex();
uptors "Positive"; rri "Positive"; ex();
wb();
p "POSTYPE";

(*

POSPLUS:  

(Positive @ ?x) & Positive @ ?y  =  

(Positive @ ?x + ?y) & (Positive @ ?x) & Positive 
      @ ?y

ABSOLUTE , ABSOLUTE2 , AND , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , MINUSTYPE , NONTRIV , NOT1 , ODDCHOICE 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PLUS_POS 
, PM , Positive , REFLEX , TD , TIMESASSOC , TIMESCOMM 
, TIMESID , TIMESTYPE , TYPES , 0

*)

(* we don't start with the left side of the eventual theorem;
workback will be used below *)

s "(Positive@?x)&(Positive@?y)&Positive@?x+?y";
ri "AND"; ex();
right(); left(); rri "BOOLDEF"; rri "ANDBOOL"; ex();
ri "AND"; ex();
right(); left(); rri "BOOLDEF"; ri "TREMTOP@POSTYPE"; ex();

(* goal is to convert the local context to "true" *)

ri "Positive"; ex();
ri "AND"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
left();rri "(2|-|1)@false"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left();
rri "(2|-|2)@false"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left();
ri "LEFT@REALZERO"; ex();
ri "(!$ADD_CANCEL)@ -?y"; ex();
ri "LEFT@COMMPLUSID"; ex();
ri "LEFT@TREMTOP@MINUSTYPE"; ex();
right(); ri "PLUSCOMM"; ex();
rri "BREAKMINUS"; ri "MINUSPLUS"; ex();
up(); ri "EQUATION"; ex();
right(); left(); rri "(2|-|7)@false"; ex();
left(); ri "LEFT@TADDRIGHT@MINUSTYPE"; ex();
ri "RIGHT@(0|-|4)"; ex();
ri "LEFT@RIGHT@(0|-|6)"; ex();
ri "RIGHT@ ($ABSREAL)**RIGHT@ $0|-|7"; ex();
ri "RIGHT@ABSOLUTE2"; ex();
ri "EQSYMM"; ex();
ri "LEFT@ $REALABS"; ex();
ri "ZEROSELFINV"; ex();
ri "EVERYWHERE@ $0|-|6"; ri "RIGHT@TYPES"; ri "EQUATION**1|-|5"; ex();
up(); ex();
up();up();rri "CASEINTRO"; ex();
up();up();rri "CASEINTRO"; ex();
up();up();rri "CASEINTRO"; ex();
up();up();rri "CASEINTRO"; ex();
up();up();rri "CASEINTRO"; ex();
up(); ex();
right();rri "(2|-|1)@true"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left();
rri "(2|-|2)@true"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left(); ri "EVERYWHERE@TADDBOTH@PLUSTYPE"; ex();
ri "LEFT@TADDBOTH@PLUSTYPE"; ex();
ri "EVERYWHERE@(0|-|4)**0|-|6"; ex();
left(); ri "PLUS_POS"; ex();
up(); ri "REFLEX"; ex();
upto "true=?x";
ri "RIGHT@EVERYWHERE@ $CASEINTRO"; ex();
ri "REFLEX"; ex();
top(); right(); left(); rri "BOOLDEF0"; ri "BOOLDEF"; ex();
top(); rri "AND"; ex();
wb(); rri "CASSOC"; ri "CSYM"; ex();
p "POSPLUS";  (* whew!!! *)

(*

POSTIMES:  

(Positive @ ?x) & Positive @ ?y  =  

(Positive @ ?x * ?y) & (Positive @ ?x) & Positive 
      @ ?y

ABSOLUTE , AND , BOOLDEF , CASEINTRO , COMP_NAT , COMP_PLUS 
, DIST , DIVTYPE , EQBOOL , EQUATION , FNDIST , NONTRIV 
, NOT1 , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , POINTTYPE , Positive , REFLEX , TD 
, TIMESASSOC , TIMESCOMM , TIMESTYPE , TIMES_POS , TYPES 
, 0

*)

s "(Positive@?x)&(Positive@?y)&Positive@?x*?y";
ri "AND"; ex();
right(); left(); rri "BOOLDEF"; rri "ANDBOOL"; ex();
ri "AND"; ex();
right(); left(); rri "BOOLDEF"; ri "TREMTOP@POSTYPE"; ex();
ri "Positive"; ex();
left(); right(); ri "RIGHT@TREMTOP@TIMESTYPE"; ex();
ri "FACTORZERO"; ex();
rri "(2|-|1)@false"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left();
rri "(2|-|2)@false"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left();
ri "(RL@EQUATION**(1|-|3)**(1|-|5))"; ex();
ri "DID"; ri "AF"; ex();
upto "~?x"; ri "RIGHT@EVERYWHERE@ $CASEINTRO"; ri "NEGF"; ex();
up(); right(); ri "LEFT@TREMTOP@TIMESTYPE"; ex();
ri "EVERYWHERE@TADDBOTH@TIMESTYPE"; ex();
rri "(2|-|1)@true"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left();
rri "(2|-|2)@true"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left();
ri "EVERYWHERE@(0|-|4)**0|-|6"; ex();
left(); ri "TIMES_POS"; ex();
up(); ri "REFLEX"; ex();
upto "true&?x"; ri "RIGHT@EVERYWHERE@ $CASEINTRO"; ex();
ri "CIDEM"; ri "AT"; ex();
upto "?x||?y,?z"; rri "BOOLDEF0"; ri "BOOLDEF"; ex();
top(); rri "AND"; ex();
wb(); rri "CASSOC"; ri "CSYM"; ex();
p "POSTIMES";

(* axiom "TRICHOTOMY" "(Positive@?x)|(Positive@ -?x)" "~0=Real:?x"; *)

(*

TRICHOTOMY:  

(Positive @ ?x) | Positive @ - ?x  =  

~ 0 = Real : ?x

ABSOLUTE , ABSOLUTE2 , AND , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , MINUSTYPE , NONTRIV , NOT1 , ODDCHOICE 
, OR , PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM 
, POINTTYPE , Positive , REFLEX , TD , TIMESASSOC 
, TIMESCOMM , TIMESID , TIMESTYPE , TYPES , 0

*)

s "(Positive@?x)|(Positive@ -?x)";
ri "RL@Positive"; ex();
right(); left(); ri "RIGHT @ $ ZEROSELFINV"; ex();
right(); ri "EQSYMM"; ex();
ri "RIGHT@TREMTOP@MINUSTYPE"; ex();
ri "LEFT@MINUSMINUS"; ex();
ri "ZEROSELFINV"; ex();
top(); rri "CDISD"; ex();
ri "EVERYWHERE@ABSOLUTE2"; ex();
right();ri "EVERYWHERE @ ABSOLUTE"; ex();
ri "PCASEINTRO@((Real : ?x) = Absolute : Real : ?x)"; ex();
ri "ALT_PUSH"; ex();
right(); left(); ri "LEFT@REFLEX"; ex();
ri "DSYM"; ri "DZER"; ex();
up(); right();right();
ri "(LEFT@TREMTOP@MINUSTYPE)**(RIGHT@TREMRIGHT@MINUSTYPE)**REFLEX"; ex();
up(); ri "DZER"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); ri "CID"; ri "NRULE1"; ex();
p "TRICHOTOMY";

(* axiom "REAL_LESS_DEF" "?x<?y" "Positive@?y-?x"; *)

(*

MINUSFLIP:  

- ?x - ?y  =  

?y - ?x

CASEINTRO , COMP_NAT , COMP_PLUS , MINUSTYPE , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX , TYPES 
, 0

*)

s "-?x-?y";
ri "SUBTRACT_DIFF"; ri "PLUSID"; ri "TREMTOP@PLUSTYPE";
	ri "PLUSCOMM"; rri "BREAKMINUS"; ex();
p "MINUSFLIP";



(*

DISTANCEFLIP:  

Absolute : ?x - ?y  =  

Absolute : ?y - ?x

ABSOLUTE , ABSOLUTE2 , CASEINTRO , COMP_NAT , COMP_PLUS 
, MINUSTYPE , PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE 
, PM , REFLEX , TYPES , 0

*)

s "Absolute:?x-?y";
rri "ABSREAL"; ex();
right(); rri "MINUSMINUS"; ex();
right(); ri "SUBTRACT_DIFF"; ri "PLUSID"; ri "TREMTOP@PLUSTYPE";
	ri "PLUSCOMM"; rri "BREAKMINUS"; ex();
top(); ri "ABSOLUTE2"; ex();
p "DISTANCEFLIP";

(*

REAL_LESS_DEF:  

?x < ?y  =  

Positive @ ?y - ?x

ABSOLUTE , ABSOLUTE2 , AND , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , LESS , MINUSTYPE , NONTRIV , NOT1 , ODDCHOICE 
, PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM , POINTTYPE 
, Positive , REFLEX , TD , TIMESASSOC , TIMESCOMM 
, TIMESID , TIMESTYPE , TYPES , 0

*)

s "?x<?y";
ri "LESS"; ex();
ri "PCASEINTRO@Positive@?y-?x"; ex();
ri "EVERYWHERE@DISTANCEFLIP"; ex();
right(); left(); ri "NOT"; ex();
right(); left(); rri "(2|-|1)@true"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); left(); rri "(2|-|3)@true"; ex();
left(); rri "ZEROSELFINV"; ex();
ri "LEFT@0|-|4"; ex();
ri "RIGHT@MINUSFLIP**0|-|2"; ex();
ri "REFLEX"; ex();
top(); right(); left(); ri "EVERYWHERE@ $CASEINTRO"; ex();
up(); right(); ri "NOT"; ex();
right(); right(); rri "(2|-|1)@false"; ex();
ri "(LEFT@Positive)**UNPACK"; ex();
ri "(LEFT@AND)**UNPACK"; ex();
ri "(LEFT@NOT)**UNPACK"; ex();
right(); right(); right(); right();
ri "(!$REFLEX)@Absolute:?y-?x";
ri "LEFT@ABSOLUTE"; ex();
ri "UNEVAL@[?1=(Absolute:?y-?x)]"; ri "FNDIST"; ri "BOTH_CASES@EVAL"; ex();
right(); left(); ri "EQUATION**1|-|4"; ex();
up(); right();left(); ri "TREMRIGHT@MINUSTYPE"; ri "MINUSFLIP"; ex();
up(); ri "EQUATION**1|-|2"; ex();
top(); right(); right(); ri "EVERYWHERE@ $CASEINTRO"; ex();
downtoright "true"; rri "(2|-|2)@false"; ex();
left(); ri "LEFT@ $MINUSFLIP"; ex();
ri "EVERYWHERE@TADDTOP@MINUSTYPE"; ex();
ri "EVERYWHERE@ $0|-|3"; ex();
ri "EVERYWHERE@MINUSZERO** $REALZERO"; ex();
ri "RIGHT@ABSOLUTE"; ex();ri "EVERYWHERE@MINUSZERO** $REALZERO"; ex();
ri "UNEVAL@[0=?1]"; ri "FNDIST"; ri "BOTH_CASES@EVAL"; ex();
top(); ri "EVERYWHERE2@REFLEX** $CASEINTRO"; ex();
ri "LEFT@POSTYPE"; ex();
rri "BOOLDEF0"; ex();
ri "TYPES** $POSTYPE"; ex();
p "REAL_LESS_DEF";

defineinfix "GREATER" "?x>?y" "?y<?x";

defineinfix "LESS_EQ_REAL" "?x=<?y" "((Real:?x)=(Real:?y))|?x<?y";

defineinfix "GREATER_EQ_REAL" "?x>=?y" "((Real:?x)=(Real:?y))|?x>?y";

defineinfix "NOT_EQ" "?x~=?y" "~?x=?y";

(*

ALT_POS_DEF:  

Positive @ ?x  =  

0 < ?x

ABSOLUTE , ABSOLUTE2 , AND , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , LESS , MINUSTYPE , NONTRIV , NOT1 , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , Positive , REFLEX 
, TD , TIMESASSOC , TIMESCOMM , TIMESID , TIMESTYPE 
, TYPES , 0

*)

s "Positive@?x";
ri "POSTYPE"; ex();
right();right();
initializecounter();
rri "PLUSMINUS"; ex();
assign "?y_1" "0";
ri "PLUSCOMM**PLUSID"; ex();
top();
rri "POSTYPE";
rri "REAL_LESS_DEF"; ex();
p "ALT_POS_DEF";

(*

POSASSERT:

Positive @ ?x = 

|-Positive @ ?x

["ASSERT","POSTYPE","TYPES"]

*)

s "Positive@?x";
ri "POSTYPE";
rri "TYPES";
ri "RIGHT@ $POSTYPE"; 
ri "ASSERT2";
ex();
prove "POSASSERT";


(*

ZERONOTPOS:

Positive @ 0 = 

false

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","POSTYPE","REFLEX","TRICHOTOMY","TYPES","XOR"]

*)

s "Positive@0";
ri "POSASSERT** $DIDEM"; ex();
right();right();
rri "MINUSZERO"; ex();
top();
ri "TRICHOTOMY"; ex();
right();right();
rri "REALZERO"; ex();
up();
ri "REFLEX"; ex();
up();
rri "FDEF";ex();
p "ZERONOTPOS";

(*

NOTBOTHPOS:

(Positive @ ?x) & Positive @ -?x = 

false

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","POSPLUS","POSTYPE","REFLEX","TRICHOTOMY","TYPES","XOR"]

*)

s "(Positive@?x)&Positive@ -?x";
ri "POSPLUS"; ex();
left();right();
ri "PLUSCOMM**PLUSMINUS"; ex();
up();
ri "POSTYPE**(EVERYWHERE@TYPES)** $POSTYPE"; ex();
ri "ZERONOTPOS"; ex();
up();
ri "CSYM**CZER"; ex();
p "NOTBOTHPOS";

(*

SQUARE_POS:  

(0 = Real : ?x) | Positive @ ?x * ?x  =  

true

ABSOLUTE , ABSOLUTE2 , AND , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , MINUSTYPE , NONTRIV , NOT1 , ODDCHOICE 
, OR , PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PM 
, Positive , REFLEX , TD , TIMESASSOC , TIMESCOMM 
, TIMESID , TIMESTYPE , TIMES_POS , TYPES , 0

*)

s "(0=Real:?x)|Positive@?x*?x";
ri "MAKE_CASE"; ex();
ri "OR_EXP"; ex();
rri "NOT_EXP"; ex();
left();
rri "TRICHOTOMY"; ex();
top();
ri "OR_EXP"; ex();
ri "EVERYWHERE2@ODDCHOICE"; ex();
downtoleft "false";
ri "FDEF"; ex();
right();
ri "($AT)** $CIDEM"; ex();
ri "RL@0|-|1"; ex();
ri "POSTIMES"; ex();
left();
ri "POSASSERT** $ASSERT_UNEXP"; ex();
ri "ODDCHOICE**1|-|2"; ex();
up();up();
ri "NEWTAUT"; ex();
up();up();up();
downtoright "false";
ri "FDEF"; ex();
right();
ri "($AT)** $CIDEM"; ex();
ri "RL@0|-|2"; ex();
ri "POSTIMES"; ex();
left();right();
ri "SIGNPULL**RIGHT@TIMESCOMM**SIGNPULL"; ex();
ri "MINUSMINUS"; ex();
up();
ri "POSTYPE**(EVERYWHERE@TYPES)** $POSTYPE"; ex();
ri "POSASSERT** $ASSERT_UNEXP"; ex();
ri "ODDCHOICE**1|-|3"; ex();
up();up();
ri "NEWTAUT"; ex();
top();
ri "EVERYWHERE@ $CASEINTRO"; ex();
prove "SQUARE_POS";

(*

POS_ONE:

Positive @ 1 = 

true

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","DIST","EQUATION","EVALEQ","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","POSTIMES","POSTYPE","REFLEX","TIMESCOMM","TIMESID","TIMESTYPE","TRICHOTOMY","TYPES","XOR"]

*)

s "Positive@1";
ri "POSTYPE"; ex();
ri "EVERYWHERE@ $TIMESID"; ex();
ri "ASSERT2"; ex();
ri "($DID)**DSYM"; ex();
left();
rri "ZERONOTONE"; ex();
right();
ri "ONENAT**REALNAT**RIGHT@ $BUILTIN"; ex();
top();
ri "SQUARE_POS"; ex();
p "POS_ONE"; 

(*

POS_ZERO:

Positive @ 0 = 

false

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","POSTYPE","REFLEX","TRICHOTOMY","TYPES","XOR"]

*)

s "Positive@0";
ri "POSASSERT"; ex();
rri "DIDEM"; ex();
right();right();
rri "MINUSZERO"; ex();
up();up();
ri "TRICHOTOMY"; ex();
right();left();
ri "REALZERO"; ex();
up();
ri "REFLEX"; ex();
top();
ri "NEWTAUT"; ex();
p "POS_ZERO";

(* time to insert developments from algebra2.wat *)

(*
ZEROORSUCC:

forall 
@ [(0 = Nat : ?1) | forsome 
   @ [(Nat : ?1) = 1 + Nat : ?2]] = 

true

["AND","ASSERT","BOOLDEF","CASEINTRO","CONVIF","EQBOOL","EQUATION","FNDIST","IF","IFF","INDUCTION","NONTRIV","NOT","ODDCHOICE","OR","PLUSTYPE","REFLEX","TYPES","XOR","forall","forsome"]



*)

s "forall@[(0=Nat:?1)| forsome@[(Nat:?1)=1+Nat:?2]]";
right(); right(); 
ri "BIND@Nat:?1";

top();
ri "INDUCTION"; ex();

left();
ri "EVAL"; ex();
ri "LEFT@REFLEX"; ex();
ri "DSYM"; ex();
ri "DZER"; ex();

up();right();

right();right();right();

ri "EVAL"; ex();

right();

ri "forsome"; ex();

right();

ri "forall"; ex();
ri "EQUATION"; ex();

right(); left();

ri "BIND@?1"; ex();
ri "LEFT@ $0|-|1"; ex();
ri "EVAL"; ex();
ri "RIGHT@REFLEX"; ex();
rri "FDEF"; ex();
up();up();
rri "CASEINTRO"; ex();
up();
ri "NEGF"; ex();
up();
ri "DZER"; ex();
up();
ri "IRZER"; ex();
up();up();
ri "forall**REFLEX"; ex();
up();
ri "CID"; ex();
ri "AT"; ex();

p "ZEROORSUCC";


(* an extended example of programming; a tactic ALL_CANCEL is
developed which is good (but not perfect) at cancellations. *)

(* it now appears to be perfect *)

s "?x+?y";
ri "GET@?z,PLUSCOMM,PLUSASSOC";
prove "GETPLUS@?z";

s "0 + -?x";
ri "PLUSID"; ex();
ri "(RIGHT@MINUSTYPE)**TYPES**($MINUSTYPE)"; ex();
p "FIXBREAKMINUS";

s "(-?x)+?x";
ri "PLUSMINUS**REALNUMERAL2"; ex();
prove "ALL_CANCEL_1";

s "?x+ -?x";
ri "PLUSCOMM**ALL_CANCEL_1"; ex();
prove "ALL_CANCEL_2";

s "?x + (-?x) + ?y";
rri "PLUSASSOC";ex();
ri "(LEFT@PLUSCOMM**PLUSMINUS**REALNUMERAL2)**PLUSID"; ex();
prove "ALL_CANCEL_3";

s "(-?x) + ?x + ?y";
rri "PLUSASSOC";
ri "(LEFT@PLUSMINUS**REALNUMERAL2)**PLUSID"; ex();
prove "ALL_CANCEL_4";

s "(-?x)+?y";
right();
ri "GETPLUS@?x";
top();
ri "ALL_CANCEL_1";
ari "ALL_CANCEL_4";
prove "ALL_CANCEL_5";

s "?x+?y";
right();
ri "GETPLUS@ -?x";
top();
ri "ALL_CANCEL_2";
ari "ALL_CANCEL_3";
prove "ALL_CANCEL_6";

dpt "ALL_CANCEL_7";
s "?x";
ri "ALLASSOCS@PLUSASSOC";
ri "RIGHT@ALL_CANCEL_7";
ri "TREMRIGHT@PLUSTYPE";
ri "ALL_CANCEL_6";
ri "ALL_CANCEL_5";
prove "ALL_CANCEL_7";

s "?x";
ri "EVERYWHERE@BREAKMINUS**FIXBREAKMINUS";
ri "EVERYWHERE@PLUSINVDISTS";
ri "TOPDOWN@MINUSMINUS";
ri "EVERYWHERE@TYPES";
ri "EVERYWHERE@TREMLEFT@PLUSTYPE";
ri "EVERYWHERE@TREMRIGHT@PLUSTYPE";
ri "ALL_CANCEL_7";
ri "TREMTOP@PLUSTYPE";  (* June 26 change in TREMTOP allows this *)
ri "TREMTOP@MINUSTYPE";
prove "ALL_CANCEL";

s "(?x-?y) + (?y-?z) + (?z-?u) + (?u-?v)";
ri "ALL_CANCEL"; ex();

s "(?x + ?y - ?z) - (?y - ?z - ?x) - ?x + ?y + ?z"; 
ri "ALL_CANCEL"; ex();

(* the proof of a theorem from above redone with use of GET *)

initializecounter();
s "-?y+?z";
ri "MINUSTYPE"; ex();
rri "PLUSID"; ex();
ri "RIGHT@(TADDTOP@MINUSTYPE)** $MINUSTYPE"; ex();
left();
ri "REALNUMERAL"; ex();
rri "PLUSID";ex();
ri "RL@REALNUMERAL** $PLUSMINUS"; ex();
assign "?y_41" "?y"; assign "?y_54" "?z";
top();
ri "GETPLUS@ -?y + ?z"; ex();
right();
ri "GETPLUS@?y"; ex();
right();
ri "GETPLUS@?z"; ex();
up();
rri "PLUSASSOC";
up();
rri "PLUSASSOC";
ri "LEFT@PLUSMINUS**REALNUMERAL2"; ex();
ri "PLUSID";
ri "TREMTOP@PLUSTYPE"; ex();

(* draft typing tactics *)

s "?x";
ri "PLUSTYPE";
ari "MINUSTYPE*>(RIGHT@LEFT@TYPES** $REALZERO)";
ari "REALNUMERAL";
prove "REAL_TYPE_1";

s "?x";
ri "EVERYWHERE@REAL_TYPE_1";
ri "EVERYWHERE@TYPES";
prove "REAL_TYPE";

s "?x";
ri "TREMTOP@PLUSTYPE";
ri "TREMTOP@MINUSTYPE";
ri "TREMBOTH@MINUSTYPE";
ri "TREMBOTH@PLUSTYPE";
ri "TYPES";
prove "REAL_UNTYPE_1";



s "?x";
ri "EVERYWHERE@REAL_UNTYPE_1"; 
prove "REAL_UNTYPE";

(* expansion algorithm *)

dpt "X";

s "?x+?y";
left();ri "X";
up();right(); ri "X";
top();
ri "ALLASSOCS@PLUSASSOC";
p "X1";

s "?x*?y";
left();ri "X";
up();right(); ri "X";
top();
ri "ALLASSOCS@TIMESASSOC";
ri "DIST";
ari "COMMDIST";
ri "X1";
p "X2";

s "?x";
ri "X1";
ari "X2";
p "X";

(* should create a term sorting algorithm, then aim for a pretty expansion
and collection algorithm *)

s "(Real:?m)=Real:?n";
initializecounter();
rri "ADD_CANCEL"; ex();
assign "?z_1" "-?n";
right(); ri "PLUSMINUS"; rri "REALZERO"; ex();
up();left(); ri "PLUSCOMM"; rri "BREAKMINUS"; ex();
p "EQUATION_TO_DIFFERENCE";


(*

REAL_LESS_TRANS:

(?x < ?y) & ?y < ?z = 

(?x < ?z) & (?x < ?y) & ?y < ?z

["BUILTIN","CASEINTRO","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","POSPLUS","REAL_LESS_DEF","REFLEX","TYPES"]

*)

s "(?x<?y)&?y<?z";
ri "RL@REAL_LESS_DEF";ex();
ri "POSPLUS"; ex();
left();right();
ri "ALL_CANCEL"; ex();
ri "PLUSCOMM"; ex();
rri "BREAKMINUS"; ex();
top();
ri "EVERYWHERE@ $REAL_LESS_DEF"; ex(); 
p "REAL_LESS_TRANS"; 

(*

REAL_LESS_CANCEL:

(?z + ?x) < ?z + ?y = 

?x < ?y

["BUILTIN","CASEINTRO","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REAL_LESS_DEF","REFLEX","TYPES"]

*)


s "(?z+?x)<?z+?y";
ri "REAL_LESS_DEF"; ex();
right();
ri "ALL_CANCEL"; ex();
rri "BREAKMINUS"; ex();
top();
rri "REAL_LESS_DEF"; ex();
p "REAL_LESS_CANCEL";

(*

POS_SIGN:

(0 ~= Real : ?x) & Positive @ - ?x = 

(0 ~= Real : ?x) & ~ Positive @ ?x

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","POSPLUS","POSTYPE","REFLEX","TRICHOTOMY","TYPES","XOR"]

*)

s "(0~=Real:?x)&Positive@ -?x";
ri "EVERYWHERE@NOT_EQ";
ri "NEWTAUT"; ex();
right();right();
ri "ODDCHOICE**PCASEINTRO@true=Positive@?x";ex();
right();left();
right();left();
ri "($AT)**($CIDEM)"; ex();
ri "(LEFT@0|-|2)**RIGHT@0|-|3"; ex();
ri "NOTBOTHPOS"; ex();
up();up();
rri "CASEINTRO"; ex();
top();
ri "EVERYWHERE2@ $ODDCHOICE"; ex();
right();right();right();right();right();right();
rri "(2|-|2)@true"; ex();
right();right();
rri "(2|-|3)@true"; ex();
up();up();
rri "OR_EXP";
ri "LEFT@TRICHOTOMY"; ex();
ri "NOT_EXP**1|-|1"; ex();
up();up();
rri "CASEINTRO"; ex();
up();up();
rri "NOT_EXP"; ex();
top();
rri "NOT_EXP"; rri "AND_EXP";ex();
ri "EVERYWHERE2@ $NOT_EQ"; ex();
ri "ASSERT_UNEXP"; ex();
ri "CRULE1"; ex();
p "POS_SIGN";

(*

DIFF_EQ:

0 = ?y - ?x = 

(Real : ?x) = Real : ?y

["BUILTIN","CASEINTRO","EQUATION","MINUSTYPE","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","REFLEX","TYPES"]

*)

s "0=?y-?x";
ri "REAL_TYPE"; ex();
initializecounter();
rri "ADD_CANCEL"; ex();
assign "?z_1" "?x";
ri "REAL_UNTYPE"; ex();
ri "ALL_CANCEL";
ri "LEFT@PLUSCOMM**PLUSID"; ex();
p "DIFF_EQ";

(*

REAL_NOT_LESS:

~ ?x < ?y = 

((Real : ?x) = Real : ?y) | ?y < ?x

["AND","ASSERT","BOOLDEF","BUILTIN","CASEINTRO","CONVIF","EQUATION","IF","IFF","MINUSTYPE","NONTRIV","NOT","NOT_EQ","ODDCHOICE","OR","PLUSASSOC","PLUSCOMM","PLUSCOMP","PLUSID","PLUSMINUS","PLUSTYPE","POSPLUS","POSTYPE","REAL_LESS_DEF","REFLEX","TRICHOTOMY","TYPES","XOR"]

*)

s "~?x<?y";
ri "RIGHT@REAL_LESS_DEF"; ex();
ri "PCASEINTRO@0=Real:?y-?x";ex();
right();left();
right();right();
ri "TADDTOP@MINUSTYPE"; ex();
rri "0|-|1"; ex();
up();
ri "POS_ZERO"; ex();
up();
ri "NEWTAUT"; ex();
up();right();
ri "MAKE_CASE"; ex();
rri "(2|-|1)@true"; ex();
rri "OR_EXP"; ex();
left();left();
ri "(ASRTEQ) ** $DUBNEG2"; ex();
up();
ri "DEMa"; ex();
ri "EVERYWHERE@ $NOT_EQ";ex();
right();right();right();
ri "TADDTOP@MINUSTYPE"; ex();
ri "($MINUSMINUS)**RIGHT@ALL_CANCEL";ex();
ri "(RIGHT @ PLUSCOMM ** $ BREAKMINUS)"; ex();
up();up();
left();
ri "NOT_EQ"; ex();
right();
ri "RIGHT@TREMTOP@MINUSTYPE"; ex();
ri "DIFF_EQ**EQSYMM** $DIFF_EQ"; ex();
ri "RIGHT@TADDTOP@MINUSTYPE"; ex();

up();
rri "NOT_EQ"; ex();
up();
ri "POS_SIGN"; ex();
left();
ri "NOT_EQ";ex();
right();
ri "RIGHT@TREMTOP@MINUSTYPE"; ex();
ri "DIFF_EQ**EQSYMM** $DIFF_EQ"; ex();
ri "RIGHT@TADDTOP@MINUSTYPE"; ex();
ri "EQUATION**1|-|1"; ex();
up();up();up();
ri "NEWTAUT"; ex();
up();
ri "UNPACK"; ex();
top();
rri "OR_EXP"; ex();
ri "ASSERT_UNEXP"; ex();
ri "DRULE1"; ex();
ri "RIGHT@ $REAL_LESS_DEF"; ex();
ri "LEFT@REAL_UNTYPE**DIFF_EQ"; ex();
ri "(LEFT@EQSYMM)** $LESS_EQ_REAL"; ex();
p "REAL_NOT_LESS";

(* theorems for integration with natorder.mk2 *)

s "(Nat:?x)>=Nat:?y";
ri "GREATER_EQ_REAL"; ex();
ri "EVERYWHERE@ $REALNAT"; ex();
ri "DSYM"; ex();
p "GREATER_OR_EQ";

s "(Nat:?x)=<Nat:?y";
ri "LESS_EQ_REAL"; ex();
ri "EVERYWHERE@ $REALNAT"; ex();
ri "DSYM"; ex();
p "LESS_OR_EQ";

(* axiom "MINUSCOMP" "(Nat:?x)-Nat:?y" "(?x<!?y)||(0-(?y-!?x)),?x-!?y"; *)

s "(?x<!?y)||(0-(?y-!?x)),?x-!?y";
ri "EVERYWHERE2@($LESSCOMP)** $NATMINUSCOMP"; ex();
ri "EVERYWHERE@NAT__SUB"; ex();
ri "EVERYWHERE2@TYPES"; ex();
ri "ALT_PUSH"; ex();
right(); left(); ri "UNEVAL_TAC@[-?1]"; ex();
ri "EVERYWHERE@MINUSZERO**MINUSFLIP"; ex();
left(); ri "LESS"; ri "NOTBOOL"; ri "RIGHT@ $LESS"; ri "BOOLDEF"; ex();
rri "(2|-|1)@false"; rri "AND"; ri "REAL_LESS_TRANS"; ex();
left(); ri "REAL_LESS_DEF"; ri "RIGHT@BREAKMINUS**ALL_CANCEL_2"; ex();
ri "POS_ZERO"; ex(); 
up(); ri "CSYM**CZER"; ex();
top(); ri "EVERYWHERE@ $CASEINTRO"; ex();
wb();
p "MINUSCOMP";

(* stuff to support export from peano *)

defineinfix "NATPLUS" "?x.+.?y" "(Nat:?x)+Nat:?y";
defineinfix "NATLESS" "?x.<.?y" "~(?y.-.?x)=0";

(*

SUCCNOTZERO_NAT:  

0 = 1 .+. ?x  =  

false

CASEINTRO , COMP_NAT , EQUATION , NATPLUS , REFLEX 
, SUCCNOTZERO , 0

*)

s "0=?x.+.1";
ri "RIGHT@NATPLUS";
ri "RIGHT@PLUSCOMM";
ri "EVERYWHERE@ $ONENAT";
ri "SUCCNOTZERO"; ex();
p "SUCCNOTZERO_NAT";

(*

PLUSID_NAT:  

?x .+. 0  =  

Nat : ?x

CASEINTRO , COMP_NAT , COMP_PLUS , EQUATION , NATPLUS 
, PLUSCOMM , PLUSID , PLUSTYPE , REFLEX , TYPES , 0


*)

s "?x.+.0";
ri "NATPLUS";
ri "EVERYWHERE@ $ZERONAT";
ri "COMMPLUSID"; 
rri "REALNAT"; ex();
p "PLUSID_NAT";

(* some preliminaries are needed *)

(*

ABSOLUTE_ZERO:  

Absolute : 0  =  

0

ABSOLUTE , CASEINTRO , COMP_NAT , COMP_PLUS , EQUATION 
, MINUSTYPE , PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE 
, PM , REFLEX , TYPES , 0

*)

s "Absolute:0";
ri "ABSOLUTE"; ex();
ri "EVERYWHERE@($REALZERO)**MINUSZERO"; ex();
rri "CASEINTRO"; ex();
p "ABSOLUTE_ZERO";

(*

ABSOLUTE_ONE:  

Absolute : 1  =  

1

ABSOLUTE , ABSOLUTE2 , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , HYP , MINUSTYPE , NONTRIV , ODDCHOICE , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX , TD 
, TIMESASSOC , TIMESCOMM , TIMESID , TIMESTYPE , TIMES_POS 
, TYPES , 0

*)

s "Absolute:1";
ri "PCASEINTRO@Positive@1"; ex();
right(); left(); rri "(2|-|1)@1"; ex();
ri "LEFT@Positive"; ex();
ri "EVERYWHERE2@REALNUMERAL2"; ex();
ri "TAB_AND_2"; ex();
ri "LEFT@(RIGHT@ZERONOTONE)**NEGF"; ex();
ri "REVPIVOT** $CASEINTRO"; ex();
top(); ri "LEFT@POS_ONE"; ex();
p "ABSOLUTE_ONE";

(* a purely logical lemma *)

s "false = |-?x";
right(); rri "ASSERT_UNEXP"; ex();
top(); ri "UNEVAL_TAC@[false=?1]"; ex();
ri "EVERYWHERE@EQSYMM**NONTRIV**REFLEX"; ex();
rri "NOT1"; ex();
p "NOT_LEMMA";

(*

MINUSZERO2:  

?x - 0  =  

Real : ?x

CASEINTRO , COMP_NAT , COMP_PLUS , MINUSTYPE , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PM , REFLEX , TYPES 
, 0

*)

s "?x-0";
ri "BREAKMINUS**(RIGHT@MINUSZERO)**COMMPLUSID"; ex();
p "MINUSZERO2";

(*

NATSNONNEG:  

(Nat : ?x) < 0  =  

false

ABSOLUTE , ABSOLUTE2 , AND , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , HYP , IF , INDUCTION , LESS , MINUSTYPE 
, NONTRIV , NOT1 , ODDCHOICE , OR , PLUSASSOC , PLUSCOMM 
, PLUSID , PLUSTYPE , PLUS_POS , PM , REFLEX , TD 
, TIMESASSOC , TIMESCOMM , TIMESID , TIMESTYPE , TIMES_POS 
, TYPES , forall , 0

*)

s "(Nat:?x)<0";
ri "PCASEINTRO@forall@[((Nat:?1)<0)=false]"; ex();
ri "UNIV_EQ_TAC"; ex();
left(); ri "INDUCT_TAC"; ex();
left(); left(); ri "LESS"; ri "EVERYWHERE@MINUSZERO**ABSOLUTE_ZERO"; ex();
ri "(RIGHT@REFLEX)** $FDEF"; ex();
up(); ri "REFLEX"; ex();
up(); right(); right(); right(); 
	ri "RL@EQSYMM**(RIGHT@LESS** $NRULE1)**NOT_LEMMA"; ex();
rri "CONTP"; rri "CONTP"; ex();
ri "EVERYWHERE2@MINUSZERO2** $REALNAT"; ex();
ri "EVERYWHERE2@ABSREAL"; ex();
ri "RIGHT@LEFT@TREMTOP@PLUSTYPE"; ex();
ri "TAB_IF"; ex(); 
right(); left(); left(); ri "EVERYWHERE@0|-|1"; ex();
ri "EVERYWHERE@ $ABSOLUTE_ONE"; ex();
left(); ri "PLUS_POS"; ex();
up(); ri "REFLEX"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
uptols "FORALLDROP"; ri "FORALLDROP**AT"; ex();
top(); ri "LEFT@CID**AT"; ex();
p "NATSNONNEG";

(* to cover MINUSZERO *)

(*

MINUSZERO_NAT:  

?x .-. 0  =  

Nat : ?x

ABSOLUTE , ABSOLUTE2 , AND , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , HYP , IF , INDUCTION , LESS , MINUSTYPE 
, NAT__SUB , NONTRIV , NOT1 , ODDCHOICE , OR , PLUSASSOC 
, PLUSCOMM , PLUSID , PLUSTYPE , PLUS_POS , PM , REFLEX 
, TD , TIMESASSOC , TIMESCOMM , TIMESID , TIMESTYPE 
, TIMES_POS , TYPES , forall , 0

*)

s "?x.-.0";  (* target is Nat:?x *)
ri "NAT__SUB"; ex();
ri "LEFT@(RIGHT@ $ZERONAT)**NATSNONNEG"; ex();
ri "(RIGHT@ $ZERONAT)**MINUSZERO2"; ex();
rri "REALNAT"; ex();
p "MINUSZERO_NAT";

(*

PLUSMINUS_NAT:  

(?x .+. 1) .-. 1  =  

Nat : ?x

ABSOLUTE , ABSOLUTE2 , AND , BOOLDEF , CASEINTRO , COMPPLUSTYPE 
, COMP_NAT , COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION 
, EQ_COMP , FNDIST , HYP , IF , INDUCTION , LESS , MINUSTYPE 
, NATPLUS , NAT__SUB , NONTRIV , NOT1 , ODDCHOICE 
, OR , PLUSASSOC , PLUSCOMM , PLUSID , PLUSTYPE , PLUS_POS 
, PM , REFLEX , TD , TIMESASSOC , TIMESCOMM , TIMESID 
, TIMESTYPE , TIMES_POS , TYPES , forall , 0

*)

s "(?x .+. 1) .-. 1";
ri "NAT__SUB"; ex();
left(); left(); right(); ri "NATPLUS"; ex();
up(); ri "TREMTOP@PLUSTYPE2"; ex();
up(); ri "(!$REAL_LESS_CANCEL)@ -Nat:1"; ex();
ri "RL@ALL_CANCEL"; ri "LEFT@ $REALNAT"; ri "NATSNONNEG"; up(); ex();
left(); right(); ri "NATPLUS"; ex();
up(); ri "TREMTOP@PLUSTYPE2"; ex();
up(); ri "ALL_CANCEL"; ri "COMMPLUSID"; rri "REALNAT"; ex();
p "PLUSMINUS_NAT";

(*

PLUSSUCC_NAT:  

?x .+. ?y .+. 1  =  

(?x .+. ?y) .+. 1

COMPPLUSTYPE , COMP_PLUS , NATPLUS , PLUSASSOC , PLUSCOMM 
, TYPES , 0

*)

s "?x .+. ?y .+. 1";  (* goal is (?x.+.?y).+.1 *)
ri "EVERYWHERE@NATPLUS"; ex();
ri "RIGHT@TREMTOP@PLUSTYPE2"; ex();
rri "PLUSASSOC"; ex();
ri "LEFT@TADDTOP@PLUSTYPE2"; ex();
ri "TOPDOWN@ $NATPLUS"; ex();
p "PLUSSUCC_NAT";

(*

PLUSTYPE_NAT:  

?x .+. ?y  =  

Nat : (Nat : ?x) .+. Nat : ?y

COMPPLUSTYPE , COMP_PLUS , NATPLUS , PLUSCOMM , TYPES 
, 0

*)

s "?x.+.?y";
ri "NATPLUS"; ex();
ri "(RL@ $TYPES)**PLUSTYPE2"; ex();
right(); rri "NATPLUS"; ex();
p "PLUSTYPE_NAT";

(*

ZEROMINUS_NAT:  

0 .-. 1  =  

0

ABSOLUTE , ABSOLUTE2 , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , HYP , LESS , MINUSTYPE , NAT__SUB , NONTRIV 
, NOT1 , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TD , TIMESASSOC , TIMESCOMM 
, TIMESID , TIMESTYPE , TIMES_POS , TYPES , 0

*)

s "0.-.1";
ri "NAT__SUB"; ex();
left(); ri "LESS"; ex();
ri "EVERYWHERE@ $BUILTIN"; ex();
right(); right(); ri "ABSOLUTE2"; ri "ABSOLUTE_ONE"; ex();
up(); ri "RL@REAL_TYPE"; ex();
rri "DIFF_EQ"; ri "RIGHT@ALL_CANCEL"; ex();
ri "RIGHT@(RL@ONENAT)**COMP_PLUS"; ex();
ri "RL@TYPENUMERAL"; ri "EQ_COMP"; ex();
up(); ri "NEGF"; up(); ex();
p "ZEROMINUS_NAT";

s "(Nat:?x).+.Nat:?y";
ri "TREMBOTH@PLUSTYPE_NAT"; ex();
wb();
p "PLUSSCIN_NAT";
makescin ".+." "PLUSSCIN_NAT";

(* construction of the analogue of induction *)

(* forall @ [?P @ Nat : ?1]  =

(?P @ 0) & forall @ [(?P @ Nat : ?1) -> ?P @ ?1 + 1] *)

(*

INDUCTION_NAT:  

forall @ [?P @ Nat : ?1]  =  

(?P @ 0) & forall @ [(?P @ Nat : ?1) -> ?P @ ?1 .+. 1]

BOOLDEF , CASEINTRO , COMPPLUSTYPE , COMP_NAT , COMP_PLUS 
, EQBOOL , EQUATION , FNDIST , IF , INDUCTION , NATPLUS 
, NONTRIV , NOT1 , OR , PLUSCOMM , PLUSTYPE , REFLEX 
, TYPES , 0

*)

s "forall@[?P@Nat:?1]";
dlrs "TYPES"; rri "TYPES"; ex();
top(); ri "INDUCT_TAC"; ex();
ri "EVERYWHERE2@TYPES"; ex();
ri "EVERYWHERE@ $ZERONAT"; ex();
ri "EVERYWHERE2@ONENAT"; ex();
ri "EVERYWHERE2@PLUSCOMM"; ex();
ri "EVERYWHERE2@ $NATPLUS"; ex();
ri "EVERYWHERE2@TREMTOP@PLUSTYPE_NAT"; ex();
p "INDUCTION_NAT";

(*

MINUSSUCC_NAT:  

?x .-. ?y .+. 1  =  

(?x .-. ?y) .-. 1

ABSOLUTE , ABSOLUTE2 , BOOLDEF , CASEINTRO , COMPMINUSTYPE 
, COMPPLUSTYPE , COMP_NAT , COMP_PLUS , DIST , DIVTYPE 
, EQBOOL , EQUATION , EQ_COMP , FNDIST , HYP , LESS 
, MINUSTYPE , NATMINUSCOMP , NATPLUS , NAT__SUB , NONTRIV 
, NOT1 , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PLUS_POS , PM , REFLEX , TD , TIMESASSOC 
, TIMESCOMM , TIMESID , TIMESTYPE , TIMES_POS , TYPES 
, 0

*)

s "(?x.-.?y).-.1";
ri "PCASEINTRO@(Nat : ?x) < Nat : ?y .+. 1"; ex();
right(); left(); rri "(2|-|1)@0"; ex();
ri "EVERYWHERE2@NATPLUS** $PLUSTYPE2"; ex();
right(); left(); ri "NAT__SUB"; ex();
left(); left(); ri "TREMTOP@NATMINUSTYPE"; ex();
ri "NAT__SUB"; ex();
up(); ri "UNEVAL_TAC@[?1<Nat:1]"; ex();
right(); left();ri "RIGHT@ $ONENAT"; ex();
ri "LESS"; ex();
dlls "ABSOLUTE2"; ri "ABSOLUTE2"; ri "ABSOLUTE_ONE"; ex();
up(); ri "RL@REAL_TYPE"; ex();
rri "DIFF_EQ"; ex();
ri "ALL_CANCEL"; ri "RIGHT@(RL@ONENAT)**PLUSCOMP"; ex();
ri "(RL@TYPENUMERAL)**EQ_COMP"; ex();
up(); ri "NEGF"; ex();
up(); right(); ri "(!$REAL_LESS_CANCEL)@Nat:?y"; ex();
left(); ri "ALL_CANCEL** $REALNAT"; ex();
up(); rri "0|-|2"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); right(); ri "NAT__SUB"; ex();
left(); left(); ri "TREMTOP@NATMINUSTYPE"; ex();
ri "NAT__SUB"; ex();
up(); ri "UNEVAL_TAC@[?1<Nat:1]"; ex();
right(); left();ri "RIGHT@ $ONENAT"; ex();
ri "LESS"; ex();
dlls "ABSOLUTE2"; ri "ABSOLUTE2"; ri "ABSOLUTE_ONE"; ex();
up(); ri "RL@REAL_TYPE"; ex();
rri "DIFF_EQ"; ex();
ri "ALL_CANCEL"; ri "RIGHT@(RL@ONENAT)**PLUSCOMP"; ex();
ri "(RL@TYPENUMERAL)**EQ_COMP"; ex();
up(); ri "NEGF"; ex();
up(); right(); ri "(!$REAL_LESS_CANCEL)@Nat:?y"; ex();
left(); ri "ALL_CANCEL** $REALNAT"; ex();
up(); ri "LESS**($NRULE1)**(RIGHT@ $LESS)"; rri "ASSERT_UNEXP"; ex();
ri "EVERYWHERE2@($NATPLUS)**TADDTOP@PLUSTYPE_NAT"; ex();
ri "1|-|1"; ex();
up(); up(); ri "ASSERT_UNEXP"; ex();
ri "(RIGHT@LESS)**NRULE1** $LESS"; ex();
up(); right(); right(); left(); ri "TREMTOP@NATMINUSTYPE"; ex();
ri "NAT__SUB"; ri "1|-|2"; ex();
up();rri "SUBTRACT_SUM"; ex();
ri "RIGHT@ $NATPLUS"; ex();
rri "(2|-|1)@0"; ex();
ri "EVERYWHERE@(TADDTOP@PLUSTYPE_NAT)"; ex();
rri "NAT__SUB"; ex();
up(); left(); rri "(2|-|2)@?x .-. ?y .+. 1"; ex();
left(); ri "LESS"; ex();
right(); rri "(2|-|1)@false"; ex();
ri "(LEFT@LESS)**TAB_NOT_2"; ex();
right(); left(); left(); ri "REAL_TYPE"; ex();
ri "(!$PLUSMINUS)@Nat:1"; ex();
ri "EVERYWHERE@BUILTIN** $REALNAT"; ex();
left(); rri "SUBTRACT_SUM"; ex();
ri "RIGHT@($NATPLUS)**TADDTOP@PLUSTYPE_NAT"; ex();
ri "0|-|3"; ex();
up(); right();
ri "($ONENAT)**($ABSOLUTE_ONE)**RIGHT@ONENAT"; ex();
up(); ri "PLUS_POS"; ex();
up(); right(); right();ri "REAL_TYPE"; ex();
ri "(!$PLUSMINUS)@Nat:1"; ex();
ri "EVERYWHERE@BUILTIN** $REALNAT"; ex();
left(); rri "SUBTRACT_SUM"; ex();
ri "RIGHT@($NATPLUS)**TADDTOP@PLUSTYPE_NAT"; ex();
ri "0|-|3"; ex();
up(); right();
ri "($ONENAT)**($ABSOLUTE_ONE)**RIGHT@ONENAT"; ex();
uptols "REFLEX"; ri "REFLEX"; ex();
up(); up(); ri "($TAB_NOT_2)**(LEFT@ $LESS)**1|-|1"; ex();
up(); rri "FDEF"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
ri "NAT__SUB"; ri "1|-|1"; ex();
top(); rri "NAT__SUB"; ex();
wb(); 
p "MINUSSUCC_NAT";

s "?x.<.?y";
ri "NATLESS"; ex();
ri "EVERYWHERE @ TADDBOTH @ NATMINUSTYPE"; ex();
ri "$NATLESS"; ex();
p "NATLESSSCIN";
makescin ".<." "NATLESSSCIN";

(* explaining away the .<. operator *)

(*

NOT_LESS_THAN_SELF:  

?x < ?x  =  

false

ABSOLUTE , BOOLDEF , CASEINTRO , COMP_NAT , COMP_PLUS 
, EQBOOL , EQUATION , FNDIST , LESS , MINUSTYPE , NONTRIV 
, NOT1 , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PM , REFLEX , TYPES , 0

*)

s "?x<?x";
ri "LESS"; ri "EVERYWHERE@ALL_CANCEL"; ex();
ri "EVERYWHERE@ABSOLUTE_ZERO**REFLEX"; ex();
rri "FDEF"; ex();
p "NOT_LESS_THAN_SELF";

(*

NATLESS2:  

?x .<. ?y  =  

(Nat : ?x) < Nat : ?y

ABSOLUTE , ABSOLUTE2 , BOOLDEF , CASEINTRO , COMP_NAT 
, COMP_PLUS , DIST , DIVTYPE , EQBOOL , EQUATION , EQ_COMP 
, FNDIST , LESS , MINUSTYPE , NATLESS , NAT__SUB , NONTRIV 
, NOT1 , ODDCHOICE , PLUSASSOC , PLUSCOMM , PLUSID 
, PLUSTYPE , PLUS_POS , PM , REFLEX , TD , TIMESASSOC 
, TIMESCOMM , TIMESID , TIMESTYPE , TYPES , 0

*)

s "?x.<.?y";
ri "NATLESS"; ex();
ri "EVERYWHERE@NAT__SUB"; ex();
ri "UNEVAL_TAC@[~?1=0]"; ex();
ri "PCASEINTRO@(Nat:?x)<Nat:?y"; ex();
right(); left(); left(); ri "LESS**($NRULE1)**RIGHT@ $LESS"; ex();
rri "CID"; ex();
right(); ri "0|-|1"; ex();
up(); ri "REAL_LESS_TRANS"; ex();
ri "LEFT@NOT_LESS_THAN_SELF"; ex();
ri "TAB_AND"; up(); ex();
right(); ri "EQUATION"; ex();
ri "LEFT@EQSYMM**DIFF_EQ**RL@ $REALNAT"; ex();
right(); left(); rri "(2|-|1)@false"; ex();

ri"EVERYWHERE2@(0|-|2)**NOT_LESS_THAN_SELF"; ex();

uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); ri "NEGF"; ex();
up(); right(); ri "EVERYWHERE2@REFLEX** $FDEF";ex();
right(); right(); right(); ri "EQUATION"; 
	ri "LEFT@EQSYMM**DIFF_EQ**RL@ $REALNAT"; ex();
right(); right(); rri "(2|-|1)@true"; ex();
rri "TAB_NOT_2"; ri "LEFT@REAL_NOT_LESS"; ex();
left(); ri "LESS_EQ_REAL"; ri "LEFT@RL@ $REALNAT"; ex();
ri "LEFT@EQSYMM**EQUATION**1|-|3"; ex();
ri "RIGHT@LESS**($NRULE1)**(RIGHT@ $LESS)**($ASSERT_UNEXP)**1|-|2"; ex();
ri "TAB_OR"; up(); ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
up(); rri "FDEF"; ex();
uptors "CASEINTRO"; rri "CASEINTRO"; ex();
top(); ri "ASSERT_UNEXP"; ex();
ri "(RIGHT@LESS)**NRULE1** $LESS"; ex();
p "NATLESS2";


(* BEGIN export block 

(* setup for export from peano to omnibus *)

storeall "algebra2";  (* this line is important, as otherwise the theory
			will not be named algebra2 until after the script
			is finished *)

load "peano";

(* declare a view *)

dropview "test";

declareview "test";

(* logical notions shared by peano and omnibus *)

addtoview "test" "AND" "AND";
addtoview "test" "BOOLDEF" "BOOLDEF";
addtoview "test" "EQBOOL" "EQBOOL";
addtoview "test" "IF" "IF";
addtoview "test" "NOT1" "NOT1";
addtoview "test" "OR" "OR";
addtoview "test" "forall" "forall";
addtoview "test" "forsome" "forsome";

(* theorems that are analogous in omnibus (actually in algebra2)
or which have been specially proved in algebra2 to support the view *)

addtoview "test" "LESS" "NATLESS";
addtoview "test" "ONENAT" "ONENAT";
addtoview "test" "ZERONAT" "ZERONAT";
addtoview "test" "MINUSTYPE" "NATMINUSTYPE";
addtoview "test" "SUCCNOTZERO" "SUCCNOTZERO_NAT";
addtoview "test" "PLUSID" "PLUSID_NAT";
addtoview "test" "MINUSZERO" "MINUSZERO_NAT";
addtoview "test" "PLUSMINUS" "PLUSMINUS_NAT";
addtoview "test" "PLUSSUCC" "PLUSSUCC_NAT";
addtoview "test" "PLUSTYPE" "PLUSTYPE_NAT";
addtoview "test" "INDUCTION" "INDUCTION_NAT";
addtoview "test" "ZEROMINUS" "ZEROMINUS_NAT";
addtoview "test" "MINUSSUCC" "MINUSSUCC_NAT";

exportthm "test" "algebra2" "" "COMPLETE_INDUCTION";

gettheory "peano";

exportthm "test" "algebra2" "" "DESCENT";

gettheory "peano";

exportthm "test" "algebra2" "" "LNP";


(* present the theorems imported from peano in a way that
does not depend on .<. *)

ae "COMPLETE_INDUCTION";
ri "EVERYWHERE2@NATLESS2"; ex();
rp "COMPLETE_INDUCTION";

ae "LNP";
ri "EVERYWHERE2@NATLESS2"; ex();
rp "LNP";

ae "DESCENT";
ri "EVERYWHERE2@NATLESS2"; ex();
rp "DESCENT";

 END export block *)

quit();







