(* a theory of sequent proofs *)

(* version of Dec 2, 1998 *)

(* starting new approach using conventional logical axioms (old
approach is preserved at end in an extended comment);
completely implemented SF (stratified proofs only) but not
tested.  I still need to try writing cut elimination and possibly
other proof transformation tactics *)

(* this script is designed to be run after new.quantifiers --
it duplicates material in algebra2_2 (the development of GET)
and in simplesets (the definition of << and proof that it is
scout -- if these are commented out, it will run with the
omnibus theory) *)

(* really, the GET development ought to be moved into structural2.mk2 *)

script "new.quantifiers";

(* get desired term using associative and commutative laws *)

(* the basic GET algorithm, lifted from algebra_2.2; this should really be
in structural! *)

(* BEGIN now found in structural.wat

(* generalized associativity tactic *)

(* ASSOCS is actually an iterator for any theorem whatsoever *)

(* *> is the "on-success" control structure of the tactic language;
see the documentation or ask me *)

(*

ASSOCS @ ?thm:

?x = 

((ASSOCS @ ?thm) *> ?thm) => ?x

[]

*)

dpt "ASSOCS";
s "?x";
ri "?thm*>(ASSOCS@?thm)";
p "ASSOCS@?thm";

(*

ALLASSOCS @ ?thm:

?x = 

(RIGHT @ ALLASSOCS @ ?thm) => (ASSOCS @ ?thm) 
=> ?x

[]

*)

dpt "ALLASSOCS";
s "?x";
ri "ASSOCS@?thm";
ri "RIGHT@ALLASSOCS@?thm";
p "ALLASSOCS@?thm";


s "?x ^+ ?y";
p "GET0@?x";

s "?y ^+ ?x";
ri "?comm";
p "GET1@?x,?comm";

s "?y ^+ ?x ^+ ?z";
rri "?assoc";
ri "LEFT@?comm";
ri "?assoc";
p "GET2@?x,?comm,?assoc";

dpt "GET";
s "?x";
ri "ASSOCS@?assoc";
ri "GET0@?y";
ari "RIGHT@GET@?y,?comm,?assoc";
ri "GET1@?y,?comm";
ari "GET2@?y,?comm,?assoc";
prove "GET@?y,?comm,?assoc";

END now found in structural.wat *)

(* we represent sequents in the form L -> R, where
L is of the form P&...&Q&true and R is of the form P|...|Q|false.
We need the Get operations to bring things to the front of these
lists *)

s "?x&?y";
ri "GET@?z,CSYM,CASSOC";
p "GETL@?z";

s "?x|?y";
ri "GET@?z,DSYM,DASSOC";
p "GETR@?z";

s "?x";
ri "LABELINTRO@?x"; ex();
p "SELFLABEL";

(*

NEGL:  

((~ ?P) & ?gamma) -> ?delta  =  

(((~ ?P) & ?gamma) -> ?delta) . ?gamma -> ?P | ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "((~?P)&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@?gamma->?P|?delta"; ex();
p "NEGL";

(*

NEGR:  

?gamma -> (~ ?P) | ?delta  =  

(?gamma -> (~ ?P) | ?delta) . (?P & ?gamma) -> ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "?gamma->((~?P)|?delta)";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@(?P&?gamma)->?delta"; ex();
p "NEGR";

(*

ANDL:  

((?P & ?Q) & ?gamma) -> ?delta  =  

(((?P & ?Q) & ?gamma) -> ?delta) . (?P & ?Q & ?gamma) 
-> ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "((?P&?Q)&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@(?P&?Q&?gamma)->?delta"; ex();
p "ANDL";

(*

ANDR:  

?gamma -> (?P & ?Q) | ?delta  =  

(?gamma -> (?P & ?Q) | ?delta) . (?gamma -> ?P | ?delta) 
& ?gamma -> ?Q | ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "?gamma->(?P&?Q)|?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@(?gamma->?P|?delta)&?gamma->?Q|?delta"; ex();
prove "ANDR";

(*

ORL:  

((?P | ?Q) & ?gamma) -> ?delta  =  

(((?P | ?Q) & ?gamma) -> ?delta) . ((?P & ?gamma) 
   -> ?delta) & (?Q & ?gamma) -> ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "((?P|?Q)&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@((?P&?gamma)->?delta)&(?Q&?gamma)->?delta"; ex();
prove "ORL";

(*

ORR:  

?gamma -> (?P | ?Q) | ?delta  =  

(?gamma -> (?P | ?Q) | ?delta) . ?gamma -> ?P | ?Q 
| ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "?gamma->(?P|?Q)|?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@?gamma->?P|?Q|?delta"; ex();
p "ORR"; 

(*

IFL:  

((?P -> ?Q) & ?gamma) -> ?delta  =  

(((?P -> ?Q) & ?gamma) -> ?delta) . (?gamma -> ?P 
   | ?delta) & (?Q & ?gamma) -> ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "((?P->?Q)&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@(?gamma->?P|?delta)&(?Q&?gamma)->?delta"; ex();
p "IFL";

(*

IFR:  

?gamma -> (?P -> ?Q) | ?delta  =  

(?gamma -> (?P -> ?Q) | ?delta) . (?P & ?gamma) -> ?Q 
| ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "?gamma->(?P->?Q)|?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@(?P&?gamma)->?Q|?delta"; ex();
p "IFR";

(*

AXIOM:  

(?P & ?gamma) -> ?P | ?delta  =  

((?P & ?gamma) -> ?P | ?delta) . true

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "(?P&?gamma)->?P|?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@true"; ri "AT"; ex();
p "AXIOM";

(*

EXL @ ?P:  

?gamma -> ?delta  =  

(?gamma -> ?delta) . ((GETL @ ?P) => ?gamma) -> ?delta

IGNOREFIRST , 0

*)

s "?gamma->?delta";
ri "SELFLABEL"; ex();
right(); left(); ri "GETL@?P"; 
p "EXL@?P";

(*

EXR @ ?P:  

?gamma -> ?delta  =  

(?gamma -> ?delta) . ?gamma -> (GETR @ ?P) => ?delta

*)

s "?gamma->?delta";
ri "SELFLABEL"; ex();
right(); right(); ri "GETR@?P"; 
p "EXR@?P";

(*

WEAKL:  

(?P & ?gamma) -> ?delta  =  

((?P & ?gamma) -> ?delta) . (?P & ?P & ?gamma) -> ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "(?P&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@(?P&?P&?gamma)->?delta"; ex();
prove "WEAKL";

(*

WEAKR:  

?gamma -> ?Q | ?delta  =  

(?gamma -> ?Q | ?delta) . ?gamma -> ?Q | ?Q | ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "?gamma->?Q|?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@?gamma->?Q|?Q|?delta"; ex();
p "WEAKR";

(*

IFFL:  

((?P == ?Q) & ?gamma) -> ?delta  =  

(((?P == ?Q) & ?gamma) -> ?delta) . ((?P & ?Q & ?gamma) 
   -> ?delta) & ?gamma -> ?P | ?Q | ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IFF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE 
, OR , REFLEX , TYPES , 0

*)

s "((?P==?Q)&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@((?P&?Q&?gamma)->?delta)&?gamma->?P|?Q|?delta"; ex();
prove "IFFL";

(*

IFFR:  

?gamma -> (?P == ?Q) | ?delta  =  

(?gamma -> (?P == ?Q) | ?delta) . ((?P & ?gamma) -> ?Q 
   | ?delta) & (?Q & ?gamma) -> ?P | ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IFF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE 
, OR , REFLEX , TYPES , 0

*)

s "?gamma->(?P==?Q)|?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@((?P&?gamma)->?Q|?delta)&(?Q&?gamma)->?P|?delta"; ex();
p "IFFR";

(*

CUT @ ?P:  

?gamma -> ?delta  =  

(?gamma -> ?delta) . ((?P & ?gamma) -> ?delta) & ?gamma 
-> ?P | ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , 0

*)

s "?gamma->?delta";
ri "SELFLABEL"; ex();
right(); ri "PROVETAUT2@((?P&?gamma)->?delta)&?gamma->?P|?delta"; ex();
prove "CUT@?P";

(* quantifier rules are different.  UNIVL does not permit the
elimination of the universal quantifier (logical equivalence would
not hold, and this is equational reasoning). *)

(*

UNIVL @ ?t:  

((forall @ [?P @ ?1]) & ?gamma) -> ?delta  =  

(((forall @ [?P @ ?1]) & ?gamma) -> ?delta) . (((?P 
         @ ?t) & forall @ [?P @ ?1]) & ?gamma) -> ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , IGNOREFIRST 
, NONTRIV , forall , 0

*)

s "((forall@[?P@?1])&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); downtoleft "forall@?x";
initializecounter(); rri "INSTANTIATE"; ex();
up(); ri "CASSOC"; ex();
assign "?x_1" "?t";
left(); ri "EVAL";
p "UNIVL@?t";

(* In UNIVR, the quantified sentence engulfs the sequent; the intention
is to proceed inside the brackets and work there.  The bound variable serves
as the new variable *)

(*

UNIVR:  

?gamma -> (forall @ [?P @ ?1]) | ?Q  =  

(?gamma -> (forall @ [?P @ ?1]) | ?Q) . forall @ [?gamma 
   -> (?P @ ?1) | ?Q]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , forall , 0

*)

s "?gamma->(forall@[?P@?1])|?delta";
ri "SELFLABEL"; ex();
right(); right(); ri "DSYM"; rri "FORALLORDIST"; ex();
right(); right(); ri "DSYM"; ex();
upto "?x->?y"; ri "IDEF2"; rri "FORALLORDIST"; ex();
right(); right(); rri "IDEF2"; ex();
p "UNIVR";

(* the rules for the existential quantifier have precisely similar
oddities (dual to those for the universal quantifier) *)

(* auxiliary theorem missing from ambient theory *)

(*

FORSOMEANDDIST:  

?Q & forsome @ [?P @ ?1]  =  

forsome @ [?Q & ?P @ ?1]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, NONTRIV , NOT1 , ODDCHOICE , REFLEX , TYPES , forall 
, forsome , 0

*)

s "?Q&forsome@[?P@?1]";
rri "CRULE1"; ex();
rri "DUBNEG2"; ex();
right(); rri "DEMa"; ex();
downtoright "forsome@?x"; ri "forsome2"; ex();
up(); ri "DUBNEG2"; ri "ASSERT"; rri "FORALLBOOL"; ex();
up(); rri "FORALLORDIST"; ex();
right(); right(); rri "forsome2"; ex();
ri "DEMa"; ex();top();rri "forsome2"; ex();
p "FORSOMEANDDIST";

(*

EXISTL:  

((forsome @ [?P @ ?1]) & ?gamma) -> ?delta  =  

(((forsome @ [?P @ ?1]) & ?gamma) -> ?delta) . forall 
@ [((?P @ ?1) & ?gamma) -> ?delta]

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IF , IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR 
, REFLEX , TYPES , forall , forsome , 0

*)

s "((forsome@[?P@?1])&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); left(); ri "CSYM"; ri "FORSOMEANDDIST"; ex();
right(); right(); ri "CSYM"; ex(); 
up(); up();up(); ri "IDEF2"; ex();
left(); right(); ri "forsome2"; ex();
up(); ri "DUBNEG"; rri "FORALLBOOL"; ex();
up(); ri "DSYM"; rri "FORALLORDIST"; ex();
right(); right(); ri "DSYM"; rri "IDEF2"; ex();
p "EXISTL";

(*

EXISTR @ ?t:  

?gamma -> (forsome @ [?P @ ?1]) | ?delta  =  

(?gamma -> (forsome @ [?P @ ?1]) | ?delta) . ?gamma 
-> (?P @ ?t) | (forsome @ [?P @ ?1]) | ?delta

AND , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IGNOREFIRST , NONTRIV , NOT1 , ODDCHOICE , OR , REFLEX 
, TYPES , forall , forsome , 0

*)

s "?gamma->(forsome@[?P@?1])|?delta";
ri "SELFLABEL"; ex();
right();right();left(); ri "DINSTANTIATEF1@?t"; ex();
ri "LEFT@EVAL"; ex(); up(); ri "DASSOC"; ex();
left(); ri "EVAL";
p "EXISTR@?t";

(* definition of membership *)

definetypedinfix "IN" 0 1 "?x<<?y" "|-?y@?x";

s "?x<<?y";
ri "IN"; ex();
ri "ASSERTSCOUT"; ex();
ri "RIGHT@ $IN"; ex();
prove "INSCOUT";

makescout "<<" "INSCOUT";

(*

INL:  

((?x << [?P @ ?1]) & ?gamma) -> ?delta  =  

(((?x << [?P @ ?1]) & ?gamma) -> ?delta) . ((EVAL 
      => ?P @ ?x) & ?gamma) -> ?delta

AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
, FNDIST , IGNOREFIRST , IN , NONTRIV , REFLEX , TYPES 
, 0

*)

s "((?x<<[?P@?1])&?gamma)->?delta";
ri "SELFLABEL"; ex();
right(); left(); left(); ri "IN"; ex();
up(); ri "CRULE2"; ri "LEFT@EVAL"; ex(); left(); ri "EVAL";
p "INL";

(*

INR:  

?gamma -> (?x << [?P @ ?1]) | ?delta  =  

(?gamma -> (?x << [?P @ ?1]) | ?delta) . ?gamma -> (EVAL 
   => ?P @ ?x) | ?delta

ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION , FNDIST 
, IGNOREFIRST , IN , NONTRIV , NOT1 , OR , REFLEX 
, TYPES , 0

*)

s "?gamma->(?x<<[?P@?1])|?delta";
ri "SELFLABEL"; ex();
right(); right(); left(); ri "IN"; ex();
up(); ri "DRULE2"; ri "LEFT@EVAL"; ex(); left(); ri "EVAL";
p "INR";

(* this is a complete set of reductions for Marcel's system SF,
except that only stratified proofs can be considered *)

(* an example Thomas likes *)

s "true->(forsome@[(?P@?1)->forall@[?P@?2]])|false";

(* program:  add extensionality rule (for abstracts) and add
a setup and finish procedure so that a theorem to be proved can
be converted to a sequent to be proved, and the final result can
be stripped of annotations and simplified to true *)

(*

SETUP_SEQUENT:  

|- ?P  =  

true -> ?P | false

*)

s "|-?P";
ri "PROVETAUT2@true->?P|false"; ex();
p "SETUP_SEQUENT";

(* BEGIN FINISH_SEQUENT omitted in favor of FS_SEQUENT 

(* construction of the FINISH_SEQUENT tactic *)

(* with the May 26 update of Watson, this proof works and is fast *)

s "?x.true";
ri "IGNOREFIRST"; ex();
p "FINISH0";

s "forall@[true]";
ri "FORALLDROP**AT"; ex();
p "FINISH0b";

dpt "FINISH_SEQUENT";

s "?x.?y.?z";
right(); ri "FINISH_SEQUENT";
ri "FINISH0";
p "FINISH1";

s "?x.forall@[?z@?1]";
right(); right(); right(); ri "FINISH_SEQUENT"; ri "FINISH0";
up(); up(); ri "FINISH0b";
p "FINISH2"; 

s "?x.(forall@[?y@?1])&?z";
right(); right(); ri "FINISH_SEQUENT**FINISH0";
up(); left(); right(); right(); ri "FINISH_SEQUENT**FINISH0";
up(); up(); ri "FINISH0b";
up(); ri "CID**AT";
p "FINISH3";

s "?x.?y&forall@[?z@?1]";
right(); left(); ri "FINISH_SEQUENT**FINISH0";
up(); right(); right(); right(); ri "FINISH_SEQUENT**FINISH0";
up(); up(); ri "FINISH0b";
up(); ri "CID**AT";
p "FINISH4";

s "?x.(forall@[?y@?1])&forall@[?z@?1]";
right(); left(); right(); right();ri "FINISH_SEQUENT**FINISH0";
up(); up(); ri "FINISH0b";
up(); right();right(); right();ri "FINISH_SEQUENT**FINISH0";
up(); up(); ri "FINISH0b";
up(); ri "CID**AT";
p "FINISH5";

s "?x.?y&?z";
right();left();ri "FINISH_SEQUENT**FINISH0";
up(); right(); ri "FINISH_SEQUENT**FINISH0";
up(); ri "CID**AT";
p "FINISH6";

(* this proof takes a while because of link updating *)

s "?x.?y";
ri "FINISH1";
ari "FINISH2";
ari "FINISH5";
ari "FINISH3";
ari "FINISH4";
ari "FINISH6";
p "FINISH_SEQUENT";

END FINISH_SEQUENT omitted *)

(* development of FS_SEQUENT, which works and can be proved without
spending a lot of time doing updates of links! *)

(* I assume that FINISH_SEQUENT, as presented above, does work, but
the following is preferable due to system performance *)

s "?x.true";
ri "IGNOREFIRST"; ex();
p "FS0";

s "forall@[true]";
ri "FORALLDROP**AT"; ex();
p "FS0b";

s "?x.?y.?z";
right(); ri "?finish";
ri "FS0";
p "FS1@?finish";

s "?x.forall@[?z@?1]";
right(); right(); right(); ri "?finish"; ri "FS0";
up(); up(); ri "FS0b";
p "FS2@?finish"; 

s "?x.(forall@[?y@?1])&?z";
right(); right(); ri "?finish**FS0";
up(); left(); right(); right(); ri "?finish**FS0";
up(); up(); ri "FS0b";
up(); ri "CID**AT";
p "FS3@?finish";

s "?x.?y&forall@[?z@?1]";
right(); left(); ri "?finish**FS0";
up(); right(); right(); right(); ri "?finish**FS0";
up(); up(); ri "FS0b";
up(); ri "CID**AT";
p "FS4@?finish";

s "?x.(forall@[?y@?1])&forall@[?z@?1]";
right(); left(); right(); right();ri "?finish**FS0";
up(); up(); ri "FS0b";
up(); right();right(); right();ri "?finish**FS0";
up(); up(); ri "FS0b";
up(); ri "CID**AT";
p "FS5@?finish";

s "?x.?y&?z";
right();left();ri "?finish**FS0";
up(); right(); ri "?finish**FS0";
up(); ri "CID**AT";
p "FS6@?finish";

(* this proof should spare us so much link updating *)

dpt "FS_SEQUENT";

s "?x.?y";
ri "FS1@FS_SEQUENT";
ari "FS2@FS_SEQUENT";
ari "FS5@FS_SEQUENT";
ari "FS3@FS_SEQUENT";
ari "FS4@FS_SEQUENT";
ari "FS6@FS_SEQUENT";
p "FS_SEQUENT";

(* idea for constructive proofs -- distribute over disjunctions on left
to create alternative branches, each with one formula on left *)

(* an example Thomas likes *)

s "|-forsome@[(?P@?1)->forall@[?P@?2]]";
ri "SETUP_SEQUENT"; ex();
ri "EXISTR@?a"; ex();
right(); ri "IFR"; ex();
right(); ri "UNIVR"; ex();
right(); right(); right(); 
ri "EXR@(forsome @ [(?P @ ?2) -> forall @ [?P @ ?3]])"; ex();
right(); ri "EXISTR@?1"; ex();
right(); ri "IFR"; ex();
right(); ri "EXR@?P@?1"; ex();
right(); ri "AXIOM"; ex();  (* the proof has now been constructed *)
top(); ri "FS_SEQUENT";  ex(); (* this collapses the proof term *)
ri "IGNOREFIRST"; ex(); (* final evaluation *)

(* things to do:  build a cut-elimination tactic.  Build classical
and intuitionistic provers.  Is there any prospect for building a 
predicate logic prover? *)

quit();



(* BEGIN old version commented out -- takes an entirely different approach.

script "structural2";

declareinfix ";";  (* links formula to multiset *)

declareinfix ";;";  (* union of multisets *)

declareconstant "nseq";  (* null sequent *)

declareconstant "nseq";

(* indifference to order of members *)

axiom "SEQCOMM" "?a;?b;?c" "?b;?a;?c";

(* recursive definition of union *)

axiom "UNION1" "?a;;nseq" "?a";

axiom "UNION2" "?a;;?b;?c" "(?b;?a);;?c";

(* associativity and commutativity of union *)

axiom "UCOMM" "?a;;?b" "?b;;?a";

axiom "UASSOC" "(?a;;?b);;?c" "?a;;?b;;?c";

(* negation and conjunction -- these are syntactical operations! *)

declareunary "~";

declareinfix "&";

(* turnstile *)

declareinfix "|-";

declareconstant "isproof";

declareconstant "done";

declareinfix "..."  (* because *)

axiom "INITIAL"  "isproof@((?a;?c)|-?b;?c)...done" "true";

axiom "NOTLEFT"  "isproof@(((~?a);?gamma)|-?delta)...(?gamma|-?a;?delta)...?x"

	"isproof@(?gamma|-?a;?delta)...?x";

axiom "NOTRIGHT"  "isproof@(?gamma|-((~?a);?delta))...((?a;?gamma)|-?delta)...?x"

	"isproof@((?a;?gamma)|-?delta)...?x";

axiom "ANDLEFT"  
"isproof@(((?a&?b);?gamma)|-?delta)...((?a;?b;?gamma)|-?delta)...?x"

"isproof@((?a;?b;?gamma)|-?delta)...?x";

axiom "ANDRIGHT"

"isproof@(?gamma|-(?a&?b);?delta)...((?gamma|-?a;?delta)...?x),((?gamma|-?b;?delta)...?y)"

"(isproof@((?gamma|-?a;?delta)...?x))||(isproof@(?gamma|-?b;?delta)...?y),false";

axiom "CUT" 
"isproof@(?gamma|-?delta)...((?gamma|-?a;?delta)...?x),(((?a;?gamma)|-?delta)...?y)"

"(isproof@((?gamma|-?a;?delta)...?x))||(isproof@(((?a;?gamma)|-?delta)...?y)),false";

(* these axioms for deriving proofs are not complete by any means *)

axiom "DERIVE1" "isproof@?x...?y...?z"
"(isproof@?y...?z)||(isproof@?x...?z),false";

axiom "DERIVE2"  "isproof@?x...?y,?z...?w"  
"(isproof@?z...?w)||(isproof@?x...?y,?w),false";

axiom "DERIVE3"  "isproof@?x...?y,?z"  "isproof@?x...?z,?y";

s "isproof@?x...?y...?z";
ri "PCASEINTRO@isproof@?y...?z"; ex();
right(); right(); ri "DERIVE1"; ri "1|-|1"; ex();
p "DERIVELEMMA1";

s "isproof@?x...?y,?z...?w";
ri "PCASEINTRO@isproof@?z...?w"; ex();
right(); right(); ri "DERIVE2"; ri "1|-|1"; ex();
p "DERIVELEMMA2";


defineinfix "OR" "?x|?y" "~((~?x)& ~?y)";

s "isproof@(((?a|?b);?gamma)|-?delta)...?A";
downtoleft "?a|?b"; ri "OR"; ex();
assign "?A" "(?gamma|-((~ ?a) & ~ ?b);?delta)...?B";

top(); ri "NOTLEFT"; ex();

assign "?B"  "((?gamma|-(~?a);?delta)...?C),((?gamma|-(~?b);?delta)...?D)";

ri "ANDRIGHT"; ex();

left();	

assign "?C" "((?a;?gamma)|-?delta)...?E";

ri "NOTRIGHT"; ex();

up(); right(); left();

assign "?D" "((?b;?gamma)|-?delta)...?F";

ri "NOTRIGHT"; ex();

workback();

ri "DERIVE1"; ex();

left(); ri "ANDRIGHT"; ex();

left(); ri "NOTRIGHT"; ex();

up(); right(); left(); ri "NOTRIGHT"; ex();

top(); right(); left(); ri "DERIVE2"; ex();

left(); ri "NOTRIGHT"; ex();

up(); right(); left(); ri "DERIVE3"; ri "DERIVE2"; ex();

left(); ri "NOTRIGHT"; ex();

up(); right(); left();

top(); ri "PCASEINTRO@(isproof @ ((?a ; ?gamma) |- ?delta) ... ?E)"; ex();

right(); left(); ri "EVERYWHERE2@1|-|1"; ex();

up(); right(); ri "EVERYWHERE2@1|-|1"; ex();

top(); right(); left();

right(); left(); ri "EVERYWHERE2@1|-|2"; ex();

up(); up(); ri "LEFT_CASE@DERIVE3"; ex();

rri "DERIVELEMMA2"; ex();

up(); up();ri "LEFT_CASE@DERIVE3"; ex();

rri "DERIVELEMMA2"; ex();

ri "DERIVE3"; ex();

workback();

p "ORLEFT";

END old version commented out *)


