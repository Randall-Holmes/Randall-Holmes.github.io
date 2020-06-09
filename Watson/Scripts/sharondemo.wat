(* demonstration to illustrate a possible approach to educational
applications *)

demo();

demoremark "DECLARE BASIC OPERATIONS";
demoremark "the prover has little built-in knowledge";

declareinfix "+";
declareinfix "*";

demoremark "the default precedence of Watson might be confusing";

setprecedence "+" 1;
setprecedence "*" 3;

demoremark "axioms!";

axiom "PLUSCOMM" "?x+?y" "?y+?x";
axiom "PLUSASSOC" "?x+(?y+?z)" "?x+?y+?z";

demoremark "How do we use the knowledge we have just given ourselves?";

s "?x+?y+?z";
ri "PLUSCOMM"; ex();

demoremark "We want to manipulate the right subterm";

right(); 

demoremark "Now we are looking at the desired subterm";

ri "PLUSCOMM"; ex();
top(); ri "PLUSASSOC"; ex();

demoremark "We have been manipulating the right side of an equation";

demoremark "We can look back at the left side";

lookback();

demoremark "The following command records our equation as a theorem";

prove "REVERSE";

demoremark "We can use the new equation REVERSE just as we can use our axioms";

s "?a+?b+?c+?d";
ri "REVERSE"; ex();

demoremark "We introduce subtraction";

declareinfix "-";  setprecedence "-" 1;

declareprefix "-" "0";

s "?x-?y";

demoremark "We can overload a binary operation as unary in a limited way";

s "0-?y";

axiom "SUBTRACT" "?x-?y+?y" "?x";
axiom "PLUSID" "0+?x" "?x";

demoremark "We bring multiplication back into the picture";

axiom "TIMESCOMM" "?x*?y" "?y*?x";
axiom "TIMESASSOC" "?x*(?y*?z)" "?x*?y*?z";
axiom "DIST" "?x*(?y+?z)" "?x*?y+?x*?z";

demoremark "Order of operations is set sensibly";

s "?x*?y+?x*?z";
right(); up(); left();

demoremark "Prove some theorems";

s "- -?x";
rri "PLUSID"; ex();
left(); initializecounter(); rri "SUBTRACT"; ex();

demoremark "the initializecounter() command made sure that the new variable would have the same index whenever this script is run";

assign "?y_1" "?x";
ri "PLUSCOMM"; ex();
top(); rri "PLUSASSOC"; ex();
right(); ri "PLUSCOMM"; ri "SUBTRACT"; ex();
up(); ri "PLUSCOMM"; ri "PLUSID"; ex();
prove "DOUBLE_INVERSE";

s "?x*(-?y)";
rri "PLUSID"; ex();
left(); initializecounter(); rri "SUBTRACT"; ex();
assign "?y_1" "?x*?y";
top(); rri "PLUSASSOC"; ex();
right(); rri "DIST"; ex();
right(); ri "PLUSCOMM"; ri "SUBTRACT"; ex();
up();

demoremark "This ought to be zero!";

demoremark "We save our work and prove the lemma we need";

saveenv "SIGNPULL";

s "0";
initializecounter(); rri "SUBTRACT"; ex();
assign "?y_1" "?x*0"; 
right(); right(); rri "PLUSID"; ex();
up(); ri "DIST"; ex();
up(); ri "PLUSASSOC"; ex();
left(); ri "SUBTRACT"; ex();
up(); ri "PLUSID"; ex();
demoremark "The equation we have is the converse of what we really want";
lookback();
demoremark "The wb() (or workback) command will fix this";
wb();
prove "TIMESZERO";

demoremark "We can return to work on the previous theorem";
getenv "SIGNPULL";

ri "TIMESZERO"; ex();
up(); ri "PLUSCOMM"; ri "PLUSID"; ex();
prove "SIGNPULL";

start "-?x + -?y";
rri "PLUSID"; ex();
left(); initializecounter(); rri "SUBTRACT"; ex();
assign "?y_1" "?x+?y";
up(); rri "PLUSASSOC"; ex();
right(); ri "PLUSASSOC"; ex();
left(); ri "PLUSCOMM"; ex();
ri "PLUSASSOC"; ex();
left(); ri "SUBTRACT"; ex();
up(); ri "PLUSID"; 
up(); ri "PLUSCOMM"; ri "SUBTRACT"; ex();
up(); ri "PLUSCOMM"; ri "PLUSID"; ex();
prove "MINUSSUM";

s "?x+ -?y";
left(); initializecounter(); rri "SUBTRACT"; ex();
assign "?y_1" "?y";
top(); rri "PLUSASSOC"; ex();
right(); ri "PLUSCOMM"; ri "SUBTRACT"; ex();
up(); ri "PLUSCOMM"; ri "PLUSID"; ex();
wb();
demoremark "We prefer the converse";
prove "BREAKMINUS";

demoremark "We prove a familiar result";

s "(?x-?y)*(?x+?y)";
left(); ri "BREAKMINUS"; ex();
top(); ri "DIST"; ex();
left(); ri "TIMESCOMM"; ri "DIST"; ex();
right(); ri "SIGNPULL"; ex();
top(); right(); ri "TIMESCOMM"; ri "DIST"; ex();
right(); ri "SIGNPULL"; ex();
up(); left(); ri "TIMESCOMM"; ex();
top(); rri "PLUSASSOC"; ex();
right(); ri "PLUSASSOC"; ex();
left(); ri "SUBTRACT"; ex();
up(); ri "PLUSID"; ex();
up(); rri "BREAKMINUS"; ex();
p "SUMTIMESDIFFERENCE";

demoremark "Thus far we have just done painstaking rewriting";

demoremark "The prover allows us to automate commonly used procedures";

demoremark "We demonstrate this by developing a generalized associativity tactic";

s "?x ^+ ?y";

demoremark "^+ is an infix variable, matching any infix operator";

left(); ri "?thm";

demoremark "?thm is a variable theorem; what are we up to?";

prove "LEFT@?thm";

demoremark "@ is the built in function application operator";

demoremark "so LEFT should be a function generating theorems?";

s "(?x+?y)+(?z+?w)";
ri "LEFT@PLUSCOMM"; ex();

demoremark "Take that over again step by step";

startover();
ri "LEFT@PLUSCOMM"; steps();

demoremark "We can develop more things of this kind";

demoremark "but we don't need them in this demo";

demoremark "We give one more example";

s "?x";
ri "?thm1";
ri "?thm2";
p "?thm1**?thm2";

demoremark "the operator ** is an operation on theorems";

s "?x";
rri "?thm";
p "$?thm";

s "?x+0";
ri "PLUSCOMM**PLUSID"; ex();

demoremark "We did this lots of times above!";

s "?x";
initializecounter();
ri "($PLUSID)**LEFT@ $SUBTRACT"; 

demoremark "The default precedence is that everything has the same precedence aand groups to the right";

ex();

demoremark "We did this often, too";

dpt "PLUSASSOCS";

demoremark "This tells us that PLUSASSOCS will be a theorem";

s "?x+(?y+?z)";
ri "PLUSASSOC"; ex();
ri "PLUSASSOCS";
prove "PLUSASSOCS";

demoremark "A recursive definition!";

demoremark "but what does it do?";

start "?x+?y+(?z+?w)+(?a+(?b+?c))";
ri "PLUSASSOCS"; ex();

startover();
ri "PLUSASSOCS"; steps();

demoremark "It gets rid of a lot of parentheses, but not all of them";

dpt "ALLPLUSASSOCS";

s "?x+?y";
ri "PLUSASSOCS";
ri "LEFT@ALLPLUSASSOCS";
prove "ALLPLUSASSOCS";

s "?x+(?y+?z)+(?y+(?u+?v))+(?e+?f)+?u+?v";
ri "ALLPLUSASSOCS"; ex();

startover();
ri "ALLPLUSASSOCS"; steps();

quit();






