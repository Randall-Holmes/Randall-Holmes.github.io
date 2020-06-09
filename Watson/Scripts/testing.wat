(* use deduction.wat methods to solve examples from Steve's book *)
script "deduction";
s "|-?G1->?G2->?G3->?G4->?G5->?C";
assign "?G1" "(forall@[?P@?1])->forall@[forsome@[?Q@?1,?2]]";
assign "?G2" "forall@[forall@[forall@[((?Q@?1,?2)&?Q@?2,?3)->?S@?1,?3]]]";
assign "?G3" "forall@[(?P@?1)| ~?R@?1]";
assign "?G4" "forall@[forall@[((?R@?1)& ~?R@?2)->?S@?1,?2]]";
assign "?G5" "(~forsome@[?R@?1])->forsome@[?S@?1,?1]";
assign "?C" "forsome@[forsome@[?S@?1,?2]]";
ri "IFGOAL"; ex();
IFGOAL
IFGOAL
IFGOAL
IFGOAL
MODUS_PONENS@(forall@[?P@?1]) | ~forall@[?P@?1]
ORGOAL
PREMISE@6
IFGOAL
ORHYP@6
EXIST_GOAL@?x
MODUS_PONENS@forsome@[?Q@?x,?1]
MODUS_PONENS@forall@[forsome@[?Q@?1,?2]]
MODUS_PONENS@forall@[?P@?1]
PREMISE@7
PREMISE@1
IFGOAL
UNIV_HYP@8
IFGOAL
EXIST_HYP@8
MODUS_PONENS@forsome@[?Q@?1,?2]
MODUS_PONENS@forall@[forsome@[?Q@?2,?3]]
MODUS_PONENS@forall@[?P@?2]
PREMISE@7
PREMISE@1
IFGOAL
UNIV_HYP@10
IFGOAL
EXIST_HYP@10
EXIST_GOAL@?2
MODUS_PONENS@(?Q@?x,?1)&?Q@?1,?2
ANDGOAL
PREMISE@9
PREMISE@11
MODUS_PONENS@forall@[((?Q @ ?x , ?1) & ?Q @ ?1 , ?3) -> ?S @ ?x , ?3]
MODUS_PONENS@forall@[forall@[((?Q @ ?x , ?3) & ?Q @ ?3 , ?4) -> ?S @ ?x , ?4]]
MODUS_PONENS@forall@[forall@[forall@[((?Q @ ?3 , ?4) & ?Q @ ?4 , ?5) -> ?S @ ?3 , ?5]]]
PREMISE@2
IFGOAL
UNIV_HYP@12
IFGOAL
UNIV_HYP@12
IFGOAL
UNIV_HYP@12  {done with first case}
MODUS_PONENS@forsome@[~?P@?1]
$NOT_UNIV
PREMISE@8
IFGOAL
EXIST_HYP@9
MODUS_PONENS@ ~?R@?1
MODUS_PONENS@ (?P@?1)| ~?R@?1
UNIV_HYP@3
IFGOAL
ORHYP@11
NEGHYP@10
PREMISE@12
PREMISE@13
IFGOAL
MODUS_PONENS@(forsome@[?R@?2])| ~forsome@[?R@?2]
ORGOAL
PREMISE@12
IFGOAL
ORHYP@12
EXIST_HYP@13
EXIST_GOAL@?2
EXIST_GOAL@?1
MODUS_PONENS@(?R@?2)& ~?R@?1
ANDGOAL
PREMISE@14
PREMISE@11
MODUS_PONENS@forall@[((?R @ ?2) & ~ ?R @ ?3) -> ?S @ ?2 , ?3]
UNIV_HYP@4
IFGOAL
UNIV_HYP@15
MODUS_PONENS@forsome @ [?S @ ?2 , ?2]
MODUS_PONENS@ ~ forsome @ [?R @ ?2]
PREMISE@14
PREMISE@5
IFGOAL
EXIST_HYP@15
EXIST_GOAL@?2
EXIST_GOAL@?2
PREMISE@16

(* a small example inspired by Moscow visit, Aug, 1999 *)

s "|-(?p->?q->?r)==(?p&?q) -> ?r";
ri "IFFGOAL"; ex();

IFGOAL
IFGOAL
ANDHYP@2
MODUS_PONENS@?q
PREMISE@4
MODUS_PONENS@?p
PREMISE@3
PREMISE@1  {first half completed here

IFGOAL
IFGOAL
IFGOAL
MODUS_PONENS@?p&?q
ANDGOAL
PREMISE@2
PREMISE@3
PREMISE@1

quit();
