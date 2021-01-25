# All rights reserved by M. Randall Holmes, the author, 2018.  You are allowed
# to use the file and even modify it for any noncommercial purpose, but this
# notice  must be preserved.

# Python version of Marcel -- 12/26/2018

import os

def versiondate():
    print('\n   Version of 12/26/2018 5:30 PM  \n   \
    Serious debugging 12/26 \n \
    Restricted sets separated from unrestricted. \n \
    Uses native interface. \n \
    HLPR pages through all available help. \n \
    ?(name of command) will give help on a command.\n')

# working on Beeson definitions for INF proof.  One bug fixed so far:
# the free variable check in bodies of definitions of binary ops was missing

# 12/30 improved understanding of the behavior of substitute. I had
# a delusion that there was a problem with Python list equality causing
# me to have to use equality of printed forms of terms in substitution:
# in fact, what was happening was that printing the terms was performing
# needed updates to the next object index in quite special situations.
# I am still trying to debug a time leak in an instance of SU.

# 12/26 introduces an atomic name for the unique witness when applying rules for THE.
# This should make proofs about definite descriptions easier to navigate.  It is suggested
# that one immediately use the atomic name and equality rules to eliminate the description
# (except from the equation defining the atomic name) at the appropriate moment.
# corrected error in detection of bad numeral arguments.  A further correction to the distinction
# between restricted and unrestricted sets.  Fixed bug in restricted existential quantifier left rule.
# Fixed another bug in complex binders, applying to both flavors on both sides.  Testing is needed
# of complex functions of the prover!

# Note that a new definite description operator THER for restricted descriptions is a formal
# possibility.

# 12/25 Identified embarrassing slowness error:  made strip iterative
# and things run much faster.  Look for other recursion issues?

# 12/24:  made it impossible to go into OC2 mode when in constructive mode.

# 12/23 This version is a test of separation of sets from restricted sets.
# This version, if it works correctly, makes restricted sets a different sort
# of object from unrestricted sets, with a different membership relation, and preserves
# nice deep structure for the restricted universal quantifier.  There
# is now a distinct membership relation INR in restricted sets,
# and distinct restricted quantifiers AR and ER.  This does mean
# that restricted and unrestricted binders need to be defined separately.

# 12/23 LP now logs to native interface and DEM works nicely.
# a possible improvement would be to get DEM to echo native interface
# commands rather than Python console commands, but it works.

# 12/22 working on native interface scripting.

# stability and interface mnemonic fixes

# semantics of restricted sets:  think of sets as three valued functions
# with values 0,1,2  x E a is a(x) = 1  {x E a | P(x)} has value 2
# outside of a, value 1 at elements x of a such that P(x) and otherwise
# value 0.  d is the domain of a iff {x E d : x E a} = a. The system
# does successfully see {x : P(x)} as the same as {x IN univ : P(x)}.
# Pure NF can be achieved by postulating a bijection between the universe
# and the sets of universal domain.

# the reason for the curious nature of restricted sets is the desire to
# retain the nice definition of the universal quantifier as a function
# acting on sets; this requires that the domain be a feature of the set.

# It is also an interesting point semantically that the logic of Marcel
# has functions as primitive (without any information as to what functions
# might be sets, restricted or otherwise), without any assumptions about
# pairs.  It is a theorem, which it might be amusing to prove, that if all
# functions are sets, the universe is infinite.

# Another semantic point to explore in the coming paper is exactly
# how accurate it is to say that NFU* is implemented here.

# 5:30 PM 12/20/2018:  most commands are installed in the native interface
# and equipped with help, with cross references between Python functions
# and native interface mnemonics.

# 530 PM laptop home working on improving interface to support trinket version
# added a much larger subset of the user commands to the interface.  There
# are still more to be added, but the interface is now far more capable.
# Note that SP1, used to supply an extra string argument to the
# precedence changing commands, can also be used to supply extra string
# arguments to other commands.

# 12/19 eliminated dots from syntax entirely.  They had perverse effects
# in the native interface.  Spaces are used.

# 12/19  Trinket doesnt like recursion in the definition of the function
# which constructs comments. inserthash0 is the offending function, it should
# be made iterative.

# for teaching purposes, it is useful to have automatic declaration;  this is
# now installed.  A-O automatically give object output, P-Z prop output.
# Special character operators are not automatically declared.

# The interface extension needs testing.  It also needs a native help
# command.

# Documentation for the online manifestation is needed.

# I want to allow multiple commands on one line in the internal shell
# (semicolon terminated seems reasonable)

# 9/14/2018 Alternative set of premise/conclusion permutation
# commands glt, gltE, grt which just bring nth item to front or second
# position without rotation.

# 9/12/2018 For teaching purposes, set the default to Oneconclusion2:
# alternative conclusions do actually become negative premises treated like
# any other premises.  Set the display to show the virtual _|_ absurd
# conclusion if there are no conclusions under Oneconclusion2 as well.
# Report here on how this works?  Note that the gr command becomes redundant.
# There is a further thought that a virtual gr command might be possible
# under oneconclusion2:  just a command that moves a negative premise
# to the conclusion in a suitable sense could be useful.  Old version is saved
# as pythonmarcel-9-12-18.py

# 2/20/2017 There is a subtle issue with getting full NFU*, which would
# be solved if there were a built in Hilbert symbol (AN?) or if one could
# make definitions involving constants.  Definitions involving constants
# might be entertaining, but they would complicate maxindex and operate
# completely poisonously relative to Rf.

# 2/18/2017 Fine-tuned the marginalize function.  Rationalized the case of restricted quantifiers with
# a variable as left term of the complex binder.  Should I suitably modify the definition of free variables?

# 2/17/2017 We have margin control, using a SetMargin command to set the margin (default 50).
# The margin control functions are for the moment called only by printsequent, but this is the
# function most likely to produce vast output.

# 2/17/2017 Snapshot() command will log current sequent display to the log.
# LogTheProof() will log the proof of the current sequent to the log.
# Showthm will automatically log the display of the theorem to the log.
# This recovers the degree of reportage to the log found in the ML version.

# 2/17/2017 added some keys to the interface.  Interface is now
# exited with 'quit';  enter key is Look(). Fixed pl and pr so that they
# have sensible relation to line numbering, and made them user commands.

# 2/17/2017  worked on a tiny interface with single key commands.
# also, installed better reporting from commands which generate declarations.

# 2/15/2017 any unary operator may be applied to a class, giving badobject or badprop as appropriate,
# to support definite descriptions.  Testing suggests that this works.  Further restricted
# to unary operators with precedence 0.  This gives unary operators with precedence 0 a special
# semantic role (they are already syntactically viewed as "binders").  At noon, added user
# commands to declare and define binders.

# 2/14/2017 experimentally installing substitution of classes for variables in definitions.  This doesn't
# appear to trash existing scripts, but whether it works is an interesting question.
# Testing suggests that this works.  Classes may now appear to the right of IN as well as as arguments
# of suitable unary operators.  They cannot replace instantiables but they may replace parameters in definitions,
# as long as the parameters appear only in appropriate contexts.  This allows definition of quantifiers which
# can be applied to unstratified propositions:  for example, I tested the ONE uniqueness quantifier. The rules
# for IN work correctly with classes, no extra work required.  What we have is not ML:  this is NF(U)
# with virtual classes.

# 2/14/2017 5 PM changed right rule for equality to preserve the equation:  this is because I found that one
# may want to use different domain witnesses for different sets, so you really want to preserve
# the literal equation.  Not to mention that on the right the expansion via Leibniz doesn't really
# gain anything.

# 2/14/2017  No code change. I have a general solution in mind to allowing definition of operators
# on classes.  Provide an alternative substitution function which allows classes
# to replace variables and expands formulas x IN C where C is a class in the
# obvious way (or provide an alternative INN which is expanded for all abstractions:
# one probably wants uniform behavior whether abstractions are stratified or not).
# This would allow definition of quantifiers or other variable binding operators
# not intended to be restricted to set abstractions.  I should also provide
# NFU* function abstraction while I am at it (this being simple).  I do not want
# restricted functions.  It looks as if restricted definite descriptions are in
# effect already supported.  Unstratified definite descriptions would be supported
# if I used the strong substitution function proposed for definitions in the relevant
# rules?

# 2/13/2017 extensive review of comments.  It remains necessary to comment
# leftexpand and rightexpand in detail.

# 2/13/17  A strategic comment.  I do think this is my flagship version now,
# but in recent work I have found two serious bugs (failure to check stratification
# of binary operators with all three types and bad definition expansion
# inside of abstractions).  This code needs to be gone through and commented
# carefully in the same way the type function was commented, with an eye
# to spotting difficulties.  Also, work on serious theorems in the theories
# of sets and functions will give a chance to discover remaining problems.
# Note also that study of printed proofs has uncovered bugs in the genealogy
# mechanism.

# Note idea of generating proofs more in my paper style with indentation
# from Marcel proof trees is not implausible;  it might even be fairly easy, and it
# would involve less volume (only new premises or alternative conclusions would need
# to be written;  things appearing at higher levels of indentation and earlier would
# be assumed included as usual).  This is seriously useful from the educational
# standpoint, and might not be that hard to generate.

# A separate reason for careful commenting is that I find that I do not remember
# all the design decisions which went into this, and they need to be documented.

# careful commenting goes along with the aim of writing a system description
# paper.

# would it make sense to add stratification inference as an option, as in the
# ML version?  Stratification inference is mathematically interesting.

# 2/13/17  The supermatch function will now attempt definitional expansions
# to establish equality.  It may not be doing this in the most efficient way.
# Thus Done and Done2 and Right on equations will work sometimes when a
# definition is all that must be applied. Script repairs have been carried out.

# 2/12/17 I fixed a bug, blocking defexpand from making expansions involving
# bound variables.  I have proposed code to make supermatch attempt matching
# using definitions, but it breaks existing proofs.  I don't know if the
# problem is that it doesn't work or that it changes behavior of existing
# scripts.  The code is there, but commented out.  I could also make it a
# toggle, I suppose.  The exact fix I did to defexpand is motivated by
# conservation of existing proofs:  it would be simpler to just not do
# defexpand inside abstractions, but this trashed existing scripts.

# a final tweak:  I made it so that it expands complex binders as well,
# so at least it is uniform.

# I have a suspicion that the approach I have taken is not principled,
# and I should simply forbid definitional expansion inside abstractions --
# though I suppose occasionally it might force an equation.  Also,
# it does not do defexpand inside complex binders, which makes it weirdly
# nonuniform.  I could easily enable defexpand inside binders of course.

# 2/11/17 I am inclined NOT to fix the x R A case of propositional binders.
# the extra steps are dead easy ones and the advantage of having fewer cases
# in all relevant functions probably trumps it.  The point about binding
# probably is not worth the even larger amount of code which would have to
# be added for new cases.

# I'm wondering if I want a stronger Rf() that does complete removal of
# a nonce constant in any noncircular situation.  There is no script
# fixing issue as Rf() doesnt get posted to the script unless it works.

# would it be a good idea to have Done() advance the goal considered even if
# it fails?  This might make script debugging much easier.  This has been installed:
# we shall see if it helps with script debugging.  To turn this feature
# on, use the new command Scriptmode().  I do not actually know whether
# it will help.

# Specification of Done2 changed:  it just ignores reflexivity.  The original
# implementation didnt work for some reason.  Done2 is a user command, but
# it main use is in its silent version, in the internals of triv.

# 2/10/17  guarded Usethm against key errors.

# 2/10/17 3 PM error messages are now posted to log files.  In combination
# with line numbering, I am hoping that this will make scripts editable in
# practice.  We shall see.  Also, I implemented the restraint on defexpand
# with membership statements:  it will expand only on the right if it does
# nothing that preempts this and right expansion does something.  Left
# expansion will happen as with any term if no membership rule does anything.

# 2/10/2017 11AM corrected behavior of Cut with respect to genealogy.  This
# does probably mean that the cutlemma command is not needed:  autoprune will
# ensure that a lemma has a proof without extraneous stuff embedded in
# the proof of the theorem that uses it.

# I am thinking that neither restricted functions nor restricted definite
# descriptions are worth the effort.  I should point out the dead easy
# implementation of NFU proper in this logic and the theoretically possible
# (and probably practically possible with a wee bit of effort) implementation
# of NF if it is assumed that every object is a possibly restricted set.

# NFU* unstratified functions *should* be implemented, as should functions
# which fail to be stratified only because of parameters.

# logic engine updates for complex proposition binder with left term
# a variable (with annoying possibility of binding change?) and to
# control defexpand with IN are both on the table.

# I created a command Numberinglines() which toggles a condition in which
# script lines are numbered in parallel in output and in script files,
# and displayed in output as well, making
# it remotely possible to edit scripts, which may help deal with logic engine
# updates.

# 2/10/2017 very early:  fixed genealogy bug with rewritefree:  the listsubplus
# function wasnt adding all the genealogy information it was supposed to add.
# Do look at the displayed proofs!

# 2/9/2017 reformatted versiondate, making help more readable

# later 2/9, fixed a bug in Rf (rewritefree).  Once fixed, it proved
# enormously useful.

# later 2/9:  note on possible revision of the logic engine.  Defexpand
# on a membership formula should act only on the right -- or only act on
# the left if it does nothing on the right.  There was a quite annoying
# moment in the proof in 3pt4logfile.

# 2/8/2017 10 PM fixed horrid bug in 4 PM version and installed and tested command which will allow
# us to use a theorem that a set is strongly cantorian to retype a retraction to that set as
# having s.c. input and output.  See the new Scout command.

# added helpreview() command which will page through all the help.

# 2/8/2017 4 PM installed ability to type abstracts which are stratified if parameters bound in larger contexts
# are treated as constants as badobject.

# comment:  I do not think it is necessary to provide conventional bounding
# for s.c. sets.  It's better to provide unary operators retracting onto s.c.
# sets:  if #x retracts to Nat for example (sending natural numbers to themselves
# and non-natural numbers to some non-natural number), and is typed correctly,
# {#x IN Nat: P(x)} will be of type object if stratified
# or closed, and badobject otherwise, already.  A separate declaration system
# for s.c. constant sets really is not needed.

# query:  can one prove from the assertion that a set A is strongly cantorian
# that there is a suitable retraction onto it?  Or should a tool to do this be
# built in?

# 2/8/2017  It's official.  This version is more powerful than the ML version.  The only substantial feature of the ML
# version which is not provided here is the matching and unification with pairs and projections,
# and it is not entirely clear that this is needed (evaluating that would require substantial theory work).  Since
# reasoning about pairs is not required for reasoning about functions here, it is quite possible
# that this is surplus to requirements.  But the type level pair may eventually show up with its
# matching and unification effects.  The s.c. typing, now up to partial implementation of NFU*, is more
# powerful than anything in the ML version.  The explicit typing of variables might seem excessive
# but we claim it is actually a sensible practice, reflecting an actual difference in philosophy
# in this version.  Conversely, the handling of typing in the ML version without explicit types on
# variables is a feature of that version which remains of interest.

# Massive further commenting along the lines of the comments added here to the type algorithm can be
# viewed as preliminary to a system description paper.  I need to recover all the thoughts I had while I
# was writing this.

# 2/8/2017  Commented the type algorithm in detail, and discovered some local corrections were needed.

# Extensions which might be wanted:

# Abstracts which fail to be stratified only via the behavior of parameters should be typed as badobject.
# I can use variants of the newboundvarfix functions to do this.

# I may want unstratified definition facilities, and so operators with output type badobject or badprop.
# This should be an easy fix.  Do I want an ability to define binders acting on classes?  This would have
# to be done with care.  And further, I would like to have the natural effect of quantifiers and sets restricted to s.c.
# sets on stratification:  this might again use newboundvarfix variations, and also requires a new declaration
# modality.

# Extension of new features to functions and definite descriptions requires thought.

# 2/7/2017  Introducing types badprop and class.  badprop = unstratified proposition.
#  We can now enter unstratified propositions.  Classes can have unary operators
#  with object input and propositional output applied to them (so quantification works
# correctly).  Class terms cannot be substituted for any variables;  defined
# unary operators will not expand when applied to class terms.  Terms
# still have to be stratified:  I should introduce a type badobject
# to handle unstratified terms.  Badobject type is added, which gives a
# very general capability of expressing unstratified statements.

# Both the complex binders feature and the type system upgrade need to be
# extended to functions.

# Also fixed a couple of bugs.  It was not checking stratification of
# binary terms correctly where all three types in the signature were integers.
# Defexpand needed to not attempt to expand complex binders.

# This also strengthens the logic to NFU*:  this aspect needs to be checked carefully.

# Toggles modifying the logic may be wanted.  Turning off complex binders may be desirable because of their
# odd inessential effect on extensionality.  Turning off NFU* comprehension is desirable re a significant increment of strength.
# If a type level pair were added (enforcing Infinity) turning it off would probably be a desirable option.  Turning
# off badprop, badobject and class might be of some interest.

# 2/6/2017  There is the basis for a system description paper here.  I should write it.  I am making this
# the official version, though the complex binder feature is still doubtless potentially bugged.

# 2/6/2017  Editing.

#  NOTE: pretty printing and proofs in log files are of practical importance.  Also, complete the system of
#  proof comments.

#  complex binder feature is installed, with the major exception of treatment of functions (and
#  definite descriptions).  Sets and quantified statements can be bounded.

#  It does have the curious (but justifiable) feature that restricted sets have the domain to which
#  they are restricted as a feature.  This is necessitated by the structure of universal quantifier terms.
#  For sets this is unusual:  for functions of course it will make perfect sense.

#  It also has the feature that it introduces a difference between bound variables based on initial letter:
#  variables with first letter < m are free left of : or :> in complex binder terms (but not in simple binder terms).
#  This supports binding into complex binders and at the same time preserves the absence of
#  bound variable capture in this system.

#  Today I am editing.

# should I set things up so complex binders can be turned off?  This is not quite as simple as just
# turning off extra cases:  it would be necessary to provide an alternative form of the right rule for
# equality.  It's a good idea because complex binders actually have an effect on the logic.
# probably unrestricted set extensionality should be an alternative in the right rule for equality.

# should I generally turn propositional complex binders with a variable on the left into a separate
# case?  It would simplify some rules, and it would resolve a weird case of substitution:  the single variable
# on the left would be bound regardless of its initial letter.

# note that the type function needs to be updated for complex binder function terms.  Restricted THE is also wanted -- gack.
# note that defexpand implements evaluation of functions.

# the ability to declare and define binders is wanted, especially now that we have complex binders.

# At my leisure, determine whether Rf() interacts correctly with genealogy.  Currently, the equation is
# forced into linesused.  Probably it should actually be added to the geneslogy of modified sentences?  FIXED

# There should be effects of restricted sets on the type system:  a variable restricted to an s.c.
# set should be shiftable in type;  I don't think anything in the current scheme recognizes this.
# The current notion of "restriction" built into the type system is quite different.  An entirely new
# command and kind of declaration is required to identify s.c. sets as domains of restricted sets.

# another possible thing to do:  implement concrete finite iterations of functional operators.
# this is known to be useful in NF(U):  it would seem not too hard to reserve
# identifiers of the form operator+^(numeral) for such iterations.

# 2/2/2017 implementation notes:  replaced instantiables with constants as nonce replacements
# for bound variables in substitution processes.  Added minindex so that instantiables cannot be
# replaced with terms containing variables with minindex < -1, ruling out terms with these fake
# constants in them.  This is needed for equality matching to work successfully.  Actually, it is probably
# already handled in another way, but it's still worthy.

# further idea, preserving the impossibility of bound variable collision:  variables
# beginning with a-l which appear in complex binder terms are free; variables
# beginning with m-z are bound.  All variables behave in the expected way
# as simple bound variables.

# I should set things up so that the complex binder feature can be turned off, because
# it is likely to be unreliable for a while,
# and because it is easily done by guarding certain cases with a global variable.

# this is a real education in how substitution works.  The balance which keeps it working
# should be documented.  One thing which I do not allow is substitution for a single variable binder:
# these have standard behavior, which they do not in the ML version.  This is safe because it is impossible
# to rewrite a term containing a bound variable, so no simplifications which would take a complex
# binder to a variable can be effected.

# 2/2/2017  doing surgery to install sets and functions with complex binders.

# 1.  added clauses to type sets with complex binders.

# 2.  rewrote freevars and freevars2

# 3.  rewrote substitute.  Supermatch presents severe difficulties.

# 4.  supermatch is adapted.  This uses a powerful assumption that free variable
# lists of matching terms will appear in the same order.  I do think this assumption
# is valid:  it avoids a level of structural matching I don't want to add.

# 5.  strongsubstitute, strongsubstitute1, and strongsubstitutematch1 are fixed.
# This is horrible.  The same work for strongsubstitute2 and strongsubstitutemath2 is now done,
# mod careful reading for debugging.

# 6.  rethought free variables:  variables with first letter <'m' in the binder term are free in complex binder terms;
# other variables are bound.  All variables are treated the same by simple binder terms.  This means that we continue to
# have the condition that there is no bound variable capture in Marcel.

# 7.  left universal quantifier rules are installed.  An additional case where a variable is restricted to a term
# would make things a little simpler.  left existential rules installed, easy.  ALL LEFT RULES INSTALLED

# 8.  All rules are installed, except for the upgrade to simplify complex binder terms where the binder is a proposition with
# a variable on the left, and the upgrade to right rules for equality, which requires thought.

# 9.  Mod bugs, the entire logic of complex binders for sets is installed.  The logic for functions will require more work.

# 10.  there are some questions about the theory implemented.  Should we provide a domain function for sets and
# functions?  NO, IT IS DEFINABLE.  Certainly a theory of restricted sets which is fully extensional is equiconsistent with NF (a restricted
# set to be thought of as having three values, in set, in domain but not in set, and not in domain).

# 2/4/2017 fixed error, added Done2()

# 2/2/2017 first mod:  moved expansion of THE terms to highest priority.

# 2/2/2017 This is just a note (no code update).  Set and function notations
# with complex binders present difficulties best handled (given the architecture of binder terms)
# by identifying {T | U} with {T' | U'} in case they have the same elements
# and also {T | true} and {U | true} have the same elements.  The idea is that
# sets with different restricted domains are not the same object.  The difficulty motivating
# this has to do with getting correct behavior for the restricted universal quantifier.
# The identity conditions for functions would be changed similarly.

# The system also needs margin management, and preferably pretty printing
# of terms.

# 1/31/2017 added basic Help() command which displays all commands
# likely to be used in propositional and quantifier proofs.  I'm planning
# to add a few more commands to Help() and introduce a command
# help('command_name') which will display information on a command by name.
# there should also be a helpguide() command which displays all keys
# which are meaningful with help.  The system reports version information
# when the system starts or when a help system command is issued.

# added full help(command_name) command, displaying description of the command
# command_name if there is one, and command helpguide() showing all inputs available for
# the help command.

# 1/30/2017 strips whitespace and other non-Marcel characters out of
# names proposed for theorems and saved proofs.
# Installed triv command.

# 1/29/2017 constructive logic now supported, in a reasonably secure way.  See comments below
# about logical details of how this is done.

# the logic starts classical.  Constructive() makes it constructive; Classical() makes it classical.
# Either of these commands terminates the current proof.  A theorem is saved with a tag indicating whether
# the logic used in it was constructive or classical.  Proofs saved to the desktop are similarly tagged.
# Displayed theorems have a comment (constructive) if they are constructively valid.  Thus, unlike the
# Marcel version, the Python version supports reasonably safe use of the constructive logic in scripts.
# One can prove and keep sorted constructive and nonconstructive proofs in the same theory.

# 1/29/2017 Swapgoals() command installed.  This rotates the innermost list of goals,
# usually the list of goals produced by the most recent command.

# 1/27/2017 wish list (only items so far unaddressed are preserved).

# treatment of pairs and projections (type level) harmonized with matching as in the ML version.  It is
# unclear to me that this is needed at present:  the logic of the Python version does not seem to depend
# particularly on pairing, due to the effects of having primitive functions.

# bookmarks and related commands.  proof displays as comments
# in logs.

#  2/6/2017 curtailed the accumulated comments.


# log file stuff

# the name of the log file, usually of the form ---logfile.py
# created by the setlog command below. 

logfilename = 'defaultlog.txt'

# the log file itself

logfile = open(logfilename,'a')

# native interface log file stuff

# the name of the log file, usually of the form ---logfile.py
# created by the setlog command below. 

ilogfilename = 'idefaultlog.txt'

# the log file itself

ilogfile = open(ilogfilename,'a')

# dictionary of descriptions of commands for the help function

helpdict={}


#in demo mode, user commands are echoed and the system pauses
#and waits for user input befor computing the results.  If quit
# is typed as user input, one breaks out of demo mode.

demomode=False

# (non-logged) user command to toggle demo mode

# demo mode pauses after each user command is entered,
# type quit to resume fast execution.

def Demo():
    global demomode
    demomode=not(demomode)
    if demomode==True: print ('demo mode is on')
    if not demomode==True: print ('demo mode is off')

helpdict["Demo"] = "Demo():  turn demo mode on or off. [DEM]"
helpdict["DEM"] = "DEM:  turn demo mode on or off [Demo()]."


# if errorpause is true, the prover will go into demo mode
# when an error message is issued.

errorpause=False

def Errorpause():
    global errorpause
    if errorpause==False:
        errorpause = True
    errorpause = False

# error message function.  Error messages are printed to
# console and to the log file.

def printerror(s):
    global demomode
    print('\n'+str(s)+'\n')
    logfile.write('\n# '+str(s)+'\n')
    if errorpause==True: demomode=True

# function for commenting output to a log file

def inserthash0(s):
    if s=='':  return ''
    if s[0]=='\n': return '\n# '+str(inserthash0(s[1:]))
    return str(s[0])+str(inserthash0(s[1:]))

# function for forcing linebreaks

margin=50

def SetMargin(n):
    global margin
    margin=n

helpdict['SetMargin']='SetMargin(n):  set the margin to n characters [SM]'
helpdict['SM']='SM:  set the margin to n characters [SetMargin()]'

# This function was really annoying to write because I had to make it
# iterative.  It seems to put line breaks in good places, preserving readability.

def marginize(n,s):

    processed=''
    rest=s
    currentmargin=0

    while not(len(rest)==0):
      done=False
      if len(rest) <2 :
          processed=str(processed)+str(rest)
          rest=''
          done=True
          
      if done==False and rest[0]=='\n':  #return str(s[0])+str(marginize(0,s[1:]))
          processed=str(processed)+'\n'
          currentmargin=0
          rest=rest[1:]
          done=True

          
      if done==False and ((isupper(rest[0]) or isspecial(rest[0]))\
                          and rest[1]==' '): #return str(s[0])+str(marginize(n+1,s[1:]))
          processed=str(processed)+str(rest[0:2])
          rest=rest[2:]
          currentmargin=currentmargin+2
          done=True

      if done==False and (currentmargin < margin): #return str(s[0])+str(marginize(n+1,s[1:]))
          processed=str(processed)+str(rest[0:1])
          rest=rest[1:]
          currentmargin=currentmargin+1
          done=True          

      if done==False and rest[0]==' ': #return str(s[0])+'\n     '+str(marginize(5,s[1:]))
          processed=str(processed)+str(rest[0])+'\n     '
          rest= rest[1:]
          currentmargin=5
          done=True
      if done==False and islower(rest[0]) and not islower(rest[1]) and not rest[1] in [')',']','}'] \
         and not(isnumeral(rest[1])) and not (rest[1]=='$') and not (rest[1]=='_' and not(rest[1]=='?')):
           #return str(s[0])+'\n     '+str(marginize(5,s[1:]))

             processed=str(processed)+str(rest[0])+'\n     '
             rest=rest[1:]
             currentmargin=5
             done=True
             
      if done==False and isnumeral(rest[0]) and not isnumeral(rest[1])  and not rest[1] in [')',']','}']:
          #return str(s[0])+'\n     '+str(marginize(5,s[1:]))
             processed=str(processed)+str(rest[0])+'\n     '
             rest=rest[1:]
             currentmargin=5
             done=True
           
      if done==False:
          processed=str(processed)+str(rest[0])
          rest=rest[1:]
          currentmargin=currentmargin+1
          
    return processed
    

def inserthash(s):  return '\n#'+str(inserthash0(s))+'\n\n'

# page through all the help available for commands.
# type quit to break out.

def helpreview():
	for i in list(helpdict.keys()):
                
		help(i)
		q=input('Next command (type quit to quit):  ')
		if q=='quit':return 'done'

helpdict['helpreview'] = 'helpreview():  page through all the help! [HLPR]'
helpdict['HLPR'] = 'HLPR:  page through all the help! [helpreview()]'


# internals of the history feature, which is handled via
# usercommand: usercommand adds to the back history;
# Start nullifies it.  Notice that forward history is only
# preserved through executions of the back and forward commands:
# forward history is cleared by any other command.

# is history being stored?

# to get more things to updates, we need an understanding
# of all the components of the state.

# I am also having Start forget the history, so this is strictly
# local to a single proof.

# the proof data bases might reasonably include the backhistory
# data?

# a higher level history command which takes snapshots of the total
# state of the prover and allows rollbacks would be nice, but there is no
# need for such a snapshot to be made any time that any user command is
# issued.  Perhaps particular state changing commands will make snapshots!

# note that back decrements script line numbers and forward increments
# them, making it easier to edit scripts to eliminate use of these
# commands.

backhistory = []

forwardhistory = []

linesused=[]
newlineindex=1

def Back():
     logfile.write('\nBack()\n')
     global theproof
     global forwardhistory
     global backhistory
     global nextobjectindex
     global linesused
     global newlineindex
     global lineno
     if backhistory == []:
         print('\nNo back history available\n')
         return 'fail'
     forwardhistory = [[theproof,nextobjectindex,linesused,newlineindex]]+forwardhistory
     theproof=backhistory[0][0]
     nextobjectindex=backhistory[0][1]
     linesused=backhistory[0][2]
     newlineindex=backhistory[0][3]
     backhistory=backhistory[1:]
     lineno=lineno-1
     shownextgoal(theproof)

helpdict["Back"]="Back(): go back one step in history [b]"
helpdict["b"]="b: go back one step in history [Back()]"

def Forward():
    logfile.write('\nForward()\n')
    global theproof
    global forwardhistory
    global backhistory
    global linesused
    global nextobjectindex
    global newlineindex
    global lineno
    if forwardhistory ==[]:
        print('\nNo forward history available\n')
        return 'fail'
    lineno=lineno+1
    backhistory = [[theproof,nextobjectindex,linesused,newlineindex]]+backhistory
    theproof=forwardhistory[0][0]
    nextobjectindex=forwardhistory[0][1]
    linesused=forwardhistory[0][2]
    newlineindex=forwardhistory[0][3]
    forwardhistory=forwardhistory[1:]
    shownextgoal(theproof)

helpdict["Forward"]="Forward():  go forward one step in history:\
forward history cleared by most user commands [f]"
helpdict["f"]="f:  go forward one step in history:\
forward history cleared by most user commands [Forward()]"

def Forget():
    logfile.write('\nForget()\n')
    global forwardhistory
    global backhistory
    forwardhistory=[]
    backhistory=[]

helpdict["Forget"]="Forget():  forget all history [F]"
helpdict["F"]="F:  forget all history [Forget()]"

# the current goal sequent

def thegoal(P):
    if len(P)<2:  return 'fail'
    if P[1]=='goal':  return P[0]
    if len(P[1])==0:  return 'fail'
    return thegoal(P[1][0])

def TheGoal():
    global theproof
    return thegoal(theproof)

# the current script line number
    
lineno=0

# a new script line number

def newlineno():
    global lineno
    lineno=lineno+1
    return lineno

# dummy command used to post line numbers to scripts

def line(s):
    i=0

# if numberinglines is true, user commands are posted
# to scripts with line numbers.  This is to assist editing
# of scripts.

numberinglines=False

def Numberinglines():
    global numberinglines
    global lineno
    if numberinglines==True:
       numberinglines=False
    lineno=0
    numberinglines=True

helpdict['Numberinglines']='Numberinglines():  \
turn on (or off) numbering of script lines in scripts and the display:\
supports script editing'

# internal command to handle logging associated with
# (logged) user commands, meaning almost all user commands.
#  the command line is echoed to the log file, and if in
# demo mode one pauses and waits for user input before
# executing the command.

# this command also handles the history feature, recording
# the state of the current proof each time a logged command
# is executed.  Notice that Back, Forward, Forget are only semi-logged
# (they post their own text to the log without calling this command)
# and that the Start command clears the history.

def usercommand(s):
    global demomode
    global backhistory
    global forwardhistory
    global linesused
    global newlineindex
    global lineno
    if numberinglines==True:
        n=newlineno()
        logfile.write('line('+str(n)+');')
        print('\nscript line number '+str(n)+':  '+str(s)+'\n')
    logfile.write(s)

    backhistory=[[theproof,nextobjectindex,linesused,newlineindex]]+backhistory
    forwardhistory=[]
    if demomode==True:
       print(s)
       x=''  #helps demo mode to work in Python 2.7; one must type at least a character
       x=input('Press Enter to continue...type quit to quit demo mode')
       if x=='quit':demomode=False

def quotestr(s): return "'"+str(s)+"'"  #internals of logging

# (non-logged) user command to handle opening a new log file.
# (if a file of this name exists it will be destroyed, careful).
# This is the only command which closes the log file; I have
# been closing log files by typing setlog('done').  Of course you
# need to close the log file or you lose data.
# the name of the file is the argument plus "logfile.py".
# the log file is a Python file which imports all prover
# commands, so it can be executed as a Python program.

# Note that we have not provided a command to close a log file,
# as setlog does this already;  our convention is to close the
# working log file with setlog('done');  one should always do this, or
# one cannot read the log file!
    
def setlog(s):
    global logfilename
    global logfile
    logfile.close()
    logfilename=s+'logfile.py'
    logfile=open(logfilename,'w')
    logfile.write('from pythonmarcel import *\n\n')

def setilog(s):
    global ilogfilename
    global ilogfile
    ilogfile.close()
    ilogfilename=s+'ilogfile.ilg'
    ilogfile=open(ilogfilename,'w')

helpdict["setlog"]="setlog(filename):  set log file to filenamelogfile.py \
(clearing it) and closes previous log.\
By convention, we use setlog('done') to close the log file."
helpdict["SL"]="SL:  set native interface log file to filenameilogfile.ilg \
(clearing it) and closes previous log.\
By convention, we use SL done to close the log file. [setilog(filename)]"

# as setlog except that the log information is appended to an existing
# log file.

def addtolog(s):
    global logfilename
    global logfile
    logfile.close()
    logfilename=s+'logfile.py'
    logfile=open(logfilename,'a')
    
# as setilog except that the log information is appended to an existing
# log file.

def addtoilog(s):
    global ilogfilename
    global ilogfile
    ilogfile.close()
    ilogfilename=s+'ilogfile.ilg'
    ilogfile=open(ilogfilename,'a')
   
helpdict["addtolog"]="addtolog(filename):  set log file to filenamelogfile.py\
(appending); closes previous log"
helpdict["AL"]="AL:  set native interface log file to filenameilogfile.ilg\
(appending); closes previous log [addotolog(filename)]"

# character classes of significance

def isnumeral(c):  return '0'==c or '0'<c<'9' or '9'==c

def islower(c):  return 'a' == c or 'a'<c<'z' or 'z'== c

def isupper(c):  return 'A'==c or 'A'<c<'Z' or 'Z'==c

# certain special characters cannot be used as they have special uses:
# periods, quotes, underscore, dollar sign, question mark and paired forms cannot
# be used in operator names.  ! is also restricted:  I am not sure why.

def isspecial(c):  return  c in {'~','#','%','^','&','*','-','+',\
                                 '=',',','<','>','/','`','@',':'
                                 ,'|','`'}

# returns the initial segment of the second string argument
#  which passes the character class test represented by the first argument,
#  tupled with its length.

def getinit(f,x):
    if len(x)==0:  return ""
    y=""
    for n in range(len(x)):
        if not f(x[n]): return y
        y=y+x[n]
    return y

# tests for characters which can occur in Python Marcel text

# notice the explicit list of restricted special characters.  I am not sure
# why ! is in it; perhaps it should be moved to isspecial.

def isgoodchar(c):  return islower(c) or isupper(c)\
    or isspecial(c) or isnumeral(c) or c in {'$','(',')','{','}','[',']','_','!','?','.'}

# strips all non-Python Marcel characters (such as whitespace)
# out of a string

# this command inserts dots where non-Marcel characters (normally whitespace)
# break a numeral or a string of special characters.  The user can
# type . in such contexts but is not expected to.

def strip(s):
         if len(s)==0:  return ''
         S=''
         for n in range(len(s)):
          if isgoodchar(s[n]):  S=S+s[n]
          if n+1<len(s) and not(isgoodchar(s[n+1])):
             if isupper(s[n]) or isspecial(s[n]):
                 S=S+" "
             if isnumeral(s[n]):
                 m=n+1
                 while m<len(s) and not(isgoodchar(s)):
                     m=m+1
                 if m<len(s) and isnumeral(s):
                     S=S+" "
         return S 

# the old recursive version of strip which led to dismal performance.

def striptest(s):
    
    if len(s)==0:  return s
    if len(s)==1 and isgoodchar(s[0]): return s
    if len(s)==1: return ''
    if (isupper(s[0]) or isspecial(s[0])) and not isgoodchar(s[1]):
        return s[0]+' '+strip(s[2:])
    if isnumeral(s[0]) and not isgoodchar(s[1])\
       and len(strip(s[2:]))>0 and isnumeral(strip(s[2:])[0]):
        return s[0]+' '+strip(s[2:])
    if isgoodchar(s[0]):  return s[0]+strip(s[1:])
    if not isgoodchar(s[0]): return strip(s[1:])

# returns the first Python Marcel identifier in a string
# tupled with its length

# strings of lower case not of length 1 and not followed by ? $ _ or numeral are constants
# strings of lower case of length 1 followed by a numeral are variables;
#  the numeral is its type.  The length 1 strings are of type 0 and
# synonymous with the same string suffixed with zero.
# strings of lower case followed by ? are propositional constants
# strings of lower case followed by an underscore and numeral
# are arbitrary constants (really a species of free variable).
# strings of lower case followed by a dollar sign and numeral
# are "instantiables" (another species of free variable).
# strings of upper case or strings of special characters, possibly followed
# by an underscore and numeral are operators.
# we project adding strings of special characters or upper case letters followed
# by ^ then directly by a numeral as iterated forms of the (unary) operator without the ^.
# Effects of this on the ability to declare ^-final operators need to be considered.
# strings of digits are numerals, recognized as constants without
# declaration.

# the indexed constants and instantiables might better be regarded
# as free variables but the structure of the code commits me to calling
# the former constants.

# here is the next object index...this is iterated to manage introduction
# of fresh objects.  It is worth noting that the nextobjectindex function
# is incremented when necessary by the parser and the term display commands:
# so one must be sure that a term which has to be taken into account for
# identifier freshness is either parsed or printed.

nextobjectindex=1

def getident(x):
    global nextobjectindex
    if x=="":  return ([],0)
    if islower(x[0]):
        y=getinit(islower,x)
        if len(y)==len(x):
            if len(y)==1: return[['variable',y,'0'],1]
            return(['constant',y],len(y))
        if isnumeral(x[len(y)]):
            z=getinit(isnumeral,x[len(y):])
            return (['variable',y,str(int(z))],len(y)+len(z))
        if x[len(y)]=='_' and len(x)>len(y)+1 and isnumeral(x[len(y)+1]):
            z=getinit(isnumeral,x[len(y)+1:])
            if int(z)+1>nextobjectindex: nextobjectindex=int(z)+1
            #if (not len(x)==len(y)+len(z)+1) and x[len(y)+len(z)+1]=='!':
                #return(['instantiable',y,z],len(y)+len(z)+2)
            return(['constant',y,str(int(z))],len(y)+len(z)+1)
        if x[len(y)]=='$' and len(x)>len(y)+1 and isnumeral(x[len(y)+1]):
            z=getinit(isnumeral,x[len(y)+1:])
            if int(z)+1>nextobjectindex: nextobjectindex=int(z)+1
            #if (not len(x)==len(y)+len(z)+1) and x[len(y)+len(z)+1]=='!':
                #return(['instantiable',y,z],len(y)+len(z)+2)
            return(['instantiable',y,str(int(z))],len(y)+len(z)+1)
        if x[len(y)]=='?':  return(['propvar',y],len(y)+1)
        #if x[len(y)]=='$':  return(['instantiable',y],len(y)+1)
        if len(y)==1:  return (['variable',y,'0'],1)
        return(['constant',y],len(y))
    if isupper(x[0]):
        y=getinit(isupper,x)
        if len(y)==len(x):  return(['operator',y],len(y))
        if x[len(y)]==' ':  return(['operator',y],len(y)+1)
        if x[len(y)]=='_' and len(x)>len(y)+1 and isnumeral(x[len(y)+1]):
            z=getinit(isnumeral,x[len(y)+1:])
            return(['operator',y,str(int(z))],len(y)+len(z)+1)
        return(['operator',y],len(y))
    if isspecial(x[0]):
        y=getinit(isspecial,x)
        if len(y)==len(x):  return(['operator',y],len(y))
        if x[len(y)]==' ':  return(['operator',y],len(y)+1)
        if x[len(y)]=='_' and len(x)>len(y)+1 and isnumeral(x[len(y)+1]):
            z=getinit(isnumeral,x[len(y)+1:])
            return(['operator',y,str(int(z))],len(y)+len(z)+1)
        return(['operator',y],len(y))
    if isnumeral(x[0]):
        z=getinit(isnumeral,x)
        return (['constant',str(int(z))],len(z))
    if x[0]==' ' and len(x)>1 and isnumeral(x[1]):
        z=getinit(isnumeral,x[1:])
        return (['constant',str(int(z))],len(z)+1)
    return ([],0)

#parentheses braces and brackets dictionary, closing forms indexed by their opening forms.
#the various paired forms do not have differing roles in input in Python Marcel, though
# they do in output

pairedforms ={'(':')','[':']','{':'}'}

# parse a non infix term

def parseterm1(x):
    global nextobjectindex
    if len(x)==0:  return ([],0)
    if x[0] in pairedforms.keys():
        if len(x)==1:  return ([],0)
        z=parseterm(x[1:])
        if z[0]==[]:  return ([],0)
        t=z[0]
        n=z[1]
        if len(x)==n+1 or not x[n+1]==pairedforms[x[0]]:  return ([],0)
        return (['parenthesis',t],n+2)
    z=getident(x)
    if z[0]==[]: return ([],0)
    t=z[0]
    n=z[1]
    if not t[0]=='operator':  return z
    w=parseterm(x[n:])
    if w[0]==[]:  return ([],0)
    return (['unary',t,w[0]],n+w[1])

# parse an infix term using APL precedence convention (
# everything has same precedence and groups to the right)

def parseterm(x):
    global nextobjectindex
    z=parseterm1(x)
    if z[0]==[]:  return([],0)
    t=z[0]
    n=z[1]
    if len(x)==n:return z
    if not(isspecial(x[n]) or isupper(x[n])):  return z
    w=getident(x[n:])
    o=w[0]
    m=w[1]
    u=parseterm(x[n+m:])
    if u[0]==[]:  return([],0)
    s=u[0]
    p=u[1]
    return (['binary',o,t,s],n+m+p)

# parse a stripped term (the earlier functions assume input is stripped)

def parse1(x):  return parseterm(strip(x))[0]

# a fake value for the list of precedences

precedences = {'~':2,'&':0,'->':0,'V':0,'==':0,'=/=':0,':':0,':>':0,'`':0,'.':0,'E':0,'=':0}
precedences = {}



#lowest propositional connective precedence

floor1=2

#lowest relation precedence

floor2=4

#lowest operation precedence

floor3=6

#set precedence of an operator to a fixed nonnegative value.
#precedence is determined by the text part of an operator (not
# any numerical index).  This means that declaration of an operator
# of a given type signature gives us an infinite class of operator
# variables of the same type signature.

floor4=9

#the precedence of ` (function application)

# compute the precedence of an operator -- default is 0.
# special defaults for automatic declaration

def prec(o):
    try: return precedences[o]
    except KeyError:
        if isupper(o[0]) and o[0]>'O': return floor2
        if isupper(o[0]) and o[0]<='O':  return floor3
        return 0

#even precedences group to right and odd to left

def setprec(o,n):
     if not n<0: precedences[o]=n

# determines whether operator a can be set to precedence n:
# the idea is that the precedence of an operator can be set
# only if it is at the default value of precedence for its range
# and is to be set to a value less than the threshhold for the next
# range.

# notice that precedences of binders, set to zero,
# are out of the range of their type signatures and never
# can be reset.

def canbeset(a,n):
    return (prec(a)==floor1 and n<floor2) or\
       prec(a)==floor2 and n<floor3 or\
       (prec(a)==floor3 and n<floor4)

# setprec guarded by canbeset

def guardedsetprec(a,n):
    if canbeset(a,n):
        setprec(a,n)
        Showdec(a)
        return 'done'
    printerror('precedence of ' + a +' already set?\n')
    return 'error'

#set precedence of first operator to be same as that of second
     
def setprecsame(a,b):
    usercommand('\n\nsetprecsame('+quotestr(a)+','+quotestr(b)+')\n')
    guardedsetprec(a,prec(b))

helpdict['setprecsame']="setprecsame(a,b): \
set the precedence of operator a to be the same as that of b [SP=]"
helpdict['SP=']="SP=: \
set the precedence of operator a to be the same as that of b [setprecsame(a,b); set a with SP1]"

#raise all precedences above a certain value by two to allow insertion
# note that this is executed before canbeset, so a failed precedence
# insertion will have (invisible) effects.

def raiseprec1(a,n):
    global precedences
    if prec(a)>n:  setprec(a,prec(a)+2)

# set precedence of first operator to be just above or just below
# that of second operator and of given parity

# the parity of precedence indicates right or left grouping (even for
# right, odd for left).
    
def setprecevenabove(a,b):
     usercommand('\n\nsetprecevenabove('+quotestr(a)+','+quotestr(b)+')\n')
     global floor1
     global floor2
     global floor3
     global floor4
     n=prec(b)
     if floor1>n: floor1=floor1+2
     if floor2>n: floor2=floor2+2
     if floor3>n: floor3=floor3+2
     if floor4>n: floor4=floor4+2
     def F(c): raiseprec1(c,n)
     list(map(F,list(precedences.keys())))
     guardedsetprec(a,prec(b)+2-prec(b)%2)

helpdict["setprecevenabove"]="setprecevenabove(a,b):\
set precedence of a to be even (group right) and just above that of b [SPEA]"
helpdict["SPEA"]="SPEA:\
set precedence of a to be even (group right) and just above that of b [setprecevenabove(a,b); set a with SP1]"
     
def setprecoddabove(a,b):
     usercommand('\n\nsetprecoddabove('+quotestr(a)+','+quotestr(b)+')\n')
     global floor1
     global floor2
     global floor3
     global floor4
     n=prec(b)
     if floor1>n: floor1=floor1+2
     if floor2>n: floor2=floor2+2
     if floor3>n: floor3=floor3+2
     if floor4>n: floor4=floor4+2

     def F(c): raiseprec1(c,n)
     list(map(F,list(precedences.keys())))
     guardedsetprec(a,prec(b)+1+prec(b)%2)

helpdict["setprecoddabove"]="setprecoddabove(a,b): \
set precedence of a to be odd (group left) and just above that of b [SPOA]"
helpdict["SPOA"]="SPOA: \
set precedence of a to be odd (group left) and just above that of b [setprecoddabove(a,b);  set a using SP1]"

def setprecevenbelow(a,b):
     usercommand('\n\nsetprecevenbelow('+quotestr(a)+','+quotestr(b)+')\n')
     global floor1
     global floor2
     global floor3
     global floor4
     n=prec(b)-1
     if floor1>n: floor1=floor1+2
     if floor2>n: floor2=floor2+2
     if floor3>n: floor3=floor3+2
     if floor4>n: floor4=floor4+2

     if not n<0:
       def F(c): raiseprec1(c,n)
       list(map(F,list(precedences.keys())))
       guardedsetprec(a,prec(b)-2+prec(b)%2)

helpdict["setprecevenbelow"]="setprecevenbelow(a,b):\
set precedence of a to be even (group right) and just below that of b [SPEB]"
helpdict["SPEB"]="SPEB:\
set precedence of a to be even (group right) and just below that of b [setprecevenbelow(a,b);  a set using SP1]"

def setprecoddbelow(a,b):
     usercommand('\n\nsetprecoddbelow('+quotestr(a)+','+quotestr(b)+')\n')
     global floor1
     global floor2
     global floor3
     global floor4
     n=prec(b)-1
     if floor1>n: floor1=floor1+2
     if floor2>n: floor2=floor2+2
     if floor3>n: floor3=floor3+2
     if floor4>n: floor4=floor4+2

     if not n<0:
        def F(c): raiseprec1(c,n)
        list(map(F,list(precedences.keys())))
        guardedsetprec(a,prec(b)-1-prec(b)%2)

helpdict["setprecoddbelow(a,b)"]="setprecoddbelow(a,b): \
set precedence of a to be odd (group left) and just below that of b [SPOB]"
helpdict["SPOB"]="SPOB: \
set precedence of a to be odd (group left) and just below that of b setprecoddbelow(a,b); set a using SP1]"

#  correct grouping in an APL term following precedence.  Parentheses
# left undisturbed.

def stickiness(T):
    if T[0]=='unary' or T[0]=='binary':  return prec(T[1][1])
    return(-1)

def regroup(T):
    global nextobjectindex
    if len(T)==0:  return T
    if T[0]=='unary':
        if stickiness(T[2])==-1: return T
        U=regroup(T[2])
        if not U[0]=='binary':  return ['unary',T[1],U]
        if stickiness(T) > stickiness(U) or (stickiness(T)==stickiness(U)\
                                             and stickiness(T)%2==1):
            return regroup(['binary',U[1],regroup(['unary',T[1],U[2]]),U[3]])
        return ['unary',T[1],U]

    if T[0]=='binary':
        U=regroup(T[2])
        V=regroup(T[3])
        if (not stickiness(U)==-1) and (stickiness(T) > stickiness(U)\
                                        or (stickiness(T)==stickiness(U) and stickiness(T)%2==0)):
            if U[0] == 'unary':  return regroup(['unary',U[1],regroup(['binary',T[1],U[2],V])])
            if U[0] == 'binary':  return regroup(['binary',U[1],U[2],\
                                                  regroup(['binary',T[1],U[3],V])])
        if (not stickiness(V)==-1) and (stickiness(T) > stickiness(V)\
                                        or (stickiness(T)==stickiness(V)\
                                            and stickiness(T)%2==1)):
            if V[0] == 'unary': return ['binary',T[1],U,V]
            if V[0] == 'binary': return regroup(['binary',V[1],\
                                                 regroup(['binary',T[1],U,V[2]]),V[3]])
        return(['binary',T[1],U,V])
    

    return T
    
#regroup inside parentheses then remove them.

def deparen(t):
    global nextobjectindex
    if len(t)==0:  return t
    if t[0]=='parenthesis':  return deparen(regroup (t[1]))
    if t[0]=='unary':  return ['unary',t[1],deparen(t[2])]
    if t[0]=='binary':  return ['binary',t[1],deparen(t[2]),deparen(t[3])]
    return t

# the final parser:  strip string, then parse with APL precedence, then regroup
# and deparenthesize

def parse(T):
    global nextobjectindex
    return deparen(regroup(parse1(T)))

# type declaration list for operators.  We assume that subscripted variants
# of operators have the same type signature.

# this list also tells us whether operators are unary or binary

# declareunary and declarebinary are not user operations:
# they would allow declaration of some operation types which are not supported.
# the user commands given allow declarations of exactly the operators with
# expected types.

# we state the rules for legal types:  any operator with a proposition input
# type has all other inputs and outputs proposition.  An operator with object or prop
# output type will only have an integer typed input if it has two of them.
# An operator with integer typed output will have at least one integer typed input.
# Where integer types are present in a signature, the smallest one will always be zero.

# I should check that all of this is actually enforced.

# convert a unary operator to a binder (this gives it lowest
# precedence and allows it to be applied to classes)

def Makebinder(s):

    if not(s in list(optypes.keys())):
        printerror('No such operator')
        return 'fail'
    if not(len(optypes[s])==2):
        printerror('Operator is not unary')
        return 'fail'
    setprec(s,0)
    Showdec(s)

optypes={'=':['prop',0,0]}
optypes={}

# display precedence and type signature of an operator.
# non-logged semi-user command (it ought to have
# nicer output).

def echo(s):
    print(s)
    S=inserthash(s)
    logfile.write(S)
    ilogfile.write(S)

def Showdec(O):
    if not O in list(optypes.keys()):
        printerror(O+'not found in optypes list\n')
        return 'error'
    if not O in list(precedences.keys()):
        printerror(O+'not found in precedences list\n')
        return 'error'    
    echo('\n'+O+':  types-output type then input type(s):  '\
          +str(optypes[O])+'\nprecedence (even groups right, odd left):\
          '+str(precedences[O])+'\n')

helpdict["Showdec"]="Showdec(O): \
show declaration of unary or binary operator O:  format isn't nice [Sd]"
helpdict["Sd"]="Sd: \
show declaration of unary or binary operator O:  format isn't nice [Showdec(O)]"

def declareunary(o,t1,t2):
    if not getident(o)[1] == len(o):  return 'bad'
    if not len(getident(o))==2:  return 'bad'
    if not getident(o)[0][0]=='operator':  return 'bad'
    if o in list(optypes.keys()): return o+' already declared.'
    if o[0]==':':  return 'bad' #reserved for abstractors
    if t1 == 'prop' and t2 == 'prop':  optypes[o]=['prop','prop']
    if t1 == 'prop' and not(t2=='prop'):  optypes[o]=['prop','object']
    if t1 == 'object': optypes[o]=['object','object']
    if not(t1=='prop' or t1== 'object'):  optypes[o]=[t1-min(t1,t2),t2-min(t1,t2)]
    if t1=='prop' and t2=='prop':
        setprec(o,floor1)
        Showdec(o)
        return 'done'
    if t1=='prop':
        setprec(o,floor2)
        Showdec(o)
        return 'done'
    setprec(o,floor3)
    Showdec(o)
    return 'done'

def declareproperty(P):
    usercommand('\n\ndeclareproperty('+quotestr(P)+')\n')
    return declareunary(P,'prop','object')

helpdict["declareproperty"]="declareproperty(P): declare P as unary predicate [DP]"
helpdict["DP"]="DP: declare P as unary predicate [declareproperty()]"

def declarefunction(F):
    usercommand('\n\ndeclarefunction('+quotestr(F)+')\n')
    return declareunary(F,0,0)

helpdict["declarefunction"]="declarefunction(F): declare F as a type level function symbol [DF]"
helpdict["DF"]="DF: declare F as a type level function symbol [declarefunction(F)]"

def declarescfunction(F):
    usercommand('\n\ndeclarescfunction('+quotestr(F)+')\n')
    return declareunary(F,'object','object')

helpdict["declarescfunction"]="declarescfunction(F):\
declare F as a function symbol with strongly cantorian range [DSF]"
helpdict["DSF"]="DSF:\
declare F as a function symbol with strongly cantorian range [declarescfunction(F)]"

# the numerical argument expresses the displacement of the output from the input

def declaretypedfunction(F,n):
    usercommand('\n\ndeclaretypedfunction('+quotestr(F)+','+str(n)+')\n')
    return declareunary(F,n+abs(n),abs(n))

helpdict["declaretypedfunction"] = "declaretypedfunction(F,n):\
declare F as a function symbol with output n types higher than input [DTF]"
helpdict["DTF"] = "DTF:\
declare F as a function symbol with output n types higher than input [declaretypedfunction(F,n); supply n using SP1]"

def declarequantifier(P):
    usercommand('\n\ndeclarequantifier('+quotestr(P)+')\n')
    declareunary(P,'prop','object')
    if P in list(optypes.keys()):Makebinder(P)

helpdict["declarequantifier"]="declarequantifier(P): declare P as unary binder with proposition output [DQ]"
helpdict["DQ"]="DQ: declare P as unary binder with proposition output [declarequantifier(P)]"


def declarefunctionbinder(F):
    usercommand('\n\ndeclarefunctionbinder('+quotestr(F)+')\n')
    declareunary(F,0,0)
    if F in list(optypes.keys()): Makebinder(F)

helpdict["declarefunctionbinder"]="declarefunctionbinder(F): declare F as a type level function binder [DBF]"
helpdict["DBF"]="DBF: declare F as a type level function binder [declarefunctionbinder(F)]"


def declarescfunctionbinder(F):
    usercommand('\n\ndeclarescfunctionbinder('+quotestr(F)+')\n')
    declareunary(F,'object','object')
    if F in list(optypes.keys()):Makebinder(F)

helpdict["declarescfunctionbinder"]="declarescfunctionbinder(F):\
declare F as a function binder with strongly cantorian range [DSBF]"
helpdict["DSBF"]="DSBF:\
declare F as a function binder with strongly cantorian range [declarescfunctionbinder(F)]"

# the numerical argument expresses the displacement of the output from the input

def declaretypedfunctionbinder(F,n):
    usercommand('\n\ndeclaretypedfunctionbinder('+quotestr(F)+','+str(n)+')\n')
    declareunary(F,n+abs(n),abs(n))
    if F in list(optypes.keys()): Makebinder(F)

helpdict["declaretypedfunctionbinder"] = "declaretypedfunctionbinder(F,n):\
declare F as a function binder with output n types higher than input [DTBF]"
helpdict["DTBF"] = "DTBF:\
declare F as a function binder with output n types higher than inputn[declaretypedfunctionbinder(F,n);  supply n using SP1]"

# I have added all the possible signatures relative
# to s.c. input and output.

def declarebinary(o,t1,t2,t3):
#    print(str(t1)+';'+str(t2)+';'+str(t3))
    if not getident(o)[1] == len(o):  return 'bad'
    if not len(getident(o))==2:  return 'bad'
    if not getident(o)[0][0]=='operator':  return 'bad'
    if o in list(optypes.keys()): return o+' already declared.'
    if o[0]==':':  return 'bad' #reserved for abstractors
    def noninteger(t):  return t=='prop' or t=='object'
    if (noninteger(t1) and noninteger(t2)) or (noninteger(t1)\
                                               and noninteger(t3)) or (noninteger(t2)\
                                                                       and noninteger(t3)):\
                                                                       optypes[o]=[t1,t2,t3]
    if not(noninteger(t1) or noninteger(t2) or noninteger(t3)): \
       optypes[o]=[t1-min(t1,min(t2,t3)),t2-min(t1,min(t2,t3)),t3-min(t1,min(t2,t3))]
    if noninteger(t1) and not(noninteger(t2) or noninteger(t3)):\
       optypes[o]=[t1,t2-min(t2,t3),t3-min(t2,t3)]
    if noninteger(t2) and not(noninteger(t1) or noninteger(t3)): \
       optypes[o]=[t1-min(t1,t3),t2,t3-min(t1,t3)]
    if noninteger(t3) and not(noninteger(t1) or noninteger(t2)): \
       optypes[o]=[t1-min(t1,t2),t2-min(t1,t2),t3]
    if t1=='prop' and t2=='prop':
        if not t3 == 'prop':  return 'bad'
        setprec(o,floor1)
        Showdec(o)
        return 'done'
    if t1=='prop' and t3=='prop':
        if not t2 == 'prop':  return 'bad'
        setprec(o,floor1)
        Showdec(o)
        return 'done'    
    if t1=='prop':
        setprec(o,floor2)
        Showdec(o)
        return 'done'
    setprec(o,floor3)
    Showdec(o)
    return 'done'

def declarerelation(R):
    usercommand('\n\ndeclarerelation('+quotestr(R)+')\n')
    return declarebinary(R,'prop',0,0)

helpdict["declarerelation"]="declarerelation(R):  declare R as a type level relation [DR]"
helpdict["DR"]="DR:  declare R as a type level relation [declarerelation(R)]"

def declareoperation(O):
    usercommand('\n\ndeclareoperation('+quotestr(O)+')\n')
    return declarebinary(O,0,0,0);

helpdict["declareoperation"]="declareoperation(O): declare O as a type level binary operation [DO]"
helpdict["DO"]="DO: declare O as a type level binary operation [declareoperation(O)]"

def declarescoperation(O):
    usercommand('\n\ndeclarescoperation('+quotestr(O)+')\n')
    return declarebinary(O,'object',0,0)

helpdict["declarescoperation"]="declarescoperation(O): \
declare O as an operation symbol with inputs of the same type and strongly cantorian range [DSO]"
helpdict["DSO"]="DSO: \
declare O as an operation symbol with inputs of the same type and strongly cantorian range [declarescoperation(O)]"

def declarescinoperation(O):
    usercommand('\n\ndeclarescinoperation('+quotestr(O)+')\n')
    return declarebinary(O,'object','object','object')

helpdict["declarescinoperation"]="declarescinoperation(O): \
declare O as a binary operation with both arguments strongly cantorian [DSI]"
helpdict["DSI"]="DSI: \
declare O as a binary operation with both arguments strongly cantorian[declarescinoperation(O)]"


#numerical arguments express differentials of the numerical type of the output
#(or second input) from the first and second input (or first input)

def declaretypedrelation(R,n):
    usercommand('\n\ndeclaretypedrelation('+quotestr(R)+','+str(n)+')\n')
    return declarebinary(R,'prop',abs(n),n+abs(n))

helpdict["declaretypedrelation"]="declaretypedrelation(R,n):\
declare R as a relation with second argument n types higher than first [DTR]"
helpdict["DTR"]="DTR:\
declare R as a relation with second argument n types higher than first [declaretypedrelation(R,n):  supply n from SP1]"

def declarescinrelation(R):
    usercommand('\n\ndeclarescinrelation('+quotestr(R)+')\n')
    return declarebinary(R,'prop','object','object')

helpdict["declarescinrelation"]="declarescinrelation(R):\
declare R as a relation with both inputs strongly cantorian [DIR]"
helpdict["DIR"]="DIR:\
declare R as a relation with both inputs strongly cantorian [declarescinrelation(R)]"

def declaretypedoperation(O,m,n):
    usercommand('\n\ndeclaretypedoperation('+quotestr(O)+','+str(m)+','+str(n)+')\n')
    return declarebinary(O,abs(m)+abs(n)+m+n,abs(m)+abs(n)+n,abs(m)+abs(n)+m);

helpdict["declaretypedoperation"]="declaretypedoperation(O,m,n): \
declare O as an operation symbol with output m types higher than\
first input and n type higher than second input [DTO]"
helpdict["DTO"]="DTO: \
declare O as an operation symbol with output m types higher than\
first input and n type higher than second input [declaretypedoperation(O,m,n):  m from SP1; n from SP2]"

def declarelefttypedoperation(O,m):
    usercommand('\n\ndeclarelefttypedoperation('+quotestr(O)+','+str(n)+')\n')
    return declarebinary(O,n+abs(n),abs(n),'object');

helpdict["declarelefttypedooperation"]="declarelefttypedoperation(O,n): \
declare O as an operation with output n types higher than first input\
and second input strongly cantorian [DoTL]"
helpdict["DoTL"]="DoTL: \
declare O as an operation with output n types higher than first input\
and second input strongly cantorian [declarelefttypedoperation(O,n);  supply n from SP1]"

def declarerighttypedoperation(O,n):
    usercommand('\n\ndeclarerighttypedoperation('+quotestr(O)+','+str(n)+')\n')
    return declarebinary(O,n+abs(n),'object',abs(n));

helpdict["declarerighttypedoperation"]="declarerighttypedoperation(O,n):  \
declare O as an operation symbol with output n types higher than\
the second input and first input strongly cantorian [DoTR]"
helpdict["DoTR"]="DoTR:  \
declare O as an operation symbol with output n types higher than\
the second input and first input strongly cantorian [declarerighttypedoperation(O,n);  supply n from SP1]"

def declaretypedscoperation(O,n):
    usercommand('\n\ndeclaretypedscoperation('+quotestr(O)+','+str(n)+')\n')
    return declarebinary(O,'object',abs(n),abs(n)+n)

helpdict["declaretypedscoperation"]="declaretypedscoperation(O,n):  \
declare O as an operation symbol with second input n types higher\
than first input and strongly cantorian range [DoTS]"
helpdict["DoTS"]="DoTS:  \
declare O as an operation symbol with second input n types higher\
than first input and strongly cantorian range [declaretypedscoperation(O,n); supply n from SP1]"


# User command to declare a constant.

declaredconstants = []

def Declareconstant(s):
    usercommand('\n\nDeclareconstant('+quotestr(s)+')\n')
    global declaredconstants
    if s in list(declaredconstants): return s+' already declared.'
    if not(getident(s)[0]==['constant',s]):  return s+' cannot be a declared constant'
    declaredconstants=[s]+declaredconstants

def DeclareconstantI(s):
#    usercommand('\n\nDeclareconstant('+quotestr(s)+')\n')
    global declaredconstants
    if s in list(declaredconstants): return s+' already declared.'
    if not(getident(s)[0]==['constant',s]):  return s+' cannot be a declared constant'
    declaredconstants=[s]+declaredconstants

helpdict["Declareconstant"]="Declareconstant(s):  declare s as a constant object [DC]"
helpdict["DC"]="DC:  declare s as a constant object [Declareconstant(s)]"

#DISPLAY FUNCTION  -- with and without indentation and line breaks

# in output use parentheses for propositional grouping,
# brackets for object grouping, braces for abstractions?  This would
# require introduction of the operator type dictionary

# basic printing function

# leftunary function is not used.  Might be wanted.

def leftunary(T):
    if len(T)==0:  return False
    return T[0]=='unary' or (T[0]=='binary' and leftunary(T[2]))

# compute parentheses for output.  Marcel doesnt care what parentheses
# are used in input, but encloses abstractions in braces, other object terms
# in brackets, and propositions in parentheses, in output.

def openparen(T):
    if T[0]=='unary':
        if optypes[T[1][1]][0]=='prop':  return '('
        return '['
    if T[0]=='binary':
        if T[1][1][0]==':':  return '{'
        if optypes[T[1][1]][0]=='prop':  return '('
        return '['
    return ''

def closeparen(T):
    if T[0]=='unary':
        if optypes[T[1][1]][0]=='prop':  return ')'
        return ']'
    if T[0]=='binary':
        if T[1][1][0]==':':  return '}'
        if optypes[T[1][1]][0]=='prop':  return ')'
        return ']'
    return ''

# the print command.  A unary operator is now separated from a following
# term by a space unless the term is atomic or starts with a parenthesis.
# I suppose this could be adjusted for binder terms.

def termprint(T):
    global nextobjectindex
    if len(T)==0: return 'Parse error!'
    if (T[0]== 'constant' or T[0]=='operator') and len(T)==2:  return T[1]
    if (T[0]=='constant' or T[0]=='operator') and len(T)==3:
        if int(str(T[2]))+1>nextobjectindex:  nextobjectindex=int(str(T[2]))+1
        return T[1]+'_'+str(T[2])
    if T[0]=='propvar':  return T[1]+'?'
    #if T[0]=='instantiable' and len(T)==2:  return T[1]+'$'
    if T[0]=='instantiable' and len(T)==3:  
       if int(str(T[2]))+1>nextobjectindex:  nextobjectindex=int(str(T[2]))+1
       return T[1]+'$'+str(T[2])
    if T[0]=='variable' and len(T[1])==1 and T[2]=='0':  return T[1]
    if T[0]=='variable':  
       return T[1]+str(T[2])
    if T[0]=='unary':
         if T[2][0]=='unary': return termprint(T[1])+' '+termprint(T[2])  #used dot here in original version
         if stickiness(T[2])==-1:  return termprint(T[1])+termprint(T[2])
         if stickiness(T)>stickiness(T[2]) \
            or (stickiness(T)==stickiness(T[2]) and stickiness(T[2])%2==1):
              return termprint(T[1])+openparen(T[2])+termprint(T[2])+closeparen(T[2])
         if T[2][0]=='binary': return termprint(T[1])+' '+termprint(T[2])
         return termprint(T[1])+termprint(T[2])
    if T[0]=='binary':
        parens1=['',' ']
        if stickiness(T)>stickiness(T[2]) \
           or (stickiness(T)==stickiness(T[2]) \
               and stickiness(T)%2==0): parens1=[openparen(T[2]),closeparen(T[2])+' ']
        if stickiness(T[2])==-1: parens1=['',' ']
        parens2=[' ','']
        if stickiness(T)>stickiness(T[3]) or \
           (stickiness(T)==stickiness(T[3])\
            and stickiness(T)%2==1):  parens2=[' '+openparen(T[3]),closeparen(T[3])]
        if stickiness(T[3])==-1: parens2=[' ','']
        #if leftunary(T[3]) and parens2==['','']: parens2=['.',''] this line was for inserting dots
        #for a compact version, eliminate all the spaces and put the dots back in
        return parens1[0]+termprint(T[2])+parens1[1]+termprint(T[1])\
               +parens2[0]+termprint(T[3])+parens2[1]
            
termprint(parse('x+y'))

#TYPING ALGORITHM 

# possible type outputs for a term:  'prop', an integer, 'object', 'bad'.

# new types 'badprop. 'badobject' 'class' have been installed, to support
# unstratified propositions and NFU* separation.

# prerequisite functions for the type algorithm

# decompose terms into components

theproof0=[[0,[],[]],'goal']

theproof=[[0,[],[]],'goal']

def opof(T):
    if T[0]=='unary' or T[0]=='binary':  return T[1]
    return 'none'

def term1(T):
    if T[0]=='binary' or T[0]=='unary': return T[2]
    return 'none'

def term2(T):
    if T[0]=='binary':  return T[3]
    return 'none'

# free variable list functions

# the function avar recognizes bound variables with initial letter <m,
# which have the distinctive feature of being free in complex binders (making
# it possible to bind into complex binder terms).

def avar(T):
    return T[0]=='variable' and T[1][0]<'m'

def freevars(T):
    if len(T)==0:  return []
    if T[0] == 'variable':  return [T]
    if T[0] == 'unary':  return freevars(T[2])
    if T[0] == 'binary':
        if (opof(T)[1] == ':' or opof(T)[1] == ':>') and T[2][0]=='variable':
            def f(x):  return not x==T[2]
            return list(filter(f,freevars(T[3])))
        if (opof(T)[1] == ':' or opof(T)[1] == ':>')\
           and type(T[2])=='prop' and T[2][0]=='binary':
            def f(x):  return avar(x) or not x in freevars(T[2][2])
            return freevars(T[2][3])+\
                   list(filter(f,freevars(T[2][2])+freevars(T[3])))
        if opof(T)[1]==":" or opof(T)[1]==":>":
            def f(x):  return avar(x) or not x in freevars(T[2])
            return list(filter(f,freevars(T[2])+freevars(T[3])))
        return freevars(T[2])+freevars(T[3])
    return []


#the function freevars2 ignores free variables directly tagged with
# s.c. output unary operators.  It is used to recognize abstractions with domains
# in effect restricted to s.c. types.

# scvariable is a variable to which a unary operator
# with an sc or prop range is applied:  this really can be thought of
# as an sc (or boolean) variable.

def scvariable(T):
    if not T[0] == 'unary': return False
    if not T[2][0] == 'variable': return False
    op=opof(T)
    if not op[1] in list(optypes.keys()):  return False
    opt = optypes[op[1]]
    if not len(opt) == 2:  return False
    if not (opt[0] == 'object' or opt[0]=='prop'):  return False
    return True

# scvariable2 is a refinement, a variable appearing as input to
# a binary operator with untyped (sc or prop) output where the other
# argument is of type object so has manipulable type
# or the same variable repeated, with types the same

def scvariable2(T):
    if not T[0] == 'binary':  return False
    op=opof(T)
    if not op[1] in list(optypes.keys()):  return False
    opt = optypes[op[1]]
    if not len(opt) == 3:  return False
    if not (opt[0] == 'object' or opt[0]=='prop'):  return False
    if not (T[2][0] == 'variable' or T[3][0] == 'variable'):  return False
    if matches(T[2],T[3]) and not(opt[1] == 'prop') and (opt[1] == opt[2]):  return True
    if T[2][0]=='variable' and (type(T[3]) == 'object' or opt[2] == 'object'):  return True
    if T[3][0]=='variable' and (type(T[2])=='object' or opt[1] == 'object'):  return True
    return False
    
def freevars2(T):
    if len(T)==0:  return []
    if T[0] == 'variable':  return [T]
    if scvariable(T):  return []
    if scvariable2(T):  return []
    if T[0] == 'unary':  return freevars2(T[2])
    if T[0] == 'binary':
        if (opof(T)[1] == ':' or opof(T)[1] == ':>') and T[2][0]=='variable':
            def f(x):  return not x==T[2]
            return list(filter(f,freevars2(T[3])))
        if (opof(T)[1] == ':' or opof(T)[1] == ':>')\
           and type(T[2])=='prop' and T[2][0]=='binary':
            def f(x):  return avar(x) or not x in freevars(T[2][2])
            return freevars2(T[2][3])+\
                        list(filter(f,freevars(T[2][2])+freevars2(T[3])))
        if opof(T)[1]==":" or opof(T)[1]==":>":
            def f(x):  return avar(x)or not x in freevars(T[2])
            return list(filter(f,freevars(T[2])+freevars2(T[3])))        
        return freevars2(T[2])+freevars2(T[3])
    return []

# list difference

def listminus(L,M):
    if L==[]:  return []
    if M==[]:  return L
    if L[0] in M:
        return listminus(L[1:],M)
    return [L[0]]+listminus(L[1:],M)

# the type algorithm.  It also enforces unary/binary operator distinctions
# and syntax of abstraction terms.

# added option of unary and binary functions with strongly cantorian range
# (output type 'object').  Now s.c. inputs as well.

#it is important to notice that 'object' means shiftable in type,
# i.e, bounded in some s.c. range,
# not literally constant, though that is included.

#2/8/2017 commenting this function in detail.

# Glossary:

# integer types have the expected meaning in the NF(U) context.

# 'prop' is 'stratified proposition'; 'badprop' is 'unstratified proposition'.

# 'object' is an object which is either constant or coerced into an (unspecified) strongly cantorian
# domain.  An input to an operation is type 'object' if it can be viewed as coerced into an s.c. domain
# before the operation is applied.

# 'badoject' is an unstratified object term.  'class' is a proper class (these are used to build
# unstratified quantification terms and nothing else, for the time being).

# things I don't have which I might want eventually:  restricted sets and quantifiers have no effect
# on stratification yet (variables restricted to s.c. domains are restricted by having appropriately typed
# operators applied to them locally).  I may want to be able to define (and so need to have types for)
# operators with badprop or badobject output.  I type abstracts whose failures of
# quantification occur only with parameters as badobject.

# one might want to allow classes to occur on the right hand side of IN and allow equations of classes,
# but it may be better not to do this.  The intention is not to implement ML.  The classes serve the narrow
# purpose of allowing unstratified quantification.  Definition of new binders acting on classes apparently
# has to be done by hand, as substitution of classes for variables is blocked.

def type(T):
    
    if len(T)==0:  return 'bad'
    if T[0]=='constant':
        if len(T)==3:  return 'object'
        # indexed constants and instantiables are type-free
        
        if len(T)==2 and isnumeral(T[1][0]) or T[1] in declaredconstants: return 'object'
        #  declared constants and numerals are type-free
        
        printerror ('\nundeclared constant?\n')
        # other constants signal a declaration error
        
        return 'bad'
    if T[0] == 'variable':  return int(T[2])
                            # a bound variable is labelled with its type
    
    if T[0] == 'propvar':  return 'prop' # a propositional variable is obviously of type prop
    if T[0] == 'unary':  # unary operator terms
        tt=type(T[2])
        if tt == 'bad':  return 'bad'
        # a simply badly formed argument to a unary argument makes a badly formed term
        
        op=opof(T)
        if not op[1] in list(optypes.keys()):  #operator is not declared
            # printerror ('\nundeclared operator?\n')
            # return 'bad'

            # experiment with automatic declaration, easier
            # for interface
            if isupper(op[1][0]) and op[1][0]<='O':  declarefunction(op[1])
            if isupper(op[1][0]) and op[1][0] > 'O':  declareproperty(op[1])
        if not op[1] in list(optypes.keys()):  #operator is not declared
            printerror ('\nundeclared operator?\n')
            return 'bad'
            
        opt=optypes[op[1]]
        if not len(opt)==2:  # structure of term is wrong
            printerror ('\nbinary operator used as unary?\n')
            return 'bad'
        if opt[1]=='prop':  # check that an expected propositional input actually is a proposition
            if tt=='badprop':  return 'badprop'
            if tt=='prop':  return 'prop'  # originally opt[0] but unary operators with prop input always have prop output
            printerror( '\nproposition input expected?\n')
            return 'bad'
        if opt[0]=='prop' and prec(op[1])==0 and tt=='class':  return 'badprop'
        # this is the waffle that allows unstratified quantification:  unary operator with object
        # input and prop output can be applied to a class to give a badprop

        if prec(op[1])==0 and tt=='class':  return 'badobject'

        # other unary operations applied to a class will return 'badobject'.
        # this supports extension of definite descriptions.
        
        if tt=='prop' or tt=='badprop' or tt=='class': return 'bad'
        # we have covered all cases where input can be class, prop or badprop
        
        #we assume at this point that input type is an object type (object, badobject or integer)
        # if input is badobject, one must return badobject or badprop
        # if input is actually object or expected to be object (sc input), return object
        # if output is object (sc output), return object
        
        if opt[0]=='prop':
            if tt=='badobject':  return 'badprop'
            return 'prop'
        if opt[0]=='object':
            if tt=='badobject':  return 'badobject'
            return 'object'
        if tt=='object':  return 'object'
        if tt=='badobject':  return 'badobject'
        if opt[1]=='object':  return 'object'
        return tt + (opt[0]-opt[1])
    
    if T[0] == 'binary':  # binary operator terms
        tt1=type(T[2])
        #print ('tt1 is'+str(tt1))
        tt2=type(T[3])
        #print ('tt2 is'+str(tt2))
        if tt1=='bad' or tt2=='bad': return 'bad'  # badly formed input gives badly formed output

        # note that this allows type 'class' to the right of IN
        
        if tt1=='class' or (tt2 == 'class' and not(opof(T)[1]=='IN' or opof(T)[1]=='INR')):  # class input probably signals a stratification error
            printerror('Stratification error?')
            return 'bad'
        op=opof(T)
        #print('operation is'+str(op))
        if op[1]==':':   # set (or class) abstraction term
            if not (tt2=='prop' or tt2 == 'badprop'):
                printerror ('\nset body should be a proposition\n')
                return 'bad'  # body should be a proposition, prop or badprop
#           if not T[2][0]=='variable':
#                print ('\nleft term of set abstract should be variable?\n')
#                return 'bad'
            if T[2][0]=='variable':
               if tt2=='prop' and freevars(T)==[]:  return 'object'  # closed stratified abstracts are untyped
               if not T[2] in freevars2(T[3]) \
                    and (tt2=='prop' or freevars(T)==[]): return 'object'
               # if the binding variable occurs only retracted to an s.c. domain,
               # and the term is either stratified or closed, we get type object.
               # This gives stratified abstracts which are type-shiftable or
               # closed abstracts with s.c. domain and unstratified body (NFU* strength)
               LL=listminus(freevars(T[3]),[T[2]])
               if type(T[3]) == 'badprop' and type(newboundvarfix1(LL,LL,T[3]))=='prop':
                   return 'badobject'
               # if converting parameters to constants makes the abstract stratified,
               # it represents an object definable by an unstratified formula and so is badobject.
               if not T[2] in freevars2(T[3]) :  return 'badobject'

               # NFU* abstracts with parameters:  these are definable in an unstratified
               # manner so they can be mentioned in unstratified formulas.
               
               if tt2=='badprop':  return 'class'

               # this gives proper classes, which can only occur with unary operators applied
               # or to the right of IN.  Quantifiers and the definite description operator can
               # usefully be applied to classes.
               
               return type(T[2])+1

               # the typing of an abstract in sensible circumstances, one type higher
               # than the bound variable.
               
            if tt1=='prop':  # this is the case of propositional complex binders:
                # these must be of the form t R u, a binary propositional term.
                if (not T[2][0] == 'binary') or (type(T[2][2])=='prop')\
                   or (type(T[2][3])=='prop'): return 'bad'  # badly formed complex binder
                if tt2=='prop' and freevars(T)==[]:  return 'object'
                #stratified closed abstract
                if not (meets(freevars2(T[2][2]),freevars2(T[3]))) \
                      and (tt2=='prop' or freevars(T)==[]): return 'object'
                #stratified s.c. bounded abstract or constant s.c. bounded unstratified abstract
                if not (meets(freevars2(T[2][2]),freevars2(T[3]))):
                    return('badobject')
                # s.c. bounded abstract with parameters
                LL=listminus(freevars2(T[3]),freevars2(T[2][2]))
                if type(T[3])== 'badprop' and type(LL,LL,T[3])=='prop':  return 'badobject'
                # abstract which is stratified if types of parameters are ignored -- badobject.
                if tt2=='badprop':  return 'class'
                # proper class
                return type(T[2][2])+1
                # the usual typing, one type higher than the t in the complex binder t R u
                
            if tt2=='prop' and freevars(T)==[]: return 'object' #complex term binder case
            # closed stratified abstract is untyped
            if not meets(freevars2(T[2]),freevars2(T[3])) \
                  and (tt2=='prop' or freevars(T)==[]): return 'object'
            # stratified s.c. bounded abstract or closed s.c. bounded unstratified abstract
            if not meets(freevars2(T[2]),freevars2(T[3])):  return 'badobject'
            #s.c. bounded unstratified abstract with parameters
            LL = listminus(freevars2(T[3]),freevars2(T[2]))
            if type(T[3])=='badprop' and type(newboundvarfix1(LL,LL,T[3]))=='prop':  return 'badobject'
            # abstract which is stratified if parameters are viewed as constants:  badobject
            if tt2=='badprop':  return 'class'
            # proper class
            #if type(T[2])=='object': return 'object'
            # this is not incorrect, but I think it is redundant
            return type(T[2])+1 # the usual type
        #ability to recognize that sets are of an s.c. type is needed
        
        if op[1]==':>':   # function terms.  These have not been updated with complex binders or NFU* comprehension.
            # I have no intention of introducing class functions but I do want to introduce NFU* facilities:
            # s.c. input and output allows stratification requirements to be lifted.  I am uncertain about
            # complex binders.
            
            if tt2=='prop' or tt2=='badprop':
                printerror('function body should not be a proposition?\n')
                return 'bad'  #body should not be a proposition
            if tt2=='badobject':
                printerror('Unstratified function body')
                return 'bad'  #body must be stratified (no updates yet, this can be modified)
            if not T[2][0]=='variable':
                printerror('left term of function abstract should be variable?\n')
                return 'bad'  #no complex binders yet
            if freevars(T)==[]:  return 'object'
            # constants are untyped
            if not T[2] in freevars2(T[3]) and tt2=='object':  return 'object'
            # in this case a function is type shiftable though it may have s.c. parameters
            if not tt2==type(T[2]):
                printerror('types of left term and body of a function abstract should match?\n')
                return 'bad'  # stratification failure as the message indicates
            return tt2+1  # the usual type outcome
        if not op[1] in list(optypes.keys()): #experiment in automatic declaration
            if isupper(op[1][0]) and op[1][0]>'O':  declarerelation(op[1])
            if isupper(op[1][0]) and op[1][0]<='O':  declareoperation(op[1])
        if not op[1] in list(optypes.keys()):  #undeclared binary operator
            printerror('undeclared binary operator?\n')
            return 'bad'
        opt=optypes[op[1]]
        #print('operation type is '+str(opt))
        if not len(opt)==3:  # unary operator used as binary, badly formed
            printerror('unary operator used as binary?\n')
            return 'bad'
        # in the next two cases, check that inputs expected to be propositions
        # actually are propositions (prop or badprop):  report badly formed otherwise.
        if opt[1]=='prop' and not (tt1=='prop' or tt1 =='badprop'):
            printerror('left argument not a proposition?\n')
            return 'bad'
        if opt[2]=='prop' and not (tt2=='prop' or tt2=='badprop'):
            printerror('right argument not a proposition?\n')
            return 'bad'
        #handle terms with expected proposition output.
        if opt[0]=='prop':
            if opt[1]=='prop' or opt[2]=='prop':
                if tt1=='badprop' or tt2=='badprop':  return 'badprop'
                return 'prop'
            # in fact, if either input is expected to be prop, the other
            # input and the output are expected to be prop. Return badprop
            # if either input is badprop, otherwise return prop.

            # second output can be a class if the operator is IN
            
            if tt1 =='badobject' or tt2 == 'badobject' or tt2=='class':  return 'badprop'

            # at this point we expect both inputs to be of object types.
            # If either is unstratified (badobject) report badobject as the type.
            
            if tt1=='object' or tt2=='object':  return 'prop'

            # if either input is type-shiftable, stratification failure
            # cannot occur here and we have a prop.
            
            if opt[1]=='object' or opt[2]=='object':  return 'prop'

            # if either input is expected to be type-shiftable, ditto.
            
            if tt1-tt2==opt[1]-opt[2]:  return 'prop'

            # at this point we know that both the expected types and the actual
            # types are integers and we can do the stratification check.
            
#            print('\nstratification failure in binary proposition subterm?\n')
            return 'badprop'  # if stratification fails, we have badprop
        
        if tt1=='badprop' or tt2=='badprop' or tt1=='prop' or tt2=='prop':  return 'bad'

        # beyond this point, proposition input is not expected.
        
        if opt[0]=='object':
            #if opt[1]=='prop' or opt[2]=='prop':  return 'prop'
            if tt1=='badobject' or tt2=='badobject': return 'badobject'
            if tt1=='object' or tt2=='object':  return 'object'
            if opt[1]=='object' or opt[2]=='object':  return 'object'
            if tt1-tt2==opt[1]-opt[2]:  return 'object'
#            print('\nstratification failure in binary sc subterm?\n')
            return 'badobject'
        # binary operation on objects with s.c. output.  If either argument is badobject,
        # return badobject (stratification failure).  Then if either expected input or actual input
        # is object (s.c) no stratification failure can occur, and return object.  Then do the
        # standard stratification check of the inputs and return object or badobject accordingly.
        
#        if opt[1]=='prop' or tt1=='object':
#            if opt[2]=='prop' or tt2=='object': return 'object'
#            return tt2+(opt[0]-opt[2])

# this doesn't respect my expectation that any operation with a prop input has all
# inputs and output prop.  If this changes something like this might be wanted.

        # down to object input, integer typed expected output
        
        if tt1 == 'badobject' or tt2 == 'badobject': return 'badobject'

        # stratification failure in an argument
        
        if opt[1]=='object' and opt[2]=='object':  return 'object'

        # both inputs are expected to be s.c., so output is object.  There really
        # shouldn't be operators of this sort of type.
        
        if tt1=='object' and tt2=='object':  return 'object'

        # the actual types of both inputs are s.c., so the output is s.c.
        
        if opt[1]=='object' or tt1=='object':  return tt2+(opt[0]-opt[2])

        # if the actual or expected left type is s.c., use the right argument
        # to compute the type differential (no failure possible).
        
        if opt[2]=='object' or tt2=='object':
              return tt1+(opt[0]-opt[1])

        # ditto for the right argument.
            
        if tt1-tt2==opt[1]-opt[2]: return tt1+(opt[0]-opt[1])

        # if both inputs have integer type, we must check stratification and return the
        # expected type if appropriate.
        
        return 'badobject'  # otherwise report stratification failure
    
    #for any other atomic term...
    return 'object'

# the binders A and E are set by force to precedences that cannot be changed again.
# these are the universal and existential quantifiers.
# an ability to declare and define binders might be wanted; this
# would involve the same approach to precedence.
# something to do with even more care would be to allow defined quantifiers,
# which could usefully be applied to proper classes.

# AR and ER are the restricted universal and existential quantifiers, added
# in Dec 2018 updates.

declarequantifier('A')
declarequantifier('E')
declarequantifier('AR')
declarequantifier('ER')

declarerelation('=')
declaretypedrelation('IN',1)
declaretypedrelation('INR',1)
declareunary('~','prop','prop')
declarebinary('V','prop','prop','prop')
declarebinary('->','prop','prop','prop')
declarebinary('==','prop','prop','prop')
declarebinary('&','prop','prop','prop')

declarebinary('`',0,1,0)

# again, the definite description operator is a binder.

declaretypedfunctionbinder('THE',-1)
setprec('THE',0)

setprec('`',floor4)
setprecevenabove('->','==')

# conjunction and disjunction group to the left because this
# allows unpacking of conjunctions as premises and disjunctions
# as conclusions in the most efficient way.

setprecoddabove('V','->')
setprecoddabove('&','V')
setprecoddabove('~','&')

# substitution is next

# the type formerly called 'constant' is now called 'object':  it is inhabited
# by terms bounded in a strongly cantorian range (including but not restricted
# to constant terms).

# It is important to notice that bound variable conflict is not a thing:  no
# term containing a free occurrence of a bound variable can be substituted for
# a variable, so bound variable capture cannot occur.

# failure to maintain this condition is a sort of bug which must be watched for

# substitution into abstractions is only blocked in the way one might expect when
# the binder term is a variable:  substitution into complex binders proceeds by the usual
# textual procedure.  Check that this does not need to be modified now that we have
# the avar device.

# substitution of classes for variables is now supported, as long as it is only
# into contexts where classes are allowed to appear.

def substitute(t,v,T):
     global theproof
     
     if not (v[0]=='variable' or v[0]=='constant' or v[0]=='instantiable'):  return T
     if T[0]=='operator':  return T
     if (not (type(t)=='object' or type(t)=='class')) or not freevars(t)==[]:
         printerror('term to be substituted is not an object or class term or contains free variables?\n')
         return T
     #if type(T)=='bad': return T

     # the function of this strange line is to update the new object index when what is being
     # done is replacing a local constant or instantiable with a term.  All updates of nextobjectindex
     # are actually done by the term parse and display functions.  This line does work
     # when a substitution is made for a constant or instantiable in a theorem or definition
     # which forces an update of the next object index:  of course the update associated
     # with a local constant or instantiable introduced in the current proof has already
     # been done when we viewed the sequent introducing it.

     termprint(v)
     
    
     if type(t)=='object' and (T[0]==v[0]) and T==v: return t
     if type(t)=='class' and T[0]=='unary' and prec(T[1][1])==0 and ((T[2])==(v)):
         return ['unary',T[1],t]
     if type(t)=='class' and T[0]=='binary' and (opof(T)[1]=='IN' or opof(T)[1]=='INR') and ((T[3])==(v)):
         return ['binary',T[1],substitute(t,v,T[2]),t]
     if type(t)=='class' and ((T)==(v)):
          printerror('class term substituted in inappropriate context')
          return T
     if T[0]=='unary':  return ['unary',T[1],substitute(t,v,T[2])]
     if T[0]=='binary':
         if T[1][1]==':' or T[1][1]==':>':
             if v[0]=='variable' and not(v in freevars(T)):  return T
             return ['binary',T[1],substitute(t,v,T[2]),substitute(t,v,T[3])]
         return ['binary',T[1],substitute(t,v,T[2]),substitute(t,v,T[3])]
     return T

# new bound variable fixes for complex binders and generally for matching inside abstractions:
# newboundvarfix1 and newboundvarfix2 replace bound variables with constants (with negative index)
# to make matching possible; newboundvarfix3 restores bound variables when emerging from matching
# internal to abstractions.

def newboundvarfix1(L,M,t):
    if not len(L)==len(M):
        return t
    if L==[]:
        return t
    return substitute(['constant',termprint(L[0])+termprint(M[0]),str(-len(termprint(t)))],\
         L[0],newboundvarfix1(L[1:],M[1:],t))

def newboundvarfix2(L,M,t):
    if not len(L)==len(M):
        return t
    if L==[]:
        return t
    return substitute(['constant',termprint(L[0])+termprint(M[0]),str(-len(termprint(t)))],\
         M[0],newboundvarfix2(L[1:],M[1:],t))

def newboundvarfix3(L,t,u):
    if L==[]: return t
    return substitute(L[0],['constant',termprint(L[0])+termprint(L[0]),str(-len(termprint(t)))],
         newboundvarfix3(L[1:],t,u))

# rules for use in equality substitutions
# versions usable for propositions with biconditionals are very similar

# equality rules on left will also require rotations of all assumptions except the first,
# to bring the desired equation into second position

# substitute one constant term for another everywhere.  This version is not assisted
# by matching as the other two are (in global substitution, how are we to decide which match
# to apply?

def strongsubstitute(a,b,T):
     if not (type(a) == type(b))  or not freevars(a)==[] or not freevars(b)==[]:
         printerror('term to be substituted (for?)\
is not an object term or contains free variables?\n')
         return T
     if type(T)=='bad': return T
     if matches(T,a):  return b
     if T[0]=='unary':  return ['unary',T[1],strongsubstitute(a,b,T[2])]

     if T[0]=='binary' and (T[1]==':' or T[1]==':>') and type(T[2])=='prop'\
        and T[2][0]=='binary' and not(type(T[2][2])=='prop') and not(type(T[2][3])=='prop'):
              return ['binary',T[1],\
                                 newboundvariablefix3(freevars(T[2][2]),T[2],\
                                    strongsubstitute(a,b,\
                                        newboundvariablefix1(freevars(T[2][2]),freevars(T[2][2]),T[2])))\
                                    ,newboundvariablefix3(freevars(T[2][2]),T[3],\
                                                          strongsubstitute(a,b,\
                                        newboundvariablefix1(freevars(T[2][2]),freevars(T[2][2]),T[3])))]
     
     if T[0]=='binary' and (T[1]==':' or T[1]==':>') and not(T[2][0]=='variable'):
            return ['binary',T[1],\
                                 newboundvariablefix3(freevars(T[2]),T[2],\
                                    strongsubstitute(a,b,\
                                        newboundvariablefix1(freevars(T[2]),freevars(T[2]),T[2])))\
                                    ,newboundvariablefix3(freevars(T[2]),T[3],\
                                                          strongsubstitute(a,b,\
                                        newboundvariablefix1(freevars(T[2]),freevars(T[2]),T[3])))]

     
     if T[0]=='binary':  return ['binary',T[1],\
                                 strongsubstitute(a,b,T[2]),strongsubstitute(a,b,T[3])]
     return T

# substitute leftmost occurrence only
    
def strongsubstitute1(a,b,T):
     if not (type(a)==type(b)) or not freevars(a)==[] or not freevars(b)==[]:
         printerror('term to be substituted (for?)\
is not an object term or contains free variables?\n')
         return T
     if type(T)=='bad': return T
#     if matches(T,a):  return b
     if matches(T,b):  return b

     if T[0]=='binary' and (T[1]==':' or T[1]==':>') and type(T[2])=='prop'\
        and T[2][0]=='binary' and not(type(T[2][2])=='prop') and not(type(T[2][3])=='prop'):
         A=strongsubstitute1(a,b,newboundvarfix1(freevars(T[2][2]),freevars(T[2][2]),T[2]))
         if matches(A,newboundvarfix1(freevars(T[2][2]),freevars(T[2][2]),T[2])):
             if matches(T,a):  return b
             return ['binary',T[1],T[2],newboundvarfix3(freevars(T[2][2]),T[3],\
                                                        strongsubstitute1(a,b,\
                            newboundvarfix1(freevars(T[2][2]),freevars(T[2][2]),T[3])))]
         return ['binary',T[1],newboundvarfix3(freevars(T[2][2]),T[2],A),T[3]]

        
     if T[0]=='binary' and (T[1]==':' or T[1]==':>') and not(T[2][0]=='variable'):
         A=strongsubstitute1(a,b,newboundvarfix1(freevars(T[2]),freevars(T[2]),T[2]))
         if matches(A,newboundvarfix1(freevars(T[2]),freevars(T[2]),T[2])):
             if matches(T,a):  return b
             return ['binary',T[1],T[2],newboundvarfix3(freevars(T[2]),T[3],\
                                                        strongsubstitute1(a,b,\
                            newboundvarfix1(freevars(T[2]),freevars(T[2]),T[3])))]
         return ['binary',T[1],newboundvarfix3(freevars(T[2]),T[2],A),T[3]]
     
     if T[0]=='binary':
         A=strongsubstitute1(a,b,T[2])
         if matches(A,T[2]):
             if matches(T,a):  return b
             return ['binary',T[1],T[2],strongsubstitute1(a,b,T[3])]
         return ['binary',T[1],A,T[3]]
        
     if matches(T,a):  return b
     if T[0]=='unary':  return ['unary',T[1],strongsubstitute1(a,b,T[2])]
     return T

def ssbtest(a,b,T):  return strongsubstitute1(parse(a),parse(b),parse(T))

def meets(L,M):
    if L==[]:return False
    if M==[]:  return False
    return str(L[0]) == str(M[0]) or meets([L[0]],M[1:]) or meets(L[1:],M)

def domain(X):
    if X==[]:  return []
    return [X[0][0]]+(domain(X[1:]))

# generate a substitution into a and b (with no effect on T) which will allow the
# intended substitution into T to be carried out.

def strongsubstitutematch1(a,b,T):
     if not (type(a)==type(b)) or not freevars(a)==[] or not freevars(b)==[]:
         return 'fail'
     if type(T)=='bad': return 'fail'
#     M=supermatch(a,T)
#     if not(M=='fail'):  return M
     if matches(b,T):  return 'fail'

     if T[0]=='binary' and (T[1]==':' or T[1]==':>') and type(T[2])=='prop'\
        and T[2][0]=='binary' and not(type(T[2][2])=='prop') and not(type(T[2][3])=='prop'):
         
         A=strongsubstitutematch1(a,b,newboundvarfix1(freevars(T[2][2]),freevars(T[2][2]),T[2]))
         if A=='fail':
             M=supermatch(a,T)
             if (not(M=='fail'))  and not(meets(domain(M),generalities(T))):  return M
             return strongsubstitutematch1(a,b,\
                        newboundvarfix1(freevars(T[2][2]),freevars(T[2][2]),T[3]))
         return A

     if T[0]=='binary' and (T[1]==':' or T[1]==':>') and not(T[2][0]=='variable'):
         A=strongsubstitutematch1(a,b,newboundvarfix1(freevars(T[2]),freevars(T[2]),T[2]))
         if A=='fail':
             M=supermatch(a,T)
             if (not(M=='fail'))  and not(meets(domain(M),generalities(T))):  return M
             return strongsubstitutematch1(a,b,newboundvarfix1(freevars(T[2]),freevars(T[2]),T[3]))
         return A
     
     if T[0]=='binary':
         A=strongsubstitutematch1(a,b,T[2])
         if A=='fail':
             M=supermatch(a,T)
             if (not(M=='fail'))  and not(meets(domain(M),generalities(T))):  return M
             return strongsubstitutematch1(a,b,T[3])
         return A
     M=supermatch(a,T)
     if (not(M=='fail')) and not(meets(domain(M),generalities(T))):  return M
     if T[0]=='unary':  return strongsubstitutematch1(a,b,T[2])
     return 'fail'

def ssmtest(a,b,T):  return strongsubstitutematch1(parse(a),parse(b),parse(T))

# substitute rightmost occurrence only
    
def strongsubstitute2(a,b,T):
     if not (type(a) == type(b)) or not freevars(a)==[] or not freevars(b)==[]:
         printerror('term to be substituted (for?) is \
not an object term or contains free variables?\n')
         return T
     if type(T)=='bad': return T
#     if matches(T,a):  return b
     if matches(T,b):  return b

     if T[0]=='binary'  and (T[1]==':' or T[1]==':>') and type(T[2])=='prop'\
        and T[2][0]=='binary' and not(type(T[2][2])=='prop') and not(type(T[2][3])=='prop'):
         A=strongsubstitute2(a,b,newboundvarfix1(freevars(T[2][2]),freevars(T[2][2]),T[3]))
         if matches(A,newboundvarfix1(freevars(T[2][2]),freevars(T[2][2]),T[3])):
             if matches(T,a):  return b
             return ['binary',T[1],newboundvarfix3(freevars(T[2][2]),T[2],\
                strongsubstitute2(a,b,newboundvarfix1(freevars(T[2][2]),freevars(T[2][2]),T[2]))),T[3]]
         return ['binary',T[1],T[2],newboundvarfix3(freevars(T[2][2]),T[3],A)]
     if matches(T,a):  return b

     if T[0]=='binary'  and (T[1]==':' or T[1]==':>') and not(T[2][0]=='variable'):
         A=strongsubstitute2(a,b,newboundvarfix1(freevars(T[2]),freevars(T[2]),T[3]))
         if matches(A,newboundvarfix1(freevars(T[2]),freevars(T[2]),T[3])):
             if matches(T,a):  return b
             return ['binary',T[1],newboundvarfix3(freevars(T[2]),T[2],\
                strongsubstitute2(a,b,newboundvarfix1(freevars(T[2]),freevars(T[2]),T[2]))),T[3]]
         return ['binary',T[1],T[2],newboundvarfix3(freevars(T[2]),T[3],A)]
     if matches(T,a):  return b

     
     if T[0]=='binary':
         A=strongsubstitute2(a,b,T[3])
         if matches(A,T[3]):
             if matches(T,a):  return b
             return ['binary',T[1],strongsubstitute2(a,b,T[2]),T[3]]
         return ['binary',T[1],T[2],A]
     if matches(T,a):  return b
     
     if T[0]=='unary':  return ['unary',T[1],strongsubstitute2(a,b,T[2])]
     return T

# generate a substitution into a and b (with no effect on T) which will allow the intended
# substitution into T to be carried out.

def strongsubstitutematch2(a,b,T):
     if not (type(a)==type(b)) or not freevars(a)==[] or not freevars(b)==[]:
         return 'fail'
     if type(T)=='bad': return 'fail'
#     M=supermatch(a,T)
#     if not(M=='fail'):  return M
     if matches(b,T):  return 'fail'

     if T[0]=='binary'  and (T[1]==':' or T[1]==':>') and type(T[2])=='prop'\
        and T[2][0]=='binary' and not(type(T[2][2])=='prop') and not(type(T[2][3])=='prop'):
         
         A=strongsubstitutematch2(a,b,newboundvariablefix1(freevars(T[2][2],freevars(T[2][2]),T[3])))
         if A=='fail':
             M=supermatch(a,T)
             if not(M=='fail')   and not(meets(domain(M),generalities(T))):  return M
             return strongsubstitutematch2(a,b,\
                            newboundvariablefix1(freevars(T[2][2]),freevars(T[2][2],T[2])))
         return A

     if T[0]=='binary'  and (T[1]==':' or T[1]==':>') and not(T[2][0]=='variable'):
         A=strongsubstitutematch2(a,b,newboundvariablefix(freevars(T[2]),freevars(T[2]),T[3]))
         if A=='fail':
             M=supermatch(a,T)
             if not(M=='fail')   and not(meets(domain(M),generalities(T))):  return M
             return strongsubstitutematch2(a,b,newboundvarfix1(freevars(T[2]),freevars(T[2]),T[2]))
         return A
     
     if T[0]=='binary':
         A=strongsubstitutematch2(a,b,T[3])
         if A=='fail':
             M=supermatch(a,T)
             if not(M=='fail')   and not(meets(domain(M),generalities(T))):  return M
             return strongsubstitutematch2(a,b,T[2])
         return A
        
     M=supermatch(a,T)
     if not(M=='fail') and not(meets(domain(M),generalities(T))):  return M
     if T[0]=='unary':  return strongsubstitutematch2(a,b,T[2])
     return 'fail'

def ssmtest2(a,b,T):  return strongsubstitutematch2(parse(a),parse(b),parse(T))

oldobjectindex=1
thedifferential=0

# this function replaces all constants and instantiables in a term
# with instantiables of high index (above that of the current working
# index)

# a possible update of the complex binder proof strategies would be to use
# this function (and a correlated one for constants) instead of existential
# and universal closures, as is done in the ML version.

def instsubstitute0(T):
    global oldobjectindex
    if T[0]=='unary':  return ['unary',T[1],instsubstitute0(T[2])]
    if T[0]=='binary':  return ['binary',T[1],instsubstitute0(T[2]),instsubstitute0(T[3])]
    if (T[0]=='constant' or T[0]=='instantiable') and len(T)==3:
        return['instantiable',T[1],str(int(T[2])+oldobjectindex)]
    return T

# replace the propositional variable v with the proposition (with no
# free occurrences of bound variables) t in the term T.
    
def propsubstitute(t,v,T):
     global theproof
     if not (v[0]=='propvar'):
         printerror('target not propositional variable?\n')
         return T
     if not type(t)=='prop':
         printerror('source not proposition?\n')
         return T
     if not freevars(t)==[]:
         printerror('source contains free variables?\n')
         return T
     if T[0]=='operator':  return T
     if type(T)=='bad': return T
     if termprint(T)==termprint(v): return t
     if T[0]=='unary':  return ['unary',T[1],propsubstitute(t,v,T[2])]
     if T[0]=='binary':
#         if T[1][1]==':' or T[1][1]==':>' and T[2][0]=='variable':
#             if termprint(T[2])==termprint(v):  return T
#             return ['binary',T[1],propsubstitute(t,v,T[2]),propsubstitute(t,v,T[3])]
         return ['binary',T[1],propsubstitute(t,v,T[2]),propsubstitute(t,v,T[3])]
     return T

def opprint(op):
    if not len(op)==2 and not len(op)==3:  return '_bad_'
    if len(op)==2:  return op[1]
    if len(op)==3:  return op[1]+'_'+op[2]

# replace an indexed operator with another operator of the same type signature

def opsubstitute(t,v,T):
    global theproof
    if len(v) == 0 or not (v[0]=='operator'):
        printerror('target is not an operator?\n')
        return T
    if not len(v)==3:
        printerror('target is not a variable operator?\n')
        return T
    if len(t)==0 or not (t[0]=='operator'):
        printerror('source is not an operator?\n')
        return T
    if not optypes[t[1]]==optypes[v[1]]:
        printerror('source and target do not match in type?\n')
        return T
    if T[0]=='unary':
        if opprint(T[1])==opprint(v):  return ['unary',t,opsubstitute(t,v,T[2])]
        return ['unary',T[1],opsubstitute(t,v,T[2])]
    if T[0]=='binary':
        if opprint(T[1])==opprint(v):  \
           return ['binary',t,opsubstitute(t,v,T[2]),opsubstitute(t,v,T[3])]
        return ['binary',T[1],opsubstitute(t,v,T[2]),opsubstitute(t,v,T[3])]
    return T
    
def testsub(t,v,T):  return termprint(opsubstitute(getident(t)[0],getident(v)[0],parse(T)))

# matching and unification work area

# find all the non-bound generalizable terms in T

def generalities(T):
    if len(T)==0: return []
    if T[0] == 'propvar':  return [T]
    if T[0] == 'constant' and len(T)==3:  return [T]
    if T[0] == 'instantiable' and len(T)==3:  return [T]
    if T[0] == 'unary' and len(T[1])== 3:  return [T[1]]+generalities(T[2])
    if T[0] == 'unary':  return generalities(T[2])
    if T[0] == 'binary' and len(T[1])==3:  return [T[1]]+generalities(T[2])+generalities(T[3])
    if T[0] == 'binary':  return generalities(T[2])+generalities(T[3])
    return []

def generalsubstitute(t,v,T):
    if v[0]=='instantiable': return(substitute(t,v,T))
    if v[0]=='propvar':  return (propsubstitute(t,v,T))
    if v[0]=='operator':return (opsubstitute(t,v,T))
    return T

# remove redundant items from substitutions
# (I am to some extent guessing what this does:  track down its use)

def allapply(t,v,L):
    if L==[]:  return []
    if L=='fail':  return 'fail'
    M=generalsubstitute(t,v,L[0][1])
    if M==L[0][0]: return allapply(t,v,L[1:])
    return [[L[0][0],M]]+allapply(t,v,L[1:])

# block substitutions for generalities in the target term
# (I am to some extent guessing what this does:  track down its use)

def subcollapse(L):
    if L==[]:  return []
    if L=='fail':  return 'fail'
    if L[0][0] in generalities(L[0][1]):  return 'fail'
    M=subcollapse(allapply(L[0][0],L[0][1],L[1:]))
    if M=='fail':  return 'fail'
    return [L[0]]+M

# merging matching lists

def findintable(x,L):
    if L==[]: return []
    if L[0][0]==x:  return [L[0][1]]
    return findintable(x,L[1:])

def merge(x,y):
    if x=='fail' or y=='fail':  return 'fail'
    if x==[] or y==[]:  return x+y
    if findintable(x[0][0],y)==[]:  return [x[0]]+merge(x[1:],y)
    M=supermatch(x[0][1],findintable(x[0][0],y)[0])
    if M=='fail':  return 'fail'
    if not(findintable(x[0][0],M)==[]): return 'fail'
    return subcollapse(merge(M,merge(x[1:],y)))

#this includes a hack for alpha equivalence

#the idea is that the output is initial data for a set
#of substitutions for instantiables, propositional variables, and variable
#operators which will make the terms the same

# this is the unification function.  It generates a list of substitutions
# for instantiables or proposition/operator variables in terms S and
# T which will cause them to coincide.  It does not record trivial
# substitutions.

# It now includes use of definitional equivalence to force a match, not necessarily
# in the most efficient way (fix this).

# attempts to match an instantiable with a class will fail silently (no error message).

def supermatch(S,T):
    if termprint(S)==termprint(T):  return []
    if S[0]=='operator' and T[0]=='operator' \
       and len(S)==3 and not(S in generalities(theproof[0][2][0][0])):  return [[S,T]]
    if T[0]=='operator' and S[0]=='operator' \
       and len(T)==3 and not(T in generalities(theproof[0][2][0][0])):  return [[T,S]]
    if S[0] == 'propvar' and type(T) == 'prop' \
       and freevars(T) == [] and not(S in generalities(theproof[0][2][0][0])):  return [[S,T]]
    if T[0] == 'propvar' and type(S) == 'prop' \
       and freevars(S) == [] and not(T in generalities(theproof[0][2][0][0])):  return [[T,S]]
    if S[0] == 'instantiable' and int(S[2])>= 0 \
       and type(T)=='object' and freevars(T)==[]\
       and maxindex(T)<int(S[2]) and not(minindex(T)<-1) \
       and not(S in generalities(theproof[0][2][0][0])):
           return[[S,T]]
    if T[0] == 'instantiable' and int(T[2])>=0 and type(S)=='object' and freevars(S)==[]\
       and maxindex(S)<int(T[2]) and not(minindex(S)<-1) \
       and not(T in generalities(theproof[0][2][0][0])):
           return[[T,S]]
    if S[0] == 'unary' and len(S[1]) == 3 and T[0] == 'unary':
        return merge([[S[1],T[1]]],supermatch(S[2],T[2]))
    if T[0] == 'unary' and len(T[1]) == 3 and S[0] == 'unary':
        return merge([[T[1],S[1]]],supermatch(S[2],T[2]))
    if S[0] == 'unary' and T[0] == 'unary' and S[1]==T[1]:  return supermatch(S[2],T[2])
    
    if S[0] == 'binary' and T[0] == 'binary' and S[1]==T[1]\
       and (S[1][1]==':' or S[1][1]==':>') and S[2][0]=='variable' and T[2][0]=='variable':
        return supermatch\
               (substitute(['constant','0',str(-len(termprint(S[3])))],S[2],S[3]),\
            substitute(['constant','0',str(-len(termprint(S[3])))],T[2],T[3]))
    
    if S[0] == 'binary' and T[0] == 'binary' and S[1]==T[1]\
       and (S[1][1]==':' or S[1][1]==':>') and type(S[2]) == 'prop' and type(T[2]) == 'prop'\
       and S[2][0]=='binary' and T[2][0]=='binary'\
       and not(type(S[2][2])=='prop') and not (type(S[2][3])=='prop')\
       and not(type(T[2][2])=='prop') and not (type(T[2][3])=='prop'):
        
           return merge(supermatch(newboundvarfix1(freevars(S[2][2]),freevars(T[2][2]),S[2]),\
                                newboundvarfix2(freevars(S[2][2]),freevars(T[2][2]),T[2])),\
                        supermatch(newboundvarfix1(freevars(S[2][2]),freevars(T[2][2]),S[3]),\
                                newboundvarfix2(freevars(S[2][2]),freevars(T[2][2]),T[3])))
        
    if S[0] == 'binary' and T[0] == 'binary' and S[1]==T[1]\
       and (S[1][1]==':' or S[1][1]==':>'):
           return merge(supermatch(newboundvarfix1(freevars(S[2]),freevars(T[2]),S[2]),\
                             newboundvarfix2(freevars(S[2]),freevars(T[2]),T[2])),\
                  supermatch(newboundvarfix1(freevars(S[2]),freevars(T[2]),S[3]),\
                             newboundvarfix2(freevars(S[2]),freevars(T[2]),T[3])))
                  
    if T[0] == 'binary' and S[0] == 'binary' and S[1]==T[1]:
        return merge(supermatch(S[2],T[2]),supermatch(S[3],T[3]))
    if S[0] == 'binary' and T[0] == 'binary' and len(S[1]) == 3\
       and optypes[S[1][1]]==optypes[T[1][1]]:
        return merge([[S[1],T[1]]],merge(supermatch(S[2],T[2]),supermatch(S[3],T[3])))
    if T[0] == 'binary' and S[0] == 'binary' and len(T[1]) == 3\
       and optypes[S[1][1]]==optypes[T[1][1]]:
        return merge([[T[1],S[1]]],merge(supermatch(S[2],T[2]),supermatch(S[3],T[3])))
    S2=defexpand(S)
    T2=defexpand(T)
    if not(S2==S): return supermatch(S2,T)
    if not(T2==T): return supermatch(S,T2)

    
    return 'fail'

# in complex binders, we strongly rely on the hypothesis that free variable lists
# of terms that match will have their free variables in the same order.

# execute a list of substitutions

def executelist(L):
    global theproof
    if L==[]:  return 'done'
    if L[0][0][0]=='instantiable':
        theproof=instantiate(L[0][1],L[0][0],theproof)
        executelist(L[1:])
    if L[0][0][0]=='propvar':
        theproof=propproofsub(L[0][1],L[0][0],theproof)
        executelist(L[1:])
    if L[0][0][0]=='operator':
        theproof=opproofsub(L[0][1],L[0][0],theproof)
        executelist(L[1:])

# this function is not used.

def executematchsubs(L,T):
    if L==[]:  return T
    if L[0][0][0]=='instantiable':  return substitute(L[0][1],L[0][0],executematchsubs(L[1:],T))
    if L[0][0][0]=='propvar':  return propsubstitute(L[0][1],L[0][0],executematchsubs(L[1:],T))
    if L[0][0][0]=='operator':  return opsubstitute(L[0][1],L[0][0],executematchsubs(L[1:],T))
    return T

# carry out the global substitutions in the current proof which will
# make S and T coincide.

def executematch(S,T):
    global theproof
    M=supermatch(S,T)
    if M=='fail':  return 'match fail'
    executelist(M)
        
def smtest(S,T):
    return supermatch(parse(S),parse(T))       
                                                                


# basic functions for sequent display

showgen = False

#this command causes genealogies of sentences to be displayed.
#its really a debugger command not a user command.

def showgenealogy():
    global showgen
    showgen= not(showgen)

helpdict["showgenealogy"]="showgenealogy(): \
toggle whether genealogy is displayed.  Not practical for users, a debugger command"

# this function suppresses genealogies in the display
# (the default situation).

def gendisplay(s):
    if not(showgen):  return ''
    return s

# commands for displaying lists of propositions with numbers.

def printproplist0(L,n):
    if len(L)==0: return '\n'
    #if not type(L[0][0])=='prop':  return '\n'
    return str(n)+":  "+termprint(L[0][0])+'  '\
           +(gendisplay(str(L[0][1])))+'\n'+printproplist0(L[1:],n+1)

def printproplist(L):  return printproplist0(L,1)

# commands for generating the list of second and subsequent alternative
# conclusions, negated, as starred premises.

def printpropliststar0(L,n):
    if len(L)==0: return '\n'
    if not type(L[0][0])=='prop':  return '\n'
    return str(n)+"*:  "+termprint(L[0][0])+ '  '\
           + gendisplay(str(L[0][1]))+'\n'+printpropliststar0(L[1:],n+1)

def printpropliststar(L):  return printpropliststar0(L,1)

# a sequent is a natural number identifier and two lists of propositions with appended dependency information

# global variable indicating a constructive proof

# I think oneconclusion2 is incompatible with constructive logic.  Fix?

constructive = False

oneconclusion=False

oneconclusion2 = False

# these user commands control the display of a single conclusion
# (in two different styles) or of multiple conclusions.  The Oneconclusion2
# style keeps the internal structure of many conclusions and displays
# second and subsequent conclusions as starred (negated) premises. The
# Oneconclusion2 style slams the second and subsequent conclusions into
# the actual premise list after negating them.  OneConclusion2()
# is the default state; the others may sometimes be desirable.

def Oneconclusion():
    usercommand('\n\nOneconclusion()\n')
    global oneconclusion
    oneconclusion=True

helpdict["Oneconclusion"]="Oneconclusion(): \
use the format with alternative conclusions displayed as negated premises:  default [OC1]"
helpdict["OC1"]="OC1: \
use the format with alternative conclusions displayed as negated premises:  default [Oneconclusion()]"

def Manyconclusions():
    usercommand('\n\nManyconclusions()\n')
    global oneconclusion
    oneconclusion=False

helpdict["Manyconclusions"]="Manyconclusions(): \
display alternative conclusions in positive form below the first conclusion [MC1]"
helpdict["MC1"]="MC1: \
display alternative conclusions in positive form below the first conclusion [Manyconclusions()]"

def Oneconclusion2():
    usercommand('\n\nOneconclusion2()\n')
    global oneconclusion2
    if constructive == True:  print("Cannot go into this mode in constructive logic\n")
    if constructive == False: oneconclusion2=True

helpdict["Oneconclusion2"]="Oneconclusion2():\
coerce alternative conclusion to negative premises:  force one or no conclusions [OC2]"
helpdict["OC2"]="OC2:\
coerce alternative conclusion to negative premises:  force one or no conclusions [Oneconclusion2()]"

def Manyconclusions2():
    usercommand('\n\nManyconclusions2()\n')
    global oneconclusion2
    oneconclusion2=False

helpdict["Manyconclusions2"]="Manyconclusion2():\
turn off coercion of alternative conclusions to negative premises [MC2]"
helpdict["MC2"]="MC2:\
turn off coercion of alternative conclusions to negative premises [Manyconclusion2()]"

# put a fake negative on an alternative conclusion

def pseudonegate(T):  return ['unary',['operator','~'],T]

# ditto on a list of alternative conclusions

def pseudolist(L):
    if len(L)==0:  return L
    return [[pseudonegate(L[0][0]),L[0][1]]]+pseudolist(L[1:])

# display a sequent

def printsequent0(S):

    if oneconclusion and not len(S[2])==0:
        return str(S[0])+':\n\n'+printproplist(S[1])\
               +printpropliststar0(pseudolist(S[2][1:]),2)\
               +"-------------------\n\n"+printproplist([S[2][0]])+'\n\n'
    if oneconclusion or oneconclusion2 and len(S[2])==0:
        # notice display of fake absurd symbol for empty conclusion list in oneconclusion mode
        return str(S[0])+':\n\n'+printproplist(S[1])+"------------------\n\n_|_\n\n"
    return str(S[0])+':\n\n'+printproplist(S[1])+"------------------\n\n"\
           +printproplist(S[2])+'\n\n'

def printsequent(S):  return marginize(0,printsequent0(S))

# functions for forcibly moving alternative conclusions
# to negated premises in oneconclusion2 mode

def negate(T):
    if len(T)<2:  return ['unary',['operator','~'],T]
    if T[0]=='unary' and T[1]==['operator','~']:  return T[2]
    return ['unary',['operator','~'],T]

def neglist(L):
    if len(L)==0:  return L
    return [[negate(L[0][0]),L[0][1]]]+neglist(L[1:])

def transformsequent(S):
    if not oneconclusion2:  return S
    if len(S[2])==0:  return S
    return [S[0],S[1]+neglist(S[2][1:]),[S[2][0]]]

# a proof is a sequent paired with 'goal' or a list of proofs to be completed.
# a proof is complete if none of its subproofs contain 'goal'.

# we will want genealogy data in sequents or proofs somewhere in order to support
# automatic pruning.  Make simple version now:  but post-engineering is to be expected.

nextsequent=0

def makesequent(L,M,comment):
    global nextsequent
    nextsequent=nextsequent+1
    return (transformsequent(['Line '+str(nextsequent)+comment,L,M]))

# global variables for the genealogy feature -- linesused is a list of lines used in the
# current proof.  newlineindex is the first currently free line number.

linesused = []

newlineindex=1

# this user command starts the proof of a new theorem p.

def Start(p):
    global stopped
    global k
    global newlineindex
    usercommand('\n\nStart('+quotestr(p)+')\n')
    global nextobjectindex
    global linesused
    global backhistory
    global forwardhistory
    nextobjectindex=1
    newlineindex=1
    backhistory=[]
    forwardhistory=[]
    linesused =[]
    if not freevars(parse(p))==[]:
        printerror('term to be started contains free variables?\n')
        return 'bad'
    if not (type(parse(p))=='prop' or type(parse(p))=='badprop'):
        printerror('term to be started is not a proposition?\n')
        return 'bad'
    global nextsequent
    nextsequent=0
    global theproof
    theproof=[makesequent([],[[parse(p),[newlineindex]]],''),'goal']
    newlineindex=newlineindex+1
    print(printsequent(theproof[0]))


helpdict["Start"]="Start(p): start proof of p as a theorem [s]"
helpdict["s"]="s: start proof of p as a theorem [Start(p)]"

#is a given proof structure completely resolved?

def completeproof(P):
    global theproof
    if P[1]=='goal':  return False
    for Q in P[1]:
        if not completeproof(Q): return False
    return True

# rotateproof moves the first available goal into leftmost position
# when a proof becomes complete, auxilary functions move the component
# proofs into sensible order (that is the role of sequentproof and onerotate)

def sequentnumber(s):
    if len(s)<5 or not s[0:5] == 'Line ':  return -1
    return int(getinit(isnumeral,s[5:]))

# usually rotates once to put a proof of a too high numbered initial sequent
# at the end.  Might however be applied more than once, who knows?

def onerotate(P):
    if P[1]=='goal':  return P
    if P[1]==[]:  return P
    if len(P[1])==1 or sequentnumber(P[1][-1][0][0]) == -1\
       or sequentnumber(P[1][-1][0][0])>sequentnumber(P[1][0][0][0]):  return P
    return onerotate([P[0],P[1][1:]+[P[1][0]]])

def rotateproof(P):
    global theproof
    if completeproof(P): return onerotate(P)
    if P[1]=='goal':  return P
    if completeproof(P[1][0]): return rotateproof ([P[0],P[1][1:]+[onerotate(P[1][0])]])
    return [P[0],[rotateproof(P[1][0])]+P[1][1:]]

# rotate as the previous even if the current sequent is a goal.

def rotateproofB(P):
    global theproof
    if completeproof(P): return onerotate(P)
#    if P[1]=='goal':  return P
    if completeproof(P[1][0]): return rotateproof ([P[0],P[1][1:]+[onerotate(P[1][0])]])
    return [P[0],[rotateproof(P[1][0])]+P[1][1:]]

# a not very efficient way to traverse the proof tree
# it is guaranteed to visit every goal, but it may
# visit some goals more than once

def rotateproof2(P):
    if completeproof(P):  return P
    if P[1]=='goal':  return P
    return(rotateproof3(rotateproof([P[0],P[1][1:]+[P[1][0]]])))

def rotateproof3(P):
     return[P[0],[rotateproof2(P[1][0])]+P[1][1:]]

def rotateproof4(P):
    global theproof
    if completeproof(P): return P
    if P[1]=='goal': return P
    if P[1][0][1]=='goal':
        if len(P[1])<2:  return P
        return rotateproof([P[0],P[1][1:]+[P[1][0]]])
    return [P[0],[rotateproof4(P[1][0])]+P[1][1:]]

# show the leftmost goal

def shownextgoal(P):
    
    global theproof
    if theproof==theproof0:
        print('There is no goal\n')
        return 'fail'
    if P[1]=='goal':  print(printsequent(P[0]))
    if P[1]==[]:
        Autoprune()
        print('Q. E. D.\n')
        print(printsequent(theproof[0]))
    if not(P[1]=='goal') and not(len(P[1])==0):  shownextgoal(P[1][0])

# show the leftmost goal

def snapshot(P):
    
    global theproof
    if P[1]=='goal':
        print(printsequent(P[0]))
        logfile.write(inserthash(printsequent(P[0])))
    if P[1]==[]:
        Autoprune()
        print('Q. E. D.\n')
        print(printsequent(theproof[0]))
        logfile.write(inserthash(printsequent(theproof[0])))
    if not(P[1]=='goal') and not(len(P[1])==0):
        shownextgoal(P[1][0])
        snapshot(P[1][0])



# user command to show the next goal, in weird order guaranteed to traverse
# all goals, but with the possibility of repetitions

def Nextgoal():
    usercommand('Nextgoal()\n')
    global theproof
    theproof=rotateproof2(theproof)
    shownextgoal(theproof)

helpdict["Nextgoal"]="Nextgoal():\
display the next unproved goal in a weird order\
which will traverse all goals but possibly with repetitions [NG]"
helpdict["NG"]="NG:\
display the next unproved goal in a weird order\
which will traverse all goals but possibly with repetitions [Nextgoal()]"

# user command to rotate the set of goals most recently produced

def Swapgoals():
    global theproof
    usercommand('Swapgoals()\n')
    theproof=rotateproof4(theproof)
    shownextgoal(theproof)

helpdict["Swapgoals"]="Swapgoals(): \
rotate through the unproved goals with the same parent as the current goal [SG]"
helpdict["SG"]="SG: \
rotate through the unproved goals with the same parent as the current goal [Swapgoals()]"

# this is now equality up to alpha conversion (and definitional expansion)

def matches(P,Q):
    return supermatch(P,Q)==[]



# changing the constructive tag ends the current proof

def Constructive():
    global constructive
    global oneconclusion2
    usercommand('\nConstructive()\n')
    constructive = True
    oneconclusion2 = False
    Start('p?->p?')

helpdict["Constructive"]="Constructive(): \
turn on use of constructive logic.  Ends current proof. [Co]"
helpdict["Co"]="Co: \
turn on use of constructive logic.  Ends current proof. [Constructive()]"

def Classical():
    global constructive
    usercommand('\nClassical()\n')
    constructive = False
    oneconclusion2 = True
    Start('p?->p?')

helpdict["Classical"]="Claasical(): \
turn on use of classical (nonconstructive) logic.  Ends current proof [Cl]"
helpdict["Cl"]="Cl: \
turn on use of classical (nonconstructive) logic.  Ends current proof [Classical()]"

def concrush(S):
    if len(S[2])<2 : return S
    if constructive == False : return S
    return [S[0],S[1],[S[2][0]]]

def conlist(L):
    if constructive == True: return L
    return []

# apply a function to the leftmost goal

# the function f takes the sequent in the leftmost goal to a list of proofs
# modifying this for the correct action in constructive logic

def leftapply(f,P):
    global theproof
    if P[1]==[]: return P
    pp = concrush(P[0])
    if P[1]=='goal':  return rotateproof([pp,f(pp)])
    return rotateproof([P[0],[leftapply(f,P[1][0])]+P[1][1:]])

def act(f):
    global theproof
    theproof=leftapply(f,theproof)
    shownextgoal(theproof)

# the function f takes the sequent in the leftmost goal to a single proof

def leftapply2(f,P):
    global theproof
    if P[1]==[]: return P
    if P[1]=='goal':  return f(P[0])
    return rotateproof([P[0],[leftapply2(f,P[1][0])]+P[1][1:]])

def act2(f):
    global theproof
    theproof=leftapply2(f,theproof)
    shownextgoal(theproof)

# an internal use of act2 not visible at the user level,
# used in macro user commands to avoid subcommands being logged

def act2I(f):
    global theproof
    theproof=leftapply2(f,theproof)
#    shownextgoal(theproof)


#  we need a done function which takes a sequent with first
# props on both sides matching to the empty list of proofs.

# set up the substitution which will force first
# premise and conclusion to match, if there is one

# updating this so it will also enforce reflexivity of equality.

def forcedone():
    global theproof
    if completeproof(theproof):  return 'done'
    if TheGoal()[2]==[]: return 'done'
    if TheGoal()[2][0][0][0]=='binary' and TheGoal()[2][0][0][1]==['operator','=']:
        executematch(TheGoal()[2][0][0][2],TheGoal()[2][0][0][3])
    if TheGoal()[1]==[]: return 'done'
    executematch(TheGoal()[1][0][0],TheGoal()[2][0][0])
    return 'done'
    
# test whether first premise and conclusion are the same:
# return trivial complete proof if they are

# now also accepts the conclusion being an instance of reflexivity of equality.

def done(S):
    global linesused
    if len(S[2])==0:  return 'goal'
    if S[2][0][0][0] == 'binary' and S[2][0][0][1]== ['operator','=']\
       and matches(S[2][0][0][2],S[2][0][0][3]):
        linesused = linesused+S[2][0][1]
        return []
    if len(S[1])==0:  return 'goal'
    if matches(S[1][0][0],S[2][0][0]):
        linesused = linesused+S[1][0][1]+S[2][0][1]
#        Autoprune()
        return []
    printerror('Not done!\n')
    return 'goal'

# as forcedone, but ignores reflexivity of equality

def forcedone2():
    global theproof
    if completeproof(theproof):  return 'done'
    if TheGoal()[2]==[]: return 'done'
#    if TheGoal()[2][0][0][0]=='binary' and TheGoal()[2][0][0][1]==['operator','=']:
#        executematch(TheGoal()[2][0][0][2],TheGoal()[2][0][0][3])
    if TheGoal()[1]==[]: return 'done'
    executematch(TheGoal()[1][0][0],TheGoal()[2][0][0])
    return 'done'
    
# test whether first premise and conclusion are the same:
# return trivial complete proof if they are

# this variant ignores reflexivity of equality.

def done2(S):
    global linesused
    if len(S[2])==0:  return 'goal'
#    if S[2][0][0][0] == 'binary' and S[2][0][0][1]== ['operator','=']\
#       and matches(S[2][0][0][2],S[2][0][0][3]):
#        linesused = linesused+S[2][0][1]
#        return []
    if len(S[1])==0:  return 'goal'
    if matches(S[1][0][0],S[2][0][0]):
        linesused = linesused+S[1][0][1]+S[2][0][1]
#        Autoprune()
        return []
    printerror('Not done!\n')
    return 'goal'



# user command to view the current goal

def Look():
    usercommand('Look()\n')
    global theproof
    shownextgoal(theproof)

helpdict["Look"]="Look():  display the current goal. [L]"
helpdict["L"]="L:  display the current goal [Look()]."

# user command to view the current goal and log the view as well

def Snapshot():
    usercommand('Snapshot()\n')
    global theproof
    snapshot(theproof)

helpdict["Snapshot"]="Snapshot():  display and log the current goal. [Sn]"
helpdict["Sn"]="Sn():  display and log the current goal. [Snapshot()]"

# adding experimental facility to rotate the proof anyway if
# Done fails, which may make broken scripts easier to fix.
# If scriptmode is true, this behavior is implemented.

scriptmode=False

def Scriptmode():
    global scriptmode
    if scriptmode==False: scriptmode=True
    if scriptmode==True: scriptmode=False

helpdict['Scriptmode']='Scriptmode():  \
this toggle causes Done or Done2 to move \
to the next goal even if they fail.  Might be useful for script debugging. [Sc]'
helpdict['Sc']='Sc:  \
this toggle causes Done or Done2 to move \
to the next goal even if they fail.  Might be useful for script debugging. [Scriptmode()]'

# user command to close up the proof of a trivial sequent,
# possibly forcing triviality by unification.

def Done():
    global theproof
    usercommand('Done()\n')
    G=TheGoal()
    forcedone()
    act(done)
    Autoprune()
    if TheGoal()==G and scriptmode:
        theproof=rotateproofB(theproof)
        shownextgoal(theproof)

helpdict["Done"]="Done(): close up proof of a trivial sequent (first goal matching first conclusion or goal an equation of matching terms [tries equationsl conclusion first]) [d]"
helpdict["d"]="d: close up proof of a trivial sequent (first goal matching first conclusion or goal an equation of matching terms [tries equationsl conclusion first]) [Done()]"

# as the previous, but doesn't work for reflexivity of equality.

def Done2():
    global theproof
    usercommand('Done2()\n')
    G=TheGoal()
    forcedone2()
    act(done2)
    Autoprune()
    if TheGoal()==G and scriptmode:
        theproof=rotateproofB(theproof)
        shownextgoal(theproof)

#for internals of triv (Done2I is used, DoneI is not, so far but might be wanted).

def DoneI():
#    usercommand('Done2()\n')\
    G = TheGoal()
    forcedone()
    act(done)
    Autoprune()
    if TheGoal()==G and scriptmode:
        theproof=rotateproofB(theproof)
        shownextgoal(theproof)

def Done2I():
#    usercommand('Done2()\n')
    G=TheGoal()
    forcedone2()
    act(done2)
    Autoprune()
    if TheGoal()==G and scriptmode:
        theproof=rotateproofB(theproof)
        shownextgoal(theproof)

helpdict["Done2"]="Done2(): close up proof of a trivial sequent \
(first goal matching first conclusion:  reflexivity of equality ignored) [d2]"
helpdict["d2"]="d2: close up proof of a trivial sequent \
(first goal matching first conclusion:  reflexivity of equality ignored) [Done2()]"

# machinery for applying rules to premises or conclusions and distributing the
# results into one or more proofs

# make a new copy of a line with a fresh line number

def newcopy(item):
    global newlineindex
    return[item[0],[makenewlineindex()]+item[1]]

def distribute(L,S):
    global newlineindex
    if len(L)==0:  return []
    return [[makesequent(L[0][0]+list(map(newcopy,S[1])),L[0][1]\
                         +list(map(newcopy,S[2])),L[0][2]),'goal']]+distribute(L[1:],S)


def leftaction(S):
    if len(S[1])== 0:
        printerror('left rule fails to apply\n')
        return 'goal'
    if leftexpand(S[1][0])=='fail':
        printerror('left rule fails to apply\n')
        return 'goal'
    return distribute(leftexpand(S[1][0]),[S[0],S[1][1:],S[2]])
            
def rightaction(S):
    if len(S[2])== 0:
        printerror('right rule fails to apply\n')
        return 'goal'
    if rightexpand(S[2][0])=='fail':
        printerror('right rule fails to apply\n')
        return 'goal'
    return distribute(rightexpand(S[2][0]),[S[0],S[1],S[2][1:]])

# user commands to apply left and right rules.

def Left():
    usercommand('Left();')
    act(leftaction)

helpdict["Left"]="Left():  apply logical rule to first posit/assumption [l]"
helpdict["l"]="l:  apply logical rule to first posit/assumption [Left()]"

def Right():
    usercommand('Right();')
    act(rightaction)

helpdict["Right"]="Right():  apply logical rule to first goal/conclusion [r]"
helpdict["r"]="r:  apply logical rule to first goal/conclusion [Right()]" 

# internal functions and user commands to remove the first
# premise or conclusion.

def leftprune(S):  return [[S[0],S[1][1:],S[2]],'goal']

def rightprune(S):  return [[S[0],S[1],S[2][1:]],'goal']

def Pruneleft():
    usercommand('Pruneleft()\n')
    act2(leftprune)

def PruneleftI():
#    usercommand('Pruneleft()\n')
    act2I(leftprune)
    

helpdict["Pruneleft"]="Pruneleft():  remove the first posit/assumption"

def Pruneright():
    usercommand('Pruneright()\n')
    act2(rightprune)

def PrunerightI():
#    usercommand('Pruneright()\n')
    act2I(rightprune)    

helpdict["Pruneright"]="Pruneright():  remove the first goal/conclusion"

# definition facility

Definitions = {}

# the argument of the define command is a list, name of defined operator
# followed by one or two variables followed by body
# installed ability to define operators with strongly cantorian range.

# we cannot make a definition
# involving propositional variables, instantiables, or indexed operators.
# this also excludes indexed constants, though strictly speaking they could be permitted (?).

def defsafe(T):

    if len(T)==0: return False
    if (T[0]== 'constant' or T[0]=='operator') and len(T)==2:  return True
    if (T[0]=='constant' or T[0]=='operator') and len(T)==3:  return False
    if T[0]=='propvar':  return False
    #if T[0]=='instantiable' and len(T)==2:  return False
    if T[0]=='instantiable' and len(T)==3:  return False
       
    if T[0]=='variable' and len(T[1])==1 and T[2]=='0':  return True
    if T[0]=='variable':  
       return True
    if T[0]=='unary':  return defsafe(T[2]) and len(T[1])==2
         
    if T[0]=='binary': 
        return defsafe(T[2]) and defsafe(T[3]) and len(T[1])==2
    return False

# operator definition subcommand

def define(L):
#        usercommand('\n\nDefine('+str(L)+')\n')
#        ident=getident(L[0])[0]
        ident = L[0]
        if (not len(ident)==2) or (not ident[0]=='operator'):  return 'bad'
        if ident[1] in list(optypes.keys()):  return 'bad'
        if len(ident)==3:  return 'bad'
        if len(L)==3:
#            var1 = getident(L[1])[0]
            var1=L[1]
            if len(var1)==0 or not var1[0]=='variable':  return 'bad'
#            body=parse(L[2])
            body=L[2]
            if type(body)=='bad' or type(body)=='class'\
               or type(body)=='badprop' or type(body)=='badobject':
                   return 'bad'
            thetype=type(body)
            if not defsafe(body):  return 'bad'
            #if thetype=='constant':  thetype='sc'
            type1=type(var1)
            if not(var1 in freevars2(body)):  type1='object'
            body2=substitute(['constant','.arg','1'],var1,body)
            if not freevars(body2)==[]:  return 'bad'
            Definitions[ident[1]]=body2
            declareunary(ident[1],thetype,type1)
            Showdef(ident[1])
            return 'done'
        if len(L)==4:
#            var1=getident(L[1])[0]
#           var2=getident(L[2])[0]
            var1=L[1]
            var2=L[2]
            if len(var1)==0 or not var1[0]=='variable':  return 'bad'
            if len(var2)==0 or not var2[0]=='variable':  return 'bad'
#            body=parse(L[3])
            body=L[3]
            if type(body)=='bad' or type(body)=='class'\
               or type(body)=='badprop' or type(body)=='badobject':
                  return 'bad'
            if not defsafe(body):  return 'bad'
            thetype=type(body)
            type1=type(var1)
            if not(var1 in freevars2(body)):  type1='object'
            type2=type(var2)
            if not(var1 in freevars2(body)):  type2='object'
            #if thetype=='constant':  thetype='sc'
            body2=substitute(['constant','.arg','1'],var1,\
                             substitute(['constant','.arg','2'],var2,body))
            if not freevars(body2)==[]:  return 'bad'
            Definitions[ident[1]]=body2
            declarebinary(ident[1],thetype,type1,type2)
            Showdef(ident[1])
            return 'done'
        return 'bad'

# constant definition subcommand

def defineconstant(ident,body):
#    usercommand('\n\nDefineconstant('+quotestr(c)+','+quotestr(t)+')\n')
    global declaredconstants
#    ident = parse(c)
    if (not len(ident)==2) or (not ident[0]=='constant'):  return 'error'
    if ident[1] in declaredconstants:  return 'error'
#    body = parse(t)
    if not(defsafe(body)):  return 'error'
    if not type(body)=='object' or not freevars(body) == []:  return 'error'
    DeclareconstantI(ident[1])
    Definitions[ident[1]]=body
    Showdef(ident[1])

# user definition command:  the argument is a term with the illegal operator :=
# the left side being a constant or the operator to be defined with variable arguments;
# the right side is the body of the definition.   The left side must be enclosed in
# parentheses due to operator precedence technicalities.

def Define(s):
    global declaredconstants
    usercommand('\n\nDefine('+quotestr(s)+')\n')
    S = parse(s)
    if not(len(S)==4):
        printerror('bad input to define command 1')
        return 'fail'
    if not (S[0]=='binary' and S[1]==['operator',':=']):
        printerror('bad input to define command 2')
        return 'fail'
    if len(S[2]) == 2 and S[2][0] == 'constant':
#        print(str(S[2]))
#        print(str(S[3]))
        defineconstant(S[2],S[3])
        return 'done'
    if len(S[2])==3 and S[2][0]=='unary':
        define([S[2][1],S[2][2],S[3]])
        return 'done'
    if len(S[2])==4 and S[2][0]=='binary':
#        print(str(S[2][1]))
#        print(str(S[2][2]))
#        print(str(S[3]))
        define([S[2][1],S[2][2],S[2][3],S[3]])
        return 'done'
    printerror('bad input to define command 3')
    return 'fail'

helpdict["Define"]="Define('(leftside):=rightside'):\
defines leftside as rightside.  Leftside will be a complex term with parameters. [DEF]"
helpdict["DEF"]="DEF:\
defines leftside as rightside.  Leftside will be a complex term with parameters. [Define('(leftside):=rightside')]"

def Definebinder(s):
    
    global declaredconstants
    usercommand('\n\nDefinebinder('+quotestr(s)+')\n')
    S = parse(s)
    if not(len(S)==4):
        printerror('bad input to define command 1')
        return 'fail'
    if not (S[0]=='binary' and S[1]==['operator',':=']):
        printerror('bad input to define command 2')
        return 'fail'
#    if len(S[2]) == 2 and S[2][0] == 'constant':
#        print(str(S[2]))
#        print(str(S[3]))
#        defineconstant(S[2],S[3])
#        return 'done'
    if len(S[2])==3 and S[2][0]=='unary':
        define([S[2][1],S[2][2],S[3]])
        Makebinder(S[2][1][1])
        return 'done'
#    if len(S[2])==4 and S[2][0]=='binary':
#        print(str(S[2][1]))
#        print(str(S[2][2]))
#        print(str(S[3]))
#        define([S[2][1],S[2][2],S[2][3],S[3]])
#        return 'done'
    printerror('bad input to define command 3')
    return 'fail'   

helpdict["Definebinder"]="Definebinder('(leftside):=rightside'):\
defines leftside as rightside.  Leftside will be a complex term with parameters. \
Operator should be unary to be made a binder. [DEB]"
helpdict["DEB"]="DEB:\
defines leftside as rightside.  Leftside will be a complex term with parameters. \
Operator should be unary to be made a binder. [Definebinder('(leftside):=rightside')]"
    
# internal command for expanding definitions.

# this is now guarded so that it will not expand terms containing free variables,
# though it will expand subterms of such terms which do not contain free variables.

# it checks for correctness of resulting term when a class is substituted for a parameter.

def defexpand(T):
    if T[0]=='constant' and len(T)==2 and T[1] in list(Definitions.keys()):
        return Definitions[T[1]]
    if T[0]=='unary':

        if not(freevars(T[2])==[]): return T
        
        if T[1][1] in list(Definitions.keys()) and len(T[1])==2:
            if type(T[2])=='class':
                U=substitute(T[2],['constant','.arg','1'],Definitions[T[1][1]])
                V=substitute(['constant','.arg','2'],['constant','.arg','1'],U)
                if U==V: return U
                printerror('Class substitution failure')
                return T

            return substitute(T[2],['constant','.arg','1'],Definitions[T[1][1]])
        return [T[0],T[1],defexpand(T[2])]
    if T[0]=='binary':

        if T[1]==['operator','`'] and T[2][0]=='binary' and T[2][1]==['operator',':>']:
            if not(freevars(T[2])==[]): return T
            if not(freevars(T[3])==[]):  return T
            return substitute(T[3],T[2][2],T[2][3])
        if T[1][1] in list(Definitions.keys()) and len(T[1])==2:
            if not(freevars(T[2])==[]): return T
            if not(freevars(T[3])==[]):  return T           
            U= substitute(T[2],['constant','.arg','1'],\
                              substitute(T[3],['constant','.arg','2'],Definitions[T[1][1]]))
            if type(T[2])=='class':
                if U==substitute(['constant','.arg','3'],['constant','.arg','1'],U):
                    return(U)
                printerror('Class substitution error')
                return T
            if type(T[3])=='class':
                if U==substitute(['constant','.arg','3'],['constant','.arg','2'],U):
                    return(U)
                printerror('Class substitution error')
                return T
            return U
        if T[1]==['operator',':'] or T[1]==['operator',':>']:
             return [T[0],T[1],T[2],defexpand(T[3])]
        return [T[0],T[1],defexpand(T[2]),defexpand(T[3])]
        
    return T

#functions leftaction and rightaction will contain the meat of the logic

# generate the next line index

def makenewlineindex():
    global newlineindex
    newlineindex=newlineindex+1
    return newlineindex

# universal and existential closures of formulas, used in logic rules for
# complex binders.

def oneclosure(s,v,t):
    return ['unary', s, ['binary', ['operator',':'], v,t]]

def listclosure(s,L,t):
    if L == [] : return t
    if L[0] in L[1:]:  return listclosure(s,L[1:],t)
    return oneclosure(s,L[0],listclosure(s,L[1:],t))

def eclosure(t):  return listclosure(['operator','E'],freevars(t),t)

def uclosure(t): return listclosure(['operator','A'],freevars(t),t)

def forcetype(t):
    if type(t) == 'object':  return 0
    return (type(t))

# leftexpand and rightexpand require point by point commenting.  These functions implement the details
# of most of the logic.

# used to apply the appropriate left rule (rule based on the form of the first premise):  the argument is the premise,
# the output is a list of proofs (to be expanded to include other premises and conclusions using distribute).

def leftexpand(PP):
    global newlineindex
    global nextobjectindex
    global constructive
    def fix(Q):
        return [Q,[makenewlineindex()]+PP[1]]
    P=PP[0]
    if P[0] == 'unary' and P[1]==['operator','~']:
        return [[conlist([PP]),[fix(P[2])],'\nuse \n'+\
                 (termprint (P))+'\nby denying conclusion and proving\n'+(termprint(P[2]))]]
    if P[0] == 'binary' and P[1]==['operator','&']:
        return [[[fix(P[2]),fix(P[3])],[],'\nuse \n'+\
                 (termprint(P))+'\nby breaking it into its parts\n'+(termprint(P[2]))\
                 +'\nand\n'+(termprint(P[3]))]]
    if P[0]=='binary' and P[1]==['operator','V']:
        return [[[fix(P[2])],[],'\nusing hypothesis\n'+\
                 (termprint(P))+'\nfirst part: assume case 1,\n'+(termprint(P[2]))],[[fix(P[3])],[],'\nusing hypothesis\n'+(termprint(P))+'\nsecond part: assume case 2,\n'+(termprint(P[3]))]]
    if P[0]=='binary' and P[1]==['operator','->']:
        return [[conlist([PP]),[fix(P[2])],'\nuse\n'+\
                 (termprint(P))+'\n, first part, showing that\n'\
                 +(termprint(P[2]))+'\nor the desired conclusion holds'],\
                [[fix(P[3])+conlist([PP])],[],'\nuse\n'+(termprint(P))+\
                 '\nsecond part, show that the desired conclusion follows from\n'\
                 +(termprint(P[3]))]]
    if P[0]=='binary' and P[1]==['operator','==']:
        firstimp=['binary',['operator','->'],P[2],P[3]]
        secondimp=['binary',['operator','->'],P[3],P[2]]
        return [[[fix(firstimp),fix(secondimp)],[],\
                 '\nbreak biconditional assumption\n'+(termprint(P))+\
                 '\ninto its constituent implications']]
    if P[0]=='unary' and P[1]==['operator','A'] and P[2][0] == 'binary' \
       and P[2][1]==['operator',':'] and P[2][2][0] == 'variable':
         #nextobjectindex=nextobjectindex+1
         return [[[fix(substitute(['instantiable',P[2][2][1],\
                                   str(nextobjectindex)],P[2][2],P[2][3])),fix(P)],[],\
                  '\nuse the universal hypothesis\n'+(termprint(P))+\
                  '\nby creating an instance to be further specified and used']]

# simplifying the case where P[2][2][2] is a variable in the following would be a good deed

    if P[0]=='unary' and P[1]==['operator','AR'] and P[2][0]=='binary'\
       and P[2][1]==['operator',':'] and type(P[2][2]) == 'prop'\
       and P[2][2][0]=='binary' and not(type(P[2][2][2])=='prop') and not(type(P[2][2][3])=='prop'):

            if P[2][2][2][0]=='variable':
                return [[[fix(substitute(['instantiable',P[2][2][2][1],str(nextobjectindex)],P[2][2][2],\
                  ['binary',['operator','->'],P[2][2],P[2][3]])),fix(P)],[],'']]

            return [[[fix(uclosure(['binary',['operator','->'],['binary',['operator','&'],['binary',['operator','='],\
                        ['instantiable','x',str(nextobjectindex)],P[2][2][2]],P[2][2]],P[2][3]]))],[],'']]




    if P[0]=='unary' and P[1]==['operator','AR'] and P[2][0] == 'binary' and P[2][1]==['operator',':'] and not(type(P[2][2])=='prop'):

            return[[[fix(uclosure(['binary',['operator','->'],['binary',['operator','='],\
                ['instantiable','x',str(nextobjectindex)],P[2][2]],P[2][3]]))],[],'']]
        
    if P[0]=='unary' and P[1]==['operator','E'] and P[2][0] == 'binary'\
       and P[2][1]==['operator',':'] and P[2][2][0]=='variable':
 #       nextobjectindex=nextobjectindex+1
        return [[[fix(substitute(['constant',P[2][2][1],\
                                  str(nextobjectindex)],P[2][2],P[2][3]))],[],\
                 '\nuse the existential hypothesis\n'+(termprint(P))+\
                 '\nby introducing a new witness']]

    if P[0]=='unary' and P[1]==['operator','ER'] and P[2][0]=='binary'\
       and P[2][1]==['operator',':'] and type(P[2][2]) == 'prop'\
       and P[2][2][0]=='binary' and not(type(P[2][2][2])=='prop') and not(type(P[2][2][3])=='prop'):

            if P[2][2][2][0]=='variable':
                return [[[fix(substitute(['constant',P[2][2][2][1],str(nextobjectindex)],P[2][2][2],\
                  ['binary',['operator','&'],P[2][2],P[2][3]]))],[],'']]


            return [[[fix(eclosure(['binary',['operator','&'],['binary',['operator','&'],['binary',['operator','='],\
                        ['constant','x',str(nextobjectindex)],P[2][2][2]],P[2][2]],P[2][3]]))],[],'']]

    if P[0]=='unary' and P[1]==['operator','ER'] and P[2][0] == 'binary' and P[2][1]==['operator',':'] and not(type(P[2][2])=='prop'):

            return[[[fix(eclosure(['binary',['operator','&'],['binary',['operator','='],\
                ['constant','x',str(nextobjectindex)],P[2][2]],P[2][3]]))],[],'']]

    
    if (P[0]=='unary' and P[2][0]== 'unary' and P[2][1]==['operator','THE']):
         C1=substitute(P[2][2],parse('x1'),parse('Ey0:Ax0:x0INx1==x0=y0'))
         N=['constant','x',str(nextobjectindex)]
         N1=['binary',['operator','='],N,P[2]]
         C2=substitute(N,parse('z1'),substitute(P[2][2],parse('x1'),parse('Ax0:x0INx1==x0=z1')))
         return [[[fix(P)],[fix(C1)],''],[[fix(N1),fix(C2),fix(P)],[],'']]
    if (P[0]=='binary' and P[3][0]== 'unary' and P[3][1]==['operator','THE']):
         C1=substitute(P[3][2],parse('x1'),parse('Ey0:Ax0:x0INx1==x0=y0'))
         N=['constant','x',str(nextobjectindex)]
         N1=['binary',['operator','='],N,P[3]]
         C2=substitute(N,parse('z1'),substitute(P[3][2],parse('x1'),parse('Ax0:x0INx1==x0=z1')))        
#         C2=substitute(P[3][2],parse('x1'),parse('Ax0:x0INx1==x0=THEx1'))
         return [[[fix(P)],[fix(C1)],''],[[fix(N1), fix(C2),fix(P)],[],'']]
    if (P[0]=='binary' and P[2][0]== 'unary' and P[2][1]==['operator','THE']):
         C1=substitute(P[2][2],parse('x1'),parse('Ey0:Ax0:x0INx1==x0=y0'))
         N=['constant','x',str(nextobjectindex)]
         N1=['binary',['operator','='],N,P[2]]
         C2=substitute(N,parse('z1'),substitute(P[2][2],parse('x1'),parse('Ax0:x0INx1==x0=z1')))          
#         C2=substitute(P[2][2],parse('x1'),parse('Ax0:x0INx1==x0=THEx1'))
         return [[[fix(P)],[fix(C1)],''],[[fix(N1),fix(C2),fix(P)],[],'']]
    if P[0]=='binary' and P[1]==['operator','IN']:
        if P[3][0]=='binary' and P[3][1]==['operator',':'] and P[3][2][0]=='variable':
            return [[[fix(substitute(P[2],P[3][2],P[3][3]))],[],'']]

    if P[0]=='binary' and P[1]==['operator','INR'] and P[3][0] == 'binary' and P[3][1] == ['operator',':']\
       and (type(P[3][2]) == 'prop') and P[3][2][0] == 'binary' and not(type(P[3][2][2])=='prop') and not(type(P[3][2][3])=='prop'):

         if P[3][2][2][0]=='variable':
             return [[[fix(substitute(P[2],P[3][2][2],\
                  ['binary',['operator','&'],P[3][2],P[3][3]]))],[],'']]
             

         return [[[fix(eclosure(['binary',['operator','&'],\
                ['binary',['operator','&'],\
                    ['binary',['operator','='],P[2],P[3][2][2]],
                     P[3][2]],P[3][3]]))],[],'']]
        
    if P[0]=='binary' and P[1]==['operator','INR'] and P[3][0] == 'binary' and P[3][1] == ['operator',':'] and not(type(P[3][2])=='prop'):

         return [[[fix(eclosure(\
                ['binary',['operator','&'],\
                    ['binary',['operator','='],P[2],P[3][2]]\
                     ,P[3][3]]))],[],'']]
    if P[0]=='binary' and (P[1]==['operator','IN'] or P[1]==['operator','INR']):
        D=defexpand(P[3])
        if not(D==P[3]):
            return [[[fix([P[0],P[1],P[2],D])],[],'']]
         
             
       
    if P[0]=='binary' and P[1]==['operator','=']:
        if supermatch(P[2],P[3])==[]:  return [[[],[],""]]
    D=defexpand(P)  #moved before left action on =, 1/25/2017
    if not P==D:  return [[[fix(D)],[],'']]
    if P[0]=='binary' and P[1]==['operator','=']:
#        if supermatch(P[2],P[3])==[]:  return [[[],[]]]
        return [[[fix(substitute(P[2],parse('x0'),substitute(P[3],parse('y0'),\
                                                             parse('Az1:x0INz1->y0INz1')))),\
                  fix(P)],[],'']]
#    D=defexpand(P)
#    if not P==D:  return [[[fix(D)],[],'']]

    return 'fail'

# used to apply the appropriate right rule (rule based on the form of the first conclusion):  the argument is the conclusion,
# the output is a list of proofs (to be expanded to include other premises and conclusions using distribute).

def rightexpand(PP):
    global newlineindex
    global nextobjectindex
    global linesused
    P=PP[0]
    def fix(Q):
        return [Q,[makenewlineindex()]+PP[1]]
    if P[0]=='unary' and P[1]==['operator','~']:
        return [[[fix(P[2])],[],'\nprove\n'+(termprint(P))+'\nby assuming\n'\
                 +(termprint(P[2]))+'\nand deducing a contradiction or alternative conclusion']]
    if P[0]=='binary' and P[1]==['operator','&']:
        return [[[],[fix(P[2])],'\nprove\n'+(termprint(P))+'\nfirst part:  prove\n'\
                 +(termprint(P[2]))],[[],[fix(P[3])],'\nprove\n'+(termprint(P))+'\nsecond part:  prove\n'+(termprint(P[3]))]]
    if P[0]=='binary' and P[1]==['operator','V']:
        return [[[],[fix(P[2]),fix(P[3])],'\nprove\n'+(termprint(P))+'\nby denying\n'\
                 +(termprint(P[3]))+'\nand showing\n'+(termprint(P[2]))]]
    if P[0]=='unary' and P[1]==['operator','A'] and P[2][0] == 'binary'\
       and P[2][1]==['operator',':'] and P[2][2][0]=='variable':
        n = nextobjectindex
 #       nextobjectindex=nextobjectindex+1
        return[[[],[fix(substitute(['constant',P[2][2][1],str(n)],P[2][2],P[2][3]))],\
                '\nprove the universal\n'+(termprint(P))+\
                '\nby proving an arbitrary instance\n']]

# simplifying the case where P[2][2][2] is a variable in the following would be a good deed

    if P[0]=='unary' and P[1]==['operator','AR'] and P[2][0]=='binary'\
       and P[2][1]==['operator',':'] and type(P[2][2]) == 'prop'\
       and P[2][2][0]=='binary' and not(type(P[2][2][2])=='prop') and not(type(P[2][2][3])=='prop'):


            if P[2][2][2][0]=='variable':
                return [[[],[fix(substitute(['constant',P[2][2][2][1],str(nextobjectindex)],P[2][2][2],\
                  ['binary',['operator','->'],P[2][2],P[2][3]]))],'']]


            return [[[],[fix(uclosure(['binary',['operator','->'],['binary',['operator','&'],['binary',['operator','='],\
                        ['constant','x',str(nextobjectindex)],P[2][2][2]],P[2][2]],P[2][3]]))],'']]

    if P[0]=='unary' and P[1]==['operator','AR'] and P[2][0] == 'binary' and P[2][1]==['operator',':'] and not(type(P[2][2])=='prop'):

            return[[[],[fix(uclosure(['binary',['operator','->'],['binary',['operator','='],\
                ['constant','x',str(nextobjectindex)],P[2][2]],P[2][3]]))],'']]
    
    if P[0]=='unary' and P[1]==['operator','E'] and P[2][0] == 'binary' \
       and P[2][1]==['operator',':'] and P[2][2][0]=='variable':
        n=nextobjectindex
 #       nextobjectindex=nextobjectindex+1
        return[[[],[fix(substitute(['instantiable',\
                                    P[2][2][1],str(n)],P[2][2],P[2][3])),fix(P)],\
                '\nprove the existential \n'+(termprint(P))\
                +'\nby introducing an instance to be further specified then proved']]

    if P[0]=='unary' and P[1]==['operator','ER'] and P[2][0]=='binary'\
       and P[2][1]==['operator',':'] and type(P[2][2]) == 'prop'\
       and P[2][2][0]=='binary' and not(type(P[2][2][2])=='prop') and not(type(P[2][2][3])=='prop'):

            if P[2][2][2][0]=='variable':
                return [[[],[fix(substitute(['instantiable',P[2][2][2][1],str(nextobjectindex)],P[2][2][2],\
                  ['binary',['operator','&'],P[2][2],P[2][3]])),fix(P)],'']]


            return [[[],[fix(eclosure(['binary',['operator','&'],['binary',['operator','&'],['binary',['operator','='],\
                        ['instantiable','x',str(nextobjectindex)],P[2][2][2]],P[2][2]],P[2][3]]))],'']]

    if P[0]=='unary' and P[1]==['operator','ER'] and P[2][0] == 'binary' and P[2][1]==['operator',':'] and not(type(P[2][2])=='prop'):

            return[[[],[fix(eclosure(['binary',['operator','&'],['binary',['operator','='],\
                ['instantiable','x',str(nextobjectindex)],P[2][2]],P[2][3]]))],'']]

    
    if P[0]=='binary' and P[1]==['operator','->']:
        return [[[fix(P[2])],[fix(P[3])],'\nprove\n'+(termprint(P))\
                 +'\nby assuming\n'+(termprint(P[2]))+'\nand deducing\n'+(termprint(P[3]))]]
    if P[0]=='binary' and P[1]==['operator','==']:
        return [[[fix(P[2])],[fix(P[3])],'\nproving biconditional\n'+(termprint(P))\
                 +'\nPart I =>\n'],[[fix(P[3])],[fix(P[2])],'\nproving biconditional\n'\
                                    +(termprint(P))+'\nPart II <=\n']]

    if (P[0]=='unary' and P[2][0]== 'unary' and P[2][1]==['operator','THE']):
         C1=substitute(P[2][2],parse('x1'),parse('Ey0:Ax0:x0INx1==x0=y0'))
         N=['constant','x',str(nextobjectindex)]
         N1=['binary',['operator','='],N,P[2]]
         C2=substitute(N,parse('z1'),substitute(P[2][2],parse('x1'),parse('Ax0:x0INx1==x0=z1'))) 
#         C2=substitute(P[2][2],parse('x1'),parse('Ax0:x0INx1==x0=THEx1'))
         return [[[],[fix(C1),fix(P)],''],[[fix(N1),fix(C2)],[fix(P)],'']]
    if (P[0]=='binary' and P[3][0]== 'unary' and P[3][1]==['operator','THE']):
         C1=substitute(P[3][2],parse('x1'),parse('Ey0:Ax0:x0INx1==x0=y0'))
         N=['constant','x',str(nextobjectindex)]
         N1=['binary',['operator','='],N,P[3]]
         C2=substitute(N,parse('z1'),substitute(P[3][2],parse('x1'),parse('Ax0:x0INx1==x0=z1'))) 
#         C2=substitute(P[3][2],parse('x1'),parse('Ax0:x0INx1==x0=THEx1'))
         return [[[],[fix(C1),fix(P)],''],[[fix(N1),fix(C2)],[fix(P)],'']]
    if (P[0]=='binary' and P[2][0]== 'unary' and P[2][1]==['operator','THE']):
         C1=substitute(P[2][2],parse('x1'),parse('Ey0:Ax0:x0INx1==x0=y0'))
         N=['constant','x',str(nextobjectindex)]
         N1=['binary',['operator','='],N,P[2]]
         C2=substitute(N,parse('z1'),substitute(P[2][2],parse('x1'),parse('Ax0:x0INx1==x0=z1'))) 
#         C2=substitute(P[2][2],parse('x1'),parse('Ax0:x0INx1==x0=THEx1'))
         return [[[],[fix(C1),fix(P)],''],[[fix(N1),fix(C2)],[fix(P)],'']] 
    if P[0]=='binary' and P[1]==['operator','IN']:
        if P[3][0]=='binary' and P[3][1]==['operator',':'] and P[3][2][0]=='variable':
            return [[[],[fix(substitute(P[2],P[3][2],P[3][3]))],'']]

    if P[0]=='binary' and P[1]==['operator','INR'] and P[3][0] == 'binary' and P[3][1] == ['operator',':']\
       and (type(P[3][2]) == 'prop') and P[3][2][0] == 'binary' and not(type(P[3][2][2])=='prop') and not(type(P[3][2][3])=='prop'):

         if P[3][2][2][0]=='variable':
             return [[[],[fix(substitute(P[2],P[3][2][2],\
                  ['binary',['operator','&'],P[3][2],P[3][3]]))],'']]
  
         return [[[],[fix(eclosure(['binary',['operator','&'],\
                ['binary',['operator','&'],\
                    ['binary',['operator','='],P[2],P[3][2][2]],
                     P[3][2]],P[3][3]]))],'']]
        
    if P[0]=='binary' and P[1]==['operator','INR'] and P[3][0] == 'binary' and P[3][1] == ['operator',':'] and not(type(P[3][2]) == 'prop'):

         return [[[],[fix(eclosure(\
                ['binary',['operator','&'],\
                    ['binary',['operator','='],P[2],P[3][2]]\
                     ,P[3][3]]))],'']]       
    if P[0]=='binary' and (P[1]==['operator','IN'] or P[1]==['operator','INR']):
         D=defexpand(P[3])
         if not(D==P[3]):
             return [[[],[fix([P[0],P[1],P[2],D])],'']]
   

        
    if P[0]=='binary' and P[1]==['operator','=']:
        if supermatch(P[2],P[3]) == []: #termprint(P[2])==termprint(P[3]):
            linesused=linesused+PP[1]
#            Autoprune() # autoprune wont work here
            return []
        if P[2][0]=='binary' and P[2][1]==['operator',':'] and P[3][0]=='binary'\
           and P[3][1]==['operator',':'] and P[3][2][0]=='variable' and P[2][2][0]=='variable':
 #          nextobjectindex=nextobjectindex+1
           A=substitute(['constant',P[2][2][1],str(nextobjectindex)],P[2][2],P[2][3])
           B=substitute(['constant',P[2][2][1],str(nextobjectindex)],P[3][2],P[3][3])
           return [[[],[fix(['binary',['operator','=='],A,B])],'']]
        if P[2][0]=='binary' and P[2][1]==['operator',':>'] and P[3][0]=='binary'\
           and P[3][1]==['operator',':>']:
 #          nextobjectindex=nextobjectindex+1
           A=substitute(['constant',P[2][2][1],str(nextobjectindex)],P[2][2],P[2][3])
           B=substitute(['constant',P[2][2][1],str(nextobjectindex)],P[3][2],P[3][3])
           return [[[],[fix(['binary',['operator','='],A,B]),],'']]

        if P[2][0]=='binary' and P[2][1]==['operator',':'] and P[3][0]=='binary' and P[3][1]==['operator',':']:
            return[[[],[fix(['binary',['operator','=='],['binary',['operator','INR'],['constant','x',str(nextobjectindex)],\
                                                         [P[2][0],P[2][1],P[2][2],parse('a_1=a_1')]],\
                   ['binary',['operator','INR'],['constant','x',str(nextobjectindex)],[P[3][0],P[3][1],P[3][2],parse('a_1=a_1')]]])],''] ,\
                   [[],[fix(['binary',['operator','=='],['binary',['operator','INR'],['constant','x',str(nextobjectindex)],P[2]],\
                   ['binary',['operator','INR'],['constant','x',str(nextobjectindex)],P[3]]])],'']]
        
        D=defexpand(P)
        if not P==D:  return [[[],[fix(D)],'']]
        
        return [[[],[fix(P),
                     fix(substitute((P[2]),parse('x1'),substitute((P[3]),parse('y1'),\
                    parse('x1={x0:x0INx1}&y1={x0:x0INy1}&Az0:z0INx1==z0INy1')))),
               fix(substitute((P[2]),parse('x1'),substitute((P[3]),parse('y1'),\
                    parse('x1={x0 IN a$'+str(nextobjectindex)+':x0INRx1}&y1={x0 IN a$'+str(nextobjectindex)+':x0INRy1}&Az0:z0INRx1==z0INRy1')))),
               fix(substitute((P[2]),parse('x1'),substitute((P[3]),parse('y1'),\
                              parse('x1={x0:>x1`x0}&y1={x0:>y1`x0}&Az0:x1`z0=y1`z0'))))],'']]

   
    D=defexpand(P)
    if not P==D:  return [[[],[fix(D)],'']]
    return('fail')

# pull nth premise to second position

def pregltE(n,S):
    if len(S[1])==0:  return [S,'goal']
    if len(S[1])<n: return [S,'goal']
    if n<=2:  return [S,'goal']
    return [[S[0],[S[1][0]]+[S[1][n-1]]+S[1][2:n-1]+[S[1][1]]+S[1][n:],S[2]],'goal']

def gltE(n):
    global theproof
    usercommand('gltE('+str(n)+'); ')
    def doit(s):  return pregltE(n,s)
    act2(doit)
    shownextgoal(theproof)

helpdict['gltE']='gltE(n):  move nth premise to second position [get]'
helpdict['get']='get:  move nth premise to second position [gltE(n)]'

# pull nth premise to front

def preglt(n,S):
    if len(S[1])==0:  return [S,'goal']
    if len(S[1])<n: return [S,'goal']
    if n<=1:  return [S,'goal']
    return [[S[0],[S[1][n-1]]+S[1][1:n-1]+[S[1][0]]+S[1][n:],S[2]],'goal']

def glt(n):
    global theproof
    usercommand('glt('+str(n)+'); ')
    def doit(s):  return preglt(n,s)
    act2(doit)
    shownextgoal(theproof)

helpdict['glt']='glt(n):  move nth premise to first position [glt]'
helpdict['glt']='glt:  move nth premise to first position [glt(n)]'

    # pull nth conclusion to front

def pregrt(n,S):
    if len(S[2])==0:  return [S,'goal']
    if len(S[2])<n: return [S,'goal']
    if n<=1:  return [S,'goal']
    return [[S[0],S[1],[S[2][n-1]]+S[2][1:n-1]+[S[2][0]]+S[2][n:]],'goal']

def grt(n):
    global theproof
    usercommand('grt('+str(n)+'); ')
    def doit(s):  return pregrt(n,s)
    act2(doit)
    shownextgoal(theproof)

helpdict['grt']='grt(n):  move nth conclusion to second position [grt]'
helpdict['grt']='grt:  move nth conclusion to second position [grt(n)]'

# rotate premises by one, first to end

def leftrot(S):
    if len(S[1])==0:  return [S,'goal']
    return [[S[0],S[1][1:]+[S[1][0]],S[2]], 'goal']

# rotate second and subsequent premises by one, second to end

def leftrotE(S):
    if len(S[1])==0:  return [S,'goal']
    if len(S[1])==1:  return [S,'goal']
    return [[S[0],[S[1][0]]+S[1][2:]+[S[1][1]],S[2]],'goal']

# rotate second and subsequent premises by one, last to second

def leftrot2E(S):
    if len(S[1])==0:  return [S,'goal']
    if len(S[1])==1:  return [S,'goal']
    return [[S[0],[S[1][0]]+[S[1][-1]]+S[1][1:-1],S[2]],'goal']

# user command to rotate premises by one, first to end

def Getleft():
    usercommand('Getleft();')
    act2(leftrot)

helpdict["Getleft"]="Getleft(): \
rotate posits/premises by one, moving first to end"

def GetleftI():
#    usercommand('Getleft();')
    act2I(leftrot)

# user command to rotate second and subsequent premises by one, second to end

def GetleftE():
    usercommand('GetleftE();')
    act2(leftrotE)

helpdict["GetleftE"]="GetleftE(): \
rotate second and subsequent premises by one, moving second to end"

def GetleftEI():
#    usercommand('GetleftE();')
    act2I(leftrotE)

# user command to rotate second and subsequent premises by one, last to second

def Getleft2E():
    usercommand('Getleft2E();')
    act2(leftrot2E)

helpdict["Getleft2E"]="Getleft2E(): \
rotate second and subsequent premises by one, moving last to second"

def rightrot2(S):
    if len(S[2])==0:  return [S,'goal']
    return [[S[0],S[1],[S[2][-1]]+S[2][0:-1]],'goal']

# user command to rotate conclusions, last to first

def Getright2():
    usercommand('Getright2();')
    act2(rightrot2)

def Getright2I():
#    usercommand('Getright2();')
    act2I(rightrot2)

helpdict["Getright2"]="Getright2():  rotate goals by one, moving last to first"

def leftrot2(S):
    if len(S[1])==0:  return [S,'goal']
    return [[S[0],[S[1][-1]]+S[1][0:-1],S[2]], 'goal']

# user command to rotate premises by one, last to first

def Getleft2():
    usercommand('Getleft2();')
    act2(leftrot2)

def Getleft2I():
#    usercommand('Getleft2();')
    act2I(leftrot2)

helpdict["Getleft2"]="Getleft2():  rotate premises by one, moving last to first"

def rightrot(S):
    if len(S[2])==0:  return [S,'goal']
    return [[S[0],S[1],S[2][1:]+[S[2][0]]],'goal']

# user command to rotate conclusions by one, first to last

def Getright():
    usercommand('Getright();')
    act2(rightrot)

helpdict["Getright2"]="Getright2():  rotate goals by one, moving first to last"

def GetrightI():
#    usercommand('Getright();')
    act2I(rightrot)

thecutterm=[]

def cut(S):
    global newlineindex
    global thecutterm
    global linesused
    m=makenewlineindex()
    n=makenewlineindex()
    linesused=linesused+[m,n]
    return [[makesequent(list(map(newcopy,S[1])),\
                         [[thecutterm,[m]]]\
                         +(list(map(newcopy,S[2]))),''),'goal'],\
            [makesequent([[thecutterm,[n]]]\
                         +list(map(newcopy,S[1])),list(map(newcopy,S[2])),''),'goal']]

# user command to introduce a lemma:  turns sequent into two sequents,
# one with the lemma added as a premise, one with the lemma added as a conclusion

def Cut(t):
    usercommand('Cut('+quotestr(t)+')\n')
    global thecutterm
    T=parse(t)
    if not type(T)=='prop':  return 'error'
    if not freevars(T)==[]:  return 'error'
    thecutterm=parse(t)
    act(cut)

helpdict["Cut"]="Cut(t):  prove t as a lemma:\
creates two sequents, in the first adding t as a goal\
and in the second adding it as a premise [CUT]"
helpdict["CUT"]="CUT:  prove t as a lemma:\
creates two sequents, in the first adding t as a goal\
and in the second adding it as a premise [Cut(t)]"

# equality command

converse=False
inleft=False

# these were originally intended as user commands
# to control equality rule behavior, but this is
# no longer done.

# this is all about user commands to apply an equation
# appearing as first premise

# change the direction in which the equation is applied

def Converse():
    global converse
    converse=True
def Direct():
    global converse
    converse=False

# change whether the equation is being applied
# to the conclusion or to the second premise
    
def Inleft():
    global inleft
    inleft=True
def Inright():
    global inleft
    inleft=False

# the equality command -- carry out the
# substitution using the first premise equation
# in the order indicated by converse to the
# target indicated by Inleft.  There is a further
# choice of which substitution operator to use
# (aim for all occurrences of the appropriate
# side of the equation in the target term,
# or the leftmost (with unification) or
# the rightmost (with unification).

# the function thesub is one of the strongsubstitute functions.

def equal(thesub,S):
    global converse
    global inleft
    if len(S[1])==0:  return 'goal'
    if not S[1][0][0][0]=='binary':  return 'goal'
    if not (S[1][0][0][1]==['operator','='] or S[1][0][0][1]==['operator','==']) :  return 'goal'
    if converse:
        b=S[1][0][0][2]
        a=S[1][0][0][3]
    if not converse:
        a=S[1][0][0][2]
        b=S[1][0][0][3]
    if inleft:
        if len(S[1])==1: return 'goal'
        return [[makesequent([newcopy(S[1][0])]+[[thesub(a,b,S[1][1][0]),\
                [makenewlineindex()]+S[1][0][1]+S[1][1][1]]]\
                             +list(map(newcopy,S[1][2:])),list(map(newcopy,S[2])),""),'goal']]
    if not inleft:
        if len(S[2])==0:  return 'goal'
        return [[makesequent(list(map(newcopy,S[1])),[[thesub(a,b,S[2][0][0]),\
                        [makenewlineindex()]+S[1][0][1]+S[2][0][1]]]\
                             +list(map(newcopy,S[2][1:])),''),'goal']]

# if using matching, this command makes the global substitution
# needed to make the equation applicable.

def forceequal(thematch):
    global theproof
    G=TheGoal()
    if len(G[1])==0:  return 'fail'
    if not G[1][0][0][0]=='binary':  return 'fail'
    if not (G[1][0][0][1]==['operator','='] or G[1][0][0][1]==['operator','==']):  return 'fail'
    if converse:
        b=G[1][0][0][2]
        a=G[1][0][0][3]
    if not converse:
        a=G[1][0][0][2]
        b=G[1][0][0][3]
    if inleft:
        if len(G[1])==1:return 'fail'
        executelist(thematch(a,b,G[1][1][0]))
    if not inleft:
        if len(G[2])==0:  return 'fail'
        executelist(thematch(a,b,G[2][0][0]))
        

def equal0(S):  return equal(strongsubstitute,S)
def equal1(S):  return equal(strongsubstitute1,S)
def equal2(S):  return equal(strongsubstitute2,S)

def Equal0():  act(equal0)
def Equal1():
    forceequal(strongsubstitutematch1)
    act(equal1)
def Equal2():
    forceequal(strongsubstitutematch2)                    
    act(equal2)

# Here is the suite of user equality commands.
# d or c determines the way the equation is to be read
# r or l determines whether it is applied to conclusion or premise
# 0 1 or 2 determines whether application is everywhere
# or leftmost with matching or rightmost with matching.

def Equaldr0():
    usercommand('Equaldr0()\n')
    Direct()
    Inright()
    Equal0()

helpdict["Equaldr0"]="Equaldr0():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [EDR0]"

helpdict["EDR0"] = "See Equaldr0"

def Equaldl0():
    usercommand('Equaldl0()\n')
    Direct()
    Inleft()
    Equal0()

helpdict["Equaldl0"]="Equaldl0():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [EDL0]"

helpdict["EDL0"] = "See Equaldl0"

def Equalcr0():
    usercommand('Equalcr0()\n')
    Converse()
    Inright()
    Equal0()

helpdict["Equalcr0"]="Equalcr0():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [ECR0]"

helpdict["ECR0"] = "See Equalcr0"


def Equalcl0():
    usercommand('Equalcl0()\n')
    Converse()
    Inleft()
    Equal0()

helpdict["Equalcl0"]="Equalcl0():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [ECL0]"

helpdict["ECL0"] = "See Equalcl0"


def Equaldr1():
    usercommand('Equaldr1()\n')
    Direct()
    Inright()
    Equal1()

helpdict["Equaldr1"]="Equaldr1():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [EDR1]"

helpdict["EDR1"] = "See Equaldr1"


def Equaldl1():
    usercommand('Equaldl1()\n') 
    Direct()
    Inleft()
    Equal1()

helpdict["Equaldl1"]="Equaldl1():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [EDL1]"

helpdict["EDL1"] = "See Equaldl1"


def Equalcr1():
    usercommand('Equalcr1()\n')
    Converse()
    Inright()
    Equal1()

helpdict["Equalcr1"]="Equalcr1():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [ECR1]"

helpdict["ECR1"] = "See Equalcr1"


def Equalcl1():
    usercommand('Equalcl1()\n')
    Converse()
    Inleft()
    Equal1()

helpdict["Equalcl1"]="Equalcl1():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [ECL1]"

helpdict["ECL1"] = "See Equalcl1"

def Equaldr2():
    usercommand('Equaldr2()\n')
    Direct()
    Inright()
    Equal2()

helpdict["Equaldr2"]="Equaldr2():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [EDR2]"

helpdict["EDR2"] = "See Equaldr2"


def Equaldl2():
    usercommand('Equaldl2()\n')
    Direct()
    Inleft()
    Equal2()

helpdict["Equaldl2"]="Equaldl2():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [EDL2]"

helpdict["EDL2"] = "See Equaldl2"


def Equalcr2():
    usercommand('Equalcr2()\n')
    Converse()
    Inright()
    Equal2()

helpdict["Equalcr2"]="Equalcr2():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [ECR2]"

helpdict["ECR2"] = "See Equalcr2"


def Equalcl2():
    usercommand('Equalcl2()\n')
    Converse()
    Inleft()
    Equal2()

helpdict["Equalcl2"]="Equalcl2():\
an equality command applying the first premise a=b.\
d/c decides action as written (a=b) or converse action (b=a);\
r/l determines whether it acts on conclusion or the second premise;\
0/1/2 determines whether it acts everywhere possible (without matching)\
or on the leftmost matching subterm or on the rightmost matching subterm [ECL2]"

helpdict["ECL2"] = "See Equalcl2"


# develop rewritefree command

# The Rf command rewrites all of a sequent in such a way as to eliminate a constant appearing
# in an equation which is the first premise.  Currently, it only does this in a way which reduces
# maxindex:  it might be desirable to do it in any noncircular way, as in the ML version.


def rf(S):
    global linesused
    global nextsequent
    if S[1]==[]: return [[S,'goal']]
    if S[1][0][0][0]=='binary' and S[1][0][0][1]==['operator','='] \
       and S[1][0][0][2][0]=='constant' and maxindex(S[1][0][0][3])<maxindex(S[1][0][0][2]):
#         linesused=linesused+S[1][0][1]
#         nextsequent=nextsequent+1
         return [[['Line '+str(nextsequent),listsubplus(S[1][0][0][3],(S[1][0][0][2]),S[1],S[1][0][1])[1:],\
                   listsubplus(S[1][0][0][3],(S[1][0][0][2]),S[2],S[1][0][1])],'goal']]

    if S[1][0][0][0]=='binary' and S[1][0][0][1]==['operator','='] \
       and S[1][0][0][3][0]=='constant' and maxindex(S[1][0][0][2])<maxindex(S[1][0][0][3]):
#         linesused = linesused+S[1][0][1]
#          nextsequent=nextsequent+1
          return [[['Line '+str(nextsequent),listsubplus(S[1][0][0][2],(S[1][0][0][3]),S[1],S[1][0][1])[1:]\
                    ,listsubplus(S[1][0][0][2],(S[1][0][0][3]),S[2],S[1][0][1])],'goal']]

    return[[S,'goal']]

def Rf():
    global nextsequent
    if [[TheGoal(),'goal']] == rf(TheGoal()):
        Look()
        return 'fails'
    nextsequent=nextsequent+1
    usercommand('\nRf()\n')
    act(rf)

helpdict["Rf"]="Rf():  use the first equation to rewrite \
one side (an indexed constant) to the other side (a term of \
lower maximum index) in the current sequent and eliminate the equation: \
fails if this condition doesn't obtain [rf]"
helpdict["rf"]="rf:  use the first equation to rewrite \
one side (an indexed constant) to the other side (a term of \
lower maximum index) in the current sequent and eliminate the equation: \
fails if this condition doesn't obtain [Rf()]"

# printproof is the command which displays printed proofs
# for Showall, for example.

# toreturn is a utility for printproof, reading the first line
# of a sequent identifier.

def toreturn(s):
    if s == '':  return s
    if s[0]=='\n':return ''
    return s[0]+toreturn(s[1:])

def printproof(P):
    print(printsequent(P[0]))
    if len(P)<2:
        print ('\nbad proof structure\n')
        return 0
    if P[1]=='goal': print('\ngoal\n')    
    if completeproof(P):  print('proved')
    if not completeproof(P):  print('\nnot yet proved\n')
    if P[1]==[]:
        if sequentnumber(P[0][0])== -1:  print('\ntheorem\n')
        if not sequentnumber(P[0][0]) == -1:  print('\ntrivial\n')
    if not P[1]=='goal' and not P[1]==[]:
        bystring=''
        for Q in P[1]: bystring=bystring+'\nAND\n'+toreturn(str(Q[0][0]))
        bystring='by '+bystring[5:]
        print(bystring+'\n')
        for Q in P[1]:  printproof(Q)



def logproof(P):
    echo(printsequent(P[0]))
    if len(P)<2:
        echo('\nbad proof structure\n')
        return 0
    if P[1]=='goal':
        echo('\ngoal\n')
        
    if completeproof(P):  echo('proved')
    if not completeproof(P):  echo('\nnot yet proved\n')
    if P[1]==[]:
        if sequentnumber(P[0][0])== -1:  echo('\ntheorem\n')
        if not sequentnumber(P[0][0]) == -1:  echo('\ntrivial\n')
    if not P[1]=='goal' and not P[1]==[]:
        bystring=''
        for Q in P[1]: bystring=bystring+'\nAND\n'+toreturn(str(Q[0][0]))
        bystring='by '+bystring[5:]
        echo(bystring+'\n')
        for Q in P[1]:  logproof(Q)

def iecho(s):
    print(s)
    ilogfile.write(inserthash(s))

def ilogproof(P):
    iecho(printsequent(P[0]))
    if len(P)<2:
        iecho('\nbad proof structure\n')
        return 0
    if P[1]=='goal':
        iecho('\ngoal\n')
        
    if completeproof(P):  iecho('proved')
    if not completeproof(P):  iecho('\nnot yet proved\n')
    if P[1]==[]:
        if sequentnumber(P[0][0])== -1:  iecho('\ntheorem\n')
        if not sequentnumber(P[0][0]) == -1:  iecho('\ntrivial\n')
    if not P[1]=='goal' and not P[1]==[]:
        bystring=''
        for Q in P[1]: bystring=bystring+'\nAND\n'+toreturn(str(Q[0][0]))
        bystring='by '+bystring[5:]
        iecho(bystring+'\n')
        for Q in P[1]:  ilogproof(Q)

# set up for global instantiation

# returns maximum object index  (the maximum index in a term
# of an arbitrary constant or instantiable; an instantiable can
# only properly be replaced by a term with lower maximum index.

# verssions for terms, lists, sequents

def maxindex(t):
    global theproof
    if (t[0]=='constant' or t[0]=='instantiable') and len(t)==3:  return int(t[2])
    if t[0]=='unary':  return (maxindex(t[2]))
    if t[0]=='binary':
        m=maxindex(t[2])
        n=maxindex(t[3])
        if m>n: return m
        return n
    return -1

# checks for negative index subterms (minindex<-1 is bad)

def minindex(t):
    global theproof
    if (t[0]=='constant' or t[0]=='instantiable') and len(t)==3:  return int(t[2])
    if t[0]=='unary':  return (minindex(t[2]))
    if t[0]=='binary':
        m=minindex(t[2])
        n=minindex(t[3])
        if m<n: return m
        return n
    return -1

def maxlistindex(L):
    if len(L)==0:  return -1
    m=maxindex(L[0][0])
    n=maxlistindex(L[1:])
    if m>n: return m
    return n

def maxsequentindex(S):
    m=maxlistindex(S[1])
    n=maxlistindex(S[2])
    if m>n: return m
    return n

# substitutions into lists and proofs

def listsub(t,v,L):
    if L==[]:  return []
    global theproof
#    return [[substitute(t,v,L[0][0]),L[0][1]]]+listsub(t,v,L[1:])
    list1 = L
    list2 = []
    while(not(list1==[])):
        list2 = list2+[[substitute(t,v,list1[0][0]),list1[0][1]]]
        list1 = list1[1:]
    return list2

# this command is used by Rf()--adds genealogy information

def listsubplus(t,v,L,i):
    if L==[]:  return []
    global theproof
    return [[substitute(t,v,L[0][0]),L[0][1]+i]]+listsubplus(t,v,L[1:],i)

def sequentsub(t,v,S):
    global theproof
    return [S[0],listsub(t,v,S[1]),listsub(t,v,S[2])]

def proofsub(t,v,P):
    global theproof
    if P[1]=='goal':  return [sequentsub(t,v,P[0]),'goal']
    return [sequentsub(t,v,P[0]),prooflistsub(t,v,P[1])]

def prooflistsub(t,v,L):
    global theproof
    if L==[]:  return []
#    return [proofsub(t,v,L[0])]+prooflistsub(t,v,L[1:])
    list1 = L
    list2 = []
    while(not(list1==[])):
        list2=list2+[proofsub(t,v,list1[0])]
        list1=list1[1:]
    return list2

# substitution for an instantiable, appropriately
# guarded by index

# one cannot substitute a class for an instantiable.

def instantiate(t,v,P):
    global theproof
    if not v[0]=='instantiable':  return P
    if type(t)=='class':
        printerror('cannot instantiate with class term')
        return P
    if not maxindex(t)<maxindex(v):
        printerror('substitution fails because term is newer than instantiable\n')
        return P
    return proofsub(t,v,P)

# substitution for propositional variables in lists, sequents
# and proofs

def proplistsub(t,v,L):
    if L==[]:  return []
    global theproof
    return [[propsubstitute(t,v,L[0][0]),L[0][1]]]+proplistsub(t,v,L[1:])

def propsequentsub(t,v,S):
    global theproof
    return [S[0],proplistsub(t,v,S[1]),proplistsub(t,v,S[2])]

def propproofsub(t,v,P):
    global theproof
    if P[1]=='goal':  return [propsequentsub(t,v,P[0]),'goal']
    return [propsequentsub(t,v,P[0]),propprooflistsub(t,v,P[1])]

def propprooflistsub(t,v,L):
    global theproof
    if L==[]:  return []
    return [propproofsub(t,v,L[0])]+propprooflistsub(t,v,L[1:])

#  operator substitution into lists, sequents and proofs

def oplistsub(t,v,L):
    if L==[]:  return []
    global theproof
    return [[opsubstitute(t,v,L[0][0]),L[0][1]]]+oplistsub(t,v,L[1:])

def opsequentsub(t,v,S):
    global theproof
    return [S[0],oplistsub(t,v,S[1]),oplistsub(t,v,S[2])]

def opproofsub(t,v,P):
    global theproof
    if P[1]=='goal':  return [opsequentsub(t,v,P[0]),'goal']
    return [opsequentsub(t,v,P[0]),opprooflistsub(t,v,P[1])]

def opprooflistsub(t,v,L):
    global theproof
    if L==[]:  return []
    return [opproofsub(t,v,L[0])]+opprooflistsub(t,v,L[1:])

# this is the user command to select witnesses; there are
# two versions, Inst and SU (SetUnknown).  To instantiate instantiable
# x$5 with term T, either Inst('T','x$5') or SU('x$5 := T')
# SU has just one pseudo-term quoted argument, analogous to
# Define.

def Inst(t,v):
    usercommand('Inst('+quotestr(t)+','+quotestr(v)+')\n')
    global theproof
    T=parse(t)
    V=parse(v)
    if type(T)=='bad' or not(freevars(T) == []):
        printerror('source does not parse, is not well-typed, or contains free variables?\n')
        return 'error'
    theproof=instantiate(T,V,theproof)
    shownextgoal(theproof)

helpdict["Inst"]="Inst(t,v):  term t of lower maxindex than v,\
an instantiable, replaces v globally in the proof"

#internal version of Inst used to implement SU

def InstI(T,V):
#    usercommand('Inst('+quotestr(t)+','+quotestr(v)+')\n')
    global theproof
#    T=parse(t)
#    V=parse(v)
    if type(T)=='bad' or not(freevars(T) == []):
        printerror('source does not parse, is not well-typed, or contains free variables?\n')
        return 'error'
    theproof=instantiate(T,V,theproof)
    shownextgoal(theproof)

# the alternative user command for instantiation

def SU(s):
    usercommand('SU('+quotestr(s)+')\n')
    S=parse(s)
    if len(S)==4 and S[0]=='binary' and S[1]==['operator',':=']:
        InstI(S[3],S[2])
        return('done')
    printerror('badly formed input to SU')
    return ('fail')

helpdict["SU"]="SU('x$n:=t'):  replace x$n globally in proof with t,\
which has maxindes less than n [SU]"
helpdict["SU"]="SU:  replace x$n globally in proof with t,\
which has maxindes less than n [SU('x$n:=t')]"    

# globally replace a propositional variable v with a sentence term t
# with no free variables

def PropInst(t,v):
    usercommand('PropInst('+quotestr(t)+','+quotestr(v)+')\n')
    global theproof
    theproof=propproofsub(parse(t),parse(v),theproof)
    shownextgoal(theproof)

helpdict["PropInst"]="PropInst(t,v):  proposition term t replaces \
propositional variable v globally in the proof [PrI]"
helpdict["PrI"]="PrI:  proposition term t replaces \
propositional variable v globally in the proof [PropInst(t,v); supply t from SP1]"

# globally replace a general (indexed) operator

def OpInst(t,v):
    usercommand('OpInst('+quotestr(t)+','+quotestr(v)+')\n')
    global theproof
    theproof=opproofsub(getident(t)[0],getident(v)[0],theproof)
    shownextgoal(theproof)

helpdict["OpInst"]="OpInst(t,v):\
operator t replaces indexed operator v globally in the proof [OpI]"
helpdict["OpI"]="OpI:\
operator t replaces indexed operator v globally in the proof [OpInst(t,v):  supply t from SP1]"

# display the current proof

def Showall():
    usercommand('Showall()\n')
    global theproof
    printproof(theproof)

helpdict["Showall"]="Showall():  show the entire proof of the current proved sequent [SA]"
helpdict["SA"]="SA:  show the entire proof of the current proved sequent [Showall()]"

# display and log the current proof

def LogTheProof():
    usercommand('LogTheProof()\n')
    global theproof
    printproof(theproof)
    logproof(theproof)

def iLogTheProof():
    usercommand('LogTheProof()\n')
    global theproof
    printproof(theproof)
    ilogproof(theproof)

helpdict["LogTheProof"]="LogTheProof():  show and log the entire proof of the current proved sequent [LP]"
helpdict["LP"]="LP:  show and log the entire proof of the current proved sequent [LogTheProof()]"


# lists of theorems and proofs on desktop

Theorems={}

Proofs={}

# save and load proofs in progress on desktop
# these are now saved and reloaded with back history

def Saveproof(Name):
    global theproof
    global backhistory
    global forwardhistory
    global nextobjectindex
    global linesused
    global newlineindex
    global constructive
    if theproof==theproof0:
        print('There is no proof\n')
        return 'fail'
    name=strip(Name)
    usercommand('\n\nSaveproof('+quotestr(name)+')\n')
    if name in list(Theorems.keys()):
        print ('\ncannot overwrite saved theorem '+name+'\n')
        return 'conflict'    
    Proofs[name]=[theproof,backhistory,nextobjectindex,linesused,newlineindex,constructive]

helpdict["Saveproof"]="Saveproof(Name):\
save current proof onto desktop with name obtained\
by stripping Name of non-Marcel characters [Sprf]"
helpdict["Sprf"]="Sprf:\
save current proof onto desktop with name obtained\
by stripping Name of non-Marcel characters [Saveproof(Name)]"

def SaveproofI(Name):
#    usercommand('\n\nSaveproof('+quotestr(name)+')\n')
    name=strip(Name)
    if name in list(Theorems.keys()):
        print ('\ncannot overwrite saved theorem '+name+'\n')
        return 'conflict'
    Proofs[name]=[theproof,backhistory,nextobjectindex,linesused,newlineindex,constructive]

def Loadproof(name):
    usercommand('\n\nLoadproof('+quotestr(name)+')\n')
    global theproof
    global backhistory
    global forwardhistory
    global nextobjectindex
    global linesused
    global newlineindex
    global constructive
    forwardhistory=[]
    theproof=Proofs[name][0]
    backhistory=Proofs[name][1]
    nextobjectindex=Proofs[name][2]
    linesused=Proofs[name][3]
    newlineindex=Proofs[name][4]
    constructive=Proofs[name][5]
    Look()

helpdict["Loadproof"]="Loadproof(name):  get the proof saved with the given name [Lprf]"
helpdict["Lprf"]="Lprf:  get the proof saved with the given name [Loadproof(name)]"                          

# internal command to get a line in a proof
# by the first line of its identifier

def getline(label,P):
    global theproof
    if not len(P)==2:  return 'bad'
    if not len(P[0]) == 3:  return 'bad'
    if toreturn(P[0][0])==label: return P
    if P[1]=='goal':  return 'bad'
    for Q in P[1]:
        F=getline(label,Q)
        if not F=='bad':  return F
    return 'bad'

# save a theorem by name:  first argument is
# a sequent identifier first line.

# this now also silently executes Saveproof, so
# one can load the proof of a theorem (including its back history)
# using Loadproof with the same key
    
def Savetheorem(label,Name):
    global constructive
    name=strip(Name)
    usercommand('\n\nSavetheorem('+quotestr(label)+','+quotestr(name)+')\n')
    global theproof
    if theproof==theproof0:
        print('There is no proof\n')
        return 'fail'
    if label in list(Theorems.keys()):  return 'cant get a theorem line'
    if name in list(Theorems.keys()):  return 'conflict'
    if name[:5]=='Line ':  return 'cant name a theorem as a line number'
    P=getline(label,theproof)
    if P=='bad':  return 'label not found'
    if completeproof(P):
        SaveproofI(name)
        Theorems[name]=[P,constructive]
        Showthm(name)
    if not completeproof(P):  return 'not proved'

helpdict["Savetheorem"]="Savetheorem(label,Name):\
save the proved subsequent with the given label\
in the current proof as a theorem with name obtained\
by stripping non-Marcel characters from Name [Sthm]"
helpdict["Sthm"]="Sthm:\
save the proved subsequent with the given label\
in the current proof as a theorem with name obtained\
by stripping non-Marcel characters from Name [Savetheorem(label,Name);  supply label from SP1]"

# macro to handle the commonest theorem saving situation

def Savethetheorem(name):
    Savetheorem('Line 1',name)

helpdict["Savethetheorem"]="Savethetheorem(name): \
save the current completed proof with name obtained\
by stripping non-Marcel characters from name argument [ST]"
helpdict["ST"]="ST: \
save the current completed proof with name obtained\
by stripping non-Marcel characters from name argument [Savethetheorem(name)]"

# internal version of Savetheorem called by Axiom

def SavetheoremI(label,Name):
    name=strip(Name)
    global theproof
    if label in list(Theorems.keys()):  return 'cant get a theorem line'
    if name in list(Theorems.keys()):  return 'conflict'
    if name[:5]=='Line ':  return 'cant name a theorem as a line number'
    P=getline(label,theproof)
    if P=='bad':  return 'label not found'
    if completeproof(P):
        Theorems[name]=[P,constructive]
        Showthm(name)
    if not completeproof(P):  return 'not proved'

# this creates a sequent with proposition p as content
# and asserts it proved

# I think the flexibility of having axioms with generalities
# is safe and worthwhile, so I removed the defsafe check.
# note that anything an axiom says about an arbitrary constant
# is implicitly universally quantified.

# it is an incidental fact about this command that it clears
# all back history in the current proof.   But probably one should
# not introduce an axiom in the middle of a proof.

def Axiom(name,p):
    usercommand('\n\nAxiom('+quotestr(name)+','+quotestr(p)+')\n')
    global nextobjectindex
    nextobjectindex=1
    if not freevars(parse(p))==[]:  return 'bad'
    if not type(parse(p))=='prop': return 'bad'
#    if not defsafe(parse(p)):  return 'bad'  #this could be removed
    global nextsequent
    nextsequent=0
    global theproof
    global backhistory
    global forwardhistory
    theproof=[[name,[],[[parse(p),[0]]]],[]]
    backhistory=[]
    forwardhistory=[]
    print(printsequent(theproof[0]))
    SavetheoremI(name,name)

helpdict["Axiom"]="Axiom(name,p):  save proposition p as a theorem (asserted as an axiom) with name the name argument [AX]"
helpdict["AX"]="AX:  save proposition p as a theorem (asserted as an axiom) with name the name argument [Axiom(name,p); get name from SP1]"

def singleton(p):  return [[],[p],'']

# distribution list for applying a sequent as a rule

def theoremexpand0(S):
    global thedifferential
    global oldobjectindex
    global nextobjectindex
    global newlineindex
    global linesused
    global thetheorem
    def fix(Q):
            return [Q,[thetheorem]]
    def inst2(T):  return fix(instsubstitute0(T[0]))
    thedifferential=maxsequentindex(S)
    oldobjectindex=nextobjectindex
#    nextobjectindex=nextobjectindex+thedifferential+1
    linesused=[thetheorem]+linesused
    return list(map(singleton,(list(map(inst2,S[1])))))+[[list(map(inst2,S[2])),[],'']]
    
def Thm(name):  return Theorems[name][0][0]

thetheorem=''

def UseThm0(S):
    global thetheorem
    if constructive and not(Theorems[thetheorem][1]==True): return 'constructivity failure'
    def fix(Q):
        return [Q[0],[thetheorem]]
    return [[[thetheorem,list(map(fix,Theorems[thetheorem][0][0][1])),\
              list(map(fix,Theorems[thetheorem][0][0][2]))],[]]]\
              +distribute(theoremexpand0(Theorems[thetheorem][0][0]),S)

# change the declaration of operator op to have output type
# "object" if theorem th has the correct form to say that its range
# is strongly cantorian.  This tightens up the type system.  We
# do not want separate declarations that sets are s.c. so we can
# restrict to them.  But we can use a proof that a set is s.c. to
# define a retraction to that set with s.c. input and output, which
# we can then use to label variables as of 'type' element of that set.

def Scout(op,th):
    usercommand("Scout("+quotestr(op)+","+quotestr(th)+")")
    if not op in list(optypes.keys()):
        print ("operator not declared")
        return "failed"
    if not th in list(Theorems.keys()):
        print("theorem not declared")
        return "failed"
    if not(Thm(th)[1]==[]):
        print("Theorem is not of right form (1)")
        return "failed"
    if not (len(Thm(th)[2])==1):
        print("Theorem is not of right form (2)")
    if matches(Thm(th)[2][0][0],parse('(Ef1:(Ax:f1` ('+op+'x)={y:y= '+op+'x}))')):
        optypes[op]=['object','object']
        Showdec(op)
        return 'done'
    print("Theorem is not of the right form (3)")
    return('failed')

helpdict['Scout']="Scout(op,th):  redeclares the unary operator op to have object input\
 and object output if theorem th proves that (Ef1:Ax:f1`(op(x)) = {y:y= op(x)} in\
 precisely that form (an assertion that op has strongly cantorian range) [SC]"
helpdict['SC']="SC:  redeclares the unary operator op to have object input\
 and object output if theorem th proves that (Ef1:Ax:f1`(op(x)) = {y:y= op(x)} in\
 precisely that form (an assertion that op has strongly cantorian range) [Scout(op,th);  enter th using SP1]"

# user command to apply a theorem.   All arbitrary axioms and
# instantiables have index raised appropriately.

def Usethm(name):
    usercommand('Usethm('+quotestr(name)+')\n')
    if not name in list(Theorems.keys()):
        printerror('No such theorem\n')
        return 'fails'
    global thetheorem
    thetheorem=name
    act(UseThm0)

helpdict["Usethm"]="Usethm(name):  apply the theorem indicated\
by the name argument to the current sequent:  create sequents \
proving each premise of the theorem and a sequent with the conclusion as a premise [u]"
helpdict["u"]="u:  apply the theorem indicated\
by the name argument to the current sequent:  create sequents \
proving each premise of the theorem and a sequent with the conclusion as a premise [Usethm(name)]"

# user command to display a definition.
# non-logged user command

def Showdef(name):
    print('\n\n')
    if not name in list(Definitions.keys()):
        print('\n'+name+' not found in definitions list\n')
        return 'error'
    if name in declaredconstants:
        echo(name+':\n\n')
        echo(termprint(['binary',['operator','='],['constant',name],Definitions[name]]))
        print('\n\n')
        return 'done'
    if len(optypes[name])==3:
        echo (name+':\n\n')
        echo(termprint(['binary',['operator','='],['binary',['operator',name],\
                    ['constant','.arg','1'],['constant','.arg','2']],Definitions[name]]))
        print('\n\n')
        return 'done'
    if len(optypes[name])==2:
        echo (name+':\n\n')
        echo(termprint(['binary',['operator','='],['unary',['operator',name],\
                    ['constant','.arg','1']],Definitions[name]]))
        print('\n\n')
        return 'done'
    return 'error'

helpdict["Showdef"]="Showdef(name):  show the definition of the identifier name [SD]"
helpdict["SD"]="SD:  show the definition of the identifier name [Showdef(name)]"

def ShowdefU(name):
    usercommand('ShowdefU('+quotestr(name)+')\n')
    print('\n\n')
    if not name in list(Definitions.keys()):
        printerror(name+' not found in definitions list\n')
        return 'error'
    if name in declaredconstants:
        echo(name+':\n\n')
        echo(termprint(['binary',['operator','='],['constant',name],Definitions[name]]))
        print('\n\n')
        return 'done'
    if len(optypes[name])==3:
        echo (name+':\n\n')
        echo(termprint(['binary',['operator','='],\
                         ['binary',['operator',name],['constant','.arg','1'],\
                          ['constant','.arg','2']],Definitions[name]]))
        print('\n\n')
        return 'done'
    if len(optypes[name])==2:
        echo (name+':\n\n')
        echo(termprint(['binary',['operator','='],['unary',['operator',name],\
                                ['constant','.arg','1']],Definitions[name]]))
        print('\n\n')
        return 'done'
    return 'error'

helpdict["ShowdefU"]="Showdef(name):  show the definition of the identifier name.  Logged command."

# display a theorem or axiom
# non-logged user command

def Showthm(name):
    print('\n\n')
    if not name in list(Theorems.keys()):
        printerror(name+' not found in theorem list\n')
        return 'error'
    constructivitycomment=""
    if Theorems[name][1]==True : constructivitycomment=" (constructive)"
    echo (name+constructivitycomment+':\n\n')
    echo(printsequent(Theorems[name][0][0]))

helpdict["Showthm"]="Showthm(name):  display the theorem with the given name [Stm]"
helpdict["Stm"]="Stm:  display the theorem with the given name [Showthm(name)]"

def ShowthmU(name):
    usercommand('\n'+'ShowthmU('+(quotestr(name))+')\n')
    print('\n\n')
    if not name in list(Theorems.keys()):
        printerror(name+' not found in theorem list\n')
        return 'error'
    print (name+':\n\n')
    print(printsequent(Theorems[name][0][0]))

helpdict["ShowthmU"]="ShowthmU(name):  display the theorem with the given name.  Logged command."

def Showalltheorems():
    global demomode
    old=demomode
    demomode=True
    for K in list(Theorems.keys()):
        ShowthmU(K)
    demomode=old

helpdict["Showalltheorems"]="Showalltheorems(): \
show all theorems, hitting enter to page through them [SAT]"
helpdict["SAT"]="SAT: \
show all theorems, hitting enter to page through them [Showalltheorems()]"

def Showalldefinitions():
    global demomode
    old=demomode
    demomode=True
    for K in list(Definitions.keys()):
        ShowdefU(K)
    demomode=old

helpdict["Showalldefinitions"]="Showalldefinitions(): \
show all definitions, hitting enter to page through them [SAD]"
helpdict["SAD"]="SAD: \
show all definitions, hitting enter to page through them [Showalldefinitions()]"


# development of the autoprune operation.  At the end of
# the proof, all lines (premises and conclusions) not actually used are removed.

def autoprunelist(L):
    global linesused
    if L==[]:  return []
    if L[0][1][0] in linesused:  return [L[0]]+autoprunelist(L[1:])
    return autoprunelist(L[1:])

def autoprunesequent(S):
    return [S[0],autoprunelist(S[1]),autoprunelist(S[2])]

def autopruneproof(S):
    if completeproof(S):  return [autoprunesequent(S[0]),list(map(autopruneproof,S[1]))]
    if S[1]=='goal':return S
    return [S[0],list(map(autopruneproof,S[1]))]

doprune=True

def togglepruning():
    global doprune
    doprune=not(doprune)

# the autoprune command eliminates premises and conclusions from proofs
# which we can tell are never used.

def Autoprune():
    global theproof
    global doprune
    if doprune==True: theproof=autopruneproof(theproof)

# enable commands in Marcel ML style

def l():  Left()

helpdict["l()"]=helpdict["Left"] + " (abbreviation)"

def r():  Right()

helpdict["r()"]=helpdict["Right"]+ " (abbreviation)"

def gl(n):
    global theproof
    usercommand('gl('+str(n)+');')
    if n>1: GetleftI(); glI(n-1)
    shownextgoal(theproof)

def gl2(n):
    global theproof
#    usercommand('gl('+str(n)+');')
    if n>1: Getleft2I(); gl2(n-1)
#    shownextgoal(theproof)

helpdict["gl"]="gl(n):  get posit/premise/assumption n to front"
    
def glI(n):
#    usercommand('gl('+str(n)+')')
    if n>1: GetleftI(); glI(n-1)

def gr(n):
    global theproof
    usercommand('gr('+str(n)+');')
    if n>1: GetrightI(); grI(n-1)
    shownextgoal(theproof)

def gr2(n):
    global theproof
#    usercommand('gr('+str(n)+');')
    if n>1: Getright2I(); gr2(n-1)
#    shownextgoal(theproof)

helpdict["gr"]="gr(n): get goal/conclusion n* to first goal position"
    
def grI(n):
#    usercommand('gr('+str(n)+');')
    if n>1: GetrightI(); grI(n-1)
def gle(n):
    global theproof
    usercommand('gle('+str(n)+');')
    if n>2: GetleftEI(); gleI(n-1)
    shownextgoal(theproof)

helpdict["gle"]="gle(n): get premise n>1 to second position"

def gleI(n):
#    usercommand('gle('+str(n)+');')
    if n>2: GetleftEI(); gleI(n-1)
    

def s(T):Start(T)

# helpdict["s"] = helpdict["Start"]+ " (abbreviation)"

def b():  Back()

helpdict["b()"]=helpdict["Back"]+ " (abbreviation)"

def f():  Forward()

helpdict["f()"]=helpdict["Forward"]+ " (abbreviation)"

# these can stay macros  -- prune line n on left or right
# a refinement would put the lines back in the same place.

# These commands should be fixed so that they have sensible
# effects on line numbers and can be logged.

def pl(n):
    global theproof
    usercommand('pl('+str(n)+');')
    glI(n)
    PruneleftI()
    gl2(n)
    shownextgoal(theproof)

# helpdict["pl"]="pl(n):  removes premise n"

def pr(n):
    global theproof
    usercommand('pr('+str(n)+');')
    grI(n)
    PrunerightI()
    gr2(n)
    shownextgoal(theproof)

# helpdict["pr"]="pr(n):  remove goal n"

Oneconclusion2()

# Done2 shortcut:  if premise m matches conclusion n, done.

def triv(m,n):
    usercommand('triv('+str(m)+','+str(n)+');')
    glI(m);grI(n); Done2I();

helpdict["triv"]="triv(m,n):  close proof if premise m is the same as goal n*"

def showtheproof():
    print(str(theproof))

def showlinesused():
    print(str(linesused))

def returnbackhistory():
    return backhistory

def Help():
    print("r():  act on goal\nl(): \
act on first posit/assumption\ngl(n) [n an integer]: \
get posit/assumption n to first position\ngr(n) [n an integer]:\
get alternative goal n* (with ~ removed) as goal\nDone(): \
finish proof of sequent if first assumption and goal match\ntriv(m,n):\
finish proof of sequent if posit m and goal m* match\ns('p'): \
start proof of p\nSU('x$n:=t'):  replace instantiable x$n with t\
\ndeclareproperty('P'):  declare P as a unary predicate\ndeclarerelation('R'):\
declare R as a binary relation\nLook(): \
display the current sequent\nsetlog(filename):\
set logfile to filenamelogfile.py (clearing this log, \
closing previous logs)\naddtolog(filename): \
set log file to filenamelogfile.py, appending to this log, closing previous logs.")
    versiondate()
helpdict["Help"]="Help():  print short list of commonly used commands with descriptions"

def help(s):
   if not s in list(helpdict.keys()): return "not_found"
   print('\n'+helpdict[s])
   versiondate()

helpdict["help"]="help(s):  print description of command s"

def helpguide():  print(helpdict.keys()); versiondate()

helpdict["helpguide"]="helpguide():  display a list of all the commands for which help exists"

# these commands are misnamed:  they started out as second
# arguments which are precedences, but they are in fact general
# additional parameters for native interface commands.

def isnumerals(s):
    s2=s
    if len(s)==0:  return False
    while len(s2)>1:
        if not(isnumeral(s[0])):  return False
        s2=s2[1:]
    return isnumeral(s2[0])
        

def safeint(s):
    if isnumerals(s): return int(s)
    return 0

prectobeset= "0"

def startsetprec(s):
    global prectobeset
    prectobeset = s

prectobeset2= "0"

def startsetprec2(s):
    global prectobeset2
    prectobeset2 = s

helpdict["SP1"] = "SP1:  set first additional parameter to a subsequent native interface command"
helpdict["SP2"]= "SP2: set second additional parameter to a subsequent native interface command"

def fromsemi (s):
    if s=='':  return ''
    if s[0]==';':  return s[1:]
    return fromsemi (s[1:])

def tosemi(s):
    if s=="":  return ""
    if s[0] == ';':  return ""
    return s[0]+tosemi(s[1:])

# tiny experimental interface

def interface(ss):
  global ilogfile
  global prectobeset
  if (not ss=="") and (not os.path.isfile(ss+'ilogfile.ilg')):
      print ('No such file')
      ss=''
  if not ss=='': inputfile=open(ss+'ilogfile.ilg','r')
  kk=''
  while(not(kk=='quit')):
     K=fromsemi(kk)
     if K[0:2]=='SL' or K[0:2]=='AL' or K[0:2]=='LP': K=='' # don't allow logs to be set
     # in deferred commands.
     if K=='':
         if ss == '':
             kk=input('Enter quit to break out of interface:\n\n>> ')
             if (not kk[0:2]=='SL') and (not kk[0:2]=='AL') and (not kk[0:2]=='LP'): ilogfile.write(kk+'\n')
             print("\n")
         if not ss=='':
             kk=inputfile.readline()[0:-1]
             #ilogfile.write(kk+'\n\n')
     if not K=='':
         kk = K
     k= strip(tosemi(kk))
     
     if k == 'l':
        Left()
#        interface()

     if k == 'b':
        b()
#        interface()
     if k == 'f':
        f()
#        interface()

     if k == 'F':
         Forget()
        
        
     if k=='r':
        Right()
#        interface()
        
     if k== 'd':
        Done()
#        interface()

     if k=='d2':
        Done2()

     if k=='' and ss=='':
         Look()

     if k=='SA':
         Showall()

     if k=='SAT':
         Showalltheorems()

     if k=='SAD':
         Showalldefinitions()
         
     if k=='LP':
       iLogTheProof()

     if k=='rf':
       Rf()

     if k=='DEM':  Demo()
     if k == "ERP":  Errorpause()
     if k == "HLPR":  helpreview()
     if k=='OC1': Oneconclusion()
     if k=='MC1': Manyconclusions()
     if k=='OC2': Oneconclusion2()
     if k=='MC2': Manyconclusions2()

     if k=='NG':  Nextgoal()
     if k=='SG':  Swapgoals()
     if k=='Co':  Constructive()
     if k == "Cl": Classical()
     
# Here is the suite of user equality commands.
# d or c determines the way the equation is to be read
# r or l determines whether it is applied to conclusion or premise
# 0 1 or 2 determines whether application is everywhere
# or leftmost with matching or rightmost with matching.

     if k=="EDR0":
         Equaldr0()
     if k=="EDR1":
         Equaldr1()
     if k=="EDR2":
         Equaldr2()

     if k=="EDL0":
         Equald10()
     if k=="EDL1":
         Equaldl1()
     if k=="EDL2":
         Equaldl2()

     if k=="ECR0":
         Equalcr0()
     if k=="ECR1":
         Equalcr1()
     if k=="ECR2":
         Equalcr2()

     if k=="ECL0":
         Equalc10()
     if k=="ECL1":
         Equalcl1()
     if k=="ECL2":
         Equalcl2()

     if k=='L':  Look()
     if k=='Sn':  Snapshot()
     if k=='Sc': Scriptmode()

        
     if len(k)>=3 and k[0:3]=='glt':
        glt (safeint(k[3:]))
#        interface()
       
     if len(k)>=3 and k[0:3]=='grt':
        grt (safeint(k[3:]))
#        interface()

     if len(k)>=3 and k[0:3]=='get':
        gltE (safeint(k[3:]))
#        interface()    
         
        
     if len(k)>=2 and k[0:2]=='gl':
        gl (safeint(k[2:]))
#        interface()
       
     if len(k)>=2 and k[0:2]=='gr':
        gr (safeint(k[2:]))
#        interface()

     if len(k)>=2 and k[0:2]=='ge':
        gle (safeint(k[2:]))
#        interface()

     if len(k)>=2 and k[0:2]=='SU':
        print (strip(k[2:]))
        SU  (strip(k[2:]))

     if len(k)>=2 and k[0]=='s':
        s (k[1:])

     if len(k)>=2 and k[0:2]=='ST':
        Savethetheorem (strip(k[2:]))
     if len(k)>=2 and k[0:2]=='SM':
        SetMargin (safeint(strip(k[2:])))

     if len(k)>=2 and k[0]=='u':
        Usethm (strip(k[1:]))

     if len(k)>=2 and k[0:2]=='SL':
        ilogfile.write('quit\n')
        setilog (strip(k[2:]))

     if len(k)>=2 and k[0:2]=='AL':
        ilogfile.write('quit\n')
        addtoilog (strip(k[2:]))

     if len(k)>=2 and k[0:2]=='RL':
        interface (strip(k[2:]))

     if len(k)>=2 and k[0:2]=='Sd':
        Showdec (strip(k[2:]))
     if len(k)>=2 and k[0:2]=='SD':
        Showdef (strip(k[2:]))
     if len(k)>=3 and k[0:3]=='Stm':
        Showthm (strip(k[3:]))        

     if len(k)>=2 and k[0:2]=='DP':
        declareproperty (strip(k[2:]))
     if len(k)>=2 and k[0:2]=='DR':
        declarerelation (strip(k[2:]))
     if len(k)>=2 and k[0:2]=='DF':
        declarefunction (strip(k[2:]))
     if len(k)>=2 and k[0:2]=='DO':
        declareoperation (strip(k[2:]))
     if len(k)>=2 and k[0:2]=='DC':
        Declareconstant (strip(k[2:]))
     if len(k)>=2 and k[0:2]=='DQ':
        declarequantifier (strip(k[2:]))
     if len(k)>=3 and k[0:3]=='DEF':
        Define (strip(k[3:]))        
     if len(k)>=3 and k[0:3]=='DEB':
        Definebinder (strip(k[3:]))

     if len(k)>=3 and k[0:3]=='CUT':
        Cut (strip(k[3:]))

        
     if len(k)>=3 and k[0:3]=='DSF':
        declarescfunction (strip(k[3:]))
     if len(k)>=3 and k[0:3]=='DSO':
        declarescoperation (strip(k[3:]))
     if len(k)>=3 and k[0:3]=='DSI':
        declarescinoperation (strip(k[3:]))
     if len(k)>=3 and k[0:3]=='DTF':
        declaretypedfunction (strip(k[3:]),safeint(prectobeset))
     if len(k)>=3 and k[0:3]=='DTR':
        declaretypedrelation (strip(k[3:]),safeint(prectobeset))

     if len(k)>=3 and k[0:3]=='PrI':
        PropInst (safeint(prectobeset),strip(k[3:]))
     if len(k)>=3 and k[0:3]=='OpI':
        OpInst (safeint(prectobeset),strip(k[3:]))

        
     if len(k)>=3 and k[0:3]=='DTO':
        declaretypedoperation (strip(k[3:]),safeint(prectobeset),safeint(prectobeset2))
     if len(k)>=4 and k[0:4]=='DoTL':
        declarelefttypedoperation (strip(k[4:]),safeint(prectobeset))
     if len(k)>=4 and k[0:4]=='DoTR':
        declarerighttypedoperation (strip(k[4:]),safeint(prectobeset))
     if len(k)>=4 and k[0:4]=='DoTS':
        declaretypedscoperation (strip(k[3:]),safeint(prectobeset))
     if len(k)>=3 and k[0:3]=='DIR':
        declarescinrelation (strip(k[3:]))
     if len(k)>=3 and k[0:3]=='DBF':
        declarefunctionbinder (strip(k[3:]))
     if len(k)>=4 and k[0:4]=='DSBF':
        declarescfunctionbinder (strip(k[4:]))
     if len(k)>=4 and k[0:4]=='DTBF':
        declaretypedfunctionbinder (strip(k[4:]),safeint(prectobeset))
     if len(k)>=3 and k[0:3]=='SP1':
        startsetprec (strip(k[3:]))
     if len(k)>=3 and k[0:3]=='SP2':
        startsetprec2 (strip(k[3:]))
     if len(k)>=3 and k[0:3]=='SP=':
        setprecsame(prectobeset,strip(k[3:]))
     if len(k)>=4 and k[0:4]=='SPEA':
        setprecevenabove(prectobeset,strip(k[4:]))
     if len(k)>=4 and k[0:4]=='SPEB':
        setprecevenbelow(prectobeset,strip(k[4:]))
     if len(k)>=4 and k[0:4]=='SPOA':
        setprecoddabove(prectobeset,strip(k[4:]))
     if len(k)>=4 and k[0:4]=='SPOB':
        setprecoddbelow(prectobeset,strip(k[4:]))

     if len(k)>=4 and k[0:4]=='Sprf':
        Saveproof(strip(k[4:]))
     if len(k)>=4 and k[0:4]=='Lprf':
        Loadproof(strip(k[4:]))
     if len(k)>=4 and k[0:4]=='Sthm':
        Savetheorem(safeint(prectobeset),strip(k[4:]))
     if len(k)>=2 and k[0:2]=='AX':
        Axiom(prectobeset,strip(k[2:]))      
     if len(k)>=2 and k[0:2]=='SC':
        Scout(strip(k[4:]),prectobeset)

     if len(k)>=2 and k[0:2]=='pl':
        pl(safeint(strip(k[2:])))
     if len(k)>=2 and k[0:2]=='pr':
        pr(int(strip(k[2:])))



     if len(k) >= 1 and k[0:1] == '?':
         help(strip(k[1:]))

  ilogfile.close()
  ilogfile=open('defaultilog.txt','a')
  if not ss=='':  inputfile.close()

helpdict['RL'] = 'RL:  Run native interface log file'

# report version date

versiondate()

# for Trinket, Marcel should start in its own shell

interface('')

