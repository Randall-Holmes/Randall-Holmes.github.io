(* the text home of the project of implementing a version of Watson based
on combinatory logic *)

(* Nov. 1:


in "safe area" comment, working on matching solution for multiple candidate
matches.  However, I have another approach in mind.  Abstract relative
to the value in T(U) only if all variables of U are found in L.  Also,
try matches for opposite order in a term if matches in first order do not
work.

A more modest refinement of higher order matching is implemented and
has been tested.  The multiple possible matches of the "safe area" function
will probably not be needed.  Match function does now attempt to match
applications and the two sides of an infix in both orders (but a complex
infix is matched without reference to its arguments -- this can be corrected
if it turns out to be a problem).  When T(U) matches V, we only attempt
to match T with (lambda U.V) when all variables in U are found in the already
given part of the match; otherwise we match structurally.  Further, 
structural matching between applications and infix terms does not work.
When matching from an infix term, structural matching is attempted first.
(perhaps the correct form of higher order matching is to match
T U V to L by matching U with (lambda |T|.lambda V.L); but note 
that this may happen automatically))

Further directions:

declaration control and definitions.  Declaration of theorems and identifiers.
The function "isabstract" should be passed information to know how many
arguments can be applied to a combinator before it ceases to be "abstract".
Theorems should have a special declaration list (for "pretheorems").

Dependencies on axioms, definitions and theorem text?  Reprove, theorem
export?

The hypothesis mechanism.  It occurred to me that this could be done without
doing s.c. abstraction first by changing equations so as to preserve type
as one navigates, but invisibly (by modifying the display to hide inconvenient
details) and permitting type-raised or lowered equations to rewrite all their
potential left and right sides appropriately.  x=y goes up to |x|=|y|
and down to x({x Diff y}(z)) = y({x Diff y}(z)):  each of these could
be displayed indifferently as x=y.  x=y would then support rewrites of the
other terms.

Hypotheses are to be carried around as a normally invisible part of the
selected term, so that all operations are actually local.  So there are
further games to be played with the display (and also with theorem
application so that it does not modify hypotheses).

The s.c. abstraction mechanism.  This of course needs services from the
declaration mechanism to handle scin/scout stuff (see old Watson).

Although I have had lots of fun engineering this version to do as well
as possible with no pair, a version with the TRC primitive pair would have
advantages in abstraction, I suspect.  This should probably be a separate
file, perhaps implemented as the very last thing.

Entire new vistas open up with the object language implementation ("quoted"
terms).

*)

(*

Oct. 29:

I would like to make matching smarter in some way.  The difficulty
lies with matching expressions with variable head.  One possibility
would be to maintain lists of possible matches (and in the end choose
the preferred survivor).  Another is that one ought to match in the
other order in a composite expression if the first one doesn't work.
Distinctions need to be drawn between explicit and implicit infix
expressions, perhaps.  When do we go to "structural" matching in an
application?  Getting a constant function as the higher order match
might be a hint -- but it doesn't always signal a problem.  This is
probably best used in combination with a system of putting up many
candidate matches.

For the moment it seems that matches between abstractions should work
more or less correctly?

*)

(*

Oct. 28:

Examples now include definitions of on-failure and on-success theorem
connectives in terms of the two basic theorem connectives.  "success"
is interpreted as making a change in a term, which is slightly different
from the meaning in old Watson.

Made theorem variable space and term variable space disjoint by
translation to negative variables.  Apparently isbadterm does not
object to negative variables, so if a theorem application introduces
variables the prover happily displays negative variables, and with
assign1 we can assign values to them.  Perhaps the prove command
should be guarded against accepting negative variables, completing a
fairly friendly system for handling the new variable issue (this is
now implemented).  This does actually work, though it isn't what I
expected.

corrected serious error in the new parser.

Found a problem with conflict between variables in theorems and variables
in concrete formats and target terms.  Suggestion:  translate all variables
in theorems into negative indices -- this will also prevent theorem
applications from introducing new variables, or at least allow control
of this phenomenon.

changed manual to reflect Oct. 27 updates.

revised abstraction so that explicit/implicit distinction in embedded theorems
is not destroyed.

It appears that I should perfect s.c. abstraction (or else a special variant
for equations -- but this seems unwise) before developing the hypothesis
mechanism, since I want the action of the hypothesis mechanism to be local
(the hypothesis list will be an invisible component of the selected term).

*)

(*

Oct. 27:

I have now installed the extra bit in constant functions which tells
whether they are explicitly defined by the user; an explicitly introduced
constant function will not collapse into infix notation.  A user command
toggleinfix() to reset all these flags one way or the other is provided.

I implemented the idea that application of the semantic function Ref
to any object term gives that same object term; this is built into quotecontract.

I still do not know why we get [x1=>"x2(x1)" Apply "x3(x4)"] (for example)
instead of "[x1=>"x2(x1)(x3(x4))"]";  The same thing happens with K; the top
level operator isn't handled correctly.

The parser will not accept more arguments after an application term
T(|U|)(V) (the kind which converts to an infix expression) unless we
enclose it in braces!  This should be fixed.  THIS IS NOW FIXED --
THE PARSER WAS COMPLETELY REENGINEERED.  I also made the command decision
that application terms appearing as infixes must be enclosed in braces;
this was not strictly necessary but can provide a useful clue in complex
infix expressions where one might lose track of what the infix is.

The parser now accepts T(|||U|||)(||V||)(|W|)(X), for example.  The old
version would allow any term to be entered but braces would be needed if
there were too many curried arguments with constant functions.

parser idea to avoid unintended infix terms -- distinguish between
explicit constant function constructions and those created by infix term
parsing?  Separate constructions "ConstantFunction1" and "ConstantFunction2"?
Give the ConstantFunction constructor a boolean field, set by the parser,
whose only function is to prevent the constant function from being subsumed
in an infix term.

Major change in matching:  introduced the "infix variable" exception
to higher-order matching.  It may be that the special case where an infix
expression matches an expression with leading Abst (not intended to be
an infix expression) will cause difficulties.  But actually, probably not.
Perhaps one ought to have an alternative position if the match fails
(attempt higher-order matching in this case?); this would solve the problem?
Done -- I put in higher-order matching when the match fails.  In fact,
this is actually an important case of higher-order matching and should not
be omitted.  The development of Allassocs now works correctly.

I also set Quote S to match Quote T, allowing some higher order matching to
take place in object terms.

On a superficial level, it seems that the object language feature works:
there is something odd about the display of [x1=>"x1(x1)"], but it's
probably something which will yield to finetuning.

My guess is that the basics are in place for the object language feature,
but a great deal needs to be done to really make it work.  The reason
it is provided is as a way to implement unstratified quantifications, which
are interpreted as involving abstraction over a model of the logic.
Is Ref("T") always equal to "T"?  This should be true (if Ref is a retraction,
which it might as well be) and will improve quotecontract.

*)

(*

Oct. 26:  I have been working on the manual.

Late:  I have installed the full quote facility (metatheory):  goodness
knows whether or how well it works!

*)

(*

Oct. 25:

At this point there are a number of things that ought to be done.
It's about time to implement hypotheses -- I prefer to have hypotheses
actually carried around in the process of term navigation (picked up
and dropped when appropriate) so that hypothesis manipulations are
close to local applications of sound rules in the same way that the
steps in application of the abstraction machinery are.  The system is
now protected in the sense that bound variables cannot be abused, so
the type free hypothesis axioms are sound.  I should WRITE A MANUAL
and start maintaining it in a sensible way, and then post this material
on the Watson page.  Then the natural development of strongly cantorian
types and then of metatheory should proceed.

On a retro level, the rules for an "unsafe" option (in which we are
doing polymorphic type theory) should also be available.  Perhaps there
should be a toggle to turn off the safety checks.

Kludge fixed:  it now does "honest" abstraction on iterated constant
functions of variables when abstracting and reducing embedded theorems 
(after a fashion!)

Full embedded theorem abstraction is restored.  There is a kludge
which must be noted: abstraction and reduction into theorems makes
sense only for variables at this point, since it proved necessary to
identify theorem abstraction from a variable with abstraction from its
constant function in order to get theorem abstraction without constant
function expansion (and similarly for reduction).  For the moment this
is probably workable but it could create trouble later.

minor fixes to matching projected.  In principle they are made.

insert "stratification check":  subs1 or change will not allow modifications
that introduce a free copy of the "bound variable".  This essentially checks
for stratification errors (and equally for opacity errors). This check has
been inserted.

consider requiring substitution to be strict (subs, not subs1):  every
variable must appear in the match?   This would prevent inverse theorems
from being applied in such a way as to introduce new variables, and probably
is best.  I did not do this:  strict substitution is not easy to implement.

restore variable-free character of embedded rules, now that the problem
with expandconstantfunctions has been identified.  Done.

consider using an "infix raising" operator to handle abstraction from infix
expressions:  this is clearly better than the conversion idea.  This ought
to be feasible.

Write procedures to support abstraction in the presence of strongly cantorian
types.  Longer term project.

*)

(*

Oct. 22:

There are probably bugs in substitution caused by updating the new variable
counter too soon.  Substitution requires that variables seen in all component
matches be remembered, and I'm not sure that this is enforced. Perhaps the
Look commands are the only ones which should update the variable counter.

Problems with variable renaming for embedded theorems were actually
caused by ineffective abstraction.  At the moment, I'm solving this
by the brutal expedient of identifying bound variables with their
constant functions for purposes of abstraction and reduction in embedded
rules.

Further nasty bug removed:  expandconstantfunctions didn't have ability
to extract constant functions from rule application terms, which had horrible
effects!  Rule application terms are for the moment opaque contexts,
which means that variable names in rule applications are fragile:  I should
change this back (but it seems that it should not be hard to restore the
original idea).

A more profound problem is the fact that bound variables themselves are
fragile:  if we introduce a variable at an incorrect type in an abstraction,
it kindly does it and renames the bound variable:  this seems to make the
type-free version of our hypothesis reasoning unsound.

Inert terms are implemented and moreover can be parsed and displayed,
and the user can make a subterm inert using the makeinert() command.
Inert terms seem to have the desired effect of making abstractions
properly transparent.

I made the higher-order matching more precise and fixed a variable
renaming bug in substitution.  One can now write an ABSTRACT tactic in
the system, as is demonstrated in the playspace.

Theorem applications currently announce their internal matches; a useful
debugging measure.

The "inertia" idea is implemented (apparently painlessly; we'll see
what problems pop up!)

There is a serious problem with arguments to embedded theorems in
abstracts:  the local bound variable is not treated correctly.

Consider "inertia" to handle the problem with transparency of abstractions
caused by the rule converting [x=>f(x)] to f when f is an abstraction.

If we represent [x=>f(x)] by Inert(f) instead of f, with the rule
of reduction Inert(f)(x) => f(x) (without further reduction on f)
then we will have invertibility.

Abstraction into "inert" environments:  [x=>Inert(A(B))]
is Inert_2(Abst([x=>A])([x=>B]))  where Inert_2(f)(x) reduces to
Inert(f(x)) (f(x) being reduced!).  

Semantics of Inert:  it doesn't change values at all; it is purely
a control operator for managing abstraction and reduction.

*)

(*

Oct. 21:

Final version of Oct. 21:  the parser is about as good as it will get
unless I install operator precedence.  [All(x1)=>x1=x1] illustrates
the facility for binders (All is applied not to x1 but to the whole
term).  The display function takes only constants as binders:  the
parser will abstract using any application term:  it will apply the
function to the abstraction of the body from the argument; if the function
is Id it will eliminate it, so it is still possible to abstract from
an application term (apply Id to it and abstract from that).

A string preprocessor to insert spaces and remove redundant spaces would
be to the point.  I'm frequently having trouble with things like x1+x2.

I have installed string pre- and postprocessing which enables the parser
to insert spaces in a natural way (and eliminate some redundant spaces)
except that the string "=>" will not have spaces inserted next to it
because of its role in abstractions; use of infixes containing this as
initial or final segment is thus deprecated.  The postprocessing allows
insertion of carriage returns; margin and indent can be set by the user.

Quite modest levels of abstraction nesting lead to absurdly sized terms.
It might be worthwhile to automatically convert infixes from left to
right before abstraction if the longer term is on the left (because
of constant function unpacking).  This is also an advertisement for
the use of the type-level pair (which is pending, and will affect the
amount of constant function unpacking that is needed).

Efficient representation using combinators is a research question...

Note that the pair can be introduced without parsing burden just as
RuleApp was introduced:  parse it initially as an infix called ",".

I want to tool up matching so that it matches abstractions as one expects;
though I am not absolutely sure that it doesn't do this already.

I tested convert and deconvert; the effects on lengths of abstractions
are dramatic in my particular rather forced example, but the "deconversion"
process does not work correctly.  It is necessary for deconversion to
work inside abstractions (we need strong reduction).  And perhaps we need
strong reduction anyway.  I'm leaving everything set up but commenting
out the uses of convert and deconvert.

It might be possible to make the convert program work by a purely
syntactical maneuver:  read x {Convert(x2)} y as y x2 x:  display
it this way, carry out matches in this way, and so forth.  Don't get rid
of the Converts at all; simply live with them?  But would one actually
gain anything over all?  Actually, it might be worth it: the construction
of deep levels of abstraction in one place which get resolved before going
to another place seems as if it might be typical of Watson reasoning.
underlying idea:  grammar requires us to write the longer term after an infix.
This is never visible to the user but allows cheaper abstraction.

*)

(*

Oct. 20:

Notice that this entire implementation makes no use of the notion
of stratification or type at all!

Final version of Oct. 20 resulted from a lengthy fight with a bug in
substitution; the Value tactic now works for a simple example, but I
don't think that all refinements are in yet.  An issue which I think
may cause trouble is that terms with the same display may actually not
be the same, and this may cause trouble for matching, particularly
higher order matching.  A general trick which I have been using in the
latest updates is to use change f [Value] to apply an operation f to
the value (then abstract back to get the result).  This didn't work
exactly for substitution because this uses "bad" intermediate terms --
so I "inlined" code from change to make this work.  I'm not absolutely
sure that the new substitution works -- check up on whether the dearg
implementation actually works.  I'm worried about bound variable
capture?  It's probably OK, though.

The display function seems to need isinfixterm to flag application
terms as well; otherwise its output cannot be parsed.  This has been
repaired.

constants now can be strings of special characters, and it is also
possible to suffix numerals to the name of any constant.

The rule application operators :>: and :<: are installed, with abstraction
implemented and the ri, rri, droprule rules installed as well.  Untyped
abstraction into embedded rules is supported; we should perhaps use
a cleaner abstraction algorithm (an analogue of fix1 should be defined).

Directionality on theorem application is installed.

This means that I'm almost ready to write "execute";

After writing basics of "execute", it is probably time to clean up
ths issue of constant declarations (recall that info for isabstract
is needed for general constants).  After that perhaps definitions?

Note that the untyped abstraction used for embedded theorems could
be replicated for the implementation of strongly cantorian types.

The basic Execute() and Onestep() commands are installed!  I still
need alternative rule application and Steps()

Abandoned use of "Lambda".  The elimination of (lambda x.f(x)) is
carried out only for components of abstracts (using the delambda
and delambda2 functions) but not at the top level.  Execute() should
now work on the internals of abstracts.

*)

(*

Oct. 19:  an issue:  consider a version of abstraction where we abstract
from a complex expression and want to recognize instances of the complex
expression inside "lambda-terms".  This seems to be related to the uneval
issue.

Movement to contexts and to multiple positions is now supported (the latter
in a general way but not the most intuitive way).  Operations on contexts
can currently have unexpected effects.  A more powerful test for "abstractness"
would help; or perhaps not using the "Lambda" simplification?  Another point:
in a "context" position, we know that we are in a lambda-safe position in the
term; maybe this information can be used.

I should install the rule application machinery, the hypothesis mechanism,
and the meta-machinery, so that we can proceed to implementation of sequent
calculus.  View this as the current project and we see all ingredients that
are needed:

1.  binder syntax.  Also, generalize forms of constants. (the latter is done).

2.  embedded rule applications, including Input.  This should
include parameters and such, as well as alternative application.
Basics of embedded rule application are done (not special rules
nor indeed execution yet).

3.  the axioms and built-in functions for equality.

4.  the definition facility!

5.  The meta-material with the needed upgrades to abstraction, etc.

I shouldn't spend too much time now on refining the context and goto
stuff, though it is certainly interesting.

A full implementation of this is a proof of concept of my whole
approach to foundations.  It will be quite interesting if it really
is possible to use combinators!

*)

(*

Oct. 16, 2004:

There now seems to be a substantial agenda for development of this program,
of which I provide a summary.

The assignment commands given are correct for type theory in which
variables of different type are actually different variables.  This
will be changed by creating assign and assigninto commands using
substitution rather than application and abstraction.

Create variables which reset the view (define Look in terms of a parameter).
Also, modify the effects of the movement commands according to the view?
This would require some changes to the internals of the movement commands,
but they may be worthwhile anyway.

   Multiple views are now defined.  They are not seamlessly tied to each
   other, because their representations of term structure are incompatible;
   transition from one view to another will probably require return to the
   top of the term!  Views may also be taken to affect how matching
   works!  I redefined the view1(), view2(), view3() commands to also execute
   top() so that position information is not coerced by view change.

   Discovered and fixed a bug in infix term display which I found by
   experimenting with views.

Context and goto movement commands.  For the goto command (and for other
purposes) we need to develop the CL version of "uneval".

Special character constants (operators).

Metatheory vs. object theory: the idea is to introduce a Quote term
construction which creates object terms (and also object terms within
the object language, and so forth).  Abstraction and reduction for
Quote terms seems to have a sensible model in my mind; this will be
added.  Theorems of the metatheory definitely port into the object
theory; the idea of reflecting object theorems upward also recommends
itself.  Is an Unquote operation needed to embed meta-constants in object
terms?

Parser issues:  implement binders.  This seems to be something to do early.

Implement the TRC type level pair.  The pair will allow a different
implementation of infix notation.

Develop the Watson theorem application system.  Dependencies probably wanted
eventually.  Definition facility.  Declarations of constants and theorems.
Declarations of constants can include the information needed to generalize
"isabstract" (how many applications we can make and still have a function).

*)

(* 

Oct. 15, 2004:

Term navigation is installed.  Bound variable handling is a little
strange but I think sound (this might be fixable by looking at how
Display3 serves up new variables).

*)

(*

Oct. 14, 2004:

LATEST UPDATE:  it now supports infix notation as syntactical sugar
on top of CL (including complex infixes!)  This may fulfill all desired
functions of virtual argument lists.  Note that the top level parser
function should at some point check for Argument subterms and raise
an error if they are present.

This now contains an implementation of TRC without the primitive pair
with abstraction and reduction algorithms.  There are display and parse
functions Display and parse which do not understand abstracts [xn=>T]
and there are display and parse functions Display2 and parse2 which do.
In any case actual terms are combinatory terms without any actual
bound variables.

Two further lines of progress:  implement navigation with the possibility
of navigation to values or to contexts, then implement the Watson theorem
system.  The syntax can be enhanced with virtual argument lists and infixes
at some point in this development.  The other line of development is to
retool the data type for minimal memory usage -- this seems important because
CL terms will probably as a rule be large.  But finicky memory storage
ought to have some chance of making this a plausible approach.  The
definition facility is also needed.

The isabstract function should be tooled to handle all constant-led
terms, consulting an arity for each constant.

The metalogic can probably be added fairly painlessly?  Or perhaps
this is the metalogic :-)

*)

(* design issues:  I'd like to support both a primitive pair (with the
TRC rule of application) and the virtual pair of the new CL treatment *)

(* all stored terms are to actually be CL terms.  The display function
and the navigation function use abstraction and reduction algorithms to
present terms in lambda-calculus form.  The idea is to see whether this
concept works at all!  *)

(* infixes are to be syntactic sugar for CL expressions.  Issues about
what style of pairing to use come to light at once. *)

(* structure of the term type:

application terms

constant function terms

variables -- indexed, with global facility for generation of new variables

constants -- a definition facility would be handy

TRC pair

a term type to handle virtual pair applications?

a term type to represent lambda-calculus terms?  (though not primitive
in principle, this still might be useful).

similarly, if-then-else terms might get a special term representation
because of their special status in the logic.

ultimately, support for virtual classes might be desirable -- recent
idea of type theory with our model of CL at the base might be the best
approach (since essentially the same logic can then be used at the
meta-level).  I think this is definitely the most attractive approach
-- it is odd but not bad that unstratified quantification is not the
same thing as stratified comprehension!  The primitives of the
meta-type theory will be the same as those of the base theory with the
exception that the application and constant function constructors of
the base theory become functions.  I suppose there is no reason that
the metatheory can't be ambiguous (can one have an ambiguous hierarchy
of metatheories?)  The metatheory will allow the statement of any
reasonable strong axioms we might want (it is in fact far stronger than is
needed for this purpose).

Some consideration of how to handle rule applications (and other term
labelling maneuvers?

This might end up as a full-scale reimplementation of Watson!

*)

(* static term type *)

datatype Term =

Variable of int |

Constant of string |

Application of Term*Term |

ConstantFunction of bool*Term |  (* the boolean is true if the constant function was explicitly entered by the user *)

RuleApp of (bool*Term*Term) |

Argument of Term |  (* used in parser *)

Inert of (int*Term) |  (* controls reductions *)

Quote of Term |   (* for the metatheory *)

(* Pair of Term*Term | *)

TermError;

fun termlength (Constant s) = length (explode s) |

termlength (Variable n) = length (explode(makestring n))+1 |

termlength (Application(T,U)) = (termlength T) + (termlength U) + 2 |

termlength (ConstantFunction (b,T)) = (termlength T) + 2 |

termlength (RuleApp(b,U,V)) = (termlength U) + (termlength V) + 4 |

termlength (Argument T) = (termlength T) + 2 |

termlength (Inert(n,T)) = termlength T |

termlength (Quote T) = 2+(termlength T) |

termlength TermError = 0;

fun rulefree (RuleApp(b,T,U)) = false |

rulefree (ConstantFunction (b,T)) = rulefree T |

rulefree (Application(T,U)) = rulefree T andalso rulefree U |

rulefree T = true;

fun isbadterm TermError = true |

isbadterm (Argument T) = true |

isbadterm (ConstantFunction (b,T)) = isbadterm T |

isbadterm (Application(T,U)) = isbadterm T orelse isbadterm U |

isbadterm (RuleApp(b,T,U)) = isbadterm T orelse isbadterm U 
orelse not(rulefree T) |

isbadterm (Constant s) = s = ":>:" orelse s = ":<:" |

isbadterm (Inert(n,T)) = isbadterm T |

isbadterm (Quote T) = isbadterm T |

isbadterm T = false;

(* simplest display function *)

fun Display (Variable n) = "x"^(makestring n) |

Display (Constant s) = s |

Display (Inert(n,T)) = "`"^(Display T)^"'" |

Display (Quote T) = "\""^(Display T)^"\"" |

Display (Application(T,U)) = (Display T)^"("^(Display U)^")" |

Display (RuleApp(b,T,U)) = if b then

Display(Application(Application(Constant ":>:",ConstantFunction (false,T)),U))

else Display(Application(Application(Constant ":<:",ConstantFunction (false,T)),U)) |

Display (ConstantFunction (b,T)) = "|"^(Display T)^"|" |

Display (Argument T) = Display T |

Display TermError = "? ! ?";

(* dynamic term type *)

datatype PreTermD =

VariableD of int |

ConstantD of string |

ApplicationD of (TermD ref) * (TermD ref) |

ConstantFunctionD of TermD ref |

PairD of (TermD ref)*(TermD ref) |

TermErrorD

and TermD = Top of PreTermD |

SubTerm of (TermD ref)*(PreTermD);  (* reference is back to parent term *)

fun display1 (VariableD n) = "x"^(makestring n) |

display1 (ConstantD s) = s |

display1 (ApplicationD(t,u)) = (display2(!t))^"("^(display2(!u))^")" |

display1 (ConstantFunctionD t) = "["^(display2 (!t))^"]" |

display1 (PairD(t,u)) = "<"^(display2(!t))^(display2(!u))^">" |

display1 TermErrorD = "! ? !"

and display2 (Top(y)) = display1 y |

display2 (SubTerm(x,y)) = display1 y;

(* numeral handling for parser *)

fun isdigit n = n= #"0" orelse n= #"1" orelse n= #"2" orelse n= #"3" orelse n=
#"4" orelse n= #"5"
orelse n= #"6" orelse n= #"7" orelse n= #"8" orelse n= #"9"; 

fun digitvalue  (#"0")=0 
|digitvalue (#"1")=1 
|digitvalue (#"2")=2 
|digitvalue (#"3")=3 |digitvalue (#"4")=4 
|digitvalue (#"5")=5 |
digitvalue (#"6")=6 
|digitvalue (#"7")=7 |digitvalue (#"8")=8 
|digitvalue (#"9")=9 |digitvalue x = ~1;

fun evalnum nil = ~1 |

evalnum [n] = digitvalue n |

evalnum (n::L) = if isdigit n then 10*(evalnum L) + (digitvalue n) else ~1;

fun getdigits nil = nil |

getdigits (n::L) = if isdigit n then ((getdigits L)@[n]) else nil;

fun restdigits nil = nil |

restdigits (n::L) = if isdigit n then restdigits L else (n::L);

fun islower c = c = #"a"
orelse c = #"b" orelse c = #"c" orelse c = #"d" orelse c = #"e" orelse c = #"f" orelse c = #"g" orelse c = #"h" orelse c = #"i" orelse c = #"j" orelse c = #"k" orelse c = #"l" orelse c = #"m" orelse c = #"n" orelse c = #"o" orelse c = #"p" orelse c = #"q" orelse c = #"r" orelse c = #"s" orelse c = #"t" orelse c = #"u" orelse c = #"v" orelse c = #"w" orelse c = #"x" orelse c = #"y" orelse c = #"z";
fun isupper c = c = #"A"
orelse c = #"B" orelse c = #"C" orelse c = #"D" orelse c = #"E" orelse c = #"F" orelse c = #"G" orelse c = #"H" orelse c = #"I" orelse c = #"J" orelse c = #"K" orelse c = #"L" orelse c = #"M" orelse c = #"N" orelse c = #"O" orelse c = #"P" orelse c = #"Q" orelse c = #"R" orelse c = #"S" orelse c = #"T" orelse c = #"U" orelse c = #"V" orelse c = #"W" orelse c = #"X" orelse c = #"Y" orelse c = #"Z";

fun isspecial c = c = #"~" 
orelse  c = #"!" 
orelse  c = #"@" 
orelse  c = #"$" 
orelse  c = #"%" 
orelse  c = #"^" 
orelse  c = #"&" 
orelse  c = #"*" 
orelse  c = #"-" 
orelse  c = #"+" 
orelse  c = #"=" 
orelse  c = #"~" 
(* orelse  c = #"|" *)
orelse  c = #":" 
orelse  c = #";" 
orelse  c = #"<" 
orelse c = #">" orelse  c = #"," orelse  c = #"." orelse  c = #"?" orelse c = #"/";

fun getlower nil = nil |

getlower (c::L) = if islower c then c::(getlower L) else nil;

fun restlower nil = nil |

restlower (c::L) = if islower c then restlower L else c::L;

fun getspecial nil = nil |

getspecial (c::L) = if isspecial c then c::(getspecial L) else nil;

fun restspecial nil = nil |

restspecial (c::L) = if isspecial c then restspecial L else c::L;

fun getname1 nil = "" |

getname1 (c::L) = if isupper c then implode (c::(getlower L))

else if isspecial c then implode(getspecial (c::L))

else "";

fun restname1 nil = nil |

restname1 (c::L) = if isupper c then restlower L else 

if isspecial c then restspecial (c::L)

else (c::L); 

fun getname L = let val A = getname1 L and B = restname1 L
in if B = nil orelse not (isdigit (hd B)) then A
else A^(implode(getdigits B)) end;

fun restname L = let val B = restname1 L in 
if B = nil orelse not(isdigit (hd B)) then B
else restdigits B end;

(* with internal reference structure, I should at least make a stab
at maximal efficiency in creating terms? *)

(* for this I would need a global catalog of TermD's (a sorted
binary tree would do the trick).  If I have unique reference, then
equality of references can be used to check?  Unfortunately
order of references is not available. *)

(* so what I need is a global sorted tree of PreTermD's
and a command for creating a compound term with given subterm(s):
look in the catalog and see if a reference to such a subterm is
already available -- use it if it is; otherwise make a new reference
and insert it into the catalog.  But notice that I only want to do
this if I am not going to make any dynamic changes to the term in
question:  such terms are appropriate for theorems, for example,
but not for the current term being manipulated. *)

(* the preparser should take as input a list of characters and output
a PreTermD? *)

(* simplest parser for static term type *)

(* utility for incremental construction of application terms *)

fun isargument (Argument A) = true |

isargument T = false;

fun isargumentlist (Application(Argument U,V)) = true |

isargumentlist (Application(U,V)) = isargumentlist U |

isargumentlist U = false;

fun unpack(Argument T) = unpack T |

unpack T = T;

fun repack (T, (Application(Application(A,ConstantFunction(false,B)),C))) =

Application(Application(A,ConstantFunction(false,repack(T,B))),C) |

repack (T, (Application(U,V))) = 

Application(repack (T, U),V) |

repack(T,Argument U) = Application(T,U) |

repack (T, TermError) = TermError |

repack (T,U) = Application(T,U);

fun preparse1 nil = TermError |

preparse1 (#"x"::L) = let val A = evalnum (getdigits L) in
if A = ~1 then TermError else Variable A end |

preparse1 (#"|"::L) = let val A = preparse L and B = restparse L

in if B = nil orelse hd B <> #"|" then TermError

else ConstantFunction (true,A)

end |

preparse1 (#"\""::L) = let val A = preparse L and B = restparse L

in if B = nil orelse hd B <> #"\"" then TermError

else Quote A

end |

preparse1 (#"("::L) = let val A = preparse L and B = restparse L

in if B = nil orelse hd B <> #")" then TermError

else Argument A

end |

preparse1 (c::L) = let val N = getname (c::L) in 

if N = "" then TermError else Constant N

end

and preparse L = let val A = preparse1 L and B = restparse1 L

in

if B = nil then A

else if hd B = #"(" then let val D = preparse B in

repack(A,D) end

else A end

and restparse1 nil = nil |

restparse1 (#"x"::L) = restdigits L |

restparse1 (#"|"::L) = let val B = restparse L
in if B = nil orelse hd B <> #"|" then nil else tl B end |

restparse1 (#"\""::L) = let val B = restparse L
in if B = nil orelse hd B <> #"\"" then nil else tl B end |

restparse1 (#"("::L)= let val B = restparse L
in if B = nil orelse hd B <> #")" then nil else tl B end |

restparse1 (c::L) = restname (c::L)

and

restparse L = let val B = restparse1 L

in if B = nil then nil

else if hd B = #"(" then restparse B else B

end;

fun parse s = let val A = preparse(explode s) and B = restparse(explode s)
in if B = nil then A else TermError end;

(* I think I now have adequate simple parse and display *)

(* abstraction and reduction algorithms *)

(* this should be an adequate abstraction algorithm for
weak extensionality, with what look like optimal simplifications
of abstracts *)

fun listapply1 T nil = T |

listapply1 T (c::L) = Application(listapply1 T L,c);

fun listapply T L = listapply1 T (rev L);

(* the abstract recognition function will need to be extendible to
handle defined combinators *)

fun isthmabstract (Constant "Id") = true |

isthmabstract (ConstantFunction (b,T)) = true |

(* isthmabstract (Application(Constant "Lambda", T))=true | *)

isthmabstract (Application(Constant "Thmk",T)) = true |

isthmabstract (Application(Application(Constant "Thmabst",T),U)) = true |

isthmabstract T = false;

fun isabstract (Constant "Id") = true |

isabstract (ConstantFunction (b,T)) = true |

isabstract (Constant "Abst") = true |

isabstract (Application(Constant "Abst",T)) = true |

isabstract (Application(Application(Constant "Abst",T),U)) = true |

isabstract (RuleApp(b,T,U)) = (* n>0 andalso isabstract U |  (* this could check for abstractness of theorem as well *) *)

isabstract U andalso isthmabstract T |

(* isabstract (Constant "Lambda") = true | *)

(* isabstract (Application(Constant "Lambda",T)) = true | *)

isabstract (Inert(n,T)) = isabstract T |

isabstract T = false;

fun fix1 (Application(Application(Constant "Abst",ConstantFunction (b,T)),ConstantFunction (b1,U))) = ConstantFunction(b orelse b1,Application(T,U)) |

fix1 (Application(Application(Constant "Abst",ConstantFunction (b,T)),Constant "Id")) = if isabstract T then Inert(1,T) else (Application(Application(Constant "Abst",ConstantFunction (b,T)),Constant "Id")) | 

fix1 (RuleApp(b,T,U)) = RuleApp(b,T,fix1 U) |

fix1 T = T; 

(* applications of Lambda (the retraction to the coextensional abstraction)
can be eliminated in arguments of Abst (and in similar positions for
arguments of defined operations) *)

fun delambda (Application(Application(Constant "Abst",ConstantFunction (b,T)),Constant "Id")) = delambda T |

delambda (RuleApp(b,T,U)) = RuleApp(b,T,delambda U) |

delambda T = T;

fun delambda2 (Application(Application(Constant "Thmabst",ConstantFunction (b,T)),Constant "Id")) = delambda2 T |

delambda2 T = T;

(* the additional argument is used if one is abstracting relative
to a complex term which contains a complex constant term which
one does not wish to expand *)


fun quoteexpand (ConstantFunction (b,T)) = ConstantFunction (b,quoteexpand T) |

quoteexpand (Application(U,V)) = Application(quoteexpand U,quoteexpand V) |

quoteexpand (RuleApp(b,T,U)) = RuleApp(b,quoteexpand T,quoteexpand U) |

quoteexpand (Inert(n,T)) = Inert(n,quoteexpand T) |

quoteexpand (Argument T) = Argument T|

quoteexpand (Quote(Variable n)) = Application(Constant "Ref",Variable n) |

quoteexpand (Quote(ConstantFunction (b,T))) = Application(if b then Constant "K1" else Constant "K2",quoteexpand(Quote T)) |

quoteexpand (Quote(Application(T,U))) = Application(Application(Constant "Apply",ConstantFunction(false,quoteexpand(Quote T))),quoteexpand(Quote U)) |

quoteexpand (Quote(RuleApp(b,T,U))) = Application(Application(Constant (if b then "R1" else "R2"),ConstantFunction(false,quoteexpand(Quote T))),quoteexpand(Quote U)) |

quoteexpand (Quote(Inert(n,T))) = if n<=1 then Application(Constant "I",quoteexpand(Quote T)) else  Application(Constant "I",quoteexpand(Quote (Inert(n-1,T)))) |

quoteexpand (Quote(Quote T)) = (fn (Quote U) => Quote(Quote U)| V => quoteexpand(Quote V))(quoteexpand (Quote T)) |

quoteexpand (Quote(Argument T)) = Quote(Argument T) |

quoteexpand T = T;

fun quotecontract (ConstantFunction (b,T)) = ConstantFunction(b,quotecontract T) |

quotecontract (RuleApp(b,T,U)) = RuleApp(b,quotecontract T,quotecontract U) |

quotecontract (Inert(n,T)) = Inert(n,quotecontract T) |

quotecontract (Argument T) = Argument T |

quotecontract (Application(Constant "Ref",Variable n)) = Quote(Variable n) |

quotecontract (Application(Constant "Ref",T)) =

(fn (Quote U) => Quote U | V => (Application(Constant "Ref",V)))(quotecontract T) |

quotecontract (Application(Constant "K1",T)) = (fn (Quote U) =>
Quote(ConstantFunction (true,U)) | V => Application(Constant "K1",V))(quotecontract T) |
quotecontract (Application(Constant "K2",T)) = (fn (Quote U) =>
Quote(ConstantFunction (false,U)) | V => Application(Constant "K2",V))(quotecontract T) |

quotecontract (Application(Application(Constant "Apply",ConstantFunction (b,U)),V)) = (fn (Quote W,Quote X) => Quote(Application(W,X)) | (W,X) => Application(Application(Constant "Apply",ConstantFunction (b,W)),X))(quotecontract U,quotecontract V) |

quotecontract (Application(Application(Constant "R1",ConstantFunction (b,T)),U)) =

(fn (Quote V,Quote W) => Quote(RuleApp(true,V,W)) | (V,W) =>(Application(Application(Constant "R1",ConstantFunction (b,V)),W)))(quotecontract T,quotecontract U) |

quotecontract (Application(Application(Constant "R2",ConstantFunction (b,T)),U)) =

(fn (Quote V,Quote W) => Quote(RuleApp(false,V,W)) | (V,W) =>(Application(Application(Constant "R1",ConstantFunction (b,V)),W)))(quotecontract T,quotecontract U) |

quotecontract (Application(Constant "I",T)) = (fn (Quote (Inert(n,U))) =>
Quote(Inert(n+1,U)) | Quote U => Inert(1,U) | U => Application(Constant "I",U))(quotecontract T) |

quotecontract (Application(U,V)) = Application(quotecontract U,quotecontract V) |

quotecontract T = T;


fun expandconstantfunctions W (ConstantFunction(b,Application(U,V)))

= if  (ConstantFunction(b,Application(U,V)))=W 

orelse (ConstantFunction(not b,Application(U,V)))=W then W else

Application(Application(Constant "Abst",expandconstantfunctions W (ConstantFunction (b,U))),expandconstantfunctions W (ConstantFunction (b,V))) |

expandconstantfunctions W (ConstantFunction(b1,RuleApp(b,T,U))) =

(* RuleApp(b,n+1,T,expandconstantfunctions W(ConstantFunction(U))) *)

RuleApp(b,ConstantFunction (b1,T),expandconstantfunctions W (ConstantFunction (b1,U)))

|

expandconstantfunctions W (ConstantFunction (b,T)) = 

if (ConstantFunction (b,T))=W 
orelse (ConstantFunction (not b,T))=W 

then W else

let val T2 = expandconstantfunctions W T in

if T2 = T then ConstantFunction (b,T)

else expandconstantfunctions W (ConstantFunction (b,T2)) end |

expandconstantfunctions W (Application(T,U)) =

if (Application(T,U)) = W then W else

Application(expandconstantfunctions W T,expandconstantfunctions W U) |

expandconstantfunctions W (RuleApp(b,T,U)) =

 RuleApp(b,T,expandconstantfunctions W U) | 

expandconstantfunctions W (Inert(n,T)) = Inert(n,expandconstantfunctions W T) |

expandconstantfunctions W T = T;

fun contractconstantfunctions (Application(Application(Constant "Abst",ConstantFunction (b,T)),ConstantFunction (b1,U))) = (ConstantFunction(b orelse b1,contractconstantfunctions(Application(T,U)))) |

contractconstantfunctions (RuleApp(b,ConstantFunction (b1,T),ConstantFunction (b2,U))) =

(* if n<=0 then RuleApp(b,0,T,contractconstantfunctions(ConstantFunction U))

else ConstantFunction(b1 orelse b2,RuleApp(b,n-1,T,contractconstantfunctions U)) *)

ConstantFunction(b1 orelse b2,RuleApp(b,T,contractconstantfunctions U)) |

contractconstantfunctions (Application(T,U)) = let val T2 = contractconstantfunctions T and U2 = contractconstantfunctions U in 

if T=T2 andalso U=U2 then Application(T,U)

else contractconstantfunctions (Application(T2,U2)) end |

contractconstantfunctions (ConstantFunction (b,T)) = ConstantFunction(b,contractconstantfunctions T) |

contractconstantfunctions (RuleApp(b,T,U)) =

RuleApp(b,T,contractconstantfunctions U) |

contractconstantfunctions (Inert(n,T)) = Inert(n,contractconstantfunctions T) |

contractconstantfunctions T = T;

(* "untyped" abstraction for embedded rules *)

fun thmfix (Application(Application(Constant"Thmabst",ConstantFunction (b,T)),ConstantFunction (b1,U))) = ConstantFunction(b orelse b1,Application(T,U)) |

thmfix (Application(Application(Constant"Thmabst",ConstantFunction (b,T)),Constant "Id")) = if isthmabstract T then T else (Application(Application(Constant"Thmabst",ConstantFunction (b,T)),Constant "Id")) | 

thmfix T = T;

fun ThmAbstract  (ConstantFunction (b,T)) U = Application(Constant "Klift",ThmAbstract T U) |

ThmAbstract T (Application(U,V)) =

if T = (Application(U,V)) then Constant "Id" else

thmfix(Application(Application(Constant "Thmabst",delambda2(ThmAbstract T U)),delambda2(ThmAbstract T V))) |

ThmAbstract T (ConstantFunction (b,U)) =

if T = (ConstantFunction (b,U))

orelse T = (ConstantFunction (not b,U))
 then Constant "Id" else

Application(Constant (if b then "Thmk1" else "Thmk2"),ThmAbstract T U) |

ThmAbstract T U = if T = U then Constant "Id" else 

ConstantFunction (true,U); 

fun Abstract1 T (Application(U,V)) =

if T = Application(U,V) then Constant "Id"

else (fix1 (listapply (Constant "Abst") [(* delambda *)(Abstract1 (ConstantFunction (false,T)) U),
(* delambda *)(Abstract1 T V)])) |

Abstract1 T (RuleApp(b,U,V)) = (* RuleApp(b,n+1,U,Abstract1 T V) | *)

RuleApp(b,ThmAbstract T U,Abstract1 T V) |

Abstract1 T (Inert(n,U)) = if T = (Inert(n,U)) then Constant "Id"

else Inert(n+1,Abstract1 T U) |

Abstract1 T U = if T = U then Constant "Id" else ConstantFunction (true,U);

fun Abstract T U = Abstract1 (quoteexpand T) (expandconstantfunctions (ConstantFunction (false,quoteexpand T)) (quoteexpand U));

fun abstract s t = Display(Abstract (parse s)(parse t));

fun Abstractlist nil U = U |

Abstractlist (c::L) U = Abstract c (Abstractlist L U);

fun abstractlist L u = Display(Abstractlist (map parse L) (parse u));

fun ThmReduce (Application(Constant "Klift",X)) (ConstantFunction (b,T)) = ThmReduce X T | 

ThmReduce (Constant "Id") T = T |

ThmReduce (ConstantFunction (b,T)) U = T |

(* ThmReduce (Application(Constant "Lambda",T)) U = Application(T,U) | *)

ThmReduce (Application(Application(Constant "Thmabst",T),U)) V =

Application(ThmReduce T V,ThmReduce U V) |

ThmReduce (Application(Constant "Thmk1",T)) U =

ConstantFunction(true,ThmReduce T U) |

ThmReduce (Application(Constant "Thmk2",T)) U =

ConstantFunction(false,ThmReduce T U) |

ThmReduce T U = Application(T,U); 

fun max(m:int,n:int) = if m<n then n else m;

fun Reduce1 (Application(Constant "Id",T)) = T |

Reduce1 (Application(ConstantFunction (b,T),U)) = T |

(* Reduce1(Application(Application(Constant "Lambda",T),U)) =

Application(T,U)  | *)



Reduce1 (Application(Application(Application(Constant "Abst",T),U),V)) =

(Application(Reduce1(Application(T,ConstantFunction (false,V))),Reduce1(Application(U,V))))

 |

Reduce1 (Application(RuleApp(b,T,U),V)) = 

(* if n <= 0 then (Application(RuleApp(b,n,T,U),V))

else RuleApp(b,n-1,T,Reduce1(Application(U,V))) *)

RuleApp(b,ThmReduce T V,Reduce1 (Application(U, V)))

 |

Reduce1 (Application(Inert(1,T),U)) = Application(T,U) |

Reduce1 (Application(Inert(n,T),U)) = Inert(n-1,Reduce1(Application(T,U))) |

Reduce1 T = T

and Reduce T = quotecontract(contractconstantfunctions(Reduce1(T)));

fun HeadReduce (Application(T,U)) = Reduce(Application(HeadReduce T,U)) |

HeadReduce T = T;

fun reduce s t = Display(Reduce(Application(parse s,parse t)));

fun parsetest s = Display(parse s) = s;

(* display with lambda terms *)

val NEWVAR = ref 0;

val THEVAR = ref (Variable 0);

fun getnewvar() = (NEWVAR:=(!NEWVAR)+1;Variable (!NEWVAR));

fun occursin n (Variable m) = n=m |

occursin n (ConstantFunction (b,T)) = occursin n T |

occursin n (Application(T,U)) = occursin n T orelse occursin n U |

occursin n (RuleApp(b,T,U)) = occursin n T orelse occursin n U |

occursin n (Inert(m,T)) = occursin n T |

occursin n (Quote T) = occursin n T |

occursin n (Argument T) = occursin n T | (* ??? *)

occursin n T = false;

fun newvarfromterm (Variable n) = NEWVAR:=max(n,(!NEWVAR)) |

newvarfromterm (ConstantFunction (b,T)) = newvarfromterm T |

newvarfromterm (Application(T,U)) = (newvarfromterm T;newvarfromterm U) |

newvarfromterm (RuleApp(b,T,U)) = (newvarfromterm T;  newvarfromterm U) |

newvarfromterm (Argument T) = (newvarfromterm T) |

newvarfromterm (Inert(n,T)) = newvarfromterm T |

newvarfromterm (Quote T) = newvarfromterm T |

newvarfromterm T = ();

fun getnewvarfromterm T = (newvarfromterm T;getnewvar());

fun resetvar() = NEWVAR:=0;

fun Display2 (Variable n) = "x"^(makestring n) |

Display2 (Constant s) = s |

Display2 (Inert(n,T)) = "`"^(Display2 T)^"'" |

Display2 (Application(Application(Constant "Abst",T),U)) =

(resetvar();(fn V => "["^(Display2 V)^"=>"^(Display2(Application(Reduce(Application(T,ConstantFunction (false,V))),Reduce(Application(U,V)))))^"]")(getnewvarfromterm((Application(Application(Constant "Abst",T),U))))) |

Display2 (Application(Constant "Abst",T)) = Display2 (Application(Application(Constant "Abst",ConstantFunction(false,Application(Constant "Abst",T))),Constant "Id")) |

Display2 (Application(T,U)) = (Display2 T)^"("^(Display2 U)^")" |

Display2 (RuleApp(b,T,U)) = 

if not(isabstract(RuleApp(b,T,U)) ) then

if b then

Display2(Application(Application(Constant ":>:",ConstantFunction (false,T)),U))

else Display2(Application(Application(Constant ":<:",ConstantFunction (false,T)),U))

else (resetvar();(fn V => "["^(Display2 V)^"=>"^(Display2(Reduce(Application(RuleApp(b,T,U),V))))^"]")(getnewvarfromterm(RuleApp(b,T,U))))

 |

Display2 (ConstantFunction (b,T)) = "|"^(Display2 T)^"|" |

Display2 (Quote T) = "\""^(Display2 T)^"\"" |

Display2 (Argument T) = Display2 T |

Display2 TermError = "? ! ?";

fun abstract2 s t = Display2(Abstract (parse s)(parse t));

(* parser updated to handle abstractions *)

fun preparse21 nil = TermError |

preparse21 (#"x"::L) = let val A = evalnum (getdigits L) in
if A = ~1 then TermError else Variable A end |

preparse21 (#"|"::L) = let val A = preparse2 L and B = restparse2 L

in if B = nil orelse hd B <> #"|" then TermError

else ConstantFunction (true,A)

end |
preparse21 (#"\""::L) = let val A = preparse2 L and B = restparse2 L

in if B = nil orelse hd B <> #"\"" then TermError

else Quote A

end |

preparse21 (#"("::L) = let val A = preparse2 L and B = restparse2 L

in if B = nil orelse hd B <> #")" then TermError

else Argument A

end |

preparse21 (#"["::L) = let val A = preparse2 L  and B = restparse2 L

in

if (* A = TermError orelse *)

B = nil orelse hd B <> #"=" orelse tl B = nil orelse hd(tl B) <> #">"

then TermError

else let val C = preparse2 (tl (tl B)) and D = restparse2 (tl (tl B)) in

if (* C = TermError orelse  *) D = nil orelse hd D <> #"]" then TermError

else Abstract A C

end

end

|

preparse21 (c::L) = let val N = getname (c::L) in 

if N = "" then TermError else Constant N

end

and preparse2 L = let val A = preparse21 L and B = restparse21 L

in

if B = nil then A

else if hd B = #"(" then let val D = preparse2 B in

repack(A,D) end

else A end

and restparse21 nil = nil |

restparse21 (#"x"::L) = restdigits L |

restparse21 (#"|"::L) = let val B = restparse2 L
in if B = nil orelse hd B <> #"|" then nil else tl B end |

restparse21 (#"\""::L) = let val B = restparse2 L
in if B = nil orelse hd B <> #"\"" then nil else tl B end |

restparse21 (#"("::L)= let val B = restparse2 L
in if B = nil orelse hd B <> #")" then nil else tl B end |

restparse21 (#"["::L) = let val B = restparse2 L in

if B = nil orelse hd B <> #"=" orelse tl B = nil orelse hd(tl(B))<> #">"

then nil else let val D = restparse2 (tl (tl B)) in 

if D= nil orelse hd D <> #"]" then nil else tl D end

end |

restparse21 (c::L) = restname (c::L)

and

restparse2 L = let val B = restparse21 L

in if B = nil then nil

else if hd B = #"(" then restparse2 B else B

end;

fun parse2 s = let val A = preparse2(explode s) and B = restparse2(explode s)
in if B = nil then A else TermError end;

(* this catches complex terms which must be parenthesized or braced
in the display *)

fun isinfixterm (Application(Application(T,ConstantFunction (false,U)),V)) =

T <> Constant "Abst" |

(* isinfixterm (Application(T,U)) = T <> Constant "Abst" | *)

isinfixterm (RuleApp(b,T,U)) = true |

isinfixterm T = false;

fun iscomplexterm (Application(Application(T,ConstantFunction (false,U)),V)) =

T <> Constant "Abst" |

iscomplexterm (Application(T,U)) = T <> Constant "Abst" | 

iscomplexterm (RuleApp(b,T,U)) = true |

iscomplexterm T = false;

fun Display3 (Variable n) = "x"^(makestring n) |

Display3 (Constant s) = s |

Display3 (Inert(n,T)) = if n < 2 then "`"^(Display3 T)^"'" else
"`"^(Display3(Inert(n-1,T)))^"'" |

Display3 (Quote T) = "\""^(Display3 T)^"\"" |

Display3 (Application(Application(Constant "Abst",T),U)) =

(resetvar();(fn V => "["^(Display3 V)^"=>"^(Display3(Application(Reduce(Application(T,ConstantFunction (false,V))),Reduce(Application(U,V)))))^"]")(getnewvarfromterm((Application(Application(Constant "Abst",T),U))))) |

Display3 (Application(Constant "Abst",T)) = Display3 (Application(Application(Constant "Abst",ConstantFunction(false,Application(Constant "Abst",T))),Constant "Id")) |

Display3 (Application(Constant W,(Application(Application(Constant "Abst",T),U)))) =

(resetvar();(fn V => "["^(Display3 (Application(Constant W,V)))^"=>"^(Display3(Application(Reduce(Application(T,ConstantFunction (false,V))),Reduce(Application(U,V)))))^"]")(getnewvarfromterm((Application(Application(Constant "Abst",T),U))))) |

Display3 (Application(Constant W,(Application(Constant "Abst",T)))) = Display3 (Application(Constant W,(Application(Application(Constant "Abst",ConstantFunction(false,Application(Constant "Abst",T))),Constant "Id")))) |

Display3 (Application(Application(T,ConstantFunction (false,U)),V)) =

(if isinfixterm U then "(" else "")^(Display3 U)^
(if isinfixterm U then ")" else "")
^" "^
(if iscomplexterm T then "{" else "")^
(Display3 T)^
(if iscomplexterm T then "}" else "")^
" "^(Display3 V) | 

Display3 (Application(T,U)) = 
(if isinfixterm T then "{" else "")^
(Display3 T)^
(if isinfixterm T then "}" else "")^
"("^(Display3 U)^")" |

Display3 (RuleApp(b,T,U)) = 

if not(isabstract(RuleApp(b,T,U)) ) then

if b then

Display3(Application(Application(Constant ":>:",ConstantFunction (false,T)),U))

else Display3(Application(Application(Constant ":<:",ConstantFunction (false,T)),U))

else (resetvar();(fn V => "["^(Display3 V)^"=>"^(Display3(Reduce(Application(RuleApp(b,T,U),V))))^"]")(getnewvarfromterm(RuleApp(b,T,U))))

 |


Display3 (ConstantFunction (b,T)) = "|"^(Display3 T)^"|" |

Display3 (Argument T) = "(* "^Display3 T^" *)" |

Display3 TermError = "? ! ?";

fun abstract3 s t = Display3(Abstract (parse s)(parse t));

(* parser updated to handle abstractions and infix notation *)

(*  begin bad parser

fun preparse31 nil = TermError |

preparse31 (#"x"::L) = let val A = evalnum (getdigits L) in
if A = ~1 then TermError else Variable A end |

preparse31 (#"|"::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #"|" then TermError

else ConstantFunction (true,A)

end |

preparse31 (#"\""::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #"\"" then TermError

else Quote A

end |

preparse31 (#"("::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #")" then TermError

else Argument A

end |

preparse31 (#"{"::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #"}" then TermError

else A

end |

preparse31 (#"`"::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #"'" then TermError

else (fn (Inert(n,T)) => Inert(n+1,T) | A => Inert(1,A))(A)

end |

preparse31 (#"["::L) = let val A = preparse3 L  and B = restparse3 L

in

if (* A = TermError orelse *)

B = nil orelse hd B <> #"=" orelse tl B = nil orelse hd(tl B) <> #">"

then TermError

else let val C = preparse3 (tl (tl B)) and D = restparse3 (tl (tl B)) in

if (* C = TermError orelse  *) D = nil orelse hd D <> #"]" then TermError

else 

(fn (Application(Constant "Id",Y),C) => Abstract Y C |

(Application(X,Y),C) => Application(X,Abstract Y C) | (A,C) =>Abstract A C)(A,C)

end

end

|

preparse31 (c::L) = let val N = getname (c::L) in 

if N = "" then TermError else Constant N

end

and preparse3 L = let val A = preparse31 L and B = restparse31 L

in

if B = nil then A

else if hd B = #"(" then let val D = preparse3 B in

repack(A,D) end

else if hd B = #" " 

then let val D = preparse31 (tl B) 
and E = restparse31 (tl B) in

if E = nil orelse hd E <> #" " then TermError

else let val F = preparse3 (tl E) in

if D = Constant ":>:" then RuleApp(true,unpack A,unpack F)

else if D = Constant ":<:" then RuleApp(false,unpack A,unpack F)

else (Application(Application(D,ConstantFunction(false,unpack A)),unpack F))

end

end

else A end

and restparse31 nil = nil |

restparse31 (#"x"::L) = restdigits L |

restparse31 (#"|"::L) = let val B = restparse3 L
in if B = nil orelse hd B <> #"|" then nil else tl B end |

restparse31 (#"\""::L) = let val B = restparse3 L
in if B = nil orelse hd B <> #"\"" then nil else tl B end |

restparse31 (#"("::L)= let val B = restparse3 L
in if B = nil orelse hd B <> #")" then nil else tl B end |

restparse31 (#"{"::L)= let val B = restparse3 L
in if B = nil orelse hd B <> #"}" then nil else tl B end |

restparse31 (#"`"::L)= let val B = restparse3 L
in if B = nil orelse hd B <> #"'" then nil else tl B end |

restparse31 (#"["::L) = let val B = restparse3 L in

if B = nil orelse hd B <> #"=" orelse tl B = nil orelse hd(tl(B))<> #">"

then nil else let val D = restparse3 (tl (tl B)) in 

if D= nil orelse hd D <> #"]" then nil else tl D end

end |

restparse31 (c::L) = restname (c::L)

and

restparse3 L = let val B = restparse31 L

in if B = nil then nil

else if hd B = #"(" then restparse3 B 

else if hd B = #" " then 

let val C = restparse31 (tl B) in

if C = nil orelse hd C <> #" " then nil

else restparse3 (tl C)

end

else B

end;

end bad parser *)

fun repack2 A nil = A |

repack2 A (B::L) = Application(repack2 A L,B);

(* parse one term *)

fun preparse31 nil = TermError |

(* get a variable *)

preparse31 (#"x"::L) = let val A = evalnum (getdigits L) in
if A = ~1 then TermError else Variable A end |

(* get a constant function *)

preparse31 (#"|"::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #"|" then TermError

else ConstantFunction (true,A)

end |

(* get an object term *)

preparse31 (#"\""::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #"\"" then TermError

else Quote A

end |

(* get a term in braces *)

preparse31 (#"{"::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #"}" then TermError

else A

end |

(* get an "inert" term *)

preparse31 (#"`"::L) = let val A = preparse3 L and B = restparse3 L

in if B = nil orelse hd B <> #"'" then TermError

else (fn (Inert(n,T)) => Inert(n+1,T) | A => Inert(1,A))(A)

end |

(* read a lambda-term *)

preparse31 (#"["::L) = let val A = preparse3 L  and B = restparse3 L

in

if (* A = TermError orelse *)

B = nil orelse hd B <> #"=" orelse tl B = nil orelse hd(tl B) <> #">"

then TermError

else let val C = preparse3 (tl (tl B)) and D = restparse3 (tl (tl B)) in

if (* C = TermError orelse  *) D = nil orelse hd D <> #"]" then TermError

else 

(fn (Application(Constant "Id",Y),C) => Abstract Y C |

(Application(X,Y),C) => Application(X,Abstract Y C) | (A,C) =>Abstract A C)(A,C)

end

end

|

(* read a constant term *)

preparse31 (c::L) = let val N = getname (c::L) in 

if N = "" then TermError else Constant N

end

and getargumentlist (#"("::L) =

let val T = preparse3 L and U = restparse3 L in

if U = nil orelse hd U <> #")" then [TermError]

else (T::(getargumentlist (tl U))) end |

getargumentlist L = nil

(* a term beginning with a parenthesis must be an infix term *)

and preparse3 ((#"(")::L) = let val T = getargumentlist ((#"(")::L) 

and U = restargumentlist ((#"(")::L) in

if T = [TermError] orelse length T <> 1 orelse U = nil 
orelse hd U <> #" " then TermError

else let val V = preparse31 (tl U) and W = restparse31 (tl U) in

if W = nil orelse hd W <> #" " then TermError

else let val X = preparse3 (tl W) in Application(Application(V,ConstantFunction (false,(hd T))),X) end end end  |

preparse3 L = 
let val T = preparse31 L and U = restparse31 L
in
if U = nil then T
else if hd U = #"(" 
   then let val V = getargumentlist U and W = restargumentlist U  
   in if W = nil then repack2 T (rev V)
   else if hd W = #" "
       then let val X = preparse31 (tl W) and Y = restparse31 (tl W) in
       if Y = nil orelse hd Y <> #" "
          then TermError
          else Application(Application(X,ConstantFunction(false,repack2 T (rev V))),
              preparse3(tl Y))
     end
   else repack2 T (rev V)
   end
else if hd U = #" "
   then let val X = preparse31 (tl U) and Y = restparse31 (tl U) in
   if Y = nil orelse hd Y <> #" "
   then TermError
   else Application(Application(X,ConstantFunction (false,T)),preparse3 (tl Y))
   end
else T
end

and restparse31 nil = nil |

restparse31 (#"x"::L) = restdigits L |

restparse31 (#"|"::L) = let val B = restparse3 L
in if B = nil orelse hd B <> #"|" then nil else tl B end |

restparse31 (#"\""::L) = let val B = restparse3 L
in if B = nil orelse hd B <> #"\"" then nil else tl B end |

restparse31 (#"{"::L)= let val B = restparse3 L
in if B = nil orelse hd B <> #"}" then nil else tl B end |

restparse31 (#"`"::L)= let val B = restparse3 L
in if B = nil orelse hd B <> #"'" then nil else tl B end |

restparse31 (#"["::L) = let val B = restparse3 L in

if B = nil orelse hd B <> #"=" orelse tl B = nil orelse hd(tl(B))<> #">"

then nil else let val D = restparse3 (tl (tl B)) in 

if D= nil orelse hd D <> #"]" then nil else tl D end

end |

restparse31 (c::L) = restname (c::L)

and restargumentlist ((#"(")::L) =

let val U = restparse3 L in if U = nil orelse hd U <> #")" then nil

else restargumentlist (tl U) end |

restargumentlist L = L

and restparse3 ((#"(")::L) = let val T = getargumentlist ((#"(")::L) 

and U = restargumentlist ((#"(")::L) in

if T = [TermError] orelse length T <> 1 orelse U = nil 
orelse hd U <> #" " then nil

else let val W = restparse31 (tl U) in

if W = nil orelse hd W <> #" " then nil

else restparse3 (tl W)  end end  |

restparse3 L = 
let val T = preparse31 L and U = restparse31 L
in
if U = nil then nil
else if hd U = #"(" 
   then let val V = getargumentlist U and W = restargumentlist U  
   in if W = nil then nil
   else if hd W = #" "
       then let val X = preparse31 (tl W) and Y = restparse31 (tl W) in
       if Y = nil orelse hd Y <> #" "
          then nil
          else restparse3(tl Y)
     end
   else W
   end
else if hd U = #" "
   then let val X = preparse31 (tl U) and Y = restparse31 (tl U) in
   if Y = nil orelse hd Y <> #" "
   then nil
   else restparse3 (tl Y)
   end
else U
end;



(* string preprocessor *)

(* the carriage return handling is designed so that postprocessed text
for output can actually be parsed *)

(* note that separating spaces are NOT provided next to all parentheses;
spaces between infix operators and adjacent following parentheses are
required. It's not that bad, because with APL precedence such parentheses
can usually be omitted anyway.*)

(* the two different flavors of parentheses have a semantic
difference: true parentheses are function arguments (whether the
function is prefix or infix), while complex terms in braces are not
(as a rule: braces can be applied to arguments of infixes *)

fun okbrace1 c = c = #"]" orelse c = #")" orelse c = #"}";
fun okbrace2 c  = c = #"[" orelse c = #"{";

fun preprocess nil = nil |

preprocess ((#" ")::((#" ")::L)) = preprocess(#" "::L) |
preprocess ((#"\n")::((#" ")::L)) = preprocess(#" "::L) |
preprocess ((#" ")::((#"\n")::L)) = preprocess(#" "::L) |
preprocess ((#")")::(#"\n")::(#"(")::L)=preprocess ((#")")::(#"(")::L)|

preprocess (#"\n"::L) = preprocess (#" "::L) |

preprocess (s::(#"=")::(#">")::t::L) = (s::(#"=")::(#">")::(preprocess (t::L))) |

preprocess (S::T::L) = if (isspecial S andalso (islower T orelse isupper T orelse isdigit T orelse okbrace2 T)) orelse (isspecial T andalso (islower S orelse isupper S orelse isdigit S orelse okbrace1 S))

then S::((#" ")::(preprocess(T::L)))

else S::(preprocess(T::L)) |

preprocess (s::L) = s::(preprocess L);

fun parse3 s = let val A = preparse3(preprocess(explode s)) and B = restparse3(preprocess(explode s))
in if B = nil then A else TermError end;

(* one more parser and display update -- probably to be added directly
to version 3.  Allow binding operations: All([x1=>T]) becomes [All
x1=>T] *)

(* tools for finding things in lists *)

fun find x nil = [] |

find s ((t,u)::L) = if s=t then [u] else find s L;

fun foundin s L = find s L <> nil;

fun safefind default s L = let val t = 
find s L in if t = nil then default else hd t end;

(* check that every variable in a term has a match on a list *)

fun covers L (Variable n) = find n L <> nil |

covers L (ConstantFunction (b,T)) = covers L T |

covers L (Application(T,U)) = covers L T andalso covers L U |

covers L (Inert(n,T)) = covers L T |

covers L (Quote T) = covers L T |

covers L (Argument T) = covers L T |

covers L T = true;

(* list merge for matches *)

val NEGNEW = ref 0;

fun getnegvar() = (NEGNEW:=(!NEGNEW)-1;Variable (!NEGNEW));

fun resetnegvar() = NEGNEW:=0;

fun equals T U = if T = U then true

else if isabstract T andalso isabstract U then

let val N = getnegvar() in

equals (Reduce (Application(T,N))) (Reduce (Application(U,N)))

end

else false;

fun reconcile nil L = nil |

reconcile L nil = nil |

reconcile [(n,t)] M = if find n M = nil

then ((n,t)::M)

else if find n M = [t]

then M

else nil |

reconcile ((n,t)::L) M = if find n M = nil

then reconcile L ((n,t)::M)

else if (* (resetnegvar();equals(hd(find n M))t) *) find n M = [t]

then reconcile L M

else nil;

(* reconcile rank-ordered lists of possible matches *)
(*
fun reconcile2 nil L = nil |

reconcile2 L nil = nil |

reconcile2 [L] (M1::M) = let val MATCH1 = if reconcile L M1 = nil

then reconcile2 [L] M

else (MATCH1::(reconcile2 [L] M)) end |

reconcile2 (L1::L) M =

(reconcile2 [L1] M)@(reconcile2 L M);
*)
(* rule application terms do not match anything *)
(* this will have some kind of effect on uneval and context 
movement *)

val VIEW = ref 3;

fun DisplayV x = if (!VIEW) = 1 then Display x else if (!VIEW) = 2 then
Display2 x else Display3 x;

(* to get the "goto" position function we need an UNEVAL operation *)

datatype Position = Left | Right | Middle | Value | Function |
         Context of Term | Goto of Term;

fun say s = TextIO.output(TextIO.stdOut,"\n\n"^s^"\n\n");

fun versiondate() = say "November 1, 2004";

(* block any bad change in a term *)

fun protect f T = if isbadterm (f T) then 
(say "Attempt to make ill-formed term!";T) else f T;

(* apply an operation to a "subterm" in a general sense *)

fun change f L (Inert(n,T)) = Inert(n,change f L T) |

change f nil T = protect f T |

(* one cannot navigate into an applied rule *)

change f (x::L) (Quote T) = Quote(change f L T) |

change f ((Context T)::L) U =

Reduce(Application(change f L (Abstract T U),T)) |

(* change f ((Goto T)::L) U =

if uneval T U = TermError then (say "Context formation error!";U)

else

Reduce(Application(T,change f L (uneval T U))) | *)

change f (Value::L) T = 

if (!VIEW) = 1 then (say "Abstraction not supported in this view!";T) else

(resetvar();newvarfromterm T;

let val (Variable n) = getnewvar() in

if isabstract T then

let val TT = Abstract (Variable n) (change f L (Reduce (Application(T,Variable n))))

in if occursin n TT then (say"Bound variable becomes free!";T) else TT end

else (say "Term is not abstract";T)

end) |

change f (x::L) (RuleApp(b,T,U)) = 

if isabstract (RuleApp(b,T,U)) then change f (Value::L) (RuleApp(b,T,U))

else

RuleApp(b,T,change f L U) |

change f (x::L) (Application(Constant "Abst",T)) =

if (!VIEW) = 1 then if x = Left then

(Application(change f L (Constant "Abst"),T))

else if x = Right then

(Application(Constant "Abst",change f L T))

else (say "Option not supported under this view!";(Application(Constant "Abst",T)))

else

change f (Value::L) (Application(Constant "Abst",T)) |

change f (x::L) (Application(Application(Constant "Abst",T),U)) =

if (!VIEW) = 1 then if x = Left then

(Application(change f L (Application(Constant "Abst",T)),U))

else if x = Right then

(Application(Application(Constant "Abst",T),change f L U))

else (say "Option not supported under this view!";(Application(Application(Constant "Abst",T),U)))

else

change f (Value::L) (Application(Application(Constant "Abst",T),U)) |

change f (x::L) (ConstantFunction (b,T)) = ConstantFunction (b,change f L T) |

(* function option exists in order to deal with pathologies which can
occur with infix notation *)

change f (Function::L) (Application(T,U)) = Application(change f L T,U) |

change f (Function::L) T = (say "Not an application term";T) |

change f (Left::L) (Application(Application(T,ConstantFunction (false,U)),V)) =

if (!VIEW)<3 then

(Application(change f L (Application(T,ConstantFunction (false,U))),V))

else

(Application(Application(T,ConstantFunction (false,change f L U)),V)) |

change f (Right::L) (Application(Application(T,ConstantFunction (false,U)),V)) =

(Application(Application(T,ConstantFunction (false,U)),change f L V)) |

change f (Middle::L) (Application(Application(T,ConstantFunction (false,U)),V)) =

if (!VIEW)<3 then

(say "Option not available under this view!";(Application(Application(T,ConstantFunction (false,U)),V)))

else

(Application(Application(change f L T,ConstantFunction (false,U)),V)) |

change f (Right::L) (Application(T,U)) = 

Application(T,change f L U) |

change f (x::L) (Application(T,U)) =

if (!VIEW)<3 andalso x = Middle 

then

(say "Option not available under this view!";(Application(T,U)))

else

Application(change f L T,U) |

change f L T = (say "Subterm error!";T);

fun subs1 T U (Inert(n,V)) = Inert(n,subs1 T U V) | 

subs1 T U (Quote V) = quotecontract(subs1 (quoteexpand T) (quoteexpand U) (quoteexpand (Quote V))) |

subs1 T U (Variable n) =

if T = Variable n then U else Variable n |

subs1 T U (Constant s) = if T = Constant s then U else Constant s |

subs1 T U (ConstantFunction (b,V)) = if T = ConstantFunction (b,V)

orelse T = ConstantFunction (not b,V) then

U else ConstantFunction(b,subs1 T U V) |

subs1 T U (Application(V,W)) = 

if T = Application(V,W) then U 

else

if isabstract(Application(V,W)) then

(newvarfromterm (Application(V,W));newvarfromterm U;

let val Variable n = getnewvar() in

let val TT = Abstract (Variable n) (subs1 T U (Reduce (Application(Application(V,W),Variable n)))) in 

if occursin n TT then (say "Bound variable becomes free!";TermError) else TT end

end)

else if T = V then Reduce(Application(U,W))

else Application(subs1 T U V,subs1 T U W) |

subs1 T U (Argument V) = Argument V |

subs1 T U (RuleApp(b,V,W)) = 

if isabstract (RuleApp(b,V,W))

then (newvarfromterm(RuleApp(b,V,W)) ;newvarfromterm U;

let val (Variable n) = getnewvar() in

let val TT =
Abstract (Variable n) (subs1 T U (Reduce (Application(RuleApp(b,V,W),
Variable n)))) 
  in if occursin n TT then (say "Bound variable becomes free!";TermError) 
  else TT end

end)

else RuleApp(b,subs1 T U V,subs1 T U W) |

subs1 T U TermError = TermError;

(* removes Argument instances in simultaneous substitutions *)

fun dearg (Argument T) = T |

dearg (Quote T) = Quote(dearg T) |

dearg (ConstantFunction (b,T)) = ConstantFunction (b,dearg T) |

dearg (Application(Argument T,U)) = 

Reduce(Application(T,dearg U)) |

dearg (Application(T,U)) = 

if isabstract (Application(T,U)) then

(newvarfromterm (Application(T,U));

let val Variable n = getnewvar() in

Abstract (Variable n) (dearg (Reduce (Application(Application(T,U),Variable n))))

end) else

Application(dearg T,dearg U) |

dearg (RuleApp(b,T,U)) = 

if isabstract(RuleApp(b,T,U)) then

(newvarfromterm (RuleApp(b,T,U));

let val Var = getnewvar() in

Abstract Var (dearg (Reduce (Application((RuleApp(b,T,U)),Var))))

end) else

RuleApp(b,dearg T,dearg U) |

dearg (Inert(n,T)) = Inert(n,dearg T) |

dearg T = T;

fun subs2 nil T = T |

subs2 ((n,t)::L) T = subs1 (Variable n) (Argument t) (subs2 L T);

fun subs L T = dearg(subs2 L T);

(* I don't think that the "matches" being developed below will be needed.
precis of higher order matching:  expressions x1(x2) are first matched
by abstracting the target rel x2 and matching this to x1 -- but only if
all variables in x1 are explained in the match already given. After
this structural mapping is attempted.  Application terms do not match
infix terms structurally.  When one infix term is matched with another,
structural matching is attempted first.  In application terms, match is
attempted in both orders; in infix terms, application is attempted
in two orders -- the infix part is always matched first.  Is this OK:
are we likely to need information from the matching of arguments to
successfully match an infix?  For the moment I simply note this:
complex infixes are not a common feature yet?  (but will be when case
expressions are considered).  The problem is that there are six possible
orders!

*)

fun match nil T U = nil | 

match L (Inert(n,S)) T = match L S T |

match L (Variable n) T = [(n,T)] |

match L S (Inert(n,T)) = match L S T |

match L (Constant S) (Constant T) = if S=T then [(~1,Variable ~1)] else nil|

match L (ConstantFunction (b,S)) (ConstantFunction (c,T)) = match L S T |

 match L (Application(Application(Constant "Abst",ConstantFunction (b,T)),Constant "Id"))(Application(Application(Constant "Abst",ConstantFunction (c,T2)),Constant "Id"))

= match L T T2 |

 match L (Application(Application(Constant "Abst",ConstantFunction (b,T)),Constant "Id")) U = if isabstract U then match L T U else nil |

(* this is the infix variable exception.  Is it a problem
if S = Abst?; I put in higher order matching if plain infix
matching fails. *)

match L (Application(Application(S1,ConstantFunction (false,T)),U))
(Application(Application(S,ConstantFunction (false,T2)),U2)) =

let val M1 = reconcile (match L (S1) S) L in

let val M2 = reconcile(match M1 T T2)M1 in

let val M3 = reconcile (match M2 U U2) M2 in

if M3 <> nil then M3

else let val M4 = reconcile (match M1 U U2) M1 in

let val M5 = reconcile (match M4 T T2) M4 in

if M5 <> nil then M5 else

if covers L U then 

reconcile (match L U (subs L U)) 
(match (reconcile (match L U (subs L U)) L) 
 (Application(S1,ConstantFunction (false,T)))
(Abstract (subs L U) (Application(Application(S,ConstantFunction (false,T2)),U2))))

else nil

end end end end end

 |

match L (Application(S,T)) (Application(S2,T2)) =

let val M1 = if (not(covers L T)) then nil else

reconcile (match L T (subs L T)) 
(match (reconcile (match L T (subs L T)) L) 
S (Abstract (subs L T) (Application(S2,T2))))

in 

if M1 <> nil then M1

else if HeadReduce(Application(S,T)) <> Application(S,T) then

let val M2 = match L (HeadReduce(Application(S,T))) (Application(S2,T2))

in if M2 <> nil then M2

else let val M3 = if isinfixterm (Application(S2,T2)) then nil

else reconcile (match L T T2) L

in 

let val M4 = reconcile (match M3 S S2) M3 

in if M4 <> nil then M4

else let val M5 = if isinfixterm (Application(S2,T2)) then nil

else reconcile (match L S S2) L

in reconcile (match M5 T T2) M5

end

end

end

end

else let val M3 = reconcile (match L T T2) L

in 

let val M4 = if isinfixterm (Application(S2,T2)) then nil

else reconcile (match M3 S S2) M3 

in

if M4 <> nil then M4

else let val M5 = if isinfixterm (Application(S2,T2)) then nil

else reconcile (match L S S2) L

in reconcile (match M5 T T2) M5

end

end

end

end

|

match L (RuleApp(b,S,T)) U = nil |

match L (Application(S,T)) U = 

let val M1 = if (not(covers L T)) then nil else 

reconcile (match L T (subs L T)) 
(match (reconcile (match L T (subs L T)) L)
S (Abstract (subs L T) U)) in

if M1 <> nil then M1

else if HeadReduce(Application(S,T)) <> Application(S,T) then 

match L (HeadReduce(Application(S,T))) U 

else nil

end

|

match L (Quote S) (Quote T) = match L S T |

match L (Quote S) T = match L (quoteexpand S) (quoteexpand T) |

match L S (Quote T) = match L (quoteexpand S) (quoteexpand T) |



match L T U = nil

and Match1 T U = match [(~1,Variable ~1)] T U;

(*  safe area for development of matches function handling multiple possible matches 

fun matches nil T U = nil | 

matches L (Inert(n,S)) T = matches L S T |

matches L (Variable n) T = [[(n,T)]] |

matches L S (Inert(n,T)) = matches L S T |

matches L (Constant S) (Constant T) = if S=T then [[(~1,Variable ~1)]] else nil|

matches L (ConstantFunction (b,S)) (ConstantFunction (c,T)) = matches L S T |

 matches L (Application(Application(Constant "Abst",ConstantFunction (b,T)),Constant "Id"))(Application(Application(Constant "Abst",ConstantFunction (c,T2)),Constant "Id"))

= matches L T T2 |

 matches L (Application(Application(Constant "Abst",ConstantFunction (b,T)),Constant "Id")) U = if isabstract U then matches L T U else nil |

(* this is the infix variable exception.  Is it a problem
if S = Abst?; I put in higher order matching if plain infix
matching fails. *)

matches L (Application(Application(Variable n,ConstantFunction (false,T)),U))
(Application(Application(S,ConstantFunction (false,T2)),U2)) =

let val M1 = reconcile2 [[(n,S)]] L in

let val M2 = reconcile2(matches M1 T T2)M1 in

let val M3 = reconcile2 (matches M2 U U2) M2 in (* include other order, too *)

let val M4 = reconcile2 (matches M1 U U2) in

let val M5 = reconcile2 (matches M4 T T2) in

(if M3 = nil then nil else M3)@(if M5 = nil then nil else M5)@(reconcile2 (matches L U (subs L U)) 
(matches (reconcile2 (matches L U (subs L U)) L) 
 (Application(Variable n,ConstantFunction (false,T)))
(Abstract (subs L U) (Application(Application(S,ConstantFunction (false,T2)),U2)))))

end end end end end |

(* here's where I stopped working on the matches revision *)

match L (Application(S,T)) (Application(S2,T2)) =

let val M1 = reconcile (match L T (subs L T)) 
(match (reconcile (match L T (subs L T)) L) 
S (Abstract (subs L T) (Application(S2,T2))))

in 

if M1 <> nil then M1

else if HeadReduce(Application(S,T)) <> Application(S,T) then

let val M2 = match L (HeadReduce(Application(S,T))) (Application(S2,T2))

in if M2 <> nil then M2

else let val M3 = reconcile (match L T T2) L

in reconcile (match M3 S S2) M3 end

end

else let val M3 = reconcile (match L T T2) L

in reconcile (match M3 S S2) M3 end

end

|

match L (RuleApp(b,S,T)) U = nil |

match L (Application(S,T)) U = 

let val M1 = reconcile (match L T (subs L T)) 
(match (reconcile (match L T (subs L T)) L)
S (Abstract (subs L T) U)) in

if M1 <> nil then M1

else if HeadReduce(Application(S,T)) <> Application(S,T) then 

match L (HeadReduce(Application(S,T))) U 

else nil

end

|

match L (Quote S) (Quote T) = match L S T |

match L (Quote S) T = match L (quoteexpand S) (quoteexpand T) |

match L S (Quote T) = match L (quoteexpand S) (quoteexpand T) |



match L T U = nil

and Match1 T U = match [(~1,Variable ~1)] T U;

end of matches safe area *)


(* (* find a term U such that S(U) reduces to T *)

and uneval S T = if not (isabstract S) then TermError else

(resetvar(); newvarfromterm S;

let val Variable n = getnewvar() in

let val S2 = Reduce(Application(S,Variable n)) in

let val M = Match1 S2 T in

if M = nil then TermError else if M = nil then Constant "Id" else hd(find n M)

end

end end); *)




(* the environment:  a term and a position in that term *)

(* more components may be needed! *)

val ENV = ref (Application(Variable 1,Variable 2),Application(Variable 1,Variable 2),[Right],[Right]);

(* term output postprocessing function *)

val MARGIN = ref 50;

fun setmargin n = MARGIN:=n;

val INDENT = ref 3;

fun setindent n = if n>=0 then INDENT:= n else ();

fun indentstring 0 = nil |

indentstring n = #" "::(indentstring(n-1));

fun postprocess1 n nil = nil | 

postprocess1 n (s::(t::L)) =

if (n>(!MARGIN)) andalso (s = #" " orelse (s = #")" andalso t = #"("))

then [s]@[#"\n"]@(indentstring (!INDENT))@(postprocess1 (!INDENT) (t::L))

else s::(postprocess1 (n+1) (t::L)) |

postprocess1 n [s] = [s];

fun postprocess s = implode(postprocess1 0 (explode s));

fun look T = (say (postprocess(DisplayV T));T);

fun look2 T = (say (postprocess(Display2 T));T);

fun look1 T = (say (postprocess(Display T));T);

fun currentterm() = (fn (S,T,U,V)=>T)(!ENV);

fun currentpos() = (fn (S,T,U,V) => U)(!ENV);

fun origterm() = (fn (S,T,U,V)=>S)(!ENV);

fun origpos() = (fn (S,T,U,V) => V)(!ENV);

fun Look() = (resetvar();look (currentterm());resetvar();change look (currentpos()) (currentterm());());

fun Look2() =(resetvar();look2 (currentterm());resetvar();change look2 (currentpos()) (currentterm());());
fun Look1() =(resetvar();look1 (currentterm());resetvar();change look1 (currentpos()) (currentterm());());

fun Ex f = (resetvar();ENV := (fn (S,T,L,L2) => (S,change f L T,L,L2))(!ENV);Look());

fun left() = (ENV:= (fn (S,T,U,V) => (S,T,U@[Left],V))(!ENV);Look());

fun right() = (ENV:= (fn (S,T,U,V) => (S,T,U@[Right],V))(!ENV);Look());

fun middle() = (ENV:= (fn (S,T,U,V) => (S,T,U@[Middle],V))(!ENV);Look());

fun function() = (ENV:= (fn (S,T,U,V) => (S,T,U@[Function],V))(!ENV);Look());

fun value() = (ENV:= (fn (S,T,U,V) => (S,T,U@[Value],V))(!ENV);Look());

fun goto TT = (ENV:= (fn (S,T,U,V) => (S,T,U@[Goto (parse3 TT)],V))(!ENV);Look());

fun context TT = (ENV:= (fn (S,T,U,V) => (S,T,U@[Context (parse3 TT)],V))(!ENV);Look());

fun up() = (ENV:= (fn (S,T,U,V) => (S,T,if U = nil then 
(say "At top already!";nil) else rev(tl(rev U)),V))(!ENV);Look());

fun top() = (ENV:= (fn (S,T,U,V) => (S,T,nil,V))(!ENV);Look());


fun view1() = (VIEW:=1;top());

fun view2() = (VIEW:=2;top());

fun view3() = (VIEW:=3;top());


fun start T = if isbadterm T then say "Ill-formed term!" else

(resetvar();ENV:= (T,T,nil,nil);Look());

fun Start T = start(parse3 T);

val s = Start;

fun workback() = (resetvar();ENV:= (fn (S,T,L,L2) => (T,S,L2,L))(!ENV);Look());

fun startover() = (resetvar();ENV:=(fn(S,T,L,L2)=>(S,S,nil,nil))(!ENV);Look());

fun lookback() = (workback();Look();workback());

(* BEGIN bad assignment operators commented out

(* assignment operation is limited to variables of relative type 0;
but note the following commands which can be used to adjust types *)

(* the addition of the metalevel will fix this *)

(* these functions are bad:  we need true assign and assigninto
for compatibility with ambiguous type theory -- this implicitly supposes
that variables at different types are different *)

fun assign1 n T U = Reduce(Application(Abstract (Variable n) U,T));

fun assign n U = (ENV := (fn(S,T,L,L2)=>(assign1 n (parse3 U) S,assign1 n (parse3 U) S,L,L2))(!ENV);Look());

fun itercon n T =

if n<= 0 then T else itercon (n-1) (ConstantFunction T);

fun deepassign1 m n T U = Reduce(Application(Abstract (itercon m (Variable n)) U,itercon m T)); 

fun deepassign m n U = (ENV := (fn(S,T,L,L2)=>(deepassign1 m n (parse3 U) S,deepassign1 m n (parse3 U) S,L,L2))(!ENV);Look());

(* these functions will raise and lower types *)

(* this supports general use of the assign function:  raise
or lower type until the correct type can be abstracted from.
If the type of a variable to be assigned to is too low, this
may not work perfectly because extensionality is weak, but
this is a strange situation anyway. *)

(* deepassign defined above fixes this problem.  Any global assignment
can be carried out using deepassign for low types and addcon and decon
for high types *)

(* one could also assign constant functions to constant functions?
This would work with more generality. *)

fun addcon() = (ENV := (fn(S,T,L,L2)=>(ConstantFunction S,ConstantFunction T,(Value::L),(Value::L2)))(!ENV);Look());

fun decon() = (ENV := (fn(ConstantFunction S,ConstantFunction T,(Value::L),(Value::L2))=>(S,T,L,L2)|(S,T,L,L2)=>(S,T,L,L2))(!ENV);Look());

fun addval() = (resetvar();newvarfromterm(currentterm()); newvarfromterm(origterm());
let val V = getnewvar() in

(ENV:=(Application(origterm(),V),Application(currentterm(),V),(Left::origpos()),Left::currentpos());Look())

end);

fun deval n = (ENV:=(fn (S,T,U,V)=>(Abstract (Variable n) S,
Abstract (Variable n) T,nil,nil))(!ENV);Look());

(* do the same thing to both sides of an equation *)

(* there are similar type issues here *)

fun bothsides W = (ENV:=(fn (S,T,U,V)=>(Reduce(Application(W,S)),
Reduce(Application(W,T)),nil,nil))(!ENV);Look());

END bad assignment operators commented out *)


fun assign1 n T = if isbadterm (parse3 T) then 

say "Ill-formed term!"

else (ENV:=(subs1 (Variable n) (parse3 T) (origterm()),
subs1(Variable n)(parse3 T)(currentterm()),currentpos(),origpos());Look());

fun assigninto n T = if isbadterm (parse3 T) then 

say "Ill-formed term!"

else (ENV:=(subs1 (Variable n) (origterm()) (parse3 T),subs1 (Variable n) (currentterm()) (parse3 T),nil,nil);Look());

(* some elementary opportunities to modify terms *)

fun extract T U = Application(Abstract T U,T);

fun Extract T = Ex (extract (parse3 T));

(* fun extract2 T U = let val V = uneval T U in 

if V = TermError then U else Application(T,V) end;

fun Extract2 T = Ex (extract2 (parse3 T)); *)

fun Red() = Ex(Reduce);

fun makeinert() = Ex(fn (Inert(n,T))=>Inert(n+1,T)|A=>Inert(1,A));

fun toggleinfix() = Ex(fn (Application(Application(A,ConstantFunction(b,B)),C))
=>(Application(Application(A,ConstantFunction(not b,B)),C)) | A => A);

fun ri T = Ex(fn U => RuleApp(true,parse3 T,U));

fun rri T = Ex(fn U => RuleApp(false,parse3 T, U));

fun droprule() = Ex(fn (RuleApp(b,T,U)) => U | U =>
(say "No rule to drop!";U));

(* next we need theorems and matches *)

val THEOREMS = ref [("Triv",(Constant "Triv",Variable 1,Variable 1))];

(* components of theorems *)

fun formatof (u,v,w) = u;

fun rightof (u,v,w) = w;

fun leftof (u,v,w) = v;

fun Formatof th = formatof (safefind (Constant "Triv",Variable 1,Variable 1) th (!THEOREMS));

fun Rightof th =  rightof (safefind (Constant "Triv",Variable 1,Variable 1) th (!THEOREMS));

fun Leftof th =  leftof (safefind (Constant "Triv",Variable 1,Variable 1) th (!THEOREMS));

fun thmdisplay th =

if find th (!THEOREMS) = nil then say "Theorem not found!"

else (say ((Display3 (Formatof th))^":");

say ((Display3 (Leftof th))^"  =");
say (Display3 (Rightof th)));

(* prove a theorem *)

fun arghead (Constant s) = s |

arghead (Application(T,U)) = arghead T |

arghead T = "";

fun foundtheoremvariables (Variable n) = n<0 |

foundtheoremvariables (ConstantFunction (b,T)) = foundtheoremvariables T |

foundtheoremvariables (Application(U,V)) = 
   foundtheoremvariables U orelse foundtheoremvariables V |

foundtheoremvariables (RuleApp(b,T,U)) = foundtheoremvariables T orelse foundtheoremvariables U |

foundtheoremvariables (Argument T) = foundtheoremvariables T |

foundtheoremvariables (Inert(n,T)) = foundtheoremvariables T |

foundtheoremvariables (Quote T) = foundtheoremvariables T |

foundtheoremvariables T = false;


fun prove s = 

if arghead(parse3 s) = "" then say "Impossible theorem format!" else

if find s (!THEOREMS) <> nil then say "Theorem of that name already exists!"

else if foundtheoremvariables (origterm()) orelse foundtheoremvariables (currentterm()) then say "Assign values to new variables before proving!"

else (THEOREMS:=(arghead (parse3 s),(parse3 s,origterm(),currentterm()))::(!THEOREMS);thmdisplay (arghead(parse3 s)));

fun reflect thm thm2 = if find thm2 (!THEOREMS)<> nil then say "Theorem of that name already exists!"

else if find thm (!THEOREMS) = nil then say "Theorem to be reflected does not exist"

else let val (formats,lefts,rights) = hd(find thm (!THEOREMS)) in

(fn (Quote LEFT,Quote RIGHT)=>(THEOREMS:=(thm2,(formats,LEFT,RIGHT))::(!THEOREMS)) | (LEFT,RIGHT) => say "Theorem is not of correct form to be reflected")(lefts,rights) end;

fun axiom name t u = 
if parse3 name <> Constant name then

say "Impossible name for axiom!"

else if find name (!THEOREMS) <> nil 

then say "Theorem of that name already exists!"

else 

(THEOREMS:=(name,(Constant name,parse3 t,parse3 u))::(!THEOREMS);
thmdisplay name);

fun gettheorem th =

if find th (!THEOREMS) = nil

then say "No such theorem to get!"

else (ENV:=(Leftof th,Rightof th,nil,nil);Look());

(* oddly, the current system is actually logically complete, I think.
But matching is certainly required for any practical use to be made of
the system (and to justify the use of navigation) *) 

(* no, it's not logically complete without an implementation of
transitivity; this comes in with rule application *)

fun matchdisplay nil = "" |

matchdisplay ((n,T)::L) = ("x"^(makestring n)^":   "^(Display3 T))^"\n"^(matchdisplay L);

fun matchannounce M = (say (matchdisplay M);M);

fun theoremvariables (Variable n) = Variable(~2-n) |

theoremvariables (ConstantFunction (b,T)) = ConstantFunction(b,theoremvariables T) |

theoremvariables (Application(U,V)) = (Application(
   theoremvariables U,theoremvariables V)) |

theoremvariables (RuleApp(b,T,U)) = RuleApp(b,theoremvariables T,theoremvariables U) |

theoremvariables (Argument T) = Argument(theoremvariables T) |

theoremvariables (Inert(n,T)) = Inert(n,theoremvariables T) |

theoremvariables (Quote T) = Quote(theoremvariables T) |

theoremvariables T = T;



fun apply b formats lefts rights givenformat T =

let val LEFT = if b then (theoremvariables lefts)
 else (theoremvariables rights) and RIGHT = if b then 
(theoremvariables rights) else 
(theoremvariables lefts)

in

let val M = matchannounce(Match1 (theoremvariables formats) givenformat) in

if M = nil then T else

let val LEFT2 = subs M LEFT and RIGHT2 = subs M RIGHT in

let val M2 = matchannounce(match M LEFT2 T) in

if M2 = nil then T else

subs M2 RIGHT2

end

end

end

end

;

(* fun applytest b lefts rights T =

apply b (parse3 lefts) (parse3 rights) (parse3 T);

fun applythm b thm = Ex (apply b (Formatof thm) (Leftof (thm)) (Rightof (thm)));
*)
fun onestep (RuleApp(b,T,U)) =

if isabstract (RuleApp(b,T,U)) then 

change onestep [Value] (RuleApp(b,T,U)) else

if rulefree U then let val Thm = arghead T in

apply b (Formatof Thm) (Leftof Thm) (Rightof Thm) T U

end

else RuleApp(b,T,onestep U)


 |

onestep (ConstantFunction (b,T)) = ConstantFunction(b,onestep T) |

onestep (Application(T,U)) = 

if isabstract (Application(T,U))

then change onestep [Value] (Application(T,U)) else

Application(onestep T,onestep U) |

onestep (Inert(n,T)) = Inert(n,onestep T) |

onestep T = T;

fun Onestep() = Ex(onestep);

fun carryout (RuleApp(b,T,U)) = 

if isabstract (RuleApp(b,T,U))

then change carryout [Value] (RuleApp(b,T,U))

else

let val Thm = arghead T in

let val V = apply b (Formatof Thm) (Leftof Thm) (Rightof Thm) T (carryout U)

in if rulefree V then V else carryout V

end end

 |

carryout (ConstantFunction (b,T)) = ConstantFunction(b,carryout T) |

carryout (Application(T,U)) = 

if isabstract (Application(T,U))

then change carryout [Value] (Application(T,U))

else Application(carryout T,carryout U) |

carryout (Inert(n,T)) = Inert(n,carryout T) |

carryout T = T;

fun Execute() = Ex(carryout);

val ex = Execute;




fun matchtest a b = say(matchdisplay(Match1 (parse3 a)(parse3 b)));

fun matchtest2 a b c d = say (matchdisplay(match (Match1 (parse3 a) (parse3 b)) (parse3 c) (parse3 d)));


(* fun matchtest2 T U = say(matchdisplay(matchtest T U)); *)

fun applytest b T U = let val Thm = arghead (parse3 T) in

Display3(apply b (Formatof Thm) (Leftof Thm) (Rightof Thm) (parse3 T) (parse3 U)) end;

fun substest T U V = Display3(subs1 (parse3 T) (parse3 U) (parse3 V));

(*

axiom "Comm" "x1 + x2" "x2 + x1";

Start "[x1=>x2(x1)]";

right(); ri "x4";

prove "Value(x4)";

Start "[x1=>x1 + x2]";

ri "Value(Comm)";  Execute();

Start "[x1=>x2 + x1]";

substest "x2" "[x1=>x1 + x2]" "[x5=>x4 :>: x2(x5)]";

change (subs1 (parse3 "x2") (parse3 "[x1=>x1 + x2]")) [Value] (parse3 "[x5=>x4 :>: x2(x5)]");



carryout(parse3 "(Value(Comm)) :>: [x1=>x1 + x2]");

apply true  (parse3 "Value(x4)") (parse3 "[x3=>x2(x3)]") (parse3 "[x5=>x4 :>: x2(x5)]") (parse3 "Value(Comm)") (parse3 "[x3=>x3 + x2]");

matchtest2 "Value(x4)" "Value(Comm)";

val MM = Match1 (parse3 "Value(x4)") (parse3 "Value(Comm)");

val LL = Display3(subs MM (parse3 "[x3=>x2(x3)]"));

val RR = Display3 (subs MM (parse3 "[x5=>x4 :>: x2(x5)]"));

val MM2 = Match1 (subs MM (parse3 "[x3=>x2(x3)]")) (parse3 "[x3=>x3 + x2]");

 subs1 (Variable 4) (Argument(Constant "Comm")) (parse3 "[x5=>x4 :>: x2(x5)]");

subs MM2 (subs MM (parse3 "[x5=>x4 :>: x2(x5)]"));

assign1 1 "[x2=>x1+x2]";

implode(preprocess(explode"[|x1|=>[x2=>x1 Test x2]]"));

Start "[x1=>[x3=>x1(x2(x3))]]";

Display(parse3 "[x1=>x2(x1)]");



Start "x1(x2)";

Extract "x2";

prove "A1(x2)";

Start "x1(x2)";

Extract "x2";

left(); makeinert();

prove "A2(x2)";

Start "x5+x5";

ri "A1(x5)"; Execute();

Start "[x1=>[x3=>x1(x2(x3))]]";right();right();left();

val M = Match1 (parse3 "Test(x1)") (parse3 "Test([x1=>x1+x1])");

say(matchdisplay M);

val L2 = subs M (parse3 "x1(x2)");

val R2 = subs M (Rightof "Test");

val M2=match M L2 (parse3 "Term+Term");

say(matchdisplay M2);

say(matchdisplay M2);

subs M2 R2;

subs M2 (parse3 "[x1=>x1+x1]");

Start "[x1=>x2(x1)+x3(x4)]";

right(); ri "Test(x5)";

Start "x1(x2)";

Extract "x2";

prove "Test(x1)";

Start "Term+Term";

ri "Test([x1=>x1+x1])";  (*interesting display foible *)

Execute();

Abstract (parse3 "x3") (parse3 "((Test(x3)) :>: x3) + x2");

parse3 "x1(x2) + x3";

parse3 "(x1(x2)) :>: x3";

ThmAbstract(parse "x3")(ThmAbstract (parse "x3") (parse "Test(x3)"));

val A = (parse3 "((Test(x3)) :>: x3) + x2");

Display3 A;  Display A;

val B = expandconstantfunctions (parse "|x3|") A;

Display3 B; Display B;

val C = Abstract1 (parse "x3") B;

Display3 C; Display C;

val D = Abstract (parse "x3") ;Display3 B; Display B;

val E = parse3 "|Test(x3)| :>: |x3|";

occursin 5 (parse3 "[x6=>|x2|(x5)(x6) + x3(x4)]");

s "[x1=>\"x1(x1)\"](x3)";  (* this reduces to "x3(x3)" as one expects *)
s "[x1=>\"x2(|x1|)\"]";

s "[|x1|=>[x3=>\"x1(x2(x3))\"]](|x5|)(x6)";

s "[x1=>\"x1(x1)\"](\"x3(x4)\")";

s "{Eq(|||T|||)(||U||)}(|V|)(W)";

s "Eq(||Test||)(|Test2|)(Test3)";

s "Eq(|||Test|||)(||Test2||)(Test3)";


*)

(*

s "T(|||U|||)(||V||)(|X|)(Y)";

s"X {||U|| T ||V||} Y";



space for serious examples.

axiom "Comm" "x1+x2" "x2+x1";

axiom "Assoc" "(x1+x2)+x3" "x1+x2+x3";

s "(x1+x2)+x3";

ri "Assoc"; ex();

ri "Assocs"; prove "Assocs";

s "(x1+x2)+ (x3+ (x4+x5)+ x6)+ (x3+x4) + x2";

axiom "Infix" "x1 x2 x3" "x1 {Infix(x2)} x3";

s "x1 x2 x3";

ri "Infix";

prove "Infix2(x2)";

s "x1 x2 x3";

right(); ri "x4";

prove "Right(x4)"; (* one needs the infix as an argument! *)


s "x1+x2";

ri "Assocs";

ri "Right(Allassocs)";

prove "Allassocs";

(* lesson of this example:  the higher order matching makes
the formation of left and right tactics difficult *)

(* do I want an infix variable exception to the higher-order matching rule? *)

Display3(parse3 "{|x1| + |x3|}(X)"); toggleinfix(); toggleinfix();

Implementing "on-failure" and "on-success"

s "x1";

ri "x2";

prove "Ifsame(x1)(x2)";

s "x1";

ri "x2"; ri "Ifsame(x1)(x3)";

prove "x2 Else x3";

axiom "Comm" "x1+x2" "x2+x1";

axiom "Zero" "Zero+x1" "x1";

s "x1+x2"; ri "Zero Else Comm"; ex();

(* there's a problem with variable space collisions --
the variables in the theorem need to be kept disjoint from the
variables in the concrete format and target term *)

(* Idea:  translate all theorem variables into negative values
xn -> x [-n-2] (because 0 is legal and ~1 has a special use)

This could also be used to force strict substitution! *)

axiom "Fail" "x1" "Fail(x1)";

s "x1";

rri "x2";

prove "Reverse(x2)";

axiom "Assoc" "(x1 + x2) + x3" "x1 + x2 + x3";

s "x1 + x2 + x3";  ri "Reverse(Assoc)"; ex();

s "x1";

ri "x2 Else Fail";

ri "Reverse(Fail) Else x3";

prove "x2 Then2 x3";  (* on-success connective *)

val M = Match1 (parse3 "Ifsame(x1)") (parse3 "Ifsame(x1 + x2)");

fun matchtest a b = say(matchdisplay(Match1 (parse3 a)(parse3 b)));

fun matchtest2 a b c d = say (matchdisplay(match (Match1 (parse3 a) (parse3 b)) (parse3 c) (parse3 d)));

covers (Match1 (parse3 "x1") (parse3 "x1")) (parse3 "x1");

*)