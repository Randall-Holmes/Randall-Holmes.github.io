demoremark "Some `algebraic laws' for boolean algebra";

s "(?x&?y)|(?x& ~?y)";
rri "DISTC"; ex();
right(); ri "CANCELD"; ex();
top(); ri "IDC"; ex();
prove "ALT_ELIM";

s "|-?x";
rri "ALT_ELIM"; ex();

demoremark "introduces `new variables'";

demoremark "this can be avoided";

initializecounter();
s "|-?x";
rri "ALT_ELIM"; ex();
assign "?y_1" "?y";
prove "ALT_INTRO@?y";

s "|-?y";
ri "ALT_INTRO@?z"; ex();

s "?x&?y";
ri "CRULE3"; ex();
right(); ri "ALT_INTRO@?z"; ex();

demoremark "now we prove a theorem of some interest";

s "?y|?x&?y";
ri "DRULE2"; ex();
left(); ri "ALT_INTRO@?x"; ex();

demoremark "observe that two of the disjuncts are `the same'";

ri "COMMD"; ex();
ri "RIGHT@COMMC"; ex();

demoremark "the effect of RIGHT@COMMC is to apply COMMC to the right subterm";

up(); ri "ASSOCD"; ex();
right(); ri "IDEMD"; ex();
up(); rri "DRULE3"; ex();
ri "RIGHT@COMMC"; ex();
ri "COMMD"; ex();
ri "ALT_ELIM"; ex();
prove "ABSORBD";

demoremark "Verification of some tautologies";

s "(?p&?q)->?p";

demoremark "we need to eliminate implication";

ri "IF_DEF"; ex();

demoremark "we now apply a deMorgan law";

left(); ri "DEMC"; ex();

demoremark "now we use regrouping to set up a cancellation";

ri "COMMD"; ex();
top(); ri "ASSOCD"; ex();
right(); ri "COMMD"; ri "CANCELD"; ex();

demoremark "we use the `zero law' of disjunction";

top(); ri "ZERD"; ex();

p "CONJ_IMP_1";

s "(?p&?q->?r)<->?p->?q->?r";
left(); ri "IF_DEF"; ex();
left(); ri "DEMC"; ex();
up();ri "ASSOCD"; ex();
rri "IF_DEF"; ex();
right(); rri "IF_DEF"; ex();
top(); ri "IFF_DEF"; ex();
ri "RL@IF_DEF"; ex();

demoremark "The effect of RL@IF_DEF is to apply IF_DEF to right and left subterms";

ri "RL@COMMD"; ex();
ri "RL@CANCELD"; ex();
ri "IDC"; ex();
right(); rri "CANCELD"; ex();
top(); rri "DRULE1"; ex();
ri "CANCELD"; ex();
p "SHUNTING";

demoremark "This proof exemplifies a bad practice";

demoremark "It would be much shorter and easier to follow if we had proved some lemmas";

s "|-true";
right(); rri "CANCELD"; ex();
top(); rri "DRULE1"; ex();
ri "CANCELD"; ex();
p "TASSERT";

s "?p<->?p";
ri "IFF_DEF"; ex();
ri "RL@IF_DEF"; ex();
ri "RL@COMMD"; ex();
ri "RL@CANCELD"; ex();
ri "IDC"; ri "TASSERT"; ex();
prove "BREFLEX";

(* exercises;  verify that ?p->?q|?p is a tautology; verify that
(?p->?q)<->(~?q -> ~?p) is a tautology (contrapositive);
show that (?p->?q)&(?q->?r)->?p->?r is a tautology (this
may be harder). *)

demoremark "Examples of DNF and CNF";

demoremark "We need the other form of distributivity";

(* 

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

*)



s "?p<->?q";
ri "IFF_DEF"; ex();
ri "RL@IF_DEF"; ex();
ri "DISTC"; ex();
ri "RL@DISTC2"; ex();
left(); right(); ri "CANCELC"; ex();
up(); ri "IDD"; ex();
up(); rri "DRULE2"; ex();
right(); left(); ri "COMMC"; ri "CANCELC"; ex();
up(); ri "COMMD"; ri "IDD"; ex();
up(); rri "DRULE3"; ex();
ri "RIGHT@COMMC"; ri "COMMD"; ex();
prove "IFF_DNF";

(* exercises: convert ?x <+> ?y to DNF; convert ?x <-> ?y to CNF (this
is easy!); convert ?p<->?q<->?r to CNF (for this you might want
to prove a theorem DISTD2) *)

s "(?p&?q&?r)|(?p& ~?q)";
right(); ri "CRULE1**ALT_INTRO@?r"; ex();
left(); ri "CRULE1** $IDEMD"; ex();
up(); ri "ASSOCD"; ex();
ri "RIGHT@ALT_ELIM"; rri "DRULE3"; ex();
up(); rri "ASSOCD"; ex();
left(); ri "RIGHT@ASSOCC"; ex();
ri "RL@RIGHT@COMMC"; ex();
ri "RL@ $ASSOCC"; ex();
ri "ALT_ELIM"; ex();
rri "CRULE1"; ex();
p "SINGLE_ELIM_D";

(* below this point, develop the whole algorithm defined in class *)

(* the functions here so far will reduce to DNF *)

(* definition expansion *)

s "?x";
ri "EVERYWHERE@XOR_DEF";
ri "EVERYWHERE@IFF_DEF";
ri "EVERYWHERE@IF_DEF";
p "DEFPUSH";

(* systematic negation pushing *)

dpt "NEGPUSH";

s "~ ~?x";
ri "DNEG"; ex();
right(); ri "NEGPUSH";
top(); rri "NRULE1";
arri "DRULE1";
arri "CRULE1";
p "NEGPUSH1";

s "~(?x & ?y)";
ri "DEMC"; ex();
right(); ri "NEGPUSH";
up(); left(); ri "NEGPUSH";
top(); rri "DRULE2";rri "DRULE3";
p "NEGPUSH2";

s "~(?x|?y)";
ri "DEMD"; ex();
right(); ri "NEGPUSH";
up(); left(); ri "NEGPUSH";
top(); rri "CRULE2";rri "CRULE3";
p "NEGPUSH3";

s "?x&?y";
right(); ri "NEGPUSH";
up(); left(); ri "NEGPUSH";
top(); rri "CRULE2";rri "CRULE3";
p "NEGPUSH4";

s "?x|?y";
right(); ri "NEGPUSH";
up(); left(); ri "NEGPUSH";
top(); rri "DRULE2";rri "DRULE3";
p "NEGPUSH5";

s "?x";
ri "NEGPUSH1";
ari "NEGPUSH2";
ari "NEGPUSH3";
ari "NEGPUSH4";
ari "NEGPUSH5";
p "NEGPUSH";


(* DNF pushing *)

dpt "DNFPUSH";

s "?x|?y";
right(); ri "DNFPUSH";
up(); left(); ri "DNFPUSH";
p "DNFPUSH1";

s "?x&?y";
right(); ri "DNFPUSH";
up(); left(); ri "DNFPUSH";
top(); ri "DISTC";
ri "DISTC2";
ri "DNFPUSH1";
p "DNFPUSH2";

s "?x";
ri "DNFPUSH1";
ari "DNFPUSH2";
p "DNFPUSH";

(* CNF pushing *)

dpt "CNFPUSH";

s "?x&?y";
right(); ri "CNFPUSH";
up(); left(); ri "CNFPUSH";
p "CNFPUSH1";

s "?x|?y";
right(); ri "CNFPUSH";
up(); left(); ri "CNFPUSH";
top(); ri "DISTD";
ri "DISTD2";
ri "CNFPUSH1";
p "CNFPUSH2";

s "?x";
ri "CNFPUSH1";
ari "CNFPUSH2";
p "CNFPUSH";


(* generalized associativity *)

dpt "ASSOCSC";

s "(?x&?y)&?z";
ri "ASSOCC"; ex();
ri "ASSOCSC";
p "ASSOCSC";

dpt "ALLASSOCSC";

s "?x&?y";
ri "ASSOCSC";
ri "RIGHT@ALLASSOCSC";
p "ALLASSOCSC";

s "?x&(?y&(?z&?w)&?u)&?v";

ri "ALLASSOCSC"; ex();

dpt "ASSOCSD";

s "(?x|?y)|?z";
ri "ASSOCD"; ex();
ri "ASSOCSD";
p "ASSOCSD";

dpt "ALLASSOCSD";

s "?x|?y";
ri "ASSOCSD";
ri "RIGHT@ALLASSOCSD";
p "ALLASSOCSD";

s "?x|(?y|(?z|?w)|?u)|?v";

ri "ALLASSOCSD"; ex();

s "true&?x";
ri "COMMC";
ri "IDC";
ex();
p "COMMIDC";

s "false|?x";
ri "COMMD";
ri "IDD";
ex();
p "COMMIDD";

s "false&?x";
ri "COMMC";
ri "ZERC";
ex();
p "COMMZERC";

s "true|?x";
ri "COMMD";
ri "ZERD";
ex();
p "COMMZERD";

(* general truth value eliminator *)

s "?x";
ri "EVERYWHERE@IDC**COMMIDC"; ri "EVERYWHERE@ZERC**COMMZERC**ASSERT_FALSE";
ri "CLEANUP";
ri "EVERYWHERE@IDD**COMMIDD"; ri "EVERYWHERE@ZERD**COMMZERD**ASSERT_TRUE";
ri "CLEANUP";
p "TRUTHVALUES";

s "?p&?p";
ri "IDEMC"; rri "IDC"; ex();
p "IDEMTWIDDLEC";

s "?p& ~?p";
ri "CANCELC"; ri "(!$ZERC)@?p"; ex();
p "CANCELTWIDDLE1C";

s "~?p & ?p";
ri "COMMC"; ri "CANCELC"; ri "(!$ZERC)@ ~?p"; ex();
p "CANCELTWIDDLE2C";

dpt "PURGEC";

s "?p&?q&?r";
ri "CRULE2"; ex();
ri "LEFT@ $IDEMC"; ex();
ri "ASSOCC"; ex();
ri "RIGHT@ $ASSOCC"; ex();
ri "RIGHT@COMMC"; ex();
ri "CRULE2"; ex();
ri "LEFT@ $IDEMC"; ex();
ri "ASSOCC"; ex();
ri "RIGHT@ $ASSOCC"; ex();
ri "RIGHT@COMMC"; ex();
p "COPY2C";

s "?p&?q";
ri "IDEMTWIDDLEC";
ari "CANCELTWIDDLE1C";
ari "CANCELTWIDDLE2C";
ari "COPY2C**(RIGHT@RL@PURGEC)** $COPY2C";
ri "RIGHT@PURGEC";
p "PURGEC";

dpt "BUBBLE0C";

s "?p&?q&?r";
right();
ri "BUBBLE0C";
ari "FLIP@COMMC";
up();
rri "ASSOCC";
ri "LEFT@FLIP@COMMC";
ri "ASSOCC";
p "BUBBLE0C";

dpt "BUBBLEC";

s "?p&?q";
ri "BUBBLE0C";
ari "FLIP@COMMC";
ri "RIGHT@BUBBLEC";
p "BUBBLEC";

s "?p|?p";
ri "IDEMD"; rri "IDD"; ex();
p "IDEMTWIDDLED";

s "?p| ~?p";
ri "CANCELD"; ri "(!$ZERD)@?p"; ex();
p "CANCELTWIDDLE1D";

s "~?p | ?p";
ri "COMMD"; ri "CANCELD"; ri "(!$ZERD)@ ~?p"; ex();
p "CANCELTWIDDLE2D";

dpt "PURGED";

s "?p|?q|?r";
ri "DRULE2"; ex();
ri "LEFT@ $IDEMD"; ex();
ri "ASSOCD"; ex();
ri "RIGHT@ $ASSOCD"; ex();
ri "RIGHT@COMMD"; ex();
ri "DRULE2"; ex();
ri "LEFT@ $IDEMD"; ex();
ri "ASSOCD"; ex();
ri "RIGHT@ $ASSOCD"; ex();
ri "RIGHT@COMMD"; ex();
p "COPY2D";

s "?p|?q";
ri "IDEMTWIDDLED";
ari "CANCELTWIDDLE1D";
ari "CANCELTWIDDLE2D";
ari "COPY2D**(RIGHT@RL@PURGED)** $COPY2D";
ri "RIGHT@PURGED";
p "PURGED";

dpt "BUBBLE0D";

s "?p|?q|?r";
right();
ri "BUBBLE0D";
ari "FLIP@COMMD";
up();
rri "ASSOCD";
ri "LEFT@FLIP@COMMD";
ri "ASSOCD";
p "BUBBLE0D";

dpt "BUBBLED";

s "?p|?q";
ri "BUBBLE0D";
ari "FLIP@COMMD";
ri "RIGHT@BUBBLED";
p "BUBBLED";

dpt "EACH_DISJUNCT";

s "?x|?y";
right(); ri "EACH_DISJUNCT@?thm";
up(); left(); ri "EACH_DISJUNCT@?thm";
p "EACH_DISJUNCT_1@?thm";

s "?x";
ri "EACH_DISJUNCT_1@?thm";
ari "?thm";
p "EACH_DISJUNCT@?thm";

dpt "EACH_CONJUNCT";

s "?x&?y";
right(); ri "EACH_CONJUNCT@?thm";
up(); left(); ri "EACH_CONJUNCT@?thm";
p "EACH_CONJUNCT_1@?thm";

s "?x";
ri "EACH_CONJUNCT_1@?thm";
ari "?thm";
p "EACH_CONJUNCT@?thm";


(* a powerful but not complete DNF simplification procedure *)

s "?x";
ri "DEFPUSH";  (* eliminate defined forms *)
ri "NEGPUSH";  (* apply deMorgan laws and double negation *)
ri "DNFPUSH";  (* go to DNF *)
ri "EACH_DISJUNCT@ALLASSOCSC";
ri "EACH_DISJUNCT@PURGEC";
ri "EACH_DISJUNCT@TRUTHVALUES";
ri "EACH_DISJUNCT@BUBBLEC";
ri "TRUTHVALUES";
ri "ALLASSOCSD";
ri "PURGED";
ri "TRUTHVALUES";
ri "BUBBLED";
p "SIMPLIFYD";

(* a powerful but not complete CNF simplification procedure *)

s "?x";
ri "DEFPUSH";  (* eliminate defined forms *)
ri "NEGPUSH";  (* apply deMorgan laws and double negation *)
ri "CNFPUSH";  (* go to DNF *)
ri "EACH_CONJUNCT@ALLASSOCSD";
ri "EACH_CONJUNCT@PURGED";
ri "EACH_CONJUNCT@TRUTHVALUES";
ri "EACH_CONJUNCT@BUBBLED";
ri "TRUTHVALUES";
ri "ALLASSOCSC";
ri "PURGEC";
ri "TRUTHVALUES";
ri "BUBBLEC";
p "SIMPLIFYC";

s "(?P<+>?Q)->(?R<->?S)";
ri "SIMPLIFYC"; ex();


quit();





