(* MOSCOW ML VERSION *)

(* New implementation of Mark2 theorem prover *)
(* now officially called "Watson" *)

(* copyright M. Randall Holmes, 2001 -- you may freely distribute as long
as this notice is preserved *)

(* also July 2, 2003:

other ideas which should be worked out, taken from earlier notes:

application of reference types, especially to the tactic interpreter.  figure
out how to apply all functions to terms with reference types.  Aim for unique
reference?  Interaction with parsing and display.  references need to know
about local hypotheses.  look at Dec 1 notes.

examine currentmenu fix -- what is this about?

implement s.c. separation.  More generally, implement something more like a type
system.

*)

(* July 2, 2003:

This note summarizes ideas for implementation of partial functions.

A new value "error" is introduced, standing for the unique nonexistent object,
which is the value of any function at the places where it is undefined.

?f@error = error for all ?f.

[P]@?x = if error = ?x then error else P[?x/?1]

To replicate the usual function of abstraction and reduction as far as possible,
we want to be able to recognize situations under which P[?x/?1] = 
if error = ?x then error else P[?x/?1].  We would like to automate this
process.

?n <> error can always be assumed.  (bound variables do not take the error value).
This should be implemented as a theorem and also as part of an automatic function.

When applying BIND@x to P, we have normal behavior if we can verify one of two
things:  either x <> error (x exists) or P is error if x is error (P is strict
relative to x).  So we would like to have an existence detector and a relative
strictness detector.

When applying EVAL to P@x, we are safe if we can tell that P is error
if x is error (relative strictness again), or if we can tell that x exists.

Operators have possibly interesting properties: an operator is total
if its value exists whenever its arguments exist, and an operator is
strict if its value does not exist whenever its arguments do not
exist.  Totality is useful for the recursion component of an existence
detector, and strictness is useful for the recursion component of a
relative strictness detector.

Effects on definition: defined _functions_ must be strict; the
relative strictness detector needs to be at work.  Defined operators
need not be strict, but we might want the ability to register a
defined operator as strict in spite of a non-strict definition (by
recording a theorem?).  Certain operations (equality for example) are
not strict.  The case construction is not strict.

Effects on theorem application:  theorems are no longer equivalent to 
universally quantified equations:  quantifiers have only existent objects
in their domain of applicability (we implement free logic), whereas theorems
are permitted to match free variables which may not have existent values.
Would it be a good idea to add variables which share the property of bound
variables that they can only match things known to exist?

Effects on higher-order matching:  existence or relative strictness is needed
to match P@x (or explicit appearance of if error = x...).  I was thinking that
this didn't apply to @! or @*, but in fact it must if we are to preserve standard
reasoning about equality of abstractions along with the fact that we have
just one kind of abstraction.  Our unstratified quantifiers also must satisfy free logic.
Note that issues of relative strictness are independent of stratification.

Now I have to read the program to see how easy or difficult it will be to implement this
everywhere.  Is it possible to implement it as a "toggle" which can be turned on or off
in a single Watson source, or do we need two different versions?

The type system can then be modified so that t:x = x for all x in type
t, and t:x = error for all x not in type t.  This has corresponding
effects on type definition, etc.

*)

(* July 25:

I should work on smart memory management (including storage of rewrites
-- replace 0|-|n's with explicit equations) inside the tactic interpreter.
This should make the tactic interpreter faster.

There should be an option to declare connectives "always break".
This would be a vast improvement in formatting.

A detailed review of the innards of the system is needed...particularly
the complicated stuff that has been added recently.

*)



(* March 1:

changed former exporttheorem and exportall to interfacetheorem and
draftinterface everywhere (including comments) [these are the
"theory modularity" commands).  Also improved the interface theorem
command using a technique which probably should be used to simplify
the older dependency update commands.  (these are long overdue for
careful review!)

Relevant display commands for theory modularity (one might want
to look at the theory interface, for example) and support for enforcement
of "locality" of identifiers (declare _new_ identifiers as local,
and set up interfacetheorem to abort if it tries to put a local
identifier in the interface).  Also, declaration safety for the
interface commands.

*)

(* Feb. 28:

eliminated level=0 clauses in strat.  This should have no effect at all.


I installed theory modularity.  If the command interfacetheorem
<name-of-theorem> is not used anywhere in a script, everything is
exported by newsegment().  If it is used, only things required for
theorems which are exported are actually exported.  There may be bugs,
as always; the exact way that the new segment is edited may be in
error.  To be precise, the function segmentedit needs to be examined
carefully, especially re the dependency lists.  The storeall command
will carry out the restrictions on the theory; backuptheory will not.
The command draftinterface() nulls the export list and so restores the
ability to back up the entire theory.  This needs to be tested!

I made a better effort to edit the inverse dependency lists intelligently,
but this is still a hard issue.

I want the new type system.  I think it will be independent of the
stratification (relative) type system: it should return deducible
types for subterms of a given term (a given subterm as an argument?)
-- focus would be on scin types, since scout types can be seen anyway?
This will go along with matching taking implicit type labels into
account -- bool:?x should match ?y&?z, for example.  Complex types
(arrow and product types) may come into play.  This may all be quite
complex, depending on how much of the information provided by scin/scout
we use?  We may want to accept more general forms of theorems as
"typing theorems" (with induced effects on scin/scout itself).  A possible
approach:  develop a global procedure for automatically generating
(and eliminating) types; always apply it to the target before matching
and apply it again after substitution.

*)

(* Feb. 27:

It is necessary to restore "linearity" of the stratification procedure
(it cannot, as presently designed, take identifications between
variables representing type shifting operators into account, without
complicating the relative_type data type.)

Further, it seems that the upgrade of relative_type isn't worthwhile;
the circumstances under which @* is used are limited and likely to remain
limited.

The reason why linearity is important is that the way force_equation
is implemented assumes that whenever a term with a given "unknown
displacement" is "floated", all terms with that unknown displacement
are floated; this allows us to avoid calculations with unknown types
by just arbitrarily shifting that unknown floated value when it becomes
rigid again.

Stuff from agendadir outlining changes to be made:

   Definitely plan on changing form of definition theorems,
   exploiting automatic matching, so that patterns are always
   universally applicable.  Further, extend generality of scin
   theorems to cover things like FORALLBOOL2.  (for FORALLBOOL2,
   the correct form of theorem would be forall@?p = forall@[bool:?p@?1]).
   This extension to scin would eliminate problems with quantifier
   switching theorems, for example.  Further, idea of extending
   matching to exploit scin/scout info (perhaps also the extended
   type system).  Test the proposed s.c. separation theorem.

   Idea of extending automatic projection operators to the
   proposed but never implemented ?m..n (and ?m...n final) 
   iterated projection operators for argument lists.  Could
   that generalization of matching be automatically extended
   by allowing all "functional programs" to be executed before
   matching (in whatever sense this is done with p1 and p2?)

   Review theorems and tactics to be predeclared (appropriate for
   preparation of new manual).

   The new user manual for the prover is definitely looking like
   a serious prospect.

The function strat, in spite of our
forebodings, has been correct (in Feb18.sml); I found and fixed a bug
in the new stratification scheme (fix_function wasn't working correctly)
which restored it to good order.  But strat2 was in error in
Feb18.sml; it has now been repaired by setting it up to type
bound variables as well as free variables in the same way that
strat does (by defining a function prestrat2 "basically the same"
as strat, mod type manipulations).

The level=0 clauses in strat seem to be pointless; they are a relic
of an early stage of development (and had to be deleted from prestrat2
for it to work).  They do no damage at this point, but should be removed.

I should think very carefully before installing any update of scin
based on the case of FORALLBOOL2.

*)

(* Feb. 26:

Further minor repairs to "type unification" function before making
this the official version.

It should now be the best possible solution to the @* typing issue;
it recognizes identifications between unknown displacements of identical
argument places of type-raising operators represented by the same variable.

*)

(* Feb. 23:  the solution for unkonwn displacements is incorrect --
and so was the CHECKTYPE solution, apparently.

To simplify matters, arguments of @* are now required to be "meta-free"
(no occurrences of @*, thus no repeated "unknown displacements").

*)

(* Feb. 22:

new version testing a more transparent implementation of stratification,
using single functions with domains including indeterminate types.

changed union so that it eliminates duplications from the first argument
as well as the second.

This appears to be completely implemented.  The one thing that remains
is to determine how to eliminate the need for CHECKTYPE by defining
special (possibly "must-float"?) types for subterms of @* expressions.

Plan to save old file as Feb18.sml

It appears that I now have an implementation of stratification
of @* terms using "unknown rigid displacements" which must be "floated"
for stratification.

Added restriction to the effect that the same term cannot get
an "unknown" displacement more than once (operators with @*
are not composed).  This allows justification of the typing
convention for @* and doesn't eliminate any realistic possibilities
for higher-order matching.  But there may still be type coincidences
to worry about?

*)

(* Feb. 18:

fixed bug in incremental backup -- attempts to do scratch work without
running a script first produced a crash because cleartheories didn't
save the preamble theory into the theories list.  Problem should now
be fixed.

*)

(* Dec. 6:

an idea (no code change).  Maintain lists of things declared in the
current theory and of things renamed or forgotten in the current
theory.  Don't allow new things to be renamed or forgotten, and don't
allow repeated renaming.  This could support the idea of renaming the
+ * of the natural numbers to allow use of the usual terminology for
the rationals in newlib*, for example.

I should start working on applications of the new reference term
construction.  The most evident use of this construction would be
to make the tactic interpreter a bit smarter (avoiding duplication
of effort).  There is a great deal of tedious case-checking, installing
the new term type for existing functions where it is not hard to see
what to do.

*)

(* Dec. 1:

Reference terms are installed as a formal possibility, though
term operations are not yet implemented for them.  I should set
about doing that implementation.  High priorities: display of
terms with embedded references (this is trivial) and creation
of such terms with unique reference properties.  Other tricks
possible with references:  one could manipulate many places in 
a term at once if one had explicit notation for shared subterms?

added commands showcounter() showmaxcounter() longestproof() to view
counter information.  I made all counter viewing and manipulation commands
"secure".  This means, for example, that if the max counter is set, one
can reset the counter to avoiding "timing out" during an INPUT (or other)
proof in progress.

The = built in tactic may need another fix to behave as one would
like.  Is it possible to arrange for it to set new variables using the
variables found in the given equation?

An inventory of dubious aspects of the software (places where bugs
might hide) would be handy.

There is a lurking idea that a term constructor using a reference to a
term is something that might be added for "meta-substitution" purposes
(attempts at efficient memory management and efficiency of
substitution).  It could also be accompanied by free atomic term
information.  Then new stuff could be added while avoiding wholesale
invalidation of the old approach.

It is in the tactic interpreter that such an idea could be useful?
Copied terms might actually be the same term, and manipulation of
one subterm implies similar manipulation of all identical subterms?
This might have the effect that execution of a term may cause nonlocal
execution of terms somewhere else, but this doesn't seem too bad?
The manipulations carried out elsewhere should be valid (though one
must be careful about local hypothesis executions; they will have to
be somehow indexed with their actual context), and much wasted effort
might be averted?

One could work with a table of term references (the table is needed to
tell when a given reference has already been accessed); term
references created under global hypotheses need to be eliminated when
one vacates the appropriate local context (and need to be kept
distinct from possibly typographically identical terms elsewhere, so
that modifications of terms legitimate in one context are not carried
out in another).  The goal of unique representation can be
approximated in ML...  Idea:  reference terms for subterms
with local hyps might actually include references to the local
hyps, or at least be indexed using such references (rather than
just by hlevel).

The handling of the "current menu" is ugly (though now apparently
valid); I should change this.

*)

(* Nov. 29:

New features to avoid infinite looping.  There is a command
setmaxcounter n, which, if n is positive, sets a bound to the number
of times the new variable counter can be incremented (if n is
negative, there is no bound, as before).  This will bound the number
of times theorems can be applied, which prevents infinite loops from
taking place.  The error message "Ran out of time" is issued by
the tactic interpreter if the bound is overrun.

The start command now initializes the new variable counter (which
I should have done a long time ago; this would have largely eliminated
the unpredictability of the new variable counter!)

This will be valuable when using the GUI, which has no graceful way
to issue interrupts.

Detected a bug which causes suspend to mess up
the menu inside scripts.  load was making the same mistake.  
I hope it is fixed; the fix is awkward
(look at the functions currentmenu, setcurrentmenu).

*)

(* Nov. 22:

Implemented numeral variables of the form ??n.

Variables with two leading question marks will match only numerals
or other variables of the same kind.  This will facilitate definition
of natural number typing theorems, for example.  There are apparently
no uses of variables of this form in the current library, so no conflicts
should be created.  This will allow avoidance of some inelegant hacks
in the current libraries, and should be regarded as a precedent if other
built-in data types are added (such as strings).

*)

(* Nov. 20:

minor bug fix to new precedence commands leftprecabove and rightprecabove
(they would not raise precedence of a command with the opposite grouping
just stronger than the new infix/prefix).

*)

(* Nov. 7:

internal change (no change of version):  the stratification function
will not do the second stratification check if the term is metafree
(which means it won't contain @* ).

*)

(* Nov. 6:

The @* connective is installed, compiled, but not tested yet.  The
crux of the matter lies in functions inserttype, deletetype, raisebind
and raisestrongeval.  There are clauses for @* in
metahead/metastrat/metafree, declarescheck, match, autoeval, 
and strat.  Only free
variable headed terms with @* are regarded as stratified.

The semantics of @* are that it represents application of
operations which raise or lower type uniformly.  It is used
only for purposes of higher-order matching.  The idea is that
a term like (?f@*?1)@*?2 matches an arbitrary stratified but
possibly inhomogeneous term.  Heads of terms built with @* are
restricted in the same way as heads of terms built with @!.
@* is not technically opaque, but a term built with @* is only
stratifiable if it is headed by a free variable.  The net effect
of this is that it is impossible to abstract into the head of a @*
term and only possible to abstract into the arguments under controlled
conditions.

The fact that stratification tests have to be carried out twice
for the sole benefit of @*, plus possible doubts about its soundness,
suggest that there ought to be a way to turn it off (or else that
there ought to be a defter way to do the strat check).FIXED

This connective is a technicality of interest mostly to students
of the logic underlying the prover (and as such it is still important,
but users don't need to worry about it unless I come up with important
applications).  It is essentially the version
of the connective @! found in the old version design.sml;
it allows stronger forms of higher-order matching in true stratified
functions.

Preliminary tests suggest that it works.  We shall see!

*)

(* Nov. 3:

All current commands and built-in theorems are now found in the web
documentation.

No code changes.

Think stratification refinements:  I am thinking of introducing
@* (the application operator for type-raising or lowering operations)
with higher-order matching and stratification privileges; I would
also like to implement s.c. separation.

There should be no eval or bind analogue for @*; it should be managed
strictly by matching and substitution functions.  The clue is that
[T] is stratified for @* exactly if [bool:T] is stratified.  This should
actually make this easy.  Then one needs the CHECKTYPE trick to 
ascertain that the type of terms built with this operator can be
freely raised and lowered.

The advantage of @* is that it can be used to build true functions
where @! cannot.  But is it really needed?  When will one want to
generalize over possibly type-raising operators?  There is some danger
that one will become able to quantify over things one would rather
not quantify over (the whole range of functions and their type-raised
versions).  This should probably be avoided!

The original motivation for @* was that it was needed for uniform
treatment of nested quantifiers in the context of higher-order
matching.  But @! handles this just fine.  A new application for @*
will be a situation like that with nested quantifiers where we want to
be able to do matching on "stratified but inhomogeneous" expressions,
where type differentials are not known in advance, as in (Ax.(Ay.Pxy))
= (Ay.(Ax.Pxy)), where x and y may have any type differential and
the whole will remain stratified.  This is exactly what (P@*x)@*y is
supposed to match:  an expression which is stratified with unknown
types for x and y.  Will thoughts along these lines make things
easier?  If we are using it only for matching and substitution, we
can impose the same well-formedness requirements as with @! --
leading terms must be free variables or "eliminable" abstractions.
The advantage it will have over @! will be the ability to appear
in true functions.

So @* will be mentioned as a variant of @! in metastrat.
It will have its own clauses in higher-order matching
and correlated clauses in substitution.  Stratified terms
will have to stratify with @* having types 0 0 and types 1 0.
(a sketch of a proof that this is enough to verify that
it works would be nice).

For s.c. separation, we need to be able to explicitly s.c. type the
top level term (use scin/scout or explicit type label) and we also
need to be able to type the local bound variable as s.c., while
forbidding violations of opacity.  This suggests thinking about tools
for deducing s.c. types.

These are both mathematically rather than practically motivated 
ideas; there is no hurry.

*)

(* Nov. 2: 

All current commands are now documented in babydocs.tex.  They have
not been put on the web.  It is still necessary to document new
built-in theorems (there are a number of these to put in!) 


combination of old notes and some new stuff with SCOUT family of
commands, scin/scout declarations, and installation of the match
test on the = command.

Major cleanup of old comments!

(old note) automatically generated scripts should include
verify statements (no change yet)

(old note) Idea for interface: type terms to be "started" in the
Global Term window; then a keystroke could carry out the start
command.  fields for entering arguments to other commands would make
it possible to do this with other commands as well.


bug with display of backed up environment after use of autoedit;
backed up environment gets wrong name?  Of course, is it really a bug?
This goes with not wanting prove to rename environments, to avoid having
loads of backed-up environments.

The redundant parenthesis problem with unary terms still exists.

Incompatibility of incremental backup with forget still an issue;
this can be addressed when we do theory modularity.

Do I want @*?  Related in spirit is the question of implementation of
s.c. separation.

an old note: idea that operators declared scin or scout should be
retyped (scin as flat and scout so as to get smallest type to 0).
Recognize that if one is on two of the scin/scout lists one should be
on all three?  another old note: Idea about internalizing type
information: provide a built-in tactic which will convert an infix
term to a functional form, with appropriate introduction of constant
functions and values.another old note: an INPUTP@?tactic command which
allows one to input parameters to a tactic.

A built-in theorem which implements matchtri might be of interest.
This is likely to be more unpredictable than the = builtin theorem.
It is important to note that it is dependent on the order of the theorems
in the master theorems list, which changes!  NEW COMMENT:  could such
a command be made interactive?

another loose end: target search should also look at local hypotheses?

items reproduced from an old list of gaps:

   a redefinition command appropriate for type definitions.  This can wait
   for proof that redefinition will actually be used.

   the general, hard problem of scin/scout for functions or operators with lists 
   of arguments.  This is hard, and requires reflection.

   add application of commutative laws (and perhaps other laws of
   stereotyped form) to tri.  There is a vague idea of having an ability
   to register new abstract forms which theorems can take and have the
   system flag theorems of these kinds?  (so one could add idempotent laws,
   for example, without modifying code).  Do this, or at least think about it.

   rewrite logic?  refinement of success/failure? theoretical questions
   about infix variables (generation of new ones, unification?)  All
   things not to worry about now.

   other built-in data types?  (strings, terms?)

   I definitely need to implement sensible binding and abstraction with
   multiple variables of each type (?m..n).  Try doing it in structural,
   but be open to idea of doing it hard-wired.  Do this, but first try
   writing tactics for structural.wat that do it.

see note below (Aug. 20) about "makescinvar"; is there a use for
this any longer?  Stratification problems in embedded theorems (or in
paramterized new variables) are no longer a problem, for unexpected reasons.

I probably need to look at the documentation re documentation of all
recently introduced commands.

restricted makescinleft and makescinright so that fully
"scin" operators cannot have their types changed without use of
the makescin command.

some qualms about unary operators and functions in relation to scinright
are removed:  these are treated as "scin" and can't be touched by
makescinright anyway.  Only infixes can be made scinleft or scinright
proper.

Would it make sense for SCINL and SCINR to be restricted to
"true" scinleft and scinright operators?

Yes:  restricted SCINL and SCINR so that they apply only when
scinleftof and scinrightof are different theorems.  This makes the
forms of the theorems they will apply predictable!  It also means
that they will be much less often used.

added the "match check" to the = built in theorem; the target needs
to match the appropriate side of the given equation, not just the
matching theorem.  This allows one to automatically create restricted
versions of theorems...  This broke some tactics in newlib2 where
I wasn't careful to maintain disjointness of variables in theorems
built with = from those in the target term.  newlib2 seems to be fixed...
No obvious problems in omnibus, but it is harder to tell.

*)

(* Nov. 1:


for GUI-related reasons, seedeps now does its output via nopausemessage. 

I have a much better idea, involving less fiddling with the
innards of the prover (in fact, none!);  provide built-in theorems which
execute the theorems witnessing scin/scout properties of operators
and functions! 

The practical problem with this is that scin/scout theorem directionality
needs to be determined.  Otherwise it would be difficult to write tactics with
predictable effects.

It looks as if one would want functions to determine the precise
forms of theorems.  Direction of theorems is an issue; the difference
between scinform on the one hand and scinleftform, scinrightform on 
the other is also an issue.  Alternatively, the internal functions
could use the theorems to determine relevant types, and proceed to
do appropriate types without explicitly worrying about the exact forms
of the theorems?  But they would still need to post the correct
dependencies.

The advantage of this approach is that it does not create any new
data structures to keep track of at all, and still will provide a
new generalized type facility (while actively encouraging use of the
scin/scout facilities :-)

This suggests that it ought to be possible to change scin/scout
information about operators.  It also suggests that we ought to
accept scin/scout theorems for type labels; these won't be useful
for scin/scout, but they will be useful for subtyping judgments.

The built in theorems SCOUT, SCIN, SCINL and SCINR are now installed!
They can be executed in direct or converse senses; in the direct sense,
they add types and in the converse sense they remove types (no matter
what the sense of the actual scin/scout witness theorems may be).

This all seems about right.  Whatever information we have about the
"type system" of s.c. types which is available for stratification is
already coded in the scin/scout lists.  The new built-in theorems make
this information available to tactics as well.  Moreover, notice that
term types (and maybe even dependent types?) are made available by this
maneuver, since complex types can appear in scin/scout theorems.

Sensitivity to directionality has been tested.

The functions introduced Oct. 31 have been commented out for the moment.

What remains to be done:  things about changing scin/scout information;
support for subtyping theorems.

The interesting issue of s.c. separation remains open...

A built-in theorem which automatically expands definitions is no
harder than the SCOUT family to write, and might be useful.

It is easy enough to provide the ability to change the scin/scout lists
(so changing s.c. typing of operators) but it is unclear that this is
something one would use?  I went ahead and did it; the functions will
warn you if the operator or function is already scin/scout, but they
will go ahead with the new scin/scout assignment anyway.

*)


(* Oct. 26:

Added "cef" abbreviation for "clearerrorflag".

I changed the version date to Oct. 25, but only because of the optimizations;
there should be no change in prover behavior.

Upgrades being seriously considered now:

1.  the type system upgrade.  The practical aim of this upgrade is
to allow a general implementation of the problem of assigning explicit
types to terms and eliminating them where necessary.

A secondary aim of theoretical interest is to see whether there is
a nice way to implement s.c. separation and so get a stronger logic.
It is not clear that this is useful in a practical sense.

A very basic thing is to change the declarations of constants and
operators to record input and output types; add built in theorems
which will add and remove these types.  The scin/scout functions would
then modify the declaration lists.NO - the scin/scout lists themselves
are the source of type information.

A very basic implementation of this idea might go no farther than this.
A full implementation might also add arrow and product types and more
complex facilities for type inference.  I'm not sure what's desirable.
THE scin/scout approach does support complex types.

2.  Theory level modularity.  This would mean that theorems would be
copied into an inheriting theory only if explicitly "exported" from 
within the inheriting theory.  This is a very good idea!

A related issue is to deal systematically with any remaining
awkwardnesses with the theory module system (as with "forget").

3.  Memory management for the term type.  This should have no effect
at all on behavior of the prover, but might conceivably have a
dramatic effect on performance (as in the GoL example, where automated
proof is attempted)!  Ideas from the Portland conference are relevant
here.  Memory sharing, delaying substitution are the issues.  The idea
of tagging terms with their free variables (probably with both their
free and their bound variables in Watson) is nice.

*)

(* Oct. 25:

thinking about upgrading the "type system".  No code changes as
yet.

First idea:  upgrade the stratification function so that it reports
types for well-typed variables even when problems exist for other
variables.  This would allow implementation of s.c. separation.

Some optimization of stratification functions (as in crushtypes).

Also optimized merge.  The non-optimized version of merge might have
been wasting quite a lot of cycles?

A way to achieve s.c. separation:  the idea is to avoid assigning types
to any bound variables higher in type than the binding variable in a function;
if one does this and gets "shiftable" type for the local bound variable,
then s.c. separation should apply?  Note that failures of opacity should
still be a problem.

The previous idea seems not to work too well?  It depends.  It seems
that if a term T is stratified wrt ?1 (ignoring types of all variables
above ?1) and has "floating" type for ?1, that the whole expression
will be typable?  Operations that would allow sabotage of this would
seem to be opaque (unstratified recursions, for example).  But this
does require some proof.  If it works, then it is fairly easy to
implement s.c. separation without any extension of type inference.
Another query: can we really tell using strat whether ?1 is in an
s.c. domain?  This query also applies to the implemented technique for
stratifying types.  The fact that we eliminate single typed variables
when they are "floated" might be challenged?  Of course, the
"floating" of a single typed variable might be regarded as putting it
through a type filter?  I see problems with this: images of typable
sets under the formation of unstratified abstractions are apt to be
problematic?  In fact, this criterion would allow one to form the
function taking x to (lambda y.y(y)+Nat:x); this is clearly
problematic (though it is not altogether clear that it really causes a
problem; we still can't apply these functions).

*)


(* Sept 11:

The built in tactic #! has been installed, which causes the prover
to remember the particular case of the rewrite being applied, so that
it can apply it in one step if it is encountered later.  This allows
very efficient computation of recursively defined functions.

A tricky point is that reverse application of #! format will allow
reverse application of the stored rewrite rule; new effects can
be produced by doing this (tactics can be applied in reverse!)

#! is disabled in steps.  Since different saved rewrite rules
may be available in different branches of case expressions, it seems
that there isn't any way to enable #! for steps; #! is incompatible
with the parallelism in steps.

Do I want to allow saved rewrites at level 0 to persist?
In this case, they should be stored in theory structures.
For the moment, keep them internal to execute and steps.

Internally, the =>> and <<= tactics have been rewritten so that
they will behave sensibly with the UP and #! tactics (and
any other tactics whose behavior is mediated by execute instead
of thmresult).  They will also exhibit more fine-grained behavior
in relation to steps.  The same modification has been carried out for
*> and <*.  Something similar may need to be done with the functional
programming feature?  (only if complex programs are to be allowed
will this be needed).

Can saved rewrites be registered by level+hlevel?  I think so...

Safest version:  use an operator # to signal intention to register
a rewrite (# format executes format if it finds no registered
rewrite, and otherwise uses the registered rewrite).  Registered
rewrites are remembered only in the environment where they are
registered.

I'm erasing earlier comments about the tactic module system and
summarizing.

The tactic module system allows tactics to be "hidden" in modules
associated with other theorems.  The intention is to keep 
components of recursively defined tactics off the main theorem
list; there are other possible applications.

User commands:

Push name1 name2:  put theorem name1 in module associated with theorem name2.
name1 cannot equal name2; name1 cannot be a pure equation (it must either
have parameters or involve embedded theorem applications).  Other theorems
using name1 may automatically be Pushed into the module.

Open name:  open the module associated with name.  This means that
theorems in the module will appear (temporarily) on the main theorem
list.

Close name:  close the module associated with name.  This may force
any new theorems depending on theorems into the module into the module.

CloseAll():  close all modules.  This command is automatically invoked
by steps(), ex(), and prove, and possibly by other commands as well.

PopModule name:  unpack the module associated with the theorem name,
returning the theorems to the same level of visibility as name.

It is possible to nest modules, but the rules for this are rather
restrictive.  There is no way to take theorems out of a module 
individually.

Note issue of using blocking elements to prevent reappearance of
old material when material in the current theory is deleted.

New theorysize() user command reports number of theorems.

The ability to display modules is wanted.  New command showmodule
does this.  The theorem display command issues a message when a theorem
has an associated module.

showscout and showscin user commands (to view scin/scout information).

*)

(*

Sept. 5:  

The prover now automatically declares undeclared operator variables as
opaque infix or prefix operators as appropriate.  This may require changes
(as it did in structural.wat) if an operator has been used without a
declaration and later declared.  The reason for this change is that the
prover could have been crashed by using an operator variable implicitly
as an infix then later typing it explicitly as a prefix.  Now the earlier
use as an infix will cause an automatic declaration.

New command tacticdisplay displays tactics with argument lists;
it checks for well-formedness of argument lists and makes substitutions
into theorems as the argument lists require.  This could be used
by the GUI to extract arguments for ri from the equation window.
There might be places in the existing code where 

Modified treatment of ill-formed case expressions (it produces a well-formed
term).  Reviewed all error messages for conversion to nopausemessage.
In general, display commands should now not set the error flag!


ideas, not code changes:

Idea of storing "absolute theorems", which contain all information
about the axioms, definitions, and scin/scout theorems they need.
"Absolute theorems" might make theorem export easier.

re modularity: Note that a list of modules (list of theorem lists
labelled by theorem names) will work just as well, and involve no
changes at all to existing data types.  Opening a module = (weakly)
copying theorems to the head of the theorem list; closing a module =
(strongly) copying them back from the theorem list (not just erasing
them!).  In this way, we can edit theorems inside modules in a secure
way.  None of this will involve any modification of the existing data
types.  Nested modules will work just fine with this format.

I like the idea of referring to objects applicable with @! as
"contexts", and objects applicable with @ as "functions".
I should write an update for the online documentation (an appendix
to the submitted paper) discussing context abstraction and application,
and quoting the theorems (it should discuss the solution to the
existential quantification problem as well as the results of the Portland
paper).

add a connective (say :=:) such that T :=: U denotes both T and U.
A term of the form T :=: U cannot be freely constructed:  it must be
introduced as T :=: T (to avoid the formation of such horrors as
true :=: false).  There might be alternative approaches?  For example,
it might be safe to even introduce such terms as long as they were
never copied (so that two different copies were collapsed in different
ways).  But this would complicate matters at a deeper level than the
other solution.  Is there a general solution using case expressions to
the problem that leads to this (needing to transform a term to a different
form but wanting to recover the equality between the two forms quickly)?
The semantics are that T :=: U is well-formed (in a context) just in
case T and U are interchangeable in that context.

:=: amounts to recording a local theorem; perhaps the right way to use
it is as the hypothesis of a case expression?  Perhaps T :=: U should
be equal to "true", not to T, and usable as a case expression
hypothesis.  It can only be introduced by a variation of REFLEX and
can only be eliminated by conversion to = (after which it can be
applied as hypothesis of a case expression?).  Controlling theorems:
?x = (?y:=:?y)||?x,?z, ?x:=:?y = true (not reversible!) , prover
restriction that :=: cannot appear in a starting expression (and can't
be introduced by assignment or as new material introduced by a
theorem), and privileges for ?x:=:?y as hypothesis of a case
expression.

Direct support for cases in pattern matching:  an idea is to allow
theorems of the form T,U = V,W to be applied to prove T = V and
U = W as well as the obvious...

Further thoughts about how to cope with the @! operator.  Could it
be the application of untyped lambda-calculus, always automatically
evaluated?  This would mean that we would have to deal with the
possibility of terms like ?f @! ?x being undefined (partial functions).
Evaluation of the Curry paradox term would present no problems, precisely
because it would crash!

Alternatively, is there a tidier way to deal with the current solution
(which amounts to excluding @! from contexts, except in terms ?P@!?x@!?y...
(left grouped) in which ?P must eliminate all the @!'s (it must be
sufficiently bracketed).  What I don't like is the implicit typing
of ?P and the resulting restriction on assignment; in some sense this is
unavoidable, but I'd like to get a neater justification for it?

Is there a way to eliminate term formation restrictions (as we did for
@ when @! was introduced) and have the work done entirely by restrictions
on application of EVALM, BINDM?

But in fact there is a great deal to be said for strong restrictions on
@!, which is a very dangerous connective!

*)

(*

Sept. 1:  I need to modify the stratification function so that it
only accepts bindings into type labels when there is no nontrivial
type information therein (all bound variables are restricted to s.c.
types).DONE and tested on omnibus.

The reason is that I would like to adopt a logical axiom to the effect
that f(x) = f:x whenever f is a retraction with s.c. domain, and this
is incompatible with the existence of most functions binding into type
labels.  This will also impact the type definition facility (I'm not
sure how) though it will also essentially make that facility obsolete
(no, it doesn't!).  The new axiom is only possible to state because we
now have unstratified quantification.

The axiom can be written elegantly as

[?T@(?T@?1)] = [?T@?1] & [[?T@?1]] = [[[?T@?2]]@?1] -> [?T@?1] = [?T:?1]

My guess is that there is no effect on the type definition command,
and that that command will remain useful.  The new viewpoint still
probably requires that the general arrow type constructor (for
example) be an opaque operator, though it allows the definition of
non-opaque restrictions of the arrow type constructor by other means.
Though it does seem that any abstraction into a type label with
a constructor is actually safe (where the embedded abstraction into
the type built with the constructor might not be).

Under the old stratification rules,

[[?1@?2]=[?1:?2]] would be stratified, defining the _set_ of functions
?f equivalent as functions and as type labels, which could then be proved
not to coincide with the retractions with s.c. domain.

How about "Sigma_2 Replacement"?  This would require a change in the
structure of the stratification function, since subterms of allowed
terms may turn out to be unstratified.

Sigma_2 replacement comes in with the upgrade to a true polymorphic
type system.  It would come in if we kept type information even when
stratification fails -- some variables would be typed as "bad"
in the course of stratification, but the type information about
others would be kept.  This approach would make the implementation
of Sigma_2 replacement possible.  (what is wanted is the ability to
stratify any class function with s.c. domain and range).

Also, matchtri and amtri will now display the proposed theorem.

*)

(* August 31:

error messages now raise a flag which prevents proofs; this flag
is reset by the start command (and by derived commands like startover,
starthere).  It is also reset by a new clearerrorflag() user command.

This is a seemingly minor feature which should protect one against
the effects of overeager drag-and-drop proofs (since these carry on
through error messages without stopping).

It seems that only the prove command needs to look at this flag, and
it is sufficient to have the start family of commands set it.  Experience
will tell us whether it is too finicky!  It does mean that proofs by
hand will need to be started over whenever an error message is raised.
I added a clearerrorflag() user command which will also clear the
error flag.

Another improvement:  files with the iri "theorem";; format
for talking to the INPUT command now work as scripts. But
the format is still quite rigid:  the iri lines need to appear
one to a line with no intervening commands.  So scripts are
still much more limited than top-level dialogue at the INPUT
prompt.  Still, this makes it easier to edit interactively developed
INPUT files to scripts, and it means that scripts can be written to
run interactively as well.

*)


(* August 20:

UP tactic has been tested and appears to work.

Version now has the UP tactic installed!  Complete installation
but not much testing.  Oddly, competing UP tactics are executed
from the back of the term.

For the moment, I think that UP tactics at top level should
be left hanging; one might want to go up and execute again,
and the droprule command exists.

Notes made on laptop after TPHOLs:

3 corrections to file made during conference.  Hypothesis display
added a return for the sake of the interface.  I changed the pause
message to Watson:  Paused, again for the sake of the interface.
Finally, I fixed an actual bug in the "functional programming"
feature:  the program attempted to execute constant names
rather than their associated programs.

As an immediate upgrade, I project the UP built-in tactic.

*)

(* August 10:

corrects an oversight re the INPUT command:  the display will now
tell you if the theorem supplied to INPUT is being applied in the
converse sense.  I don't know if anyone will ever use this, but it
should be there.

changed "errormessage" in envname() to "nopausemessage" -- probably
fixed problem with demo scripts?

The SHELL built-in tactic has been disabled, since it is now
redundant.  One still might like it in guimode, but guimode is
deprecated anyway...

Is it a good idea to display a theorem whenever it is introduced
by a ruleintro command, for purposes of the interface?DONE for matchtri,
amtri.

I have set up tabular displays so that they are captured in the equation
window, and messages so that they are appended to the local term window.
I think that essentially all Watson output is now captured in one of
the special windows in the GUI, though some only gets "flashed".

*)





(* June 19:  added defaultprecsame command, which sets default precedence
to be the same as that of an existing operator, completing the suite
of "relative" precedence commands *)


(* June 16: planning an upgrade to precedence setting, allowing
precedences to be set relative to precedences of existing operators,
without any reference to numbers. 

new commands

sameprec
leftprecabove
rightprecabove
leftprecbelow
rightprecbelow

Each command takes two arguments, the first being an operator
to be assigned precedence, and the second being an operator which
presumably already has precedence.  The new precedence is set to be
the same, inserted just above, or inserted just below the old
precedence, and set to group left or right as appropriate.

*)

(* June 15 note (no change):  For easy use of precedences, there should
be a device for "inserting" precedences -- give an operator a certain
precedence and raise the precedence of all operators with precedence 
higher than that by one.  An idea:  don't use numbers at all!
Define precedence as "same as ^+" (a simple assignment), "just above
^+" (an insertion) or "just below ^+" (another kind of insertion).
This should make for a much more natural approach!  (the showprecedences
command can then be used to look at the resulting order of precedence).

New "verify" command added.  Also new "showdef" command.

*)

(* June 15:  updated documentation again.  Added new commands showdef
(which displays the defining theorem, if any, of a constant or operator)
and verify (which can be used in scripts to check that theorems are
proved correctly). *)


(* Apr. 27-8:  I regard the higher-order matching upgrades as now complete,
barring discovery of bugs.

The next issue is adding security to incremental theory saving to file
and desktop by enforcing a tree-like structure of dependency between
theories.  The simplest technique is to maintain a registry of precursor lists
of theories, and prevent a theory name from being assigned if the list
of precursor theories (SCRIPTS) is not appropriate.

A registry of theory dependencies is now maintained and checked.
I do not know whether it works.

I think that the current registry scheme is secure against at least
the most obvious kinds of abuse of mutual calls of theory files; it enforces
a sensible tree structure.

There is a new user command droptheory; droptheory s will delete theory
s and every theory which depends on it from the desktop.

A nice addition would be the ability to load a theory file with a different
name than the file name?  Same for scripts.


*)

(* Apr. 19:

a change in the treatment of formats which may make higher-order
matching more powerful.  The match of formats is used to make substitutions
into the theorem to be used before it is applied.  This should make it
possible to implement BIND, for example.  The change is strictly
confined to the function USE.

Further refinements will be needed.  The match that will allow user
implementation of UNEVAL will also allow elimination of possible unexpected
behavior of the new approach to format matching.  Also, @! should be
made more like @ in higher order matching (but no need to support the
pair).

*)

(* Mar. 3:

mod minor difficulties, the segmented desktop and save file system
now seems to work.

Invariants:  the first element of the SCRIPTS list should always be
the current theory.  the second element of the SCRIPTS list should
always be the theory to be loaded just before the current theory.
The hierarchy of "modules" is still strictly linear, though I have
some ideas how this might be changed.

The file sizes are _dramatically_ smaller.  On the other hand,
one needs .sav.wat files for all precursors of a theory to load it;
this is a new situation.  Maybe the old load command could be preserved?

It is quite likely that there will be other peculiar problems.

*)

(* June 28:  This has been tested with SML 96.  The only problem
in building it is that the Io x exception in noml doesn't work; 
use IO.Io instead.

It appears that SML96 is perfectly happy with the Moscow ML source--
except for the same problem with the Io exception.  What is the I/O
exception type for SML 96?

Stuff about exportML:


      exportML, heap image files, @SMLload command line parameter 

            Question: Calling the function exportML, as in 

            - SMLofNJ.exportML "image";

            creates a file called "image.mipseb-irix" that is not executable,
            while with SML/NJ 93 I would get an executable file called
            "image". I wonder if I am doing the export correctly or if there is a
            new procedure for using the exported image? 

            Answer: The file "image.mipseb-irix" is a heap image -- not an
            executable. You can load it as follows: 

            % sml @SMLload=image

            Note that you do not need to specify the ".mipseb-irix" suffix
            when specifying the image file, it will be inferred. 

*)


(* June 16:  very slight refinement of comments in INPUT text
In the June 15 version, either { or } started a comment to the end
of the line; now it is only { which starts a comment, which will
go either to the end of the line or to a }.  A } acts like an
end of line and could be used to put more than one input on the
same line.

changes to script, reset and demo


*)

(* comment these out for SML 93 *)

(* SML 96 Conversion functions *)

(* load "Int"; *)

(* val load = load; *)

val std_in = TextIO.stdIn;
val std_out = TextIO.stdOut;
fun output (out, msg) = TextIO.output(out,msg);
fun input (inp, n) = TextIO.inputN(inp,n);

fun makestring(value) = Int.toString(value);
fun explode (s) = (List.map str (String.explode s));
fun implode (ls) = String.concat ls;
fun max(n1,n2) = Int.max(n1,n2);

fun open_out(s) = TextIO.openOut(s);
fun close_out(s) = TextIO.closeOut(s);
fun flush_Out(s) = TextIO.flushOut(s);

fun open_in(s) = TextIO.openIn(s);
fun close_in(s) = TextIO.closeIn(s);

fun flush_Out(s) = TextIO.flushOut(s);

fun substring s = String.substring(s);

(* fun exit() = OS.Process.exit(OS.Process.success); *)
(* fun abort() = OS.Process.exit(OS.Process.failure); *)

(* END SML 96 Conversion functions *)

(* used for SML 93 compatibility *)

(* fun flush_Out s = (); *)


(* Error message function with pause control functions *)

val ERRORPAUSE = ref false;

fun setpause() = ERRORPAUSE := true;

fun setnopause() = ERRORPAUSE := false;

exception Breakout;

val Returns = ref("\n\n");

fun compress() = Returns := "\n";

fun expand() = Returns := "\n\n";



(* due to the needs of the GUI, the error message command
raises an exception rather than pausing (and so waiting for
input that the GUI can't handle) *)

val ERRORFLAG = ref false;

fun clearerrorflag() = ERRORFLAG:=false;

fun errormessage s = (output(std_out,(!Returns)^"Watson:  "^s^(!Returns));
			flush_Out(std_out);ERRORFLAG:=true;
                        if (!ERRORPAUSE) then raise Breakout
                        else ());

(* this command is used for merely informative messages
that should not interrupt script execution *)

fun nopausemessage s = (output(std_out,(!Returns)^"Watson:  "^s^(!Returns));
			flush_Out(std_out));


(* this toggle tells the prover to use the new method of handling
INPUT at top level -- but the old method is available *)

(* It may eventually be used to turn off some other changes used by
the GUI.  In general, turning GUI mode off is deprecated,
and it is not guaranteed to restore previous behavior in all respects. *)

val GUIMODE = ref true;

fun guimode() = (GUIMODE := not(!GUIMODE);nopausemessage 
("GUI mode is "^(if (!GUIMODE) then "on" else "off")));


(* verbosity of output *)

val VERBOSITY = ref 2;

fun bequiet() = VERBOSITY := 0; 

fun thmsonly() = VERBOSITY := 1;

fun speakup() = VERBOSITY := 2;

(* version command *)

fun versiondate() = nopausemessage 
     "March 1, 2001 (first-order, segmented, for GUI)";

(* container classes *)

(* Watson requires two kinds of container classes, finite sets and
finite functions.  These were implemented as balanced binary trees in
Mark2.  In this design, they are implemented in a very simple way as
lists.  There doesn't seem to be any deficit in performance. *)

(* all operations attempt to maintain the invariant that any
set or function element appears no more than once *)

(* sets *)

(* a set of objects of a given type is simply a list of objects of
that type *)

(* is an object x found in a given set? *)

fun foundinset x nil = false |

	foundinset x (a::rest) = if x = a then true else foundinset x rest;

(* add x to a given set *)

fun addtoset x L = if foundinset x L then L else (x::L);

(* drop x from given set *)

fun dropfromset x nil = nil |

	dropfromset x (a::rest) = if x = a then rest 
	else (a::(dropfromset x rest));

(* union of sets *)

fun union nil nil = nil |

        union nil L = union L nil |

	union (a::L) M = a::(union (dropfromset a L) (dropfromset a M));

(* faster, less safe old form:

fun union nil L = L |
union (a::L) M = a::(union L (dropfromset a M));


*)

fun union2 nil = nil |

	union2 (L::M) = union L (union2 M);

fun intersection nil L = nil |

	intersection (a::L) M = if foundinset a M

		then a::(intersection L M)

		else intersection L M;

(* subset relation *)

fun subset nil L = true |

	subset (a::L) M = (foundinset a M) andalso (subset L M);

(* the subset of a list of which the predicate f is true *)

fun separate f nil = nil |

	separate f (a::L) = if (f a) then (a::(separate f L))
	else separate f L;

(* suppose one only wants to find one object for which f is true... *)

fun separate2 f nil = nil |

	separate2 f (a::L) = if (f a) then [a] else separate2 f L;

fun restriction L f = separate (fn (x,y) => foundinset x L) f;


fun setminus a b = separate (fn x=>not(foundinset x b)) a;

(* sorting a set *)

fun sortsetput (s:string) nil = [s] |

	sortsetput (s:string) (a::L) = if s < a then (s::(a::L))
		else (a::(sortsetput s L));

fun sortset nil = nil |

	sortset (a::L) = sortsetput a (sortset L);

(* functions *)

(* find an object in the list associated with key s; return a one-element
list of the found object if it is found, otherwise nil *)

fun find s nil = nil |

	find s ((t,x)::rest) = if s = t then [x] else find s rest;

(* a safe version of find which gives the object found and a default
when there is no such object *)

fun safefind default s L = let val A = find s L in 
			if A = nil then default else (hd A) end;


(* is there an object with key s in L? *)

(* changed so that lists of things not of equality types can be handled *)

(* fun foundin s L = find s L <> nil; *)

fun foundin s L = length(find s L) > 0;

(* drop item with given key *)

fun drop s nil = nil |

	drop s ((t,x)::L) = if s = t then L else ((t,x)::(drop s L));

(* an optimization, perhaps; it brings the found item to the front
of the list.  this version of find is used inside the thmresult
function below. *)

fun Find s reference = let val A = find s (!reference) in
	if A = nil then nil
	else (reference:=((s,hd A)::drop s (!reference));A) end;

fun Safefind default s reference = let val A = Find s reference in
		if A = nil then default else (hd A) end;

fun Foundin s L = Find s L <> nil;

(* add item with given key; the first will not overwrite and the
second will *)

fun addto s x L = if foundin s L then L else ((s,x)::L);

fun strongadd s x L = addto s x (drop s L);

(* this is the union operation for the theory segments construction;
keys in the second file override keys found in the first. *)

fun strongunion nil L = L |

	strongunion L nil = L |

	strongunion ((s,x)::L) ((t,y)::M) = strongadd t y(
	addto s x(strongunion L M));

(* this is the difference operation for the theory segments construction *)

fun strongdiff L nil = L |
	strongdiff nil M = nil |
	strongdiff ((s,x)::L) M =
		let val FOUND = find s M in
			if FOUND = nil then ((s,x)::strongdiff L M)
			else if (hd FOUND) = x then strongdiff L M
			else ((s,x)::strongdiff L M)
		end;
	            

(* is a list of pairs a function? *)

fun isfun nil = true |

	isfun ((s,x)::L) = let val A = find s L in 
			if A = nil orelse A = [x]
				then isfun L
				else false end;

(* merge function used with match lists; it returns nil as an
error object, and packages resultant lists in a unit list *)

fun merge L M = 

let val U = union L M in

if isfun U then [U] else nil end;

(* sorting a function *)

fun sortfunput (s:string,x) nil = [(s,x)] |

	sortfunput (s:string,x) ((a,y)::L) = if s < a then ((s,x)::((a,y)::L))
		else ((a,y)::(sortfunput(s:string,x) L));

(* this is an update function like strongadd which maintains sortedness *)

fun sortfunput2 (s:string) x nil = [(s,x)] |

	sortfunput2 (s:string) x ((a,y)::L) = if s < a then ((s,x)::((a,y)::L))
                else if s = a then ((s,x)::L)
		else ((a,y)::(sortfunput2 s x L));


fun sortfun nil = nil |

	sortfun (a::L) = sortfunput a (sortfun L);


(* The primary objects manipulated by Mark2 are terms; the
manipulations allowed are algebraic.  Atomic terms in Mark2 are of
three kinds, constants (which must be declared), free and bound
variables.  Composite terms are of three kinds: terms constructed
using binary infix operators (which must be declared; though there is
a provision for variable infixes), function terms, and terms defined
by cases.  Unary operators are also supported, but they are
coded as binary operators as will be seen below.  *)

(* the separate clauses for reserved identifiers and for case
expressions are a new idea *)

(* term data type declaration *)

(* type of infix operators *)

datatype operator =

	ConOp of string |
	VarOp of string |
	ResOp of string |  (* reserved operator *)
	ParOp of string;   (* an internal device *)

datatype term = 

	(* atomic terms *)
	
	Constant of string |
	Numeral of int list |  (* Mark2 has built in arithmetic *)
	FreeVar of string |
        BoundVar of int |

	(* composite terms *)
	
	Infix of term*operator*term |
	Function of term |
	CaseExp of term*term*term |
	Parenthesis of term (* Parenthesis is a special construction
			used internally for various purposes *) |
        Reference of term (* reference terms might also contain
        some additional data, telling something about the term
        referenced -- a bit to tell whether term is rulefree,
        for example *)

        ;

	

(* There are some differences between the surface form of Mark2 terms
(as displayed and understood by a user) and the "deep structure" exhibited
in the type declaration above.  There are also some notational points
not capable of being made in this format.

All atomic terms are represented by strings made of alphanumeric characters
plus the special characters "?" and "_".

The empty string does not represent a constant; Constant "" is used 
internally as an error object.

Strings made up entirely of digits stand for numerals.  They are stored
as lists of digits (in reverse order).  The built in arithmetic of Mark2 is
unlimited precision arithmetic of non-negative integers.

Strings made up of the special character "?" followed by a non-zero-initial
numeral represent bound variables.

Strings which begin with "?" and do not represent bound variables are 
used to represent free variables.

Strings which do not represent any of the above represent constants.
Unlike the three other sorts of atomic term, constants need to be declared
by the user.

We now consider terms defined using operators.  This includes the case
of unary prefix operators, which are in fact supported by Mark2, though
this is not reflected in the data type.  An infix which has been declared
may be used as a prefix operator if a declaration has been made which
assigns to that infix a default left argument; when the operator is
used as a prefix, an invisible left argument is present, equal to the
default; moreover, when a term is entered in binary form whose left
term happens to be the default left argument for its infix, the prover
will display it in unary form.

Operators are represented by nonempty strings made up entirely of special 
characters other than 
the two special characters allowed in atomic terms.

Operators of more than one character beginning with "^" are operator
variables.

All other operators are constant operators and must be declared.

A final refinement: an operator may actually end with alphanumerics:
it consists of (zero or more) special characters possibly followed by
a suffix consisting of one backquote "`" followed by zero or more
alphanumerics, with the length of the whole being nonzero.

Function terms are of the form [term]; a term enclosed in brackets is
a function term.  The appearance of bound variables is restricted to
appropriate function terms; the bound variable ?n may only appear in a
context within at least n nested brackets.

Case expression terms take the surface form ?x || ?y , ?z
This causes some peculiarities because the apparent subterm ?y , ?z
does not correspond to any actual term.  This is handled differently
in the current version of Mark2, but a related problem occurs.

*)

(* we now give code for functions which retrieve the first token of
a given kind (atomic term or operator) from a list of characters; it
has a companion function which returns the rest of the string *)

(* the tokenizer does not consult the declaration lists, but it
does recognize reserved constants and operators *)

(* the list of reserved operators *)

val RESERVED = ref([("bogus",(0,0))]);

(* RESERVED := nil; *)

fun isreserved x = foundin x (!RESERVED);


(* kinds of character *)

fun iscap x = x = "A" orelse x= "B" orelse x = "C" orelse x = "D"
	orelse x = "E" orelse x = "F" orelse x = "G" orelse x = "H"
	orelse x = "I" orelse x = "J" orelse x = "K" orelse x = "L"
	orelse x = "M" orelse x = "N" orelse x = "O" orelse x = "P"
	orelse x = "Q" orelse x = "R" orelse x = "S" orelse x = "T"
	orelse x = "U" orelse x = "V" orelse x = "W" orelse x = "X"
	orelse x = "Y" orelse x = "Z";

fun islowercase x = x = "a" orelse x= "b" orelse x = "c" orelse x = "d"
	orelse x = "e" orelse x = "f" orelse x = "g" orelse x = "h"
	orelse x = "i" orelse x = "j" orelse x = "k" orelse x = "l"
	orelse x = "m" orelse x = "n" orelse x = "o" orelse x = "p"
	orelse x = "q" orelse x = "r" orelse x = "s" orelse x = "t"
	orelse x = "u" orelse x = "v" orelse x = "w" orelse x = "x"
	orelse x = "y" orelse x = "z";

fun isspecial x = x = "!" orelse x = "@" orelse x = "#" orelse x = "$"
	orelse x = "%" orelse x = "^" orelse x = "&" orelse x = "*"
	orelse x = "=" orelse x = "+" orelse x = "-" orelse x = "<"
	orelse x = ">" orelse x = "/" orelse x = "," orelse x = ";"
	orelse x = "." orelse x = ":" orelse x = "~"
	orelse x = "|";

fun isdigit x = x = "0" orelse x = "1" orelse x = "2" orelse x = "3"
orelse x = "4" orelse x = "5" orelse x = "6" orelse x = "7"orelse x = "8" 
orelse x = "9";

(* remove whitespace *)

fun strip nil = nil |

	strip (" "::L) = strip L |
	strip ("\n"::L) = strip L |
	strip ("\t"::L) = strip L |
	strip L = L;

fun isalpha x = iscap x orelse islowercase x orelse isdigit x
	orelse x = "?" orelse x = "_";

(* get desired characters from a list of characters *)

fun getalpha nil = nil |
	getalpha (a::L) = if isalpha a then a::(getalpha L) else nil

and restalpha nil = nil |
	restalpha (a::L) = if isalpha a then restalpha L else (a::L);

fun getnumeral nil = nil |
	getnumeral (a::L) = if isdigit a then a::(getnumeral L) else nil

and restnumeral nil = nil |
	restnumeral (a::L) = if isdigit a then restnumeral L else (a::L);


fun getspecial nil = nil |

getspecial (a::L) = if isspecial a then (a::(getspecial L)) else 
	if a = "`" then (a::(getalpha L))
	else nil
and restspecial nil = nil |
	restspecial (a::L) = if isspecial a then restspecial L 
	else if a = "`" then restalpha L
	else (a::L);

(* integer character value *)

fun numvalue "0" = 0 |
	numvalue "1" = 1 |
	numvalue "2" = 2 |
	numvalue "3" = 3 |
	numvalue "4" = 4 |
	numvalue "5" = 5 |
	numvalue "6" = 6 |
	numvalue "7" = 7 |
	numvalue "8" = 8 |
	numvalue "9" = 9 |
	numvalue x = ~1;

(* fun evalnum nil = 0 |

	evalnum ("0"::L) = 0 + 10*(evalnum L) |
	evalnum ("1"::L) = 1 + 10*(evalnum L) |
	evalnum ("2"::L) = 2 + 10*(evalnum L) |
	evalnum ("3"::L) = 3 + 10*(evalnum L) |
	evalnum ("4"::L) = 4 + 10*(evalnum L) |
	evalnum ("5"::L) = 5 + 10*(evalnum L) |
	evalnum ("6"::L) = 6 + 10*(evalnum L) |
	evalnum ("7"::L) = 7 + 10*(evalnum L) |
	evalnum ("8"::L) = 8 + 10*(evalnum L) |
	evalnum ("9"::L) = 9 + 10*(evalnum L) |
	evalnum x = ~1; *)

fun evalnum nil = 0 |

	evalnum (x::L) = if isdigit x 
	then let val A = evalnum L in
	if A = ~1 then ~1 else (numvalue x) + (10*A)
	end 
	else ~1;

fun listtoint nil = 0 |

	listtoint (n::L) = n + 10*(listtoint L);

(* strips unwanted zeroes off fronts of numerals *)

fun stripzeroes nil = (0::nil) |

	stripzeroes (0::nil) = 0::nil |

	stripzeroes (0::L) = stripzeroes L |

	stripzeroes L = L;

(* strips unwanted zeroes off ends of reversed lists of digits
(our internal representation of integers) *)

fun stripzeroes2 L = rev(stripzeroes(rev L));


(* functions which extract the first atom represented in a list
of characters and return the rest of the list *)


fun prefirstatom s = let val A = getnumeral  s and B = getalpha s in

		if A <> nil andalso A = B then 
			Numeral (rev (stripzeroes(map numvalue A)))

		else 

		if B<>nil then 

			if hd B = "?" then

				let val C = getnumeral (tl B) in

				if C <> nil andalso C = tl B

				then BoundVar (evalnum (rev C)) 

				else FreeVar (implode B) end

			else Constant (implode B)

		else Constant "" end  (* conventional error value *)

and prerestfirstatom s  = let val A = getnumeral s and B = getalpha s in

		if A <> nil andalso A = B then restnumeral s

		else

		if B<>nil then restalpha s

		else s end   (* conventional error value *)

(* this function returns the first atomic term in the string s,
if any.  A locution like "stringtocon s = FreeVar s" asks whether
s is a free variable; in the case of constants, one also needs to
stipulate that s is not "" *)

fun stringtocon s = prefirstatom (strip (explode s));

fun firstatom s = prefirstatom (strip s);

fun restfirstatom s = prerestfirstatom (strip s);

(* functions for getting the first operator from a list of characters
and the rest of the list *)

fun prefirstop s = let val A = getspecial s in

			if A = nil then ConOp "" (* error value *)

			else if hd A = "^" andalso tl A <> nil

				then VarOp (implode A)

			else if isreserved (implode A)

				then ResOp (implode A)

				else ConOp (implode A)

			end;

(* this function gets the first operator from a string; see comments under
stringtocon *)

fun stringtoop s = prefirstop (strip (explode s));

fun firstop s = prefirstop (strip s);

fun restfirstop s = restspecial (strip s);

(* cleans up parentheses -- appears here because stringtoop is needed *)

fun deparenthesize1 (Parenthesis t) = t |

	deparenthesize1 t = t;

fun deparenthesize (Parenthesis t) = deparenthesize t |
	deparenthesize (Function s) = Function(deparenthesize s) |
	deparenthesize (Infix(x,ParOp s,y)) =Infix(deparenthesize x,
					stringtoop s,
					deparenthesize y) |
	deparenthesize (Infix(x,i,y)) = Infix(deparenthesize x,i,
					deparenthesize y) |
	deparenthesize (CaseExp(u,v,w)) = CaseExp(deparenthesize u,
					deparenthesize v,deparenthesize w) |
	deparenthesize t = t;


(* We now construct a family of functions culminating in the parser.
In this version, we do not allow user declared precedence, which is
found in the full implementation; most users have been content with
the APL precedence (all operators have same precedence, all operators
group to the right) which is the default in the full implementation *)

(* We begin with the declaration lists (needed by the display function
to handle prefix operators, as well as by the parser), follow with the
display functions, and conclude with the parser *)

(* the constant declaration list *)

val CONSTANTS = ref(["bogus"]);

fun isaconstant s = (stringtocon s = 
	Numeral (rev(stripzeroes(map (numvalue) (explode s)))))
	orelse foundinset s (!CONSTANTS);

(* USER COMMAND *)

fun declareconstant s = if s <> "" andalso stringtocon s = Constant s

	then if foundinset s (!CONSTANTS)

		then errormessage ("Constant "^s^" already declared")

		else CONSTANTS:=addtoset s (!CONSTANTS)

	else errormessage ("Ill-formed constant "^s^" cannot be declared");

(* operator declarations *)

(* operators require integer "left type" and "right type" parameters for
the stratification function *)


val OPERATORS = ref([("bogus",(1,2))]);

(*

(* declarations of operators declared with s.c. types *)

val OPERATORTYPES = ref([("bogus",("bogus","bogus","bogus"))]);

val _ = OPERATORTYPES:=nil;

*)

fun isoperator s = if stringtoop s = VarOp s then true

	else if stringtoop s = ResOp s then true

	else if s <> "" andalso stringtoop s = ConOp s then

		if foundin s (!OPERATORS) then true

		else false

	else false;


val defaultop = (0,0);

fun opof s = if (stringtoop s) = ResOp s then safefind defaultop s (!RESERVED)
		else safefind defaultop s (!OPERATORS);

fun lefttype s = (fn (a,b) => a) (opof s);
fun righttype s = (fn (a,b) => b) (opof s);

(*

val defaultoptype = ("","","");

fun optypeof s  = safefind defaultoptype s (!OPERATORTYPES);

fun topsctype s = (fn (a,b,c) => a) (optypeof s);
fun leftsctype s = (fn (a,b,c) => b) (optypeof s);
fun rightsctype s = (fn (a,b,c) => c) (optypeof s);

*)

(* It is permissible to declare variable operators in order 
to record their type information *)

(* in fact, it is now mandatory that they be declared; undeclared
variable operators are automatically declared as opaque *)

(* USER COMMAND *)

fun declaretypedinfix m n s = if stringtoop s = ResOp s

	then errormessage ("Reserved operator "^s^" cannot be redeclared")

	else if stringtoop s = VarOp s 

	then if foundin s (!OPERATORS) 

		then errormessage 
	("Variable operator "^s^" has already been typed")

		else OPERATORS:=
		addto s (m,n)(!OPERATORS)

	else if s <> "" andalso stringtoop s = ConOp s

		then  if foundin s (!OPERATORS)

		then errormessage ("Operator "^s^" has already been declared")

		else OPERATORS:=
		addto s (m,n) (!OPERATORS)

	else errormessage ("Ill-formed operator "^s^" cannot be declared");

(*

(* function for declaring operators with explicit s.c. types *)

(* output type followed by left, right input types *)

(* it accepts numerals for polymorphically typed arguments *)

fun declarescinfix a b c s = if stringtoop s = ResOp s

	then errormessage ("Reserved operator "^s^" cannot be redeclared")

        else if stringtoop s = VarOp s 

        then errormessage ("Variable operators with sc types not supported")

        else  if s <> "" andalso stringtoop s = ConOp s

        then if foundin s (!OPERATORS)

        then errormessage ("Operator "^s^" has already been declared")

        else  if ((not (isaconstant a)) orelse (not (isaconstant b))
             orelse (not (isaconstant c)))
        then errormessage ("Incorrect types for proposed operator")
        else

        let val A = evalnum(rev(explode a))
        and B = evalnum(rev(explode b))
        and C = evalnum(rev(explode c)) in

        (OPERATORTYPES:= addto s ((if A = ~1 then a else ""),
                                  (if B = ~1 then b else ""),
                                  (if C = ~1 then c else "")) (!OPERATORTYPES);
         declaretypedinfix
         ((if B = ~1 then 0 else B) - (if A = ~1 then 0 else A))
         ((if C = ~1 then 0 else C) - (if A = ~1 then 0 else A)) s)

         end

         else errormessage ("Proposed operator "^s^" ill-formed");

*)

(* Declaration of reserved operators:  not a user command! *)

fun reserveop m n s = if s <> "" andalso 
	stringtoop s = ConOp s andalso (not (isoperator s))

	then RESERVED:=addto s (m,n) (!RESERVED)

	else errormessage ("Improper operator reservation of "^s); 

(* reserveop 0 0 "||";

reserveop 0 0 ","; *)

(* declares the usual "flat" operators with only trivial type information *)

(* USER COMMAND *)

fun declareinfix s = declaretypedinfix 0 0 s;


(* lists of operators with special properties needed by the
stratification functions of the prover *)

val OPAQUE = ref["bogus"];
val SCOUT = ref[("bogus","bogus")];
val SCINLEFT = ref[("bogus","bogus")];
val SCINRIGHT = ref[("bogus","bogus")];

(* opaque operators are "opaque" to abstraction; one cannot define
a function in a way which essentially involves an opaque operator
(an opaque operator could appear in the name of a constant) *)

(* distinct from defined opaque "constant" operators (not used in 
any current theory, though they could be) are opaque variable operators;
an operator variable with declared type matches only operators of that
same type, while an opaque operator matches any operator, and for that
reason must observe the same restrictions on abstraction as an opaque
declared operator *)

fun isopaque s = s = "@!" orelse foundinset s (!OPAQUE);

fun istypedoperator s = (foundin s (!RESERVED) orelse foundin s (!OPERATORS))
	andalso not (isopaque s);

(* declare opaque operator *)

fun declareopaque s = if stringtoop s = ResOp s 

	then errormessage ("Reserved operator "^s^" cannot be made opaque")

	else if stringtoop s = VarOp s 

	then if foundin s (!OPERATORS) 

		then errormessage 
	("Reserved or variable operator "^s^" has already been typed")

		else (OPERATORS:=
		addto s (0,0)(!OPERATORS);OPAQUE:=addtoset s (!OPAQUE))

	else if s <> "" andalso stringtoop s = ConOp s

		then  if foundin s (!OPERATORS)

		then errormessage ("Operator "^s^" has already been declared")

		else (OPERATORS:=
		addto s (0,0) (!OPERATORS);OPAQUE:=addtoset s (!OPAQUE))

	else errormessage ("Ill-formed operator "^s^" cannot be declared");
 

(* scout = strongly Cantorian output; scinleft = strongly Cantorian input
(left argument) and scinright = strongly Cantorian input (right argument) 
strongly Cantorian = (in practice) belonging to some data type *)

val SCINSCOUT = ref ["bogus"];  (* list used in posting axiom 
				dependencies induced by scin/scout functions *)

fun scoutof s = safefind "" s (!SCOUT);

fun scinleftof s = safefind "" s (!SCINLEFT);

fun scinrightof s = safefind "" s (!SCINRIGHT);

fun scinof s = if scinleftof s = scinrightof s then scinleftof s else "";

fun isscout s = let val A = foundin s (!SCOUT) in
	(if A then SCINSCOUT:=addtoset (scoutof s) (!SCINSCOUT) else ();A) end;

fun isscinleft s = let val A = foundin s (!SCINLEFT) in
	(if A then SCINSCOUT:=addtoset (scinleftof s) (!SCINSCOUT) 
	else ();A) end;

fun isscinright s = let val A = foundin s (!SCINRIGHT) in
	(if A then SCINSCOUT:=addtoset (scinrightof s) (!SCINSCOUT) 
	else ();A) end;

(* assignment of scin/scout properties to theorems needs to
be witnessed by existence of theorems of appropriate forms and
will be handled later *)

(* prefix display declarations -- needed for display as well as
parser *)

(* variable prefix operators are needed! *)

(* the default left argument of an operator will be an atomic constant *)

val PREFIX = ref([("bogus","bogus")]);

(* PREFIX := nil; *)

fun prefixof s = safefind "" s (!PREFIX);

fun hasprefix s = foundin s (!PREFIX);

(* command to assign a default left argument to an operator;
this version only permits such an assignment to be made once *)

(* USER COMMAND *)

fun declareprefix s t = if hasprefix s then 

	errormessage ("Cannot reassign default left argument of "^s)

	else if (stringtoop s = ResOp s orelse (stringtoop s
	= ConOp s andalso isoperator s)) andalso
		isaconstant t

	then PREFIX := addto s t (!PREFIX)

	else errormessage ("Invalid prefix "^t^" proposed for operator "^s);

(* NOT a user command -- this command creates strict prefix operators,
which are those operators which have a prefix on the list equal to "" *)

(* it is necessary to be able to declare strict prefix operator
variables so that one can build structural tactics which will work
on prefix terms *)

fun isstrictprefix s = hasprefix s andalso prefixof s = "";

fun declarestrictprefix s = if (stringtoop s = ResOp s orelse 
	stringtoop s = VarOp s orelse (stringtoop s
	= ConOp s andalso isoperator s)) then PREFIX := addto s "" (!PREFIX)
	else errormessage 
	("Undeclared operator "^s^" cannot be declared strict prefix");

(* declarations of strictly unary operators *)

fun declaretypedunary n s = (declaretypedinfix 0 n s; declarestrictprefix s);

fun declareunary s = declaretypedunary 0 s;

(*

fun declarescunary a b s = (declarescinfix a "0" b s;declarestrictprefix s);

*)

fun declareunaryopaque s = (declareopaque s; declarestrictprefix s);

(* default type handling:  this allows the suppression of type labels
on variables which are understood to usually have a given type; the
type label infix : appears as a prefix operator in this case *)

val VARTYPES = ref [("bogus",Constant "")];

(* VARTYPES := nil; *)

fun hasdefaulttype v = foundin v (!VARTYPES);

fun defaulttypeof v = safefind (Constant "") v (!VARTYPES);

fun hasdtprefix ":" (FreeVar v) = hasdefaulttype v |

	hasdtprefix s t = false;

fun dtprefixof ":" (FreeVar v) = defaulttypeof v |

	dtprefixof s t = Constant "";

fun haseitherprefix s t = hasprefix s orelse hasdtprefix s t;

fun eitherprefixof s t = if hasprefix s then stringtocon (prefixof s)

			else dtprefixof s t;

(* USER COMMAND *)

fun notypeinfo v = if foundin v (!VARTYPES)

	then VARTYPES:=drop v (!VARTYPES)

	else errormessage ("No default type for "^v^" found to drop");

(* function for assigning types is found below; it requires
declaration checking *)

(* I might want to add scin/scout information *)

fun showdec s = if stringtocon s = Constant s 
		then if isaconstant s
		then nopausemessage (s^" is a declared constant")
		else nopausemessage ("Undeclared constant "^s)
		else if stringtocon s = 
		Numeral (rev (stripzeroes(map numvalue (explode s))))

		then nopausemessage "Numerals are predeclared"

		else if (stringtoop s = ResOp s)
			then if isopaque s 
			then nopausemessage ("Opaque reserved operator "^s)
			else if isoperator s
			then nopausemessage 
			("Reserved operator "^s^" left type:  "
			^(makestring (lefttype s))^" right type: "
				^(makestring(righttype s)^
				" left arg (if any): "^(prefixof s)))
			else errormessage ("Undeclared reserved operator?!")
		else if (stringtoop s = ConOp s)
			then if isopaque s 
			then nopausemessage ("Opaque declared operator "^s)
			else if isoperator s
			then nopausemessage ("Declared operator "^s^
				" left type: "
			^(makestring (lefttype s))^" right type: "
				^(makestring(righttype s))^
				(if hasprefix s then 
				if prefixof s = "" then " Prefix operator only"
				else " Default left argument:  "^(prefixof s)
				else " Infix argument only"))
		
			else nopausemessage ("Undeclared operator")
		
		else if stringtoop s = VarOp s andalso foundin s (!OPERATORS)
		then nopausemessage 
                     ("Typed variable operator "^s^" left type: "
		^(makestring (lefttype s))^" right type: "^
		(makestring(righttype s))^
		(if hasprefix s then " (strict prefix)" else ""))

		else if stringtoop s = VarOp s andalso isopaque s
		then nopausemessage ("Opaque operator variable "^s^
		(if hasprefix s then " (strict prefix)" else ""))

		else if stringtoop s = VarOp s then nopausemessage
			("Undeclared operator variable "^s)

		else errormessage "No applicable declaration";


(* simple display function *)

fun opdisplay (ConOp s) = s |

	opdisplay (VarOp s) = s |

	opdisplay (ResOp s) = s |

	opdisplay (ParOp s) = "{"^s^"}";

(* the master precedence list *)

val PRECEDENCES = ref ([("bogus",0)]);

(* PRECEDENCES:=nil; *)

(* default precedence *)

val DEFAULTPREC = ref 0;

(* user command to set precedence of an operator *)

fun setprecedence s n = if n<0 then setprecedence s 0 
			else PRECEDENCES := strongadd s n (!PRECEDENCES);

(* user command to set default precedence *)

fun setdefaultprec n = if n < 0 then setdefaultprec 0 else
			DEFAULTPREC := n;

(* user command to reset precedences to standard *)

fun clearprecs () = (PRECEDENCES := nil; DEFAULTPREC := 0);

fun precedenceof s = safefind (!DEFAULTPREC) s (!PRECEDENCES);

(* sophisticated precedence commands *)

fun preraiseprecs n nil = nil |
preraiseprecs n ((s,m)::L) = (s,if m>=n then m+2 else m)::(preraiseprecs n L);

fun raiseprecs n = PRECEDENCES := preraiseprecs n (!PRECEDENCES);

(* USER COMMANDS (5) *)

(* these commands allow precedences to be set relative to an
existing precedence -- either the same, just above, or just below
(making insertions in the latter two cases) and with left or
right grouping as indicated *)

fun sameprec s t = setprecedence s (precedenceof t);

fun defaultprecsame s = setdefaultprec (precedenceof s);

fun leftprecabove s t = (raiseprecs ((precedenceof t)+1);
                           setprecedence s ((precedenceof t)+1+
                                           ((precedenceof t) mod 2)));

fun rightprecabove s t = (raiseprecs ((precedenceof t)+1);
                           setprecedence s ((precedenceof t)+2-
                                           ((precedenceof t) mod 2)));

fun leftprecbelow s t = (raiseprecs ((precedenceof t));
                           setprecedence s ((precedenceof t)-1+
                                           ((precedenceof t) mod 2)));

fun rightprecbelow s t = (raiseprecs ((precedenceof t));
                           setprecedence s ((precedenceof t)-2+
                                           ((precedenceof t) mod 2)));


(* NORULES supports a mode in which embedded theorems are not
displayed (when it is true) *)

val NORULES = ref false;

(* in the old version, =>> and <<= were rule infixes as well, but they
are not in this version (they are operators linking a pair of theorems) *)

fun ruleinfix s = s = "=>" orelse s = "<=";

fun stickiness (Infix(x,s,y)) = if (!NORULES) andalso

	ruleinfix (opdisplay s) then stickiness y else

	precedenceof (opdisplay s) |

	stickiness (CaseExp(u,v,w)) = precedenceof "||" |

	stickiness x = 0;

(* this refers to surface form *)

fun isinfixterm (Infix(x,s,y)) = if (!NORULES) andalso
	ruleinfix (opdisplay s) then isinfixterm y else true |

	isinfixterm (CaseExp(u,v,w)) = true |

	isinfixterm x = false;

fun isprefixterm (Infix(x,s,y)) = (x = eitherprefixof (opdisplay s) y) |

	isprefixterm x = false;

(* parentest x s b tells us whether term x needs to be parenthesized
when it is term b (left term has b=0, right term has b=1) in an infix
term with infix s *)

(* there is a difficulty with parentheses around prefix terms to the
right of an infix; such parentheses are sometimes eliminable, but this
depends on context in a way which is hard to implement. *)

fun parentest x s b = ((not (!NORULES)) 
	orelse (not (ruleinfix (opdisplay s)))) 
	andalso (isinfixterm x andalso ((stickiness x <
	precedenceof (opdisplay s)) orelse
	(stickiness x = precedenceof (opdisplay s) andalso 
	((stickiness x) mod 2 = b))));

(* pp for "possible parenthesis" *)

fun pp x s b p = if parentest x s b then p else ""; 

(* function for converting preparsed terms to correct form *)

fun reassociate1 (Infix(x,s,Infix(y,t,z))) =

	if ((precedenceof (opdisplay s) > precedenceof (opdisplay t))
	orelse (precedenceof (opdisplay s) = precedenceof (opdisplay t)
	andalso ((precedenceof (opdisplay s)) mod 2) = 1))
	andalso y <> eitherprefixof (opdisplay t) z

	then Infix(reassociate1(Infix(x,s,y)),t,z)

	else (Infix(x,s,Infix(y,t,z))) |

	reassociate1 t = t;

fun reassociate (Parenthesis t) = Parenthesis (reassociate t) |

	reassociate (Function t) = Function (reassociate t) |

	reassociate (Infix(x,s,y)) = 
		reassociate1 (Infix(reassociate x,s,reassociate y)) |

	reassociate t = t;

(* baredisplay should now handle user-defined precedence correctly *)

fun baredisplay (Constant s) = s |

	baredisplay (Numeral n) = implode(rev (map makestring n)) |

	baredisplay (FreeVar s) = s |

	baredisplay (BoundVar s) = "?"^(makestring s) |

	baredisplay (Infix(t,i,u)) = let val T = baredisplay t in

		(* the baredisplay function does not use 
		default type information; this avoids trouble
		for load and save commands *)

		if T = prefixof (opdisplay i)

			then (opdisplay i)^" "^(pp u i 1 "(")^
			(baredisplay u)^(pp u i 1 ")")

			else (pp t i 0 "(")^T^(pp t i 0 ")")^" "
			^(opdisplay i)^" "
			^(pp u i 1 "(")
			^(baredisplay u)^(pp u i 1 ")") end |

	baredisplay (Function t) = "["^(baredisplay t)^"]" |

	(* display of case expressions "cheats"; it relies on the
	surface form of case expressions as complex infix expressions *)

	(* this works because the display functions are independent
	of declarations *)

	baredisplay (CaseExp(t,u,v)) = baredisplay 
		(Infix(t,ResOp("||"),Infix(u,ResOp(","),v))) |

	(* the case for Parenthesis handles highlighting the current subterm *)

	baredisplay (Parenthesis t) = "{"^(baredisplay t)^"}";

val CURSOR = ref 0;

fun bumpcursor s = (CURSOR:=(!CURSOR)+(length(explode s));s);

val MARGIN = ref 50;

fun setline n = MARGIN:=n;

fun spaces 0 = "   " |

	spaces n = (spaces (n-1))^"   ";

fun predashes 0 = "" |
	predashes 1 = " " |
	predashes 2 = "  " |
        predashes 3 = "   " | 
	predashes n = if n<0 then "" else (predashes (n-1))^"-";

fun dashes() = predashes (!MARGIN);

fun Newline() = (CURSOR:=0;"\n");

fun maybebreak d = if (!CURSOR) >= (!MARGIN)

		then (Newline()^bumpcursor(spaces d))

		else ""; 


fun predisplay d (Constant s) = 
	(bumpcursor s) |

	predisplay d (Numeral n) = (bumpcursor
		(implode(rev (map makestring n)))) |

	predisplay d (FreeVar s) =(bumpcursor s) |

	predisplay d (BoundVar s) = 
	(bumpcursor ("?"^(makestring s))) |

	predisplay d (Infix(t,i,u)) = 

		if (!NORULES) andalso ruleinfix (opdisplay i)

			then predisplay d u

		else let val T = baredisplay t in

		if T = baredisplay(eitherprefixof (opdisplay i) u)

			then 

			(bumpcursor (opdisplay i))
			^" "
			^(bumpcursor (pp u i 1 "("))
			^(predisplay (if parentest u i 1 then d+1 else d) u)
			^(bumpcursor (pp u i 1 ")"))

			else (bumpcursor (pp t i 0 "("))
			^(predisplay (if parentest t i 0 then d+1 else d) t)
			^(bumpcursor (pp t i 0 ")"))
			^(bumpcursor " ")
			^(maybebreak d)
			^(bumpcursor(opdisplay i))
			^(bumpcursor " ")
			^(bumpcursor (pp u i 1 "("))
			^(predisplay (if parentest t i 0 then d+1 else d) u)
			^(bumpcursor (pp u i 1 ")")) end |

	predisplay d (Function t) = (bumpcursor "[")^
				(predisplay (d+1) t)^(bumpcursor "]") |

	(* display of case expressions "cheats"; it relies on the
	surface form of case expressions as complex infix expressions *)

	(* this works because the display functions are independent
	of declarations *)

	predisplay d (CaseExp(t,u,v)) = predisplay d
		(Infix(t,ResOp("||"),Infix(u,ResOp(","),v))) |

	(* the case for Parenthesis handles highlighting the current subterm *)

	predisplay d (Parenthesis t) = (bumpcursor "{")
				^(predisplay (d+1) t)^(bumpcursor "}");


fun display t = (CURSOR:=0;(spaces 0)^(predisplay 0 t));

(* the parser *)

(* the parser engine works, like the tokenizer, with a list of characters *)

(* functions for extracting projections from pairs *)

fun p1(x,y) = x;

fun p2(x,y) = y;

(* the only change involved in user-defined precedence is recording
of user-supplied parentheses *)

fun getfirstterm L =

	if (strip L) = nil then (Constant "", nil)
	else let val A = firstatom L and B = strip(restfirstatom L) in
	if A <> Constant ""
		then (* first term is atomic *)
		(A,B)
	else let val C = firstop L and D = strip(restfirstop L) in
	if C <> ConOp ""
		then (* first term has a prefix operator *)
		let val E = getterm D in
		if haseitherprefix (opdisplay C) (p1 E) then
			if p1 E = Constant "" then (Constant "",nil)
			else ((* Parenthesis *)(
				Infix(eitherprefixof(opdisplay C)(p1 E),
				C,p1 E)),p2 E)
			
		else (Infix(Constant "",C,p1 E),p2 E) end
	else if hd (strip L) = "["
		then (* function term *)
		let val G = getterm (tl(strip L)) in
		if p1 G = Constant "" orelse p2 G = nil orelse
			hd(p2 G) <> "]"
			then (Constant "", nil)
		else (Function(p1 G),strip(tl(p2 G)))
		end
	else if hd (strip L) = "("
		then (* parenthesis term *)
		let val G = getterm (tl(strip L)) in
		if p1 G = Constant "" orelse p2 G = nil 
			orelse hd(p2 G) <> ")"
			then (Constant "", nil)
		else (Parenthesis (p1 G),strip(tl(p2 G)))
		end
	else (Constant "",nil)
	end
	end

and getterm L = let val (A,B) = getfirstterm L in
if A = Constant "" 
	then (Constant "",nil)
else if B = nil orelse hd B = "]" orelse hd B = ")"
	then (A,B)
else let val C = firstop B and D = strip(restfirstop B) in
	if C = ConOp "" then (Constant "",nil)
	else let val E = getterm D in
		if p1 E = Constant "" then (Constant "",nil)
		else (Infix(A,C,p1 E),p2 E)
		end
	end
end;


(* the parser reads case expressions as a particular kind of infix
expression; the casefix function rectifies this situation and rejects
expressions of the form ?x || ?y where ?y is not a pair. *)

fun casefix (Infix(x, ResOp "||",Infix(y,ResOp",",z))) =

		CaseExp(casefix x,casefix y,casefix z) |

	casefix (Infix(x,ResOp"||",y)) = 
	(errormessage "Ill-formed case expression"; 
         CaseExp(casefix x,Infix(Constant "p1",ResOp"@",casefix y),
            Infix(Constant "p2",ResOp"@",casefix y))) |

	casefix (Function t) = Function (casefix t) |

	casefix (Infix (x,s,y)) = Infix(casefix x,s,casefix y) |

	casefix t = t;

fun parse s = let val A = getterm(explode s) in if p2 A = nil then 
	casefix(deparenthesize(reassociate(p1 A)))
	else Constant "" end;

(* the theorem-embedding infixes which signal intentions to rewrite *)

(* reserveop 0 0 "=>";

reserveop 0 0 "<="; *)

(* they are actually declared in the setup command at the end *)


(* operators of built-in arithmetic *)

(* the declarations are actually made later in the setup command *)

(* reserveop 0 0 "+!"; reserveop 0 0 "-!"; reserveop 0 0 "*!"; reserveop 0 0 "/!";
reserveop 0 0 "%!"; reserveop 0 0 "<!"; reserveop 0 0 ">!"; 
reserveop 0 0 "=!"; *)

fun arithop s = s = "+!" orelse s = "-!" orelse s = "*!" orelse s = "/!"
orelse s = "%!" orelse s = "<!" orelse s = ">!" orelse s = "=!";

(* the rulefree function certifies a term as free of "execution
behaviour" *)

(* execution behaviour refers to presence of embedded theorems,
operations of the built-in arithmetic, or case expressions whose
hypotheses are truth values or equations with first term true. *)

(* declarations for functional programming *)

val PROGRAMS = ref ([("bogus","bogus")]);

(* command setprogram to bind a program to a constant or operator 
is found below *)

(* USER COMMAND *)

(* user program to remove any tactic bound to a function or operator *)

fun deprogram s = PROGRAMS := drop s (!PROGRAMS);

fun hasprogram s = foundin s (!PROGRAMS);

fun programof s = safefind "" s (!PROGRAMS);

(* moved here from near changehlevel below because of needs of 

enhanced higher-order matching  *)

fun changelevel source target (BoundVar s) = 
	if s <= source andalso s <= target then BoundVar s
	else if s <= source andalso s > target then Constant ""
	else BoundVar (target + (s - source)) |
	changelevel source target (Function t) =

		let val TRY = changelevel source target t in
		if TRY = Constant "" then Constant "" else Function TRY end |
	changelevel source target (Infix(x,i,y)) =

		let val TRY1 = changelevel source target x
		and TRY2 = changelevel source target y in
		if (TRY1 = Constant "" andalso ((not(hasprefix (opdisplay i)))
			orelse prefixof (opdisplay i) <> ""))
		orelse TRY2 = Constant ""
		then Constant "" else Infix(TRY1,i,TRY2)  end |
	changelevel source target (CaseExp(u,v,w)) =

		let val TRY1 = changelevel source target u
		and TRY2 = changelevel source target v
		and TRY3 = changelevel source target w in

		if TRY1 = Constant "" orelse TRY2 = Constant "" 
			orelse TRY3 = Constant ""
		then Constant ""
		else (CaseExp(TRY1,TRY2,TRY3))
		end |
	changelevel source target (Parenthesis u) =

		let val TRY = changelevel source target u in

		if TRY = Constant "" then Constant "" else Parenthesis TRY 
		end |

	changelevel source target t = t;


fun rulefree (Infix(Numeral m,ResOp s,Numeral n)) = not(arithop s) |

	rulefree (Infix(x,ResOp s, y)) = (not(ruleinfix s))

	andalso rulefree x andalso rulefree y |

	rulefree (CaseExp(Infix(Constant"true",ResOp"=",x),y,z)) = false |

	rulefree (CaseExp (u,v,w)) = u <> Constant "true" andalso
	u <> Constant "false" andalso rulefree u andalso rulefree v
	andalso rulefree w |

	rulefree (Function t) = rulefree t |

	rulefree (Infix(x,i,y)) = rulefree x andalso rulefree y |

	rulefree t = true;

(* list of "locally free" bound variables on which a term
depends -- obviously this needs the level as a parameter *)

fun boundvarlist level (BoundVar s) = if s=0 then nil else [s] |

	boundvarlist level (Infix(u,i,v)) = union (boundvarlist level u) 
		(boundvarlist level v) |

	boundvarlist level (Function t) = dropfromset (level + 1) 
		(boundvarlist (level+1) t) |

	boundvarlist level (CaseExp(u,v,w)) = union
		(boundvarlist level u) (union
		(boundvarlist level v)(boundvarlist level w)) |

	boundvarlist level t = nil;

(* the "stratification" function for "predicate" abstraction:
roughly, no bound variables to occur free in applied position *)

(* it's actually rather more elegantly described now; the constraint
described above is obtained without any direct reference to bound
variables per se *)

fun metahead level n (Function t) = metahead (level+1) (n-1) t |

	metahead level n (Infix(x,ResOp"@!",y)) = metastrat level y
		andalso metahead level (n+1) x |

	metahead level n (Infix(x,ResOp"@*",y)) = metastrat level y
		andalso metahead level (n+1) x |

	metahead level n (FreeVar x) = true |

	metahead level n (Infix(x,ResOp"=>",y)) =

		metahead level n y |

	metahead level n (Infix(x,ResOp"<=",y)) =

		metahead level n y |

	metahead level n (Parenthesis t) = metahead level n t |

	metahead level n (CaseExp(u,v,w)) =

		metahead level n v andalso metahead level n w |

	metahead level n t = (n<=0 andalso metastrat level t)

and	metastrat level (Infix (x,ResOp"@!",y)) = 

	metahead level 1 x andalso metastrat level y |

        metastrat level (Infix (x,ResOp"@*",y)) = 

	metahead level 1 x andalso metastrat level y |



	metastrat level (Infix(x,i,y)) = 
	metastrat level x andalso metastrat level y |

	metastrat level (Function t) = metastrat (level+1) t |

	metastrat level (CaseExp(t,u,v)) = metastrat level t 
		andalso metastrat level u andalso metastrat level v |

	metastrat level (Parenthesis t) = metastrat level t |

	metastrat level t = true;


(* the master declaration checking function; it checks constants,
operators, and bound variables for meaningfulness *)

(* declarecheck sends error messages (if the quiet parameter is false), 
but only for the first error it
encounters *)

(* design decision:  we do not check for meaningless m|-|n, because
such things appear to be harmless (and even potentially useful) *)

fun declarecheck quiet (level:int) (Constant s) = 
		if isaconstant s then true 
	else

	((if quiet then () else 
	errormessage ("Undeclared constant "^s^" found"));false) |

	declarecheck quiet level (Numeral n) = true |

	declarecheck quiet level (FreeVar s) = true |

	declarecheck quiet level (BoundVar s) = if s<=level 
		then true else ((if quiet then () else errormessage 
	("Meaningless bound variable ?"^(makestring s)^" found"));false) |

	declarecheck quiet level (Function t) = metastrat level (Function t)
		andalso
		declarecheck quiet ((level:int)+1) t |

	declarecheck quiet level (CaseExp(u,v,w)) = 
		(declarecheck  quiet level u) 
		andalso
		(declarecheck quiet level v) andalso 
		(declarecheck quiet level w) |

	declarecheck quiet level (Infix(x,ResOp"@!",y)) = 

		declarecheck quiet level x andalso declarecheck quiet level y
		andalso metahead level 1 x | 

	declarecheck quiet level (Infix(x,ResOp"@*",y)) = 

		declarecheck quiet level x andalso declarecheck quiet level y
		andalso metahead level 1 x | 

	declarecheck quiet level (Infix(u,ResOp s,v)) =

		if isstrictprefix s
		then if u = Constant "" then declarecheck quiet level v
		else ((if quiet then () else errormessage 
		("Exclusive prefix operator "^s^" used as infix"));false)
		else (declarecheck quiet level u) 
		andalso
		(declarecheck quiet level v) |

	declarecheck quiet level (Infix(u,VarOp s,v)) = 


		if stringtoop s <> VarOp s 
		then ((if quiet then () 
		else errormessage ("Ill-formed infix variable "^s));false)
		else 

                if isstrictprefix s 
		then if u = Constant "" then declarecheck quiet level v
		else ((if quiet then () else errormessage 
		("Exclusive prefix operator "^s^" used as infix"));false)

		else if isopaque s then (declarecheck  quiet level u) 
		andalso
		(declarecheck quiet level v) else

                if u = Constant "" then
		(nopausemessage 
                   ("Automatically declaring opaque prefix operator "^s);
                declarestrictprefix s;
                declareopaque s; declarecheck quiet level v) 
                else
 
                ((nopausemessage 
                   ("Automatically declaring opaque infix operator "^s);
                declareopaque s);

		(declarecheck  quiet level u) 
		andalso
		(declarecheck quiet level v)) |

	declarecheck quiet level (Infix(u,ConOp s,v)) = 
		if isstrictprefix s  
		then if u = Constant "" then 
		(declarecheck quiet level v)

		andalso if isoperator s then true 
		else ((if quiet then () 
		else errormessage ("Undeclared operator "^s^" found"));false)

		else ((if quiet then () else errormessage 
		("Exclusive prefix operator "^s^" used as infix"));false)

		else (declarecheck  quiet level u) 
		andalso
		(declarecheck quiet level v)

		andalso if isoperator s then true 
		else ((if quiet then () 
		else errormessage ("Undeclared operator "^s^" found"));false) |

	declarecheck quiet level (Parenthesis u) = 

		((if quiet then () else errormessage ("Braces found"));false);

(* stratification checking *)

(* reserveop 0 0 ":"; *)  (* the type label (retraction) infix *)

(* the actual declaration is deferred to setup *)

(* the stratification function takes as its parameter a local
type and generates a list of lists of type assignments to bound variables,
which will be empty if there is no consistent type assignment; otherwise,
the first of these lists will be the types fixed for bound variables
in the given context, while subsequent lists record known "relative"
types which may be shifted by a constant amount *)

(*  BEGIN deleted stuff for old stratification algorithm 

(* utilities which operate on lists of type assignments *)

fun shifttype n nil = nil |

	shifttype (n:int) ((p,q)::L) = ((p,q+n)::shifttype n L);

(* finds a candidate for the displacement between two type
assignments -- does not check for consistency! *)

(* returns nil if there is no point of contact between the lists *)

fun typediff nil L = nil |

	typediff ((p,q:int)::L) M = let val A = find p M in
		if A = nil then typediff L M  else [q -(hd A)] end;

(* shiftmerge, given two type assignment lists, returns the list of
the two if they have no point of contact, returns nil if they are
inconsistent, and returns the merged list otherwise (shifting the
second list by the amount reported by typediff) *)

(* the first two clauses allow for considerable simplification; "floating"
lists with zero or one entry do not supply any information, but may
not merge using the third clause *)

fun shiftmerge L nil = [L] |

	shiftmerge L (x::nil) = [L] |

	shiftmerge L M = if typediff L M = nil then [L, M]
	else merge L (shifttype (hd (typediff L M)) M); 

(* crushtypes simplifies a list of type assignment lists, merging any
lists which have a point of contact and preserving the special role
of the head of the list (whose types must be fixed) *)

fun crushtypes nil = nil |

	crushtypes (L::nil) = (L::nil) |

	crushtypes (L::(M::rest)) = let val A = crushtypes (M::rest)
		in if A = nil then nil else let val (N::rest2) = A in

                let val B = shiftmerge L N in
		if B = nil then nil
		else if B = [L,N] 
		then ((crushtypes (L::rest2))@[N])
		else crushtypes (B@rest2) end end end;

(* merges two type lists *)

fun mergetypes nil L = nil |

		mergetypes M nil = nil |

		mergetypes (L::rest1) (M::rest2) = 

			if merge L M = nil then nil

			else crushtypes((merge L M)@rest1@rest2);

(* checkappend is used in strat for "floating" a type list; we check that the
list we are "floating" isn't nil before we prepend [nil] to it *)

fun checkappend L M = if M = nil then nil else L@M;

END deleted stuff for old stratification algorithm *)

(* development of type of "variables plus numerals" used for 
new extended stratification algorithm *)

(* 

simplifying assumptions for "unknown displacements": forbid @* terms
in arguments of @*.  Further, forbid floating types in arguments of
@*.  These are reasonable restrictions, met for example by any
higher-order pattern. If you do this, then all types in any given
argument of a @* will have the same fixed unknown displacement, so an
unknown displacement can safely be converted directly to a floating
displacement when it is floated?

forall @ [forall @ [ forall@[((?P@*?1)@*?2)@?3]]]

so all types assigned to a given argument will have the same
unknown displacement from an assortment of rigid types.

Another idea:  can we suppose that all rigid types in a problem
are floated by the same unknown amount -- then when an assignment
is made to one floated rigid type, all other floated rigid types
become unfloated unknown types again?

Add additional condition to stratification of @* terms -- all
types in the stratification of the argument must be concrete integers.

Further, unknown floating types may only be equated with rigid types,
and when one unknown floating type is equated with a rigid type,
all other unknown floating types revert to rigidity.  In fact,
when any type equation is imposed, all unknown floating types
revert to rigidity?

*)

datatype relative_type =

    rigid_type of int |
    floating_type of (int*int) |
    unknown_rigid_type of (int*int) |
    unknown_floating_type of (int*int*int);

(* probably we can broaden this to allow floating types to
match unknown types.  Unknown floating types with different
floats can probably also be coordinated. *)

(* string coding argument place of a variable type-raising operator *)

(* fun sillystring (FreeVar s) = s |
    sillystring (Infix(t,ResOp "@*",u)) = (sillystring t)^"#"; *)

fun force_equation 
(floating_type(p,q)) (floating_type(r,s)) (floating_type(t,u)) = 
   if p<>r andalso t=p then floating_type(r,u+(s-q)) else floating_type(t,u) |

force_equation 
(floating_type(p,q)) (floating_type(r,s)) (unknown_floating_type(t,u,v)) =

   if p=t then unknown_floating_type(r,u,v) else unknown_floating_type(t,u,v) |

force_equation x (floating_type(p,q)) (floating_type(p1,q1)) = 
   force_equation (floating_type(p,q)) x (floating_type(p1,q1)) |

force_equation x (floating_type(p,q)) (unknown_floating_type(p1,q1,r)) = 
   force_equation (floating_type(p,q)) x (unknown_floating_type(p1,q1,r)) |


force_equation (floating_type(p,q)) (unknown_floating_type(t,u,v))
               (floating_type(w,x)) =

   if p=w then unknown_floating_type(t,u,x+(v-q)) else (floating_type(w,x)) |

force_equation (floating_type(p,q)) (unknown_floating_type(t,u,v))
               (unknown_floating_type(w,x,y)) =

   if p=w then (unknown_floating_type(t,x,y)) 
   else (unknown_floating_type(w,x,y)) |

force_equation (floating_type(p,q)) (rigid_type n) (floating_type(r,s)) =

   if p=r then rigid_type(s+(n-q)) else (floating_type(r,s)) |

force_equation (floating_type(p,q)) (rigid_type n) 
               (unknown_floating_type(r,s,t)) =

               if p=r then unknown_rigid_type(s,t)
               else (unknown_floating_type(r,s,t)) |

force_equation (floating_type(p,q)) (unknown_rigid_type(i,j)) 
               (floating_type(r,s)) =

               if p=r then unknown_rigid_type(i,s+(j-q))
               else (floating_type(r,s)) |

force_equation (floating_type(p,q)) (unknown_rigid_type(i,j))
               (unknown_floating_type(r,s,t)) =

               if p=r then unknown_rigid_type(s,t)

               else (unknown_floating_type(r,s,t)) |

force_equation (unknown_floating_type(a,b,c)) (unknown_floating_type(d,e,f))
               (unknown_floating_type(g,h,i)) =

               if a=g then
               if b=h then unknown_floating_type(d,e,i+(f-c))
               else unknown_floating_type(d,h,i)
               else unknown_floating_type(g,h,i) |

force_equation x (unknown_floating_type(a,b,c))
(unknown_floating_type(a1,b1,c1))  =

     force_equation (unknown_floating_type(a,b,c)) x 
(unknown_floating_type(a1,b1,c1)) |

force_equation (unknown_floating_type(a,b,c)) (rigid_type n) 
               (unknown_floating_type(d,e,f)) =

               if a=d then 
               if b=e then rigid_type(f+(n-c))
               else unknown_rigid_type(e,f)
               else unknown_floating_type(d,e,f) |

force_equation (unknown_floating_type(a,b,c)) (rigid_type n) 
               (floating_type(d,e)) =

               if a = d then unknown_rigid_type(b,e)
               else (floating_type(d,e)) |

force_equation (unknown_floating_type(a,b,c)) (unknown_rigid_type(d,e))
               (unknown_floating_type(f,g,h)) =

               if a=f then 
               if b=g then unknown_rigid_type(d,h+(e-c))
               else unknown_rigid_type(g,h)
               else  unknown_floating_type(f,g,h) |

force_equation (unknown_floating_type(a,b,c)) (unknown_rigid_type(d,e))
               (floating_type(f,g)) =

               if a=f then unknown_rigid_type(b,g)
               else (floating_type(f,g))  |

force_equation x y z = z;

fun can_equal (floating_type(p,q)) (floating_type(r,s)) =
              if p=r then q=s else true |

can_equal (floating_type(p,q)) (unknown_floating_type(r,s,t)) =

              p<>r |

can_equal (floating_type(p,q)) x = true |

can_equal x (floating_type(p,q)) = can_equal (floating_type(p,q)) x |

can_equal (unknown_floating_type(r,s,t)) (unknown_floating_type(u,v,w)) =

          if r=u then s=v andalso t=w else true |

can_equal (unknown_floating_type(r,s,t)) (unknown_rigid_type(u,v)) =

          if s=u then t=v else true |

can_equal (unknown_floating_type(r,s,t)) x = true |

can_equal x (unknown_floating_type(r,s,t)) = 
           can_equal (unknown_floating_type(r,s,t)) x |

can_equal x y = x=y;

(* 

fun is_rigid (rigid_type n) = true |

is_rigid x = false;

(* recognizes completely rigid stratifications *)

fun all_rigid nil = false |

    all_rigid [nil] = true |

    all_rigid [((x,rigid_type n)::L)] = all_rigid [L] |

    all_rigid x = false;

*)

(* is_rigid is generalized for subsequent (now all) uses *)

fun is_rigid (rigid_type n) = true |

is_rigid (unknown_rigid_type(i,j)) = true |

is_rigid x = false;

val TYPE_VAR_INDEX = ref 0;

fun reset_type_var_index() = TYPE_VAR_INDEX := 0;

fun bump_type_var_index() = TYPE_VAR_INDEX:=(!TYPE_VAR_INDEX)+1;

fun fresh_type_var_index() = 
(bump_type_var_index();(!TYPE_VAR_INDEX));

(* fun prepend x nil = nil |

prepend x [L] = [(x::L)] |

prepend x y = nil; *)

(* first argument = processed part of list;
second argument = rest of list *)

fun fix_function1 L nil = [L] |

fix_function1 L ((x,n)::M)  = 

    let val F = find x M in

    if F = nil then fix_function1 ((x,n)::L) M

    else if can_equal (hd F) n 

    then 
    fix_function1 nil 
    (map (fn (x,y) => (x,force_equation n (hd F) y)) (L@M))

    else nil

    end;

fun fix_function L = fix_function1 nil L;

fun mergestrats nil L = nil |

   mergestrats L nil = nil |

   mergestrats [L] [M] = fix_function(union L M) |

   mergestrats x y = nil;


fun float_list nil = nil |

float_list [L] = [let val M = separate (fn (x,N) => is_rigid N) L
in 

if length M < 2 then separate (fn (x,N) => not(is_rigid N)) L

else let val T = fresh_type_var_index() in

(map (fn (x,rigid_type n) => (x,floating_type(T,n))|
         (x,unknown_rigid_type(i,j)) => (x,unknown_floating_type(T,i,j))) M)@
(separate (fn (x,N) => not(is_rigid N)) L)

end

end];

fun displace_list T nil = nil |

displace_list T [L] =

[(map (fn (x,rigid_type n) => (x,unknown_rigid_type(T,n)) |
       (x,y) => (x,y)) L)];

fun metafree (Infix(x,ResOp t,y)) = t<>"@!" andalso t<>"@*" 
	andalso metafree x andalso metafree y |
	metafree (Infix(x,i,y)) = metafree x andalso metafree y |
	metafree (Function t) = metafree t |
	metafree (CaseExp(u,v,w)) = metafree u andalso metafree v
		andalso metafree w |
	metafree (Parenthesis t) = metafree t |
	metafree t = true;



(* the main stratification function *)

(* another stratification function will be needed by the
definition function -- it will type free variables rather
than bound variables *)

(* all changes to strat must also be made to prestrat2 *)

(* val CHECKTYPE = ref 0; *)

fun strat level localtype (Constant s) = [nil] |

	strat level localtype (FreeVar s) = [nil] |

	strat level localtype (Numeral s) = [nil] |

	strat level localtype (BoundVar s) = if s = 0 then [nil] else 
		[[(s,rigid_type(localtype))]] |

	strat level localtype (Function s) = map (drop (level+1))
		(mergestrats
			(strat (level+1) (localtype-1) s)
			[[(level+1,rigid_type(localtype-1))]]) |

	strat level localtype (CaseExp(t,u,v)) =

		mergestrats(float_list(strat level localtype t))
		(mergestrats(strat level localtype u)
			(strat level localtype v)) |

(*	strat level localtype (Infix(t,ResOp":",u)) =

		mergetypes (strat level (localtype+1) t) 
		(checkappend [nil] (strat level localtype u)) | 

*)

        strat level localtype (Infix(t,ResOp":",u)) =

                if (strat level (localtype) t = [nil])

                then (float_list (strat level localtype u))

                else nil |

	strat level localtype (Infix(Constant f,ResOp "@",t)) =
		
		(if (* level = 0 
			orelse *) isscout f orelse isscinright f 
			then float_list  else (fn x => x))
		(strat level localtype t) |

        strat level localtype 
	(Infix(Infix(t,ResOp"@*",m),ResOp"@*",n)) =

                let val N = strat level localtype n in

                if metafree n then

		mergestrats (displace_list (fresh_type_var_index()) N)
		(strat level (localtype) (Infix(t,ResOp"@*",m)))

                else nil  end |

        strat level localtype (Infix(FreeVar t,ResOp "@*",n)) =

                let val N = strat level localtype n in

                if metafree n then

	        displace_list (fresh_type_var_index()) N

                else nil end

		|

	strat level localtype (Infix(t,ResOp"@*",u)) = nil |


	strat level localtype (Infix(t,i,u)) =

		if istypedoperator (opdisplay i)

		then
		
		(if (* level = 0 orelse *) 
                isscout (opdisplay i) then float_list else                
                (fn x => x))
		(mergestrats

		((if (* level = 0 
			orelse *) isscinleft (opdisplay i) 
                        then float_list else 
                        (fn x => x))
		(strat level (lefttype(opdisplay i)+localtype) t))

		((if (* level = 0 orelse *)
			isscinright (opdisplay i) then float_list else 
                        (fn x => x))
		(strat level (righttype(opdisplay i)+localtype) u)))

		else (* case of opaque or undeclared variable operators *)

		if boundvarlist level (Infix(t,i,u)) = nil
		andalso strat level 0 t <> nil
		andalso strat level 0 u <> nil
		then [nil] else nil;


fun isstratified level t = (reset_type_var_index();
strat level 0 t <> nil);

(* USER COMMAND *)

(* delayed to here because it uses declaration and stratification
checking *)

fun defaulttypeinfo v t = if stringtocon v = FreeVar v andalso
	declarecheck false 0 (parse t) (* andalso isstratified 0 (parse t) *)

	then VARTYPES := strongadd v (parse t) (!VARTYPES)

	else errormessage 
("Declaration or syntax error in assigning type "^t^" to variable "^v);

(* the prover environment comes into view! *)

(* the prover environment consists of the following elements:

	name of environment (a string)

	"format" of environment (a term, used to indicate parameters
		of a parameterized theorem/tactic)

	left side of equation being proved (a term)

	right side of equation being proved (a term)

	current position in term (a list of booleans, true = right,
		false = left, the step into a function term is
		either right or left indifferently)

	current level and "hypothesis level" (two integers)

	list of local hypotheses (a list of "theorems" derived
		from hypotheses of case expressions -- a triple
		consisting of two terms to be equated and an
		integer coding the "sense" (positive, negative,
		or inactive) of the hypothesis)

	dependencies of current environment -- only the traditional
	kind will be considered; the new definition and theorem-text
	dependencies will be maintained separately

The theorem data structure is almost the same, except that it does
not have position-dependent components *)

(* a workhorse function -- apply a function to a term at a
position *)

fun applyat f nil t = f t |

	applyat f (a::L) (Constant s) = 
		(errormessage "Subterm error";Constant s) | 
	applyat f (a::L) (FreeVar s) = 
		(errormessage "Subterm error";FreeVar s) | 
	applyat f (a::L) (BoundVar s) = 
		(errormessage "Subterm error";BoundVar s) | 
	applyat f (a::L) (Numeral s) = 
		(errormessage "Subterm error";Numeral s) | 

	applyat f (a::L) (Function t) = Function (applyat f L t) |

	applyat f (false::L) (Infix(u,i,v)) =
		if u = Constant ""
		then (errormessage "Subterm error";(Infix(u,i,v)))
		else (Infix(applyat f L u,i,v)) |
	applyat f (true::L) (Infix(u,i,v)) =
		(Infix(u,i,applyat f L v)) |

	applyat f (false::L) (CaseExp(u,v,w)) =
		CaseExp(applyat f L u,v,w) |

	applyat f (true::(false::L)) (CaseExp(u,v,w)) =
		CaseExp(u,applyat f L v,w) |
	applyat f (true::(true::L)) (CaseExp(u,v,w)) =
		CaseExp(u,v,applyat f L w) |

	(* the Parenthesis case below helps prevent the 
	prover from issuing an error message when just looking
	at the virtual subterm *)

	applyat f (true::nil) (CaseExp(u,v,w)) =

		((let val A = f (Infix(v,ResOp",",w)) in
		if A = (Infix(v,ResOp",",w)) orelse
		A = Parenthesis((Infix(v,ResOp",",w))) then ()
		else errormessage "Virtual subterm of case expression" end);
		(CaseExp(u,v,w)));


(* the prover environment data type *)
(* this is a structure with nine fields as indicated above *)

fun ename (na,fo,lt,rt,po,lev,hlev,hyps,deps) = na;
fun formatof (na,fo,lt,rt,po,lev,hlev,hyps,deps) = fo;
fun leftside (na,fo,lt,rt,po,lev,hlev,hyps,deps) = lt;
fun rightside (na,fo,lt,rt,po,lev,hlev,hyps,deps) = rt;
fun position (na,fo,lt,rt,po,lev,hlev,hyps,deps) = po;
fun level (na,fo,lt,rt,po,lev,hlev,hyps,deps) = lev;
fun hlevel (na,fo,lt,rt,po,lev,hlev,hyps,deps) = hlev;
fun hypslist (na,fo,lt,rt,po,lev,hlev,hyps,deps) = hyps;
fun deps (na,fo,lt,rt,po,lev,hlev,hyps,deps) = deps;

(* functions which change environment fields to given values *)

fun changeename na2 (na,fo,lt,rt,po,lev,hlev,hyps,deps) = 
	(na2,fo,lt,rt,po,lev,hlev,hyps,deps);
fun changeformatof fo2 (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo2,lt,rt,po,lev,hlev,hyps,deps);
fun changeleftside lt2 (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt2,rt,po,lev,hlev,hyps,deps);
fun changerightside rt2 (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt,rt2,po,lev,hlev,hyps,deps);
fun changeposition po2 (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt,rt,po2,lev,hlev,hyps,deps);
fun changeelevel lev2 (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt,rt,po,lev2,hlev,hyps,deps);
fun changeehlevel hlev2 (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt,rt,po,lev,hlev2,hyps,deps);
fun changehypslist hyps2 (na,fo,lt,rt,po,lev,hlev,hyps,deps)=
	(na,fo,lt,rt,po,lev,hlev,hyps2,deps);
fun changedeps deps2 (na,fo,lt,rt,po,lev,hlev,hyps,deps)=
	(na,fo,lt,rt,po,lev,hlev,hyps,deps2);

(* functions which apply given functions to environment fields *)

fun changeename2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps) = 
	(f na,fo,lt,rt,po,lev,hlev,hyps,deps);
fun changeformatof2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,f fo,lt,rt,po,lev,hlev,hyps,deps);
fun changeleftside2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,f lt,rt,po,lev,hlev,hyps,deps);
fun changerightside2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt,f rt,po,lev,hlev,hyps,deps);
fun changeposition2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt,rt,f po,lev,hlev,hyps,deps);
fun changelevel2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt,rt,po,f lev,hlev,hyps,deps);
fun changehlevel2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps) =
	(na,fo,lt,rt,po,lev,f hlev,hyps,deps);
fun changehypslist2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps)=
	(na,fo,lt,rt,po,lev,hlev,f hyps,deps);
fun changedeps2 f (na,fo,lt,rt,po,lev,hlev,hyps,deps)=
	(na,fo,lt,rt,po,lev,hlev,hyps,f deps);

(* the current prover environment *)

val ENV = ref("",Constant "", Constant "", Constant "",
	[true],0,0,[(Constant"",Constant"",[true],0,0)],["bogus"]);

(* apply a function to the environment *)

fun envmod f = ENV:=f (!ENV);

(* reference for temporarily posting new dependencies *)

val NEWDEPS = ref ["bogus"];

(* dependency posting function *)

fun postdeps() = (envmod(changedeps2 (union(!NEWDEPS)))
	;NEWDEPS:=nil);

fun dropdeps() = NEWDEPS:=nil;

(* term viewing functions *)

(* these are actually identity functions with side effects *)

val PROMPT = ref true;

fun termprompts() = PROMPT := not (!PROMPT);

fun showterm prompt t = (if (!VERBOSITY) = 2 then 
(output(std_out,
(if (!PROMPT) then ("\n"^prompt^":") else "")
^"\n\n"^(display t)^(if (!GUIMODE) then ((!Returns)^". . .") else "")
^(!Returns));
flush_Out(std_out)) else ();t);

fun exec f = envmod (changerightside2 (applyat f
	(position(!ENV))));

(* USER COMMAND *)

(* look at current subterm *)

fun lookhere() = exec (showterm "Local term display");

(* variables controlling the look display *)

val LOCAL_DISPLAY = ref true;

val GLOBAL_DISPLAY = ref true;

(* USER COMMAND *)

(* look at current subterm and at top of right side of equation *)

(* insert a "parenthesis" temporarily to highlight current subterm *)

fun look() = (exec Parenthesis;
	envmod(changerightside2 (if (!GLOBAL_DISPLAY) 
	then (showterm "Global term display") else (fn x => x))); 
	exec deparenthesize1;
	lookhere());

(* USER COMMANDS (3) *)

(* control the look display *)

fun localdisplayoff() = (LOCAL_DISPLAY:=false;GLOBAL_DISPLAY:=true;look());

fun globaldisplayoff()= (LOCAL_DISPLAY:=true;GLOBAL_DISPLAY:=false;look());

fun bothdisplays()= (LOCAL_DISPLAY:=true;GLOBAL_DISPLAY:=true;look());

(* USER COMMAND *)

(* look at the left side of the equation under construction *)

fun lookback() = envmod(changeleftside2 (showterm "Initial term display"));

(* term starting functions appear below after the environment
saving commands, which have to appear after the declaration of
the theorem list *)


val SWAPTERM = ref (Constant "");

(* USER COMMAND *)

(* interchange the left and right sides of the equation under
construction *)

fun workback() =  (SWAPTERM:=leftside(!ENV);
	envmod(changeleftside (rightside(!ENV)));
	envmod(changerightside (!SWAPTERM));
	envmod(changeposition nil);
	envmod(changeelevel 0); envmod(changeehlevel 0);
	envmod(changehypslist nil);look());

(* functions acting on positions that implement the
term navigation commands *)

fun preup nil = (errormessage "At top already!";nil) |

	preup L = rev(tl(rev L));

fun preright L = rev (true::(rev L));

fun preleft L = rev (false::(rev L));

(* we also need functions acting on levels, hlevels, and hypothesis 
lists which support the movement commands *)

(* when one moves into or out of a function term, one needs to adjust
the level (the number of nested brackets enclosing one); when moving
into or out of case expressions, one needs to adjust the hlevel (the
number of relevant hypotheses of case expressions) and the list of
relevant hypotheses with their senses (positive, negative, or (at
the virtual subexpression) inactive) *)

val CURRENTTERM = ref(Constant "");

fun makecurrent t = (CURRENTTERM:=t;t);

fun getcurrent() = exec (makecurrent);

fun levelchange (Function f) n  = n+1 |

	levelchange t n = n;

fun uplevelchange (Function f) n = n-1 |

	uplevelchange t n = n;

fun hlevelchange (CaseExp(u,v,w)) n  = n+1 |

	hlevelchange t n = n;

fun uphlevelchange (CaseExp(u,v,w))  n = n-1 |

	uphlevelchange t n = n;

(* builds equation from hypothesis of a case expression and
records current position *)

(* true=?y is indistinguishable from ?y *)

fun equationfromterm (Infix(x,ResOp"=",y)) = 
	(x,y,position(!ENV),0,level(!ENV)) |

	equationfromterm t = (Constant "true",t,position(!ENV),0,level(!ENV));

fun hypslistchange (CaseExp(u,v,w)) L = 

	rev((equationfromterm u)::(rev L)) |

	hypslistchange t L = L;

fun listindex n nil = nil |

	listindex 1 (a::L) = [a] |

	listindex n (a::L) = listindex (n-1) L;

fun presethypslistsense (x,y,p,n,l) = let val A =
	listindex ((length p)+2) (position(!ENV)) in
		if A = nil then (x,y,p,0,l)
		else if A = [false] then (x,y,p,1,l)
		else if A = [true] then (x,y,p,2,l)
		else (x,y,p,0,l)
		end;

fun sethypslistsense L = if L = nil then nil else

rev((presethypslistsense(hd (rev L)))::(tl (rev L)));

fun coercehypslistsense n lv (x,y,p,m,l) = (x,y,p,n,lv);  

fun uphypslistchange (CaseExp(u,v,w)) L =

	if L = nil then nil

	else rev(tl (rev L)) |

	uphypslistchange t L = L;


(* the basic movement commands *)
(* they have "silent" variants used by the fancy movement
commands below *)

(* USER COMMAND *)

fun up() = if position(!ENV) = nil then errormessage "At top already!"

else if hd (rev (position (!ENV))) = true then  (* coming up from right *)

	(envmod (changeposition2 preup);
	getcurrent();
	envmod (changelevel2 (uplevelchange (!CURRENTTERM)));
	envmod (changehlevel2 (uphlevelchange (!CURRENTTERM)));
	envmod (changehypslist2 (uphypslistchange(!CURRENTTERM)));
	envmod (changehypslist2 (sethypslistsense));
	look())

else (* coming up from left *)

(envmod (changeposition2 preup);
	getcurrent();
	envmod (changelevel2 (uplevelchange (!CURRENTTERM)));
	envmod (changehypslist2 (sethypslistsense));	
	look());

fun sup() = if position(!ENV) = nil then errormessage "At top already!"

else if hd (rev (position (!ENV))) = true then  (* coming up from right *)

	(envmod (changeposition2 preup);
	getcurrent();
	envmod (changelevel2 (uplevelchange (!CURRENTTERM)));
	envmod (changehlevel2 (uphlevelchange (!CURRENTTERM)));
	envmod (changehypslist2 (uphypslistchange(!CURRENTTERM)));
	envmod (changehypslist2 (sethypslistsense)))

else (* coming up from left *)

(envmod (changeposition2 preup);
	getcurrent();
	envmod (changelevel2 (uplevelchange (!CURRENTTERM)));
	envmod (changehypslist2 (sethypslistsense))	
	);

(* USER COMMAND *)

fun left() = (getcurrent(); 
envmod (changelevel2 (levelchange (!CURRENTTERM))); 
envmod (changeposition2 preleft);
envmod (changehypslist2 (sethypslistsense));
look());

fun sleft() = (getcurrent(); 
envmod (changelevel2 (levelchange (!CURRENTTERM))); 
envmod (changeposition2 preleft);
envmod (changehypslist2 (sethypslistsense))
);

(* USER COMMAND *)

fun right() = (getcurrent(); 
envmod (changelevel2 (levelchange (!CURRENTTERM)));
envmod (changehlevel2 (hlevelchange (!CURRENTTERM))); 
envmod (changehypslist2 (hypslistchange (!CURRENTTERM)));
envmod (changeposition2 preright);
envmod (changehypslist2 (sethypslistsense));
look());

fun sright() = (getcurrent(); 
envmod (changelevel2 (levelchange (!CURRENTTERM)));
envmod (changehlevel2 (hlevelchange (!CURRENTTERM))); 
envmod (changehypslist2 (hypslistchange (!CURRENTTERM)));
envmod (changeposition2 preright);
envmod (changehypslist2 (sethypslistsense))
);

(* USER COMMAND *)

fun top() = (envmod (changeelevel 0); envmod (changeehlevel 0);
envmod(changehypslist nil);
envmod (changeposition nil); look());

(* USER COMMAND *)

(* used to check correct execution in scripts *)

fun verify s = (top();if (parse s) = rightside(!ENV) then ()
                      else errormessage ("Verification failure"));

(* theorem declaration list *)

(*

A theorem consists of the following components:

	a name (which appears as a key in the theorems list rather
	than part of the structure)

	a format (used to supply parameters) (a term)

	left side of equation (a term)

	right side of equation  (a term)

	a dependency list (the new definition and theorem-text
	dependency schemes will be supported by separate lists)

Note the similarity to a proof environment; eliminating the components
of a proof environment which support navigation yields a theorem.

*)

val THEOREMS = 
ref ([("bogus",(Constant "",Constant "",Constant "",["bogus"]))]);

fun theorysize() = nopausemessage(makestring(length(!THEOREMS)));

(* theorems declared but to be proved later -- i.e., recursive tactics *)

val PRETHEOREMS = ref ["bogus"];

(* list of tactic modules *)

val MODULES = ref [("bogus",(!THEOREMS))];

(* what module is a given theorem in? *)

val MODULES_INVERSE = ref [("bogus","bogus")];

fun whichmodule s = safefind "" s (!MODULES_INVERSE);

fun addwhichmodule s m = (* if m = "" 
then MODULES_INVERSE := drop s (!MODULES_INVERSE)
else *) MODULES_INVERSE := strongadd s m (!MODULES_INVERSE);

(* commands for manipulating theorems list and individual theorems *)

fun addtheorem name fo ls rs dps = (THEOREMS:= 
	strongadd name (fo,ls,rs,dps) (!THEOREMS);
	PRETHEOREMS := dropfromset name (!PRETHEOREMS));

(* weak addtheorem command used for module manipulations *)

fun addtheorem2 name thm  = THEOREMS := addto name thm (!THEOREMS);

fun droptheorem name = THEOREMS:= drop name (!THEOREMS);

val dummythm = (Constant "", Constant "", Constant "", []);

fun PreFormatof (a,b,c,d) = a;

fun PreLeftside (a,b,c,d) = b;

fun PreRightside (a,b,c,d) = c;

fun PreDeps (a,b,c,d) = d;

fun Thm name = safefind dummythm name (!THEOREMS);

fun Formatof name = PreFormatof (safefind dummythm name (!THEOREMS));

fun Leftside name = PreLeftside (safefind dummythm name (!THEOREMS));

fun Rightside name = PreRightside (safefind dummythm name (!THEOREMS));

fun Deps name = PreDeps (safefind dummythm name (!THEOREMS));

(* string lists will be converted to terms when needed for theorem deps *)

fun listtoterm nil = Numeral [0] |

	listtoterm (s::L) = Infix(if stringtocon s = Constant s
	then Constant s else Infix(FreeVar "?x",ConOp s,FreeVar "?y")
	,ResOp ",",listtoterm L);

fun listtoterm2 L = baredisplay(listtoterm L);

fun termtolist (Numeral [0]) = nil |

	termtolist (Infix(Constant s,ResOp",",y)) = (s::(termtolist y)) |

	termtolist (Infix(Infix(x,ConOp s,y),ResOp",",z)) = 
		(s::(termtolist z)) |

	termtolist x = nil;

fun termtolist2 s = termtolist (parse s);

(* either version of isatheorem is true only of "theorems" actually
found on the theorem list; built-in tactics are treated separately *)

fun isatheorem name = foundin name (!THEOREMS);

(* this version of isatheorem is used inside thmresult only as
a possible optimization *)

fun Isatheorem name = Foundin name (THEOREMS);

fun hasmodule name = safefind nil name (!MODULES) <> nil; 

fun moduleof name = if hasmodule name then hd(find name (!MODULES)) else nil;

(* USER COMMANDS (4) *)

(* name1 is pushed into the module associated with name2 *)

(* this command needs to be moved later in the file and made safe with respect
to dependencies *)

(* but this form of push will still be wanted for the internals of the
close command *)

(* notice that this form will push into hidden modules, which is
needed for CloseAll to work *)

fun push name1 name2 = if not(isatheorem name1)

   then errormessage (name1^" is not a theorem")

   else if not(hasmodule name2 orelse isatheorem name2)

   then errormessage (name2^" is not a theorem")

   else if name1 = name2 then errormessage 
   ("Theorem "^name1^" cannot be pushed into its own module")

   else if whichmodule name1 <> whichmodule name2
           andalso whichmodule name1 <> name2
   then errormessage 
        (name1^" and "^name2^"  need to originate in the same module")

   else (addwhichmodule name1 name2;
        MODULES:= strongadd name2 
        ((sortfunput2 name1 (Thm name1) (moduleof name2))) (!MODULES);
         droptheorem name1);

(* open the module associated with a theorem *)

(* list of all open modules *)

val OPENMODULES = ref ["bogus"];

(* opens hidden modules *)

fun StrongOpen name = if not (hasmodule name)

    then ()

    else (map (fn (x,y) => addtheorem2 x y) (moduleof name);
          OPENMODULES:=addtoset name (!OPENMODULES));

(* user command which cannot open hidden modules *)

fun Open name = if not(isatheorem name)

    then errormessage ("There is no theorem "^name)

    else if not(hasmodule name)

    then errormessage ("There is no module "^name)

    else if foundinset name (!OPENMODULES) then () else

    (map (fn (x,y) => addtheorem2 x y) (moduleof name);
          OPENMODULES:=addtoset name (!OPENMODULES));

fun PopModule name = 

    if not(foundinset name (!OPENMODULES))

    then errormessage (name^" is not an open module")

    else

	(
    map (fn (x,y) => (addwhichmodule x (whichmodule name);
    if whichmodule name <> "" 
    then (push x (whichmodule name)) else ()))
    (moduleof name);
    MODULES:=strongadd name nil (!MODULES);
    OPENMODULES:=dropfromset name (!OPENMODULES);
    if whichmodule name <> "" then StrongOpen (whichmodule name) else ());

fun Close name = if not(hasmodule name)

    then errormessage ("There is no module "^name)

    else if not(foundinset name (!OPENMODULES)) then () else

    (map (fn (x,y) => (if foundinset x (!OPENMODULES) then Close x else ();
       if isatheorem x then push x name
       else (
      nopausemessage (x^" not found to update while closing  module "^name))))
      (moduleof name);
    OPENMODULES:= dropfromset name (!OPENMODULES));

fun CloseAll() = (map Close (!OPENMODULES);OPENMODULES:=nil);


fun isapretheorem name = foundinset name (!PRETHEOREMS);

(* this version of isstratified posts dependencies to the environment *)

fun Isstratified1 level t = (SCINSCOUT := nil; 
	let val A = isstratified level t in
	((if A then
	(envmod (changedeps2 (union (union2(map Deps (!SCINSCOUT))))))
	else ());SCINSCOUT:=nil;A) end);

fun Isstratified t = Isstratified1 0 t;

(* built-in tactics *)

fun isbuiltinthm name = foundinset name ["EVAL","BIND","UNEVAL",
	"EVALM","BINDM","UNEVALM","FLIP",
	"INPUT","OUTPUT","STOPINPUT","UP","SCOUT","SCIN","SCINL","SCINR",
	"|-|","=",
	"=>>", "<<=","*>","<*","!@","!$","#!"];

(* other aspects of theorems are not usually changed,
but dependencies are more often modified *)

fun changedeps name f = if isatheorem name then

	let val A = hd (find name (!THEOREMS)) in

		(droptheorem name;
		addtheorem name (PreFormatof A) (PreLeftside A) 
			(PreRightside A) (f (PreDeps A))) end

		else ();

(* theorem display command *)

val STATEMENTDISPLAY = ref false;

(* USER COMMAND *)

(* toggle which turns on and off special statement display *)

fun statementdisplay() = (STATEMENTDISPLAY := not (!STATEMENTDISPLAY);
		nopausemessage ("Statement display is "^(if (!STATEMENTDISPLAY)
		then "on" else "off")));

fun eqdisplay fo ls rs dps = if (!STATEMENTDISPLAY) andalso
		rs = Constant "true"

		then output(std_out,(if (!GUIMODE)
                then(!Returns)^"Statement display:"
                else "")^

		(!Returns)^(display fo)^":"^(!Returns)^
		"|-"^(display ls)^(!Returns)^
		(if (!Returns) = "\n" then (dashes())^(!Returns) else "")^
		(display (listtoterm dps))^(!Returns)

                ^(if (!GUIMODE) then ". . ."^(!Returns) else ""))

		else if (!STATEMENTDISPLAY) andalso
		ls = Constant "true"

		then output(std_out,(if (!GUIMODE)
                then(!Returns)^"Statement display:"
                else "")^

		(!Returns)^(display fo)^":"^(!Returns)^
		"$|-"^(display rs)^(!Returns)^
		(if (!Returns) = "\n" then (dashes())^(!Returns) else "")^
		(display (listtoterm dps))^(!Returns)
                ^(if (!GUIMODE) then ". . ."^(!Returns) else ""))

		else output(std_out,(if (!GUIMODE)
                then(!Returns)^"Equation display:"
                else "")^

		(!Returns)^(display fo)^":  "^(!Returns)^
		(display ls)^"   ="^(!Returns)^(display rs)^(!Returns)^
		(if (!Returns) = "\n" then (dashes())^(!Returns) else "")^
		(display (listtoterm dps))^(!Returns)
                ^(if (!GUIMODE) then ". . ."^(!Returns) else ""));

(* USER COMMAND *)

(* display a theorem *)

fun thmdisplay name = if isatheorem name

		then if (!VERBOSITY) > 0 then

		let val (fo,ls,rs,dps) = Thm name in

			(eqdisplay fo ls rs dps;
                        if hasmodule name 
                        then nopausemessage (name^" has an associated module")
                        else ();
                        flush_Out(std_out)) end

		else ()

		else if isbuiltinthm name

		then nopausemessage (name^" is a built in tactic")

		else nopausemessage ("Theorem "^name^" not found");

(* USER COMMAND *)

(* look at dependencies of current environment *)

fun seedeps() = nopausemessage(display(listtoterm(deps(!ENV)))^(!Returns));

(* material related to script reading *)

(* string to hold automatically generated script *)

val AUTOSCRIPT = ref "";

val SCRIPTING = ref false;

val NEXTCHAR = ref "a";  val CHARSYET = ref false;

fun prestringinput file = (

	NEXTCHAR:=input(file,1);

	if (!NEXTCHAR) = "\n" orelse (!NEXTCHAR) = "}" 

	then ""

	(* these lines allow comments in INPUT text in scripts *)

	else if (!NEXTCHAR) = "{" 

		then (prestringinput file;"")

	else if (!NEXTCHAR) = " " then if (!CHARSYET) then " "^
		(prestringinput file)

		else prestringinput file

	else (CHARSYET:=true;(!NEXTCHAR)^(prestringinput file)));

fun quoteextract nil = nil |

    quoteextract ("\""::L) = quoteextract2 L |

    quoteextract  (a::L) = let val M = quoteextract L in
                   if L=M then a::L else M end

and quoteextract2 nil = nil |

     quoteextract2 ("\""::L) = nil |

     quoteextract2 (a::L) = a::(quoteextract2 L);

fun qe s = implode(quoteextract(explode s));

fun stringinput file = (CHARSYET:=false;
        let val T = qe(prestringinput file)
	in if T = "" then qe(stringinput file) else if (!SCRIPTING) then
	(AUTOSCRIPT:=(!AUTOSCRIPT)^T^"\n";T) else T end );

val TESTTH = ref([std_in]);

val DIAGNOSTIC = ref false;

val SAVEINPUT = ref "bogus";


fun inputri s = SAVEINPUT:=s;

(* script machinery *)
(* including scripts for saving and loading theories *)

(* this is incorporated, with minor adaptations for different
tokenization functions, from the full implementation *)

(* it is moved here, up to noml, to support the SHELL builtin
tactic (which is used to get information from inside INPUT tactics) *)

(* the development resumes below at the makescript command *)

(* function for reading line input *)

fun prelineinput commentlevel stringlevel file =

(NEXTCHAR:=input(file,1);

(* ignore anything but closing brace  if comments are being read *)

if commentlevel > 0 

	then if (!NEXTCHAR) = "*"

	then (NEXTCHAR:=input(file,1);
		if (!NEXTCHAR) = ")" then 
		prelineinput (commentlevel-1) stringlevel file
		else prelineinput commentlevel stringlevel file)

	else if (!NEXTCHAR) = "("

	then (NEXTCHAR:=input(file,1);
		if (!NEXTCHAR) = "*" then
		prelineinput (commentlevel+1) stringlevel file
		else prelineinput commentlevel stringlevel file)

	else prelineinput commentlevel stringlevel file

(* from here on we can assume commentlevel = 0 *)

(* tabs are read as spaces *)

else if (!NEXTCHAR) = "\t" then 
	(" "::(prelineinput commentlevel stringlevel file))

(* carriage returns are read as spaces except inside strings, where 
an error occurs *)

(* unclosed string error has been removed; the old code is preserved
in a comment *)

else if (!NEXTCHAR) = "\n"

	then (* if stringlevel = 0 then (" "::
		(prelineinput commentlevel stringlevel file))

	else (errormessage "Unclosed string in script";nil) *)

	(" ":: (prelineinput commentlevel stringlevel file))

else if stringlevel = 1 then 

	if (!NEXTCHAR) = "\"" then "\""::(prelineinput commentlevel 0 file)
	else (!NEXTCHAR)::(prelineinput commentlevel 1 file)

(* we can assume from here on that stringlevel = 0 *)

else if (!NEXTCHAR) = "\"" then

	"\""::(prelineinput commentlevel 1 file)

else if (!NEXTCHAR) = "("

	then (NEXTCHAR:=input(file,1);
		if (!NEXTCHAR)="*" 
			then prelineinput (commentlevel+1) stringlevel file
		else if (!NEXTCHAR)=")"
			then "()"::(prelineinput commentlevel stringlevel file)
			else (errormessage 
			"Incomprehensible parenthesis in script";nil))

else if (!NEXTCHAR) = ";" then nil

else (!NEXTCHAR)::(prelineinput commentlevel stringlevel file));

(* the lineinput command extracts the next command line from a
script file *)

fun lineinput file = let val T = implode(strip((prelineinput 0 0 file)))
		in if (!SCRIPTING) 
		then (AUTOSCRIPT:=(!AUTOSCRIPT)^T^";\n";T) else T end;

fun listsafefind default s nil = default |
	listsafefind default s ((t,x)::L) = if s = t then x 
	else listsafefind default s L;

fun listaddto s x L = (s,x)::L;

(* reference holding all current commands *)

val MENU = ref [("seedeps",seedeps)];

val MENUNAME = ref "main";

(* main command menu *)

val MAINMENU = ref (!MENU);

(* load/save menu *)

val LOADMENU = ref (!MENU);

(* the secure menu -- commands allowed when prover is paused *)

val SECUREMENU = ref (!MENU);

val CURRENTMENU = ref(!MENU);

val CURRENTMENUNAME = ref "bogus";

fun mainmenu() = (MENUNAME:="main";MENU := (!MAINMENU));

fun loadmenu() = (MENUNAME:="load";MENU := (!LOADMENU));

fun securemenu() = (MENUNAME:= "secure";MENU := (!SECUREMENU));

fun setcurrentmenu() = (CURRENTMENU:=(!MENU);CURRENTMENUNAME:=(!MENUNAME));

fun currentmenu() = (MENUNAME:=(!CURRENTMENUNAME);MENU:=(!CURRENTMENU));

(* reference to string of arguments of current line *)

val ARGUMENTS = ref (explode(""));

val ARGUMENTS2 = ref (explode(""));

fun executeline s = let val command = implode(getalpha(explode s)) in

(ARGUMENTS:=(restalpha(explode s)); 
listsafefind (fn () => (errormessage ("Unknown command "^
command^" in script")))
command (!MENU))() end;

fun getchararg1 nil = "" |
	getchararg1 ("\""::M) = "" |
	getchararg1 (x::M) = x^(getchararg1 M);

fun restchararg nil = nil |
	restchararg ("\""::M) = M |
	restchararg (x::M) = restchararg M;

val TEMPCHARARG = ref "bogus";


fun getchararg L = if (strip L) = nil orelse hd (strip L) <> "\""
	then (errormessage "Character argument in script not found";"")
	else (ARGUMENTS:=restchararg (tl(strip L));
		getchararg1 (tl(strip L)));


fun readalldigits2 L = evalnum(rev(getnumeral(L)));

fun getintarg L = if (strip L) = nil orelse
		(strip L) = ["~"] orelse
		(hd (strip L) = "~" andalso not (isdigit (hd(tl (strip L)))))
		orelse (hd (strip L) <> "~" 
		andalso not (isdigit (hd (strip L))))
	then (errormessage "Integer argument in script not found";0)
	else (ARGUMENTS:= (if hd(strip L) = "~"
	then restnumeral (tl(strip L))
	else restnumeral (strip L));
	if hd(strip L) = "~" then 
		(~1)*(readalldigits2(getnumeral(tl(strip L))))
	else readalldigits2(getnumeral (strip L)));


(* val TESTTH = ref([std_in]); *)

val SAVELINE = ref "bogus";

(* val DIAGNOSTIC = ref false; *)

val DEMO = ref false;

(* USER COMMANDS (2) *)

fun diagnostic() = (DIAGNOSTIC := not (!DIAGNOSTIC);
	nopausemessage ("Diagnostic mode is "
	^(if (!DIAGNOSTIC) then "on" else "off")));

(* June 25:  turning demo mode on causes speakup; turning it off
causes thmsonly; users should only have any occasion to turn demo
mode off inside scripts, since the end of the top level script
now turns it off *)

val TURNOFFPROMPT =ref false;

fun demo() = ((if (!DEMO) then thmsonly()
        else (speakup();TURNOFFPROMPT:=false));
        diagnostic(); DEMO:=not(!DEMO);
	nopausemessage ("Demo mode is "^(if (!DEMO) then "on" else "off")));


val SCRIPTFILE = ref std_out;

fun autoscript s = (
SCRIPTFILE:=open_out(s^".log.wat");
output((!SCRIPTFILE),(!AUTOSCRIPT));
flush_Out(!SCRIPTFILE);
close_out(!SCRIPTFILE));

val load_EXT = ref ".wat";

fun setloadext s = (load_EXT := s);

(* we prevent any activity during execution of a file from
being automatically scripted *)

val OLDSCRIPTING = ref false;

(* this is the latest GUI version.  It supports demo mode again.
The internals of how the prompt parameter is used are weird. *)

exception Breakout2;

fun executelines prompt file =

(SAVELINE := lineinput file;
let val thecommand = implode(getalpha(explode(!SAVELINE))) in
if
not(foundin thecommand (!MENU)) then

	if thecommand = "quit" 
        orelse thecommand = "q"
        orelse thecommand = ""
	then ()
        else errormessage 
	(thecommand^" is not a "^(!MENUNAME)^" command")
else (
if (!DIAGNOSTIC) then (output(std_out,(!Returns)^(!SAVELINE)^";"^(!Returns));
flush_Out(std_out)) else ();
executeline (!SAVELINE);
if (strip(!ARGUMENTS))<>nil 
andalso 

(* implode(strip(!ARGUMENTS))<>"()" *)

(length(strip(!ARGUMENTS))<2 orelse hd(strip(!ARGUMENTS)) <> "(" orelse
hd(tl(strip(!ARGUMENTS))) <> ")" 
orelse strip(tl(tl(strip(!ARGUMENTS)))) <> nil)

then (ARGUMENTS2:=(!ARGUMENTS);ARGUMENTS:=nil;errormessage 
("Argument list not used up:  "^(implode(!ARGUMENTS2)))) else ();

if prompt = "" andalso (not(!DEMO)) then () 
else (output(std_out,"\nWatson> ");flush_Out(std_out));
if (!DEMO) andalso prompt <> "Watson> "
then suspend(fn()=>executelines prompt file) else
executelines prompt file) end)

and executefile prompt s = (
	TESTTH := ((if s = "std_in" then std_in else open_in (s^(!load_EXT)))
		::(!TESTTH));
	executelines (if s="std_in" then "Watson> " else "") (hd(!TESTTH)); 	
	if s <> "std_in" then close_in (hd(!TESTTH)) else ();
	TESTTH := tl(!TESTTH))

and suspend f = (nopausemessage "Paused";setcurrentmenu(); securemenu();
executefile "" "std_in";currentmenu();f()) handle Breakout2 => 
        (currentmenu();
	TESTTH := tl(!TESTTH));

(* dummy command here; it is an exit command in a script *)

fun quit() = ();

(* demo mode comment function *)

fun demoremark s = ();

fun showsometheorems filter nil = () |
showsometheorems filter ((na,x)::L) = 

		if filter na andalso hd(explode na) <> "}"

		then (thmdisplay na;suspend (fn ()=>showsometheorems filter L))

                else showsometheorems filter L;

fun showalltheorems() = (showsometheorems (fn x => true) (sortfun(!THEOREMS)));

(* shows axioms and definitions *)

fun showaxioms() = (showsometheorems (fn x => foundinset x (Deps x)) 
	(sortfun(!THEOREMS)));

fun showmodule thm = if not(hasmodule thm) 

   then errormessage ("There is no module "^thm)
   else (StrongOpen thm;showsometheorems (fn x => true) (moduleof thm);Close thm);

(* definition facility *)

(* definitions require a second stratification function, whose 
object is to type free variables so that implicitly defined functions
behave correctly *)

(* list of all free variables (including infix variables) in
a given term *)

(* it is possible that some glitches will arise from including infix
variables *)

fun freevarlist  (FreeVar s) = [s] |

	freevarlist (Infix(u,VarOp s,v)) = addtoset s (union (freevarlist  u) 
		(freevarlist  v)) |

	freevarlist  (Infix(u,i,v)) = union (freevarlist  u) 
		(freevarlist  v) |

	freevarlist  (Function t) = freevarlist  t |

	freevarlist  (CaseExp(u,v,w)) = union
		(freevarlist  u) (union
		(freevarlist  v)(freevarlist  w)) |

	freevarlist  t = nil;

(* variant which does not include infix variables, introduced to support
autoformat built-in tactics *)

fun freevarlist2  (FreeVar s) = [s] |

	freevarlist2  (Infix(u,i,v)) = union (freevarlist2  u) 
		(freevarlist2  v) |

	freevarlist2  (Function t) = freevarlist2  t |

	freevarlist2  (CaseExp(u,v,w)) = union
		(freevarlist2  u) (union
		(freevarlist2  v)(freevarlist2  w)) |

	freevarlist2  t = nil;

(*

fun strat2  localtype (Constant s) = [nil] |

	strat2  localtype (FreeVar s) = [[(s,rigid_type(localtype))]] |

	strat2  localtype (Numeral s) = [nil] |

	strat2  localtype (BoundVar s) = [nil] |

	strat2  localtype (Function s) = 
		(strat2 (localtype-1) s) |

	strat2  localtype (CaseExp(t,u,v)) =

		mergestrats((float_list(strat2  localtype t)))
		(mergestrats(strat2  localtype u)
			(strat2  localtype v)) |

(*	strat2  localtype (Infix(t,ResOp":",u)) =

		mergestrats (strat2  (localtype+1) t) 
		(float_list (strat2  localtype u)) | *)

        strat2 localtype (Infix(t,ResOp":",u)) =

               if (strat2  (localtype) t) = [nil]

               then (float_list (strat2  localtype u))

               else nil |

	strat2 localtype (Infix(Constant f,ResOp "@",t)) =
		(
		(if isscout f orelse isscinright f then float_list else 
                (fn x => x))
		(strat2 localtype t)) |

	strat2  localtype (Infix(t,i,u)) =

		if istypedoperator (opdisplay i)

		then
		(
		(if isscout (opdisplay i) then float_list else (fn x => x))
		(mergestrats

		((if isscinleft (opdisplay i) then float_list else (fn x => x))
		(strat2  (lefttype(opdisplay i)+localtype) t))

		((if isscinright (opdisplay i) then 
                    float_list else (fn x => x))
		(strat2  (righttype(opdisplay i)+localtype) u))))

		else (* case of opaque or undeclared variable operators *)

		if freevarlist  (Infix(t,i,u)) = nil
		andalso strat2 0 t <> nil
		andalso strat2 0 u <> nil
		then [nil] else nil;

*)

fun prestrat2 level localtype (Constant s) = [nil] |

	prestrat2 level localtype (FreeVar s) = [[(s,rigid_type(localtype))]] |

	prestrat2 level localtype (Numeral s) = [nil] |

	prestrat2 level localtype (BoundVar s) = if s = 0 then [nil] else 
		[[(makestring s,rigid_type(localtype))]] |

	prestrat2 level localtype (Function s) = map (drop
                (makestring(level+1)))
		(mergestrats
			(prestrat2 (level+1) (localtype-1) s)
			[[(makestring(level+1),rigid_type(localtype-1))]]) |

	prestrat2 level localtype (CaseExp(t,u,v)) =

		mergestrats(float_list(prestrat2 level localtype t))
		(mergestrats(prestrat2 level localtype u)
			(prestrat2 level localtype v)) |

(*	strat level localtype (Infix(t,ResOp":",u)) =

		mergetypes (strat level (localtype+1) t) 
		(checkappend [nil] (strat level localtype u)) | 

*)

        prestrat2 level localtype (Infix(t,ResOp":",u)) =

                if (prestrat2 level (localtype) t = [nil])

                then (float_list (prestrat2 level localtype u))

                else nil |

	prestrat2 level localtype (Infix(Constant f,ResOp "@",t)) =
		
		(if (* level = 0 
			orelse *) isscout f orelse isscinright f 
			then float_list  else (fn x => x))
		(prestrat2 level localtype t) |

        prestrat2 level localtype 
	(Infix(Infix(t,ResOp"@*",m),ResOp"@*",n)) =

                let val N = prestrat2 level localtype n in

                if metafree n then

		mergestrats (displace_list (fresh_type_var_index()) N)
		(prestrat2 level (localtype) (Infix(t,ResOp"@*",m)))

                else nil  end |

        prestrat2 level localtype (Infix(FreeVar t,ResOp "@*",n)) =

                let val N = prestrat2 level localtype n in

                if metafree n then

	        displace_list (fresh_type_var_index()) N

                else nil end

		|

	prestrat2 level localtype (Infix(t,ResOp"@*",u)) = nil |


	prestrat2 level localtype (Infix(t,i,u)) =

		if istypedoperator (opdisplay i)

		then
		
		(if (* level = 0 orelse *)
                isscout (opdisplay i) then float_list else                
                (fn x => x))
		(mergestrats

		((if (* level = 0 
			orelse *) isscinleft (opdisplay i) then float_list else 
                        (fn x => x))
		(prestrat2 level (lefttype(opdisplay i)+localtype) t))

		((if (* level = 0 orelse *)
			isscinright (opdisplay i) then float_list else 
                        (fn x => x))
		(prestrat2 level (righttype(opdisplay i)+localtype) u)))

		else (* case of opaque or undeclared variable operators *)

		if boundvarlist level (Infix(t,i,u)) = nil
		andalso prestrat2 level 0 t <> nil
		andalso prestrat2 level 0 u <> nil
		then [nil] else nil;

fun strat2 localtype t = prestrat2 0 localtype t;


fun isstrat2 t = (reset_type_var_index();strat2 0 t <> nil);

(* functions used to define format for left sides of definitions *)
(* other functions, used to define format for parameter lists of tactics,
are also given here *)

fun iterconvar (FreeVar s) = true |

	iterconvar (Function t) = iterconvar t |

	iterconvar t = false;

fun pairsovervars (Infix(u,ResOp ",",v)) = 
		(pairsovervars u) andalso (pairsovervars v) |

	pairsovervars t = iterconvar t;

fun atomdefinitionformat (Constant s) = s<>"" |

	atomdefinitionformat (Infix(u,ResOp"@",v)) = (atomdefinitionformat u)
		andalso (pairsovervars v) |

	atomdefinitionformat t = false;

fun opdefinitionformat (Infix(x,ConOp s,y)) = 
	s<>"" andalso (
	(x = (stringtocon (prefixof s)) orelse
	(pairsovervars x)) andalso (pairsovervars y)) |

	opdefinitionformat (Infix(u,ResOp"@",v)) = (opdefinitionformat u)
		andalso (pairsovervars v) |

	opdefinitionformat t = false;

fun opaqueopdefinitionformat (Infix(x,ConOp s,y)) = 
	s<>"" andalso (
	(x = (stringtocon (prefixof s)) orelse
	(pairsovervars x)) andalso (pairsovervars y)) |

	opaqueopdefinitionformat t = false;

fun atomhead (Constant s) = s |

	atomhead (Infix(x,ResOp"@",y)) = atomhead x |

	atomhead t = "";

fun ophead (Infix(u,ResOp"@",v)) = ophead u |

	ophead (Infix(x,ConOp s,y)) = s |

	ophead (Infix(x,ResOp s,y)) = s |

	ophead t = "";

fun eitherhead x = if atomhead x = "" then ophead x else atomhead x;

(* formats used by parameterized tactics *)

fun weakpairsovervars (Infix(u,ResOp ",",v)) = 
		(weakpairsovervars u) andalso (weakpairsovervars v) |

	weakpairsovervars (Infix(u,VarOp s,v)) = 
		if isstrictprefix s 
		then u = Constant "" andalso (weakpairsovervars v)
		else (weakpairsovervars u) andalso (weakpairsovervars v) |

	weakpairsovervars t = iterconvar t;

fun weakatomdefinitionformat (Constant s) = s<>"" |

	weakatomdefinitionformat (Infix(u,ResOp"@",v)) = 
	(weakatomdefinitionformat u)
		andalso (weakpairsovervars v) |

	weakatomdefinitionformat t = false;


fun weakopdefinitionformat (Infix(u,ResOp"@",v)) = 
		(weakopdefinitionformat u)
		andalso (weakpairsovervars v) |

	weakopdefinitionformat (Infix(x,i,y)) = 
	(((opdisplay i) <>"" andalso (
	(x = (stringtocon (prefixof (opdisplay i)))))) orelse
	(weakpairsovervars x)) andalso (weakpairsovervars y) |

	weakopdefinitionformat t = false;

(* a variation on the "head" functions allowing variables
and reserved operators where appropriate *)

(* also used for parameterized tactics rather than general
functions *)

fun varatomhead (Constant s) = s |

	varatomhead (FreeVar s) = s |

	varatomhead (Infix(x,ResOp"@",y)) = varatomhead x |

	varatomhead t = "";

fun varophead (Infix(x,ConOp s,y)) = s |

	varophead (Infix(x,ResOp s,y)) = if s = "@" then varophead x else s |

	varophead (Infix(x,VarOp s,y)) = s |

	varophead t = "";

fun eithervarhead t = 
	if varatomhead t = "" then varophead t else varatomhead t;

(* the list of defined constants and operators
with defining theorems *)

val DEFINITIONS = ref [("bogus","bogus")];

(* the converse of the definition list *)

val DEFINITIONS2 = ref [("bogus","bogus")];

(* DEFINITIONS:=nil;  DEFINITIONS2:= nil; *)

fun adddef name named = (DEFINITIONS:=addto name named (!DEFINITIONS);
			DEFINITIONS2:= addto named name (!DEFINITIONS2));

fun isdefinition name = foundin name (!DEFINITIONS);

fun isdefined name = foundin name (!DEFINITIONS2);

fun definitionof named = safefind "" named (!DEFINITIONS2);

(* USER COMMAND *)

fun showdef s = if isdefined s then thmdisplay (definitionof s)
                else nopausemessage (s^" is not defined.");

fun showscout s = if not(isscout s) then nopausemessage (s^" is not scout")
                  else thmdisplay (scoutof s);

fun showscin s = if not(isscinleft s) andalso not(isscinright s)
                 then nopausemessage (s^" has no scin properties")
                 else if scinleftof s = scinrightof s 
                 then thmdisplay (scinleftof s)
                 else (if isscinleft s then thmdisplay (scinleftof s) else ();
                 if isscinright s then thmdisplay (scinrightof s) else ());


(* scin/scout functions *)

(* is the theorem s = t of the correct form to verify that an
operator or function is scout? *)

fun scoutform S (Infix(Constant s,ResOp"@",FreeVar x))
	(Infix(t,ResOp":",(Infix(Constant s2,ResOp"@",FreeVar x2)))) = 
	if S <> s orelse s<>s2 orelse x<>x2 then false else
	let val A = strat2 0 t in 
	if A = nil then false
	else (A = [nil]) end |

	scoutform S (Infix(t,ResOp":",(Infix(Constant s,ResOp"@",FreeVar x))))
	(Infix(Constant s2,ResOp"@",FreeVar x2)) =
	if S <> s orelse s<>s2 orelse x<>x2 then false else
	let val A = strat2 0 t in 
	if A = nil then false
	else (A = [nil]) end |

	scoutform  S (Infix(FreeVar s,i,FreeVar t))
	(Infix(T,ResOp":",(Infix(FreeVar s2,i2,FreeVar t2)))) =
	if S <> (opdisplay i) orelse s <> s2 orelse t <> t2 
	orelse i<>i2 then false else
	let val A = strat2 0 T in 
	if A = nil then false
	else (A = [nil]) end |

	scoutform S (Infix(T,ResOp":",(Infix(FreeVar s,i,FreeVar t))))
	(Infix(FreeVar s2,i2,FreeVar t2)) =
	if S <> (opdisplay i) orelse s <> s2 orelse t <> t2 
	orelse i <> i2 then false else
	let val A = strat2 0 T in 
	if A = nil then false
	else (A = [nil]) end | 

	scoutform  S (Infix(Constant "",i,FreeVar t))
	(Infix(T,ResOp":",(Infix(Constant "",i2,FreeVar t2)))) =
	if S <> (opdisplay i) orelse t <> t2 
	orelse i<>i2 then false else
	let val A = strat2 0 T in 
	if A = nil then false
	else (A = [nil]) end |

	scoutform S (Infix(T,ResOp":",(Infix(Constant "",i,FreeVar t))))
	(Infix(Constant "",i2,FreeVar t2)) =
	if S <> (opdisplay i) orelse t <> t2 
	orelse i <> i2 then false else
	let val A = strat2 0 T in 
	if A = nil then false
	else (A = [nil]) end |

	scoutform S t u = false;

(* function used by the built-in SCOUT theorem to determine
the directionality of the scout witness theorem 
(SCOUT always adds a type label *)

(* the other -dir theorems below are similarly motivated *)

fun scoutdir u (Infix(t,ResOp":",u0)) = "=>" |

   scoutdir (Infix(t,ResOp":",u)) u0 = "<=" |

   scoutdir u v = "";

(* used to reverse sense of output of -dir functions
when appropriate *)

fun reversedir "=>" = "<=" |

   reversedir "<=" = "=>" |

   reversedir s = "";

(* make an operator scout if given a theorem of the appropriate form *)

fun makescout s thm = (if isscout s then nopausemessage (s^" is already scout")
        else ();

	if scoutform s (Leftside thm) (Rightside thm)

	then (SCOUT:=strongadd s thm (!SCOUT))
	else errormessage ("Scout declaration of "^s^" using "^thm^" failed"));

(* is a theorem of the correct form to declare an operator "scin"
(both left and right)? *)

fun scinform S (Infix(Constant s,ResOp"@",t))

	(Infix(Constant s2,ResOp"@",Infix(T,ResOp":",t2))) = 

	if S <> s orelse s <> s2 orelse t <> t2 then false
	else let val A = strat2 0 T in
	if A = nil then false
	else (A = [nil]) end |

	scinform S (Infix(Constant s,ResOp"@",Infix(T,ResOp":",t)))

		(Infix(Constant s2,ResOp"@",t2)) =	
	if S <> s orelse s <> s2 orelse t <> t2 then false
	else let val A = strat2 0 T in
	if A = nil then false
	else (A = [nil]) end |

	scinform S (Infix(FreeVar x,i,FreeVar y))

		(Infix(Infix(T,ResOp":",FreeVar x2),i2,
			Infix(U,ResOp":",FreeVar y2))) =

	if S <> (opdisplay i) orelse x <> x2 orelse y <> y2
		then false
		else let val A = strat2 0 T and B = strat2 0 U in
		if A = nil orelse B = nil then false
		else (A = [nil]) andalso (B = [nil]) end  |

	scinform S (Infix(Infix(T,ResOp":",FreeVar x),i,
			Infix(U,ResOp":",FreeVar y)))

		(Infix(FreeVar x2,i2,FreeVar y2)) = 

		if S <> (opdisplay i) orelse x <> x2 orelse y <> y2
			orelse i <> i2
		then false
		else let val A = strat2 0 T and B = strat2 0 U in
		if A = nil orelse B = nil then false
		else (A = [nil]) andalso (B = [nil]) end  | 

	scinform S (Infix(Constant "",i,FreeVar y))

		(Infix(Constant "",i2,
			Infix(U,ResOp":",FreeVar y2))) =	

		if S <> (opdisplay i) orelse y <> y2 orelse i <> i2
		then false
		else let val B = strat2 0 U in
		if B = nil then false
		else (B = [nil]) end  |

	scinform S (Infix(Constant "",i,
			Infix(U,ResOp":",FreeVar y)))

		(Infix(Constant "",i2,FreeVar y2)) =	
	
		if S <> (opdisplay i) orelse y <> y2 orelse i <> i2
		then false
		else let val B = strat2 0 U in
		if B = nil then false
		else (B = [nil]) end |

	scinform s t u = false;

fun scindir (Infix(u,i,v)) 
      (Infix(Infix(t1,ResOp":",u0),i0,Infix(t2,ResOp":",v0))) = "=>" |

scindir (Infix(Infix(t1,ResOp":",u),i,Infix(t2,ResOp":",v)))(Infix(u0,i0,v0)) =
      "<=" |

scindir (Infix(u,i,v)) (Infix(u0,i0,Infix(t,ResOp":",v0))) = "=>" |

scindir (Infix(u,i,Infix(t,ResOp":",v)))(Infix(u0,i0,v0)) = "<=" |

scindir u v = "";

fun scinleftform S (Infix(FreeVar x,i,FreeVar y))

		(Infix(Infix(T,ResOp":",FreeVar x2),i2,
			FreeVar y2)) =

	if S <> (opdisplay i) orelse x <> x2 orelse y <> y2
		then false
		else let val A = strat2 0 T in
		if A = nil then false
		else (A = [nil]) end  |

	scinleftform S (Infix(Infix(T,ResOp":",FreeVar x),i,
			FreeVar y))

		(Infix(FreeVar x2,i2,FreeVar y2)) = 

		if S <> (opdisplay i) orelse x <> x2 orelse y <> y2
			orelse i <> i2
		then false
		else let val A = strat2 0 T in
		if A = nil then false
		else (A = [nil]) end  |

	scinleftform s t u = false;

fun scinleftdir (Infix(u,i,v)) (Infix(Infix(t,ResOp":",u0),i0,v0)) = "=>" |

scinleftdir (Infix(Infix(t,ResOp":",u),i,v))(Infix(u0,i0,v0)) = "<=" |

scinleftdir u v = "";


fun scinrightform S (Infix(FreeVar x,i,FreeVar y))

		(Infix(FreeVar x2,i2, Infix(T,ResOp":",FreeVar y2))) =

	if S <> (opdisplay i) orelse x <> x2 orelse y <> y2
		then false
		else let val A = strat2 0 T in
		if A = nil then false
		else (A = [nil]) end  |

	scinrightform S (Infix(FreeVar x,i, Infix(T,ResOp":",FreeVar y)))  
		(Infix(FreeVar x2,i2,FreeVar y2)) =

		if S <> (opdisplay i) orelse x <> x2 orelse y <> y2
			orelse i <> i2
		then false
		else let val A = strat2 0 T in
		if A = nil then false
		else (A = [nil]) end  |

	scinrightform s t u = false;

fun scinrightdir (Infix(u,i,v)) (Infix(u0,i0,Infix(t,ResOp":",v0))) = "=>" |

scinrightdir(Infix(u,i,Infix(t,ResOp":",v)))(Infix(u0,i0,v0)) = "<=" |

scinrightdir u v = "";

(* USER COMMANDS (3) *)

(* make an operator scin(left/right) if an appropriate 
witness theorem is given *)

fun makescin s thm = (if isscinleft s andalso isscinright s

	then nopausemessage (s^" is already scin") else();

	if scinform s (Leftside thm) (Rightside thm)

	then (SCINLEFT:= strongadd s thm (!SCINLEFT);
	SCINRIGHT:= strongadd s thm (!SCINRIGHT))

	else errormessage ("Scin declaration of "^s^" using "^thm^" failed"));

fun makescinvar s = if s = "" orelse stringtoop s <> VarOp s orelse
	istypedoperator s orelse isopaque s

	then errormessage(s^" cannot be made a scin infix variable")

	else (declareinfix s;SCINLEFT:= addto s "" (!SCINLEFT);
	SCINRIGHT:= addto s "" (!SCINRIGHT));

fun makescinleft s thm = if scinleftof s <> "" andalso

        scinleftof s = scinrightof s

        then nopausemessage ("makescin must be used with scin operator "^s)

        else

        (if isscinleft s

	then nopausemessage (s^" is already scinleft") else ();

	if scinleftform s (Leftside thm) (Rightside thm)

	then (SCINLEFT:= strongadd s thm (!SCINLEFT))

	else errormessage ("Scinleft declaration of "^s^" using "
		^thm^" failed"));

fun makescinright s thm = if scinleftof s <> "" andalso

        scinleftof s = scinrightof s

        then nopausemessage ("makescin must be used with scin operator "^s)

        else


        (if isscinright s

	then nopausemessage (s^" is already scinright")else();

	if scinrightform s (Leftside thm) (Rightside thm)

	then (SCINRIGHT:= strongadd s thm (!SCINRIGHT))

	else errormessage ("Scinright declaration of "^s^" using "
		^thm^" failed"));

(* is the equation of the second and third arguments a theorem to
the effect that Constant S is a retraction?   Used by typedefinition
below. *)

(* prove command and variations -- note that the prove command needs
to know about definition format! *)

(* the use of weak definition formats effectively allows operator
variable parameters to parameterized tactics *)

(* definition dependencies of a term can be read from the
term (no need to maintain in environment); if a defined term
does not appear in a theorem, then the proof of the theorem
could in principle have been carried out without reference
to the definition at all 

This indicates that definitions can go back to null axiom dependencies
if a separate definition dependency scheme is maintained; 

master definition dependency list needs references to all constants,
not just to theorems, so is naturally not part of the theorems list.
The master theorem-text dependency list will also be separate,
though it could more naturally be part of the theorem list *)

(* management of theorem text and definition dependencies of theorems,
which will support reaxiomatization, redefinition, 
and theorem export facilities *)

val DEFDEPS = ref [("bogus",["bogus"])];

val DEFDEPS2 = ref [("bogus",["bogus"])];  (* inverse list *)

fun defdeps s = safefind nil s (!DEFDEPS);

fun defdeps2 s = safefind nil s (!DEFDEPS2);

(* now should update inverse list correctly *)

fun adddefdep s L = (
	map(fn x=>let val A = find x (!DEFDEPS2) in
	DEFDEPS2:=strongadd x
	(if A = nil then nil else (dropfromset s (hd A)))(!DEFDEPS2)end)
	(defdeps s);
	DEFDEPS:= strongadd s L (!DEFDEPS);
	map(fn x => 
	DEFDEPS2:= strongadd x
	(let val A = find x (!DEFDEPS2) in
	if A = nil then [s] else addtoset s (hd A) end) (!DEFDEPS2)) L;());

(* lists defined constants and operators not appearing in embedded theorems *)
(* also picks up dependencies of defined terms from (!DEFDEPS) *)

(* the thm parameter is a technicality for blocking references to
the defining theorem (which is then the same as the defined object)
within the definition *)

fun conlist2 thm (Constant "") = nil |

	conlist2 thm (Constant s) = if isdefined s
				then if definitionof s = thm then [thm]
				else addtoset (definitionof s) 
					(defdeps (definitionof s))
				else nil |

	conlist2 thm (Function t) = conlist2 thm t |

	conlist2 thm (CaseExp(u,v,w)) = union (conlist2 thm u)
		(union(conlist2 thm v)(conlist2 thm w)) |

	conlist2 thm (Infix(x,ResOp "=>",y)) = conlist2 thm y |

	conlist2 thm (Infix(x,ResOp "<=",y)) = conlist2 thm y |

	conlist2 thm (Infix(x,i,y)) = union
		(if isdefined (opdisplay i) then if definitionof(opdisplay i)
					= thm then [thm]

					else addtoset 
					(definitionof (opdisplay i)) 
					(defdeps (definitionof (opdisplay i)))
				else nil)
		(union (conlist2 thm x) (conlist2 thm y)) |

	conlist2 thm t = nil;
	
fun makedefdeps thm = if isatheorem thm then

		let val (fo,rt,lt,dps) = Thm thm in

		(
		adddefdep thm
			(union(conlist2 thm lt)(conlist2 thm rt));

		map (fn (x) => if x <> thm
		then makedefdeps x else ()) (defdeps2 thm);())

		end

		else errormessage (thm^" is not a theorem");

(* list of all constants (including infixes) on which a term depends,
used by theorem text deps functions *)

fun conlist (Constant "") = nil |

	conlist (Constant s) = [s] |

	conlist (Infix(x,ConOp s,y)) = addtoset s 
			(union (conlist x) (conlist y)) |
	conlist (Infix(x,ResOp s,y)) = addtoset s 
			(union (conlist x) (conlist y)) |
	conlist (Infix(x,VarOp s,y)) = 
			(union (conlist x) (conlist y)) |
	conlist (Function s) = conlist s |
	conlist (CaseExp(u,v,w)) = union (conlist u) (union (conlist v)
							(conlist w)) |
	conlist t = nil;

val THMTEXTDEPS = ref [("bogus",["bogus"])];

val THMTEXTDEPS2 = ref [("bogus",["bogus"])];

fun thmtextdeps s = safefind nil s (!THMTEXTDEPS);

fun thmtextdeps2 s = safefind nil s (!THMTEXTDEPS2);

(* now should update inverse list correctly *)

fun addthmtextdep s L = (
	map(fn x=>let val A = find x (!THMTEXTDEPS2) in
	THMTEXTDEPS2:=strongadd x
	(if A = nil then nil else (dropfromset s (hd A)))(!THMTEXTDEPS2)end)
	(thmtextdeps s);
	THMTEXTDEPS:= strongadd s L (!THMTEXTDEPS);
	map(fn x => 
	THMTEXTDEPS2:= strongadd x
	(let val A = find x (!THMTEXTDEPS2) in
	if A = nil then [s] else addtoset s (hd A) end) (!THMTEXTDEPS2)) L;());

fun isatheorem2 s = isatheorem s orelse isapretheorem s;

(* determine the text dependencies of a term, L being a list
of known recursive dependencies *)

(* make this dynamic; it updates the text dependencies as it goes
and it short circuits the recursive process where it knows the work
has already been done *)

val DONELIST = ref ["bogus"];  
(* list of theorems whose text dependencies have
already been updated *)

(* the user "push" command *)

(* everything that uses name1 and does not use name2 gets pushed into name2 *)

(* this command should be safe to use at any time? *)

fun isaconstantterm (Constant s) = true |
isaconstantterm t = false;

fun ispureequation t = isatheorem t andalso isaconstantterm(Formatof t)
                       andalso rulefree(Rightside t);

(* blocking pure equations from being put into modules protects
axioms, definitions, scin/scout theorems, and protects the automatic
theorem search facilities *)

fun Push name1 name2 = 

if (!ERRORFLAG) then errormessage 
("Aborted Push "^name1^" "^name2^" due to errors")

else if (not(isatheorem name2)) then 
errormessage (name2^" is not a theorem")

(* else if foundin name1 (moduleof name2) then
nopausemessage (name1^" is already in module "^name2) *)

else if (not(isatheorem name1)) then
if foundin name1 (moduleof name2) then
nopausemessage (name1^" is already in module "^name2)
else errormessage (name1^" is not a theorem")

else if ispureequation name1

then errormessage 
("Pure equation "^name1^" cannot be put in module "^name2)

else (push name1 name2;map (fn x =>
if not(isatheorem x) orelse x = name2 
orelse not(foundinset name1 (conlist (Rightside x))) then ()
else (Push x name2))
(thmtextdeps2 name1); if (!ERRORFLAG) then PopModule name2 else ());

(* stronger version of Close, becomes the user command *)

fun Close name = if not(hasmodule name)

    then errormessage ("There is no module "^name)

    else if not(foundinset name (!OPENMODULES)) then () else

    (map (fn (x,y) => (if foundinset x (!OPENMODULES) then Close x else ();
       if isatheorem x then Push x name
       else ()))
      (moduleof name);
    OPENMODULES:= dropfromset name (!OPENMODULES));

fun StrongCloseAll() = (map Close (!OPENMODULES);OPENMODULES:=nil);

fun conlist4 L (Constant "") = nil |

	conlist4 L (Constant s) = if (not (foundinset s L)) andalso
					foundinset s (!DONELIST)

				then thmtextdeps s  (* short circuit! *)

				
				else if isatheorem s 
				then if foundinset s L then thmtextdeps s
				else (if hasmodule s then StrongOpen s else ();
				let val LL =
				addtoset s (union (conlist4 (addtoset s L)
				(Leftside s))(conlist4 (addtoset s L)
				(Rightside s)))

				in (DONELIST:=addtoset s (!DONELIST);
					addthmtextdep s 
					(LL);LL)

				end)	
				else if isdefined s
				then if foundinset (definitionof s) L then 
					thmtextdeps (definitionof s)
				else
				(conlist4 L
				(Constant (definitionof s)))
				
				else if isapretheorem s then [s]
				else nil |

	conlist4 L (Function t) = conlist4 L t |

	conlist4 L (CaseExp(u,v,w)) = union (conlist4 L u)
		(union(conlist4 L v)(conlist4 L w)) |

	conlist4 L (Infix(x,i,y)) =

			union (conlist4 L x)

			(union (conlist4 L y)

			(conlist4 L (Constant (opdisplay i))))

			|

	conlist4 L t = nil;

fun makethmtextdeps1 thm = if isatheorem thm then

		let val LIST =
			(conlist4 nil (Constant thm)) in

		(
		addthmtextdep thm LIST;

		map (fn x => if (foundinset x (!DONELIST))
		then if foundinset thm (thmtextdeps x)

		then addthmtextdep x LIST else ()

		else makethmtextdeps1 x) (thmtextdeps2 thm);())

		end

		else errormessage (thm^" is not a theorem");

fun makethmtextdeps thm = (DONELIST:=nil;makethmtextdeps1 thm;
		DONELIST:=nil);


(* modification to note that definition deps of an axiom cannot
be removed from a theorem using the axiom *)

fun fixdeps thm = (makethmtextdeps thm;makedefdeps thm;
        if isatheorem thm then
	let val (fo,lt,rt,dps) = Thm thm in
	addtheorem thm fo lt rt
	(sortset((setminus dps 
	(setminus (separate isdefinition dps) 
	(union(defdeps thm)(union2(map defdeps 
	(separate (fn x => not(isdefinition x)) dps))))))))
	end
	else ());

(* USER COMMAND *)

(* see all dependencies of a theorem *)

fun showalldeps thm = if isatheorem thm then

	output(std_out,(!Returns)^"axiomatic:"^(!Returns)
	^(display(listtoterm (sortset(Deps thm))))
	^(!Returns)^"definition:"^(!Returns)
	^(display(listtoterm (sortset(defdeps thm))))^(!Returns)^
	"theorem text:"^(!Returns)
	^(display(listtoterm(sortset(thmtextdeps thm))))^(!Returns))
	
	else if isbuiltinthm thm 

	then nopausemessage (thm^" is a built-in tactic")

	else nopausemessage (thm^" is not a theorem");

(* USER COMMAND *)

(* see what theorems use a given theorem (in the theorem text sense) *)

fun whatuses thm = if isatheorem thm then

	output(std_out,
	(!Returns)^(display(listtoterm(sortset(thmtextdeps2 thm))))^(!Returns))
	else if isbuiltinthm thm

	then nopausemessage (thm^" is a built-in tactic")

	else nopausemessage (thm^" is not a theorem");

(* left sides of theorems may not have execution behaviour *)

(* the overloading of existing non-theorem constants as theorems
(except by definitions)
has been prevented -- it can be forced by hand by using pretheorems
(as it could be in the existing version) *)

(* commands for creating theorems *)

(* left sides of theorems may not have execution behaviour *)

(* USER COMMAND *)

(* command for declaring recursive tactics prior to their actual proof *)

fun declarepretheorem name = if isaconstant name orelse isoperator name
	then errormessage (name^" is already declared")
	else if name <> "" andalso stringtocon name = Constant name 
		then (declareconstant name; 
		PRETHEOREMS:=addtoset name (!PRETHEOREMS);
		addthmtextdep name [name])
	else if name <> "" andalso stringtoop name = ConOp name
		then (declareinfix name;
		PRETHEOREMS:=addtoset name (!PRETHEOREMS);
		addthmtextdep name [name])
	else errormessage (name^" is ill-formed"); 

(* USER COMMAND *)

(* a technicality, but someone might want it *)

fun declareunarypretheorem name = if name <> "" andalso stringtoop name
	= ConOp name then (declarepretheorem name;declarestrictprefix name)
	else errormessage 
	("Inappropriate argument "^name^" for unary pretheorem declaration");

(* should axioms have scin/scout induced deps? *)
(* axioms must be rule-free on both sides, or thm text deps must
be more complicated *)

(* it appears at this point that axioms and definitions can safely be
solely dependent on themselves:  any application of an axiom or definition
introduces its scin/scout deps.  Definition dependencies of axioms will not
be dropped by fixdeps.  In general, axioms and definitions are treated
specially by the prover in ways which are likely to avoid problems:
they cannot be reproven or forgotten *)

(* USER COMMAND *)

fun axiom na ls rs = if stringtocon na = Constant na andalso 
					not(isaconstant na)

	then let val LS = parse ls and RS = parse rs in

	if declarecheck false 0 LS andalso declarecheck false 0 RS (* andalso
	isstratified 0 LS andalso isstratified 0 RS *) andalso rulefree LS
	andalso rulefree RS
	

		then (addtheorem na (Constant na) LS RS [na]; fixdeps na;
			declareconstant na;thmdisplay na)

		else (errormessage 
	("Declaration or stratification error in proposed theorem "^na))
		end
	else errormessage 
	("Name of proposed theorem "^na^" is ill-formed or already declared");

(* USER COMMAND *)

(* axioms asserting truth of propositions *)

fun statement na ls = axiom na ls "true";

(* the definition commands require that the object being defined be
undeclared as yet, that no new variables or undeclared constants or
operators appear on the right side of the definition, and that the
whole definition be stratified *)

(* should definitions have scin/scout induced deps? *)
(* since thmtextdeps functions follow trail of definitions, it seems
safe to allow execution behavior on right side of a definition *)

(* in this case it might seem natural to allow definition theorems
to be pretheorems to allow definitions with recursive execution 
behavior -- not implemented *)

(* USER COMMAND *)

fun defineconstant ls rs = let val LS = parse ls and RS = parse rs in
	
	if atomdefinitionformat LS andalso not(isaconstant(atomhead LS))
	andalso declarecheck false 0 RS (* andalso isstratified 0 RS *)
	andalso subset (freevarlist RS) (freevarlist LS)
	andalso isstrat2 (Infix(LS,ResOp"=",RS))

	then (declareconstant (atomhead LS);
		addtheorem (atomhead LS) 
		(Constant(atomhead LS)) LS RS [atomhead LS]; 
		adddef (atomhead LS) (atomhead LS);
		fixdeps (atomhead LS);
		thmdisplay (atomhead LS))

	else errormessage 
("Format, declaration or stratification failure of proposed definition of "^ls)

	end;

(* this version now supports automatic declaration of unary
operators (as strict prefixes); the command will accept a 
left side in unary format *)

(* USER COMMAND *)

fun definetypedinfix name m n ls rs = 

	let val LS = parse ls and RS = parse rs in

	if opdefinitionformat LS andalso not(isoperator(ophead LS))
	andalso not(isatheorem name orelse isapretheorem name
	orelse isbuiltinthm name)
	andalso declarecheck false 0 RS (* andalso isstratified 0 RS *)
	andalso subset (freevarlist RS) (freevarlist LS)

	then if

	(declaretypedinfix m n (ophead LS);
		if not(declarecheck true 0 LS) 
		then declarestrictprefix (ophead LS)
			else ();
		isstrat2 (Infix(LS,ResOp"=",RS)))

		then (declareconstant name;
		addtheorem (name) 
		(Constant(name)) LS RS [name]; 
		adddef (name) (ophead LS);
		fixdeps (name);
		thmdisplay (name))

		else (OPERATORS:=drop (ophead LS) (!OPERATORS);
		PREFIX := drop (ophead LS) (!PREFIX);
		
		errormessage 

		("Stratification error in proposed definition of "^ls))

	else errormessage

	("Format or declaration error in proposed definition of "
	^ls)

	end;

(* USER COMMAND *)

(* command for defining opaque operators *)
(* for the December 1999 revisions, @! is excluded from the 
expressions defining opaque operators; otherwise we would have
paradoxes *)


fun defineopaque name ls rs = 

	let val LS = parse ls and RS = parse rs in

	if opaqueopdefinitionformat LS andalso not(isoperator(ophead LS))
	andalso not(isatheorem name orelse isapretheorem name
	orelse isbuiltinthm name)
	andalso declarecheck false 0 RS andalso metafree RS
		(* andalso isstratified 0 RS *)
	andalso subset (freevarlist RS) (freevarlist LS)

	then

	(declareopaque (ophead LS);
		if not(declarecheck true 0 LS) 
		then declarestrictprefix (ophead LS)
			else ();
		declareconstant name;
		addtheorem (name) 
		(Constant(name)) LS RS [name]; 
		adddef (name) (ophead LS);
		fixdeps (name);
		thmdisplay (name))

	else errormessage

	("Format or declaration error in proposed definition as opaque of "
	^ls)

	end;


(* USER COMMAND *)

(* define operators with flat typing *)

fun defineinfix name ls rs = definetypedinfix name 0 0 ls rs;

(* USER COMMAND *)

(* user command to bind a tactic to a function or operator *)

fun setprogram s thm = if thm <> "" andalso eitherhead (Leftside thm) = s

	then PROGRAMS := strongadd s thm (!PROGRAMS)
	
	else errormessage 
	("Inappropriate program "^thm^" cannot be bound to "^s);

(* USER COMMAND *)

(* see the program (if any) bound to a function or operator *)

fun seeprogram s = if hasprogram s then thmdisplay (programof s)
	else nopausemessage (s^" does not have a program bound to it");


(* USER COMMAND *)

fun prove fo = if (!ERRORFLAG)

        then errormessage "Proof aborted due to errors"

	else if declarecheck false 0 (leftside(!ENV)) 
	(* andalso 
		Isstratified 
		(Infix(leftside(!ENV),ResOp"=",rightside(!ENV))) *)
	andalso rulefree (leftside(!ENV))
	andalso declarecheck false 0 (rightside(!ENV)) 

	then let val FO = parse fo in
	if weakatomdefinitionformat FO 
	then let val NA = atomhead FO in
		if (isatheorem NA orelse isbuiltinthm NA
		orelse (isaconstant NA andalso (not (isapretheorem NA)))) then
			errormessage 
			("There is already a constant or theorem "^NA)
		else (if isaconstant NA then () else declareconstant NA;
			addtheorem NA FO (leftside(!ENV))
				(rightside(!ENV)) (deps(!ENV));
			fixdeps NA; 
			if (!SCRIPTING) then
			AUTOSCRIPT:=((!AUTOSCRIPT)^"\n(*\n"^(display FO)^
			":"^(!Returns)^(display(leftside(!ENV)))
			^"   ="^(!Returns)^
			(display(rightside(!ENV)))^(!Returns)^
			(display(listtoterm (deps(!ENV))))^"\n*)"^(!Returns)) 
			else ();
			thmdisplay NA;StrongCloseAll())
		end

	else if weakopdefinitionformat FO 
	then let val NA = ophead FO in
		if (isatheorem NA orelse isbuiltinthm NA 
		orelse (isaconstant NA andalso (not (isapretheorem NA)))) then
			errormessage 
			("There is already an operator or theorem "^NA)
		else (if isoperator NA then () else declareinfix NA;
			if not(declarecheck true 0 FO) then
			if isapretheorem NA
			then errormessage 
		("Pretheorem "^NA^" cannot be automatically declared unary")
			else declarestrictprefix NA else ();
			addtheorem NA FO (leftside(!ENV))
				(rightside(!ENV)) (deps(!ENV));
			fixdeps NA;
			if (!SCRIPTING) then
			AUTOSCRIPT:=((!AUTOSCRIPT)^"\n(*\n"^(display FO)^
			":"^(!Returns)^(display(leftside(!ENV)))
			^"   ="^(!Returns)^
			(display(rightside(!ENV)))^(!Returns)^
			(display(listtoterm (deps(!ENV))))^"\n*)"^(!Returns)) 
			else ();
			thmdisplay NA;StrongCloseAll())
		end

	else errormessage (fo^" cannot be a proof format")

	end

	else errormessage "Declaration or stratification error in environment";

(* environment saving commands *)

(* the environment desktop *)

val ENVS = ref [("bogus",(!ENV))];

(* USER COMMAND *)

(* save an environment *)

(* saved environments are stored both on the desktop and on the theorem
list with initial "}" (a character which cannot occur in a term) *)

fun saveenv s = if eitherhead (parse s) = "" 

	then errormessage ("Ill-formed proposed format "^s)

	else if declarecheck true 0 (leftside(!ENV)) andalso
		declarecheck true 0 (rightside(!ENV)) (* andalso
		Isstratified (Infix(leftside(!ENV),ResOp"=",rightside(!ENV)))*)

	then (envmod(changeename(eitherhead(parse s)));
		envmod(changeformatof(parse s));
		ENVS:=strongadd (eitherhead(parse s)) (!ENV) (!ENVS);
		addtheorem 
		("}"^(eitherhead(parse s))) (formatof(!ENV))
		(leftside(!ENV)) (rightside(!ENV)) (deps(!ENV));
		thmdisplay ("}"^(eitherhead(parse s))))

	else errormessage 
	("Cannot save "^s^" due to declaration errors");

(* USER COMMAND *)

(* display an environment *)

fun showenv s = if isatheorem ("}"^s) then thmdisplay ("}"^s)
		else errormessage ("Saved environment "^s^" not found");

(* display all (or selected) environments *)

fun showsomeenvs filter nil = () |

	showsomeenvs filter ((na,x)::L) = 

		if filter na andalso hd(explode na) = "}"

		then (thmdisplay na; suspend(fn()=>showsomeenvs filter L))
		else showsomeenvs filter L;

(* USER COMMAND *)

fun showallenvs() = (showsomeenvs (fn x => true) (sortfun(!THEOREMS)));

(* USER COMMAND *)

(* the name of the current environment; it is usually the null string,
unless an environment has been saved or invoked by autoedit *)

fun envname() = if (!VERBOSITY) = 2 then nopausemessage (ename(!ENV)) else ();

(* USER COMMAND *)

(* backup the current environment by name or as "backup" *)

fun backupenv() = if (formatof(!ENV)) = Constant ""
	then saveenv "backup"
	else saveenv (baredisplay(formatof(!ENV)));

(* USER COMMAND *)

(* retrieve a saved environment; if it is on the desktop, one gets 
complete information; if recovered from the theorem list, one loses
position information *)

(* getenv works by _name_, not format *)

fun getenv s = (if s = ename(!ENV) orelse (s = "backup"
	andalso formatof(!ENV) = Constant "")
	then () else backupenv();
	if foundin s (!ENVS)

		then

		(ENV:=hd(find s (!ENVS));look())

	else if isatheorem ("}"^s)

		then 

		(ENV:=(s,Formatof("}"^s),Leftside("}"^s),Rightside("}"^s),
			nil,0,0,nil,Deps("}"^s));look())

		else errormessage ("Environment "^s^" not found"));

(* USER COMMAND *)

(* drop an environment *)

fun dropenv s = if s = ename(!ENV) orelse (parse (ename(!ENV))) = Constant ""
andalso s = "backup" then errormessage "Cannot drop backup"

else (ENVS:=drop s (!ENVS); THEOREMS:=drop s (!THEOREMS));

(* ADD: a command for clearing saved environments *)

(* Commands for initializing the environment (starting work on
an equation *)

(* Moved here from above so that they can use the backupenv
command for safety *)

(* machinery for labelling all variables in a term with a counter,
used by the use function below *)

val COUNTER = ref 0;

val MAXCOUNTER = ref ~1;

val LONGESTPROOF = ref 0;

fun setmaxcounter n = MAXCOUNTER:=n;

fun showcounter() = nopausemessage(makestring(!COUNTER));

fun showmaxcounter() = nopausemessage(makestring(!MAXCOUNTER));

fun longestproof() = nopausemessage(makestring(!LONGESTPROOF));

exception OutOfTime;

fun initializecounter () = (if (!COUNTER)>(!LONGESTPROOF)
then LONGESTPROOF:=(!COUNTER) else ();COUNTER:=0);

fun bumpcounter () = (COUNTER := (!COUNTER)+1; if (!COUNTER)=(!MAXCOUNTER)
                     then raise OutOfTime else());


(* USER COMMAND *)

(* create the equation t = t to start working on *)

fun start t = (initializecounter();backupenv();ERRORFLAG:=false;
	ENV:=("",Constant"",(parse t),(parse t),nil,0,0,nil,nil);
	if declarecheck false 0 (leftside(!ENV)) 
		then (* if Isstratified (leftside(!ENV))

			then *) ()
			(* else errormessage "Term is not stratified" *)
	else errormessage "Undeclared identifiers or bound variables found"; 
	look());

(* supports modification of startover and starthere to preserve
environment name (as needed by getleftside and getrightside) *)

val OLDNAME = ref "bogus";  (* old name of environment *)

(* USER COMMAND *)

(* start over with left side *)

fun startover() = 
	(OLDNAME := ename(!ENV);
	start (baredisplay(leftside (!ENV)));
	envmod (changeename (!OLDNAME)));

(* USER COMMAND *)

(* start over with current term *)

fun starthere() = 
	(OLDNAME := ename(!ENV);
	start (baredisplay(rightside (!ENV)));
	envmod (changeename (!OLDNAME)));

(* USER COMMAND *)

(* convenient command for theorem editing -- use with reprove *)

fun autoedit thm = if isatheorem thm andalso isaconstant thm

	then (backupenv();ENV:=(thm,Formatof(thm),Leftside(thm),Rightside(thm),
			nil,0,0,nil,Deps(thm));look())

	else errormessage ("Cannot autoedit \"theorem\" "^thm);

(* USER COMMANDS (2) *)

(* start with left or right side of a theorem *)

fun getleftside thm = (autoedit thm; startover());

fun getrightside thm = (autoedit thm; starthere());

(* USER COMMAND *)

(* allows theorem to be proved in a new form.  Usually used for tactic
debugging and updating.  The dependency related restrictions found in Mark2
are no longer operative *)

fun reprove thm = let val THM = eitherhead (parse thm) in

	if isatheorem THM 

	then if foundinset THM (Deps THM) orelse foundin THM (!DEFINITIONS)

	then errormessage ("Cannot reprove axiom or definition "^THM)

	else if (!ERRORFLAG) then errormessage "Proof aborted due to errors"

        else

        (THEOREMS:=drop THM (!THEOREMS);
		CONSTANTS:=dropfromset THM (!CONSTANTS);
		OPERATORS:=drop THM (!OPERATORS); 
		PREFIX:=drop THM (!PREFIX);
		declarepretheorem THM;
		prove thm)

	(* else errormessage ("Would add additional dependencies to "^THM) *)

	else errormessage ("Theorem "^thm^" not found to reprove") end;

(* USER COMMAND *)

(* reprove where theorem name and format are already known *)

fun autoreprove() = if (eitherhead(formatof(!ENV))) = "" 

	then errormessage "Autoprove information not available"

	else reprove (baredisplay(formatof(!ENV)));

(* matching, substitution, and use of theorems *)

(* functions implementing changes of level and hlevel ( = "hypothesis level"
in case expressions) *)

fun changelevelcheck source target term = if source = target then term
	else changelevel source target term;

(* the command to change "hypothesis level" of a term *)

fun changehlevel source target (Infix(x,ResOp "|-|" ,Numeral S)) = 
let val s = evalnum (map makestring S) in
	if s <= source andalso s <= target then
				(Infix(x,ResOp"|-|",Numeral S))
	else if s <= source andalso s > target then Constant ""
	else(Infix(x,ResOp"|-|",Numeral 
	(map numvalue (rev (explode (makestring (target + (s - source)))))))) 
		end |
	changehlevel source target (Function t) =

		let val TRY = changehlevel source target t in
		if TRY = Constant "" then Constant "" else Function TRY end |
	changehlevel source target (Infix(x,i,y)) =

		let val TRY1 = changehlevel source target x
		and TRY2 = changehlevel source target y in
		if (TRY1 = Constant "" andalso ((not(hasprefix (opdisplay i)))
			orelse prefixof (opdisplay i) <> ""))
		orelse TRY2 = Constant ""
		then Constant "" else Infix(TRY1,i,TRY2)  end |
	changehlevel source target (CaseExp(u,v,w)) =

		let val TRY1 = changehlevel source target u
		and TRY2 = changehlevel source target v
		and TRY3 = changehlevel source target w in

		if TRY1 = Constant "" orelse TRY2 = Constant "" 
			orelse TRY3 = Constant ""
		then Constant ""
		else (CaseExp(TRY1,TRY2,TRY3))
		end |

	changehlevel source target (Parenthesis u) =

		let val TRY = changehlevel source target u in

		if TRY = Constant "" then Constant "" else Parenthesis TRY 

		end |

	changehlevel source target t = t;

fun changehlevelcheck source target term = if source = target then term
	else changehlevel source target term;

(* command for displaying the local hypothesis list *)
(* inserted here because changelevel is needed *)

(* also now displays the local variable binding situation *)

fun prelookhyps n level nil = 

		(if n = 1 andalso level <> 0
		then ("\nBound variables locally free up to ?"
			^(makestring level)^(!Returns))
		else "") |

	prelookhyps n level ((t,u,p,s,l)::L) =

		(if n = 1 andalso level <> 0
		then ("\nBound variables locally free up to ?"
			^(makestring level)^(!Returns))
		else "")^

		(makestring n)^

			(if s = 0 then " (inactive):  "^(!Returns)
			else if s = 1 then " (positive):  "^(!Returns)
			else if s = 2 then " (negative):  "^(!Returns)
			else "(bogus):  ")

		^(if u = Constant "true" andalso (!STATEMENTDISPLAY) then

		"|-"^(display (changelevel l level t))

		else if t = Constant "true" andalso (!STATEMENTDISPLAY) then

		"$|-"^(display (changelevel l level u))

		else (display (changelevel l level t))^"  =  "^(!Returns)
		^(display (changelevel l level u)))
		^(!Returns)^(prelookhyps (n+1) level L);

fun guiprelookhyps n l h =

(if (!GUIMODE) then "\nHypothesis display:"^(!Returns) else "")^
(prelookhyps n l h)^(if (!GUIMODE) then ". . ."^(!Returns) else "");

(* USER COMMAND *)

(* view list of local hypotheses *)

fun lookhyps() = output(std_out,

guiprelookhyps 1 (level(!ENV)) (hypslist(!ENV)));

(* text replacement in terms -- takes level changes into account *)
(* replace t with u in last argument at given level and hlevel *)

(* utilities for handling replacement of operator variables *)

fun isphonyconstant (Parenthesis(Constant t)) = t <> "" andalso
		(explode t) = getspecial(explode t) |

	isphonyconstant t = false;

fun isphonyvariable (FreeVar t) = t <> "" 
		andalso stringtoop t = VarOp t  |

	isphonyvariable t = false;

fun replace level hlevel t u (Function s) =

	if t = Function s then u 

	else Function (replace level hlevel (changelevel level (level+1) t)
		(changelevel level (level+1) u) s) |

	replace level hlevel t u (CaseExp(a,b,c)) =

	if t = CaseExp(a,b,c) then u 

	else  let val T = changehlevel hlevel (hlevel+1) t 
		and U = changehlevel hlevel (hlevel+1) u in

		CaseExp(replace level hlevel t u a,
		replace level hlevel T U b,
                replace level hlevel T U c) end |

	replace level hlevel t u (Infix(x,i,y)) =

	(* handle substitution for operator variables *)
	(* this is strictly a hack for the internal consumption
	of the substitution operation below *)

	if isphonyvariable t andalso isphonyconstant u
	andalso (opdisplay i) = (baredisplay t)

	then Infix(replace level hlevel t u x,ParOp(baredisplay 
		(deparenthesize1 u)),
		replace level hlevel t u y)

	else if t = (Infix(x,i,y)) then u 

	else Infix(replace level hlevel t u x,i,replace level hlevel t u y) |

	replace level hlevel t u v =

	if t = v then u else v;

(* eval and bind functions *)

val STRATWARNING = ref false;

fun stratwarning() = (STRATWARNING:= not (!STRATWARNING);
	nopausemessage ("Stratification warning is "^(if (!STRATWARNING) then
	"on" else "off")));

(* eval determines the value of Function t at u *)

(* hlevel will not be an issue *)

fun eval level (Function t) u = 
	changelevel (level+1) level (replace (level+1) 0
		(BoundVar (level+1)) (changelevel level (level+1) u) t) |

	eval level t u = Infix(t,ResOp"@!",u);

fun morevals level (Infix(t,ResOp"@!",u)) v = 
		eval level (morevals level t u) v |

	morevals level t u = eval level t u;

(* depairprep handles evaluation of the automatic projection operators
p1 and p2 and of constant functions at ?0 *)

fun depairprep level (Infix(Constant"p1",ResOp"@",(Infix(x,ResOp",",y)))) = 
	depairprep level x |

	depairprep level (Infix(Constant"p2",ResOp"@",
		(Infix(x,ResOp",",y)))) = 
	depairprep level y |

	depairprep level (Infix(Function t,ResOp"@",BoundVar 0)) =

	if changelevel (level + 1) level t = Constant "" then 
		(Infix(Function (depairprep (level+1) t),ResOp"@",BoundVar 0))
		else depairprep level (changelevel (level+1) level t) |

	depairprep level (Function t) = Function(depairprep (level+1) t) |

	depairprep level (Infix(x,i,y)) = 
	Infix(depairprep level x,i,depairprep level y) |

	depairprep level (CaseExp(u,v,w)) =
        CaseExp(depairprep level u,depairprep level v,depairprep level w) |

        depairprep level u = u;

(* this is eval strengthened to post scin/scout deps *)

(* now strengthened to automatically evaluate p1, p2, constant
functions at ?0 *)

fun strongeval level (Function t) u = if Isstratified1 level (Function t)
	then depairprep level 
	(changelevel (level+1) level (replace (level+1) 0
		(BoundVar (level+1)) (changelevel level (level+1) u) t))

	else (if (!STRATWARNING) then 
	nopausemessage "Evaluation at unstratified abstract attempted" else ();
	Infix(Function t,ResOp"@",u)) |

	strongeval level t u = Infix(t,ResOp"@",u);

fun morestrongevals level (Infix(t,ResOp"@",u)) v =

	strongeval level (morestrongevals level t u) v |

	morestrongevals level t u = strongeval level t u;

(* prebind expresses t as a function of u without checking for
stratification *)

fun prebind level t u = Function(replace (level+1) 0
	(changelevel level (level+1) u) 
	(BoundVar (level+1)) (changelevel level (level+1) t));

(* this is list binding, and it looks at the grouping of
the comma to decide which way to go! *)

(* it now handles constant functions as well as pairs *)

fun pairprep level (Infix(x,ResOp",",y)) t =
	deparenthesize(
	replace level 0 x 
	(Parenthesis(Infix(Constant "p1",ResOp"@",Infix(x,ResOp",",y))))
	(replace level 0 y 
	(Parenthesis(Infix(Constant "p2",ResOp"@",Infix(x,ResOp",",y))))
	(replace level 0 (Infix(x,ResOp",",y)) 
	(Parenthesis (Infix(x,ResOp",",y))) 
	(pairprep level x (pairprep level y t))))) |

	pairprep level (Function u)  t = let val U =
	changelevel (level-1) level u in
	
	if U = Constant "" then t else

	deparenthesize(
	replace level 0 U
		(Infix(Function u,ResOp"@",BoundVar 0))
		(replace level 0 (Function u) (Parenthesis(Function u))
		(pairprep level u t))) end |

	pairprep level u t = t;
									

(* bind incorporates stratification check *)
(* and now incorporates fun with pairs*)

fun bind level t u = let val A = prebind level (pairprep level u t) u in

	if Isstratified1 level A then A else 

	(if (!STRATWARNING) then 
	nopausemessage "Attempt to form unstratified abstract" else ();
	Constant "")	end;

(* inserttype and deletetype are tricky functions for inserting
and deleting a dummy bool type label for use in recognizing
uniformly type-raising or lowering abstracts *)

fun inserttype (Function t) = Function(Infix(Constant"bool",ResOp":",t)) |
    inserttype t = t;

fun deletetype (Infix(Constant"bool",ResOp":",t)) = t |
    deletetype (Infix(Function t,ResOp"@",u)) =
               (Infix(Function (deletetype t),ResOp"@*",u)) |
    deletetype t = t;

(* the form of bind which goes with @* -- the application of
type-raising or lowering operations *)

fun raisebind level t u = let val A = 
    (prebind level t u)

    in if Isstratified1 level (inserttype A) then A else 

	(if (!STRATWARNING) then 
	nopausemessage "Attempt to form unstratified abstract" else ();
	Constant "")	end;

fun raisestrongeval level (Function t) u =

    deletetype(strongeval level (inserttype(Function t)) u) |

    raisestrongeval level t u = Infix(t,ResOp"@*",u);

(* the match function returns a list containing a finite function
matching free variables of its first term argument with terms in the
second term argument, if such a match is possible; otherwise it returns
nil *)

(* there is a hack for matches to operator variables; matching operators are
"repackaged" as constants *)

(* the "higher order matching" refinement provides that if a term
T@?n matches a term U at level n, and T is meaningful at our working
level, that T will match [U] *)

(* machine for merging matches *)

fun mergematches nil L = nil |

	mergematches M nil = nil |

	mergematches (a::L) (b::M) = merge a b;


(* it is presumed that terms of the same level and hlevel are
being matched *)

(* level is the level of the top-level terms being matched; n is the 
level of the current subterm being examined *)

(* match has been modified so that terms with execution behaviour
will not match anything *)


(* fun hyptoeq (Infix(x,ResOp"=",y))(Infix(z,ResOp"=",w))=(Infix(z,ResOp"=",w))|
	hyptoeq (Infix(x,ResOp"=",y)) t = Infix(Constant"true",ResOp"=",t)|
	hyptoeq t u = u; *)

fun isnumeralterm (Numeral L) = true |

    isnumeralterm (FreeVar s) = tl(explode s) <> nil
    andalso hd(explode s) = "?"
    andalso hd(tl(explode s)) = "?" |

    isnumeralterm t = false;

fun aptoeq (Infix(x,ResOp"@",y)) = (Infix(x,ResOp"bogus",y)) |

	aptoeq t = t;

fun iterboundvar (BoundVar n) = n |

	iterboundvar (Function u) = iterboundvar u |

	iterboundvar t = ~1;

fun itervalue (Function u) t = Infix(itervalue u t,ResOp"@",BoundVar 0) |

	itervalue u t = t;

fun match level n (Constant s) (Constant t) = if s=t then [nil] else nil |

	match level n (Numeral s) (Numeral t) = if s=t then [nil] else nil |

	match level n (FreeVar s) t = 
                                if isnumeralterm(FreeVar s)
                                then if isnumeralterm t then [[(s,t)]]
                                else nil

                                else let val T = changelevel n level t in
				if declarecheck true level T then
					[[(s,T)]] else nil end |

	match level n (Infix(t,ResOp"@",BoundVar 0)) u =

	match level n t (Function(changelevel n (n+1) u))

	|

	match level n (Infix(Function t,ResOp "@",u)) 
		(Infix(Function t1,ResOp"@",u1)) =

        let val M = match level n (Infix(Function t,ResOp "=",u)) 
		(Infix(Function t1,ResOp"=",u1)) in

	if M = nil andalso (strongeval n (Function t) u) <> 
	(Infix(Function t,ResOp "@",u))

        then match level n (strongeval n (Function t) u) 
		(Infix(Function t1,ResOp"@",u1))

        else M

        end |

	match level n (Infix(Function t,ResOp "@",u)) v =

	if (strongeval n (Function t) u) <> (Infix(Function t,ResOp "@",u))
	then match level n (strongeval n (Function t) u) v else nil |

	match level n (Infix(t,ResOp"@",u))(Infix(t1,ResOp"@",u1)) =

	let val M = match level n (Infix(t,ResOp"=",u))(Infix(t1,ResOp"=",u1))

	in 

	if M = nil 

	then let val SE = morestrongevals n t u in

	if SE <> (Infix(t,ResOp"@",u))

	then match level n SE (Infix(t1,ResOp"@",u1))

	else let val v = (Infix(t1,ResOp"@",u1)) in

	match level n t (bind n v u) end end

	else M end |

	match level n (Infix(t,ResOp"@",u)) v =

	let val SE = morestrongevals n t u in

	if SE <> (Infix(t,ResOp"@",u))

	then match level n SE v

	else match level n t (bind n v u) end |

	match level n (Infix(t,ResOp"@*",u))(Infix(t1,ResOp"@*",u1)) =

	let val M = match level n (Infix(t,ResOp"=",u))(Infix(t1,ResOp"=",u1))

	in 

	if M = nil 

	then let val v = (Infix(t1,ResOp"@",u1)) in

	match level n t (raisebind n v u) end

	else M end |

	match level n (Infix(t,ResOp"@*",u)) v =

	match level n t (raisebind n v u) |

	match level n (Infix(Function t,ResOp "@!",u)) 
		(Infix(Function t1,ResOp"@!",u1)) =

        let val M = match level n (Infix(Function t,ResOp "=",u)) 
		(Infix(Function t1,ResOp"=",u1)) in

	if M = nil andalso (eval n (Function t) u) <> 
		(Infix(Function t,ResOp "@!",u))

        then match level n (eval n (Function t) u) 
		(Infix(Function t1,ResOp"@!",u1))

        else M

        end |

	match level n (Infix(Function t,ResOp "@!",u)) v =

	if (eval n (Function t) u) <> (Infix(Function t,ResOp "@!",u))

	then match level n (eval n (Function t) u) v else nil |



	match level n (Infix(t,ResOp"@!",u))(Infix(t1,ResOp"@!",u1)) =

	let val M = match level n (Infix(t,ResOp"=",u))(Infix(t1,ResOp"=",u1))

	in if M = nil 

	then let val EV = morevals n t u in

	if EV <> (Infix(t,ResOp"@!",u))

	then match level n EV (Infix(t1,ResOp"@!",u1))

	else let val v = (Infix(t1,ResOp"@!",u1)) in

	match level n t (prebind n v u) end end

	else M end |

	match level n (Infix(t,ResOp"@!",u)) v =

	let val EV = morevals n t u in

	if EV <>  (Infix(t,ResOp"@!",u))

	then match level n EV v

	else match level n t (prebind n v u) end |

	match level n (BoundVar s) (BoundVar t) = if s=t then [nil] else nil |

	match level n (Function s) (Function t) = match level (n+1) s t |

	match level n (Infix(x,VarOp s,y)) (Infix(z,i,w)) =

		if istypedoperator s andalso (((not(istypedoperator 
		(opdisplay i))) orelse 
		((lefttype (opdisplay i),righttype (opdisplay i)) <>
		(lefttype s,righttype s))))  then nil

		else if (isscinleft s andalso not (isscinleft (opdisplay i)))
		orelse (isscinright s andalso not (isscinright (opdisplay i)))
		orelse (isscout s andalso not (isscout (opdisplay i))) then nil

		(* a phony term is used here to represent a
		matched operator *)

		else mergematches [[(s,Constant (opdisplay i))]]
		(mergematches (match level n x z) (match level n y w)) |

	match level n (Infix(Numeral a,ResOp s,Numeral b)) 
				(Infix(x,ResOp t,y)) =

		if arithop s then nil
		else if s = t andalso x = Numeral a andalso y = Numeral b
			then [nil]
			else nil |

	match level n (Infix(x,ResOp s,y)) (Infix(z,ResOp t,w)) =

		if ruleinfix s orelse s <> t
		then nil
		else
		(mergematches (match level n x z) (match level n y w)) |

	match level n (Infix(x,i,y)) (Infix(z,j,w)) = 

		if i <> j then nil

		else (mergematches (match level n x z) (match level n y w)) |

	match level n (CaseExp(Infix(Constant "true",ResOp"=",t),u,v))
		w =nil |

	match level n (CaseExp(u,v,w)) (CaseExp(a,b,c)) =

		if u = Constant "true" orelse u = Constant "false" then nil
		else mergematches (match level n u ((* hyptoeq u *) a)) (
		mergematches (match level n v b) (match level n w c)) |

	match level n t u = nil;


(* sophisticated navigation commands are added here *)

(* these commands move to terms which match their arguments;
a version which looks for terms literally would also sometimes be useful *)

(* literal versions are now provided *)

val MATCHES = ref true;

fun preitmatches level s t = if match level level 
	(changelevel 0 (level) s) t = nil then 
				(MATCHES := false;t) else (MATCHES := true;t);

fun itmatches s = exec (preitmatches (level(!ENV)) s);

fun preitsequal level s t = if s = t then 
				(MATCHES := true;t) else (MATCHES := false;t);

fun itsequal s = exec (preitsequal (level(!ENV)) s);

(* USER COMMAND *)

(* moves up to a term matching its argument *)

(* performance slightly changed; it will always move up (so it can
be repeated effectively *)

fun upto s = (sup(); itmatches (parse s); if (!MATCHES) 
		then look()
		else if position(!ENV) = nil
		then (errormessage ("No match found for "^s);look())
		else upto s);

fun litupto s = (sup(); itsequal (parse s); if (!MATCHES) 
		then look()
		else if position(!ENV) = nil
		then (errormessage ("No match found for "^s);look())
		else litupto s);

(* USER COMMANDS (2) *)

(* move to places where theorems can be applied *)

fun uptols thm = if isatheorem thm then upto (baredisplay(Leftside thm))
		else errormessage ("No theorem "^thm^" found");
fun uptors thm = if isatheorem thm then upto (baredisplay(Rightside thm))
		else errormessage ("No theorem "^thm^" found");

fun atomic (Constant t) = true |

	atomic (FreeVar s) = true |

	atomic (BoundVar n) = true |

	atomic (Numeral n) = true |

	atomic t = false;

fun noleftsubterm (Function t) = true |

	noleftsubterm (Infix(Constant "",i,y)) = true |

	noleftsubterm t = false;

(* like the upto command, the downtoleft and downtoright functions
behave differently here; they always go to subterms if there are any,
unlike the original function, which would stick where it was if it
found a match *)

(* there still may be need to tinker with this family of commands *)

fun predowntoleft s = (getcurrent(); if atomic (!CURRENTTERM)
		then () 
		else if noleftsubterm (!CURRENTTERM)

		then (sright(); predowntoleft s; itmatches (parse s);
		if (!MATCHES) = true then () else sup())

		else (sleft(); predowntoleft s; itmatches (parse s);
		if (!MATCHES) = true then () else 
		(sup(); sright(); predowntoleft s; itmatches (parse s);
		if (!MATCHES) = true then () else sup())));

(* USER COMMANDS (4) *)

fun downtoleft s = (predowntoleft s; itmatches (parse s);
		if (!MATCHES) = true then look() else
		(errormessage ("No match found for "^s);look()));

fun litpredowntoleft s = (getcurrent(); if atomic (!CURRENTTERM)
		then () 
		else if noleftsubterm (!CURRENTTERM)

		then (sright(); litpredowntoleft s; itsequal (parse s);
		if (!MATCHES) = true then () else sup())

		else (sleft(); litpredowntoleft s; itsequal (parse s);
		if (!MATCHES) = true then () else 
		(sup(); sright(); litpredowntoleft s; itsequal (parse s);
		if (!MATCHES) = true then () else sup())));

fun litdowntoleft s = (litpredowntoleft s; itsequal (parse s);
		if (!MATCHES) = true then look() else
		(errormessage ("No match found for "^s);look()));


(* move to places where theorems can be applied *)

fun dlls thm = if isatheorem thm then downtoleft (baredisplay(Leftside thm))
		else errormessage ("No theorem "^thm^" found");
fun dlrs thm = if isatheorem thm then downtoleft (baredisplay(Rightside thm))
		else errormessage ("No theorem "^thm^" found");

(* literal versions of the previous commands are not appropriate *)

fun predowntoright s = (getcurrent(); if atomic (!CURRENTTERM)
		then () else (sright(); predowntoright s; itmatches (parse s);
		if (!MATCHES) = true then () else
 
		(sup(); getcurrent(); if noleftsubterm (!CURRENTTERM) 
		then () else (sleft(); predowntoright s; itmatches (parse s);
		if (!MATCHES) = true then () else sup()))));

(* USER COMMANDS (4) *)

fun downtoright s = (predowntoright s; itmatches (parse s);
		if (!MATCHES) = true then look() else
		(errormessage ("No match found for "^s);look()));

fun litpredowntoright s = (getcurrent(); if atomic (!CURRENTTERM)
		then () else (sright(); litpredowntoright s; 
			itsequal (parse s);
		if (!MATCHES) = true then () else
 
		(sup(); getcurrent(); if noleftsubterm (!CURRENTTERM) 
		then () else (sleft(); litpredowntoright s; itsequal (parse s);
		if (!MATCHES) = true then () else sup()))));

fun litdowntoright s = (litpredowntoright s; itsequal (parse s);
		if (!MATCHES) = true then look() else
		(errormessage ("No match found for "^s);look()));


(* move to places where theorems can be applied *)

fun drls thm = if isatheorem thm then downtoright (baredisplay(Leftside thm))
		else errormessage ("No theorem "^thm^" found");
fun drrs thm = if isatheorem thm then downtoright (baredisplay(Rightside thm))
		else errormessage ("No theorem "^thm^" found");

(* the substitution function *)

(* implements the automatic eval used by the substitution function
to implement the substitution side of "higher-order matching"  *)

(* requires some reasonable assumptions to avoid need to talk about
hlevel, which probably need to be enforced *)

fun changedtofunction (Function t) (Function u) = false |

	changedtofunction t (Function u) = true |

	changedtofunction u v = false;

fun autoeval level (Infix(Parenthesis(Function u),ResOp"@",v))

	= (strongeval level (Function u) (autoeval level v)) |

        autoeval level (Infix(Parenthesis(Function u),ResOp"@*",v))

	= (raisestrongeval level (Function u) (autoeval level v)) |

	autoeval level (Infix(Parenthesis(Function u),ResOp"@!",v))

	= (eval level (Function u) (autoeval level v)) |

	autoeval level (Infix(t,ResOp"@",u)) =

	let val T = autoeval level t in

	if changedtofunction t T 

	then reautoeval level (Infix(T,ResOp"@",autoeval level u)) 

	else (Infix(T,ResOp"@",autoeval level u)) end |

	autoeval level (Infix(t,ResOp"@!",u)) =

	let val T = autoeval level t in

	if changedtofunction t T

	then reautoeval level (Infix(T,ResOp"@!",autoeval level u)) 

	else (Infix(T,ResOp"@!",autoeval level u)) end |

	autoeval level (Infix(t,ResOp"@*",u)) =

	let val T = autoeval level t in

	if changedtofunction t T

	then reautoeval level (Infix(T,ResOp"@*",autoeval level u)) 

	else (Infix(T,ResOp"@*",autoeval level u)) end |

	autoeval level (Infix(x,i,y)) = 

	Infix(autoeval level x,i,autoeval level y) |

	autoeval level (CaseExp(u,v,w)) =

	CaseExp(autoeval level u,autoeval level v, autoeval level w) |

	autoeval level (Function t) =

	Function (autoeval (level +1) t) |

	autoeval level t = t

and reautoeval level (Infix(Function u,ResOp"@",v)) =

	(strongeval level (Function u) v) |

	reautoeval level (Infix(Function u,ResOp"@!",v)) =

	(eval level (Function u) v) |

	reautoeval level (Infix(Function u,ResOp"@*",v)) =

	(raisestrongeval level (Function u) v) |

	reautoeval level t = t;

(* the substitution function itself *)

(* presubs keeps stuff in parentheses so that simultaneous 
substitutions don't interfere *)

fun presubs level hlevel t nil = t |

	presubs level hlevel t ((s,u)::L) = replace level hlevel

			(FreeVar s) (Parenthesis u) (

			presubs level hlevel t L);

exception BadSub;

fun baresubs level hlevel L t = presubs level hlevel t L;

fun subs level hlevel L t =
	let val T = presubs level hlevel t L in
	(* deparenthesize(autoeval level (presubs level hlevel t L)) in *)
	if metastrat level (deparenthesize T) then
	deparenthesize(autoeval level T) else
	(errormessage "Substitution abuses context terms";raise BadSub) end;

(* new type definition commands *)

(* they appear here because they need substitution *)

(* format of left side of a type definition *)

fun atomtypedefinitionformat (Infix(t1,ResOp":",FreeVar x)) =

	atomdefinitionformat t1 andalso not (foundinset x (freevarlist t1))|

	atomtypedefinitionformat x = false;

fun optypedefinitionformat (Infix(t1,ResOp":",FreeVar x)) =

	opdefinitionformat t1 andalso not (foundinset x (freevarlist t1)) |

	optypedefinitionformat x = false;

fun opaqueoptypedefinitionformat (Infix(t1,ResOp":",FreeVar x)) =

	opaqueopdefinitionformat t1 andalso not (foundinset x (freevarlist t1)) |

	opaqueoptypedefinitionformat x = false;


fun atomtypehead (Infix(t1,ResOp":",FreeVar x)) =

	atomhead t1 |

	atomtypehead x = "";

fun optypehead (Infix(t1,ResOp":",FreeVar x)) =

	ophead t1 |

	optypehead x = "";

fun typedarg (Infix(t1,ResOp":",FreeVar x)) = x |

	typedarg y = "";

(* USER COMMAND *)

(* declare a constant as a type label *)

fun defineconstanttype retractionthm ls rs =

	let val LS = parse ls and RS = parse rs in

	(* standard conditions on definitions *)

	if atomtypedefinitionformat LS andalso 
		not(isaconstant(atomtypehead LS))
	andalso declarecheck false 0 RS (* andalso isstratified 0 RS *)
	andalso subset (freevarlist RS) (freevarlist LS)
	andalso isstrat2 (Infix(LS,ResOp"=",RS))

	(* the argument being typed is not assigned a type
	in the stratification of this theorem (relative to free
	variables) *)

	andalso not (foundinset (typedarg LS) (map (fn (y,z) => y)
		(hd(strat2 0 (Infix(LS,ResOp"=",RS))))))

	(* the retraction theorem says the right thing *)
	(* we require a quite literal relationship down to
	names of variables between the retraction theorem and the
	definition:  the left side of the retraction theorem
	should be the right side of the proposed definition, and the
	right side should be the result of substituting the left side
	into itself for the parameter being typed (establishing
	that we have a retraction). *)

	andalso (Leftside retractionthm = RS andalso Rightside
		retractionthm = subs 0 0 [(typedarg LS,RS)] RS)
		orelse (Rightside retractionthm = RS andalso Leftside
		retractionthm = subs 0 0 [(typedarg LS,RS)] RS)


	then (declareconstant (atomtypehead LS);
		addtheorem (atomtypehead LS) 
		(Constant(atomtypehead LS)) LS RS 
		(addtoset (atomtypehead LS) (Deps retractionthm)); 
		adddef (atomtypehead LS) (atomtypehead LS);
		fixdeps (atomtypehead LS);
		thmdisplay (atomtypehead LS))

	else errormessage 
("Format, declaration or stratification failure of proposed definition of type "^ls)

	end;

(* USER COMMAND *)

(* type constructors are now declared as opaque operators *)

fun defineinfixtype name retractionthm ls rs = 

	let val LS = parse ls and RS = parse rs in

	if opaqueoptypedefinitionformat LS 
		andalso not(isoperator(optypehead LS))
	andalso not(isatheorem name orelse isapretheorem name
	orelse isbuiltinthm name)
	andalso declarecheck false 0 RS (* andalso isstratified 0 RS *)
	andalso subset (freevarlist RS) (freevarlist LS)

	(* the retraction theorem says the right thing *)
	(* we require a quite literal relationship down to
	names of variables between the retraction theorem and the
	definition *)

	andalso (Leftside retractionthm = RS andalso Rightside
		retractionthm = subs 0 0 [(typedarg LS,RS)] RS)
		orelse (Rightside retractionthm = RS andalso Leftside
		retractionthm = subs 0 0 [(typedarg LS,RS)] RS)

	andalso strat2 0 (subs 0 0 (map(fn x => (x,Numeral [0])) 
	(setminus (freevarlist RS) [typedarg LS])) RS) = [nil]

	then

	(declareopaque (optypehead LS);
		if not(declarecheck true 0 LS) 
		then declarestrictprefix (optypehead LS)
			else ();
		declareconstant name;
		addtheorem (name) 
		(Constant(name)) LS RS (addtoset name (Deps retractionthm));
		adddef (name) (optypehead LS);
		fixdeps (name);
		thmdisplay (name))

	else errormessage

	("Format or declaration error in proposed definition of type "
	^ls)

	end;


(*  BEGIN development of unification *)

(*

let apply_subst l t = rev_itlist (\pair term.subst[pair]term) l t;;

% Find a substitution to unify two terms (lambda-terms not dealt with) %

Thomas's HOL algorithm

letrec find_unifying_subst t1 t2 = 
 if t1=t2
  then []
 if is_var t1
  then if not(mem t1 (frees t2)) then [t2,t1] else fail
 if is_var t2
  then if not(mem t2 (frees t1)) then [t1,t2] else fail
 if is_comb t1 & is_comb t2
  then
   (let rat1,rnd1 = dest_comb t1
    and rat2,rnd2 = dest_comb t2
    in
    let s = find_unifying_subst rat1 rat2
    in s@find_unifying_subst(apply_subst s rnd1)(apply_subst s rnd2)
   )else fail;;



*)

(* an auxiliary hack for substitutions into match keys *)


(* this algorithm ignores hlevel; thus, it should only be applied in
rule-free contexts *)

(* it forbids matches to terms of nonzero intrinsic level *)

fun unify n (Constant s) (Constant t) = if s=t then [nil]
	else nil |

	unify n (Numeral s) (Numeral t) = 
		if s=t then [nil] else nil |

	unify n (FreeVar s) t = 
			if t = FreeVar s then [nil] else
			let val T = changelevel n 0 t in
				if declarecheck true 0 T 
				andalso not (foundinset s (freevarlist t))
					then [[(s,T)]] else nil end |

	unify n t (FreeVar s) = 
			let val T = changelevel n 0 t in
				if declarecheck true 0 T 
				andalso not (foundinset s (freevarlist t))
					then
					[[(s,T)]] else nil end |

	unify n (Infix(FreeVar s,ResOp"@",BoundVar p))

		(Infix(x,ResOp"@",BoundVar m))  = 

		let val X = changelevel n 0 x in
		if m = p 
		andalso declarecheck true 0 X 
		andalso not (foundinset s (freevarlist x))
		then
		if X = FreeVar s then [nil] else
		[[(s,X)]] else  

		let val T = changelevel (n-1) 0 
		(Function (Infix(x,ResOp"@",BoundVar m))) in

		if p=n andalso declarecheck true 0 T

		(* andalso isstratified 0  T *)

		then [[(s,T)]] 

		else nil end
		end |

	unify n (Infix(x,ResOp"@",BoundVar m))
 
		(Infix(FreeVar s,ResOp"@",BoundVar p))

		  = 

		let val X = changelevel n 0 x in
		if m = p 
		andalso declarecheck true 0 X 
		andalso not (foundinset s (freevarlist x))
		then
		[[(s,X)]] else  

		let val T = changelevel (n-1) 0 
		(Function (Infix(x,ResOp"@",BoundVar m))) in

		if p=n andalso declarecheck true 0 T

		(* andalso isstratified 0  T *)

		then [[(s,T)]] 

		else nil end
		end |

	unify n t (Infix(FreeVar s,ResOp"@",BoundVar m)) =

		let val T = changelevel (n-1) 0 (Function t) in

		if m=n andalso declarecheck true 0 T

		andalso not (foundinset s (freevarlist t))

		(* andalso isstratified 0  T *)

		then [[(s,T)]] 

		else nil end |

	unify n (Infix(FreeVar s,ResOp"@",BoundVar m)) t =

		let val T = changelevel (n-1) 0 (Function t) in

		if m=n andalso declarecheck true 0 T

		andalso not (foundinset s (freevarlist t))

		(* andalso isstratified 0  T *)

		then [[(s,T)]] 

		else nil end |

	unify n (BoundVar s) (BoundVar t) = if s=t then
		[nil] else nil |

	unify n (Function s) (Function t) = 
		unify (n+1) s t |

	unify n (Infix(x,VarOp s,y)) (Infix(z,i,w)) =

		if istypedoperator s andalso (((not(istypedoperator 
		(opdisplay i))) orelse 
		((lefttype (opdisplay i),righttype (opdisplay i)) <>
		(lefttype s,righttype s))))  
		orelse foundinset s (freevarlist (Infix(z,i,w)))
		then nil

		(* a phony term is used here to represent a
		matched operator *)

		else (mergeunifs n (mergeunifs n 
		(if s = opdisplay i then [nil] else 
			[[(s,Constant (opdisplay i))]])
		x z) y w) |

	unify n (Infix(z,i,w)) (Infix(x,VarOp s,y))  =

		if istypedoperator s andalso (((not(istypedoperator 
		(opdisplay i))) orelse 
		((lefttype (opdisplay i),righttype (opdisplay i)) <>
		(lefttype s,righttype s))))  
		orelse foundinset s (freevarlist (Infix(z,i,w)))
		then nil

		(* a phony term is used here to represent a
		matched operator *)

		else (mergeunifs n 
		(mergeunifs n [[(s,Constant (opdisplay i))]]
		x z) y w) |

	unify n (Infix(Numeral a,ResOp s,Numeral b)) 
				(Infix(x,ResOp t,y)) =

		if arithop s then nil
		else if s = t andalso x = Numeral a andalso y = Numeral b
			then [nil]
			else nil |

	unify n (Infix(x,ResOp s,y)) (Infix(z,ResOp t,w)) =

		if ruleinfix s orelse s <> t
		then nil
		else
		(mergeunifs n (unify n x z) y w) |

	unify n (Infix(x,i,y)) (Infix(z,j,w)) = 

		if i <> j then nil

		else (mergeunifs n (unify n x z) y w) |

	unify n (CaseExp(Infix(Constant "true",ResOp"=",t),u,v))
		w =nil |

	unify n (CaseExp(u,v,w)) (CaseExp(a,b,c)) =

		if u = Constant "true" orelse u = Constant "false" then nil
		else (mergeunifs n 
		(mergeunifs n (unify n u a) v b) w c) |

	unify n t u = nil

and mergeunifs n M t u = if M = nil then nil else

	let val M2 = map (fn (s,t) => (s,changelevel 0 n t)) (hd M) in

	mergematches M
	(unify n (subs n 0 M2 t) (subs n 0 M2 u)) end;


(* END development of unification *)


fun labelvars (FreeVar s) = FreeVar (s^"_"^(makestring(!COUNTER)))|

	labelvars (Function s) = Function(labelvars s) |

	labelvars (Infix(x,i,y)) = Infix(labelvars x,i,labelvars y) |

	labelvars (CaseExp(x,y,z)) = 
		CaseExp(labelvars x,labelvars y,labelvars z) |
	labelvars t = t;

(* precursor function for UNEVAL *)

(* it will output a list of arguments to which the argument (Function u)
is to be applied to obtain the term t *)

(* we want to attempt a sequence of substitutions *)

fun modellist 0 = nil |

modellist n = (modellist (n-1))@[n];

fun evals level t [u] = eval level t u |

evals level t (m::n) = evals level (eval level t m) n; 

fun evalsterm t [u] = Infix(t,ResOp"@!",u) |

evalsterm t (m::n) = evalsterm (Infix(t,ResOp"@!",m)) n;

fun unevals n level (Function u) (Function v) t =

let val U = changelevel (level+1) level (replace (level+1) 0
(BoundVar(level+1)) (FreeVar(makestring n)) v)  in

let val M = match level level U t in

if M = nil then unevals (n+1) level (Function u) U t

else let val L = map (fn m =>safefind (FreeVar "?x") (makestring m)
(hd(match level level U t))) (modellist n) in

if evals level (Function u) L = t then L else nil

end

end

end |

unevals n level u v t = nil;

fun strongevals level t [u] = strongeval level t u |

strongevals level t (m::n) = strongevals level (strongeval level t m) n; 

fun strongevalsterm t [u] = Infix(t,ResOp"@",u) |

strongevalsterm t (m::n) = strongevalsterm (Infix(t,ResOp"@",m)) n;

fun strongunevals n level (Function u) (Function v) t =

let val U = changelevel (level+1) level (replace (level+1) 0
(BoundVar(level+1)) (FreeVar(makestring n)) v)  in

let val M = match level level U t in

if M = nil then strongunevals (n+1) level (Function u) U t

else let val L = map (fn m =>safefind (FreeVar "?x") (makestring m)
(hd(match level level U t))) (modellist n) in

if strongevals level (Function u) L = t then L else nil

end

end

end |

strongunevals n level u v t = nil;


(* machinery for making "new" variables introduced by a theorem
depend on local bound variables *)

(* it is very conservative (more so than the old implementation)
but still not safe; this may introduce stratification errors in which
case use of a reverse tactic with parameters through which new
values can be supplied is indicated *)

(* what we need to know to make this work better is the relative
type of the subterm relative to the smallest bracket term containing it *)

fun varstofuns L n (FreeVar s) = if foundinset s L andalso n>0

		then Infix(FreeVar s, ResOp"@",BoundVar n)
		else (FreeVar s) |

	varstofuns L  n (Function s) = Function(varstofuns L n s) |

	varstofuns L  n (Infix(x,i,y)) = Infix(varstofuns L n x,i,
		varstofuns L n y) |

	varstofuns L n  (CaseExp(x,y,z)) = 
		CaseExp(varstofuns L n x,varstofuns L n y,varstofuns L n z) |
	varstofuns L n t = t;

(* fixvars s t fixes variables in t so that new variables introduced
by the theorem s=t are made dependent on local bound variables
if this is easily verified to be possible *)

fun fixvars n fo s t = let val A = strat2 0 t in  if A = nil then t 

	else varstofuns (separate (fn x=>find x (hd A) = [rigid_type 0]) 
	(setminus (setminus (freevarlist t) (freevarlist s))
	(freevarlist fo))) n t
	end;

(* apply a presumed equational theorem s = t to the term u *)
(* the labelvars operation with a new counter is applied to
both sides of the equational theorem *)

(* some new variables introduced by theorems will be introduced
so as to depend on the highest index locally free bound variable;
this only happens under restrictions which ensure stratification locally
but may still cause stratification problems globally *)

(* USE also posts dependency changes *)

(* an auxiliary function for dependency posting *)

fun StrongDeps s = let val S = find s (!THEOREMS) in 
	if S = nil then Deps ("}"^s) else PreDeps (hd S) end;


fun USE level hlevel fo s t fo2 u = ((bumpcounter();

(let val FO = (changehlevel 0 hlevel (changelevel 0 level (labelvars fo))) 

in

let val M0 = match level level FO fo2 in 

if M0 = nil then u else

let val S = (subs level hlevel (hd M0) 
	(changehlevel 0 hlevel (changelevel 0 level (labelvars s))))

and T = (subs level hlevel (hd M0) 
	(changehlevel 0 hlevel (changelevel 0 level (labelvars t))))

in

let val M = mergematches (match level level fo2 fo2)(match level level S u) in

if M = nil then u

else ((NEWDEPS:=union(StrongDeps(eithervarhead fo))(!NEWDEPS));

	subs level hlevel (hd M) (fixvars level fo2 S T))

end end end end)));


val OLDENV = ref (!ENV);

(* USER COMMANDS (2) *)

fun applyenv s = if isatheorem ("}"^(eitherhead (parse s)))

	then (OLDENV:=(!ENV); exec(USE (level(!ENV)) (hlevel(!ENV)) 
	(Formatof ("}"^(eitherhead (parse s))))
	(Leftside ("}"^(eitherhead (parse s))))
	(Rightside ("}"^(eitherhead (parse s)))) (parse s));
	(* if (Isstratified(Infix(leftside(!ENV),ResOp"=",rightside(!ENV)))) 
		then *)
		(postdeps();look()) (*
	else (dropdeps(); errormessage "Introduces stratification error";
		ENV:=(!OLDENV);look())*)) handle BadSub =>
	(errormessage "Command aborted due to context term  abuse")

	else errormessage ("No environment "^s^" found to apply");

fun applyconvenv s = if isatheorem ("}"^(eitherhead (parse s)))

	then (exec(USE (level(!ENV)) (hlevel(!ENV)) 
	(Formatof ("}"^(eitherhead (parse s))))
	(Rightside ("}"^(eitherhead (parse s))))
	(Leftside ("}"^(eitherhead (parse s)))) (parse s));
	(* if (Isstratified(Infix(leftside(!ENV),ResOp"=",rightside(!ENV)))) 
		then *)
		(postdeps();look())
	(* else (dropdeps(); errormessage "Introduces stratification error";
		ENV:=(!OLDENV);look())*))handle BadSub =>
	(errormessage "Command aborted due to context term abuse")

	else errormessage ("No environment "^s^" found to apply");

(* USER COMMAND *)

(* the global assignment command -- this uses a match to make substitutions
on both the left and right side of the equation under construction *)

fun assign S T = 

let val s = parse S and t = parse T in

if declarecheck false 0 s andalso declarecheck false 0 t (* andalso
Isstratified s andalso Isstratified t *)

then let val M = (* cmatch old *) match 0 0 s t in

		if M = nil
		then errormessage ("No match in assignment of "
		^(baredisplay t)^" to "^(baredisplay s))

		else if declarecheck false 0 (subs 0 0 (hd M)
		(Infix(leftside(!ENV),ResOp"=",rightside(!ENV))))

		then (envmod(changerightside2 (subs 0 0 (hd M)));
			envmod(changeleftside2 (subs 0 0 (hd M))); look())

		else errormessage "Introduces predicate error"  end
		handle BadSub =>
		(errormessage "Command aborted due to context term abuse") 

else errormessage 
("Declaration or stratification errors found in assignment of "^(baredisplay t)^" to "^(baredisplay s))

end;

(* USER COMMANDS (3) *)

fun unification t =

	let val T = parse t in

	if declarecheck false (level(!ENV)) T (* andalso 
	Isstratified T *) andalso rulefree T

	then (getcurrent(); 
	let val M = unify (level(!ENV)) T (!CURRENTTERM) in
	if M = nil 
	then errormessage ("No match in unification of "
	^(baredisplay T)^" with "^(baredisplay (!CURRENTTERM)))

		else (OLDENV:= (!ENV);
		envmod(changerightside2 (subs 0 0 (hd M)));
		envmod(changeleftside2 (subs 0 0 (hd M))); 
		if declarecheck true 0 (leftside(!ENV))
		andalso declarecheck true 0 (rightside (!ENV))
		(* andalso Isstratified (leftside(!ENV))
		andalso Isstratified (rightside(!ENV)) *)

		then look()

		else (errormessage ("Unification of "
	^(baredisplay T)^" with "^(baredisplay (!CURRENTTERM))^
	" produces declaration or stratification errors");
	ENV:=(!OLDENV); look())) end )

	else errormessage 
("Level, declaration, stratification or embedded theorem error in unification with "
	^t) end;

val u = unification;

fun ul thm = (bumpcounter();
	unification (baredisplay (labelvars (Leftside thm))));

fun ur thm = (bumpcounter();
	unification (baredisplay (labelvars (Rightside thm))));

(* USER COMMAND *)

(* assignit sets the second parameter of assign to the current subterm *)

fun assignit s = (getcurrent(); if rulefree (!CURRENTTERM) andalso
changelevel (level(!ENV)) 0 (!CURRENTTERM) <> Constant "" then 
assign s (baredisplay(!CURRENTTERM)) else
errormessage "Cannot assign the current subterm";look());

(* assigninto "does the same things to both sides of the current equation";
it substitutes both sides of the equation for a given variable in a given
term, and uses the results as the new equation.  It destroys position
information *)

fun subinto s t u  = subs 0 0 [(s,u)] t;

(* USER COMMAND *)

fun assigninto s t = if stringtocon s = FreeVar s 

		then 
		if declarecheck false 0 (parse t) (* andalso 
			Isstratified (parse t) *)

		then if declarecheck false 0 (subinto s (parse t) 
		(Infix(leftside(!ENV),ResOp"=",rightside(!ENV))))

		then (top();envmod(changerightside2 (subinto s (parse t)));
			envmod(changeleftside2 (subinto s (parse t))); 
			look()) handle BadSub =>
		(errormessage "Command aborted due to context term abuse")

		else errormessage "Introduces predicate error"

		else errormessage ("Declaration or stratification error in "^t)

		else errormessage (s^" is not a free variable");

(* machinery for finding theorems which match given equations in
the theorem list; also see targetruleintro below *)

fun tacticdisplay format = if (!VERBOSITY)= 0 then () else

               let val FORMAT = parse format in

               if eitherhead FORMAT = "" 

               then errormessage ("Ill-formed argument "^format)

               else if not(isatheorem (eitherhead FORMAT)) then

               if isbuiltinthm (eitherhead FORMAT) then

               nopausemessage ((eitherhead FORMAT)^" is a built in theorem")

               else nopausemessage ((eitherhead FORMAT)^" is not a theorem")

               else 
               let val M = match 0 0 (Formatof(eitherhead FORMAT)) FORMAT in

               if M = nil 
               then nopausemessage (format^" does not match format of theorem")

               else let val (fo,ls,rs,dps) = Thm(eitherhead FORMAT) in

               (eqdisplay FORMAT (subs 0 0 (hd M) ls) (subs 0 0 (hd M) rs) dps;
               flush_Out(std_out))

               end end end;



(* the underlying function for finding matching theorems *)

fun prematchtheorem level s t nil = Constant "" |

	prematchtheorem level s t ((NA,x)::L) =

	let val (fo,lt,rt,dps) = (Thm NA) in

	let val FO = changelevel 0 level fo 
	and LT = changelevel 0 level lt
	and RT = changelevel 0 level rt in

	let val M =
	(* cmatch old *) match level level 
		((Infix(LT,ResOp"=",RT))) ((Infix(s,ResOp"=",t))) in

	if M = nil orelse NA = "" orelse hd (explode NA) = "}"

	then prematchtheorem level s t L

	else subs level 0 (hd M) FO

	end
	end
	end;

(* a variant *)

val RESTOFLIST = ref (!THEOREMS);

val RESTOFLIST2 = ref (!THEOREMS);

fun prematchtheorem2 b level s t nil = (if b then RESTOFLIST := nil
		else RESTOFLIST2:=nil;Constant "") |

	prematchtheorem2 b level s t ((NA,x)::L) =

	let val (fo,lt,rt,dps) = (Thm NA) in

	let val FO = changelevel 0 level fo
	and LT = if b then changelevel 0 level lt else changelevel 0 level rt
	and RT = if b then changelevel 0 level rt 
		else changelevel 0 level lt in

	let val M =
	(match level level LT s)
	and N = (match level level t RT) in
	let val P = mergematches M N 
		in

	if M = nil orelse N = nil orelse NA = "" orelse hd (explode NA) = "}"

	then prematchtheorem2 b level s t L

	else (if b then RESTOFLIST:=L else RESTOFLIST2:=L;
        thmdisplay (eitherhead fo);
	(if P = nil then FO else subs level 0 (hd P) FO))

	end end
	end
	end;


(* USER COMMAND *)

(* showmatchtheorem takes the two sides of an equation as separate arguments,
unlike the analogous function in Mark2 *)

fun showmatchtheorem s t = let val T =
(* cmatch weak *) prematchtheorem 0 (parse s) (parse t) (!THEOREMS) in

if T = Constant ""
then nopausemessage "Theorem not found"

else (nopausemessage(display (T)); thmdisplay (eitherhead T)) end;

(* utility for showrelevantthms *)
(* prevents completely generic theorems from matching *)

fun isgeneric (FreeVar t) = true |

	isgeneric (Infix(FreeVar s,VarOp t,FreeVar u)) = true |

	isgeneric (Infix(Constant "",VarOp s,FreeVar t)) = true |

	isgeneric (CaseExp(FreeVar s,FreeVar t,FreeVar u)) = true |

	isgeneric t = false;

(* USER COMMAND *)

(* shows all theorems which nontrivially match
the current subterm *)

fun showrelevantthms() = (showsometheorems (fn na =>
		(getcurrent(); ((match (level(!ENV)) (level(!ENV))
		(Leftside na) (!CURRENTTERM) <> nil) andalso
		(not(isgeneric (Leftside na))))
		orelse (match (level(!ENV)) (level(!ENV))
		(Rightside na)(!CURRENTTERM) <> nil) andalso
		not(isgeneric (Rightside na)))) (sortfun(!THEOREMS)));

(* functions for automatic formatting to assist the automatic
parameterization tactics !@ and !$ *)

(* the list of free variables found in s and not in t *)

fun autoformatlist s t = sortset(setminus (freevarlist2 s) (freevarlist2 t));

fun freevarlisttoterm nil = Constant "" |

	freevarlisttoterm [s] = FreeVar s |

	freevarlisttoterm (s::L) = 
		Infix(FreeVar s,ResOp",",freevarlisttoterm L);

fun autoformat na s t = let val L = freevarlisttoterm (
	(autoformatlist s t)) in

	if L = Constant ""

	then Constant na

	else Infix(Constant na,ResOp"@",L) end;

fun comesbefore x y = (baredisplay x) < (baredisplay y);


(* installation of user commands *)

fun addtomenu s x = MAINMENU:=listaddto s x (!MAINMENU);

fun addtomenusecure s x = (MAINMENU:=listaddto s x
(!MAINMENU);SECUREMENU:=listaddto s x (!SECUREMENU));

fun addtocurrentmenu s x = (MENUNAME:="script";MENU := listaddto s x (!MENU));

(* installation of commands for loading save files *)

fun addtoothermenu s x = LOADMENU := listaddto s x (!LOADMENU);

(* USER COMMAND *)

(* something to run after breaking out of a script with Control-C *)

fun reset() = (setnopause(); speakup(); NORULES:=false;
DEMO:=false;DIAGNOSTIC:=false; 
TESTTH := [std_in];TURNOFFPROMPT:=false;CloseAll();
mainmenu());


(* USER COMMAND *)

(* an ML-free user interface of sorts *)

(* now fixed to avert breakout due to I/O errors *)

fun noml() = (output(std_out,"\nWatson>  ");flush_Out(std_out);
	DEMO:=false;DIAGNOSTIC:=false;TURNOFFPROMPT:=false;
	executelines "Watson>  " std_in) handle _ => (reset();
		errormessage ("Uncaught exception -- probably I/O");
	        mainmenu(); 
	noml());

(* utility for breaking out of suspended processes *)

fun exit() = raise Breakout2;

(* tactic engine(s) *)

(* implemented the alternative rule infixes quite differently:
what was ?x =>> ?y => ?t is now (?y =>> ?x) => ?t *)

(* applybuiltinthm and thmresult handle all individual theorem
applications.  all axiomatic dependencies will be posted by thmresult
(or deduced from scin/scout data) *)

val STOPINPUT = ref false;  (* toggle for stopping INPUT tactic *)

(* val SHELLENVS = ref([!ENV]); (* used to check for illicit environment
				changes under SHELL *) *)

(* list of saved rewrites already performed, listed by
embedded theorem, term to which applied, term which results, and
sum of level and hlevel *)

(* strictly an internal affair of execute *)

(* it seems that any registered rewrites must be carried out
completely by steps, as otherwise there is no way to record
results --it is worse, steps can't handle this at all, without
a more complex implementation.  *)

(* it also appears that the behavior of the reserved operator
(whatever its shape) must be controlled by execute, not by
thmresult *)

(* it seems that it will not work with ari ? *)

val SAVEDREWRITES = ref([(0,[(Constant"",[(Constant"",Constant"")])])]);

fun findsavedrewrite Level Sense t u = 

   if Level < 0 then Constant ""

   else let val F1 = find Level (!SAVEDREWRITES) in 

   if F1 = nil then findsavedrewrite (Level-1) Sense t u

   else let val F2 = find t (hd F1)

   in if F2 = nil then findsavedrewrite (Level-1) Sense t u

   else  let val F3 = find u (if Sense = "<=" then 
   (map (fn (x,y)=>(y,x)) (hd F2)) else hd F2)

   in if F3 = nil then findsavedrewrite (Level-1) Sense t u

   else ((* nopausemessage ("Found "^(baredisplay (hd F3))); *) hd F3)

   end end end; 

fun addsavedrewrite Level Sense t u v =
((* nopausemessage ( "Adding "^(baredisplay t)^" "^(baredisplay u)^"  "^(baredisplay v)); *)
   let val F1 = find Level (!SAVEDREWRITES) in

   if F1 = nil

   then SAVEDREWRITES:=addto Level [(t,[(u,v)])] (!SAVEDREWRITES)

   else let val F2 = find t (hd F1) in

   if F2 = nil then 
   SAVEDREWRITES:= strongadd Level 
	(strongadd t [(u,v)] (hd F1))(!SAVEDREWRITES)

   else SAVEDREWRITES:= 
   strongadd Level(strongadd t (strongadd u v (hd F2)) (hd F1))
   (!SAVEDREWRITES)

   end end);

fun purgesavedrewrites n = SAVEDREWRITES:=drop n (!SAVEDREWRITES);

fun applybuiltin level hlevel hyps 
		(Infix(Constant "FLIP",ResOp"@",thm)) s
		(Infix(x,t,y)) =

	if comesbefore y x

	then thmresult level hlevel hyps thm s (Infix(x,t,y))

	else (Infix(x,t,y)) |

	(* crash out of an INPUT environment *)

	applybuiltin level hlevel hyps (Constant "STOPINPUT") s t =

		(STOPINPUT:=true;Constant "") |

	(* shell out of an INPUT environment; crashes if any changes made in
	environment during the shelled out period -- disabled *)

	(* admits stacked SHELL environments formally, but don't do it!!! *)

(*	applybuiltin level hlevel hyps (Constant "SHELL") s t =

		((SHELLENVS:=(!ENV)::(!SHELLENVS));
		noml(); 
		if (!ENV) = hd (!SHELLENVS) then
		(SHELLENVS:=tl (!SHELLENVS);t)
		else
		(SHELLENVS:=tl (!SHELLENVS);
		errormessage "Environment changed in SHELL command";
		Constant "")) | *)

	applybuiltin level hlevel hyps (Constant "INPUT") s t

	= (if (!VERBOSITY)=2 then (output(std_out,(!Returns));
	output(std_out,guiprelookhyps 1 level hyps); 
	showterm "INPUT term display" t;
	output(std_out,(!Returns));
	if s = "=>" then output(std_out,"INPUT:  ")
                    else output(std_out,"INPUT (converse):  ");
	flush_Out(std_out)) else ();
	if (!STOPINPUT) then Constant "" else
	(thmresult level hlevel hyps
	(if length(!TESTTH)=1 then 
	(if (!GUIMODE) then (suspend(fn ()=>());
        parse (!SAVEINPUT)) else parse (stringinput std_in)) else
	(SAVEINPUT:=(stringinput(hd(!TESTTH)));
	if (!DIAGNOSTIC) andalso length(!TESTTH)>1
	then (output(std_out,(!SAVEINPUT)^(!Returns));
		flush_Out(std_out);
		if input(std_in,1) = "q" then raise Breakout else ();())
	else (); parse (!SAVEINPUT)))) s t) |

	applybuiltin level hlevel hyps (Infix(Constant "OUTPUT",ResOp"@",t))
		s x =

	(output(std_out, if (!PROMPT) then "" else (!Returns)^"OUTPUT:\n");
	showterm "OUTPUT term display" t;
	flush_Out(std_out);

	x) |


	applybuiltin level hlevel hyps 
		(Infix(Constant "BIND",ResOp"@",t)) "=>" y

	= let val A = bind level y t in
	if A = Constant "" then y
	else (Infix(A,ResOp"@",t)) end |

	applybuiltin level hlevel hyps 
		(Infix(Constant "BINDM",ResOp"@",t)) "=>" y

	= let val A = prebind level y t in
	if A = Constant "" then y
	else (Infix(A,ResOp"@!",t)) end |

	applybuiltin level hlevel hyps (Constant "EVAL") "=>" 
		(Infix(Function t,ResOp"@",u)) =

	strongeval level (Function t) u |
	applybuiltin level hlevel hyps (Constant "EVALM") "=>" 
		(Infix(Function t,ResOp"@!",u)) =

	eval level (Function t) u |

	applybuiltin level hlevel hyps 
		(Infix(Constant "UNEVAL",ResOp"@",Function t)) "=>" y =

	let val A = strongunevals 1 level (Function t) (Function t) y in

		if A = nil then y

		else strongevalsterm (Function t) A  end |

	applybuiltin level hlevel hyps 
		(Infix(Constant "UNEVALM",ResOp"@",Function t)) "=>" y =

	let val A = unevals 1 level (Function t) (Function t) y in

		if A = nil then y

		else evalsterm (Function t) A  end |

	applybuiltin level hlevel hyps 
		(Infix(Numeral [0],ResOp"|-|",Numeral n)) s y =

	let val N = listtoint n in

	if listindex N hyps = nil then y

	else let val (lt,rt,po,se,lv) = hd(listindex N hyps) in

	if se <> 1 orelse not(rulefree lt) orelse not(rulefree rt) then y

	else if s = "=>" andalso y = (changelevel lv level lt) then 
		(changelevel lv level rt)
	else if s = "<=" andalso y = (changelevel lv level rt) then 
		(changelevel lv level lt)
	else y

	end
	end |
	applybuiltin level hlevel hyps 
		(Infix(Numeral [1],ResOp"|-|",Numeral n)) "=>"
		 (CaseExp(x,y,z)) =

	let val N = listtoint n in

	if listindex N hyps = nil then (CaseExp(x,y,z))

	else let val (lt,rt,po,se,lv) = hd(listindex N hyps) in

	if x = Infix(changelevel lv level lt,ResOp"=",
		changelevel lv level rt) orelse lt = Constant "true"
		andalso changelevel lv level rt = x

	then if se = 1 then y else z

	else (CaseExp(x,y,z))
	
	end
	end |
	applybuiltin level hlevel hyps 
		(Infix(Numeral [1],ResOp"|-|",Numeral n)) "<="
		 y =

	let val N = listtoint n in

	if listindex N hyps = nil then y

	else let val (lt,rt,po,se,lv) = hd(listindex N hyps) in

	let val Var = if level = 0 then 
		(bumpcounter();FreeVar ("?x_"^(makestring (!COUNTER))))

		else (bumpcounter();
		Infix(FreeVar (("?x_"^(makestring (!COUNTER)))),ResOp"@",
			BoundVar level))

	and Hyp = Infix(changelevel lv level lt,ResOp"=",
		changelevel lv level rt)

	in  if not (rulefree Hyp) then y


	else if se = 1 then CaseExp(Hyp,y,Var) else CaseExp(Hyp,Var,y)

	end
	
	end
	end |
	applybuiltin level hlevel hyps 
		(Infix((Infix(Numeral [2],ResOp"|-|",Numeral n)),ResOp"@",x))
		"<=" y =

	let val N = listtoint n in

	if listindex N hyps = nil then y

	else let val (lt,rt,po,se,lv) = hd(listindex N hyps) in

	let val Hyp = Infix(changelevel lv level lt,ResOp"=",
		changelevel lv level rt)

	in if not (rulefree Hyp) then y 

	else if se = 1 then CaseExp(Hyp,y,x) else CaseExp(Hyp,x,y)

	end
	
	end
	end |

	applybuiltin level hlevel hyps 
		(Infix(x,ResOp"=>>",y)) s z =

	let val NA = eithervarhead x in

	if Isatheorem NA

	then let val (FO,LT,RT,DPS) = Thm NA in
	if s = "=>"

	then 
	if mergematches
(match level level (changelevel 0 level(changehlevel 0 hlevel FO))
	x) 
(match level level (changelevel 0 level(changehlevel 0 hlevel LT)) z) = nil

	then (* thmresult level hlevel hyps y "=>" z *)
             Infix(y,ResOp "=>",z)

	else thmresult level hlevel hyps x "=>" z
             

	else 
	if mergematches
(match level level (changelevel 0 level(changehlevel 0 hlevel FO))
	x) 
(match level level (changelevel 0 level(changehlevel 0 hlevel RT)) z) = nil

	then (* thmresult level hlevel hyps y "=>" z *)

             Infix(y,ResOp"=>",z)

	else thmresult level hlevel hyps x "<=" z
            
	

	end 

	else if isbuiltinthm NA

	(* not very subtle -- it just checks to see if any change in 
	the term happens; it will for example regard a trivial hyp
	x = x as failing even if it applies *)

	then let val step1 = applybuiltin level hlevel hyps x s z in

		if step1 = z then (* thmresult level hlevel hyps y "=>" z *)
                                  Infix(y,ResOp "=>",z)

		else step1 end

	else z

	end |

	applybuiltin level hlevel hyps 
		(Infix(x,ResOp"<<=",y)) s z =

	let val NA = eithervarhead x in

	if Isatheorem NA

	then let val (FO,LT,RT,DPS) = Thm NA in
	if s = "=>"

	then 
	if mergematches
(match level level (changelevel 0 level(changehlevel 0 hlevel FO))
	x) 
(match level level (changelevel 0 level(changehlevel 0 hlevel LT)) z) = nil

	then (* thmresult level hlevel hyps y "<=" z *)
             Infix(y,ResOp"<=",z)

	else  thmresult level hlevel hyps x "=>" z 
            

	else 
	if mergematches
(match level level (changelevel 0 level(changehlevel 0 hlevel FO))
	x) 
(match level level (changelevel 0 level(changehlevel 0 hlevel RT)) z) = nil

	then (* thmresult level hlevel hyps y "<=" z *)
             Infix(y,ResOp"<=",z)

	else  thmresult level hlevel hyps x "<=" z 
             

	end 

	else if isbuiltinthm NA

	(* not very subtle -- it just checks to see if any change in 
	the term happens; it will for example regard a trivial hyp
	x = x as failing even if it applies *)

	then let val step1 = applybuiltin level hlevel hyps x s z in

		if step1 = z then (* thmresult level hlevel hyps y "<=" z *)
                                  Infix(y,ResOp"<=",z)

		else step1 end

	else z

	end |
	applybuiltin level hlevel hyps 
		(Infix(x,ResOp"*>",y)) s z =

	let val NA = eithervarhead x in

	if Isatheorem NA

	then let val (FO,LT,RT,DPS) = Thm NA in
	if s = "=>"

	then 
	if mergematches
(match level level (changelevel 0 level(changehlevel 0 hlevel FO))
	x) 
(match level level (changelevel 0 level(changehlevel 0 hlevel LT)) z) = nil

	then z

	else (* thmresult level hlevel hyps y "=>" *)
                Infix(y,ResOp"=>", 
		(thmresult level hlevel hyps x "=>" z))

	else 
	if mergematches
(match level level (changelevel 0 level(changehlevel 0 hlevel FO))
	x) 
(match level level (changelevel 0 level(changehlevel 0 hlevel RT)) z) = nil

	then  z

	else (* thmresult level hlevel hyps y "=>" *)
                Infix(y,ResOp"=>",
		(thmresult level hlevel hyps x "<=" z))
	

	end 

	else if isbuiltinthm NA

	(* not very subtle -- it just checks to see if any change in 
	the term happens; it will for example regard a trivial hyp
	x = x as failing even if it applies *)

	then let val step1 = applybuiltin level hlevel hyps x s z in

		if step1 = z then  z

		else (* thmresult level hlevel hyps y "=>" *)
                Infix(y,ResOp"=>", step1) end

	else z

	end |

	applybuiltin level hlevel hyps 
		(Infix(x,ResOp"<*",y)) s z =

	let val NA = eithervarhead x in

	if Isatheorem NA

	then let val (FO,LT,RT,DPS) = Thm NA in
	if s = "=>"

	then 
	if mergematches
(match level level (changelevel 0 level(changehlevel 0 hlevel FO))
	x) 
(match level level (changelevel 0 level(changehlevel 0 hlevel LT)) z) = nil

	then  z

	else (* thmresult level hlevel hyps y "<=" *)
                Infix(y,ResOp"<=", 
		(thmresult level hlevel hyps x "=>" z))

	else 
	if mergematches
(match level level (changelevel 0 level(changehlevel 0 hlevel FO))
	x) 
(match level level (changelevel 0 level(changehlevel 0 hlevel RT)) z) = nil

	then  z

	else (* thmresult level hlevel hyps y "<=" *)
                Infix(y,ResOp"<=", 
		(thmresult level hlevel hyps x "<=" z))

	end 

	else if isbuiltinthm NA

	(* not very subtle -- it just checks to see if any change in 
	the term happens; it will for example regard a trivial hyp
	x = x as failing even if it applies *)

	then let val step1 =  applybuiltin level hlevel hyps x s z in

		if step1 = z then z

		else (* thmresult level hlevel hyps y "<=" *)
                Infix(y,ResOp"<=", step1) end

	else z

	end |
	(* modified to allow application of converse theorems *)
        (* further modified to test whether the given equation
        (not just the matching theorem) matches the target *)
	applybuiltin level hlevel hyps (Infix(x,ResOp"=",y)) s z =
		if s = "=>" then 
                if match level level x z = nil then z else
                let val T = 
		prematchtheorem level x y (!THEOREMS) in
		if T = Constant "" then
		thmresult level hlevel hyps 
		(prematchtheorem level y x (!THEOREMS)) "<=" z
		else thmresult level hlevel hyps
		(prematchtheorem level x y (!THEOREMS)) s z end
		else 
                if match level level y z = nil then z else
                let val T = 
		prematchtheorem level x y (!THEOREMS) in
		if T = Constant "" then
		thmresult level hlevel hyps 
		(prematchtheorem level y x (!THEOREMS)) "=>" z
		else thmresult level hlevel hyps
		(prematchtheorem level x y (!THEOREMS)) s z end
		|

	applybuiltin level hlevel hyps 
	(Infix(Infix(x,ResOp"!@",Constant Na),ResOp"@",y)) s z =
	
	let val leftfun  = (if s = "=>" then Leftside else Rightside)

	and rightfun = (if s = "=>" then Rightside else Leftside) in

		if  Isatheorem Na 
		then USE level hlevel 
		(autoformat Na (Rightside Na) (Leftside Na)) (leftfun Na)
			(rightfun Na) (Infix(Constant Na,ResOp"@",y)) z

		else z

		end

		|

	applybuiltin level hlevel hyps 
	(Infix(Infix(x,ResOp"!$",Constant Na),ResOp"@",y)) s z =
	
	let val leftfun  = (if s = "=>" then Leftside else Rightside)

	and rightfun = (if s = "=>" then Rightside else Leftside) in

		if  Isatheorem Na 
		then USE level hlevel 
		(autoformat Na (Leftside Na) (Rightside Na)) (rightfun Na)
			(leftfun Na) (Infix(Constant Na,ResOp"@",y)) z

		else z

		end

		|

        applybuiltin level hlevel hyps (Constant "SCOUT") "=>" x =

          thmresult level hlevel hyps
          (Constant(scoutof (eitherhead x))) 
          (scoutdir(Leftside(scoutof(eitherhead x)))
          (Rightside(scoutof (eitherhead x)))) x |

        applybuiltin level hlevel hyps (Constant "SCOUT") "<=" 
          (Infix(t,ResOp":",x)) =

          thmresult level hlevel hyps
          (Constant(scoutof (eitherhead x))) (reversedir
          (scoutdir(Leftside(scoutof(eitherhead x)))
          (Rightside(scoutof (eitherhead x))))) x

                |
        applybuiltin level hlevel hyps (Constant "SCIN") s x =

          if s = "=>" then thmresult level hlevel hyps
          (Constant(scinof (eitherhead x))) 
          (scindir(Leftside(scinof(eitherhead x)))
          (Rightside(scinof (eitherhead x)))) x

          else thmresult level hlevel hyps
          (Constant(scinof (eitherhead x))) (reversedir
          (scindir(Leftside(scinof(eitherhead x)))
          (Rightside(scinof (eitherhead x))))) x


                |
        applybuiltin level hlevel hyps (Constant "SCINL") s x =

          if scinleftof (eitherhead x) = scinrightof (eitherhead x) then x else

          if s = "=>" then thmresult level hlevel hyps
          (Constant(scinleftof (eitherhead x)))
          (scinleftdir(Leftside(scinleftof(eitherhead x)))
          (Rightside(scinleftof (eitherhead x)))) x

          else thmresult level hlevel hyps
          (Constant(scinleftof (eitherhead x))) (reversedir
          (scinleftdir(Leftside(scinleftof(eitherhead x)))
          (Rightside(scinleftof (eitherhead x))))) x


                |
        applybuiltin level hlevel hyps (Constant "SCINR") s x =

          if scinleftof (eitherhead x) = scinrightof (eitherhead x) then x else

          if s = "=>" then thmresult level hlevel hyps
          (Constant(scinrightof (eitherhead x))) 
          (scinrightdir(Leftside(scinrightof(eitherhead x)))
          (Rightside(scinrightof (eitherhead x)))) x

          else thmresult level hlevel hyps
          (Constant(scinrightof (eitherhead x))) (reversedir
          (scinrightdir(Leftside(scinrightof(eitherhead x)))
          (Rightside(scinrightof (eitherhead x))))) x

                |

	applybuiltin level hlevel hyps x s y = y


and thmresult level hlevel hyps x s y =

	let val leftfun  = (if s = "=>" then Leftside else Rightside)

	and rightfun = (if s = "=>" then Rightside else Leftside) in

	let val NA = eithervarhead x in

	if  Isatheorem NA 
		then (if hasmodule NA then StrongOpen NA else ();

                USE level hlevel 
		(Formatof NA) (leftfun NA) (rightfun NA) x y)

	else if isbuiltinthm NA then 

	applybuiltin level hlevel hyps x s y

	else (* not a valid theorem at all! *) y

	end end;

(* built in arithmetic operations *)

fun lastdigit n = n mod 10;

fun restofdigits n = inttolist(n div 10)

and inttolist 0 = nil |

	inttolist n = (lastdigit n)::(restofdigits n);

fun addlistints nil L = L |

	addlistints L nil = L |

	addlistints (head1::L) (head2::M) =

		(lastdigit(head1 + head2))::
		(addlistints (restofdigits (head1+head2))
		(addlistints L M));

fun multiplyints nil L = nil |

	multiplyints L nil = nil |

	multiplyints (head1::tail1) (head2::tail2) =

		rev(stripzeroes(rev(addlistints (inttolist (head1*head2))

		(addlistints (0::((multiplyints [head1] tail2)))

		(addlistints (0::((multiplyints [head2] tail1)))

		(0::(0::(multiplyints tail1 tail2))))))));

fun 

	lessints L nil = false |

	lessints nil L = true |

	lessints (head1::tail1) (head2::tail2) =

		(lessints tail1 tail2) orelse ((tail1 = tail2) 
			andalso ((head1:int) < head2));

(* This is subtraction of unsigned integers; it returns zero *)
(* when a negative answer would normally be expected *)

fun subtractints L M = if lessints L M orelse L=M then nil 
	else if M = nil then L
	else if hd L >= hd M then ((hd L - hd M)::
		(subtractints (tl L) (tl M)))

	else ((10 + hd L - hd M)::(subtractints (tl L) 
		(addlistints [1] (tl M))));

fun divideints L M = if lessints M [1] 
		then (nil) 

	else if lessints L M then nil

	else if lessints (tl L) M then addlistints [1] 
		(divideints (subtractints L M) M)

	else addlistints (0::divideints (tl L) M)

		(divideints (addlistints (0::
			(remainder (tl L) M)) [hd L]) M)

and remainder L M = if lessints M [1] 
		then (L) 

	else if lessints L M then L

	else if lessints (tl L) M then remainder (subtractints L M) M

	else remainder (addlistints (0::(remainder (tl L) M)) [hd L]) M;

(* evaluates a single arithmetic expression *)

fun aritheval (Infix(Numeral m,ResOp"+!",Numeral n)) =

Numeral (stripzeroes2(addlistints m n)) |
aritheval (Infix(Numeral m,ResOp"-!",Numeral n)) =

Numeral (stripzeroes2(subtractints m n)) |
aritheval (Infix(Numeral m,ResOp"*!",Numeral n)) =

Numeral (stripzeroes2(multiplyints m n)) |
aritheval (Infix(Numeral m,ResOp"/!",Numeral n)) =

Numeral (stripzeroes2(divideints m n)) |
aritheval (Infix(Numeral m,ResOp"%!",Numeral n)) =

Numeral (stripzeroes2(remainder m n)) |
aritheval (Infix(Numeral m,ResOp"=!",Numeral n)) =

if m = n then Constant "true" else Constant "false" |
aritheval (Infix(Numeral m,ResOp"<!",Numeral n)) =

if lessints m n then Constant "true" else Constant "false" |
aritheval (Infix(Numeral m,ResOp">!",Numeral n)) =

if lessints n m then Constant "true" else Constant "false" |

aritheval t = t;

(* function for automatic reduction of hypotheses true=?p to ?p *)

fun oddchoice (Infix(Constant"true",ResOp"=",x)) = oddchoice x |

	oddchoice t = t;

(* the tactic engine itself.  It follows a depth-first strategy,
applying innermost embedded theorems, including those introduced
in the course of execution *)

fun isupterm (Infix(Infix(Constant"UP",ResOp"@",th),ResOp"=>",
            rest)) = true |

    isupterm t = false;

fun upthm (Infix(Infix(Constant"UP",ResOp"@",th),ResOp"=>",
            rest))  = th |

    upthm t = t;

fun upterm (Infix(Infix(Constant"UP",ResOp"@",th),ResOp"=>",
            rest)) = rest |

    upterm t = t;

fun upterms t = if upterm t = t then t else upterms (upterm t);

fun preexecuteargs level hlevel hyps (Infix(x,ResOp "@",y)) =

	Infix(preexecuteargs level hlevel hyps x,ResOp "@",
		preexecute level hlevel hyps y) |

	preexecuteargs level hlevel hyps (Infix(x,ResOp "=>",y)) =

		preexecute level hlevel hyps (Infix(x,ResOp "=>",y))|

	preexecuteargs level hlevel hyps (Infix(x,ResOp "<=",y)) =

		preexecute level hlevel hyps (Infix(x,ResOp "<=",y))|

	preexecuteargs level hlevel hyps (Infix(x,i,y)) =

		Infix(preexecute level hlevel hyps x,i,
			preexecute level hlevel hyps y) |

	preexecuteargs level hlevel hyps t = t

and   preexecute level hlevel hyps (Infix(x,ResOp"@",y)) =

	let val X = preexecute level hlevel hyps x
	and Y = preexecute level hlevel hyps y in

      if isupterm X then preexecute level hlevel hyps
      (Infix(upthm X,ResOp"=>",Infix(upterm X,ResOp"@",Y)))

      else if isupterm Y then preexecute level hlevel hyps
      (Infix(upthm Y,ResOp"=>",Infix(X,ResOp"@",upterm Y)))

	else if hasprogram (eitherhead X)
	andalso match level level (Leftside (programof (eitherhead X)))
		(Infix(X,ResOp"@",Y)) <> nil

	then preexecute level hlevel hyps
	(thmresult level hlevel hyps 
	(Constant (programof(eitherhead X))) "=>" (Infix(X,ResOp"@",Y)))

	else (Infix(X,ResOp"@",Y))  end |

preexecute level hlevel hyps (Infix
          (Infix(Constant "",ResOp"#!",th),ResOp"=>",term)) =

          let val A = preexecuteargs level hlevel hyps th and
          B = upterms(preexecute level hlevel hyps term) in

          let val T = findsavedrewrite (level+hlevel) "=>" 
          (A) 
          (B) in

          if T = Constant "" then 

          let val U = 
          preexecute level hlevel hyps (Infix(
          A,ResOp"=>",B)) in

          (addsavedrewrite (level+hlevel) "=>" A B U; U)

          end

          else T

          end end |

preexecute level hlevel hyps (Infix
          (Infix(Constant "",ResOp"#!",th),ResOp"<=",term)) =

          let val A = preexecuteargs level hlevel hyps th and
          B = upterms(preexecute level hlevel hyps term) in

          let val T = findsavedrewrite (level+hlevel) "<=" 
          (A) 
          (B) in

          if T = Constant "" then 

          let val U = 
          preexecute level hlevel hyps (Infix(
          A,ResOp"<=",B)) in

          (addsavedrewrite (level+hlevel) "<=" A B U; U)

          end

          else T

          end end |



preexecute level hlevel hyps (Infix(x,ResOp s,y)) =

      if isupterm (Infix(x,ResOp s,y))

      then (Infix(x,ResOp s,preexecute level hlevel hyps y))

	else if ruleinfix s

		then preexecute level hlevel hyps 
		(thmresult level hlevel hyps 
			(preexecuteargs level hlevel hyps x)
			s 
			(upterms(preexecute level hlevel hyps y)))

	else if arithop s andalso (not(isupterm x))
      andalso (not (isupterm y))

		then aritheval((Infix(preexecute level hlevel hyps x,ResOp s,

		preexecute level hlevel hyps y)))

	else let val X = preexecute level hlevel hyps x
		and Y = preexecute level hlevel hyps y in

            if isupterm X then preexecute level hlevel hyps
                   (Infix(upthm X,ResOp"=>",Infix(upterm X,ResOp s,Y)))

            else if isupterm Y then preexecute level hlevel hyps
                   (Infix(upthm Y,ResOp"=>",Infix(X,ResOp s,upterm Y)))

		else if hasprogram (s)
		andalso match level level (Leftside (programof (s)))
			(Infix(X,ResOp s,Y)) <> nil

		then preexecute level hlevel hyps
		(thmresult level hlevel hyps 
		(Constant(programof(s))) "=>"
		(Infix(X,ResOp s,Y)))

		else (Infix(X,ResOp s,Y)) end |



	preexecute level hlevel hyps (Infix(x,i,y)) =

		let val X = preexecute level hlevel hyps x
		and Y = preexecute level hlevel hyps y in

            if isupterm X then preexecute level hlevel hyps
                   (Infix(upthm X,ResOp"=>",Infix(upterm X,i,Y)))

            else if isupterm Y then preexecute level hlevel hyps
                   (Infix(upthm Y,ResOp"=>",Infix(X,i,upterm Y)))

		else 

		if hasprogram (opdisplay i)
		andalso match level level (Leftside (programof (opdisplay i)))
			(Infix(X,i,Y)) <> nil

		then preexecute level hlevel hyps
		(thmresult level hlevel hyps 
		(Constant(programof(opdisplay i))) "=>"
		(Infix(X,i,Y)))

		else (Infix(X,i,Y)) end |

	preexecute level hlevel hyps (Function t) =

            let val T = preexecute (level+1) hlevel hyps t in
            (purgesavedrewrites (level+hlevel+1);
            if isupterm T andalso 
            changelevel (level+1) level (upthm T) <> Constant ""

            then preexecute level hlevel hyps 
            (Infix(upthm T,ResOp"=>",Function(upterm T))) 

		else if (isupterm T) then preexecute level hlevel hyps
            (Function (upterm T))

            else Function T)

            end |

	preexecute level hlevel hyps (CaseExp(u,v,w)) =

		let val U = oddchoice(preexecute level hlevel hyps u) in

		if U = Constant "true" then preexecute level hlevel hyps v

		else if U = Constant "false" then 
				preexecute level hlevel hyps w

            else let val V = preexecute level (hlevel+1)
 		(rev ((coercehypslistsense 1 level
		(equationfromterm U))::(rev hyps)))
		 v 

            and W = preexecute level (hlevel+1)  
		(rev ((coercehypslistsense 2 level
		(equationfromterm U))::(rev hyps)))
		 w in


            (purgesavedrewrites (level+hlevel+1);
            if isupterm U then

            preexecute level hlevel hyps
            (Infix(upthm U,ResOp"=>",CaseExp(upterm U,V,W)))

            else if isupterm V then
            preexecute level hlevel hyps
            (Infix(upthm V,ResOp"=>",CaseExp(U,upterm V,W)))

            else if isupterm W then
            preexecute level hlevel hyps
            (Infix(upthm W,ResOp"=>",CaseExp(U,V,upterm W)))

		else CaseExp(U,V,W)) end end|

	preexecute level hlevel hyps t = t;

(* USER COMMAND *)

(* the tactic interpreter *)

fun execute() = ((SAVEDREWRITES:=nil;
        STOPINPUT:=false;
	OLDENV:=(!ENV);
	exec (preexecute 
	(level(!ENV)) (hlevel(!ENV)) (hypslist(!ENV)));
	if (* Isstratified (Infix(leftside(!ENV),ResOp"=",rightside(!ENV))) 
	andalso *) declarecheck true 0 (leftside(!ENV))
	andalso declarecheck true 0 (rightside(!ENV))

	then postdeps()
	else (dropdeps();
		errormessage "Introduces declaration or stratification error";
		ENV:=(!OLDENV));
	CloseAll();look()) handle OutOfTime => 
        (CloseAll();errormessage "Ran out of time")) handle BadSub =>
	(CloseAll();errormessage "Command aborted due to context term abuse")
        ;

(* functions for fine trace control *)

val TRACE = ref 0;

val TRACELEVELS = ref ([("bogus",0)]);

fun tracelevel s = safefind 0 s (!TRACELEVELS);

(* USER COMMANDS (2) *)

(* user command to set trace level for a particular tactic *)

fun settracelevel s n = TRACELEVELS := addto s n (!TRACELEVELS);

(* user command to set the level at which the trace function steps()
starts executing tactics completely instead of stepping through them *)

fun settrace n = if n>0 then (TRACE:=n) else (TRACE:=0);

(* the trace facility; it carries out the same operations as thmresult,
one step at a time; all innermost embedded theorems (or other executable
terms) are handled at the same time *)

(* new version of rulefree needed for clean handling of functional
programming by the trace function *)

fun rulefree2 level (Infix(x,ResOp"@",y)) = rulefree2 level x 
	andalso rulefree2 level y andalso not(isupterm x)
      andalso not(isupterm y)
	andalso ((not (hasprogram (eitherhead x))) orelse
	(match level level (Leftside (programof (eitherhead x))) 
	(Infix(x,ResOp"@",y)) = nil)) |

	rulefree2 level (Infix(Numeral m,ResOp s,Numeral n)) = not(arithop s) |

	rulefree2 level (Infix(x,ResOp s, y)) = 

      (isupterm (Infix(x,ResOp s,y)) andalso rulefree2 level y)
      orelse ((not (ruleinfix s)) andalso rulefree2 level x
      andalso rulefree2 level y andalso (not(isupterm x))
      andalso (not(isupterm y))) |

	rulefree2 level 
		(CaseExp(Infix(Constant"true",ResOp"=",x),y,z)) = false |

	rulefree2 level (CaseExp (u,v,w)) = u <> Constant "true" andalso
	u <> Constant "false" andalso rulefree2 level u 
	andalso rulefree2 level v andalso rulefree2 level w 
      andalso (not(isupterm u)) andalso (not(isupterm v))
      andalso (not(isupterm w))|

	rulefree2 level (Function t) = rulefree2 (level+1) t 
      andalso (not (isupterm t))|

	rulefree2 level (Infix(x,i,y)) = rulefree2 level x 
			andalso rulefree2 level y 
            andalso (not (isupterm x)) andalso (not(isupterm y))

		andalso not (hasprogram (opdisplay i)) |

	rulefree2 level t = true;


fun preonestepargs level hlevel hyps (Infix(x,ResOp "@",y)) =

	Infix(preonestepargs level hlevel hyps x,ResOp "@",
		preonestep level hlevel hyps y) |

	preonestepargs level hlevel hyps (Infix(x,ResOp "=>",y)) =

		preonestep level hlevel hyps (Infix(x,ResOp "=>",y)) |

	preonestepargs level hlevel hyps (Infix(x,ResOp "<=",y)) =

		preonestep level hlevel hyps (Infix(x,ResOp "<=",y)) |

	preonestepargs level hlevel hyps (Infix(x,i,y)) =
		Infix(preonestep level hlevel hyps x,i,
			preonestep level hlevel hyps y) |

	preonestepargs level hlevel hyps t = t

and preonestep level hlevel hyps (Infix(x,ResOp"@",y)) =

      if isupterm x andalso rulefree2 level y andalso rulefree2 level x
      then preonestep level hlevel hyps
      (Infix(upthm x,ResOp"=>",Infix(upterm x,ResOp"@",y)))

      else if isupterm y andalso rulefree2 level x andalso rulefree2 level y
      then preonestep level hlevel hyps
      (Infix(upthm y,ResOp"=>",Infix(x,ResOp"@",upterm y)))

	else if rulefree2 level y andalso rulefree2 level x
	andalso hasprogram (eitherhead x)
	andalso match level level (Leftside (programof (eitherhead x)))
		(Infix(x,ResOp"@",y)) <> nil

	then thmresult level hlevel hyps 
	(Constant(programof(eitherhead x))) "=>"
	(Infix(x,ResOp"@",y))

	else (Infix(preonestep level hlevel hyps x,ResOp"@",
		preonestep level hlevel hyps y)) |

     preonestep level hlevel hyps (Infix
          (Infix(Constant "",ResOp"#!",th),ResOp"=>",term)) =

     (nopausemessage "Behavior of #! is not simulated by steps";
     preonestep level hlevel hyps (Infix(th,ResOp"=>",term))) |

     preonestep level hlevel hyps (Infix
          (Infix(Constant "",ResOp"#!",th),ResOp"<=",term)) =

     (nopausemessage "Behavior of #! is not simulated by steps";
     preonestep level hlevel hyps (Infix(th,ResOp"<=",term))) |

	preonestep level hlevel hyps (Infix(x,ResOp s,y)) =

      if rulefree2 level x andalso rulefree2 level y
      andalso isupterm (Infix(x,ResOp s,y))

      then Infix(x,ResOp s,y)

	else if ruleinfix s andalso rulefree2 level y andalso rulefree2 level x

		then 

		if (tracelevel (eitherhead x) > (!TRACE))

		then (preexecute level hlevel hyps (Infix(x,ResOp s,y)))

		else (thmresult level hlevel hyps x s (upterms y))

	else if ruleinfix s then

		Infix(preonestepargs level hlevel hyps x, ResOp s,
			preonestep level hlevel hyps y)

	else if arithop s 
      andalso rulefree2 level x andalso rulefree2 level y
      andalso (not(isupterm x)) andalso (not(isupterm y))

		then aritheval((Infix(preonestep level hlevel hyps x,ResOp s,

		preonestep level hlevel hyps y)))

	else 	if rulefree2 level x andalso rulefree2 level y
            andalso isupterm x then

            (Infix(upthm x,ResOp"=>",(Infix(upterm x,ResOp s,y))))

            else if rulefree2 level x andalso rulefree2 level y
            andalso isupterm y then

            (Infix(upthm y,ResOp"=>",(Infix(x,ResOp s,upterm y))))

            else if hasprogram (s) andalso rulefree2 level x
		andalso rulefree2 level y andalso match level level
		(Leftside(programof(s))) (Infix(x,ResOp s,y)) <> nil

		then thmresult level hlevel hyps 
		(Constant(programof(s))) "=>" (Infix(x,ResOp s,y))

		else

		(Infix(preonestep level hlevel hyps x,ResOp s,
		preonestep level hlevel hyps y)) |

	preonestep level hlevel hyps (Infix(x,i,y)) =

		if rulefree2 level x andalso rulefree2 level y
            andalso isupterm x then

            (Infix(upthm x,ResOp"=>",(Infix(upterm x,i,y))))

            else if rulefree2 level x andalso rulefree2 level y
            andalso isupterm y then

            (Infix(upthm y,ResOp"=>",(Infix(x,i,upterm y))))

            else if  

            hasprogram (opdisplay i) andalso rulefree2 level x
		andalso rulefree2 level y andalso match level level
		(Leftside(programof(opdisplay i))) (Infix(x,i,y)) <> nil

		then thmresult level hlevel hyps 
		(Constant(programof(opdisplay i))) "=>" (Infix(x,i,y))

		else

		(Infix(preonestep level hlevel hyps x,i,
		preonestep level hlevel hyps y)) |

	preonestep level hlevel hyps (Function t) =

            let val T = preonestep (level+1) hlevel hyps t in

            if isupterm T andalso changelevel (level+1) level T <> Constant ""
            then preonestep level hlevel hyps
            (Infix(upthm T,ResOp"=>",Function(upterm T)))
		else Function (upterm T) end |

	preonestep level hlevel hyps (CaseExp(u,v,w)) =

		if not(rulefree2 level u)

		then 
		CaseExp( preonestep level hlevel hyps u ,v,w) 

		else  

		if u = Constant "true" then v

		else if u = Constant "false" then w

		else if u<>oddchoice u then CaseExp(oddchoice u,v,w)

		else 

             if isupterm u andalso rulefree2 level v
             andalso rulefree2 level w

             then preonestep level hlevel hyps 
             (Infix(upthm u,ResOp"=>",
             CaseExp(upterm u,v,w)))

            else if isupterm v andalso rulefree2 level v
            andalso rulefree2 level w

             then preonestep level hlevel hyps
             (Infix(upthm v,ResOp"=>",CaseExp(u,upterm v,w)))

            else if isupterm w andalso rulefree2 level v
            andalso rulefree2 level w

            then preonestep level hlevel hyps
            (Infix(upthm w,ResOp"=>",CaseExp(u,v,upterm w)))

		else CaseExp(u,preonestep level (hlevel+1)
 		(rev ((coercehypslistsense 1 level
		(equationfromterm u))::(rev hyps)))
		 v,
			preonestep level (hlevel+1)  
		(rev ((coercehypslistsense 2 level
		(equationfromterm u))::(rev hyps)))
		 w) |

	preonestep level hlevel hyps t = t;


(* this command carries out one trace step *)

(* onestep has been removed as a user command; stratification checking
has been moved to presteps.  The idea is to preserve parallelism
with execute, which can pass through temporary failures of global
stratification *)

(* but this is no longer true with the introduction of @! *)

val CHECKDISPLAY = ref "";

val CHECKDISPLAY2 = ref "";

fun precheckdisplay t = (CHECKDISPLAY := display t;t);

fun checkdisplay() = exec precheckdisplay;

fun onestep() = (

	checkdisplay(); CHECKDISPLAY2:=(!CHECKDISPLAY);

	exec (preonestep (level(!ENV)) (hlevel(!ENV)) 
	(hypslist(!ENV)));

	(* if Isstratified (rightside(!ENV)) then postdeps()
	else (dropdeps();
	errormessage "Introduces stratification error";ENV:=(!OLDENV)); *)

	checkdisplay(); if 
	((not(!NORULES)) orelse (!CHECKDISPLAY)<>(!CHECKDISPLAY2))

	then lookhere() else ());

fun presteps() = (

	checkdisplay(); CHECKDISPLAY2:=(!CHECKDISPLAY);

	exec (preonestep (level(!ENV)) (hlevel(!ENV)) 
	(hypslist(!ENV)));

	checkdisplay(); if 
	((not(!NORULES)) orelse (!CHECKDISPLAY)<>(!CHECKDISPLAY2))

	then (lookhere();if rulefree2 0 (rightside(!ENV)) then (()) else 
        suspend(presteps))

  	else (if rulefree2 0 (rightside(!ENV)) 
             then (()) else presteps()) );


(* USER COMMAND *)

(* this is the user command for many trace steps *)

fun steps() = ((
        STOPINPUT:=false;
	OLDENV := (!ENV); 
		look(); presteps();
		postdeps();CloseAll();look())
		handle BadSub =>
	(CloseAll();
        errormessage "Command aborted due to context term abuse"))
        handle OutOfTime => (CloseAll(); errormessage "Ran out of time");

fun stepsnorules() = (NORULES:=true;steps();NORULES:=false);

fun predroprule (Infix(x,ResOp"=>",y)) = y |
	predroprule (Infix(x,ResOp"<=",y)) = y |
	predroprule t = (errormessage "No rule to drop!";t);

(* USER COMMAND *)

(* user command to eliminate an embedded theorem *)

fun droprule() = (exec(predroprule);look());

(* commands to introduce embedded theorems *)

fun preruleintro level tm s t = 

	let val NA = eithervarhead tm in

	if NA = "" 
	then 
	((errormessage ((baredisplay tm)^" cannot be an embedded theorem"));t)

	else if (stringtocon NA = FreeVar NA orelse stringtoop NA = VarOp NA
		orelse isatheorem NA
		orelse isapretheorem NA
		orelse isbuiltinthm NA) andalso declarecheck true level tm

	then Infix(tm,ResOp s,t)

	else (errormessage 
	("Declaration error in proposed embedded theorem "^(baredisplay tm));t)

	end;

(* USER COMMANDS (2) *)

(* introduce tm =>... *)

fun ruleintro tm = (exec(preruleintro (level(!ENV)) (parse tm) "=>");look());

(* introduce tm <=... *)

fun revruleintro tm = 
	(exec(preruleintro (level(!ENV)) (parse tm) "<=");look());

fun altruleinfix s = s = "=>>" orelse s = "<<=";

(* function to fix tortured syntax of lists of alternative rules
(change from leftward grouping to rightward grouping); alternative is
to introduce alternatives in reverse order! *)

fun rectifyalts (Infix(Infix(x,i,y),j,z)) =

	if altruleinfix (opdisplay i) andalso altruleinfix (opdisplay j)

	then Infix(x,i,rectifyalts(Infix(y,j,z)))

	else (Infix(Infix(x,i,y),j,z)) |

	rectifyalts t = t;

fun prealtruleintro level tm s (Infix(x,ResOp i,t)) = 

	if not(ruleinfix i) then 
	(errormessage "No rule to which to add an alternative";
		(Infix(x,ResOp i,t)))

	else let val NA = eithervarhead tm in

	if NA = "" 
	then 
	((errormessage ((baredisplay tm)^" cannot be an embedded theorem"));
		(Infix(x,ResOp i,t)))

	else if (stringtocon NA = FreeVar NA orelse stringtoop NA = VarOp NA
		orelse isatheorem NA
		orelse isapretheorem NA
		orelse isbuiltinthm NA) andalso declarecheck true level tm

	then Infix((rectifyalts(Infix(x,ResOp s,tm))),ResOp i,t)

	else (errormessage 
	("Declaration error in proposed embedded theorem "^(baredisplay tm));
		(Infix(x,ResOp i,t)))

	end |

	prealtruleintro level tm s t = 
	(errormessage "No rule to which to add an alternative";t);

(* USER COMMANDS (2) *)

(* introduce a direct alternative embedded theorem *)

fun altruleintro tm = (exec (prealtruleintro (level(!ENV)) (parse tm) "=>>");
			look());

(* introduce a converse alternative embedded theorem *)

fun altrevruleintro tm = (exec 
		(prealtruleintro (level(!ENV)) (parse tm) "<<=");look());

(* introduce a theorem which will get you to a target term *)

fun pretargetruleintro level t u = 
	let val T = (* cmatch weak *) prematchtheorem level u t (!THEOREMS)

	in 

	if T = Constant "" then let val T2 =

		(* cmatch weak *) prematchtheorem level t u (!THEOREMS) in

		if T2 = Constant "" then u

		else preruleintro level T2 "<=" u end

	else preruleintro level T "=>" u end;

(* USER COMMAND *)

(* introduce a theorem which will get you to a target term *)

fun targetruleintro t = (exec (pretargetruleintro (level(!ENV)) (parse t));
			look());

fun prematchtri level L1 L2 t u = 
	let val T = (* cmatch weak *) prematchtheorem2 false level u t L2

	in 

	if T = Constant "" then let val T2 =

		(* cmatch weak *) prematchtheorem2 true level u t L1 in

		if T2 = Constant "" then u

		else preruleintro level T2 "=>" u end

	else preruleintro level T "<=" u end;

(* USER COMMAND *)

(* introduce a theorem which will get you to something matching a target term*)

val ANOTHERMATCHTERM = ref (Constant "");

fun matchtri t = (RESTOFLIST:=(!THEOREMS);RESTOFLIST2:=(!THEOREMS);
		exec (prematchtri (level(!ENV)) (!THEOREMS)(!THEOREMS) 
			(parse t));
			ANOTHERMATCHTERM:=parse t;
			look());

(* USER COMMAND *)

(* tries matchtri again on the tail of the list *)

fun anothermatchtri() = (droprule();
			exec (prematchtri (level(!ENV)) (!RESTOFLIST)
			(!RESTOFLIST2)
			(!ANOTHERMATCHTERM)); look());

(* utility for iteration of search *)

(* lists of all nontrivial results that can be obtained from a term
using existing theorems *)

fun resultlist1 level hlevel hyps x = 
separate (fn (z,y) => rulefree2 level y andalso y <> x) 
(map (fn (thm,a) => (thm,
thmresult level hlevel hyps (Formatof thm) "=>" x)) (!THEOREMS));

fun resultlist2 level hlevel hyps x = 
separate (fn (z,y) => rulefree2 level y andalso y <> x) 
(map (fn (thm,a) => (thm,
thmresult level hlevel hyps (Formatof thm) "<=" x)) (!THEOREMS));

fun safehead nil = ("", Constant "") |

	safehead L = hd L;

(* cmatch all occurrences of prematchtheorem are weak *)

fun thmpair1 L level hlevel hyps x w = safehead 
(separate2 (fn (y,z) => z <> Constant "")
(map (fn (y,z) => (y,prematchtheorem level z w (!THEOREMS))) L));

(* fun thmpair2 level hlevel hyps x w = safehead 
(separate (fn (y,z) => z <> Constant "")
(map (fn (y,z) => (y,prematchtheorem level z w (!THEOREMS)))
(resultlist2 level hlevel hyps x))); *)

fun thmpair3 L level hlevel hyps x w = safehead 
(separate2 (fn (y,z) => z <> Constant "")
(map (fn (y,z) => (y,prematchtheorem level w z (!THEOREMS))) L));

(* fun thmpair4 level hlevel hyps x w = safehead 
(separate (fn (y,z) => z <> Constant "")
(map (fn (y,z) => (y,prematchtheorem level w z (!THEOREMS)))
(resultlist2 level hlevel hyps x))); *)

fun pretri2 level hlevel hyps y x = 

	let val L1 = resultlist1 level hlevel hyps x in

	let val (A,B) = thmpair1 L1 level hlevel hyps x y in

	if A <> "" andalso B <> Constant "" 

	then Infix(B,ResOp "=>",Infix(Formatof A,ResOp "=>",x)) 

	else let val (A,B) = thmpair3 L1 level hlevel hyps x y in

	if A <> "" andalso B <> Constant "" 

	then Infix(B,ResOp "<=",Infix(Formatof A,ResOp "=>",x)) 

	else let val L2 = resultlist2 level hlevel hyps x in

	let val (A,B) = thmpair1 L2 level hlevel hyps x y in

	if A <> "" andalso B <> Constant "" 

	then Infix(B,ResOp "=>",Infix(Formatof A,ResOp "<=",x)) 

	else let val (A,B) = thmpair3 L2 level hlevel hyps x y in

	if A <> "" andalso B <> Constant "" 

	then Infix(B,ResOp "<=",Infix(Formatof A,ResOp "<=",x)) 

	else x
	end

	end
	end

	end
	end

	end; 

(* USER COMMAND *)

(* look for a two step proof *)

fun tri2 t = (exec (pretri2 (level(!ENV)) (hlevel(!ENV)) (hypslist(!ENV))
		(parse t));look());

(* development of theorem search using a metric *)

fun premetricresultlist1 metric target level hlevel hyps X nil 
	= nil |
premetricresultlist1 metric target level hlevel hyps X ((thm,a)::x)
= let val T = thmresult level hlevel hyps (Formatof thm) "=>" X in
if rulefree2 level T andalso (T <> X) 
andalso (((metric T target):real) <= metric X target)
then ((thm,T)::premetricresultlist1 metric target level hlevel hyps X x) 
else premetricresultlist1 metric target level hlevel hyps X x end;

fun metricresultlist1 metric target level hlevel hyps X = 
premetricresultlist1 metric target level hlevel hyps X (!THEOREMS);

fun premetricresultlist2 metric target level hlevel hyps X nil 
	= nil |
premetricresultlist2 metric target level hlevel hyps X ((thm,a)::x)
= let val T = thmresult level hlevel hyps (Formatof thm) "=>" X in
if rulefree2 level T andalso (T <> X) 
andalso (((metric T target):real) <= metric X target)
then ((thm,T)::premetricresultlist2 metric target level hlevel hyps X x) 
else premetricresultlist2 metric target level hlevel hyps X x end;

fun metricresultlist2 metric target level hlevel hyps X =
premetricresultlist2 metric target level hlevel hyps X (!THEOREMS);


(* the operation we want should take a list of terms and return the list
of terms closer to the target obtained by applying theorems to terms on
the original list *)

(* the function also needs to keep a list of theorems applied on hand! *)

(* this takes a pair of a theorem,sense list and a term and generates
a list of terms and theorem,sense pairs to which one can go *)

fun closerliststep metric target level hlevel hyps (L,t) =
	union
	(map (fn (thm,term) => ((L@[(thm,"=>")]),term))
	(metricresultlist1 metric target level hlevel hyps t))(
	map (fn (thm,term) => ((L@[(thm,"<=")]),term))
	(metricresultlist2 metric target level hlevel hyps t));

(* this applies closerliststep to look for further approaches, but
stops if the desired term has actually been reached *)

fun closerlist n metric target level hlevel hyps L =

	if n <=0 then map (fn x => (nil,x)) L else

	let val testlist = separate (fn (list,term) => term = target)
	(closerlist (n-1) metric target level hlevel hyps L)

	in

	if testlist <> nil then testlist

	else let val M = union2 
	(map (closerliststep metric target level hlevel hyps)
	(closerlist (n-1) metric target level hlevel hyps L)) in

	let val testlist2 = separate (fn (list,term) => term = target) M

	in

	if testlist2 = nil then M else testlist2

	end

	end

	end;

fun safehead2 nil = (nil,Constant "") |

	safehead2 L = hd L;

fun resultterm (nil,t) = t |

	resultterm (((thm,s)::list),t) = resultterm 
		(list,Infix(Formatof thm,ResOp s,t));

fun pretrimetric n metric target level hlevel hyps x =

	let val (list,term) = safehead2 
	(closerlist n metric target level hlevel hyps [x]) in

	if term = target then resultterm (list,x)

	else x

	end;

(* what remains is to develop mymetric *)

fun topsymbol (Constant s) = s |

	topsymbol (FreeVar s) = s |

	topsymbol (BoundVar s) = (baredisplay (BoundVar s)) |

	topsymbol (Numeral s) = (baredisplay (Numeral s)) |

	topsymbol (Function s) = "[]" |

	topsymbol (Parenthesis s) = "{}" |

	topsymbol (CaseExp (u,v,w)) = "||" |

	topsymbol (Infix(x,s,y)) = (opdisplay s);

fun leftsubterm (Constant s) = Constant ""  |

	leftsubterm (FreeVar s) = Constant "" |

	leftsubterm (Numeral s) = Constant "" |

	leftsubterm (BoundVar s) = Constant "" |

	leftsubterm (Function s) = s |

	leftsubterm (Parenthesis s) = s |

	leftsubterm (CaseExp (u,v,w)) = u |

	leftsubterm (Infix(x,s,y)) = x;

fun rightsubterm (Constant s) = Constant ""  |

	rightsubterm (FreeVar s) = Constant "" |

	rightsubterm (Numeral s) = Constant "" |

	rightsubterm (BoundVar s) = Constant "" |

	rightsubterm (Function s) = s |

	rightsubterm (Parenthesis s) = s |

	rightsubterm (CaseExp (u,v,w)) = Infix(v,ResOp",",w) |

	rightsubterm (Infix(x,s,y)) = y;

fun mymetric (Constant "") (Constant "") = 0.0 |

	mymetric (Constant "") x = 1.0 |

	mymetric x (Constant "") = 1.0 |

	mymetric x y = if x = y then 0.0 else

	(if topsymbol x = topsymbol y then 0.25 else 0.5) +

	(0.125*((mymetric x (leftsubterm y)) + (mymetric x (rightsubterm y))
	+ (mymetric y (leftsubterm x)) + (mymetric y (rightsubterm x))
	));

(* USER COMMAND *)

(* a dumb routine for multistep proof search *)

fun trimetric n target = (exec (pretrimetric n mymetric (parse target) 
	(level(!ENV)) (hlevel(!ENV)) (hypslist(!ENV)));look());

(* resume developmment of scripting *)

fun makescript scriptname = if (!SCRIPTING) then () else

(SCRIPTING:=true;
AUTOSCRIPT:="";noml();autoscript scriptname;SCRIPTING:=false);


(* Theory handling *)

(* Theory components:

CONSTANTS OPERATORS OPAQUE SCOUT SCINLEFT SCINRIGHT PREFIX VARTYPES
THEOREMS PRETHEOREMS DEFINITIONS DEFINITIONS2 (ENVS on desktop only)
DEFDEPS THMTEXTDEPS SCRIPTS
*)

val SCRIPTS = ref ["bogus"];  (* list of scripts that have been run *)
(* this appears early so that it can be a theory
component *)

(* registry of theory dependencies *)

val REGISTRY = ref [("bogus",["bogus"])];

(* SCRIPTS:=nil; *)

val THEORIES = ref [("scratch",(!CONSTANTS,! OPERATORS,! OPAQUE,! SCOUT,
! SCINLEFT,! SCINRIGHT,! PREFIX,! VARTYPES
,!THEOREMS,!MODULES,!MODULES_INVERSE,
! PRETHEOREMS,! DEFINITIONS,! DEFINITIONS2,
!DEFDEPS,!DEFDEPS2,!THMTEXTDEPS,!THMTEXTDEPS2,! ENVS,!ENV,!SCRIPTS,
!TRACE,!TRACELEVELS,!PRECEDENCES,!DEFAULTPREC,!PROGRAMS))];


fun wholetheory s  =

let val (co,ope,opa,sco,scil,scir,pre,var,the,modu,modinv,
preth,def1,def2,defd,defd2,
thd,thd2,envs,
env,scr,trac,traclev,precs,defprec,progs) =

hd (find s (!THEORIES)) in

if scr = nil orelse (tl scr = nil) then 
(co,ope,opa,sco,scil,scir,pre,var,the,modu,modinv,preth,def1,def2,defd,defd2,
thd,thd2,envs,
env,scr,trac,traclev,precs,defprec,progs (* cmatch ,comm *))

else

let val 
(co_2,ope_2,opa_2,sco_2,scil_2,scir_2,
pre_2,var_2,the_2,modu_2,modinv_2,preth_2,def1_2,def2_2,defd_2,defd2_2,
thd_2,thd2_2,envs_2,
env_2,scr_2,trac_2,traclev_2,precs_2,defprec_2,progs_2) =

wholetheory (hd (tl scr)) in

(union co co_2,strongunion ope_2 ope,union opa opa_2,
strongunion sco_2 sco,strongunion scil_2 scil, strongunion scir_2 scir,
strongunion pre_2 pre, strongunion var_2 var, strongunion the_2 the,
strongunion modu_2 modu, strongunion modinv_2 modinv,
preth, strongunion def1_2 def1, 
strongunion def2_2 def2, strongunion defd_2 defd,
strongunion defd2_2 defd2, strongunion thd_2 thd, strongunion thd2_2 thd2,
envs, env, scr, trac, traclev,
precs, defprec, progs)

end

end;

(* reference to name of current theory *)

val NAME = ref "";

(* reference to name of just previous theory *)

val LASTNAME = ref "";

(* we define the function which generates the "new" part of the
current theory *)

(* newsegment will be edited in the development of theory modularity.
There will be an export list which will be used, if non-nil, to edit
the output of newsegment() *)

(* the export list 

This is a list of identifiers to be used to edit newsegment
(when it is non-nil)

*)

(* lists all constants, operators, and operator variables (other than reserved
operators; used for declaration checking by interfacetheorem and exportthmlist) *)

fun conlist3 (Constant "") = nil |

	conlist3 (Constant s) = [s] |

	conlist3 (Infix(x,ConOp s,y)) = addtoset s 
			(union (conlist3 x) (conlist3 y)) |
	conlist3 (Infix(x,VarOp s,y)) = addtoset s 
			(union (conlist3 x) (conlist3 y)) |
	conlist3 (Infix(x,ResOp s,y)) = 
			(union (conlist3 x) (conlist3 y)) |
	conlist3 (Function s) = conlist3 s |
	conlist3 (CaseExp(u,v,w)) = union (conlist3 u) (union (conlist3 v)
							(conlist3 w)) |
	conlist3 t = nil;

(* the same for theorems *)

fun thmconlist thm = union(conlist3 (Formatof thm)) 
	(union (conlist3 (Leftside thm)) (conlist3 (Rightside thm)));


val THEORY_INTERFACE = ref["bogus"];

val _ = THEORY_INTERFACE:= nil;

(* USER COMMAND *)

(* this command is intended to be used in scripts to control
what theorems are actually included in the theory as it is saved;
it supports the ability to have local declarations inside theories
which are not seen outside, on the script level.  A script
which contains any interfacetheorem commands will need to have such
commands for all theorems to be exported -- a script which does
not contain any such commands will be exported in its entirety. *)

fun interfacetheorem s = THEORY_INTERFACE := union (!THEORY_INTERFACE)
(union2 (map thmconlist (union(Deps s)(union(defdeps s)(thmtextdeps s)))));

fun addthmstointerface L nil = () |

    addthmstointerface L (thm::M) = if foundinset thm L

       then addthmstointerface L M

       else (THEORY_INTERFACE:= union(!THEORY_INTERFACE)(thmconlist thm);

       addthmstointerface (thm::L) 
       (union M (union (Deps thm) (union (defdeps thm) (thmtextdeps thm)))));

fun interfacetheorem thm = addthmstointerface nil [thm];       

fun draftinterface() = THEORY_INTERFACE:=nil;

(* used to take out new constants which aren't to be exported
as "users" of inverse dependency lists *)

fun weirdintersection A B L = 
   setminus L (setminus A B);

fun weird2 A B L = map (fn (x,y) => (x,weirdintersection A B y)) L;

fun segmentedit L (co,ope,opa,sco,scil,scir,pre,var,the,modu,modinv,
preth,def1,def2,defd,defd2,
thd,thd2,envs,
env,scr,trac,traclev,precs,defprec,progs) =

if L = nil then (co,ope,opa,sco,scil,scir,pre,var,the,modu,modinv,
preth,def1,def2,defd,defd2,
thd,thd2,envs,
env,scr,trac,traclev,precs,defprec,progs)

else (intersection L co,restriction L ope,intersection L opa,
restriction L sco, restriction L scil, restriction L scir,
restriction L pre,restriction L var,restriction L the,
restriction L modu, 
map (fn (x,y)=>(y,x)) (restriction L (map (fn (x,y)=>(y,x)) modinv)),
intersection L preth,
restriction L def1,
restriction L def2,
restriction L defd,
weird2 co L (restriction L defd2),
restriction L thd, 
weird2 co L (restriction L thd2),envs,
env,scr,trac,restriction L traclev,precs,defprec,progs);

fun newsegment() =

(CloseAll();
let val (co,ope,opa,sco,scil,scir,pre,var,the,modu,modinv,
preth,def1,def2,defd,defd2,
thd,thd2,envs,
env,scr,trac,traclev,precs,defprec,progs (* cmatch ,comm *)) =

(!CONSTANTS,! OPERATORS,! OPAQUE,! SCOUT,
! SCINLEFT,! SCINRIGHT,! PREFIX,! VARTYPES
,!THEOREMS,!MODULES,!MODULES_INVERSE,
! PRETHEOREMS,! DEFINITIONS,! DEFINITIONS2,
!DEFDEPS,!DEFDEPS2,!THMTEXTDEPS,!THMTEXTDEPS2,! ENVS,!ENV,
!SCRIPTS,
!TRACE,!TRACELEVELS,!PRECEDENCES,!DEFAULTPREC,!PROGRAMS) in

if  (!LASTNAME) = ""

then segmentedit (!THEORY_INTERFACE) 
(co,ope,opa,sco,scil,scir,pre,var,the,modu,modinv,
preth,def1,def2,defd,defd2,
thd,thd2,envs,
env,scr,trac,traclev,precs,defprec,progs (* cmatch ,comm *))

else

let val (co_2,ope_2,opa_2,sco_2,scil_2,scir_2,pre_2,var_2,the_2,
modu_2,modinv_2,
preth_2,def1_2,def2_2,defd_2,defd2_2,
thd_2,thd2_2,envs_2,
env_2,scr_2,trac_2,traclev_2,precs_2,defprec_2,progs_2 (* cmatch ,comm *)) =

wholetheory (!LASTNAME) in

segmentedit(!THEORY_INTERFACE)

(setminus co co_2,strongdiff ope ope_2,setminus opa opa_2,
strongdiff sco sco_2,strongdiff scil scil_2, strongdiff scir scir_2,
strongdiff pre pre_2, strongdiff var var_2, strongdiff the the_2,
strongdiff modu modu_2,strongdiff modinv modinv_2,
preth, strongdiff def1 def1_2, strongdiff def2 def2_2, strongdiff defd defd_2,
strongdiff defd2 defd2_2, strongdiff thd thd_2, strongdiff thd2 thd2_2,
envs, env, scr, trac, traclev,
precs, defprec, progs)

end

end);

(* segments: each structural element here gets a "NEW_" variant? or
just the theorem list? or maybe also the large -deps2 structures?
The cross-referencing in general presents a problem here. *)


(* USER COMMAND *)

fun theoryname() = if (!VERBOSITY)=2 then nopausemessage (!NAME) else ();

(* USER COMMAND *)

(* back up theory onto desktop *)

fun backuptheory() = if (!NAME) = "" 
     orelse (!LASTNAME) = (!NAME) then () else

     if  find (!NAME) (!REGISTRY) = nil orelse
     find (!NAME) (!REGISTRY) = [(!SCRIPTS)] 
     then (if (!THEORY_INTERFACE)<>nil then (ENVS:=nil;start "?x") else ();
           REGISTRY:=addto (!NAME) (!SCRIPTS) (!REGISTRY); 
           THEORIES:=strongadd (!NAME) (newsegment()) (!THEORIES))
     else errormessage 
	("Theory "^(!NAME)^" cannot be backed up due to change in precursors");


(* declarations of reserved constants and theorems *)

(* function for restoring declarations of built-in constants *)

fun preamble0() = map declareconstant ["true","false",
	"BIND","EVAL","UNEVAL","BINDM","EVALM","UNEVALM","UP",
	"FLIP","INPUT","OUTPUT","STOPINPUT","SCOUT","SCIN","SCINL","SCINR"];

(* function for declaring primitive logical axioms *)

fun preamble() = ( 

axiom "TYPES" "?t:?t:?x" "?t:?x";  (* type labels are retractions *)

defineinfix "COMP"  "(?f@@?g)@?x" "?f@?g@?x";

defineconstant  "P1@?x,?y"  "?x";

defineconstant "P2@?x,?y"  "?y";

defineconstant "p1@?x,?y" "?x";

defineconstant "p2@?x,?y" "?y";

setprogram "p1" "p1";

setprogram "p2" "p2";

defineconstant  "Id@?x"  "?x";

axiom "FNDIST" "?f@?x||?y,?z" "?x||(?f@?y),(?f@?z)";

axiom "CASEINTRO" "?x" "?y||?x,?x";  (* can be proven from FNDIST;
					FNDIST can also be proven from
					CASEINTRO using built- in logic 
					of || *)

axiom "REFLEX" "?a=?a" "true";

axiom "NONTRIV" "true=false" "false";

axiom "EQUATION"  "?a=?b" "(?a=?b)||true,false";

axiom "ODDCHOICE"  "?x" "?x";  (* original form of this axiom is now
				illegal; it is preserved for reverse
				compatibility *)

axiom "HYP" "(?a=?b)||(?f@?a),?c" "(?a=?b)||(?f@?b),?c";

backuptheory()

);

(* preamble(); *)


(* fast forget function *)

(* it should be noted that until I fix the updating of the inverse
lists, this will drop any theorem that ever depended on thm, even if
it no longer does!  It drops all saved environments and restarts 
the current one (because it is harder to do dependency checking on these) *)

(* a theorem is not likely to be scin, scout or opaque at the moment;
if this ceases to be a reasonable expectation, one would also
need to drop s from the scin/scout lists *)

(* au contraire, there are theorems which are scout in the current
omnibus theory, such as forall -- but they are axioms or definitions,
so still OK *)

(* there ought to be a fix for the cmatch version *)

fun fulldroptheorem s = (droptheorem s; DEFDEPS:=drop s (!DEFDEPS);
THMTEXTDEPS:=drop s (!THMTEXTDEPS);
DEFDEPS2:=map (fn (t,x) => (t,dropfromset s x)) (drop s (!DEFDEPS2));
THMTEXTDEPS2:=map (fn (t,x) => (t,dropfromset s x)) (drop s (!THMTEXTDEPS2)); 
CONSTANTS:=dropfromset s (!CONSTANTS);
OPERATORS:=drop s (!OPERATORS); PREFIX:=drop s (!PREFIX));

(* it will not drop axioms or definitions *)
(* it will not post names of theorems dropped if run inside a script *)

(* it does not automatically back up theory on desktop -- user needs
to do this.  Its internal use in theorem exportthm is compromised if it
does backups *)

(* corrected fulldroptheorem so that forget will handle inverse lists
as well *)

(* USER COMMAND *)

(* forget a theorem *)

fun forget thm = if isatheorem thm then

	if foundinset thm (Deps thm)

	then errormessage (thm^" is an axiom or definition")

	else let val L = thmtextdeps2 thm 
		and M = thmtextdeps thm in (
		map (fn (s,(fo,lt,rt,dps)) => 
		if foundinset s L
		then (if (!VERBOSITY)=2 then nopausemessage s else ();
		fulldroptheorem s) else 
		if hd (explode s) = "}" then droptheorem s
		else () ) (!THEOREMS);
		start "?x") end

	else if isbuiltinthm thm

	then errormessage (thm^" is a built-in tactic")

	else errormessage (thm^" is not a theorem");


(* USER COMMAND *)

(* retrieve a theory from the desktop *)

fun gettheory s = 

if find s (!THEORIES) = nil then
errormessage ("Theory "^s^" not found")
else (if s = (!NAME) then (backuptheory()) else (draftinterface();
let val (co,ope,opa,sco,scil,scir,pre,var,the,modu,modinv,
preth,def1,def2,defd,defd2,
thd,thd2,envs,
env,scr,trac,traclev,precs,defprec,progs (* cmatch ,comm *)) =

(hd(find s (!THEORIES))) in

if scr = nil orelse (tl scr) = nil then

 (backuptheory(); start "?x"; NAME:=s; LASTNAME := "";
 CONSTANTS:= co; OPERATORS:= ope; OPAQUE:=opa;SCOUT:=sco;SCINLEFT:=scil;
 SCINRIGHT:=scir;PREFIX:=pre;VARTYPES:=var;THEOREMS:=the;
 MODULES:=modu; MODULES_INVERSE:=modinv; PRETHEOREMS:=preth;
 DEFINITIONS:=def1;DEFINITIONS2:=def2;DEFDEPS:=defd;THMTEXTDEPS:=thd;
 DEFDEPS2:=defd2;THMTEXTDEPS2:=thd2;
 ENVS:=envs;ENV:=env;SCRIPTS:=scr;
 TRACE:=trac;TRACELEVELS:=traclev;
 PRECEDENCES:=precs;DEFAULTPREC:=defprec;PROGRAMS:=progs; 
	(* cmatch COMMUTATIVE:=comm; *)theoryname();envname();look())

else (gettheory (hd (tl scr));NAME:=s;LASTNAME:=(hd (tl scr));
(CONSTANTS:= union (!CONSTANTS) co; 
OPERATORS:= strongunion (!OPERATORS) ope; 
OPAQUE:=union (!OPAQUE) opa;SCOUT:=strongunion (!SCOUT) sco;SCINLEFT:=
strongunion (!SCINLEFT) scil; SCINRIGHT:=strongunion (!SCINRIGHT) scir;
PREFIX:=strongunion (!PREFIX) pre;VARTYPES:=strongunion (!VARTYPES) var;
THEOREMS:=strongunion (!THEOREMS) the;
MODULES:= strongunion (!MODULES) modu; 
MODULES_INVERSE:=strongunion (!MODULES_INVERSE) modinv;
PRETHEOREMS:=preth;
 DEFINITIONS:=strongunion (!DEFINITIONS) def1;
DEFINITIONS2:=strongunion (!DEFINITIONS2) def2;
DEFDEPS:=strongunion (!DEFDEPS) defd;
THMTEXTDEPS:=strongunion (!THMTEXTDEPS) thd;
 DEFDEPS2:=strongunion (!DEFDEPS2) defd2;
THMTEXTDEPS2:=strongunion (!THMTEXTDEPS2) thd2;
 ENVS:=envs;ENV:=env;SCRIPTS:=scr;
 TRACE:=trac;TRACELEVELS:=traclev;
 PRECEDENCES:=precs;DEFAULTPREC:=defprec;PROGRAMS:=progs; 

 theoryname();envname();look())) end));

(* development of the load/save facility *)

(* this function strips all the "old" stuff out of the current
theory preparatory to the theory save operation *)

fun loadnewsegment() = (backuptheory(); let val 
(co,ope,opa,sco,scil,scir,pre,var,the,modu,modinv,preth,def1,def2,defd,defd2,
thd,thd2,envs,
env,scr,trac,traclev,precs,defprec,progs (* cmatch ,comm *)) = newsegment()

in (CONSTANTS:= co; 
OPERATORS:= ope; 
OPAQUE:=opa;SCOUT:=sco;SCINLEFT:=scil; SCINRIGHT:=scir;
PREFIX:=pre;VARTYPES:=var;
THEOREMS:=the;MODULES:=modu;MODULES_INVERSE:=modinv;PRETHEOREMS:=preth;
 DEFINITIONS:=def1;
DEFINITIONS2:=def2;
DEFDEPS:=defd;
THMTEXTDEPS:=thd;
 DEFDEPS2:=defd2;
THMTEXTDEPS2:=thd2;
 ENVS:=envs;ENV:=env;SCRIPTS:=scr;
 TRACE:=trac;TRACELEVELS:=traclev;
 PRECEDENCES:=precs;DEFAULTPREC:=defprec;PROGRAMS:=progs) end);


fun saveset readername nil = "" |

	saveset readername (s::L) = (readername)^
					" \""^s^"\";\n"^(saveset readername L);

fun revsaveset readername nil = "" |

	revsaveset readername (s::L) = (revsaveset readername L)^(readername)^
					" \""^s^"\";\n";

fun savefun readername displayfun nil = "" |

	savefun readername displayfun ((s,x)::L) =
	(readername)^" \""^s^"\" \""^(displayfun x)^"\";\n"
	^(savefun readername displayfun L);

fun saveconstants() = saveset "declareconstant" (!CONSTANTS);

fun prefixreader s t = if t = "" then declarestrictprefix s else
	declareprefix s t;

fun saveprefixes() = savefun "prefixreader" (fn x=> x) (!PREFIX);


fun saveprograms() = savefun "setprogram" (fn x => x) (!PROGRAMS);

fun saveprecedences() = savefun "precedencereader" makestring (!PRECEDENCES);

fun precedencereader s n = setprecedence s (evalnum (rev (explode n)));

fun savetracelevels() = savefun "tracelevelreader" makestring (!TRACELEVELS);

fun tracelevelreader s n = settracelevel s (evalnum (rev (explode n)));

fun savedefaultprec() = "setdefaultprec "^(makestring(!DEFAULTPREC))^";\n";

fun saveopaque() = saveset "addopaque" (!OPAQUE);

fun addopaque s = OPAQUE:=addtoset s (!OPAQUE);

fun savescinleft() = savefun "addscinleft" (fn x => x) (!SCINLEFT);

fun addscinleft s t = SCINLEFT:=addto s t (!SCINLEFT);

fun savescinright() = savefun "addscinright" (fn x => x) (!SCINRIGHT);

fun addscinright s t = SCINRIGHT:=addto s t (!SCINRIGHT);

fun savescout() = savefun "addscout" (fn x => x) (!SCOUT);

fun addscout s t = SCOUT:=addto s t (!SCOUT);

fun numpair1 (Infix(Numeral m,ResOp",",Numeral n)) =

	(listtoint m,listtoint n) |

	numpair1 (Infix(Infix(x,ConOp"~",Numeral m),ResOp",",Numeral n)) =

	(0-(listtoint m),listtoint n) |

	numpair1 (Infix(Numeral n,ResOp",",Infix(x,ConOp"~",Numeral m))) =
	(listtoint n,0-(listtoint m)) |

	numpair1 (Infix(Infix(x,ConOp"~",Numeral m),ResOp",",
	Infix(y,ConOp"~",Numeral n))) = (0-(listtoint m),0-(listtoint n)) |

	numpair1 t = (0,0);

fun numpair2 (m:int,n:int) = ("("^(makestring m)^") , "^(makestring n));

fun saveoperators() = savefun "addoperator" numpair2 (!OPERATORS);

fun addoperator s t = declaretypedinfix (p1 (numpair1 (parse t)))
		(p2(numpair1 (parse t))) s;

fun readthm1 (Infix(x,ResOp",",Infix(y,ResOp",",Infix(z,ResOp",",w))))
	 = (x,y,z,termtolist w);

fun readthm2 (x,y,z,w) = 
	baredisplay((Infix(x,ResOp",",Infix(y,ResOp",",
		Infix(z,ResOp",",listtoterm w)))));

(* the reversal is to preserve the order of the theorem list *)

fun savetheorems() = savefun "forcetheorem" readthm2 (rev(!THEOREMS));

fun forcetheorem s t = let val (fo,lt,rt,dp) = readthm1(parse t) in

	addtheorem s fo lt rt dp end;

(* develop module save function *)

(* the display for a module is a list of commands of the form
"forcetheorem" followed by "push" *)

fun forcemoduletheorem m s t = 
(forcetheorem s t;addwhichmodule s m;push s m;StrongOpen m);

fun moduledisplayfun m = ("modulestamp \""^m^"\";\n")^
(savefun ("forcemoduletheorem \""^m^"\" ") readthm2 (moduleof m));

fun modulestamp m = MODULES:=strongadd m nil (!MODULES);

fun moduleinvstamp s = MODULES_INVERSE:=strongadd s "" (!MODULES_INVERSE);

fun listfold f nil = "" |

listfold f ((a,x)::L) = (f a)^(listfold f L);

fun savemodules() = listfold moduledisplayfun (!MODULES);

fun savemoduleinvs() = saveset "moduleinvstamp"
(separate (fn x => whichmodule x = "") 
(map (fn (x,y) => x) (!MODULES_INVERSE)));

fun savepretheorems() = saveset "addpretheorem" (!PRETHEOREMS);

fun addpretheorem s = PRETHEOREMS:= addtoset s (!PRETHEOREMS);

fun savevartypes() = savefun "addvartype" baredisplay (!VARTYPES);

fun addvartype s t = VARTYPES := addto s (parse t) (!VARTYPES);

(* DEFINITIONS2 does not need to be saved; it can be constructed from
DEFINITIONS *)

fun savedefinitions() = savefun "adddef" (fn x => x) (!DEFINITIONS);

fun savedefdeps() = savefun "adddefdep2" listtoterm2 (!DEFDEPS); 

fun adddefdep2 s t = adddefdep s (termtolist2 t);

fun savethmtextdeps() = savefun "addthmtextdep2" listtoterm2 (!THMTEXTDEPS); 

fun addthmtextdep2 s t = addthmtextdep s (termtolist2 t);

fun savescripts() = if (!SCRIPTS)=nil orelse (tl(!SCRIPTS)) = nil
		then "" else "addscript "^"\""^(hd(tl(!SCRIPTS)))^"\";\n";

val OLDTHEORYNAME = ref "bogus";

fun savefile() = (savescripts())^(saveconstants())
	^(saveoperators())^(savescout())
	^(savescinleft())^(savescinright())
	^(saveprecedences())^(savedefaultprec())^(saveprefixes())
	^(savevartypes())^(saveopaque())
	^(savetheorems())^(savemodules())^(savemoduleinvs())^
        (savepretheorems())
        ^(savedefinitions())
	(* ^(savesimplifier()) *) ^(savetracelevels())
	^(saveprograms())^(savedefdeps())^(savethmtextdeps())^"quit();\n";

val THEORY = ref(open_out("dummy"));

val SAVE_EXT = ref ".wat";

(* USER COMMAND *)

fun setsaveext s = SAVE_EXT := s;

(* USER COMMANDS (2) *)

(* save theory files *)


fun storeall name = if find name (!REGISTRY) = nil
                    orelse find name (!REGISTRY) =
                    [if name = (!NAME) 
                    then (!SCRIPTS) 
                    else addtoset name (!SCRIPTS)] then

		(if (name <> (!NAME))
		then (LASTNAME:=(!NAME);
			NAME:=name;
			SCRIPTS:=addtoset name (!SCRIPTS)
			(* ;backuptheory() *) ) else ();
		start "?x"; loadnewsegment();
		THEORY:=open_out(name^".sav"^(!SAVE_EXT));
		output((!THEORY),savefile());
		close_out(!THEORY);
		NAME:="";gettheory name)

                else errormessage 
     "Theory cannot be stored with this name due to precursor errors";

fun clearfor s = (backuptheory();
draftinterface();
SAVEDREWRITES:=nil;
MODULES:=nil;MODULES_INVERSE:=nil;
OPENMODULES:=nil;
PROGRAMS:=nil;
PRECEDENCES:=nil; DEFAULTPREC := 0;
TRACE:=0; TRACELEVELS:= nil;
DEMO:=false; DIAGNOSTIC:= false; LASTNAME := "";
NAME:= s; start "?x"; CONSTANTS := nil;
OPERATORS := nil; 
OPAQUE := nil; SCOUT := nil; 
SCINLEFT := nil; SCINRIGHT := nil; PREFIX := nil; VARTYPES := nil;
THEOREMS := nil; PRETHEOREMS := nil; DEFINITIONS := nil; DEFINITIONS2 := nil;
DEFDEPS:=nil; THMTEXTDEPS:=nil; SCRIPTS:=nil; DEFDEPS2:=nil;
THMTEXTDEPS2:=nil; (* cmatch COMMUTATIVE := nil; *)
ENVS := nil; 
declarestrictprefix "!@"; declarestrictprefix "!$"; declarestrictprefix "#!";
SCINLEFT:=addto "=>" "" (!SCINLEFT);SCINLEFT:=addto "<=" "" (!SCINLEFT);
if s = "" then (preamble0(); preamble(); storeall "preamble") else ());

(* USER COMMAND *)

fun clear() = clearfor "";

(* USER COMMAND *)

(* total destruction *)

fun cleartheories () = (clear(); THEORIES:=nil; REGISTRY:=nil; backuptheory());

fun droptheory s = (clear(); THEORIES:=drop s (!THEORIES); 
                             REGISTRY := drop s (!REGISTRY);
                   map (fn (x,y) => if foundinset s y then (droptheory x)
                    else ()) (!REGISTRY);());


fun safesave() = storeall (!NAME);

(* USER COMMAND *)

(* load uses a different menu of commands from script; they check
to see whether the appropriate menu is present and swap if necessary *)

fun preload name = if name = "preamble" then () else
		(
		loadmenu();
                nopausemessage ("Now preloading "^name);
		executefile "" (name^".sav");
                nopausemessage ("Done preloading "^name);
		PRECEDENCES:=nil; PROGRAMS:=nil);

fun addscript name = 	(preload name;

                        if find name (!REGISTRY) = nil
                        orelse find name (!REGISTRY) = 
				[addtoset name (!SCRIPTS)]
			then
			(LASTNAME:=(!NAME); 
			NAME:=name; SCRIPTS:=addtoset name (!SCRIPTS);
                        backuptheory())

			else errormessage ("Precursor error at theory"^name)
			);

fun load name = (backuptheory(); clear(); 
		setcurrentmenu();loadmenu();
		executefile "" (name^".sav");currentmenu();LASTNAME:=(!NAME);
                if find name (!REGISTRY) = nil
                     orelse find name (!REGISTRY) = 
                     [addtoset name (!SCRIPTS)] then
		(NAME:=name; SCRIPTS:=addtoset name (!SCRIPTS); backuptheory())
   else errormessage ("Precursor error at theory "^name));

(* development of the script command *)

fun scriptinscript s = (if foundinset s (!SCRIPTS) then 
(setnopause();errormessage
("Script "^s^" already run");setpause()) 

else (
LASTNAME:=(!NAME);
executefile (if (!DEMO) then "Watson>  " else "") s;storeall s));


(* June 25 modification: coming out of the top level script will always
turn off demo and diagnostic modes *)

fun setlastname() = if (!SCRIPTS) = nil orelse (tl(!SCRIPTS)) = nil
then LASTNAME:="" else LASTNAME:= hd(tl(!SCRIPTS));

(* USER COMMAND *)

fun script s = (backuptheory();OLDSCRIPTING:=(!SCRIPTING);
SCRIPTING:=false;
(if (!DEMO) then () else thmsonly(); setpause(); mainmenu();
addtocurrentmenu "script" (fn () => scriptinscript (getchararg(!ARGUMENTS)));
scriptinscript s; setnopause(); speakup();DEMO:=false;DIAGNOSTIC:=false;
  TURNOFFPROMPT:=false;mainmenu();setlastname();
SCRIPTING:=(!OLDSCRIPTING))
handle Breakout => (setnopause(); speakup(); TESTTH:=[std_in];DEMO:=false;
DIAGNOSTIC:=false; TURNOFFPROMPT:=false;mainmenu();setlastname();
SCRIPTING:=(!OLDSCRIPTING);
errormessage ("User escape from script "^s)));


(* BEGIN theorem export under construction *)

(* theorem export system -- under construction *)

(* basic idea is that the user may define a "view" (a translation table
for constants and operators) of one theory in another.  This view can then be
used to translate theorems of the source theory into theorems of the target
theory.  The prover checks the validity of views.  *)

(* the master list of views:  this will need
to be declared earlier when this feature is fully installed *)

val VIEWS = ref [("bogus",[("bogus","bogus")])];

(* a view which sees all the predeclared constants as themselves *)

val basicview = ref [("bogus","bogus")];

fun setbasicview() = basicview := union (map (fn x=>(x,x)) (!CONSTANTS))
		(map (fn (x,y)=>(x,x)) (!OPERATORS));

(* functions for handling views *)

(* USER COMMAND *)

fun declareview s = if foundin s (!VIEWS)

		then errormessage ("View "^s^" already exists")

		else VIEWS:=addto s (!basicview) (!VIEWS);

(* USER COMMANDS (2) *)

(* restoreview and backupview are provided as user commands;
backupview is also invoked automatically by exportthmlist, and
restoreview may be used to restore a damaged view after a failed
export *)

fun restoreview s = if foundin ("~"^s) (!VIEWS)

		then VIEWS:=strongadd s (hd(find ("~"^s) (!VIEWS))) (!VIEWS)

		else errormessage ("No backup of view "^s^" to restore");

fun backupview s = if foundin s (!VIEWS)

		then VIEWS := strongadd ("~"^s) (hd(find s (!VIEWS))) (!VIEWS)

		else errormessage ("No view "^s^" found to back up");

fun isaview s = foundin s (!VIEWS);

fun theview s = safefind nil s (!VIEWS);

fun foundinview s t = foundin t (theview s);

fun viewof s t = safefind "" t (theview s);

fun viewof2 s t = let val A = find t (theview s) in

	if A = nil then if t <> ""

	then (errormessage ("Can't translate "^t^" using view "^s);"")

	else ""

	else hd A end;

(* USER COMMAND *)

fun addtoview s t u = if isaview s andalso not(foundinview s t)

	then VIEWS:=strongadd s (addto t u (theview s)) (!VIEWS)

	else errormessage (s^" is not a view or "^t^" is already found in it");

(* USER COMMAND *)

fun dropfromview s t = if isaview s andalso (foundinview s t)

	then VIEWS:=strongadd  s (drop t (theview s)) (!VIEWS)

	else errormessage (s^" is not a view or "^t^" is not found in it");

(* USER COMMAND *)

fun dropview s = if isaview s then VIEWS := drop s (!VIEWS)
	else ();

fun preshowview nil = (!Returns) |

	preshowview ((s,t)::L) = s^"\t"^t^"\n"^(preshowview L);

fun preshowview2 L = (if (!GUIMODE) then "Table display:"^(!Returns) else "")
                     ^(preshowview L)
                     ^(if (!GUIMODE) then ". . ."^(!Returns) else "");

(* USER COMMANDS (3) *)

(* all these have in command is a tabular form *)

fun showview s = if isaview s

	then output(std_out,preshowview2 (hd (find s (!VIEWS))))

	else nopausemessage ("There is no view "^s);

fun showprecedences() = (output(std_out,
"The default precedence is "^(makestring(!DEFAULTPREC))^(!Returns)^
	(preshowview2 (map (fn(x,y)=>(x,makestring y)) (!PRECEDENCES))));
	flush_Out(std_out));
	

fun showprograms() = (output(std_out,preshowview2 (!PROGRAMS));
	flush_Out(std_out));

(* make substitutions into a term using a view as a translation table *)

fun viewsub s (Constant t)  = Constant (viewof2 s t) |

	viewsub s (Function t) = Function (viewsub s t) |

	viewsub s (CaseExp(u,v,w)) = 
		CaseExp(viewsub s u,viewsub s v,viewsub s w) |

	viewsub s (Infix(x,ConOp t,y)) = (Infix(viewsub s x,
		ConOp (viewof2 s t),
		viewsub s y)) |

	(* Infix variables require view information because they may
		be typed *)

	viewsub s (Infix(x,VarOp t,y)) = (Infix(viewsub s x,
		VarOp (viewof2 s t),
		viewsub s y)) |

	viewsub s (Infix(x,ResOp t,y)) = Infix(viewsub s x,ResOp t,
		viewsub s y) |

	viewsub s t = t;

(*  strip variables out of a match produced by supermatch below *)

(* stripvars modified July 14 to recognize bogus free variables 
introduced in the "reversal" of infix variable matching *)

fun stripvars1 nil = nil |

	stripvars1 ((s,t)::L) = if t <> "" andalso hd(explode t) = "?" then
		stripvars1 L else ((s,t)::stripvars1 L);

(* it is to be expected that L will actually be nil in all cases *)

fun stripvars nil = nil |

	stripvars (a::L) = (stripvars1 a)::L;

(* builds matches between theories *)

(* design points:

free variables only match free variables; this is just to check identical
form of theorems.

reserved operators only match themselves

constants, operators, and operator variables match constants, operators,
operator variables with the following conditions:

	matches between theorem names require matches between the
associated theorems.  matches to defined concepts require matches of the
defining theorems (and defined concepts can only match defined concepts).
Matches of theorems have free variable matches stripped out (hence
the stripvars function above).
matches to scin/scout operators require matches of the corresponding theorems
as well.  operators only match other operators with the same relative
type and opacity information.
operator variables only match if their declaration status is
the same (treating undeclared as equivalent to opaque as usual).

	making these matches requires access to declaration lists
from other theories?

	Build small lists of relevant declarations from the material
to be matched, and label these declarations with an impossible prefix?

Alternatively, put the old declaration lists in special places in the
environment and swap them for the current declaration lists when necessary?

*)

val OLDTHEOREMS = ref (!THEOREMS);
val OLDOPERATORS = ref (!OPERATORS);
val OLDDEFINITIONS = ref (!DEFINITIONS);
val OLDDEFINITIONS2 = ref (!DEFINITIONS2);
val OLDOPAQUE = ref (!OPAQUE);
val OLDSCOUT = ref (!SCOUT);
val OLDSCINLEFT = ref (!SCINLEFT);
val OLDSCINRIGHT = ref (!SCINRIGHT);
val OLDPREFIX = ref (!PREFIX);

val TEMPTHEOREMS = ref (!THEOREMS);
val TEMPOPERATORS = ref (!OPERATORS);
val TEMPDEFINITIONS = ref (!DEFINITIONS);
val TEMPDEFINITIONS2 = ref (!DEFINITIONS2);
val TEMPOPAQUE = ref (!OPAQUE);
val TEMPSCOUT = ref (!SCOUT);
val TEMPSCINLEFT = ref (!SCINLEFT);
val TEMPSCINRIGHT = ref (!SCINRIGHT);
val TEMPPREFIX = ref (!PREFIX);

(* copy declaration lists of source theory before moving to target theory *)

(* problems with the module system are averted by opening all modules *)

fun getoldlists() = (
map (fn (x,y) => StrongOpen x) (!MODULES);
 OLDTHEOREMS := (!THEOREMS);
 OLDOPERATORS :=  (!OPERATORS);
 OLDDEFINITIONS := (!DEFINITIONS); 
 OLDDEFINITIONS2 := (!DEFINITIONS2);
 OLDOPAQUE := (!OPAQUE); 
 OLDSCOUT := (!SCOUT);
 OLDSCINLEFT :=(!SCINLEFT);
 OLDSCINRIGHT := (!SCINRIGHT);
 OLDPREFIX := (!PREFIX);
CloseAll()
);

(* interchange definition lists with the "old" ones *)

fun swapoldlists() = (TEMPTHEOREMS := (!THEOREMS);
 TEMPOPERATORS :=  (!OPERATORS);
 TEMPDEFINITIONS := (!DEFINITIONS); 
 TEMPDEFINITIONS2 := (!DEFINITIONS2);
 TEMPOPAQUE := (!OPAQUE); 
 TEMPSCOUT := (!SCOUT);
 TEMPSCINLEFT :=(!SCINLEFT);
 TEMPSCINRIGHT := (!SCINRIGHT);
 TEMPPREFIX := (!PREFIX);

 THEOREMS:=(!OLDTHEOREMS);
 OPERATORS:=(!OLDOPERATORS);
 DEFINITIONS:=(!OLDDEFINITIONS);
 DEFINITIONS2:=(!OLDDEFINITIONS2);
 OPAQUE:=(!OLDOPAQUE);
 SCOUT:=(!OLDSCOUT);
 SCINLEFT:=(!OLDSCINLEFT);
 SCINRIGHT:=(!OLDSCINRIGHT);
 PREFIX := (!OLDPREFIX);

OLDTHEOREMS := (!TEMPTHEOREMS);
 OLDOPERATORS :=  (!TEMPOPERATORS);
 OLDDEFINITIONS := (!TEMPDEFINITIONS); 
 OLDDEFINITIONS2 := (!TEMPDEFINITIONS2);
 OLDOPAQUE := (!TEMPOPAQUE); 
 OLDSCOUT := (!TEMPSCOUT);
 OLDSCINLEFT :=(!TEMPSCINLEFT);
 OLDSCINRIGHT := (!TEMPSCINRIGHT);
 OLDPREFIX := (!TEMPPREFIX));

(* a hack for using the old lists without writing new commands;
we'll see if it works! *)

fun oldlists f x = (swapoldlists(); 
	let val y = f x in (swapoldlists();y) end );

(* list argument L is needed to avert circular searches for theorems? 
it contains matches already established between theorems, not to be
checked again! *)

(* definition is repeated here to avoid problems for cmatch version *)

(* machine for merging matches *)

fun verboseisfun nil = true |

	verboseisfun ((s,x)::L) = let val A = find s L in 
			if A = nil orelse A = [x]
				then isfun L
				else 
	(errormessage((hd A)^" conflicts with "^x^" as match for "^s);
		false) end;

(* merge function used with match lists; it returns nil as an
error object, and packages resultant lists in a unit list *)

fun verbosemerge L M = if verboseisfun (union L M) then [union L M] else nil;


fun mergematches nil L = nil |

	mergematches M nil = nil |

	mergematches (a::L) (b::M) = verbosemerge a b;


(* supermatch could send helpful error messages *)

fun supermatch L (Constant "") (Constant s) = if s = "" then [nil] else 
		(errormessage ("Bad match "^s^" for null prefix");nil) |

	supermatch L (Constant s) (Constant t) = if foundin s L 
		then if (hd (find s L) = t) then [nil] else 
		(errormessage ("Bad match "^t^" for "^s);nil)

	else mergematches [[(s,t)]] (mergematches 

	(* match of any theorems s and t may name *)

	(if oldlists Isatheorem s

	then if not (Isatheorem t) then 
		(errormessage 
		("Bad match "^t^" for "^s^" (not a theorem)");nil) 

	else (if hasmodule t then StrongOpen t else ();
        let val (fo,lt,rt,dps) = oldlists Thm s and
	(fo2,lt2,rt2,dps2) = Thm t in 
	let val M =
	stripvars(mergematches ((supermatch ((s,t)::L) fo fo2))
	(mergematches ((supermatch ((s,t)::L) lt lt2))
		((supermatch ((s,t)::L) rt rt2))))

	in if M = nil 
	then (errormessage ("Match of theorems "^s^" and "^t^" failed");nil) 
	else M  end end)

	else [nil])

	(* match between any definitions *)

	(mergematches (if oldlists isdefined s 

	then if not (isdefined t) then 
		(errormessage 
		("Bad match "^t^" for "^s^" (not a defined notion)");nil)

	else
	stripvars (supermatch ((s,t)::L) (Constant(oldlists definitionof s))
		(Constant(definitionof t)))

	else [nil])

	(* match between any scout, scinleft, scinright witness theorems *)

	(mergematches (if oldlists isscout s 

	then if not (isscout t) then

		(errormessage 
		("Bad match "^t^" for "^s^" (not scout)");nil)


	else stripvars (supermatch ((s,t)::L) (Constant(oldlists scoutof s))
		(Constant(scoutof t)))

	else [nil])

	(mergematches (if oldlists isscinleft s 

	then if not (isscinleft t) then

		(errormessage 
		("Bad match "^t^" for "^s^" (not scinleft)");nil)

	else stripvars (supermatch ((s,t)::L) 
		(Constant(oldlists scinleftof s))
		(Constant(scinleftof t)))

	else [nil])

	(if oldlists isscinright s 

	then if not (isscinright t) then

		(errormessage 
		("Bad match "^t^" for "^s^" (not scinright)");nil)

	else stripvars (supermatch ((s,t)::L) 
		(Constant(oldlists scinrightof s))
		(Constant(scinrightof t)))

	else [nil]))))) |

(* reversal of order here is a subtle logical point --
one does not want stronger theorems in source theory to
match weaker theories in the target theory! *)

	supermatch L (FreeVar s) (FreeVar t) = 

if (isnumeralterm (FreeVar s)) = (isnumeralterm (FreeVar t))

then [[(t,s)]] else nil |

	supermatch L (Function t) (Function u) = supermatch L t u |

	supermatch L (CaseExp(u,v,w)) (CaseExp(u2,v2,w2)) =

		mergematches (supermatch L u u2) (mergematches 
		(supermatch L v v2) (supermatch L w w2)) |

	supermatch L (Infix(x,ResOp t,y)) (Infix(x2,ResOp t2,y2)) =

		if t <> t2 then 

		(errormessage ("Bad match "^t2^" for "^t);nil)

		else mergematches (supermatch L x x2) (supermatch L y y2) |

	supermatch L (Infix(x,i,y)) (Infix(x2,j,y2)) =

		(* types of operator (constant or variable) match *)

		if ((stringtoop (opdisplay i) = ConOp (opdisplay i)
		andalso stringtoop (opdisplay j) = ConOp (opdisplay j))

		orelse (stringtoop (opdisplay i) = VarOp (opdisplay i)
		andalso stringtoop (opdisplay j) = VarOp (opdisplay j)))

		(* relative type and opacity information matches *)

		andalso ((oldlists istypedoperator (opdisplay i) andalso
		istypedoperator (opdisplay j) andalso 
		oldlists opof (opdisplay i) = opof (opdisplay j))

		orelse (not (oldlists istypedoperator (opdisplay i)) andalso
		not (istypedoperator (opdisplay j))))

		(* the handling of the operators themselves is precisely
		like the handling of constants (it involves references
		to possible theorems and definitions); then merge in
		the matches of the operands *)

		(* the first clause here expresses the same reversal
		of matching found in the case of free variables above *)

		then mergematches (if 
		((stringtoop (opdisplay i) = VarOp (opdisplay i)
		andalso stringtoop (opdisplay j) = VarOp (opdisplay j)))

		then [[(("?"^(opdisplay j)),("?"^(opdisplay i)))]]
		else [nil])

		(mergematches (supermatch L (Constant (opdisplay i))
			(Constant (opdisplay j)))
		(mergematches (supermatch L x x2) (supermatch L y y2)))


		else 

		(errormessage ("Bad match "^(opdisplay j)^
		" for "^(opdisplay i)
		^" (relative types or opacity fail to match)");nil) |

	(* other atomic terms need to match precisely *)

	supermatch L t u = if t=u then [nil] else 

	(errormessage ((baredisplay t)^" doesn't match "^(baredisplay u));nil);


(* supermatch can be run on a term constructed by listtoterm from the
view *)

(* then the viewsub function should do the work of old supersubs;
the outcome of supermatch is actually a view (extending the skeleton
provided by the "official" view); the theorems to which viewsub is
to be applied can be read from THMTEXTDEPS (actually, need to have
been read from there in advance!) *)

(* this is an internal command; the user command will call this
on the theorem text dependencies of its single theorem argument *)

(* utility for generating new theorem names; add a suffix repeatedly
until new name is formed.  Prefix # is always used for operators *)

(* this utility does allow pretheorems to be overwritten; required by
the internal structure of the exportthmlist command *)

fun newtheoremname suffix name = if isatheorem name orelse isbuiltinthm name

	then if opdisplay(stringtoop name) = name then 
		newtheoremname suffix("#"^name) 

	else newtheoremname suffix (name^"_"^suffix)

	else name;

(* utility for fixing declarations of the new theorems to be added *)

(* we rely here on theorems not having nontrivial relative type,
opacity, scin/scout, or any such properties *)

fun fixdec suffix s = if s <> "" andalso stringtocon s = Constant s

	then declarepretheorem (newtheoremname suffix s)

	else let val S = newtheoremname suffix s in

	(if oldlists isstrictprefix s then declareunarypretheorem S 
	else declarepretheorem S)

	end;


(* exportthmlist now does declaration checking *)

fun exportthmlist view target suffix thmlist = 

 (* check that all axioms on which theorems in thmlist depend
are found in view *)

if let val A =(union2(map Deps thmlist)) in (map (viewof2 view) A; 
   (map (foundinview view) A = map (fn x => true) A)) end 

then

let val L2 =
	(map (fn s => (s,Thm s))) thmlist in (* build theorem list *)

(getoldlists();  (* save declaration info from source theory *)

gettheory target; backuptheory();  (* go to target theory and back it up
					against disaster *)

let val M = stripvars(supermatch nil 
	(listtoterm (map (fn (a,b) => a) (theview view)))
	(listtoterm (map (fn (a,b) => b) (theview view)))) in 

if M = nil then  (* don't go any further! *)
(errormessage "Construction of match list failed")

else(backupview view; VIEWS:=strongadd view 
	(union (hd M) 
(map (fn x => (x,
	(newtheoremname suffix x)))

		(separate (fn x => not (foundin x (hd M))) thmlist)))
		(!VIEWS);  (* replace the original view with
				its extension plus names for the
				new theorems to be proved *)

(* check that all constants, operators and variable operators present
are found in view *)

if let val A = union2(map (oldlists thmconlist) thmlist) in 
(map (viewof2 view) A;
(map (foundinview view)
A = map (fn x => true) A)) end

then(

map (fn (name,x) => fixdec suffix name) 
	(separate (fn (x,y) => not (foundin x (hd M))) L2);

map (fn (name,(fo,lt,rt,dps)) => (let val T = newtheoremname suffix name in

(addtheorem T

	(viewsub view fo) (viewsub view lt) (viewsub view rt) (sortset(union2 
(map Deps (map (fn x => (hd(termtolist(viewsub view (listtoterm [x]))))) dps))))); 
fixdeps T; 

(* this error check should no longer be triggered *)

if declarecheck false 0 (Leftside T) andalso declarecheck false 0 (Rightside T)
andalso declarecheck false 0 (Formatof T) then thmdisplay T 
else (errormessage ("Declaration failure in export of "^T);forget T) end)) 
(separate (fn (x,y) => not (foundin x (hd M))) L2)  ; ())

else errormessage "Not all constants and operators are found in view"

) end ) end

else errormessage "Required axioms not covered by view";

(* USER COMMAND *)

(* this command should be invoked in the source theory from which a
theorem is to be exported.  view is the view used.  target is the
name of the target theory.  suffix is a suffix to be attached when
name collisions are to be avoided (alphanumeric).  thm is the name
of the theorem to be exported. *)

(* this command will issue many messages, which should be examined
to see if anything went wrong.  It remains unstable. *)

(* points to remember:  one does need to include operator variables
in views; the system does not accept them automatically, because operator
variables do have user-declarable properties.  This command extends
the view being used.  When the view is not adequate to support the 
export of the theorem, the view will need to be repaired to eliminate
any theorems that were not exported successfully. *)

fun exportthm view target suffix thm = if not(foundin target (!THEORIES))

	then errormessage ("Target theory "^target^" not found")

	else if not (isatheorem thm)

	then errormessage ("Theorem "^thm^" not found")

	else if not (foundin view (!VIEWS))

	then errormessage ("View "^view^" not found")

	else exportthmlist view target suffix (thmtextdeps thm);
	

(* END theorem export under construction *)

(* ADD:  reaxiomatization and redefinition commands *)

(* these are needed to make theorem export more flexible, by making
it possible to change axiomatization and definition structures *)

(* proveanaxiom and makeanaxiom together support full reaxiomatization
capability with respect to non-definitions *)

(* USER COMMAND *)

(* this reaxiomatization function supports the introduction of lemmas
as axioms to be proved later; it is to be issued in a proof environment
in which the axiom has been re-proved using other axioms *)

fun proveanaxiom thm = if isatheorem thm andalso
	not(isdefinition thm) andalso foundinset thm (Deps thm)

	then if leftside(!ENV) = Leftside thm andalso
		rightside(!ENV) = Rightside thm
		andalso not (foundinset thm (deps(!ENV)))

	then THEOREMS := map (fn (na,(fo,lt,rt,dps)) =>
	(na,(fo,lt,rt,if foundinset thm dps 
		then sortset(union (deps (!ENV)) (dropfromset thm dps)) 
		else dps))) (!THEOREMS)

	else errormessage 
	("Environment not appropriate for proof of axiom "^thm)

	else errormessage ("Axiom "^thm^" not found");

(* USER COMMAND *)

(* make a non-definition into an axiom *)

fun makeanaxiom thm = if isatheorem thm andalso not(foundinset thm (Deps thm))

	then addtheorem thm (Formatof thm) (Leftside thm) (Rightside thm) [thm]

	else errormessage
	("Theorem "^thm^" either does not exist or is an axiom or definition");

(* redefinition commands *)

(* USER COMMAND *)

(* coerce a definition to an axiom *)

fun undefine s = if isdefined s then (let val thm = definitionof s in
	addtheorem thm (Formatof thm) (Leftside thm) (Rightside thm) [thm];
			DEFINITIONS := drop (thm) (!DEFINITIONS);
			DEFINITIONS2 := drop s (!DEFINITIONS2);
			fixdeps (thm) end)

	else errormessage (s^" is not a defined notion"); 

(* USER COMMAND *)

(* make the axiom thm into a definition, if possible *)

fun makeadefinition thm =

	if not (isatheorem thm) orelse not (foundinset thm (Deps thm))
	orelse isdefinition thm

	then errormessage (thm^" is not an axiom")

	else if ((not (atomdefinitionformat (Leftside thm)))
	andalso (not (opdefinitionformat (Leftside thm)))) orelse
	isdefined (eitherhead (Leftside thm)) orelse 
	stringtoop (eitherhead (Leftside thm)) = 
		ResOp (eitherhead (Leftside thm))
	orelse not (subset (freevarlist (Rightside thm)) 
		(freevarlist (Leftside thm)))
	then errormessage 
	("Format error in "^thm^" or relevant definition already exists")

	else if foundinset thm (union2 (map thmconlist 
		(conlist2 thm (Rightside thm))))

	then errormessage (thm^" would be a circular definition")

	else (adddef thm (eitherhead (Leftside thm));fixdeps thm);

(* for completeness, a version for type definitions would seem desirable,
but not until the type definition facility is complete; otherwise, this
should complete the redefinition functions by making it possible to 
map back and forth between axiom and definition status.  Complete redefinition
would be achieved by undefining the first definition, making the new
definition an axiom then a definition, then reproving the original
definition and using proveanaxiom; a full redefine command would still
be nice, but is not strictly needed *)

(* signals to GUI *)

fun guidone() = output(std_out,"\n\nGUIDONE\n");

fun guistart() = output(std_out,"\n\nGUISTART\n");




(* Standard abbreviations *)

val a = axiom;

val s = start;

val e = exit;

val q = quit;

val wb = workback;

val ri = ruleintro;

val rri = revruleintro;

val ari = altruleintro;

val iri = inputri;

val arri = altrevruleintro;

val ex = execute;

val td = thmdisplay;

val dpt = declarepretheorem;

val dupt = declareunarypretheorem;

val p = prove;

val smt = showmatchtheorem;

val tri = targetruleintro;

val ae = autoedit;

val rp = reprove;

val sat = showalltheorems;

val srt = showrelevantthms;

val dti = defaulttypeinfo;

val nti = notypeinfo;

(* new on July 13, 1999 *)

val ut = upto;

val dtl = downtoleft;

val dtr = downtoright;

val lut = litupto;

val ldtl = litdowntoleft;

val ldtr = litdowntoright;

val mtri = matchtri;

val amtri = anothermatchtri;

val cef = clearerrorflag;

(* user commands installed on the script menu *)

(* these should be classified and comments added *)

(* as with Close above, command is strengthened with Push
instead of push when used as a user command *)

fun CloseAll() = (map Close (!OPENMODULES);OPENMODULES:=nil);

fun setupmenu () = (

(* internals of load command *)

addtoothermenu "setprogram" (fn () => setprogram 
	(getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));	
addtoothermenu "precedencereader" (fn () => precedencereader 
(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));
addtoothermenu "tracelevelreader" (fn () => tracelevelreader 
(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));
addtoothermenu "setdefaultprec" 
	(fn () => setdefaultprec (getintarg (!ARGUMENTS)));


addtoothermenu "prefixreader" (fn () => prefixreader (getchararg (!ARGUMENTS)) 
	(getchararg(!ARGUMENTS)));
addtoothermenu "addopaque" (fn () => addopaque (getchararg(!ARGUMENTS)));
addtoothermenu "addscinleft" (fn () => addscinleft (getchararg(!ARGUMENTS))
		(getchararg(!ARGUMENTS)));
addtoothermenu "addscinright" (fn () => addscinright (getchararg(!ARGUMENTS))
		(getchararg(!ARGUMENTS)));
addtoothermenu "addscout" (fn () => addscout (getchararg(!ARGUMENTS))
		(getchararg(!ARGUMENTS)));
addtoothermenu "addoperator" (fn ()=>addoperator(getchararg(!ARGUMENTS))
	(getchararg(!ARGUMENTS)));
addtoothermenu "forcetheorem" (fn () => forcetheorem (getchararg(!ARGUMENTS)) 
		(getchararg(!ARGUMENTS)));
addtoothermenu "forcemoduletheorem" (fn () => forcemoduletheorem 
(getchararg(!ARGUMENTS)) (getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtoothermenu "modulestamp" (fn () => modulestamp (getchararg(!ARGUMENTS)));
addtoothermenu "moduleinvstamp" 
(fn () => moduleinvstamp (getchararg(!ARGUMENTS)));
addtoothermenu "addpretheorem" (fn () => addpretheorem 
(getchararg(!ARGUMENTS)));
addtoothermenu "addvartype" (fn () => addvartype (getchararg (!ARGUMENTS))
	(getchararg(!ARGUMENTS)));
addtoothermenu "adddef" (fn () => adddef (getchararg (!ARGUMENTS)) 
(getchararg (!ARGUMENTS)) );
addtoothermenu "adddefdep2" (fn () => adddefdep2 (getchararg (!ARGUMENTS)) 
(getchararg (!ARGUMENTS)) );
addtoothermenu "addthmtextdep2" (fn () => addthmtextdep2 
(getchararg (!ARGUMENTS)) 
(getchararg (!ARGUMENTS)) );
addtoothermenu "addscript" (fn () => addscript (getchararg(!ARGUMENTS)));

(* environment management commands *)

addtomenusecure "exit" exit;
addtomenusecure "e" exit;

	(* create new environment *)

addtomenu "start" (fn () => start (getchararg (!ARGUMENTS)));
addtomenu "s" (fn () => start (getchararg (!ARGUMENTS)));

	(* conversions of existing environment *)

addtomenu "workback" workback;
addtomenu "wb" workback;

addtomenu "startover" startover;
addtomenu "starthere" starthere;

	(* environment desktop commands *)

addtomenu "getenv" (fn () => getenv (getchararg (!ARGUMENTS)));

addtomenu "saveenv" (fn () => saveenv (getchararg (!ARGUMENTS)));
addtomenu "backupenv" backupenv;

addtomenu "dropenv" (fn () => dropenv (getchararg (!ARGUMENTS)));

	(* environments from theorems *)

addtomenu "autoedit" (fn () => autoedit (getchararg (!ARGUMENTS)));
addtomenu "ae" (fn () => ae (getchararg (!ARGUMENTS)));

addtomenu "getleftside" (fn () => getleftside (getchararg(!ARGUMENTS)));
addtomenu "getrightside" (fn () => getrightside (getchararg(!ARGUMENTS)));

(* navigation commands *)

	(* basic movement commands *)

addtomenu "right" right;
addtomenu "left" left;
addtomenu "up" up;
addtomenu "top" top;

	(* powerful movement commands *)

addtomenu "upto" (fn ()=>upto (getchararg (!ARGUMENTS)));
addtomenu "ut" (fn ()=>upto (getchararg (!ARGUMENTS)));
addtomenu "litupto" (fn ()=>litupto (getchararg (!ARGUMENTS)));
addtomenu "lut" (fn ()=>litupto (getchararg (!ARGUMENTS)));
addtomenu "uptols" (fn ()=>uptols (getchararg (!ARGUMENTS)));
addtomenu "uptors" (fn ()=>uptors (getchararg (!ARGUMENTS)));

addtomenu "downtoleft" (fn () => downtoleft (getchararg (!ARGUMENTS)));
addtomenu "dtl" (fn () => downtoleft (getchararg (!ARGUMENTS)));
addtomenu "litdowntoleft" (fn () => litdowntoleft (getchararg (!ARGUMENTS)));
addtomenu "ldtl" (fn () => litdowntoleft (getchararg (!ARGUMENTS)));
addtomenu "dlls" (fn ()=>dlls (getchararg (!ARGUMENTS)));
addtomenu "dlrs" (fn ()=>dlrs (getchararg (!ARGUMENTS)));

addtomenu "downtoright" (fn () => downtoright (getchararg (!ARGUMENTS)));
addtomenu "dtr" (fn () => downtoright (getchararg (!ARGUMENTS)));
addtomenu "litdowntoright" (fn () => litdowntoright (getchararg (!ARGUMENTS)));
addtomenu "ldtr" (fn () => litdowntoright (getchararg (!ARGUMENTS)));
addtomenu "drls" (fn ()=>drls (getchararg (!ARGUMENTS)));
addtomenu "drrs" (fn ()=>drrs (getchararg (!ARGUMENTS)));

(* display commands *)

	(* version *)

addtomenusecure "versiondate" versiondate;

	(* verbosity control *)

(* addtomenu "bequiet" bequiet;
addtomenu "thmsonly" thmsonly; *)
addtomenu "speakup" speakup;
addtomenu "diagnostic" diagnostic;
addtomenu "demo" demo;

addtomenu "termprompts" termprompts;
addtomenu "localdisplayoff" localdisplayoff;
addtomenu "globaldisplayoff" globaldisplayoff;
addtomenu "bothdisplays" bothdisplays;

	(* margin control *)

addtomenusecure "setline" (fn () => setline (getintarg(!ARGUMENTS)));

	(* vertical compression *)

addtomenusecure "compress" compress;
addtomenusecure "expand" expand;

	(* error message control *)

addtomenu "setpause" setpause;
addtomenu "setnopause" setnopause;

	(* demo remark function *)

addtomenu "demoremark" (fn()=> demoremark (getchararg(!ARGUMENTS)));

	(* identify environment and theory *)

addtomenusecure "envname" envname;
addtomenusecure "theoryname" theoryname;
addtomenusecure "theorysize" theorysize;

	(* term display *)

addtomenusecure "look" look;
addtomenusecure "lookback" lookback;
addtomenusecure "lookhere" lookhere;

	(* declaration display *)

addtomenusecure "showdec" (fn()=>showdec (getchararg(!ARGUMENTS)));


	(* theorem and saved environment display *)

addtomenusecure "thmdisplay" (fn () => thmdisplay (getchararg(!ARGUMENTS)));
addtomenusecure "td" (fn () => thmdisplay (getchararg(!ARGUMENTS)));
addtomenusecure "tacticdisplay" (fn () => 
   tacticdisplay (getchararg(!ARGUMENTS)));
addtomenusecure "showenv" (fn () => showenv (getchararg (!ARGUMENTS)));
addtomenusecure "showmatchtheorem" (fn () => 
showmatchtheorem (getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenusecure "smt" (fn () => 
showmatchtheorem (getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenusecure "lookhyps" lookhyps;
addtomenusecure "seeprogram" (fn()=>seeprogram(getchararg(!ARGUMENTS)));
addtomenusecure "showdef" (fn()=>showdef (getchararg(!ARGUMENTS)));
addtomenusecure "showscout" (fn()=>showscout (getchararg(!ARGUMENTS)));
addtomenusecure "showscin" (fn()=>showscin (getchararg(!ARGUMENTS)));

	(* dependency display *)

addtomenusecure "seedeps" seedeps;
addtomenusecure "showalldeps" (fn () => showalldeps (getchararg (!ARGUMENTS)));
addtomenusecure "whatuses" (fn () => whatuses (getchararg (!ARGUMENTS)));

	(* theorem list display *)

(* these cannot be secure at the moment because they themselves
invoke the secure menu *)

addtomenu "showalltheorems" showalltheorems;
addtomenu "showmodule" (fn () => showmodule (getchararg (!ARGUMENTS)));
addtomenu "sat" sat;
addtomenu "showrelevantthms" showrelevantthms;
addtomenu "srt" srt;
addtomenu "showaxioms" showaxioms;
addtomenusecure "statementdisplay" statementdisplay;

	(* view display *)

addtomenusecure "showview" (fn () => showview (getchararg (!ARGUMENTS)));

(* display operator precedences *)

addtomenusecure "showprecedences" showprecedences;

(* tabulate program bindings *)

addtomenusecure "showprograms" showprograms;

(* declaration commands *)

	(* operators *)

addtomenu "declaretypedinfix" (fn () => declaretypedinfix 
(getintarg (!ARGUMENTS)) (getintarg (!ARGUMENTS)) (getchararg(!ARGUMENTS)));
addtoothermenu "declaretypedinfix" (fn () => declaretypedinfix 
(getintarg (!ARGUMENTS)) (getintarg (!ARGUMENTS)) (getchararg(!ARGUMENTS)));
addtomenu "declareinfix" (fn () => declareinfix (getchararg (!ARGUMENTS)));

	(* opaque and unary operators *)

addtomenu "declareopaque" (fn () => declareopaque (getchararg (!ARGUMENTS)));
addtomenu"declareprefix" (fn () => declareprefix (getchararg(!ARGUMENTS)) 
(getchararg(!ARGUMENTS)));
addtomenu "declaretypedunary" 
(fn() => declaretypedunary (getintarg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenu "dtu" 
(fn() => declaretypedunary (getintarg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenu "declareunaryopaque" (fn () => declareunaryopaque
(getchararg(!ARGUMENTS)));
addtomenu "declareunary" (fn() => declareunary (getchararg(!ARGUMENTS)));
addtomenu "du" (fn() => declareunary (getchararg(!ARGUMENTS)));

	(* default types *)

addtomenu "defaulttypeinfo" (fn () => defaulttypeinfo (getchararg (!ARGUMENTS))
	(getchararg (!ARGUMENTS)));
addtomenu "dti" (fn () => defaulttypeinfo (getchararg (!ARGUMENTS))
	(getchararg (!ARGUMENTS)));
addtomenu "notypeinfo" (fn () => notypeinfo (getchararg (!ARGUMENTS)));
addtomenu "nti" (fn () => notypeinfo (getchararg (!ARGUMENTS)));

	(* precedence *)

addtomenu "setprecedence" (fn () => setprecedence (getchararg(!ARGUMENTS))
	(getintarg (!ARGUMENTS)));
addtomenu "setdefaultprec" (fn () => setdefaultprec (getintarg (!ARGUMENTS)));
addtomenu "clearprecs" clearprecs;
addtomenu "sameprec" 
(fn () =>sameprec (getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenu "defaultprecsame" (fn()=>defaultprecsame(getchararg(!ARGUMENTS)));
addtomenu "leftprecabove"
(fn () =>leftprecabove (getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenu "rightprecabove"
(fn () =>rightprecabove (getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenu "leftprecbelow"
(fn () =>leftprecbelow (getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenu "rightprecbelow"
(fn () =>rightprecbelow (getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));

	(* constants *)

addtomenu "declareconstant" (fn () => declareconstant 
(getchararg (!ARGUMENTS)));
addtoothermenu "declareconstant" (fn () => declareconstant 
(getchararg (!ARGUMENTS)));

	(* pretheorems *)

addtomenu "declarepretheorem" 
(fn () => declarepretheorem (getchararg (!ARGUMENTS)));
addtomenu "dpt" 
(fn () => declarepretheorem (getchararg (!ARGUMENTS)));
addtomenu "declareunarypretheorem" 
(fn () => declareunarypretheorem (getchararg (!ARGUMENTS)));
addtomenu "dupt" 
(fn () => declareunarypretheorem (getchararg (!ARGUMENTS)));

	(* scin/scout *)

addtomenu "makescout" (fn ()=>makescout (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS)));
addtomenu "makescin" (fn ()=>makescin (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS)));
addtomenu "makescinvar" (fn ()=>makescinvar (getchararg (!ARGUMENTS)));
addtomenu "makescinleft" (fn ()=>makescinleft (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS)));
addtomenu "makescinright" (fn ()=>makescinright (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS)));

	(* functional programming *)
	
addtomenu "setprogram" (fn () => setprogram (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS)));
addtomenu "deprogram" (fn()=>deprogram (getchararg (!ARGUMENTS)));

(* Environment modification commands *)

	(* assignment commands *)

addtomenu "assign"
(fn () => assign (getchararg(!ARGUMENTS)) (getchararg(!ARGUMENTS)));

addtomenu "assignit" (fn () => assignit (getchararg (!ARGUMENTS)));
addtomenu "assigninto" (fn () => assigninto (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS)));

addtomenu "unification" (fn () => unification (getchararg (!ARGUMENTS)));
addtomenu "u" (fn () => unification (getchararg (!ARGUMENTS)));
addtomenu "ul" (fn () => ul (getchararg (!ARGUMENTS)));
addtomenu "ur" (fn () => ur (getchararg (!ARGUMENTS)));

addtomenusecure "initializecounter" initializecounter;
addtomenusecure "setmaxcounter" (fn () => setmaxcounter (getintarg (!ARGUMENTS)));
addtomenusecure "showcounter" showcounter;
addtomenusecure "showmaxcounter" showmaxcounter;
addtomenusecure "longestproof" longestproof;

	(* embedded theorem introduction *) 

addtomenu "ruleintro" (fn () => ruleintro (getchararg (!ARGUMENTS)));
addtomenu "ri" (fn () => ruleintro (getchararg (!ARGUMENTS)));
addtomenu "revruleintro" (fn () => revruleintro (getchararg (!ARGUMENTS)));
addtomenu "rri" (fn () => revruleintro (getchararg (!ARGUMENTS)));

addtomenusecure "inputri" (fn () => inputri (getchararg (!ARGUMENTS)));
addtomenusecure "iri" (fn () => inputri (getchararg (!ARGUMENTS)));

addtomenu "targetruleintro" 
	(fn () => targetruleintro (getchararg (!ARGUMENTS)));
addtomenu "tri" (fn () => targetruleintro (getchararg (!ARGUMENTS)));
addtomenu "tri2" (fn () => tri2 (getchararg (!ARGUMENTS)));
addtomenu "matchtri" (fn () => matchtri (getchararg (!ARGUMENTS)));
addtomenu "mtri" (fn () => matchtri (getchararg (!ARGUMENTS)));
addtomenu "anothermatchtri" anothermatchtri;
addtomenu "amtri" anothermatchtri;

addtomenu "droprule" droprule;

	(* alternative embedded theorem introduction *)

addtomenu "altruleintro" (fn () => altruleintro (getchararg (!ARGUMENTS)));
addtomenu "ari" (fn () => altruleintro (getchararg (!ARGUMENTS)));
addtomenu "altrevruleintro" (fn () => altrevruleintro 
(getchararg (!ARGUMENTS)));
addtomenu "arri" (fn () => altrevruleintro (getchararg (!ARGUMENTS)));

	(* tactic interpreters *)

addtomenu "execute" execute;
addtomenu "ex" ex;
addtomenu "steps" steps;
addtomenu "stepsnorules" stepsnorules;
(* addtomenu "onestep" onestep; *)

(* cmatch

	(* matching strength *)

addtomenu "cmatch" cmatch;

*)

addtomenu "settrace" (fn () => settrace (getintarg (!ARGUMENTS)));
addtomenu "settracelevel" (fn () => settracelevel (getchararg (!ARGUMENTS))
	(getintarg (!ARGUMENTS)));

	(* use of saved environments *)

addtomenu "applyenv" (fn () => applyenv (getchararg (!ARGUMENTS)));
addtomenu "applyconvenv" (fn () => applyconvenv (getchararg (!ARGUMENTS)));

(* Proof commands *)

	(* definition commands *)

addtomenu "defineconstant" (fn () => defineconstant (getchararg(!ARGUMENTS)) 
(getchararg(!ARGUMENTS)));
addtomenu "definetypedinfix" (fn ()=> definetypedinfix (getchararg(!ARGUMENTS))
(getintarg(!ARGUMENTS))(getintarg(!ARGUMENTS))(getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenu "defineinfix" (fn () => defineinfix (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));
addtomenu "defineconstanttype" (fn () => defineconstanttype 
(getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));
addtomenu "defineinfixtype" (fn () => defineinfixtype (getchararg(!ARGUMENTS))
(getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS))(getchararg(!ARGUMENTS)));

	(* axiom commands *)

addtomenu "axiom" (fn () => axiom (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));
addtomenu "a" (fn () => axiom (getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));
addtomenu "statement" (fn () => statement(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));

	(* rexiomatization *)

addtomenu "proveanaxiom" (fn () => proveanaxiom (getchararg (!ARGUMENTS)));
addtomenu "makeanaxiom" (fn () => makeanaxiom (getchararg (!ARGUMENTS)));
addtomenu "undefine" (fn () => undefine (getchararg (!ARGUMENTS)));
addtomenu "makeadefinition" (fn () => 
	makeadefinition (getchararg (!ARGUMENTS)));

	(* proof commands proper *)

addtomenu "prove" (fn () => prove (getchararg (!ARGUMENTS)));
addtomenu "p" (fn () => prove (getchararg (!ARGUMENTS)));

addtomenu "reprove" (fn () => reprove (getchararg (!ARGUMENTS)));
addtomenu "rp" (fn () => rp (getchararg (!ARGUMENTS)));
addtomenu "autoreprove" autoreprove;

addtomenu "verify" (fn () => verify (getchararg (!ARGUMENTS)));
addtomenu "clearerrorflag" clearerrorflag;
addtomenu "cef" cef;

	(* oops *)

addtomenu "forget" (fn () => forget (getchararg (!ARGUMENTS)));

(* theory handling commands *)

	(* clear commands *)

addtomenu "clear" clear;
addtomenu "cleartheories" cleartheories;

	(* theory desktop commands *)

addtomenu "backuptheory" backuptheory;
addtomenu "gettheory" (fn () => gettheory(getchararg(!ARGUMENTS)));
addtomenu "droptheory" (fn () => droptheory(getchararg(!ARGUMENTS)));

	(* theory file commands *)

addtomenu "storeall" (fn () => storeall (getchararg (!ARGUMENTS)));
addtomenu "safesave" safesave;
addtomenu "load" (fn () => load (getchararg (!ARGUMENTS)));

	(* script command *)

addtomenu "script" (fn () => script (getchararg(!ARGUMENTS)));
addtomenu "truescript" (fn () => script (getchararg(!ARGUMENTS)));
addtomenu "Script" (fn () => script (getchararg(!ARGUMENTS)));
addtomenu "makescript" (fn () => makescript (getchararg(!ARGUMENTS)));

(* GUI stuff *)

addtomenusecure "guistart" guistart;
addtomenusecure "guidone" guidone;

(* View management and theorem export *)

addtomenu "declareview" (fn () => declareview (getchararg (!ARGUMENTS)));
addtomenu "restoreview" (fn () => restoreview (getchararg (!ARGUMENTS)));
addtomenu "backupview" (fn () => backupview (getchararg (!ARGUMENTS)));

addtomenu "addtoview" (fn () => addtoview 
(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));

addtomenu "dropfromview" (fn () => dropfromview 
	(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));

addtomenu "dropview" (fn () => dropview (getchararg (!ARGUMENTS)));

addtomenu "exportthm" (fn () => exportthm 
(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS))
(getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));

(* theory modularity *)

addtomenu "interfacetheorem" (fn () => interfacetheorem 
(getchararg (!ARGUMENTS)));

addtomenu "draftinterface" draftinterface;

(* tactic module system *)

addtomenu "Push" (fn () => Push (getchararg (!ARGUMENTS))(getchararg (!ARGUMENTS)));

addtomenu "Open" (fn () => Open (getchararg (!ARGUMENTS)));

addtomenu "Close" (fn () => Close (getchararg (!ARGUMENTS)));

addtomenu "PopModule" (fn () => PopModule (getchararg (!ARGUMENTS)));

addtomenu "CloseAll" CloseAll

);  (* end of setupmenu() *)

(* more setup functions for compiled version *)

(* reserved new operators !@ and !$ for automatic parameterization of
theorems *)

fun reserveflat () = map (reserveop 0 0) ["<*","*>","<<=","=>>","|-|",
"=",":","=!",
">!","<!","%!","/!","*!","-!","+!","<=","=>",",","||","!@","!$","#!"];


fun setup () = ((* RESERVED:=nil; *)reserveflat();
	reserveop 1 0 "@";
	reserveop 1 0 "@!";
        reserveop 1 0 "@*";
	NEWDEPS:=nil;
	SCINSCOUT := nil;
	SCRIPTS:=nil;
	setupmenu(); mainmenu(); cleartheories(); setbasicview());

(* val _ = addtomenu "guidone" guidone;
val _ = addtomenu "guistart" guistart; *)

(* the following line eliminates the need to run setup() *)

val _ = setup();




