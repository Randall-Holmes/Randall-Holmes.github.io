(* adapted to Watson June 1999 *)

(* development of untyped combinatory logic *)

(* last updated Oct. 28, 1997 *)

(* this is looking pretty good.  There is a development of algorithms
for bracket abstraction of the various types considered by Curry, plus a
development of a reasonably fast algorithm for eta-strong reduction.  *)

(* beta-strong reduction is now implemented as SR3 -- I think.
This was done by changing the weak reduction algorithm from (abcdef)
to (abcdef)', in which clause c is restricted to "basic O_1 obs" *)

(* the ambient theory remains fully extensional; the next upgrade
will be to develop the beta-strong reduction from suitable weak
extensionality assumptions *)

(* put ABSI ahead of ABSAPP in all abstraction algorithms to accomodate
nonatomic parameters; this isn't strictly relevant to CL context, but
is often convenient *)

(* commands ETASTEP and BETASTEP trigger single parallel reduction steps.
Commenting out the lines with ALLARGS convert these to single head reduction
steps, which are _much_ faster.  BETASTEP in particular is quite slow
when called upon to reduce all arguments; I think that this is to be expected.
These commands are provided so that the behaviour of terms with nonterminating
reductions can be explored *)

(* more models of the use of the various tactics defined here will 
eventually be supplied *)

(* this file does not depend on any of the other files on the page *)

(* look below for beginning of real combinator stuff *)
(* there will be some mysterious stuff before it *)

(* definition of the boolean type *)

declareconstant "bool";
axiom "EQBOOL" "?x=?y" "bool:?x=?y";
makescout "=" "EQBOOL";

(* adapts to change in preamble; proves redundant "axioms"
in preamble *)

ae "P1";  prove "PI1";

ae "P2"; prove "PI2";

ae "Id"; prove "ID";

(* parameterized "CASEINTRO" *)

initializecounter();
s "?x";
ri "CASEINTRO"; ex();
assign "?y_1" "?p";
prove "PCASEINTRO@?p";

(* elimination of FNDIST *)

s "?f@?x||?y,?z";
ri "PCASEINTRO@?x"; ex();
right();left();right();
ri "1|-|1"; ex();
up();up();right();right();
ri "1|-|1"; ex();
proveanaxiom "FNDIST";

(* elimination of HYP *)

s "(?a=?b)||(?f@?a),?c";
right();left();right();
ri "0|-|1"; ex();
proveanaxiom "HYP";


(* Structural tactics taken from Parvin's file *)

(* these allow application of theorems to left and right subterms,
reversal of the direction of a theorem, and composition of theorems *)

(* ************************ methods ****************************** *)

(* theorem/tactic composition *)

(*

?thm1 ** ?thm2:

?x = 

?thm2 => ?thm1 => ?x

[]

*)

s "?x"; ri "?thm1"; ri "?thm2"; p "?thm1**?thm2";

(* reverse direction of theorem *)

(*

$?thm:

?x = 

?thm <= ?x

*)

s "?x"; rri "?thm"; p "$?thm";

(* apply theorem to left subterm *)

(*

LEFT @ ?thm:

?p ^+ ?q = 

(?thm => ?p) ^+ ?q

[]

*)

s "?p ^+ ?q"; left(); ri "?thm"; p "LEFT@?thm";

(* apply theorem to right subterm *)

(*

RIGHT @ ?thm:

?p ^+ ?q = 

?p ^+ ?thm => ?q

[]

*)

s "?p ^+ ?q"; right(); ri "?thm"; p "RIGHT@?thm";

(* apply theorem to both left and right subterms *)

(*

RL @ ?thm:

?p ^+ ?q = 

(?thm => ?p) ^+ ?thm => ?q

[]

*)

s "?p ^+ ?q"; left(); ri "?thm"; up(); right(); ri "?thm"; p "RL@?thm";

s "?x||?y,?z";
right(); left(); ri "?thm";
p "LEFT_CASE@?thm";

(* a tool for applying hypotheses of expressions defined by cases *)

(*

PIVOT:

(?a = ?b) || ?T , ?U = 

(RIGHT @ LEFT @ EVAL) => HYP => (?a = ?b) 
|| ((BIND @ ?a) => ?T) , ?U

["HYP"]

*)

s "(?a=?b)||?T,?U";
right();left();
ri "BIND@?a";
top();
ri "HYP";
ri "LEFT_CASE@EVAL";
p "PIVOT";

(* beginning of untyped combinatory logic development *)

declareinfix ".";  (* this is the "function application" internal to CL *)

(* special version of EVERYWHERE for the CL context; a tactic for
aggressive application of tactics everywhere *)

(*

EVERYWHERE @ ?thm:

?x . ?y = 

?thm => (?thm =>> (EVERYWHERE @ ?thm) => ?x) 
. (?thm =>> (EVERYWHERE @ ?thm) => ?y)

[]

*)

declarepretheorem "EVERYWHERE";
start "?x.?y";
right(); ri "EVERYWHERE@?thm"; ari "?thm";
up();left(); ri "EVERYWHERE@?thm"; ari "?thm";
top();
ri "?thm";
p "EVERYWHERE@?thm";

setprecedence "." 1;

declareconstant "I";  (* atomic combinators *)

declareconstant "K";

declareconstant "S";

axiom "II" "I . ?x" "?x";

axiom "KK" "K . ?x . ?y" "?x";

axiom "SS" "S . ?x . ?y . ?z" "?x . ?z . (?y . ?z)";

(* development of an abstraction algorithm *)

(*

ABSI @ ?x:

?x = 

I . ?x

["II"]

*)

s "?x";
rri "II"; ex();
p "ABSI@?x";

(*

ABSK @ ?x:

?y = 

K . ?y . ?x

["KK"]

*)

s "?y";
initializecounter();
rri "KK"; ex();
assign "?y_1" "?x";
p "ABSK@?x";

(*


*)

s "?T . ?x . (?U . ?x)";
rri "SS"; ex();
p "ABSS@?x";

declarepretheorem "ABS";

s "?T.?U";
right(); ri "ABS@?x";
up(); left(); ri "ABS@?x";
top();
ri "ABSS@?x";
p "ABSAPP@?x";

s "?t";
(* ri "ABSAPP@?x";
ari "ABSI@?x"; *)
ri "ABSI@?x";
ari "ABSAPP@?x";
ari "ABSK@?x";
p "ABS@?x";  (* algorithm fab *)

(* We demonstrate why this is not a very good algorithm *)

s "?x.(?y.?z)";
ri "ABS@?z"; ex();
left();
ri "ABS@?y"; ex();
left();
ri "ABS@?x"; ex();
left();

(* the term one is now looking at is not the optimal form of the
composition combinator B! *)

(* the added steps needed to repair this *)

(* ABSFIX handles the idea of using K on complex terms (not just
atomic terms) which do not contain ?x; it might seem that we would
have a problem recognizing such terms, but it turns out to be easy *)

(*

ABSFIX:

S . (K . ?a) . (K . ?b) . ?x = 

K . (?a . ?b) . ?x

["KK","SS"]

*)

s "S.(K.?a).(K.?b).?x";
ri "SS";
ri "EVERYWHERE@KK"; ex();
ri "ABSK@?x"; ex();
p "ABSFIX";

(* ABSFIX2 handles the idea of letting ?f rather than S(K?f)I be the
abstract from ?f.?x *)

(*

ABSFIX2:

S . (K . ?a) . I . ?x = 

?a . ?x

["II","KK","SS"]

*)

s "S.(K.?a).I.?x";
ri "SS"; ri "EVERYWHERE@KK";  ri "EVERYWHERE@II"; ex();
p "ABSFIX2";


ae "ABS";
ri "ABSFIX";ri "ABSFIX2";
rp "ABS@?x";  (* algorithm abf *)

(* we repeat the development of the B combinator from above *)

s "?x.(?y.?z)";
ri "ABS@?z"; ex();
left();
ri "ABS@?y"; ex();
left();
ri "ABS@?x"; ex();
left();

(* things come out much simpler! *)

(* reduction algorithm *)

declarepretheorem "RED";

s "?t";
ri "LEFT@RED"; ri "RIGHT@RED";  (* dropping RIGHT@RED gives head reduction *)
ri "II*>RED";
ari "KK*>RED";
ari "SS*>RED";
p "RED";

(* we define the B combinator and prove its characteristic theorem *)

defineconstant "B" "S . (K . S) . K";

s "B . ?x . ?y . ?z";
ri "EVERYWHERE@B";
ri "RED"; ex();
p "BB";

(* we develop an even more general abstraction tool *)

setprecedence "," 1;  (* give pairing the same left grouping as
			internal application *)

dpt "ABSLIST";

s "?t";
ri "ABS@?y";
ri "LEFT@ABSLIST@?x";
p "ABSLIST@?x,?y";

(* once again, we develop the B combinator *)

s "?x.(?y.?z)";
ri "ABSLIST@0,?x,?y,?z"; ex();

(* this works "all at once"; now we can develop other familiar combinators *)

(* the C combinator -- conversion *)

s "?x.?z.?y";
ri "ABSLIST@0,?x,?y,?z"; ex();

defineconstant "C" "S . (S . (K . S) . (S . (K . K) . S)) . (K . K)";

s "C.?x.?y.?z";
ri "EVERYWHERE@C"; ri "RED"; ex();
p "CC";

(* the W combinator -- diagonalization *)

s "?x.?y.?y";
ri "ABSLIST@0,?x,?y"; ex();

defineconstant "W" "S . S . (K . I)";

s "W.?x.?y";
ri "EVERYWHERE@W"; ri "RED"; ex();
p "WW";

(* the D combinator -- "ordered pair" *)

s "?z.?x.?y";
ri "ABSLIST@0,?x,?y,?z"; ex();

defineconstant "D" "S . (S . (K . S) . (S . (K . K) . (S . (K . S). (S . (K . (S . I)) . K)))). (K . K)";

s "D.?x.?y.?z";
ri "EVERYWHERE@D"; ri "RED"; ex();
p "DD";

(* We develop "fixes" to the abstraction algorithm which enable us to use
B and C *)

(*

ABSFIXB:

S . (K . ?a) . ?b . ?x = 

B . ?a . ?b . ?x

["B","II","KK","SS"]

*)

s "S.(K.?a).?b.?x";
ri "RED"; ex();
rri "BB"; ex();
p "ABSFIXB";

(*

ABSFIXC:

S . ?a . (K . ?b) . ?x = 

C . ?a . ?b . ?x

*)

s "S.?a.(K.?b).?x";
ri "RED"; ex();
rri "CC"; ex();
p "ABSFIXC";

(* an abstraction algorithm with B and C steps *)

dpt "ABS2";

s "?y.?z";
right();ri "ABS2@?x";
up();left(); ri "ABS2@?x";
top();
ri "ABSS@?x";
p "ABSAPP2@?x";

s "?t";
(* ri "ABSAPP2@?x";
ari "ABSI@?x"; *)
ri "ABSI@?x";
ari "ABSAPP2@?x";
ari "ABSK@?x";
ri "ABSFIX";
ri "ABSFIX2";
ri "ABSFIXB";
ri "ABSFIXC";
p "ABS2@?x";  (* algorithm abcdef *)

dpt "ABSLIST2";

s "?t";
ri "ABS2@?y";
ri "LEFT@ABSLIST2@?x";
p "ABSLIST2@?x,?y";

(* try this algorithm out on the D combinator: *)

s "?z.?x.?y";
ri "ABSLIST2@0,?x,?y,?z"; ex();

(* the result is much more economical *)

(* a reduction algorithm to go with ABS2 *)

declarepretheorem "RED2";

s "?t";
ri "LEFT@RED2"; ri "RIGHT@RED2";  
(* dropping RIGHT@RED2 gives head reduction *)
ri "II*>RED2";
ari "KK*>RED2";
ari "SS*>RED2";
ari "BB*>RED2";
ari "CC*>RED2";
p "RED2";

(* we clearly have the tools to experiment with different abstraction
algorithms built from the clauses in Curry's book (use the same subtactics
in different orders, for those who don't know the book) *)

(* I don't know if the fact that we obtain all of Curry's clauses by
working with the I, S, K clauses and "backtracking" using -FIX
theorems is interesting *)

(* can an algorithm using B,C,W and not S be developed under Mark2? *)

(* axiom of extensionality *)

axiom "EXT" "?x=?y" "[?x.?1]=[?y.?1]";

declareconstant "zap";

axiom "ZAP" "zap@[?x.?1]" "[?x]";

(* axiom ZAP is a consequence of axiom EXT provable in the higher order
logic; its use solves the old computation problem with strong reduction *)

(* strong reduction *)

(* some old stuff which was here has been deleted -- Oct. 27 *)

(* machinery for recognition of potential strong redexes *)

s "K.?x";
p "KX";

s "S.?x";
p "SX";

s "S.?x.?y";
p "SXY";

s "B.?x";
p "BX";

s "B.?x.?y";
p "BXY";

s "C.?x";
p "CX";

s "C.?x.?y";
p "CXY";

(* this version is fairly fast; the use of the zap function avoids the
double reduction and exponential blowup of old versions *)

(* notice that zap is a meta-function; it is not a combinator *)

(* version of strong reduction using the zap function *)

(* tool for reducing arguments  *)

dpt "ALLARGS";

s "?x";
ri "RIGHT@?red";
ri "LEFT@ALLARGS@?red";
p "ALLARGS@?red";

dpt "SR2";

s "?x.?u";  (* atoms are irreducible; avoids loop with ALLARGS *)
ri "BIND@?y"; ri "LEFT@ $ZAP"; ex();
left();right();right();
ri "RED2";
ri "KX*>SR2";
ari "SX*>SR2";
ari "BX*>SR2";
ari "CX*>SR2";
ari "SXY*>SR2";
ari "BXY*>SR2";
ari "CXY*>SR2";
ari "ALLARGS@SR2"; (* fixes problem of non-reduction of arguments *)
(* but may cause performance problems *)
ri "ABS2@?1";
up();up();
ri "ZAP";
up();
ri "EVAL";
p "SR2";

(* to get beta-strong reduction rather than eta-strong reduction,
restrict the application of clause (c) of the abstraction algorithm to
objects I,S,K,KX, SX, SXY and the like; this is a replacement
of ABSFIX2 by a number of special cases. *)

(* one could replace EXT and ZAP by special cases, similarly, to get
an ambient theory more friendly to strong beta-reduction; the ambient
theory here assumes full extensionality, of course.  One restricts EXT
and ZAP to cases involving pairs of functional obs (which makes for a
great many axioms) *)

(* work toward algorithm (abcdef)' (the weak reduction appropriate to
strong beta-reduction *)

s "S.(K.I).I.?x";
ri "ABSFIX2";ex();
p "ABSFIX2I";

s "S.(K.K).I.?x";
ri "ABSFIX2";ex();
p "ABSFIX2K";

s "S.(K.S).I.?x";
ri "ABSFIX2";ex();
p "ABSFIX2S";

s "S.(K.B).I.?x";
ri "ABSFIX2";ex();
p "ABSFIX2B";

s "S.(K.C).I.?x";
ri "ABSFIX2";ex();
p "ABSFIX2C";

s "S.(K.(K.?x)).I.?u";
ri "ABSFIX2";ex();
p "ABSFIX2KX";

s "S.(K.(S.?x)).I.?u";
ri "ABSFIX2";ex();
p "ABSFIX2SX";

s "S.(K.(B.?x)).I.?u";
ri "ABSFIX2";ex();
p "ABSFIX2BX";

s "S.(K.(C.?x)).I.?u";
ri "ABSFIX2";ex();
p "ABSFIX2CX";

s "S.(K.(S.?x.?y)).I.?u";
ri "ABSFIX2";ex();
p "ABSFIX2SXY";

s "S.(K.(B.?x.?y)).I.?u";
ri "ABSFIX2";ex();
p "ABSFIX2BXY";

s "S.(K.(C.?x.?y)).I.?u";
ri "ABSFIX2";ex();
p "ABSFIX2CXY";

s "?t";

ri "ABSI@?x";
ari "ABSAPP2@?x";
ari "ABSK@?x";
ri "ABSFIX";
ri "ABSFIX2I";
ari "ABSFIX2K";
ari "ABSFIX2S";
ari "ABSFIX2B";
ari "ABSFIX2C";
ari "ABSFIX2KX";
ari "ABSFIX2SX";
ari "ABSFIX2BX";
ari "ABSFIX2CX";
ari "ABSFIX2SXY";
ari "ABSFIX2BXY";
ari "ABSFIX2CXY";
ri "ABSFIXB";
ri "ABSFIXC";
p "ABS3@?x";  (* algorithm (abcdef)' *)

(* list abstraction for ABS3 *)

dpt "ABSLIST3";

s "?t";
ri "ABS3@?y";
ri "LEFT@ABSLIST3@?x";
p "ABSLIST3@?x,?y";

(* the beta-strong reduction algorithm *)

(* its structure is a little different, because we do not want to 
apply a term to a formal variable and reduce unless it is of one of
the O_1 forms *)

(* the ambient theory still assumes full extensionality; a different
approach, which I am planning to work out below, is to develop the same
algorithm in an environment in which the full extensionality axiom
is not assumed *)

dpt "SR3";

dpt "SR3a";  (* subalgorithm handling strong steps *)

s "?x";
ri "BIND@?y"; ri "LEFT@ $ZAP"; ex();
left();right();right();
ri "RED2";
ri "KX*>SR3";
ari "SX*>SR3";
ari "BX*>SR3";
ari "CX*>SR3";
ari "SXY*>SR3";
ari "BXY*>SR3";
ari "CXY*>SR3";
ari "ALLARGS@SR3"; (* fixes problem of reducing subterms? *)
(* permissible because it preserves functionality *)
ri "ABS3@?1";
up();up();
ri "ZAP";
up();
ri "EVAL";
p "SR3a";

s "?x";
ri "RED2";
ri "KX*>SR3a";
ari "SR3a*>SX";
ari "BX*>SR3a";
ari "CX*>SR3a";
ari "SXY*>SR3a";
ari "BXY*>SR3a";
ari "CXY*>SR3a";
p "SR3";

(* a kind of single-step reduction -- actually does one step on all
arguments then one head step; it's a parallel reduction step *)

declarepretheorem "RED2STEP";

s "?t"; 
ri "ALLARGS@RED2STEP"; 
ri "II";
ari "KK";
ari "SS";
ari "BB";
ari "CC";
ari "LEFT@RED2STEP";
p "RED2STEP";

s "?f.(?x.?x)";
ri "ABSLIST @ 0 , ?f , ?x"; ex();
s "S . (S . (K . S) . K) . (K . (S . I . I)) . ?f.(S . (S . (K . S) . K) . (K . (S . I . I)) . ?f)";

(* this is a fun example to run RED2STEP on repeatedly *)

s "C . B . (S . I . I) . ?f.(C . B . (S . I . I) . ?f)";

(* similar, using ABS2 instead of ABS *)


(* another kind of reduction *)

(* precise inverse of abstraction (ABS2) *)

dpt "HDRED";  (* HDRED is a deceptive name, I suppose;
		it's traditional for me for this "abstraction inverse"
		kind of reduction *)

ae "SS";
right(); ri "HDRED";
up();left(); ri "HDRED";
p "SSH";

ae "BB";
right(); ri "HDRED";
p "BBH";

ae "CC";
left(); ri "HDRED";
p "CCH";

s "?x";
ri "II";
ari "KK";
ari "SSH";
ari "BBH";
ari "CCH";
p "HDRED";

(* construct inverse of the ABS3 abstraction algorithm *)

(* what is needed is a restriction on the application of SSH *)

dpt "HDRED2";

s "S.(K.?x).I.?y";
ri "ABSFIX2I";
ari "ABSFIX2K";
ari "ABSFIX2S";
ari "ABSFIX2B";
ari "ABSFIX2C";
ari "ABSFIX2KX";
ari "ABSFIX2SX";
ari "ABSFIX2BX";
ari "ABSFIX2CX";
ari "ABSFIX2SXY";
ari "ABSFIX2BXY";
ari "ABSFIX2CXY";
p "SKI";

ae "SS";
right(); ri "HDRED2";
up();left(); ri "HDRED2";
p "SSH2";

ae "BB";
right(); ri "HDRED2";
p "BBH2";

ae "CC";
left(); ri "HDRED2";
p "CCH2";

s "?x";
ri "II";
ari "KK";
ari "SKI";
ari "SSH2";
ari "BBH2";
ari "CCH2";
p "HDRED2";

(* eta-strong parallel reduction step *)

(* further modified to make a "lazy parallel step"; arguments are
only reduced if no top-level head step succeeds *)

dpt "ETASTEP";

dpt "STRONGSTEP";

s "?x.?y";  (* atoms are irreducible *)
(* ri "ALLARGS@ETASTEP"; *)  (* omitting this line 
			gives eta-strong head reduction step *)
ri "II";
ari "SS";
ari "KK";
ari "BB";
ari "CC";
ari "KX*>STRONGSTEP";
ari "SX*>STRONGSTEP";
ari "BX*>STRONGSTEP";
ari "CX*>STRONGSTEP";
ari "SXY*>STRONGSTEP";
ari "BXY*>STRONGSTEP";
ari "CXY*>STRONGSTEP";
(* ari "LEFT@ETASTEP"; *)  (* for full parallel reduction *)
ari "RL@ETASTEP";
p "ETASTEP";

s "?x.?u";
ri "BIND@?y"; ri "LEFT@ $ZAP"; ex();
left();right();right();
ri "HDRED";  (* I want just the right extra reduction here! *)

(* I think this should work now; what HDRED does is set up exactly what
the inside of the "lambda-term" being strongly reduced should look like *)

ri "ETASTEP";
ri "ABS2@?1"; 
up();up();
ri "ZAP";
up(); ri "EVAL";
p "STRONGSTEP";

(* beta-strong parallel step *)

(* BETASTEP now appears to work; the earlier problem was a bug in the ABS3
abstraction algorithm!  HDRED2 (the inverse of ABS3) plays the same
role here that HDRED plays in the ETASTEP algorithm above. *)

dpt "BETASTEP";

dpt "BSTRONGSTEP";

(* BETASTEP is quite slow.  Omitting the second line gives a faster
single head reduction step (in place of the parallel reduction step
which the full algorithm implements) *)

(* this is further modified to reflect a new idea:  this is now
a "lazy parallel step" which only tries to reduce arguments in case
no head step can be carried out.  The "lazy parallel" step is
much faster. *)

s "?x.?y";  (* atoms are irreducible *)
(* ri "ALLARGS@BETASTEP"; *)  (* the line to be omitted *)
ri "II";
ari "SS";
ari "KK";
ari "BB";
ari "CC";
ari "KX*>BSTRONGSTEP";
ari "SX*>BSTRONGSTEP";
ari "BX*>BSTRONGSTEP";
ari "CX*>BSTRONGSTEP";
ari "SXY*>BSTRONGSTEP";
ari "BXY*>BSTRONGSTEP";
ari "CXY*>BSTRONGSTEP";
(* ari "LEFT@BETASTEP"; *) (* for full parallel reduction *)
ari "RL@BETASTEP";
p "BETASTEP";

s "?x.?u";
ri "BIND@?y"; ri "LEFT@ $ZAP"; ex();
left();right();right();
ri "HDRED2";  (* I want just the right extra reduction here! *)

(* I think this should work now; what HDRED2 does is set up exactly what
the inside of the "lambda-term" being strongly reduced should look like *)

ri "BETASTEP";
ri "ABS3@?1"; 
up();up();
ri "ZAP";
up(); ri "EVAL";
p "BSTRONGSTEP";

(* space for example setup *)

s "?z.(?x.?z).(?y.?z)";
ri "ABSLIST3@0,?x,?y,?z";ex();
assign "?x" "?x.?u.?v";
assign "?y" "?y.?u.?v";
assign "?z" "?z.?u.?v";
ri "ABSLIST3@0,?x,?y,?z,?u,?v";ex();
left();left();left();left();left();

quit();




