(* file for development of theory of finite sets and counting *)

script "natorder";

script "deduction";

(* definition of an injection *)

defineconstant "injection@?A,?B,?f" "forall@[forall@[((?1<<?A)&(?2<<?A))->((?f@?1)<<?B)&(?1=?2)=(?f@?1)=?f@?2]]";

s "((?x<<?A)&injection@?A,?B,?f)->(?f@?x)<<?B";

rri "IRULE1"; ri "IFGOAL"; ex();

(*

   INJECTION_RANGE:  

   ((?x << ?A) & injection @ ?A , ?B , ?f) -> (?f @ ?x) 
      << ?B   =

   true

   AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
   , FNDIST , IF , NONTRIV , NOT1 , ODDCHOICE , OR 
   , REFLEX , TYPES , forall , injection , 0

*)

ANDHYP@1
MODUS_PONENS@injection@?A,?B,?f
PREMISE@3
USE_THM@LEFT@injection
IFGOAL
MODUS_PONENS@(((1.?x) << ?A) & (2.?x) << ?A) -> ((?f @ (1.?x)) << ?B) & ((1.?x) = (2.?x)) = (?f @ (1.?x)) = ?f @ (2.?x)
NESTED_UNIV_HYP@4,(1.?x),(2.?x),0
EVERYWHERE2@IGNOREFIRST
USE_THM@NEWTAUT  {I had some fun here
USE_THM@ASRTCOND
USE_THM@LEFT@PREMISE@2

prove "INJECTION_RANGE";

(* definition of smaller or same size relation *)

defineinfix "LESSOREQSIZE" "?A<#=?B" "forsome@[injection@?A,?B,?1]";

(* transitivity of smaller-ord-same-size relation, proved using the
natural deduction package *)

(*

   LESSOREQSIZE_TRANSITIVE:
|-   ((?A <#= ?B) & ?B <#= ?C) -> ?A <#= ?C
   -----------------------------------------------
   AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
   , FNDIST , IF , IN , NONTRIV , NOT1 , ODDCHOICE 
   , OR , REFLEX , LESSOREQSIZE , TYPES , injection , forall 
   , forsome , 0

*)

s "((?A<#=?B)&(?B<#=?C))->?A<#=?C";

ri "EVERYWHERE2@LESSOREQSIZE"; ri "EVERYWHERE2@injection"; rri "IRULE1"; ex();

ri "IFGOAL"; ex();

ANDHYP@1
EXIST_HYP@2
EXIST_HYP@3
EXIST_GOAL@[?2@?1@?3]
EVERYWHERE2@EVAL
UNIV_GOAL
UNIV_GOAL
IFGOAL
MODUS_PONENS@((?1@?3)<<?B)&(?3=?4)=(?1@?3)=?1@?4
MODUS_PONENS@(?3 << ?A) & ?4 << ?A
PREMISE@6
MODUS_PONENS@forall@[((?3 << ?A) & ?5 << ?A) -> ((?1 @ ?3) << ?B) & (?3 = ?5) = (?1 @ ?3) = ?1 @ ?5]
UNIV_HYP@4
IFGOAL
UNIV_HYP@7
MODUS_PONENS@(?1@?4)<<?B
MODUS_PONENS@(?4<<?A)&?4<<?A
ANDGOAL
ANDHYP@6
PREMISE@8
ANDHYP@6
PREMISE@8
MODUS_PONENS@((?4 << ?A) & ?4 << ?A) -> ((?1 @ ?4) << ?B) & (?4=?4)=(?1@?4)=?1@?4
MODUS_PONENS@forall@[((?4 << ?A) & ?5 << ?A) -> ((?1 @ ?4) << ?B) & (?4 = ?5) = (?1 @ ?4) = ?1 @ ?5]
UNIV_HYP@4
IFGOAL
UNIV_HYP@7
IFGOAL
MODUS_PONENS@((?1 @ ?4) << ?B) & (?4 = ?4) = (?1 @ ?4) = ?1 @ ?4
MODUS_PONENS@((?4 << ?A) & ?4 << ?A)
ANDHYP@6
ANDGOAL
PREMISE@9
PREMISE@9
PREMISE@7
IFGOAL
ANDHYP@8
IFGOAL
PREMISE@9
MODUS_PONENS@(((?1@?3)<<?B)&(?1@?4)<<?B)->((?2 @ ?1 @ ?3) << ?C) & (?3 = ?4) = (?2 @ ?1 @ ?3) = ?2 @ ?1 @ ?4 {little problem here with ?3=?4}
MODUS_PONENS@(((?1@?3)<<?B)&(?1@?4)<<?B)->((?2 @ ?1 @ ?3) << ?C) & ((?1@?3) = ?1@?4) = (?2 @ ?1 @ ?3) = ?2 @ ?1 @ ?4 {little problem here with ?3=?4}
MODUS_PONENS@forall@[(((?1@?3)<<?B)&(?5)<<?B)->((?2 @ ?1 @ ?3) << ?C) & ((?1@?3) = ?5) = (?2 @ ?1 @ ?3) = ?2 @ ?5]
UNIV_HYP@5
IFGOAL
UNIV_HYP@7
MODUS_PONENS@(?3=?4)=(?1@?3)=?1@?4
MODUS_PONENS@((?3 << ?A) & ?4 << ?A) -> ((?1 @ ?3) << ?B) & (?3 = ?4) = (?1 @ ?3) = ?1 @ ?4
MODUS_PONENS@forall@[((?3 << ?A) & ?5 << ?A) -> ((?1 @ ?3) << ?B) & (?3 = ?5) = (?1 @ ?3) = ?1 @ ?5]
UNIV_HYP@4
IFGOAL
UNIV_HYP@7
IFGOAL
MODUS_PONENS@((?1 @ ?3) << ?B) & (?3 = ?4) = (?1 @ ?3) = ?1 @ ?4
MODUS_PONENS@(?3 << ?A) & ?4 << ?A
PREMISE@6
PREMISE@7
IFGOAL
ANDHYP@8
PREMISE@10
right {I switch briefly to more usual Watson approach, using the movement tactics
TAB_IF
goto@?3=?4
up {go to the second occurrence
0|-|7
up
$TAB_IF
up
IFGOAL
IFGOAL
PREMISE@8
IFGOAL
IFGOAL
IFGOAL
MODUS_PONENS@((?1@?3)<<?B)&(?1@?4)<<?B
ANDGOAL
ANDHYP@9
PREMISE@10
PREMISE@8
PREMISE@7

prove "LESSOREQSIZE_TRANSITIVE";

(*

   LESSOREQSIZE_AS_SELF:
|-   ?A <#= ?A
   -----------------------------------------------
   AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
   , FNDIST , IF , IN , NONTRIV , NOT1 , ODDCHOICE 
   , OR , REFLEX , LESSOREQSIZE , TYPES , injection , forall 
   , forsome , 0

*)

s "?A<#=?A";
ri "LESSOREQSIZE"; ri "EVERYWHERE2@injection"; ex();
ri "(!$DINSTANTIATE)@[?1]"; ex();
left(); ri "EVERYWHERE2@EVAL"; ex();
ri "EVERYWHERE2@REFLEX"; ex();
right(); right(); right(); right(); ri "NEWTAUT"; ex();
top(); ri "EVERYWHERE2@FORALLDROP**AT"; ri "NEWTAUT"; ex();
p "LESSOREQSIZE_AS_SELF";

defineconstant "Card@[?A]" "[(?A<#=?1)&(?1<#=?A)]";

(* with this definition of cardinal number, the Schroder-Bernstein theorem
will prove that there is a bijection between any two sets of the same
cardinality *)

defineconstant "surjection@?A,?B,?f" 
"forall@[((?1<<?A) -> ((?f@?1)<<?B))&(?1<<?B)->forsome@[(?2<<?A)&(?f@?2)=?1]]";

defineconstant "bijection@?A,?B,?f" 
"(injection@?A,?B,?f)&surjection@?A,?B,?f";

(* for sensible handling of primitive functions vs. functions as relations,
a unique choice operator is needed -- otherwise one will need to use the
axiom of choice *)

(* state a unique choice axiom *)

(* I don't know if I will use it, but it is nice to have it on record *)

declareconstant "function";

statement "FUNCTION" "(forall@[(?F@?x,?1)==?1=?y])->?y=(function@?F)@?x";

(* definitions needed to prepare for CSB theorem *)

defineinfix "IMAGE" "?f/|?A" "[forsome@[(?2<<?A)&(?f@?2)=?1]]";

defineconstant "closure@?A,?f" 
"[forall@[(((?f/|?2)|=?2)&?A|=?2)->?1<<?2]]";

(*

   SUBSET_OF_CLOSURE:  

   (?x << ?A) -> ?x << closure @ ?A , ?f   =

   true

   AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
   , FNDIST , IF , IN , NONTRIV , NOT1 , ODDCHOICE 
   , OR , REFLEX , Subset , TYPES , closure , forall 
   , 0

*)

s "(?x<<?A)->?x<<closure@?A,?f";

rri "IRULE1"; ri "IFGOAL"; ex();

RIGHT@IN
TWOASSERTS
RIGHT@LEFT@closure
RIGHT@EVAL
UNIV_GOAL
IFGOAL
ANDHYP@2
MODUS_PONENS@?x<<?A
PREMISE@1
MODUS_PONENS@?A|=?1
PREMISE@4
RIGHT@LEFT@Subset
IFGOAL
UNIV_HYP@5

prove "SUBSET_OF_CLOSURE";

(*

   CLOSURE_IS_CLOSED:  

   (?x << closure @ ?A , ?f) -> (?f @ ?x) << closure 
         @ ?A , ?f   =

   true

   AND , ASSERT , BOOLDEF , CASEINTRO , EQBOOL , EQUATION 
   , FNDIST , IF , IMAGE , IN , NONTRIV , NOT1 , ODDCHOICE 
   , OR , REFLEX , Subset , TYPES , closure , forall 
   , forsome , 0

*)

s "(?x<<closure@?A,?f)->(?f@?x)<<closure@?A,?f";

rri "IRULE1"; ri "IFGOAL"; ex();

RIGHT@IN
TWOASSERTS
(RIGHT@LEFT@closure)
RIGHT@EVAL
UNIV_GOAL
IFGOAL
ANDHYP@2
MODUS_PONENS@?x<<?1
MODUS_PONENS@?x << closure @ ?A , ?f
PREMISE@1
RIGHT@LEFT@EVERYWHERE2@closure**IN**EVAL
RIGHT@IRULE2
IFGOAL
MODUS_PONENS@((?f /| ?1) |= ?1) & ?A |= ?1
PREMISE@2
UNIV_HYP@5
IFGOAL
MODUS_PONENS@(?f@?x)<<?f/|?1
EVERYWHERE2@IMAGE
(RIGHT@IN)**TWOASSERTS
EXIST_GOAL@?x
ANDGOAL
PREMISE@5
(RIGHT@REFLEX)**AT
MODUS_PONENS@(?f /| ?1) |= ?1
PREMISE@3
RIGHT@LEFT@Subset
IFGOAL
UNIV_HYP@6

prove "CLOSURE_IS_CLOSED";

(* partial inverse function: ?f needs specified intended domain and range *)

defineconstant "inverse@?A,?B,?f" "function@[((P1@?1)<<?A)&((P2@?1)<<?B)&(?f@P2@?1)=P1@?1]";

s "((injection@?B,?A,?f)&?x<<?f/|?B)->((inverse@?A,?B,?f)@?x)<<?B";

rri "IRULE1"; ri "IFGOAL"; ex();

ANDHYP@1
EVERYWHERE@inverse
MODUS_PONENS@?x << ?f /| ?B
PREMISE@3
USE_THM@LEFT@(RIGHT@IMAGE)**IN
USE_THM@IRULE2
IFGOAL
EXIST_HYP@4
MODUS_PONENS@?1=(function @ [((P1 @ ?2) << ?A) & ((P2 @ ?2) << ?B) & (?f @ P2 @ ?2) = P1 @ ?2]) @ ?x
MODUS_PONENS@(forall@[([((P1 @ ?3) << ?A) & ((P2 @ ?3) << ?B) & (?f @ P2 @ ?3) = P1 @ ?3]@?x,?2)==?2=?1])
EVERYWHERE2@EVAL
EVERYWHERE2@P1**P2
UNIV_GOAL
IFFGOAL
MODUS_PONENS@injection@?B,?A,?f
PREMISE@2
EVERYWHERE2@injection
IFGOAL
MODUS_PONENS@((?2 << ?B) & ?1 << ?B) -> ((?f @ ?2) << ?A) & (?2 = ?1) = (?f @ ?2) = ?f @ ?1
NESTED_UNIV_HYP@6,?2,?1,0
IFGOAL
IFGOAL
MODUS_PONENS@((?f @ ?2) << ?A) & (?2 = ?1) = (?f @ ?2) = ?f @ ?1
MODUS_PONENS@(?2 << ?B) & ?1 << ?B
ANDHYP@5
ANDHYP@8
ANDHYP@12
ANDGOAL
PREMISE@13
PREMISE@9
PREMISE@7
ANDHYP@9
ANDHYP@5
ANDHYP@8
ANDHYP@12
HYP_PIVOT@10
HYP_PIVOT@14
EVERYWHERE2@REFLEX
IFGOAL
ANDHYP@15
HYP_PIVOT@17
AT
IFGOAL
HYP_PIVOT@6
ANDGOAL
MODUS_PONENS@(?1 << ?B) & injection@?B,?A,?f
ANDGOAL
ANDHYP@5
PREMISE@7
PREMISE@2
ANDHYP@5
HYP_REVPIVOT@8
USE_THM@INJECTION_RANGE
PREMISE@5
USE_THM@FUNCTION
IFGOAL
HYP_REVPIVOT@6
ANDHYP@5
PREMISE@7

prove "INJECTION_INVERSE_RANGE";

(* this is the same proof as the one above with changes in the last
two lines!! *)

s "((injection@?B,?A,?f)&?x<<?f/|?B)->?x=?f@(inverse@?A,?B,?f)@?x";

rri "IRULE1"; ri "IFGOAL"; ex();

ANDHYP@1
EVERYWHERE@inverse
MODUS_PONENS@?x << ?f /| ?B
PREMISE@3
USE_THM@LEFT@(RIGHT@IMAGE)**IN
USE_THM@IRULE2
IFGOAL
EXIST_HYP@4
MODUS_PONENS@?1=(function @ [((P1 @ ?2) << ?A) & ((P2 @ ?2) << ?B) & (?f @ P2 @ ?2) = P1 @ ?2]) @ ?x
MODUS_PONENS@(forall@[([((P1 @ ?3) << ?A) & ((P2 @ ?3) << ?B) & (?f @ P2 @ ?3) = P1 @ ?3]@?x,?2)==?2=?1])
EVERYWHERE2@EVAL
EVERYWHERE2@P1**P2
UNIV_GOAL
IFFGOAL
MODUS_PONENS@injection@?B,?A,?f
PREMISE@2
EVERYWHERE2@injection
IFGOAL
MODUS_PONENS@((?2 << ?B) & ?1 << ?B) -> ((?f @ ?2) << ?A) & (?2 = ?1) = (?f @ ?2) = ?f @ ?1
NESTED_UNIV_HYP@6,?2,?1,0
IFGOAL
IFGOAL
MODUS_PONENS@((?f @ ?2) << ?A) & (?2 = ?1) = (?f @ ?2) = ?f @ ?1
MODUS_PONENS@(?2 << ?B) & ?1 << ?B
ANDHYP@5
ANDHYP@8
ANDHYP@12
ANDGOAL
PREMISE@13
PREMISE@9
PREMISE@7
ANDHYP@9
ANDHYP@5
ANDHYP@8
ANDHYP@12
HYP_PIVOT@10
HYP_PIVOT@14
EVERYWHERE2@REFLEX
IFGOAL
ANDHYP@15
HYP_PIVOT@17
AT
IFGOAL
HYP_PIVOT@6
ANDGOAL
MODUS_PONENS@(?1 << ?B) & injection@?B,?A,?f
ANDGOAL
ANDHYP@5
PREMISE@7
PREMISE@2
ANDHYP@5
HYP_REVPIVOT@8
USE_THM@INJECTION_RANGE
PREMISE@5
USE_THM@FUNCTION
IFGOAL
HYP_REVPIVOT@6
ANDHYP@5
USE_THM@EQSYMM
PREMISE@8

prove "INJECTION_INVERSE";

(* this is really just a restatement of the definition of closure *)

s "((?B|=?A)&(?f/|?A)|=?A)->(closure@?B,?f)|=?A";

rri "IRULE1"; ri "IFGOAL"; ex();

ANDHYP@1
USE_THM@Subset
UNIV_GOAL
EVERYWHERE2@closure
USE_THM@LEFT@IN
USE_THM@IRULE2
USE_THM@LEFT@EVAL
IFGOAL
MODUS_PONENS@(((?f /| ?A) |= ?A) & ?B |= ?A) -> ?1 << ?A
UNIV_HYP@4
MODUS_PONENS@?1<<?A
MODUS_PONENS@((?f /| ?A) |= ?A) & ?B |= ?A
ANDGOAL
PREMISE@3
PREMISE@2
UNIV_HYP@4
USE_THM@NEWTAUT

prove "CLOSURE_LEMMA";

(* a big part of the problem with developing the following proof is
exactly that of defining the witnessing map; the power to define things
efficiently is a very important practical feature of one's logic! *)

(* Cantor-Schroder-Bernstein theorem *)

(* I'm forcing myself to use a correct style here; I'm proving lemmas
wherever I think a result might be re-used. *)

(*


*)

quit();  (* keep this here until following INPUT reasoning is finished *)

start "((?A<#=?B)&(?B<#=?A))==forsome@[bijection@?A,?B,?1]";

rri "BRULE1"; ex();

ri "IFFGOAL"; ex();

EVERYWHERE2@LESSOREQSIZE
EVERYWHERE2@bijection
IFGOAL
ANDHYP@1
EXIST_HYP@2
EXIST_HYP@3

EXIST_GOAL@[(?3<<closure@(?A--?2/|?B),[?2@?1@?4])||(?1@?3),(inverse@?A,?B,?2)@?3]

ANDGOAL

USE_THM@injection
UNIV_GOAL
UNIV_GOAL
IFGOAL
ANDHYP@6
ANDGOAL
USE_THM@UNEVAL_TAC@[?5<<?B]
UNEVAL_TAC@[|-?5]
left_case
MODUS_PONENS@(?3<<?A)&injection@?A,?B,?1
ANDGOAL
PREMISE@7
PREMISE@4
USE_THM@INJECTION_RANGE
up
$TAB_NOT_2
left_case
MODUS_PONENS@ ~ ?3<<?A--?2/|?B
MODUS_PONENS@ ~ ?3 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?5]
USE_THM@PREMISE@9
CONTRAPOSITIVE
USE_THM@SUBSET_OF_CLOSURE
EVERYWHERE2@SetDifference
right
left
right
IN
up
NRULE2
up
up
IFGOAL
NEGHYP@10
ANDGOAL
PREMISE@7
NEGHYP@11
MODUS_PONENS@(injection@?B,?A,?2)&?3<<?2/|?B
ANDGOAL
PREMISE@5
NEGHYP@12
PREMISE@13
USE_THM@INJECTION_INVERSE_RANGE
up
$CASEINTRO
PCASEINTRO@((?3 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?5]))
ALT_PUSH
ASRTCOND
PCASEINTRO@(?4 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?5])
ALT_PUSH
ASRTCOND
left_case
left_case
MODUS_PONENS@injection@?A,?B,?1
PREMISE@4
EVERYWHERE2@injection
IFGOAL
MODUS_PONENS@((?3 << ?A) & ?4 << ?A) -> ((?1 @ ?3) << ?B) & (?3 = ?4) = (?1 @ ?3) = ?1 @ ?4
NESTED_UNIV_HYP@11,?3,?4,0
IFGOAL
MODUS_PONENS@((?1 @ ?3) << ?B) & (?3 = ?4) = (?1 @ ?3) = ?1 @ ?4
MODUS_PONENS@((?3 << ?A) & ?4 << ?A)
ANDGOAL
PREMISE@7
PREMISE@8
PREMISE@12
USE_THM@NEWTAUT
up
$ASRTCOND
$TAB_NOT_2
ASRTCOND
left_case
USE_THM@RL@ASRTEQ
USE_THM@ $BCONV
IFFGOAL
IFGOAL
NEGHYP@10
HYP_PIVOT@11
PREMISE@9
IFGOAL
NEGHYP@10
MODUS_PONENS@?3=?2@?1@?4
HYP_REVPIVOT@11
MODUS_PONENS@(injection@?B,?A,?2)&?3<<?2/|?B
ANDGOAL
PREMISE@5
NEGHYP@10
MODUS_PONENS@?3<<?A--?2/|?B
USE_THM@IN
EVERYWHERE2@SetDifference
TWOASSERTS
USE_THM@EVAL
ANDGOAL
PREMISE@7
PREMISE@13
USE_THM@SUBSET_OF_CLOSURE
USE_THM@INJECTION_INVERSE
IFGOAL
HYP_PIVOT@13
MODUS_PONENS@?4 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?5]
PREMISE@9
goto@?2 @ ?1 @ ?4
BIND@?4
up
USE_THM@CLOSURE_IS_CLOSED
up
$CASEINTRO
up
$ASRTCOND
$TAB_NOT_2
ASRTCOND
left_case
left_case
USE_THM@RL@ASRTEQ
USE_THM@ $BCONV
IFFGOAL
IFGOAL
NEGHYP@9
HYP_REVPIVOT@11
PREMISE@10

IFGOAL
NEGHYP@9
MODUS_PONENS@?4=?2@?1@?3
HYP_PIVOT@11
MODUS_PONENS@(injection@?B,?A,?2)&?4<<?2/|?B
ANDGOAL
PREMISE@5
NEGHYP@9
MODUS_PONENS@?4<<?A--?2/|?B
USE_THM@IN
EVERYWHERE2@SetDifference
TWOASSERTS
USE_THM@EVAL
ANDGOAL
PREMISE@8
PREMISE@13
USE_THM@SUBSET_OF_CLOSURE
USE_THM@INJECTION_INVERSE
IFGOAL
HYP_PIVOT@13
MODUS_PONENS@?3 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?5]
PREMISE@10
goto@?2 @ ?1 @ ?3
BIND@?3
up
USE_THM@CLOSURE_IS_CLOSED
up
$ASRTCOND
$TAB_NOT_2
ASRTCOND
left_case
USE_THM@RL@ASRTEQ
USE_THM@ $BCONV
IFFGOAL
IFGOAL
HYP_PIVOT@11
USE_THM@REFLEX
MODUS_PONENS@?3<<?2/|?B
NEGHYP@10
MODUS_PONENS@?3<<?A--?2/|?B
USE_THM@IN
TWOASSERTS
USE_THM@LEFT@SetDifference
USE_THM@EVAL
ANDGOAL
PREMISE@7
PREMISE@11
USE_THM@SUBSET_OF_CLOSURE
IFGOAL
MODUS_PONENS@?4<<?2/|?B
NEGHYP@9
MODUS_PONENS@?4<<?A--?2/|?B
USE_THM@IN
TWOASSERTS
USE_THM@LEFT@SetDifference
USE_THM@EVAL
ANDGOAL
PREMISE@8
PREMISE@12
USE_THM@SUBSET_OF_CLOSURE
IFGOAL
MODUS_PONENS@?3=?2@(inverse @ ?A , ?B , ?2) @ ?3
MODUS_PONENS@(injection@?B,?A,?2)&?3<<?2/|?B
ANDGOAL
PREMISE@5
PREMISE@11
USE_THM@INJECTION_INVERSE
IFGOAL
MODUS_PONENS@?4=?2@(inverse @ ?A , ?B , ?2) @ ?4
MODUS_PONENS@(injection@?B,?A,?2)&?4<<?2/|?B
ANDGOAL
PREMISE@5
PREMISE@12
USE_THM@INJECTION_INVERSE
IFGOAL
IFGOAL
HYP_PIVOT@13
HYP_PIVOT@14
HYP_PIVOT@15
USE_THM@REFLEX
up
$CASEINTRO
up
$CASEINTRO

USE_THM@surjection
UNIV_GOAL
ANDGOAL
IFGOAL
PCASEINTRO@(?3 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?4])
ALT_PUSH
ASRTCOND
left_case
MODUS_PONENS@(?3<<?A)&injection@?A,?B,?1
ANDGOAL
PREMISE@6
PREMISE@4
USE_THM@INJECTION_RANGE
up
$ASRTCOND
$TAB_NOT_2
ASRTCOND
left_case
MODUS_PONENS@(injection@?B,?A,?2)&?3<<?2/|?B
ANDGOAL
PREMISE@5
NEGHYP@7
MODUS_PONENS@?3<<?A--?2/|?B
USE_THM@IN
TWOASSERTS
USE_THM@LEFT@SetDifference
USE_THM@EVAL




ANDGOAL
PREMISE@6
PREMISE@8
USE_THM@SUBSET_OF_CLOSURE
USE_THM@INJECTION_INVERSE_RANGE
up
$CASEINTRO
IFGOAL
EXIST_GOAL@(?3<<?1/|closure@(?A--?2/|?B),[?2@?1@?4])||((inverse@?B,?A,?1)@?3),?2@?3
PCASEINTRO@(?3<<?1/|closure@(?A--?2/|?B),[?2@?1@?4])
ALT_PUSH
ASRTCOND
left_case

MODUS_PONENS@?3<<?1/|?A
USE_THM@IN
TWOASSERTS
USE_THM@LEFT@IMAGE
USE_THM@EVAL
MODUS_PONENS@?3 << ?1 /| closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?4]
PREMISE@7
USE_THM@LEFT@IN
USE_THM@IRULE2
USE_THM@LEFT@LEFT@IMAGE
USE_THM@LEFT@EVAL
IFGOAL
EXIST_HYP@8
EXIST_GOAL@?4
ANDGOAL
ANDHYP@9
MODUS_PONENS@?4 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?5]
PREMISE@10
USE_THM@LEFT@IN
USE_THM@IRULE2
USE_THM@LEFT@LEFT@closure
USE_THM@LEFT@EVAL
IFGOAL
MODUS_PONENS@((([?2 @ ?1 @ ?5] /| ?A) |= ?A) & (?A -- ?2 /| ?B) |= ?A) -> ?4 << ?A
UNIV_HYP@12
MODUS_PONENS@?4<<?A
MODUS_PONENS@(([?2 @ ?1 @ ?5] /| ?A) |= ?A) & (?A -- ?2 /| ?B) |= ?A
ANDGOAL
USE_THM@Subset
UNIV_GOAL
USE_THM@LEFT@IN
USE_THM@IRULE2
USE_THM@LEFT@LEFT@IMAGE
USE_THM@LEFT@EVAL
IFGOAL
EXIST_HYP@13
ANDHYP@14
MODUS_PONENS@(?1@?6)<<?B
MODUS_PONENS@(?6<<?A)&injection@?A,?B,?1
ANDGOAL
PREMISE@15
PREMISE@4
USE_THM@INJECTION_RANGE
IFGOAL
MODUS_PONENS@((?1@?6)<<?B)&injection@?B,?A,?2
ANDGOAL
PREMISE@17
PREMISE@5
HYP_REVPIVOT@16
USE_THM@INJECTION_RANGE
USE_THM@Subset
UNIV_GOAL
USE_THM@LEFT@IN
USE_THM@IRULE2
USE_THM@LEFT@(LEFT@SetDifference)**EVAL
USE_THM@NEWTAUT
UNIV_HYP@12
USE_THM@NEWTAUT
ANDHYP@9
PREMISE@11
USE_THM@INJECTION_INVERSE_RANGE
IFGOAL

ANDGOAL
MODUS_PONENS@(injection@?A,?B,?1)&?3<<?1/|?A
ANDGOAL
PREMISE@4
PREMISE@8
USE_THM@INJECTION_INVERSE_RANGE
EVERYWHERE2@ASRTCOND
EVERYWHERE2@PREMISE@7
PCASEINTRO@ |- ((inverse @ ?B , ?A , ?1) @ ?3) << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?4]
ALT_PUSH
left_case
USE_THM@EQSYMM
MODUS_PONENS@(injection@?A,?B,?1)&?3<<?1/|?A
ANDGOAL
PREMISE@4
PREMISE@8
USE_THM@INJECTION_INVERSE
up
$ASRTCOND
$TAB_NOT_2
ASRTCOND
left_case  {this case cannot occur

NEGHYP@9
MODUS_PONENS@?3 << ?1 /| closure @ (?A -- ?2 /| ?B) , [?2 @ ?1@ ?4]
PREMISE@7
USE_THM@LEFT@IN
USE_THM@IRULE2
USE_THM@LEFT@LEFT@IMAGE
USE_THM@LEFT@EVAL
IFGOAL
EXIST_HYP@11
ANDHYP@12
MODUS_PONENS@?4=(inverse @ ?B , ?A , ?1) @ ?3
MODUS_PONENS@injection@?A,?B,?1
PREMISE@4
EVERYWHERE2@injection
IFGOAL
MODUS_PONENS@((?4 << ?A) & ((inverse @ ?B , ?A , ?1) @ ?3) << ?A) -> ((?1 @ ?4) << ?B) & (?4 = ((inverse @ ?B , ?A , ?1) @ ?3)) = (?1 @ ?4) = ?1 @ ((inverse @ ?B , ?A , ?1) @ ?3)  { I might want a better lemma to handle ?4<<?A
NESTED_UNIV_HYP@15,?4,((inverse @ ?B , ?A , ?1) @ ?3),0

MODUS_PONENS@((?1 @ ?4) << ?B) & (?4 = (inverse @ ?B , ?A , ?1) @ ?3) = (?1 @ ?4) = ?1 @ (inverse @ ?B , ?A , ?1) @ ?3

MODUS_PONENS@((?4 << ?A) & ((inverse @ ?B , ?A , ?1) @ ?3) << ?A)

ANDGOAL

MODUS_PONENS@(closure @ (?A -- ?2 /| ?B), [?2 @ ?1 @ ?5])|=?A

MODUS_PONENS@((?A -- ?2 /| ?B)|=?A)&([?2 @ ?1 @ ?5] /| ?A)|=?A

ANDGOAL

USE_THM@((?A--?B)|=?A)=true

USE_THM@Subset
UNIV_GOAL
USE_THM@LEFT@IN
USE_THM@IRULE2
USE_THM@LEFT@LEFT@IMAGE
USE_THM@LEFT@EVAL
IFGOAL
EXIST_HYP@16
MODUS_PONENS@(?1@?6)<<?B
MODUS_PONENS@(?6<<?A)&injection@?A,?B,?1
ANDGOAL
ANDHYP@17
PREMISE@18
PREMISE@4
USE_THM@INJECTION_RANGE
IFGOAL
MODUS_PONENS@((?1@?6)<<?B)&injection@?B,?A,?2
ANDGOAL
PREMISE@18
PREMISE@5
ANDHYP@17
HYP_REVPIVOT@20
USE_THM@INJECTION_RANGE
USE_THM@CLOSURE_LEMMA
EVERYWHERE2@Subset
IFGOAL
MODUS_PONENS@(?4 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?5]) -> ?4 << ?A
UNIV_HYP@16
MODUS_PONENS@?4 << closure @ (?A -- ?2 /| ?B) , [?2 @ ?1 @ ?5]
PREMISE@13
USE_THM@NEWTAUT

quit();










