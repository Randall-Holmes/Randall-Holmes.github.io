
(* ===================================================================== 
      FILE:        sets.mk2						 
      DESCRIPTION: a simple theory of sets
      DATE:        October 9, 1997			 
   ===================================================================== *)

script "logic_tools";

defineconstant "Set@?x" "[|-?x@?1]";

(* definetypedinfix "IN" 0 1 "?P << ?Q" "|-?Q@?P"; *)

defineinfix "SetEquiv" "?P === ?Q" "forall@[(?1<<?P) == ?1<<?Q]";

defineinfix "Union" "?P ++ ?Q" "[(?1<<?P) | ?1<<?Q]";

defineinfix "Intersection" "?P && ?Q" "[(?1<<?P) & ?1<<?Q]";

defineinfix "SetDifference" "?P -- ?Q" "[(?1<<?P) & ~ ?1<<?Q]";

defineinfix "Subset" "?P |= ?Q" "forall@[(?1<<?P) -> ?1<<?Q]";

defineinfix "Complement" "^?P" "[~ ?1<<?P]";

defineinfix "Psubset" "?P ||= ?Q" "(?P |= ?Q) & ~?P === ?Q";

defineinfix "Disjoint" "?P ||| ?Q" "(?P&&?Q) === [false]";



(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SETRETRACT:	
	----------
	Set @ Set @ ?x = 

	Set @ ?x
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "Set@Set@?x";
ri "EVERYWHERE @ Set"; ex();
right(); ri "TWOASSERTS"; ex();
up(); rri "Set"; ex();

p "SETRETRACT";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	TrueSet:	
	-------
	Set @ [true] = 

	[true]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "Set@[true]"; 
ri "Set"; ex();
right(); ri "AT"; ex();

p "TrueSet";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EmptySet:
	--------
	Set @ [false] = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "Set@[false]"; 
ri "Set"; ex();
right(); ri "AF"; ex();

p "EmptySet";


(*  MEMBERSHIP  *)

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	INBOOL:
	------
	?x << ?y = 

	bool : ?x << ?y
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?x << ?y";
ri "IN"; ex();
rri "TWOASSERTS"; ex();
rri "ASSERT2"; ex();
ri "RIGHT@ $IN"; ex();

p "INBOOL"; ex();


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InType:
	------
	?s << ?t = 

	?s << Set @ ?t
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s << ?t";
ri "IN"; ex();
rri "TWOASSERTS"; ex();
right();
ri "BIND@?s"; ex();
ri "LEFT@ $Set"; ex();
up();
rri "IN"; ex();

p "InType"; ex();


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ApplyIn:
	-------
	?a = 

	(IN ** RIGHT @ EVAL) => ?a
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?a";
ri "IN ** RIGHT@EVAL"; 

p "ApplyIn"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ReverseIn @ ?x:
	--------------
	|- ?a = 
	
	IN <= (RIGHT @ BIND @ ?x) => |- ?a
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "|-?a";
ri "RIGHT@BIND@?x"; 
rri "IN"; 

p "ReverseIn@?x"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InEmpty:
	-------
	?x << [false] = 

	false
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?x << [false]";
ri "ApplyIn"; ex();
ri "AF"; ex();

p "InEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InUniv:
	------
	?x << [true] = 
		
	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?x << [true]";
ri "ApplyIn"; ex();
ri "AT"; ex();

p "InUniv";


(* SET EQUIVALENCE *)

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EquivBool:
	---------
	?a === ?b = 

	bool : ?a === ?b
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?a === ?b";
ri "SetEquiv"; ex();
ri "FORALLBOOL"; ex();
ri "RIGHT@ $SetEquiv"; ex();

p "EquivBool"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EquivType:
	---------
	?s === ?t = 

	(Set @ ?s) === Set @ ?t
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s === ?t";
ri "SetEquiv"; ex();
right(); right();
ri "RL@InType"; ex();
top();
rri "SetEquiv"; ex();

p "EquivType"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EquivSymm:
	---------
	?a === ?b = 

	?b === ?a
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?a === ?b";
ri "SetEquiv"; ex();
right(); right();
ri "BSYM"; ex();
top();
rri "SetEquiv"; ex();

p "EquivSymm"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnivNotEmpty:
	------------
	[true] === [false] = 

	false
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[true]===[false]";
ri "SetEquiv"; ex();
right(); right();
ri "(LEFT@InUniv)**RIGHT@InEmpty"; ex();
ri "3pt15a"; ex();
rri "FDEF"; ex();
top();
ri "FORALLDROP**AF"; ex();

p "UnivNotEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EmptyNotUniv:
	--------------
	[false] === [true] = 

	false
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[false]===[true]";
ri "EquivSymm**UnivNotEmpty"; ex();

p "EmptyNotUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	NotEq:
	-----
	~ ?s === ?t = 

	forsome @ [(~ ?1 << ?s) == ?1 << ?t]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "~?s===?t";
ri "RIGHT@SetEquiv"; ex();
ri "FORSOME_NOTFORALL"; ex();
rri "NRULE1"; ex();
rri "FORSOMEDROP";ex();
right(); right(); 
ri "BDIS"; ex();

p "NotEq";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EqUniv:
	------
	?s === [true] = 
	
	forall @ [?1 << ?s]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s === [true]";
ri "SetEquiv"; ex();
right(); right();
ri "RIGHT @ InUniv"; ex();
ri "BID2"; ex();
rri "ASSERT2"; ex();
top();
ri "FORALLBOOL2"; ex();

p "EqUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	NotEqEmpty:
	----------
	~?s === [false] = 
	
	forsome @ [?1 << ?s]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "~?s === [false]";
right();
ri "SetEquiv"; ex();
right(); right();
ri "RIGHT @ InEmpty"; ex();
ri "3pt15a"; ex();
top();
rri "forsome2"; ex();

p "NotEqEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EqEmpty:
	-------
	?s === [false] = 

	forall @ [~ ?1 << ?s]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "forall@[~?1<<?s]";
ri "FORALLBOOL"; ex();
rri "DUBNEG"; ex();
ri "RIGHT@ $forsome2"; ex();
ri "RIGHT@ $NotEqEmpty"; ex();
ri "DUBNEG"; ex();
rri "EquivBool"; ex();
wb();

p "EqEmpty";


(* COMPLEMENT *)

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DubComplement:
	-------------
	 ^ ^?S = 

	Set @ ?S
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "^ ^?S";
ri "EVERYWHERE@Complement"; ex();
right();right();
ri "ApplyIn"; ex();
ri "RIGHT@(RIGHT@IN) ** NRULE2"; ex();
ri "NRULE1"; ex();
up();
ri "DUBNEG2"; ex();
up();
rri "Set"; ex();

p "DubComplement";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ComplEmpty:
	----------
	^ [false] = 

	[true]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "^[false]";
ri "Complement"; ex();
right();
ri "RIGHT @ InEmpty"; ex();
ri "NEGF"; ex();

p "ComplEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ComplUniv:
	---------
	^ [true] = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "^[true]";
ri "Complement"; ex();
right();
ri "RIGHT @ InUniv"; ex();
rri "FDEF"; ex();

p "ComplUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ComplEqUniv:
	-----------
	(^ ?s) === [true] = 

	forall @ [~ ?1 << ?s]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(^ ?s) === [true]";
ri "LEFT@Complement"; ex();
ri "SetEquiv"; ex();
right(); right();
ri "RIGHT@InUniv"; ex();
ri "BID2"; ex();
ri "RIGHT@ApplyIn"; ex();
ri "TWOASSERTS"; ex();
rri "ASSERT2"; ex();
top();
ri "FORALLBOOL2"; ex();

p "ComplEqUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ComplEq:
	-------	
	(^ ?a) === ^ ?b = 

	?a === ?b
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(^?a) === ^?b";
ri "RL@Complement"; ex();
ri "SetEquiv"; ex();
right(); right();
ri "RL@ApplyIn ** NRULE1"; ex();
rri "NEQ"; ex();
top();
rri "SetEquiv"; ex();

p "ComplEq"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EqCompl:
	-------
	?a === ^ ?b = 

	(^ ?a) === ?b
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?a === ^?b";
ri "RIGHT@Complement"; ex();
ri "SetEquiv"; ex();
right(); right();
ri "RIGHT@ApplyIn ** NRULE1"; ex();
rri "3pt11"; ex();
left();
rri "NRULE1"; ex();
ri "ReverseIn@?1"; ex();
top();
rri "SetEquiv"; ex();
ri "LEFT@ $Complement"; ex();

p "EqCompl";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ComplUniv_Empty:
	---------------
	(^ ?a) === [true] = 

	?a === [false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(^?a) === [true]";
rri "EqCompl"; ex();
ri "RIGHT@ComplUniv"; ex();

p "ComplUniv_Empty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ComplEmpty_Univ:
	---------------
	(^ ?a) === [false] = 

	?a === [true]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(^?a) === [false]";
rri "EqCompl"; ex();
ri "RIGHT@ComplEmpty"; ex();

p "ComplEmpty_Univ";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InCompl:
	-------	
	?x << ^ ?P = 

	~ ?x << ?P
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?x << ^?P";
ri "RIGHT@Complement"; ex();
ri "ApplyIn"; ex();
ri "NRULE1"; ex();

p "InCompl";


(*  UNION  *)

axiom "UnionType" "?P++?Q" "Set@(Set@?P)++Set@?Q";

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionScin:
	---------
	?P ++ ?Q = 

	(Set @ ?P) ++ Set @ ?Q
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P ++ ?Q";
ri "UnionType"; ex();
right(); ri "RL @ $SETRETRACT"; ex();
top(); rri "UnionType"; ex();

p "UnionScin"; 


(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionSymm:
	---------
	?P ++ ?Q = 

	?Q ++ ?P
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P++?Q";
ri "Union"; ex();
right(); ri "DSYM"; ex();
up(); rri "Union"; ex();

p "UnionSymm";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionAssoc:
	----------
	(?A ++ ?B) ++ ?C = 

	?A ++ ?B ++ ?C
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?A++?B)++?C";
ri "(LEFT@Union) ** Union"; ex();
right(); left(); 
ri "ApplyIn"; ex();
ri "DRULE1"; ex();
up();
ri "DASSOC"; ex();
rri "DRULE3"; ex();
right();
ri "ReverseIn@?1"; ex();
up();
rri "IN"; ex();
top();
rri "Union"; ex();
ri "RIGHT @ $Union"; ex();

p "UnionAssoc";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionIdem:
	---------
	?A ++ ?A = 

	Set @ ?A
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?A++?A";
ri "Union"; ex();
right(); ri "DIDEM"; ex();
ri "RIGHT @ IN"; ex();
ri "TWOASSERTS"; ex();
up(); rri "Set"; ex();

p "UnionIdem";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnivUnion:
	---------
	[true] ++ ?s = 

	[true]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[true] ++ ?s";
ri "Union"; ex();
right(); 
ri "LEFT @ InUniv"; ex();
ri "DSYM ** DZER"; ex();

p "UnivUnion";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionUniv:
	---------
	?s ++ [true] = 

	[true]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ++ [true]";
ri "UnionSymm ** UnivUnion"; ex();

p "UnionUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EmptyUnion:
	----------
	[false] ++ ?s = 

	Set @ ?s
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[false] ++ ?s";
ri "Union"; ex();
right(); 
ri "LEFT @ InEmpty"; ex();
ri "DSYM ** DID"; ex();
ri "(RIGHT @ IN) ** TWOASSERTS"; ex();
up(); 
rri "Set"; ex();

p "EmptyUnion";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionEmpty:
	----------
	?s ++ [false] = 

	Set @ ?s
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ++ [false]";
ri "UnionSymm ** EmptyUnion"; ex();

p "UnionEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionCompl:
	----------
	?S ++  ^?S = 

	[true]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?S ++ ^?S";
ri "RIGHT @ Complement"; ex();
ri "Union"; ex();
right();
ri "RIGHT@ApplyIn"; ex();
ri "DRULE3"; ex();
ri "DXM"; ex();

p "UnionCompl";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionEqEmpty:
	------------
	(?s ++ ?t) === [false] = 

	(?s === [false]) & ?t === [false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?s ++ ?t) === [false]";
ri "EqEmpty"; ex();
right(); right(); right();
ri "RIGHT@Union"; ex();
ri "ApplyIn"; ex();
ri "DRULE1"; ex();
up();
rri "DEMb"; ex();
top(); 
ri "FORALLDIST"; ex();
ri "RL@ $EqEmpty"; ex();

p "UnionEqEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionEqUniv:
	-----------
	(?S ++ ?T) === [true] = 

	forall @ [(~ ?1 << ?S) -> ?1 << ?T]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?S ++ ?T) === [true]";
ri "LEFT@Union"; ex();
ri "EqUniv"; ex();
right(); right();
ri "ApplyIn"; ex();
right();
rri "DRULE2"; ex();
ri "LEFT@ $DUBNEG2"; ex();
rri "IDEF2"; ex();
up();
ri "IRULE1"; ex();

p "UnionEqUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InUnion:
	-------
	?X << ?A ++ ?B = 

	(?X << ?A) | ?X << ?B
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?X << ?A++?B";
ri "RIGHT @ Union"; ex();
ri "ApplyIn"; ex();
ri "DRULE1"; ex();

p "InUnion";


(*  INTERSECTION  *)

axiom "InterType" "?P&&?Q" "Set@(Set@?P)&&Set@?Q";

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterScin:
	---------
	?P && ?Q = 

	(Set @ ?P) && Set @ ?Q
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P && ?Q";
ri "InterType"; ex();
right(); ri "RL @ $SETRETRACT"; ex();
top(); rri "InterType"; ex();

p "InterScin"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterSymm:
	---------
	?P && ?Q = 

	?Q && ?P
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P&&?Q";
ri "Intersection"; ex();
right(); ri "CSYM"; ex();
up();
rri "Intersection"; ex();

p "InterSymm";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterAssoc:
	----------
	(?A && ?B) && ?C = 

	?A && ?B && ?C
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?A&&?B)&&?C";
ri "EVERYWHERE@Intersection"; ex();
right(); left(); 
ri "ApplyIn"; ex();
ri "CRULE1"; ex();
up();
ri "CASSOC"; ex();
rri "CRULE3"; ex();
ri "RIGHT@ReverseIn@?1"; ex();
up();
rri "Intersection"; ex();
ri "RIGHT@ $Intersection"; ex();

p "InterAssoc";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterIdem:
	---------
	?A && ?A = 

	Set @ ?A
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?A&&?A";
ri "Intersection"; ex();
right();
ri "CIDEM"; ex();
ri "(RIGHT@IN)**TWOASSERTS"; ex();
up(); rri "Set"; ex();

p "InterIdem";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EmptyInter:
	----------
	[false] && ?s = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[false] && ?s";
ri "Intersection"; ex();
right(); 
ri "LEFT@InEmpty"; ex();
ri "CSYM ** CZER"; ex();

p "EmptyInter";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterEmpty:
	----------
	?s && [false] = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s && [false]";
ri "InterSymm ** EmptyInter"; ex();

p "InterEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnivInter:
	---------
	[true] && ?s = 

	Set @ ?s
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[true] && ?s";
ri "Intersection"; ex();
right(); 
ri "LEFT@InUniv"; ex();
ri "CSYM ** CID"; ex();
ri "(RIGHT@IN)**TWOASSERTS"; ex();
up(); rri "Set"; ex();

p "UnivInter";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterUniv:
	---------
	?s && [true] = 

	Set @ ?s
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s && [true]";
ri "InterSymm ** UnivInter"; ex();

p "InterUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterEqEmpty:
	------------
	(?S && ?T) === [false] = 

	forall @ [(?1 << ?S) -> ~ ?1 << ?T]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?S && ?T) === [false]";
ri "EqEmpty"; ex();
right(); right(); right();
ri "RIGHT@Intersection"; ex();
ri "ApplyIn"; ex();
up();
ri "NRULE2"; ex();
rri "DEMa"; ex();
rri "IDEF2"; ex();

p "InterEqEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterUnion:
	----------
	?A && ?B ++ ?C = 

	(?A && ?B) ++ ?A && ?C
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?A && ?B ++ ?C";
ri "RIGHT @ Union"; ex();
ri "Intersection"; ex();
right(); 
ri "RIGHT@ApplyIn ** DRULE1"; ex();
ri "CDISD"; ex();
rri "DRULE2"; ex();
rri "DRULE3"; ex();
ri "RL@ReverseIn@?1"; ex();
up();
rri "Union"; ex();
ri "RL@ $Intersection"; ex();

p "InterUnion";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionInter:
	----------
	?A ++ ?B && ?C = 

	(?A ++ ?B) && ?A ++ ?C
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?A ++ ?B && ?C";
ri "RIGHT @ Intersection"; ex();
ri "Union"; ex();
right();
ri "RIGHT@ApplyIn ** CRULE1"; ex();
ri "DDISC"; ex();
rri "CRULE2"; ex();
rri "CRULE3"; ex();
ri "RL@ReverseIn@?1"; ex();
up(); 
rri "Intersection"; ex();
ri "RL@ $Union"; ex();

p "UnionInter";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterCompl:
	----------
	?S &&  ^?S = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?S && ^?S";
ri "RIGHT @ Complement"; ex();
ri "Intersection"; ex();
right();
ri "RIGHT@ApplyIn ** NRULE1"; ex();
ri "CCON"; ex();

p "InterCompl";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DEMORGANa:
	---------
	 ^?S ++ ?T = 

	( ^?S) &&  ^?T
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "^(?S ++ ?T)";
ri "RIGHT @ Union"; ex();
ri "Complement"; ex();
right(); 
ri "RIGHT@ApplyIn ** DRULE1"; ex();
rri "DEMb"; ex();
rri "CRULE2"; ex();
rri "CRULE3"; ex();
ri "RL@ReverseIn@?1"; ex();
up();
rri "Intersection"; ex();
ri "RL @ $Complement"; ex();

p "DEMORGANa";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DEMORGANb:
	---------
	 ^?S && ?T = 

	( ^?S) ++  ^?T
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "^(?S && ?T)";
ri "RIGHT @ Intersection"; ex();
ri "Complement"; ex();
right();
ri "(RIGHT@ApplyIn) ** NRULE2"; ex();
rri "DEMa"; ex();
rri "DRULE2"; ex();
rri "DRULE3"; ex();
ri "RL@ReverseIn@?1"; ex();
up();
rri "Union"; ex();
ri "RL @ $Complement"; ex();

p "DEMORGANb";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionUniv_InterEmpty:
	--------------------
	((?S ++ ?T) === [true]) & (?S && ?T) === [false] = 

	?S ===  ^?T
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "((?S ++ ?T) === [true]) & (?S && ?T) === [false]";
ri "LEFT @ UnionEqUniv"; ex();
ri "RIGHT @ InterEqEmpty"; ex();
rri "FORALLDIST"; ex();
right(); right();
left();
ri "CONTP";ex();
ri"RIGHT@DUBNEG2"; ex();
ri "IRULE3"; ex();
up();
ri "3pt80"; ex();
ri "BSYM"; ex();
ri "RIGHT@ $InCompl"; ex();
top();
rri "SetEquiv"; ex();

p "UnionUniv_InterEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InInter:
	-------
	?X << ?A && ?B = 

	(?X << ?A) & ?X << ?B
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?X << ?A&&?B";
ri "RIGHT @ Intersection"; ex();
ri "ApplyIn ** CRULE1"; ex();

p "InInter";


(*  DIFFERENCE  *)

axiom "DiffType" "?P--?Q" "Set@(Set@?P)--Set@?Q";

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffScin:
	--------
	?P -- ?Q = 
	
	(Set @ ?P) -- Set @ ?Q
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P -- ?Q";
ri "DiffType"; ex();
right(); ri "RL @ $SETRETRACT"; ex();
top(); rri "DiffType"; ex();

p "DiffScin"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DubDiff:
	--------
	(?A -- ?B) -- ?B = 

	?A -- ?B
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?A--?B)--?B";
ri "EVERYWHERE @ SetDifference"; ex();
right();
ri "LEFT@ApplyIn ** CRULE1"; ex();
ri "CASSOC"; ex();
ri "RIGHT @ (CIDEM ** NRULE1)"; ex();
top(); rri "SetDifference"; ex();

p "DubDiff";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffEmpty:
	---------
	?s -- [false] = 

	Set @ ?s
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s -- [false]";
ri "SetDifference"; ex();
right(); 
ri "RIGHT@RIGHT@InEmpty"; ex();
ri "RIGHT @ NEGF"; ex();
ri "CID"; ex();
ri "RIGHT@IN"; ex();
ri "TWOASSERTS"; ex();
up(); rri "Set"; ex();

p "DiffEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EmptyDiff:
	---------
	[false] -- ?s = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[false] -- ?s";
ri "SetDifference"; ex();
right(); 
ri "LEFT@InEmpty"; ex();
ri "CSYM ** CZER"; ex();

p "EmptyDiff";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffUniv:
	--------
	?s -- [true] = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s -- [true]";
ri "SetDifference"; ex();
right(); 
ri "RIGHT@RIGHT@InUniv"; ex();
ri "RIGHT @ $FDEF"; ex();
ri "CZER"; ex();

p "DiffUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnivDiff:
	--------
	[true] -- ?S = 

	 ^?S
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[true] -- ?S";
ri "SetDifference"; ex();
right();
ri "LEFT@InUniv"; ex();
ri "CSYM ** CID"; ex();
ri "NRULE1"; ex();
up();
rri "Complement"; ex();

p "UnivDiff";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffIdem:
	--------
	?s -- ?s = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s -- ?s";
ri "SetDifference"; ex();
right(); ri "CCON"; ex();

p "DiffIdem";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffSymm:
	--------
	(?s -- ?x) -- ?y = 

	(?s -- ?y) -- ?x
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?s -- ?x) -- ?y";
ri "EVERYWHERE @ SetDifference"; ex();
right(); 
ri "LEFT@ApplyIn ** CRULE1"; ex();
ri "CASSOC"; ex(); 
ri "RIGHT @ CSYM"; ex();
rri "CASSOC"; ex();
left();
rri "CRULE1"; ex();
ri "ReverseIn@?1"; ex();
top(); 
rri "SetDifference"; ex();
ri "LEFT @ $SetDifference"; ex();

p "DiffSymm";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffInter:
	---------
	(?s -- ?x) && ?t = 

	(?s && ?t) -- ?x
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?s -- ?x) && ?t";
ri "LEFT @ SetDifference"; ex();
ri "Intersection"; ex();
right(); 
ri "LEFT@ApplyIn ** CRULE1"; ex();
ri "CASSOC ** RIGHT@CSYM"; ex();
rri "CASSOC"; ex();
rri "CRULE2"; ex();
ri "LEFT@ReverseIn@?1"; ex();
top(); 
rri "SetDifference"; ex();
ri "LEFT@ $Intersection"; ex();

p "DiffInter";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Diff_InterCompl:
	---------------
	?S -- ?T = 

	?S &&  ^?T
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?S -- ?T";
ri "SetDifference"; ex();
right(); right();
rri "InCompl"; ex();
top();
rri "Intersection"; ex();

p "Diff_InterCompl";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterDiff_Empty:
	---------------
	?S && ?T -- ?S = 

	[false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?S && ?T -- ?S";
ri "RIGHT @ SetDifference"; ex();
ri "Intersection"; ex();
right(); 
ri "RIGHT@ApplyIn **CRULE1"; ex();
ri "CSYM ** CASSOC"; ex();
ri "RIGHT @ (CSYM ** CCON)"; ex();
ri "CZER"; ex();

p "InterDiff_Empty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionDiff_absorption:
	--------------------
	?S ++ ?T -- ?S = 

	?S ++ ?T
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?S ++ ?T -- ?S";
ri "RIGHT @ SetDifference"; ex();
ri "Union"; ex();
right(); 
ri "RIGHT@ApplyIn ** CRULE1"; ex();
ri "RIGHT @ CSYM"; ex();
ri "3pt44b"; ex();
up();
rri "Union"; ex();

p "UnionDiff_absorption";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffUnion:
	---------
	?S -- ?T ++ ?R = 

	(?S -- ?T) && ?S -- ?R
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?S -- ?T ++ ?R";
ri "RIGHT @ Union"; ex();
ri "SetDifference"; ex();
right(); right(); 
ri "RIGHT@ApplyIn ** DRULE1"; ex();
rri "DEMb"; ex();
up();
ri "CDISC"; ex();
rri "CRULE2"; ex();
rri "CRULE3"; ex();
ri "RL@ReverseIn@?1"; ex();
top();
rri "Intersection"; ex();
ri "RL @ $SetDifference"; ex();

p "DiffUnion";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffInter_Union:
	---------------
	?S -- ?T && ?R = 

	(?S -- ?T) ++ ?S -- ?R
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?S -- ?T && ?R";
ri "RIGHT @ Intersection"; ex();
ri "SetDifference"; ex();
right(); right(); 
ri "RIGHT@ApplyIn ** CRULE1"; ex();
rri "DEMa"; ex();
up();
ri "CDISD"; ex();
rri "DRULE2"; ex();
rri "DRULE3"; ex();
ri "RL@ReverseIn@?1"; ex();
top();
rri "Union"; ex();
ri "RL @ $SetDifference"; ex();

p "DiffInter_Union";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InDiff:
	------
	?x << ?A -- ?B = 

	(?x << ?A) &  ~?x << ?B
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?x << ?A--?B";
ri "RIGHT @ SetDifference"; ex();
ri "ApplyIn ** CRULE1"; ex();

p "InDiff";


(*  SUBSET  *)

axiom "SubsetType" "?P|=?Q" "Set@(Set@?P)|=Set@?Q";

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetScin:
	----------
	?P |= ?Q = 

	(Set @ ?P) |= Set @ ?Q
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P |= ?Q";
ri "SubsetType"; ex();
right(); ri "RL @ $SETRETRACT"; ex();
top(); rri "SubsetType"; ex();

p "SubsetScin"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	FORALL_3pt82a:
	-------------
	((forall @ [(?P @ ?1) -> ?Q @ ?1]) & forall @ [(?Q @ ?1) -> ?R @ ?1]) 
	-> forall @ [(?P @ ?1) -> ?R @ ?1] = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

initializecounter();
s "((forall @ [(?P @ ?1) -> ?Q @ ?1]) & forall @ [(?Q @ ?1) -> ?R @ ?1]) -> forall @ [(?P @ ?1) -> ?R @ ?1]";
ri "LEFT@ $FORALLDIST";ex();
ri "LEFT@forall";ex();
ri "IMPTOCOND";ex();
right();right();left();right();right();rri "IRULE1";ex();
rri "ILID";ex();
left();ri "BIND@?1";ex();
left();rri "0|-|1";ex();
up();ri "EVAL";ex();
up();ri "3pt82a";ex();
up();up();ri "FORALLDROP**AT";ex();
up();up();rri "CASEINTRO";ex();
up();ri "AT";ex();

p "FORALL_3pt82a";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetTrans:
	-----------
	((?A |= ?B) & ?B |= ?C) -> ?A |= ?C = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "((?A|=?B) & ?B|=?C) -> ?A|=?C";
ri "EVERYWHERE @ Subset"; ex();
ri "FORALL_3pt82a"; ex();

p "SubsetTrans";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetIdem:
	----------
	?A |= ?A = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?A|=?A";
ri "Subset"; ex();
right(); right(); ri "IREF"; ex();
top(); ri "FORALLDROP ** AT"; ex();

p "SubsetIdem";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetAntisym:
	-------------
	((?A |= ?B) & ?B |= ?A) -> ?A === ?B = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "((?A|=?B) & ?B|=?A) -> ?A === ?B";
left(); ri "RL @ Subset"; ex();
rri "FORALLDIST"; ex();
right(); right(); ri "3pt80"; ex();
up(); up(); rri "SetEquiv"; ex();
up(); ri "IREF"; ex();

p "SubsetAntisym";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EmptySubset:	
	-----------
	[false] |= ?s = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[false] |= ?s";
ri "Subset"; ex();
right(); right();
ri "LEFT@InEmpty"; ex();
ri "3pt75"; ex();
top(); ri "FORALLDROP ** AT"; ex();

p "EmptySubset";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetEmpty:
	-----------
	?s |= [false] = 

	?s === [false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s |= [false]";
ri "Subset"; ex();
right(); right();
ri "IDEF"; ex();
left();
ri "RIGHT@InEmpty"; ex();
ri "DID"; ex();
up();
ri "BRULE2"; ex();
top(); rri "SetEquiv"; ex();

p "SubsetEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetUniv:
	----------
	?s |= [true] = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s |= [true]";
ri "Subset"; ex();
right(); right();
ri "RIGHT@InUniv"; ex();
ri "IRZER"; ex();
top(); ri "FORALLDROP ** AT"; ex();

p "SubsetUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnivSubset:
	----------
	[true] |= ?s = 

	?s === [true]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[true] |= ?s";
ri "Subset"; ex();
right(); right();
ri "IDEF3"; ex();
left();
ri "LEFT@InUniv"; ex();
ri "CSYM**CID"; ex();
up();
ri "BRULE2"; ex();
top(); rri "SetEquiv"; ex();

p "UnivSubset";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Subset_UnionAbsorption:
	-----------------------
	?s |= ?t = 

	(?s ++ ?t) === ?t
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?s ++ ?t) === ?t";
ri "LEFT @ Union"; ex();
ri "SetEquiv"; ex();
right(); right();
ri "LEFT@ApplyIn ** DRULE1"; ex();
rri "IDEF"; ex();
top(); rri "Subset"; ex();
wb();

p "Subset_UnionAbsorption";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetUnion:
	-----------
	?s |= ?s ++ ?t = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s |= ?s++?t";
ri "RIGHT @ Union"; ex();
ri "Subset"; ex();
right(); right();
ri "RIGHT@ApplyIn ** DRULE1"; ex();
ri "3pt76a"; ex();
top(); ri "FORALLDROP ** AT"; ex();

p "SubsetUnion";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetUnionSymm:
	---------------
	?s |= ?t ++ ?s = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s |= ?t++?s";
ri "RIGHT @ UnionSymm"; ex();
ri "SubsetUnion"; ex();

p "SubsetUnionSymm";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterSubset:
	-----------
	(?s && ?t) |= ?s = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?s && ?t) |= ?s";
ri "LEFT @ Intersection"; ex();
ri "Subset"; ex();
right(); right();
ri "LEFT@ApplyIn ** CRULE1"; ex();
ri "3pt76b"; ex();
top(); ri "FORALLDROP ** AT"; ex();

p "InterSubset";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	InterSymmSubset:
	----------------
	(?t && ?s) |= ?s = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?t && ?s) |= ?s";
ri "LEFT @ InterSymm"; ex();
ri "InterSubset"; ex();

p "InterSymmSubset";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Subset_InterAbsorption:
	-----------------------
	?s |= ?t = 

	(?s && ?t) === ?s
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s |= ?t";
ri "Subset"; ex();
right(); right();
ri "IDEF3"; ex();
left();
rri "CRULE1"; ex();
ri "ReverseIn@?1"; ex();
top(); 
rri "SetEquiv"; ex();
ri "LEFT @ $Intersection"; ex();

p "Subset_InterAbsorption";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffSubset:
	-----------
	(?s -- ?x) |= ?s = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?s -- ?x) |= ?s";
ri "LEFT @ SetDifference"; ex();
ri "Subset"; ex();
right(); right();
ri "LEFT@ApplyIn ** CRULE1"; ex();
ri "3pt76b"; ex();
top(); ri "FORALLDROP ** AT"; ex();

p "DiffSubset";


(*  PROPER SUBSET  *)

axiom "PsubsetType" "?P||=?Q" "Set@(Set@?P)||=Set@?Q";

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	PsubsetScin:
	-----------
	?P ||= ?Q = 
	
	(Set @ ?P) ||= Set @ ?Q
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P ||= ?Q";
ri "PsubsetType"; ex();
right(); ri "RL @ $SETRETRACT"; ex();
top(); rri "PsubsetType"; ex();

p "PsubsetScin"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	PsubsetIdem:
	-----------
	?s ||= ?s = 

	false
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ||= ?s";
ri "Psubset"; ex();
ri "LEFT @ SubsetIdem"; ex();
ri "CSYM ** CID"; ex();
right(); right();
ri "SetEquiv"; ex();
right(); right();
ri "BID"; ex();
up(); up();
ri "FORALLDROP ** AT"; ex();
up(); rri "FDEF"; ex();
up(); ri "AF"; ex();

p "PsubsetIdem";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	PsubsetEmpty:
	------------
	?s ||= [false] = 

	false
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ||= [false]";
ri "Psubset"; ex();
ri "LEFT @ SubsetEmpty"; ex();
ri "CCON"; ex();

p "PsubsetEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EmptyPsubset:
	------------
	[false] ||= ?s = 

	~ ?s === [false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[false] ||= ?s";
ri "Psubset"; ex();
ri "LEFT @ EmptySubset"; ex();
ri "CSYM**CID"; ex();
ri "NRULE1"; ex();
ri "RIGHT@EquivSymm";ex();

p "EmptyPsubset";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnivPsubset:
	-----------
	[true] ||= ?s = 

	false
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[true] ||= ?s";
ri "Psubset"; ex();
left(); ri "UnivSubset ** SetEquiv"; ex();
right(); right();
ri "BSYM"; ex();
up(); up(); rri "SetEquiv"; ex();
top(); ri "CCON"; ex();

p "UnivPsubset";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	PsubsetUniv:
	-----------
	?s ||= [true] = 

	forsome @ [~ ?1 <<< ?s]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ||= [true]";
ri "Psubset"; ex();
ri "LEFT @ SubsetUniv"; ex();
ri "CSYM ** CID"; ex();
ri "NRULE1"; ex();
ri "RIGHT@EqUniv"; ex();
ri "FORSOME_NOTFORALL"; ex();

p "PsubsetUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	PsubsetSubset:
	-------------
	(?S ||= ?T) -> ?S |= ?T = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?S ||= ?T) -> ?S |= ?T";
ri "LEFT @ Psubset"; ex();
ri "3pt76b"; ex();

p "PsubsetSubset";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	PsubsetNotSubset:
	----------------
	(?S ||= ?T) ->  ~?T |= ?S = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?S ||= ?T) -> ~?T |= ?S";
ri "LEFT @ Psubset"; ex();
ri "IDEF2"; ex();
ri "LEFT @ $DEMa"; ex();
ri "DASSOC ** (RIGHT @ DSYM) ** $DASSOC"; ex();
ri "LEFT @ DEMa"; ex();
ri "(RIGHT @ DUBNEG2) ** DRULE3"; ex();
rri "IDEF2"; ex();
ri "SubsetAntisym"; ex();

p "PsubsetNotSubset";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SubsetNotPsubset:
	----------------
	(?S |= ?T) ->  ~?T ||= ?S = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?S |= ?T) -> ~?T ||= ?S";
ri "CONTP"; ex();
ri "(LEFT @ DUBNEG2) ** IRULE2"; ex();
ri "PsubsetNotSubset"; ex();

p "SubsetNotPsubset";



(*  DISJOINT  *)

axiom "DisjType" "?P|||?Q" "Set@(Set@?P)|||Set@?Q";

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DisjScin:
	--------
	?P ||| ?Q = 

	(Set @ ?P) ||| Set @ ?Q
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P ||| ?Q";
ri "DisjType"; ex();
right(); ri "RL @ $SETRETRACT"; ex();
top(); rri "DisjType"; ex();

p "DisjScin"; 


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DisjSymm:
	--------
	?s ||| ?t = 

	?t ||| ?s
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ||| ?t"; ex();
ri "Disjoint"; ex();
ri "LEFT @ InterSymm"; ex();
rri "Disjoint"; ex();

p "DisjSymm";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnivDisj:
	--------
	[true] ||| ?s = 

	?s === [false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[true]|||?s";
ri "Disjoint"; ex(); 
ri "LEFT @ UnivInter"; ex();
ri "RIGHT@ $EmptySet"; ex();
rri "EquivType"; ex();

p "UnivDisj";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DisjUniv:
	--------
	?s ||| [true] = 

	?s === [false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s|||[true]";
ri "DisjSymm ** UnivDisj"; ex(); 

p "DisjUniv";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	EmptyDisj:
	---------
	[false] ||| ?s = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "[false]|||?s";
ri "Disjoint"; ex(); 
ri "LEFT @ EmptyInter"; ex();
ri "SetEquiv"; ex();
right(); right();
ri "BID"; ex();
top(); ri "FORALLDROP ** AT"; ex();

p "EmptyDisj";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DisjEmpty:
	---------
	?s ||| [false] = 

	true
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ||| [false]";
ri "DisjSymm ** EmptyDisj"; ex(); 

p "DisjEmpty";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DisjIdem:
	--------
	?s ||| ?s = 

	?s === [false]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ||| ?s";
ri "Disjoint"; ex();
ri "LEFT @ InterIdem"; ex();
ri "RIGHT@ $EmptySet"; ex();
rri "EquivType"; ex();

p "DisjIdem";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Disj_NotForsome:
	---------------
	?s ||| ?t = 

	~ forsome @ [(?1 << ?s) & ?1 << ?t]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?s ||| ?t";
ri "Disjoint"; ex();
ri "LEFT @ Intersection"; ex();
ri "EqEmpty"; ex();
right(); right();
ri "RIGHT@ApplyIn ** CRULE1"; ex();
top();
rri "FORALL_NOTFORSOME"; ex();

p "Disj_NotForsome";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	UnionDisj:
	---------
	(?s ++ ?t) ||| ?u = 

	(?s ||| ?u) & ?t ||| ?u
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?s ++ ?t) ||| ?u";
ri "LEFT @ Union"; ex();
ri "Disjoint"; ex();
left(); ri "Intersection"; ex();
right();
ri "LEFT@ApplyIn ** DRULE1"; ex();
ri "CSYM ** CDISD"; ex();
rri "DRULE2"; ex();
rri "DRULE3"; ex();
ri "RL@ReverseIn@?1"; ex();
up();
rri "Union"; ex();
ri "RL @ $Intersection"; ex();
top(); 
ri "UnionEqEmpty"; ex();
ri "RL @ $Disjoint"; ex();
ri "RL @ DisjSymm"; ex();

p "UnionDisj";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DiffSymmDisj:
	------------
	(?s -- ?x) ||| ?t = 

	(?t -- ?x) ||| ?s
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "(?s -- ?x) ||| ?t";
ri "LEFT @ SetDifference"; ex();
ri "Disjoint"; ex();
left(); ri "Intersection"; ex();
right(); 
ri "LEFT@ApplyIn ** CRULE1"; ex();
ri "CASSOC"; ex();
ri "RIGHT @ CSYM"; ex();
ri "CSYM"; ex();
rri "CRULE2"; ex();
ri "LEFT@ReverseIn@?1"; ex();
up(); 
rri "Intersection"; ex();
ri "LEFT @ $SetDifference"; ex();
top(); rri "Disjoint"; ex();

p "DiffSymmDisj";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SetEquiv2:
	---------
	?P === ?Q = 

	forall @ [(?P @ ?1) == ?Q @ ?1]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P === ?Q";
ri "SetEquiv"; ex();
right();right();
ri "RL@IN"; ex();
ri "BRULE2**BRULE3"; ex();

p "SetEquiv2";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Union2:
	------
	?P ++ ?Q = 

	[(?P @ ?1) | ?Q @ ?1]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P ++ ?Q";
ri "Union"; ex();
right();
ri "RL@IN"; ex();
ri "DRULE2**DRULE3"; ex();

p "Union2";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Intersection2:
	-------------
	?P && ?Q = 

	[(?P @ ?1) & ?Q @ ?1]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P && ?Q";
ri "Intersection"; ex();
right();
ri "RL@IN"; ex();
ri "CRULE2**CRULE3"; ex();

p "Intersection2";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	SetDifference2:
	--------------
	?P -- ?Q = 

	[(?P @ ?1) & ~ ?Q @ ?1]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P -- ?Q";
ri "SetDifference"; ex();
right();
ri "EVERYWHERE@IN"; ex();
ri "CRULE2**RIGHT@NRULE2"; ex();

p "SetDifference2";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Subset2:
	-------
	?P |= ?Q = 

	forall @ [(?P @ ?1) -> ?Q @ ?1]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "?P |= ?Q";
ri "Subset"; ex();
right();right();
ri "RL@IN"; ex();
ri "IRULE2**IRULE3"; ex();

p "Subset2";


(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Complement2:
	-----------
	^ ?P = 

	[~ ?P @ ?1]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

s "^?P";
ri "Complement"; ex();
right();
ri "RIGHT@IN"; ex();
ri "NRULE2"; ex();

p "Complement2";






quit();