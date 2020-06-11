(* automation of RTT (ramified theory of types) as presented in
Kamareddine et. al. paper, by Randall Holmes.  All rights reserved,
Randall Holmes, 2002, copying and use permitted freely as long as this
notice is preserved. *)

(* a complete polymorphic type checker for STT and a remarkably smart 
one -- and now a complete one as well -- for RTT are defined *) 

(* the RTT prover is now much closer to being "canonical" *)

(* Aug. 27, 2004:

I think that the generation of new variables may need to be rethought
throughout.

Why is the new dynamic version of newvar (commented out) not working?
Reverse the commenting of original and modified versions, and some proofs in
the old book (now available by running "theoldbook()") no longer work.

Preliminary modifications have been carried out.  The Desc construction
now takes a vector of variables as an argument.  Handling of these vectors
of variables is limited; see NOTEs for comments on what remains to be done.
Automatic description elimination (descelim0) is no longer used; we
need to introduce machinery for introducing existence hypotheses where
necessary (when instantiating in certain contexts, as the underlying
free logic will require).

Considerable changes are projected in the process of readying the system
for a full implementation of PM.

I have decided to implement free logic, which will allow me to prove
the same theorems about descriptions (without explicit scopes) that PM
does but using a more implementable approach.  This requires a
division of terms into "necessary" and "contingent" terms, presumably
automatically detectable by analysis of constructions used, and use of
a primitive "existence predicate".

It is necessary to review PM for notational upgrades.  We clearly need
binary relation and operator symbols.  We also seem to need the ability
to suffix operators in certain cases (as in formal implication).

The existing Desc term construction can be used to support the construction
of descriptions proper and classes; what about relations?

*)

(* Aug. 25, 2004:

I implemented functions ambtypeson(), ambtypesoff(), showambtypes():
ambtypeson turns off type checking in MP.  I'm trying to get it to
turn off type checking in extendparameters but I'm forgetting which
check this applies to.  I believe that extendparameters is now correctly
modified as well.

I'm revisiting this preparatory to writing a grant proposal.  

Are there other situations still living in the code where use of the
"newvar" function can lead to a type conflict?  In particular, I'm
thinking of the expansion of definite descriptions.

What upgrades will be needed for a full proof checker?

I should set up the toggle re propositional type components so that
it does (or so that it can?  -- a third alternative?) turn off the
type checking in MP and extendparameters.

I need notation for classes and relations; is notation for n-ary relations
needed?

I need notation for prefix and infix operators.  In general, a richer
term language is needed.  Infix relation predicates are also needed.

Definition facilities for introduction of new operators and relations
are needed as well.

Some kind of formal statement about the philosophy of situations in which
actual changes are made to PM needs to be enunciated.

*)

(* Nov. 26: 

Generation of new variables must be modified so that it is global; otherwise
new variable generation will introduce type conflicts.

*)

(* Nov. 22:  refinement of Nov. 21 "upgrade" to descriptions.

Restored original format, more or less, but preserved new ideas in comments.

It seems that the system does check to prevent substitution of definite description
terms.

Quantifier definition is needed to complete usefulness of definite description terms.

Should class terms be defined using desc or independently?

 *)

(* Nov. 21:

The modification introduced below requires further work.  It is
necessary to figure out how to handle the standard description: the
contextually defined terms for other quantifiers are now under
control.  We also need to ability to define quantifiers (I now needs
this).

This version includes revision of description arguments -- it now
supports something sound for "all P" and "some P" arguments, but not
for "the unique x such that P"; this will need special treatment
(or extra consideration).  The different propositional connectives
needed for different quantifiers are now supported.

I'm trying to understand the software again after a break, since I am
now writing the accompanying paper.  It may be that what I should do is
rewrite the algorithms to ensure that they follow the paper precisely.

I don't know, in particular, whether the convention for choosing which
variables of the same polymorphic type (index smallest or largest) will
determine the polymorphic type variable is the same here as in the paper.

*)

(* Jan. 25:

A future consideration is the addition of class and relation
constructions, though these are fairly easy to handle with the current
description notation.

Lots of testing and modifications to the proof-checker functions to make
them more suitable for demo purposes are needed.

The ability to introduce and manage defined quantifiers (to match the
installed ability to introduce and manage defined connectives) is needed.

*)

(* Jan 24:

Added tools for the proof-checker to register equivalence of
propositions to theorems under expansion of definite descriptions and
of constant pf application terms.  (functions desceq and redeq).

Fixed a bug in the type safety check in substitution -- it was reporting
type collisions between new variables introduced by substitutions and
old variables eliminated by substitutions.

I hope that I have now defined substitution in such a way as to eliminate
description terms automatically (when necessary).  Tests suggest that
it works.  Any nontrivial substitution into a pf with virtual arguments
will induce expansion.  A mechanism for recontraction would be handy!
I also put guards into the specification commands in the proof checker
so that they will not allow substitution of virtual terms for variables.

The only remaining lacuna in the treatment of description terms is the
fact that elementary predicates still can't take description terms as
arguments (though there is a way to fake this using constant pf
application).


*)

(* Jan 23:

I have completed installation of a preliminary version of syntax and
type-checking for definite description and similar operators (see
lacunae noted below).  This is not extensively tested, but at any rate it
should not interact destructively with the earlier material.

lacunae:  elementary predicates should be able to take description
arguments, with the necessary typing conventions.  It should not be
possible to substitute descriptions for variables.  Something needs
to be done to implement "contextual definition", particularly noting
the problem of pfs with more than one description argument (how is
the binding order handled?).

corrected "extendparameter" so that it treats terms <x1>(T1,...,Tn)
and <x1>!(T1,...,Tn) correctly:  adding an axiom (<x1>(x2) iff x1(x2))
(or (<x1>() iff x1()) then allows proofs of the equivalences one expects
between constant pf application terms and the terms obtained by carrying
out the intended substitutions.  I tested this a little.

Inserted guards into the parser so that it should not raise exceptions
in parsing bad <...>... terms.

*)

(* Jan 22:

I have installed an extension to the pf type, allowing application
of constant pfs, with the appropriate extensions to typing and
substitution.  I cannot say that this is fully debugged, and the parser
is probably not nearly as safe with the new term constructions as
with the old ones.

Examples of the pf constructions:

<x1(x2)>(R1(x3),a1) -- apply the pf x1(x2) to the arguments R1(x3), a1
(this term has the same meaning as R1(a1)).

<x1>(x2,x3) <x1>!(x2,x3)  The only difference between these and
x1(x2,x3) and x1!(x2,x3) respectively is that substitution of a pf
for x1 will not result in any substitution of x2 and x3 into the
pf, but merely cause the pf to be placed between the angle brackets.

I'll put some examples into the rttdemo file.

*)

(* Jan 19: 

I think that the standard form (canonical variable renaming)
may finally work as intended.  It is dynamic, so one should check
how it works with a different ML (it uses a global "new variable"
reference which is updated as it goes through the term).

The Test2 function will now attempt to type the standard form with
variables renamed to avoid collisions if it cannot obtain a type
by the complete algorithm.

IMPORTANT:  I have moved all the substitution functions (and the
variable renaming functions) to follow the type checkers, to make the
point that there is no dependency on (pf) substitution in the type
checking, and to allow the installation of an STT type-check in the
definition of substitution, which has the effect of guaranteeing
termination!

Test2 alone appears after the substitution block because it now
uses variable renaming to attempt a second check after type failure.
Notice that the substitution of variables for variables in the variable
renaming function is not type-checked, because renaming of variables
is sometimes needed to establish an STT type.

a final small fix to the variable capture. The problem was
that the test for variable capture involved making test substitutions
of dummy objects, and in certain cases these substitutions were
unexpectedly illegal and the tests had unexpected answers. *)

(* Jan 18: found and probably repaired a major bug in substitution
(notice that this has no bearing on the type-checking).  The problem
had nothing to do with the specific peculiarities of substitution in
RTT -- it was the result of an interaction of the two classical problems
of doing multiple independent substitutions and avoiding variable
capture in quantified terms.  My multiple substitution solution broke
the variable capture solution...

I installed test functions for substitution.

I'm in the process of developing a function which will return
canonical forms for terms mod bound variable renaming.  This is
how I discovered the substitution problem.

*)

(* Jan 17:  the display function now shows problems with ill-formedness
caused by inappropriate arity of elementary relations, by failure
of quantified variables to appear free in their scope, and by
appearance of propositions which are not pfs as pf arguments.  This
means that the display of any ill-formed term will now give some
signal of what is wrong with it (and _that_ something is wrong with it,
which was not the case before with these kinds of terms).

IMPORTANT:  the prover now supports the ability to turn on and off
"proposition types".

If the command "proptypesoff();" is issued, terms xi() become ill-formed
and it further becomes a requirement that pf arguments contain at least
one free variable.  This has the effect of eliminating proposition types
as subtypes (the system still types top-level propositions, but no
pf argument can have proposition type).

If the command "proptypeson();" is issued, the normal situation is
restored.  Proposition types are on by default.

showproptypes() will cause the program to state whether proposition types
are on or off.

In rttdemo.sml, there are several examples of terms with proposition-typed
arguments which become ill-formed when proposition types are turned off.
I implemented this because Russell seems to take the view in PM that
proposition types should be avoided.

*)

(* Jan. 16:

I made Test and Test2 more interactive -- they will now display the
term entered, then wait for a return to display the type results.
This makes executing rttdemo a more satisfactory option.

There is also a new function TestLoop() which applies the 
complete checker to a sequence of terms entered by the user.

it would be nice to make the complete checker even smarter, so that
it could use the conditions (where appropriate) to simplify the
conditional type.  For example, in 

Test2 "(x6([x5](x5!(R1(x1)) implies x5!(x2))) and x6!((x2(a1) and [x7]x7())))";

we get

conditional type:

((((0))^3)^max(|x7|+2,4))

WITH

|x7| >= 2 and
|x7| <= 2

where the condition actually tells us that the type is ((((0))^3)

*)

(* Jan. 15:

if there are no bugs in my thinking (a big if!), this package now
incorporates a complete type-checker for RTT.  The Test function now
includes a label on the type reported by the original partial
algorithm (this is just a cosmetic change) -- it is called the
"unconditional type".  Test2 now reports the "unconditional type"
(with label) and its own "conditional type" (which, if my thinking is
correct, will be defined for any term typable in RTT), which is only
valid if the following inequality conditions hold.

The difference between the partial algorithm and the new one is that
the partial algorithm (essentially the original one, though as you
will see this algorithm is also modified) required that a unique order
be reported for the type of each variable in the final type list (the
result of the rewriting stage).  The current version of both the new
and old algorithm actually uses the new (complete) algorithm to report
types of pf arguments (thus allowing the requirement of a unique order
to be delayed as long as possible in the partial algorithm); the fact
that all type information from pf arguments is now retained is
essential for this to work.  The complete algorithm just chooses the
first type on the list for each variable, relying on the fact that the
conditions are sufficient to show equivalence of the various possible
reported orders.  It is quite possible that different forms will be
reported for the same type when it appears as a component of a complex
type in the complete algorithm; of course, this will not happen in the
partial algorithm, which requires that all possible orders for the
type of a given variable eventually be rewritten to the same form.
The modification of the partial algorithm consists in the fact that it
is probably possible to contrive examples where the types of pf
arguments cannot be rewritten to unique forms using only local
information but will eventually be rewritten to unique forms using
global information, so the new version of the partial algorithm will
type more pfs (but probably won't behave any differently on any
practical example).

The proof checker still requires unconditional typing -- this needs
to remain true until I can look into its innards and see how it would
make use of the conditions in certain aspects of type-checking (notably
the type-checking of modus ponens steps).

*)

(* further note on Jan 11:

in order to get the "additional conditions" to work correctly,
I had to make two further changes:

the algorithm now derives inequality conditions from all unbounded
orders whether they appear in matches or not (this should have been
done already -- it was a bug).  This also has the effect that
Test2 will report inequality information for some typable terms.
I installed a check so that it doesn't report any inequalities
when the typing process fails at the unification step!

the type algorithm now retains all type information on variables inside
pf arguments, so, for example, x1!(x1!(x2)) no longer is well-typed
(though x1!(x3!(x4)) is well-typed).  This is important because it is
the only way to retain type information about quantified variables inside
pf arguments, which is important for reasoning about orders.  (note, for
example, that the fact that an order variable is a bounding variable
could be lost in passing from a pf argument to its context in the old
approach).

Another advantage is that this now makes the theoretical discussion
of our type approach agree with the discussion in the paper.  We do not
ever discard information about bound variables -- all variables of the
same typographical form must have the same type.

NOTE: this means that what I say in the paper about limited renaming
of variables is incorrect!  But this is good -- it makes things simpler.

*)

(* Jan 11:  The "additional conditions" produced by Test2
should now be much shorter and easier to read (and maybe now
I can start evaluating their correctness with some confidence!).
Theoretically, these conditions should still be complete.  *)

(* Jan 10: I'm working on the complete type checking problem.
Currently, if things are not buggy, if the type checker fails, but a
term is typable and the type checker has succeeded in typing all pf
arguments in that term, the checker will report a list of lists of
additional inequalities on orders which would permit the checker to
assign types to the term.  There is an example (the only term with
x7).  In the example, we see that these lists of lists can be
extremely long (there are too many possible situations in which the
term can be typed).  Further, there doesn't seem to be a convenient
way of handling typing of pf arguments under conditions -- this would
cause even nastier combinatorics...

The function Test2 has the additional condition checking function;
if a term is conditionally typable, Test2 will report its type
as ?!? but will give conditions under which it can be typed.

I'm also not at all confident that the code which generates the lists
of inequality conditions is bug-free!!!

My guess is that the correct conclusion to draw is that a complete
checker is probably not desirable, though it might be interesting to
have a tool like the one shown here for investigating more complex
situations.

*)

(* Jan 4:  changed the handling of matching of complex orders:
new variables are now created to carry matched types where a "bounding
variable" is not available.  This is achieved by causing the boundingvar
function to generate the desired fresh variables.  This allows the
rule for identity of orders in the paper to be stated in a much simpler
way.

The order of (e.g.) type [x1] is now |x1|, as in the paper.

I'm ready to return to PM development.  This should include adopting
(or at least testing) the distinction between propositions and
propositional functions, with the elimination of assignments of
proposition types to variables xi.  I think this is in accord with the
actual practice in PM.  Further, I need to check up the rules for
renaming of bound variables, think about the parameter introduction
rules, etc.

*)

(* Jan 3:  new type algorithms for STT and RTT fully implemented,
and the new RTT algorithm is plugged into the proof checker in place
of the old one.  This suggests that there ought to be some cleanup
of the files. 

Old functions are now commented out.  The proof checker appears to run
fine on the new RTT functions.

It is interesting to note that the new approach no longer leads us to 
consider the issue of nested orders.

What would be required for a really complete RTT typechecker (which
would be able to find a type assignment if any was possible, and which
would presumably need a more general notation for polymorphic orders?)

What is a precise description of the class of terms which can be typed
by the RTT checker?

Here is something which would be very nice if it were true:

Theorem?:  any term typable in RTT all of whose possible types are
expressible by a single type notation of this system can be typed
by this system.  Note that if a term is typed by this system, the
types given are the only possible types; this would make this algorithm
a perfect match for its polymorphic type notation.  Unfortunately,
this probably isn't true.

*)

(* Dec. 31:  beginning development of the algorithms described in
the draft paper.  I think there is a loophole in the RTT algorithm which
the analysis in the paper uncovered; I should try to construct an example. *)

(* Reimplementation of the STT algorithm apparently complete.

Where will the RTT algorithm be harder?  The rewritten version should
be notably simpler than the original.  The role of the nested orders
in its development appears to drop from view? *)

(* 

Nov. 8:  the new book has reached the same point as the old one.
In the proof of 2.16, the need to implement derived rules comes up.

The book now displays theorem labels.

Application of theorems with matching, combined with the ability
to pass theorems as terms, would do the trick for the Syll derived
rule.   But perhaps I should stick to implementing the actual rule. 

Nov. 6:

I have commented out the old "book" and started a new one.

The connective definition command seems to work well.  With
propositional variables and the connective definition, we
seem to be closer to the level of formalization of the
original PM.

New things to be done: 

   install label display in the book.

   justifications in the book would be good.

   derived rules would be good, too.

   introduce binder definition, and perhaps relation
   definition.

   (big project) implement virtual terms, so that descriptions
   can be supported.

   Consider restricting types to "infinite" types
   and restoring (and justifying) full polymorphism
   (the NFU connection).  See definition of the wellformed
   function for a commented-out clause that will do this cheaply.
   Use of propositional variables seems to make this natural --
   in fact, closer to the actual practice in PM.

   Develop a more general justification for variable
   renaming (something more like the current approach
   to definition -- define a standard form and allow
   introduction of theorems with the same standard form
   as earlier theorems.

   Should I change the implementation so that polymorphic
   types are not tied to variable names (so that bound
   variable behavior will be fully modern)?

   Should support be provided for RTT with nested orders?
   The new form of the unification algorithm allows us
   to do this cheaply if we want to, since we type for
   the nested version as a preliminary step in typing for
   the strict version! (no longer true, Jan. 3)
   Certainly the nested version would
   be discussed in the hypothetical paper.

   Theoretical questions:  is the newparam rule still needed?
   It might still be needed for purposes of generalization
   over functions with arbitrary numbers of arguments,
   even though we have finessed our way out of needing
   it for propositional logic by introducing propositional
   variables.

*)

(* Nov 4:  At long last, I think I have the "complete" (in a suitable sense)
algorithm for typing RTT. 

Unify in two waves -- one allowing nesting of orders (unifying
distinct orders to their maximum) followed by substitutions followed
by a strict unification stipulating that types have to be the same,
covering the original type assignments as well as the previously
unified ones.  A tricky point is the handling of the circularity in
unbounded type functions: when such a type is unified, the polymorphic
type variable handling the "unbounded" character of the type needs to
be unified with any smaller variable to which that type is assigned.

Presumably implicit in this is a type checker for the version which
does allow orders.

What is the correct sense of "completeness" of the type algorithm?
Does it type every term which is uniquely typable in its notation?
There ought also to be terms which are typable on additional assumptions
about the type variables involved, and examples of these ought to be
given in any paper.  I suppose it could be the case that there are
uniquely typable terms whose unique typability obtains for reasons
too complicated for this algorithm to detect?  It is important to
observe that RTT terms are not locally typable in the way STT terms are.

The merit of the approach taken here is that it avoids arithmetic
reasoning, or type judgements which would depend on explicit arithmetic
hypotheses about unknown types (are there really situations like this?)

At this point there may be a paper to write.

Note added Jan. 3:  there was a loophole in this approach.  The
problem is that unification of complex types of pf arguments
would not check that their orders were the same, because such
orders would never even be considered -- the old algorithm simply
discarded them.  The new algorithm deals with this, but its approach
is different and does not involve the detour through nested orders.

Also Nov. 4, connective definition facility passed first test.
New command bydefinition tried out.  But there should also be
a binder and perhaps eventually a primitive relation version.

*)

(* the syntax for the language of PM and variable binding
conventions are taken from an unpublished paper of Kamareddine,
Nederpelt, and Laan, "Type theory in logic and mathematics before 1940".
  The approach taken to type-checking is
independent of that taken in that paper, however. *)

(* suggested updates as we work toward a PM prover based on this:

extend the disj subcase of the pf type to a general binary propositional
connective constructor -- say any sequence of lower case letters. DONE --
arbitrary strings of lower-case letters are now interpreted as
propositional connectives.

an idea for handling general "constant" predicates on pf arguments
is to extend the elementary relation type to have Term instead of
AtomicTerm arguments.  Types of predicates might be "persistent"
(entered in a database).

descriptions are needed.

attention to type handling in PM rules of inference is needed:  for example,
in MP (given |-p and |-p->q, deduce |-q, the type of q given the type bindings
in p must be the same as the type of q with no prior type bindings.

Further idea:  there seems no reason not to allow infix relation
symbols.  The way the name space and parser work seems to make this
easy.

An idea for handling constant pfs without too much extra work:
use negative indexed variables to represent them for type checking
purposes -- maybe even internally, using a lookup table?

Book lines need justifications.  Eventually, the proof checker should
be able to read the justifications.

For the problem of generalizing over lengths of type variables:
a less ad hoc solution is to implement a rule of inference which allows
addition of a new parameter to any pf appearing free in a theorem.
This is logically valid, and neatly handles the problem!

The problem of generalizing over lengths of lists is solved
by the newparam command, which allows one to add a new parameter
to any top-level free pf variable (subject to typing and variable
capture restrictions).  Curiously, this was very important in making
general propositional reasoning practical.

Fixed bug in multiple substitutions using a variable renumbering trick.
This required a second fix; the variable renumbering did need to go into
the innards of pf arguments.

Proved the first two theorems of propositional logic in PM; I
believe the prover is now fully capable (in principle) for propositional logic.

I have now installed rules and axioms for first order logic, including
an extensionality rule, so that equalities can be derived from mutual
implications.

An important note is that notations like the one here which do not
use leading binders are intrinsically interesting as treatments of
the notion of "mathematical expression" as found in mathematics
pedagogy at lower levels and as implemented in Maple.  Term functions
without leading binders might also be of interest as a natural
extension of this notation, though they are not found in Russell
(I don't think).  The same difference between operations whose argument
places bind and those whose argument places do not (connectives vs.
pfs) would have an analogue with terms.  With terms, it would be
"operations" versus "functions" -- though function application should
appear as an "operation" as well?  d/dx is an example of a "function"
(actually, it has the intermediate status of a quantifier!)

An idea for handling descriptions (but with more generality):

introduce ranged quantifiers [Qx1:A], where A is a pf (there seems
no reason not to allow A to depend on other parameters).  The definition
of [Qx1:A] will depend on Q (it will have to be given separately for
each Q).  It is assumed for typing purposes that [Qx1:A]T types in the
same way as [Qx1](A v T).  Now allow prefixes [Qx:A] to occur as terms,
indicating a leading [Qx:a] quantifier on the largest possible context
(alphabetical order controlling order of scopes when more than one
variable appears).  This device will immediately handle definite
descriptions, and it will allow a lot of other clever stuff as well --
a term like [x1] has the meaning "everything" or "every x".  This
analysis will be _very_ interesting from the standpoint of justifying
the PM approach!  Question:  should the display of prefixes as terms
be automatic for leading quantifiers, or should there be a term construction
and rule?  Probably there should be a term construction and rule.

Notice that substitution needs to be defined cleverly -- if there is
a term [Qx1:A] present anywhere, it will not permit substitution for x1
(any occurrences of x1 anywhere in the term are bound!)

This looks like a very exciting idea!  Note that the distinction between
variable binding in terms and variable binding in pf's falls out for free!
Also note that we get free Hilbert symbols :-)  it's appropriate for
PM because it makes sense of his definite descriptions almost for free!
The assertion of existence of [1x:A] is just [1x:A] = [1x:A]!

This could end up being a useful system...

And note that the modifications required in the parser are far from heroic.
Modify the parser, change the definition of FV and substitution appropriately,
introduce a rule for stripping the leading prefix or for dropping the
(innermost?) quantifier.  What is the order convention for implicit
vs. explicit quantifiers?  Simplest rule is probably to have all implicit
ones outermost, order determined alphabetically.

Does the prover currently handle renaming of bound variables, or
is some automation needed?

There is a problem with the current version of the prover.
To make the current version sound, the parameter extending
version has to exclude variables that occur as arguments of
pfs, and the MP function (modus ponens) has to check that type
information about q is the same as the type information about
q in (p implies q).  This is necessary because the proposition
type and types built from it are not polymorphic.

Both problems can also be solved by excluding the proposition
type, which is very simple:  a well-formed pf must be required
to contain a free variable.  This would require re-doing all the
work in the comment at the end of the file...  With this requirement,
all types become polymorphic, and it is possible to have MP
and the parameter list extending rule in their full generality.
There is some support for this approach in PM.  Of course, there
is also support in PM for making the rules type-safe!

A very general solution would require the ability to recognize
infinite types.  One intermediate approach would be to forbid
finite types to appear as formal arguments to pfs.  Only a few
simple finite types would then be possible.  But this seems so
impoverished that one might as well make a clean sweep.

For the moment, the prover has typechecking in MP and
a weakened version of extendparameters which does not allow
the extended function to appear as a pf argument.  But note
that both restrictions could be lifted in a version which did
not allow finite types, and so could be polymorphic.

The fragment of PM now implemented is invoked by the function
thebook(); which is invoked during loading of the file.

A theoretically meaningless but practically quite important update:
there is now practical support for the use of names for theorems.
(see functions setlabel and thmno and their use in the book).

The function ultimate() removes the last theorem (correction of error)
and penultimate() removes the last theorem but one (cleanup of lemmas).

For tactic development, it seems that rules of inference ought
to return boolean values (true if application succeeds and false
if it does not).

propositional variables have been added as a new case of 
pfs.  Substitutions for propositional variables are defined.
Propositional variables are not allowed in pf arguments.

I think that the propositional variable upgrade _greatly_
improves the propositional logic and first-order functionality
of the prover.

The next step is to think about developing a version in which
x variables cannot be assigned types with the proposition type
as components.  In this system strong polymorphism becomes
feasible.  This position is supported by PM, but I should not
implement the change until I have rewritten the book, which currently
depends on x variables with proposition type.

The trickiest part of managing propositional variables is
ensuring that bound variable capture does not happen when subs
are made for propositional variables in quantified formulas.

Further question:  is the newparam rule still valid and useful?
My guess is that it is valid in a stronger form; whether it is still
needed now that we have propositional variables is another question.

*)

(* names of individuals *) 

datatype Name = A of int; 

(* variables *) 

datatype Variable = X of int; 

(* order relation on variables *) 

fun lessvar (X m) (X n) = m<n; 

(* primitive relations on individuals, with name 
and arity components *) 

datatype Relation = R of string*int; 

fun arity (R(s,n)) = n; 

fun relname (R(s,n)) = s; 

(* atomic terms (names or variables) *) 

datatype AtomicTerm = const of Name | var of Variable; 

(* the master type of propositional functions; the enclosed term 
type is a technicality -- terms may be names, variables, or 
propositional functions *)

(* this is really the type of _propositions_  -- propositional
functions are a special case *) 

datatype PropFun = atomic of Relation*(AtomicTerm list) |

    (* the atomic constructor builds elementary propositions,
     whose arguments are either individuals (type 0) or variables
     standing for type 0 objects *) 

(* propositional variable *)

propvar of int | 

negation of PropFun | (* negation *)

disj of string*PropFun*PropFun | (* disjunction -- to be updated
                           to a more general binary propositional
                           connective construction *)

                           (* this has now been updated *)

univ of string*Variable*PropFun | (* universal quantification *)

                                  (* facility for general binders added *)

varhead of Variable*(Term list) | (* variable pf applied to list 
                                   of arguments *)

varhead2 of Variable*(Term list) | (* variable pf applied to list
                                    of arguments with stipulation
                                    that the applied pf is of
                                    minimal type *)

(* installing ability to apply propositional function constants,
with a correlated ability to apply a variable with the intention
that if it is replaced it will not be expanded *)

varapp of Variable*(Term list) |

varapp2 of Variable*(Term list) |

constapp of PropFun*(Term list) |

error (* to signal error conditions *) 

(* Term is the type of arguments to variable pfs: these
can be individuals (thus type 0), variables (of polymorphic
type), or pfs.  It should be noted that pfs appearing as arguments
cannot have parameters: all variables appearing in pf arguments
are bound.  The only free variables in a varhead or varhead2
term are those appearing in the argument list by themselves. *)

and Term = Const of Name | Var of Variable | Fun of PropFun |

Desc of (string*Variable list*PropFun); (* change description terms to abstract
over a vector *)

(* for the following free variable function we need a type of 
sets of variables *) 

(* a set of variables is an ordered list of variables *) 

fun insertvar v nil = [v] | 

insertvar v (w::L) = if lessvar v w then (v::(w::L)) 
else if v = w then (w::L) 
else w::(insertvar v L); 

fun union L nil = L | 

union nil L = L | 

union (v::L) (w::M) = insertvar v (insertvar w (union L M)); 

fun deletevar v nil = nil | 

deletevar v (w::L) = if lessvar v w then w::L 
else if v = w then L 
else w::(deletevar v L); 

fun deletevars nil L = L |

deletevars (v::M) L = deletevar v (deletevars M L);

fun foundin v nil = false | 
foundin v (w::L) = if lessvar v w then false 
else if v = w then true 
else foundin v L; 

fun allinlist predicate nil = true | 

allinlist predicate (x::L) = predicate x andalso allinlist predicate L; 

(* ORIGINAL newvar *)

fun newvar nil = X 1 | 

newvar [X n] = X (n+1) | 

newvar (v::L) = newvar L;

val NEWVAR = ref (X 1);

fun prevvar (X n) = (X (n-1));

fun setnewvar L = NEWVAR := newvar L;


(* *)


(*  MODIFIED newvar 

(* generate the first variable not in a set of variables *) 

(* much use of this function is not a good idea, due to type
considerations *)

fun newvar0 nil = X 1 | 

newvar0 [X n] = X (n+1) | 

newvar0 (v::L) = newvar0 L;

(* the next available new variable *)

(* the idea is to replace the original local technique of generating
new variables with a global one *)

val NEWVAR = ref (X 1);

fun prevvar (X n) = (X (n-1));

fun nextvar (X n) = (X (n+1));

fun newvar x = (NEWVAR:=nextvar(!NEWVAR);prevvar(!NEWVAR));

fun setnewvar L = NEWVAR := newvar0 L;

 *)

(* the free variable function on propositional functions *) 

fun FV (atomic(r,nil)) = nil |

FV (propvar n) = nil | 

FV (atomic(r,((var v)::L))) = insertvar v (FV(atomic(r,L))) | 

FV (atomic(r,((const c)::L))) = FV (atomic(r,L)) | 

(* the free variables in an elementary proposition are
simply the variables in the argument list *)

FV (negation T) = FV T | (* obvious *)

FV (disj(s,T,U)) = union (FV T) (FV U) | (* obvious *) 

FV (univ(s,v,T)) = deletevar v (FV T) | (* obvious *)

FV (varhead(v,nil)) = [v] | 

FV (varhead(v,(Var w)::L)) = union [w] (FV (varhead(v,L))) | 

FV (varhead(v,(Desc(s,w,T))::L)) = union (deletevars w (FV T))
                                   (FV (varhead(v,L))) |

(* with this clause and clauses below, there is a possibility that the
description term may be considered as binding occurrences of w in L.
I have to think about this. *)

FV (varhead(v,x::L)) = FV (varhead(v,L)) |

FV (varhead2(v,L)) = FV(varhead(v,L)) |

FV (varapp(v,L)) = FV (varhead(v,L)) |

FV (varapp2(v,L)) = FV (varhead(v,L)) |

FV (constapp(t,nil)) = nil |

FV (constapp(t,(Var w)::L)) = union [w] (FV (constapp(t,L))) |

FV (constapp(t,(Desc(s,w,T))::L)) = union (deletevars w (FV T))
                                   (FV (constapp(t,L)))
                                    | 

FV (constapp(t,x::L)) = FV (constapp(t,L)) |

(* surprisingly, the free variables in a varhead or varhead2
term are the variables in the argument list plus the head variable:
variables in pf arguments are all bound *)

FV error = nil; 

(* this function finds quantified variables in a term *)

(* note the new case for constant pf application terms -- there
seems to be no way to capture the quantified variables in the constant
pf applied other than to include them here *)

fun qvars (atomic(r,nil)) = nil | 

qvars (atomic(r,((var v)::L))) = nil |

qvars (propvar n) = nil | 

qvars (atomic(r,((const c)::L))) = nil | 

qvars (negation T) = qvars T | 

qvars (disj(s,T,U)) = union (qvars T) (qvars U) | 

qvars (univ(s,v,T)) = union [v] (qvars T) | 

qvars (constapp(t,L)) = union (qvars t) (qvars (varhead(X 0,L))) |

qvars (varhead(v,nil)) = nil |

qvars (varhead(v,(Desc(s,w,T))::L)) = union w
(union (qvars T) (qvars (varhead(v,L)))) |

qvars (varhead(v,x::L)) = qvars (varhead(v,L)) |

qvars (varhead2(v,L)) = qvars (varhead(v,L)) |

qvars (varapp(v,L)) = qvars (varhead(v,L)) |

qvars (varapp2(v,L)) = qvars (varhead(v,L)) |

qvars t = nil;

fun allvars t = union (FV t) (qvars t); 

(* lexical components of the parser, needed here for well-formedness
checking *)

fun isalpha x = 
x = #"A" orelse x = #"B" orelse x = #"C" orelse x = #"D" 
orelse x = #"E" orelse x = #"F" orelse x = #"G" 
orelse x = #"H" orelse x = #"I" orelse x = #"J" orelse x = #"K" 
orelse x = #"L" orelse x = #"M" orelse x = #"N"orelse x = #"O" 
orelse x = #"P"orelse x = #"Q"orelse x = #"R"orelse x = #"S" 
orelse x = #"T"orelse x = #"U"orelse x = #"V"orelse x = #"W" 
orelse x = #"X"orelse x = #"Y"orelse x = #"Z"; 

fun isloweralpha x = 
x = #"a" orelse x = #"b" orelse x = #"c" orelse x = #"d" 
orelse x = #"e" orelse x = #"f" orelse x = #"g" 
orelse x = #"h" orelse x = #"i" orelse x = #"j" orelse x = #"k" 
orelse x = #"l" orelse x = #"m" orelse x = #"n"orelse x = #"o" 
orelse x = #"p"orelse x = #"q"orelse x = #"r"orelse x = #"s" 
orelse x = #"t"orelse x = #"u"orelse x = #"v"orelse x = #"w" 
orelse x = #"x"orelse x = #"y"orelse x = #"z"; 

fun isnumeral x = x = #"0" orelse x = #"1" orelse x = #"2" orelse x = #"3" 
orelse x = #"4" orelse x = #"5" orelse x = #"6" orelse x = #"7" orelse x = 
#"8" orelse 
x = #"9"; 

fun numvalue (#"0") = 0 |numvalue(#"1") = 1 |numvalue(#"2") = 2 
|numvalue(#"3") = 3 |numvalue(#"4") = 4 |numvalue(#"5") = 5 
|numvalue(#"6") = 6 |numvalue(#"7") = 7 |numvalue(#"8") = 8 |numvalue(#"9") = 
9|numvalue x = ~1; 

fun getnumlist nil = nil | 

getnumlist (v::L) = if isnumeral v then (getnumlist L)@[v] 
else nil; 

fun evalnumlist nil = 0 | evalnumlist (v::L) = numvalue v + 10*(evalnumlist 
L); 

(* getnum reads numerical indices for the parser *) 

fun getnum nil = ~1 | 

getnum (v::L) = evalnumlist (getnumlist (v::L)); 

fun restnum nil = nil | 

restnum (v::L) = if isnumeral v then restnum L else (v::L); 

fun getalphalist nil = nil | 

getalphalist (v::L) = if isalpha v then (v::(getalphalist L)) else nil; 

(* getalpha reads relation names for the parser *)
 
fun getloweralphalist nil = nil | 

getloweralphalist (v::L) = if isloweralpha v 
then (v::(getloweralphalist L)) else nil; 

(* getloweralpha reads connective names for the parser *) 

fun getalpha nil = "" |

getalpha (v::L) = implode(getalphalist (v::L)); 

fun restalpha nil = nil | 

restalpha (v::L) = if isalpha v then restalpha L else v::L; 

fun getloweralpha nil = "" |

getloweralpha (v::L) = implode(getloweralphalist (v::L)); 

fun restloweralpha nil = nil | 

restloweralpha (v::L) = if isloweralpha v then restloweralpha L else v::L;

val PROPTYPES = ref true;val AMBTYPES = ref false;

fun proptypeson() = (PROPTYPES:=true;AMBTYPES:=false);
fun proptypesoff() = PROPTYPES:=false;
fun showproptypes() = if (!PROPTYPES) then TextIO.output(TextIO.stdOut,"\nProposition types are on.\n\n") else TextIO.output(TextIO.stdOut,"\nProposition types are off.\n\n");

(* turn off type checking in MP and extendparameters *)

fun ambtypeson() = (PROPTYPES:=false; AMBTYPES :=true);
fun ambtypesoff() = AMBTYPES:=false;

fun ambison() = (!AMBTYPES);

fun showambtypes() = if (!AMBTYPES) then TextIO.output(TextIO.stdOut,"\nTypical ambiguity is on.\n\n") else TextIO.output(TextIO.stdOut,"\nTypical ambiguity is  off.\n\n");

fun propfree T = propfree1 T andalso ((!PROPTYPES) orelse FV T <> nil)


and propfree1 (propvar n) = false |

propfree1 (negation T) = propfree1 T |

propfree1 (disj(s,T,U)) = propfree1 T andalso propfree1 U |

propfree1 (univ(s,v,T)) = propfree1 T |

propfree1 (varhead(v,nil)) = (!PROPTYPES) |

propfree1 (varhead(v,L)) = map (fn (Const c) => true | (Var v) => true |
         (Fun t) => propfree t |
         (Desc(s,v,T)) => propfree T) L = map (fn x => true) L |

propfree1 (varhead2(v,L)) = propfree1 (varhead(v,L)) |

propfree1 (varapp(v,L)) = propfree1 (varhead(v,L)) |

propfree1 (varapp2(v,L)) = propfree1 (varhead(v,L)) |

propfree1 (constapp(t,L)) = propfree t andalso propfree1(varhead(X 0,L)) |

propfree1 T = true;


(* well-formedness condition for propositional functions; 
it amounts to checking correct arity of primitive relations 
and non-presence of the special error term *)

(* it also checks that quantified variables actually appear
in their scopes, which is required in PM *) 

(* it also forbids propositional variables to occur in 
pf arguments *)

fun wellformed (atomic(r,L)) = arity r = length L |

wellformed (propvar n) = true | 

wellformed (negation T) = wellformed T | 

wellformed (disj(s,T,U)) =s<>"" andalso getloweralpha(explode s) = s andalso 
                          wellformed T andalso wellformed U | 

wellformed (univ(s,v,T)) = getalpha(explode s) = s andalso
                           wellformed T andalso foundin v (FV T)
                            | 

wellformed (varhead(v,L)) = allinlist Wellformed L 
andalso propfree(varhead(v,L)) |

wellformed (varhead2(v,L)) = allinlist Wellformed L 
andalso propfree(varhead(v,L)) |

wellformed (varapp(v,L)) = wellformed (varhead(v,L)) |

wellformed (varapp2(v,L)) = wellformed (varhead(v,L)) |

wellformed (constapp(t,L)) = wellformed t andalso wellformed (varhead(X 0,L))
andalso length(FV t) = length L | 

wellformed error = false 

and Wellformed (Const c) = true | Wellformed (Var v) = true | 
Wellformed (Fun T) = wellformed T |
Wellformed (Desc(s,v,T)) = 
wellformed T andalso map(fn v1=>foundin v1 (FV T))v = map (fn v1=>true)v;


(* print out pfs *) 

fun displayvar (X v) = "x"^(makestring v); 

fun displayvars nil = "" |

displayvars (v::L) = (displayvar v)^(displayvars L);

fun displayatomicterm (var(X n)) = "x"^(makestring n) | 

displayatomicterm (const(A n)) = "a"^(makestring n); 

fun displayatomicargs nil = ")" | 

displayatomicargs (T::nil) = (displayatomicterm T)^")" | 

displayatomicargs (T::L) = (displayatomicterm T)^","^(displayatomicargs L); 

fun display (atomic(r,L)) = if arity r = length L
then (relname r)^(makestring(arity r))^"("^(displayatomicargs L) 
else (relname r)^(makestring(arity r))^"???("^(displayatomicargs L) |

display (propvar n) = "p"^(makestring n) |

(* elementary propositions R0(), R1(a1), S3(x1,a22,x5)
Note that arity of a relation symbol is expressed in its
displayed form *) 

display (negation T) = "~"^(display T) |

(* ~T is the negation of T *) 

display (disj (s,T,U)) = "(" ^(display T)^" "^s^" "^(display U)^")" | 

(* (TvU) is disjunction of T and U -- in current version,
parentheses are mandatory, and the only pfs which begin
with parentheses are disjunctions *)

(* updated to allow general connectives *)

display (univ(s,v,T)) = if foundin v (FV T)

then "["^s^(displayvar v)^"]"^(display T) 

else "["^s^(displayvar v)^"???]"^(display T) |

(* [x3]T is the typical form -- don't enclose the scope
in parentheses! *) 

display (varhead(v,L)) = if propfree (varhead(v,L))

then (displayvar v)^"("^(displaytermargs L) 

else (displayvar v)^"???("^(displaytermargs L)|

(* x5(x1(a1),x2,a33) is a typical example (with arguments
a pf, a variable and an individual).  Here x5 may have any
order above the orders of its arguments. *)

display (varhead2(v,L)) = if propfree (varhead2(v,L))

then (displayvar v)^"!("^(displaytermargs L) 

else (displayvar v)^"!???("^(displaytermargs L)  |

(* x5!(x1(a1),x2,a33) is a typical example.  This construction
is not found in the Kamareddine et. al. paper.  Here it is
stipulated that the order of x1 is one greater than the largest order found among 
the arguments -- the notation is intended to suggest the notation
for "matrices" in PM (see p. 165), though the type of x5 does
not have to be predicative because there is no requirement that
the argument types be predicative. *)

display (varapp(v,L)) = if propfree (varapp(v,L))

then "<"^(displayvar v)^">("^(displaytermargs L)

else "<"^(displayvar v)^">???("^(displaytermargs L) |

display (varapp2(v,L)) = if propfree (varapp2(v,L))

then "<"^(displayvar v)^">!("^(displaytermargs L)

else "<"^(displayvar v)^">!???("^(displaytermargs L) |

display (constapp(t,L)) = if propfree (constapp(t,L))
andalso length(FV t) = length L

then "<"^(display t)^">("^(displaytermargs L)

else "<"^(display t)^">???("^(displaytermargs L) |

display error = " !?! " 

(* the following handles display of argument lists to pf application terms *)

and displaytermargs nil = ")" | 

displaytermargs ((Const (A n))::L) = "a"^(makestring n)^ 
(if L = nil then ")" else ","^(displaytermargs L)) | 

displaytermargs ((Var (X n))::L) = "x"^(makestring n)^ 
(if L = nil then ")" else ","^(displaytermargs L)) | 

displaytermargs ((Fun T)::L) = (display T) ^ 
(if L = nil then ")" else ","^(displaytermargs L)) |

displaytermargs ((Desc(s,v,T))::L) = "{"^s^(displayvars v)^"}"^(display T)^ 
(if L = nil then ")" else ","^(displaytermargs L));

(* we have the following idea for the parser: a term beginning with x 
is a varhead term; a term beginning with ~ is a negation; a term 
beginning with ( is a disjunction; a term beginning with [ is a 
universal quantification; a term beginning with a capital letter is an 
atomic proposition (or error). *)

(* The parser works.  There is some indication that problems
arise when spaces are inserted, though it is designed to handle
them. *) 


fun getvariable (#"x"::L) = if L = nil then (X 0) else (X (getnum L)) | 
getvariable x = (X ~1); 


fun restvariable (#"x"::L) = if L = nil then (L) else restnum L | 
restvariable x = x; 

fun getvariables (#"x"::L) = (getvariable L)::(getvariables (restvariable L)) |

getvariables x = nil;


fun restvariables (#"x"::L) = restvariables (restvariable (#"x"::L)) |

restvariables x = x;

fun getconstant (#"a"::L) = if L = nil then (A 0) else (A (getnum L))| 
getconstant x = (A ~1); 

fun restconstant (#"a"::L) = if L = nil then L else restnum L | 
restconstant x = x; 

fun getrel nil = R("",~1) |

getrel (v::L) = R(getalpha(v::L),getnum(restalpha(v::L))); 

fun restrel nil = nil |

restrel (v::L) = restnum(restalpha(v::L)); 

(* this will read over spaces *) 

fun despace nil = nil | 

despace (#" "::L) = despace L | 

despace L = L; 


(* read an atomic argument *) 

fun getatomicterm nil = var(X ~1) |

getatomicterm (v::L) = if v = #"a" then const(getconstant (v::L)) 
else if v = #"x" then var(getvariable (v::L)) 
else const(A ~1); 

fun restatomicterm nil = nil |

restatomicterm (v::L) = if v = #"a" then restconstant (v::L) 
else if v = #"x" then restvariable (v::L) 
else (v::L); 

(* read an argument list of atomic terms *) 

fun getatomictermlist nil = nil | 

getatomictermlist (v::L) = if v = #")" then nil 

else if v = #"a" orelse v = #"x" then (getatomicterm (v::L):: 
(let val M = despace(restatomicterm (v::L)) in 

if M = nil then nil 

else if hd M = #")" then nil 

else if hd M = #"," then getatomictermlist (despace(tl M)) 

else nil end))

(* else if v = #"{" then (getterm (v::L)::

(let val M = despace(restterm (v::L)) in 

if M = nil then nil 

else if hd M = #")" then nil 

else if hd M = #"," then getatomictermlist (despace(tl M)) 

else nil end)) *)

else nil

and restatomictermlist nil = nil | 

restatomictermlist (v::L) = if v = #")" then L 

else if v = #"a" orelse v = #"x" then 

let val M = despace(restatomicterm (v::L)) in 

if M = nil then nil 

else if hd M = #")" then despace(tl M) 


else if hd M = #"," then restatomictermlist (despace(tl M))

else nil end 

(* else if v = #"{" then 

let val M = despace(restterm (v::L)) in 

if M = nil then nil 

else if hd M = #")" then despace(tl M) 

else if hd M = #"," then restatomictermlist (despace(tl M))

else nil end *)

else nil 

(* the parser -- here goes nothing! *) 

(* the parser allows parentheses only to enclose argument lists 
and to enclose disjunction terms, and in both of these cases they 
are required *) 

and preparse nil = error | 

preparse (v::L) = if v = #"~" then negation (preparse (despace L)) 

else if v = #"(" then let val T1 = preparse (despace L) and

R1 = despace(restparse L) in

if R1 = nil orelse not(isloweralpha(hd R1)) then error

else disj(getloweralpha R1,T1,preparse(despace(restloweralpha R1))) end 

else if v = #"[" then univ(getalpha L,getvariable ((restalpha (despace L))), 

let val M = despace(restvariable (restalpha(despace L))) in 

if M = nil then error else 

if hd M = #"]" 

then preparse (despace(tl M)) 

else error 

end 

) 

else if v = #"x" then let val V = getvariable (v::L) and 

M = despace(restvariable(v::L)) in 

if M = nil then (varhead(V,[Fun(error)]))

else if hd M = #"!"

then let val M2 = despace(tl M) in

if hd M2 <> #"(" then varhead2(V,[Fun(error)])

else varhead2(V,parsetermlist(despace(tl M2)))

end

else if hd M <> #"(" then varhead(V,[Fun(error)]) 

else varhead(V,parsetermlist (despace(tl M))) 

end

else if isalpha v then atomic(getrel(v::L), 

let val M = despace(restrel (v::L)) in 

if M = nil orelse hd M <> #"(" then nil 

else getatomictermlist (despace (tl M)) 

end) 

else if v = #"p" then propvar(getnum L)

else if v = #"<" then let val HEAD = getterm(despace(L)) in

(fn (Const c) => error | (Desc(s,v,T)) => error |

(Var v) => if restterm(despace(L)) = nil orelse
hd(restterm(despace(L))) <> #">"

then error 

else if length(restterm(despace L)) >= 3 andalso hd(tl(restterm(despace( L)))) =
#"!" andalso hd(tl(tl(restterm(despace L)))) = #"("

then varapp2(v,parsetermlist(despace(tl(tl(tl(restterm(despace( L))))))))

else if length (restterm(despace L)) >= 2 andalso
hd(tl(restterm(despace( L)))) = #"("

then  varapp(v,parsetermlist(despace(tl(tl(restterm(despace( L)))))))

else error      

|

(Fun t) => if length (restterm(despace L)) < 2 orelse
hd(restterm(despace( L))) <> #">" orelse hd(tl(restterm(despace L)))
<> #"("

then error

else constapp(t,parsetermlist(despace(tl(tl(restterm(despace( L)))))))

) HEAD        


end 

else error 

and restparse nil = nil | 

restparse (v::L) = if v = #"~" 

then restparse L 

else if v = #"(" then let val M = despace(restparse L) in 
if M = nil orelse not(isloweralpha (hd M)) then M
else let val N = restparse(despace(restloweralpha M)) in
if N = nil orelse hd N <> #")" then N else tl N end end

else if v = #"[" then let val M = despace(restvariable (restalpha L)) 
in if M = nil orelse hd M <> #"]" then M 
else restparse(despace(tl M)) 
end 

else if v = #"x" 
then let val M = despace(restvariable (v::L)) 
in if M = nil 
   then M
   else if hd M = #"!" 
      then let val M2 = despace(tl M) in
         if M2 = nil orelse hd M2 <> #"(" 
            then M
            else resttermlist(despace(tl M2)) end
      else if hd M <> #"(" 
        then M 
        else resttermlist(despace(tl M)) 
      end

else if isalpha v 

then let val M = despace(restrel (v::L)) in 
if M = nil orelse hd M <> #"(" then M 
else restatomictermlist(despace(tl M)) 
end 

else if v = #"p" then restnum L

else if v = #"<" then if restterm(despace L) = nil orelse
hd(restterm(despace L)) <> #">" then L else if length(restterm(despace
L)) >=3 andalso hd(tl(restterm(despace L))) = #"!" andalso
hd(tl(tl((restterm (despace L))))) = #"(" then
resttermlist(tl(tl(tl(restterm (despace L))))) else

if length(restterm(despace L)) >= 2 andalso hd(tl(restterm(despace
L))) = #"(" then resttermlist(tl(tl(restterm L))) else L

else (v::L) 

and getterm nil = Fun error | 

getterm (v::L) = if v = #"{" then Desc(getalpha L,getvariables ((restalpha (despace L))), 

let val M = despace(restvariable (restalpha(despace L))) in 

if M = nil then error else 

if hd M = #"}" 

then preparse (despace(tl M)) 

else error 

end 

) 
 

else if v = #"a" then Const (getconstant (v::L)) 

else if v = #"x" then let val M = despace(restvariable (v::L)) in 
if M = nil then Fun error else if hd M = #")" orelse hd M = #"," 

orelse hd M = #">"

then Var (getvariable (v::L)) else Fun (preparse (v::L)) 
end 

else Fun (preparse(v::L)) 

and restterm nil = nil | 

restterm (v::L) = if v = #"{" then let val M = despace(restvariable
(restalpha L)) in if M = nil orelse hd M <> #"}" then M else
restparse(despace(tl M)) end

else if v = #"a" then restconstant (v::L) 
else if v = #"x" then let val M = despace(restvariable (v::L)) in 
if M = nil then nil else if hd M = #")" orelse hd M = #"," 

orelse hd M = #">" 

then restvariable (v::L) else if hd M = #"(" then 
resttermlist (despace (tl M)) else if hd M = #"!" 
then if M <> nil andalso hd (tl M) = #"(" then 
resttermlist(despace (tl(tl M))) else
M else M

end 

else restparse(v::L) 

and parsetermlist nil = [Fun error] | 

parsetermlist (v::L) = if v = #")" then nil 

else let val M = despace(restterm (v::L)) in 

if M = nil orelse (hd M <> #")" andalso hd M <> #",") 

then [Fun error] 

else (getterm (v::L))::(if hd M = #")" then nil 
else parsetermlist(despace(tl M))) 

end 

and resttermlist nil = nil | 

resttermlist (v::L) = if v = #")" then despace L 

else let val M = restterm (v::L) in 

if M = nil orelse (hd M <> #")" andalso hd M <> #",") 

then M 

else if hd M = #")" then despace (tl M) 

else resttermlist (despace (tl M)) 

end; 

(* parser will append an error disjunct if the whole term is not used
(this usually signals a missing leading parenthesis) *)

fun parse s = if despace(restparse (explode s)) = nil 
              then let val S = preparse(explode s) in

              (setnewvar (insertvar (prevvar(!NEWVAR)) (allvars S));S) end
              else disj("...",preparse(explode s),error); 

(* examples: all parse but some do not typecheck for various reasons. 

FV(parse "R0()"); 

FV(parse "(R0()vS2(a2,x351))"); 

FV(parse "[x1](R0()vS2(a2,x351))"); 

FV(parse "[x1][x2]x1(x2)"); 

FV(parse "x1((R0()vS2(a2,x351)),x5,x2(x3,x4))"); 

(* this is interesting (uses function from below): 

- test "x1((R0()vS2(a2,x351)),x5,x2(x3,x4))"; 
> val it = "(((0),[x5],(([x3],[x4]),[x3],[x4])),[x5])" : string 

*) 


FV(parse "x1((R0()vS2(a2,x351)),[x1]E2(a1,x1))"); 

FV(parse "x1([x2]x1(x3),[x1]E2(a1,x1))"); 

FV(parse "[x1](~R(x1,x3)vR(x2,x1))"); 

*) 




(* construction of the data type of simple types *)

datatype SimpleType = individual | (* type 0 *)

ArgTypes of SimpleType list | (* types (t_1,...,t_n) *)

Unknowntype of int | (* unknown type of polymorphic occurrences of the
                      variable xn *)

simpletyperror; 

(* display function for simple types *)

fun showsimpletype individual = "0" | 

showsimpletype (ArgTypes nil) = "()" | 

showsimpletype (ArgTypes [t]) = "("^(showsimpletype t)^")" | 

showsimpletype (ArgTypes (t::L)) = "("^(showsimpletype t)^"," 
^(implode(tl (explode (showsimpletype (ArgTypes L))))) | 

showsimpletype (Unknowntype n) = "[x"^(makestring n)^"]" |

     (* the polymorphic type of variable xn is [xn] *) 

showsimpletype simpletyperror = " !?! "; 

(* the parser isn't really used, but I wrote one *)

(* Parser allows no spaces in type symbols *) 

fun getsimpletype nil = simpletyperror | 

getsimpletype (#"0"::L) = individual | 

getsimpletype (#"("::L) = ArgTypes(getsimpletypelist L) | 

getsimpletype t = simpletyperror 

and restsimpletype nil = nil | 

restsimpletype (#"0"::L) = L | 

restsimpletype (#"("::L) = restsimpletypelist L | 

restsimpletype t = nil 

and getsimpletypelist nil = [simpletyperror] | 

getsimpletypelist (#")"::L) = nil | 

getsimpletypelist t = let val M = restsimpletype t 

in if M = nil orelse (hd M <> #")" andalso hd M <> #",") 

then [simpletyperror] 

else if hd M = #")" then [getsimpletype t] 

else (getsimpletype t)::(getsimpletypelist(tl M)) 

end 

and restsimpletypelist nil = nil | 

restsimpletypelist (#")"::L) = L | 

restsimpletypelist t = let val M = restsimpletype t 
in if M = nil orelse (hd M <> #")" andalso hd M <> #",") 

then nil 

else if hd M = #")" then tl M 

else restsimpletypelist(tl M) end; 

fun parsesimpletype s = getsimpletype(explode s); 

(* I now begin development of the type checker for
simple type theory (no orders); of course for this system
the notations x1(t1...tn) and x1!(t1...tn) do not need
to be distinguished *)

(* Instead of embedding type indices in terms (which would complicate 
the parser I have already written), type judgments will apply to all 
occurrences of a given variable, bound or free, and the type inference 
algorithm will rename bound variables which already have type judgments 
attached to them *) 

(* this is not actually what happens!  As it turns out,
the only variables in pf arguments which can have type conflicts
with free variables are those with polymorphic types *)

(* note that in the ramified type theory checker below
I do not rename quantified variables *)

(* the type system has to allow 
"unknown" types of variables for unification purposes *) 

(* type inference rules (simple types): 

A type judgment is a list of assignments of types to variables. 
The type inference function yields a form for the current pf 
(bound variables may be renamed) and a type assignment for that 
pf, plus a list of type assignments to variables. 

From the recursive structure, it appears that the function 
also needs a list of type assignments to variables as an argument. 

arguments of primitive relations have type 0. 

if a term x1(t1,...tn) appears, then we assign x1 type (T1...Tn), 
where Ti is the type assigned to ti. 

if we have already assigned a type to xi when we come to typing 
[xi]T, we should rename xi before proceeding. Then type the 
possibly updated T. 

strategy: in reading a pf, when Rn(t1...tn) is encountered, 
assign each ti which is a variable type 0. (Notice that no 
conflicts can arise). 

typing of ~T is the same as typing of T. 

typing of (T v U) is "type T, then type U using these judgments". 

typing of [xi]T: if xi has already been assigned a type, rename it; 
whether it is renamed or not, type the resulting version of T. 

typing of xi(T1...Tn) goes as follows: type each term (atoms get type
0, variables get unknown type, unless they are already typed) and
assign max of the unknown type [xi] and type (type(T1)...type(Tn)) to
xi.

typing of xi!(T1...Tn) goes as follows: type each term (atoms get type
0, variables get unknown type, unless they are already typed) and
assign type (type(T1)...type(Tn)) to xi.


unification: when a variable is assigned two superficially different 
types, the types need to be unified: unification of two pf types fails 
if they have different numbers of arguments, and otherwise amounts to 
unification of each pair of corresponding arguments: unification of an 
unknown type (type variable) with another type amounts to assignment 
of a type to that variable (or equation of two unknown variable 
types: in this case we take the lower indexed unknown type and assign 
it to the higher indexed variable). 

The type we finally assign to a pf is the list of types of its 
free variables in order. *)

(*  

There is one form of collision of free and bound variables
that follows from the curious handling of free variables in the
notation for pfs:  variables which are not really to be identified
and which are assigned "base" polymorphic types will be assigned
the same polymorphic type.

This may cause type failure or greater specificity of type which
could have been avoided by renaming bound variables.  I have no intention
of fixing this.

*)

(* functions to handle finite functions with domain a set of variables *) 

(* the parameter U controls "unification" of distinct values given for the 
same variable. U allows the addition of many items to the list. *) 

fun addtovarfun U (v,x) nil = [(v,x)] | 

addtovarfun U (v,x) ((w,y)::L) = 

if lessvar v w then ((v,x)::((w,y)::L)) 

else if v = w 

then if x = y then ((w,y)::L) 

else (U v x y)@L 

else (w,y)::(addtovarfun U (v,x) L); 

fun vsegment v nil = nil |

  vsegment v ((w,x)::L) = if v=w then (w,x)::(vsegment v L)

  else nil;

fun dropvs v nil = nil |

  dropvs v ((w,x)::L) = if v = w then dropvs v L

  else ((w,x)::L);

fun findinvarfun v nil = nil | 

findinvarfun v ((w,x)::L) = if v = w then [x] else findinvarfun v L; 

fun sortvarfun U nil = nil | 

sortvarfun U ((v,x)::L) = 

let val M = addtovarfun U (v,x) (sortvarfun U L) in 

if (* M = (v,x)::L *) dropvs v M = dropvs v L then M else 

(vsegment v M)@(sortvarfun U (dropvs v M)) end; 

fun mergevarfuns U L M = sortvarfun U (L @ M); 

(* the failure test is to look for the error value in the list *) 

fun foundinvarfun x nil = false | 

foundinvarfun x ((v,y)::L) = 

x=y orelse foundinvarfun x L; 

fun indomain v nil = false | 

indomain v ((w,Fun x)::L) = v=w orelse indomain v L |

indomain v ((w,x)::L) = indomain v L;

fun domainofvarfun nil = nil | 

domainofvarfun ((v,x)::L) = v::(domainofvarfun L); 

fun rangeof nil = nil | 

rangeof ((v,x)::L) = x::(rangeof L); 

fun restrictvarfun d nil = nil | 

restrictvarfun d ((v,x)::L) = if foundin v d 

then (v,x)::(restrictvarfun d L) 

else restrictvarfun d L 

fun dropvarfromfun v x L = mergevarfuns (fn v =>(fn x=>(fn y=> nil))) 

[(v,x)] L; 

(* functions of arbitrary keys *)

fun foundinkeyfun s nil = false |

foundinkeyfun s ((t,u)::L) = s=t orelse foundinkeyfun s L;

fun dropfromkeyfun s nil = nil |

dropfromkeyfun s ((t,u)::L) = if s=t then dropfromkeyfun s L

else (t,u)::(dropfromkeyfun s L);

fun addtokeyfun s t L = (s,t)::(dropfromkeyfun s L);

fun getfromkeyfun s nil = nil |

getfromkeyfun s ((t,u)::L) = if s=t then [u] else getfromkeyfun s L;



(* onetypesub makes the substitution of type t for
the polymorphic type [xn] of the nth variable in the type
given as its second argument *)

fun onetypesub (n,t) individual = individual | 

onetypesub (n,t) (ArgTypes L) = 

ArgTypes (map (onetypesub (n,t)) L) | 

onetypesub (n,t) (Unknowntype m) = if n=m then t else Unknowntype m | 

onetypesub (n,t) simpletyperror = simpletyperror; 

(* safeonetypesub makes the substitution twice -- if the second
substitution changes the result of the first, the type must
be ill-formed and an error type is returned *)

(* it remains an interesting question whether this circularity
check is ever really needed; it seems that this might always be
detected at the final unification stage using order *)

fun safeonetypesub (n,t) T = 

let val B = onetypesub (n,t) T in 

if onetypesub (n,t) B = B then B else simpletyperror end;



(* reducesimpletypelist is applied to a list of proposed
assignments of type values to the polymorphic types
[xn] -- there may be more than one assignment to each type.
Each substitution in turn is applied (using safeonetypesub)
to the entire list.  Any circularity of definition of types
will be detected and cause an error type to be assigned to
one of the polymorphic types.  *)

fun reducetypelist0 n nil nil = nil | 

reducetypelist0 n (((X m),t)::L) M = if n <= 1 

then map (fn (a,b) => (a, safeonetypesub (m,t) b)) M 

else reducetypelist0 (n-1) L M |

reducetypelist0 x y z = nil; 

fun reducetypelist1 n L = if n>length L then L else 

reducetypelist1 (n+1) (reducetypelist0 n L L); 

fun reducesimpletypelist L = reducetypelist1 1 L; 


(* stage 0:  develop new list handling tools *)

(* the idea here is that we work with "multi-valued functions" with domain
variables -- sorting on the order of variables is maintained and identical
items are collapsed together, but there can be multiple values at a single
variable *)

fun newadd (X n,t) nil = [(X n,t)] |

newadd (X n,t) ((X m,u)::L) = if m < n then ((X m,u)::(newadd (X n,t) L))

   else if n < m then ((X n,t)::((X m,u)::L))

   else if t = u then ((X m,u)::L) else ((X m,u)::(newadd (X n,t) L));

fun newunion nil L = L |

newunion L nil = L |

newunion (x::L) (y::M) = newadd x (newadd y (newunion L M));

fun newfound x nil = false |

newfound x ((y,z)::L) = x = z orelse newfound x L;

fun newunions nil = nil |

newunions (L::M) = newunion L (newunions M);

fun newpointfound x nil = false |

newpointfound x (y::L) = x=y orelse newpointfound x L;

fun newdroppoint x nil = nil |

newdroppoint x (y::L) = if x=y then L else
y::(newdroppoint x L);

fun dropfromlist x nil = nil |

dropfromlist x (y::L) = if x=y then dropfromlist x L
else (y::(dropfromlist x L));


fun uniquelist nil = nil |

uniquelist (x::L) = x::(dropfromlist x(uniquelist L));

(* list equality needs to be defined because there
is no canonical order for multiple values at the same
variable *) 

fun equallists nil nil = true |

equallists t nil = false |

equallists nil t = false |

equallists (x::L) (y::M) = if x = y then

equallists L M else 

newpointfound x (y::M) andalso newpointfound y (x::L)
andalso equallists (newdroppoint x (M)) 
(newdroppoint y (L));

fun newstrict nil = true |

newstrict [x] = true |

newstrict ((x,u)::((y,v)::L)) = x <> y andalso newstrict ((y,v)::L);

fun newnth n L = if n = 1 then hd L else newnth (n-1) (tl L);

fun neweval (X m) nil = Unknowntype m |

neweval (X n) (((X m),t)::L) = if m=n then if neweval (X n) L = t
orelse neweval (X n) L = Unknowntype n then t else simpletyperror
else neweval (X n) L;

(* stage 1:  develop a list of all the type assignments implied
by the syntax of the term. basiclist t *)

(* utility for typing of constant pf application terms *)

fun specialfold nil L = nil |

specialfold L nil = nil |

specialfold (X n::L) (Var (X m)::M) = newadd (X n,Unknowntype m) 
(newadd (X m,Unknowntype n) (specialfold L M)) |

specialfold (v::L) (Const c::M) =  newadd (v,individual) (specialfold L M) |

specialfold (v::L) (Fun t::M) = newadd (v,newtypecheck t) (specialfold L M) |

specialfold ((X n)::L) (Desc("I",[X m],T)::M) = newadd (X n,neweval (X m) (finaltypelist T)) (specialfold L M)

(* NOTE:  other clauses needed here for class and relation constructions *)

(* the varhead clause looks ahead to a function termtype defined later *)

(* addition of pf constant application causes another recursive
look ahead using newtypecheck in the specialfold utility just defined *)

and basiclist (atomic(r,L)) = map (fn x => (x,individual))(FV (atomic(r,L)))  |

basiclist (negation T) = (basiclist T) |

basiclist (disj(s,T,U)) =(newunion(basiclist T)(basiclist U)) |

basiclist (univ(s,v,T)) = basiclist T |

(* basiclist (varhead(v,L)) = newadd (v,ArgTypes(map termtype L)) (map
(fn (X n) => (X n,Unknowntype n)) (FV (varhead(v,L)))) | 

basiclist (varhead2(v,L)) = newadd (v,ArgTypes(map termtype L)) (map
(fn (X n) => (X n,Unknowntype n)) (FV (varhead(v,L)))) | *)

basiclist (varhead(v,L)) = newadd (v,ArgTypes(map termtype L))

(newunions (map (fn (Var (X n)) => [((X n),Unknowntype n)] |

(Desc(s,w,T)) => basiclist T | x => nil) L)) |

basiclist (varhead2(v,L)) = basiclist (varhead(v,L)) |

basiclist (varapp(v,L)) = basiclist(varhead(v,L)) |

basiclist (varapp2(v,L)) = basiclist(varhead2(v,L)) |

basiclist (constapp(t,L)) = newunion(basiclist t)(specialfold (FV t) L) |

basiclist (propvar p) = nil |

basiclist error = [(X 0,simpletyperror)]

(* stage 2:  unify.  This is complex *)

(* identifytypes generates the list of type identifications determined
by the unification of a pair of types; this approach will not work (or at
least not this readily) with ramified types, unless I come up with some
clever idea to code order information using dummy variable typings --
which is not too hard to imagine *)

(* this avoids the need to represent type equations specifically *)

and identifytypes (Unknowntype m) (Unknowntype n) = if m <> n then 
newadd (X n,Unknowntype m) [(X m,Unknowntype n)] else nil | 

identifytypes (Unknowntype n) t = [(X n,t)] |

identifytypes t (Unknowntype n) = [(X n,t)] |

identifytypes individual individual = nil |

identifytypes (ArgTypes nil) (ArgTypes nil) = nil |

identifytypes (ArgTypes(t::L)) (ArgTypes(u::M)) =
newunion (identifytypes t u) (identifytypes (ArgTypes L) (ArgTypes M)) |

identifytypes t u = [(X 0,simpletyperror)]

(* samevarlist detects the initial bloc in a multi-valued
function of values associated with the same domain element *)

and samevarlist nil = nil |

samevarlist [x] = [x] |

samevarlist ((x,t)::(y,u)::L) = if x=y then ((x,t)::(samevarlist ((y,u):: L)))
                                       else [(x,t)]
 
(* newidslist is the list of new variable typing assertions
generated by one pass of unifications of different types assigned
to the same variable in its argument *)

and newidslist nil = nil |

newidslist [x] = nil |

newidslist ((x,t)::(y,u)::L) = if x <> y then newidslist ((y,u)::L)
else newunion (identifytypes t u) 
(newunion(newidslist((x,t)::(tl(samevarlist((y,u)::L)))))(newidslist((y,u)::L)))

(* newunify (the result of the unification step) is computed
by applying newidslist until it no longer introduces any new
assertions *)

and newunify L = let val M = newunion L (newidslist L) in

if equallists L M then L else newunify M end

(* stage 3:  universal substitution *)

(* use reducesimpletypelist, which is already written, and implements the same
idea *)

(* we now need to define newtypecheck and termtype from above *)

and listcollapse L = newunion L L  (* listcollapse is used
to eliminate duplicate elements from the output of 
reducesimpletypelist *)

and finaltypelist t = listcollapse(reducesimpletypelist
     (newunify(basiclist t)))

and newtypecheck t = let val T = finaltypelist t in

if newstrict T andalso not (newfound simpletyperror T)

then ArgTypes(map (fn x => neweval x T) (FV t))

else simpletyperror

end

and termtype (Var (X n)) = Unknowntype n |

termtype (Const v) = individual |

termtype (Fun t) = newtypecheck t |

termtype (Desc("I",[v],T)) = neweval v (finaltypelist T);

(* NOTE:  clauses needed in termtype for class and relation constructions *)

fun typecheck2 t = showsimpletype(newtypecheck(parse t));

fun showtypelist1 nil = "" |

   showtypelist1 ((v,t)::L) = ((displayvar v)^":  "^(showsimpletype t)^"\n")^
                             (showtypelist1 L);

fun showbasic s = TextIO.output(TextIO.stdOut,"\nbasic list:\n\n"^(showtypelist1(basiclist(parse s)))^"\n");

fun showunified s = TextIO.output(TextIO.stdOut,"\n\nunification list:\n\n"^(showtypelist1(newunify(basiclist(parse s)))^"\n"));

fun showfinal s = TextIO.output(TextIO.stdOut,"\n\nfinal type list:\n\n"^(showtypelist1(listcollapse(reducesimpletypelist(newunify(basiclist(parse s))))))^"\n");

fun test s = (showbasic s;showunified s;showfinal s;
TextIO.output(TextIO.stdOut,(typecheck2 s)^"\n\n"));

(* a test suite *)

(* test "((R1(x1)v x2(a1))v x2(x1))"; *) 

(* test "((x1()v x2(R1(a1))v x2(x1))"; *) 

(* test "(R1(x2)v x1(x1(x2)))"; *) 

(* test "(R1(x2)v x1(x2(x1)))"; *) 

(* test "((x1(a1)v x2())v x3(x1,x2))"; *) 

(* test "R1(x1)"; *) 

(* test "x2(R1(x1),S1(a1))"; *) 

(* test "(x1(a1)v x2())"; *) 

(* test "x3(x2(R1(x1)))"; *) 

(* test "[x1]R1(x1)"; *) 

(* test "[x1]~x2(x1)"; *) 

(* test "~x1(x1)"; *) 

(* test "[x1](x1()v~x1())"; *) 

(* typecheck "(R1(x1) v S1(x1))"; *) 

(* typecheck "x2(R1(x1))"; *) 

(* typecheck "S2(a1,a2)"; *) 

(* typecheck "(R1(a1) v S1(a1))"; *) 

(* typecheck "x3(R1(x1),S1(x2))"; *) 

(* typecheck "x2(x1,x1)"; *) 

(* typecheck "(x1(a1) v x2(x1,x1))"; *) 

(* typecheck "x3(x1,x2)"; *) 

(* typecheck "((R1(x1)vR1(x2))v x3(x1,x2))"; *) 

(* typecheck "R1(a1)vS1(a1)"; *) 

(* test "(R1(x1)v~T3(x1,x1,x2))"; *) 

(* typecheck "(x1(a1)vS1(a1))"; *) 

(* typecheck "(x1()v x2())"; *) 

(* typecheck "x1()"; *) 

(* typecheck "((x1(a1)v x2())v x3(x1,x2))"; *) 

(* begin development of ramified type theory *) 

datatype RamifiedType = Individual | (* type 0 *)

ComplexType of (RamifiedType list)*(int*((Variable*int)list)) |

(* orders are represented by a pair (n,L), where n is
an integer and L is a list of pairs (xm,i) of variables
and integers:  this represents the maximum of the integer
n and a list of unknown quantities:  (xm,i) is the order
of the polymorphic type xm plus the integer i *)

(* most of the complexity of the problem of typechecking
the ramified theory comes from handling the orders correctly! *) 

UnknownType of int |  (* polymorphic types of variables *)

ramifiedtyperror; (* error type *)

fun max (m:int) n = if m>n then m else n; 

fun unionlist nil = nil | unionlist (v::L) = union v (unionlist L); 

(* functions acting on orders *) 

(* increment order *) 

fun plusone (n,L) = (n+1,map (fn (v,m)=>(v,m+1)) L); 

(* add an integer to an order *)

fun plusN N (n,L) = (n+N,map (fn (v,m)=>(v,m+N)) L); 


(* find the displacement from a given polymorphic order
of a given order *)

fun displacement n (v,nil) = 0 | 

displacement n (v,(((X m),p)::L)) = 

if n<m then 0 

else if n=m then p 

else displacement n (v,L); 

(* maximum of orders *) 

fun ordermax (m,L) (n,M) = (max m n, 
mergevarfuns (fn z=>(fn x=>(fn y=> [(z,max x y)]))) L M); 

(* maximum of a list of orders *)

fun maxlist nil = (~1,nil) | maxlist (v::L) = ordermax v (maxlist L); 

(* display orders *) 

fun showorder (n,nil) = makestring n | 

showorder (n,[((X v),m)]) = "max(" 
^"|x"^(makestring v)^"|"^
(if m = 0 then "" else "+"^(makestring m))^","^(makestring n)^")" | 

showorder (n,(((X v),m)::L)) = "max("^ 
("|x"^(makestring v)^"|"^(if m=0 then "" else "+"^(makestring m))^",")^ 
implode(tl(tl(tl(tl(explode(showorder(n,L)))))));


(* compute the order of a type *)

fun typeorder Individual = (0,nil) | 

typeorder (ComplexType (L,M)) = M | 

typeorder (UnknownType n) = (0,[((X n),0)]) | 

typeorder ramifiedtyperror = (~1,nil); 

(* compute the "bounding variable" (if any) of an order *)

val NEWBOUNDINGVAR = ref 0;

val BOUNDINGVARS = ref [((X ~1),typeorder (UnknownType (~1)))];

val _ = BOUNDINGVARS:= nil;

fun findboundingvar x nil = (NEWBOUNDINGVAR:=(!NEWBOUNDINGVAR)-1;
BOUNDINGVARS:=((X (!NEWBOUNDINGVAR)),x)::(!BOUNDINGVARS);
X (!NEWBOUNDINGVAR)) |

findboundingvar x ((y,z)::L) = if x=z then y else findboundingvar x L;

fun preboundingvar orig (n,nil) = findboundingvar orig (!BOUNDINGVARS) |

preboundingvar orig (n,((X m),p)::L) = if p=0 then X m
     else preboundingvar orig (n,L);

fun boundingvar x = preboundingvar x x;


(* check for well-formedness of types *)

(* i.e., check for the correct relations of orders
of type components to the whole type *) 

fun checktypeorder Individual = true | 

checktypeorder (ComplexType(L,M)) = 

M = ordermax M (plusone(maxlist(map typeorder L))) 
andalso map checktypeorder L = map (fn x => true) L | 

checktypeorder (UnknownType n) = true | 

checktypeorder ramifiedtyperror = false; 

(* substitution into types *) 

fun subintotype ((X n),t) (m,L) = 

if foundin (X n) (domainofvarfun L) 

andalso t <> (UnknownType n)

then 

ordermax (plusN (displacement n (m,L)) (typeorder t)) 
(m,dropvarfromfun (X n) ~2 L) 

else (m,L); 

(* make a list of substitutions into a type *)

fun sublistintotype nil T = T | 

sublistintotype (v::L) T = subintotype v (sublistintotype L T); 

(* the display function does not show minimal orders;
so predicative types look just like the corresponding
simple types. *) 

fun showramifiedtype Individual = "0" | 

showramifiedtype (ComplexType(L,M)) = 

if checktypeorder (ComplexType(L,M)) then 

if M = plusone(maxlist(map typeorder L)) 

then showramifiedtypelist L 

else (showramifiedtypelist L)^"^"^(showorder M) 

else " ?!? " | 

showramifiedtype (UnknownType n) = "[x"^(makestring n)^"]" | 

showramifiedtype ramifiedtyperror = " ?!? " 

and showramifiedtypelist nil = "()" | 

showramifiedtypelist [t] = "("^(showramifiedtype t)^")" | 

showramifiedtypelist (t::L) = "("^(showramifiedtype t)^"," 
^(implode(tl(explode(showramifiedtypelist L)))); 

fun max (m:int) n = if m>n then m else n;

fun min (m:int) n = if m<n then m else n;


(* next problem:

develop facility to determine consistency of sets of 
equations between maxima of polymorphic orders, in order
to construct a complete RTT checker:  the one given above
is not complete.

1.  eliminate occurrences of the same order variable on
both sides of an equation, unless the two occurrences have
the same constant displacement.

2.  Expand into collections of inequalities, by cases (determined
by which two items are declared to be maximal).

3.  The expansion process will lead (in each case) to a collection of
equations or inequalities between polymorphic orders, which can be
modified to values or bounds on differences between order variables.

x+m <= y+n becomes x-y <= n-m and y-x >= m-n

Then work with the triangle inequality.

Basic item: (m,n,r) meaning |xm| - |xn| <= r.  |xm| - |xn| >= r is
equivalent to (n,m,-r).  Operations:  given (m,n,r) and (m,n,s),
keep (m,n,min(r,s)); given (m,n,r) and (n,p,s), get (m,p,r+s).
(m,m,r) is unremarkable if r>=0, impossible if r<0.  If we
have the equation |xm| = |xn| + r, this is equivalent to
(m,n,r) and (n,m,-r) together.  We also need to represent 
differences involving 0.  (0,m,0) always holds, so (0,m,-r) is
another impossible conclusion.

A situation is represented by a list of lists of triples,
where the items in the top level list are cases.

Convert an equation between polymorphic orders into a list of
lists as follows -- choose one term of each maximum to be
the maximum -- it needs to exceed each other term in its own
term and be equal to the other top term.  When several lists
of lists are to be conjoined, one needs to make a list consisting
of all unions of one list from each list of lists. *)

(* type of "atomic polymorphic orders"  -- Zero represents
0 and Poly n represents |xn|. *)

datatype BaseOrder = Zero | Poly of int;

fun lessbaseorder Zero Zero = false |

lessbaseorder Zero (Poly n) = true |

lessbaseorder (Poly n) Zero = false |

lessbaseorder (Poly m) (Poly n) = m<n;

(* operations to manipulate lists of triples 

preserve lexicographic order of triples.

*)

(* a triple (m,n,r) stands for an inequality m-n <= r,
m and n being atomic polymorphic orders and r an integer (negative included) *)

(* [(Zero,Zero,-1)] represents error.  The procedure makes sure
that all needed conditions (Zero,m,0) are present (basic
values are nonnegative)  Where two triples are present, the smaller
bound is used.  Triples (m,m,r) are not recorded if possible
and raise error if not possible; triples (m,Zero,r) raise
error if r is negative. *)

fun addtriple (m,n,r) nil = 

if m=n 

   then if r<0 

      then [(Zero,Zero,~1)]

      else nil

else if m = Zero

         then if r>0 

            then [(Zero,n,0)] 

            else [(Zero,n,r)]

else if n=Zero then if r<0 then [(Zero,Zero,~1)]
 else [(m,Zero,r)]

else [(m,n,r)] |

addtriple x [(Zero,Zero,~1)] = [(Zero,Zero,~1)] |

addtriple (m1,n1,r1) ((m2,n2,r2)::L) =

if m1=n1 then if  r1 < 0 then [(Zero,Zero,~1)] else ((m2,n2,r2)::L)

else if n1 = Zero andalso r1 < 0 then [(Zero,Zero,~1)]

else if lessbaseorder m1 m2 then ((m1,n1,r1)::((m2,n2,r2)::L))

else if m1 = m2 then if lessbaseorder n1 n2 then ((m1,n1,r1)::((m2,n2,r2)::L))

else if n1=n2 then ((m2,n2,if r1<r2 then r1 else r2)::L)

else ((m2,n2,r2)::(addtriple (m1,n1,r1) L))

else ((m2,n2,r2)::(addtriple (m1,n1,r1) L));

fun addbounds nil = nil |

addbounds ((m,n,r)::L) = if m = Zero then addtriple (m,n,r) (addbounds L)

else if n = Zero then addtriple (Zero,m,0)(addtriple (m,n,r) (addbounds L))

else addtriple(Zero,n,0)(addtriple (Zero,m,0)(addtriple (m,n,r) (addbounds L)));

fun triangulate (m1, n1, r1) nil = nil |

triangulate (m1,n1,r1) ((m2,n2,r2)::L) =

if n1 = m2 then addtriple (m1,n2,r1+r2) (addtriple (m2,n2,r2) 
(triangulate (m1,n1,r1) L))

else if m1 = n2 then addtriple (m2,n1,r1+r2) (addtriple (m2,n2,r2) 
(triangulate (m1,n1,r1) L))

else addtriple (m2,n2,r2) (triangulate (m1,n1,r1) L);

fun selftriangulate1 nil = nil |

selftriangulate1 ((m1,n1,r1)::L) = 
addtriple (m1,n1,r1) (triangulate (m1,n1,r1) (selftriangulate1 L));

(* I think selftriangulate will deduce all consequences of a set
of inequalities of the form indicated *)

fun selftriangulate L = let val M = selftriangulate1 (addbounds L) in

if L = M then L else selftriangulate M end;

(* conditions deducible from m+r being the maximum component of
the order (n,L) *)

fun orderconditions (m,r) (n,nil) = if m=Zero then if r = n then nil
                else [(Zero,Zero,~1)] else [(Zero,m,r-n)] |

orderconditions (m,r) (n,(((X p),q)::L)) = 

 addtriple (Poly p,m,r-q) (orderconditions (m,r) (n,L));

(* the possible maximum items with displacement in the order (n,L) *)

fun maxpossibilities (n,L) = if (fn (X m) => m>=0) (boundingvar(n,L))

   then [((fn (X m) => (Poly m)) (boundingvar (n,L)),0)]

   else (Zero,n)::(map (fn ((X m),p) => ((Poly m),p)) L);

fun mergeconditions nil L = L |

    mergeconditions L nil = L |

    mergeconditions (x::L) (y::M) = 
    addtriple x (addtriple y (mergeconditions L M))

fun equationconditions ord1 ord2 ((m1,r1),(m2,r2)) =

    addtriple (m1,m2,r2-r1) (addtriple (m2,m1,r1-r2) (mergeconditions
    (orderconditions (m1,r1) ord1) (orderconditions (m2,r2) ord2)))

fun listproduct nil M = nil |

    listproduct (x::L) M = (map (fn y => (x,y)) M)@(listproduct L M);

fun rawequationcases ord1 ord2 = 
map (equationconditions ord1 ord2) 
(listproduct (maxpossibilities ord1) (maxpossibilities ord2));

fun casesconjunction L M = map (fn (x,y) => mergeconditions x y)
(listproduct L M);

fun minimalconjunct0 L nil M = L |

minimalconjunct0 L (x::M) N = if selftriangulate (L@M) = N
then minimalconjunct0 L M N
else minimalconjunct0 (L@[x]) M N;

fun minimalconjunct M = minimalconjunct0 nil M (selftriangulate M);

fun minimaldisjunct0 L nil M = L |

minimaldisjunct0 L (x::M) N = 

if x <> [(Zero,Zero,~1)] andalso

map (fn y => (selftriangulate(mergeconditions x y) = x) andalso y<>x) N = 
map (fn y => false) N

then minimaldisjunct0 (L@[x]) (dropfromlist x M) N

else minimaldisjunct0 L (dropfromlist x M) N;

fun minimaldisjunct L = minimaldisjunct0 nil L L;

fun fixcases0 nil = nil |

 fixcases0 (L::M) = let val T = selftriangulate L in

if T = [(Zero,Zero,~1)] then fixcases0 M else (T::(dropfromlist T (fixcases0 M)))

end;

fun fixcases L = map minimalconjunct (minimaldisjunct (fixcases0 L));

fun listcollapse2a nil = nil |

 listcollapse2a [((X n),t)] = [((X n),t)] |

 listcollapse2a (((X m),t)::((X n),u)::L) =

    if m=n then listcollapse2a (((X m), t)::L)

    else ((X m),t)::(listcollapse2a (((X n),u)::L));

fun listcollapse2b nil = [nil] |

listcollapse2b [((X n),t)] = if (fn (X m) => m>=0) (boundingvar (typeorder t))

then [orderconditions ((fn(X m)=>(Poly m))(boundingvar (typeorder t)),0) (typeorder t)]

else

[nil] |

listcollapse2b (((X m),t)::((X n),u)::L) =

    if m=n then fixcases(
(casesconjunction(rawequationcases (typeorder t) (typeorder u))(listcollapse2b (((X n),u)::L))))

    else if (fn (X m) => m>=0) (boundingvar (typeorder t))

then fixcases(casesconjunction
[(orderconditions ((fn(X m)=>(Poly m))(boundingvar (typeorder t)),0)(typeorder t))]
(listcollapse2b (((X n),u)::L)))

    else listcollapse2b (((X n),u)::L);

(* output function for conditions *)

fun singleline (Zero,Zero,~1) = "false" |

singleline (Zero,Zero,r) = "" |

singleline (Zero,m,0) = "" |

singleline (Zero,Poly m,r) = "|x"^(makestring m)^"| >= "^(makestring (~1*r)) |

singleline (Poly m,Zero,r) = "|x"^(makestring m)^"| <= "^(makestring (r)) |

singleline (Poly m,Poly n,r) = if r = 0 then "|x"^(makestring m)^"| <= "
^"|x"^(makestring n)^"|"

else if r>0 then "|x"^(makestring m)^"| <= "
^"|x"^(makestring n)^"|+"^(makestring r)

else "|x"^(makestring m)^"|+"^(makestring (~1*r))^" <= "
^"|x"^(makestring n)^"|";

fun singleconjunct nil = "" |

singleconjunct [t] = singleline t |

singleconjunct (t::L) = let val L1 = singleconjunct L
in if singleline t = "" orelse L1 = "" then L1
else (singleline t)^" and\n"^L1 end;

fun showcondition nil = "\n" |

showcondition [t] = singleconjunct t |

showcondition (t::L) = let val L1 = showcondition L
in if singleconjunct t = "" orelse L1 = "\n"
then L1 else (singleconjunct t)^"\n\nOR\n\n"^L1 end;

fun statecondition L = TextIO.output(TextIO.stdOut,(showcondition L)^"\n\n");


(* substitution of a type for a polymorphic variable in a type *) 

fun oneramtypesub (n,t) Individual = Individual | 

oneramtypesub (n,t) (ComplexType (L,M)) = 

let val L2 = map (oneramtypesub (n,t)) L 
and M2 = subintotype (X n,t) M in 

ComplexType (L2,M2) end| 

oneramtypesub (n,t) (UnknownType m) = if n=m then t else UnknownType m | 

oneramtypesub (n,t) ramifiedtyperror = ramifiedtyperror; 

(* substitution repeated to check for circularity *)

(* this was briefly disabled, but it seems that order matching 
detects circularity of types anyway!  I reenabled
if after fixing a bug in substitution of types into orders *)

fun safeoneramtypesub (n,t) T = 

let val B = oneramtypesub (n,t) T in 

if oneramtypesub (n,t) B = B 
(* andalso not (foundin (X n) (varsof B)) *) 

then B else ramifiedtyperror end;

(* reduction procedure -- takes a list of assignments of
type values to polymorphic type variables and systematically
makes each assignment in the whole list, eliminating redundant
polymorphic types and detecting circularities, but without
doing any unification *)

fun reduceramtypelist0 n nil nil = nil | 

reduceramtypelist0 n (((X m),t)::L) M = if n <= 1 

then map (fn (a,b) => (a, safeoneramtypesub (m,t) b)) M 

else reduceramtypelist0 (n-1) L M |

reduceramtypelist0 x y z = nil; 

fun reduceramtypelist1 n L = if n>length L then L else 

reduceramtypelist1 (n+1) (reduceramtypelist0 n L L); 

fun reduceramifiedtypelist L = reduceramtypelist1 1 L; 

fun neweval2 (X m) nil = UnknownType m |

neweval2 (X n) (((X m),t)::L) = if m=n then if neweval2 (X n) L = t
orelse neweval2 (X n) L = UnknownType n then t else ramifiedtyperror
else neweval2 (X n) L;

fun weakeval (X n) nil = UnknownType n |

weakeval (X n) (((X m),t)::L) = if m=n then t else weakeval (X n) L;

(* stage 1:  develop a list of all the type assignments implied
by the syntax of the term. basiclist t *)

(* the varhead clause looks ahead to a function termtype defined later *)

fun specialfold2 nil L = nil |

specialfold2 L nil = nil |

specialfold2 (X n::L) (Var (X m)::M) = newadd (X n,UnknownType m) 
(newadd (X m,UnknownType n) (specialfold2 L M)) |

specialfold2 (v::L) (Const c::M) =  newadd (v,Individual) (specialfold2 L M) |

specialfold2 (v::L) (Fun t::M) = newadd 
(v,CompleteTypeCheck0 t) (specialfold2 L M) |

specialfold2 (v::L) (Desc("I",[w],T)::M) = newadd (v,neweval2 w (Finaltypelist0 T))

                                      (specialfold2 L M)

(* new clauses needed for class and relation constructions *)


and  basiclist2 (atomic(r,L)) = map (fn x => (x,Individual))(FV (atomic(r,L)))  |

basiclist2 (negation T) = (basiclist2 T) |

basiclist2 (disj(s,T,U)) =(newunion(basiclist2 T)(basiclist2 U)) |

basiclist2 (univ(s,v,T)) = basiclist2 T |

basiclist2 (varhead2(v,L)) = let val M = map termtype2 L in
newunion
(newunions (map Finaltermtypelist L))

(newadd (v,ComplexType(M,plusone(maxlist(map typeorder M))))
(map(fn (X n) => (X n,UnknownType n)) (FV (varhead(v,L)))))

end | 

basiclist2 (varhead(v,L)) = let val M = map termtype2 L in

newunion(newunions (map Finaltermtypelist L))

(newadd (v,ComplexType(M,
ordermax (0,[(v,0)])(plusone(maxlist(map typeorder M)))))
(map(fn (X n) => (X n,UnknownType n)) (FV (varhead(v,L)))))

end | 

basiclist2 (varapp(v,L)) = basiclist2 (varhead(v,L)) |

basiclist2 (varapp2(v,L)) = basiclist2 (varhead2(v,L)) |

basiclist2 (constapp(t,L)) = 
 
newunion(newunions (map Finaltermtypelist L))
(newunion (basiclist2 t)
(specialfold2 (FV t) L)) |

basiclist2 (propvar p) = nil |

basiclist2 error = [(X 0,ramifiedtyperror)]

(* stage 2:  unify.  This is complex *)

(* identifytypes generates the list of type identifications determined
by the unification of a pair of types; this approach will not work (or at
least not this readily) with ramified types, unless I come up with some
clever idea to code order information using dummy variable typings --
which is not too hard to imagine *)

(* this avoids the need to represent type equations specifically *)

and Identifytypes (UnknownType m) (UnknownType n) = if m <> n then 
newadd (X n,UnknownType m) [(X m,UnknownType n)] else nil | 

Identifytypes (UnknownType n) t = [(X n,t)] |

Identifytypes t (UnknownType n) = [(X n,t)] |

Identifytypes Individual Individual = nil |

(* there is additional complexity in the next two cases because
identification of complex types involves not only identification
of their orders, which is handled recursively, but a proof that
the orders can be unified, which is more complicated.

If the orders are "unbounded" in order, there is a variable name
which can be assigned both types (the variable name(s) used to 
express the unbounded order of one or both of the orders); otherwise
it is necessary to carry out full unification on the local information
derivable from the types being unified and verify that the orders
of the two types become identifiable.  (the otherwise unused
variable X ~1 is assigned the two complex types and these assignments
are "reduced" along with the fully unified information from the
argument lists.

 *)

Identifytypes (ComplexType(nil,order1)) (ComplexType(nil,order2)) = 

if order1 = order2 then nil else 

listcollapse([(boundingvar order1,(fn (X n) => UnknownType n) (boundingvar order2)),
(boundingvar order2,(fn (X n) => UnknownType n) (boundingvar order1)),
(boundingvar order1,ComplexType (nil,order1)),
(boundingvar order2,ComplexType (nil,order2))])

 |

Identifytypes (ComplexType(t::L,order1)) (ComplexType(u::M,order2)) =

let val arginfo =

newunion (Identifytypes t u) (Identifytypes (ComplexType (L,typeorder Individual)) (ComplexType (M,typeorder Individual)))

in if order1 = order2 then arginfo else


newunion [(boundingvar order1,(fn (X n) => UnknownType n) (boundingvar order2)),
(boundingvar order2,(fn (X n) => UnknownType n) (boundingvar order1)),
(boundingvar order1,ComplexType (t::L,order1)),
(boundingvar order2,ComplexType (u::M,order2))] arginfo

end |

Identifytypes t u = [(X 0,ramifiedtyperror)]

(* samevarlist detects the initial bloc in a multi-valued
function of values associated with the same domain element *)

and samevarlist nil = nil |

samevarlist [x] = [x] |

samevarlist ((x,t)::(y,u)::L) = if x=y then ((x,t)::(samevarlist ((y,u):: L)))
                                       else [(x,t)]
 
(* newidslist is the list of new variable typing assertions
generated by one pass of unifications of different types assigned
to the same variable in its argument *)

and Newidslist nil = nil |

Newidslist [x] = nil |

Newidslist ((x,t)::(y,u)::L) = if x <> y then Newidslist ((y,u)::L)
else newunion (Identifytypes t u) 
(newunion(Newidslist((x,t)::(tl(samevarlist((y,u)::L)))))(Newidslist((y,u)::L)))

(* newunify (the result of the unification step) is computed
by applying newidslist until it no longer introduces any new
assertions *)

and Newunify L = let val M = newunion L (Newidslist L) in

if equallists L M then L else Newunify M end

(* stage 3:  universal substitution *)

(* use reducesimpletypelist, which is already written, and implements the same
idea *)

(* we now need to define newtypecheck and termtype from above *)

and listcollapse L = newunion L L  (* listcollapse is used
to eliminate duplicate elements from the output of 
reducesimpletypelist *)

and Finaltypelist0 t = (listcollapse(reduceramifiedtypelist
     (Newunify(basiclist2 t))))

and Finaltermtypelist (Const x) = nil | 

Finaltermtypelist (Var (X n)) = [((X n),(UnknownType n))] |
 Finaltermtypelist (Fun t) = Finaltypelist0 t |

Finaltermtypelist (Desc(s,v,T)) = Finaltypelist0 T

and Finalconditions0 t = let val T = Newunify(basiclist2 t) in

if newfound ramifiedtyperror T then nil else

listcollapse2b(listcollapse(reduceramifiedtypelist T)) end

and Newtypecheck0 t = (
let val T = Finaltypelist0 t in

if newstrict T andalso not (newfound ramifiedtyperror T)

then ComplexType(map (fn x => neweval2 x T) (FV t),plusone(maxlist(map typeorder (map (fn x => neweval2 x T) (allvars t)))))

else ramifiedtyperror

end)

and CompleteTypeCheck0 t = 
let val T = Finaltypelist0 t in
if not (newfound ramifiedtyperror T)

andalso Finalconditions0 t <> nil

then ComplexType(map (fn x => weakeval x T) (FV t),plusone(maxlist(map typeorder (map (fn x => weakeval x T) (allvars t)))))

else ramifiedtyperror end

and termtype2 (Var (X n)) = UnknownType n |

termtype2 (Const v) = Individual |

termtype2 (Fun t) = (* Newtypecheck0 t *)  CompleteTypeCheck0 t |

termtype2 (Desc("I",[v],T)) = neweval2 v (Finaltypelist0 T);

fun Newtypecheck t = (NEWBOUNDINGVAR
:=0;BOUNDINGVARS:=nil;Newtypecheck0 t); 

fun CompleteTypeCheck t =
(NEWBOUNDINGVAR :=0;BOUNDINGVARS:=nil;CompleteTypeCheck0 t); 

fun Finaltypelist t = (NEWBOUNDINGVAR
:=0;BOUNDINGVARS:=nil;Finaltypelist0 t);

fun Typecheck t = showramifiedtype(Newtypecheck(parse t));

fun showtypelist nil = "" |

   showtypelist ((v,t)::L) = ((displayvar v)^":  "^(showramifiedtype t)^"\n")^
                             (showtypelist L);

fun Showbasic s = TextIO.output(TextIO.stdOut,"\nbasic list:\n\n"^(showtypelist(basiclist2(parse s)))^"\n");

fun Showunified s = TextIO.output(TextIO.stdOut,"\n\nunification list:\n\n"^(showtypelist(Newunify(basiclist2(parse s)))^"\n"));

fun Showfinal s = TextIO.output(TextIO.stdOut,"\n\nfinal type list:\n\n"^(showtypelist(listcollapse(reduceramifiedtypelist(Newunify(basiclist2(parse s))))))^"\n");

fun say s = TextIO.output(TextIO.stdOut,s);

fun Test s = (say("\nTerm input:\n\n"^(display(parse s))^"\n\n");
say("Hit enter to see type results for proposition above\n\n");TextIO.flushOut(TextIO.stdOut);
TextIO.input(TextIO.stdIn);
NEWBOUNDINGVAR:=0;BOUNDINGVARS:=nil;if wellformed (parse s) then

(Showbasic s;Showunified s;Showfinal s;
TextIO.output(TextIO.stdOut,"unconditional type:\n\n"^(Typecheck s)^"\n\n"))

else say("Term is ill-formed\n\n"));

fun Finalconditions t =
(NEWBOUNDINGVAR:=0;BOUNDINGVARS:=nil;Finalconditions0 t);

(* substitution functions *)

(* these have been moved to make the point that our type
algorithms do not depend on the notion of substitution for
variables in propositions (as is the case in the Kamareddine et. al.
paper).  The function Test2 below does use substitution -- it
converts a term to standard form (renaming bound variables)
if it cannot type it in any other way.

The STT typing function typecheck will be used to make sure
that our substitution function terminates.

*)

(* the important fact to be recorded here about the 
Kamareddine et. al. treatment of pfs is that the result
of applying a pf to an argument list is the result of replacing
the free variables of the pf _in alphabetical order_ (index
order of my variables x1, x2, x3 etc.) with the arguments.
Of course the argument list must be the same length as the
list of free variables of the pf.  A function of a variable
must actually contain that variable. *) 

(* the function subfun takes two lists as 
arguments; the first is intended to be the free variables 
of a term and the second is intended to be the terms or variables 
to replace them. 
The variable lists are expected to be of the same length. *) 

fun subfun nil L = nil | 

subfun L nil = nil | 

subfun (v::nil) (w::nil) = [(v,w)] | 

subfun (v::L) (w::M) = let val x = subfun L M in 

if x = nil then nil else (v,w)::x end; 

(* produce canonical variable lists *) 

fun varlist n = if n<=0 then nil else (varlist (n-1))@[Var(X n)];

fun shiftvarlist m n =  if n<=0 then nil else (varlist (n-1))@[Var(X (n+m))];


(* substitute a pf for a propositional variable *)

fun propsub n t (propvar m) = if m = n then t else propvar m |

   propsub n t (negation T) = negation (propsub n t T) |

   propsub n t (disj(s,T,U)) = disj(s,propsub n t T,propsub n t U) |

   propsub n t (univ(s,v,T)) = if foundin v (FV t) then error else

   univ(s,v,propsub n t T) |

   propsub n t T = T;

(* substitute pfs for p1,p2,p3... using a list whose first element
is to replace p1, second element is to replace p2, and so on *)

fun propsubs M nil t = t |

   propsubs M (t::L) (propvar 1) = if map (fn x => foundin x M) (FV 

   t) = map (fn x => false) (FV t) then t else error |

   propsubs M (t::L) (propvar n) = propsubs M L (propvar (n-1)) |

   propsubs M L (negation T) = negation (propsubs M L T) |

   propsubs M L (disj(s,T,U)) = disj(s,propsubs M L T,propsubs M L U) |

   propsubs M L (univ(s,v,T)) = univ(s,v,propsubs (insertvar v M) L T) |

   propsubs M L T = T;

(* new substitution function under construction *)

fun dropfromvarfun v nil = nil |

dropfromvarfun v ((w,x)::L) = if v=w then L else ((w,x)::(dropfromvarfun v L));

fun findinvarfun v nil = Var v |

    findinvarfun v ((w,x)::L) = if v=w then x else findinvarfun v L;

fun dropsfromvarfun nil L = nil |

    dropsfromvarfun (v::M) L = dropfromvarfun v (dropsfromvarfun M L);


fun findinvarfun v nil = Var v |

    findinvarfun v ((w,x)::L) = if v=w then x else findinvarfun v L;

fun atomictermsub L (const c) = const c |

    atomictermsub L (var v) = let val x = findinvarfun v L

    in (fn (Var w) => var w | (Const c) => const c | x => const (A ~1)) x

    end;

(* L will be a list of substitutions of terms for variables *)

(* a diagnostic gadget *)

fun showterm t = (TextIO.output(TextIO.stdOut,"\n"^(display t)^"\n");t);

(* not now used, but it might be useful? *)

fun subacts nil t = false |

subacts ((v,x)::L) t = foundin v (FV t) orelse subacts L t;

(* elimination of description arguments *)

val QCONNECTIVES = ref [("","implies"),("E","and"),("I","and")];

fun addqconnective s t = QCONNECTIVES:=addtokeyfun s t (!QCONNECTIVES);

fun qconnective s = if getfromkeyfun s (!QCONNECTIVES) = nil then ""

else hd(getfromkeyfun s (!QCONNECTIVES));

(* fun descelim0 L (varhead(v,Desc(s,w,T)::M)) = 

let val W = if foundin w (FV (varhead(v,L)))

then newvar (union (FV T) (FV (varhead(v,L)))) else w in

(* univ(s,W,(disj(qconnective s,subs0 [(w,Var W)] T,varhead(v,L@[Var W]@(map (termsub [(w,Var W)]) M))))) end *)

disj("and",univ(s,w,T),

univ("",W,disj("implies",subs0[(w,Var W)]T,varhead(v,L@[Var W]@M)))) end
 
|
descelim0 L (varhead2(v,Desc(s,w,T)::M)) = 

let val W = if foundin w (FV (varhead2(v,L)))

then newvar (union (FV T) (FV (varhead2(v,L)))) else w in

(* univ(s,W,(disj(qconnective s,subs0 [(w,Var W)] T,varhead2(v,L@[Var W]@(map (termsub [(w,Var W)]) M))))) end *)

disj("and",univ(s,w,T),

univ("",W,disj("implies",subs0[(w,Var W)]T,varhead2(v,L@[Var W]@M)))) end
 
|
descelim0 L (varapp(v,Desc(s,w,T)::M)) = 

let val W = if foundin w (FV (varapp(v,L)))

then newvar (union (FV T) (FV (varapp(v,L)))) else w in

(* univ(s,W,(disj(qconnective s,subs0 [(w,Var W)] T,varapp(v,L@[Var W]@(map (termsub [(w,Var W)]) M))))) end *)

disj("and",univ(s,w,T),

univ("",W,disj("implies",subs0[(w,Var W)]T,varapp(v,L@[Var W]@M)))) end
 
|
descelim0 L (varapp2(v,Desc(s,w,T)::M)) = 

let val W = if foundin w (FV (varapp2(v,L)))

then newvar (union (FV T) (FV (varapp2(v,L)))) else w in

(* univ(s,W,(disj(qconnective s,subs0 [(w,Var W)] T,varapp2(v,L@[Var W]@(map (termsub [(w,Var W)]) M))))) end *)

disj("and",univ(s,w,T),

univ("",W,disj("implies",subs0[(w,Var W)]T,varapp2(v,L@[Var W]@M)))) end
 
|

descelim0 L (constapp(t,Desc(s,w,T)::M)) = 

let val W = if foundin w (FV (constapp(t,L)))

then newvar (union (FV T) (FV (constapp(t,L)))) else w in

(* univ(s,W,(disj(qconnective s,subs0 [(w,Var W)] T,constapp(t,L@[Var W]@(map (termsub [(w,Var W)]) M))))) end *)

disj("and",univ(s,w,T),

univ("",W,disj("implies",subs0[(w,Var W)]T,constapp(t,L@[Var W]@M)))) end
 
|


descelim0 L (varhead(v,x::M)) = descelim0 (L@[x]) (varhead(v,M)) |

descelim0 L (varhead2(v,x::M)) = descelim0 (L@[x]) (varhead2(v,M)) |

descelim0 L (varapp(v,x::M)) = descelim0 (L@[x]) (varapp(v,M)) |

descelim0 L (varapp2(v,x::M)) = descelim0 (L@[x]) (varapp2(v,M)) |

descelim0 L (constapp(t,x::M)) = descelim0 (L@[x]) (constapp(t,M)) |

descelim0 L (varhead(v,nil)) = varhead(v,L) |

descelim0 L (varhead2(v,nil)) = varhead2(v,L) |

descelim0 L (varapp(v,nil)) = varapp(v,L) |

descelim0 L (varapp2(v,nil)) = varapp2(v,L) |

descelim0 L (constapp(t,nil)) = constapp(t,L) |

descelim0 L t = t 

and *) 

(* descelim0 above is omitted *)

fun  termsub L (Var v) = findinvarfun v L |

    termsub L (Desc(s,v,T)) = (* let val TEST = (subs0 (dropsfromvarfun v L) (subs0 [(v,Var(X ~1))] T))

in if foundin v (allvars TEST) 

(* NOTE:  this clause is hopeless to type!  We need a function to get
a whole vector of new variables.  Perhaps we need to overhaul the whole
business of generating new variables? *)

then X ~1

(* Desc (s,newvar(allvars (disj("v",T,TEST))),subs0 (dropfromvarfun v L) (subs0
[(v,Var(newvar(allvars(disj("v",T,TEST)))))] T)) *)

(* should the substitution for new occurrences of v be made here (remove
dropfromvarfun v from previous line?) *)

 else  *) Desc (s,v,subs0 (dropsfromvarfun v L) T)

  (* end *) |


    termsub L x = x


and subs0 L (negation T) = negation (subs0 L T) |

subs0 L (disj(s,T,U)) = disj(s,subs0 L T, subs0 L U) |

subs0 L (univ(s,v,T)) =

let val TEST = (subs0 (dropfromvarfun v L) (subs0 [(v,Var(X ~1))] T))

in  if foundin v (allvars TEST) 

then  
(setnewvar(insertvar(prevvar(!NEWVAR))(allvars(disj("v",T,TEST))));
univ (s,newvar(allvars (disj("v",T,TEST))),subs0 (dropfromvarfun v L) (subs0
[(v,Var(newvar(allvars(disj("v",T,TEST)))))] T)))

else univ(s,v,subs0 (dropfromvarfun v L) T) 

end

|

subs0 L (atomic(r,M)) =  let val M2 = map (atomictermsub L) M in

if map (fn x=> x = const(A ~1)) M2 = map (fn x => false) M2

then atomic(r,M2)

else error

end |

subs0 L (varhead(v,M)) = 

(* let val DD = descelim0 nil (varhead(v,M)) in

if DD <> (varhead(v,M)) andalso indomain v L then 

subs0 L DD

else *)

let val H = findinvarfun v L

and M2 = map (termsub L) M in

(fn

(Var w) => varhead(w,M2) |

(Fun f) => if length (FV f) = length M2 then

subs0 (subfun (FV f) M2) f

else error | x => error) H

end (* end *)

(* NOTE:  something different needs to happen here instead of
descelim0; this is where existence assumptions need to be inserted *)

|

subs0 L (varhead2(v,M)) = 

(* let val DD = descelim0 nil (varhead2(v,M)) in

if DD <> (varhead2(v,M)) andalso indomain v L then 


subs0 L DD else

*)

let val H = findinvarfun v L

and M2 = map (termsub L) M in

(fn

(Var w) => varhead2(w,M2) |

(Fun f) => if length (FV f) = length M2 then

subs0 (subfun (FV f) M2) f

else error | x => error) H

end (* end *)

(* NOTE:  something different needs to happen here instead of
descelim0; this is where existence assumptions need to be inserted *)

|

subs0 L (varapp(v,M)) = 

(* let val DD = descelim0 nil (varapp(v,M)) in

if DD <> (varapp(v,M)) andalso indomain v L then 

subs0 L DD else *)

let val H = findinvarfun v L

and M2 = map (termsub L) M in

(fn

(Var w) => varapp(w,M2) |

(Fun f) => if length (FV f) = length M2 then

constapp(f,M2) else error | x=> error) H end (* end *)

|
subs0 L (varapp2(v,M)) = 

(* let val DD = descelim0 nil (varapp2(v,M)) in

if DD <> (varapp2(v,M)) andalso indomain v L then 

subs0 L DD  else *)

let val H = findinvarfun v L

and M2 = map (termsub L) M in

(fn 

(Var w) => varapp2(w,M2) |

(Fun f) => if length (FV f) = length M2 then

constapp(f,M2) else error | x => error) H end (* end *)

|

subs0 L (constapp(t,M)) =

constapp(t,map (termsub L) M) |

subs0 L t = t;

(* the subs0 function is not type-safe -- it will not terminate
with some untyped terms. *)

(* development of a canonical form for pfs with systematic
variable renaming *)

(* the standard form development uses the "unsafe" subs0 because in some
cases variable renaming may be needed to establish that a term is actually
well-typed.  Renaming of a variable never leads to nontermination, so
this is not dangerous. *)

fun presubs L t = subs0 (subfun (FV t) L) t;

fun standardform T = presubs (varlist (length (FV T))) T;

fun shiftstandardform (X m) T = presubs

(map (fn (Var (X n)) => Var (X (m+n))|x=>x)(varlist (length (FV T)))) T;

(* this function applies a function to all pf arguments --
including the applied constant function in a constant pf application
term *)

fun getpfargs f (disj(s,T,U)) = (disj(s,getpfargs f T,getpfargs f U)) |

getpfargs f (univ(s,v,T)) = univ(s,v,getpfargs f T) |

getpfargs f (negation(T)) = negation(getpfargs f T) |

getpfargs f (varhead(v,L)) = 
varhead(v,map (fn (Fun t) => Fun (f t) | x=> x) L) |

getpfargs f (varhead2(v,L)) = 

varhead2(v,map (fn (Fun t) => Fun (f t) | x=> x) L) |
getpfargs f (varapp(v,L)) = 

varapp(v,map (fn (Fun t) => Fun (f t) | x=> x) L) |

getpfargs f (varapp2(v,L)) = 

varapp2(v,map (fn (Fun t) => Fun (f t) | x=> x) L) |

getpfargs f (constapp(t,L)) = 
constapp(f t,map (fn (Fun t) => Fun (f t) | x=> x) L) |

getpfargs f t = t;


(* this function renames quantified variables in a standard way *)

fun fixquantifiers (disj(s,T,U)) = 
(setnewvar(insertvar(prevvar(!NEWVAR))(FV(disj(s,T,U))));
disj(s,fixquantifiers T,fixquantifiers U)) |

fixquantifiers (negation T) = 
(setnewvar(insertvar(prevvar(!NEWVAR))(FV T));
negation (fixquantifiers T)) |

fixquantifiers (univ(s,v,T)) = 
(setnewvar(insertvar(prevvar(!NEWVAR))(FV (univ(s,v,T))));
univ(s,(!NEWVAR),fixquantifiers(subs0 [(v,Var (!NEWVAR))] T)))  |

fixquantifiers (varhead(v,L)) = (setnewvar(insertvar(prevvar(!NEWVAR))(FV (varhead(v,L)))); varhead(v,
map (fn (Desc(s,[w],T)) => Desc(s,[(!NEWVAR)],fixquantifiers (subs0[(w,Var (!NEWVAR))] T)) | x=>x) L)) |

(* NOTE:  new clauses needed to handle general Desc terms *)

fixquantifiers (varhead2(v,L)) = (setnewvar(insertvar(prevvar(!NEWVAR))(FV (varhead2(v,L)))); varhead2(v,
map (fn (Desc(s,[w],T)) => Desc(s,[(!NEWVAR)],fixquantifiers (subs0[(w,Var (!NEWVAR))] T)) | x=>x) L)) |

(*NOTE:  as above *)

fixquantifiers (varapp(v,L)) = (setnewvar(insertvar(prevvar(!NEWVAR))(FV (varapp(v,L)))); varapp(v,
map (fn (Desc(s,[w],T)) => Desc(s,[(!NEWVAR)],fixquantifiers (subs0[(w,Var (!NEWVAR))] T)) | x=>x) L)) |

(* NOTE:  as above *)

fixquantifiers (varapp2(v,L)) = (setnewvar(insertvar(prevvar(!NEWVAR))(FV (varapp2(v,L)))); varapp2(v,
map (fn (Desc(s,[w],T)) => Desc(s,[(!NEWVAR)],fixquantifiers (subs0[(w,Var (!NEWVAR))] T)) | x=>x) L)) |

(* NOTE:  as above *)

fixquantifiers (constapp(t,L)) = (setnewvar(insertvar(prevvar(!NEWVAR))(FV (constapp(t,L)))); constapp(t,
map (fn (Desc(s,[w],T)) => Desc(s,[(!NEWVAR)],fixquantifiers (subs0[(w,Var (!NEWVAR))] T)) | x=>x) L)) |

(* NOTE:  as above *)

fixquantifiers t = (setnewvar(insertvar(prevvar(!NEWVAR))(FV t));t);

fun superstandardform1 t = let val T = 
fixquantifiers(shiftstandardform (prevvar(!NEWVAR)) (t))

in

(NEWVAR:=(if allvars T = nil then (!NEWVAR) else 
(newvar (allvars T))); getpfargs superstandardform1 T)

end;

(* this function should give a canonical form mod renaming of bound
variables *)

fun superstandardform t = (NEWVAR:= (X 1);superstandardform1 t);

(*

(* expand definite descriptions systematically -- does not expand
internals of pf arguments *)

fun expanddescs (negation T) = negation(expanddescs T) |

expanddescs (disj(s,T,U)) = disj(s,expanddescs T,expanddescs U) |

expanddescs (univ(s,v,T)) = univ(s,v,expanddescs T) |

expanddescs t = let val T = descelim0 nil t in 

if t = T then t else expanddescs T end;

fun testdescs t = display(expanddescs (parse t));

*)

(* test function *)

fun testst s = display(superstandardform(parse s));



fun evenvars t = 
subs0 (subfun (FV t) (map (fn (X n) => Var(X (2*n))) (FV t))) t;

fun Evenvars (Var (X n)) = Var (X (2*n)) |

    Evenvars t = t; 


(* in subtoterm we need to avoid reporting collisions between types of
variables eliminated in the substitution and new variables introduced
by the substitution *)

(* 

replace all free variables in the target term 
and all free variables to be substituted into the target term 
with even numbered variables

then increment all variables to be eliminated from the target term
(so they become odd-numbered variables and cannot conflict with new
variables to be introduced)

Some unintended variable conflicts are still possible.

*)

fun subtoterm L = disj("v",
varhead(X ~1,map (fn ((X n),y) => Var (X (2*n+1))) L),
varhead(X ~1,map (fn ((X n),y) => Evenvars y) L))

fun typesafetycheck L t = newtypecheck (superstandardform(disj("v",
subs0 (map (fn (X n,y) => (X (2*n),Var (X (2*n+1)))) L) 
(evenvars t),subtoterm L))) <>
simpletyperror;

fun subs1 L t = if typesafetycheck L t then subs0 L t else error;

fun subs L t = (setnewvar(insertvar(prevvar (!NEWVAR))(allvars t));subs1 (subfun (FV t) L) t);

(* test functions *)

fun testsubs0 L s = display(subs L s);

fun testsubs s t = (fn (varhead(v,L)) => testsubs0 L (parse t) | x=>"?")(parse s);

(* allred implements "beta-reduction" of pfs with constant pf arguments *)

(* does not reduce pf arguments *)

fun allred (negation T) = negation(allred T) |

allred (disj(s,T,U)) = disj(s,allred T,allred U) |

allred (univ(s,v,T)) = univ(s,v,allred T) |

allred (constapp(t,L)) = (* if descelim0 nil (constapp(t,L)) = constapp(t,L)

then *)  allred(subs L t) (* else allred (descelim0 nil (constapp(t,L))) *) |

allred (varapp(v,L)) = varhead(v,L) |

allred (varapp2(v,L)) = varhead2(v,L) |

allred t = t;

fun testred t = display(allred (parse t));



fun Test2 s = (
Test s;if not(wellformed(parse s)) then () else
let val TCHECK = CompleteTypeCheck(parse s) in
if TCHECK = ramifiedtyperror then let val S = superstandardform (parse s) in

(say ("Attempting to type standard form:\n\n"^(display S)^"\n\n");
say("conditional type:\n\n"^(showramifiedtype(CompleteTypeCheck S))^"\n\nWITH\n\n");
statecondition(Finalconditions (S))) end

else (say("conditional type:\n\n"^(showramifiedtype(TCHECK))^"\n\nWITH\n\n");
statecondition(Finalconditions (parse s))) end);

fun Test3 s = Test2 (display(superstandardform(parse s)));

fun TestLoop() = (say "\nEnter proposition to parse and type, then hit return:\n\n";
TextIO.flushOut(TextIO.stdOut);
Test2 (implode(rev(tl(rev(explode(TextIO.input(TextIO.stdIn)))))));
say "\nDo you want to do another proposition? (y/n)\n\n";
TextIO.flushOut(TextIO.stdOut);
if hd(explode(TextIO.input(TextIO.stdIn))) = #"n" then () else TestLoop()); 



(* fun finaltypefun L s = reduceramifiedtypelist(sortvarfun unifyramifiedtypes (reduceramifiedtypelist (weakunifyramifiedtypes(inferramtypes L s)))); *)

(* test examples -- it is important to be aware that orders of
ramified types are not displayed when they are as small as the types
of the arguments permit -- so, for example, predicative types look
exactly like the corresponding simple types.

It is also important to note that variables with negative index will appear
in the type lists -- these are automatically generated when
types of different orders have to be unified, so that the order information
will stick around to be unified in the rewriting stage.

 *)

(* Test2 "((R1(x1)v x2(a1))v x2(x1))"; *) 

(* the following doesn't type when variables introduced as
functions are allowed to have floating types *)

(* Test "((x1!()v x2!(R1(a1))v x2!(x1))"; *) 

(* ramtypecheck "(R1(x2)v x1!(x1!(x2)))"; *) 


(* inferramtypes nil (parse "(R1(x2)v x1(x1(x2)))"); *)

(* Test "(R1(x2)v x1(x2(x1)))"; *) 

(* Test "((x1!(a1)v x2!())v x3!(x1,x2))"; *) 

(* Test2 "((x5!(x6,x6)v x5!(x2,x3))v(x1!(x2)v x1!(x3)))"; *) 

(* Test2 "R1(x1)"; *) 

(* Test2 "x2!(R1(x1),S1(a1))"; *) 

(* Test "(x1!(a1)v x2())"; *) 

(* Test "[x1]x3(x2(R1(x1)))"; *) 
(* why doesn't this typecheck with ordinary typecheck? It should 
no, x1 isn't free! *) 

(* Test "[x1]R1(x1)"; *) 

(* ramtypecheck "[x1]R1(x1)"; *) 

(* Test "~x1(x1)"; *) 

(* Test "(x2(x1(a1))v x2([x3]x1(x3)))"; *) 

(* Test "x1([x2]x2(a1))"; *) 

(* Test "(x1(x2(a1))v x1([x3]x2(x3)))"; *) 

(* Test "[x1](x1()v~x1())"; *) 

(* Test "(R1(x1) v S1(x1))"; *) 

(* Test "x2(R1(x1))"; *) 

(* Test "S2(a1,a2)"; *) 

(* Test "(R1(a1) v S1(a1))"; *) 

(* Test "x3(R1(x1),S1(x2))"; *) 

(* Test "x2(x1,x1)"; *) 

(* Test "(x1(a1) v x2(x1,x1))"; *) 

(* Test "x3(x1,x2)"; *) 

(* Test "((R1(x1)vR1(x2))v x3(x1,x2))"; *) 

(* Test "(R1(a1)vS1(a1))"; *) 

(* Test "(R1(x1)v~T3(x1,x1,x2))"; *) 

(* Test "(x1(a1)vS1(a1))"; *) 

(* Test "(x1()v x2())"; *) 

(* Test "x1()"; *) 

(* Test "((x1(a1)v x2())v x3(x1,x2))"; *) 

(* Test "x5(((x2!(x4)v x3!(x4))v[x1](x1(x2) v x1(x3))))"; *) 

(* inferramtypes nil (parse "((x2(x4)v x3(x4))v[x1](x1(x2) v x1(x3)))"); *)

(* Test2 "x5(([x1](x1(x2) v x1(x3))v(x2(x4)v x3(x4))))"; *)

(* "([x1](x1(x2) v x1(x3))v(x2(x4)v x3(x4)))" *)

(* it is arguable that this should not type-check *) 

(* Test2 "(x1(x2,x2)v x1(R1(a1),[x4]R1(x4)))"; *) 

(* Test "((R1(x2)vR1(x3))v[x1](x1(x2)v x1(x3)))"; *) 
(* Test "(x1!(x2)v x1!(x3))"; *) 

(* Test "([x1](x1(x2)v x1(x3))v(R1(x2)vR1(x3)))"; *)

(* Test2 "(x1(x2,x2) v x1([x3]x3(x4),[x5][x7]x7(x5,x6)))"; *) 

(* 
Test "((([x1]x3!(x1)v~~[x1]~x3(x1))v[x1][x2](~x3(x1)v(~L2(x2,x1)v x3(x2))))v[x1](x3 (x1)v[x2](x3(x2)vL2(x1,x2))))"; 

*)

(*

Test "((([Ex2]x1!(x2)and[Ex2]~x1!(x2))and[x2][x3](x1(x3)implies(L2(x3,x2)implies x1(x2))))and[x2](x1(x2)implies([Ex3]x1(x3)andL2(x2,x3))))";


*)
(* new bad example:  this should type check but does not (it does now!)

Test "(x1(x3,x5) v (x3(x4) v (x5(x6) v x1(x2,x2)))";

*)


(* a display function for final conclusions is wanted, surely? *)

(* now we need operations on lists of lists of triples
(disjunctions of cases) *)


(*  Considerations in the development of a PM prover (now
that we have type-checking *)

(* the prover should take the checker as a parameter, since
I'd like to have the option of using either ramified or simple
type theory *)

(*  needed upgrades:

definition of conjunction, implication, equivalence.

These require enhancement of the parser.

There's a general issue of ability to introduce defined
notions.  A general ability to introduce defined notions
as infix operators would be handy here.  What is the best
approach to handling interaction of defined notation with
the type-checker?

p. 13 comment on "identification of real variables"  bears
on type theory.

Theories are lists of propositions (or lists of lists, etc,
giving a chapter structure.

Rules of inference are functions acting on lists which preserve
the property of being lists of true propositions.

so far, MP + ability to substitute for variables are the
rules of inference I see.

Discussion of predicative matrices, p. 165 is important.

It doesn't seem necessary to assume that the order of a
variable introduced as a function is always the lowest possible!

I tested ambiguous typing of functions.  Adding the phi!
notation would enhance the type checker; let this signal
the intention to use the lowest possible type.

A new notation x!(k1..kn) would be involved.

This new notation is now installed and tested.  This is important,
because the Axiom of Reducibility could not even be stated without
it.

*)

val BOOK = ref([(parse "R1(a1)")]);



fun saytheorem T = say((display T)^" has been accepted as a theorem.\n\n");

fun sayillformed t = say(t^" is ill-formed:\n"^(display(parse t))^"\n\n");

fun sayilltyped T = (say((display T)^" is ill-typed:\n\n");Showfinal (display T));

fun ultimate1 nil = nil |

   ultimate1 [v] = nil |

   ultimate1 (v::L) = v::(ultimate1 L);

(* function for editing of book -- remove last theorem if it
is not what is wanted *)

fun ultimate() = BOOK := ultimate1 (!BOOK);

fun penultimate1 nil = nil |

    penultimate1 [v] = [v] |

    penultimate1 [v,w] = [w] |

    penultimate1 (v::L) = v::(penultimate1 L);

(* function for editing of book -- remove lemmas *)

fun penultimate() = BOOK := penultimate1 (!BOOK);

(* axiom allows us to enter a pf as an axiom *)

fun axiom s = let val S = parse s in

   if not (wellformed S) then say (s^" is not wellformed:\n\n"
   ^(display(S))^"\n\n")

   else if Newtypecheck S = ramifiedtyperror then

      (say (s^" is not well-typed\n\n");(Showfinal s);
       say("\n\n"))

   else (BOOK:=(!BOOK)@[S];say ((display S)^" has been accepted as an axiom.\n\n")) end;

(* add ability to give names to theorems *)

(* the idea is that (setlabel s n) will give name s to theorem number n,
and that (thmno s) will be the line number of the theorem named s
(and so can be given as a parameter to the rules of inference, which
take line numbers as arguments) *) 

fun fixline n l = if n>0 then n else l+n;

val LABELS = ref [("BOGUS",0)];

val _ = LABELS := nil;

fun setlabel s n = LABELS:=(s,fixline n (length(!BOOK)))::(!LABELS);

fun thmno1 s nil = 0 |

   thmno1 s ((t,n)::L) = if s = t then n else thmno1 s L;

fun thmno s = thmno1 s (!LABELS);

fun labelof n nil = "" |

   labelof n ((s,m)::L) = if n = m then "("^s^")" else labelof n L;


(* the showbook() function shows the entire "book" of theorems; the
selectthms m n argument shows theorems from line m to line n; zero and
negative lines (position relative to end of list) are handled
correctly *)

fun showbook0 n first last nil = () |

  showbook0 n first last (thm::L) = ((if n>=fixline first ((length L)+n) 
                                    andalso n <= fixline last((length L)+n) 

                          then

                          (say ("\n"^(makestring n)^" "^
                          (labelof n (!LABELS))^":  |- "
                          ^(display thm)^"\n")) else ());
                          showbook0 (n+1) first last L);

fun showbook() = showbook0 1 1 (length(!BOOK)) (!BOOK);

fun selectthms m n = showbook0 1 m n (!BOOK);

fun selectthm m = selectthms m m;

fun findthm0 n L = if n <= 0 then findthm0 (1-n) (rev L)

   else if L = nil then parse "(x1() implies x1())"

   else if n=1 then hd L

   else findthm0 (n-1) (tl L);

fun findthm n = findthm0 n (!BOOK);


(* specify takes theorem n and a complete argument list t
and applies the pf represented by the theorem to the argument list *)

 fun specify n t = 

   if t = "" orelse hd(explode t) <> #"("

   then say ("Bad argument")

   else let val T = (parsetermlist (tl(explode t))) in

   if not (wellformed (varhead(X 1,T))) then sayillformed (display(varhead(X 1,T)))

(*   else if descelim0 nil (varhead(X 1,T)) <> (varhead(X 1,T))

   then say (t^" contains virtual terms.\n"^"\n") *)

(* NOTE:  here is where we must insert existence hypotheses *)

   else if Newtypecheck 
       (varhead(newvar(FV(varhead(X 1,T))),T)) = ramifiedtyperror

   then sayilltyped (varhead(newvar(FV(varhead(X 1,T))),T))

   else let val U = subs T (findthm n) in

   if not (wellformed U) then sayillformed (display U)

   else if Newtypecheck U = ramifiedtyperror 

   then  sayilltyped U

   else (BOOK:=(!BOOK)@[U];
   saytheorem U)

   end

   end; 

(* this differs from specify in that the list of arguments will
replace p1, p2, p3, and so forth, whether they occur or not *)

(* i.e., it is assumed that propositional variables will be
reasonably low numbered *)

fun propspecify n t = 

   if t = "" orelse hd(explode t) <> #"("

   then say ("Bad argument")

   else let val T = map (fn (Fun T) => T | x => error)

   (parsetermlist (tl(explode t))) in

   let val U = propsubs nil T (findthm n) in

   if not (wellformed U) then sayillformed (display U)

   else if Newtypecheck U = ramifiedtyperror 

   then  sayilltyped U

   else (BOOK:=(!BOOK)@[U];
   saytheorem U)

   end

   end;




exception NoSub;

fun evalvarfun nil v = raise NoSub |

   evalvarfun ((v,w)::L) x = if lessvar x v then raise NoSub

                        else if x = v then w

                        else evalvarfun L x;

fun sorted nil = true |

   sorted [v] = true |

   sorted (v::(w::L)) = lessvar v w andalso sorted (w::L);

(* alpha conversion rules:  these do permissible conversions of
bound variables = order preserving and fixing free variables throughout one
side of a theorem with a top level propositional connective.
The arguments t1 and t2 are argument lists representing the domain
of the substitution and the range; both lists must be sorted, they
must be the same length, and the map is order preserving.

The domain must include all variables in the target side of the term.

the first one applies to right sides of terms and the second
to left sides; the rules are only applicable to theorems with
top level connectives. *)

(* No polymorphic license was taken in the development of
this rule:  it should be sound *)

(*

fun alphaspecify n t1 t2 =

   (if t1 = "" orelse hd(explode t1) <> #"(" orelse t2 = "" orelse hd(explode t2) <> #"("

   then say ("Bad argument")

   else let val T1 = (parsetermlist (tl(explode t1))) 

   and T2 = (parsetermlist (tl(explode t2))) in

   if not (wellformed (varhead(X 1,T1))) then say (t1^" is ill-formed:\n"^"\n")

   else  
   if not (wellformed (varhead(X 1,T2))) then say (t2^" is ill-formed:\n"^"\n")

   else if T1 <> map (fn (Var v) => Var v | x => Var (X 0)) T1

   orelse T2 <> map (fn (Var v) => Var v | x => Var (X 0)) T2

   then say ("Rule requires lists of variables.\n\n")

   else let val U1 = map (fn (Var v) => v | x => X 0) T1 
   and U2 = map (fn (Var v) => v | x => X 0) T2

   in if not (sorted U1) orelse not (sorted U2)

   then say "Substitution must be order-preserving"

   else let val V = subfun U1 U2 and W = findthm n

   in if map (evalvarfun V) (FV W) <> FV W 

   then say ("Substitution must fix free variables.\n\n")

   else (fn (disj(s,a,b)) => let val P = disj(s,a,fvars (evalvarfun V) b)

   in if Newtypecheck P = ramifiedtyperror then sayilltyped P else

   (BOOK:=(!BOOK)@[P];saytheorem P) end |

         x => say ("Theorem is not of correct form.\n\n")) W

   end end end) handle NoSub => say "Variable not in domain of substitution.\n\n";

fun alphaspecify2 n t1 t2 =

   (if t1 = "" orelse hd(explode t1) <> #"(" orelse t2 = "" orelse hd(explode t2) <> #"("

   then say ("Bad argument")

   else let val T1 = (parsetermlist (tl(explode t1))) 

   and T2 = (parsetermlist (tl(explode t2))) in

   if not (wellformed (varhead(X 1,T1))) then say (t1^" is ill-formed:\n"^"\n")

   else  
   if not (wellformed (varhead(X 1,T2))) then say (t2^" is ill-formed:\n"^"\n")

   else if T1 <> map (fn (Var v) => Var v | x => Var (X 0)) T1

   orelse T2 <> map (fn (Var v) => Var v | x => Var (X 0)) T2

   then say ("Rule requires lists of variables.\n\n")

   else let val U1 = map (fn (Var v) => v | x => X 0) T1 
   and U2 = map (fn (Var v) => v | x => X 0) T2

   in if not (sorted U1) orelse not (sorted U2)

   then say "Substitution must be order-preserving"

   else let val V = subfun U1 U2 and W = findthm n

   in if map (evalvarfun V) (FV W) <> FV W 

   then say ("Substitution must fix free variables.\n\n")

   else (fn (disj(s,a,b)) => let val P = disj(s,fvars (evalvarfun V) a,b)

   in if Newtypecheck P = ramifiedtyperror then sayilltyped P else 

   (BOOK:=(!BOOK)@[P];saytheorem P) end |

         x => say ("Theorem is not of correct form.\n\n")) W

   end end end) handle NoSub => say "Variable not in domain of substitution.\n\n";

*)

(* new variable renaming tool using superstandardform *)

fun renamevars n t = let val T = parse t in

if not(wellformed(T)) 

then sayillformed t

else if Newtypecheck T = ramifiedtyperror

then sayilltyped (T)

else if FV T <> FV (findthm n) orelse superstandardform T <> superstandardform (findthm n)

then say ("New theorem is not alpha-equivalent to old theorem.\n\n")

else (BOOK:=(!BOOK)@[T];saytheorem T) end;

(*

(* tool for handling equivalence mod definite description expansion *)

(* it also works mod variable renaming *)

fun desceq n t = let val T = parse t in

if not(wellformed(T)) 

then sayillformed t

else if Newtypecheck T = ramifiedtyperror

then sayilltyped (T)

else if FV T <> FV (findthm n) orelse superstandardform(expanddescs T) <> 
superstandardform(expanddescs (findthm n))

then say ("New theorem is not description-equivalent to old theorem.\n\n")

else (BOOK:=(!BOOK)@[T];saytheorem T) end;

*)

fun redeq n t = let val T = parse t in

if not(wellformed(T)) 

then sayillformed t

else if Newtypecheck T = ramifiedtyperror

then sayilltyped (T)

else if FV T <> FV (findthm n) orelse superstandardform(allred T) <> 
superstandardform(allred (findthm n))

then say ("New theorem is not reduction-equivalent to old theorem.\n\n")

else (BOOK:=(!BOOK)@[T];saytheorem T) end;

(* specify1 makes a substitution of pf t for variable xm
in theorem n *)
 
 fun specify1 n m t = 

   let val T = parse t in

   if not (wellformed T) then sayillformed t

   else if Newtypecheck T = ramifiedtyperror

   then (say ((display T)^" is ill-typed:\n\n");
   (Showfinal (display T)))

   else let val U = subs1 [(X m,Fun T)] (findthm n) in

   if not (wellformed U) then sayillformed (display U)

   else if Newtypecheck U = ramifiedtyperror 

   then  sayilltyped U

   else (BOOK:=(!BOOK)@[U];
   saytheorem U)

   end

   end; 

 fun propspecify1 n m t = 

   let val T = parse t in

   if not (wellformed T) then sayillformed t

   else if Newtypecheck T = ramifiedtyperror

   then (say ((display T)^" is ill-typed:\n\n");
   (Showfinal (display T)))

   else let val U = propsub m T (findthm n) in

   if not (wellformed U) then sayillformed (display U)

   else if Newtypecheck U = ramifiedtyperror 

   then  sayilltyped U

   else (BOOK:=(!BOOK)@[U];
   saytheorem U)

   end

   end; 


(* this rule applies modus ponens to theorem m (p)
and theorem n (p implies q).

It is unsound if care is not taken:  it needs to check
for loss of type information in the conclusion q.  If
polymorphism is assured then the current version is fine.

I have now added the type check to this version.

*)

fun MP m n = let val M = findthm m and N = findthm n

in

if (fn (disj("implies",a,b))=> a | x => error) N = M

then let val P = (fn (disj ("implies",a,b))=>b| x => error) N

in let val L = Finaltypelist P in if L <>  
restrictvarfun (domainofvarfun L)
(Finaltypelist N) andalso (not (ambison()))

then (say "Modus ponens fails due to loss of type information:\n\n";
Showfinal (display N); say "But in conclusion:\n\n"; 
Showfinal (display P))

else (BOOK := (!BOOK)@[P];
    saytheorem P
    )

end end
else say ("Modus ponens does not apply\n"^(display M)^"\n"^(display N)^"\n")

end;

(* This rule, allowing addition of new parameters to free pf variables
in terms, captures what I think is an inadequately formalized aspect of
PM.  One needs to be careful:  it is important that newparam
checks type to make sure that the arguments can actually be added
to the generalized function. *)

(* this is also unsound in the presence of finite types;
it needs a check that the variable does not occur as an argument *)

(* the check has now been added *)

(* this could be extended to handle internals of description terms *)

fun extendparameters m n (negation T) =
   
   negation(extendparameters m n T) |

   extendparameters m n (disj(s,T,U)) =

   disj(s,extendparameters m n T,extendparameters m n U) |

   extendparameters m n (univ(s,(X p),T)) =

   if p = n then error  (* don't allow capture of the new variable *)

   else if p = m then (univ(s,(X p),T))

   else extendparameters m n (univ(s,(X p),extendparameters m n T)) |

   extendparameters m n (varhead(X p,L)) = 

   if (foundin (X m) (FV (varhead(X (m+1),L))) andalso not (ambison()))

   then error

   else if m = p then varhead(X p,L@[Var(X n)])

   else (varhead(X p,L)) |

   extendparameters m n (varhead2(X p,L)) =

   if (foundin (X m) (FV (varhead(X (m+1),L))) andalso not (ambison()))

   then error 

   else if m = p then varhead2(X p,L@[Var(X n)])

   else (varhead2(X p,L)) |

   extendparameters m n (varapp(X p,L)) = 

   if foundin (X m) (FV (varhead(X (m+1),L))) 

   then error

   else if m = p then varapp(X p,L@[Var(X n)])

   else (varapp(X p,L)) |

   extendparameters m n (varapp2(X p,L)) =

   if foundin (X m) (FV (varhead(X (m+1),L))) 

   then error 

   else if m = p then varapp2(X p,L@[Var(X n)])

   else (varapp2(X p,L)) |

   extendparameters m n (constapp(t,L)) =

   if foundin (X m) (FV (varhead(X (m+1),L))) 

   then error else (constapp(t,L)) |
  
   extendparameters m n t = t;

fun newparam thm m n = 

   let val T = extendparameters m n (findthm thm) in

   if not(wellformed T) then sayillformed (display T)

   else if Newtypecheck T = ramifiedtyperror 

   then sayilltyped T

   else (BOOK:=(!BOOK)@[T]; saytheorem T) end;

(* basic rules for introduction and elimination of universal quantifiers *)

fun generalize m n = 

   let val T = findthm m in

   if foundin (X n) (FV T) then 

   (BOOK:=(!BOOK)@[(univ("",X n,T))]; saytheorem (univ("",(X n),T)))

   else say ("The variable does not occur free in the theorem.\n\n") end;

fun ungeneralize m =

   let val T = findthm m in

   (fn (univ("",(X m),U)) => (BOOK:=(!BOOK)@[U];saytheorem U) |

       x => say "The theorem does not have a leading universal quantifier.\n\n") T

   end;

(* a basic extensionality rule:  if two pfs always imply each other,
then they are equal. *)

(* This corresponds to Russell's doctrine that everything one can say
about a pf is captured by knowing its values *)

(* note that the extensionality rule will allow me to greatly simplify
definitions *)

fun extensionality m n t u =

    let val T = (parse t) and U = (parse u) and 
    T1 = findthm m and T2 = findthm n in

    if T1 = disj("implies",T,U)

    andalso T2 = disj("implies",U,T)

    then let val T3 = varhead(newvar(union (allvars T) (allvars U)),[Fun T])

    and T4 = varhead(newvar(union (allvars T) (allvars U)),[Fun U])

    in if Newtypecheck (disj("implies",T3,T4)) = ramifiedtyperror

    then sayilltyped (disj("implies",T3,T4))

    else (BOOK:=(!BOOK)@[(disj("implies",T3,T4))];
          saytheorem (disj("implies",T3,T4));
          BOOK:=(!BOOK)@[(disj("implies",T4,T3))];
          saytheorem (disj("implies",T4,T3)))


    end

    else say "Theorems are not of the appropriate forms.\n\n"

    end;

(* rules on variable renumbering (alpha conversion) DONE *)

(* a rule that makes a list of substitutions of bound
variables on the right side of a theorem with a top-level
propositional connective *)

(* at this point I should have all basic formal rules I might want,
except a positive rule of ambiguity.  I might want to install a
version of MP that does type-checking [this has now been installed],
though the fully polymorphic version given here is provably consistent
(but has the effect that it allows us to prove that there are lots of
individuals, for example) *)

(* axioms of choice and infinity might be wanted, and the axiom
of reducibility (as an option).  There also ought to be a version
that works in STT *)

(* of course I want things like descriptions... *)

(* protocols for development of definitions, derived rules, etc. *)

(*

structure of desired deductive rule (two-step version)

figure out how to automate this (and work on protocols
for development of rules of inference in general).

1. p -> q  (hyp)

2. q -> r  (hyp)

3. (p -> q) -> (q -> r) -> (p -> r) (* 2.06 *)

4. (q -> r) -> (p -> r)  (MP 1 3)

5. p -> r (MP 2 4)

*)

(* extract subterms *)

fun leftterm s1 (disj(s2,T,U)) = if s1 = s2 then T else error 
   | leftterm s x = error;

fun rightterm s1 (disj(s2,T,U)) = if s1 = s2 then U else error 
   | rightterm s x = error;

(* add a list of  new parameters to a variable in a theorem *)

fun addnewvars thethm thevar (thenewvars) =

if thenewvars = nil then ()

else (newparam thethm thevar ((fn (X n) => n) (hd (thenewvars)));
addnewvars 0 thevar (tl thenewvars));

(* a hand-crafted derived rule *)

fun syll m n =

let val M = findthm m and N = findthm n in

let val p = leftterm "implies" M and q1 = rightterm "implies" M 
and q2 = leftterm "implies" N and r = rightterm "implies" N in

if q1 = error orelse q1 <> q2 then say "Theorems are not of the correct form\n\n"

else (propspecify (thmno "2.05") 
("("^(display p)^","^(display q1)^","^(display r)^")");
MP n 0;MP m 0) end end;



(* develop a definition facility *)

val PRIMITIVES = ref ["bogus"];

val DEFINITIONS = ref [("bogus",error)];

val _ = PRIMITIVES:= nil;

val _ = DEFINITIONS:= nil;

fun declareprimitive s = PRIMITIVES := s::(!PRIMITIVES);

val _ = declareprimitive "";

val _ = declareprimitive "v";

fun foundinlist s nil = false |

foundinlist s (t::L) = s=t orelse foundinlist s L;

fun isprimitive s = foundinlist s (!PRIMITIVES); 

fun find s nil = error |

find s ((t,u)::L) = if s=t then u else find s L;

fun isdefined s = find s (!DEFINITIONS) <> error;

fun isdefinedconnective s =
    s<>"" andalso getloweralpha(explode s) = s
    andalso isdefined s;

fun definitionof s = find s (!DEFINITIONS);

fun alldeclared (disj(s,T,U)) = isdefined s orelse isprimitive s
                andalso alldeclared T andalso alldeclared U |

     alldeclared (univ(s,v,T)) = isdefined s orelse isprimitive s
                andalso alldeclared T |

     alldeclared (negation T) = alldeclared T |

     alldeclared error = false |

     alldeclared (varhead(v,L)) =

     map (fn (Const c) => true | (Var x) => true | (Fun t) => alldeclared t

     | (Desc(s,v,T)) => alldeclared T)
     L = map (fn x => true) L |

     alldeclared (varhead2(v,L)) = map 
    (fn (Const c) => true | (Var x) => true | (Fun t) => alldeclared t

    | (Desc(s,v,T)) => alldeclared T )
     L = map (fn x => true) L |

     alldeclared t = true;

fun defineconnective s t =

let val T = parse t in

if s = "" orelse getloweralpha (explode s) <> s

  then say (s^" is not a legal connective name.\n\n")

  else if not(propfree(propsubs nil [parse "x1()",parse "x2()"] T))

           orelse FV T <> nil

           orelse Newtypecheck T = ramifiedtyperror

        then say ((display T)^" is not a suitable term for the definition of "^s^"\n\n")

        else if not (alldeclared T) 

            then say ("Undefined terms detected in "^(display T)^"\n\n")

            else (DEFINITIONS:= (s,T)::(!DEFINITIONS)) end;

fun showdefinition s = say ("\n\n"^(display(definitionof s))^"\n\n");

fun useconnectivedefinition1 s S (disj(t,T,U)) =

   if s <> t then disj(t,useconnectivedefinition1 s S T,
   useconnectivedefinition1 s S U)

   else propsubs nil [useconnectivedefinition1 s S T,
   useconnectivedefinition1 s S U] S |

   useconnectivedefinition1 s S (negation T) =

   negation(useconnectivedefinition1 s S T) |

   useconnectivedefinition1 s S (univ(t,v,T)) =

   univ(t,v,useconnectivedefinition1 s S T) |

   useconnectivedefinition1 s S (varhead(v,L)) =

   varhead (v,
   map (fn (Fun t) => Fun(useconnectivedefinition1 s S t) | x => x) L) |

   useconnectivedefinition1 s S (varhead2(v,L)) =

   varhead2 (v,
   map (fn (Fun t) => Fun(useconnectivedefinition1 s S t) | x => x) L) |

   useconnectivedefinition1 s S t = t;

fun useconnectivedefinition s t = useconnectivedefinition1 s (definitionof s) t;

(* this one

(* a quantifier has to be presented as an operation on a propositional function
of one variable *)

usequantifierdefinition1 s S (univ(t,v,T)) =

if s<> t then univ(t,v,T)

else if not (foundin v (FV T)) then error

else (*  S is an expression with one free variable x2, appearing only as
an argument.  Replace all occurrences of x2 applied to an argument with
T with v replaced by that argument.  Occurrences of x1 as bound variable
in S need to be replaced by v and other measures against bound variable
capture might need to be taken? *) 

*)

fun bydefinition s n T = let val t = parse T in

    if isdefinedconnective s

    andalso useconnectivedefinition s (findthm n) =

    useconnectivedefinition s t

    then (BOOK:=(!BOOK)@[t]; saytheorem (t))

    else say ("Proposed theorem not justified by definition\n\n") end;

fun clearbook() = BOOK := nil;

(* this function runs an actual book construction of part of PM:
it is under development *)



fun theoldbook () = (

clearbook();

(* definition of implication *)

axiom "(x3((x1() implies x2())) implies x3((~x1() v x2())))";

axiom "(x3((~x1() v x2())) implies x3((x1() implies x2())))";

(* The five axioms *)

axiom "((x1()v x1()) implies x1())";

setlabel "Taut" 0;

axiom "(x2() implies (x1() v x2()))";

setlabel "Add" 0;

axiom "((x1() v x2()) implies (x2() v x1())";

setlabel "Perm" 0;

axiom "((x1() v (x2() v x3())) implies (x2() v (x1() v x3())))";

setlabel "Assoc" 0;

axiom "((x2() implies x3()) implies ((x1() v x2()) implies (x1() v x3())))";

setlabel "Sum" 0;

newparam 3 1 2;

specify1 0 1 "~x1()";

specify 0 "(x1)";

newparam 2 3 4; newparam 0 3 5;

specify1 0 3 "(x1(x4,x5) implies x5())";

newparam 0 5 6;

specify1 0 5 "~x1()";

specify 0 "(x1,x1)";

MP 10 0;  (* proof of 2.01 complete *)  (* 17 *)

setlabel "2.01" 0;  setlabel "Abs" 0;

newparam 4 1 3;

specify1 0 1 "~x1()";

newparam 2 3 4; newparam 0 3 5;

specify1 0 3 "(x2() implies x1(x3,x2))";

specify 0 "(x2,x1)";

specify 19 "(x2,x1)";

MP 0 ~1;  (* proof of 2.02 complete *) (* 25 *)

setlabel "2.02" 0;  setlabel "Simp" 0;

newparam 5 1 3; newparam 0 2 4;

specify 0 "(~x1(),~x1(),x1,x2)";

newparam 2 3 4; newparam 0 3 5;  newparam 0 3 6; newparam 0 3 7;

specify1 0 3 "(x1(x2,x3) implies x1(x4,x5)";

newparam 0 5 8; newparam 0 7 9;

specify 0 "(x1,~x1(),x2,~x1(),x2,x1)";

MP 28 0;  (* proof of 2.03 complete *) (* 37 *)

setlabel "2.03" 0;

(* definition of the existential quantifier *)

(* this should complete the logic of quantification in PM *)

axiom "(x3([Ex1]x2(x1)) implies x3(~[x1]~x2(x1)))";

axiom "(x3(~[x1]~x2(x1)) implies x3([Ex1]x2(x1)))";

axiom "(x1(x2) implies [Ex2]x1(x2))";

axiom "((x1(x2) v x1(x3)) implies [Ex2]x1(x2))";

(* these may be redundant (rules for moving clauses out of scope
when the bound variable does not appear) *)

(* notice that non-appearance of the bound variable is readily
represented in this system *)

(* where more arguments are involved, newparam will do the trick *)

axiom "(x5([Ex2](x1(x2,x3) v x4(x3))) implies x5(([Ex2]x1(x2,x3) v x4(x3))))";

axiom "(x5(([Ex2]x1(x2,x3) v x4(x3))) implies x5([Ex2](x1(x2,x3) v x4(x3))))";

axiom "(x5([x2](x1(x2,x3) v x4(x3))) implies x5(([x2]x1(x2,x3) v x4(x3))))";

axiom "(x5(([x2]x1(x2,x3) v x4(x3))) implies x5([x2](x1(x2,x3) v x4(x3))))";

(* the preceding axioms could be generated by using extensionality on
simple implications *)

axiom "((x1() and x2()) implies ~(~x1() v ~x2()))";

axiom "(~(~x1() v ~x2()) implies (x1() and x2()))";

extensionality ~1 0 "(x1() and x2())" "~(~x1() v ~x2())";

newparam 6 1 4;  newparam 0 2 5;

specify1 0 1 "~x1()";specify1 0 2 "~x1()"; 

specify 0 "(x3,x1,x2)";

newparam 2 3 4; newparam 0 3 5; newparam 0 3 6;

specify1 0 3 "((~x4() v x1(x5,x6)) implies (~x5() v x1(x4,x6))";

specify 0 "(x1,x2,x3)";

MP 54 59;

newparam 57 3 7;

specify1 0 3 "(x1(x4,x5) implies x1(x6,x7))";

newparam 0 5 8; newparam 0 5 9; newparam 0 7 10; newparam 0 7 11;

specify1 0 5 "(x1() implies x2())";  specify1 0 7 "(x1() implies x2())";

specify 0 "(x1,x2,x2,x3,x1,x3)";

MP 60 0;  (* proof of 2.04 completed *) (* 70 *)

setlabel "2.04" 0;  setlabel "Comm" 0;

newparam 7 1 4;

specify1 0 1 "~x1()";

specify 0 "(x2,x3,x1)";

newparam 2 3 4;  newparam 0 3 5; newparam 0 3 6;

specify1 0 3 "((x5() implies x6()) implies (x1(x4,x5) implies x1(x4,x6)))";

specify 0 "(x1,x2,x3)";

MP 73 0; (* proof of 2.05 completed *) (* 79 *)

setlabel "2.05" 0;

newparam 70 1 4; newparam 0 1 5; 

newparam 0 2 6; newparam 0 2 7;

newparam 0 3 8; newparam 0 3 9;

specify 0 "((x1() implies x2()),(x1() implies x2()),(x1() implies x2()),x2,x3,x1,x2,x1,x3)";

MP 79 0;  (* proof of 2.06 complete *) (* 87 *)

setlabel "2.06" 0;

specify 4 "(x1,x1)";  (* this is 2.07 *) (* 88 *)

setlabel "2.07" 0;

newparam 79 2 4;

specify1 0 2 "(x1() v x1())";

specify 0 "(x1,x1,x1)";

MP 3 0;

MP 88 0;  (* proof of 2.08 is complete *) (* 93 *)

setlabel "2.08" 0; setlabel "Id" 0;

newparam 1 3 4;

specify1 0 3 "x1(x4,x4)";

specify 0 "(x1)";

MP 93 0;  (* proof of 2.1 is complete *) (* 97 *)

setlabel "2.1" 0;

newparam 5 1 3;

specify1 0 1 "~x1()";

specify 0 "(x1,x1)";

MP 97 0;  (* proof of 2.11 is complete *)  (* 101 *)

setlabel "2.11" 0;

newparam 101 1 2;

specify 0 "(~x1(),x1)";

newparam 2 3 4; newparam 0 3 5;

specify1 0 3 "x1(x4,x5)";

newparam 0 5 4;

specify1 0 5 "~~x1()";

specify 0 "(x1)";

MP 103 0;  (* proof of 2.12 is complete *) (* 110 *)

setlabel "2.12" 0;

newparam 7 2 4;  newparam 0 3 5;

specify 0 "(x1,~x1(),~~~x1(),x1,x1)";

newparam 110 1 2;

specify 0 "(~x1(),x1)";

MP 0 113;

MP 101 0;  (* proof of 2.13 is complete *)  (* 117 *)

setlabel "2.13" 0;

newparam 5 2 3;

specify 0 "(x1,~~~x1(),x1)";

MP 117 0;

newparam 2 3 4;  newparam 0 3 5;

specify1 0 3 "x1(x2,x3)";

newparam 0 4 6;

specify 0 "(~~x1(),x1,x1)";

MP 120 0;  (* 2.14 proved *)  (* 126 *)

setlabel "2.14" 0;

newparam 79 1 4;  newparam 0 3 5;

specify 0 "(~x1(),x2,~~x1(),x1,x2)";

specify 110 "(x2)";

MP 0 ~1;

newparam 37 1 3;  newparam 0 2 4;

specify 0 "(~x1(),~x1(),x1,x2)";

newparam 79 1 4;  newparam 0 2 5;

specify 0 "(~x1(),~~x1(),x1,x2,x1)";

MP 126 0;  (* (6) in proof of 2.15 *)

newparam 79 1 4;  newparam 0 1 5;

newparam 0 2 4;  newparam 0 2 5;

newparam 0 3 4;  newparam 0 3 5;

specify 0 "((~x1() implies x2()),(~x1() implies ~~x2()),(~x2() implies ~~x1()),x1,x2)";

MP 134 0;

MP 131 0;

specify 144 "((~x1() implies x2()),(~x2() implies ~~x1()),(~x2() implies x1()),x1,x2)";

MP 138 0;

MP 147 0;  (* 2.15 proved *)  (* 150 *)

setlabel "2.15" 0;

specify (thmno "2.12") "(x2)";

newparam (thmno "2.05") 3 4;

specify 0 "(x1,x2,~~x1(),x2)";

MP 151 0;

newparam (thmno "2.03") 2 3;

specify 0 "(x1,~x1(),x2)";

(* can I write a function (a derived rule) that will do what
"Syll" does at this point? (end of proof of 2.16?) *)

specify (thmno "2.06") "(x4,x5,x6)";

newparam 0 4 1;  newparam 0 4 2;

newparam 0 5 1;  newparam 0 5 2;

newparam 0 6 1;  newparam 0 6 2;

specify1 0 4 "(x1() implies x2()";

specify1 0 5 "(x1() implies ~~x2())";

specify1 0 6 "(~x2() implies ~x1())";

MP 154 0;

MP 156 0;

setlabel "2.16" 0;

specify (thmno "2.03") "(x4,x5)";

newparam 0 4 2; newparam 0 5 1;

specify1 0 4 "~x2()";  specify1 0 5 "x1()";

specify (thmno "2.14") "(x2)";

specify (thmno "2.05") "(x3,x4,x5)";

newparam 0 3 1;  newparam 0 4 2;  newparam 0 5 2;

specify1 0 3 "x1()";

specify1 0 4 "~~x2()";

specify1 0 5 "x2()"; 

MP 174 0;

specify (thmno "2.06") "(x3,x4,x5)";

newparam 0 3 1; newparam 0 3 2;

newparam 0 4 1; newparam 0 4 2;

newparam 0 5 1; newparam 0 5 2;

specify1 0 3 "(~x2() implies ~x1())";

specify1 0 4 "(x1() implies ~~x2())";

specify1 0 5 "(x1() implies x2())";

MP 173 0;  MP 182 0;  setlabel "2.17" 0;

extensionality (thmno "2.16") (thmno "2.17") "(x1() implies x2())" "(~x2() implies ~x1())";

specify (thmno "2.05") "(x2,x3,x4)";

newparam 0 2 1; newparam 0 3 1;  newparam 0 4 1;

specify 0 "(x1,~x1(),x1(),~~x1())";

MP (thmno "2.12") 0;

specify (thmno "2.01") "(x2)";

newparam 0 2 1;

specify 0 "(x1,~x1())";


());

(* val _ = theoldbook(); *)



(* new version of the book *)

fun thebook() =

(clearbook();

(* there are still problems -- definition handling seems to
require pfs of propositions? *)

axiom "((p1 implies p2) implies (~p1 v p2))";

setlabel "IMPDEF1" 0;

axiom "((~p1 v p2) implies (p1 implies p2))";

setlabel "IMPDEF2" 0;

axiom "((p1 v p1) implies p1)"; 

defineconnective "implies" "(~p1 v p2)";

setlabel "Taut" 0;

axiom "(p2 implies (p1 v p2))";

setlabel "Add" 0;

axiom "((p1 v p2) implies (p2 v p1))";

setlabel "Perm" 0;

axiom "((p1 v (p2 v p3)) implies (p2 v (p1 v p3)))";

setlabel "Assoc" 0;

axiom "((p2 implies p3) implies ((p1 v p2) implies (p1 v p3)))";

setlabel "Sum" 0;

propspecify 1 "(x1(),x2())";

propspecify 2 "(x1(),x2())";

extensionality ~1 0 "(x1() implies x2())" "(~x1() v x2())";

setlabel "IMPDEF1b" ~1;

setlabel "IMPDEF2b" 0;

propspecify (thmno "Taut") "(~p1)";

bydefinition "implies" 0 "((p1 implies ~p1) implies ~p1)";

setlabel "2.01" 0;

propspecify1 (thmno "Add") 1 "~p1";

bydefinition "implies" 0 "(p2 implies (p1 implies p2))";

setlabel "2.02" 0;

propspecify (thmno "Perm") "(~p1,~p2)";

bydefinition "implies" 0 
"((p1 implies ~p2) implies (p2 implies ~p1))";

setlabel "2.03" 0;

propspecify (thmno "Assoc") "(~p1,~p2,p3)";

bydefinition "implies" 0 
"((p1 implies (p2 implies p3)) implies (p2 implies (p1 implies p3)))";

setlabel "2.04" 0; setlabel "Comm" 0;

propspecify (thmno "Sum") "(~p1,p2,p3)";

(* what does propspecify do with short parameter lists? *)

bydefinition "implies" 0 
"((p2 implies p3) implies ((p1 implies p2) implies (p1 implies p3)))";

setlabel "2.05" 0;

propspecify (thmno "Comm") "((p2 implies p3),(p1 implies p2),(p1 implies p3))";

MP (thmno "2.05") 0;

setlabel "2.06" 0;

propspecify (thmno "Add") "(p1,p1)";

setlabel "2.07" 0;

propspecify (thmno "2.05") "(p1,(p1 v p1),p1)";

setlabel "(1)" 0;

MP (thmno "Taut") (thmno "(1)");

setlabel "(3)" 0;

MP (thmno "2.07") (thmno "(3)");

setlabel "2.08" 0;

bydefinition "implies" (thmno "2.08") "(~p1 v p1)";

setlabel "2.1" 0;

propspecify (thmno "Perm") "(~p1,p1)";

MP (thmno "2.1") 0;

setlabel "2.11" 0;

propspecify (thmno "2.11") "(~p1)";

bydefinition "implies" 0 "(p1 implies ~~p1)";

setlabel "2.12" 0;

propspecify (thmno "Sum") "(p1,~p1,~~~p1)";

propspecify (thmno "2.12") "(~p1)";

MP 0 ~1;

MP (thmno "2.11") 0;

setlabel "2.13" 0;

propspecify1 (thmno "Perm") 2 "~~~p1";

MP (thmno "2.13") 0;

bydefinition "implies" 0 "(~~p1 implies p1)";

setlabel "2.14" 0;

propspecify (thmno "2.05") "(~p1,p2,~~p2)";

propspecify (thmno "2.12") "(p2)";

MP 0 ~1;

setlabel "(3)" 0;

propspecify (thmno "2.03") "(~p1,~p2)";

setlabel "(4)" 0;

propspecify (thmno "2.05") "(~p2,~~p1,p1)";

MP (thmno "2.14") 0;

setlabel "(6)" 0;

propspecify (thmno "2.05") 
"((~p1 implies p2),(~p1 implies ~~p2),(~p2 implies ~~p1))";

MP (thmno "(4)") 0;

MP (thmno "(3)") 0;

setlabel "(9)" 0;

propspecify (thmno "2.05") 
"((~p1 implies p2),(~p2 implies ~~p1),(~p2 implies p1))";

MP (thmno "(6)") 0;

MP (thmno "(9)") 0;

setlabel "2.15" 0;

propspecify (thmno "2.12") "(p2)";

propspecify (thmno "2.05") "(p1,p2,~~p2)";

MP ~1 0;

propspecify1 (thmno "2.03") 2 "~p2";

(* this is where I stopped before -- it's time to
work on the derived rule Syll *)

syll 54 55;

setlabel "2.16" 0;

propspecify (thmno "2.03") "(~p2,p1)";

setlabel "1" 0;

propspecify (thmno "2.14") "(p2)";

propspecify (thmno "2.05") "(p1,~~p2,p2)";

MP ~1 0;

setlabel "2" 0;

syll (thmno "1") (thmno "2");



())

val _ = thebook();



