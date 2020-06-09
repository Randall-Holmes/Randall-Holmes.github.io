

(* implementation of calculus of concepts sequent calculus *)

script "structural"; script "lambda";

script "typestuff";

(* structural operations in sequents *)

(* these are not to be confused with the usual propositional operations *)

declareinfix "&";
declareconstant "tt";
declareinfix "|";
declareconstant "ff";
declareinfix "->";

declareconstant "form_set"; (* type of formula sets *)

(* structural axioms for sequent building *)

axiom "ANDCOMM" "?x&?y" "?y&?x";
axiom "ANDASSOC" "(?x&?y)&?z" "?x&?y&?z";
axiom "ANDIDEM" "?x&?x" "?x";
axiom "ANDID" "tt&?x" "form_set:?x";
axiom "ORCOMM" "?x|?y" "?y|?x";
axiom "ORASSOC" "(?x|?y)|?z" "?x|?y|?z";
axiom "ORIDEM" "?x|?x" "?x";
axiom "ORID" "ff|?x" "form_set:?x";

axiom "ANDTYPE" "?x&?y" "form_set:(form_set:?x)&form_set:?y";
axiom "ORTYPE" "?x|?y" "form_set:(form_set:?x)|form_set:?y";
axiom "IFTYPE" "?x->?y" "(form_set:?x)->form_set:?y";
axiom "TT_TYPE" "tt" "form_set:tt";
axiom "FF_TYPE" "ff" "form_set:ff";

s "?x&?y";
ri "GET@?z,ANDCOMM,ANDASSOC";
p "GETL@?z";

s "?x|?y";
ri "GET@?z,ORCOMM,ORASSOC";
p "GETR@?z";

s "?x";
ri "LABELINTRO@?x"; ex();
p "SELFLABEL";

(* operations of the calculus of concepts *)

declareunary "~"; (* negation *)
declareinfix "*"; (* product *)
declareinfix "/"; (* quotient *)
declareunary "%"; (* diagonal operator -- no good symbol! *)

(* axioms *)

axiom "AXIOM" "(?x&?y)->?x|?z" "tt";

(* the obvious rules for negation *)

axiom "NEG1" "((~?x)&?y)->?z" "?y->?x,?z";
axiom "NEG2" "?x->(~?y)&?z" "(?x&?y)->?z";

(* the definition of universal concepts = degrees *)

defineconstant "V@?x" "(%?x)/ ~?x";

(* development of axioms of calculus of degrees *)

(* effects on degree of the basic operations *)

axiom "DAX1" "V@V@?x" "V@?x";
axiom "DAX2" "V@ ~?x" "V@?x";
axiom "DAX3" "V@?x*?y" "(V@?x)*V@?y";
axiom "DAX4" "V@ %?x" "(V@?x)*V@?x";
axiom "DAX4pt5" "V@?x/?y" "(V@?x)/V@?y"; (* bad quotient relevance *)

axiom "DAX5" "(?x*?y)*?z" "?x*?y*?z";
axiom "DAX6" "(V@?x)*V@?y" "(V@?y)*V@?x";

declareconstant "V0";

axiom "DAX7" "V@?x/?x" "V0";
axiom "DAX8" "?x*V0" "?x";
axiom "DAX9" "V0*?x" "?x";
axiom "DAX10" "?x/V0" "?x";

(* axioms of quotient *)

axiom "DAX11" "((V@?x)*V@?y)/V@?y" "V@?x";
axiom "DAX12" "((V@?x)/(V@?x/?y))*V@?x/?y" "V@?x";

axiom "DAX13" "(V@?x)*V@?y/?x" "(V@?y)*V@?x/?y"; (* max degree *)
axiom "DAX14" "(V@?x)/V@?x/?y" "(V@?y)/V@?y/?x"; (* min degree *)

axiom "DAX15" "?x/?y*?z" "(?x/?y)/?z"; (* bad quotient relevance *)
axiom "DAX16" "(?x*?y)/V@?y/?z" "?x*?y/V@?y/?z";

(* DAX16 is the padding axiom for quotient (such as it is);
the padding axiom for product is implicit in associativity of product *)

(* padding axioms for negation *)

axiom "PADNEG1" "(V@?x)* ~?y" "~(V@?x)*?y";
axiom "PADNEG2" "(~?x)*V@?y" "~?x*V@?y";

(* I have the notion currently that explicit padding/unpadding rules
should be avoided; they are certainly not easy to represent here! *)

(* more sequent rules *)

axiom "PROD1" "((?x*?y)&?z)->?w" "(((V@?x)*?y)&(?x*V@?y)&?z)->?w";
axiom "PROD2" "?x->(?y*?z),?w" "(?x->((V@?y)*?z),?w)&?x->(?y*V@?z),?w";

(* but notice that some kind of padding rules for formula sets are
needed to represent the quotient and diagonal rules *)



quit();




