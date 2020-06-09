(* the Pure False stack machine *)

fun say s = TextIO.output(TextIO.stdOut,"\n\n"^s^"\n\n");

fun versiondate() = say "August 30, 2005";

(* Differences from standard False 

@ used to be different but is now restored
? used to be different but is now restored
pick is not there (but can be written)
) is flush
no inline assembly (` means something novel)
the language is (dynamically) typed, so the peek/poke trick does not work.
only functions can be stored in character variables (but given
the additional tools for handling lists/functions, this is more
an apparent than a real problem).
multi-digit integers cannot be read in the usual format:
  _ stands for (x,y...)->(10y+x...) and is used to write
  multi-digit decimals in a single-character opcode format.

There is considerable additional functionality:  

one can carry out standard list operations on "functions" (in two flavors,
since some components of lists have execution behavior and one does not
always wish to encourage this!)  Since all contents of character-labelled
variables are functions, ; includes the effect of application.

there is file I/O

*)

(* August 30:

I wrote the notext function which should convert a function to
a unique form almost without program text.  The only place where
I actually use it is in the = for functions.  I banished Opcode "0"
and its kindred.

fixed another bug in the first function.  Something needs to
be done about the dual representation of functions as
lists and text.

Restored original False meaning of @ (just for compatibility,
since this is also restored for ?).  The old meaning is new \@
The preservation of order of arguments 1 and 2 is useful.

The control structures now differ slightly in behavior and
fundamentally in implementation (the profound change is in D
and P, which now really support continuations).  The bracket
around the test is no longer wanted for ? (returning to the way
False itself behaves).  There are no longer subsidiary calculations
going on:  the "program stack" P honestly contains complete information
about what is to be run.  # behaves in the same way as before (except
under trace, where it looks rather different) but the pending
executions are actually recorded in the P parameter.  I also had
to fix i for the same reasons, and discovered a bug in incremental
execution of program text.

I seriously should consider converting program text to list
structures?  The mixture of parsing and stack operations is a little
weird, though it seems to be transparent except to =.

removed the prompt for character input from the program: this is
easily supplied by the user (and can now be controlled by the user).

env2 is another attempt at an environment, in some ways more satisfactory.

input reacts badly with the current implementation of trace.

*)

(*

August 29 status report

Reason for doing this:  Strictly False will be a good language for
the Palm when I implement it there (easy to implement and easy to use
in the sense of requiring few keystrokes).

The purity of the single character approach is enhanced by the new
integer display :-)

File commands appear to work.

Defects:

Clean up problems caused by the use of text in Program components in
functions.  These are very handy but can cause trouble:  either make
the simulation perfect or eliminate.  If a function with program text
is tested for equality the program text should perhaps be eliminated?

Features to add:

Casting between characters and integers is a legitimate feature.  A
function which casts from characters to opcodes is also a good idea.DONE

Retrieving the stack as a data item, and checking whether it is empty
are legitimate functions.  How about replacing the stack?
How about two-way access to the program being executed?DONE

I implemented a test for empty stack, grabbing the data stack and
putting it on the stack, replacing the data stack with its top
element, and grabbing the program stack and putting it on the stack,
and discarding the program stack and executing the function on top of
the data stack (this enables continuation handling).  The data stack
always means "the data stack after any opcodes or program text
on the data stack is executed" and any D command executed from the
data stack will actually be executed from a correct program stack.
D can only prevent pending conditional execution by arranging to
return a false.

File I/O; open a file and bind it to a character.  Get a character,
put a character, execute a file and put a function in a file (this
last command opens the file, saves the data in it, and closes
it). Close a file and flush a file (ML only allows for flushing
outstreams).  Open file is DONE; read and write characters are DONE;
output buffer is always flushed when doing input or closing file, so
no need for flush command.  The file read command R always leads
its output with a boolean telling whether there is a character read
or not.  Errors as to existence of files stop the program.

I implemented loading and saving of functions to files.  This also meant
that I need to enforce the condition that the execution of the display
of a stack will be the same as the execution of the stack:  to do
this I introduce opcodes for true and false and a slightly demented
but readable way of displaying multi-digit integers.  This fixes
a bug, actually:  functions containing multi-digit numbers or
truth values would not have executed correctly in previous versions?

Ability to define new opcodes: take a defined function and
"permanently" bind it to a character (from the standpoint of any fixed
program).  This command can only be issued in the programming
environment and the defined character remains dynamically allocable.

Ability to save data of all types to numerical addresses.  This
restores a cheat capability of False.  This will be static storage
(though functions/lists can be stored).  Allocation of this memory
might be an issue in a non-ML version.

There are real advantages to my formulation of ?; it will stay the
same.  My @ is better (I reversed myself on both of these).

i really is trace:  my notes below about this were wrong.  Think of
the function as living in P, not on the stack.

I could install an integer input mode, I suppose, and make it so that
integers in multi-digit format can be read by the system.NOT NEEDED:
there is now a standard way to write integers using single digit
opcodes.

Clean up the format of the user environment and install the stupid line
editor.

Write real documentation and set up a web page.  Write to Wouter about it.

The main philosophical issues are the typing and the ability to
manipulate saved stacks (including executable programs) as lists (and
the requisite need to assign (virtual) internal structure to
programs).  The invisible OpCode type is needed to preserve the idea
that executing a function is simply dropping it onto the data stack.
This is an essentially more powerful language than False (and probably
still admits a small implementation: write in C and compile?)  A
mathematical issue is demonstrating that this language does
combinators: do this by exhibiting the combinators and testing them.

*)

(* the language now works.  It is somewhat different from the original
False and these differences should be set out.  *)

(* in the help command, the language Pure False is now specified *)

(* mod debugging I believe this implements a dialect of False which
adds the ability to push items into "lambdas" (this makes it combinatorially
complete).  This dialect is fairly strongly dynamically typed: no casting.  
Only
function definitions are supported by : and ;, but every character can
be defined as a function.  The " " and [ ] forms are not supported
in the underlying opcodes:  these programs are constructed by a string
preprocessing step.  Numerical input is restricted to 0-9
as in Befunge. *)

(* I need to install the ability to run programs from the console or a file.
The internal environment in which this is done should also allow control
of the trace features.  I need to install comments in the language.
A help command with information about each opcode would be useful:
the help command is now available; it takes a string argument,
and single character strings can be used to get info about opcodes.

I need to fix the (deliberately permitted) crashes:  ML crashes will
break the projected native Pure False programming environment, which is not
a good thing (though I can use error handling to prevent this).

Starting on this:  the definition facility will no longer crash, and
the conditional tests escape gracefully when they do not detect truth values.
Division by zero is also corrected; I _think_ these are all the ML
errors possible...

There is still the need to guard against arithmetic overflow.  This could
be done neatly by putting all arithmetic in a suitable modulus?DONE

Comments are installed.

August 25th updates were bug fixes to list functions; writing
a list reverse procedure was an eye-opener.  Notice that treating
i as trace is not correct at all, since the operators would get
to act on later operators normally.  There were difficulties with
handling of the underflow situation and a very subtle confusion
between Stack(nil) and Stack[Program nil]:  probably best handled
by eliminating embedded text.  But embedded text does neatly solve
the problem it was designed to handle, and for the moment seems to
be correctly simulated.

I now have the desktop environment mostly developed.  Its look and
feel need to be improved.  The ability to turn off trace during
a trace is useful.  It would be nice if trusted functions could work
as single steps under trace.  I would like to have a line editor for
Strictly False in the repertoire.  The crashes are mostly repaired.

A main aim for this is to implement it in another language (iziBasic,
probably, but this might be via C as well).  That's what the memory
model stuff is for.

*)

(*

It would be straightforward to allow static installation of
new opcodes (basically similar to ; in implementation.  This
would of course be a programming environment command.

Explicit integer/character type casting should be supported,
since the implicit kind has been disabled.  A "cast" opcode
which takes an appropriate integer to a character and a character
to an integer is reasonable.

I have now added the ability to execute a function step by step
in the language itself (i); it might be nice to add the ability
to display the top opcode of a function and to display the
stack as opcodes in the language; one could then debug programs
inside the interpreter!  No, one can't: opcodes will execute, but
not on the right arguments!

A real trace might copy all arguments to the stack, carry out one
step, and encase the top item in a function.  Such a command could
be provided.

Adding equality of functions violates type safety completely;
what about adding equality of opcodes?  Or does thinking of it
in terms of equality of opcodes reveal that it is not a type safety
violation to have equality of functions?  Maybe it is simply that
functions are a union type into which many types can be cast?

*)

(* Why is Pure False pure?

with the addition of the p and o commands, it is combinatorially
complete (the S and K combinators can be constructed; I should
demonstrate this).  there is a very small set of commands which is a
complete pure calculus of stacks; that way lies madness, though.

it is completely reliant on single character opcodes.  'X and `X
are apparent exceptions, but really can be thought of as providing
extensions to the alphabet.  The same can be thought of X: and X; --
these can be thought of as allowing definition of and access to
a further alphabet of defined opcodes.  Even the "..."
and "[...]" forms can be rephrased in terms of single character
opcodes (I tried using this in the very first version, but
the string preprocessor I wrote didn't work correctly on
nested brackets; in any event one would have exponential
blowup with bracket nesting).

Note that variables are addressable by the language,
since their names are characters which can be produced
by program operations.

it is typed, unlike earlier versions.  there is no casting
of objects from one type to another, and no messing with
assembly code; programming in Pure False must be pure
(though it is not completely safe :-)

I'm now adding i j and x commands which give more list
functionality.  i pops off a function, executes its first command,
and puts its tail back.  j pops off a function, puts the one-element
stack of the first element on, then puts the tail back.  x checks
whether the function on top is empty.  In effect this gives
hd, tl.

There is a subtle problem with i:  in its simplest version, it
just grabs items of the form Program <text>.  It shouldn't do this.
This is now fixed (the interpreter parses out the first 
component).

After consideration, I added the function equality test;
it behaves differently because it does not consume its arguments
(they being potentially large).  This makes x redundant, but it
is still convenient (and makes more sense philosophically).

I have made the arithmetic safe from overflow:  for multiplication,
this is rather tricky :-).  Comments have been implemented.

What would be needed for static type checking?  Is it possible at all?

Perhaps the language should be called Strictly False :-)

*)

(*

Considerations for an implementation at an even lower level:

cells in the Strictly False virtual machine contain a switch telling
what kind of cell it is (boolean, integer, character, or program),
the address of the next cell and the address of the last cell in the
list (program) to which it belongs.  The last cell address is useful
because it makes it easy to take a program at the top of the master
stack and put it at the top.  How hard would it be to also have unique
cells?  This would require that cells have additional data that organizes
them into a sorted tree.  Last cell address idea doesn't work;
one still needs to scan through to update last cell addresses in
the list, so one gains nothing by recording it.

For execution purposes, there is a master address that points into the
heap:  the address is changed on execution (and new cells may be created
or destroyed).  Do we avoid circular structures?  Yes.  So reference
counting will work.   Put in fields in addition:  reference count,
cells to the left in the sorted tree, cells to the right in the sorted
tree.

The order on cells is lexicographic on the switch, the data and the
address of the next cell (the address of the last cell is of
course strictly speaking redundant).

Unused memory is organized into another linear list; more memory can
presumably be requested and organized as needed.

Unique reference is important because it makes the function equality
test simple.

In ML one can simulate this using a binary tree with cells numbered by
position: in a flat tree this is harmless (the cells in use will be
roughly a solidly filled initial segment of the naturals) This is
advantageous since I don't have arrays (or at least I don't know how
they work.)  This makes it reasonably easy to get to an address.

This observation means that one doesn't actually need a tree structure:
flattening the tree means that we can just regard 2n and 2n+1 as the 
nodes to the left and right of n.  So in an array, ref count, nodes in
use to left and nodes in use to right are enough.

*)

(* the datatype of items allowed on the machine stack *)


datatype StackItem = OpCode of char |

   Bool of bool |

   Int of int |

   Char of char |

   Program of char list |

   Stack of StackItem list;

(* prevent integer overflow -- there should be no ML crashes.  *)

fun intfix0 n = n mod 200000000;

fun intfix n = let val A = n mod 200000000 in
if A<=100000000 then A else A-200000000 end;

(* more care is required for multiplication to avoid overflow *)

(*  x*y = 2x*(y/2) = 2x*(y div 2 + y mod 2/2) = 2x*(y div 2) + x*y mod 2 *)

fun multiply x y =

   if y=0 then 0 else if y<0 then intfix(multiply (~x) (~y))

   else if y=1 then intfix x else 
   intfix(multiply(intfix(2*x))(y div 2)+x*(y mod 2));

fun makestring n = Int.toString n;

fun implode s = String.concat s

fun explode s = List.map str (String.explode s);

fun display (OpCode x) = str x |

   display (Bool x) = if x then "t" else "f" |

   display (Char x) = "'"^(str x) |

(* execution of an integer display will now put that integer on the stack *)

   display (Int x) = if x<0 then ("0"^(display (Int(~x)))^"-")

      else if x>9 then ((display(Int(x div 10)))^(display(Int(x mod 10)))^"_")

      else makestring x |

   display (Program L) = (implode (map str L)) |

   display (Stack L) = "["^(listdisplay L)^"]" 

and listdisplay nil = "" |

   listdisplay [x] = display x |

   listdisplay (x::L) = (display x)^" "^(listdisplay L);

   val DEFINITIONS = ref [(#"x",[Stack nil])];  (* defined functions *)

val _ = DEFINITIONS:=nil;


(* management of the function database *)

fun drop x nil = nil |

drop x ((y,z)::L) = if x = y then drop x L else ((y,z)::drop x L);

fun add x y L = (x,y)::(drop x L);

(* this is now safe. *)

fun find x nil = (say "Definition not found";nil) |

find x ((y,z)::L) = if x=y then z else find x L;

fun foundin x nil = false |

   foundin x ((y,z)::L) = if x = y then true else foundin x L;

(* the standard input buffer *)

val INSTREAM = ref [#"x"];

val _ =INSTREAM:=nil;

fun Tl nil = nil |

Tl [x] = [x] |

Tl x = tl x;

(* the file database *)

val FILES = ref 
[(#"a",[(TextIO.openOut("boojum.txt"),TextIO.openIn("boojum.txt"))])];

fun p1(x,y) = x; fun p2(x,y) = y;

val _ = (TextIO.closeOut(p1(hd(find #"a" (!FILES))));
TextIO.closeIn((p2(hd(find #"a"
(!FILES)))));FILES:=nil);

fun getstringto c nil = nil |

    getstringto c (x::L) = if x=c then nil else (x::(getstringto c L));

fun crest c nil = nil |

    crest c (x::L) = if x=c then L else crest c L;

val getquotestring = getstringto #"\"";

val quoterest = crest #"\"";

fun getprogram nil = (say "Close bracket missing";nil) |

   getprogram ((#"]")::L) = nil |

   getprogram ((#"[")::L) = 
   [#"["]@(getprogram L)@[#"]"]@(getprogram (programrest L)) | 

   getprogram ((#"\"")::L) = 
   [#"\""]@(getquotestring L)@[#"\""]@(getprogram (quoterest L)) |

   getprogram (x::L) = (x::(getprogram L))

and 

   programrest nil = nil |

   programrest((#"]")::L) = L |

   programrest ((#"[")::L) = programrest (programrest L) |

   programrest ((#"\"")::L) = programrest (quoterest L) |

   programrest (x::L) = programrest L;

fun first nil = nil |

first L = 

   if hd L = #"\"" then ((#"\"")::((getquotestring L)@[#"\""]))

   else if hd L = #"[" then ((#"[")::((getprogram (tl L))@[#"]"]))

   else if hd L = #"'" then if tl L = nil then 
(say "Character not identified";nil) else 
[hd L,hd(tl L)]
   else if hd L = #"`" then if tl L = nil then 
(say "Static opcode not identified";nil) else 
[hd L,hd(tl L)]

   else [hd L];

fun rest nil = nil |

rest L = if hd L = #"\"" then quoterest (tl L)

   else if hd L = #"[" then programrest (tl L)

   else if hd L = #"'" orelse hd L = #"`"
   then if tl L = nil then nil else (tl(tl L))

   else tl L;

fun boolhead ((Bool x)::L) = true |

    boolhead x = false;

val FILENAME = ref "";

fun openfile x ((Char c)::L) = (FILENAME:=(str c)^(!FILENAME);openfile x L) |

openfile x L = if (!FILENAME) = "" then say "No file name read!"

   else (if not(foundin x (!FILES)) then

   FILES:=add x [(TextIO.openOut((!FILENAME)),TextIO.openIn((!FILENAME)))](!FILES)

   else say "This character is already bound to a file";
   FILENAME:="");

fun restfile ((Char c)::L) = restfile L |

   restfile L = L;

fun help c = 

if c= "O" orelse c = "R" orelse c = "W" orelse c = "F" then say

("The basic file I/O commands are\n"^ 
"O  open a file: use first character on stack as file ID, then \n"^
"   use the rest of the characters as the name.  R read a character\n"^
"   from a file (ID read from top of stack.  Puts a boolean on top of the\n"^
"   stack:  if the character is not read, just \"false\"; if a character is\n"^
"   read it puts the character on then \"true\" on top.\n"^
"W write a character (second item) to a file ID (top).\n"^

"F closes a file (File ID on top of stack).\n"^

"R,W,F all crash if the file ID isn't found in the database.")

else if c = "t" orelse c = "f" then say

"t loads true onto the stack and f loads false onto the stack"

else if c = "M" orelse c = "m" then say

("M executes the file whose ID is on top of the stack.\n"^
"m writes the function on top of the stack to the file ID which\n"^
"is next on the stack.")

else if c = "s" then say

"Tests whether the data stack is empty"

else if c = "d" then say

"Replaces the data stack with its top element (a stack)"

else if c = "P" then say

"Puts the program stack (continuation) on the top of the stack"

else if c = "D" then say

"Discards the current program stack and executes the function on top of the stack"

else if c = "c" then say

("c is a type casting command:  toggles between integers and characters,\n"^
"applying modular arithmetic to convert large or negative integers.")

else if c = "C" then say

("C is a type casting command:  it toggles between characters and\n"^
"inert opcodes")

else if c = "t" orelse c = "T" orelse c = "U" orelse c = "V" then say

("The opcodes T,U,V implement environment functions useful for\n"^
"tracing.  T toggles the trace function on and off.  U gives the stack\n"^
"display.  V gives the current continuation (pending commands).\n\n"^

"In the shell, T turns trace off and t turns it on."

)

else if c = "b" orelse c = "X" then say

("In the shell b signals the beginning of a program:  it appears\n"^
"on the line before the program begins; X ends the program\n"^
"(appearing at the beginning of a line")

else if c = "L" orelse c = "S" then say

("L/S is a shell command:  load/save from/to the following filename (which\n"^
"should be separated by a single space from the L or S -- the extension\n"^
".sf will be supplied; S is also an opcode (copy the data stack to the top of itself)")

else if c = "l" then say

"This lists the current program in the shell"

else if c = " " orelse c = "\n" then say ("Whitespace is ignored, and plays\n"^
"no essential role in Pure False.  The r opcode will print a carriage\n"^
"return.\n\n"^

"Space appears as the opcode when opcodes or whole programs are\n"^
"being executed from the stack.")

else if c = "?" then say

("The ? opcode is a conditional construct.  Its first argument\n"^
"(second in stack) is boolean and if it is true the second argument\n"^
"(a function on top of the stack) is executed and otherwise discarded")

else if c = "#" then say

("The # opcode is a loop construct.  The top function is the body and\n"^
"the second function on the stack is the test.  The test is run first;\n"^
"as long as the test leaves a (consumed) truth value of true on\n"^
"top of the stack the body will be repeated.  A truth value of false\n"^
"causes the body to be discarded.  A non-truth value crashes.")

else if c = "!" then say

("The function at the top of the stack is unpacked and placed\n"^
"on top of the stack.  This is intended to serve as function\n"^
"application, but it is more general.")

else if c = "`" then say

("This is a pseudo-opcode.  For any character X, `X is effectively\n"^
"another character with the meaning [X] (a function with X in it).\n"^
"This provides an inert form in which opcodes can be inserted into\n"^
"functions by the o command.  Totally different from False.  When\n"^
"executed this item is put on the stack.")

else if c = "'" then say

("This is a pseudo-opcode.  'X is the character X.  (push this\n"^
"on the stack)")

else if c = "n" then say

("This is the empty stack considered as a program:  push it\n"^
"onto the stack.")

else if c = "p" then say

("This is a new capability in Pure False:  the top item on the\n"^
"stack is pushed into the second item on the stack (a function)\n"^
"(as first item).  This allows a theoretically interesting bit\n"^
"of function editing (along with the o command)\n"^
"Both arguments are removed and replaced with the result.")

else if c = "o" then say

("The first and second elements of the stack, functions,\n"^
"are composed (the first one to be done first), removed from\n"^
"the stack and replaced with the composition.  In combination\n"^
"with the p command, a theoretically interesting degree of\n"^
"function editing is obtained.")

else if c = "%" then say

"Drop the top element from the stack"

else if c = "\\" then say 

"Swap the top two elements of the stack"

else if c = "@" then say

"Rotates third element of the stack to the top:  xyz->zxy"

else if c = "$" then say

"Duplicate the top element of the stack"

else if c = "0" orelse c = "1" orelse c = "2" orelse c = "3"
orelse c = "4" orelse c = "5" orelse c = "6" orelse c = "7"
orelse c = "8" orelse c = "9" orelse c = "_"

then say 

("Each decimal digit is an opcode, loading that integer on the stack\n"^
"As in Befunge, Pure False does not support multi-digit decimal\n"^
"integers directly in programming:  the operation _ (add the top of the stack\n"^
 "to ten times the second element) enables this.  Also as in False there is \n"^
"no integer input command.")

else if c = "^"

then say

("This is character input:  a single character from standard input\n"^
"is placed on the stack.  This is the only primitive input command.\n\n"^

"Input is buffered:  you can type as many characters as you like\n"^
"at the input prompt >> and the program will accept these as needed.\n"^
"The ) command clears this buffer of any unused characters.")

else if c = "," orelse c = "." orelse c = "r" orelse c = "q"

then say

("There are four output commands.  , prints (and consumes) the\n"^
"character on the stack.  . prints (and consumes) the integer on\n"^
"the stack.  Integer output can be multi-digit (impure but\n"^
"convenient) and is preceded by a space.\n"^
"Type errors cause crashes.  q prints a quote and r\n"^
"effects a carriage return.\n\n"^

"in the shell, q means quit")

else if c = "+" orelse c = "-" orelse c = "*" orelse c = "/"

then say

("These are the usual integer arithmetic operations.  Two items\n"^
"are popped off the stack and operated on and replaced with the\n"^
"result (the second item on the stack is first argument)\n\n"^

"Support for additional operations (unary minus and mod) is likely\n"^
"to be added.  Integers are expected:  type errors cause crashes.")

else if c = "=" orelse c = "<" orelse c = ">"

then say

("Comparison operators:  overloaded to compare integers to each other\n"^
"or characters to each other.  Type errors stop the show.  Two arguments\n"^
"are popped off the stack, compared and replaced with the appropriate\n"^
"truth value.\n\n"^

"Functions can also be compared (dangerous):  in this case\n"^
"the arguments are not consumed!")

else if c = "~" orelse c = "&" orelse c = "|" orelse c = "~"

then say

("Logical operations.  ~ is logical negation (unary) and the  others\n"^
"are binary.  The appropriate number of arguments, which must be\n"^
"truth values, is popped off the stack and replaced with the result.")

else if c = ":" orelse c = ";"

then say

("Each character can be used as a variable.  Only functions can\n"^
"be assigned as variable values (though it is easy to hack around this\n"^
"with the help of p and o).  : takes two arguments:  the top of the\n"^
"stack is a character (one must use ' to address a specific character\n"^
"literally, not as in False) and the second item on the stack is a function\n"^
"which is bound to that variable.  Both are discarded.  ; takes one\n"^
"argument, a character (consumed):  the associated function is unpacked onto the\n"^
"stack and executed (it does not need to be applied with !)")

else if c = ")"

then say 

("This command flushes the ML output buffer and the interpreter's\n"^
"input buffer.")

else if c = "\""

then say

("Characters enclosed in quotes are printed to standard output\n"^
"and discarded.  The Hello, world function is \"Hello, world\"!\n\n"^
"The r command allows printing of a quote; returns in strings\n"^
"are allowed by Pure False but difficult to produce in ML.\n"^
"The q command allows printing of a double quote")

else if c = "["

then say

("Characters enclosed in brackets are a function (a stack placed\n"^
"on the stack).  Brackets can be nested.  The ! command executes\n"^
"a bracketed function (removes it from the stack, unpacks it\n"^
"and places all its contents on the stack).  Some other commands\n"^
"can do this as well (? # ;).  The p and o commands allow manipulation\n"^
"of functions, which was not supported in False.")

else if c = "i" orelse c = "j" orelse c = "x"

then say

("i allows execution of one step in the function on the top of the\n"^
"stack:  remove the function from the stack, supply the top element\n"^
"to the stack and execute, then replace the tail of the function;\n"^
"of course this also allows functions with data in them to serve\n"^
"as list data structures.  j is a static version:  put the head of\n"^
"the function on in a 1-element list, then put the tail of the function on.\n"^
"x tests the function on top of the stack to see if it is empty\n"^
"(note that underflow is a show-stopper!); x does not remove the function,\n"^
"just adds the truth value concerning its emptiness or lack thereof.")

else if c = "{"

then say

"Comments begin with { and end with }.  They may be nested and multi-line."

else say

("No help available on "^c);

(* this should produce a standard expanded form of a term
without embedded program text (with one exception) *)

fun notextitem [#"'",x] = Char x |

  notextitem [#"`",x] = if ord(x) >= ord (#"0") andalso ord(x) <= ord(#"9")
     then Stack[Int (ord(x)-ord(#"0"))] else Stack[OpCode (x)] |

  notextitem [x] = if ord(x) >= ord (#"0") andalso ord(x) <= ord(#"9")
     then Int (ord(x)-ord(#"0")) else OpCode x |

  notextitem (#"["::L) = Stack(notextlist(rev(tl(rev L)))) |

  notextitem (#"\""::L) = Stack([Program(#"\""::L)]) | (* no other representation for this! *) 

  notextitem x = Char (chr 0) 

and notextlist nil = nil |

notextlist (#" "::L) = notextlist L |

notextlist (#"\n"::L) = notextlist L |

notextlist L = (notextitem(first L))::(notextlist(rest L))

and notextlist2 ((Program L)::M) = (notextlist L)@(notextlist2 M) |

notextlist2 ((Stack L)::M) = (notext(Stack L))::(notextlist2 M) |

notextlist2 (x::M) = x::(notextlist2 M) |

notextlist2 nil = nil 

and notext (Stack L) = Stack(notextlist2 L) |

notext T = T;

   

     



val TRACE = ref true;

val PAUSE = ref true;

fun settrace() = TRACE:=true;

fun setnotrace() = TRACE := false;

fun setpause() = PAUSE:=true;

fun setnopause() = PAUSE:=false;

fun show code L = if (!TRACE) then (TextIO.output(TextIO.stdOut,
"\n opcode:  "^(str code)^"\n\n stack:  "^(listdisplay L)^"\n\n");TextIO.flushOut(TextIO.stdOut);
if (!PAUSE) then 
INSTREAM:=((String.explode(TextIO.inputN(TextIO.stdIn,1)))@(!INSTREAM))
else ();
L)

else L;

   
fun (* ignore all whitespace *) 

Execute (#" "::P) L = Execute P L |

Execute (#"\n"::P) L = Execute P L |

(* two kinds of executables on the stack:  program text
objects and opcodes. *)

(* program text objects could be constructed out of opcodes
but in practice are not.  The distinction is usually transparent,
except for equality *)

(* reorganization of text program structures *)

Execute P ((Stack((Program nil)::L))::M) = Execute P ((Stack L)::M) |

(* Execute P ((Stack((Program [x])::L))::M) = Execute  P 
((Stack((OpCode(x))::L))::M) | *)

(* Execute P ((Stack((Program L)::(Program M)::N))::S) =

   Execute P ((Stack(Program (L@M)::N))::S) | *)

(* opcodes and program text on stack -- introduced by application *)

Execute P ((OpCode x)::L) = Execute (x::P) (show (#" ")L) |
Execute P ((Program Q)::L) = Execute (Q@P) (show (#" ")L) |

(* finished with program *)

Execute nil L = show (#" ")L |  


(* control structures *)


(* this is the original False conditional;
just take out the brackets around tests and current
programs ought to work *)

(* it's much simpler... *)

Execute (#"?"::P) ((Stack y)::(Bool true)::L) =

   Execute (#"!"::P) (show (#"?")((Stack y)::L)) |

Execute (#"?"::P) ((Stack y)::(Bool false)::L) =

   Execute P (show (#"?") L) |

(* the loop construction -- notice that the pending
future executions are now on the program stack *)

Execute ((#"#")::P) ((Stack y)::(Stack x)::M) =

      Execute 
       (#"!"::
        (String.explode(
           display(
             Stack(y@
               [Stack x]@
               [Stack y]@
               [Program [#"#"]])))@
        [#"?"]@
        P))
       (show (#"#") ((Stack x)::M)) |


(* application *)

Execute (#"!"::P) ((Stack M)::L) = (Execute P (show(#"!")(M@(L)))) |

(* inert forms of opcodes *)
(* something needs to be done with iterated ` and `'s followed by ' *)

(* answer:  ` should not be iterated:  it is strictly used to
put active opcodes in inert form:  `x is synoymous with [x]
only for single characters (and this is only meaningful if
x is an opcode)  *)

(* deferred crashes can be caused by misuse of `, since the system
does not check for meaningfulness of such opcodes *)

Execute (#"`"::x::P) L = if ord(x)>=ord(#"0") andalso ord(x)>=ord(#"9")

then (Execute P (show(#"`")(Stack [Int (ord(x)-ord(#"0"))]::(L))))

else (Execute P (show(#"`")(Stack [OpCode x]::(L)))) |

(* character constants *)

Execute (#"'"::x::P) L = (Execute P (show(#"'")(Char x::(L)))) |

(* the empty stack *)

Execute (#"n"::P) L = (Execute P (show(#"n")(Stack nil::(L)))) |

(* add to stack at front *)

Execute (#"p"::P) (x::(Stack M)::L) = (Execute P (show(#"p")((Stack (x::M))::(L)))) |

(* compose stacks -- needed to add opcodes at front *)

(* this is analogous to ! in a certain sense *)

Execute (#"o"::P) ((Stack L)::(Stack M)::N) = (Execute P (show(#"o")(Stack ((L)@M)::N))) |

(* executes first command in a function; also implements hd, tl *)

(* needs to dissect text program items *)

(* contrary to misinformed comments above, i can be used to
implement trace *)

Execute (#"i"::P) ((Stack ((Program L)::N))::M) =
Execute ((String.explode(display(Stack (((Program(rest L))::N)))))@P) 
(show(#"i")
((Program(first L))::M)) |

(* this is a static [hd]/tl operation; it is needed to avoid the
peculiar effects of popping opcodes *)

(* there should be an underflow error exception for j; there is none
for i because an empty stack is simply a skip command and disappears
when executed. I think there is for i now, too *)

Execute (#"j"::P) ((Stack ((Program (x::L))::N))::M) = Execute P 
(show (#"j")(( 
(Stack ((Program(rest (x::L)))::N)))::(Stack [Program(first (x::L))])::M)) |

Execute (#"i"::P) ((Stack (y::N))::M) = Execute (
(String.explode(display(Stack N)))@P)
(show (#"i") ((Stack[y])::M)) |

Execute (#"j"::P) ((Stack (y::N))::M) = Execute P 
(show (#"j")((Stack N)::(Stack [y])::M)) |

Execute (#"x"::P) ((Stack M)::L) = Execute P 
(show(#"x")(Bool(M=nil)::(Stack M)::L)) |

(* drop *)

Execute (#"%"::P) ((y::L)) = (Execute P (show(#"%")((L)))) |

(* swap *)

Execute (#"\\"::P) ((x::y::L)) = (Execute P (show(#"\\")((y::x::(L))))) |

(* swap with third item -- changed back to rot in False *)

Execute (#"@"::P) ((x::y::z::L)) = (Execute P (show(#"@")(z::x::y::(L)))) |

(* numerical constants -- limited as in Befunge *)

Execute (#"$"::P) (x::L) = (Execute P (show(#"$")(x::x::L))) |

Execute (#"0"::P) L = (Execute P (show(#"0")(Int 0::L))) |

Execute (#"1"::P) L = (Execute P (show(#"1")(Int 1::L))) |

Execute (#"2"::P) L = (Execute P (show(#"2")(Int 2::L))) |

Execute (#"3"::P) L = (Execute P (show(#"3")(Int 3::L))) |

Execute (#"4"::P) L = (Execute P (show(#"4")(Int 4::L))) |

Execute (#"5"::P) L = (Execute P (show(#"5")(Int 5::L))) |

Execute (#"6"::P) L = (Execute P (show(#"6")(Int 6::L))) |

Execute (#"7"::P) L = (Execute P (show(#"7")(Int 7::L))) |

Execute (#"8"::P) L = (Execute P (show(#"8")(Int 8::L))) |

Execute (#"9"::P) L = (Execute P (show(#"9")(Int 9::L))) |

Execute (#"_"::P) ((Int m)::(Int n)::L) =

     Execute P (show (#"_") ((Int(intfix((multiply 10 n) + m)))::L)) |

(* character input *)

(* I took out the prompt:  this is easily provided by the user *)

Execute (#"^"::P) (L) = (Execute P (show(#"^")(

Char(if (!INSTREAM) <> nil then let val A = hd (!INSTREAM) in
(INSTREAM:=tl(!INSTREAM);A) end else
(TextIO.flushOut(TextIO.stdOut);
INSTREAM:=(rev(Tl(rev(((String.explode(TextIO.input(TextIO.stdIn))))))))@
(!INSTREAM);let val A = hd (!INSTREAM) in
(INSTREAM:=tl(!INSTREAM);A) end))
::L))) |

(*  character output *)

Execute (#","::P) (Char x::L) = 
((TextIO.output(TextIO.stdOut,str x);Execute P (show(#",") L))) |

(* integer output *)  (* this is impure but easy *)

Execute (#"."::P) (Int x::L) = 
((TextIO.output(TextIO.stdOut," "^makestring x);Execute P (show(#".") L))) |

(* print a carriage return *)

Execute (#"r"::P) L = (TextIO.output(TextIO.stdOut,"\n");Execute P (show(#"r") L)) |

(* print a quotation mark *)

Execute (#"q"::P) L = ((TextIO.output(TextIO.stdOut,"\"");Execute P (show(#"q") L))) |

(* arithmetic *)

(* intfix converts everything to mod 200000000 and makes numbers
greater than 100000000 negative; this averts overflow.  For
multiplication, a special function is needed to make this safe. *)

Execute (#"+"::P) ((Int y)::(Int x)::L) = (Execute P (show(#"+") 
   ((Int(intfix(x+y)))::L))) |

Execute (#"*"::P) ((Int y)::(Int x)::L) = (Execute P (show(#"*")
    ((Int(multiply x y))::L))) |

Execute (#"-"::P) ((Int y)::(Int x)::L) = 
    (Execute P (show(#"-")((Int(intfix(x-y)))::L))) |

Execute (#"/"::P) ((Int y)::(Int x)::L) = 

if y=0 then (say "Division by zero";show(#" ")((Int y)::(Int x)::L))else
(Execute P (show(#"/")((Int(intfix(x div y)))::L))) |

(* arithmetic tests *)

Execute (#"="::P) ((Int x)::(Int y)::L) = (Execute P (show(#"=")((Bool(x = y))::L))) |

Execute (#"<"::P) ((Int y)::(Int x)::L) = (Execute P (show(#"<")((Bool(x < y))::L))) |

Execute (#">"::P) ((Int y)::(Int x)::L) = (Execute P (show(#">")((Bool(x > y))::L))) |

(* character tests *)

Execute (#"="::P) ((Char x)::(Char y)::L) = (Execute P (show(#"=")((Bool(x = y))::L))) |

Execute (#"<"::P) ((Char y)::(Char x)::L) = (Execute P (show(#"<")((Bool(x < y))::L))) |

Execute (#">"::P) ((Char y)::(Char x)::L) = (Execute P (show(#">")((Bool(x > y))::L))) |

(* function equality test:
note that arguments are not consumed! *)

(* the effects of the usually transparent Program construction
(programs from text) are visible to = at the moment; I suppose I
could fix this but one should not expect an equality operator
on programs to work! *)

(* the notext function should make this honest *)

Execute (#"="::P) ((Stack N)::(Stack M)::L) = 
(Execute P (show(#"=")(((Bool(notextlist2 N=notextlist2 M))
::(Stack N)::(Stack M)::L)))) |

(* logic *)

Execute (#"t"::P) L = Execute P (show (#"t")((Bool true)::L)) |

Execute (#"f"::P) L = Execute P (show (#"f")((Bool false)::L)) |

Execute (#"~"::P) ((Bool x)::L) = (Execute P (show(#"~")((Bool(not(x)))::L))) |

Execute (#"&"::P) ((Bool x)::(Bool y)::L) = (Execute P (show(#"&")((Bool(x andalso y))::L)))
|

Execute (#"|"::P) ((Bool x)::(Bool y)::L) = (Execute P (show(#"|")((Bool(x orelse y))::L))) |

Execute (#"="::P) ((Bool x)::(Bool y)::L) = (Execute P (show (#"=")
                ((Bool(x=y))::L))) |

(* casting *)

(* character/integer *)

Execute (#"c"::P) ((Int x)::L) = Execute P 
   (show (#"c")((Char (chr(x mod 256))::L))) |

Execute (#"c"::P) ((Char x)::L) = Execute P
   (show (#"c")((Int(ord x))::L)) |

(* character/opcode *)

Execute (#"C"::P) ((Char x)::L) = 
   
   if ord(x)<= ord(#"0") andalso ord(x)>=ord(#"9")

   then Execute P (show (#"C")((Stack([Int (ord(x)-ord(#"0"))]))::L))

   else Execute P (show (#"C")((Stack([OpCode x]))::L)) |

Execute (#"C"::P) ((Stack([OpCode x]))::L) = Execute P (show (#"C")((Char x)::L)) |

(* Dangerous machine manipulations:  access and manipulate the data stack
and program stack (!) as objects *)

(* data stack access *)

(* is the data stack empty? *)

Execute (#"s"::P) L = if L = nil then Execute P (show (#"s")((Bool true)::L))

    else Execute P (show (#"s")((Bool false)::L)) |

(* get the data stack as an object *)

Execute (#"S"::P) L = Execute P (show (#"S")(Stack(L)::L)) |

(* replace the data stack with its top element *)

Execute (#"d"::P) ((Stack M)::L) = Execute P (show (#"d") M) |

(* program stack access *)

(* P and D together allow something like continuations *)

(* get the program stack as an object *)

Execute (#"P"::P) L = Execute P (show (#"P")(Stack([Program P])::L)) |

(* replace the program stack with the function on top of the stack *)

(* 12=nD is "stop"! *)

(* note that before D is executed, all opcodes and program texts
on the data stack have already been put into the program stack;
so the program text/opcode distinction is still transparent *)

Execute (#"D"::P) L = Execute [#"!"] (show (#"D") L) |

(* indirection:  only function definitions are allowed *)

Execute (#":"::P) ((Char x)::(Stack y)::L) = ((DEFINITIONS := add x y (!DEFINITIONS);
                               Execute P (show(#":") L))) |

Execute (#";"::P) ((Char x)::L) = (Execute (#"!"::P) (show(#";")(Stack (find x (!DEFINITIONS))::L))) |

(* flushes input and output streams *)

Execute (#")"::P) L = (TextIO.flushOut(TextIO.stdOut);INSTREAM:=nil;
                         Execute P  (show(#")") L)) |


(* file I/O *)

(* open a file *)

Execute (#"O"::P) ((Char x)::L) = 

(if foundin x (!FILES) then (say "File already exists";show (#" ") L)

else (openfile x L; if not(foundin x (!FILES)) then (say"File not created";

show (#" ") L) else (Execute P (show (#"O") (restfile L))))) |

(* read a character of input from a file *)

Execute (#"R"::P) ((Char x)::L) =

if not(foundin x (!FILES)) then (say "File not found";show (#" ") L)

else let val A = (TextIO.flushOut(p1(hd(find x (!FILES))));
TextIO.inputN(p2(hd(find x (!FILES))),1))

in if A = "" then (Execute P (show (#"R")((Bool false)::L)))

else Execute P 
(show (#"R")((Bool true)::(Char(hd(String.explode A)))::L)) end |

(* write a character of output to a file *)

Execute (#"W"::P) ((Char x)::(Char y)::L) =

if not (foundin x (!FILES)) then (say "File not found";show (#" ") L)

else (TextIO.output(p1(hd(find x (!FILES))),str y)

         ;Execute P (show (#"W")L)) |

(* close file *)

Execute (#"F"::P) ((Char x)::L) =

     if not(foundin x (!FILES)) 
     then (say "File not found to close";show #" " L)
     else (TextIO.closeOut(p1(hd(find x (!FILES))));
     TextIO.closeIn(p2(hd(find x (!FILES))));
     FILES := drop x (!FILES); Execute P (show (#"F") L)) |

(* execute a file *)

Execute (#"M"::P) ((Char x)::L) = 

if not(foundin x (!FILES)) then (say "File not found";show (#"M") L)

else (TextIO.flushOut((p1(hd(find x (!FILES)))));

Execute ((String.explode(TextIO.input(p2(hd(find x (!FILES))))))@P)

   (show (#"M") L))  |

(* write a function to a file *)

Execute (#"m"::P) ((Stack M)::(Char x)::L) =

if not (foundin x (!FILES)) then (say "File not found";show (#"m") L)

else (TextIO.output(p1(hd(find x (!FILES))),listdisplay M);

   Execute P (show (#"m") L)) |

Execute (#"\""::P) L = (TextIO.output(TextIO.stdOut,implode(map str (getquotestring P)));
                        Execute (quoterest P) (show(#"\"") L)) |

Execute (#"["::P) L = Execute (programrest P) 
(show (#"[")(Stack[Program(getprogram P)]::L)) |

(* toggle the trace feature *)

Execute (#"T"::P) L = (TRACE := not(!TRACE);PAUSE:=not(!PAUSE);Execute P L) |

(* display the stack *)

Execute (#"U"::P) M = (say (listdisplay M);TextIO.flushOut(TextIO.stdOut);
   Execute P M) |

(* display the current continuation *)

Execute (#"V"::P) M = (say (implode (map str P)); Execute P M) |

Execute (#"h"::P) ((Char c)::L) = (help (str c);Execute P L) |

Execute (x::P) L = ((TextIO.output(TextIO.stdOut,"\n\nStopped (usually due to type errors)\n\n");(show x L)));

(* the preprocessing idea is interesting in theory but not practical
(exponential blowup happens with nesting of brackets) and in any
case this version does not work.

(* handle [] and "..." using preprocessor? *)

(* first argument asks whether we are in a string, second
asks whether we are already reading inside a bracket *)

fun preprocess1 b1 b2 nil = nil |

preprocess1 false false ((#"[")::(#"]")::L) = preprocess1 false false (#"n"::L) |

preprocess1 false true ((#"[")::(#"]")::L) = L |

preprocess1 false b ((#"[")::(#"[")::L) =

preprocess1 false b ((#"[")::(preprocess1 false false ((#"[")::L))) |

preprocess1 false b ((#"[")::(#"\"")::L) =

preprocess1 false b ((#"[")::(preprocess1 false false ((#"\"")::L))) |

preprocess1 false false ((#"[")::(#"'")::x::L) =

((#"n")::(#"'")::x::(#"p")::(preprocess1 false true ((#"[")::L))) |

preprocess1 false true ((#"[")::(#"'")::x::L) =

((#"'")::x::(#"p")::(preprocess1 false true ((#"[")::L))) |

preprocess1 false false ((#"[")::(#"`")::x::L) =

((#"n")::(#"`")::x::(#"p")::(preprocess1 false true ((#"[")::L))) |

preprocess1 false true ((#"[")::(#"`")::x::L) =

((#"`")::x::(#"p")::(preprocess1 false true ((#"[")::L))) |

preprocess1 false false ((#"[")::x::L) =

((#"n")::(#"`")::x::(#"o")::(preprocess1 false true ((#"[")::L))) |

preprocess1 false true ((#"[")::x::L) =

((#"`")::x::(#"o")::(preprocess1 false true ((#"[")::L))) |

preprocess1 false b ((#"\"")::L) = preprocess1 true b L |

preprocess1 true b ((#"\"")::(#"\"")::L) = preprocess1 false b L |

preprocess1 true b ((#"\"")::x::L) = ((#"'")::x::(#",")::(preprocess1 true b L)) |

preprocess1 b1 b2 (x::L) = x :: (preprocess1 b1 b2 L);

(* if I've got the dynamics of this straight, the previous
function stops after it hits the closing bracket matching the first
opening bracket, so it is necessary to repeat this function *)

fun preprocess L = let val M = preprocess1 false false L in

if L = M then L else preprocess M end;

END preprocessor abandoned *)

(* we need a preprocessor with the less ambitious aim of
removing comments *)

(* our aim is to use the form {...} and allow nested comments *)

fun decomment nil = nil |

   decomment (#"{"::L) = crest (#"}") (decomment L) |

   decomment (x::L) = x::(decomment L);

(* the interpreter *)

fun execute s = (Execute (decomment (String.explode s)) nil;
                say "\n\n");

(*  examples

execute "[r\"done?  >>\"^)'y=~r][[\"input the first\"r\">>\"^)r\"input the second\"r\">>\"^)r=$]!['y,]?[~]!['n,]?]#";

(* stack has two or   more elements (test) *)

{if the stack has no elements, add a t}[s~][t]?
{check for the t}[][Sjx~]?

execute "[[[s~]![t]?[]![Sjx\\%\\%~]?][+]#]'x:";
[[[s~][t]?[][Sjx\%\%~]?][+]#]'x:
execute"123456789876543'x;.";


execute "'t'e's't'3'yO't'e's't'i'n'g'yW'yW'yW'yW'yW'yW'yW['yR][]#";


execute ")^$,r^$,r[=$]['yrr,]?[~]['nrr,]?";

execute ")1$.[$$=][1+$.]#";

(* 'e computes powers of two recursively with the help
of the combinator 'a *)


execute"[$1[=$]![2@%]?[~]![1-'e;$+]?]'e:";
$

x 1 1

@

1 1 x

$

1 1 x x 

@

1 xx 1

\

1 x 1 x

execute "[1'a;=$[1.]?~[%2'a;=$[1.]?~[%1-$'f;\\1-'f;+.]]]'f:";

(* this inputs a digit (~1 signals error) *)

execute "[01-)rr\">>  \"^[$'0=]![%0'x]?[$'1=]![%1'x]?[$'2=]![%2'x]?[$'3=]![%3'x]?[$'4=]![%4'x]?[$'5=]![%5'x]?[$'6=]![%6'x]?[$'7=]![%7'x]?[$'8=]![%8'x]?[$'9=]![%9'x]?%[$01-=~]![\\%]?]'d:";

execute ")[02-[$01-=~]['d;]#%0[\\02-=~][\\25**+]#]'#:";

*)




(* barebones native programming environment:  we need to be able
to enter programs at the command line and turn trace on and off. *)

(* saving the current program to a file would be nice *)

(* loading a program from a file would be nice *)

val PROGRAM = ref "";

fun env0 file = (

let val s = String.explode (readline file) in
((* say ((implode (map str s))^"\n\n"); *)
(* ignore lonely returns *)

if s=nil orelse hd s = #"\n" then env0 file

(* quit *)

else if hd s = #"q" then ()

(* load from a file *)

else if hd s = #"L" then 

(let val S = implode(map str (rev(tl (rev(tl (tl (s)))))))

in let val F = TextIO.openIn(S^".sf") in (env0 F;TextIO.flushOut(TextIO.stdOut);TextIO.closeIn(F)) end end;env0 file)

(* execute a program *)

else if hd s = #"b"

then (PROGRAM:=readlines file;execute (!PROGRAM);say "Done";
TextIO.flushOut(TextIO.stdOut);env0 file)

(* trace on and run the program *)

else if hd s = #"t" 

then (setpause();settrace();execute(!PROGRAM);say "Done";TextIO.flushOut(TextIO.stdOut);env0 file)

(* trace off and run the program *)

else if hd s = #"T" 

then (setnopause();setnotrace();execute(!PROGRAM);say "Done";TextIO.flushOut(TextIO.stdOut);env0 file)

(* list the current program *)

else if hd s = #"l"

then (say(!PROGRAM);TextIO.flushOut(TextIO.stdOut);env0 file)

else if hd s = #"S" 

then (let val S = implode(map str (rev(tl (rev(tl (tl s))))))

in let val F = TextIO.openOut(S^".sf") in (TextIO.output(F,"b\n\n"^(!PROGRAM)^"\n\nX\n\nq\n\n")
;TextIO.flushOut(F);TextIO.closeOut(F)) end end;env0 file)

else if hd s = #"?" then (help (str(hd(tl s)));TextIO.flushOut(TextIO.stdOut))


else env0 file )end)

and readline file = let val c = TextIO.inputN(file,1) in

   if c = "\n" then "\n"

   else c^(readline file) end

and readlines file = let val S = readline file

in

if S="" orelse hd (String.explode (S)) = #"X" then ""


else (S^(readlines file))
 
end;

fun env() = env0 (TextIO.stdIn);

(* a different environment *)

val THESTACK = ref [OpCode #"p"];

val _ = THESTACK:=nil;

val TRACE2 = ref true;

fun getlines() = let val A = String.explode(TextIO.input(TextIO.stdIn))

in if hd A = #"X" then nil else A@(getlines()) end;

fun env2() = (THESTACK:=Execute (decomment(getlines())) (!THESTACK);
if (!TRACE2) then say ("["^(listdisplay(!THESTACK))^"]") else ();TextIO.flushOut(TextIO.stdOut);
env2();());

(* trace utility:

trace execution of the function on top of the stack:

"[[x~]{while it is not empty}[i"the stack:"rUr"the continuation:"rVr]#!]'t:"

*)










