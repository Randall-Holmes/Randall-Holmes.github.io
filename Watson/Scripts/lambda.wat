(* August 18, 1997 (as part of general overhaul *)

(* A tactic for inserting binding variables in binding contexts *)

script "structural";

initializecounter();
s "?y"; rri "IGNOREFIRST"; ex();
assign "?x_1" "?x";
p "LABELINTRO@?x";

dpt "LAMBDAINTRO";

s "?x^+?y";
ri "RL@LAMBDAINTRO";
p "LAMBDAINTRO1";

s "[?f@?1]";
right(); ri "LAMBDAINTRO"; ri "LABELINTRO@?1";
p "LAMBDAINTRO2";

s "?x||?y,?z";
ri "LEFT@LAMBDAINTRO";
ri "BOTH_CASES@LAMBDAINTRO";
p "LAMBDAINTRO3";

s "?x";
ri "LAMBDAINTRO1";ri "LAMBDAINTRO2";ri "LAMBDAINTRO3";
p "LAMBDAINTRO";

dpt "LAMBDAREMOVE";

s "?x^+?y";
ri "RL@LAMBDAREMOVE";
p "LAMBDAREMOVE1";

s "[?f@?1]";
right(); ri "LAMBDAREMOVE"; ri "IGNOREFIRST";
p "LAMBDAREMOVE2";

s "?x||?y,?z";
ri "LEFT@LAMBDAREMOVE";
ri "BOTH_CASES@LAMBDAREMOVE";
p "LAMBDAREMOVE3";


s "?x";
ri "LAMBDAREMOVE1";ri "LAMBDAREMOVE2"; ri "LAMBDAREMOVE3";
p "LAMBDAREMOVE";

(* an example *)

s "[(?a=?b)||[?2 = ?1@?2],[?2]]";
ri "LAMBDAINTRO"; ex();
ri "LAMBDAREMOVE"; ex();

(* some work toward a synthetic abstraction algorithm *)
(* mostly of historical interest *)

(*
dpt "ABS";

s "?a^+?b";
ri "LABELINTRO@(?a:^+?b)@?x"; ex();
left();
rri "RAISE";
prove "ABSSETUP@?x";

s "((?a@?y)^+(?b@?z)).?a^+?b";
ri "IGNOREFIRST"; ex();
left(); ri "ABS@?y";
up(); right(); ri "ABS@?z";
top();
ri "RAISE";
prove "ABSREST";

s "[?f^+?g]@?x";
ri "LABELINTRO@([?f]:^+[?g])@?x"; ex();
left();
rri "RAISE";
prove "ABSSETUP2";

dpt "ABS3";

s "(([?f]@?y)^+[?g]@?z).[?f^+?g]@?x";
ri "IGNOREFIRST"; ex();
ri "EVAL"; ex();
left(); ri "ABSTRACT4@?y"; ri "ABS3";
up();right(); ri "ABSTRACT4@?z"; ri "ABS3";
top();
ri "RAISE";
prove "ABSREST2";

s "?a";
ri "ABSSETUP@?x";
ri "ABSREST";
ari "IGNOREFIRST**ABSTRACT4@?x";
prove "ABS2@?x";

s "[?f^+?g]@?x";
ri "ABSSETUP2";
ri "ABSREST2";
ari "IGNOREFIRST";
p "ABS3";

s "?a";
ri "ABSTRACT1@?x";
ari "ABS2@?x";
prove "ABS@?x";
*)




quit();








