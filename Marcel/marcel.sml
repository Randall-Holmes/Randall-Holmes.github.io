(* reimplementation of prover marcelsequent *)

(* this document should contain a clean reimplementation of marcelsequent
with enough discussion of what is going on to provide the core of a manual *)

(* I am reimplementing because the existing system is turning into patches
on patches; it was never written with this kind of serious systematic use 
in mind! *)

(* version date command *)

fun Flush() = TextIO.flushOut(TextIO.stdOut);
fun say s = (TextIO.output(TextIO.stdOut,"\n"^s^"\n");Flush());

fun versiondate() = say "October 13, 2011: \n Made ManyConclusions mode cosmetically one-conclusion,\n making OneConclusion mode eventually obsolete.\n  Changed turnstile to horizontal bar.\n  Introduce prem(ise) and conc(lusion)\n in place of left and right.\nfixed OneConclusion mode so it actually has an illusory absurd conclusion when it has no conclusion, \nand made OneCounclusion the default mode for the moment.  \nThis incorporates a solution for abtraction and function application.";


(* DAILY VERSION NOTES *)

(* 10/15/2015

cleaning up the 10/13 updates.

Installed a command oneconcdisplaytoggle() which switches
between a one conclusion display format in ManyConclusions mode
and a multi-conclusion format.   The default is the one conclusion display.

Changed the associative logical connectives so that they group
to the left.  The old precs will be needed for saved files.

*)

(* 10/13/2015

installed the display used in the Python version, with modifications to support use of line numbers.  Conclusions after
the first one are displayed as negative premises with starred numbers.

New mnemonics prem(ise) for Left, getprem(ise) for gl, conc(lusion) for Right, getconc(clusion) for gr.  The turnstile
is replaced with a horizontal line.  Of course transcripts will
still use the old mnemonics for now.

*)

(* September 8th 2011

This version is being readied for class use for Math 314, Fall 2011.

I'm going to reintroduce the alternative of no conclusion in one-conclusion
mode, with a phantom null conclusion.  I'm going to make OneConclusion
default behavior for now.  

I also made the logging commands give feedback to the user, and also warn
if one tries to stop logging when one is not logging or open a log file when there already is one.

*)

 (* December 15, 2010:

This has just been renamed marcel.sml.  The manual has been updated in
certain ways but does not contain a description of the lambda
abstraction yet.

Things to do with the prover in winter break 2010:

see if the general parser tool can be adapted to use with the prover.
Order of operations is one issue -- it would be nice to have that on
the parser tool side.

Go for an aggressive definition of substitution in the original style
which did not need a definition of free occurrences, adapted to our
generalized binders.

Implement general binder definitions of all sorts.  Do we want
function variables?

Look for modifications in recent versions which are not documented in
the manual.  Function application needs to be described in the manual.

I like the derived rule idea (discussed below), in order to aim for a
smaller core for better reliability, and also in order to aim for an
ability to reconfigure.

This is looking as if another complete rewrite might be a good idea.  Open
with use of the parser engine to build terms.  Think at every step how
alternative logics can be slotted in.  Design all structure types with
expansion slots!

The Watson programmable rewrite system should be put in, but adapted
to this sort of logical context.

Specker's theorem as a target remains a good idea.

Look at newparserforprover.sml -- I stripped down the newparser file to basics
(though I should put back in the prototype Marcel grammar).

*)

(*

May 31, 2010:

Make sure the manual is up to date.  This version marcellambda should
be the official version.  The manual should contain a writeup of the
solution to lambda-abstraction.

Go for the binder definitions.

See if a parser can be built using the generalized parser tool, and adapt
the prover to use it?  How to handle updatable order of operations, though?

*)

(* Feb 20, 2010

Make one conclusion mode really one-conclusion:  preserve a negative
conclusion when right is applied.  Implemented.

*)

(* Jan 30, 2010

The next proposed step (not yet done in this version) is to use
application and lambda-terms to implement general binder definitions.
This will bring us to a highly adequate level of generality.

After that, careful checking of the matching and substitution functions
and of the logic.

After that, think about the ability to define rules (so the
operational logic can be changed without changing the code).

For nice proof-theoretical properties, I want ability to reduce
otherwise irreducible formulas with function abstractions in them
by in effect using contextual definition.  Of course this can be done now
by cutting on for some y, y = f(x).

In version marcellambda, I have removed the experimental lambda-abstraction.
I am intending to install the solution described below.

Generalized lambda-terms are now installed.  Again note that
generalized lambda-terms are not necessarily functions.

Function application in the sense described below is now installed.

I think I have the solution for application and lambda-abstraction.
I need to put in rules for y = f(x),  f(x) = y [order matters here]
x E (LT.U) and x E (LT:A.U).  It seems redundant and dangerous to put
in rules for y = (LT.U)(x):  two rules will handle that.

x E (LT:A.U)  reduces to (x E {[T,U]|T E A}

x E (LT.U) reduces to (x E {(T,U)|T=T})

y = f'x is equivalent to (Az.(x,z)Ef <-> y=z) v y=f`x  A cheap way to do this
is just to impose that expansion.  I could also use the prover to figure out
the right thing to enter.  So, we dont require f to be a function, just to
be a function locally.

y E f'x should go to something like (Ez.y E z & z = f'x)

Check that matching works correctly for general binders.

Of course, remove the experimental lambda-abstraction.  Do notice that
lambda-abstracts as defined here are not necessarily functions if T is
complex, and the definition of function application only requires
local functionality.

*)

(*  Feb. 9, 2009:

found and fixed a minor bug Feb 11 which was detected by SML/NJ compiler.
changes to port to SML/NJ are minimal.

Make the one conclusion mode apply double negation when moving a negative
conclusion to the hypothesis list. INSTALLED

Note that derived rules might not be hard to implement:  store an incomplete
proof, and the derived rule will make substitutions into that proof and serve
up its goals.  One also needs to do things like renumber variables in the
new goals.  One would want the ability to manually reorder goals in proofs
to get goals to serve things up in a sensible order?

Idea that the free variable counter should be a component of the current
goal rather than a global variable.  Make sure this works correctly for 
operations that *are* proof-global.

*)

(* June 17, 2008:

an approach to [Lx.T]

Have the substitution function carry out reduction of f`a to T[a/x] when
[Lx.T] replaces f. Have the obvious equality rule for lambda terms. 

installed beta-reduction in substitution...

This is not a public release because we can enter unstratified lambda terms...

I moved stratification to before substitution (mostly)...there is
still an incompatibility between the behavior of binding in general
binding terms and in [Lx.T] (the variable in [Lx.T] cannot be
captured).  In any event, beta reduction now has a stratification check.

*)

(*  June 13, 2008:

Modified the logic so that one can prove nothing about unstratified abstracts
except that they are sets.

I should put in previous version's fix which made unstratified
abstracts into sets if there was a set with that extension.  make
them the null set otherwise.

started drafting commands for defining binders using set notation.

define (BT:U.Phi) as B({T|TEU},{T:U|Phi})

define (BT:U.V) as B({[T,V]|T E U})

this is daunting...

question:  is the logic back to NFU or are proper classes implemented
as urelements?  No, it still has classes as urelements -- identity conditions
on unstratified abstracts are determined by extension.  I should change this.

*)

(*  June 11, 2008:

added the application function with appropriate arity and
stratification information.  also info for the lambda operator.

can we fiddle things so that "usetermdef" does beta-reduction?

how are binders stratified at present?

I should work on lambda-abstraction, application, and beta-reduction.
Further, this then has the obvious application of allowing definitions
of binders.  Definitely decided to use "`" for application: we don't
need complications of the parser.

To reduce the core by adding derived rules is a worthy thing.  This
would require the ability to define propositional connectives in terms
of basic connectives with primitive rules, and the ability to define
binders so that quantifiers could be defined.

It would require the ability to represent, create, and store rules,
and the logic would need a general capability for determining what
derived rule to use.  I suppose one would bind derived rules to
predicates, functions, binders, and connectives; then there would be
some matching and scheduling issues.  We might need function variables
(analogous to predicate variables) in order to state rules for term binders.

We still might want fully general rewriting (including the ability to
use universally quantified equations (or equational theorems) to
rewrite into bound contexts).

Lambda-terms don't allow complex binders of arbitrary form...one has to
take that into account in the beta-reduction rule.  Should (LT.U) mean
something in cases where T does not uniquely determine U?  Should this
lead us to think sets more general? (BT:U.Phi) = B(U,{T:U|Phi})?
[BT:U.V] = B(U,{[T,V]|T E U}).  IE use set forms in the binder definitions.

*)

(*  June 3, 2008:

unisyntax.sml contains notes on a possible generalization of the syntax
aspects.

derived rules would be a great improvement.  For one thing, we could
then reduce the number of primitives here.  The core of Marcel is too
large.

I think before reengineering I want to read the whole thing.

Should I try adding contextual definition to Marcel?  It presents
itself to me as an idea usable in a sequent calculus context?

I have a really interesting idea for writing more natural "proofs in
English" by constructing statements to be made before and after rule
applications in the course of "printing out" a proof tree.  This
requires work.  It is independently important (but related) to add
information about rules applied so as to facilitate checking of proof
tree validity.

*)

(* 8 May 2008:

Things that must be done.  Scripts should report settings of logic toggles.
Do theory files save this information?

A new logic setting for standard set theory should be created.  The fix
to restricted binding just put in should help to handle this.

We need function abstract and function application notation.  Definition
facility for binding constructions.

The adjustment of binding in restricted expressions probably means that
the implementation of Zermelo set theory is now easy.

introducing improved binding structure in (binder A:B.T) constructions:
the bound variables from A are not bound in B (the bounding expression).

The logic rules for binding expressions need to be checked.  So far, changes
were made in freeboundvarlist and subslist.

The logical rules for restricted binders are valid, but their validity
depends on the fact that we will actually have no bound variables in the 
restricting set at all due to well-formedness conditions.  They should
probably be rewritten.

The independent check for free occurrences of bound variables in parseerror
is not a good thing, but it is correctly set up at this point (and was
not before:  it used boundvarlist instead of freeboundvarlist).

Think about whether and in exactly what way this system has a core that
is too large, and whether and in exactly what way this could be fixed.

Improved predicate variable treatment by allowing some sort of matching.

 *)

(* 7 May 2008:

info about prover toggles must be stored in log files?

fixed apparent bug in expandlist

contemplating a better way to manage substitution

when substituting a term t for a variable x into a binder (BT.U), first replace
each bound variable in T with a fresh variable of a different kind
(negative indexed free variable?) throughout T and U then replace x
with t throughout T and U, then replace the different variables with bound
variables again.  This manages the variable binding convention with complex
binders correctly.  Note that the term t should be reindexed first with
the alternative variables, so that the counter will be set correctly 
to avoid capturing bound variables in t.

This is dangerous...but it should be a bit less ocmplicated than the current
implementation and it is back in the Marcel spirit...

No, I think I like the latest version here.  It does not use freeboundvarlist.
Freeboundvarlist IS used by the logic of the prover to avoid problems with
bound variables appearing in complex binders, but it is not used by the
substitution algorithm.  But could there be a problem?

There are problems.  I have identified an actual error in behavior
of binders appearing in complex binders.  The error was caused by
smashbound, which is now disabled.  So now I need to figure out
what the error in smashbound is.

Next assignment:  read all this code.  Work out a clean way to rename
bound variables.

I fixed the bound variable leak once and for all  I created a rebind
function which automatically sets bound variables to small values.

It would be advisable for soundness to write a version of the substitution
algorithm which does not depend on the dynamic handling of a global
bound variable counter.  But at the moment things seem to work.  Bound
variable indices are pleasantly small!

*)

(* 6 Feb 2008:

Much more profound idea being contemplated.  Add to proof trees text
for construction of a proof in perhaps tortured mathematical English:
there should be text to introduce each node in proof tree and text to write
on exiting it.  This should actually work, more or less, and really bring
out the claims about naturalness of proof style in Marcel if the
proofs are reasonably readable.

Fixed definitions so they cannot include predicate variables.
New function predvarlist lists all predicate variables appearing in a term.

Plan to restore at least minimal usefulness of P1, P2, etc. as predicate
rather than propositional letters, by allowing them to denote sets.

match Pi(t1,...,tn) with [t1,...,tn] E S where S is a set matched with
Pi.  Stratify sentences with Pi's appropriately.  Introduce a command
sp (SetPredicate) which will set a predicate to a set.

Modified stratification so that P0 remains opaque (because its
stratification is used in defining other analogous stratifications:
this is a convenient hack which maybe should be fixed) and the other
Pi's type as flat.

updated subslist to allow Pn(t_1,...,t_m) to be converted to
[t_1,...,t_n] E S, where (Pn,S) appears in the matching list.
Note that this has no effect on propositions Pn; they must be construed
as a separate namespace.  But if P1(x1) and P1(x2,x3) both appear the
P1 refers to the same set in both cases.

Now to add a global substitution command for these...  the command
is SetPredVar, mnemonic sp.

Now it should actually be possible to use formal theorems of first order 
logic in many contexts (including ones with type displacements with suitable
use of singleton coding).  [this will require use of ThmCut and explicit
sp's]

I ran a test; it does seem to work...

With this fix, there is no longer any reason to add function variables.(??)

Now the more dangerous question:  should some kind of matching extension
go with this?

Note that the meanings of Pn as propositional letter and predicate variable
thus become completely uncoupled (or should?)  Should this be checked?

One might want to add the ability to rename a predicate variable to another
predicate variable without exploding it to a set, or even to a defined
flat operator.  These things can be considered.  But actually these effects
can be obtained with the current machinery.

So I have recovered one of the features lost in the migration from
marcelsequent, though in an apparently less general form.  Whether an
extension to matching should go with this needs to be considered.
Terms P1[x1,...,xn] could be taken to match membership statements (or
other predication statements, or flat defined relations: in the latter
cases the Pn matches appropriate sets.).  This should indeed be
implemented: it will make the aforesaid theorems of first order logic
easier to apply, and it should not be too hard to implement.  With
some cunning, non-type-flat defined relations could be taken to match
sets too, but this should be done with extreme care.  Notice that this
is not higher-order matching: I'm not letting Pi[x1...xn] match fully
general assertions about x1...xn (though that also might be a worthy
experiment it presents problems).  For the moment ThmCut should provide
all the logical power of this projected matching update.

*)

(*

22 June:  

Should there be a command to block or severely restrict the use of the
equality rules?  They have a quite unexpected quality about them...

Making change in right rule of equality to make it less aggressive.
This will probably do weird things to existing files?  It does cause
some problems with existing files:  I had to fix settheory.txt extensively.

The current modification causes it to expand any definitions present
before it applies weak extensionality.  This may not be the best
adjustment.  It might be better to have it apply weak extensionality
if it sees a set.

Installing "GUI mode", setting off prover displays that the
GUI needs to pick up with markers it can identify.

Marcel:: starts one line error messages

Marcel:  starts messages from the prover (including some displays)
which continue until a line containing only ...

Begin sequent display 


End sequent display

begin and end a sequent display.

guimode() turns the mode on and noguimode() turns it off

I doubt one would want this on when working in the command window!  More
messages can be added on request.

*)

(*

June 18:  hitting q followed by return during demo mode will cause you
to leave demo mode (continuing to run file but fast).

*)

(*

June 17:  found a bug:  running undo through a usubs and issuing
an su partway through gives illegal results.

Block this by not allowing setunknown if USUBS is nonempty -- done
in new version.  Other rewriting commands should be OK at peculiar
stages, because they are driven by matching, which does take USUBS
information into account.

Probably I should reconfigure undo so that the peculiar substages
simply do not appear.

Further problem not fixed here:  if an equation is to be proved
without using extensionality information (as from a definition)
it has to be proved in the same way twice!  See if I can twiddle
the settings on the equals right rule or introduce a definition
expansion tool?

*)

(*

Stewart suggests a toggle to display:  show all parentheses.

The GUI will need markers for beginning and end of sequents, markers
to recognize messages (and perhaps different kinds of messages -- urgent
versus routine).

I need to do frequency analysis on commands!  Prepare a baby command reference
with the most frequently used commands (and a separate category of theory
setup commands).

*)

(*

April 10:

Tests indicate that demo mode works nicely.  Demo mode (though it will
display the command after its effect, sadly) should be installed in
marcelsequent so that I can examine Joanna's proofs.

Tests indicate that the working directory stuff works.  Demo mode is needed
next, both for presentations and for evaluation of student work.

startdemo() starts demo mode and stopdemo() stops it.

Try it!  It steps through the file, displaying the commands which
are executed (using an adaptation of the method of posting commands
to log files).

You cannot be in demo and log mode at the same time.

Some commands post line numbers in demo mode; this might be an error
to be fixed or else I might cause demo mode to post line numbers with
every command as in log files.  Ignore this for now.

Installing demo mode in the old prover will be harder.

April 9:

I have created the ability to work in subdirectories of the directory
where mosml is run.  SetDir "name" makes the directory "name" the default
directory.  New commands runtext and runscript will run .txt or .mlg
files (as "use") but in the working directory.  SetDir "" will return
to the top directory.  All file operations (loading and saving theory
files, saving scripts, etc) are carried out to/from the working directory.
This should allow me to organize my workspace more sensibly and may
have similar value for others.  This command will not (or at least I don't
think it will) create a directory that does not already exist.

I should either finish or remove the bounded types update.  My inclination
is to do the latter.

On reflection, I think that I will leave the usage of : in its present
restricted state, at least for the moment.

I should do a couple of file-related things (that is what I am logging
in to work on).  I should add a "working directory" command so that I
can organize student files rationally in subdirectories.  I should
install demo mode, for both students to use in presentations and to
facilitate my evaluation of student proofs.

from below, history logs and saved theories should record bookmarks.  This
will enhance index stability.

*)

(* March 9:

Installed sensible behavior for restricted set notation with the head binder
a restricted single bound variable.  The old behavior was sound but weird.

*)

(*

Feb 23: trying to install 2-stratification option.  This is partially
installed (no user command has been created).  I have installed a
value TYPEBOUND which contains 0 if there are no type restrictions and
n>0 iff we are to restrict to n types.  When there is a positive
(!TYPEBOUND), the prover checks for type assignments which create too
great a range of types (if everything actually works...).  This is in
the assigntype command.  The user command for 2-stratification would
then set TYPEBOUND to 2.  3-stratification is also interesting.  I
think that this installation still will not quite work: the problem of
ranges of types of quantified variables in defined notions needs to be
addressed?

*)

(*

Feb 16 again:

The remaining "logical" variations are actually variations of set
theory.  They will require much more serious surgery to the logic
functions leftlists and rightlists.

I think I have installed the constructive logic update too.

Constructive()

turns it on; it should not be turned off?  I probably do not
have the correct constructive rules for xor.

Again, the basic fix is extremely simple.  Before a logic rule is
applied, all conclusions after the first are discarded.  But note that
this is not done to the output, which may have multiple conclusions;
this gives the user a chance to use structural rules to move a favorite
conclusion to the front.  Any logical rule that moves material from
premises to conclusion has the original form of the expression on the
left preserved in constructive mode.  I do not have the correct
constructive rules for xor (whatever they might be); I am ignoring this.

There is something to be said about why constructive logic has really
been captured.

Having installed the one-conclusion variant, it is tempting to go
ahead and install constructive logic, which is in some ways similar,
though not exactly.  It does also involve limiting the number of
conclusions to one, but the truncation is carried out quite
differently.

We truncate the conclusion list to its first element before applying
logical rules (but not after; a result with two conclusions will be
displayed, so that structural rules can be used to bring the desired
element to the front).  Also, we preserve implications and negations
on the left so that they can be reused appropriately.

The simple one-conclusion transformation is actually not constructively
valid, and the truncation occurs at a different point in the handling
of rule applications.

Feb. 16:  now preparing to design and install the one-conclusion
variant.

One conclusion mode is installed.

It can be turned on with

OneConclusion()

and turned off with

ManyConclusions()

It makes a serious difference in prover behavior!  Yet the difference
is more apparent than real, which is clear because the implementation
is extremely simple.

There is a potential for bad interactions with scripts if you run a script
in a mode other than the one it was prepared in.  Starting a script with
a OneConclusion or ManyConclusions command avoids this problem.  This command
is logged, so there is no problem with subsequent changes of mode (nor
is there any reason not to change back and forth between modes).

There is no need to change any prover commands; just be aware that all
conclusions after the first are negated and turned into assumptions after
any command is applied (which has a serious effect on the feel of some
rules, mind!)  Negative assumptions are swapped with the conclusion
by l() (or Gl n) (this is the normal action of left negation followed
by the one conclusion transformation).

Is there any possibility that some rules (set rules come to mind) have
weird orders which ought to be changed in the light of one-conclusion
mode?

*)

(*

Feb. 5:  

Review of major updates needed or considered:

   function variables (with infix variant):  this needs to be first
   because it is the last to introduce a change in the basic data structures.
   [which is also a reason not to do it, of course].

   Substitution for predicate (and function) variables, so that these
   are some use.  Some matching for predicate and function variables; probably
   nothing too strenuous.  Let predicate variables match defined operators
   of the same arity and perhaps also match set relations of same arity.

   Function application notation.  Infix notation for set relations
   and binary functions.  Braces for complex infixes?  Might be a stretch.
   These are parser upgrades.

   Implementation of beta reduction.  Could this be handled by usetermdef?
   This gives a true treatment of functions.

   Definition of user-defined binders.

   Generalized use of restriction operator inside binding expressions.

   Installation of single-conclusion and constructive logic variants.  Also
   standard set/class theory variant.  Kisielewicz and positive variants are
   now also straightforward.

   Script security:  installing bookmarks in script language (and history,
   saved proofs) will help.  Witness macros will also help.  Self-checking
   scripts are also a good idea and perhaps easier.

   Do I want to try automated stratification of predicate variables?  Or
   leave them fully formal?  or have some stratified (or -able) 
   and some formal?

marcelsequent now has corresponding update:  this appears to work, at any
rate it runs Joanna's lemma file *really fast*.

This version now has "unknown indexing":  each unknown variable is
associated with the line number at which it is introduced and a rewrite
of that unknown variable acts only on the part of the proof above that
line number.  Notice that it is possible to introduce instances of unknown
variables which will (harmlessly) not be rewritten, because they are
in effect irrelevant constants in the wrong part of the proof.

it should be noted that marcelsequent appeared to avoic this problem but
in a different way:  it checked all terms for presence of unknown variables
before attempting rewrites.  This would probably work here, too.

To help Joanna, I also have to make it so that marcelsequent records
such line numbers, though it does not need to use them.  This should mean
that large proofs generated with this prover should run faster...

I need to do something to speed up global rewrites.  The obvious
idea is to associate with each unknown variable the position in the proof
tree at which it is introduced (since it will occur only above that point)
and reconfigure globalrewrite to act only on that part of the proof.  The
positions of unknown variables need to be remembered by history, saved
proofs.  They will be automatically handled by proof logging.

*)

(* Feb 2:

I think the obvious time leak in the performance of the corrected script
has to do with global rewrites on a very large proof.  A quick fix:  set
things up so that only parts of the proof where the unknown variable
can appear are rewritten:  to do this, index the line numbers at which
unknown variables are created and rewrite only the part of the proof
with at least that high a line number (easy) or the part of the proof
above that line number (a little harder).  The index of unknown variables
will need to be known to the history function and saved in saved theories.

*)

(*

Feb. 1:

A really embarrassing bug in saved theories:  I confused the proposition
serial numbers and proof serial numbers, and as a result the proof serial
numbers were not properly updated at all!

I should update getproofbynumber so that it reports if the proof is not
found at all (actually it should -- I think that was a time leak).

Jan 25:  

New command CutLemma P is used to start the proof of a lemma P;
it first proves the lemma P (without any information from the current
context) then resumes the current proof with P as a hypothesis.
If one is going to prove this lemma as a theorem
one should immediately bookmark it!

Bookmarks, described below are a solution to this problem.  Warning:
bookmarks are not currently handled by either the history feature
(b, undo) or by savetheory/loadtheory.  All bookmarks are cleared when
Start or StartSequent is run.  Logs do not currently include
bookmarks either, as the commands that use bookmarks are not logged
(ProveMarked is recorded as StartSequent with appropriate line number).

History, logs and savetheory probably should record bookmarks;
for one thing, this facilitates an index-free approach to proofs
which will make logs more secure.  This is a little more work.

working on facilitating proofs of lemmas during a large proof,
since I'm not set up to store proofs on desktop.

or alternatively could we have a stack of proofs?  This isn't too
hard, but it would complicate theory saving.  With a stack I could
just let counters and the "current" list persist? No, went with the
embedded proof approach.

This version identifies goals in proof display.  Look() now displays
line numbers.

New command

bookmark "name";

indexes the current sequent with the name "name"

ShowMarked "name" will show the part of the proof at and above
that name.

ProveMarked "name" will prove the sequent named "name".

restored abbreviation d for Done

added abbreviation sg for SwapGoals

*)

(*

Jan 23:  now saves all proofs in script format.  The savetheory command
now creates four files, with extensions .thy1, .thy2, .thy3 and .psc
The first contains basic parser information, the second the definitions
in giant term format, the third some information about the local proof
in giant term format, and the fourth is a script which rebuilds the theorem
list and the current proof.

The proof display for loaded proofs will give theorem reference errors
for axioms:  this is due to a difference in the way the new prover and
old prover represent axioms, and can be fixed, but is not urgent as far
as I can see.

*)

(*  

I now have unprincipled theory saving and loading which works on
Joanna's current theory but cannot be relied on.  The change which
needs to be made is that the theorems list needs to be saved using
scripts just as the current proof is; the other stuff can be left in
the large terms created by the existing commands, because there is no
reason to expect them to grow _too_ large: the problem is the sheer
size of _proofs_.  I now have a function which produces scripts (use
files) which rebuild proofs.  It might be possible to make these
faster by evading the interpreter (writing my own parser for these
files).  For the moment I do not know how fast or slow they will be in
the end; that has to wait for correction of theorem list saving.
Joanna's file only saves because none of the theorems she has actually
prcved have huge proofs (or maybe autoprune cuts down the size a lot?)

*)

(* Jan 21:

I need to work on incremental theory saving and loading before addressing
any of this.

a cluster of thoughts about standard notation for relations and about
predicate variables.  Nothing implemented yet.

Standard notation x R y for relations exists but in unstratifiable form.

Two ideas about this:

allow atomic object terms to be used as infixes.  x1 x2 x3 would mean
[x1,x3] E x2.  This could be almost entirely a display and parser
issue (but also a special case of matching).

Even numbered predicate variables could be made stratifiable (flat,
with all arguments of the same type).  This removes the necessity for
special declarations.

Predicate variable expressions should have matching installed:
predicate variables should match other predicate variables of the same
stratifiability class, prefix operators of compatible stratifiability
class, and perhaps sets (following the notation above but not
exclusively for that case).  Global substitution for predicate
variables (including sets/classes) needs to be supported.

*)

(*

philosophical note: something should be made of the fact that our
substitution functions make no use of the traditional notion of free
occurrence of a bound variable, but it is necessary for matching and
certain rule applications to use this notion to handle complex binders
correctly.  The documentation needs to discuss the actual variable
binding conventions of this notation (since they are not quite
standard).

there have been a lot of upgrades to the code recently which were
invisible to the user but amounted to removing hacks.  These in some
cases led to the discovery of bugs...  More systematic testing is
needed, which should be supported by an adequate set of diagnostic
display commands.

Should one be permitted to declare unstratified primitive operations?
Or "opaque" operators as in Watson?

*)

(*

Jan 19:  

reinstall the "Warning: proof not completed" message (?)

Think about incremental theory saving and loading.  I need to do incremental
save from marcelsequent, which is perhaps a bit tricky.

showmatches() and showtypes() show you the current matches and the current
types assigned for stratification, respectively.  This should make testing
easier.

proof lines are now sorted.

The next upgrades to make are sorted numbering of lines in displayed
proofs (for tidiness) DONE and self-checking of scripts for index shifts.
This should include the free variable counter at appropriate points
(before l or r?) and the new line counter before theorems are proved.
There should be a toggle between safe scripts and unsafe (but readable)
scripts, probably.  Of course a safe script can be digested into an unsafe
script easily.

Perhaps the set equality rules should be refined to eliminate the
introduction of a new universal quantifier?  This is the only place
this happens.  I should do this promptly if I'm going to do it because
of course it will break scripts.

Make nice diagnostic display commands for matches and stratification.  A
command to display all numerical precedences would also be nice.

made sure that all bound variables are diversified in sequentmatch.
Otherwise matching to sequents with lots of bound variables in them would fail
unpredictably.

if some predicate (and in future function) variables are to have type
declarations, they should be declared as part of the theory
environment.  If automatic stratification of sets with predicate
variables is to occur, it should be accompanied by automatic
declaration.  As in Watson, the option of blocking any declaration (by
making the type list nil?) should be available.

The extensions of the parser that I envision (function application
f[x] and f[x,y] and the function and infix variables) should be made
soonest.  The parser at least is stable and should be brought to a
final state.

bugs in stratification were partly caused by the exceptional status of
pairs.  They were accidentally not recognized as object terms.
Curious features of the parser module like this may cause other
problems.  An obvious weakness of the code (though very useful in
parsing) is the dichotomy between Infix(T,s,U) and Prefix(s,[T,U]).
If I had the stomach for it, defining the former as a function and
eliminating it as a constructor is probably a good idea.

*)

(*

Jan 18:

I should introduce a true freeboundvarlist and use it instead of 
diversify2.  I admit it:  the usual concept of freeness is actually
important when considering heads of binder expressions.  This should
greatly reduce the hack level in the code.DONE

debugged stratification function:  despite appearances it was not working
correctly.

Typing of Kpair in settheory.txt is wrong...figure out why.FIXED

eliminate diversify2 in terms of genuine free variable list.DONE

Put in a function diversify2 to eliminate the hack I was using to
avoid bad interactions between bound variables in heads of binding
terms and variables in the bodies of the terms.  Found and fixed a
typo in the check avoiding variable capture in match.SUPERSEDED

found a bug in topmatch -- I'm not sure it's operative in the prover
but it was rather mystifying in a test environment.FIXED

*)

(*

Jan 17:  

Next modification might be to sort line numbers as part of autoprune.
Do this before there are too many possibly breakable proofs.DONE

You MUST run some sensible tests of the matching function.

I should write a sensible function implementing the idea "diversify
all bound variables in T so as to avoid all bound variables in U,
leaving bound variables free in T alone."  Even if I use the hack, I
should just put it in one place.SUPERSEDED by freeboundvarlist

Another version posted:  WARNING this version fixes free variable index leaks
so it will break some proofs.

Note old idea: have getnewfree, getnewbound, getnewunknown post
commands to log files which will fix the indices to what is expected
if this does not lower the indices, and report an error otherwise.
This would be easy to implement and would remove a lot of the problems
with version changes.  It would on the other hand make log files
impossible to read...it could be controlled by a toggle (safelogging
vs. readable logging).  New variables are introduced by certain commands;
maybe those commands should have variants with arguments the expected
values of the counters?  Maybe only l() and r() would need extra arguments
for checking the counters?  The line counter in proofs should also be checked
constantly (also by l and r).

Nathan notes specifically that this version is much faster (when it
runs scripts).  I should actually check that lemmas are referenced
correctly when more than one theorem of the same name is proved.

Before doing any major new installations I need to read through this
and make sure everything is principled.  Writing the relevant sections
of the documentation giving formal criteria for substitution,
alpha-equivalence, matching, and unification would be useful.

matching needs a refinement to avoid variable capture.INSTALLED
(and reinstalled later in the day).

It would be useful if Done also recognized reflexivity of equality (I
find myself wanting to hit Done in this case).

swapgoals should rotate the target list of goals, since it might have
more than two elements.DONE

Swapgoals should be extremely useful for situations where you want the
right goal to do a match which sets an unknown variable just introduced.

Note that swapgoals can be used now after ThmCut as well.

*)

(* Jan. 16:

Shortened file by removing superseded material in comments.

set theory file logged in settheory.mlg -- almost up to transitivity
of equinumerousness.  rf is indeed very useful.  settheory.txt is now
a version of this settheory.mlg.

matching is systematically guarded against matching any free or unknown
variable or projection of such a variable with any term with a bound variable
free in it.

savetheory now saves and loadtheory loads the entire state of the
prover, including the current proof (not history!)  I need to make the
same upgrade to marcelsequent so that Joanna can transfer all her
work.

precedence commands should check that arguments are in same realm...

order of the day: the fancy pair matching in this version is certainly
wrong in various ways.  This doesn't directly affect anyone but me
yet, but should be corrected.  I need to compare with the old version
then think about how this changes with the different treatment of
bound variables here.FIXED I think

On the plus side, the fancy binder stuff does seem to work just fine,
though I should run specific tests to be absolutely sure.

I have a fancy pair matching solution set up, but it needs to be tested.
This is something which I expect to be buggy from my experience with the
old prover.  The compatibility checking component (pairmatch0) does not
catch all legitimate matches; it will cough and die on attempts at really
deep projection matching, most likely.  I think that the problems
guarded against will very seldom arise when a match is actually possible;
so though in theory the pair checking is rather conservative in practice
it should be dead on.  It IS needed though to guard against some obviously
bad matches.  There still may be unanticipated problems though:  this
is quite complicated.

*)

(* Jan 15:

rewritefree is NOT an application of globalrewrite!  It is now
installed.  It should have correct genealogy (which I'm not sure the
old version did) and it will not act if it does not eliminate the variable
(the old version was not guarded in this way).
(except that using rf on a trivial equation on the left will eliminate
that equation).  I should redo the last proof in the settheory.txt
file and see if rf helps make it more efficient.  It should; the problem
there is exactly that a lot of names are introduced for the same few
objects.

note that expandlist1, expandlist2 are temporarily disabled.  Also depair
has been weakened in its effect.REENABLED

new bug I don't understand yet, something to do with pairs which comes
up in complex set examples.  Mostly complex binders are working quite
well.  It's a counter update problem:  the same expression works correctly
when it is entered directly.SOLVED -- very odd bug.  The problem had
to do with the effects of top level substitution on terms with free
bound variables (used in setting up applications of rules to complex
binder expressions); the commands which lower bound variable indices were
messing these up.

rewritefree would have been very handy in one of the latest proofs.

Fixed error in right rule for equations of pairs.

working on set theory examples:  there are definitely bugs to shake down.

negation was left out of stratification function!  Fixed.

Serious problem with bound variable counter and rules for
set equality; fixed but will lead to bound variable index leak.
This bug appears to be fixed and in examples I've done so far the index
didn't blow up--we can always hope.  Always remember that index
leak is an esthetic not a logical problem.

*)

(*

Jan 14:

I made the matching function transparent to definitions -- I hope.  It will
expand definitions on both sides in order to find a match.

corrected an error in the matching function (affecting binder terms).
Broke down and used the notion of freeness again...The match function
now allows bound variables to match other bound variables --
bijectively -- and checks at the end whether anything other than a
bound variable matches anything with free bound variables in it.
Quite standard.  The alpha-equality procedure already uses bijective
relation between bound variables.  Both matching and alpha-equality,
when applied at the top level are applied to completely diversified
terms (diversify by doing a dummy substitution so that all bound
variables become distinct).  Further work on this was needed -- in Jan
17 upgrade.  The problem is that in the parsing of binder terms it is
not sufficient for terms to be closed in the normal sense: they cannot
contain any occurrence of the variables free in the head of the binder
expression, because such variables are actually free in the body of
the binder expression even if they appear formally to be bound.

Removed external instances of updatebound: the value of BOUND should
now always be 0 at the top level (when substitutions and rewrites are
not actually in progress).  They remain in comments in case this is a
goof...And indeed it did _not_ work.  I don't understand why
not...(and I should investigate in due course).

Now expands definitions in theorems to attempt matches.  This required
movement of considerable blocks of text as it makes matching depend on
the definition facility.  It does not expand target terms in attempts
to apply theorems, yet.  The reason I do this is that the aggressive
expansion of definitions by the prover functions may make it difficult
ever to directly apply theorems with defined terms in them, otherwise.

Install check for free bound variables in parseerror.DONE

It is now illegal to have bound variables (x1,x2,x3...) in contexts
where they are not actually bound, except in definitions.  The reason for this
has to do with the complex binders:  substitution of expressions with free
bound variables into complex binders can change the meaning of the term.
{x1 + U1|x1 E Nat} and {x1 + x2|x1 E Nat} do not have the same meaning.

Log file kpairfun3.mlg logs some simple set theory proofs (half way to
basic kpair result).  I noticed a potential problem with applying theorems
involving definitions because of our aggressive approach to evaluating 
definitions.  This might suggest that expansion of definitions could have
a place as a matching strategy.

there is a logical flaw: it really is necessary to enforce no "free
bound variables".  Otherwise bad substitutions can be made into
complex binders.  Or perhaps free "bound variables" can be recognized
and not rewritten.

Now I got variable compacting to work or so it seems.
A further refinement is that the renaming of bound variables does
not need to be composed with the substitution in progress; one concatenates
lists (adding more substitutions) instead.

Somehow I have broken rewriting into complex binding expressions.
webmarcel.sml contains the web version, in which rewrite does work.

In what should be a purely internal change relative to anything done
so far, I have turned subslist into a genuine simultaneous
substitution and defined subsvar in terms of subslist.  This will
cause the prover to behave correctly in certain complicated situations
involving complex binders.

Now I should be able to use simultaneous substitution to control bound
variable index creep.

two things to do, then I syllabize.

1.  Sound technique of crushing large bound indices:  take all the indices
above (!BOUND) and make them consecutive.

2.  this can be implemented easily when I have a correct subslist.  In
situations where special effects on binders are not an issue, the current
subslist is all right, but it does not do correct simultaneous substitution
where binders are concerned, because all the other variables in a binder get
renamed after a single substitution.

*)

(* 

Jan 11: 

There are significant gains though.  Rewriting into bound variable
expressions is fixed and I think the new idea for handling complex
binders should work fine.  The basic idea for reducing bound variables
that will be sound is obvious: smash down all the bound variables
above the current value of the bound counter so that that their order
is preserved but there are no gaps between them.  A real simultaneous
substitution function is needed: the current form of subslist doesn't
work because the first substitution renames any bound variables in
head binders that actually should be rewritten by later substitutions.

This takes the conservative view about variable binding again.  On
reflection I don't believe that my earlier liberal strategy works in all
cases.  Further, I don't think that subslist is a correct simultaneous
substitution for certain sophisticated purposes related to complex
binders.  There is a correct strategy for controlling bound variable
indices, which I will implement shortly.

Fixed a horrible bug caused by the change in substitution -- 
texts of definitions also needed a bound variable update
once the automatic update of text substituted into was removed.  This one
was extremely hard to understand and had truly weird effects.

Perhaps I should allow : to appear in terms -- indicating additional
hypotheses.  Terms replacing Ui's cannot contain these conditions
(except in head binders)?  

I really need to do some proofs in set theory.  The Peano axiom exercise
would do it.  The Kuratowski pair exercise is a start.  Cantor's theorem?
In general, the machinery of binders needs to be tested extensively.

made subsvar and alpha mutually recursive so that depair can use
alpha-equivalence (and also installed alpha-equivalence without
unification). disabling unification needs a stack in case of nested
applications of depair (not that these seem terribly likely).  This mutual
recursion was present in the old prover for the same reason.

last fix is an adjustment to fix bound variable index leaks; different
top level functions need different reference cells to back up counters
that they restore when done.  A further tiny fix.  Why does a dummy rewrite
cause indices to go up by 2 rather than 1?  More fiddling might get
a completely elegant treatment but the current state is acceptable.

last fix is a very subtle adjustment of matching to unknown variables
which should avoid any problem with the feature of topalpha in question
in the course of matching:  matching to Un will always be replaced with
matching to the image of Un in USUBS if there is one.

In the way that the bound variable substitution fix worked, I see a
possible difficulty.  The prover does not allow Ui to be construed as
"equal" to something which has higher free index than it has.  This
is all very well, but the matching procedure does allow Ui to
tentatively match something containing (automatically generated)
unknown variables of higher index.  Is there going to be any situation
where a match of this kind fails unexpectedly because Ui is recognized
not to be "equal" to the thing with higher index before the problem is
rectified by other matches?  I actually expected the rewriting to
initially accept the bad matches then run into a circularity error.
In this case things work out better than expected, but I should check
out what might happen in matching situations.

an experimental fix to rewriting into bound variable contexts is
in place.  it does cause bound variable creep.

For the moment, all rewriting (with rwr and its relatives) into
contexts with bound variables is disabled; it does not work correctly.
The problem arises only when unknowns are being matched to variables
which are in fact bound.SEE ABOVE -- reenabled experimentally.

I need to check whether Joanna might have run into this bug.

is it permissible to drop the updatebound u in topsubsvar v t u?
The idea is that the "free" occurrences of bound variables in u have already
been handled by the check when the term was entered (in the initial sequent,
or in a cut, or in a global rewrite). 

I'm doing this experimentally.  It should let bound variable indices relax
a bit, but it may yet be too relaxed.  Does this mean that the occurrence check
in subsv is unnecessary to avoid variable creep -- or even ill-advised?

I disabled the occurrence check, leaving the code in a comment.  I think
this is a better solution to the problem of bound variable creep, and it is
more in keeping with the basic approach of the prover, which avoids any kind
of check for occurrences of bound variables by preemptive substitution.

*)

(*

Jan 10:

subsvar v t u has no effect on u unless the variable v actually occurs;
this avoids iterated increases in bound variable indices every time
a global rewrite occurs.  The same fix happened in the old version.
The dummy variable Free 0 still induces changes in all bound variables;
this is needed for technical reasons before rewrites and when certain
manipulations of complex binders are carried out.

fixed symmetry of basic right rule for equality.

I ought to think carefully about the order of the pair related and set
related right equality rules.

wish list (excerpted from below)

1.  A systematic check on conversions between Infix(T,s,U) and
Prefix(s,[T,U]).  These have caused various minor problems.

2.  What is needed now is that I drive the prover through some
extensive body of work to shake out the bugs.  The Peano axiom work is
probably best because it involves sets and pairs.  I could start with
Cantor's theorem...  I should also make sure that each line of the
logic commands gets tested (and check for things like best order of proof).
If the work involves lots of theorems and lemmas, the proof display will
get properly tested.

3.  I have started drafting a manual (or the body of the research
proposal?)  in localtexmf/marcelmanual.tex.  This will use
bussproof.sty which I have downloaded, along with the sample file
testbp2.tex and the documentation (a pdf file in localtexmf).

4.  Think about how reordering of propositions in theorems should be handled.
A reordered theorem seems to need to reference its own previous proof:
so axioms should reference the empty string, not themselves.  An axiom is
now recognized by its proof being a reference to ""; things which refer
to themselves are referring to an earlier version of themselves.

5.  Projection equality could be neatly executed with the help of
unknown variables...  But I'm not sure I want it automated.  it might
be useful...

6.  The new logic format should make it easier to set up deviant logics!
Constructive logic is certainly easy, and so are NF and INF.

Also straightforward:  the classical theory of sets and classes, extended
to ZFC by axioms (actually to Kelley-Morse because this is much easier to do).
Kisielewicz is now easy to implement and I should do it.  Positive
set theory should be easy as well.

  Notice that without even thinking about it I once again implemented
the strong criterion for identity between class abstracts which
ignores stratification...


8.  It should not be hard to extend stratification to attempt stratification
of predicate variables.  Unifying every typing of the arguments of Pn
with the typing of a dummy term (generated by displacing the types of
the previous dummy term) should do the trick.  This would be useful.


9.  Ultimately the restriction infix : should be supported in all
locations in heads of binders (they need to be in the head of the
smallest binder term they live in).  This is needed for a neat
implementation of ZFC rather than Zermelo.

10.  Longer term project: is it possible to extract the most general
possible result from a proof (replace chunks of term whose structure
is not used with variables, free or propositional?).  Even more
dramatic would be a higher-order version of this.  This would be a
really heavily souped-up version of autoprune.

11.  Introduce function application f[x] and f[x,y].  There's really no
obstruction.  Usetermdef could be expanded to work on
lambda-reductions (a sneaky way to incorporate beta reduction into the
logic).

12.  I should reinstall the sensible sorting of line numbers obtained in
marcelsequent.DONE

13.  note that depair requires strict equality.  Alpha could work but only
if matching to unknowns was disabled (which can be arranged as it was
in old prover).FIXED Jan 11

14.  Note that the solution for rewrite does mean that bound variable indices
will go up faster when rewrites into binder expressions happen.  Is there
a neater solution?  Think about it (not urgent). FIXED, I think.

15.  a function for minimizing bound variable indices would not be
hard to write and could be useful.  (it may be trivial, actually) DONE
(and was not trivial at all).

16.  add function variables Fi (with infix variation Ii for arity 2.).
Add matching for predicate and function variables with prefix terms in
the obvious way.  F1 with no arguments will not parse.

17.   and of course the old version has predicate variable matching.  In
this version we should at least add global substitution for general
predicate variables.  This hasn't been used so far by students but I
think it is about to come up.  I have to decide about automatic matching
for propositional variables and maybe for predicate variables.  A related
issue is stratification of predicate variables.

18.  the rewritefree command.  I'll add it when I feel the need.DONE

19.   witness macros.  A general macro procedure might be handy (display
level:  parse a token as a complex expression and display the complex
expression as the macro as well...)  Witness macros at least are part
of a program to avoid problems with index faults, so they will naturally
be installed.

20.  Idea of defining binders as operations on sets: binders of
propositions (Bx.P) are defined as operations on {x|P} while binders
of terms (Bx.T) are defined as operations on {<x,u>|u=T} where T is a
new variable.

21.  A long term issue: the Watson programmable rewriting is implementable
here.  (The quoted theorem name tokens needed for theory storage would
support this).  It has extra logical power since it would allow
rewriting of "equals" to "equals" inside binder expressions.

22.  For proofs, a command
which causes the proof of the sequent currently being proved to be
stored when it is completed; once again, this makes numbering
irrelevant, though it requires backtracking on the part of the user to
install proofs this way.

23.  A "check expected value" command for the index counters could be
served from inside commands like getnewfree() that get the items; they
could check against an expected value set by a command inserted in the
log and even correct it if there isn't a security problem.

24.  Throw in old prover handling of membership in unstratified abstracts
(without the tacky free variables).

end of wish list

Latest update causes free/unknown variable counter to be decremented
when the free or unknown variable with the largest index is eliminated
by a global rewrite.  This will change indices; I changed logs to use
w instead of su and solved the problems that arose.  The advantage is that
the counter does not escalate with repeated uses of ThmCut any more.

Theories can now be exported from marcelsequent, to all appearances.
This proved unexpectedly complex.

just ideas.

Ultimately the restriction infix : should be supported in all
locations in heads of binders (they need to be in the head of the
smallest binder term they live in).  This is needed for a neat
implementation of ZFC rather than Zermelo.

Set up global rewrite so that it decrements the free counter whenever
the highest free or unknown variable is rewritten.  This will control
unknown indices and automatically do the same when rewritefree is
introduced.  Notice serendipity:  fireusubs works automatically from the
highest variable!DONE

Set up the theory saving command for marcelsequent.  Make sure that
pairs are displayed with brackets.  It might be worth refitting marcellandau
one last time if it can be ported to the new prover thereby...THEORY SAVE DONE!

You need to talk to the logic teachers in the philosophy department
about this.  maybe bring someone in on thinking about the grant?  They
teach the subject formally!

Longer term project: is it possible to extract the most general
possible result from a proof (replace chunks of term whose structure
is not used with variables, free or propositional?).  Even more
dramatic would be a higher-order version of this.  This would be a
really heavily souped-up version of autoprune.

Introduce function application f[x] and f[x,y].  There's really no
obstruction.  Usetermdef could be expanded to work on
lambda-reductions (a sneaky way to incorporate beta reduction into the
logic).

Note that I have created a log file squarenonneg.mlg and theory files
squarenonneg.thy1 and squarenonneg.thy2 from which the current state
of privateguild.txt can be recovered neatly without examining the
cluttered file.

*)

(* Jan 9:  

I should study prooflog.mlg which contains the printed proof of
SQUARENONNEG, for two reasons: it should be checked over to make sure
that the printed proofs are working right (AutoPrune doing its
business, for example) and this specific proof tree was printed from a
theory session created using loadtheory from saved files.  test6.thy1
and test6.thy2 contain the theory files for that environment.

I should reinstall the sensible sorting of line numbers obtained in
marcelsequent.

This version now appears to have theory loading and saving.  The
command savetheory s creates files s.thy1 and s.thy2 which contain
information describing the theory.  The separation is required because
without the information in s.thy1 the file s.thy2 cannot be parsed
correctly.  loadtheory s loads the contents of the relevant theories.
Mod errors, all declaration lists and the complete theorem list
with saved proofs are loaded...  This feature is _highly_ sensitive to
any problems with parsing and display (this is why I definitely abandoned
the old pair notation; it was hard to get the displayed terms to parse
as what they were supposed to be).

The next task is to get marcelsequent to save files which loadtheory can
read!DONE

The version with the optimized parser is now the main version.  It remains
possible that there are new parser bugs...  The functions for theory
storage and retrieval are mostly constructed.

This is the version in which folding together of the parser will be tested.
The optimized parser appears both to be optimized and to actually work...

My theorem list saving procedure is complete, but the parser cannot
handle the resulting term.  Is this because of exponential blowup in complexity
caused by separation of preparse and restparse functions?  This might be worth
testing...FIXED

Abandoned the original notation <x,y> for pairs, even as an
alternative; it will be [x,y] only.  The problems with the parser
and attempting the use of the usual order infixes at the same time
were insuperable (or at least, overly involved for my taste).

note that depair requires strict equality.  Alpha could work but only
if matching to unknowns was disabled (which can be arranged as it was
in old prover).

preparing to write theory saving file.  Numerals are now automatically
understood to be declared constants and can no longer be declared or
defined; if you want 1+1=2 you need to introduce it as an axiom rather
than a definition.  (Eventually the prover will have built-in
arithmetic.)  Saved theories will contain arbitrary numerals, so all
must be recognized as declared constants.  Arbitrary strings enclosed
in double quotes are also now predeclared constants; these will be
theorem names.

preparing alternative version of rewrites with integer
list arguments -- nil = rewrite everywhere, otherwise rewrite listed 
occurrences.  Old code to be preserved in comment.

OK, I think this is the way to go.  The rewrite commands now take
integer lists as arguments: if the list is empty, everything is
rewritten, otherwise the listed positions are rewritten (with the
usual curious features of the way the positions are listed).

Fixing existing scripts is actually not too hard:

rewrite rwr ~1 everywhere to rwr nil rwl ~1 to rwl nil (this should
capture crwr and crwl as well) then rwr 1 to rwr [1] rwr 2 to rwr [2]
rwr 4 to rwr [3] and so on (and similarly for rwl).  It took me about
a minute to fix privateguild.txt with one crash when I missed an rwl 4.

 *)

(*  Jan 8:

Implemented =/= and <-
I'm not sure I have best rules for =/=?

I did enough of the set stuff to get a clear idea that it is set up
correctly.

when it says "Already shown" it should give proof number.DONE

found and corrected error in handling of defined concepts in leftlists.
This one would have been caught by ML in the old implementation :-(

This version runs everything needed for the proof of SQUARENONNEG
correctly; my privateguild.txt contains the translated proof.

declarations, stratification and parse error checking for conservative
use of : are in place:  all that remains is to write the rule.  The rules
are in place; fingers crossed.  A very small test worked...

Another fix to complex binders: bound variables in the binder could
cause trouble if they were coincidentally the same as bound variables
in the body of the binder expression, so diversify the bound variables
in the complex binder before substitution (not in the body, because
identifications between free occurrences of bound variables in the
binder and bound variables in binders in the body are significant).

diversification of t implemented as subsvar (Free 0) (Free 0) t.

Limited idea for restriction: binders of the form T:A at the top
level, and all other occurrences of : caught by parseerror; then add
new rules for this case.  This would probably be fine.

*)

(*

Jan 7:

A:B to denote A but express a side assumption that A E B; how is this
to be handled?

Note that the solution for rewrite does mean that bound variable indices
will go up faster when rewrites into binder expressions happen.  Is there
a neater solution?  Think about it (not urgent).

Note for the future that autoprune data makes it perhaps not too difficult
to develop a logged proof from a proof tree.

Under Jan 6, implemented one point:  all identifiers consisting of a single
letter followed by a numeral are now reserved (they cannot be declared or
defined; this namespace is reserved for classes of variables).

A dummy substitution is needed before rewrite to ensure that no bound
variables in binders are rewritten; this works.  Still avoiding the
requirement that bound variables be actually bound.  This is needed
because of the fact that unguarded substitition into complex binder
expressions actually can substitute into the binder, which is needed
for quantification purposes.

It is a continuing amusing feature of this software that the notion of
a variable being free in a term has no role.

a function for minimizing bound variable indices would not be hard to write
and could be useful.

*)

(*

Jan. 6:
This is all proposals:  not implemented yet.

 add function variables Fi (with infix variation Ii for arity
2.).  Add matching for predicate and function variables with prefix
terms in the obvious way.  F1 with no arguments will not parse.

Idea of reserving all single letters followed by numerals as potential
variables (and testing for this instead of parsability in declaration
and definition commands).

All of this goes along with automatic stratification, and will be
useful if Watson-style rewriting is implemented.

*)

(*

Jan 5.

matching in UseThm was _backward_!  Stupid mistakes...  Also matching
to unknowns was not handled correctly and should now be right.

corrected stupid mistake in matching to unknowns.  That's what
testing is for...

protected "showall"; guarded Axiom command from changing locked theorems.

At this point it should be easy to write a command reference.

added the current locked list and the length of the axiom list to the
history information.  Tightened up logging and added more synonyms for
user commands (usually guarding the non-user versions so they cannot
be invoked accidentally).

Having installed lemma locking, pl and pr, I regard this as the official
version of the prover.

What does this version lack that marcelsequent has?

0. and of course the old version has predicate variable matching.  In
this version we should at least add global substitution for general
predicate variables.  This hasn't been used so far by students but I
think it is about to come up.  I have to decide about automatic matching
for propositional variables and maybe for predicate variables.  A related
issue is stratification of predicate variables.

1.  the rewritefree command.  I'll add it when I feel the need.

2.  witness macros.  A general macro procedure might be handy (display
level:  parse a token as a complex expression and display the complex
expression as the macro as well...)  Witness macros at least are part
of a program to avoid problems with index faults, so they will naturally
be installed.

3.  storing proofs to the desktop and recovering them; the associated
mechanism of locking lemmas in use.  This is actually needed now: a
theorem used (which includes proved) in the proof of the current
theorem cannot soundly be renamed, as this would corrupt the meaning
of all references to that lemma in the proof when it is done.  Storing
proofs to desktop is not needed: one can introduce a theorem by cut
and use AutoPrune to extract the proof from the context.  But current
lemma locking is needed for soundness.

I implemented lemma locking.  I'm following the philosophy that lemmas can
be handled via cut; there will be only one current proof at any time.

A form of undo which does not erase theorems and declarations would be
useful too.

4.  Converse implication and xor.

5.  pl and pr.INSTALLED

The current lemma locking is essential.

Enforced the matching between bound variables in binders in alpha
being a bijection...

Note that in general the rewrite of the source has made it much easier
to understand the code and extend the program with new capabilities.

I have tested the installation of complex binders:  it appears
to work.  Give serious consideration to introduction of term x:A
which only has a referent if x E A.  The problem is the logic of
partial terms...

The semantics of binders here is interesting in itself: the bound
variables and expressions in binders generally do have reference -- to
the range of their possible values.  So substitution for bound
variables in binders does do something.  This semantics also suggests
that the x:A modification is sensible -- it is an obvious operation on
ranges.  Easiest seems to be the approach with : as a primitive
operator allowed in binders but not in other text, generating
additional hypotheses when rules are applied to binders.

Idea of defining binders as operations on sets: binders of
propositions (Bx.P) are defined as operations on {x|P} while binders
of terms (Bx.T) are defined as operations on {<x,u>|u=T} where T is a
new variable.

I have attempted installation of the rules for complex binders
(universal and existential quantifiers and sets).

forbade appearance of free variables in definitions.  It is formally
possible for bound variables to appear free in definitions, and maybe
I should exert myself to prevent this.  This could cause problems with
semantics of complex binders...no, it can't.  I'm leaving it alone;
one amusing aspect of this whole approach is that the usual notion of
whether a bound variable is "bound" or "free" has no role.

A long term issue: the Watson programmable rewriting is implementable
here.  (The quoted theorem name tokens needed for theory storage would
support this).  It has extra logical power since it would allow
rewriting of "equals" to "equals" inside binder expressions.

kept the set equality case on the left from eliminating the equation
completely.

I can really only settle questions about behavior of complex binders
by writing down their rules!

*)

(*

Jan 4: 

forbade appearance of free variables in definitions.

kept the set equality case on the left from eliminating the equation
completely.

complete fix, which may solve all the index problems...  It appears
to have done this.  It even helped AutoPrune...

fixed bug in logging; semi-fixed bug in rewrite...

found and fixed bug in undo (though this still needs to be checked further).

there is a bug in rewrite.

a longer term idea about fancy binding: we can get all desired effects
if we introduce a:A as a term construction, meaning a if a E A and
undefined otherwise, and allow it to be used only in binders.  I
believe that everything may work out quite naturally in this approach.
It may be possible to allow this construction to be used in general,
if additional condition is automatically introduced whenever anything
is proved about such a term.

Ideas to keep index faults from breaking log files: witness
commands which act on the latest value of the free counter rather than
on any explicit index.  For unknowns, this could be macro or actual
value assignment;for free variables just macro.  For proofs, a command
which causes the proof of the sequent currently being proved to be
stored when it is completed; once again, this makes numbering
irrelevant, though it requires backtracking on the part of the user to
install proofs this way.  These two (actually three) fixes would
actually eliminate all explicit appeals to the index counters if used
consistently.  This is now partially installed:  see the user Witness
command below.  

A "check expected value" command for the index counters could be
served from inside commands like getnewfree() that get the items; they
could check against an expected value set by a command inserted in the
log and even correct it if there isn't a security problem.

I think I have a general solution to the "order of goals" problem.
First, I have a doctrine: it is better to verify hypotheses of a
theorem before using it.  This means that the names of Cut and Cut2 in
the old prover are reversed.  Next, ThmCut2 is introduced, which puts
all the applications of the theorem in different cases before the
verification of the hypotheses (and I think the old prover had this as
the main and only version). Finally, all branching rules follow my
convention (this is only significant in the case of implication on the
left; it will also be required for converse implication when I install
it); executing SwapGoal immediately after execution of a branching
rule will interchange the order of the branches.  Note that the
convention is not always correct: sometimes it is better to complete
the proof using a lemma and then prove the lemma.  That's why there
are alternatives :-)

Installed ThmCut2 which is as ThmCut except that it uses the theorem
before verifying that the hypotheses apply.

Fixed errors and infelicities in the equality rules.  The left
rule now preserves a copy of the original equation (because with
rewriting it is actually strictly more powerful) and the right rule
(which had the error) is corrected (so that it has two branches) and 
also preserves the original equation in both branches.  This means
that inadvertantly applying the default rules to an equation is merely
annoying :-)

Saving theories as terms is important.

What is needed now is that I drive the prover through some
extensive body of work to shake out the bugs.  The Peano axiom work is
probably best because it involves sets and pairs.  I could start with
Cantor's theorem...  I should also make sure that each line of the
logic commands gets tested (and check for things like best order of proof).
If the work involves lots of theorems and lemmas, the proof display will
get properly tested.

new idea about theorem display -- lemmas in fancy proof display
should be identified not only by name but by numerical position in the
theorem list.IMPLEMENTED

This has two advantages:  the prefixes attached to line numbers do not grow
excessively long, and the shown lemmas function works correctly (otherwise
the same lemma might appear more than once if reached by different paths).

This new solution to display of "hidden lemmas" is much better than the old
one:  it involves no additional storage of copies of theorems at all!

I should fix whatever it is that is making the new version skip line numbers.

Still thinking about free variable index leak.

GetProof command was added.

*)

(*

Jan. 3:  

I still need to implement the replacement of a proved lemma in its
parent proof with a reference to itself.

RewriteFree should be implemented.

I am at the point where I ought to develop and log extensive examples
in set theory; the development of the axioms of Peano arithmetic would
be good because it puts sets and pairs all through their paces.

I have started drafting a manual (or the body of the research
proposal?)  in localtexmf/marcelmanual.tex.  This will use
bussproof.sty which I have downloaded, along with the sample file
testbp2.tex and the documentation (a pdf file in localtexmf).

Fancy display of theorems is now enabled.  Proofs are saved as text
by putting them into log files, for now (see the LogProof command).
Generating .prf files is an easy modification.

I do not know why sequent snapshots generated by errors in the log file
echo!

I also do not know why free variables seem to want to increment by
two.

Detected another horrible parser bug related to precedence...keep
watching for these!  The issue was in the prepend function:  I had
to check that the term on the left was actually of the same type
as the whole infix term.

Remaining immediately important tasks, as opposed to tidying up around
the edges and debugging (the first brings this prover to the same
visible level of function and the second allows stuff to be ported
forward from the old version):

1.  Enable the full proof display with proofs of all lemmas, and the
dot-separated notation for theorems hidden in the list.  DONE (but not
tested very much).

2.  Enable the storage of theorems as terms and the recovery of such
terms as theories.  This should be designed so that the storage procedure
can be executed under the old prover.

3.  Preparation of manual for the new prover.

4.  Preparation of grant proposal for use of this prover for
educational purposes.

Note that placing reportcommand at the beginning of execution of a user
command makes a demo mode possible:  we could have it display lines, pause,
then execute them.

Where is the leak in the free variable counter?

It looks as if excursions through Showall are accidentally inserted into
the log; but this is not a bad thing.  It makes logs long but also might
be valuable if there are problems caused by changes in sequent counter.

Found and fixed a nasty bug in operator precedence.

Make sure that left rules and the others also report errors if no
rule applies.DONE

Why does the prover "stutter"?  I reduced this somewhat.

The logging stuff compiles but has not yet been tested.  Incorporated USUBS
into prover state.  This allows one to back out of circularity errors.

I should write the theorem display function with display of lemmas
using the new style.DONE tho fine-tuning (line number tags) is possible.

Think about how reordering of propositions in theorems should be handled.
A reordered theorem seems to need to reference its own previous proof:
so axioms should reference the empty string, not themselves.  An axiom is
now recognized by its proof being a reference to ""; things which refer
to themselves are referring to an earlier version of themselves.

Various unfinished business to which I should attend:

Give Cutl and Cutr the alternative names Cut and Cut2 from the old
prover.  But in reverse: Cut is the preferred version, verify
hypothesis before using it.  DONE

Automate pair equality.  In all alternatives of equality, trap reflexivity
(this doesn't happen with sets right not).  DRAFTED; seems to work.

Projection equality could be neatly executed with the help of
unknown variables...  But I'm not sure I want it automated.  it might
be useful...

It should not be hard to extend stratification to attempt stratification
of predicate variables.  Unifying every typing of the arguments of Pn
with the typing of a dummy term (generated by displacing the types of
the previous dummy term) should do the trick.  This would be useful.

sequent matching should reset USUBS if it fails.DONE topalpha now does
the same.

In process of installing logging.

The pointless function as written does not work but indicates intent. FIXED
(I hope)

*)

(*

Jan 2 closing notes:

Mod the inevitable bugs, this is almost the entire prover.  The whole
logic is present.  The old-style witness commands should be
implemented in a safe way, and the new complex binders should be added
to the logic.  Note that function application in the form T[U] could
be allowed, and probably should be, and the logic of the lambda binder
(Lx.T) should be set up.

Look into the special functions of the old prover:  most of these
are incorporated into the master commands l() and r() in this version
(I need to check how well this works).  Notably the pair equality commands
are not found here, and they probably should just be incorporated into
l() and r();  I have not implemented RewriteFree() which is a handy tool.
PAIRS done...

The commands for deep reference in the theorem list (and the full fancy
display of theorems with all lemmas embedded) should be set up.DONE

I reiterate that now that we have rewriting for propositions we need
global rewriting and perhaps unknown-style matching for propositional
variables.  Global rewriting for predicate variables of higher arity
using class notation seems to be a good idea.STILL NEEDED

I have not worked on flexible display order; Bailey wanted that and I
should perhaps explore it. It should not be hard to arrange, either.
It should actually be simple to interchange two goals just created?SOLVED

I wanted to be able to reorder propositions in proved theorems.  This
should be straightforward:  note that this involves saving a new version
of the theorem, not replacing the old one.  The GetProof command is
probably wanted, though maybe not the other desktop commands.STILL NEEDED

The system of representation of theories as terms should be implemented
here, and the storage side of it at least should be set up to work in the
old prover as well so that proofs can be transferred.TOP PRIORITY

The log file system should be recreated, but with commands that actively
prevent log files from breaking.STILL NEEDED

There does seem to be a variable counter leak somewhere; this requires
attention.  Witness macros might be a good idea to reimplement here
(it is easy).

The new logic format should make it easier to set up deviant logics!
Constructive logic is certainly easy, and so are NF and INF.

Also straightforward:  the classical theory of sets and classes, extended
to ZFC by axioms (actually to Kelley-Morse because this is much easier to do).
Kisielewicz is now easy to implement and I should do it.  Positive
set theory should be easy as well.

Notice that without even thinking about it I once again implemented
the strong criterion for identity between class abstracts which
ignores stratification...

So, we are almost there -- mod debugging and importing existing work.  Then
the rewrite needs to be exploited correctly:  the manual needs to be written
and the grant proposal.

*)

(*

Still Jan 2 (barely):

The next item is perhaps full lemma display (with the devices taking renaming
into account).

Another point:  I enabled rewriting with biconditionals; this suggests
that global rewriting of propositional variables, and forcible matching
of these (in the style of unknown variables) should be supported?  Is this
sound?

History is on.  Moreover, it backs up through bad definitions, theorems
by shortening the lists!  History management is much easier here because
I put the backup in the basic commands that modify the state of the
proof and the declaration lists, not in the individual user commands.

Idea for logging:  log files should include commands which set indices
to needed values by force and stop execution if the value of the index
is being lowered.  This would make them much harder to break!

Use my idea from Cornell to handle renaming of theorems: just leave
theorems whose names are superseded in the list, and stipulate that in
the proof of a theorem a name has the reference it had when that
theorem was defined, readily determined from the list.  No need for
embedded structures at all!  The definitions in use at the time of a
proof are saved with the proof?  The dotted notation for theorems
might still be useful -- certainly could be used in displayed proofs.
It would be best only to use dotted prefixes if they are actually
required (if a change really occurred).

plan for denoting theories as terms:  one needs a simpler format to
handle declarations initially, because the parser won't work to read the
theorems until the declarations are complete.

Add the ability to read arbitary quoted strings "xxx xxx" as tokens
and parse them as constant terms.  Likewise all numerals should be
accepted as constant terms by the parser.

The arbitrary strings are needed to handle theorem names, which are
not constrained in their form in either version of the prover.

Now the definition lists can be handled as conjunctions of equations
and biconditionals, and proofs are readily represented as logical
constructions in a more or less natural way.  The nice thing about
this is that I don't need to write a special proof reader (even the
preamble of declarations is no problem: the change in the parser
status of strings and numerals means that parsable terms are easily
written to code the declarations).  Keywords used by proof coding do
not need special declarations:  they can also be strings.

Proof state at this time consists of 

BOUND, FREE, THEPROOF, TERMDEFS, PROPDEFS, and the length of the theorem list.
Precedence information is not really part of prover state.  The state
of the parser is not permitted to change (but note proposal below
for forgetting definitions).

Actually, the definition lists are stable and cannot be changed, since
they mutate the parser.  They can be shortened, but there's no reason to
do this.  Shortening the theorem list does make sense, since theorems
can be hidden by later theorems.

It would be permissible to forget a definition and expand all occurrences
of it everywhere in the corpus of knowledge (in all other definitions
and in all theorems); then the identifier would presumably also be
removed from the parser lists, and it would then be reasonable to regard
the definition lists as part of prover state.  Certainly definition lists
will be included in saved theory files and in printed proofs.

Note that I need commands to print out lists of definitions.

BOUND, FREE, THEPROOF, and the length of the theorem list (to
indicate the reference of theorems) is actually enough to completely
specify the state of the prover in any persisting calculation.
Firing USUBS should be a precondition for any storage of state.

When a theory is saved to a file, it will also need all the parser
files, the TERMDEFS and PROPDEFS files, and the full THEOREMS list.

*)

(*

Jan. 2, 2007:

cut and ThmCut are implemented.  Things seem to work.

Note that we can rewrite with biconditionals as well as with equations.

Wow!  I have the entire logic.  I have theorem saving and use in the
simplest form.

Next agenda items:

   ThmCut

   backup() [related issues of storing and retrieving proof states on desktop]

   log files:  think about automating absolute references.
   complex theorem storage, and all related issues of security for theorems
   and definitions.

   axioms INSTALLED

   
I made extensive mods to make prover fail to distinguish between infix
terms and prefix terms of arity 2.

rewrite rules installed but not tested.

witness macro command could be introduced at the tokenization level
as in the old prover?

This version now has all logical components except the rewrite rules
(for which I have adapted the framework) and the theorem machinery
(saving theorems, using them directly, and cutting with them).  There
is also no cut rule.

I should look at the question of the order in which branches are provided.
There should be a systematic way to do this.

I have a solution to the upgrade.  It seems pretty clear that the new
prover will NOT run old scripts.  What I should do is develop the
facility of saving theories: since the language of the old prover is a
subset of the language of the new and the proof data structure is the
same, it should be possible to write save features similar for both
and a restore feature that will build theories verified under the old
prover.  Theories could be saved as huge terms for example (no special
format needed for saved files then!)

Incidentally, I should think about the problem of reverse engineering
a script from a proof.  It should not be altogether impossible.

Also notice that the general framework for the logic can be adapted
perfectly well to the rewrite rules: we need versions of the master
function that act on the lead sequents at left and right (done() could
then be implemented in the framework!) and on the two lead sequents on
the left.

The general logical framework is a truly cool development, since it
makes all the genealogical stuff invisible...

*)

(*

Jan 1, 2007:

I disabled matching to bound variables; it seems to me that with the
conventions I've adopted about substitution into binders, matching
of bound variables becomes unsound.  Besides, it is already the
case that theorems with free bound variables are not really useful.

I did a huge amount of work today, but it needs to be organized
somehow.

With the unknown variables system in full swing, I really want
the NextGoal command...  It's implemented.

This is now a possibly brain damaged version of the entire logic.
Can witness reasonably be implemented as (r/l(); su (!FREE) <argument>?
I think it can, and this subsumes it neatly.

1.  make sure we have declaration checking.  All of that is handled by
the parser now!  DONE

2.  the free variable counter is getting incremented somewhat unexpectedly.
Keep an eye on this.  It definitely seems to be going up in twos; it used
to do this but I do not remember why.

3.  Finish adding the basic sequent rules, and install substitution
for unknown variables.  Related is NextGoal (tree traversal).  AutoPrune.
ALL INSTALLED.

4.  Rules for rearranging terms, in flavors for both views, and think
about extending these to theorem sequents as well.  IN USUAL FORM.

5.  Sequent matching, theorem proof and use are coming, but not until
the logic is on a firm footing.  ThmCut!  Rewriting!

6.  Do bear extensions in mind, just don't hare off after them now.

   a.  defined binders.

   b.  stratification which takes into account strongly cantorian
   sets (with the scin/scout features of Watson).

   c.  (near term) extending quantifier and set rules to cover complex
binders now possible.  longer term investigation of other binders.

   d.  restoration of class matching.

   e.  different flavors of set theory:  constructive, full NF are
   obvious.  Ordinary theory of sets and classes is easy and should
   be done.  Kisielewicz should now actually be reasonably straightforward!

7. Theorem storage to be modified so that everything is stored as high
up as possible.  Conversion of theories to and from terms so that
storage is facilitated (which will make communication possible between
this and the old prover).

8.  Do some investigation of reverse compatibility of this system.  Work on
forward compatibility:  logging with absolute cues is wanted.  Ways to insert
absolute cues in log files; could we set things up so that re-running the
log will give it the information it needs to insert absolute labels so that
index changes cannot disconcert it?  Have the log file automatically generate
witness macros and use them?

   

Make sure that parser errors are captured.

Proof backup is now implemented and I have added more rules.  The handling
of unknown variables needs to be done very soon too.

There is a proof display function which generates a string suitable for
writing to a file as well.

I'm all the way up to being able to prove things, and in fact I have a
very nice abstract framework for writing most rules.

What can't I do?  There is no proof reporting:  I should write a proof
output function (at least preliminary).  There is no backup(); I should
set up representations of prover state (and a way to save past prover
states).  Of course there is no logging of the user commands that now
exist.  I should of course set up the rest of the prover commands
which fit into this framework (in fact, all of them do except
rewriting and superficially the witness rules).  Of course cut
doesnt fit in this framework either.  Of course the ability to prove
theorems and save them is crucial.

I think that proof reporting and backup are actually the top priority.

There is now some reasonable hope that the definition features are mostly
debugged...

It is time to go on to the logic!  Begin by defining the sequent type,
automatic rotation.  The sequent type will need to contain
genealogical information re the propositions in the sequents.  Should
I try using the theorem serial numbers as line numbers (at least as an
option?)

Tested definition facility and repaired it a bit; it is very complicated
and probably quite buggy.

Found a parser bug...  FIXED  iterated applications of functions
were not parsed correctly.

A draft of the definition facility is installed.  I did not use the
same commands as in the old version; I can perhaps implement them...
The new format allows definition of new binders, but we will leave that
for later.  The commands compile but have not been tested.

General solution to indexing problem:  commands whose reference
depend on indices should have logged forms that explicitly include
the index as an argument.  In particular, the witness commands
(and any command that creates new free or unknown variables), NameSequent
(for line numbers) and perhaps gl and gr (even in the dynamic
style they could be logged using absolute line numbers?); the commands
which create lines should also report their line numbers?

Notice that the stratification solution given here is easily upgraded
to handle the full stratification scheme of Watson with strongly cantorian
types and scin/scout information about operators.  This is not for immediate
execution, but is worth doing.

Definitions next?  Or sequents?

The stratification function works.  It is still dynamic but it is smarter
and certainly complete.  The implementation is of strong stratification,
but a substitution in advance diversifies the bound variables so that
in fact weak stratification is in effect obtained.

Note idea for economy in the embedding of lemmas in theorems: always
embed a lemma at as high a level as possible (so a lemma will be
embedded below a lemma that uses it only if the parent theorem also
uses a different lemma with the same name).  This modification can
probably be tested in the current version fairly easily; it should
considerably reduce duplication of lemmas?

The rewrite function is written.  A virtue of the unified approach is
that I get rewriting of propositions at the same time that I get
rewriting of terms.  This can be used to extend the rewriting functions
to apply to biconditionals as well as equations.

note idea of introducing Watson rewriting: mark terms by using
explicit parenthesis (manipulable using the usual navigation commands)
introduced into some proposition in the sequent.  The rewrite commands
are then pretty straightforward at the simplest level.  Parameters to
theorems (values for variables, matches in current sequent for
hypotheses) require thought but do not seem insuperable.

The match function is now compiled and tested (a little).

Note that things could be further elaborated by making the matching
implemented using ALPHAMATCHES (inside alpha-equivalence) pair-smart
as well.

Basic logic requires only alpha-equivalence and substitution; matching
is needed for the use of theorems.

Of course the logic of equality requires full rewrite function, so maybe
that had better come next.

also, the logic of sets requires stratification (or other tests and
restrictions).  Note that stratification depends on the declaration
and definition facility.

To begin the implementation of the basic logic requires the sequent data type.

A sequent will consist of four lists (?):  two lists of propositions (left
and right) and two lists of lists of integers (genealogies of propositions).
Or should I stick with the format in which a proposition is decorated with
a genealogy?

Should we consider alternative display in which the index of a proposition
is its unique serial number?  This might have considerable merit and we could
arrange to be able to toggle between the two different styles of display.

*)

(* Dec. 31

Installed automatic projection evaluation and surjective pair
simplification into subsvar.  It is important to notice that surjectivity
of the pair is part of the logic!

This file now contains a full draft of the match function, not compiled
or tested at all, and a test function for fireusubs.  The form of circularity
testing implemented is the same as in the old prover.  I _think_ that I
have greatly simplified the pair matching.  I probably still need to install
depair function in substitution.

I have not supported the infix notation for binary predicate variables.
I believe I have now installed it...  Yes, it appears to work.

The alpha-equivalence has been tested -- a little.

The next thing to construct is matching.  The big difficulty is class
matching.  This has been very little used so far in actual work with the
prover; I'm inclined to finesse it by allowing propositional variables
to match alpha-equivalent sentences and for the moment treating predicate
variables of higher arity as in effect constants.  The more complex
considerations of class matching can then be added later at my leisure.

Propositional variables should eventually match classes.  That may be
what is done in the current version; I haven't looked.  It will be easier
with the new substitution functions...

I did not install the depair fix in the substitution function; it will
probably eventually be needed.

The alpha-equivalence function is ready; it does still have strong
circularity checking (using freeindex).  It has not been tested yet, so
further disasters may await...

Substitution function is installed, including the conventions required
for complex terms in the binder part of the expression.  This does
mean that there is a difference in the behavior of terms under
substitution from the standard, if a bound variable expression appears
inside another with the same binding variable, the inner binder does
not have the expected meaning.  Substitution will never create terms
of this form.

The various variable counters are all present.

The substitution function I wrote today handles all substitutions for
variables.  I could add substitutions for pairs easily.  Probably I should.

*)

(* Dec. 29:

Later:  I just finished writing the parser, which appears to pass 
some obvious tests (along with the display function).

I just compiled it for the first time and tested the tokenizer, which
appears to work as desired.

The namespace is now larger: do we really want to allow multiletter
noncapitalized ids?  Overlap in namespace between binders and
prefix/infix operators is allowed, but should not be supported for
declarations.

The original notation for the pair can apparently be supported: the
parser conflict in the old version depended on the preparser stage.

However boring, the next item is display and parsing.  This requires
the precedence machinery.

The display function has been installed -- maybe.  It is much more compact
when object and proposition terms are unified.

Commented out is an option to negate predicate infixes by prefixing ~

Next mission is to write the parser.  Then it will be possible to test
parsing and display.

The parser and display functions have been written and initial tests
done.  The parser flags arity errors by adding an error object at beginning
of argument list.  the overloading with < did require an additional case.
the comma cannot be an infix operator; this breaks argument lists.  So
the new pair notation is not supported unless I make special provisions
(which are of course easy).  Display of triples in a way which suppresses
internal pair might be handy; it already reads <x1,x2,x3> as input.

I did not enable numerals this time but it is now easy to do so.  Specific
numerals can be declared as constants.

The next operations to be installed will be substitution and alpha equivalence.
For this we need to carefully consider how variable counters are to work.

*)

(* INTRO *)

(* So, first of all, what is this software?

It is a sequent based general purpose proof environment.  It is not in
intention an automatic prover, though some automation may be introduced.
It has a built in higher order logic, namely a sequent presentation of
the general first-order logic plus some set theory which can be selected
by the user, but whose default state is a version of NFU, Jensen's version
of Quine's New Foundations in which there are urelements.  This version
also has a built in type level ordered pair which makes it NFU + Infinity.

There will be support for constructive logic.  There will be support
for New Foundations proper (and for its constructive version).  There
will be support for a more usual theory of sets and classes which can
be extended by axioms to the standard set theory ZFC.  There may be
support for positive set theory (the strong theory of Olivier Esser).
There might be support for the double extension set theory of
Kisielewicz, just for fun.

There will be a sound capability to introduce primitive notions and
introduce defined notions.  There will be the capability of
introducing axioms.  The theory of equality will be supported by
rewriting capability; I hope to enhance this to introduce something
like the programmable rewriting of my older prover project, but that
is not guaranteed.

The data types and parsing in this version will be completely redesigned,
though it should be reverse compatible with the immediately preceding version.

Since the character ~ is specially reserved, it might be a good idea
to implement negated infix predicates.  NOTE:  the code to support this
is present but currently commented out.

*)

(* GUI mode stuff *)

val GUIMODE = ref false;

fun guimode() = GUIMODE:=true;

fun noguimode() = GUIMODE := false;

fun guistring s = if (!GUIMODE) then s else "";


(* ML UTILITIES *)

fun Flush() = TextIO.flushOut(TextIO.stdOut);
fun say s = (TextIO.output(TextIO.stdOut,"\n"^s^"\n");Flush());
fun pause() = (say "<hit enter>";TextIO.input(TextIO.stdIn);());

(* first pass at error announcing function: no proof log effects *)

val QUIET = ref false;

(* two colons to indicate the whole message is on same line *)

fun Say1 s = (say ((guistring "Marcel::  ")^s);pause());

fun All pred L = map pred L = map (fn x=>true) L;

fun Some pred L = map pred L <> map (fn x=> false) L;

fun None pred L = map pred L = map (fn x=>false) L;

fun p1(x,y) = x;

fun p2(x,y) = y;

fun max(m:int,n:int) = if m>n then m else n;

fun min(m:int,n:int) = if m<n then m else n;

fun maxlist nil = 0 |

maxlist (n::L) = max (n, (maxlist L));

(* list utilities *)

fun bubble1 nil = nil |

   bubble1 [x] = [x] |

   bubble1 ((m:int,x)::(n:int,y)::L) =

   if m<n then  ((m:int,x)::bubble1((n:int,y)::L))

   else ((n:int,y)::bubble1((m:int,x)::L));

fun bubble L = let val A = bubble1 L in 

if A=L then A else bubble A

end;

fun item n nil = nil |

item 1 (x::L) = [x] |

item n (x::L) = item (abs(n-1)) L;

fun drop s nil = nil |

   drop s ((t,u)::L) = if s = t then drop s L else (t,u)::(drop s L);

fun drop2 s nil = nil |

   drop2 s (t::L) = if s=t then drop2 s L else (t::(drop2 s L));

fun find x nil = nil |

find x ((y,z)::L) = if x=y then [z] else find x L;

fun foundin x nil = false |

foundin x (y::L) = x=y orelse foundin x L;

fun safefind default x L = if find x L = nil then default else hd(find x L);

fun add1 s L = s::(drop2 s L);

fun union nil L = L |

union L nil = L |

union (x::L) (y::M) = add1 x (add1 y (union L M)); 

fun unionlist nil = nil |

unionlist (x::L) = union x (unionlist L);

fun showlist viewer1 viewer2 nil = "\n\n" |

showlist viewer1 viewer2 ((x,y)::L) = (showlist viewer1 viewer2 L)^(viewer1 x)^": "^(viewer2 y)^"\n";

fun showpair viewer1 viewer2 (x,y) =

   "("^(viewer1 x)^" , "^(viewer2 y)^")";

(* directories *)

val DIR = ref "";

(* this might not work right in Linux; change to "/"? *)

fun dir "" s = s |

dir t s = t^"\\"^s;

fun setdir s = dir (!DIR) s;

fun SetDir s = DIR:=s;

fun runtext s = Meta.use(setdir(s^".txt"));

fun runscript s = Meta.use(setdir(s^".mlg"));


(* autologging stuff *)

val LOGFILE = ref (TextIO.openOut("default"));

val LOGFILENAME = ref("default");

val LOGGING = ref false;

val DEMO = ref false;

val LINENUMBER = ref 0;

fun Say s = if (not(!QUIET)) then (say (guistring "Marcel:");say s;
say (guistring"...");
if (!LOGGING) then (say ("In line number "^(makestring(!LINENUMBER)));TextIO.flushOut(!LOGFILE)) else ();pause()) else ();

fun quietly f x = (QUIET:=true; let val T = f(x) in (QUIET:=false;T) end);

fun stopdemo() = (TextIO.flushOut(TextIO.stdOut);DEMO:=false);

fun stoplogging() = if (!LOGGING) then (TextIO.flushOut(!LOGFILE);
TextIO.closeOut(!LOGFILE);LOGGING:=false;say ("Closed log file "^(!LOGFILENAME))) else say "You are not logging!";;


fun startlogging filename = if (!LOGGING)
    then say ("You are already logging using file "^(!LOGFILENAME))
    else (
    if (!DEMO) then stopdemo()else();
    LINENUMBER:=0;LOGGING:=true;LOGFILE:=
    (TextIO.openOut(setdir(filename^".mlg"))); 
LOGFILENAME:=filename^".mlg";
say ("Opened log file "^filename^".mlg"));

fun startdemo() = (if (!LOGGING) then stoplogging()else();
    LINENUMBER:=0;DEMO:=true);


fun nextline() = LINENUMBER:=(!LINENUMBER)+1;

fun writelogline s = if (!LOGGING)
     then TextIO.output((!LOGFILE),s)
     else if (!DEMO) then (TextIO.output(TextIO.stdOut,"\n\n"^s^"\n");
TextIO.flushOut(TextIO.stdOut);
if TextIO.input(TextIO.stdIn) = "q\n" then DEMO:=false else ();())
     else ();


(* command line items *)

datatype Item =

   Mnemonic of string |  (*name of command*)

   IntegerArg of int |  (* integer argument *)

   IntegerListArg of int list | (* list of integers *)

   StringArg of string |  (* string argument *)

   StringListArg of string list; 

fun removefirst s = if s = "" then "" else implode(tl(explode s));

(* functions for uniform display of command lines *)

fun itemdisplay (Mnemonic s) = s |

   itemdisplay (StringArg s) = "\""^s^"\"" |

   itemdisplay (IntegerArg n) = makestring n |

   itemdisplay (IntegerListArg nil) = "[]" |

   itemdisplay (IntegerListArg (n::L)) = "["^(makestring n)
                          ^(if L = nil then "" else ",")
                          ^(removefirst(itemdisplay(IntegerListArg L))) |

   itemdisplay (StringListArg nil) = "[]" |

   itemdisplay (StringListArg (s::L)) = "["^(itemdisplay(StringArg s))
                          ^(if L = nil then "" else ",")
                          ^(removefirst(itemdisplay(StringListArg L)));

fun linedisplay [Mnemonic m] = m^"(); " |

   linedisplay [x] = (itemdisplay x)^"; " |

   linedisplay (x::L) = (itemdisplay x)^" "^(linedisplay L) |

   linedisplay nil = "";

(* format for a user command to log itself:

if logging [increment the line number
writelogline (the command)[a return followed by the line number if Done
or UseThm(2)]]

*)

fun linenumber() = "(* "^(makestring(!LINENUMBER))^" *)  ";

fun nextlinenumber() = "(* "^(makestring(1+(!LINENUMBER)))^" *)  ";


(* ABSTRACT SYNTAX AND PARSING *)

(* all terms to be accepted by the parser fall into a limited class
of structures and support similar notions of substitution; try to unify
these structures *)

(* there are variables:  these are single letters followed by numerical
indices.  They include object variables, bound, free and unknown, and
propositional variables, which may take argument lists *)

(* there are atomic terms.  These may be objects (capitalized alphabetic
format) or propositions (capitalized alphabetic format), or numerals (new
in this implementation.  Different sorts of identifier are handled by
declaration lists. *)

(* there is one special unary operator:  negation (of propositions) *)

(* there are prefix operators which take argument lists:  some of
these are primitive and some defined; all are user declared.  The shape
of these is capitalized alphabetic (with the exception of propositional
variables noted above, and the special projection operators).  Maybe the
tokenizer should be modified to allow numerical suffixes on any identifier..
Special character identifiers may be input as prefix but are always of
arity 2 and displayed only in infix format.  All argument list gadgets
take arguments of type Object. *)

(* there are both alphabetic and special character identifiers for
arity 2 operations.  All arity 2 operators are displayed in infix
format and may be assigned precedence (incl left or right grouping) if
their output is of the same type as their input.  The arity 2 operators
always take two arguments of the same sort (Prop or Object) and output
something of the same or a different sort.

infixes are of type Connective (Prop x Prop -> Prop), Predicate 2
(Object x Object -> Prop) or Function 2 (Object x Object -> Object).
Things with other positive arities are typed either Predicate n or 
Function n (only Object argument lists are possible).  I suppose
Predicate 0 can be construed as propositional constant and Function 0
can be construed as object constant.

 *)

(* there are binders.  All binders bind objects.  In this version,
they may bind general terms.  Binder notation is mixfix: it will
involve a open parenthesis form, followed by an initial identifier
(declared as a binder: not appearing in all binder formats), followed
by a bound term or variable, followed by a separator, followed by a
closing parenthesis form.  The { is specific to sets; ( and [ should
be general purpose parentheses (will I preserve the distinction that
( is propositions and argument lists while [ is terms?) *)

(* have a single parser function which takes the type of the object
to be constructed (Prop or Object) as a parameter.  Have a single term
type with a type checker?  There should be no need for deep type checking:
the parser should not allow construction of a badly typed object. *)

(* TOKENIZER *)

(* tokens are of four kinds: open parenthesis forms, close parenthesis
forms, separators, and identifiers.  also negation.  Identifiers
consist of 0 or 1 capital letters, followed by some number (possibly
0) of lower case letters, following by some number (possibly 0) of
digits (total length 1 or greater), or of 1 or more special
characters.

open parenthesis forms:  ( [ { 

close parenthesis forms:  ) ] }

separators  . ,

*)

(*

when an id appears to start with 2 letters followed by a digit,
the initial letter is construed as an identifier by itself; this is needed
in a number of common contexts to resolve things correctly; examples:
(Ax1.x1=x1)  x1Ex2  a1Ea2  a1Ep2(x2) P1vP2  x1=x2vx3=x4

so two letter ids, if there are any, cannot have numerical subscripts.

Notice that variables will be extracted as tokens:  we will need
functions to extract their indices.

*)

fun iscap c = #"A" <= c andalso #"Z" >= c;
fun islower c = #"a" <= c andalso #"z" >= c;
fun isdigit c = #"0" <= c andalso c <= #"9";

fun isspecial c = #"!" = c orelse #"@" = c orelse #"#" = c  orelse #"$"
= c orelse #"^" = c orelse #"&" = c orelse #"*" = c orelse #"-" = c
orelse #"+" = c orelse #"=" = c orelse #":" = c orelse #";" = c orelse
#"<" = c orelse #">" = c orelse #"?" = c orelse #"/" = c orelse #"!" =
c (* orelse #"." = c orelse #"," = c orelse #"|" = c  orelse #"~" = c *)
orelse c = #"`";

fun isalpha c = iscap c orelse islower c;

fun get testfn nil = nil |

   get testfn (c::L) = if testfn c then (c::(get testfn L)) else nil;

fun rest testfn nil = nil |

   rest testfn (c::L) = if testfn c then rest testfn L else (c::L);

fun getid0 nil = nil |

   getid0 (c::(d::(e::M))) = if isalpha c andalso isalpha d andalso

   isdigit e then [c]

   else let val L = (d::(e::M)) in

      if iscap c 
      then c::((get islower L)@(get isdigit (rest islower L))) 

      else if islower c then (get islower (c::L))
                              @(get isdigit (rest islower (c::L)))

      else if isdigit c then get isdigit (c::L)

      else if isspecial c then get isspecial (c::L)

      else nil
   end |

   getid0 (c::L) = if iscap c 
      then c::((get islower L)@(get isdigit (rest islower L))) 

      else if islower c then (get islower (c::L))
                              @(get isdigit (rest islower (c::L)))

      else if isdigit c then get isdigit (c::L)

      else if isspecial c then get isspecial (c::L)

      else nil;

fun getid L = implode(getid0 L);

fun restid nil = nil |

     restid (c::(d::(e::M))) =

     if isalpha c andalso isalpha d andalso isdigit e then (d::(e::M))

     else let val L = (d::(e::M)) in

     if iscap c then rest isdigit(rest islower L)

     else if islower c then rest isdigit(rest islower (c::L))

     else if isdigit c then rest isdigit (c::L)

     else if isspecial c then rest isspecial (c::L)

     else c::L
     end |

     restid (c::L) = if iscap c then rest isdigit(rest islower L)

     else if islower c then rest isdigit(rest islower (c::L))

     else if isdigit c then rest isdigit (c::L)

     else if isspecial c then rest isspecial (c::L)

     else c::L;

fun trim s = if length(explode s) < 2 then s else

   implode(rev(tl(rev(tl(explode s)))));

fun quoting s = ("\"")^s^("\"");

fun getuntilquote nil = [#"\""] |

getuntilquote (#"\""::L) = [#"\""] |

getuntilquote (x::L) = x::(getuntilquote L);

fun restquote nil = nil |

restquote (#"\""::L) = L |

restquote (x::L) = restquote L;

fun isopener0 c = c= #"(" orelse c = #"[" orelse c = #"{";

fun isopener c = c="(" orelse c = "[" orelse c = "{";

fun iscloser0 c = c= #")" orelse c = #"]" orelse c = #"}";

fun iscloser c = c=")" orelse c = "]" orelse c = "}";

(* index extraction *)

fun isdigit c = #"0" <= c andalso c <= #"9";

fun numval c = if isdigit c then ord c - ord #"0" else ~1;

fun getindex0 nil = ~1 |

getindex0 [x] = numval x |

getindex0 (x::L) = if not(isdigit x) then getindex0 L

   else numval(hd(rev (x::L)))+ 10*(getindex0(rev(tl(rev (x::L)))));

fun getindex s = getindex0 (explode s);


fun tokenlist nil = nil |

tokenlist ((#" ")::L) = tokenlist L |

tokenlist ((#"\n")::L) = tokenlist L |

tokenlist (c::L) =

   if c = #"\"" then (implode(#"\""::(getuntilquote L)))::(tokenlist (restquote L)) else

   if isopener0 c orelse iscloser0 c orelse c= #"." orelse c= #","
   orelse c= #"|"
   orelse c= #"~" then (implode [c])::(tokenlist L) 

   else let val A = getid (c::L) in 

   if A = "" then (Say1 "Tokenization error";nil) (* parse error *)

   else A::(tokenlist (restid (c::L))) end;

fun Tokenlist s = tokenlist(explode s);

(* the parser will act on the output of tokenlist (a list of strings
rather than a list of characters) *)

(* BASIC PROVER DATA TYPES *)

(* unified type of proposition and object terms *)

(* using a unified type, we should be able to construct a unified
parser and unified substitution and matching functions *)

datatype Term = 

   (* bound object variable *)

   Bound of int |

   (* free object variable *)

   Free of int |

   (* unknown object variable (for unification) *)

   Unknown of int |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   PredVar of (int*(Term list)) |

   (* this term and its argument are propositions *)

   Negation of Term |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   Prefix of (string*(Term list)) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   Infix of (Term*string*Term) |

   Binder of (string*Term*Term) |

   (* internal fix for precedence computations and guarding
    simultaneous substitutions *)

   Parenthesis of Term |

   (* error terms *)

   ErrorProp | ErrorObject;

(* index reducing bound variable renaming function *)

fun rebind0 (L,(Bound n)) = if  find n L = nil

   then let val M = maxlist(map (fn (x,y)=>y) L) in ((n,1+M)::L,Bound(1+M)) end
   else (L,Bound(hd(find n L))) |

rebind0 (L,Free n) = (L,Free n) |

rebind0 (L,Unknown n) = (L,Unknown n) |

rebind0 (L,(PredVar (n,M))) = let val (L1,M1) = rebindlist (L,M)

in (L1,PredVar (n,M1)) end |

rebind0 (L,Negation T) = let val (L1,M1) = rebind0 (L,T)

in (L1,Negation M1) end |

rebind0 (L,(Prefix(s,M))) = let val (L1,M1) = rebindlist (L,M) in

(L1,(Prefix(s,M1))) end |

rebind0 (L,Infix(T,s,U)) = let val (L1,T1) = rebind0(L,T) in

let val (L2,U1) = rebind0 (L1,U) in

(L2,Infix(T1,s,U1)) end end |

rebind0 (L,Binder(s,T,U)) = 
let val (L1,T1) = rebind0(L,T) in

let val (L2,U1) = rebind0 (L1,U) in

(L2,Binder(s,T1,U1)) end end |

rebind0 t = t

and rebindlist (L,nil) = (L,nil) |

rebindlist (L,(t::M)) = 

   let val (L1,M1) = rebindlist (L,M) in

   let val (L2,t2) = rebind0 (L1,t) in

   (L2,(t2::M1)) end end;

   
(* fun rebind t =p2(rebind0(nil,t)); *)



(* function to remove all internal parentheses -- used by parser and
probably also in fancy projection matching *)

fun 

   (* bound object variable *)

   deparenthesize (Bound n)= Bound n |

   (* free object variable *)

   deparenthesize (Free n) = Free n |

   (* unknown object variable (for unification) *)

   deparenthesize (Unknown n) = Unknown n |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   deparenthesize (PredVar(n,L)) = PredVar(n,map deparenthesize L) |

   (* this term and its argument are propositions *)

   deparenthesize (Negation T) = Negation(deparenthesize T) |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   deparenthesize (Prefix(s,[T,U])) =

       Infix(deparenthesize T,s,deparenthesize U) |

   deparenthesize (Prefix(s,L)) =

      (Prefix(s,map deparenthesize L)) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   deparenthesize(Infix(T,s,U)) =

      (Infix(deparenthesize T,s,deparenthesize U)) |

   deparenthesize (Binder(s,T,U)) = Binder(s,deparenthesize T,deparenthesize U) |

   (* internal fix for precedence computations *)

   deparenthesize (Parenthesis T) = deparenthesize T |

   (* error terms *)

   deparenthesize ErrorProp = ErrorProp | 

   deparenthesize ErrorObject = ErrorObject

(* functions used by subsvar to automatically
simplify expressions involving pairing and projection *)

fun deproj(Prefix("p1",[Infix(T,",",U)])) = deproj T |

deproj(Prefix("p2",[Infix(T,",",U)])) = deproj U |

deproj T = T;

fun listminus (x::L) (y::M) =

   drop2 y (listminus (x::L) M) |

   listminus x nil = x |

   listminus nil x = nil;



fun boundvarlist 

   (* bound object variable *)

   (Bound n) = [Bound n] |

   (* free object variable *)

   boundvarlist (Free n) = nil |

   (* unknown object variable (for unification) *)

   boundvarlist (Unknown n) = nil |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   boundvarlist (PredVar (n,L)) = unionlist (map boundvarlist L) |

   (* this term and its argument are propositions *)

   boundvarlist (Negation t) = boundvarlist t |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   boundvarlist (Prefix(s,L)) = unionlist (map boundvarlist L) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   boundvarlist (Infix(T,s,U)) = union(boundvarlist T)(boundvarlist U) |

   boundvarlist (Binder(s,T,U)) = union(boundvarlist T)(boundvarlist U) |

   (* internal fix for precedence computations *)

   (* parenthesis is used to hide information in substitution and
   matching calculations *)

   boundvarlist (Parenthesis T) = nil |

   (* error terms *)

   boundvarlist ErrorProp = nil | boundvarlist ErrorObject = nil;

(* bound variables that occur free in the usual sense *)

fun freeboundvarlist 

   (* bound object variable *)

   (Bound n) = [Bound n] |

   (* free object variable *)

   freeboundvarlist (Free n) = nil |

   (* unknown object variable (for unification) *)

   freeboundvarlist (Unknown n) = nil |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   freeboundvarlist (PredVar (n,L)) = unionlist (map freeboundvarlist L) |

   (* this term and its argument are propositions *)

   freeboundvarlist (Negation t) = freeboundvarlist t |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   freeboundvarlist (Prefix(s,L)) = unionlist (map freeboundvarlist L) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   freeboundvarlist (Infix(T,s,U)) = union(freeboundvarlist T)(freeboundvarlist U) |

   freeboundvarlist (Binder(s,Infix(A,":",B),U)) =

   union(freeboundvarlist B)
   (listminus (freeboundvarlist U) (freeboundvarlist A)) |

   freeboundvarlist (Binder(s,T,U)) = 

   listminus (freeboundvarlist U) (freeboundvarlist T)

   |

   (* internal fix for precedence computations *)

   (* parenthesis is used to hide information in substitution and
   matching calculations *)

   freeboundvarlist (Parenthesis T) = nil |

   (* error terms *)

   freeboundvarlist ErrorProp = nil | freeboundvarlist ErrorObject = nil;

(* this function renames occurrences of bound variables
efficiently (to low indices) leaving bound variables which occur free
alone (these only occur in definitions) *)

fun rebind t = p2(rebind0 (map (fn (Bound x)=>(x,x))(freeboundvarlist t),t));

(* function to detect error subterms -- this recognizes parse errors *)

(* this function now also checks for free occurrences of bound variables *)

fun 

   (* bound object variable *)

   parseerror L L2 (Bound n)= if foundin (Bound n) L andalso
   not(foundin (Bound n) L2) then false
            else (Say "Free occurrence of bound variable found";true) |

   (* free object variable *)

   parseerror L L2 (Free n) = false |

   (* unknown object variable (for unification) *)

   parseerror L L2 (Unknown n) = false |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   parseerror M M2 (PredVar(n,L)) = 

   map (parseerror M M2) L <> map (fn x=>false) L

   |

   (* this term and its argument are propositions *)

   parseerror L L2 (Negation T) = parseerror L L2 T |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   parseerror L L2 (Prefix(s,[T,U])) = parseerror L L2 (Infix(T,s,U)) |

   parseerror M M2 (Prefix(s,L)) =

      map (parseerror M M2) L <> map (fn x=> false) L |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   parseerror M M2 (Infix(T,":",U)) = true |

   parseerror M M2 (Infix(T,s,U)) =

      parseerror M M2 T orelse parseerror M M2 U |

   parseerror L L2 (Binder(s,Infix(T,":",U),V)) =

      let val M = ((freeboundvarlist T)@L) in

      parseerror M L2 T orelse parseerror L L2 U 
           orelse parseerror M L2 V  end |


   parseerror L L2 (Binder(s,T,U)) = let val M = (freeboundvarlist T)@L in

    parseerror M L2 T orelse parseerror M L2 U end |

   (* internal fix for precedence computations *)

   parseerror L L2 (Parenthesis T) = true |

   (* error terms *)

   parseerror L L2 ErrorProp = true | 

   parseerror L L2 ErrorObject = true;

fun Parseerror t = parseerror nil nil t;


datatype TermType = Proposition | Object | TypeError;

(* a fourth kind of binder is theoretically possible:  are there
binders which bind object terms and output propositions? *)

(* the name spaces of operators and binders need to be disjoint because
E is present in both (with entirely different meaning) *)

datatype OperatorType = Connective | Predicate of int | Function of int | OTError;

datatype BinderType = Quantifier | SetBinder | FnBinder | BTError;

(* master list of types of operators *)

val OPERATORS = ref (nil:((string*OperatorType) list));

val BINDERS = ref (nil:((string*BinderType) list));

fun isprefixtype (Predicate n) = n<>2 |

   isprefixtype (Function n) = n<>2 |

   isprefixtype x = false;

fun isinfixtype Connective = true |

   isinfixtype (Predicate 2) = true |

   isinfixtype (Function 2) = true |

   isinfixtype x = false;

fun optype s = 

if (s<>"" andalso makestring(getindex s) = s) 
orelse hd (explode s) = #"\"" then Function 0 else

safefind OTError s (!OPERATORS);

fun btype s = safefind BTError s (!BINDERS);

(* functions to declare operators of a specific type *)

fun makeconnective s = if optype s = OTError

   then OPERATORS:=(s,Connective)::(!OPERATORS)

   else Say1 (s^" is already declared!");

val _ = makeconnective "&";

val _ = makeconnective "v";

val _ = makeconnective "->";

val _ = makeconnective "==";

val _ = makeconnective "<-";

val _ = makeconnective "=/=";

fun makepredicate n s = if optype s = OTError 

   then OPERATORS:=(s,Predicate n)::(!OPERATORS)

   else Say1 (s^" is already declared!");

val _ = makepredicate 2 "=";

val _ = makepredicate 2 "E";

fun makefunction n s = if optype s = OTError

   then OPERATORS:=(s,Function n)::(!OPERATORS)

   else Say1 (s^" is already declared!");

val _ = makefunction 1 "p1";

val _ = makefunction 1 "p2";

val _ = makefunction 2 ":";

val _ = makefunction 2 "`"

(* val _ = makefunction 2 ","; *)

fun makequantifier s = if find s (!BINDERS) = nil 

   then BINDERS:=(s,Quantifier)::(!BINDERS)

   else Say1 (s^" is already declared!");

val _ = makequantifier "A";

val _ = makequantifier "E";

fun makesetbinder s = if find s (!BINDERS) = nil 

   then BINDERS:=(s,SetBinder)::(!BINDERS)

   else Say1 (s^" is already declared!");

val _ = makesetbinder "";

fun makefnbinder s = if find s (!BINDERS) = nil 

   then BINDERS:=(s,FnBinder)::(!BINDERS)

   else Say1 (s^" is already declared!");

val _ = makefnbinder "L";

fun otype Connective = Proposition |

    otype (Predicate n) = Proposition |

    otype (Function n) = Object |

    otype OTError = TypeError;

fun  otypeb Quantifier = Proposition |

     otypeb SetBinder = Object |

    otypeb FnBinder = Object |

    otypeb BTError = TypeError;

fun Otype s = otype(optype s);

fun Otypeb s = otypeb(btype s);

fun itype Connective = Proposition |

   itype (Predicate n) = Object |

   itype (Function n) = Object |

   itype OTError = TypeError;

fun     itypeb (Quantifier) = Proposition |

itypeb SetBinder = Proposition |

   itypeb FnBinder = Object |

   itypeb BTError = TypeError;

fun Itype s = itype(optype s);

fun Itypeb s = itypeb(btype s);

(* this function identifies the apparent type of
a term; it does not do any deep analysis (we rely on the parser
and other functions not to build badly typed terms!) *)

fun termtype  (Bound n) = Object |

   (* free object variable *)

   termtype (Free n) = Object |

   (* unknown object variable (for unification) *)

   termtype (Unknown n) = Object |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   termtype (PredVar(n,L)) = Proposition |

   (* this term and its argument are propositions *)

   termtype (Negation t) = Proposition |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   termtype (Prefix(s,L)) =  if isprefixtype(optype s)  
      then Otype s
      else TypeError |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   termtype (Infix(T,",",U)) = Object |

   termtype (Infix(T,s,U)) = if isinfixtype(optype s)
       then Otype s
       else TypeError |

   termtype (Binder(s,T,U)) = if (btype s) <> BTError

      then Otypeb s
      else TypeError|

   termtype (Parenthesis T) = termtype T |

   (* error terms *)

   (* or should these be type errors? *)

   termtype ErrorProp =Proposition| termtype ErrorObject=Object;

(* precedence for binary functions *)

val PRECS = ref (nil:((string*int) list));

val MAXPREC = ref 0;

(* utilities for setting precedences for binary functions *)

fun prec s = if find s (!PRECS) = nil then
             (PRECS:=(s,0)::(!PRECS);0) else hd(find s (!PRECS));

fun isprectype Connective = true |

isprectype (Function 2) = true |

isprectype x = false;

fun setprec s n = 

if not(isprectype (optype s)) then (Say 
"Can only set arities of connectives and binary functions")

else

(PRECS:=(s,n)::
(drop (s) (!PRECS)); MAXPREC:=max(n,(!MAXPREC)));

fun pushprecs0 n nil = nil |

pushprecs0 n ((s,m)::L) = ((s,if m>=n then m+2 else m)::(pushprecs0 n L));

fun pushprecs n = PRECS:=pushprecs0 n (!PRECS);

fun evenabove n = n+1+(1-n mod 2);

fun evenbelow n = n-1-(1-n mod 2);

fun oddabove n = n+1+(n mod 2);

fun oddbelow n = n-1-(n mod 2);

fun leftstickiness (Infix(T,s,U)) = if isprectype(optype s)
   then (2*prec s)+((prec s)mod 2) else 2*(!MAXPREC)+1 |

leftstickiness x = 2*(!MAXPREC)+1;

fun rightstickiness (Infix(T,s,U)) = 
   if isprectype(optype s) then (2*prec s)+(1-(((prec s) mod 2)))
   else  2*(!MAXPREC)+1 |

rightstickiness x = 2*(!MAXPREC)+1;

fun prelength1 nil = 0 |

   prelength1 (#"\n"::L) = 0 |

   prelength1 (c::L) = 1+prelength1 L;

fun prelength s = prelength1(explode s);

fun postlength s = prelength1(rev(explode s));

val MARGIN = ref 50;

val CURSOR = ref 0;

fun cursordisplay s = if (!CURSOR) + prelength s > (!MARGIN)

then (CURSOR:=postlength ("\n     "^s);"\n     "^s )

else (CURSOR:=(!CURSOR)+postlength s;s);

fun openparen p = if termtype p = Proposition then "(" else "[";

fun closeparen p = if termtype p = Proposition then ")" else "]";

fun display

   (Bound n) = "x"^(makestring n) |

   (* free object variable *)

   display (Free n) = "a"^(makestring n) |

   (* unknown object variable (for unification) *)

   display (Unknown n) = "U"^(makestring n) |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   display (PredVar(n,nil)) = "P"^(makestring n) |

   display (PredVar(n,[T,U])) = 
       (display T)^" R"^(makestring n)^" "^(display U) |

   display (PredVar(n,L)) = "P"^(makestring n)^"("^(displayarglist L) |

   (* this term and its argument are propositions *)

   display (Negation(Infix(T,s,U))) = 

      if optype s = Connective then "~("^(display(Infix(T,s,U)))^")"

(* display option if we have negated infix predicates *)

    (* else if optype s = Predicate 2 then

    (display T)^" ~"^s^" "^(display U) *)

      else "~"^(display(Infix(T,s,U))) |

   display (Negation t) = "~"^(display t) |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   display (Prefix(s,nil)) = s |

   display (Prefix(s,[T,U])) = display (Infix(T,s,U)) |

   display (Prefix(s,L)) = s^"("^(displayarglist L) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   (* pair display *)

(* handle right grouping *)

   display (Infix(T,",",(Infix(U,",",V))))=
   (cursordisplay("["^(display T)))^
   (cursordisplay(","^(trim(display (Infix(U,",",V))))^"]")) |

   display (Infix(T,",",U)) = (cursordisplay("["^(display T)))^
   (cursordisplay(","^(display U)^"]")) |

   display (Infix(T,s,U)) = if isprectype(optype s) 

   then (cursordisplay(ldisplay s T))^

   (cursordisplay(" "^s^" "^(rdisplay s U)))

   else (display T)^" "^s^" "^(display U) |

   display (Binder("",T,U)) = "{"^(display T)^"|"^(display U)^"}" |

   display (Binder(s,Bound n,U)) = (openparen U)^s^(display (Bound n))^
       "."^(display U)^(closeparen U) |

   display (Binder(s,T,U)) = (openparen U)^s^" "^(display T)^
       "."^(display U)^(closeparen U) |

   (* internal fix for precedence computations *)

   display (Parenthesis T) = "({("^(display T)^")})" |

   (* error terms *)

   display ErrorProp = "?!?!" | display ErrorObject = "!?!?"

and displayarglist nil = "" |

   displayarglist [x] = (display x)^")" |

   displayarglist (x::L) = (display x)^","^(displayarglist L)

and needsparen (Infix(T,s,U)) = optype s = Connective
   orelse optype s = Function 2 |

needsparen x = false 

and ldisplay s p = if termtype p = Itype s
andalso
leftstickiness p < 2*(prec s)+1 andalso needsparen p then
(openparen p)^(display p)^(closeparen p) else display p

and rdisplay s p = if 
termtype p = Itype s andalso
rightstickiness p < 2*(prec s)+1 andalso needsparen p then
(openparen p)^(display p)^(closeparen p) else display p;

(* debugging function; it is very useful! *)

fun checkterm t = (Say (display t);t);

(* the parser *)


(* get literal part of identifier *)

fun getliteral0 nil = nil |

   getliteral0 (x::L) = if isdigit x then nil else

       (x::(getliteral0 L));

fun getliteral s = implode(getliteral0 (explode s));

(* function for handling precedence in the parser *)

fun prepend x s (Infix(T,t,U)) = 

if rightstickiness(Infix(T,t,U)) < 2*(prec s)+1

andalso termtype T = termtype (Infix(T,t,U))

then Infix(prepend x s T,t,U)

else Infix(x,s,Infix(T,t,U)) |

prepend x s y = Infix(x,s,y);

fun fixinfix (Prefix(x,[T,U])) =

   if optype x = Predicate 2 orelse optype x = Function 2 

   then Infix(T,x,U) else Prefix(x,[T,U]) |

   fixinfix t = t;

(* in this version there is just one parse function of each sort,
producing a pair of the parsed term and the rest of the list *)

fun preparseterm1 nil = (ErrorObject,nil) |

   preparseterm1 ("["::nil) = (ErrorObject,nil) |

   preparseterm1 ("["::x::L) = 

      (* parenthesized term and pairs *)

      if btype x = BTError then

      let val (A,B) = preparseterm (x::L)  (*and B = restparseterm (x::L)*)

      in if B = nil then (ErrorObject,nil)

      else if hd B = "]" 

      then (Parenthesis A,tl B)

      else let val (C,D) = preparseterm1 ("["::(tl B)) in

      if hd B = "," then (Infix(A,",",C),D)

      else (ErrorObject,nil) end

      end

      (* proposition bound in term *)

      else if btype x = SetBinder 

      then let val (A,B) = preparseterm (L) (* and B = restparseterm (L) *)

      in

      if B = nil orelse hd B <> "." then (ErrorObject,nil)

      else let val (C,D) = preparseprop (tl B) (* and D = restparseprop (tl B) *) in

      if D = nil orelse hd D <> "]" then (ErrorObject,nil)

      else (Binder(x,A,C),tl D)

      end

      end

      (* term bound in term *)

      else if btype x = FnBinder 

      then let val (A,B) = preparseterm (L) (* and B = restparseterm (L) *)

      in

      if B = nil orelse hd B <> "." then (ErrorObject,nil)

      else let val (C,D) = preparseterm (tl B) (*and D = restparseterm (tl B)*) in

      if D = nil orelse hd D <> "]" then (ErrorObject,nil)

      else (Binder(x,A,C),tl D)

      end

      end

      (* btype Quantifier?! *)

      else (ErrorObject,nil)

  |

(* set *)

  preparseterm1 ("{"::L) =

let val (A,B) = preparseterm L (*and B = restparseterm L*) in

if B = nil orelse hd B <> "|" then (ErrorObject,nil)

else let val (C,D) = preparseprop (tl B) (*and D = restparseprop (tl B)*) in

if D = nil orelse hd D <> "}" then (ErrorObject,nil)

else (Binder("",A,C),tl D)

end

end

|

(*

(* pair -- this notation is abandoned *)

  preparseterm1 ("<"::L) =

let val A = preparseterm L and B = restparseterm L in

if B = nil then ErrorObject

else if hd B = ">" then Parenthesis A

else if hd B = "," then Infix(A,",",preparseterm1 ("<"::(tl B)))

else ErrorObject

end

|
*)
(* initial prefix operator, constant or variable *)

preparseterm1 (x::L) = 

let val A = getliteral x and B = getindex x in

   if A = "x" andalso B <> ~1 then (Bound B,L)

   else if A = "a" andalso B <> ~1 then (Free B,L)

   else if A = "U" andalso B <> ~1 then (Unknown B,L)

   else if optype x = Function 0 

   then (Prefix(x,nil),L)

   else if Otype x = Object 

   then 
let val (M,N) = getarglist L in
if optype x = Function (length M)
then 
(fixinfix(Prefix(x,M)),N)
else (Prefix(x,ErrorObject::M),N)

end
   else (ErrorObject,nil)

   end

and preparseprop1 nil = (ErrorProp,nil) |

preparseprop1 ("("::nil) = (ErrorProp,nil) |

preparseprop1 ("("::x::L) =

   if btype x = BTError then (* parenthesized proposition *)

   let val (A,B) = preparseprop (x::L) (* and B = restparseprop (x::L)*) in

   if B = nil orelse hd B <> ")"  then (ErrorProp,nil)

   else (Parenthesis A,tl B)

   end

   else if btype x = Quantifier then (* quantified proposition *)

   let val (A,B) = preparseterm L (* and B = restparseterm L *)in

   if B = nil orelse hd B <> "." then (ErrorProp,nil)

   else let val (C,D) = preparseprop (tl B)(* and D = restparseprop (tl B)*) in

   if D = nil orelse hd D <> ")" then (ErrorProp,nil)

   else (Binder(x,A,C),tl D)

   end

   end 

   else (ErrorProp,nil)

|

(* negated proposition *)

preparseprop1 ("~"::L) = let val (A,B) = preparseprop1 L in (Negation A,B) end |

preparseprop1 (x::L) =

let val A = getliteral x and B = getindex x in

if A = "P" andalso B <> ~1 then

if L = nil orelse hd L <> "(" then 

(* propositional variable *)

(PredVar(B,nil),L)

(* predicate variable term *)

else let val (M,N) = getarglist L in (PredVar(B,M),N) end

else if optype x = Predicate 0 then 

(* declared propositional constant *)

(Prefix(x,nil),L)

else if optype x = Connective then (ErrorProp,nil)

(* guarding against prefix use of < to protect pair notation
while allowing < as an order infix *)

else if (Otype x = Proposition (* andalso x <> "<" *))

 then 

(* prefix predicate term *)

let val (M,N) = getarglist L in 
if optype x = Predicate(length M) then 
(fixinfix(Prefix(x,M)),N)
else (Prefix(x,ErrorObject::M),N)
end

else let val (A,B) = preparseterm (x::L) (* and B = restparseterm (x::L) *) in

if B<>nil andalso getliteral (hd B) = "R" andalso getindex (hd B) <> ~1



then let val (C,D) = preparseterm(tl B) in (PredVar(getindex (hd B),[A,C]),D) end

else if B = nil orelse optype(hd B) <> Predicate 2 then

(* option for negated infix predicates *)

(* if hd B = "~" 

then if tl B = nil orelse optype(hd(tl B)) <> Predicate 2

then ErrorProp

else Negation(Infix(A,hd(tl B),preparseterm (tl(tl B))))

else

*)

(ErrorProp,nil)

(* infix predicate term *)

else let val (C,D) = preparseterm (tl B) in

(Infix(A,hd B,C),D)  end

end


end

and preparseterm L =

   let val (A,B) = preparseterm1 L (* and B = restparseterm1 L *) in

   if B = nil orelse optype (hd B) <> Function 2

   then (A,B)

   else let val (C,D) = preparseterm (tl B) in

   (prepend A (hd B) C,D)  end

   end

and preparseprop L =

   let val (A,B) = preparseprop1 L (* and B = restparseprop1 L *)in

   if B = nil orelse optype (hd B) <> Connective

   then (A,B)

   else let val (C,D) = preparseprop(tl B) in

   (prepend A (hd B) C,D) end

   end

and getarglist L =

   if L = nil orelse hd L <> "(" then ([ErrorObject],nil) else

   let val (A,B) = preparseterm (tl L) (*and B = restparseterm (tl L)*)

   in if B = nil then ([A,ErrorObject],B)

   else if hd B = ")" then ([A],tl B)

   else if hd B = "," then let val (C,D) = getarglist ("("::(tl B)) in

   (A::C,D)  end

   else ([ErrorObject],nil) end;

fun parseterm t = let val (A,B) = preparseterm(tokenlist (explode t)) in

(if B <> nil

   then (Say "Term not entirely used...") else ();
   if parseerror (boundvarlist (deparenthesize A)) nil (deparenthesize(A))

   then Say "Parse errors detected..." else ();

   deparenthesize(A))  end;

fun parseprop t = let val (A,B) = preparseprop(tokenlist(explode t)) in

(if B <> nil

   then (Say "Proposition not entirely used...") else ();

   if parseerror (boundvarlist(deparenthesize(A)))nil(deparenthesize A)

   then Say "Parse errors detected..." else ();

   deparenthesize(A)) end;

fun parsetest1 t = (CURSOR:=0;Say(display(parseterm (t))));

fun parsetest2 t = (CURSOR:=0;Say(display(parseprop (t))));

(* starting substitution and matching functions *)

(* the index of the highest variable of a given kind in use in the
current context.  Free subsumes unknown for this purpose. *)

val BOUND = ref 0;

val FREE = ref 0;

fun getnewbound() = (BOUND:=(!BOUND)+1;Bound(!BOUND));

fun getnewfree() = (FREE:=(!FREE)+1;Free(!FREE));

(* fun getnewunknown() = (FREE:=(!FREE)+1;Unknown(!FREE)); *)

fun freeindex 

   (* bound object variable *)

   (Bound n) = 0 |

   (* free object variable *)

   freeindex (Free n) = n |

   (* unknown object variable (for unification) *)

   freeindex (Unknown n) = n |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   freeindex (PredVar (n,L)) = maxlist (map freeindex L) |

   (* this term and its argument are propositions *)

   freeindex (Negation t) = freeindex t |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   freeindex (Prefix(s,L)) = maxlist (map freeindex L) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   freeindex (Infix(T,s,U)) = max(freeindex T,freeindex U) |

   freeindex (Binder(s,T,U)) = max(freeindex T,freeindex U) |

   (* internal fix for precedence computations *)

   freeindex (Parenthesis T) = freeindex T |

   (* error terms *)

   freeindex ErrorProp = 0 | freeindex ErrorObject = 0;

fun boundindex 

   (* bound object variable *)

   (Bound n) = n |

   (* free object variable *)

   boundindex (Free n) = 0 |

   (* unknown object variable (for unification) *)

   boundindex (Unknown n) = 0 |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   boundindex (PredVar (n,L)) = maxlist (map boundindex L) |

   (* this term and its argument are propositions *)

   boundindex (Negation t) = boundindex t |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   boundindex (Prefix(s,L)) = maxlist (map boundindex L) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   boundindex (Infix(T,s,U)) = max(boundindex T,boundindex U) |

   boundindex (Binder(s,T,U)) = max(boundindex T,boundindex U) |

   (* internal fix for precedence computations *)

   boundindex (Parenthesis T) = boundindex T |

   (* error terms *)

   boundindex ErrorProp = 0 | boundindex ErrorObject = 0;


fun numberlist 0 = nil |

numberlist n = (numberlist ((abs n)-1))@[abs n];

fun freevarlist 

   (* bound object variable *)

   (Bound n) = nil |

   (* free object variable *)

   freevarlist (Free n) = [Free n] |

   (* unknown object variable (for unification) *)

   freevarlist (Unknown n) = nil |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   freevarlist (PredVar (n,L)) = unionlist (map freevarlist L) |

   (* this term and its argument are propositions *)

   freevarlist (Negation t) = freevarlist t |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   freevarlist (Prefix(s,L)) = unionlist (map freevarlist L) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   freevarlist (Infix(T,s,U)) = union(freevarlist T)(freevarlist U) |

   freevarlist (Binder(s,T,U)) = union(freevarlist T)(freevarlist U) |

   (* internal fix for precedence computations *)

   (* parenthesis is used to hide information in substitution and
   matching calculations *)

   freevarlist (Parenthesis T) = nil |

   (* error terms *)

   freevarlist ErrorProp = nil | freevarlist ErrorObject = nil;

fun unknownvarlist 

   (* bound object variable *)

   (Bound n) = nil |

   (* free object variable *)

   unknownvarlist (Free n) = nil |

   (* unknown object variable (for unification) *)

   unknownvarlist (Unknown n) = [Unknown n] |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   unknownvarlist (PredVar (n,L)) = unionlist (map unknownvarlist L) |

   (* this term and its argument are propositions *)

   unknownvarlist (Negation t) = unknownvarlist t |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   unknownvarlist (Prefix(s,L)) = unionlist (map unknownvarlist L) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   unknownvarlist (Infix(T,s,U)) = union(unknownvarlist T)(unknownvarlist U) |

   unknownvarlist (Binder(s,T,U)) = union(unknownvarlist T)(unknownvarlist U) |

   (* internal fix for precedence computations *)

   (* parenthesis is used to hide information in substitution and
   matching calculations *)

   unknownvarlist (Parenthesis T) = nil |

   (* error terms *)

   unknownvarlist ErrorProp = nil | unknownvarlist ErrorObject = nil;


fun predvarlist 

   (* bound object variable *)

   (Bound n) = nil |

   (* free object variable *)

   predvarlist (Free n) = nil |

   (* unknown object variable (for unification) *)

   predvarlist (Unknown n) = nil |

   (* predicate variable; this term is a proposition  *)

   (* the terms in the term list will be objects *)

   predvarlist (PredVar (n,L)) = union [PredVar(n,nil)] 
       (unionlist (map predvarlist L)) |

   (* this term and its argument are propositions *)

   predvarlist (Negation t) = predvarlist t |

   (* prefixes with object argument lists not of length 2 *)
   (* does include constants (lists of length 0)*)

   predvarlist (Prefix(s,L)) = unionlist (map predvarlist L) |

   (* operators of arity 2 get systematic special treatment so
   get their own line *)

   predvarlist (Infix(T,s,U)) = union(predvarlist T)(predvarlist U) |

   predvarlist (Binder(s,T,U)) = union(predvarlist T)(predvarlist U) |

   (* internal fix for precedence computations *)

   (* parenthesis is used to hide information in substitution and
   matching calculations *)

   predvarlist (Parenthesis T) = nil |

   (* error terms *)

   predvarlist ErrorProp = nil | predvarlist ErrorObject = nil;


fun newboundvarslist n =

   if n<=0 then nil else (newboundvarslist (n-1))@[getnewbound()];

fun newfreevarslist n =

   if n<=0 then nil else (newfreevarslist (n-1))@[getnewfree()];

(* fun newunknownvarslist n =

   if n<=0 then nil else (newunknownvarslist (n-1))@[getnewunknown()]; *)

fun updatefree t = FREE:=max ((!FREE), (freeindex t));

fun updatebound t = BOUND:=max ((!BOUND), (boundindex t));

fun expandlist ((Infix(x,",",y))::L) ((Infix(u,",",v))::M)

   = expandlist(x::y::L) (u::v::M) |

expandlist ((Infix(x,",",y))::L) (z::M) =

    expandlist (x::y::L) ((Prefix("p1",[z]))::(Prefix("p2",[z]))::M) |

    expandlist (x::L) (y::M) = let val A = expandlist L M in
               (x::(p1 A),y::(p2 A)) end |

    expandlist A B = (nil,nil);

fun expandlist1 L M =  p1(expandlist L M);

fun expandlist2 L M =  p2(expandlist L M);

fun subsitem 1 (x::L) = x |

subsitem n (x::L) = if n<=0 then ErrorObject else

subsitem (n-1) L |

subsitem n nil = ErrorObject;

fun subsitemno x nil = 0 |

subsitemno x (y::L) = if x=y then 1 else 1+(subsitemno x L);

fun subslistmatch x L M =

subsitem (subsitemno x L) M;

fun tuplefromlist nil = ErrorObject |

   tuplefromlist [t] = t |

   tuplefromlist (t::L) = Infix(t,",",tuplefromlist L);

val USUBS = ref (nil:((int*Term)list))

val UDISABLED = ref 0;

fun udisabled() = UDISABLED:=1+(!UDISABLED);

fun uenabled() = UDISABLED:=(!UDISABLED)-1;

(* this is less fun but it is my peculiar expertise:  write the
stratification function *)

(* parameter which limits the number of types if it is
positive; 2 and 3 are the interesting bounds *)

val TYPEBOUND = ref 0;

val NEWTYPE = ref 0;

fun newtype() = (NEWTYPE:=(!NEWTYPE)+1;(!NEWTYPE));

(* the type assigned to a term is a serial number (generated by
newtype() when a new one is wanted) followed by a displacement from
that unknown type *)

(* types assigned to terms *)

val TYPES = ref (nil:((Term*(int*int))list));

(* displacements of eliminated unknown types *)

val DISPS = ref (nil:((int*(int*int))list));

val TYPEERROR = ref false;

(* functions for counting distinct types for restricted
versions of stratification *)

(* they are not in use yet *)

fun maxdisp n = maxlist (map(fn (T,(p,q)) => if p=n then q else 0) (!TYPES));

fun mindisp n = maxlist (map(fn (T,(p,q)) => if p=n then ~q else 0) (!TYPES));

fun typerange (m,n) = if n>=0 then n+(mindisp m)+1 else (~n)+(maxdisp n)+1;

fun maxrange n = (maxdisp n) + (mindisp n) + 1;

(* notypes() is the minimum number of distinct types present *)

(* but this will probably not work properly in presence of constants which are
not assigned types *)

fun notypes() = maxlist (map(fn (T,(p,q))=>maxrange p) (!TYPES));

fun plus (r,s) n = (r,s+n);

fun fixtype (m,n) =

if find m (!DISPS) = nil then (m,n)

else let val (r,s) = hd(find m (!DISPS)) in

fixtype(r,s+n)

end;

fun typeof t = if find t (!TYPES) = nil then

   let val T = (newtype(),0) in
   
   (if termtype t = Object andalso boundvarlist t <> nil 
   then TYPES:=(t,T)::(!TYPES) else ()
    ;T) end

   else let val A = fixtype (hd(find t (!TYPES)))

   in if A = hd(find t (!TYPES)) then A

   else (TYPES:=(t,A)::(drop t (!TYPES));A) end;

fun showtypes() = Say(showlist display (showpair makestring makestring) (map 
   (fn (x,y)=>(x,typeof x)) (!TYPES)));

fun unifytype (m,n) (r,s) =

if m=r then if n=s then () else TYPEERROR:=true

else if m<r then unifytype (r,s) (m,n)

else if find m (!DISPS) <> nil then unifytype (fixtype(m,n)) (r,s)

else DISPS:=(m,(r,s-n))::(!DISPS);

fun checkterm2 T = Say ((display T)^(makestring(p2(typeof T))));

fun assigntype t T = if find t (!TYPES) = nil

   then if (!TYPEBOUND)>0 andalso typerange(fixtype T) > (!TYPEBOUND)

   then TYPEERROR:=true

   else if termtype t = Object andalso boundvarlist t <> nil

   then (TYPES:=(t,fixtype T)::(!TYPES)) else ()

   else

   (unifytype (typeof t) T;
   if (!TYPEBOUND)>0 andalso typerange(typeof t)>(!TYPEBOUND)
   then TYPEERROR:=true else 
           TYPES:=(t,typeof t)::(drop t (!TYPES)));

fun assigntypes T nil nil = () |

   assigntypes T (x::L) (y::M) = (assigntype x (plus T y);assigntypes T L M) |

   assigntypes x y z = TYPEERROR:= true;

(* this is a dynamic approach but a much better one *)

(* this is strong stratification; if bound variables can be expected
not to be identified meaninglessly then it is OK (our definition of
substitution would seem likely to enforce this?) *)

(* otherwise I might have to fiddle around to get weak stratification *)

(* I believe that this can readily be updated to get strongly
cantorian types in the style of Watson *)

val OPERATORSTRAT = ref (nil:(string*(int list))list);

val BINDERSTRAT = ref (nil:(string*(int list))list);

fun addopstrat s L = OPERATORSTRAT:=(s,L)::(!OPERATORSTRAT);

fun addbstrat s n = BINDERSTRAT:=(s,n)::(!BINDERSTRAT);

val _ = addopstrat "E" [0,1];

val _ = addopstrat "=" [0,0];

val _ = addbstrat "A" [0,0];

val _ = addbstrat "E" [0,0];

val _ = addbstrat "" [1,0,0];

val _ = addbstrat "L" [1,0,0];

val _ = addopstrat "p1" [0,0];

val _ = addopstrat "p2" [0,0];

(* val _ = addopstrat "," [0,0,0]; *)

val _ = addopstrat ":" [0,0,1];

val _ = addopstrat "`" [0,1,0];

(* left P0 opaque because other clauses in stratify use this;
made all other Pn's flat predicates *)

fun stratify (Bound n) = assigntype (Bound n) (newtype(),0)|

   stratify (Free n) = () |

   stratify (Unknown n) = () |

   stratify (PredVar(0,L)) =

   if Some (fn x=>boundvarlist x<>nil) L then TYPEERROR:=true
   else (map stratify L;()) |

   stratify (PredVar(n,L)) =

   (map stratify L; 
   assigntypes (newtype(),0) L (map (fn x => 0) L)) |

   stratify (Prefix(s,L)) =

   if find s (!OPERATORSTRAT) = nil

   then stratify (PredVar(0,L))

   else if Otype s = Proposition

   then (map stratify L;
   assigntypes (newtype(),0) L (hd(find s (!OPERATORSTRAT))))

   else (map stratify L;
   assigntypes (newtype(),0) ((Prefix(s,L))::L) (hd(find s (!OPERATORSTRAT))))

   |

   stratify (Negation P) = stratify P |

   stratify (Infix(T,",",U)) =
   (stratify T;stratify U;
   assigntypes (newtype(),0) [(Infix(T,",",U)),T,U] [0,0,0]) |

   stratify (Infix(T,s,U)) =

   if optype s = Connective then (map stratify [T,U];())

   else let val L = [T,U] in if find s (!OPERATORSTRAT) = nil

   then 

   stratify (PredVar(0,L))

   else if Otype s = Proposition

   then (map stratify L;
   assigntypes (newtype(),0) L (hd(find s (!OPERATORSTRAT))))

   else ((map stratify L;
   assigntypes (newtype(),0) ((Infix(T,s,U))::L) (hd(find s (!OPERATORSTRAT)))))
 end |

   stratify (Binder(s,T,U)) =

   if find s (!BINDERSTRAT) = nil then TYPEERROR:=true

   else (stratify T;stratify U; if boundvarlist T <> nil
   andalso boundvarlist U <> nil then
   if Otypeb s = Proposition 
   then assigntypes (newtype(),0) [T,U] (hd(find s (!BINDERSTRAT)))
   else assigntypes (newtype(),0) 
        [Binder(s,T,U),T,U] (hd(find s (!BINDERSTRAT)))

   else ()) |

   stratify (Parenthesis T) = stratify T |

   stratify x = TYPEERROR:= true;

(* the substitution should diversify bound variable indices *)

val OLDBOUNDSTRAT = ref 0;

fun stratified t = (
    NEWTYPE:=0;
    OLDBOUNDSTRAT:=(!BOUND);TYPEERROR:=false;TYPES:=nil;
    DISPS:=nil;
    (* updatebound t; *)
    stratify ((* diversify *) t);
    BOUND:=(!OLDBOUNDSTRAT);
    if (!TYPEERROR)
    then (Say "Warning: stratification failed";false) else true);


(* list needed for internal matching of binders *)

val ALPHAMATCHES = ref (nil:(int*int)list);

fun depair(Infix(Prefix("p1",[T]),",",Prefix("p2",[U]))) =

if (udisabled();let val A=alpha true T U 
    in (uenabled();A) end)

then T else Infix(Prefix("p1",[T]),",",Prefix("p2",[U])) |

depair T = T

(* a more radical way to prevent depair from invoking unification *)

(* if unknownvarlist T = nil andalso unknownvarlist U = nil

then if alpha true T U then T else Infix(Prefix("p1",[T]),",",Prefix("p2",[U]))

else if T = U then T else Infix(Prefix("p1",[T]),",",Prefix("p2",[U])) |

depair T = T *)

 (* this function only acts on atomic terms and pair structures 
built of variable components *)

(* lets pairs act *)

and subsvar v t x = subslist (expandlist1 [v][t]) (expandlist2 [v][t]) x


(* NEW SUBSLIST *)

and  subslist nil nil t = t | 

   subslist L M (Parenthesis t) = Parenthesis t |

   subslist L M (Bound n) = if foundin (Bound n) L

            then subslistmatch (Bound n) L M else Bound n |

   subslist L M (Free n) = if foundin (Free n) L

            then subslistmatch (Free n) L M else (Free n) |

   subslist L M (Unknown n) = if foundin (Unknown n) L

            then subslistmatch (Unknown n) L M else Unknown n |

   subslist L M (PredVar (n,N)) = 

       if n>0 andalso N<>nil andalso foundin (PredVar(n,nil)) L

       then Infix(tuplefromlist(map (subslist L M) N),
       "E",subslistmatch (PredVar(n,nil)) L M) else

       PredVar (n,map (subslist L M) N) |

   subslist L M (Negation T) = Negation (subslist L M T) |

   subslist L M (Prefix("p1",[T])) =

      deproj(Prefix("p1",[subslist L M T])) |

   subslist L M (Prefix("p2",[T])) =

      deproj(Prefix("p2",[subslist L M T])) |

   subslist L M (Prefix(s,[T,U])) = subslist L M (Infix(T,s,U)) |

   subslist L M (Prefix(s,N)) = Prefix(s,map (subslist L M) N) |

   subslist L M (Infix(T,",",U)) =

      depair(Infix(subslist L M T,",",subslist L M U)) |
   
(*   subslist L M (Infix(Binder("L",Bound n,T),"`",U)) =
      
      if stratified (Binder("L",Bound n,T)) then 

      subslist L M (subsvar (Bound n) T U)

      else (
      let val X = getnewbound() in 
      Infix(subslist L M (Binder("L",X ,subsvar (Bound n) X T)),"`",subslist L       M U) end) | *)

(*   subslist L M (Infix(T,"`",U)) = let val T2 = subslist L M T in

      if T = T2 then Infix(T,"`",subslist L M U)

      else subslist L M (Infix(T2,"`",U)) end | *)

   subslist L M (Infix(T,s,U)) = Infix(subslist L M T,s,subslist L M U) |

   subslist L M (Binder(s,Infix(A,":",B),U)) =

(*   if foundin v (freevarlist(Binder(s,T,U))) orelse
   foundin v (unknownvarlist(Binder(s,T,U))) orelse
   foundin v (boundvarlist(Binder(s,T,U))) orelse v = Free 0 then *)

(* rename the variables in the head T which do not occur in the list L *)

   let val C = subslist L (map Parenthesis M) A in
   let val D = freeboundvarlist C in
   let val N = newboundvarslist (length(D)) in
   deparenthesize(Binder(s,Infix(subslist (D) (N) C,":",subslist L M B),
   subslist (D@L) (N@M) U))
   end
   end end

(*   else Binder(s,T,U) *)

   |

   subslist L M (Binder(s,T,U)) =

(*   if foundin v (freevarlist(Binder(s,T,U))) orelse
   foundin v (unknownvarlist(Binder(s,T,U))) orelse
   foundin v (boundvarlist(Binder(s,T,U))) orelse v = Free 0 then *)

(* rename the variables in the head T which do not occur in the list L *)

   let val A = subslist L (map Parenthesis M) T in
   let val B = freeboundvarlist A in
   let val N = newboundvarslist (length(B)) in
   deparenthesize(Binder(s,subslist (B) (N) A,
   subslist (B@L) (N@M) U))
   end
   end end

(*   else Binder(s,T,U) *)

   |

   subslist L M  ErrorProp = ErrorProp |

   subslist L M ErrorObject = ErrorObject |

   subslist L M T = ErrorObject


(* alpha-equivalence *)

(* unknown variables come first because of their side-effects *)

and alpha b (Unknown m) (Unknown n) =

if (!UDISABLED)>0 then m=n else

if m = n then true

else if n>m then alpha b (Unknown n) (Unknown m) 

else if find m (!USUBS) = nil

then (USUBS:=((m,Unknown n)::(!USUBS));true)

else alpha b (Unknown n) (hd(find m (!USUBS)))

|

alpha b (Unknown n) t =

if (!UDISABLED)>0 then false else

if freeindex t >= n then false else

if quietly Parseerror t then false else

if find n (!USUBS) = nil then (USUBS:=(n,t)::(!USUBS);true)

else alpha b t (hd(find n (!USUBS)))

|

alpha b t (Unknown n) = alpha b (Unknown n) t 

|

alpha b (Bound m) (Bound n) = 

(b andalso m=n)

orelse 

((not b) andalso 

((find m (!ALPHAMATCHES)=nil andalso 
find n (map((fn(x,y)=>(y,x)))(!ALPHAMATCHES)) = nil andalso
(ALPHAMATCHES:=(m,n)::(!ALPHAMATCHES);true))

orelse 

(find m (!ALPHAMATCHES) = [n])))



 |

alpha b (Free m) (Free n) = m=n |

alpha b (PredVar(n,nil)) (PredVar(m,nil)) =

    m=n |

alpha b (PredVar(n,nil)) t = false |

alpha b t (PredVar(n,nil)) = false |

alpha b (PredVar(m,(x::L))) (PredVar(n,(y::M))) =

   m=n andalso alpha b x y andalso alpha b (PredVar(m,L)) (PredVar(n,M)) |

alpha b (Negation T) (Negation U) = alpha b T U |

alpha b (Prefix(s,L)) (Prefix(t,M)) =

   s=t andalso alpha b (PredVar(1,L)) (PredVar(1,M)) |

(* this is a place where commutative matching could take hold *)

alpha b (Infix(T,s,U)) (Infix(V,t,W)) =

   s=t andalso alpha b T V andalso alpha b U W |

(* here's an unexpected check:  this requires that T and V
be matched!   Moreover, this is an "embedded" match, the kind
that I need to avoid for the most part!  But if I don't allow
global matching of bound variables, it is actually OK;  this is
bound variable matching... *)

(* moreover, this matching requires precisely matching structure differing
only in bound variable numbering *)

(* alpha itself does the matching:  the new parameter b indicates
that we are testing alpha-equivalence if it is true and, if it is false,
that we are testing alpha-equivalence up to matching of bound variables *)

(* the matching component has a dangerously dynamic quality about it...*)

alpha b (Binder(s,T,U)) (Binder(t,V,W)) =

   s=t andalso

   (if b then ALPHAMATCHES:=nil else ();alpha false T V)

   andalso let val M = newfreevarslist (length (boundvarlist T))

   in

   alpha b (subslist (boundvarlist T) M U) (subslist (boundvarlist V) M W) 

   end |

alpha b (Parenthesis T) (Parenthesis U) = alpha b T U |

alpha b (Prefix(s,[T,U])) x = alpha b (Infix(T,s,U)) x |

alpha b x (Prefix(s,[T,U])) = alpha b x (Infix(T,s,U)) |

alpha b x y = false;

val OLDBOUND = ref (!BOUND);
fun sortednonboundvarlist t = 

map p2 (bubble (map (fn (Bound n)=>(n,Bound n)) (listminus (boundvarlist t) 
(map Bound(numberlist (!OLDBOUND))))));

fun smashednonboundvarlist t =

map (fn x=>Bound((!OLDBOUND)+x)) (numberlist (length (sortednonboundvarlist t)));


(* bound variable counter should matter only during a particular
substitution *)

(* these functions should keep bound variable counter within bounds *)

(* the updatebound u here might be optional--im trying removing it. NO *)

fun smashbound t = rebind t;

(* = subslist ((map Bound (numberlist(!OLDBOUND)))@(sortednonboundvarlist t)) 
((map Bound (numberlist(!OLDBOUND)))@(smashednonboundvarlist t)) t; *)

fun topsubsvar0 v t u = ((* OLDBOUND:=(!BOUND)*) BOUND:=0;updatebound v;updatebound t;
    updatebound u; let val T =
     smashbound  (subsvar v t u) in ((* BOUND:=(!OLDBOUND)*) BOUND:=0;T) end);

(* renames all bound variables with maximum diversity *)

(* these functions should only be used on top-level terms *)
(* these should work as intended -- they do not depend on smashbound *)

(* what is the difference between diversify and diversify0? *)

fun diversify t = topsubsvar0 (Free 0) (Free 0) t; (* top level *)

fun diversify0 t = (updatebound t;subsvar (Free 0) (Free 0) t); (* internal *)

val OLDBOUNDSTRAT = ref (!BOUND);

fun stratified t = (
    NEWTYPE:=0;
    OLDBOUNDSTRAT:=(!BOUND);TYPEERROR:=false;TYPES:=nil;
    DISPS:=nil;
    (* updatebound t; *)
    stratify ((diversify) t);
    BOUND:=(*(!OLDBOUNDSTRAT)*)0;
    if (!TYPEERROR)
    then (Say "Warning: stratification failed";false) else true);

fun strattest1 t = (TYPEERROR:=false;TYPES:=nil;
    stratify(parseterm t);not(!TYPEERROR));

fun strattest2 t = (TYPEERROR:=false;TYPES:=nil;
    stratify(parseprop t);not(!TYPEERROR));


(* a more principled way to rename and diversify all variables in t,
avoiding the variables in u *)

(* fun diversify2 u t = (OLDBOUND:=(!BOUND);updatebound t;updatebound u;
let val T = subsvar (Free 0) (Free 0) t in (BOUND:=(!OLDBOUND);T) end); *)

(* the usual variable subs function -- smashes down bound variable indices *)

val OLDFREE = ref(!FREE);  (* free counter leak is possible if depair is invoked
and so alpha *)

fun topsubsvar v t u = ((* OLDBOUND:=(!BOUND)*) BOUND:=0;OLDFREE:=(!FREE);
    updatebound v;updatebound t;
    updatebound u; let val T =
    smashbound(subsvar v t u) in (BOUND:=(*(!OLDBOUND)*)0;FREE:=(!OLDFREE);T) end);

fun topsubslist L M u = 
if length L <> length M then ErrorObject else 
((* OLDBOUND:=(!BOUND);*) BOUND:=0; OLDFREE:=(!FREE); map updatebound (expandlist1 L M);
    map updatebound (expandlist2 L M); updatebound u; let val T =
    smashbound(subslist (expandlist1 L M) (expandlist2 L M) u) in 
    (BOUND:=(*(!OLDBOUND)*)0;FREE := (!OLDFREE);T) end);

fun substest1 T U V = Say(display(
     topsubsvar0 (parseterm T) (parseterm U) (parseterm V)));
fun substest2 T U V = Say(display(
     topsubsvar (parseterm T) (parseterm U) (parseprop V)));

fun rebindtest T = Say(display(rebind(parseterm T)));

(* Here should be the first appearance of the USUBS list *)

(* if (n,T) is in USUBS then we intend to replace Un throughout
the current environment with T.  Whenever a Un is compared in the
alpha-equivalence or matching functions with a term, we aggressively
propose that it is in fact equal. 

Un cannot be rewritten to a term which contains Un; this includes
all am with m>n (which tacitly depend on some earlier Un's).

Rewrites are accumulated in USUBS and all fired at once after all
the rewrites occasioned by a single top-level command are accumulated.
Circularity is tested at that point.  The idea is that the list is
sorted into descending order, then each rewrite is applied to the entire
prover context, including the rest of the USUBS list; examination of the
USUBS list makes it easy to detect circularity.

*)

val OLDBOUND = ref (!BOUND);
val OLDFREE=ref (!FREE);

val OLDUSUBSA=ref(!USUBS);

(* diversified all variables here with a dummy substitution *)

(* restores free counter -- alpha does use this *)

fun topalpha t u = ((*OLDBOUND:=(!BOUND);*)BOUND:=0; OLDFREE:=(!FREE);
    ALPHAMATCHES:=nil;OLDUSUBSA:=(!USUBS);
    let val T = alpha true 
    (diversify t)
     (diversify u) in (BOUND:=(*(!OLDBOUND)*)0;FREE:=(!OLDFREE);
    ALPHAMATCHES:=nil;
    if T then T else (USUBS:=(!OLDUSUBSA);T)) end);

(* alpha equivalence without unification *)

fun merealpha t u = (udisabled();let val T = topalpha t u in
                    (uenabled();T) end);

fun alphatest1 T U = topalpha (parseterm T) (parseterm U);

fun alphatest2 T U = topalpha (parseprop T) (parseprop U);

(* debugging tools *)

fun showusublist nil = ""|

showusublist ((n,t)::L) =

(showusublist L)^"\n"^(makestring n)^": "^(display t);

fun showusubs() = Say(showusublist (!USUBS));

(* general rewrite function *)

val REWRITEMASK = (* ref ~1; *) ref (nil:(int list));

(* the function is called oddmask for historical reasons; this argument
was at one time an integer bit mask rather than a list *)

fun oddmask() = let val T = (!REWRITEMASK)=nil orelse
foundin 1 (!REWRITEMASK) in
(REWRITEMASK:= map (fn x=>x-1) (!REWRITEMASK);T) end;

fun resetusubs() = USUBS:=(!OLDUSUBSA);

fun rewrite v t (Bound n) = if topalpha v (Bound n) then 
   if oddmask() then

   t else (resetusubs();Bound n) else (Bound n) |

   rewrite v t (Free n) = if topalpha  v (Free n) then 

   if oddmask() then t 
   else (resetusubs();Free n)
   else (Free n) |

   rewrite v t (Unknown n) = if topalpha v (Unknown n) 

   then 
   if oddmask() then t else (resetusubs();Unknown n)
   else Unknown n |

   rewrite v t (PredVar (n,L)) = 

   if topalpha v (PredVar (n,L))

   then if oddmask() then t 
   else (resetusubs();PredVar (n,map (rewrite v t) L))
   else PredVar (n,map (rewrite v t) L) |

   rewrite v t (Negation T) = 

   if topalpha v (Negation T) then 

   if oddmask() then t else

   (resetusubs();Negation (rewrite v t T)) else

   Negation (rewrite v t T) |

   rewrite v t (Prefix("p1",[T])) =

      if topalpha v (Prefix("p1",[T])) then 

      if oddmask() then t else

      (resetusubs();deproj(Prefix("p1",[rewrite v t T]))) else

      deproj(Prefix("p1",[rewrite v t T])) |

   rewrite v t (Prefix("p2",[T])) =

      if topalpha v (Prefix("p2",[T])) then 

      if oddmask() then t else

      (resetusubs();deproj(Prefix("p2",[rewrite v t T]))) else

      deproj(Prefix("p2",[rewrite v t T])) |

   rewrite v t (Prefix(s,[T,U])) = rewrite v t (Infix(T,s,U)) |

   rewrite v t (Prefix(s,L)) = 

     if topalpha v (Prefix(s,L)) then 

   if oddmask() then t else

   (resetusubs();Prefix(s,map (rewrite v t) L)) else

   Prefix(s,map (rewrite v t) L) |

   rewrite v t (Infix(T,",",U)) =

      if topalpha v (Infix(T,",",U)) then 

      if oddmask() then t else 

      (resetusubs();depair(Infix(rewrite v t T,",",rewrite v t U))) else 

      depair(Infix(rewrite v t T,",",rewrite v t U)) |

   rewrite v t (Infix(T,s,U)) = 
     ((* Say ("Entering term "^(display(Infix(T,s,U)))^" with mask "^(makestring(!REWRITEMASK)));showusubs(); *)
     if topalpha v (Infix(T,s,U)) then 

     if oddmask() 

     then ((* Say "Performing the rewrite?";showusubs();Say(display t); *) t)

     else
     ((* Say "Matched but not rewriting";Say "Before reset";showusubs(); *)
     (resetusubs();
     (* Say "After reset";showusubs(); *)
     Infix(rewrite v t T,s,rewrite v t U))) else

     ((* Say "Didn't match"; *) Infix(rewrite v t T,s,rewrite v t U))) |

   rewrite v t (Binder(s,T,U)) = 

     if topalpha v ((Binder(s,T,U))) then 

    if oddmask()then  t 

 else
   (resetusubs();
   let val A = rewrite v (Parenthesis t) T in
   let val M = newboundvarslist (length(boundvarlist A)) 
   and N = newfreevarslist(length(boundvarlist A))
in 
   deparenthesize(subslist N M(Binder(s,subslist (boundvarlist A) (N) A,
   rewrite v t (subslist (boundvarlist A) N U))))
   end
   end)

   else

   let val A = rewrite v (Parenthesis t) T in
   let val M = newboundvarslist (length(boundvarlist A)) 
   and N = newfreevarslist(length(boundvarlist A))
in 
   deparenthesize(subslist N M(Binder(s,subslist (boundvarlist A) (N) A,
   rewrite v t (subslist (boundvarlist A) N U))))
   end end

   |

   rewrite v t (Parenthesis T) = Parenthesis T |

   rewrite v t ErrorProp = ErrorProp |

   rewrite v t ErrorObject = ErrorObject;

(* the mask parameter was a bitmask telling which occurrences of the
target term are to be rewritten; ~1 is a convenient value (rewrites
all occurrences --it is now a list of integers indicating positions
at which to rewrite (nil signals to rewrite everywhere)*)

(* the dummy substitution diversifies free variables so that any
free variables in binders will not be rewritten if v happens to contain
relevant free variables or free variable expressions.   The same idea
appears in the stratification function.  *)

(* the removal of updatebound T relies on the same expectation
as the change in topsubsvar:  the bound variable counters are already
incremented to account for bound variables in text already entered
into the prover *)

val OLDFREE=ref(!FREE);

val OLDBOUNDREWRITE = ref(!BOUND);

fun sortednonboundvarlist2 t = 

map p2 (bubble (map (fn (Bound n)=>(n,Bound n)) (listminus (boundvarlist t) (map Bound (numberlist (!OLDBOUNDREWRITE))))));

fun smashednonboundvarlist2 t =

map (fn x=>Bound((!OLDBOUNDREWRITE)+x)) (numberlist (length (sortednonboundvarlist2 t)));


(* bound variable counter should matter only during a particular
substitution *)

(* these functions should keep bound variable counter within bounds *)

(* the updatebound u here might be optional--im trying removing it. *)


fun smashbound2 t = rebind t;

(* = subslist ((map Bound (numberlist(!OLDBOUNDREWRITE)))@(sortednonboundvarlist2 t)) 
((map Bound (numberlist(!OLDBOUNDREWRITE)))@(smashednonboundvarlist2 t)) t; *)



fun toprewrite mask v t T =

   ((*OLDBOUNDREWRITE:=(!BOUND)*)BOUND:=0;OLDFREE:=(!FREE);REWRITEMASK:=mask;
   updatebound v;updatebound t; updatebound T;
    let val U = smashbound2(rewrite v t (diversify T))

    in (BOUND:=(*(!OLDBOUNDREWRITE)*)0;FREE:=(!OLDFREE);
    (*topsubsvar (Free 0) (Free 0)*) U) end);

fun rewritetest mask v t T =
(updatefree (parseterm t);updatefree (parseterm T);
toprewrite mask (parseterm v) (parseterm t) (parseterm T));

fun rewritetest2 mask v t T =
(updatefree (parseterm t);updatefree (parseprop T);
toprewrite mask (parseterm v) (parseterm t) (parseprop T));


(* matching *)

(* fancy predicate matching will not be supported *)

(* matches to propositional and predicate variables *)

val PROPMATCHES = ref (nil:(int*Term)list);

(* matches to object variables *)

val MATCHES = ref (nil:(Term*Term)list);

fun showmatches() = Say(showlist display display (!MATCHES));


(* compatibility for matching lists *)

val NoMatch = [(Bound ~1,ErrorObject)];

fun matchadd n t L = if find (Bound ~1) L <> nil then NoMatch else

   if find n L = nil then (n,t)::L

   else if topalpha t (hd (find n L)) then L

   else NoMatch;

fun add n t = MATCHES:=(n,t)::(!MATCHES);

fun matchunion L nil = L |

   matchunion nil M = M |

   matchunion ((m,x)::L) ((n,y)::M) =

   matchadd m x (matchadd n y (matchunion L M));

fun (* isprojvar (Bound m) = true | *)

   isprojvar (Free m) = true |

   isprojvar (Unknown m) = true |

   isprojvar (Prefix("p1",[T])) = isprojvar T |

   isprojvar (Prefix("p2",[T])) = isprojvar T |

   isprojvar x = false;




(* the definition facility *)

(* lists of saved definitions *)

val TERMDEFS = ref (nil:((string*(Term*Term))list));

val PROPDEFS = ref (nil:((string*(Term*Term))list));

(* binders are defined in terms of previously defined unary
functions or predicates *)

(*

val PROPBINDDEFS = ref(nil:(string*string)list);

val TERMBINDDEFS = ref(nil:(string*string)list);

fun propbinddef s t = if find s (!BINDERS) <> nil

   orelse find s (!OPERATORS) <>nil 

then Say (s^" is already a binder or operator")

else if isflatbinary t

then

  (makequantifier s; PROPBINDDEFS:=(s,t)::(!PROPBINDDEFS);
)
else Say (t^" is not a flat binary predicate");

fun termbinddef s t =  if find s (!BINDERS) <> nil
   orelse find s (!OPERATORS) <> nil

then Say (s^" is already a binder or operator")

else if isflatbinaryfun t then

   (makesetbinder s; TERMBINDDEFS:=(s,t)::(!TERMBINDDEFS);
)
else if isflatfun t then 

   (makefnbinder s;  TERMBINDDEFS:=(s,t)::(!TERMBINDDEFS);
)
else Say (t^" is not a binary function or predicate");

*)

fun extractlist (Prefix(s,L)) = L |

extractlist (Infix(T,s,U)) = [T,U] |

extractlist t = nil;

fun variableform s = length(explode(getliteral s)) = 1
andalso getindex s <> ~1;

fun declarepredicate s L = 

if s<>"" andalso getid(explode s) = s andalso
not(variableform s)
andalso optype s = OTError andalso find s (!BINDERS) = nil
then
(makepredicate (length L) s; addopstrat s L)
else Say "Bad predicate declaration did not succeed";

fun declarefunction s L =  if s<>"" andalso getid(explode s) = s 
andalso not(variableform s)
andalso optype s = OTError andalso find s (!BINDERS) = nil
then
(makefunction ((length L)-1) s; addopstrat s L)
else Say "Bad predicate declaration did not succeed";

fun leftdefform n s (Prefix(x,L)) = x=s andalso 
length L = n andalso
boundvarlist (Prefix(x,L)) = L |
leftdefform n s (Infix(T,s2,U)) = leftdefform n s (Prefix(s2,[T,U])) |
leftdefform n x y = false;

fun definepredicate n s S T = 
if s<>"" andalso getid(explode s) = s andalso not(variableform s)
andalso optype s = OTError andalso find s (!BINDERS) = nil
then (makepredicate n s;

if (parseerror(boundvarlist (parseprop S)) nil (parseprop T)) orelse
   freeindex (parseprop T) <>0 orelse predvarlist (parseprop T) <> nil

then (OPERATORS:=drop s (!OPERATORS);Say "Bad right side of definition")

else if leftdefform n s (parseprop S) then

(PROPDEFS:= (s,(parseprop S,parseprop T))::(!PROPDEFS);


Say (display(Infix(parseprop S,"==",parseprop T)));
if stratified (parseprop T) then

addopstrat s (map (fn (x,y)=>y)(map typeof (extractlist(parseprop S))))

else Say "Definition was unstratified")

else (OPERATORS:=drop s (!OPERATORS);Say "Bad left side of definition"))

else Say "Bad predicate definition did not succeed";

fun definefunction n s S T = 

if s<>"" andalso getid(explode s) = s 
andalso not(variableform s)
andalso optype s = OTError andalso find s (!BINDERS) = nil

andalso freeindex (parseterm T) =0
then (makefunction n s;

if (parseerror (boundvarlist(parseterm S)) nil (parseterm T))
   orelse freeindex (parseterm T) <> 0 orelse predvarlist (parseterm T) <> nil

then (OPERATORS:=drop s (!OPERATORS);Say "Bad right side of definition")

else if leftdefform n s (parseterm S) then

(TERMDEFS:=(s,(parseterm S,parseterm T))::(!TERMDEFS);
Say (display(Infix(parseterm S,"=",parseterm T)));
if stratified (parseterm T) then

addopstrat s (map (fn (x,y)=>y)
   (map typeof (((diversify) (parseterm T))
    ::(extractlist(parseterm S)))))

else Say "Definition was unstratified")

else (OPERATORS:=drop s (!OPERATORS);Say "Bad left side of definition"))

else Say "Bad function definition did not succeed";

fun showtermdeflist nil = "Function definition list:" |

showtermdeflist ((s,(S,T))::L) = 
(showtermdeflist L)^"\n"^(display(Infix(S,"=",T)));

fun thetermdefs() = showtermdeflist (!TERMDEFS);

fun showpropdeflist nil = "Predicate definition list:" |

showpropdeflist ((s,(S,T))::L) = 
(showpropdeflist L)^"\n"^(display(Infix(S,"==",T)));

fun thepropdefs() = showpropdeflist (!PROPDEFS);

fun usepropdef (Prefix(s,L)) = 

if find s (!PROPDEFS) = nil

then (Say ("No prop definition of "^s);Prefix(s,L))

else let val M = extractlist(p1(hd(find s (!PROPDEFS))))

in if length M <> length L then (Say ("Wrong number of arguments for "^s);Prefix(s,L))

else 
((* updatebound (p2(hd(find s (!PROPDEFS)))); *)
topsubslist M L (p2(hd(find s (!PROPDEFS))))) end |

usepropdef (Infix(T,s,U)) = usepropdef (Prefix(s,[T,U])) |

usepropdef x  = (Say "Definition does not apply";x)

fun usetermdef (Prefix(s,L)) = 

 if find s (!TERMDEFS) = nil

then (Say ("No object definition of "^s);Prefix(s,L))

else let val M = extractlist(p1(hd(find s (!TERMDEFS))))

in if length M <> length L then (Say ("Wrong number of arguments for "^s);Prefix(s,L))

else ((* updatebound (p2(hd(find s (!TERMDEFS)))); *)
     topsubslist M L (p2(hd(find s (!TERMDEFS))))) end |

usetermdef (Infix(T,s,U)) = fixinfix(usetermdef (Prefix(s,[T,U]))) |

usetermdef  y = (Say "Definition does not apply";y);


(* matching to unknowns is installed and appears to work but pair matching
is not installed correctly; the problem has to do with checking for conflicts
between matches to projections of variables and matches to the variables
themselves -- apparently fixed *)

(* function to check compatibility of matches to 
projections of variables *)

(* this function is conservative:  some really complicated match
patterns which are valid are rejected. *)

fun nomatchabove (Prefix("p1",[x])) =

   find (Prefix("p1",[x])) (!MATCHES) = nil andalso nomatchabove x |
nomatchabove (Prefix("p2",[x])) =

   find (Prefix("p2",[x])) (!MATCHES) = nil andalso nomatchabove x |

nomatchabove x = find x (!MATCHES) = nil;

fun paircheck0 M nil = true |

paircheck0 M ((Prefix("p1",[x]),y)::L) =

if find x (L@M) <> nil then topalpha (deproj(Prefix("p1",(find x (L@M))))) y

andalso paircheck0 ((Prefix("p1",[x]),y)::M) L 

else if find (Prefix("p2",[x])) (L@M) <> nil then

paircheck0 M ((x,(Infix(y,",",hd(find (Prefix("p2",[x])) (L@M)))))::((Prefix("p1",[x]),y)::L))

else

nomatchabove x |

paircheck0 M ((Prefix("p2",[x]),y)::L) =

if find x (L@M) <> nil then topalpha (deproj(Prefix("p2",(find x (L@M))))) y

andalso paircheck0 ((Prefix("p1",[x]),y)::M) L 

else if find (Prefix("p1",[x])) (L@M) <> nil then

paircheck0 M ((x,(Infix(hd(find (Prefix("p1",[x])) (L@M)),",",y)))::((Prefix("p2",[x]),y)::L))

else

nomatchabove x |

paircheck0 M (x::L) = paircheck0 (x::M) L;

fun paircheck() = paircheck0 nil (!MATCHES);


(* fire all unknown subs on a single term

this is only a test function; the substitution in the true function
would be global. *)

fun testselfsubslist nil t = (USUBS:=nil;t) |

testselfsubslist ((n,x)::L) t = 

     if freeindex x >= n then (Say "Circularity error";t)

     else (testselfsubslist (map (fn (y,z) =>(y,(subsvar (Unknown n) x z))) L)
          (subsvar (Unknown n) x t));

fun testfireusubs t = testselfsubslist (rev (bubble (!USUBS))) t;


datatype Sequent = Seq of (((Term*(int list)) list)*((Term*(int list)) list));

datatype Proof =

    Goal of (int*Sequent) |

    Node of (int*Sequent*(Proof list)) |

    Reference of (int*Sequent*string);

(* sequent display *)

(* display lists of terms *)

val RELATIVENUMBERING = ref true;

fun proplistdisplay n nil = "" |

   proplistdisplay n ((P,G)::L) =

   let val LINE = if (!RELATIVENUMBERING)

   then makestring n else makestring(hd G) in

   (CURSOR:=0;"\n\n"^(LINE)^":  "^(display P)^
   (proplistdisplay (n+1) L)
)
   end;

fun proplistdisplay2 n nil = "" |

   proplistdisplay2 n ((P,G)::L) =

   let val LINE = if (!RELATIVENUMBERING)

   then ((makestring n)^"*") else makestring(hd G) in

   (CURSOR:=0;"\n\n"^(LINE)^":  "^(display (Negation P))^
   (proplistdisplay2 (n+1) L)
)
   end;

val ONECONCDISPLAY = ref true;

fun oneconcdisplaytoggle() = ONECONCDISPLAY := not(!ONECONCDISPLAY);

fun seqdisplay2 (Seq(L,M)) =

(proplistdisplay 1 L)^(if M=nil then  "\n\n---------\n\n_|_" else "\n\n--------"^(proplistdisplay 1 M)^"\n\n");

fun seqdisplay1 (Seq(L,M)) =

(proplistdisplay 1 L)^(if M=nil then "" else(proplistdisplay2 2 (tl M)))^(if M=nil then  "\n\n--------\n\n_|_" else "\n\n--------\n\n"^(proplistdisplay 1 [hd M])^"\n\n");

fun seqdisplay x = if (!ONECONCDISPLAY) then seqdisplay1 x else seqdisplay2 x;

val NEWSERIAL = ref 0;

fun nextserial() = (NEWSERIAL:=(!NEWSERIAL)+1;(!NEWSERIAL));

fun newprop P = (P,[nextserial()]);

fun makesequent L M = 
Seq(map newprop (map parseprop L),map newprop (map parseprop M));

(* the proof under consideration *)

val THEPROOF = ref (Goal(0,Seq(nil,nil)));  


(* the master theorem list -- needed here because information about
it goes into records of theory state *)

val THEOREMS = ref (nil:((string*(Sequent*Proof))list));

(* index counter for sequent lines -- appears here as part of theory
state *)

val SEQSERIAL = ref 0;

(* lemmas in use in (or proved during) current proof; 
protected from being renamed *)

val CURRENT=ref(nil:(string list));

(* index of line numbers in proof at which unknown variables are introduced *)

val UNKNOWNINDEX = ref (nil:((int*int)list));

(* the list of axioms; permanently protected from renaming  *)

val AXIOMS=ref (nil:(string list));

(* prover state history list *)

val HISTORY = ref [((!BOUND),(!FREE),(!SEQSERIAL),(!NEWSERIAL),(!USUBS),(!THEPROOF),length(!TERMDEFS),length(!PROPDEFS),length(!THEOREMS),(!CURRENT),(!UNKNOWNINDEX),length(!AXIOMS),length(!OPERATORS),length(!BINDERS))];

val REMEMBER = ref true;

fun backup() = if (!REMEMBER) then HISTORY:=((!BOUND),(!FREE),(!SEQSERIAL),(!NEWSERIAL),(!USUBS),(!THEPROOF),length(!TERMDEFS),length(!PROPDEFS),length(!THEOREMS),(!CURRENT),(!UNKNOWNINDEX),length(!AXIOMS),length(!OPERATORS),length(!BINDERS))::(!HISTORY) else ();

fun noremember() = REMEMBER:=false;

fun remember() = REMEMBER:= true;

fun restorelength n nil = nil |

restorelength n (x::L) = if length (x::L) <= n then (x::L)
else restorelength n L;


(* with some care I can presumably define a forward() command as well *)



(* access to goals in the proof tree *)

fun isgoal (Goal (n,s)) = true |

isgoal x = false;

fun hasgoal (Goal (n,s)) = true |

hasgoal (Node(n,s,L)) = Some hasgoal L |

hasgoal (Reference(n,s,th)) = false;

fun getlineno (Goal(n,s)) = n |

getlineno (Node(n,s,L)) = n |

getlineno (Reference(n,s,th)) = n;

fun thegoal (Goal(n,s)) = Goal(n,s) |

thegoal (Node(n,s,nil)) = Goal(1,Seq(nil,nil)) |

thegoal (Node(n,s,(x::L))) = thegoal x |

thegoal (Reference(n,s,th)) = Goal(1,Seq(nil,nil));

(* proofact applies function f to line "line" in the proof
which is the final argument *)

fun proofact line f (Goal(n,s)) = 

if n = line then f(Goal(n,s)) else Goal(n,s) |

proofact line f (Reference(n,s,th)) = if n=line then f(Reference(n,s,th))

   else Reference(n,s,th) |

proofact line f (Node(n,s,L)) =

   if line = n then f(Node(n,s,L))

   else if line < n then Node(n,s,L)

   else Node(n,s,map (proofact line f) L); 

fun currentline() = getlineno(thegoal(!THEPROOF));

(* val UNKNOWNINDEX = ref (nil:((int*int)list)); *)

fun getnewunknown() = (FREE:=(!FREE)+1;
   UNKNOWNINDEX:=(!FREE,currentline())::(!UNKNOWNINDEX);
   Unknown(!FREE));

fun newunknownvarslist n =

   if n<=0 then nil else (newunknownvarslist (n-1))@[getnewunknown()];

fun match (Bound m) (Bound n) = 

     if find (Bound m) (!MATCHES) = nil then

     if find (Bound n) (map (fn (x,y)=>(y,x))(!MATCHES)) = nil

     then (MATCHES:=(Bound m,Bound n)::(!MATCHES);true)

     else false

     else Bound n = hd(find (Bound m) (!MATCHES)) |

(* matching of binding structure is bijective and completely rigid *)

match (Bound m) x = false |

match x (Bound m) = false |

match (Free m) (Unknown n) = 
    if find n (!USUBS) <> nil

    then match (Free m) (hd(find n (!USUBS)))
      else if find (Free m) (!MATCHES) = nil 
    then (MATCHES:=(Free m,Unknown n)::(!MATCHES);paircheck())
    else
    topalpha (Unknown n) (hd(find (Free m) (!MATCHES))) |
match (Unknown m) (Unknown n) = 
    if find n (!USUBS) <> nil
    then match (Unknown m) (hd(find n (!USUBS)))
    else if find (Unknown m) (!MATCHES) = nil 
    then (MATCHES:=(Unknown m,Unknown n)::(!MATCHES);paircheck())
    else topalpha (Unknown n) (hd(find (Unknown m) (!MATCHES))) |

match t (Unknown n) =

   if quietly Parseerror t then false else 

   if find n (!USUBS) <> nil 

   then match t (hd(find n (!USUBS))) else

   let val M = (newunknownvarslist(length(freevarlist t)))

   in 

   let val T = topsubslist (freevarlist t) M t

   in

   (USUBS:=(n,T)::(!USUBS);match t T) end end

    |   

(*   let val M = (subslist (freevarlist t) 
     (newunknownvarslist (length(freevarlist t)))) t in
   (USUBS:=(n,M)::(!USUBS);
   match t M) end | *)

   match (Negation T) (Negation U) = match T U |

   match (Infix(T,",",U)) (Infix(V,",",W)) =

   match T V andalso match U W |

   match t (Infix(T,",",U)) =

   match (Prefix("p1",[t])) T andalso

   match (Prefix("p2",[t])) U |

   match (Free m) t = 

   if quietly Parseerror t then false else

   if find (Free m) (!MATCHES) = nil

   then (add (Free m) t;paircheck())

   else topalpha t (hd(find (Free m) (!MATCHES))) |

   match (Unknown m) t = if quietly Parseerror t then false else

   if find (Unknown m) (!MATCHES) = nil

   then (add (Unknown m) t;paircheck())

   else topalpha t (hd(find (Unknown m) (!MATCHES))) |

   match (PredVar(n,nil)) t = 
   if quietly Parseerror t then false else
   if t = PredVar(n,nil) then true else
   if find n (!PROPMATCHES) = nil

   then (PROPMATCHES:=(n,t)::(!PROPMATCHES);true)

   else topalpha t (hd(find n (!PROPMATCHES))) |

   match (Prefix("p1",[T])) t = 

      if isprojvar T then 
   if quietly Parseerror t then false else
   if find (Prefix("p1",[T])) (!MATCHES) = nil

   then (add (Prefix("p1",[T])) t;paircheck())

   else topalpha t (hd(find (Prefix("p1",[T])) (!MATCHES))) 

   else (fn (Prefix("p1",[U])) => match T U | x=>false) t |

   match (Prefix("p2",[T])) t = 

    if isprojvar T then 
   if quietly Parseerror t then false else
   if find (Prefix("p2",[T])) (!MATCHES) = nil

   then (add (Prefix("p2",[T])) t;paircheck())

   else topalpha t (hd(find (Prefix("p2",[T])) (!MATCHES)))

   else (fn (Prefix("p2",[U])) => match T U|x=>false) t |

(* of course predicate variable matching can be much more general than
this but it is also quite hard and little used in the prover work so far *)

   match (PredVar(m,L)) (PredVar(n,M)) =

   m=n andalso listmatch L M |

   match (Prefix(s,L)) (Prefix(t,M)) = (s=t andalso listmatch L M) 

      orelse ((find s (!PROPDEFS) <> nil andalso
      match (usepropdef(Prefix(s,L))) ((Prefix(t,M))))
      orelse (find s (!TERMDEFS) <> nil andalso
      match (usetermdef(Prefix(s,L))) ((Prefix(t,M)))))

      orelse((find t (!PROPDEFS) <> nil andalso
      match ((Prefix(s,L))) (usepropdef((Prefix(t,M)))))
      orelse (find s (!TERMDEFS) <> nil andalso
      match ((Prefix(s,L))) (usetermdef((Prefix(t,M)))))) |

   match (Infix(T,",",U)) V = match (Infix(T,",",U))

           (Infix(Prefix("p1",[V]),",",Prefix("p2",[V]))) |

   match (Infix(T,s,U)) (Infix(V,t,W)) = 
         s=t andalso match T V andalso match U W 

         orelse ((find s (!PROPDEFS) <> nil andalso
      match (usepropdef(Infix(T,s,U))) ((Infix(V,t,W))))
      orelse (find s (!TERMDEFS) <> nil andalso
      match (usetermdef(Infix(T,s,U))) ((Infix(V,t,W)))))

      orelse ((find t (!PROPDEFS) <> nil andalso
      match ((Infix(T,s,U))) (usepropdef((Infix(V,t,W)))))
      orelse (find t (!TERMDEFS) <> nil andalso
      match ((Infix(T,s,U))) (usetermdef((Infix(V,t,W)))))) |

   match (Binder(s,T,U)) (Binder(t,V,W)) =

    s=t andalso match T V andalso match U W 

    (* last condition is probably redundant now that Parseerror is
    used to check everything admitted to match with a free or unknown
    variable or projection of same.  No,  it's not.  One needs to forbid
    variables appearing in the bound variable list of V from appearing
    in matches at all, because these are free even if formally bound in
    the usual sense.  *)

    andalso map (fn (Bound m,Bound n)=>false |
    (x,y)=>quietly (parseerror nil (freeboundvarlist V)) y)(!MATCHES)
     =  map (fn x=>false) (!MATCHES) |

   match x (Prefix(s,[T,U])) = match x (Infix(T,s,U)) |

   match (Prefix(s,[T,U])) x = match (Infix(T,s,U)) x |

   match (Prefix(s,L)) x =  ((find s (!PROPDEFS) <> nil andalso
      match (usepropdef (Prefix(s,L))) x)
      orelse (find s (!TERMDEFS) <> nil andalso
      match (usetermdef (Prefix(s,L))) x)) |

   match (Infix(T,s,U)) x = ((find s (!PROPDEFS) <> nil andalso
      match (usepropdef (Infix(T,s,U))) x)
      orelse (find s (!TERMDEFS) <> nil andalso
      match (usetermdef (Infix(T,s,U))) x)) |

   match x (Prefix(s,L)) =  ((find s (!PROPDEFS) <> nil andalso
      match (usepropdef (Prefix(s,L))) x)
      orelse (find s (!TERMDEFS) <> nil andalso
      match (usetermdef (Prefix(s,L))) x)) |

   match x (Infix(T,s,U)) = ((find s (!PROPDEFS) <> nil andalso
      match x (usepropdef (Infix(T,s,U))) )
      orelse (find s (!TERMDEFS) <> nil andalso
      match x (usetermdef (Infix(T,s,U))) )) |

   match x y = false

and listmatch nil nil = true |

   listmatch (x::L) (y::M) = match x y andalso listmatch L M |

   listmatch x y = false;

val OLDFREE = ref (!FREE);

val OLDBOUND = ref (!BOUND);

(* diversified variables here too:  the correct handling of bound 
variable matches requires it. *)

fun topmatch t u = (OLDFREE:=(!FREE);
    OLDBOUND:=(!BOUND);MATCHES:=nil;PROPMATCHES:=nil;
     let val M = match 
(diversify t) (diversify u)
 in (FREE:=(!OLDFREE);BOUND:=(*(!OLDBOUND)*)0;M) end);

fun matchtest1 T U = (updatefree (parseterm U);topmatch (checkterm(parseterm T)) (checkterm(parseterm U)));

fun matchtest2 T U = (updatefree (parseprop U);topmatch (parseprop T) (parseprop U));



(* global substitutions, needed for setunknown *)

fun rewriteseq v t (Seq(L,M)) =
    Seq(map (fn (x,y)=>(topsubsvar v t x,y)) L, map (fn (x,y)=>(topsubsvar v t x,y)) M);

fun varline (Unknown n) = safefind 1 n (!UNKNOWNINDEX) |

varline v = 1;

fun rewriteproof v t (Goal(n,s)) = Goal(n,rewriteseq v t s) |

rewriteproof v t (Node(n,s,L)) = Node(n,rewriteseq v t s,
                            map (rewriteproof v t) L) |

rewriteproof v t (Reference(n,s,th)) = Reference(n,rewriteseq v t s,th);

fun globalrewrite v t = 

                       (backup();

                       updatefree t;
                       (* updatebound t ;*)
                       THEPROOF:=proofact (varline v) 
                                (rewriteproof v t) (!THEPROOF);
                       if freeindex v = (!FREE) 
                       andalso freeindex t < (!FREE)

                       then (UNKNOWNINDEX:=drop (!FREE) (!UNKNOWNINDEX);
                            FREE:=(!FREE)-1) 
                       else ());


fun selfsubslist nil = (USUBS:=nil) |

selfsubslist ((n,x)::L) = 

     if freeindex x >= n then (Say "Circularity error";USUBS:=nil)

     else (((* Say ("Rewriting U"^(makestring n)^" as "^(display x)); *)

globalrewrite (Unknown n) x);(selfsubslist (map (fn (y,z) =>(y,(subsvar (Unknown n) x z))) L)));

fun fireusubs t = selfsubslist (rev (bubble (!USUBS)));

(* rotate a list of proofs to get a goal to the front *)



fun nogoals L = None hasgoal L;

fun rotate1 L = if L=nil then nil

   else (tl L)@[hd L];

fun rotate L = if nogoals L then L

   else if hasgoal (hd L) then L

   else rotate(rotate1 L);

fun autorotate (Goal (n,s)) = Goal (n,s) |

autorotate (Node(n,s,L)) = Node(n,s,rotate(map autorotate L)) |

autorotate (Reference(n,s,th)) = Reference(n,s,th);

fun Autorotate() = THEPROOF:=autorotate (!THEPROOF);

(* the previous function brings a goal to the first and highest
position in the proof tree *)

(* prover operations usually act on this goal; when there is no
such goal there is a complete proof *)


(* list of propositions in sequents actually used in a proof *)

fun genlist1 (Seq(L,M)) = 
    union (unionlist (map p2 L)) (unionlist (map p2 M));

fun genlist (Goal (n,s)) = genlist1 s |

genlist (Node(n,Seq(L,(Infix(T,"=",U),g)::M),nil)) =

    if topalpha T U then g

    else if L<>nil andalso topalpha (p1(hd L)) (Infix(T,"=",U))

    then union (p2(hd L)) g

    else genlist1 (Seq(L,(Infix(T,"=",U),g)::M)) |

genlist (Node(n,Seq(L,M),nil)) =

    if L<>nil andalso M<>nil andalso topalpha(p1(hd L))(p1(hd M))

    then union (p2(hd L)) (p2(hd M))

    else genlist1 (Seq(L,M)) |

genlist (Node(n,s,L)) = unionlist (map genlist L) |

genlist (Reference(n,s,th)) = genlist1 s;

fun prune1 L nil = nil |

prune1 L ((P,G)::M) = if foundin (hd G) L

    then (P,G)::(prune1 L M)

    else prune1 L M;

fun prune2 A (Seq(L,M)) = Seq(prune1 A L,prune1 A M);

fun prune L (Goal(n,s)) = Goal(n,prune2 L s) |

prune L (Node(n,s,M)) = Node(n,prune2 L s,map (prune L) M) |

prune L (Reference(n,s,th)) = Reference(n,prune2 L s,th);

fun getlineno (Goal(n,s)) = n |

getlineno (Node(n,s,L)) = n |

getlineno (Reference(n,s,th)) = n;

fun sortprooflist L = map p2 (bubble (map (fn x=>(getlineno x,x)) L));

fun sortproof (Node(n,s,L)) = Node(n,s,sortprooflist(map sortproof L)) |

  sortproof x = x;


fun autoprune() = (backup();THEPROOF := autorotate(sortproof(prune (genlist(!THEPROOF)) (!THEPROOF))));

val ONECONC = ref true;  (* this is left on the OneConclusion mode, which is now actually obsolete, for benefit of current students.  The next generation will get the ManyConclusions mode
with the modified display and a briefing about multiple conclusions *)

(* coerce a sequent to one-conclusion form *)

fun dubneg (Negation(Negation P)) = P |

  dubneg t = t;

fun oneconk ((n,(Seq(L,(x::M))))) = 

   if (!ONECONC) then

   Goal(n,Seq(L@(map (fn (P,G)=>(dubneg(Negation P),G)) M),[x]))

   else Goal(n,Seq(L,x::M)) |

   oneconk x = Goal x;

fun sameseq (Seq(L,M)) (Seq(A,B)) =

   map p1 L = map p1 A andalso map p1 M = map p1 B;

fun pointless (Goal(n,s)) (Node(p,t,[Goal(m,u)])) = sameseq s t
andalso sameseq t u |

pointless x y = false;

fun Act f (Goal (n,s)) = let val G = f(n,s) in if pointless (Goal(n,s)) G

     then Goal(n,s) else G end |

Act f (Node(n,s,L)) = if L = nil then (Node(n,s,L))

else Node(n,s,(Act f (hd L))::(tl L)) |

Act f (Reference(n,s,th)) = (Reference(n,s,th));

fun lookat ((n,s)) = (
say (guistring "Begin sequent display");
say ("Line number "^(makestring n)^":\n\n");say(seqdisplay s);
say (guistring "End sequent display");
(Goal (n,s)));

val BOOKMARKS = ref (nil:((string*int) list));

fun getbookmark s = safefind 0 s (!BOOKMARKS);

fun bookmark0 name (n,s) = (BOOKMARKS:=(name,n)::(!BOOKMARKS);Goal(n,s));

(* put the two goal branches produced by the most recent rule application
in the other order.  It swaps their line numbering too.  Does nothing
when a branching rule has not just been applied.  Modified to act usefully
when there are more subgoals than two.  *)

fun swapgoals (Goal(n,s)) = Goal(n,s) |

(* swapgoals (Node(n,s,[Goal(p,u),Goal(q,v)])) = Node(n,s,[Goal(p,v),Goal(q,u)]) |

swapgoals (Node(n,s,nil)) = Node(n,s,nil) | *)

swapgoals (Node(n,s,(Goal(p,v)::L))) 
     = autorotate(Node(n,s,rotate1((Goal(p,v)::L)))) |

swapgoals (Node(n,s,nil)) = Node(n,s,nil) |

swapgoals (Node(n,s,(x::L))) = Node(n,s,((swapgoals x)::L)) |

swapgoals (Reference(n,s,th)) = Reference(n,s,th);

(* look at the current goal *)

(* lowercase version is just for undo *)

fun look() = (if hasgoal (!THEPROOF) then
(Act lookat (!THEPROOF))
else (say "Q. E. D.";(!THEPROOF));());

fun Look() = (fireusubs();
if hasgoal (!THEPROOF) then (
Act lookat (!THEPROOF))
else (say "Q. E. D.";(!THEPROOF));());

fun bookmark name = (Act (bookmark0 name) (!THEPROOF);Look());

fun putlast (Node(n,x,p::L)) = Node(n,x,L@[putlast p]) |

putlast S = S;

(* the nextgoal command puts the current goal last at every level;
I believe it is provable that repeated execution will scan the entire proof,
though some sequents may be repeated before the whole process is
finished *)

fun nextgoal() = (backup();THEPROOF:=autorotate(putlast(!THEPROOF));Look());


(* the undo function is delayed to here because it uses Look *)

fun undo() = (if (!HISTORY) = nil then Say "No undo information"

else if (!REMEMBER) = false then say "History has been turned off"

else (let val (b,f,sq,ns,u,p,td,pd,th,c,ui,a,lo,lb) = hd(!HISTORY) in

(BOUND:=b;FREE:=f;USUBS:=u;THEPROOF:=p;SEQSERIAL:=sq;NEWSERIAL:=ns;
TERMDEFS:=restorelength td (!TERMDEFS); PROPDEFS:=restorelength pd (!PROPDEFS);
THEOREMS:=restorelength th (!THEOREMS);CURRENT:=c;UNKNOWNINDEX:=ui;
AXIOMS:=restorelength a (!AXIOMS);
OPERATORS:=restorelength lo (!OPERATORS); BINDERS:=restorelength lb (!BINDERS);HISTORY:=tl(!HISTORY))

end); look());


fun setunknown n t = 

if Parseerror (parseterm t) then Say "Parse errors in input block rewrites"

else if (!USUBS) <> nil

then Say "Unfired global substitutions block this command"

else (if freeindex (parseterm t) < n

then 

globalrewrite (Unknown n) (parseterm t)

else Say "Circularity error";Look());

fun setpredvar n t = 

if Parseerror (parseterm t) then Say "Parse errors in input block rewrites"

else if (!USUBS) <> nil

then Say "Unfired global substitutions block this command"

else (globalrewrite (PredVar(n,nil)) (parseterm t);Look());

(* act on the current goal *)

fun act f = (backup();THEPROOF:=(Act f (!THEPROOF));Autorotate();
if (!ONECONC) then THEPROOF:= Act oneconk (!THEPROOF) else ();
Look());

fun nextseq() = (SEQSERIAL:=(!SEQSERIAL)+1;(!SEQSERIAL));

(* basic logging functions *)

(* this block may need to be relocated earlier *)

(* this is a dummy -- to be replaced with snapshot from marcelsequent
eventually *)

fun logseq (n,s) = 
(if (!LOGGING) andalso s <> Seq(nil,nil) then 
(writelogline "\n(* Sequent snapshot:\n";
    TextIO.output((!LOGFILE),seqdisplay s);writelogline "\n*)\n\n";s) else s;
    Goal(n,s));

fun snapshot() = (Act logseq (!THEPROOF);());

fun logcomment s = (
     writelogline ("\n\n(* "^(makestring(!LINENUMBER))^
     "\n\n"^s^"*)\n\n");snapshot());

(* hardcomment1 is for all lines of a hard comment except the last;
it omits the snapshot *)

fun hardcomment1 s = (
     writelogline ("\n\n(* "^(makestring(!LINENUMBER))^
     " *)\n\nhardcomment \""^s^"\";\n\n"));

fun hardcomment s = (
     writelogline ("\n\n(* "^(makestring(!LINENUMBER))^
     " *)\n\nhardcomment \""^s^"\";\n\n");snapshot());

fun reportcommand ((Mnemonic m)::L) = if (!LOGGING) = false 
   andalso (!DEMO)=false
   then ()

   else (nextline();writelogline(
   (if 

(* commands before which we place a return *)

   m = "Start" orelse m = "DefineProp" orelse m="DefineTerm"
   orelse m = "DefSent" orelse m="StartSequent"
   orelse m = "Declarepredicate" orelse m="Declarefunction"
   orelse m = "Definepredicate" orelse m = "Definefunction"

   orelse m = "Constructive" orelse m = "Extensional"
   orelse m = "NoClasses" orelse m = "NoPairs" orelse m = "Inf"
   orelse m = "Unknowns" orelse m = "Axiom"

   then "\n\n"^(linenumber()) else "")
   ^(linedisplay ((Mnemonic m)::L))^(if

(* commands after which we place a return *)
 
   m = "Done" orelse m = "UseThm" orelse m = "NextGoal"
   orelse m = "UseThm2" orelse m = "Reflexiveeq" 
   orelse m="Cut" orelse m="Cut2"
   orelse m = "Cutr" orelse m = "Cutl"
    orelse m = "ThmCut"
   orelse m = "w" orelse m = "w2" orelse m = "su" orelse m = "NameSequent" orelse
   m = "Start" orelse m = "DefineProp" orelse m="DefineTerm"
   orelse m = "Declarepredicate" orelse m="Declarefunction"
   orelse m = "Definepredicate" orelse m = "Definefunction"
   
   orelse m = "DefSent" orelse m = "Axiom" orelse m ="StartSequent"

   then "\n"^(nextlinenumber()) else ""))) |

   reportcommand x = ();


fun Say s = (say (guistring "Marcel:  ");say s;say (guistring "..."); 
if (!LOGGING) then (say ("In line number "^(makestring(1+(!LINENUMBER))));
logcomment s) else(); 
pause();());

fun rewritefree (Seq((Infix(Free m,"=",Free n),G)::L,M)) =

    if m=n then Seq(L,M) else

    Seq(map (fn (x,y)=>(topsubsvar (Free(max(m,n))) (Free(min(m,n))) x,
                       (nextserial()::
                       (if foundin (Free(max(m,n))) (freevarlist x) then (y@G)
                        else y)))) L,
    map (fn (x,y)=>(topsubsvar (Free(max(m,n))) (Free(min(m,n))) x,
                       (nextserial()::
                       (if foundin (Free(max(m,n))) (freevarlist x) then (y@G)
                         else y)))) M) |

rewritefree (Seq((Infix(Free m,"=",z),G)::L,M)) =

    if foundin (Free m) (freevarlist z) then

    (Say "Free variable would not be eliminated";
    (Seq((Infix(Free m,"=",z),G)::L,M)))

    else Seq(map (fn (x,y)=>(topsubsvar (Free m) z x,
                       (nextserial()::
                       (if foundin (Free m) (freevarlist x) then (y@G)
                         else y)))) L,
    map (fn (x,y)=>(topsubsvar (Free m) z x,
                       (nextserial():: (if foundin (Free m) (freevarlist x) then (y@G) else y)))) M) |

rewritefree (Seq((Infix(z,"=",Free m),G)::L,M)) =

    if foundin (Free m) (freevarlist z) then

    (Say "Free variable would not be eliminated";
    (Seq((Infix(z,"=",Free m),G)::L,M)))    

    else Seq(map (fn (x,y)=>(topsubsvar (Free m) z x,
                       (nextserial()::(if foundin (Free m) (freevarlist x) then (y@G) else y)))) L,
    map (fn (x,y)=>(topsubsvar (Free m) (z) x,
                       (nextserial()::(if foundin (Free m) (freevarlist x) then (y@G) else y)))) M) |

rewritefree x = (Say "No opportunity to rewrite";x);

val CONSTRUCTIVE = ref false;

fun constructivize (Seq(L,x::M)) = 

if (!CONSTRUCTIVE) then Seq(L,[x]) else Seq(L,x::M) |

constructivize x = x;

(* make a node from a list of sequents determined by action of
a function f on a goal sequent *)

(* here is the very slight modification required for constructive logic:
discard conclusions after the first before applying a logical rule *)

fun makenode f (n,s) = 
let val S = constructivize s in
Node(n,S, map (fn x=>Goal(nextseq(),x)) (f S)) end;

fun action f = act (makenode f);

fun RewriteFree() = action ((fn x=>[rewritefree x]));

(* the list of theorems used (or proved as lemmas) during the current
proof *)


fun startsequent L M = (backup();SEQSERIAL:=0;NEWSERIAL:=0;
     BOUND:=0;FREE:=0;CURRENT:=nil;BOOKMARKS:=nil;UNKNOWNINDEX:=nil;

     if Some Parseerror (map parseprop (L@M)) then 
     Say "Parse error prevents starting sequent"
     else(
     (*map updatebound (map parseprop (L@M)); *)
     map updatefree (map parseprop(L@M));
     THEPROOF:=Goal(nextseq(),makesequent L M);Look()));

fun start P = startsequent nil [P];

(* a plan to build the simple rules in a systematic way *)

(* it's not quite perfect because it doesn't handle implication
on the right in one step *)

(* the general approach will use lists of pairs of lists of propositions
not a pair of lists of lists as here  *)

(* this is now fixed:  I have the correct general framework *)

fun pack y L = map (fn x => (x,((nextserial())::y))) L;

fun pack2 L = map (fn (x,y)=>(x,(nextserial())::y)) L;

fun packpair z (x,y) = (pack z x,pack z y);

fun leftpropaction f (Seq(x::L,M)) =

    (map (fn y=>Seq((pack (p2 x) (p1 y))@(pack2 L),
                (pack (p2 x) (p2 y))@(pack2 M))) (f(p1 x))) |


leftpropaction f x = [x];

fun leftact f = action (leftpropaction f);

fun rightpropaction f (Seq(L,x::M)) =

    (map (fn y=>Seq((pack (p2 x) (p1 y))@(pack2 L),
                (pack (p2 x) (p2 y))@(pack2 M))) (f(p1 x))) |


rightpropaction f x = [x];

(* these functions enable the rewrite rules to be incorporated into the
logical framework *)

fun left2propaction f (Seq(x::y::L,M)) =

    (map (fn z=>Seq((pack (union(p2 x)(p2 y)) (p1 z))@(pack2 L),
                (pack (union(p2 x)(p2 y)) (p2 z))@(pack2 M))) (f(p1 x)(p1 y))) |


left2propaction f x = [x];

fun left2act f = action(left2propaction f);

fun bothpropaction f (Seq(x::L,y::M)) =

    (map (fn z=>Seq((pack (union(p2 x)(p2 y)) (p1 z))@(pack2 L),
                (pack (union(p2 x)(p2 y)) (p2 z))@(pack2 M))) (f(p1 x)(p1 y))) |


bothpropaction f x = [x];

fun bothact f = action(bothpropaction f);

fun rightact f = action (rightpropaction f);

fun maybeusetermdef x = if quietly usetermdef x <> x then usetermdef x else x;

(* the following code embodies the logic of the prover;
it is so dense as to certainly contain bugs! *)

(* Here I have incorporated some maneuvers which are in special functions
in the original version *)


fun leftlists (Infix(P,"&",Q)) = [([P,Q],nil)] |
leftlists (Infix(P,"v",Q)) = [([P],nil),([Q],nil)] |
leftlists (Infix(P,"->",Q)) = [(
     if (!CONSTRUCTIVE) then [(Infix(P,"->",Q))] else nil,[P]),([Q],nil)] |
leftlists (Infix(P,"<-",Q)) = [(
     if (!CONSTRUCTIVE) then [(Infix(P,"<-",Q))] else nil,[Q]),([P],nil)] |
leftlists (Negation P) = [(if (!CONSTRUCTIVE) then [Negation P]
     else nil,[P])] |
leftlists (Infix(P,"==",Q)) = 
 [([Infix(P,"->",Q),Infix(Q,"->",P)],nil)] |
leftlists (Infix(P,"=/=",Q)) =[([P],[Q]),([Q],[P])] | 
leftlists (Binder("A",Bound n,P)) =
  [([topsubsvar (Bound n)(getnewunknown()) P, Binder("A",Bound n,P)],nil)] |
leftlists (Binder("E",Bound n,P)) =
  [([topsubsvar (Bound n)(getnewfree())P],nil)]   |

(* this might seem to be compromised by stiffening up the
binding conditions, but it isn't:  the bound is simply forbidden
to contain any bound variables in the situation in which this rule
applies *)

leftlists (Binder("A",(Infix(A,":",B)),P)) =

let val T = Infix(A,":",B) in


let val T1 = freeboundvarlist T in
let val L = newunknownvarslist(length(T1)) in
[([Binder("A",T,P)],[topsubslist(T1) L(Infix(A,"E",B))]),
([topsubslist (T1) L P, Binder("A",T,P)],nil)]

end end end

|

leftlists (Binder("A",T,P)) =


let val T1 = freeboundvarlist T in
let val L = newunknownvarslist(length(T1)) in
[([topsubslist (T1) L P, Binder("A",T,P)],nil)]

end end

|


leftlists (Binder("E",Infix(A,":",B),P)) =
let val T = Infix(A,":",B) in
let val T1 = freeboundvarlist T in
let val L = newfreevarslist(length(T1)) in

[([topsubslist (T1) L (Infix(A,"E",B)),
(topsubslist (( T1)) L P)],nil)]

end end end |

leftlists (Binder("E",T,P)) =

let val T1 = freeboundvarlist T in
let val L = newfreevarslist(length(T1)) in

[([(topsubslist (( T1)) L P)],nil)]

end end |

leftlists (Infix(x,"E",Binder("",Bound n,P))) =

[([if stratified (Binder("",Bound n,P)) then (topsubsvar (Bound n) x P) else (
Infix(x,"E",Binder("",Bound n,P))) ],nil)] |

leftlists (Infix(x,"E",Binder("",Infix(Bound n,":",B),P))) =

[(if stratified (Binder("",Infix(Bound n,":",B),P)) then 
[Infix(x,"E",(* topsubsvar (Bound n) x *) B),(topsubsvar (Bound n) x P)] else 
[(
Infix(x,"E",Binder("",Infix(Bound n,":",B),P))) ],nil)] |

leftlists (Infix(x,"E",Binder("",Infix(A,":",B),P))) =
let val T =Infix(A,":",B) in
let val T1 = freeboundvarlist T

in let val L = newfreevarslist(length(T1)) in

[(if stratified (Binder("",T,P)) then [
Infix(x,"=",topsubslist
(( T1)) L A),
Infix(x,"E",topsubslist
(( T1)) L B),
(topsubslist (( T1)) L P)] else [(Infix(x,"E",(Binder("",T,P))))],nil)] end end end|

leftlists (Infix(x,"E",Binder("L",Infix(T,":",A),P))) =
leftlists (Infix(x,"E",Binder("",Infix(T,",",P),Infix(T,"E",A)))) |

leftlists (Infix(x,"E",Binder("L",T,P))) =
leftlists (Infix(x,"E",Binder("",Infix(T,",",P),Infix(T,"=",T)))) |

leftlists (Infix(x,"E",Binder("",T,P))) =

let val T1 = freeboundvarlist T

in let val L = newfreevarslist(length(T1)) in

[(if stratified (Binder("",T,P)) then [Infix(x,"=",topsubslist
(( T1)) L T),
(topsubslist (( T1)) L P)] else [(Infix(x,"E",(Binder("",T,P))))],nil)] end end |

leftlists (Infix(x,"E",Prefix(s,[T,U]))) =leftlists (Infix(x,"E",Infix(T,s,U)))|

leftlists (Infix(x,"E",Prefix(s,L))) = 

if find s (!TERMDEFS) <> nil then leftlists (Infix(x,"E",usetermdef(Prefix(s,L))))
else [([Infix(x,"E",Prefix(s,L))],nil)] |

leftlists (Infix(x,"E",Infix(T,s,U))) = if find s (!TERMDEFS) <> nil then leftlists (Infix(x,"E",usetermdef(Prefix(s,[T,U]))))
else [([Infix(x,"E",Infix(T,s,U))],nil)] |

leftlists (Infix(T,"=",Infix(U,"`",V))) =

leftlists((BOUND:=0;updatebound (Infix(T,"=",Infix(U,"`",V)));
let val X = getnewbound() in
Infix(
Binder("A",X,Infix(Infix(Infix(V,",",X),"E",U) ,"==", Infix(X,"=",T))),
"v",(Infix(T,"=",Infix(U,"`",V))))

end))|
leftlists (Infix(Infix(U,"`",V),"=",T)) =

leftlists((BOUND:=0;updatebound (Infix(T,"=",Infix(U,"`",V)));
let val X = getnewbound() in
Infix(
Binder("A",X,Infix(Infix(Infix(V,",",X),"E",U) ,"==", Infix(X,"=",T))),
"v",(Infix(T,"=",Infix(U,"`",V))))

end))|


leftlists (Infix(Infix(T,",",U),"=",Infix(V,",",W))) =

[([Infix(T,"=",V),Infix(U,"=",W)],nil)] |

leftlists (Infix(Infix(T,",",U),"=",X)) =

[([Infix(T,"=",Prefix("p1",[X])),Infix(U,"=",Prefix("p2",[X]))],nil)]
 |

leftlists (Infix(X,"=",Infix(V,",",W))) =

leftlists (Infix(Infix(V,",",W),"=",X)) |

leftlists (Infix(Binder("",Bound m,P),"=",Binder("",Bound n,Q))) =

(* if topalpha (Binder("",Bound m,P))(Binder("",Bound n,Q))

then nil else *)
(BOUND:=0;updatebound (Infix(Binder("",Bound m,P),"=",Binder("",Bound n,Q)));
let val X = getnewbound() in

if stratified (Binder("",Bound m,P)) andalso stratified (Binder("",Bound n,Q))
then
[([Binder("A",X,Infix(topsubsvar (Bound m) X P,"==",topsubsvar (Bound n) X Q)),(Infix(Binder("",Bound m,P),"=",Binder("",Bound n,Q)))],nil)]

else let val T = Bound m and U = Bound n in

[([Binder("A",X,Infix(Infix(X,"E",(Binder("",T,P))),"==",(Infix(X,"E",(Binder("",U,Q)))))),(Infix(Binder("",T,P),"=",Binder("",U,Q)))],nil)] end

end) |

leftlists (Infix(Binder("",T,P),"=",Binder("",U,Q))) =

(* if topalpha (Binder("",Bound m,P))(Binder("",Bound n,Q))

then nil else *)
(BOUND:=0;updatebound (Infix(Binder("",T,P),"=",Binder("",U,Q)));
let val X = getnewbound() in
[([Binder("A",X,Infix(Infix(X,"E",(Binder("",T,P))),"==",(Infix(X,"E",(Binder("",U,Q)))))),(Infix(Binder("",T,P),"=",Binder("",U,Q)))],nil)]

end) |

leftlists (Infix(x,"=",y)) = 
if (quietly usetermdef x<> x) orelse (quietly usetermdef y<>y) 
then leftlists (Infix(maybeusetermdef x,"=",maybeusetermdef y))

else (BOUND:=0;updatebound (Infix(x,"=",y)); let val X = getnewbound() in

[([Binder("A",X,Infix(Infix(x,"E",X),"==",Infix(y,"E",X))),Infix(x,"=",y)],nil)] end) |

leftlists (Prefix(s,L)) = if find s (!PROPDEFS)<>nil
then [([usepropdef(Prefix(s,L))],nil)] else [([fixinfix(Prefix(s,L))],nil)]|
leftlists (Infix(T,s,U)) = (leftlists (Prefix(s,[T,U]))) |

leftlists x = (Say "No left rule applies.";[([x],nil)]);

fun rightlists (Infix(P,"&",Q)) = [(nil,[P]),(nil,[Q])] |
rightlists (Infix(P,"v",Q)) = [(nil,[P,Q])] |
rightlists (Infix(P,"->",Q)) = [([P],[Q])] |
rightlists (Infix(P,"<-",Q)) = [([Q],[P])] |
rightlists (Infix(P,"==",Q)) = [([P],[Q]),([Q],[P])] |
rightlists (Infix(P,"=/=",Q)) = [([P,Q],nil),(nil,[P,Q])] |
rightlists (Negation P) = [([P],(* if (!ONECONC) then [Negation P] else *) nil)]
|
rightlists (Binder("A",Bound n,P)) =
[(nil,[topsubsvar (Bound n) (getnewfree()) P])] |

rightlists (Binder("E",Bound n,P)) =
[(nil,[topsubsvar (Bound n) (getnewunknown()) P,(Binder("E",Bound n,P))])] |

rightlists (Binder("A",Infix(A,":",B),P)) =
let val T = Infix(A,":",B) in
let val T1 = freeboundvarlist T in
let val L = newfreevarslist(length(T1)) in
[([topsubslist (T1) L (Infix(A,"E",B))]
 ,[topsubslist (( T1)) L P])] end end end |

rightlists (Binder("A",T,P)) =
let val T1 = freeboundvarlist T in
let val L = newfreevarslist(length(T1)) in
[(nil,[topsubslist (( T1)) L P])] end end |

rightlists (Binder("E",Infix(A,":",B),P)) =
let val T = Infix(A,":",B) in
let val T1 = freeboundvarlist T in

let val L = newunknownvarslist (length(T1)) in
[(nil,[topsubslist (( T1)) L (Infix(A,"E",B)),(Binder("E",T,P))]),
(nil,[topsubslist (( T1)) L P,(Binder("E",T,P))])] end end end |

rightlists (Binder("E",T,P)) =
let val T1 = freeboundvarlist T in

let val L = newunknownvarslist (length(T1)) in
[(nil,[topsubslist (( T1)) L P,(Binder("E",T,P))])] end end |

rightlists (Infix(x,"E",Binder("",Bound n,P))) =

[(nil,[if stratified (Binder("",Bound n,P)) then (topsubsvar (Bound n) x P) else (Infix(x,"E",Binder("",Bound n,P))) ])] |

rightlists (Infix(x,"E",Binder("",Infix(Bound n,":",B),P))) =

if stratified (Binder("",Infix(Bound n,":",B),P))

then [(nil,[Infix(x,"E", (* topsubsvar (Bound n) x *) B)]),
      (nil,[topsubsvar (Bound n) x P])
]

else [(nil,[(Infix(x,"E",Binder("",Infix(Bound n,":",B),P)))])] |


rightlists (Infix(x,"E",Binder("",Infix(A,":",B),P))) =

let val T = Infix(A,":",B)in
let val T1 = freeboundvarlist T in

let val L = newunknownvarslist(length(T1)) in

if stratified (Binder("",T,P))

then [(nil,[(Infix(x,"=",topsubslist (( T1)) L (A)))]),
      (nil,[(Infix(x,"E",topsubslist (( T1)) L (B)))]),
      (nil,[topsubslist (( T1)) L P])]

else [(nil,[Infix(x,"E",(Binder("",T,P)))])]

 end end end|


rightlists (Infix(x,"E",Binder("L",Infix(T,":",A),P))) =
rightlists (Infix(x,"E",Binder("",Infix(T,",",P),Infix(T,"E",A)))) |

rightlists (Infix(x,"E",Binder("L",T,P))) =
rightlists (Infix(x,"E",Binder("",Infix(T,",",P),Infix(T,"=",T)))) |


rightlists (Infix(x,"E",Binder("",T,P))) =
let val T1 = freeboundvarlist T in

let val L = newunknownvarslist(length(T1)) in

if stratified (Binder("",T,P))

then [(nil,[(Infix(x,"=",(topsubslist  (( T1))  L (T))))]),
      (nil,[topsubslist (( T1)) L P])]

else [(nil,[Infix(x,"E",(Binder("",T,P)))])]

 end end |

rightlists (Infix(x,"E",Prefix(s,[T,U]))) = rightlists (Infix(x,"E",Infix(T,s,U)))|

rightlists (Infix(x,"E",Prefix(s,L))) = 

if find s (!TERMDEFS)<>nil then rightlists (Infix(x,"E",usetermdef(Prefix(s,L))))
else [(nil,[Infix(x,"E",Prefix(s,L))])] |

rightlists (Infix(x,"E",Infix(T,s,U))) = if find s (!TERMDEFS)<>nil then rightlists (Infix(x,"E",usetermdef(Prefix(s,[T,U]))))
else [(nil,[Infix(x,"E",Infix(T,s,U))])] |

rightlists (Infix(T,"=",Infix(U,"`",V))) =

if topalpha T (Infix(U,"`",V)) then nil else

rightlists((BOUND:=0;updatebound (Infix(T,"=",Infix(U,"`",V)));
let val X = getnewbound() in
Infix(
Binder("A",X,Infix(Infix(Infix(V,",",X),"E",U) ,"==", Infix(X,"=",T))),
"v",(Infix(T,"=",Infix(U,"`",V))))

end))|

rightlists (Infix(Infix(U,"`",V),"=",T)) =

if topalpha T (Infix(U,"`",V)) then nil else

rightlists((BOUND:=0;updatebound (Infix(T,"=",Infix(U,"`",V)));
let val X = getnewbound() in
Infix(
Binder("A",X,Infix(Infix(Infix(V,",",X),"E",U) ,"==", Infix(X,"=",T))),
"v",(Infix(T,"=",Infix(U,"`",V))))

end))|


rightlists (Infix(Infix(T,",",U),"=",Infix(V,",",W))) =

if topalpha (Infix(T,",",U))(Infix(V,",",W)) then nil else

[(nil,[Infix(T,"=",V)]),(nil,[Infix(U,"=",W)])] |

rightlists (Infix(Infix(T,",",U),"=",X)) =

[(nil,[Infix(T,"=",Prefix("p1",[X]))]),(nil,[Infix(U,"=",Prefix("p2",[X]))])]
 |

rightlists (Infix(X,"=",Infix(V,",",W))) =

rightlists (Infix(Infix(V,",",W),"=",X)) |

rightlists (Infix(Binder("",Bound m,P),"=",Binder("",Bound n,Q))) =

if topalpha (Binder("",Bound m,P)) (Binder("",Bound n,Q)) then nil else

(BOUND:=0;updatebound(Infix(Binder("",Bound m,P),"=",Binder("",Bound n,Q))) ;
let val X = getnewbound() in

if stratified (Binder("",Bound m,P)) andalso stratified (Binder("",Bound n,Q))

then

[(nil,[Binder("A",X,Infix(topsubsvar (Bound m) X P,"==",topsubsvar (Bound n) X Q))])]

else

[(nil,[(Infix(Binder("",Bound m,P),"=",Binder("",Bound n,Q)))])]

end) |

rightlists (Infix(Binder("",T,P),"=",Binder("",U,Q))) =

if topalpha (Binder("",T,P)) (Binder("",U,Q)) then nil else

(BOUND:=0;updatebound (Infix(Binder("",T,P),"=",Binder("",U,Q)));
let val X = getnewbound() in

if stratified(Binder("",T,P)) andalso stratified(Binder("",U,Q))
then
[(nil,[Binder("A",X,Infix(
Infix(X,"E",Binder("",T,P)),
"==",
Infix(X,"E",Binder("",U,Q))))])]
else
[(nil,[(Infix(Binder("",T,P),"=",Binder("",U,Q)))])]

end) |

rightlists (Infix(x,"=",y)) = 

if topalpha x y then nil else

if quietly usetermdef x<> x orelse quietly usetermdef y<>y 
then (* rightlists (Infix(maybeusetermdef x,"=",maybeusetermdef y)) *)

[(nil,[(Infix(maybeusetermdef x,"=",maybeusetermdef y))])]

else (BOUND:=0;updatebound (Infix(x,"=",y));
let val X = getnewbound() in

[(nil,[Infix(getnewunknown(),"E",x),Infix(getnewunknown(),"E",y),Infix(x,"=",y)]),(nil,[Binder("A",X,Infix(Infix(X,"E",x),"==",Infix(X,"E",y))),Infix(x,"=",y)])] end) |
rightlists (Prefix(s,L)) = if find s (!PROPDEFS)<>nil then [(nil,[(usepropdef(Prefix(s,L)))])] else [(nil,[fixinfix(Prefix(s,L))])] |

rightlists (Infix(T,s,U)) = (rightlists (Prefix(s,[T,U]))) |

rightlists x = (Say "No right rule applies.";[(nil,[x])]);

fun rwllist mask (Infix(P,"=",Q)) T = [([Infix(P,"=",Q),toprewrite mask P Q T],nil)] |

rwllist mask (Infix(P,"==",Q)) T = [([Infix(P,"==",Q),toprewrite mask P Q T],nil)] |

rwllist mask x y = (Say "No left rewrite rule applies.";[([x,y],nil)]);

fun rwl mask = action (left2propaction (rwllist mask));

fun crwllist mask (Infix(P,"=",Q)) T = [([Infix(P,"=",Q),toprewrite mask Q P T],nil)] |

crwllist mask (Infix(P,"==",Q)) T = [([Infix(P,"==",Q),toprewrite mask Q P T],nil)] |

crwllist mask x y = (Say "No left rewrite rule applies.";[([x,y],nil)]);

fun crwl mask = action(left2propaction (crwllist mask));

fun rwrlist mask (Infix(P,"=",Q)) T = [([Infix(P,"=",Q)],[toprewrite mask P Q T])] |

rwrlist mask (Infix(P,"==",Q)) T = [([Infix(P,"==",Q)],[(toprewrite mask P Q T)])] |

rwrlist mask x y = (Say "No right rewrite rule applies.";[([x],[y])]);

fun rwr mask = action (bothpropaction (rwrlist mask));

fun crwrlist mask (Infix(P,"=",Q)) T = [([Infix(P,"=",Q)],[toprewrite mask Q P T])] |

crwrlist mask (Infix(P,"==",Q)) T = [([Infix(P,"==",Q)],[toprewrite mask Q P T])] |

crwrlist mask x y = (Say "No right rewrite rule applies.";[([x],[y])]);

fun crwr mask = action(bothpropaction (crwrlist mask));

fun left1() = leftact leftlists;

fun right1() = rightact rightlists;

fun done (n,Seq(x::L,y::M)) = if topalpha (p1 x) (p1 y) then Node(n,Seq(x::L,y::M),nil)
else (Say "Not done!";Goal(n,Seq(x::L,y::M))) |

done (n,s) = (Say "Not done!";Goal(n,s));

fun Done() = (act done);

(* the two versions of the Cut command *)

fun cutl P (Seq(L,M)) = (updatefree P; (*updatebound P;*) 
                          [Seq((P,[nextserial()])::L,M),
                           Seq(L,(P,[nextserial()])::M)]);

fun cutr P (Seq(L,M)) = (updatefree P; (*updatebound P;*) 
                          [Seq(L,(P,[nextserial()])::M),
                           Seq((P,[nextserial()])::L,M)]);

(* another version, designed for proving lemmas; it is cutr
but discarding all information from the current sequent from
the proof of the lemma *)

fun cutlemma P (Seq(L,M)) = (updatefree P; (*updatebound P;*) 
                          [Seq(nil,(P,[nextserial()])::nil),
                           Seq((P,[nextserial()])::L,M)]);


fun Cutl P = (if Parseerror (parseprop P) then Say "Parse errors block cut"
 else act(makenode (cutl (parseprop P))));

fun Cutr P = (if Parseerror (parseprop P) then Say "Parse errors block cut"
 else act(makenode (cutr (parseprop P))));

fun CutLemma P = (if Parseerror (parseprop P) then Say "Parse errors block cut"
 else act(makenode (cutlemma (parseprop P))));


fun leftrotate (n,Seq(L,M)) = Goal(n,Seq(rotate1 L,M));

fun rightrotate (n,Seq(L,M)) = Goal(n,Seq(L,rotate1 M));

fun leftrotate2 (n,Seq(x::L,M)) = Goal(n,Seq(x::(rotate1 L),M))|
leftrotate2 (n,x) = Goal(n,x);

fun rightrotate2 (n,Seq(L,x::M)) = Goal(n,Seq(L,x::(rotate1 M)))|
rightrotate2 (n,x) = Goal(n,x);

fun lr() = (act leftrotate);

fun rr() = (act rightrotate);

fun goalarg (Goal(n,s)) = (n,s) |

goalarg x = (0,Seq(nil,nil));

fun repeat 0 f x = Goal x |

repeat n f x = f (goalarg(repeat (abs n-1) f x));

fun Tl nil = nil |  Tl L = tl L;

fun Ltl (Goal(n,Seq(L,M))) = Goal(n,Seq(Tl L,M))|
Ltl x = x;

fun Rtl (Goal(n,(Seq(L,M)))) = Goal(n,Seq(L,Tl M))|
Rtl x = x;

fun leftprune f (n,x) = Ltl(f(n,x));

fun rightprune f (n,x) = Rtl(f(n,x));

fun gl n = (act ((repeat (n-1) leftrotate)));

fun gr n = (act ((repeat (n-1) rightrotate))); 

fun pl n = (act (leftprune(repeat (n-1) leftrotate)));

fun pr n = (act (rightprune(repeat (n-1) rightrotate))); 

fun gl2 n = (act (repeat (n-2) leftrotate2));

fun gr2 n = (act (repeat (n-2) rightrotate2)); 

fun absolutenumbering() = RELATIVENUMBERING:=false;

fun relativenumbering() = RELATIVENUMBERING:=true;

(* sequent matching; theorem use *)

fun subsequent L M (Seq(A,B)) =

    if Some (fn x=> item x A = nil) L

    orelse Some (fn x=>item x B = nil) M

    then (Say "Index error in proposed subsequent selection";Seq(nil,nil))

    else Seq(map (fn x=> hd(item x A)) L,map (fn x=>hd(item x B)) M);

val OLDUSUBS=ref (!USUBS);

(* This function now restores USUBS if the match fails *)

val OLDBOUNDSEQ = ref (!BOUND);

val OLDFREE = ref (!FREE);

fun sequentmatch (Seq(L1,M1)) (Seq(L2,M2)) =

    (OLDUSUBS:=(!USUBS);PROPMATCHES:=nil; MATCHES:= nil;  OLDFREE:=(!FREE); OLDBOUNDSEQ:=(!BOUND);
let val TT = listmatch (map diversify0(map p1 L1)) (map diversify0(map p1 L2)) 
andalso listmatch (map diversify0(map p1 M1)) (map diversify0(map p1 M2)) in
(FREE:=(!OLDFREE);BOUND:=(*(!OLDBOUNDSEQ)*)0;
if TT then TT else (USUBS:=(!OLDUSUBS);TT)) end);

fun usethm thm L M (n,s) =

    if find thm (!THEOREMS) = nil

    then (Say ("No theorem "^thm);Goal(n,s))

    else if sequentmatch (p1(hd(find thm (!THEOREMS)))) (subsequent L M s)

    then (CURRENT:=thm::(!CURRENT);Reference(n,subsequent L M s,thm))

    else (Say ("Theorem "^thm^" did not apply");Goal(n,s));

fun UseThm thm L M = (act(usethm thm L M));

(* Proof Display *)


fun makenumberlist nil = "" |

makenumberlist [x] = makestring x |

makenumberlist (x::L) = (makestring x)^", "^(makenumberlist L);



fun getproofbynumber m (Goal(n,s)) = if m=n then Goal(n,s) else Goal(0,Seq(nil,nil)) |

getproofbynumber m (Node(n,s,nil)) = if m=n then (Node(n,s,nil)) else Goal(0,Seq(nil,nil)) |

getproofbynumber m (Node(n,s,(x::L))) =

    if m<n then Goal(0,Seq(nil,nil)) else

    if m=n then (Node(n,s,(x::L)))

    else let val A = getproofbynumber m x in if A = Goal(0,Seq(nil,nil)) 

    then getproofbynumber m (Node(n,s,L))

    else A  end |

getproofbynumber m (Reference(n,s,th)) = if m=n then Reference(n,s,th)
    else Goal(0,Seq(nil,nil));

(* replace the proof of a line proved as a theorem
with a reference to the theorem *)

fun fixline m th (Goal(n,s)) = Goal(n,s) |

fixline m th (Node(n,s,nil)) = Node(n,s,nil) |

fixline m th (Node(n,s,(L))) =

    if m=n then (Reference(n,s,th))

    else Node(n,s,map (fixline m th) (L)) |

fixline m th (Reference(n,s,th2)) = (Reference(n,s,th2));

fun thesequent (Goal(n,s)) = s |

thesequent (Node(n,s,L)) = s |

thesequent (Reference(n,s,th)) = s;

fun ThmDisplay thm = if find thm (!THEOREMS) = nil

   then Say ("No such theorem as "^thm)

   else Say(thm^":\n\n"^(seqdisplay(p1(hd(find thm(!THEOREMS))))));

fun showtheoremlist ((s,x)::L) = ((showtheoremlist L);(ThmDisplay s)) |
showtheoremlist nil = ();

fun Axiom name L M =      

(if foundin name (!AXIOMS) then Say (name^" is already an axiom")

else if foundin name (!CURRENT) 
then Say (name^" is a currently locked theorem") 
else(
backup();
if Some Parseerror (map parseprop (L@M)) then 
     Say "Parse error prevents starting sequent"
     else(
     THEOREMS:=(name,(makesequent L M,Reference(1,makesequent L M,"")))::(!THEOREMS);  AXIOMS:=(name::(!AXIOMS))  
     ;ThmDisplay name)));


(* other data besides the proof may be stored in the second
component of a theorem item *)


fun namesequent n th =

    (if foundin th (!AXIOMS) then Say (th^" is an axiom")

    else if foundin th (!CURRENT) then Say (th^" is referenced in current proof") else

    (fireusubs();autoprune();let val G = getproofbynumber n (!THEPROOF) in

    if G = Goal(0,Seq(nil,nil)) then Say "Invalid line number"

    else if hasgoal G then Say "Sequent is not proved"

    else (THEPROOF:=fixline n th (!THEPROOF);
    THEOREMS:=(th,(thesequent G,G))::(!THEOREMS);
    CURRENT:=(th::(!CURRENT))
    ;ThmDisplay th) end));

(* development of ThmCut *)

fun unknownify P = topsubslist (freevarlist P) 
   (newunknownvarslist(length(freevarlist P))) P;


fun thmfreevarlist (Seq(A,B)) = 

unionlist(map freevarlist ((map p1 A)@(map p1 B)));

fun updateboundsequent (Seq(A,B)) =

(map (fn (P,G) => updatebound P) A;map (fn (P,G) => updatebound P) B);  

fun intlist nil = nil |

intlist (x::L) = (intlist L)@[length(x::L)];

fun lintlist (Seq(L,M)) = intlist L;

fun rintlist (Seq(L,M)) = intlist M;

fun thmcutlist (Seq(A,B)) (Seq(L,M)) =

( (*updateboundsequent (Seq(A,B));*) 

let val C = thmfreevarlist (Seq(A,B)) in

let val D = newunknownvarslist (length C) in

[Seq(map (fn (x,y)=>(topsubslist C D x,[nextserial()])) A,
map (fn (x,y)=>(topsubslist C D x,[nextserial()])) B)]@
(map (fn x=> Seq(L,(topsubslist C D (p1 x),[nextserial()])::M)) A)@
(map (fn x=> Seq((topsubslist C D (p1 x),[nextserial()])::L,M)) B) end end);

fun thmcutlist2 (Seq(A,B)) (Seq(L,M)) =

((*updateboundsequent (Seq(A,B));*)
let val C = thmfreevarlist (Seq(A,B)) in

let val D = newunknownvarslist (length C) in

[Seq(map (fn (x,y)=>(topsubslist C D x,[nextserial()])) A,
map (fn (x,y)=>(topsubslist C D x,[nextserial()])) B)]@
(map (fn x=> Seq((topsubslist C D (p1 x),[nextserial()])::L,M)) B)@
(map (fn x=> Seq(L,(topsubslist C D (p1 x),[nextserial()])::M)) A) end end);


fun ThmCut th = if find th (!THEOREMS) = nil

then Say ("No such theorem as "^th)

else (action (thmcutlist (p1(hd(find th (!THEOREMS)))));
      UseThm th (lintlist  (p1(hd(find th (!THEOREMS)))))                             (rintlist  (p1(hd(find th (!THEOREMS))))));                 

fun ThmCut2 th = if find th (!THEOREMS) = nil

then Say ("No such theorem as "^th)

else (action (thmcutlist2 (p1(hd(find th (!THEOREMS)))));
      UseThm th (lintlist  (p1(hd(find th (!THEOREMS)))))                             (rintlist  (p1(hd(find th (!THEOREMS))))));                 

(* proof display and storage *)

(* stuff for fancy display with all lemmas *)

(* theorems (possibly hidden by later theorems of the same name)
are referenced in two ways:  thm1.thm2 refers to the latest thm2
found when thm1 was proved; these prefixes can be iterated.  Theorems
are also referenced by their position in the master theorems list;
this is less readable but has the advantage of being unique. *)

fun prefix0 nil = nil |

prefix0 ((#".")::L) = nil |

prefix0 (x::L) = (x::(prefix0 L));

fun restprefix0 nil = nil |

restprefix0 ((#".")::L) = L |

restprefix0 (x::L) = restprefix0 L;

fun prefix s = implode(prefix0 (explode s));

fun deprefix s = implode(restprefix0 (explode s));

fun prefixfind s nil = nil |

   prefixfind s ((t,u)::L) =

   if prefix s = s then if s=t then [(u,length L + 1)]
   else prefixfind s L

   else

   if prefix s = t then prefixfind (deprefix s) L

   else prefixfind s L;

fun thmfind s = prefixfind s (!THEOREMS);


fun thmfind2 s = if s = "" then "" else

if thmfind s = nil then "0"

else makestring(p2(hd(thmfind s)));

fun attach s t = if s = "" then t else s^"."^t;


fun makelinenolist L = 

makenumberlist ((map getlineno L));


val SHOWNLEMMAS = ref (nil:(string list));

val NOLEMMAS = ref false;

fun showproof prefix (Goal (n,s)) =

"\n\n--------------------  Goal  ------------------"^
"\n\nLine "^(attach (thmfind2 prefix)(makestring n))^":\n\n"^(seqdisplay s) |

showproof prefix (Node(n,s,nil)) =

"\n\n-------------------- Trivial ---------------------"^
"\n\nLine "^(attach (thmfind2 prefix)(makestring n))^":\n\n"^(seqdisplay s) |

showproof prefix (Node(n,s,L)) =

(if hasgoal(Node(n,s,L)) then
"\n\n-------------------- Not Proved ------------------"
else
"\n\n-------------------- Proved ----------------------")^
"\n\nLine "^(attach(thmfind2 prefix)(makestring n))^":\n\n"^(seqdisplay s)^
"\n\nBy "^(makelinenolist L)^(showprooflist prefix L) |

showproof prefix (Reference(n,s,th)) =
"\n\n-------------------- Proved ----------------------"^
"\n\nLine "^(attach(thmfind2 prefix)(makestring n))^":\n\n"^(seqdisplay s)^
"\nBy "^(attach prefix th)^(showproofof prefix th)

and showprooflist prefix nil = "" |

showprooflist prefix (x::L) = (showproof prefix x)^(showprooflist prefix L)

and showproofof prefix th = 

if (!NOLEMMAS) then "" else

if th = "" then (th^" is an axiom")

else if thmfind (attach prefix th) = nil 

then "Theorem reference error"

else if foundin (thmfind2 (attach prefix th)) (!SHOWNLEMMAS)

   then ("Already shown ("^(thmfind2 (attach prefix th))^")")

else (SHOWNLEMMAS:=(thmfind2 (attach prefix th))::(!SHOWNLEMMAS);
("\n\nProof of "^(attach prefix th)^" begins\n\n"^
(showproof (attach prefix th)
           (p2(p1(hd(thmfind (attach prefix th))))))^
"\n\nProof of "^(attach prefix th)^" ends\n\n"));


fun showall prefix (Goal (n,s)) =
Say(
"\n\n--------------------  Goal  ------------------"^
"\n\nLine "^(attach (thmfind2 prefix)(makestring n))^":\n\n"^(seqdisplay s)) |

showall prefix (Node(n,s,nil)) =

Say("\n\n-------------------- Trivial ---------------------"^
"\n\nLine "^(attach(thmfind2 prefix)(makestring n))^":\n\n"^(seqdisplay s)) |

showall prefix (Node(n,s,L)) =

(Say((if hasgoal(Node(n,s,L)) then
"\n\n-------------------- Not Proved ------------------"
else
"\n\n-------------------- Proved ----------------------")^
"\n\nLine "^(attach(thmfind2 prefix)(makestring n))^":\n\n"^(seqdisplay s)^
"\nBy "^(makelinenolist L));(showalllist prefix L)) |

showall prefix (Reference(n,s,th)) =(Say(
"\n\n-------------------- Proved ----------------------"^
"\n\nLine "^(attach (thmfind2 prefix)(makestring n))^":\n\n"^(seqdisplay s)^
"\nBy "^(attach prefix th));(showallof prefix th))

and showalllist prefix nil = () |

showalllist prefix (x::L) = ((showall prefix x);(showalllist prefix L))

and showallof prefix th = if (!NOLEMMAS) then () else
if th = "" then Say (th^"is an axiom")
else if thmfind (attach prefix th) = nil then Say "Theorem reference error"

else if foundin (thmfind2(attach prefix th)) (!SHOWNLEMMAS)

then Say ("Already shown("^(thmfind2(attach prefix th))^")")

else (SHOWNLEMMAS:=(thmfind2(attach prefix th))::(!SHOWNLEMMAS);
Say("Proof of "^(attach prefix th)^" begins\n\n");
(showall (attach prefix th)
           (p2(p1(hd(thmfind (attach prefix th))))));
Say("\n\nProof of "^(attach prefix th)^" ends"));




val r = right1;

val l = left1;

val su = setunknown;

fun wl t = (l();su (!FREE) t);

fun wr t = (r();su (!FREE) t);

(* THEORY SAVE AND RESTORE *)

(* unfortunately this theoretically appealing approach creates terms which
are too large to parse *)

(* conversion between numerals and strings is handled by built-in makestring
and the already defined getindex *)

(* conversion of lists of proposition terms to proposition terms and back *)

(* integers coded as proposition variables *)

fun listtoterm nil = PredVar(0,nil) |

listtoterm (t::L) = Infix(t,"&",listtoterm L);

fun termtolist (PredVar(0,nil)) = nil |

termtolist (Infix(t,"&",L)) = t::(termtolist L) |

termtolist x = [ErrorProp];

fun codegen (P,G) = Infix(P,"&",listtoterm(map (fn x=>PredVar(x,nil)) G));

fun decodegen (Infix(P,"&",Q)) =

   (P,map(fn (PredVar(x,nil))=>x |y=> ~1) (termtolist Q))|

   decodegen x = (ErrorProp,nil);

fun sequenttoterm (Seq(L,M)) = Infix(listtoterm (map codegen L),"->",listtoterm (map codegen M));

fun termtosequent (Infix(L,"->",M)) =

   Seq(map decodegen (termtolist L),map decodegen (termtolist M)) |

termtosequent x = Seq(nil,nil);

fun prooftoterm (Goal(n,s)) = Infix(PredVar(n,nil),"&",sequenttoterm s) |

prooftoterm (Node(n,s,L)) = Infix(PredVar(n,nil),"v",(Infix(sequenttoterm s,"<-",listtoterm(map prooftoterm L)))) |

prooftoterm (Reference(n,s,th)) = 
    Infix(PredVar(n,nil),"<-",(Infix(sequenttoterm s,"->",Infix(Free 0,"=",Prefix("\""^th^"\"",nil)))));

fun termtoproof (Infix(PredVar(n,nil),"&",s)) = Goal(n,termtosequent s) |

termtoproof (Infix(PredVar(n,nil),"v",Infix(s,"<-",L))) =

   Node(n,termtosequent s,map termtoproof (termtolist L)) |

termtoproof (Infix(PredVar(n,nil),"<-",Infix(s,"->",Infix(Free 0,"=",Prefix(th,nil))))) =  Reference(n,termtosequent s,trim th) |

termtoproof x = Goal(0,Seq(nil,nil));

(* which lists make up the theory? *)

fun stringtoterm s = Infix(Free 0,"=",Prefix(quoting s,nil));

fun termtostring (Infix(Free 0,"=",Prefix(s,nil))) =
   trim s |
termtostring t = "";
   

fun pairtoterm (P,Q) = Infix(P,"&",Q);

fun termtopair (Infix(P,"&",Q)) = (P,Q)|

termtopair x = (stringtoterm "",ErrorProp);

(* the theoremsterm() and readtheoremslist functions work but the
parser does not handle terms that large very well...now it does... *)

fun theoremsterm() = listtoterm (map (fn (name,(sequent,proof))=>

    pairtoterm(stringtoterm name,pairtoterm(sequenttoterm sequent,prooftoterm proof))) (!THEOREMS));

fun readtheoremsterm T =

     map (fn (name, sp)=>(termtostring name,(fn (sequent,proof)=>(termtosequent sequent,
          termtoproof proof)) (termtopair sp)))
     (map (termtopair) (termtolist T));

(* lists needed for theory state:

THEOREMS (already handled),

OPERATORS, BINDERS, PRECS, OPERATORSTRAT, BINDERSTRAT, TERMDEFS, PROPDEFS,
AXIOMS

other information needs to be set to starting state when a theory is loaded 

such as THEPROOF CURRENT *)

fun optypetoterm Connective = PredVar(0,nil) |

   optypetoterm (Function n) = PredVar(1+2*n,nil) |

   optypetoterm (Predicate n) = PredVar(2+2*n,nil) |

   optypetoterm OTError = PredVar(~1,nil);

fun termtooptype (PredVar(n,nil)) =

   if n<0 then OTError

   else if n=0 then Connective

   else if n mod 2 = 1 then Function ((n-1) div 2)

   else if n mod 2 = 0 then Predicate ((n-2) div 2)

   else OTError |

termtooptype x = OTError;

fun btypetoterm Quantifier = PredVar(0,nil) |

   btypetoterm FnBinder = PredVar(1,nil) |

   btypetoterm SetBinder = PredVar(2,nil) |

   btypetoterm BTError = PredVar(~1,nil);

fun termtobtype (PredVar(n,nil)) =

   if n = 0 then Quantifier

   else if n = 1 then FnBinder

   else if n=2 then SetBinder

   else BTError |termtobtype x = BTError;

fun intlisttoterm L = listtoterm(map (fn n=>PredVar(n,nil)) L);

fun termtointlist T = map (fn (PredVar(n,nil))=>n|x=> ~1) (termtolist T);

(* change stratification lists so they contain no negative numbers *)

fun fixstratlist L = let val D = maxlist (map (fn n => ((abs n)-n)div 2) L)

in map (fn x=>x+D) L end;

fun operatorsterm() = listtoterm
(map (fn (s,t) => pairtoterm(stringtoterm s,optypetoterm t)) (!OPERATORS));

fun readoperatorsterm T = map (fn (s,t) => (termtostring s,termtooptype t))
(map termtopair (termtolist T));

fun bindersterm() = listtoterm(map (fn (s,t) => pairtoterm(stringtoterm s,btypetoterm t)) (!BINDERS));

fun readbindersterm T = map (fn (s,t) => (termtostring s,termtobtype t))
(map termtopair (termtolist T));

fun operatorstratsterm() = listtoterm (map (fn (s,t)=>pairtoterm(stringtoterm s,
   intlisttoterm(fixstratlist t)))(!OPERATORSTRAT));

fun binderstratsterm() = listtoterm (map (fn (s,t)=>pairtoterm(stringtoterm s,
   intlisttoterm(fixstratlist t)))(!BINDERSTRAT));

fun readstratsterm T = map (fn (s,t)=>(termtostring s,termtointlist t))
   (map termtopair (termtolist T));

fun precsterm() = listtoterm (map (fn (s,t)=>pairtoterm(stringtoterm s,PredVar(t,nil)))
   (!PRECS));

fun readprecsterm T = map (fn (s,PredVar(n,nil)) => (termtostring s,n)|
   x=>("",~1)) (map termtopair (termtolist T));

fun termdefsterm() = listtoterm (map (fn (s,(t,u))=>pairtoterm(stringtoterm s,
   Infix(t,"=",u))) (!TERMDEFS));

fun propdefsterm() = listtoterm (map (fn (s,(t,u))=>pairtoterm(stringtoterm s,
   Infix(t,"==",u))) (!PROPDEFS));

fun readtermdefsterm T = map (fn(s,Infix(t,"=",u))=>(termtostring s,(t,u)) |
   x=>("",(ErrorObject,ErrorObject))) (map termtopair (termtolist T));

fun readpropdefsterm T = map (fn(s,Infix(t,"==",u))=>(termtostring s,(t,u)) |
   x=>("",(ErrorProp,ErrorProp))) (map termtopair (termtolist T));

fun axiomsterm() = listtoterm (map stringtoterm (!AXIOMS));

fun currentterm() = listtoterm (map stringtoterm (!CURRENT));


fun readaxiomsterm T = map termtostring (termtolist T);

fun uiterm() = listtoterm (map (fn (m,n)=>pairtoterm(PredVar(m,nil),PredVar(n,nil)))
   (!UNKNOWNINDEX));

fun readuiterm T = map (fn (PredVar(m,nil),PredVar(n,nil))=>(m,n)
    |x=>(~1,~1)) (map
   termtopair(termtolist
   T));

fun theoryterm1() =

listtoterm[operatorsterm(),bindersterm(),precsterm(),
   operatorstratsterm(),binderstratsterm(),axiomsterm()
   (* termdefsterm(),propdefsterm(),theoremsterm()*)];

fun theoryterm2() =

listtoterm [termdefsterm(),propdefsterm()(*,theoremsterm()*)];

fun theoryterm3() = 
            listtoterm [PredVar((!BOUND),nil),PredVar((!FREE),nil),
            PredVar((!NEWSERIAL),nil),PredVar((!SEQSERIAL),nil),
            (* prooftoterm(!THEPROOF), *) currentterm(),uiterm()];

fun readtheoryterm1 T =

(fn [opl,b,pr,ops,bis,ax] (* td,pd,th]*)=>

(OPERATORS:=readoperatorsterm opl;BINDERS:=readbindersterm b;
PRECS:=readprecsterm pr; OPERATORSTRAT:=readstratsterm ops;
BINDERSTRAT:= readstratsterm bis;AXIOMS:=readaxiomsterm ax (*TERMDEFS:=readtermdefsterm td;
PROPDEFS:=readpropdefsterm pd;THEOREMS:=readtheoremsterm th;*)
)|x=>()) (termtolist T);

fun readtheoryterm2 T = 

(fn [td,pd(*, th ,bo,fr,prf,cur*)]=>(TERMDEFS:=readtermdefsterm td;
PROPDEFS:=readpropdefsterm pd(* ;THEOREMS:=readtheoremsterm th  ;
HISTORY:=nil;BOUND:=(fn (PredVar(n,nil))=>n|x=>0) bo;
FREE:=(fn (PredVar(n,nil))=>n|x=>0) fr;
THEPROOF:=termtoproof prf;CURRENT:=readaxiomsterm cur*))|x=>()) (termtolist T);

fun readtheoryterm3 T = (fn [bo,fr,ns,sqs,(* prf, *) cur,ui]=>(HISTORY:=nil;BOUND:=(fn (PredVar(n,nil))=>n|x=>0) bo;
FREE:=(fn (PredVar(n,nil))=>n|x=>0) fr;NEWSERIAL:=(fn (PredVar(n,nil))=>n|x=>0) ns;SEQSERIAL:= (fn (PredVar(n,nil))=>n|x=>0) sqs;
(* THEPROOF:=termtoproof prf; *) CURRENT:=readaxiomsterm cur;
UNKNOWNINDEX:=readuiterm ui; 
Look())|x=>()) (termtolist T);

(* build script to reconstruct a proof (for when the term is too large) *)

(* use a stack *)

val PROOFSTACK = ref (nil:(Proof list));

(* push a goal onto the stack *)

fun pushgoal n s  = PROOFSTACK:=(Goal(n,termtosequent(parseprop s)))::(!PROOFSTACK);

(* push a proof by reference onto the stack *)

fun pushreference n s th = PROOFSTACK:=(Reference(n,termtosequent(parseprop s),th))::(!PROOFSTACK);

(* push a node onto the stack; the subproofs are popped off the stack! *)

fun partition 0 L = (nil,L) |

partition n nil = (nil,nil) |

partition n (x::L) = (x::(p1(partition (n-1) L)),p2(partition (n-1) L));

fun pushnode n s m = let val (A,B) = partition m (!PROOFSTACK) in

    PROOFSTACK:=(Node(n,termtosequent(parseprop s),A))::B end;

(* reduce whitespace *)

fun reduce0 nil = nil |

reduce0 (#"\n"::L) = reduce0 (#" "::L) |

reduce0 (#" ":: #" ":: L) = reduce0 (#" "::L) |

reduce0 (x::L) = x::(reduce0 L);

(* remove carriage returns and extra spaces from display *)

fun stripdisplay s = implode(reduce0(explode(display s)));

fun sdisplay s = stripdisplay(sequenttoterm s);

fun proofrestorescript (Goal (n,s)) = "pushgoal "^(makestring n)^" \""^(sdisplay s)^"\";\n" |

proofrestorescript (Reference(n,s,th)) = "pushreference "^(makestring n)^" \""^(sdisplay s)^"\" \""^th^"\";\n" |

proofrestorescript (Node(n,s,L)) = (proofrestorescriptlist L)^
   ("pushnode "^(makestring n)^" \""^(sdisplay s)^"\" "^(makestring(length L))^";\n")

and proofrestorescriptlist nil = "" |

proofrestorescriptlist (x::L) = (proofrestorescriptlist L)^(proofrestorescript x);

val FILE = ref(TextIO.openOut("dummy"));

fun theoremlistrestorescript nil = "" |

theoremlistrestorescript ((name,(seq,prf))::L) =

   (theoremlistrestorescript L)^
   (
   (proofrestorescript prf)^
   "THEOREMS:=(\""^name^"\",(termtosequent(parseprop(\""^(sdisplay seq)^
 "\")),hd(!PROOFSTACK)))::(!THEOREMS);\nPROOFSTACK:=nil;\ntd \""^name^"\";\n");

fun makeproofscript s = (FILE:=TextIO.openOut(setdir(s^".psc"));
TextIO.output((!FILE),(theoremlistrestorescript(!THEOREMS)));
TextIO.output((!FILE),(proofrestorescript(!THEPROOF)));TextIO.flushOut(!FILE);
TextIO.closeOut(!FILE));


fun savetheory s = (FILE:=TextIO.openOut(setdir(s^".thy1"));
TextIO.output((!FILE),display(theoryterm1())^"\n\\\n");TextIO.flushOut(!FILE);
TextIO.closeOut(!FILE);FILE:=TextIO.openOut(setdir(s^".thy2"));
TextIO.output((!FILE),display(theoryterm2())^"\n\\\n");TextIO.flushOut(!FILE);
TextIO.closeOut(!FILE);FILE:=TextIO.openOut(setdir(s^".thy3"));
TextIO.output((!FILE),display(theoryterm3())^"\n\\\n");TextIO.flushOut(!FILE);
TextIO.closeOut(!FILE);makeproofscript s);

fun nobackslash0 nil = nil |

nobackslash0 ((#"\\")::L) = nil |

nobackslash0 (x::L) = x::(nobackslash0 L);

fun nobackslash s = implode(nobackslash0 (explode s));

val FILE2 = ref(TextIO.openIn("dummy"));

fun opentheory1 s = FILE2:=TextIO.openIn(setdir(s^".thy1"));

fun opentheory2 s = FILE2:=TextIO.openIn(setdir(s^".thy2"));

fun opentheory3 s = FILE2:=TextIO.openIn(setdir(s^".thy3"));

fun getlines() = let val A = (TextIO.input(!FILE2))

in if foundin (#"\\") (explode A) then nobackslash A
 else A^(getlines()) end;

fun loadtheory s = (opentheory1 s; readtheoryterm1 (parseprop(getlines()));
   TextIO.closeIn(!FILE2);opentheory2 s; readtheoryterm2 (parseprop(getlines()));
   TextIO.closeIn(!FILE2);opentheory3 s; readtheoryterm3 (parseprop(getlines()));
   TextIO.closeIn(!FILE2);PROOFSTACK:=nil;THEOREMS:=nil;
Meta.use (setdir(s^".psc"));THEPROOF:=hd(!PROOFSTACK);Look();
backup()); 


(* USER COMMANDS *)

(* all user commands should appear in this section *)

(* NON-LOGGED USER COMMANDS *)

(* user commands that do not modify prover state so do not need
to be logged *)

(* Look() is a user command but must appear earlier *)

(* ThmDisplay is a user command but must appear earlier *)

val td = ThmDisplay;

(* commands to turn on and off fancy display of lemmas *)

fun nolemmas() = NOLEMMAS:=true;

fun showlemmas() = NOLEMMAS:=false;

fun Showall() = (SHOWNLEMMAS:=nil;showall "" (!THEPROOF));

fun ShowMarked name = 
(SHOWNLEMMAS:=nil;showall "" (getproofbynumber (getbookmark name)(!THEPROOF)));

val showall = Showall;

(* display the declaration lists *)

fun Showtermdefs() = 
                     Say (thetermdefs());
fun Showpropdefs() = 
                     Say (thepropdefs());

(* show all theorems (hit return after each one) *)

fun Showalltheorems()= showtheoremlist(!THEOREMS);

(* show the axioms *)

fun Showaxioms() = showtheoremlist (map
          (fn x=>(x,hd(find x(!THEOREMS)))) (!AXIOMS));

val ShowAxioms = Showaxioms;

(* show all the lemmas used in the current proof *)

fun Showcurrent() = showtheoremlist(map
          (fn x=>(x,hd(find x(!THEOREMS)))) (!CURRENT));

val ShowCurrent = Showcurrent;

(* save the proof of a theorem or the current proof to the log file *)

fun LogProof th = (logcomment(thetermdefs());logcomment(thepropdefs());
                  SHOWNLEMMAS:=nil;logcomment(showproofof "" th));

fun LogTheProof th = 
if (!LOGGING) = false then say "You are not logging!" else
(logcomment(thetermdefs());logcomment(thepropdefs());
                  SHOWNLEMMAS:=nil;logcomment(showproof "" (!THEPROOF));
                   say ("Proof log added to file "^(!LOGFILENAME)));


(* PREAMBLE USER COMMANDS *)

(* user commands that should only be issued at the outset to set
things up and so would go in the preamble of a log *)


(* LOGGED USER COMMANDS *)

(* user commands issued during prover sessions that change state
and so need to be logged *)

(* margin control *)

fun SetMargin n = (MARGIN:=n;Look());

(* activate or deactivate one-conclusion mode *)

fun OneConclusion() = (reportcommand[Mnemonic"OneConclusion"];
                      ONECONC:=true);

fun ManyConclusions() = (reportcommand[Mnemonic"ManyConclusions"];
                      ONECONC:=false);

(* this turns on constructive (intuitionistic) logic which
cannot be turned off, because it is a real change in the logic *)

(* Ideally, if this is to be used it should be turned on first thing *)

fun Constructive() = (reportcommand[Mnemonic"Constructive"];
                      ONECONC:=false;CONSTRUCTIVE:=true)

(* user precedence setting commands *)

fun setprecsame s t = (setprec s (prec t);
                      reportcommand [Mnemonic "setprecsame",
                      StringArg s,StringArg t]);

val Sps = setprecsame;

fun setprecrightabove s t = ((pushprecs (evenabove(prec t));setprec s
(evenabove(prec t)));reportcommand [Mnemonic "setprecrightabove",
                      StringArg s,StringArg t]);

val Spra = setprecrightabove;

fun setprecrightbelow s t = ((pushprecs ((prec t));setprec s
(evenbelow(prec t)));reportcommand [Mnemonic "setprecrightbelow",
                      StringArg s,StringArg t]);

val Sprb = setprecrightbelow;

fun setprecleftabove s t = ((pushprecs (oddabove(prec t));setprec s
(oddabove(prec t)));reportcommand [Mnemonic "setprecleftabove",
                      StringArg s,StringArg t]);

val Spla = setprecleftabove;

fun setprecleftbelow s t = ((pushprecs ((prec t));setprec s
(oddbelow(prec t)));reportcommand [Mnemonic "setprecleftbelow",
                      StringArg s,StringArg t]);

val Splb = setprecleftbelow;

fun setprecrightmax s  = (setprec s (evenabove (!MAXPREC));
                      reportcommand [Mnemonic "setprecrightmax",
                      StringArg s]);

val Sprx = setprecrightmax;

fun setprecleftmax s  = (setprec s (oddabove (!MAXPREC));
                      reportcommand [Mnemonic "setprecleftmax",
                      StringArg s]);

val Splx = setprecleftmax;

fun setprecrightmin s = ((pushprecs 0;setprec s 0);
                      reportcommand [Mnemonic "setprecrightmin",
                      StringArg s]);

val Sprn = setprecrightmin;

fun setprecleftmin s = ((pushprecs 0;setprec s 1);
                      reportcommand [Mnemonic "setprecleftmin",
                      StringArg s]);

val Spln = setprecleftmin;

(* put in a command to display precedences *)

(*  resetting grouping of conjunction and disjunction;
these are the old settings.  These values will be needed
for old theory files.

val _ = setprecrightbelow "v" "&";

val _ = setprecrightbelow "->" "v";

val _ = setprecrightbelow "==" "->";

val _ = setprecsame "<-" "->";

val _ = setprecsame "=/=" "==";

*)

val _ = setprecleftmin "&";

val _ = setprecleftbelow "v" "&";

val _ = setprecrightbelow "->" "v";

val _ = setprecleftbelow "==" "->";

val _ = setprecsame "<-" "->";

val _ = setprecsame "=/=" "==";

fun Declarepredicate s L =

(reportcommand [Mnemonic "Declarepredicate",StringArg s,IntegerListArg L];
declarepredicate s L);

val DeclarePredicate = Declarepredicate;

fun Declarefunction s L =

(reportcommand [Mnemonic "Declarefunction",StringArg s,IntegerListArg L];
declarefunction s L);

val DeclareFunction = Declarefunction;

fun Definepredicate n s S T =
(reportcommand [Mnemonic "Definepredicate",IntegerArg n,StringArg s,StringArg S,StringArg T];definepredicate n s S T);

fun DefSent S T = Definepredicate 0 S S T;

val DefinePredicate = Definepredicate;

fun Definefunction n s S T =
(reportcommand [Mnemonic "Definefunction",IntegerArg n,StringArg s,StringArg S,StringArg T];definefunction n s S T);

val DefineFunction = Definefunction;

fun Remember() = (reportcommand [Mnemonic "Remember"];remember());

val remember = Remember;

fun NoRemember() = (reportcommand [Mnemonic "NoRemember"];noremember());

val noremember = NoRemember;

fun NextGoal() = (reportcommand [Mnemonic "NextGoal"];nextgoal());

val ng = NextGoal;

val nextgoal = NextGoal;

fun AutoPrune() = (reportcommand [Mnemonic "AutoPrune"];autoprune());

fun Undo() = (reportcommand [Mnemonic "undo"];undo());

val b = Undo;

val undo = Undo;

fun SetUnknown n t = (reportcommand [Mnemonic "su",IntegerArg n,StringArg t]; setunknown n t);

val su = SetUnknown;

fun SetPredVar n t = (reportcommand [Mnemonic "sp",IntegerArg n,StringArg t]; setpredvar n t);

val sp = SetPredVar;

(* this is best used immediately after introduction of unknowns;
it has the nice feature that it is much less vulnerable to index faults
in logs.  It is NOT the same as the old prover witness command, though
it is certainly related.  r() or l() followed by Witness 1 resembles the
old witness command in appropriate contexts.  Notice that we count backward
from the highest new index.  This could be dangerous in a complex ThmCut
if the highest index is not visible... (can that happen?).  Of course
one can always type FREE and see the free/unknown counter. *)

fun Witness n t = (reportcommand [Mnemonic "w",IntegerArg n,StringArg t]; setunknown (((!FREE)+1)-n) t);

val w = Witness;

fun StartSequent L M = (reportcommand [Mnemonic "StartSequent",StringListArg L,StringListArg M];startsequent L M);

val ss = StartSequent;

(* Start is a user command but will be logged as StartSequent *)

fun Start P = StartSequent nil [P];

val s = Start;

val start = Start;

fun Rwl mask = (reportcommand [Mnemonic "rwl",IntegerListArg mask];rwl mask);

val rwl = Rwl;

fun Rwr mask = (reportcommand [Mnemonic "rwr",IntegerListArg mask];rwr mask);

val rwr = Rwr;

fun Crwl mask = (reportcommand [Mnemonic "crwl",IntegerListArg mask];crwl mask);

val crwl = Crwl;

fun Crwr mask = (reportcommand [Mnemonic "crwr",IntegerListArg mask];crwr mask);

val crwr = Crwr;

fun L() = (reportcommand [Mnemonic "l"];l());

val l = L;

fun R() = (reportcommand [Mnemonic "r"];r());

val r = R;

fun DONE() = (reportcommand [Mnemonic "Done"];Done());

val Done = DONE;

val d = Done;

(* the names Cut and Cut2 are preserved but their meanings are reversed;
Cut is the preferred version, which verifies lemma before using it *)

fun CUTL P = (reportcommand [Mnemonic "Cut2",StringArg P];Cutl P);

val Cutl = CUTL;

val Cut2 = Cutl;

fun CUTR P = (reportcommand [Mnemonic "Cut",StringArg P];Cutr P);

val Cutr = CUTR;

val Cut = CUTR;

fun CUTLEMMA P = (reportcommand [Mnemonic "CutLemma",StringArg P];CutLemma P);

val CutLemma = CUTLEMMA;

fun GetLeft n = (reportcommand [Mnemonic "gl",IntegerArg n];gl n);

val gl = GetLeft;

fun GetRight n = (reportcommand [Mnemonic "gr",IntegerArg n];gr n);

val gr = GetRight;

fun PruneLeft n = (reportcommand [Mnemonic "pl",IntegerArg n];pl n);

val pl = PruneLeft;

fun PruneRight n = (reportcommand [Mnemonic "pr",IntegerArg n];pr n);

val pr = PruneRight;

fun GetLeft2 n = (reportcommand [Mnemonic "gl2",IntegerArg n];gl2 n);

val gl2 = GetLeft2;

fun GetRight2 n = (reportcommand [Mnemonic "gr2",IntegerArg n];gr n);

val gr2 = GetRight2;

(* convenient macros *)

fun Gl n = (gl n;l());

fun Gr n = (gr n;r());

fun Triv m n = (gl m;gr n;Done());


fun USETHM thm L M = (reportcommand [Mnemonic "UseThm",StringArg thm,
                     IntegerListArg L,IntegerListArg M];UseThm thm L M);

val UseThm = USETHM;

fun AXIOM name L M = (reportcommand [Mnemonic "Axiom",StringArg name,
                     StringListArg L,StringListArg M];Axiom name L M);

val Axiom = AXIOM;

fun NameSequent n th = (reportcommand [Mnemonic "NameSequent",IntegerArg n,StringArg th];namesequent n th);

val Prove = NameSequent;

fun ProveMarked name th = NameSequent (getbookmark name) th;

val namesequent = NameSequent;

val prove = Prove;

fun THMCUT th = (reportcommand [Mnemonic "ThmCut",StringArg th];
                ThmCut th);

val ThmCut = THMCUT;

fun THMCUT2 th = (reportcommand [Mnemonic "ThmCut2",StringArg th];
                ThmCut2 th);

val ThmCut2 = THMCUT2;

(* this brings the proof of th onto the desktop; useful for 
extracting sequents to prove as lemmas *)

fun GetProof th = (reportcommand [Mnemonic "GetProof",StringArg th];
                if thmfind th = nil then Say ("No such theorem as "^th)
                else (backup();THEPROOF:=p2(p1(hd(thmfind th)))));

(* this is the universal fix for the order of branches problem *)

fun SwapGoals() = (reportcommand [Mnemonic "SwapGoals"];
                  (backup();THEPROOF:=swapgoals(!THEPROOF));Look());

val swapgoals=SwapGoals;

val sg = SwapGoals;

fun rf() = (reportcommand[Mnemonic "RewriteFree"];
                    RewriteFree());

val RewriteFree = rf;



(*

(* example space *)

declarefunction "+" [0,0,0];

Axiom "Comm" nil ["a1+a2=a2+a1"];

Axiom "Assoc" nil ["[a1+a2]+a3=a1+a2+a3"];

start "a1+a2+a3=a3+a2+a1";

startlogging "logtest";

s "(P1&P2->P3)->(P1->P2->P3)";

DefineFunction 0 "1" "1" "{x1|(Ex2.x2Ex1)&(Ax2.(Ax3.x2Ex1&x3Ex1->x2=x3))}";

DefineFunction 1 "Sing" "Sing(x1)" "{x2|x2=x1}";
s "x2 E x1 & x3 E x1 -> x2 = x3";

parsetest1"x2 E x1 & x3 E x1 -> x2 = x3"; 

s "(x2 E x1 & x3 E x1) -> x2 = x3"; 

*)

(*

(* quantifier exercises from Grantham's book.  I've driven
the prover through some of them and written some remarks.
I'll keep updating these. *)

(* Intructions on using this file:  take the cleardefs()
and the following DefSent lines defining the premises for
a single problem and
conclusions and drop the whole block into your ML window.
[cleardefs clears definitions so that there won't
be conflicts with definitions in other problems]
Then highlight the specific proof you want to do and drop that
into your window. *)

(* 1 *)

cleardefs();

(* on the definitions, don't worry about 
"Stratification failed" error message *)

(* premises *)

DefSent "#eone" "(Ax1.(Ax2.(Ax3.x1 R1 x2&x2R1 x3->x1 R1 x3)))";

DefSent "#etwo" "(Ax1.(Ax2.x1R1x2->x2R1x1))";

(* possible conclusions *)

DefSent "#cone" "(Ax1.(Ex2.x1R1x2))==(Ax3.x3 R1 x3)";

DefSent "#ctwo" "(Ax1.(Ex2.x1 R1 x2))==(Ex2.(Ax1.x1R1x2))";

DefSent "#cthree" "(Ex2.(Ax1.x1 R1 x2))==(Ax1.(Ax2.x1R1x2))";

(* things to prove (or not) *)

Start "#eone&#etwo->#cone";   (* valid  the assigned 1a *)

Start "#eone&#etwo->#ctwo";   (* this is invalid; in trying to prove
                              it you come up against a stone wall.
                              Describe a counterexample? *)

Start "#eone&#etwo->#cthree";  (* valid (this is the recommended 1b)
                               :  requires some interesting
                              maneuvers.  At one point you just need to
                              introduce a new object by force to witness
                              an existential conclusion.  At another
                              point, you need to use a universal hypoothesis
                              twice *)

(* 2 *)

cleardefs();

DefSent "Gone" "(Ax1.P1(x1))->(Ax2.(Ex3.P2(x2,x3)))";

   (* note that P2 is automatically changed to R2 *)

DefSent "Gtwo" "(Ax1.(Ax2.(Ax3.x1R2x2&x2R2x3->x1R3x3)))";

DefSent "Gthree" "(Ax1.P1(x1)v~P4(x1))";

DefSent "Gfour" "(Ax1.(Ax2.P4(x1)&~P4(x2)->x1R3x2))";

DefSent "Gfiwe" "~(Ex1.P4(x1))->(Ex2.x2R3x2)"; (* parser wont accept v in a name *)

DefSent "Cone" "(Ex1.(Ex2.x1R3x2))";

(* DefSent "#ctwo" "(Ax1.P4(x1)->(Ex2.x1R2x2))"; *)

Start "Gone&Gtwo&Gthree&Gfour&Gfiwe->Cone";

   (* the one just above is valid and a *very* clever problem:
     this is the recommended 2a *)

Start "#gone&#gtwo&#gthree&#gfour&#gfiwe->#ctwo";

   (* I don't think this is provable? *)

(* 3 *)

(* everything gets converted automatically to infix notation here *)

DefSent "#done" "(Ex1.(Ax2.P1(x1,x2)))";

DefSent "#dtwo" "(Ax1.(Ex2.P2(x1,x2)))";

DefSent "#dthree" "(Ax1.(Ax2.(Ax3.P1(x1,x2)&P2(x2,x3)->P3(x3,x1))))";

DefSent "#dfour" "(Ax1.(Ax2.(Ax3.P3(x1,x3)&P3(x2,x3)->(Ex4.P2(x4,x1)&P2(x4,x2)))))";

DefSent "#dfiwe" "(Ax1.(Ax2.(Ax3.P2(x1,x3)&P2(x2,x3)->P4(x1,x2))))";

DefSent "#dlast" "(Ax1.(Ax2.(Ax3.P4(x1,x3)&P4(x2,x3)->P5(x1,x2))))";

DefSent "#cone" "(Ax1.(Ax2.P5(x1,x2)))";

DefSent "#ctwo" "(Ax1.(Ax2.P4(x1,x2)))";

(* things to prove *)

Start "#done&#dtwo&#dthree&#dfour&#dfiwe&#dlast->#cone";

  (* I'm working on this one; I don't know if it is valid yet;
   the prover don't do your work for you -- I suggest drawing
   pictures with arrows then driving the prover as the pictures
   suggest... *)

   (* I do remember working on this one with M187 *)

Start "#done&#dtwo&#dthree&#dfour&#dfiwe&#dlast->#ctwo";

  (* same remarks as on last one -- I seem to recall that one of
   these conclusions works but I do not remember if both do *)

(* 4 *)

cleardefs();

DefSent "#pone" "(Ax1.(Ax2.(Ex3.P1(x1,x2,x3))))";

DefSent "#ptwo" "(Ax1.(Ex2.P2(x1,x2)))";

DefSent "#pthree" 
"(Ax1.(Ax2.(Ax3.(Ax4.P2(x1,x2)&P1(x3,x2,x4)->P3(x1,x4)&P3(x3,x4)))))";

DefSent "#cone" "(Ax1.(Ax2.(Ex3.P3(x1,x3)&P3(x2,x3))))";

  (* I don't remember looking at this problem *)

  (* But it is valid (this is the recommended 4).  
  It requires some care to set up;
  the proof isn't *too* long but I couldn't do it just at the console;
  I had to have my orders written in a file so that I could
  make corrections as needed (the style I'm asking you
  to cultivate) *)

Start "#pone&#ptwo&#pthree->#cone";

  (* this is one you can prove *)

(* 5 *)

cleardefs();

DefSent "#qone" "(Ax1.(Ex2.(Ex3.P1(x2,x1)&P1(x1,x3))))";

DefSent "#qtwo" "(Ax1.~P1(x1,x1))";

DefSent "#qthree" "(Ex1.(Ax2.P2(x1,x2)vP2(x2,x1)))";

DefSent "#cone" "(Ex1.(Ex2.(Ex3.P2(x1,x2)&P1(x2,x3)&P2(x3,x1))))";

Start "#qone&#qtwo&#qthree->#cone";

  (* don't know whether this follows or not, so far *)

(* more to come -- I am planning to set up all the
exercises here *)



*)

fun premise() = l();

fun conclusion() = r();

fun getpremise n = gl n;

fun getconclusion n = gr n;

val prem = premise;

val conc = conclusion;

val getprem = getpremise;

val getconc = getconclusion;







