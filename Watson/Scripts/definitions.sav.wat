declareconstant "forsome";
declareconstant "forall";
declareconstant "NEQ";
declareconstant "XOR";
declareconstant "IFF";
declareconstant "CONVIF";
declareconstant "IF";
declareconstant "OR";
declareconstant "AND";
declareconstant "NOT";
declareconstant "ASSERT";
declareconstant "REVPIVOT";
declareconstant "PIVOT";
declareconstant "ALT_PUSH";
declareconstant "TOPDOWN_ABSTRACT";
declareconstant "TOPDOWN_PREFIX";
declareconstant "TOPDOWN_INFIX";
declareconstant "TOPDOWN_CASE";
declareconstant "TOPDOWN";
declareconstant "EVERYWHERE_CASES";
declareconstant "EVERYWHERE_ABSTRACT";
declareconstant "EVERYWHERE_PREFIX";
declareconstant "EVERYWHERE_INFIX";
declareconstant "EVERYWHERE";
declareconstant "VALUE";
declareconstant "BOTH_CASES";
declareconstant "RIGHT_CASE";
declareconstant "LEFT_CASE";
declareconstant "RL";
declareconstant "RIGHT";
declareconstant "RIGHT2";
declareconstant "RIGHT1";
declareconstant "LEFT";
declareconstant "LEFT2";
declareconstant "LEFT1";
declareconstant "HYP";
declareconstant "ODDCHOICE";
declareconstant "EQUATION";
declareconstant "NONTRIV";
declareconstant "REFLEX";
declareconstant "CASEINTRO";
declareconstant "FNDIST";
declareconstant "Id";
declareconstant "p2";
declareconstant "p1";
declareconstant "P2";
declareconstant "P1";
declareconstant "COMP";
declareconstant "TYPES";
declareconstant "SHELL";
declareconstant "STOPINPUT";
declareconstant "OUTPUT";
declareconstant "INPUT";
declareconstant "FLIP";
declareconstant "UNEVALM";
declareconstant "EVALM";
declareconstant "BINDM";
declareconstant "UNEVAL";
declareconstant "EVAL";
declareconstant "BIND";
declareconstant "false";
declareconstant "true";
addoperator "<>" "(0) , 0";
addoperator "<+>" "(0) , 0";
addoperator "<->" "(0) , 0";
addoperator "<-" "(0) , 0";
addoperator "->" "(0) , 0";
addoperator "|" "(0) , 0";
addoperator "&" "(0) , 0";
addoperator "~" "(0) , 0";
addoperator "|-" "(0) , 0";
addoperator "$" "(0) , 0";
addoperator "**" "(0) , 0";
addoperator "^-" "(0) , 0";
addoperator "^+" "(0) , 0";
addoperator "@@" "(0) , 0";
addscinleft "<=" "";
addscinleft "=>" "";
precedencereader "<+>" "0";
precedencereader "<->" "0";
precedencereader "<-" "2";
precedencereader "->" "2";
precedencereader "|" "4";
precedencereader "&" "4";
precedencereader "|-" "6";
precedencereader "~" "6";
setdefaultprec 0;
prefixreader "~" "";
prefixreader "|-" "";
prefixreader "$" "";
prefixreader "^-" "";
prefixreader "!$" "";
prefixreader "!@" "";
addopaque "^-";
addopaque "^+";
forcetheorem "TYPES" "TYPES , (?t : ?t : ?x) , (?t : ?x) , TYPES , 0";
forcetheorem "COMP" "COMP , ((?f @@ ?g) @ ?x) , (?f @ ?g @ ?x) , COMP , 0";
forcetheorem "P1" "P1 , (P1 @ ?x , ?y) , ?x , P1 , 0";
forcetheorem "P2" "P2 , (P2 @ ?x , ?y) , ?y , P2 , 0";
forcetheorem "p1" "p1 , (p1 @ ?x , ?y) , ?x , p1 , 0";
forcetheorem "p2" "p2 , (p2 @ ?x , ?y) , ?y , p2 , 0";
forcetheorem "Id" "Id , (Id @ ?x) , ?x , Id , 0";
forcetheorem "FNDIST" "FNDIST , (?f @ ?x || ?y , ?z) , (?x || (?f @ ?y) , ?f @ ?z) , FNDIST , 0";
forcetheorem "CASEINTRO" "CASEINTRO , ?x , (?y || ?x , ?x) , CASEINTRO , 0";
forcetheorem "REFLEX" "REFLEX , (?a = ?a) , true , REFLEX , 0";
forcetheorem "NONTRIV" "NONTRIV , (true = false) , false , NONTRIV , 0";
forcetheorem "EQUATION" "EQUATION , (?a = ?b) , ((?a = ?b) || true , false) , EQUATION , 0";
forcetheorem "ODDCHOICE" "ODDCHOICE , ?x , ?x , ODDCHOICE , 0";
forcetheorem "HYP" "HYP , ((?a = ?b) || (?f @ ?a) , ?c) , ((?a = ?b) || (?f @ ?b) , ?c) , HYP , 0";
forcetheorem "LEFT1" "(LEFT1 @ ?thm) , (?x ^+ ?y) , ((?thm => ?x) ^+ ?y) , 0";
forcetheorem "LEFT2" "(LEFT2 @ ?thm) , (?x || ?y , ?z) , ((?thm => ?x) || ?y , ?z) , 0";
forcetheorem "LEFT" "(LEFT @ ?thm) , ?x , (((LEFT1 @ ?thm) =>> LEFT2 @ ?thm) => ?x) , 0";
forcetheorem "RIGHT1" "(RIGHT1 @ ?thm) , (?x ^+ ?y) , (?x ^+ ?thm => ?y) , 0";
forcetheorem "RIGHT2" "(RIGHT2 @ ?thm) , (^- ?x) , (^- ?thm => ?x) , 0";
forcetheorem "RIGHT" "(RIGHT @ ?thm) , ?x , (((RIGHT1 @ ?thm) =>> RIGHT2 @ ?thm) => ?x) , 0";
forcetheorem "RL" "(RL @ ?thm) , (?x ^+ ?y) , ((?thm => ?x) ^+ ?thm => ?y) , 0";
forcetheorem "LEFT_CASE" "(LEFT_CASE @ ?thm) , (?x || ?y , ?z) , (?x || (?thm => ?y) , ?z) , 0";
forcetheorem "RIGHT_CASE" "(RIGHT_CASE @ ?thm) , (?x || ?y , ?z) , (?x || ?y , ?thm => ?z) , 0";
forcetheorem "BOTH_CASES" "(BOTH_CASES @ ?thm) , (?x || ?y , ?z) , (?x || (?thm => ?y) , ?thm => ?z) , 0";
forcetheorem "VALUE" "(VALUE @ ?thm) , [?P @! ?1] , [(?thm @ ?1) => ?P @! ?1] , 0";
forcetheorem "**" "(?thm1 ** ?thm2) , ?x , (?thm2 => ?thm1 => ?x) , 0";
forcetheorem "$" "($ ?thm) , ?x , (?thm <= ?x) , 0";
forcetheorem "EVERYWHERE_INFIX" "(EVERYWHERE_INFIX @ ?thm) , (?x ^+ ?y) , (?thm => ((EVERYWHERE @ ?thm) => ?x) ^+ (EVERYWHERE @ ?thm) => ?y) , 0";
forcetheorem "EVERYWHERE_PREFIX" "(EVERYWHERE_PREFIX @ ?thm) , (^- ?x) , (?thm => ^- (EVERYWHERE @ ?thm) => ?x) , 0";
forcetheorem "EVERYWHERE_ABSTRACT" "(EVERYWHERE_ABSTRACT @ ?thm) , [?P @! ?1] , (?thm => [(EVERYWHERE @ ?thm) => ?P @! ?1]) , 0";
forcetheorem "EVERYWHERE_CASES" "(EVERYWHERE_CASES @ ?thm) , (?x || ?y , ?z) , (?thm => ((EVERYWHERE @ ?thm) => ?x) || ((EVERYWHERE @ ?thm) => ?y) , (EVERYWHERE @ ?thm) => ?z) , 0";
forcetheorem "EVERYWHERE" "(EVERYWHERE @ ?thm) , ?x , (((EVERYWHERE_INFIX @ ?thm) =>> (EVERYWHERE_PREFIX @ ?thm) =>> (EVERYWHERE_ABSTRACT @ ?thm) =>> (EVERYWHERE_CASES @ ?thm) =>> ?thm) => ?x) , 0";
forcetheorem "TOPDOWN_CASE" "(TOPDOWN_CASE @ ?thm) , (?a || ?x , ?y) , ((BOTH_CASES @ TOPDOWN @ ?thm) => (LEFT @ ?thm) => ?thm => ?a || ?x , ?y) , 0";
forcetheorem "TOPDOWN_INFIX" "(TOPDOWN_INFIX @ ?thm) , (?x ^+ ?y) , ((RL @ TOPDOWN @ ?thm) => ?thm => ?x ^+ ?y) , 0";
forcetheorem "TOPDOWN_PREFIX" "(TOPDOWN_PREFIX @ ?thm) , (^- ?x) , ((RIGHT @ TOPDOWN @ ?thm) => ?thm => ^- ?x) , 0";
forcetheorem "TOPDOWN_ABSTRACT" "(TOPDOWN_ABSTRACT @ ?thm) , [?P @! ?1] , ((VALUE @ [?thm]) => ?thm => [?P @! ?1]) , 0";
forcetheorem "TOPDOWN" "(TOPDOWN @ ?thm) , ?x , (((TOPDOWN_CASE @ ?thm) =>> (TOPDOWN_INFIX @ ?thm) =>> (TOPDOWN_PREFIX @ ?thm) =>> (TOPDOWN_ABSTRACT @ ?thm) =>> ?thm) => ?x) , 0";
forcetheorem "ALT_PUSH" "ALT_PUSH , (?x || ?y , ?z) , (?x || ((EVERYWHERE @ 1 |-| 1) => ALT_PUSH => ?y) , (EVERYWHERE @ 1 |-| 1) => ALT_PUSH => ?z) , 0";
forcetheorem "PIVOT" "PIVOT , (?x || ?y , ?z) , (?x || ((EVERYWHERE @ 0 |-| 1) => ?y) , ?z) , 0";
forcetheorem "}backup" "backup , (?x || ?y , ?z) , (?x || ((EVERYWHERE @ 0 |-| 1) => ?y) , ?z) , 0";
forcetheorem "REVPIVOT" "REVPIVOT , (?x || ?y , ?z) , (?x || ((EVERYWHERE @ $ 0 |-| 1) => ?y) , ?z) , 0";
forcetheorem "ASSERT" "ASSERT , |- ?p , (?p || true , false) , ASSERT , 0";
forcetheorem "NOT" "NOT , ~ ?p , (?p || false , true) , NOT , 0";
forcetheorem "AND" "AND , ?p & ?q , (?p || (?q || true , false) , false) , AND , 0";
forcetheorem "OR" "OR , ?p | ?q , (?p || true , ?q || true , false) , OR , 0";
forcetheorem "IF" "IF , ?p -> ?q , (?p || (?q || true , false) , true) , IF , 0";
forcetheorem "CONVIF" "CONVIF , ?p <- ?q , (?p || true , ?q || false , true) , CONVIF , 0";
forcetheorem "IFF" "IFF , (?p <-> ?q) , (?p || (?q || true , false) , ?q || false , true) , IFF , 0";
forcetheorem "XOR" "XOR , (?p <+> ?q) , (?p || (?q || false , true) , ?q || true , false) , XOR , 0";
forcetheorem "NEQ" "NEQ , (?x <> ?y) , ((?x = ?y) || false , true) , NEQ , 0";
forcetheorem "forall" "forall , (forall @ ?P) , (?P = [true]) , forall , 0";
forcetheorem "forsome" "forsome , (forsome @ ?P) , (?P <> [false]) , forsome , 0";
adddef "forsome" "forsome";
adddef "forall" "forall";
adddef "NEQ" "<>";
adddef "XOR" "<+>";
adddef "IFF" "<->";
adddef "CONVIF" "<-";
adddef "IF" "->";
adddef "OR" "|";
adddef "AND" "&";
adddef "NOT" "~";
adddef "ASSERT" "|-";
adddef "Id" "Id";
adddef "p2" "p2";
adddef "p1" "p1";
adddef "P2" "P2";
adddef "P1" "P1";
adddef "COMP" "@@";
addscript "definitions";
setprogram "p2" "p2";
setprogram "p1" "p1";
adddefdep2 "forsome" "NEQ , forsome , 0";
adddefdep2 "forall" "forall , 0";
adddefdep2 "NEQ" "NEQ , 0";
adddefdep2 "XOR" "XOR , 0";
adddefdep2 "IFF" "IFF , 0";
adddefdep2 "CONVIF" "CONVIF , 0";
adddefdep2 "IF" "IF , 0";
adddefdep2 "OR" "OR , 0";
adddefdep2 "AND" "AND , 0";
adddefdep2 "NOT" "NOT , 0";
adddefdep2 "ASSERT" "ASSERT , 0";
adddefdep2 "REVPIVOT" "0";
adddefdep2 "PIVOT" "0";
adddefdep2 "ALT_PUSH" "0";
adddefdep2 "TOPDOWN" "0";
adddefdep2 "TOPDOWN_ABSTRACT" "0";
adddefdep2 "TOPDOWN_PREFIX" "0";
adddefdep2 "TOPDOWN_INFIX" "0";
adddefdep2 "TOPDOWN_CASE" "0";
adddefdep2 "EVERYWHERE" "0";
adddefdep2 "EVERYWHERE_CASES" "0";
adddefdep2 "EVERYWHERE_ABSTRACT" "0";
adddefdep2 "EVERYWHERE_PREFIX" "0";
adddefdep2 "EVERYWHERE_INFIX" "0";
adddefdep2 "$" "0";
adddefdep2 "**" "0";
adddefdep2 "VALUE" "0";
adddefdep2 "BOTH_CASES" "0";
adddefdep2 "RIGHT_CASE" "0";
adddefdep2 "LEFT_CASE" "0";
adddefdep2 "RL" "0";
adddefdep2 "RIGHT" "0";
adddefdep2 "RIGHT2" "0";
adddefdep2 "RIGHT1" "0";
adddefdep2 "LEFT" "0";
adddefdep2 "LEFT2" "0";
adddefdep2 "LEFT1" "0";
adddefdep2 "HYP" "0";
adddefdep2 "ODDCHOICE" "0";
adddefdep2 "EQUATION" "0";
adddefdep2 "NONTRIV" "0";
adddefdep2 "REFLEX" "0";
adddefdep2 "CASEINTRO" "0";
adddefdep2 "FNDIST" "0";
adddefdep2 "Id" "Id , 0";
adddefdep2 "p2" "p2 , 0";
adddefdep2 "p1" "p1 , 0";
adddefdep2 "P2" "P2 , 0";
adddefdep2 "P1" "P1 , 0";
adddefdep2 "COMP" "COMP , 0";
adddefdep2 "TYPES" "0";
addthmtextdep2 "forsome" "forsome , NEQ , 0";
addthmtextdep2 "NEQ" "NEQ , 0";
addthmtextdep2 "forall" "forall , 0";
addthmtextdep2 "XOR" "XOR , 0";
addthmtextdep2 "IFF" "IFF , 0";
addthmtextdep2 "CONVIF" "CONVIF , 0";
addthmtextdep2 "IF" "IF , 0";
addthmtextdep2 "OR" "OR , 0";
addthmtextdep2 "AND" "AND , 0";
addthmtextdep2 "NOT" "NOT , 0";
addthmtextdep2 "ASSERT" "ASSERT , 0";
addthmtextdep2 "REVPIVOT" "REVPIVOT , EVERYWHERE_INFIX , EVERYWHERE , EVERYWHERE_PREFIX , EVERYWHERE_ABSTRACT , EVERYWHERE_CASES , (?x $ ?y) , 0";
addthmtextdep2 "$" "(?x $ ?y) , 0";
addthmtextdep2 "EVERYWHERE" "EVERYWHERE_INFIX , EVERYWHERE , EVERYWHERE_PREFIX , EVERYWHERE_ABSTRACT , EVERYWHERE_CASES , 0";
addthmtextdep2 "EVERYWHERE_CASES" "EVERYWHERE_INFIX , EVERYWHERE , EVERYWHERE_PREFIX , EVERYWHERE_ABSTRACT , EVERYWHERE_CASES , 0";
addthmtextdep2 "EVERYWHERE_ABSTRACT" "EVERYWHERE_INFIX , EVERYWHERE , EVERYWHERE_PREFIX , EVERYWHERE_ABSTRACT , EVERYWHERE_CASES , 0";
addthmtextdep2 "EVERYWHERE_PREFIX" "EVERYWHERE_INFIX , EVERYWHERE , EVERYWHERE_PREFIX , EVERYWHERE_ABSTRACT , EVERYWHERE_CASES , 0";
addthmtextdep2 "EVERYWHERE_INFIX" "EVERYWHERE_INFIX , EVERYWHERE , EVERYWHERE_PREFIX , EVERYWHERE_ABSTRACT , EVERYWHERE_CASES , 0";
addthmtextdep2 "PIVOT" "PIVOT , EVERYWHERE_INFIX , EVERYWHERE , EVERYWHERE_PREFIX , EVERYWHERE_ABSTRACT , EVERYWHERE_CASES , 0";
addthmtextdep2 "ALT_PUSH" "EVERYWHERE_INFIX , EVERYWHERE , EVERYWHERE_PREFIX , EVERYWHERE_ABSTRACT , EVERYWHERE_CASES , ALT_PUSH , 0";
addthmtextdep2 "TOPDOWN_CASE" "TOPDOWN_CASE , BOTH_CASES , TOPDOWN , LEFT , LEFT1 , LEFT2 , TOPDOWN_INFIX , RL , TOPDOWN_PREFIX , RIGHT , RIGHT1 , RIGHT2 , TOPDOWN_ABSTRACT , VALUE , 0";
addthmtextdep2 "TOPDOWN_INFIX" "TOPDOWN_CASE , BOTH_CASES , TOPDOWN , LEFT , LEFT1 , LEFT2 , TOPDOWN_INFIX , RL , TOPDOWN_PREFIX , RIGHT , RIGHT1 , RIGHT2 , TOPDOWN_ABSTRACT , VALUE , 0";
addthmtextdep2 "TOPDOWN_PREFIX" "TOPDOWN_CASE , BOTH_CASES , TOPDOWN , LEFT , LEFT1 , LEFT2 , TOPDOWN_INFIX , RL , TOPDOWN_PREFIX , RIGHT , RIGHT1 , RIGHT2 , TOPDOWN_ABSTRACT , VALUE , 0";
addthmtextdep2 "TOPDOWN" "TOPDOWN_CASE , BOTH_CASES , TOPDOWN , LEFT , LEFT1 , LEFT2 , TOPDOWN_INFIX , RL , TOPDOWN_PREFIX , RIGHT , RIGHT1 , RIGHT2 , TOPDOWN_ABSTRACT , VALUE , 0";
addthmtextdep2 "TOPDOWN_ABSTRACT" "TOPDOWN_ABSTRACT , VALUE , 0";
addthmtextdep2 "VALUE" "VALUE , 0";
addthmtextdep2 "RIGHT" "RIGHT , RIGHT1 , RIGHT2 , 0";
addthmtextdep2 "RIGHT2" "RIGHT2 , 0";
addthmtextdep2 "RIGHT1" "RIGHT1 , 0";
addthmtextdep2 "RL" "RL , 0";
addthmtextdep2 "LEFT" "LEFT , LEFT1 , LEFT2 , 0";
addthmtextdep2 "LEFT2" "LEFT2 , 0";
addthmtextdep2 "LEFT1" "LEFT1 , 0";
addthmtextdep2 "BOTH_CASES" "BOTH_CASES , 0";
addthmtextdep2 "**" "(?x ** ?y) , 0";
addthmtextdep2 "RIGHT_CASE" "RIGHT_CASE , 0";
addthmtextdep2 "LEFT_CASE" "LEFT_CASE , 0";
addthmtextdep2 "HYP" "HYP , 0";
addthmtextdep2 "ODDCHOICE" "ODDCHOICE , 0";
addthmtextdep2 "EQUATION" "EQUATION , 0";
addthmtextdep2 "NONTRIV" "NONTRIV , 0";
addthmtextdep2 "REFLEX" "REFLEX , 0";
addthmtextdep2 "CASEINTRO" "CASEINTRO , 0";
addthmtextdep2 "FNDIST" "FNDIST , 0";
addthmtextdep2 "Id" "Id , 0";
addthmtextdep2 "p2" "p2 , 0";
addthmtextdep2 "p1" "p1 , 0";
addthmtextdep2 "P2" "P2 , 0";
addthmtextdep2 "P1" "P1 , 0";
addthmtextdep2 "COMP" "COMP , 0";
addthmtextdep2 "TYPES" "TYPES , 0";
quit();