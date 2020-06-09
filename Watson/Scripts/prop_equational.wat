(* this file illustrates an equational approach to propositional
reasoning *)

script "definitions";

(* typing rules *)

axiom "ASSERTS" "|-?x" "|- |-?x";

axiom "NOT_TYPE" "~?x" "|- ~ |- ?x";

s "~?x";
ri "NOT_TYPE"; ex();
ri "ASSERTS"; ex();
right(); rri "NOT_TYPE"; ex();
p "NRULE1";

s "~?x";
ri "NOT_TYPE"; ex();
right(); right(); ri "ASSERTS"; ex();
top(); rri "NOT_TYPE"; ex();
p "NRULE2";

axiom "AND_TYPE" "?x & ?y" "|-(|-?x & |-?y)";

s "?x&?y";
ri "AND_TYPE"; ex();
ri "ASSERTS"; ex();
right(); rri "AND_TYPE"; ex();
p "CRULE1";

s "?x&?y";
ri "AND_TYPE"; ex();
right();left(); ri "ASSERTS"; ex();
top(); rri "AND_TYPE"; ex();
p "CRULE2";

s "?x&?y";
ri "AND_TYPE"; ex();
right();right(); ri "ASSERTS"; ex();
top(); rri "AND_TYPE"; ex();
p "CRULE3";

s "?x&?y";
ri "AND_TYPE"; ex();
right();right(); ri "ASSERTS"; ex();
top();right();left(); ri "ASSERTS"; ex();
top(); rri "AND_TYPE"; ex();
p "CRULE4";

axiom "OR_TYPE" "?x | ?y" "|-(|-?x | |-?y)";

s "?x|?y";
ri "OR_TYPE"; ex();
ri "ASSERTS"; ex();
right(); rri "OR_TYPE"; ex();
p "DRULE1";

s "?x|?y";
ri "OR_TYPE"; ex();
right();left(); ri "ASSERTS"; ex();
top(); rri "OR_TYPE"; ex();
p "DRULE2";

s "?x|?y";
ri "OR_TYPE"; ex();
right();right(); ri "ASSERTS"; ex();
top(); rri "OR_TYPE"; ex();
p "DRULE3";

s "?x|?y";
ri "OR_TYPE"; ex();
right();right(); ri "ASSERTS"; ex();
top();right();left(); ri "ASSERTS"; ex();
top(); rri "OR_TYPE"; ex();
p "DRULE4";

s "?x";
ri "NRULE1"; ri "DRULE1"; ri "CRULE1"; ri "EVERYWHERE@NRULE2**CRULE4**DRULE4";
ri "EVERYWHERE@ $ASSERTS";
ri "EVERYWHERE@($NRULE2)**($DRULE4)**($CRULE4)";
rri "NRULE1"; rri "DRULE1"; rri "CRULE1";
p "CLEANUP";


(* axioms of boolean algebra *)

(* double negation *)

axiom "DNEG" "~ ~?x" "|-?x";

(* commutative laws *)

axiom "COMMC" "?x&?y" "?y&?x";

axiom "COMMD" "?x|?y" "?y|?x";

(* associative laws *)

axiom "ASSOCC" "(?x&?y)&?z" "?x&(?y&?z)" ;

axiom "ASSOCD" "(?x|?y)|?z" "?x|(?y|?z)" ;

(* distributive laws *)

axiom "DISTC" "?x&(?y|?z)" "(?x&?y)|(?x&?z)";

axiom "DISTD" "?x|(?y&?z)" "(?x|?y)&(?x|?z)";

(* identity laws *)

axiom "IDC" "?x&true" "|-?x";

axiom "IDD" "?x|false" "|-?x";

(* idempotent laws *)

axiom "IDEMC" "?x&?x" "|-?x";

axiom "IDEMD" "?x|?x" "|-?x";

(* zero laws *)

axiom "ZERC" "?x&false" "false";

axiom "ZERD" "?x|true" "true";

(* cancellation laws *)

axiom "CANCELC" "?x& ~?x" "false";

axiom "CANCELD" "?x| ~?x" "true";

(* de Morgan laws *)

axiom "DEMC" "~(?x & ?y)" "~?x| ~?y";

axiom "DEMD" "~(?x | ?y)" "~?x & ~?y";

(* definitions of other operators *)

axiom "IF_DEF" "?x -> ?y" "~?x | ?y";

axiom "CONVIF_DEF" "?x <- ?y" "?y -> ?x";

axiom "IFF_DEF" "?x <-> ?y" "(?x -> ?y) & (?y -> ?x)";

axiom "XOR_DEF" "?x <+> ?y" "~(?x <-> ?y)";

(* sample proofs *)

s "?p -> ?p";
ri "IF_DEF"; ex();
ri "COMMD"; ex();
ri "CANCELD"; ex();
p "SELFIMPLY";

s "?p -> (?q -> ?p)";
ri "EVERYWHERE@IF_DEF"; ex();
right(); ri "COMMD"; ex();
top(); ri "ASSOCD"; ex();
left(); ri "COMMD"; ri "CANCELD"; ex();
up(); ri "COMMD"; ri "ZERD"; ex();
p "IRRELEVANCE";

s "(?p&?q)<->(?q&?p)";
right(); ri "COMMC"; ex();
top(); ri "IFF_DEF"; ex();
ri "RL@SELFIMPLY"; ex();
ri "IDC"; ex();
ri "RIGHT@ $CANCELD"; ex();
rri "DRULE1"; ex();
ri "CANCELD"; ex();
p "COMMC_TAUT";

s "|-true";
ri "RIGHT@ $CANCELD"; ex();
rri "DRULE1"; ex();
ri "CANCELD"; ex();
p "ASSERT_TRUE";

s "|-false";
ri "RIGHT@ $CANCELC"; ex();
rri "CRULE1"; ex();
ri "CANCELC"; ex();
p "ASSERT_FALSE";

autoedit "CLEANUP";
ri "ASSERT_TRUE";
ri "ASSERT_FALSE";
autoreprove();

s "~false";
ri "RIGHT@ $CANCELC"; ex();
ri "DEMC"; ex();
ri "COMMD"; ex();
ri "LEFT@DNEG"; ex();
rri "DRULE2"; ex();
ri "CANCELD"; ex();
p "NOT_FALSE";

s "(?x|?y)&?z";
ri "COMMC"; ex();
ri "DISTC"; ex();
ri "RL@COMMC"; ex();
prove "DISTC2"; 

s "(?x&?y)|?z";
ri "COMMD"; ex();
ri "DISTD"; ex();
ri "RL@COMMD"; ex();
prove "DISTD2"; 




(* Nand and Nor -- one-point bases for propositional logic *)

defineinfix "NAND" "?x ~& ?y" "~(?x & ?y)";

defineinfix "NOR" "?x ~| ?y" "~(?x | ?y)";

setprecedence "~&" 4;

setprecedence "~|" 4;

quit();

