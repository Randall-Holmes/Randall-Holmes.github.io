(* implementation of Parser Expression Grammars from Bryan Ford's original
paper (strongly recommended to read this) by Randall Holmes *)

(* FRONT END read this if you are a naive user, i.e, using the functions
in this file to test my TLI Loglan grammar

The contents of this file are the intellectual property of Randall Holmes
(not of the Loglan Institute).  They are available for the public to use
(for example to read my Loglan grammar) but not to incorporate into works of
their own, especially commercial works.  All rights are reserved.

This is a file to be run under the Moscow ML interpreter, which you can get
for most platforms at 

http://www.itu.dk/~sestoft/mosml.html

When you have Moscow ML set up, type the following in the command window:

compile "pegparser.sml"; (* only the first time *)
load "pegparser";
open pegparser;

Every line in ML ends with a semicolon.  Quotes are important.  Newlines
are not allowed in quoted strings.  All parser environment commands are ML function calls being typed in the Moscow ML command window.  ML
is case sensitive.

I will be happy to advise you if you have trouble with any of this.
Yes, it will install on a Mac, but I don't know much about Macs.  Yes,
it will install on Linux.  I know about Windows, myself.

To load the Loglan grammar type

use "loglangrammar.sml";  (* when you have the latter file, too *)

Here are user commands you might want to know about.

versiondate();  (* version of this parser generator that you have *)

showdef "<name>";  (* look at the grammar rule called <name> *)

Parsedef "<definition>";  (* add a line to the current PEG grammar,\
                          using the exact formalism of Ford's paper.
                          Not for the faint of heart *)

removedef "<name>";  (* remove a name from the grammar -- you can't
                     change a definition that is present with Parsedef *)

                     (* use of removedef is deprecated -- you really
                     should use clear() and reload the file every time
                     you make a change. Termination checking and
                     ambiguity checking functions are quite meaningless 
                     once you start making
                     manual changes to the grammar. *)

parsetest "<class>" "<string>";  (* attempt to parse <string> using the rule
                              called <name> *)

verbose();  (* turn on the class labels in parser output *)

unverbose();  (* turn off the class labels in parser output *)

reallyverbose();  (* turn on *all* the class labels in parser output *)
               (* this is actually independent of "verbose"; if "verbose"
               is off it wont turn on labels, but when you do turn them on
               again there will be lots more *)

unreallyverbose();  (* turn off the excessive class labels in parser output *)

hide "<name>";  (* terms of grammar class <name> will be just shown as strings,
                all structure hidden *)

unhide "<name>";

tag "<name>";  (*when parsing, all failures of rule <name> will be shown --
              including expected ones in NOT tests, so don't assume this
              always signals errors *)

untag "<name>";  (* obvious related commands *)

cleartags();

(* new 8/23/2013 *)

numberbrackets();  (* turns on numerical marking of brackets in parses 
   that should make matching clear but of course is cumbersome *)

unnumberbrackets();  (* turns bracket numbering off *)

setdepth <number>;  (* inserts pretty-printing breaks and indentations
    down to the <number>th level of bracketing.  setdepth 0; turns this off. *)

clear(); (* clears all grammar rules except the internally reserved
ones that it uses to parse PEG definitions.  Usually typed just before
use "loglangrammar.sml" when you are trying to change something.  It
is actually much better if you want to modify the grammar rules to
change them in the file then clear the grammar and rerun the entire
file.  The termination checks are not meaningful if you start editing
random commands in random orders.  This also clears caches used by
the ambiguity checker. *)

setnopause();  (* causes it not to pause at error messages *)

setpause();  (* much better for you *)

savegrammar "<filename>";  (* saves the current grammmar to <filename>.peg 
                            as a text file in PEG format *)

loadgrammar "<filename>";  (* read grammar from <filename>.peg --
                           its more graceful than it was at first
                           but still stops with an error, which you
                           can ignore.  Comment lines beginning with
                           # can be put in saved theory files. *)


settop "<class>";  (* specify the top level class of your working grammar *)

utter "<string>";  (* parse string as an item of the top level class *)

(* new 8/23/2013 *)

viewcache();  (* issue this command immediately after a parsetest
    or utter command and you will get to page through all the successful
    partial parses of bits of the string in the parser cache.  Ones
    starting earlier are displayed first.  
    Of course it is mainly useful (?) to try
    to diagnose reasons for a parse failure. 
    The volume of what is displayed may be
    large.  You need to hit enter repeatedly to page through it. *)

postcomment "<class>"  "<comment>";  (* this will add a comment
                   to the saved grammar file just above the entry
                    for the class.  Inserts # after returns so that
                    it will be a comment for PEG grammar and my
                    loadgrammar command.  The command needs to be issued
                    after the class is defined. *)

If the parser generator gives you messages that a rule fails a
termination check, it *has* parsed and installed the rule; it is
warning you that it can't prove that the rule terminates.  Very often
this is due to a typo in the rule, but not always.  In any event, you
should not be installing your own grammar rules unless you understand
PEG grammars; they do NOT necessarily work the way you expect if you
just copy over a BNF grammar.

The parser generator currently checks for termination of the grammar.  It is intended to have ambiguity checking functions as well, but these do not work at the moment.

I am not at this time working on ambiguity checking (it is needed
eventually but it is very tricky), but I do want two things: partial
parse reporting and pretty printing of output.  These are needed for
end users.

*)


(*  working on ambiguity checking.  This is very tricky *)

(*

7/9/2013

The functions that are relevant are those mentioned in canmatch;
preemptioncheck now calls canmatch.  I need to clean out a lot of the
other stuff.

*)

(* 7/5/2013

The bugs do not in any way compromise the parser engine itself:  the parser functions work really well, and the current grammar parses TLI Loglan with caveats clearly indicated.

discovered another awful bug, in caching, which was simply lethal.  It is quite amazing how well a function with such serious errors appeared to work:  in general when it reported problems with the grammar they actually *were* problems.  But the bugs were quite fatal.  I'm drafting new ambiguity checking functions, but they are so far so slow as to be useless.

discovered an awful bug which sets me back considerably.  The ambiguity
checker does not check the Loglan grammar, though in general terms it
does the right sorts of things.  The main bug caused it to take leaps
of faith at points where this is all right in a well-structured grammar,
so it *looked* as if it worked, even if one traced it.  Ghastly.

That bug is fixed, but it masked other ones that I do not understand
yet.  I'm working on a sensible implementation of negations of
character and string classes.

CharClass nil is now interpreted as !., that is as accepting the empty string.

*)

(* 7/4/2013

theory note:  the new implementation is much cleaner and clearly
sufficiently aggressive about alternatives which appear explicitly
in the rule being tested.  I noted this time that x* terms actually
need no special treatment; since when they are not there the following
part cannot begin with x.  All expansion of alternatives is from the front
of the rule due to preprocessing.  This means one sometimes tests quite
large terms (flashing on the screen in the Loglan grammar checking).

There remains a problem with concatenation and references.  A line
<reference> morestuff might possibly fail if (expansion of reference)
morestuff doesn't check which *is* possible.  I have a fix for this
installed which, amazingly, appears to work on the Loglan grammar and
doesnt on a grammar for the input language of the Marcel theorem
prover which I have also constructed (that is, it runs out of resources
while trying to check it.  I would like to understand why...*)

(* Theory of the ambiguity checking

This comment contains musings which may be incorrect!

I want a condition on PEG's which will enforce the following:

A string is of class A iff it can be read from the front of some
string by the rule A <- Adef.

We want the grammar to be greedy in the sense that if a string is of the
form (A string) | X and rule A accepts it then it will read something at
least as long as the given A-string.

Further, we want the strings accepted by (A1 / A2 / ... / An) (if a
canonical order is imposed on the Ais) to be exactly the union of the
classes of strings accepted by the Ai's.  We view A? B as abbreviating
(A B / B) for this analysis.

The condition which appears to enforce both of these is that in any
priority list, including those implicit in use of the optional
construction A?, it cannot be the case that an earlier Ai "preempts" a
later Aj in the sense that it accepts a string accepted by Aj but
stops at an earlier point.  This means that
anything accepted by Aj will be accepted by the disjunction in the
same way -- or a longer string will be accepted by a rule earlier in the list,
in accordance with greedy behavior.

The greed condition then holds by induction, with the condition on
disjunctions being applied to show that it holds for priority lists:
if the one actually accepted by a priority list of rules was shorter
than the one accepted by any of the alternatives it would be an
example of preemption.  Optional components A? are translated to priority
constructions for the sake of this argument.

The net result is that a context free grammar in which the classes are
defined by a PEG meeting the nonpreemption condition on priority
and option constructions is unambiguous in
a precise sense: whenever a string can be parsed A | B in more than
one way, we understand that the bar is to be moved to the right as far
as possible; the disjunction condition means that we can safely ignore
the order of alternatives in the CFG associated with a PEG (though
certainly not in the PEG itself) because there is a canonical order to
be applied (or many permissible canonical orders) all of which will
have the same result.

Thus we are working on developing an automated tool which verifies
nonpreemption in priority lists ---which now exists.

Comments about optional and repetition constructions:

A B? C:  this is equivalent to B C cannot preempt C.  If B cannot preempt C
then certainly B C cannot preempt C.  It might be that B C could not preempt
C but B could.

A B* C:  this is precisely that B* C cannot preempt C.  If B cannot preempt
C then of course it is impossible.  It might be that B could preempt
C but B* C could not.  Showing that B C cant preempt C is NOT correct.
Showing that B^n cannot preempt for any fixed n would work.  One can
force the checker to check a B^n condition by writing the B* term differently.

The ambiguity checker now works.  It only does appropriate checks for
& conditions if the argument of & is not a reference; otherwise things
slow down too much due to the internal reference structure of the
terms it processes.  But it is easy thus to force ambiguity checking
to take an and condition into account: expand the argument of the & if
it is a reference.

The ambiguity checker can sometimes detect ambiguity, but it can also fail
by failing to terminate (looping or memory overflow).  My experience in testing the Loglan grammar suggest so far that when it fails it really is telling you something about the grammar (that is, that it works correctly).  It found
badly ordered word lists and arguments, ambiguities to do with initial multiple negations (which are fixed), and non-ambiguities which were due to the fact
that a head marker distinguishing two classes could be deferred indefinitely because of left recursion in the two class definitions of exactly parallel structure, which I resolved by adding
additional & conditions which could detect this head information.

Brief discussion of the theory.  We are interested in defining "greedy"
word classes:  a word class is greedy iff an extension of a string with an initial segment accepted by the class which preserves all negative conditions will only extend the string.

We say that a class A preempts a class B iff it is possible for A to
accept a proper initial segment of something accepted by B.  We write
A > B if A does not preempt B.  If C1,...,Cn are greedy conditions and
C1>C2>,...,>Cn we claim that the string accepted by C1/.../Cn will be
the longest of those accepted by any of C1,...,Cn, as if for Cj > Ci
there was a longer one accepted by Cj, the one actually accepted by Ci
would be the same (no problem) or shorter (preemption).  To argue that
C1/.../Cn is greedy, we need to think about persistence of negative
conditions: if the one accepted at a certain length is accepted both
by Ci and Cj, extension of it respecting negative conditions in one of
them can only extend the string accepted.  Nonpreemption tells us that
the earlier one must keep up with the later one or a preemption
condition would occur, so nonpreemption implies that negative
conditions required by Ci and Cj cannot conflict.  Which option is
chosen remains stable, so the disjunction is also greedy!  Extend
using conditions respecting the negative conditions in the later one:
if the later one accepts longer and longer strings, Ci is forced by
nonpreemption to accept these strings as well so of course the
negative conditions required by Ci are preserved.  The alternative
actually used remains stable, so the notion of what negative
conditions are required by the disjunction is stable.  Addition of
either positive or negative logical conditions to a greedy class does
not affect its greediness (that negative conditions work is enforced
"by force" in the definition).  Concatenation is problematic, but
concatenation with alternatives is defined in such a way that we
expand classes and only accept classes that obey nonpreemption
conditions in any case.

*)

(* 6/24/2013 adding macros to the basic Ford language -- but without expanding the syntax.  Allow definition of double-underscore-initial classes, but with
no underscore-initial operators in their definitions.  Give underscore initial classes a bye in terminationcheck.  Also refined pruning to reduce nested classes applied to the same text to just the innermost and outermost.

The merit of this approach is that the macros are actually just PEG classes;
rules about defining them mean that I dont need to termination check them, they
can safely be thought of as expanded inline (in fact, they are expanded inline in the termination checking process).  This is useful for maintenance of the grammar.

*)

(* ML version stuff *)

fun desome x = x;

(* BEGIN for PolyML decomment this; 
for Moscow ML 2.10 in addition comment out first line 

(*open PolyML*)

fun desome (SOME x) = x |

desome NONE = "";

 END *)

fun Inputline x = desome(TextIO.inputLine x);

val maxChar = #"\255";
val minChar = #"\^@";



(* autologging stuff *)

val LOGFILE = ref (TextIO.openOut("default"));

val LOGFILENAME = ref("default");

val LOGGING = ref false;



fun writelogline s = if (!LOGGING)
     then TextIO.output((!LOGFILE),(s^"\n\n"))
     else ();


fun Flush() = TextIO.flushOut(TextIO.stdOut);
fun say s = (TextIO.output(TextIO.stdOut,"\n"^s^"\n");Flush());
fun stoplogging() = if (!LOGGING) then (writelogline "###\n"; TextIO.flushOut(!LOGFILE);
TextIO.closeOut(!LOGFILE);LOGGING:=false;say ("Closed log file "^(!LOGFILENAME))) else say "You are not logging!";
fun startlogging filename = if (!LOGGING)
    then say ("You are already logging using file "^(!LOGFILENAME))
    else (
    LOGGING:=true;LOGFILE:=
    (TextIO.openOut((filename^".llg"))); 
LOGFILENAME:=filename^".llg";
say ("Opened log file "^filename^".llg"));




fun say1 s = (TextIO.output(TextIO.stdOut,"\n"^s);Flush());
fun pause() = (say "<hit enter>";TextIO.input(TextIO.stdIn);());

val TESTING = ref false;

fun testing() = TESTING:=true;

fun notesting() = TESTING:=false;

fun testsay s = if (!TESTING) then testsay s else ();

val PAUSE = ref true;

fun setnopause() = PAUSE:=false;

fun setpause() = PAUSE:=true;

fun errormessage s = (say s;if (!PAUSE) then (Flush();pause()) else());

fun versiondate() = say "9/16/2017: adapted for multiple ML versions\n 4/26/2017: Export grammar to an HTML file using savegrammar3\nchanges to logging functions to support batch processing.\n10:15 PM 1/23/2016: redesigned output display\nremoved extraneous commas from display.\nadded ability to log input and output to a file.\n";


fun p1(x,y) = x;

fun p2(x,y) = y;


fun find s nil = nil |

find s ((t,u)::L) = if s=t then [u] else find s L;


(* type of grammar components *)

datatype ParsingExpression =

Reference of string |

Literal of char list |

CharClass of (char*char) list |

AnyChar |

Unknown |

Optional of ParsingExpression |

ZeroOrMore of ParsingExpression |

OneOrMore of ParsingExpression |

AndPredicate of ParsingExpression |

NotPredicate of ParsingExpression |

Sequence of ParsingExpression list |

Priority of ParsingExpression list;

(* a rough and ready display function for parser rules *)

fun unescape #"\n" = "\\n" |
unescape #"\r" = "\\r" |
unescape #"\t" = "\\t" |
unescape #"\"" = "\\\"" |
unescape #"'" = "\\'" |
unescape #"[" = "\\[" |
unescape #"]" = "\\]" |
unescape #"\\" = "\\\\" |
unescape x = implode [x];

fun underscorefree (Reference s) = s<>"" andalso hd(explode s) <> #"_" |

underscorefree (Optional X) = underscorefree X |

underscorefree (ZeroOrMore X) = underscorefree X |

underscorefree (OneOrMore X) = underscorefree X |

underscorefree (AndPredicate X) = underscorefree X |

underscorefree (NotPredicate X) = underscorefree X |

underscorefree (Sequence L) =

map underscorefree L = map (fn x => true) L |

underscorefree (Priority L) =

map underscorefree L = map (fn x => true) L |

underscorefree X = true;

(* put character classes in normal form and negate them *)

fun charmax (x:char) y = if x<y then y else x;

fun charadd (x,y) (CharClass L) = CharClass((x,y)::L);

fun chardrop (CharClass nil) = CharClass nil |

   chardrop (CharClass(x::L)) = CharClass L;

fun charsucc x = chr((ord x)+1);

fun charpred x = chr((ord x)-1);

fun charnormalize (CharClass nil) = CharClass nil |

charnormalize (CharClass([(x,y)])) = if y<x
then CharClass nil else CharClass([(x,y)]) |

charnormalize (CharClass((x,y)::(z,w)::L)) =

     if y<x then charnormalize (CharClass((z,w)::L)) 

     else if w<z then charnormalize (CharClass((x,y)::L))

     else if x<=z andalso z<=y  then charnormalize (CharClass((x,charmax y w)::L))

     else if z<=x andalso x<=w then charnormalize (CharClass((z,charmax y w)::L))

     else if x<=z then 

let val TEST = charnormalize(charadd (z,w)(charnormalize (CharClass L))) in

if TEST = charnormalize(CharClass((z,w)::L)) then charadd (x,y) TEST

else charnormalize (charadd (x,y) TEST) end



     else
let val TEST = charnormalize(charadd (x,y)(charnormalize (CharClass L))) in

if TEST = charnormalize(CharClass((x,y)::L)) then charadd (z,w) TEST


 else charnormalize (charadd (z,w) TEST) end;

(* fun cntest s = defdisplay(charnormalize(classfromstring s)); *)

val top = maxChar;

val bottom = minChar;

fun prenegate (CharClass nil) = CharClass([(bottom,top)]) |

prenegate (CharClass([(x,y)])) = 

if x=bottom andalso y = top then CharClass nil else

if x=bottom then CharClass([(charsucc y,top)]) else

if y=top then CharClass([(bottom,charpred x)]) else

CharClass([(bottom,charpred x),(charsucc y,top)]) |

prenegate (CharClass((x,y)::(z,w)::L)) =

     if x=bottom then (charadd (charsucc y,charpred z) (chardrop (prenegate
            (CharClass((z,w)::L)))))

     else charadd (top,charpred x) (charadd (charsucc y,charpred z) (chardrop (prenegate
            (CharClass((z,w)::L)))));

fun charnegate (CharClass M) = prenegate(charnormalize(CharClass M));

(* predicates literally equivalent to NotPredicate(a literal)
if AndPredicate is added *)

fun literalnegate (CharClass M) = (charnegate(CharClass M)) |

    literalnegate AnyChar = CharClass nil |

    literalnegate (Literal nil) = NotPredicate(Sequence nil) |

    literalnegate (Literal[s]) = charnegate(CharClass[(s,s)]) |

    literalnegate (Literal(x::s)) =

       (Priority[charnegate (CharClass[(x,x)]),Sequence[CharClass[(x,x)],literalnegate(Literal s)]]) |

    literalnegate x = x;

(* fun cnnegtest s = defdisplay(charnegate(classfromstring s)); *)


fun defdisplay (Reference s) = s |

defdisplay (Literal L) = "'"^(literaltaildisplay L) |

defdisplay (CharClass L) = 

if L<>nil andalso p1(hd L) = bottom then

"~"^(defdisplay(charnegate (CharClass L))) else

"["^(charclasstaildisplay L) |

defdisplay AnyChar = "." |

defdisplay Unknown = "---" |

defdisplay (Optional X) = "("^(defdisplay X)^")?" |

defdisplay (ZeroOrMore X) = "("^(defdisplay X)^")*" |

defdisplay (OneOrMore X) = "("^(defdisplay X)^")+" |

defdisplay (AndPredicate X) = "&("^(defdisplay X)^")" |

defdisplay (NotPredicate X) = "!("^(defdisplay X)^")" |

defdisplay (Sequence L) = "("^(sequencetaildisplay L) |

defdisplay (Priority L) = "("^(prioritytaildisplay L) 

and charclasstaildisplay nil = "]" |

charclasstaildisplay ((x,y)::L) = if x=y then(unescape x)^(charclasstaildisplay L) else (unescape x)^"-"^(unescape y)^(charclasstaildisplay L)
and literaltaildisplay nil = "'" |

literaltaildisplay (x::L) = (unescape x)^(literaltaildisplay L)

and sequencetaildisplay nil = ")" |

sequencetaildisplay [x] = (defdisplay x)^")" |

sequencetaildisplay (x::L) = (defdisplay x)^" "^(sequencetaildisplay L) 

and

prioritytaildisplay nil = ")" |

prioritytaildisplay [x] = (defdisplay x)^")" |

prioritytaildisplay (x::L) = (defdisplay x)^" / "^(prioritytaildisplay L); 

datatype ParsingOutput =

String of char list |

Check |

UnlabelledList of (ParsingOutput list) |

ReferenceTagged of string*(ParsingOutput) |

Error;


val TAGGED = ref ["bogus"];

val _ = TAGGED:=nil;

fun tag s = TAGGED:=(s::(!TAGGED));

fun drop s nil = nil |

drop s ((t,u)::L) = if s=t then drop s L
else ((t,u)::(drop s L));


fun drop1 s nil = nil |

drop1 s (t::L) = if s = t then drop1 s L
else (t::(drop1 s L));

fun untag s = TAGGED:=drop1 s (!TAGGED);

fun cleartags() = TAGGED:=nil;

fun find1 s nil = false |

find1 s (t::L) = s=t orelse find1 s L;

fun tagged s = find1 s (!TAGGED);

val VERBOSE = ref true;

fun verbose() = VERBOSE:=true;

fun unverbose()=VERBOSE:=false;


val HIDDEN = ref["bogus"];

val _ = HIDDEN:=nil;

fun hide s = HIDDEN := s::(!HIDDEN);

fun hidden s = find1 s (!HIDDEN);

fun unhide s = HIDDEN:=drop1 s (!HIDDEN);

val DONTSKIP = ref["bogus"];

val _ = DONTSKIP:=nil;

fun dontskip s = DONTSKIP := s::(!DONTSKIP);

fun important s = find1 s (!DONTSKIP);

fun undontskip s = DONTSKIP:=drop1 s (!DONTSKIP);

val REALLYVERBOSE = ref false;

fun reallyverbose() = REALLYVERBOSE:=true;

fun unreallyverbose()=REALLYVERBOSE:=false;

fun prunemerge A (UnlabelledList B) = UnlabelledList(A::B) |

prunemerge A B = UnlabelledList[A,B];

fun prune (UnlabelledList [x]) = prune x |

prune (UnlabelledList(x::L)) = 

let val A = prune x and B= prune(UnlabelledList L)

in if A = UnlabelledList nil orelse A = String nil orelse A = String[#" "]  then B else if B = UnlabelledList nil orelse B = String [#" "] orelse B = String nil then A

else prunemerge A B end |

prune (ReferenceTagged(s,UnlabelledList nil)) = 

if (!REALLYVERBOSE) = false then UnlabelledList nil 
else (ReferenceTagged(s,UnlabelledList nil)) |

prune (ReferenceTagged(s,ReferenceTagged(t,ReferenceTagged(u,X)))) =

if (!REALLYVERBOSE)

then (ReferenceTagged(s,ReferenceTagged(t,ReferenceTagged(u,prune X))))

else if hidden s orelse hidden t orelse hidden u

then (ReferenceTagged(s,ReferenceTagged(t,ReferenceTagged(u,prune X))))

else if important t andalso not(important u)

then prune (ReferenceTagged(s,ReferenceTagged(t,X)))

else prune (ReferenceTagged(s,ReferenceTagged(u,X))) |


prune (ReferenceTagged(s,X)) = 
if (!REALLYVERBOSE) = false then 
let val A = prune X in if A=X then
(ReferenceTagged(s,A)) else prune(ReferenceTagged(s,A)) end

else (ReferenceTagged(s,prune X))|

prune x = x;

fun flatten (String s) = s |

flatten (UnlabelledList nil) = nil |

flatten (UnlabelledList (x::L)) = (flatten x)@(flatten (UnlabelledList L)) |

flatten (ReferenceTagged(s,X)) = flatten X |

flatten Error = (errormessage "Error should not be flattened";nil) |

flatten Check = (errormessage  "Check should not be flattened";nil);

val NUMBERBRACKETS = ref false;

fun numberbrackets() = NUMBERBRACKETS:=true;

fun unnumberbrackets() = NUMBERBRACKETS:=false;

val DEPTH = ref 0;

fun setdepth n = DEPTH:=n;

fun indent 0 = "\n" |

indent n = (indent (n-1))^" ";

fun makestringA n = 
(if n<=(!DEPTH) then indent n else "")^
(if (!NUMBERBRACKETS) then "<"^(makestring n)^">" else "");

fun outputdisplay0 n (String s) = ("`"^(implode s)^"'") |

outputdisplay0 n (UnlabelledList L) = "["^(makestringA (n+1))^(tailoutputdisplay (n+1) L) |

outputdisplay0 n (ReferenceTagged (s,(ReferenceTagged(t,X)))) = 

if hidden s then implode(flatten(X))

else if hidden t then 

if (!VERBOSE) orelse tagged s then s^":"^(if (!REALLYVERBOSE) then makestringA n else (makestringA (n+1)))^(implode(flatten X))
else implode(flatten X)

else 

outputdisplay0 (n+2) (ReferenceTagged(s^": "^t,X))|

outputdisplay0 n (ReferenceTagged (s,X)) = 

if hidden s then implode(flatten(X)) else

if (!VERBOSE) orelse tagged s then s^":"^(if (!REALLYVERBOSE) then makestringA n else (makestringA (n+1)))^(outputdisplay0 (n+1) X)
else outputdisplay0 n X |

outputdisplay0 n Error = "!!!error!!!" |

outputdisplay0 n Check = "!!!check!!!" 

and tailoutputdisplay n nil = (makestringA n)^"]" |

tailoutputdisplay n [x] = (outputdisplay0 n x)^(makestringA n)^"]" |

tailoutputdisplay n (x::L) = (outputdisplay0 n x)^(makestringA n)^(tailoutputdisplay n L);

fun outputdisplay X = outputdisplay0 0 X;



val DEFS = ref [("bogus",AnyChar)];

val COMMENTS = ref [("bogus","bogus")];  (* comments can be put into
                              automatically generated grammar *)

fun postcomment s t = if find s (!DEFS) = nil then say "No such class"
                     else if find s (!COMMENTS) <> nil then say "Class already commented"
                     else COMMENTS:=(s,t)::(!COMMENTS);

val _ = DEFS :=nil;


val CACHE = ref [(("bogus",[#"X"]),(Error,[#"X"]))];

val THESTRING = ref [#"X"];

fun clearcache() = CACHE:=nil;

fun viewcache0 nil = () |

viewcache0 (((a,b),(c,d))::L) = (if c <> Error andalso b = (!THESTRING) then (say (a^":  "^(implode b)^"; "^(outputdisplay (prune c))^"; "^(implode d)^"\n");pause()) else (); viewcache0 L);

fun viewcache() = (viewcache0 (rev(!CACHE)); if (!THESTRING) = nil then ()
else (THESTRING:=tl(!THESTRING);viewcache()));

(* the parsing function inputs a list of characters and 
outputs a pair of a parsed expression and the rest of the input list *)

val GREEDY = ref false;

fun greedy() = GREEDY:=true;

fun ungreedy() = GREEDY:= false;

fun parse (Literal nil) L = (String(nil),L) |

parse (Literal(x::L)) (y::M) = if x=y then

   let val A = parse (Literal L) M in

   if p1(A) = Error then (Error,(y::M))

   else (fn (String B,N) => (String(x::B),N)|w=>(errormessage "Error encountered in Literal parsing";(Error,y::M))) (parse (Literal L) M) end

   else (Error,(y::M)) |

parse (Literal(x::L)) nil = (Error,nil) |

parse (CharClass nil) L = if L = nil then (String nil,L) else (Error,L) |

parse (CharClass ((x,y)::L)) nil = if x<=y then (Error,nil)
            else parse(CharClass L) nil |

parse (CharClass((x,y)::L)) (z::M) =

    if x<=z andalso z<=y then (String [z],M)

    else parse (CharClass L) (z::M) |

parse AnyChar nil = (Error,nil) |

parse AnyChar (x::L) = (String [x],L) |

parse (AndPredicate X) L = 

   let val A = parse X L in

   if p1(A) = Error then (Error,L)

   else (Check,L)

   end |

parse (NotPredicate X) L =

   let val A = parse X L in

   if p1(A) = Error then (Check,L)

   else (Error,L)

   end |

parse (Sequence nil) L = ((UnlabelledList nil),L) |

(*

parse (Sequence((Optional X)::L)) M =

parse (Priority[Sequence (X::L),Sequence L]) M | *)

parse (Sequence (X::L)) M =  

    let val A = parse X M in

    if p1(A) = Error then (Error,M)

    else let val B = parse (Sequence L) (p2(A)) in

    if p1(B) = Error then (Error,M) else

    if p1(A) = Check then B

    else (fn (UnlabelledList N,R) =>

    (UnlabelledList (p1(A)::N),R)|w=>(errormessage "Error encountered in Sequence parsing";(Error,M))) B

    end end |

parse (Priority nil) L = (Error,L) |

parse (Priority(X::L))(M) =

   if (!GREEDY) then

   let val A = parse X M
   and B = parse (Priority L) M in

   if p1(A) = Error then B

   else if p1(B) = Error orelse length(p2(B)) >= length(p2(A))

   then A else B end

   else let val A = parse X M in

   if p1(A) = Error then parse (Priority L) M

   else A end |

parse (Optional X) L =

   let val A = parse X L in

   if p1(A) = Error then (Check,L)

   else A end |

parse (ZeroOrMore X) L =

   let val A = parse X L in

   if p1(A) = Error then (UnlabelledList nil,L)

   else if p1(A) = Check then A

   else (fn (UnlabelledList M,R) => (UnlabelledList (p1(A)::M),R)|
x=>(errormessage "Error encountered in ZeroOrMore parsing";(Error,L))) 
   (parse (ZeroOrMore X) (p2(A))) end |

parse (OneOrMore X) L =

   let val A = parse X L in

   if p1(A) = Error then (Error,L)

   else if p1(A) = Check then A 

   else (fn (UnlabelledList M,R) => (UnlabelledList (p1(A)::M),R)|
x=> (errormessage  "Error encountered in OneOrMore parsing";(Error,L)))
   (parse (ZeroOrMore X) (p2(A))) end |

parse Unknown L = (Error,L) |

parse (Reference s) L =

   if find s (!DEFS) = nil then (errormessage ("Attempt to evaluate meaningless Reference "^ s);(Error,L))

   else let val Z = find (s,L) (!CACHE) in

   if Z <> nil then hd Z else

   let val [X] = find s (!DEFS) in

   let val A=parse X L in

   if p1(A) = Error then (if tagged s then errormessage ("Failed in "^s^" at "^(implode L))else ();CACHE:=((s,L),(Error,L))::(!CACHE);(Error,L))

   else (CACHE:=((s,L),(ReferenceTagged(s,p1(A)),p2(A)))::(!CACHE);(ReferenceTagged(s,p1(A)),p2(A)))

   end

   end end;

(* the meaning here is that the rule is verified to always either fail
or make forward progress, subject to the assumption that references not yet defined meet the criterion as well *)

(* this is only really useful when run on a file of definitions in order
as they are first made.  It should not be called manually, but from
inside define only.
It checks recursions using whether things have been declared yet or not.
It becomes meaningless once you start using removedef and redefining things. *)

val TERMINATIONCHECKED = ref [("bogus",false)];

val _ = TERMINATIONCHECKED := nil;

fun reservedname s = s <> "" andalso hd(explode s) = #"_";

fun macroname s = reservedname s andalso tl(explode s) <> nil
andalso hd(tl(explode s)) = #"_";

fun terminationcheck b (Reference s) = 

if find s (!DEFS) = nil

then b else if find s (!TERMINATIONCHECKED) <> nil then hd(find s (!TERMINATIONCHECKED))  else 
let val T =terminationcheck false (hd (find s (!DEFS))) in

(if T then TERMINATIONCHECKED:= (s,true)::(!TERMINATIONCHECKED) 
else (errormessage ("Warning:  Definition "^s^" fails termination check (definition does succeed)");
TERMINATIONCHECKED:= (s,false)::(!TERMINATIONCHECKED));T) end |

terminationcheck b (Literal s) = s <> nil |

terminationcheck b (CharClass L) = if map (fn (x,y) => x <= y) L =
       map(fn x=>false) L then (errormessage "Badly formed character class"; true) else true |  (* check for empty character classes; doesnt imperil termination as this causes failure *)

terminationcheck b (AnyChar) = true |

terminationcheck b (NotPredicate Anychar) = true |

terminationcheck b Unknown = false |

terminationcheck b (Optional X) = false |

terminationcheck b (ZeroOrMore X) = false |

terminationcheck b (OneOrMore X) = terminationcheck b X |

terminationcheck b (AndPredicate X) = false |

terminationcheck b (NotPredicate X) = false |

terminationcheck b (Priority L) = map (terminationcheck b) L =
   map (fn x => true) L |

terminationcheck b (Sequence ((Reference s)::L)) =

if macroname s then if find s (!DEFS) = nil then false

else terminationcheck b (Sequence((hd(find s (!DEFS))::L)))

else terminationcheck b (Reference s) andalso
terminationcheck true (Sequence L) 

 |

terminationcheck b (Sequence((Optional X)::L)) = terminationcheck b X andalso terminationcheck b (Sequence L) |

terminationcheck b (Sequence((ZeroOrMore X)::L)) = terminationcheck b X andalso terminationcheck b (Sequence L) |

terminationcheck b (Sequence((AndPredicate X)::L)) = terminationcheck b X andalso terminationcheck b (Sequence L) |

terminationcheck b (Sequence((NotPredicate X)::L)) = terminationcheck b X andalso terminationcheck b (Sequence L) |

terminationcheck b (Sequence((Priority L)::M)) =
map (fn Y => terminationcheck b (Sequence(Y::M))) L =
map (fn Y=> true) L |

terminationcheck b (Sequence((Sequence L)::M)) =

terminationcheck b (Sequence(L@M)) |

terminationcheck b (Sequence(x::L)) =  terminationcheck b x andalso
     terminationcheck true (Sequence L) |

terminationcheck b (Sequence nil) = b;

fun forceterminationcheck s = TERMINATIONCHECKED:=((s,true)::(drop s (!TERMINATIONCHECKED)));

fun checktermination s = terminationcheck false (Reference s);

(*  BEGIN ambiguity checking development *)

(* format of output is a list of lists -- the top level list is a list
of alternatives, each alternative is a list of equivalent forms in a fixed
case.  The idea is to unify the forms?  Items in the second level list
are actual forms of the terms? *)

fun unionlists nil = nil |

unionlists (L::M) = L@(unionlists M);

fun andlists nil L = nil |

andlists (L::M) N = (map (fn Y => L@Y) N) @ (andlists M N);

(* the aim of initials is to convert a definition to a disjunction
of conjunctions of sequences starting with characters or strings,
with references, or with negations, with an aim to following this
by matching (the ultimate aim of this being failure.  Sequence nil,
though it matches anything, is treated as failure in this context *)

fun isreference (Reference s) = true |

isreference x = false;

fun isntpriority (Priority M) = false |

isntpriority X = true;

fun nottransform (NotPredicate(Sequence nil)) = Priority nil |

nottransform (NotPredicate(Priority nil)) = Sequence nil |

nottransform (NotPredicate(Sequence([X]))) = nottransform (NotPredicate X) |

nottransform (NotPredicate(Sequence((Sequence L)::M))) =

nottransform (NotPredicate(Sequence(L@M))) |

nottransform (NotPredicate(Priority[X,Priority M])) =
 nottransform (NotPredicate(Priority(X::M))) |

nottransform (NotPredicate(Priority((Priority L)::M))) =

nottransform (NotPredicate(Priority(L@M))) |

nottransform (NotPredicate(Sequence(X::L))) =

Priority([nottransform(NotPredicate(X)),AndPredicate(Sequence([X,nottransform(NotPredicate (Sequence L))]))]) |

nottransform (NotPredicate(Priority[X])) = nottransform (NotPredicate X) |

nottransform (NotPredicate(Priority (L::M))) = Sequence([nottransform(NotPredicate L),nottransform(NotPredicate (Priority M))]) |

nottransform (NotPredicate(Optional X)) = Priority nil |

nottransform (NotPredicate(ZeroOrMore X)) = Priority nil |

nottransform (NotPredicate(OneOrMore X)) =  nottransform(NotPredicate X) |

nottransform (NotPredicate(AndPredicate X)) = nottransform(NotPredicate X) |

nottransform (NotPredicate(NotPredicate X)) = AndPredicate X |

nottransform X = X;

fun add1 s nil = [s] |

add1 s L = s::(drop1 s L);

fun union1 nil L = L |

union1 L nil = L |

union1 (x::L) (y::M) = add1 x (add1 y(union1 L M));

fun union2 nil = nil |

union2 (L::M) = union1 L (union2 M);

(* identify the actual classes of strings *)

fun isliteral AnyChar = true |

isliteral (Literal s) = true |

isliteral (CharClass s) = true |

isliteral x = false;

fun isliteral2 x = x<>Literal nil andalso isliteral x;

(* strip off initial segments of a pair of strings of the same length;
in context, the fact that they match is already taken care of. *)

fun stringminus ((Literal nil), (Literal s)) = ((Literal nil), (Literal s)) |

stringminus ((Literal s), (Literal nil)) = ((Literal s), (Literal nil)) |

stringminus ((Literal (x::s)), (Literal (y::t))) =
stringminus((Literal (s)), (Literal (t))) |

stringminus ((CharClass nil), x) =((CharClass nil), x) |

stringminus (x,(CharClass nil)) =(x,(CharClass nil)) |

stringminus ((CharClass M), (Literal(x::s))) = (Literal nil,Literal s) |

stringminus ((Literal(x::s)), (CharClass M)) = (Literal s, Literal nil) |

stringminus ((CharClass M), (CharClass N)) = (Literal nil,Literal nil) |

stringminus ((AnyChar), (AnyChar)) = (Literal nil,Literal nil) |

stringminus ((AnyChar), (CharClass M)) = (Literal nil,Literal nil) |

stringminus ((CharClass M), (AnyChar)) = (Literal nil,Literal nil) |

stringminus ((AnyChar), Literal(x::s)) = (Literal nil,Literal s) |

stringminus (Literal(x::s), (AnyChar)) = (Literal s,Literal nil) |

stringminus (x,y) = (x,y);

(* string classes are incompatible iff neither contains an
initial segment of an element of the other *)

(* CharClass nil is now understood as capturing just the empty
string (not always failing as before) so all literal classes are
compatible with Literal nil *)

(* the empty class of strings is not the non-literal
NotPredicate(Sequence nil) *)

(* new program for preemption checking -- require that we
be able to show that any extension of a string preserves non
preemption of alternatives. This will probably force us to enforce
disjointness of alternatives. *)

fun incompatible (Literal (x::s)) (Literal (y::t)) =

x<> y orelse incompatible (Literal s) (Literal t) |

incompatible (CharClass L) (CharClass M)

= (charnormalize (CharClass L) <> CharClass nil

orelse charnormalize (CharClass M) <> CharClass nil)

andalso (L= nil orelse M = nil orelse let val (x,y) = hd L and (z,w) = hd M in

(y<x orelse w<z orelse y<z orelse w<x) andalso (incompatible (CharClass (tl L))
(CharClass M)) andalso (incompatible (CharClass L) (CharClass (tl M))) end) |

incompatible (Literal nil) (CharClass nil) = false |

incompatible (CharClass nil) (Literal nil) = false |

incompatible (Literal(x::s)) (CharClass nil) = true |

incompatible (CharClass nil) (Literal(x::s)) = true |

incompatible (Literal(x::s)) (CharClass((u,v)::L)) =

((x>v orelse x<u) andalso incompatible (Literal(x::s)) (CharClass L)) |

incompatible (CharClass((u,v)::L)) (Literal(x::s)) =

(x>v orelse x<u) andalso incompatible (Literal(x::s)) (CharClass L) |

incompatible AnyChar (CharClass ((u,v)::L)) =
v<u andalso incompatible  AnyChar (CharClass ((u,v)::L)) |

incompatible (CharClass ((u,v)::L))AnyChar=
v<u andalso incompatible  AnyChar (CharClass ((u,v)::L)) |

incompatible AnyChar (Literal(s)) = false |

incompatible (Literal s) AnyChar = false  |

incompatible x (NotPredicate(Sequence nil)) = true |

incompatible (NotPredicate(Sequence nil)) x = true |

(* incompatible (Sequence((Sequence L)::M)) N = 

incompatible (Sequence(L@M)) N |

incompatible N (Sequence((Sequence L)::M)) =

incompatible (Sequence(L@M)) N |

incompatible (Sequence(Literal nil::M)) N = 

incompatible (Sequence M) N |

incompatible N (Sequence(Literal nil::M)) = 

incompatible (Sequence M) N |

incompatible (Sequence(x::L)) (Sequence(y::L)) =
incompatible x y |

incompatible x (Sequence(y::L)) =
incompatible x y |

incompatible (Sequence(y::L)) x =
incompatible x y | *)

incompatible x y = false;

(*  BEGIN matching development *)

(* develop a matching function *)

(* this is equivalent to the assertion that two classes
can accept a common string *)

(* it is important that this function may report false positives
but should never report a false negative -- its non-matches are relied
upon for nonpreemption verification *)

(* the parameter LL is a list of logical conditions -- these are
checked at various points and cancelled when the pointer moves ahead.
In some matching conditions, I cancel the logical conditions where a test
for zero length might cause one to keep them.  Write such a test
and insert it there? *)

val TRACE = ref false;

fun traceremark message = (if (!TRACE) then errormessage message else ()) ;

fun settrace() = TRACE:=true;

fun setnotrace() = TRACE:=false;

val NOMATCHCACHE= ref[(AnyChar,AnyChar)];

val _ = NOMATCHCACHE := nil;

val MAYMATCHCACHE= ref[(AnyChar,AnyChar)];

val _ = MAYMATCHCACHE := nil;

fun matchcachevalue LL x b = (if b orelse LL<> nil then MAYMATCHCACHE:= add1 x (!MAYMATCHCACHE) else NOMATCHCACHE:=add1 x (!NOMATCHCACHE);b);

fun dereference (Reference s) =

if find s (!DEFS) = nil then Reference s

else hd(find s (!DEFS)) |

dereference X = X;

fun canmatch LL (Sequence((AndPredicate X)::L)) (Sequence M) =

if find1 (NotPredicate X) LL 

then (traceremark ("Contradiction with condition "^(defdisplay X)); false) else 

(* the idea that bare reference names are not matched was originally
to avoid a circularity condition but is actually a good idea.
Conditions that you want checked against one another by an actual
recursive call should be more than a bare reference, which is easily
arranged *)

(* I seem to have completely avoided checks of logical conditions against
the actual matched terms in this implementation, except for reference 
names and negative literal conditions.  I believe this fits my intent.
Further, I have cleared logical conditions in such checks; they are static. *)

(* I *could* put checks of reference conditions against one another
if I am doing them in a static manner, as such checks are cached *)

if ((not(isreference X)) andalso (map (fn (AndPredicate(Reference s))=>true|(NotPredicate(x))=> true |
(AndPredicate Y) => 
(if X<>Y then Canmatch (drop1 (AndPredicate X) (drop1 (AndPredicate Y)LL)) X Y else true)) LL) <>
(map (fn u=> true) LL))

then (traceremark "And condition match causes failure";false)

else Canmatch (add1 (AndPredicate X) LL) (Sequence L) (Sequence M) 

|   canmatch LL (Sequence M) (Sequence((AndPredicate X)::L)) =

canmatch LL (Sequence((AndPredicate X)::L)) (Sequence M) 

|   canmatch LL (Sequence((NotPredicate X)::L)) (Sequence M) =

if find1 (AndPredicate X) LL then 

(traceremark "Contradiction with logical condition causes failure";false)

(* installed expansion of negative conditions *)

else if nottransform(NotPredicate X) <> NotPredicate X

then Canmatch LL (Sequence((nottransform(NotPredicate X))::L)) (Sequence M)

else Canmatch (add1 (NotPredicate X) LL) (Sequence L) (Sequence M) 

|   canmatch LL (Sequence M) (Sequence((NotPredicate X)::L)) =

canmatch LL (Sequence((NotPredicate X)::L)) (Sequence M) 

|   canmatch LL L (Sequence((Literal nil)::M))

= canmatch LL L (Sequence M) 

|   canmatch LL (Sequence((Literal nil)::M)) L

= canmatch LL (Sequence M) L 

|   canmatch LL (Sequence((Sequence L)::M)) (Sequence (N)) = 

Canmatch LL (Sequence(L@M)) (Sequence(N))  

|   canmatch LL (Sequence(N)) (Sequence((Sequence L)::M)) =
canmatch LL (Sequence((Sequence L)::M)) (Sequence (N))

|   canmatch LL (Sequence(L)) (Sequence((Priority nil)::M)) = false 

|  canmatch LL (Sequence(L)) (Sequence((Priority (Y::M))::N)) =

Canmatch LL (Sequence(L)) (Sequence(Y::N))

orelse Canmatch LL (Sequence(L)) (Sequence((Priority M)::N))

|   canmatch LL (Sequence((Priority M)::N)) (Sequence(L)) =
canmatch LL (Sequence(L)) (Sequence((Priority M)::N)) 

|   canmatch LL (Sequence(x::L)) (Sequence((Optional X)::M)) =

(* sequence nil does match with an optional, so we let that pass through *)

(* when matching optionals or repetitions, which *may* be zero length
we nonetheless assume the logical conditions are cleared *)

if x = Optional X then 

Canmatch nil (Sequence L) (Sequence (NotPredicate X::M))

else Canmatch LL (Sequence(x::L)) (Sequence(X::M)) 
orelse Canmatch LL (Sequence(x::L)) (Sequence((NotPredicate X)::M))

|   canmatch LL (Sequence((Optional X)::M)) (Sequence(x::L)) =

canmatch LL (Sequence(x::L)) (Sequence((Optional X)::M)) 

|   canmatch LL (Sequence((ZeroOrMore X)::M)) (Sequence(x::L)) =

(* when matching optionals or repetitions, which *may* be zero length
we nonetheless assume the logical conditions are cleared *)

if x = ZeroOrMore X 

then Canmatch nil (Sequence M) (Sequence (NotPredicate X::L))

else Canmatch LL (Sequence((NotPredicate X)::M)) (Sequence(x::L)) 

(* this must be weakened to avert nontermination problems-
but without allowing false negatives *)

(* one can supply more data to the checker by writing
the repetition in a different form *)

orelse Canmatch LL (Sequence((X)::nil)) (Sequence(x::L))

|   canmatch LL (Sequence(x::L)) (Sequence((ZeroOrMore X)::M))  =

canmatch LL (Sequence((ZeroOrMore X)::M)) (Sequence(x::L)) 

|   canmatch LL (Sequence((OneOrMore X)::M)) (Sequence(L)) =

if L<>nil andalso hd L  = OneOrMore X then Canmatch nil (Sequence M) (Sequence (tl L))

else Canmatch LL (Sequence(X::(ZeroOrMore X)::M)) (Sequence(L)) 

|   canmatch LL (Sequence(L)) (Sequence((OneOrMore X)::M))  =


canmatch LL (Sequence(( OneOrMore  X)::M)) (Sequence(L)) 

(* the case of two references is separated out for possible special
attention for caching *)

(* idea for caching:  cache only if LL = nil; use the cache to
confirm a false value (but not a true value) *)

(* the basic idea (which needs to be checked, this is subtle) is
that the function may report false positives but will never report
false negatives *)

   | canmatch LL (Sequence((Reference s)::L)) (Sequence ((Reference t)::M)) =

(* check for undefined references *)

(if find s (!DEFS) = nil then (errormessage ("Undefined class "^s);false)

else if find t (!DEFS) = nil then (errormessage ("Undefined class "^t);false)

(* check to see if we are configured to make an entry into the cache *)

else if s<>t andalso (LL=[AndPredicate(Reference s),AndPredicate(Reference t)]

orelse LL=[AndPredicate(Reference t),AndPredicate(Reference s)])

 andalso L=nil andalso M=nil  andalso (not(find1 (Reference s,Reference t) (!NOMATCHCACHE)))
andalso (not(find1 (Reference t,Reference s) (!NOMATCHCACHE)))
andalso (not(find1 (Reference s,Reference t) (!MAYMATCHCACHE)))
andalso (not(find1 (Reference t,Reference s) (!MAYMATCHCACHE)))


then matchcachevalue nil  (Reference s,Reference t) (Canmatch 
[AndPredicate(Reference s),AndPredicate(Reference t)]
(Sequence((hd(find s (!DEFS)))::nil)) (Sequence ((hd(find t (!DEFS))::nil))))

(* force caching if we aren't in the right situation *)


else if s<>t andalso (not(find1 (Reference s,Reference t) (!NOMATCHCACHE)))
andalso (not(find1 (Reference t,Reference s) (!NOMATCHCACHE)))
andalso (not(find1 (Reference s,Reference t) (!MAYMATCHCACHE)))
andalso (not(find1 (Reference t,Reference s) (!MAYMATCHCACHE)))

andalso ( not(Canmatch [AndPredicate(Reference s),AndPredicate(Reference t)]
(Sequence((Reference s)::nil)) (Sequence ((Reference t)::nil))))

then false else

(* evaluate from the cache if possible *)

if (find1 (Reference s,Reference t) (!NOMATCHCACHE)
orelse find1 (Reference t,Reference s) (!NOMATCHCACHE))

then (traceremark("Failure from cache:  "^s^"; "^t) ;false)

(* this might seem redundant but needs to come before the
check for matching names to avert unnecessary tail matching *)

else if find1 (NotPredicate(Reference s)) LL orelse
find1 (NotPredicate(Reference t)) LL then 

(traceremark ("Logical condition rules out one of the classes "^s^", "^t);false)

else if s=t then Canmatch nil (Sequence L) (Sequence M)

else Canmatch (add1 (AndPredicate(Reference s)) (add1 (AndPredicate(Reference t)) LL)) (Sequence((hd (find s (!DEFS)))::L))(Sequence((hd (find t (!DEFS)))::M)))
  
|   canmatch LL (Sequence((Reference s)::L)) (Sequence (x::M)) =

(* check for undefined reference *)

if find s (!DEFS) = nil 

  then (errormessage ("Undefined class "^s);false)

(* check to see if it is the right time for caching *)

  else if LL = [AndPredicate(Reference s)] andalso L = nil andalso M = nil
andalso (not(find1 (Reference s,x) (!NOMATCHCACHE))) andalso (not(find1 (Reference s,x) (!MAYMATCHCACHE)))

      then matchcachevalue nil (Reference s,x) (Canmatch [AndPredicate(Reference s)] (Sequence((hd(find s (!DEFS)))::nil)) (Sequence (x::nil)))

(* force caching *)

      else if (not(find1 (Reference s,x) (!NOMATCHCACHE))) andalso (not(find1 (Reference s,x) (!MAYMATCHCACHE)))
       andalso (not(Canmatch [AndPredicate(Reference s)] (Sequence((hd(find s (!DEFS)))::nil)) (Sequence (x::nil))))
                 then false 
                 else

                      if find1 (Reference s,x) (!NOMATCHCACHE) 

                              then
(traceremark ("Failed from cache:  "^s^"; "^(defdisplay x));false)

                              else (Canmatch (add1 (AndPredicate(Reference s))LL) (Sequence((hd(find s (!DEFS)))::L))(Sequence(x::M)))

|  canmatch LL (Sequence (x::M)) (Sequence((Reference s)::L)) =

canmatch LL (Sequence((Reference s)::L)) (Sequence (x::M)) 

(* at this point the lead items (if there are two of them) will be literals *)

|  canmatch LL (Sequence(x::L)) (Sequence(y::M))

= if incompatible x y

then (traceremark "Literal match failure";false) 

else if (map (fn 
AndPredicate(X) => 

(not(incompatible (dereference X) x))

andalso 

(not (incompatible (dereference X) y))

andalso 
(isreference X orelse
((Canmatch nil (dereference X) (Sequence(x::L))) 

andalso (Canmatch nil (dereference X) (Sequence(y::M)))))

| 

NotPredicate(X) => x<>X 

andalso y<>X 

andalso (not(incompatible (literalnegate(dereference X)) (x)))

andalso (not(incompatible (literalnegate(dereference X)) y))) 

LL <>
map (fn u => true) LL)

then (traceremark "Literal fails match with logical condition"; false)

else let val (a,b) =
stringminus(x,y) in Canmatch nil (Sequence(a::L))  (Sequence(b::M)) end 

(* the only condition in which we exit with true *)
(* logical conditions can preempt this *)

|  canmatch LL (Sequence nil) (Sequence ((Reference s)::L)) =

if find1 (NotPredicate(Reference s)) LL then 

(traceremark "Logical contradiction with reference"; false)

else

canmatch LL (Sequence nil) (Sequence((hd(find s (!DEFS)))::L))

|  canmatch LL (Sequence nil) (Sequence(x::L)) =

(* a lone literal *)

if (map (fn AndPredicate(X) => not(incompatible (dereference X) x) andalso 

(isreference X orelse (Canmatch nil (dereference X) (Sequence(x::L)))) | NotPredicate(X) => x<>X andalso not(incompatible (literalnegate(dereference X)) (x))) LL <>
map (fn u => true) LL)

then (traceremark "Literal fails match with logical condition"; false)

else true

|  canmatch LL (Sequence(x::L)) (Sequence nil) =

canmatch LL (Sequence nil) (Sequence(x::L))

|  canmatch LL (Sequence ((Reference s)::L)) (Sequence nil) =

canmatch LL (Sequence nil) (Sequence ((Reference s)::L)) 

| canmatch LL (Sequence nil) (Sequence (L)) = true 

| canmatch LL (Sequence (L)) (Sequence nil) = true 

(* the matching operation works on sequence terms; these clauses
reorganize non-sequences *)

| canmatch LL (Sequence L) x = canmatch LL (Sequence L) (Sequence [x]) 

| canmatch LL x (Sequence L) = canmatch LL (Sequence [x]) (Sequence L) 

| canmatch LL x y = canmatch LL (Sequence[x]) (Sequence[y])

and Canmatch LL x y = 
(traceremark  ("Starting match of "^(defdisplay x)^"\n with "^(defdisplay y)^"\nunder conditions "^(defdisplay(Sequence LL)));
let val M = canmatch LL x y in

(if M then (traceremark  ("Match of "^(defdisplay x)^"\n with "^(defdisplay y)^" succeeds");M) else (traceremark ("Match of "^(defdisplay x)^"\n with "^(defdisplay y)^" fails");M)) end);

(* END matching development *)


fun preemptioncheck (Priority nil) = true |

preemptioncheck (Priority(x::L)) = 

Preemptioncheck x andalso

map (fn y=> 

(say ("Checking "^(defdisplay x)^"\nagainst "^(defdisplay y)^" for preemption");
not(Canmatch nil x y))) L = map (fn u=>true) L

andalso preemptioncheck (Priority L) |

preemptioncheck (Sequence((Optional X)::L)) =

Preemptioncheck X andalso (Preemptioncheck (Sequence L)) |

preemptioncheck (Sequence(X::L)) = Preemptioncheck X
    andalso Preemptioncheck (Sequence L) |

preemptioncheck (Optional X) = Preemptioncheck X |
preemptioncheck (ZeroOrMore X) = Preemptioncheck X |
preemptioncheck (OneOrMore  X) = Preemptioncheck X |
preemptioncheck (AndPredicate X) = Preemptioncheck X |
preemptioncheck (NotPredicate X) = Preemptioncheck X |
preemptioncheck X = true

and Preemptioncheck X = let val T = preemptioncheck X in
(if T then say ((defdisplay X)^" checks") else (say ((defdisplay X)^" fails"));T)
end;

fun Pcheck s = if find s (!DEFS) = nil then (say "No such class";false)

else let val A = Preemptioncheck (hd(find s (!DEFS)))

in if A then (say (s^" passes preemption check");A)

else (say (s^" fails preemption check");pause();A) end;

(* END ambiguity development *)

fun define s X = if find s (!DEFS) = nil then
( let val A = terminationcheck false X in (if not A andalso not (macroname s) then errormessage ("Fails termination check in "^s)else ();TERMINATIONCHECKED:=(s,A)::(!TERMINATIONCHECKED)) end; 



DEFS := (s,X)::(!DEFS);say (s^":");say (defdisplay X)) else (errormessage ("Cannot redefine "^s);say (defdisplay (hd(find s (!DEFS)))));

fun AChar x = CharClass[(x,x)];

fun ACharList L = CharClass (map (fn x=>(x,x)) L);

(* the grammar of PEG expressions installed *)

(* hierarchical syntax *)

val _ = setnopause();

val _ = define "_Grammar" (Sequence[Reference "_Spacing",OneOrMore(Reference "_Definition"),Reference "_EndOfFile"]);

val _ = define "_Definition" (Sequence[Reference "_Identifier",Reference "_LEFTARROW",Reference "_Expression"]);

val _ = define "_Expression" (Sequence[Reference "_Sequence",ZeroOrMore(Sequence[Reference "_SLASH",Reference "_Sequence"])]);

val _ = define "_Sequence" (ZeroOrMore (Reference "_Prefix"));

val _ = define "_Prefix" (Sequence[Optional(Priority[Reference "_AND",Reference "_NOT"]),Reference "_Suffix"]);

val _ = define "_Suffix" (Sequence[Reference "_Primary",Optional(Priority[Reference "_QUESTION",Reference "_STAR",Reference "_PLUS"])]);

val _ = define "_Primary" (Priority[Sequence[Reference "_Identifier",NotPredicate(Reference "_LEFTARROW")],
Sequence[Reference "_OPEN", Reference "_Expression", Reference "_CLOSE"],
Reference "_Literal",
Reference "_Class",
Reference "_DOT"]);

(* lexical syntax *)

val _ = define "_Identifier" (Sequence [Reference "_IdentStart",ZeroOrMore(Reference "_IdentCont"),Reference "_Spacing"]);

val _ = define "_IdentStart" (CharClass[(#"a",#"z"),(#"A",#"Z"),(#"_",#"_")]);

val _ = define "_IdentCont"  (Priority[Reference"_IdentStart",CharClass[(#"0",#"9")]]);

val _ = define "_Literal"  
(Priority[
(Sequence[CharClass[(#"'",#"'")],
   ZeroOrMore(Sequence[NotPredicate(CharClass[(#"'",#"'")]),Reference "_Char"]),
   CharClass[(#"'",#"'")],Reference "_Spacing"]),
(Sequence[CharClass[(#"\"",#"\"")],
   ZeroOrMore(Sequence[NotPredicate(CharClass[(#"\"",#"\"")]),Reference "_Char"]),
   CharClass[(#"\"",#"\"")],Reference "_Spacing"])]);

val _ = define "_Class" (Sequence[CharClass[(#"[",#"[")],
   ZeroOrMore(Sequence[NotPredicate(CharClass[(#"]",#"]")]),Reference "_Range"]),
CharClass[(#"]",#"]")],Reference "_Spacing"]);

val _ = define "_Range" (Priority[Sequence[Reference "_Char",CharClass[(#"-",#"-")],
   Reference "_Char"],Reference "_Char"]);

val _ = define "_Char" (Priority[

Sequence[CharClass[(#"\\",#"\\")],
ACharList[#"n",#"r",#"t",#"'",#"\"",#"[",#"]",#"\\"]],

Sequence[CharClass[(#"\\",#"\\")],
CharClass[(#"0",#"2")],CharClass[(#"0",#"7")],CharClass[(#"0",#"7")]],
Sequence[CharClass[(#"\\",#"\\")],CharClass[(#"0",#"7")],Optional(CharClass[(#"0",#"7")])],
Sequence[NotPredicate(AChar(#"\\")),AnyChar]

]);

val _ = define "_LEFTARROW" (Sequence [Literal (explode "<-"),Reference "_Spacing"]);

val _ = define "_SLASH" (Sequence [Literal (explode "/"),Reference "_Spacing"]);

val _ = define "_AND" (Sequence [Literal (explode "&"),Reference "_Spacing"]);

val _ = define "_NOT" (Sequence [Literal (explode "!"),Reference "_Spacing"]);

val _ = define "_QUESTION" (Sequence [Literal (explode "?"),Reference "_Spacing"]);

val _ = define "_STAR" (Sequence [Literal (explode "*"),Reference "_Spacing"]);

val _ = define "_PLUS" (Sequence [Literal (explode "+"),Reference "_Spacing"]);

val _ = define "_OPEN" (Sequence [Literal (explode "("),Reference "_Spacing"]);

val _ = define "_CLOSE" (Sequence [Literal (explode ")"),Reference "_Spacing"]);

val _ = define "_DOT" (Sequence [Literal (explode "."),Reference "_Spacing"]);

val _ = define "_Spacing"  (ZeroOrMore(Priority[Reference "_Space",Reference "_Comment"]));

val _ = define "_Comment" (Sequence[AChar (#"#"),

   ZeroOrMore(Sequence[NotPredicate(Reference "_EndOfLine"),AnyChar]),
   Reference "_EndOfLine"]);

val _ = define "_Space" (Priority[AChar #" ",AChar #"\t",Reference "_EndOfLine"]);

val _ = define "_EndOfLine"  (Priority[Sequence[AChar #"\r",AChar #"\n"],
     AChar #"\r",
     AChar #"\n"]);

val _ = define "_EndOfFile"  (NotPredicate(AnyChar));

val _ = setpause();

val PEGPARSE = (!DEFS);



(* functions to read parsed PEG definitions *)

fun escapesequence (#"n") = #"\n" |
 escapesequence (#"r") = #"\r" |
 escapesequence (#"t") = #"\t" |
 escapesequence (#"\"") = #"\"" |
 escapesequence (#"'") = #"'" | 
escapesequence (#"]") = #"]" |
 escapesequence (#"[") = #"[" |
 escapesequence (#"\\") = #"\\" |
escapesequence x = (errormessage "Bad escape sequence encountered";#"X"); 

fun extractchar (String[t]) = t |

extractchar (ReferenceTagged(s,u)) = extractchar u |

extractchar (UnlabelledList [x]) = extractchar x |

extractchar (UnlabelledList [x,y]) = escapesequence (extractchar y) |

extractchar x = (errormessage "Failed character extraction";#"X");

fun extractrange (UnlabelledList [x]) = extractrange x |

extractrange (UnlabelledList[x,y]) = 

   (extractchar (UnlabelledList[x,y]),extractchar (UnlabelledList[x,y])) |

extractrange (ReferenceTagged(r,x)) = extractrange x |

extractrange (String[s]) = (s,s) |

extractrange (UnlabelledList[x,y,z]) = (extractchar x,extractchar z) |

extractrange x = (errormessage "Failed range extraction";(#"X",#"X"));

fun parseid (ReferenceTagged ("_Identifier",
     UnlabelledList[ReferenceTagged ("_IdentStart",String [s]),
     UnlabelledList L,x])) =

     implode (s::(map extractchar L)) |

parseid x = (errormessage  "parseid applied to bad value";"???!!!");

(* numerical escape codes not supported; not hard to add *)

fun parseexp (ReferenceTagged("_Expression",UnlabelledList[ReferenceTagged("_Sequence",s)])) = parseexp (ReferenceTagged("_Sequence",s)) |

parseexp (ReferenceTagged ("_Expression",UnlabelledList[
           ReferenceTagged("_Sequence",s),UnlabelledList L]))

    = if L = nil then parseexp (ReferenceTagged("_Sequence",s))

    else Priority((parseexp (ReferenceTagged("_Sequence",s)))::
    (map (fn (UnlabelledList[ReferenceTagged("_SLASH",a),ReferenceTagged("_Sequence",t)]) => (parseexp (ReferenceTagged("_Sequence",t)))|
x=>(errormessage  "Error 1 in Expression parsing";Sequence nil)) L)) | 

parseexp (ReferenceTagged ("_Expression",u))

= (errormessage "Error 2 in Expression parsing";Sequence nil) |

parseexp (ReferenceTagged("_Sequence",UnlabelledList [x])) =

parseexp x |

parseexp (ReferenceTagged("_Sequence",UnlabelledList L)) =

Sequence (map parseexp L) |

parseexp (ReferenceTagged("_Prefix",UnlabelledList[ReferenceTagged("_Suffix",s)])) = parseexp (ReferenceTagged("_Suffix",s)) |

parseexp (ReferenceTagged("_Prefix",UnlabelledList[ReferenceTagged("_NOT",n),ReferenceTagged("_Suffix",s)])) = NotPredicate(parseexp (ReferenceTagged("_Suffix",s))) |

parseexp (ReferenceTagged("_Prefix",UnlabelledList[ReferenceTagged("_AND",n),ReferenceTagged("_Suffix",s)])) = AndPredicate(parseexp (ReferenceTagged("_Suffix",s))) |



parseexp (ReferenceTagged("_Suffix",UnlabelledList[ReferenceTagged ("_Primary",p)])) =

parseexp (ReferenceTagged ("_Primary",p)) |

parseexp (ReferenceTagged("_Suffix",UnlabelledList[ReferenceTagged ("_Primary",p),
     ReferenceTagged( "_QUESTION",q)])) = 
Optional(parseexp (ReferenceTagged ("_Primary",p))) |

parseexp (ReferenceTagged("_Suffix",UnlabelledList[ReferenceTagged ("_Primary",p),
     ReferenceTagged( "_STAR",s)])) = 
ZeroOrMore(parseexp (ReferenceTagged ("_Primary",p))) |

parseexp (ReferenceTagged("_Suffix",UnlabelledList[ReferenceTagged ("_Primary",p),
     ReferenceTagged( "_PLUS",q)])) = 
OneOrMore(parseexp (ReferenceTagged ("_Primary",p))) |

parseexp (ReferenceTagged ("_Primary",UnlabelledList[(ReferenceTagged("_Identifier",I))])) =

     Reference (parseid (ReferenceTagged("_Identifier",I))) |

parseexp (ReferenceTagged ("_Primary",UnlabelledList[x,ReferenceTagged("_Expression",E),y])) = parseexp (ReferenceTagged("_Expression",E)) |

parseexp (ReferenceTagged ("_Primary",ReferenceTagged("_Literal",UnlabelledList[x,UnlabelledList L,y,z]))) =

Literal (map extractchar L) |

parseexp (ReferenceTagged ("_Primary",ReferenceTagged("_Class",UnlabelledList[x,UnlabelledList L,y,z]))) =

charnormalize(CharClass(map extractrange L))  |

parseexp (ReferenceTagged ("_Primary",ReferenceTagged ("_DOT",d))) = AnyChar |

parseexp (ReferenceTagged(s,x)) = 
(errormessage ("Parseexp error with tag "^s);Sequence nil) |

parseexp x = (errormessage  "General error in parseexp";Sequence nil);

fun parsedef (ReferenceTagged("_Definition",UnlabelledList[ReferenceTagged("_Identifier",I),a,ReferenceTagged("_Expression",E)])) = 

let val J = (parseid (ReferenceTagged("_Identifier",I)))

and K = (parseexp (ReferenceTagged("_Expression",E))) in

if reservedname J then if (not(macroname J))

then (errormessage "Cannot define a new reserved class (single _)")

else if (not (underscorefree K))

then (errormessage "Macro names (double __) are reserved for non-nested macros") else

define J K else define J K end |

parsedef x = errormessage "Badly formed definition line";


fun Parsedef s = (clearcache();
let val (A,B) = parse (Reference "_Definition") (explode s) in

if B = nil then

parsedef A

else errormessage  "Definition line was not parsed completely" end);

fun exptest e s = parseexp (p1(parse (Reference e) (explode s)));

fun showdef s = if find s (!DEFS) = nil then errormessage "No such definition"

else (say (s^":");say(defdisplay (hd(find s (!DEFS)))));


fun removedef s = 
if reservedname s andalso not(macroname s) then 

errormessage "Cannot remove definition with reserved name (single _)"

else

DEFS:=drop s (!DEFS);

fun percentdecorate0 nil = nil |

percentdecorate0 [x] = [x] |

percentdecorate0 (#"\n"::L) = (#"\n":: #"%" :: (percentdecorate0 L)) |

percentdecorate0 (x::L) = (x::(percentdecorate0 L));

fun percentdecorate s = ("%")^(implode(percentdecorate0 (explode s)));

(* removedef breaks termination checking of course *)

fun parsetest c s = (clearcache();
if hd(explode s) <> #"%" then writelogline s else ();
THESTRING:=explode s;
if length(explode s) >= 2 andalso hd(explode s)<> #"#" andalso hd(explode s)<> #"%" then
let val OUT = outputdisplay(prune(p1(parse (Reference c)(explode s)))) in (writelogline(percentdecorate OUT);
say(OUT)) end else ());

fun classfromstring s =

let val (A,B) = parse (Reference "_Expression")(explode s)

in (if B <> nil then say "Incomplete parse" else ();
parseexp A) end;


fun test f x y = f(classfromstring x)(classfromstring y);


fun commentprocess0 nil = nil |

commentprocess0 (#"\n"::L) = (#"\n")::(#"#")::(commentprocess0 L) |

commentprocess0 (#"\r"::L) = (#"\r")::(#"#")::(commentprocess0 L) |

commentprocess0 (x::L) = x::(commentprocess0 L);

fun commentprocess s = implode(commentprocess0(explode s));

fun commentstring s = if find s (!COMMENTS) = nil then ""
                      else "\n#"^(commentprocess(hd(find s (!COMMENTS))))^"\n";;

fun grammarstring nil = "" |

grammarstring ((s,X)::L) = (commentstring s)^"\n"^s^" <- "^(defdisplay X)^"\n"^(grammarstring L);

fun grammarstring2 nil="" |

grammarstring2 ((s,X)::L) = (commentstring s)^"\nL(\""^s^" <- "^(defdisplay X)^"\")\n"^(grammarstring2 L);

fun grammarstring3 nil = "" |

grammarstring3 ((s,X)::L) = "<TT>"^(commentstring s)^"\n"^s^" <- "^(defdisplay X)^"</TT><P>\n"^(grammarstring3 L);



val FILE = ref(TextIO.openOut("dummy"));

fun savegrammar filename =  (FILE:=TextIO.openOut((filename^".peg"));
TextIO.output((!FILE),grammarstring(rev(!DEFS)));TextIO.flushOut(!FILE);
TextIO.closeOut(!FILE));

fun savegrammar3 filename =  (FILE:=TextIO.openOut((filename^".html"));
TextIO.output((!FILE),grammarstring3(rev(!DEFS)));TextIO.flushOut(!FILE);
TextIO.closeOut(!FILE));


fun savegrammar2 filename =  (FILE:=TextIO.openOut((filename^".py"));
TextIO.output((!FILE),"from loglanpreamble import *\n\n");
TextIO.output((!FILE),grammarstring2(rev(!DEFS)));TextIO.flushOut(!FILE);
TextIO.output((!FILE),"if __name__ == '__main__':interface();");
TextIO.closeOut(!FILE));


val FILE2 = ref(TextIO.openIn("dummy"));

fun loadgrammar0() = (
let val A = Inputline(!FILE2) in
(if A = "" orelse hd(explode A) = #"#" orelse  hd(explode A) = #"\n" orelse  hd(explode A) = #"\r"then () else Parsedef A;
if A <> "" then loadgrammar0() else (TextIO.closeIn(!FILE2))) end);

fun loadgrammar filename = (FILE2:=TextIO.openIn(filename^".peg");
           loadgrammar0());


val TOPTYPE = ref "";

fun settop s = TOPTYPE:=s;

fun utter s = parsetest (!TOPTYPE) s;

fun clear() = ( setpause(); verbose();  unreallyverbose();  settop ""; HIDDEN:=nil; cleartags();TERMINATIONCHECKED:=nil;DEFS := PEGPARSE; COMMENTS:=nil; setnotrace();NOMATCHCACHE:=nil;MAYMATCHCACHE:=nil);

fun clearcaches() =  (TERMINATIONCHECKED:=nil;NOMATCHCACHE:=nil;MAYMATCHCACHE:=nil);

fun grammarcheck() = map (fn (x,y) => Pcheck x) (rev(!DEFS));

(* begin new ambiguity checking project *)

(* The idea is to search for elements of a class *)

(* BEGIN copied from above for reference

(* put character classes in normal form and negate them *)

fun charmax (x:char) y = if x<y then y else x;

fun charadd (x,y) (CharClass L) = CharClass((x,y)::L);

fun chardrop (CharClass nil) = CharClass nil |

   chardrop (CharClass(x::L)) = CharClass L;

fun charsucc x = chr((ord x)+1);

fun charpred x = chr((ord x)-1);

fun charnormalize (CharClass nil) = CharClass nil |

charnormalize (CharClass([(x,y)])) = if y<x
then CharClass nil else CharClass([(x,y)]) |

charnormalize (CharClass((x,y)::(z,w)::L)) =

     if y<x then charnormalize (CharClass((z,w)::L)) 

     else if w<z then charnormalize (CharClass((x,y)::L))

     else if x<=z andalso z<=y  then charnormalize (CharClass((x,charmax y w)::L))

     else if z<=x andalso x<=w then charnormalize (CharClass((z,charmax y w)::L))

     else if x<=z then 

let val TEST = charnormalize(charadd (z,w)(charnormalize (CharClass L))) in

if TEST = charnormalize(CharClass((z,w)::L)) then charadd (x,y) TEST

else charnormalize (charadd (x,y) TEST) end



     else
let val TEST = charnormalize(charadd (x,y)(charnormalize (CharClass L))) in

if TEST = charnormalize(CharClass((x,y)::L)) then charadd (z,w) TEST


 else charnormalize (charadd (z,w) TEST) end;

(* fun cntest s = defdisplay(charnormalize(classfromstring s)); *)

val top = maxChar;

val bottom = minChar;

fun prenegate (CharClass nil) = CharClass([(bottom,top)]) |

prenegate (CharClass([(x,y)])) = 

if x=bottom andalso y = top then CharClass nil else

if x=bottom then CharClass([(charsucc y,top)]) else

if y=top then CharClass([(bottom,charpred x)]) else

CharClass([(bottom,charpred x),(charsucc y,top)]) |

prenegate (CharClass((x,y)::(z,w)::L)) =

     if x=bottom then (charadd (charsucc y,charpred z) (chardrop (prenegate
            (CharClass((z,w)::L)))))

     else charadd (top,charpred x) (charadd (charsucc y,charpred z) (chardrop (prenegate
            (CharClass((z,w)::L)))));

fun charnegate (CharClass M) = prenegate(charnormalize(CharClass M));

END copied from above for reference *)

fun charunion (CharClass L) (CharClass M) = charnormalize (CharClass (L@M));

fun charintersection (CharClass L) (CharClass M) =

    charnegate (charunion (charnegate (CharClass L)) (charnegate (CharClass M)));

fun cnt s = defdisplay(charnegate(classfromstring s));

fun cvt s t = defdisplay(charunion(classfromstring s)(classfromstring t));

fun cit s t = defdisplay(charintersection(classfromstring s)(classfromstring t));

(* BEGIN for reference

datatype ParsingExpression =

Reference of string |

Literal of char list |

CharClass of (char*char) list |

AnyChar |

Unknown |

Optional of ParsingExpression |

ZeroOrMore of ParsingExpression |

OneOrMore of ParsingExpression |

AndPredicate of ParsingExpression |

NotPredicate of ParsingExpression |

Sequence of ParsingExpression list |

Priority of ParsingExpression list;

END for reference *)

fun desequence1(Sequence L) = L |

desequence1 x = [x];
fun

desequence2 (Priority L) = L|

desequence2 x = [x];

(* a standard form function -- flatten sequence and priority lists,
convert literals to sequences of characters, convert AnyChar to 
CharClass form; logical simplications  *)

fun 

regiment (Literal (L)) = Sequence(map (fn s => CharClass[(s,s)]) L) |

regiment AnyChar = CharClass[(bottom,top)] |

regiment (CharClass L) = charnormalize(CharClass L) |

regiment (Sequence [x]) = regiment x |

regiment (Priority [x]) = regiment x |

regiment (Sequence((Priority L)::M)) =

regiment (Priority(map (fn X=>regiment(Sequence(X::M))) L)) |

regiment (Sequence(x::(Priority L)::M)) =

regiment(Priority(map (fn X=>regiment(Sequence(x::X::M))) L)) |

regiment (Sequence((Sequence L)::M)) = regiment(Sequence(L@M)) |

regiment (Sequence(x::(Sequence L)::M)) =

regiment (Sequence(x::(L@M))) |

regiment (Priority((Priority L)::M)) = regiment(Priority(L@M)) |

regiment (Priority(x::(Priority L)::M)) =

regiment (Priority(x::(L@M))) |

regiment (Sequence(x::L)) = let val T = regiment x 

and U = regiment(Sequence L) in

if T=x andalso (U=Sequence L orelse U = hd L) then Sequence(x::L)

else regiment(Sequence(T::(desequence1 U))) end |

regiment (Priority(x::L)) = let val T = regiment x 

and U = regiment(Priority L) in

if T=x andalso (U = Priority L orelse U = hd L) then Priority(x::L)

else regiment(Priority(T::(desequence2 U))) end |

regiment (Optional (Priority L)) =
regiment(Priority(map Optional L)) |

regiment (Optional X) = Optional(regiment X) |

regiment (ZeroOrMore X) = ZeroOrMore(regiment X) |

regiment (OneOrMore X) = OneOrMore (regiment X) |

regiment (AndPredicate (Priority L)) =
regiment(Priority(map AndPredicate L)) |

regiment (NotPredicate (Priority L)) =
regiment(Sequence (map NotPredicate L)) |

regiment (AndPredicate (AndPredicate X)) = regiment (AndPredicate X) |
regiment (AndPredicate (NotPredicate X)) = regiment (NotPredicate X) 
|regiment (NotPredicate (AndPredicate X)) = regiment (NotPredicate X) 
|regiment (NotPredicate (NotPredicate X)) = regiment (AndPredicate X) |
regiment (AndPredicate X) = AndPredicate (regiment X) |

regiment (NotPredicate X) = NotPredicate (regiment X) |

regiment x = x;

fun negfun (CharClass L) = AndPredicate(charnegate(CharClass L)) |

negfun (Sequence nil) = Priority nil |

negfun (Sequence [x]) = negfun x |

negfun (Sequence(x::L)) = regiment(Priority([negfun x,AndPredicate(Sequence[x,negfun (Sequence L)])])) |

negfun (Priority L) = regiment(Sequence(map (fn X => regiment((AndPredicate (negfun X)))) L)) |

negfun (Optional X) = Priority nil |

negfun (ZeroOrMore X) = Priority nil |

negfun (OneOrMore X) = negfun X |

negfun (NotPredicate X) = regiment(AndPredicate X) |

negfun (AndPredicate X) = regiment(NotPredicate X) |

negfun x = regiment(NotPredicate(regiment x));

fun rt s = defdisplay(regiment(classfromstring s));

fun nt s = defdisplay(negfun(regiment(classfromstring s)));

(* I need to fix the display of Priority nil *) 





