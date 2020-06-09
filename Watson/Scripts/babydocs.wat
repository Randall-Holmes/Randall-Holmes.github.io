(* theory file supporting the examples in the documentation/paper *)

declareinfix "+";
axiom "COMM" "?x+?y" "?y+?x";
axiom "ASSOC" "(?x+?y)+?z" "?x+?y+?z";

s "?x+?y+?z";
left();
up();
ri "COMM"; ex();	
left(); ri "COMM"; ex();
up(); ri "ASSOC"; ex();
p "REVERSE";

s "?a+?b+?c+?d";
ri "REVERSE"; ex();

axiom "ZERO" "0+?x" "?x";
declarepretheorem "ZEROES";
s "0+?x";	(* display omitted *)
ri "ZERO"; ex();
ri "ZEROES";
prove "ZEROES";

s "0+0+0+?x";   (* display omitted *)
ri "ZEROES"; ex();

startover();
ri "ZEROES"; steps();

declareunary "-";  (* declare a strict prefix operator - *)
axiom "INV" "?x + -?x" "0";

s "0";
rri "INV";  (* rri = revruleintro applies converse of theorem *)
ex();

s "0";
initializecounter();  (* initializes automatically generated suffixes *)
rri "INV"; ex();
assign "?x_1" "?x";  (* replace new variable using global assignment *)
prove "INV_INVERSE@?x";

s "0";
ri "INV_INVERSE@3"; ex();

s "0";
ri "(!$ INV)@3"; ex();

s "?x+0";    (* displays suppressed *)
ri "COMM"; ri "ZERO";
prove "COMMZERO";

s "?x+?y";
ri "ZERO"; ri "COMMZERO"; 
p "EITHERZERO";

s "0+?x+0";
ri "EITHERZERO"; ex();

s "?x+?y";
ri "ZERO"; ari "COMMZERO";  (* ari = altrevruleintro
                            introduces an alternative theorem to be
                            applied if COMM fails *)
reprove "EITHERZERO";

s "0+?x+0";
ri "EITHERZERO"; ex();

declareopaque "^+";   (* this variable operator declaration will be
			explained below *)
s "?x^+?y";
right(); ri "?thm";
p "RIGHT@?thm";

s "?x+?y+?z";
ri "RIGHT@COMM"; steps();

s "?x";
ri "?thm1";
ri "?thm2";
p "?thm1**?thm2";

s "?x+?y+?z";
ri "COMM**ASSOC"; ex();

declarepretheorem "ASSOCS";

s "(?x+?y)+?z";
ri "ASSOC"; ex();
ri "ASSOCS";
p "ASSOCS";

s "((?x+?y)+?z)+(?u+?v)+?w";
ri "ASSOCS"; ex();

declarepretheorem "ALLASSOCS";

s "?x+?y";
ri "ASSOCS"; ri "RIGHT@ALLASSOCS";
p "ALLASSOCS";

s "(((?x+(?y+?z)+?w)+(?u+?v)+?w)+((?u+?v)+?w)+?e)+(?u+?v)+?e+?f";
ri "ALLASSOCS"; ex();

s "(?a=?b)||((?c=?b)||(?a+?b),?x),?y";
right();left();right();left();left();

lookhyps();

ri "0|-|1"; ex();
rri "0|-|2"; ex(); 
rri "1|-|1"; ex();
ri "1|-|1"; ex();
up(); up(); right();

lookhyps();

rri "(2|-|2)@0"; ex(); 

(* now we need abstraction examples! *)

s "?x";
ri "BIND@?x"; ex();
ri "EVAL"; ex();

s "[?1]";
ri "BIND@?y"; ex();
ri "EVAL"; ex();

s "?x@?x";
ri "BIND@?x"; ex();

s "(?f@?x)+?g@?x";
ri "BIND@?x"; ex();
left();ri "BIND@?g";ex();
left();ri "BIND@?f"; ex();

startover();
assign "?f,?g" "(P1@?F),P2@?F";
ri "BIND@?x"; ex();
left(); ri "BIND@?F"; ex();
assign "?F" "?f,?g";
ri "EVAL"; ex();
left();left();left();
ri "P1"; ex();
up();up();right();left();
ri "P2"; ex();
top(); ri "EVAL"; ex();

s "(?x+?y)=?x+?y";
ri "BIND@?x+?y"; ex();

s "3+3";
ri "UNEVAL@[?1+?1]"; ex();

defineinfix "NOT" "~?x" "?x||false,true";
defineinfix "AND" "?x&?y" "?x||(?y||true,false),false";
defineconstant "forall@?x" "?x=[true]";
defineconstant "forsome@?x" "~forall@[~?x@?1]";

(*

Some unstratified examples:

s "[?1@?1]";
s "[[?1]]";
s "forall@[forsome@[?1=?2]]";

*)

declareconstant "bool";

s "forall@[bool:forsome@[?1=?2]]";

axiom "FORALLBOOL" "forall@?x" "bool:forall@?x";

axiom "FORSOMEBOOL" "forsome@?x" "bool:forsome@?x";

makescout "forall" "FORALLBOOL";
makescout "forsome" "FORSOMEBOOL";

s "forall@[forsome@[?1=?2]]";

defineconstant "four" "2+2";

defineconstant "Double@?x" "?x+?x";
defineconstant "(Comp@?f,?g)@?x" "?f@?g@?x";
defineconstant "Comp2@?f,?g,?x" "?f@?g@?x";

defineinfix "OR" "?x|?y" "~(~?x)& ~?y";
definetypedinfix "CONV_APP" 0 1 "?x <@ ?y" "?y @ ?x";

start "?x||true,false";
assign "?x" "?x||true,false";  (* sets up theorem that this operation
					is a retraction *)
ri "(!@CASEINTRO)@?x"; ex();
top(); downtoleft "?x||?y,?z"; ri "1|-|1"; ex();
top(); downtoright "?x||?y,?z"; ri "1|-|1"; ex();
top(); ex();
p "BOOLRETRACT";

defineconstanttype "BOOLRETRACT" "Bool:?x" "?x||true,false";

axiom "FORALLDIST" "forall@[(?P@?1)&?Q@?1]" "(forall@[?P@?1])&forall@[?Q@?1]";

s "forall@[(?1=?1)&?1=?1]";
ri "FORALLDIST"; ex();

s "forall@[(?1=?1)&?1=?1]";
right();right();
right(); ri "BIND@?1"; up(); left(); ri "BIND@?1"; up(); ex();
top(); ri "FORALLDIST"; ex();
ri "RL@RIGHT@VALUE@[UNEVAL@[?2=?2]]"; ex();  (* this line is here to 
						fake effect of pre-
						higher-order matching
						version of prover *)
left();right();right();ri "EVAL";
	top();right();right();right();ri "EVAL"; top(); ex();


s "?x+?y+?z";
ri "ASSOC"; ex();

cmatch();

ri "ASSOC"; ex();



quit();


