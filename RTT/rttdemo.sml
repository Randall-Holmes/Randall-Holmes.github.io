(* demonstration file for RTT typechecker *)

(* Jan 16:

It is now feasible to actually execute this file, if
rtt.sml has been compiled.  The programs Test and Test2
now display the term entered and wait for the user to enter
input before displaying the type results.

There are some new Test2 examples.  I'm interested in the testing of
complex propositions with the ostensibly complete checker -- examples
from readers are very welcome!

*)

(* Jan 15:  

the Test and Test2 checkers have been updated.
Test now includes a label on the type it reports (called
"unconditional type"); Test2 now includes what should be a complete
type-checker for RTT -- it reports the unconditional type (output
of the original algorithm) plus the new "conditional type" which
requires the stated conditions for correctness. 

Outputs in this file have NOT been updated to reflect this,
so it is worth running the commands again (especially the Test2
examples).
*)

(* due to version changes, reported outputs may differ
from what the latest version gives you. *)

(* Some example propositional functions to type are taken from the
unpublished paper of Kamareddine, Nederpelt, and Laan, and in some 
of the comments I refer to the numbered examples or parts of examples
in the paper from which the pfs are taken.  It is not necessary
to have their paper to understand what I am doing. It is a good idea
to read my draft paper's discussion of syntax and variable binding
conventions.  *)

(* the syntax *)

(* 

<proposition> differs from <pf> only in that it can contain
propositional variables.  Eventually, there will be a requirement
that <pf>'s contain at least one free variable (xi) as well as no
propositional variables <pi>

(* propositional variable *)

(* propositional variables were introduced because of the demands
of proof checking *)

<propvar>  p1, p2, p3...

(* variable *)

<var>  x1, x2, x3...

(* individual constant *)

<ind>  a1, a2, a3...

(* binary propositional connective *)

<binary> -- any nonempty string of lower case letters 

(* relation symbol *)

<rel> any nonempty string of upper case letters followed by a numeral
--R2 is a relation symbol of arity 2.

(* quantifier *)

<quant>  any string of upper case letters (including the empty string)

(* atomic terms *)

<atom>  either <var> or <ind>

(* general terms *)

<term> = <var> or <ind> or <pf> where <pf> is a <proposition>
        as below in which no propositional variable can appear,
        and in which it will eventually be required that there
        be a free variable (this requirement is not now implemented,
        and probably will be implemented as something the user can
        turn on and off; the effect will be to eliminate proposition
        types as constituents of pf types, while still allowing
        proposition types as types of propositions themselves)

(* propositions *)

<proposition> =  <propvar>  propositional variable -- example:  p1

                 <rel>(<atom>,...,<atom>)  The number of arguments
                        must agree with the arity of the relation symbol
                        elementary sentence example:
                        R3(a3,x1,a2)

                 ~<proposition>  negation example:  ~p5

                 (<proposition><binary><proposition>)  
                        binary propositional connective example: (p1 v p2)

                        There is no order of operations 
                        -- parentheses are mandatory

                 [<quant><var>]<proposition>  The proposition must
                       contain a free occurrence of the variable.

                        quantified proposition example:
                        [x1]R2(x3,x1)

                 <var>(<term>,...,<term>)

                 <var>!(<term>,...,<term>)

                        propositional variable application examples:

                        x1(a1,x2,x1(x2)), x1!(a1,x2,x1(x2))

                        The exclamation point indicates that the
                        order of the pf represented by the variable
                        is exactly one higher than the maximum of the
                        orders of the arguments; it does not indicate
                        (as it would for Russell and Whitehead) that
                        the type of the pf represented by the variable
                        is actually predicative, but it will be predicative
                        if its argument types are predicative.

*)

(* Test takes a proposition or pf as argument and reports typing of
variables in the proposition at the three stages of the algorithm,
then reports the final type of the proposition or pf.

?!? signals ill-typedness.

Orders are supplied only where they are nontrivial (where the order
is the smallest permitted by the types of its constituents, it is not
given).  |xi| is the unknown order of the polymorphic type of the
variable xi.

Test2 is as Test, but further reports (in the case of a proposition in
which all pf arguments are typable by this algorithm, but which this
algorithm cannot type), additional conditions (if there are any) under
which the proposition or pf could be typed.  This report is currently
(and perhaps inevitably) quite long.  The report is now shorter (usually)
as of second revision Jan 11, and also Test2 will sometimes report
some information about typable terms as well.

The function Typecheck will just return the type of a pf (taking its
string representation as an argument).

*)

(* examples *)

Typecheck "p1";

(* > val it = "()" : string *)

Typecheck "x1!(a1)";

(* > val it = "((0))" : string *)

(* in the next example, the order of the type of x1
is indeterminate (anything higher than 1 is possible) *)

Typecheck "x1(a1)";

(* > val it = "((0)^max(|x1|,1))" : string *)

(* examples from the paper *)

(* the stages of variable typing reported by Test2 are

basic list:  types derived from syntax of the term.

unification list: additional type judgements derived by unification.
It's useful to be aware that a failure of unification is usually
signalled by the assignment of the nonsense type ?!? to the variable
x0 in the unification list.

final type list:  judgments obtained by the rewriting of the unified
type list using each of the assignments in the list.

See the paper for more discussion.
*)

(* pfs from example 21 *)

Test2 "R1(x1)";

(* 

basic list:

x1:  0

unification list:

x1:  0

final type list:

x1:  0

(0)

*)

(* this is also the term typed in example 32 *)

Test2 "x3(R1(x1),S1(a1))";

(*


basic list:

x1:  0
x3:  ((0),())^max(|x3|,2)
x3:  [x3]



unification list:

x1:  0
x3:  ((0),())^max(|x3|,2)
x3:  [x3]



final type list:

x1:  0
x3:  ((0),())^max(|x3|,2)

(((0),())^max(|x3|,2))

*)

(* it seems more appropriate to use the 
"predicative" version, and I'll do this in subsequent
examples from the paper *)

Test2 "x3!(R1(x1),S1(a1))";

(*

basic list:

x1:  0
x3:  ((0),())
x3:  [x3]



unification list:

x1:  0
x3:  ((0),())
x3:  [x3]



final type list:

x1:  0
x3:  ((0),())

(((0),()))


*)

Test2 "(x1!(a1) v x2!())";

(*
basic list:

x1:  (0)
x1:  [x1]
x2:  ()
x2:  [x2]



unification list:

x1:  (0)
x1:  [x1]
x2:  ()
x2:  [x2]



final type list:

x1:  (0)
x2:  ()

((0),())
*)


Test2 "x3!(x2!(R1(x1)))";

(*

basic list:

x1:  0
x2:  ((0))
x3:  ((((0))))
x3:  [x3]



unification list:

x1:  0
x2:  ((0))
x3:  ((((0))))
x3:  [x3]



final type list:

x1:  0
x2:  ((0))
x3:  ((((0))))

(((((0)))))


*)

Test2 "[x1]R1(x1)";

(*
basic list:

x1:  0



unification list:

x1:  0



final type list:

x1:  0

()^1
*)

(* example 24 *)

(* I type the following term in the form with unbounded order first --
notice that while the type of x3 does not appear as a polymorphic type
[x3] (we know quite a lot about this type) its order |x3| is unknown
and appears as a variable, though we do know that it is greater than
or equal to 2 and greater than or equal to the polymorphic order
|x2|+1. *)

Test2 "x3(S1(x1),x2,a2)";

(*

basic list:

x1:  0
x2:  [x2]
x3:  ((0),[x2],0)^max(|x2|+1,|x3|,2)
x3:  [x3]



unification list:

x1:  0
x2:  [x2]
x3:  ((0),[x2],0)^max(|x2|+1,|x3|,2)
x3:  [x3]



final type list:

x1:  0
x2:  [x2]
x3:  ((0),[x2],0)^max(|x2|+1,|x3|,2)

([x2],((0),[x2],0)^max(|x2|+1,|x3|,2))


*)

(* Here's the same term with the exclamation point to control
the order.  Notice that the type is polymorphic -- the type of the
variable x2 is left free. *)

Test2 "x3!(S1(x1),x2,a2)";

(*

basic list:

x1:  0
x2:  [x2]
x3:  ((0),[x2],0)
x3:  [x3]



unification list:

x1:  0
x2:  [x2]
x3:  ((0),[x2],0)
x3:  [x3]



final type list:

x1:  0
x2:  [x2]
x3:  ((0),[x2],0)

([x2],((0),[x2],0))

*)

(* the following calculation shows the polymorphic order of the
type shown above -- it is nontrivial but it is not displayed because
it is the smallest possible order determined by the structure of the
type *)

showorder(typeorder(Newtypecheck (parse "x3!(S1(x1),x2,a2)")));

(* > val it = "max(|x2|+2,3)" : string *)


Test2 "x2!(x1,R1(x1))";

(*

basic list:

x1:  [x1]
x1:  0
x2:  ([x1],(0))
x2:  [x2]



unification list:

x1:  [x1]
x1:  0
x2:  ([x1],(0))
x2:  [x2]



final type list:

x1:  0
x2:  (0,(0))

(0,(0,(0)))

*)

(* example 49 *)

Test2 "S2(a1,a2)";


(*

basic list:

unification list:

final type list:


()

*)

Test2 "(R1(a1) v S1(a1))";


(*

basic list:

unification list:

final type list:


()

*)

Test2 "(R1(x1) v S1(x1))";


(*

basic list:

x1:  0



unification list:

x1:  0



final type list:

x1:  0

(0)

*)

Test2 "(R1(x1) v S1(x2))";


(*

basic list:

x1:  0
x2:  0



unification list:

x1:  0
x2:  0



final type list:

x1:  0
x2:  0

(0,0)

*)

(* the term finally typed in part 3 types polymorphically here *)

Test2 "x1!(x2,x2)";

(*
basic list:

x1:  [x1]
x1:  ([x2],[x2])
x2:  [x2]



unification list:

x1:  [x1]
x1:  ([x2],[x2])
x2:  [x2]



final type list:

x1:  ([x2],[x2])
x2:  [x2]

(([x2],[x2]),[x2])
*)

(* this term from the derivation of type 3 types as you typed it *)

Test2 "x3!(R1(x1),R1(x2))";


(*

basic list:

x1:  0
x2:  0
x3:  ((0),(0))
x3:  [x3]



unification list:

x1:  0
x2:  0
x3:  ((0),(0))
x3:  [x3]



final type list:

x1:  0
x2:  0
x3:  ((0),(0))

(((0),(0)))

*)

(* given extra information, the term will type as you wanted it to: *)

(* the additional disjunct fixes the type of x2 *)

Test2 "(x1!(x2,x2) v x2!(a1))";

(*

basic list:

x1:  [x1]
x1:  ([x2],[x2])
x2:  [x2]
x2:  (0)



unification list:

x1:  [x1]
x1:  ([x2],[x2])
x2:  [x2]
x2:  (0)



final type list:

x1:  ((0),(0))
x2:  (0)

(((0),(0)),(0))

*)

(* example 4 types polymorphically *)

Test2 "x3!(x1,x2)";

(* 

basic list:

x1:  [x1]
x2:  [x2]
x3:  [x3]
x3:  ([x1],[x2])



unification list:

x1:  [x1]
x2:  [x2]
x3:  [x3]
x3:  ([x1],[x2])



final type list:

x1:  [x1]
x2:  [x2]
x3:  ([x1],[x2])

([x1],[x2],([x1],[x2]))

*)

(* and with extra info will type as you wanted it to *)

(* the disjuncts supply the extra information that x1 and x2
have type 0 *)

Test2 "(x3!(x1,x2) v (R1(x1) v R1(x2)))";


(*

basic list:

x1:  0
x1:  [x1]
x2:  0
x2:  [x2]
x3:  [x3]
x3:  ([x1],[x2])



unification list:

x1:  0
x1:  [x1]
x2:  0
x2:  [x2]
x3:  [x3]
x3:  ([x1],[x2])



final type list:

x1:  0
x2:  0
x3:  (0,0)

(0,0,(0,0))

*)

(* in example 5, the type of x1 is deducible from the syntax,
but not the type of x2 *)

Test2 "(R1(x1) v ~x3!(x1,x2))";

(*

basic list:

x1:  [x1]
x1:  0
x2:  [x2]
x3:  [x3]
x3:  ([x1],[x2])



unification list:

x1:  [x1]
x1:  0
x2:  [x2]
x3:  [x3]
x3:  ([x1],[x2])



final type list:

x1:  0
x2:  [x2]
x3:  (0,[x2])

(0,[x2],(0,[x2]))

*)

(* an extra disjunct recovers the specific type you wanted *)

Test2 "((R1(x1) v ~x3!(x1,x2)) v S1(x2)";

(*

basic list:

x1:  0
x1:  [x1]
x2:  [x2]
x2:  0
x3:  [x3]
x3:  ([x1],[x2])



unification list:

x1:  0
x1:  [x1]
x2:  [x2]
x2:  0
x3:  [x3]
x3:  ([x1],[x2])



final type list:

x1:  0
x2:  0
x3:  (0,0)

(0,0,(0,0))

*)

Test2 "(R1(x1) v ~T3(x1,x1,x2))";

(*

basic list:

x1:  0
x2:  0



unification list:

x1:  0
x2:  0



final type list:

x1:  0
x2:  0

(0,0)
*)

(* example 50 *)

Test2 "(x3!(a1) v S1(a1))";

(*

basic list:

x3:  [x3]
x3:  (0)



unification list:

x3:  [x3]
x3:  (0)



final type list:

x3:  (0)

((0))

*)

Test2 "x3!(R1(a1),S1(a1))";

(*
basic list:

x3:  [x3]
x3:  ((),())



unification list:

x3:  [x3]
x3:  ((),())



final type list:

x3:  ((),())

(((),()))
*)

Test2 "[x3](x3!() v ~x3!())";

(*
basic list:

x3:  ()
x3:  [x3]



unification list:

x3:  ()
x3:  [x3]



final type list:

x3:  ()

()^1
*)

(* example 58 *)

(* Notice that the general type covers both cases in your example *)

(* subsequently I reconstruct both special cases you give by
supplying extra information in the term. *)

Test2 "x3!(x1)";

(*
basic list:

x1:  [x1]
x3:  [x3]
x3:  ([x1])



unification list:

x1:  [x1]
x3:  [x3]
x3:  ([x1])



final type list:

x1:  [x1]
x3:  ([x1])

([x1],([x1]))
*)

Test2 "(x3!(x1)vR1(x1))";


(*

basic list:

x1:  0
x1:  [x1]
x3:  [x3]
x3:  ([x1])



unification list:

x1:  0
x1:  [x1]
x3:  [x3]
x3:  ([x1])



final type list:

x1:  0
x3:  (0)

(0,(0))

*)


Test2 "(x3!(x1)v x1!())";

(*

basic list:

x1:  ()
x1:  [x1]
x3:  ([x1])
x3:  [x3]



unification list:

x1:  ()
x1:  [x1]
x3:  ([x1])
x3:  [x3]



final type list:

x1:  ()
x3:  (())

((),(()))

*)

(* selected examples from comments in the source file *)

(* this one requires the algorithm to "think" a bit! *)

Test2 "((x5!(x6,x6)v x5!(x2,x3))v(x1!(x2)v x1!(x3)))";

(* the variables with negative indices are generated internally
as a device to support matching of orders of pf arguments,
which happens in the rewriting stage rather than the structural
unification stage *)

(*

basic list:

x1:  [x1]
x1:  ([x2])
x1:  ([x3])
x2:  [x2]
x3:  [x3]
x5:  ([x6],[x6])
x5:  [x5]
x5:  ([x2],[x3])
x6:  [x6]



unification list:

x~4:  [x~3]
x~4:  ([x6],[x6])
x~4:  ([x2],[x3])
x~3:  ([x2],[x3])
x~3:  [x~4]
x~3:  ([x6],[x6])
x~2:  ([x2])
x~2:  [x~1]
x~2:  ([x3])
x~1:  ([x3])
x~1:  ([x2])
x~1:  [x~2]
x1:  ([x3])
x1:  ([x2])
x1:  [x1]
x2:  [x3]
x2:  [x6]
x2:  [x2]
x3:  [x2]
x3:  [x6]
x3:  [x3]
x5:  ([x6],[x6])
x5:  [x5]
x5:  ([x2],[x3])
x6:  [x6]
x6:  [x3]
x6:  [x2]



final type list:

x~4:  ([x6],[x6])
x~3:  ([x6],[x6])
x~2:  ([x6])
x~1:  ([x6])
x1:  ([x6])
x2:  [x6]
x3:  [x6]
x5:  ([x6],[x6])
x6:  [x6]

(([x6]),[x6],[x6],([x6],[x6]),[x6])

*)

Test2 "~x1(x1)";

(*circularity of types is detected at the third stage*)

(*
basic list:

x1:  [x1]
x1:  ([x1])



unification list:

x1:  [x1]
x1:  ([x1])



final type list:

x1:   ?!? 

 ?!? 
*)

Test2 "x1!(x1!(x2))";

(*

basic list:

x1:  ((([x2]),[x2]))
x1:  [x1]
x1:  ([x2])
x2:  [x2]



unification list:

x~2:  [x~1]
x~2:  ((([x2]),[x2]))
x~2:  ([x2])
x~1:  ([x2])
x~1:  [x~2]
x~1:  ((([x2]),[x2]))
x1:  ((([x2]),[x2]))
x1:  ([x2])
x1:  [x1]
x2:  (([x2]),[x2])
x2:  [x2]



final type list:

x~2:   ?!? 
x~1:   ?!? 
x1:   ?!? 
x2:   ?!? 

 ?!? 

*)

(* with renaming of bound variables, this is the same as
the previous pf, and types correctly *)

Test2 "x1!(x2!(x3))";

(*
basic list:

x1:  ((([x3]),[x3]))
x1:  [x1]
x2:  ([x3])
x3:  [x3]



unification list:

x1:  ((([x3]),[x3]))
x1:  [x1]
x2:  ([x3])
x3:  [x3]



final type list:

x1:  ((([x3]),[x3]))
x2:  ([x3])
x3:  [x3]

(((([x3]),[x3])))
*)

(* this does not type *)

Test2 "x1(x1(x2))";

(*

basic list:

x1:  [x1]
x1:  ((([x2])^max(|x1|,|x2|+1,1),[x2]))



unification list:

x1:  [x1]
x1:  ((([x2])^max(|x1|,|x2|+1,1),[x2]))



final type list:

x1:   ?!? 

 ?!? 

*)

(* but this, with the same meaning, does type: *)

Test2 "x1(x3(x4))";

(*

basic list:y


x1:  [x1]
x1:  ((([x4])^max(|x3|,|x4|+1,1),[x4]))^max(|x1|,|x3|+2,|x4|+3,3)



unification list:

x1:  [x1]
x1:  ((([x4])^max(|x3|,|x4|+1,1),[x4]))^max(|x1|,|x3|+2,|x4|+3,3)



final type list:

x1:  ((([x4])^max(|x3|,|x4|+1,1),[x4]))^max(|x1|,|x3|+2,|x4|+3,3)

(((([x4])^max(|x3|,|x4|+1,1),[x4]))^max(|x1|,|x3|+2,|x4|+3,3))

*)

Test2 "x1!(x2!(x1))";

(*
basic list:

x1:  [x1]
x1:  (([x1],([x1])))



unification list:

x1:  [x1]
x1:  (([x1],([x1])))



final type list:

x1:   ?!? 

 ?!? 


*)

(* but with renaming of variables in the pf argument: *)

Test2 "x1!(x4!(x3))";

(*

basic list:

x1:  (([x3],([x3])))
x1:  [x1]
x3:  [x3]
x4:  ([x3])



unification list:

x1:  (([x3],([x3])))
x1:  [x1]
x3:  [x3]
x4:  ([x3])



final type list:

x1:  (([x3],([x3])))
x3:  [x3]
x4:  ([x3])

((([x3],([x3]))))


*)

Test2 "x5(((x2!(x4)v x3!(x4))v[x1](x1(x2) v x1(x3))))";

(* 
basic list:

x1:  (([x4]))^max(|x1|,|x4|+2,2)
x2:  ([x4])
x3:  ([x4])
x4:  [x4]
x5:  ((([x4]),([x4]),[x4])^max(|x1|+1,|x4|+3,3))^max(|x1|+2,|x4|+4,|x5|,4)
x5:  [x5]



unification list:

x1:  (([x4]))^max(|x1|,|x4|+2,2)
x2:  ([x4])
x3:  ([x4])
x4:  [x4]
x5:  ((([x4]),([x4]),[x4])^max(|x1|+1,|x4|+3,3))^max(|x1|+2,|x4|+4,|x5|,4)
x5:  [x5]



final type list:

x1:  (([x4]))^max(|x1|,|x4|+2,2)
x2:  ([x4])
x3:  ([x4])
x4:  [x4]
x5:  ((([x4]),([x4]),[x4])^max(|x1|+1,|x4|+3,3))^max(|x1|+2,|x4|+4,|x5|,4)

*)


(* Here is a type failure caused by order alone:  this would
check in STT *)


Test2 "(x1!(x2,x2)v x1!(R1(a1),[x4]R1(x4)))";

(*

basic list:

x1:  [x1]
x1:  ((),()^1)
x1:  ([x2],[x2])
x2:  [x2]
x4:  0


unification list:

x~4:  [x~3]
x~4:  ()
x~4:  ()^1
x~3:  ()^1
x~3:  ()
x~3:  [x~4]
x~2:  ((),()^1)
x~2:  ([x2],[x2])
x~2:  [x~1]
x~1:  ([x2],[x2])
x~1:  ((),()^1)
x~1:  [x~2]
x1:  ((),()^1)
x1:  ([x2],[x2])
x1:  [x1]
x2:  ()^1
x2:  [x2]
x2:  ()
x4:  0



final type list:

x~4:  ()^1
x~4:  ()
x~3:  ()^1
x~3:  ()
x~2:  (()^1,()^1)
x~2:  ((),()^1)
x~1:  ((),()^1)
x~1:  (()^1,()^1)
x1:  ((),()^1)
x1:  (()^1,()^1)
x2:  ()
x2:  ()^1
x4:  0

 ?!? 

*)

(* The same term with the STT checker "Test2" *)

Test2 "(x1(x2,x2)v x1(R1(a1),[x4]R1(x4)))";



(*

basic list:

x1:  ((),())
x1:  ([x2],[x2])
x1:  [x1]
x2:  [x2]



unification list:

x1:  [x1]
x1:  ([x2],[x2])
x1:  ((),())
x2:  [x2]
x2:  ()



final type list:

x1:  ((),())
x2:  ()

(((),()),())

*)

(* Here's an example of the use of Test2. *)

(* Test2 reports that this term cannot be typed by our algorithm, but
goes on to report (I hope!) addtional conditions under which the term
could be assigned a type.  I'm not entirely confident about
correctness (there could be bugs).  I have trouble seeing how a useful
type notation could be developed for the completely general case --
for practical work the more limited algorithm is probably sufficient.
*)

(* It would be worthwhile to check the conditions by hand -- they
are now much shorter than the original output of the Jan 10 version! *)

(* with the final Jan. 11 revision there is a single apparently
correct condition for typability generated *)

Test2 "(x1(x2,x2) v x1([x3]x3(x4),[x5][x7]x7(x5,x6)))";

(*

basic list:

x1:  ((),())
x1:  ([x2],[x2])
x1:  [x1]
x2:  [x2]



unification list:

x1:  [x1]
x1:  ([x2],[x2])
x1:  ((),())
x2:  [x2]
x2:  ()



final type list:

x1:  ((),())
x2:  ()

(((),()),())

> val it = () : unit
- Test2 "(x1(x2,x2) v x1([x3]x3(x4),[x5][x7]x7(x5,x6)))";

basic list:

x1:  [x1]
x1:  (([x4])^max(|x3|+1,|x4|+2,2),([x6])^max(|x5|+2,|x6|+2,|x7|+1,2))^max(|x1|,|x3|+2,|x4|+3,|x5|+3,|x6|+3,|x7|+2,3)
x1:  ([x2],[x2])^max(|x1|,|x2|+1,1)
x2:  [x2]
x3:  ([x4])^max(|x3|,|x4|+1,1)
x4:  [x4]
x5:  [x5]
x6:  [x6]
x7:  ([x5],[x6])^max(|x5|+1,|x6|+1,|x7|,1)



unification list:

x~2:  [x~1]
x~2:  ([x6])^max(|x5|+2,|x6|+2,|x7|+1,2)
x~2:  ([x4])^max(|x3|+1,|x4|+2,2)
x~1:  ([x4])^max(|x3|+1,|x4|+2,2)
x~1:  [x~2]
x~1:  ([x6])^max(|x5|+2,|x6|+2,|x7|+1,2)
x1:  (([x4])^max(|x3|+1,|x4|+2,2),([x6])^max(|x5|+2,|x6|+2,|x7|+1,2))^max(|x1|,|x3|+2,|x4|+3,|x5|+3,|x6|+3,|x7|+2,3)
x1:  ([x2],[x2])^max(|x1|,|x2|+1,1)
x1:  [x1]
x2:  ([x4])^max(|x3|+1,|x4|+2,2)
x2:  ([x6])^max(|x5|+2,|x6|+2,|x7|+1,2)
x2:  [x2]
x3:  ([x4])^max(|x3|,|x4|+1,1)
x4:  [x4]
x4:  [x6]
x5:  [x5]
x6:  [x4]
x6:  [x6]
x7:  ([x5],[x6])^max(|x5|+1,|x6|+1,|x7|,1)



final type list:

x~2:  ([x6])^max(|x3|+1,|x6|+2,2)
x~2:  ([x6])^max(|x5|+2,|x6|+2,|x7|+1,2)
x~1:  ([x6])^max(|x5|+2,|x6|+2,|x7|+1,2)
x~1:  ([x6])^max(|x3|+1,|x6|+2,2)
x1:  (([x6])^max(|x3|+1,|x6|+2,2),([x6])^max(|x5|+2,|x6|+2,|x7|+1,2))^max(|x1|,|x3|+2,|x5|+3,|x6|+3,|x7|+2,3)
x1:  (([x6])^max(|x3|+1,|x6|+2,2),([x6])^max(|x3|+1,|x6|+2,2))^max(|x1|,|x3|+2,|x5|+3,|x6|+3,|x7|+2,3)
x2:  ([x6])^max(|x3|+1,|x6|+2,2)
x2:  ([x6])^max(|x5|+2,|x6|+2,|x7|+1,2)
x3:  ([x6])^max(|x3|,|x6|+1,1)
x4:  [x6]
x5:  [x5]
x6:  [x6]
x7:  ([x5],[x6])^max(|x5|+1,|x6|+1,|x7|,1)

 ?!? 

|x3| <= |x7| and
|x5|+1 <= |x7| and
|x6|+1 <= |x7| and
|x7|+2 <= |x1| and
|x7| <= |x3|
 
*)

(* this was a Test2 case that broke some of my early algorithms *)

Test2 "(x1(x3,x5) v (x3(x4) v (x5(x6) v x1(x2,x2)))";

(*

basic list:

x1:  [x1]
x1:  ([x2],[x2])^max(|x1|,|x2|+1,1)
x1:  ([x3],[x5])^max(|x1|,|x3|+1,|x5|+1,1)
x2:  [x2]
x3:  ([x4])^max(|x3|,|x4|+1,1)
x3:  [x3]
x4:  [x4]
x5:  [x5]
x5:  ([x6])^max(|x5|,|x6|+1,1)
x6:  [x6]



unification list:

x1:  [x1]
x1:  ([x2],[x2])^max(|x1|,|x2|+1,1)
x1:  ([x3],[x5])^max(|x1|,|x3|+1,|x5|+1,1)
x2:  ([x4])^max(|x3|,|x4|+1,1)
x2:  ([x6])^max(|x5|,|x6|+1,1)
x2:  [x3]
x2:  [x2]
x2:  [x5]
x3:  ([x4])^max(|x3|,|x4|+1,1)
x3:  [x3]
x3:  ([x6])^max(|x5|,|x6|+1,1)
x3:  [x5]
x3:  [x2]
x4:  [x4]
x4:  [x6]
x5:  [x2]
x5:  ([x6])^max(|x5|,|x6|+1,1)
x5:  [x5]
x5:  ([x4])^max(|x3|,|x4|+1,1)
x5:  [x3]
x6:  [x6]
x6:  [x4]



final type list:

x1:  (([x6])^max(|x5|,|x6|+1,1),([x6])^max(|x5|,|x6|+1,1))^max(|x1|,|x5|+1,|x6|+2,2)
x2:  ([x6])^max(|x5|,|x6|+1,1)
x3:  ([x6])^max(|x5|,|x6|+1,1)
x4:  [x6]
x5:  ([x6])^max(|x5|,|x6|+1,1)
x6:  [x6]

((([x6])^max(|x5|,|x6|+1,1),([x6])^max(|x5|,|x6|+1,1))^max(|x1|,|x5|+1,|x6|+2,2),([x6])^max(|x5|,|x6|+1,1),([x6])^max(|x5|,|x6|+1,1),[x6],([x6])^max(|x5|,|x6|+1,1),[x6])

*)

(* another example with Test2 -- it is quite clear that the
conditions described for typability are the correct ones *)

Test2 "(x1!(x2,x2)v x1!([x3][x5]x3!(x5,x8),[x6][x9]x6!(x4,x9)))";

(*

basic list:

x1:  [x1]
x1:  (([x8])^max(|x5|+2,|x8|+2,2),([x4])^max(|x4|+2,|x9|+2,2))
x1:  ([x2],[x2])
x2:  [x2]
x3:  ([x5],[x8])
x4:  [x4]
x5:  [x5]
x6:  ([x4],[x9])
x8:  [x8]
x9:  [x9]



unification list:

x~4:  [x~3]
x~4:  ([x4])^max(|x4|+2,|x9|+2,2)
x~4:  ([x8])^max(|x5|+2,|x8|+2,2)
x~3:  ([x8])^max(|x5|+2,|x8|+2,2)
x~3:  [x~4]
x~3:  ([x4])^max(|x4|+2,|x9|+2,2)
x~2:  (([x8])^max(|x5|+2,|x8|+2,2),([x4])^max(|x4|+2,|x9|+2,2))
x~2:  ([x2],[x2])
x~2:  [x~1]
x~1:  ([x2],[x2])
x~1:  (([x8])^max(|x5|+2,|x8|+2,2),([x4])^max(|x4|+2,|x9|+2,2))
x~1:  [x~2]
x1:  (([x8])^max(|x5|+2,|x8|+2,2),([x4])^max(|x4|+2,|x9|+2,2))
x1:  ([x2],[x2])
x1:  [x1]
x2:  ([x4])^max(|x4|+2,|x9|+2,2)
x2:  [x2]
x2:  ([x8])^max(|x5|+2,|x8|+2,2)
x3:  ([x5],[x8])
x4:  [x4]
x4:  [x8]
x5:  [x5]
x6:  ([x4],[x9])
x8:  [x4]
x8:  [x8]
x9:  [x9]



final type list:

x~4:  ([x8])^max(|x5|+2,|x8|+2,2)
x~4:  ([x8])^max(|x8|+2,|x9|+2,2)
x~3:  ([x8])^max(|x8|+2,|x9|+2,2)
x~3:  ([x8])^max(|x5|+2,|x8|+2,2)
x~2:  (([x8])^max(|x8|+2,|x9|+2,2),([x8])^max(|x8|+2,|x9|+2,2))
x~2:  (([x8])^max(|x5|+2,|x8|+2,2),([x8])^max(|x8|+2,|x9|+2,2))
x~1:  (([x8])^max(|x5|+2,|x8|+2,2),([x8])^max(|x8|+2,|x9|+2,2))
x~1:  (([x8])^max(|x8|+2,|x9|+2,2),([x8])^max(|x8|+2,|x9|+2,2))
x1:  (([x8])^max(|x5|+2,|x8|+2,2),([x8])^max(|x8|+2,|x9|+2,2))
x1:  (([x8])^max(|x8|+2,|x9|+2,2),([x8])^max(|x8|+2,|x9|+2,2))
x2:  ([x8])^max(|x5|+2,|x8|+2,2)
x2:  ([x8])^max(|x8|+2,|x9|+2,2)
x3:  ([x5],[x8])
x4:  [x8]
x5:  [x5]
x6:  ([x8],[x9])
x8:  [x8]
x9:  [x9]

 ?!? 

|x5| <= |x9| and
|x8| <= |x9| and
|x9| <= |x5|

OR

|x5| <= |x8| and
|x9| <= |x8|

*)

(* the file needs some nontrivial examples for Test2 -- RTT terms with
interesting type conditions *)


Test2 "(x1([x4][x2][x3]x4(x2,x3)) and x1([x6][x8][x7]x6(x7,x8)))";

(*

[some output omitted]

final type list:

x~2:  ()^max(|x2|+2,|x3|+2,|x4|+1,2)
x~2:  ()^max(|x6|+1,|x7|+2,|x8|+2,2)
x~1:  ()^max(|x2|+2,|x3|+2,|x4|+1,2)
x~1:  ()^max(|x6|+1,|x7|+2,|x8|+2,2)
x1:  (()^max(|x2|+2,|x3|+2,|x4|+1,2))^max(|x1|,|x2|+3,|x3|+3,|x4|+2,|x6|+2,|x7|+3,|x8|+3,3)
x1:  (()^max(|x6|+1,|x7|+2,|x8|+2,2))^max(|x1|,|x2|+3,|x3|+3,|x4|+2,|x6|+2,|x7|+3,|x8|+3,3)
x2:  [x2]
x3:  [x3]
x4:  ([x2],[x3])^max(|x2|+1,|x3|+1,|x4|,1)
x6:  ([x7],[x8])^max(|x6|,|x7|+1,|x8|+1,1)
x7:  [x7]
x8:  [x8]

unconditional type:

 ?!? 

conditional type:

((()^max(|x2|+2,|x3|+2,|x4|+1,2))^max(|x1|,|x2|+3,|x3|+3,|x4|+2,|x6|+2,|x7|+3,|x8|+3,3))

WITH

|x2|+1 <= |x6| and
|x3|+1 <= |x6| and
|x4| <= |x6| and
|x6|+2 <= |x1| and
|x6| <= |x4| and
|x7|+1 <= |x6| and
|x8|+1 <= |x6|

*)

Test2 "(x1!([x2][x3](x2(x4) v x3(x4))) v x1!([x5][x7]x5(x4,x7)))";

(*

[some output omitted]

unconditional type:

 ?!? 

conditional type:

((([x4])^max(|x4|+2,|x5|+1,|x7|+2,2)))

WITH

|x2| <= |x5| and
|x3| <= |x5| and
|x4|+1 <= |x3| and
|x5| <= |x2| and
|x7|+1 <= |x5|

OR

|x2| <= |x5| and
|x3| <= |x5| and
|x4|+1 <= |x2| and
|x5| <= |x3| and
|x7|+1 <= |x5|


*)

(* the interesting feature of this next example is that you
can see the complete checker determining that the order of the type of the
"free floating" variable x7 must be exactly 2 *)

Test2 "(x6([x5](x5!(R1(x1)) implies x5!(x2))) and x6!((x2(a1) and [x7]x7())))";

(*

[some output omitted]

final type list:

x~6:  ((0))^max(|x7|+1,2)
x~6:  ((0))^3
x~5:  ((0))^3
x~5:  ((0))^max(|x7|+1,2)
x~4:  (0)
x~3:  ((0))
x~2:  ((0))
x1:  0
x2:  (0)
x5:  ((0))
x6:  (((0))^3)^max(|x6|,|x7|+2,4)
x6:  (((0))^max(|x7|+1,2))^max(|x6|,|x7|+2,4)
x7:  ()^max(|x7|,0)

unconditional type:

 ?!? 

conditional type:

((((0))^3)^max(|x6|,|x7|+2,4))

WITH

|x7| >= 2 and
|x7| <= 2 and
|x7|+2 <= |x6|

*)

Test2 "(x6!([x2](R1(x1) or (x2!(x1) or [Ex3](x3!(x2) or [Ex4](x4!(x3) or [Ex5]x5!(x4)))))) and x6!([x8][x9][x10](x10!(x8,x9,x1) or x8(a1))))";

(*

conditional type:

(((0)^5))

WITH

|x8| >= 3 and
|x8| <= 3 and
|x9| <= |x8|

OR

|x9| >= 3 and
|x8| <= |x9| and
|x9| <= 3 and
|x9| <= |x8|+2

*)


