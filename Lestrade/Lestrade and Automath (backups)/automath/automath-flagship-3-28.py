import sys

import time

sys.setrecursionlimit(2000)

# implementation of core Automath function based on my draft paper,
# extended to check the Grundlagen translation.  This has been achieved.

# March 28:  timestamps are now controlled by a toggle, off by default

# March 17 flagship version, optimized to run fast.  Short display on by default.
# Toggle installed to turn on use of standardized keys in equation caching,
# but it is off by default.  Infix notation is enabled for both parsing
# and display, basically in APL style, with single quoted strings as infix
# identifiers as in historical Automath documents.

# Further optimized, enabling argument omission in infix terms.  Further,
# argument omission is stronger:  it is by comparison with the actual context,
# not the context in which the construction was declared, so it will apply more
# often.  This was already true for display (unintentionally),
# so it had better be true for parsing!  Even better (or worse) bound
# variables are treated as in the context during parsing, so invisible
# variables may actually be bound.  Such variables appear in display,
# because the display does not reset the context;  this is accidental, but
# probably is no bad thing.

# project:  option of building term implementing a book.  Note that this
# indicates that we allow ! and $ identifiers to be used as bound variables
# (these name the actual objects declared by construction lines and their
# sorts).  Not necessarily:  might use fresh bound variables construction_name###linenumber
# and convert all construction terms to application term form with the construction
# replaced by the appropriate bound variable name.  The book term
# of a line declaring f as a PN is [f### appropriate type]rest of book
# the book term of a line declaring f=D is <D>[f###:appropriate type]rest of book.
# the bindings in the rest of the book are handled automatically by
# the way construction terms are to be expanded.

# restore error recovery from the line reading function.

# 3/21 attempted to fix error recovery in ReadLine.  Added a toggle to turn on warnings about
# some redeclarations.

# 3/20 disabled prefix and infix displays qualified with line numbers
# since the parser cannot handle these and must parse displays in some situations.
# When qualified with a line number, a single quoted identifier is to behave
# like any other construction.  There still might be considerable weirdness in
# parsing a term with line-numbered single quoted identifiers in it;  but this
# should not often happen.

# 3/19 Restoring consistency to the infix/prefix solution:  I am letting
# all operators, including prefixes, have the same precedence and group
# to the right as far as possible.  This is unfamiliar but consistent.
# So ~p&q is the negation of p&q:  to get just the negation of p, ~(p)&q with
# explicit indication of shorter scope of ~

# 3/18 I believe I have a full solution for quoted prefix and infix operators in
# place.  It is not maximally elegant.  Infixes are all of the same precedence and
# group to the right as far as possible.  Prefixes are the same, with the exception
# that they bind tightly to atomic terms.  Function application and abstraction
# both bind more loosely than the infixes.  Displays will always parse as shown,
# I believe.  Both infix and prefix operators can also be used as constructions
# in the normal way, and normal constructors can be used as infixes (though
# with parentheses on both sides).  The display will always put infixes after
# the first argument in their argument list (which may have more than two terms;
# mixfix is supported).  Arguments are omitted just as for ordinary constructions.
# Prefixes will have their arguments unparenthesized where this is permissible.
# Note again that prefixes do not reliably bind more tightly than infixes:  if
# the leading term in an infix term is complex, a prefix will grab the entire term.

# 3/18 corrected glitch in need for parentheses:  the part after the infix
# shouldn't have  enclosed in parentheses if it begins with a parenthesis.  Found
# this by actually doing some logic with proper infix notation.

# 3/18 it now attempts comparison before beta reduction (equalterms will check
# if function and argument separately are the same before reducing and checking
# equality of the results).  This seems to dramatically help with places
# where reduction has stalled in past tests.

# 3/17 Infix notation is installed.  Identifiers are augmented to include
# arbitrary single quoted strings.  The display will show these as infix terms,
# not omitting any arguments:  they can however also be supplied as constructions
# in initial position.  In infix position, the parser will not accept line number
# suffixes on these.  It should accept paragraph references just fine, though.
# The display will show line number references on infixes.  The parser will
# accept infix terms with any construction (whether of infix form or not) as the infix.
# Grouping (for both parsing and display) is to the right as far as possible
# (no support for order of operations is intended).  Terms to the left of
# an infix are always parenthesized unless they are atomic.  Terms to the
# right of an infix do  not need to be parenthesized. An identifier to the left
# of a quoted infix does not need to be parenthesized.

# Note that this is actually mixfix:  what is really being done is that the
# argument list of a construction can be partitioned into two argument lists with
# the construction in the middle, with the modifications that an identifier to the left
# of a quoted identifier does not need to be parenthesized, and a one-argument list
# to the right of an identifier (in an infix term) does not need to be parenthesized,
# unless identifiers would merge.  All parentheses still are boundaries of construction
# argument lists!

# 3/16 fixing some oddities of display in the interface.  The interface
# needs to be enhanced with the ability to invoke some or all of the toggles.

# 3/15 forced variables introduced by FreshIdent (which can appear in contexts
# and be in effect free variables locally) to be disjoint from those produced
# by FreshIdent2, to avoid collisions.  It is essential for validity of
# renameallx and renameall2 that no free copy of the "fresh" variables
# they invoke can be encountered.  Now the only variables with # in them
# which can occur free are those produced by FreshIdent, and they have
# been forced to have ## in them.  For renameall2 this is less crucial:
# it is never used in a context where a ## variable might be in the context
# and so free in the term considered.  But renameallx is used in EqualTerms,
# which may be invoked in such contexts.

# 3/14 installed a timestamp posted after each construction declaration.

# 3/13 installed alphastandard again (as renameallx).  It appears that
# the only real use for this is to speed up matching:  using alpha standard
# forms as keys in caching seems to slow things down.  But being able
# to recognize terms identical up to renaming of bound variables as the
# same does gain speed.

# 3/12 enables variable binding with constructor names fully.  It ought to be safe to run
# the Grundlagen with the paragraph tweak.  Note that binding of identifiers
# with ! is probably wanted if we build terms representing books.

# put in a toggle to turn on the insane type inclusion, which does
# seem to make sense.  Variants such as turning off all type inclusion
# and turning on insane type inclusion just for prop should be considered.

#  3/7/2018 version intended to upgrade the type system.
#  I would like to allow use of metasorts as domains, without extending
# the subtyping.  This has been implemented.

# this version has a lot more experimental declarations!  Added the option
# of turning off the experimental declarations.

# In this type system, I should be able to build terms representing the
# declarations in a book, and these terms will be accommodated by the native
# type system.  They could in fact be declared within the system.  And
# all of this is done without declaring another tier (it is still just
# objects, sorts, and metasorts, with some additional functions at the
# level of complexity of metasorts.  Certainly the functions implementing
# constructions can now be declared internally.

# MICRO-MANUAL (probably needs updates)

# Welcome to MANIAC (for, MANIAC:  A Nice Interactive Automath Checker)

# It's not really very nice, but it is interactive!

# the term language I started with is standard late Automath
# (with types [x:t]prop which are subtypes of prop, for
# example) with certain caveats. The metasorts prop and type are lowercase.
# Identifiers consist of one or zero upper case letters,
# followed by zero or more lowercase letters, followed by zero or more
# numerals, and must have positive length.
# The identifiers are more free-form now because the Grundlagen requires it.
# Function application
# is written <x>f, function or type abstraction as [x:s]t, and construction
# application as f(t1,...,tn) as usual.  Omitting some or all of the
# arguments of a construction is supported in the inimitable Automath
# way, by filling in missing arguments from the front if they coincide
# in their spelling and types with the corresponding initial segment of
# the context.  The paragraph system is now supported yet, with paragraph
# qualifications of constructions and contexts.  The parser checks
# that constructors are declared and do not have too many arguments.
# The parser will read an identifier as a context variable in preference
# to reading it as a constructor, and will not read it as a constructor
# even in applied position if it is masked in this way.  The parser will
# not allow bound variables which coincide with constructors or with
# variables in the context.  Alas, the Grundlagen forced relaxation
# of some of these sanity checks.
# TERMS DO NOT CONTAIN WHITESPACE.

# A line in my original dialect consists of four terms, separated by whitespace.  Punctuation in
# The order is the usual context/identifier/value/type.
# The null context is written
# 00.  The special value
# EB is used for variable declaration lines and the special value PN for
# primitive construction declaration lines.
# These reserved words must be followed by spaces.  A new feature:  a special
# type ?? allows you to tell Automath to compute the type.

# The line style has been augmented to support the style of the
# Grundlagen.  Historical styles described by Wiedijk are described,
# but not styles with the identifier before the context.

# One can issue the command interface0() and type lines at the (empty)
# prompt.  The system will give you feedback about the effects of your lines.
# It will also give you fairly informative error messages.  Things are fragile,
# and it is definitely possible to cause Python errors if you confuse the parser
# or the type-checker enough.  Python crashes might possibly damage your environment
# if the crash happens while the context is dynamically extended for typing
# purposes...errors in the declaration commands of the checker will not
# do such damage, as they are properly designed to save and restore the
# context if necessary.  BUGS ARE VERY POSSIBLE, though I have run some
# moderately extensive bits of Automath text and ironed out some of the
# problems.

# One can run script files (books).  There are two types of scripts, .aut1 files
# and .aut2 files.  One can put Automath lines and
# persistent comments in these files (comments headed
# by #);  the system posts transitory comments to the file headed by % (feedback
# on your lines and error messages).  The command readbook filename1 filename2
# will read filename1.aut1 and post the results (including the original
# lines and persistent comments) to filename2.aut2.
# The command readbook2 filename1 filename2
# will read filename1.aut2 and post the results (including the original
# lines and persistent comments) to filename2.aut1.  The intention is that
# the transcript of the execution of a book is itself a book, and can
# be read back using the second command.

# Notation for the Grundlagen and the Grundlagen version of the paragraph
# system are supported.  Not all of Wiedijk's variants are supported
# The paragraph system as implemented here is close to but not
# exactly the same as Zandleven's;  it ought to be close enough to work.

# This checker has a NEW FEATURE.  When you declare a construction,
# you may notice additional declarations.  If the construction can be
# implemented by a curried function, it will be declared.  If the type
# of the construction can be implemented by a curried function, it will
# be declared.  The new types end with @ and new object functions with !:
# these identifiers cannot be used for any other purpose.

# The system uses variables with names as opposed to a fancy nameless
# scheme;  it has a strong device for generating fresh variables as required.

# I have installed a scheme which allows constructor declarations to be masked
# safely:  constructors have internal serial numbers, only displayed if necessary,
# and they can freely be redeclared (and referenced using explicit line numbers).
# If an identifier test is declared on line 10 and again on line 53, test thereafter
# means test.53, but test.10 will invoke the one on line 10, and any occurrences
# of test.10 will be displayed that way after test.53 is declared.  Also, context
# variables do not mask constructors if they are labelled with their line numbers.

# END MICRO-MANUAL

# toggle to display timestamp

timestamp=False

def Toggletime():
    global timestamp
    timestamp=not timestamp
    if timestamp:  print('showing timestamps')
    if not timestamp: print('Not showing timestamp')

# toggle to control changes made for type experiment

constructiontypes=True

# toggle to enable dangerous subtyping

# other type system variants should be supported, such as no subtyping
# and insane subtyping just for prop.

insanetypes=False

def ToggleConstructionTypes():
    global constructiontypes
    constructiontypes=not constructiontypes
    if constructiontypes:  print('Construction types are on')
    if not constructiontypes:  print('Construction types are off')

def ToggleInsaneTypes():
    global insanetypes
    insanetypes= not insanetypes
    if insanetypes:  print ("Dangerous type inclusion is on")
    if not insanetypes:  print ("Dangerous type inclusion is off")

# send an error message to the screen and to the log file

def errormessage(s):
    global target
    print('\nMANIAC: '+s)
    target.write('% MANIAC: '+s+'\n')

# the line number (lines declaring or defining constructions
# are numbered).

linenumber=0

def Linenumber():
    global linenumber
    linenumber = linenumber+1
    return linenumber

# identifiers defined

# Our original intention was to have some control over the
# shape of identifiers, but the Grundlagen is quite liberal in
# their forms, and this is followed here.

# forms ending in ! or $ are generated by the automatic declaration feature --
# these are Automath functions implementing a construction if the type system
# permits it.

# identifiers including # are automatically produced by the fresh variable
# generator.

def isupper(l):  return l <= 'Z' and l >= 'A'

def islower(l):  return l <= 'z' and l >= 'a'

def isdigit(l):  return (l <= '9' and l>='0')

def isnumeral(s):
    
    return (len(s)>0) and isdigit(s[0]) and ((len(s)==1) or isnumeral(s[1:]) or (len(s)==2 and (s[1]=='$' or s[1]=='!')))

def islowerident(s):  return isnumeral(s) or ((len(s)>0) and islower(s[0]) and ((len(s)==1) or islowerident(s[1:]) or (len(s)==2 and (s[1]=='$' or s[1]=='!'))))

def isident(s):
    
    #return islowerident(s) or ((len(s)>0) and isupper(s[0]) and ((len(s)==1) or isident(s[1:]) or (len(s)==2 and (s[1]=='$' or s[1]=='!'))))
    return (len(s)>0 and (isdigit(s[0]) or isupper(s[0]) or islower(s[0]) or s[0]=='#') and ((len(s)==1) or (len(s)==2 and (s[1]=='$' or s[1]=='!')) or isident(s[1:])))

def tonosign(s):
    S=''
    i=0
    while(i<len(s) and not(s[i]=='#')):
          S=S+s[i]
          i=i+1
    return S
            

# the LocalConstructors list is an aspect of my own paragraph system;  but it may be doing work
# to protect declarations in the current paragraph from being masked.  The LocalConstructors2 list
# might theoretically lead to a fight with the Grundlagen and need to be deleted or modified.

def isDeclared(s):
    global Context
    global LocalConstructors
    global LocalConstructors2
    return s=='prop' or s=='type' or s in Context  or s in LocalConstructors or s in LocalConstructors2

# tests validity of an identifier.

def Isident(s):  return Getident(s)==s

def Isident0(s):  return Getident0(s,1)==s

# lists representing Automath terms (or failed attempts at terms).

# second component can be a Useful Error Flag

# in some places, I should want not(isAutomathTerm) instead
# of isAutomathError

def isAutomathError(L): return len(L)==2 and L[0]==0

# it is annoying that the numeral label for metasorts is the same as
# for abstractions but in fact there is no reason to change it, length being
# different.

# this is used just for prop and type:  it might get further use if
# more layers of sorts are added.  No intention of adding more tiers!



def isAutomathMetaSort(L):  return (len(L)==2 and L[0]==4 and (L[1]=='prop' or L[1]=='type'))

# variables, bound or free.

def isAutomathVar(L): return (len(L)==2 and L[0]==1 and Isident(L[1]))

# construction terms.  The argument list can be empty:  an atomic term can be
# an instance of a construction.
    
def isAutomathConstruct(L):
    # print(L)
    return (len(L)==4 and L[0]==2 and Isident(L[1]) and isAutomathTermList(L[2]))

# function application term.  Note that the argument appears before the function, as in the notation.

def isAutomathApp(L): return (len(L)==3 and L[0]==3 and isAutomathTerm(L[1]) and isAutomathTerm(L[2]))

# abstracts (functions, lambda terms).

def isAutomathAbstract(L):  return (len(L)==4 and L[0]==4 and Isident(L[1]) and isAutomathTerm(L[2]) and isAutomathTerm(L[3]))

# Automath terms

def isAutomathTerm(L): return (isAutomathVar(L) or isAutomathConstruct(L) or isAutomathApp(L) or isAutomathAbstract(L) or isAutomathMetaSort(L))

# lists of Automath terms

def isAutomathTermList(L):  return (len(L)==0 or (isAutomathTerm(L[0]) and isAutomathTermList(L[1:])))

# this function harvests all identifiers from a term;
# bound variable renaming avoids all of them.

def VarList(L):
    if isAutomathError(L):  return []
    if isAutomathVar(L):  return [L[1]]
    if isAutomathConstruct(L):  return [L[1]] + ListVarList(L[2])
    if isAutomathApp(L):
        A=VarList(L[1])
        return A + VarList(L[2])
    if isAutomathAbstract(L):
        A=VarList(L[2])
        return [L[1]]+A+VarList(L[3])
    if isAutomathMetaSort(L):  return []
    return []

def ListVarList(L):
    if len(L) == 0:  return []
    return VarList(L[0])+ListVarList(L[1:])

# this function is used on those limited occasions when we
# want to harvest just *free* variables.

def BlockVarList(L,B):
    if isAutomathVar(L):
        if L[1] in B: return []
        return [L[1]]
    if isAutomathConstruct(L):
        return BlockListVarList(L[2],B)
    if isAutomathApp(L):  return BlockVarList(L[1],B) + BlockVarList(L[2],B)
    if isAutomathAbstract(L):
        return BlockVarList(L[2],B)+BlockVarList(L[3],[L[1]]+B)
    return []

def BlockListVarList(L,B):
    if len(L) == 0:  return []
    return BlockVarList(L[0],B)+BlockListVarList(L[1:],B)

# the current context

Context=[]

# a list to which names of constructors will be posted.
# I have changed parse and display functions to recognize
# constructor names and handle them differently.

# construction declarations are now checked.  Number of arguments is checked, too.

Constructors=[]

# constructors in current paragraph which cannot be rewritten (check that this constraint is still in force)

LocalConstructors=[]

# constructors in most recently closed paragraph, which cannot be overwritten
# caution -- this may lead to trouble with the Grundlagen.

LocalConstructors2 =[]

# paragraphs

Paragraphs=[[["top"],[],[]]]

theparagraph=[["top"],[],[],[],[]]

Types={} #dictionary used for caching of types

Equations={} # cache of equations

Simps={} # cache of simplifications

# I am clearing cache when paragraph commands are called,
# just as a way of keeping the caches from growing indefinitely

# the basic paragraph management commands.

# is there enough paragraph manipulation that it would make sense
# to turn these into a dictionary?  and would it work correctly?

def OpenNewParagraph(s):
    global Context
    global Contexts
    global LocalConstructors
    global LocalConstructors2
    global Paragraphs
    global theparagraph
    global Types
    global Equations
    global Simps
    global TypedContext
    Types={}
    Equations={}
    Simps={}
    Paragraphs=[theparagraph[0:2]+[LocalConstructors]+[Context]+[TypedContext]]+Paragraphs
    theparagraph=[[s]+theparagraph[0],theparagraph[0],LocalConstructors,Contexts]
    LocalConstructors2=[]
    #errormessage('Now in paragraph '+theparagraph[0][0])

JustClosed=""

def CloseParagraph():
    global Context
    global Contexts
    global LocalConstructors
    global LocalConstructors2
    global Paragraphs
    global theparagraph
    global Types
    global Equations
    global Simps
    global TypedContext
    global JustClosed
    JustClosed=parastring(theparagraph[0])
    Types={}
    Equations={}
    Simps={}
    Paragraphs=[theparagraph[0:2]+[LocalConstructors]+[[]]+[Context]+[TypedContext]]+Paragraphs
    theparagraph=FindParagraph(theparagraph[1])
    LocalConstructors2=LocalConstructors
    LocalConstructors=theparagraph[2]
    #Contexts=theparagraph[3]
    Context=theparagraph[3]
    TypedContext=theparagraph[4]
    #errormessage('Now in paragraph '+theparagraph[0][0])

def ReopenParagraph(s):
    global Context
    global Contexts
    global theparagraph
    global LocalConstructors
    global Paragraphs
    global Types
    global Equations
    global Simps
    global TypedContext
    Types={}
    Equations={}
    Simps={}
    Paragraphs=[theparagraph[0:2]+[LocalConstructors]+[Context]+[TypedContext]]+Paragraphs
    theparagraph=FindParagraph([s]+theparagraph[0])
    LocalConstructors2=[]

    #errormessage('Now in paragraph '+theparagraph[0][0])

def FindParagraph(L):
    global Paragraphs
    PL=Paragraphs
    i=0
    while i<len(Paragraphs):
       if(PL[i][0]==L):
           return PL[i]
       i=i+1
    errormessage('Paragraph not found:  went to top')
    return [["top"],[],[],[],[]]

# the dictionary of indices for each identifier which convert it to a fresh variable.
# these indices should be huge, but never normally seen.

varindices={}

# generate a fresh variable from a bound variable.

def FreshIdent(v):
    V=Getident0(v,1)
    if not(V in varindices.keys()):  varindices[V]=0
    varindices[V]=varindices[V]+1
    return V+'##'+str(varindices[V])

# the basic display function.  It is worth noting that instances of constructions which
# are masked will be subscripted with their line numbers for unambiguous reference in the display.
# error terms are displayed with their error message.  Otherwise it is all quite standard.

# added very basic infix display

def unless(b,s):
    if b: return ""
    return s
                
def AutomathDisplay(L):
    global Context
    if isAutomathVar(L):  return L[1]
    
    if isAutomathConstruct(L) and L[2]==[] and not(L[1] in Context) and Getconstruction((L[1]),L[3])[3]==Getconstruction(L[1],-1)[3]:
        
        return L[1]
    if isAutomathConstruct(L) and L[2]==[]:  
        
        return L[1]+'.'+str(L[3])      
    if isAutomathApp(L):  return '<'+AutomathDisplay(L[1])+'>'+AutomathDisplay(L[2])
    if isAutomathConstruct(L) and not(L[1] in Context) and Getconstruction((L[1]),L[3])[3]==Getconstruction(L[1],-1)[3]:
              if len(L[2])==1 and L[1][0]=="'" and not(isAutomathConstruct(L[2][0]) and L[2][0][1][0]=="'" and len(L[2][0][2])>1): return L[1]+AutomathDisplay(L[2][0])
              if len(L[2])==2 and L[1][0]=="'":
                  secondpart=AutomathDisplay(L[2][1])
                  #if secondpart[0]=='(':  secondpart = '('+secondpart+')'
                  return unless(isAutomathVar(L[2][0]),"(")+AutomathDisplay(L[2][0])+unless(isAutomathVar(L[2][0]),")")+L[1]+secondpart
              if len(L[2])>2 and L[1][0]=="'":  return unless(isAutomathVar(L[2][0]),"(")+AutomathDisplay(L[2][0])+unless(isAutomathVar(L[2][0]),")")+L[1]+"("+AutomathListDisplay(L[2][1:])
                            
              return L[1]+'('+AutomathListDisplay(L[2])
    if isAutomathConstruct(L):
              # do not allow display of prefix or infix operators with line numbers, since the parser cannot handle this, and the
              # parser actually has to parse displays in certain situations.
              #if len(L[2])==1 and L[1][0]=="'" and not(isAutomathConstruct(L[2][0]) and L[2][0][1][0]=="'" and len(L[2][0][2])>1): return L[1]+AutomathDisplay(L[2][0])
              """if len(L[2])==2 and L[1][0]=="'":
                  secondpart=AutomathDisplay(L[2][1])
                  #if secondpart[0]=='(':  secondpart = '('+secondpart+')'

                  return unless(isAutomathVar(L[2][0]),"(")+AutomathDisplay(L[2][0])+unless(isAutomathVar(L[2][0]),")")+L[1]+str(L[3])+secondpart
              if len(L[2])>2 and L[1][0]=="'":  return unless(isAutomathVar(L[2][0]),"(")+AutomathDisplay(L[2][0])+unless(isAutomathVar(L[2][0]),")")+L[1]+str(L[3])+"("+AutomathListDisplay(L[2][1:])"""
              return L[1]+'.'+str(L[3])+'('+AutomathListDisplay(L[2])
    if isAutomathAbstract(L): return '['+L[1]+':'+AutomathDisplay(L[2])+']'+AutomathDisplay(L[3])
    if isAutomathMetaSort(L):  return L[1]
    if isAutomathError(L):  return 'ERROR {'+L[1]+'}'
    return 'PaNiC'

def AutomathListDisplay(L):
    if len(L) == 1:
        return AutomathDisplay(L[0])+')'

    return AutomathDisplay(L[0])+','+AutomathListDisplay(L[1:])

# device for toggling between long and short display (enabling
# or disabling the hiding of initial arguments which coincide with
# those in the context in which a function was declared).

longdisplay=False

def ToggleDisplay():
    global longdisplay
    longdisplay=not longdisplay
    if longdisplay: print('\nLong display is on\n')
    if  not longdisplay: print('\nShort display is on\n')

# Here is the short display function.  It calls the default
# display function if longdisplay is True.

# added infix display without argument omission

def AutomathShortDisplay(L):
    if longdisplay:  return AutomathDisplay(L)
    global Context
    if isAutomathVar(L):  return L[1]
    
    if isAutomathConstruct(L) and L[2]==[] and not(L[1] in Context) and Getconstruction((L[1]),L[3])[3]==Getconstruction(L[1],-1)[3]:
        
        return L[1]
    if isAutomathConstruct(L) and L[2]==[]:  
        
        return L[1]+'.'+str(L[3])      
    if isAutomathApp(L):  return '<'+AutomathShortDisplay(L[1])+'>'+AutomathShortDisplay(L[2])
    if isAutomathConstruct(L) and not(L[1] in Context) and Getconstruction((L[1]),L[3])[3]==Getconstruction(L[1],-1)[3]:

              LL=AutomathShortList(L[2],addones(Context),True)
              if len(LL)==1 and L[1][0]=="'" and not(isAutomathConstruct(LL[0]) and LL[0][1][0]=="'" and len(LL[0][2])>1): return L[1]+AutomathShortDisplay(LL[0])
              if len(LL)==2 and L[1][0]=="'":
                  secondpart=AutomathShortDisplay(LL[1])
                  #if secondpart[0]=='(':secondpart='('+secondpart+')'
                  return unless(isAutomathVar(LL[0]),"(")+AutomathShortDisplay(LL[0])+unless(isAutomathVar(LL[0]),")")+L[1]+secondpart
              if len(LL)>2 and L[1][0]=="'":  return unless(isAutomathVar(LL[0]),"(")+AutomathShortDisplay(LL[0])+unless(isAutomathVar(LL[0]),")")+L[1]+"("+AutomathShortListDisplay(LL[1:],addones(Context[1:]),False)
              
              if LL==[]: return L[1]
              return L[1]+'('+AutomathShortListDisplay(L[2],addones(Context),True)
    if isAutomathConstruct(L):

              """LL=AutomathShortList(L[2],addones(Context),True)
              if len(LL)==1 and L[1][0]=="'" and not(isAutomathConstruct(LL[0]) and LL[0][1][0]=="'" and len(LL[0][2])>1): return L[1]+AutomathShortDisplay(LL[0])
              if len(LL)==2 and L[1][0]=="'":
                  secondpart=AutomathShortDisplay(LL[1])
                  #if secondpart[0]=='(':secondpart='('+secondpart+')'
                  return unless(isAutomathVar(LL[0]),"(")+AutomathShortDisplay(LL[0])+unless(isAutomathVar(LL[0]),")")+L[1]+str(L[3])+secondpart
              if len(LL)>2 and L[1][0]=="'":  return unless(isAutomathVar(LL[0]),"(")+AutomathShortDisplay(LL[0])+unless(isAutomathVar(LL[0]),")")+L[1]+str(L[3])+'('+AutomathShortListDisplay(LL[1:],addones(Context[1:]),False)
              
              if LL==[]: return L[1]"""
              return L[1]+'.'+str(L[3])+'('+AutomathShortListDisplay(L[2],addones(Context),True)
    if isAutomathAbstract(L): return '['+L[1]+':'+AutomathShortDisplay(L[2])+']'+AutomathShortDisplay(L[3])
    if isAutomathMetaSort(L):  return L[1]
    if isAutomathError(L):  return 'ERROR {'+L[1]+'}'
    return 'PaNiC'

def AutomathShortListDisplay(L,C,b):
    if len(L)==0:  return ''

    if (b==True and not(C==[])) and L[0]==C[0]: return AutomathShortListDisplay(L[1:],C[1:],True)
    if len(L) == 1:
        return AutomathShortDisplay(L[0])+')'
    if C==[]:Cshorter=[]
    if not C== []: Cshorter=C[1:]
    return AutomathShortDisplay(L[0])+','+AutomathShortListDisplay(L[1:],Cshorter,False)

def AutomathShortList(L,C,b):
    if len(L)==0:  return []

    if (b==True and not(C==[])) and L[0]==C[0]: return AutomathShortList(L[1:],C[1:],True)
    if len(L) == 1:
        return [L[0]]
    if C==[]:Cshorter=[]
    if not C== []: Cshorter=C[1:]
    return [L[0]]+AutomathShortList(L[1:],Cshorter,False)

# this pulls out the first identifier from a string.
# added ability to read infixes (single-quoted as in Automath
# historical sources).

def Getident0(s,n):
    if s[0:1]=="'":
        i=1
        while(len(s)>i and not(s[i]=="'")):
            i=i+1
        if s[i]=="'":  return s[0:i+1]
        return 'ERROR'
    if s[0:1]=='~' and isident(s[1:]): return Getident0(s[1:],n)
    if isident(s):  return s
    if not isident(s[0:n]):  return 'ERROR'
    if not isident(s[0:n+1]):  return s[0:n]
    return Getident0(s,n+1)
    
# this pulls out an identifier possibly followed by a paragraph label 

def Getident(s):
    A=Getident0(s,1)
    if A=='ERROR':  return 'ERROR'
    R=s[len(A):]
    if not R[0:1]=='"':  return A
    RR = R[1:]
    while not RR == '' and not RR[0:1]=='"':
        RR=RR[1:]
    if RR == '': return 'ERROR'
    return A+R[0:len(R)-len(RR)+1]

def Restident(s):
    A=Getident0(s,1)
    if A=='ERROR':  return s
    R=s[len(A):]
    if not R[0:1]=='"':  return R
    RR = R[1:]
    while not RR == '' and not RR[0:1]=='"':
        RR=RR[1:]
    if RR == '': return 'ERROR'
    return s[len(A)+len(R)-len(RR)+1:]

# The Automath parser.  This checks construction declarations and numbers of arguments.
# Construction declarations are needed in particular to see when an atomic identifier
# is actually a construction.
# It allows context variables to be read as such even if they conflict with constructor
# declarations.  It allows binders to share names with constructors (because this actually
# happens, horribly, in the Grundlagen).

# there is now infix parsing

def GettermPair(s):
    global Context
    global Constructors
    global Constructions
    if len(s)==0:
        errormessage(' empty term? in Getterm')
        return [[0,"empty term"],s]
    
    #these single quoted identifiers are not infixes/prefixes.  
    if s[0:6]=="'prop'":  return [[4,'prop'],s[6:]]
    if s[0:6]=="'type'":  return [[4,'type'],s[6:]]
    if s[0:6]=='TYPE': return [[4,'type'],s[4:]]

    S=Getident(s)
    R=Restident(s)
    N=-1
    if not(S=='ERROR') and not(R=='') and R[0]=='.' and not(R[1:]=='') and not(Getident(R[1:])=='ERROR') and isnumeral(R[1]):
            N=int(Getident(R[1:]))
            R=Restident(R[1:])
                                                                        
    if not(S=='ERROR') and (R=='' or R[0]==')' or R[0]=='>' or R[0]==']' or R[0]==',' or R[0]==':' or R[0]==' ' or R[0]=='\n'):
        if S=='prop' or S=='type':  return [[4,S],R]
        if (not(Getconstruction2(S,N)=='ERROR')) and not (S in Context and N==-1): return [FixArgumentsTerm([2,S,[],Getconstruction(S,N)[3]]),R]
        return[[1,S],R]

    if not(S=='ERROR') and not(S[0]=="'") and R[0]=="'" and N==-1:
        return GettermPair('('+S+')'+R)   
    if not(S=='ERROR') and not(S[0]=="'") and R[0]=="'":
        return GettermPair('('+S+'.'+str(N)+')'+R)

    S2 = Getident(R)
    R2 = Restident(R)


    """if not(S2=='ERROR') and not(S2[0]=="'") and N==-1:
        if R2[0:1]=="'": return GettermPair('('+S+'('+S2+'))'+R2)
        if (R2=='' or R2[0]==')' or R2[0]=='>' or R2[0]==']' or R2[0]==',' or R2[0]==':' or R2[0]==' ' or R2[0]=='\n'):return GettermPair(S+'('+S2+')'+R2)
    if not(S2=='ERROR') and not(S2[0]=="'"):
        if R2[0:1]=="'": return GettermPair('('+S+'.'+str(N)+'('+S2+'))'+R2)
        if (R2=='' or R2[0]==')' or R2[0]=='>' or R2[0]==']' or R2[0]==',' or R2[0]==':' or R2[0]==' ' or R2[0]=='\n'):return GettermPair(S+'.'+str(N)+'('+S2+')'+R2)
    """
    
    if not(S=='ERROR') and not(R[0:1]=='('):
        T=GettermPair(R)
        if not(isAutomathError(T[0])):
            if T[1][0:1]=="'": return GettermPair('('+S+'('+AutomathDisplay(T[0])+'))'+T[1])
            return [FixArgumentsTerm([2,S,[T[0]],Getconstruction(S,N)[3]]),T[1]]

    if not(S=='ERROR') and R[0:1]=='(':
        PP=GettermlistPair(R[1:])
        LL = PP[0]

        if LL=='ERROR':
            errormessage(' bad argument list (in Getterm) '+R[1:])
            return [[0,'bad argument list'],s]
        if (Getconstruction2(S,N)=='ERROR') or (N==-1 and S in Context) or len(Getconstruction(S,N)[0])<len(LL) or isAutomathError(FixArguments(S,LL,N)):
            errormessage(' declaration or number of arguments problem with constructor (in Getterm) '+S)
            return [[0,'constructor declaration error'],s]
        if PP[1][0:1]=="'" and N==-1: return GettermPair('('+S+'('+AutomathListDisplay(PP[0])+')'+PP[1])
        if PP[1][0:1]=="'": return GettermPair('('+S+'.'+str(N)+'('+AutomathListDisplay(PP[0])+')'+PP[1])
        return [FixArgumentsTerm([2,S,LL,Getconstruction(S,N)[3]]),PP[1]]
    if s[0]=='<':
        P=GettermPair(s[1:])
        T1=P[0]
        if isAutomathError(T1):
            errormessage(' bad application argument (in Getterm)'+s[1:])
            return [[0,'bad application argument'],s]
        R1 = P[1]
        if R1 == '' or not(R1[0]=='>'):
            errormessage(' failure to match application brackets (in Getterm)'+s)
            return [[0,'application brackets dont match'],s]
        P2=GettermPair(R1[1:])
        T2=P2[0]
        if isAutomathError(T2):
            errormessage(' bad function applied (in Getterm)'+R1[1:])
            return [[0,'bad function part in application'],s]
        return [[3,T1,T2],P2[1]]
    if s[0]=='[':
        T1=Getident(s[1:])
        if T1=='ERROR':
            errormessage(' bad bound variable (in Getterm) '+s[1:])
            return [[0,'bad bound variable'],s]
        # That I had to disable this is a sign of *bad* use of notation in the Grundlagen!
        
        #if isDeclared(T1) or (not(Getconstruction2(T1,-1)=='ERROR')) or T1[-1]=='$' or T1[-1]=='!' or '"' in T1 or '.' in T1:
            #errormessage(" can't bind already declared or reserved experimental identifier (in Getterm) "+T1)
            #return [0,'declared or reserved identifier used as binder']
        R1=Restident(s[1:])
        if R1=='' or not(R1[0]==':' or R1[0]==','):
            errormessage(' missing colon or comma in abstraction (in Getterm) '+R1)
            return [[0,'missing colon in abstraction'],s]
        P2=GettermPair(R1[1:])
        T2=P2[0]
        if isAutomathError(T2):
            errormessage(' badly formed type (in Getterm) '+R1[1:])
            return [[0,'badly formed type in abstraction'],s]
        R2=P2[1]
        if R2=='' or not (R2[0]==']'):  return [[0,'missing closing bracket in abstraction'],s]
        Context=Context+[T1]
        P3=GettermPair(R2[1:])
        Context=Context[0:-1]
        T3=P3[0]
        if isAutomathError(T3):
            errormessage(' badly formed function body (in Getterm) '+R2[1:])
            return [[0,'badly formed body in abstraction'],s]
        return [[4,T1,T2,T3],P3[1]]
    
    if s[0]=='(':
        A1=GettermlistPair(s[1:])
        if A1[0]=='ERROR': return [[0,'bad infix term'],s]
        a1=A1[0]
        R1=A1[1]
        A2=Getident(R1)
        if A2=='ERROR':  return [[0,'bad infix term (2)'],s]
        if Getconstruction2(A2,-1)=='ERROR': return [[0,'bad infix term (2a)'],s]
        R2=Restident(R1)
        """if not(R2[0:1]=='('):
            A3=GettermPair(R2)
            if isAutomathError(A3[0]):return [[0,'bad infix term (2b)'],s]
            return [FixArgumentsTerm([2,A2,a1+[A3[0]],Getconstruction(A2,-1)[3]]),A3[1]]
            """
        A3=GettermPair(R2)
        if not isAutomathError(A3[0]): return [FixArgumentsTerm([2,A2,a1+[A3[0]],Getconstruction(A2,-1)[3]]),A3[1]]
        A3=GettermlistPair(R2[1:])
        if A3[0]=='ERROR': return [[0,'bad infix term'],s]
        a3=A3[0]
        R3=A3[1]
        return [FixArgumentsTerm([2,A2,a1+a3,Getconstruction(A2,-1)[3]]),R3]
    errormessage(' general syntax failure (in Getterm) '+s)   
    return [[0,'general syntax failure'],s]

def Getterm(s):  return GettermPair(s)[0]

def Restterm(s):  return GettermPair(s)[1]




def GettermlistPair(s):
    P1=GettermPair(s)
    T1 = P1[0]
    if isAutomathError(T1):  return ['ERROR',s]
    R1 = P1[1]
    if R1=='':  return ['ERROR',s]
    if R1[0]==')':  return [[T1],R1[1:]]
    if R1[0]==',':
        P1 = GettermlistPair(R1[1:])
        L1=P1[0]
        if L1=='ERROR':  return ['ERROR',s]
        return [[T1]+L1,P1[1]]
    return ['ERROR',s]

def Gettermlist(s):  return GettermlistPair(s)[0]

def Resttermlist(s):  return GettermlistPair(s)[1]



def SimpleTest(s):
    return(AutomathDisplay(Getterm(s)))

def VarListTest(L):
    return (VarList(Getterm(L)))

# Substitution of T into [x:A]U will force x to be renamed
# to a fresh variable (not found anywhere) if the variables
# in T include x.

def Subs(s,T,U):

    if not isAutomathTerm(T) or not isAutomathTerm(U):
        errormessage(' substitution of ill-formed terms (in Subs)')
        return [0,'substitution GIGO']
    L=VarList(T)+VarList(U)
    if isAutomathVar(U):
        if U==[1,s]: return T
        return U
    if isAutomathConstruct(U):
#        U=FixArgumentsTerm(U);
        return [2,U[1],ListSubs(s,T,U[2]),U[3]]
    if isAutomathApp(U):
        return [3,Subs(s,T,U[1]),Subs(s,T,U[2])]
    if isAutomathAbstract(U):
        if not(U[1] in VarList (T)) and not(U[1] in Context):
            return [4,U[1],Subs(s,T,U[2]),Subs(s,T,U[3])]
        Q=FreshIdent(tonosign(U[1]))
        return [4,Q,Subs(s,T,U[2]),
                Subs(s,T,Subs(U[1],[1,Q],U[3]))]
    if isAutomathMetaSort(U):  return U
    return [0,'substituted into what?']

def ListSubs(s,T,L):
    if len(L)==0:  return []
    return [Subs(s,T,L[0])]+ListSubs(s,T,L[1:])

# version of substitution used by bound variable renaming functions

def Subs2(s,T,U):

    if not isAutomathTerm(T) or not isAutomathTerm(U):
        errormessage(' substitution of ill-formed terms (in Subs2)')
        return [0,'substitution GIGO']
    L=VarList(T)+VarList(U)
    if isAutomathVar(U):
        if U==[1,s]: return T
        return U
    if isAutomathConstruct(U):
#        U=FixArgumentsTerm(U);
        return [2,U[1],ListSubs2(s,T,U[2]),U[3]]
    if isAutomathApp(U):
        return [3,Subs2(s,T,U[1]),Subs2(s,T,U[2])]
    if isAutomathAbstract(U):
        if not(U[1] in VarList (T)) and not(U[1] in Context):
            return [4,U[1],Subs2(s,T,U[2]),Subs2(s,T,U[3])]
        Q=FreshIdent2(tonosign(U[1]))
        return [4,Q,Subs2(s,T,U[2]),
                Subs2(s,T,Subs2(U[1],[1,Q],U[3]))]
    if isAutomathMetaSort(U):  return U
    return [0,'substituted into what?']

def ListSubs2(s,T,L):
    if len(L)==0:  return []
    return [Subs2(s,T,L[0])]+ListSubs2(s,T,L[1:])

def SubsTest(s,T,U):
    return AutomathDisplay(Subs(s,Getterm(T),Getterm(U)))

# This function evaluates functions applied to arguments.  This is extended
# to constructions (represented as "fake" lambda terms with types which may be
# impossible in the Automath type system, as input types may be metasorts).
# Typing conditions for application are checked at runtime:  this is how
# instances of constructions are type checked.

# actual typing of an applied function is avoided as far as possible
# since these may actually not type, as in the implementation of construction
# evaluation = definition expansion.

def betastep(L):
    global TypedContext

    if not isAutomathTerm(L):
        #errormessage(' Attempted beta reduction of non-term')
        return [0,'beta reduction of non-term']
    if not isAutomathApp(L): return L

    # if it is formally an abstraction we apply it without checking its type,
    # but we do check that type of input matches.

    if isAutomathAbstract(L[2]):
        LL=L
        if L[2][1] in Context: LL=[3,L[1],renameall(L[2])]
        TL=Typeof(LL[1])
        if not(isAutomathTerm(TL)):  return [0,"argument doesn't type (in betastep)"]
        if not EqualTerms(LL[2][2],TL):
            #errormessage(' Types '+AutomathDisplay(L[2][2])+' and '+AutomathDisplay(Typeof(L[1]))+" don't match (in betastep)")
            return [0,'failure to match in betastep']
        return Subs(LL[2][1],LL[1],(LL[2][3]))

    W=L[2]
    W=Simplify(W)
    
    if not(isAutomathAbstract(W)):
        
        TL=Typeof(L[1])
        if not(isAutomathTerm(TL)):  return [0,"argument doesn't type (in betastep)"]
        DD = FunDomain(L[2])
        if not(isAutomathTerm(DD)): return [0,'bad domain in betastep']
        if not EqualTerms(DD,TL):
            #errormessage(' Types '+AutomathDisplay(FunDomain(L[2]))+' and '+AutomathDisplay(TL)+" don't match (in betastep)")
            return [0,'type match failure']
        return L

        
    return betastep([3,L[1],W])
    


def betasteptest(s):
    return AutomathDisplay(betastep(Getterm(s)))

Contexts = {}  # the global list of contexts

ParagraphContexts = [] # contexts with paragraph references

TypedContext = [] # the current context with types.  This will be needed.

# installed the paragraph fix for contexts as well as constructions.  Jutting
# uses paragraph references in context parts, and interpretation of context names
# can depend on paragraph.

# lines commented out enabled harvesting context from the current context,
# which I think is no longer required (though possibly it may be desirable).

def Getcontext(s):
    global Contexts
    global ParagraphContexts
    global original

    if original==True:
        S=Getident0(s,1)
        R=s[len(S)+1:-1]
        
        original=False
        N=len(theparagraph[0])
        G=Getcontext(S+'"'+(parastring(theparagraph[0]))+R+'"')
        if not G=='ERROR':
              original=True
              return G
        i=0
        stringfix='.'
        if R=='':  stringfix=''
        while(i<N):
          #print(s+'"'+(parastring(theparagraph[0][i:N]))+'"')
          G=Getcontext(S+'"'+(parastring(theparagraph[0][i:N]))+stringfix+R+'"')
          if not G=='ERROR':
              original=True
              return G
          i=i+1
        if paragraphtweak:
            G=Getcontext(S+'"'+(JustClosed)+'"')
            if not G=='ERROR':
                original = True
                return G
  
    
        errormessage('Context not found in any paragraph (in Getcontext): '+s)
        original=True
        return 'ERROR' 


    if s in Contexts.keys():return Contexts[s]

    
    if original==True:
        errormessage('Not found in context list (in Getcontext) '+str(s))
    return 'ERROR'




# not used, but could be for an absolutely precise implementation, perhaps.
# I have so far avoided any parsing of paragraph strings.

def droponedot(s):
    
    if len(s)==0:  return s
    S=s
    while(len(S)>0 and not(S[0]=='.')):
        S=S[1:]
    if len(S)==0:return s
    return S

# get a construction from the list of construction declarations.
# notice that a construction which is actually used (but not via an
# explicit line reference) will be pulled to the front of the construction list.
    
# the paragraph fix gives something now much closer to Zandleven's treatment of paragraph identifiers.
# now setting my tweak to the paragraph system to work by default.  It does work in the Grundlagen
# if construction names are treated as masked when used as bound variables.

original=True
paragraphtweak=True

def ToggleParagraphTweak():
    global paragraphtweak
    paragraphtweak=not paragraphtweak
    if paragraphtweak:  print('Paragraph tweak is on')
    if not paragraphtweak:  print ('Paragraph tweak is off')

def Getconstruction(s,n):
    global Constructions
    global Constructors
    global theparagraph
    global original
    global JustClosed
    
    s0=Getident0(s,1)
    if not(n==-1) and not(s==s0):  return Getconstruction(s0,n)
    
    if Isident0(s) and n==-1:
        original=False
        N=len(theparagraph[0])
        i=0
        while(i<N):
          #print(s+'"'+(parastring(theparagraph[0][i:N]))+'"')
          G=Getconstruction(s+'"'+(parastring(theparagraph[0][i:N]))+'"',n)
          if not G=='ERROR':
              original = True
              return G
          i=i+1
        if paragraphtweak:
            G=Getconstruction(s+'"'+(JustClosed)+'"',n)
            if not G=='ERROR':
                original = True
                return G
    if Isident0(s) and n==-1:
        original=True
        return 'ERROR'
    if not(Isident0(s)) and n==-1 and original==True:
        original=False
        S=Getident0(s,1)
        R=s[len(S)+1:-1]
        # if R has initial period it is intended to be appended to the full
        # current paragraph
        G=Getconstruction(S+'"'+(parastring(theparagraph[0]))+R+'"',n)
        if not G=='ERROR':
              original = True
              return G
        N=len(theparagraph[0])
        i=0
        while(i<N):
            #errormessage('looking for '+S+'"'+(parastring(theparagraph[0][i:N]))+'.'+R+'"')
            G=Getconstruction(S+'"'+(parastring(theparagraph[0][i:N]))+'.'+R+'"',n)
            if not G=='ERROR':
               original = True
               return G
            i=i+1
        original=True
        return 'ERROR'

    if n==-1:
       
       if s in Constructions.keys():  return Constructions[s]
    if s+'.'+str(n) in Constructions.keys():  return Constructions[s+'.'+str(n)]
    if original==True and not(s=='prop' or s=='type'):
        errormessage(' Not found in constructions (in Getconstruction) '+s)   
    return 'ERROR'

# This function sends no error messages.  Don't forget to update it
# if the previous one is updated!

def Getconstruction2(s,n):
    global Constructions
    global Constructors
    global theparagraph
    global original

    s0=Getident0(s,1)
    if not(n==-1) and not(s==s0): return Getconstruction2(s0,n)
    
    if Isident0(s) and n==-1:
        original=False
        N=len(theparagraph[0])
        i=0
        while(i<N):
          #print(s+'"'+(parastring(theparagraph[0][i:N]))+'"')
          G=Getconstruction2(s+'"'+(parastring(theparagraph[0][i:N]))+'"',n)
          if not G=='ERROR':
              original = True
              return G
          i=i+1
        if paragraphtweak:
            G=Getconstruction(s+'"'+(JustClosed)+'"',n)
            if not G=='ERROR':
              original = True
              return G
    if Isident0(s) and n==-1:
        original=True
        return 'ERROR'
    if not(Isident0(s)) and n==-1 and original==True:
        original=False
        S=Getident0(s,1)
        R=s[len(S)+1:-1]
        # if R has initial period it is intended to be appended to the full
        # current paragraph
        G=Getconstruction(S+'"'+(parastring(theparagraph[0]))+R+'"',n)
        if not G=='ERROR':
              original = True
              return G
        N=len(theparagraph[0])
        i=0
        while(i<N):
            #errormessage('looking for '+S+'"'+(parastring(theparagraph[0][i:N]))+'.'+R+'"')
            G=Getconstruction(S+'"'+(parastring(theparagraph[0][i:N]))+'.'+R+'"',n)
            if not G=='ERROR':
              original = True
              return G
            i=i+1
        original=True
        return 'ERROR'



    if n==-1:
       
       if s in Constructions.keys():  return Constructions[s]
    if s+'.'+str(n) in Constructions.keys():  return Constructions[s+'.'+str(n)]
#    if original==True and not(s=='prop' or s=='type'):
#        errormessage(' Not found in constructions (in Getconstruction) '+s)   
    return 'ERROR'


def GetConstruction(s):  Getconstruction(s,-1)

# this function displays the entire list of constructions
# with a particular name.

def GetConstructions(s):

    global Constructions
    
    for i in Constructions.keys():
       if Getident0(i,1)==s:
           print(i+':')
           print(ShowConstruction(s,Constructions[i][3])+'\n')
       
    return 'DONE'

# are we type checking?

checking=True

# declare a variable and the associated context.  This handles
# variable declaration lines.

def DeclareContext(s,t,TT):
    global Context
    global Contexts
    global Constructors
    global TypedContext
    global target
    global ParagraphContexts
    global samecontext
    global OldContext
    global OldTypedContext
    
# 00 represents the null context, so it can't be a variable name.
# construction names cannot be variable names.

# the samecontext condition handles situations where the previous context
# is allowed to persist.

# but the Grundlagen abuses notation hideously.  Removing the construction restriction.
    
    if s=='00' or s[-1]=='!' or s[-1]=='$' or '"' in s or '.' in s or '#' in s:
        errormessage('Context name is an already declared or special identifier')
        return 'ERROR 1'
    if t=='00':L=[[],[]]
    if samecontext:
        L=[Context,TypedContext]

 
    if not t=='00' and not samecontext: L=Getcontext(t)
    samecontext=False
    if L=='ERROR': return 'ERROR 2'

# the name to be declared should be new in context

    if s in L[0]:
        errormessage(' Identifier '+s+' to be declared already used in context '+t+' (in DeclareContext)')
        return 'ERROR 3'

# save the context for error recovery (moved to Readline)
    
    #OldContext=Context
    #OldTypedContext=TypedContext
    Context=L[0]
    TypedContext=L[1]
    #TT=FixAllArguments(TT)


# recover if the proposed type is bad
    
    if checking and isAutomathError(TT):# or not RR=='':
        Context=OldContext
        TypedContext=OldTypedContext
        errormessage(' Type is ill-formed (in DeclareContext)')
        return 'ERROR 4'

# recover if the proposed type depends on
# free variables not in the context.
    
    if not BlockVarList(TT,L[0])==[]:
        #errormessage(str(Context))
        #errormessage(str(BlockVarList(TT,L[0])))
        Context=OldContext
        TypedContext=OldTypedContext
        errormessage(' Type contains inappropriate free variables (in DeclareContext)')
        return 'ERROR 5'

# recover if the proposed type doesnt type

    if checking and not(istypetype(Typeof (TT))) and not(istypetype(TT)):
        Context=OldContext
        TypedContext=OldTypedContext
        errormessage(' Type is ill-typed (in DeclareContext)')
        return 'ERROR 6'
    
# update the context list
    
    #Contexts=[[s,[Context+[s],L[1]+[[s,TT]]]]]+Contexts
        
    # declare with additional names known to the paragraph
    # system
    PARA=theparagraph[0]
    S=parastring(PARA)
    #if paragraphfix:  ParagraphContexts=[[s+'"'+S+'"',[Context+[s],L[1]+[[s,TT]]]]]+ParagraphContexts
    Contexts[s+'"'+S+'"']=[Context+[s],L[1]+[[s,TT]]]

          
    Context = Context+[s]
    TypedContext = TypedContext+[[s,TT]]
    #print('% '+ShowContext()+'\n')
    target.write('\n% '+ ShowContext()+'\n')
    return ShowContext()

#Constructions = []
Constructions={}

def parastring(L):
    if len(L)==0:
        errormessage('null string error in parastring')
        return 'bogus'
    if len(L)==1: return L[0]
    return (parastring(L[1:]))+'.'+L[0]

# this handles declarations of both primitive and defined constructions.

silent=False

showcomputedtype=False

def ToggleShowType():
    global showcomputedtype
    showcomputedtype=not showcomputedtype
    if showcomputedtype: print('Display of computed types is on')
    if not showcomputedtype: print('Display of computed types is off')

experimental=False

def ToggleExperimental():
    global experimental
    experimental=not experimental
    if experimental:  print('experimental declarations are on')
    if not experimental:  print('experimental declarations are off')

declarationwarnings=False

def ToggleWarnings():
    global declarationwarnings
    declarationwarnings=not declarationwarnings
    if declarationwarnings: print('warnings about redeclarations will be printed')
    if not declarationwarnings:  print('warnings about redeclarations will not be printed')
    
def DeclareConstruction(s,t,BB,TT):
    
    global Context
    global Contexts
    global Constructors
    global LocalConstructors
    global Constructions
    global TypedContext
    global silent
    global target
    global linenumber
    global theparagraph
    global samecontext
    global OldContext
    global OldTypedContext

    

# 00 represents the null context, so it can't be a variable name.
# construction names cannot be variable names.

# the samecontext flag handles conditions where the previous context
# persists.

    
    if s=='00' or s in Context or '"' in s or '#' in s or '.' in s:
        errormessage('Identifier to be declared is an already declared or special identifier')
        Context=OldContext
        TypedContext=OldTypedContext
        return 'ERROR 1'
    if s in LocalConstructors:
        if declarationwarnings:  errormessage('Construction in same paragraph redefined')
    if s in LocalConstructors2:
        if declarationwarnings: errormessage('Construction in just-closed paragraph redefined')
    if t=='00':L=[[],[]]
    if samecontext:
        L=[Context,TypedContext]
        
    if not t=='00' and not samecontext: L=Getcontext(t)
    samecontext=False
    if L=='ERROR':
        Context=OldContext
        TypedContext=OldTypedContext
        return 'ERROR 2'

# the name to be declared should be new in context

    if s in L[0]:
       Context=OldContext
       TypedContext=OldTypedContext
       errormessage(' Identifier '+s+' appears in context '+t+' (in DeclareConstruction)')
       return 'ERROR 3'

# save the context for error recovery (moved to Readline)
    
    #OldContext=Context
    #OldTypedContext=TypedContext
    Context=L[0]
    TypedContext=L[1]
    TT1=TT
    #TT1=FixAllArguments(TT)

    #if not BB =='PN':  BB1 = FixAllArguments(BB)#BB=FixAllArguments(Getterm (BODY))

    BB1=BB

# recover if the proposed type is bad
    
    if checking and ((isAutomathError(TT1) or (not BB1=='PN' and (isAutomathError(BB1))))):
        Context=OldContext
        TypedContext=OldTypedContext
        errormessage(' Parse errors in body or type (in DeclareConstruction)')
        return 'ERROR 4'

# recover if the proposed type depends on
# free variables not in the context.
    
    if not BlockVarList(TT1,L[0])==[] or (not BB1=='PN' and not BlockVarList(BB1,L[0])==[]):
        #errormessage(str(BlockVarList(TT1,L[0])))
        #errormessage(str(Context))

        Context=OldContext
        TypedContext=OldTypedContext
        errormessage(' Inappropriate free variables in body or type (in DeclareConstruction)')
        return 'ERROR 5'

# recover if the proposed type doesnt type

    if checking and not(istypetype(Typeof (TT1))) and not(istypetype(TT1)):
        Context=OldContext
        TypedContext=OldTypedContext
        errormessage(" The type doesn't type (in DeclareConstruction)")
        return 'ERROR 6'

# recover if the type of the body is not the proposed type
    BB2 = Typeof(BB1)
    if checking and (not(BB1=='PN') and not(EqualTerms(TT1,BB2))):
        Context=OldContext
        TypedContext=OldTypedContext
        errormessage(" The type "+AutomathDisplay(BB2)+" is bad or doesn't match "+AutomathDisplay(TT1)+ "(in DeclareConstruction)")
        return 'ERROR 7'

    if showcomputedtype and not(BB1=='PN'):
        errormessage(" The type "+AutomathDisplay(BB2)+" was shown to match "+AutomathDisplay(TT1)+ "(in DeclareConstruction)")
    

    if not(s=='_'):
      N=Linenumber()
      """Constructions=[[s,[L[1],BB1,TT1,N]]]+Constructions"""
      Constructors=[s]+Constructors
      
      # declare with additional names known to the paragraph
      # system
      PARA=theparagraph[0]
      S=parastring(PARA)
      
       
      Constructions[s+'"'+S+'"']=[L[1],BB1,TT1,N]
      Constructions[s+'.'+str(N)]=[L[1],BB1,TT1,N]
      Constructors=[s+'"'+S+'"']+Constructors


      
      LocalConstructors=[s]+LocalConstructors
      if timestamp: target.write('\n%'+time.ctime()+'\n')
      if timestamp: print('\n%'+time.ctime()+'\n')
      #print('\n%'+ShowConstructionP(s,N)+'\n')
      if silent: print('\n%'+ShowConstructionP(s,N)+'\n')
      target.write('\n%'+ShowConstructionP(s,N)+'\n')


    if s=='_':
        
        target.write ('\n% 0. '+s+'('+printtypelist(L[1])+' = '+(AutomathShortDisplay(BB1))+' : '+(AutomathShortDisplay(TT1))+'\n')
        print ('\n% 0. '+s+'('+printtypelist(L[1])+' = '+(AutomathShortDisplay(BB1))+' : '+(AutomathShortDisplay(TT1))+'\n') 
    
    # this is an experimental feature.  Any declaration of a construction which can be implemented
    # as an object or sort function actually declares a term representing a suitable function.  This may make a style
    # possible in which the user never (or seldom) writes an abstraction, as in basic Lestrade.

    # these declarations happen if they are run in a book.

    if experimental:
       silenton=False

       if silent==False:
        silent=True
        silenton=True

       #print(AutomathDisplay(TT1))
       #print(AutomathDisplay(BB1))
       if checking and (not s=='_' and silenton and not(BB1=='PN') and not(len(Context)==0) and  (istypetype(Abstbuild(L[1],TT1)) or istypetype(Typeof(Abstbuild(L[1],TT1))))):
        #SS=FreshIdent(s,[s]+VarList(BB1)+VarList(TT1))
        OldContext=Context
        OldTypedContext=TypedContext
        TTT=Abstbuild(L[1],TT1)
        BBB=Abstbuild(L[1],BB1)
        TTTT=Typeof(TTT)
        if not istypetype(TTT) and not isAutomathError(TTTT):  DeclareConstruction(s+'$','00',renameall2(TTT),renameall2(TTTT))

        if not istypetype(TTT) and not isAutomathError(TTTT): DeclareConstruction(s+'!','00',renameall2(BBB),Getterm(s+'$'))
        if istypetype(TTT) and not isAutomathError(Typeof(BBB)): DeclareConstruction(s+'$','00',renameall2(BBB),renameall2(TTT))
        Context=OldContext
        TypedContext=OldTypedContext
       if silenton==True:
        silent=False
    
    
    if not(s=='_'):return ShowConstructionP(s,N)
    if s=='_': return ('0. '+s+'('+printtypelist(L[1])+' = '+(AutomathShortDisplay(BB1))+' : '+(AutomathShortDisplay(TT1)))

# at this point, every line can be executed!  All that remains is type checking.

#  definitional expansion

# add missing arguments to a construction term

def addones(L):
    if L == []: return []
    return [[1,L[0]]]+addones(L[1:])

def typelisttoargs(L):
    if L==[]:  return []
    return [[1,L[0][0]]]+typelisttoargs(L[1:])

def printtypelist(L):
    if len(L)==0: return ''
    if len(L)==1:  return L[0][0]+":"+AutomathShortDisplay(L[0][1])+")"
    return L[0][0]+":"+AutomathShortDisplay(L[0][1])+","+printtypelist(L[1:])

def FixArguments(s,L,n):

     global TypedContext
     global Context
     global Constructions
     if Getconstruction(s,n)=='ERROR':
         errormessage('  weird error in FixArguments')
     LL = Getconstruction(s,n)[0]

     
     
     LL2 = LL[0:len(LL)-len(L)]
     
     if True:#LL2 == TypedContext[0:len(LL)-len(L)]:
         
         return [2,s,addones(Context[0:len(LL)-len(L)])+L,n]

     print(LL2)

     print('doesnt match')
     print(TypedContext[0:len(LL)-len(L)])
     errormessage(" Cannot extend short argument list to construction (in FixArguments) "+s)
     return [0,"fix argument failure 0"]

def FixArgumentsTest(s):
    S=Getterm(s)
    if isAutomathError(S):  return [0,'fix argument failure 1']
    if not isAutomathConstruct(S):  return [0,'fix argument failure 2']
    return AutomathDisplay(FixArguments(S[1],S[2],S[3]))

def FixArgumentsTerm(L):
    if not isAutomathConstruct(L): return [0,'fix arguments term failure']
    return FixArguments(L[1],L[2],L[3])




# display contexts and constructions (feedback from commands now provided)

def ShowConstructionP(s,n):
    S=Getconstruction(s,n)
    if S[1]=='PN':
        if Getconstruction(s,n)[0] == []:
#            print(s+' = '+'PN'+' : '+(AutomathDisplay(S[2])))
            return (str(S[3])+'. '+s+' = '+'PN'+' : '+(AutomathShortDisplay(S[2])))
#        print(s+'('+printtypelist(Getconstruction(s)[0])+' = '+'PN'+' : '+(AutomathDisplay(S[2])))
        return (str(S[3])+'. '+s+'('+printtypelist(Getconstruction(s,n)[0])+' = '+'PN'+' : '+(AutomathShortDisplay(S[2])))
    if Getconstruction(s,n)[0] == []:
#        print(s+' = '+(AutomathDisplay(S[1]))+' : '+(AutomathDisplay(S[2])))
        return (str(S[3])+'. '+s+' = '+(AutomathShortDisplay(S[1]))+' : '+(AutomathShortDisplay(S[2])))
    return(str(S[3])+'. '+s+'('+printtypelist(Getconstruction(s,n)[0])+' = '+(AutomathShortDisplay(S[1]))+' : '+(AutomathShortDisplay(S[2])))
    
def ShowConstruction(s,n):
    S=Getconstruction(s,n)
    if S[1]=='PN':
        if Getconstruction(s,n)[0] == []:
#            print(s+' = '+'PN'+' : '+(AutomathDisplay(S[2])))
            return (str(S[3])+'. '+s+' = '+'PN'+' : '+(AutomathShortDisplay(S[2])))
#        print(s+'('+printtypelist(Getconstruction(s)[0])+' = '+'PN'+' : '+(AutomathDisplay(S[2])))
        return (str(S[3])+'. '+s+'('+printtypelist(Getconstruction(s,n)[0])+' = '+'PN'+' : '+(AutomathShortDisplay(S[2])))
    if Getconstruction(s,n)[0] == []:
#        print(s+' = '+(AutomathDisplay(S[1]))+' : '+(AutomathDisplay(S[2])))
        return (str(S[3])+'. '+s+' = '+(AutomathShortDisplay(S[1]))+' : '+(AutomathShortDisplay(S[2])))
    return(str(S[3])+'. '+s+'('+printtypelist(Getconstruction(s,n)[0])+' = '+(AutomathShortDisplay(S[1]))+' : '+(AutomathShortDisplay(S[2])))
def Showconstruction(s):  return ShowConstruction(s,-1)

def ShowContext():
    if Context==[]:
        print('00')
        return 0
    return ('('+printtypelist(TypedContext))

# expand defined construction term

def fixtypelist(L):
    if L==[]:return []
    return [[[1,L[0][0]],L[0][1]]]+fixtypelist(L[1:])

# turn the argument list of a construction into arguments
# applied to a (possibly illegal) function representing
# the construction.

def Argbuild(L,T):
    if len(L)==0:  return (T)
    if not isAutomathTerm(T): return [0,'argbuild 1']
    if not isAutomathTerm(L[-1]):  return [0,'argbuild 2']
    TT=Argbuild(L[0:-1],T)
    if isAutomathError(TT): return [0,'argbuild 3']
    return [3,L[-1],TT]

# use declaration of a construction to build a likely illegal function
# representing it.

def Abstbuild(L,T):
    if len(L)==0: return renameall(T)
    if not isAutomathTerm(T):  return [0,'abstbuild 1']
    if not Isident(L[0][0]):  return [0,'abstbuild 2']
    if not isAutomathTerm(L[0][1]):  return [0,'abstbuild 3']
    TT=Abstbuild(L[1:],T)
    if isAutomathError(TT): return [0,'abstbuild 4']
    if L[0][0] in Context:  return renameall([4,L[0][0],L[0][1],TT])
    return [4,L[0][0],L[0][1],TT]

def defexpand(s,L,n):
    
    S=Getconstruction(s,n)
    if S[1]=='PN':  return [0,'defexpand primitive?']
    if L==[]: return renameall(S[1])
    TT=Abstbuild(S[0],S[1])
    if isAutomathError(TT): return [0,'abstbuild prev step failure']
    D=Argbuild(L,TT)
    return betastep(D)

def Defexpand(L):
    if isAutomathApp(L):
        dd = Defexpand(L[2])
        if not isAutomathError(dd):  return betastep([3,L[1],dd])
    if not(isAutomathConstruct(L)): return [0,'wrong input to Defexpand']
    L2=L
    if isAutomathError(L2):  return [0,'ill formed term in Defexpand']
    return defexpand(L2[1],L2[2],L[3])

def DefexpandTest(s):
    return AutomathDisplay(Defexpand(Getterm(s)))

# equality of terms (used for type checking, but usable for other purposes)

def definable(L):
    if isAutomathError(L):  return False
    if not isAutomathConstruct(L):  return False
    S=Getconstruction(L[1],L[3])
    if S =='ERROR':
        errormessage('Tried to check term with bad constructor for definability (in definable)')
        return False
    if S[1]=='PN':  return False
    return True

# eta reduction.  The type checking is excessive, I suppose/

def etared(L):
    if not(isAutomathAbstract(L)):  return L
    if isAutomathApp(L[3]) and L[3][1] == [1,L[1]] and not L[1] in VarList(L[3][2]) and EqualTerms(L[2],FunDomain(L[3][2])) and EqualTerms(FunDomain(L[3][2],L[2])):  return etared(L[3][2])
    return L

# force all bound variables to fresh forms.  Its main use is above in Defexpand and
# its subsidiary functions.

def renameall(L):
    if not(isAutomathTerm(L)):  return [0,'renameall of error']
    if isAutomathConstruct(L):  return [2,L[1],renamealllist(L[2]),L[3]]
    if isAutomathApp(L):  return [3,renameall(L[1]),renameall(L[2])]
    if isAutomathAbstract(L):
        L1=FreshIdent(tonosign(L[1]))
        L2=renameall(L[2])
        L3=renameall(L[3])

        return [4,L1,L2,Subs(L[1],[1,L1],L3)]
        
    return L

def renamealllist(L):
    if L==[]:  return L
    return [renameall(L[0])]+renamealllist(L[1:])

varindices2={}

def FreshIdent2(v):
    V=Getident0(v,1)
    if not(V in varindices2.keys()):  varindices2[V]=0
    varindices2[V]=varindices2[V]+1
    return V+'#'+str(varindices2[V])

def renameallx0(L):
    if not(isAutomathTerm(L)):  return [0,'renameall of error']
    if isAutomathConstruct(L):  return [2,Getident0(L[1],1),renamealllistx(L[2]),L[3]]
    if isAutomathApp(L):  return [3,renameallx0(L[1]),renameallx0(L[2])]
    if isAutomathAbstract(L):
        L1=FreshIdent2('x')
        L2=renameallx0(L[2])
        L3=renameallx0(L[3])

        return [4,L1,L2,Subs2(L[1],[1,L1],L3)]
        
    return L

def renamealllistx(L):
    if L==[]:  return L
    return [renameallx0(L[0])]+renamealllistx(L[1:])

def renameallx(L):
    global varindices2
    varindices2={}
    return renameallx0(L);

def renameall20(L):
    if not(isAutomathTerm(L)):  return [0,'renameall of error']
    if isAutomathConstruct(L):  return [2,L[1],renamealllist2(L[2]),L[3]]
    if isAutomathApp(L):  return [3,renameall20(L[1]),renameall20(L[2])]
    if isAutomathAbstract(L):
        L1=FreshIdent2(tonosign(L[1]))
        L2=renameall20(L[2])
        L3=renameall20(L[3])

        return [4,L1,L2,Subs2(L[1],[1,L1],L3)]
        
    return L

def renamealllist2(L):
    if L==[]:  return L
    return [renameall20(L[0])]+renamealllist2(L[1:])

def renameall2(L):
    global varindices2
    varindices2={}
    return renameall20(L);


#name of this parameter is backward
#reversed the default value of this parameter;
# it seems to be better to compare function and
# argument before reducing.
betafirst = True

def ToggleBeta():
    global betafirst
    betafirst=not betafirst
    if not betafirst: print('Beta reduction will be carried out before comparison')
    if betafirst: print('Beta reduction will not be carried out before comparision')

# optional feature of using renameallx on keys in
# equation caching.  Could be added to type and simplification
# caching.  This is a feature I do not expect to use as it
# does not seem to help.

def ToggleAlphakeys():
    global alphakeys
    alphakeys=not alphakeys
    if alphakeys:  print('Alphakeys in caching are on')
    if not alphakeys:  print('Alphakeys in caching are off')

alphakeys=False

def alphakey(L):
    if alphakeys:  return renameallx(L)
    if not alphakeys:  return L

# post to the equation cache

def Posttoeqs(L,T):
    global Context
    global TypedContext
    global caching

    if not caching:  return T
    i=0
    while(i<=len(TypedContext)):
        if str([TypedContext[0:i],L]) in Equations.keys():
            
            return T
        i=i+1
    LL=[alphakey(L[0]),alphakey(L[1])]
    Equations[str([TypedContext,LL])]=T
    
    return T

equationcachehits=0

# equality of terms.  Actually, this is "first argument is a supertype of the second argument".

def EqualTerms(L,M):
    global Context
    global TypedContext
    global Equations
    global equationcachehits
    LL=renameallx(L)
    MM=renameallx(M)
    if not(isAutomathTerm(LL)): return False
    if not(isAutomathTerm(MM)):  return False

    if LL==MM:  return True

    # getting values from the cache
    if caching:
        i=0
        while(i<=len(TypedContext)):
           if str([TypedContext[0:i],[alphakey(L),alphakey(M)]]) in Equations.keys():
               equationcachehits=equationcachehits+1
               return Equations[str([TypedContext[0:i],[alphakey(L),alphakey(M)]])]
           i=i+1
           
    if showmatches:  errormessage('Comparing '+(AutomathDisplay(L))+' and '+(AutomathDisplay(M)))

    # it is important here that the forms that metasorts can take are tightly controlled.
    # the final condition, which holds anyway, is nontrivial and needed to restrict the scope
    # of subtyping, if construction types are enabled.

    # if insanetypes is on, truly demented subtyping is enabled...
    
    if istypetype(M) and istypetype(L) and (not(isAutomathAbstract(L)) and isAutomathAbstract(M)) and (insanetypes or istypetype(Typeof(M[2]))):
        V=FreshIdent(M[1])
        Context=Context+[V]
        TypedContext=TypedContext+[[V,M[2]]]
        Q=EqualTerms(L,Subs(M[1],[1,V],M[3]))
        Context=Context[0:-1]
        TypedContext=TypedContext[0:-1]
        return Q

    # note that subtyping of abstraction types requires exact equality of domains and subtyping of ranges.
    # this point becomes nontrivial when metasorts are allowed as domains.
        
    if (isAutomathAbstract(L) and isAutomathAbstract(M)) and EqualTerms(L[2],M[2]) and ((not istypetype(L[2])) or EqualTerms(M[2],L[2])):
        V=FreshIdent('xx')
        Context=Context+[V]
        TypedContext=TypedContext+[[V,L[2]]]
        Q=EqualTerms(Subs(L[1],[1,V],L[3]),Subs(M[1],[1,V],M[3]))
        
        Context=Context[0:-1]
        TypedContext=TypedContext[0:-1]
        return Posttoeqs([L,M],Q)



    if (isAutomathConstruct(L) and isAutomathConstruct(M)) and L[3]==M[3] and EqualTermLists(L[2],M[2]):  return Posttoeqs([L,M],True)
    if betafirst:  # this is now the default behavior
        if isAutomathApp(L) and isAutomathApp(M)  and EqualTerms(L[1],M[1]) and EqualTerms(L[2],M[2]):  return Posttoeqs([L,M],True) 

    LLL=Simplify(L)
    MMM=Simplify(M)
    if not(isAutomathTerm(LLL)):  LLL=L
    if not(isAutomathTerm(MMM)):  MMM=M
    if not (LLL==L and MMM==M) and EqualTerms(LLL,MMM): return Posttoeqs([L,M],True)

    if not betafirst:
        if isAutomathApp(L) and isAutomathApp(M)  and EqualTerms(L[1],M[1]) and EqualTerms(L[2],M[2]):  return Posttoeqs([L,M],True )

    # different approach to eta reduction

    if isAutomathAbstract(L) and not(isAutomathAbstract(M)) and (EqualTerms(L[2],FunDomain(M)) and EqualTerms(FunDomain(M),L[2])):
          V=FreshIdent('xx')
          if EqualTerms(L,[4,V,L[2],[3,V,M]]): return True
        
    if isAutomathAbstract(M) and not(isAutomathAbstract(L)) and (EqualTerms(FunDomain(L),M[2]) and EqualTerms(M[2],FunDomain(L))):
          V=FreshIdent('xx')
          if EqualTerms([4,V,M[2],[3,V,L]],M): return True   
        
showmatches=False

def ToggleShowMatches():
    global showmatches
    showmatches= not showmatches


def EqualTermsTest(s,t):
    return EqualTerms(Getterm(s),Getterm(t))

def EqualTermLists(L,M):
    if L==[]:  return M==[]
    return EqualTerms(L[0],M[0]) and EqualTermLists(L[1:],M[1:])

# type computation

def Getcontexttype(s):
    L=TypedContext
    if len(L)==0:  return [0,'bad context type 1']
    if len(L[-1])==0:  return [0,'bad context type 2']
    while not(L[-1][0]==s):
        L=L[0:-1]
        if len(L)==0: return [0,'bad context type 3']
    if len(L)==0:  return [0,'bad context type 4']
    return L[-1][1]

# compute domain of a function

def FunDomain(L):
    
    L=Simplify(L)
    if isAutomathError(L): return [0,'domain of error is error']
    if isAutomathAbstract(L): return L[2]
    if isAutomathMetaSort(L): return [0,'metasorts do not have domains']

    return FunDomain(Typeof(L))
    
# preliminary check that a term is a possible Sort for a sort
# there is a problem here:  cannot fully check that
# it is a metasort, because checking that internal
# types are a metasort here leads to circularity.

# failure to check types of metasorts was already
# a problem in the previous version.  Now I know how
# to fix it...

def istypetype(L):
    global TypedContext
    global Context
    if isAutomathError(L):  return False
    if isAutomathMetaSort(L):  return True
    if not isAutomathAbstract(L):  return False
    if not (constructiontypes and istypetype(L[2])) and not istypetype(Typeof(L[2])):  return False
    V=FreshIdent(L[1])
    Context=Context+[V]
    TypedContext=TypedContext+[[V,L[2]]]
    Q=istypetype(Subs(L[1],[1,V],L[3]))
    Context=Context[0:-1]
    TypedContext=TypedContext[0:-1]
    return Q

def istypetypeTest(s):
    return istypetype(Getterm(s))

# aggressive head reduction using both beta reduction
# and definition expansion

def Simplify(L):

    global Context
    global TypedContext
    global cachehits

    if isAutomathVar(L):  return L

    # getting values from the cache
    if caching:
        i=0
        while(i<=len(TypedContext)):
           if str([TypedContext[0:i],L]) in Simps.keys():
               cachehits=cachehits+1
               return Simps[str([TypedContext[0:i],L])]
           i=i+1


    # eta reduction
    
    if isAutomathAbstract(L) and isAutomathApp(L[3]) and L[3][1]==[1,L[1]] and not(L[1] in VarList(L[3][2])):  L=Simplify(L[3][2])

    
    if isAutomathAbstract(L):
        if L[1] in Context: L=renameall(L)
        Context=Context+[L[1]]
        TypedContext=TypedContext+[[L[1],L[2]]]
        V=Simplify(L[3])
        Context=Context[0:-1]
        TypedContext=TypedContext[0:-1]
        if isAutomathAbstract(V) and isAutomathApp(V[3]) and V[3][1]==[1,V[1]] and not(V[1] in VarList(V[3][2])):  V=Simplify(V[3][2])
        return Posttosimps(L,[4,L[1],L[2],V])
    
    
    LL=L

    docontinue = True

    while(docontinue):
        docontinue=False
        U = Defexpand(LL)
        if (not(U==LL)) and isAutomathTerm(U):
            docontinue=True
            LL=U
        V=betastep(LL)
        if (not(V==LL)) and isAutomathTerm(V):
            docontinue=True
            LL=V
            
    
    """U = betastep (LL)
    V = Defexpand (LL)
    while(not((U==LL or not(isAutomathTerm(U))) and (V==LL or not(isAutomathTerm(V))))):
        if not(U==LL) and (isAutomathTerm(U)):  LL=U
        if not(V==LL) and (isAutomathTerm(V)):  LL=V
        U=betastep(LL)
        V=Defexpand(LL)"""
    
    return Posttosimps(L,LL)

# turn caching on and off (for all three functions
# that support it).

# caching is now on by default

caching = True

def ToggleCaching():
    global caching
    caching=not caching
    if caching: print('Caching in Typeof and EqualTerms is on')
    if not caching:  print('Caching in Typeof and EqualTerms is off')
    
# posting values to the type cache:
# replace each return X in Typeof with return Posttotypes(L,X)

def Posttotypes(L,T):
    global Context
    global TypedContext
    global caching

    if not caching:  return T
    i=0
    while(i<=len(TypedContext)):
        if str([TypedContext[0:i],L]) in Types.keys():
            
            return (T)
        i=i+1
    Types[str([TypedContext,L])]=(T)
    
    return (T)

# post to the simplification cache.

def Posttosimps(L,T):
    global Context
    global TypedContext
    global caching

    if not caching:  return T
    i=0
    while(i<=len(TypedContext)):
        if str([TypedContext[0:i],L]) in Simps.keys():
            
            return (T)
        i=i+1
    Simps[str([TypedContext,L])]=(T)
    
    return (T)

cachehits=0

# compute the type of a term

def Typeof(L):
    global silent
    global TypedContext
    global Context
    global Types
    global cachehits


    
    if not(isAutomathTerm(L)):  return Posttotypes(L,[0,'what is the type of an error term?'])
    if isAutomathVar(L):  return Posttotypes(L,Getcontexttype(L[1]))

    # getting values from the cache
    if caching:
        i=0
        while(i<=len(TypedContext)):
           if str([TypedContext[0:i],L]) in Types.keys():
               cachehits=cachehits+1
               return Types[str([TypedContext[0:i],L])]
           i=i+1
    
    if isAutomathApp(L):
        T1=Typeof(L[1])
        T2=Simplify(Typeof(L[2]))
        if isAutomathError(T1):
            #errormessage('bad argument type in Typeof')
            return Posttotypes(L,[0,'bad argument type in Typeof'])
        #if not(Isfunction(L[2])):
            #if not silent: errormessage(' type '+AutomathDisplay(Typeof(L[2]))+' of applied term '+AutomathDisplay(L[2])+' is not a function type (in Typeof)')
            #return [0,'not a function type in Typeof']
        if isAutomathAbstract(T2) and T2[1] in Context:  T2=renameall(T2)
        if isAutomathAbstract(T2) and EqualTerms(T2[2],T1):
            return Posttotypes(L,Simplify([3,L[1],T2]))
        T3=Simplify(Typeof(T2))
        if isAutomathAbstract(T3) and T3[1] in Context:  T3 = renameall(T3)
        if isAutomathAbstract(T3) and EqualTerms(T3[2],T1):
            return Posttotypes(L,Simplify([3,L[1],T2]))
        #if not silent: errormessage(' Types '+AutomathDisplay(FunDomain(T2))+' and '+AutomathDisplay(T1)+" don't match in application "+AutomathDisplay(L)+" (in Typeof)")
        return Posttotypes(L,[0,'type match failure in Typeof'])
    if isAutomathAbstract(L):
        if not constructiontypes and not(istypetype(Typeof(L[2]))):
            #if not silent:  errormessage(" Type of type "+(AutomathDisplay(Typeof(L[2])))+" is inappropriate in "+AutomathDisplay(L)+" (in Typeof)")
            return Posttotypes(L, [0,'inappropriate type in Typeof'])
        # construction types allows metasorts as domains.
        if constructiontypes and not istypetype(L[2]) and not istypetype(Typeof(L[2])):
             return Posttotypes(L, [0,'inappropriate type in Typeof'])
        if L[1] in Context:  L=renameall(L)
        Context=Context+[L[1]]
        TypedContext=TypedContext+[[L[1],L[2]]]

        V= [4,L[1],L[2],Typeof(L[3])]

        TypedContext=TypedContext[0:-1]
        Context=Context[0:-1]
        if isAutomathError(V):
            #errormessage('Badly typed abstraction body in Typeof')
            return Posttotypes(L, [0,'badly typed abstraction body in Typeof'])
        return Posttotypes(L,V)
    if isAutomathConstruct(L):
        
        S=Getconstruction(L[1],L[3])
        #TT=FixArgumentsTerm(L)
        #if isAutomathError(TT):  return [0,'fix argument failure in Typeof']
        if L[2]==[]: return Posttotypes(L,S[2])

        return Posttotypes(L,betastep(Argbuild(L[2],renameall(Abstbuild(S[0],S[2])))))
    if isAutomathMetaSort(L):
        return Posttotypes(L, [0,'metametasort'])
    return Posttotypes(L,[0,'Typeof bad exit'])

# type checking internal to the betastep function is supposed
# to ensure that all types match.

def TypeofTest(s):
    return AutomathDisplay(Typeof(Getterm(s)))

# input and output

# Read an Automath line.  I am making this very simple for now,
# but I want to support more than one or even all of the styles
# described by Wiedijk.  For the moment a line is simply
# four terms separated by whitespace.  Context is first, as
# in traditional Automath, at this point.  Identifier first
# also would work.

# It is a subtle point that the arguments have to be read under
# the context determined by the first argument, then one has to
# return to the previous context before running the command:
# this could be fixed if the internal commands took Automath terms rather
# than text to be parsed as arguments, but I see no reason to fiddle
# with it now.

def Despace(s):
    t=s
    while not(t=='') and t[0]== ' ':
        t=t[1:]
    return t

samecontext=False

def ReadLine(ss):

    global Context
    global Contexts
    global TypedContext
    global samecontext
    global OldContext
    global OldTypedContext

    

    s = Despace(ss)
    samecontext=False

    if len(s)>=1 and s[0]=='-':
        if len(s)==0 or (not(s=='--') and not(Getident(s[1:])==theparagraph[0][0])):
                         errormessage('Weird paragraph closer '+s)
                        
        CloseParagraph()
        #PreviousContext='NoNe'
        return s

    if len(s)>=2 and s[0:2]=='+*':
        ReopenParagraph(Getident(s[2:]))
        return s

    if len(s)>=1 and s[0:1]=='+':
        OpenNewParagraph(Getident(s[1:]))
        return s

    if s[0:1]=='*' or s[0:1]=='@':
        context = '00'
        restcontext=Despace(s[1:])
        L=[[],[]]

    if s[0:1]=='[':
        #if PreviousContext=='NoNe':
            #errormessage('Missing previous context error')
        if Context==[]:context='00'
        if not(Context==[]):
            context=Context[-1]
            samecontext=True
        identifier = Getident(s[1:])
        restidentifier1 = Despace(Restident(s[1:]))
        if not(restidentifier1[0:1]==':' or restidentifier1[0:1]==','):
            errormessage('Ill-formed bracketed context line--missing colon or commna')
            return 'ERROR'
        value='EB'
        if restidentifier1[1:8]=="'prop']":
            thetype=[4,'prop']
            afteridentifier=restidentifier1[7:]
        
        if restidentifier1[1:8]=="'type']":
            thetype=[4,'type']
            afteridentifier=restidentifier1[7:]
        if not (restidentifier1[1:8]=="'prop']" or restidentifier1[1:8]=="'type']"):
           thetype=Getterm(restidentifier1[1:])
           afteridentifier=Restterm(restidentifier1[1:])
        if not(afteridentifier[0:1]==']'):
            errormessage('Unclosed bracket in bracketed context line'+afteridentifier)

            return 'ERROR'
        if Despace(afteridentifier[1:])[0:1]=='[':
            DeclareContext(identifier,context,thetype)
            return(ReadLine(afteridentifier[1:]))
        return(DeclareContext(identifier,context,thetype))
    
    if not (s[0:1]=='*' or s[0:1]=='@'):
        context = Getident(s)
    
        restcontext = Despace(Restident(s))

        if restcontext[0:1]=='*' or restcontext[0:1]=='@':  restcontext=Despace(restcontext[1:])

    if restcontext[0:2]==':=':
        #if PreviousContext=='NoNe':
            #errormessage('Missing previous context error')
            #return('ERROR')

        identifier = context
        if Context==[]: context='00'
        if not(Context==[]):
            samecontext=True
            context=Context[-1]
        L=[Context,TypedContext]
        Restidentifier=Despace(restcontext[2:])
        #errormessage(str(Context))

    if not(context=='00') and not(restcontext[0:2]==':=') and not samecontext: L = Getcontext(context)
    if (context=='00'): L = [[],[]]
    if samecontext: L=[Context,TypedContext]
    if L=='ERROR' or context=='ERROR':
        errormessage('No such context as '+context+' (in ReadLine)')
        return 'ERROR 1'

    #if restcontext[0:2]==':=':
        #L=[Context,TypedContext]

    OldContext=Context
    OldTypedContext=TypedContext
    Context=L[0]
    TypedContext=L[1]


    if restcontext[0:1]=='[':
        #if PreviousContext=='NoNe':
            #errormessage('Missing previous context error')
        #PreviousContext=Context
        identifier = Getident(restcontext[1:])
        restidentifier1 = Despace(Restident(restcontext[1:]))
        #if Context==[]: context='00'
        #if not(Context==[]):  context=Context[-1]
        if not(restidentifier1[0:1]==':' or restidentifier1[0:1]==','):
            errormessage('Ill-formed bracketed context line--missing colon or commna')
            Context=OldContext
            TypedContext=OldTypedContext
            return 'ERROR'
        value='EB'
        if restidentifier1[1:8]=="'prop']":
            thetype=[4,'prop']
            afteridentifier=restidentifier1[7:]
        
        if restidentifier1[1:8]=="'type']":
            thetype=[4,'type']
        
            afteridentifier=restidentifier1[7:]
        if not(restidentifier1[1:8]=="'prop']" or restidentifier1[1:8]=="'type']"):
           thetype=Getterm(restidentifier1[1:])
           afteridentifier=Restterm(restidentifier1[1:])
        if not(afteridentifier[0:1]==']'):
            errormessage('Unclosed bracket in bracketed context line')
            Context=OldContext
            TypedContext=OldTypedContext
            return 'ERROR'
        if Despace(afteridentifier[1:])[0:1]=='[':
            DeclareContext(identifier,context,thetype)
            return(ReadLine(Despace(afteridentifier[1:])))

        return(DeclareContext(identifier,context,thetype))


    if restcontext[0:1]=='_':
        identifier='_'
        Restidentifier = Despace(restcontext[1:])
    
    if not (restcontext[0:1]=='_') and not(restcontext[0:2]==':='):
        identifier=Getident(restcontext)
    
        Restidentifier = Despace(Restident(restcontext))

    if identifier=='ERROR':
       Context=OldContext
       TypedContext=OldTypedContext
       errormessage('Badly formed identifier in ReadLine '+restcontext)
       return('ERROR 3')

    if  identifier in Context:
        errormessage('Variable '+s+' is already in context '+context+' (in ReadLine)')
        Context=OldContext
        TypedContext=OldTypedContext
        return 'ERROR 2'
    if (identifier[-1]=='$' or identifier[-1]=='!'):
        Context=OldContext
        TypedContext=OldTypedContext
        errormessage('Identifier '+identifier+' ending in special characters cannot be declared directly by user (in DeclareConstruction)')
        return 'ERROR0'

    if not(restcontext==':=') and Restidentifier[0:2]==':=':
        Restidentifier=Despace(Restidentifier[2:])
    
    value = []
    
    if Restidentifier[0:3]=='EB ' or Restidentifier[0:3]=='eb 'or Restidentifier[0:3]=='---':
        value='EB'
        if Restidentifier[0:3]=='---':
            restvalue=Despace(Restidentifier[3:])
        if not(Restidentifier[0:3]=='--'):
            restvalue=Despace(Restidentifier[3:])
            
    if Restidentifier[0:3]=='PN ' or Restidentifier[0:3]=='pn ' or Restidentifier[0:5]=='PRIM ' or Restidentifier[0:6]=="'prim'" or Restidentifier[0:3]=='???':
        value='PN'
        if Restidentifier[0:3]=='PN ' or Restidentifier[0:3]=='pn ':
            restvalue=Despace(Restidentifier[3:])
        if Restidentifier[0:5]=='PRIM ':
            restvalue=Despace(Restidentifier[5:])
        if Restidentifier[0:6]=="'prim'":
            restvalue=Despace(Restidentifier[6:])
        if Restidentifier[0:3]=='???':
            restvalue=Despace(Restidentifier[3:])

    if value==[]:
       value=((Getterm(Restidentifier)))
       restvalue = Despace(Restterm(Restidentifier))

    if restvalue[0:1]==';' or restvalue[0:1]==':':
        restvalue=Despace(restvalue[1:])
    
    if restvalue[0:2]=='??':
        thetype=Typeof(value) # new feature attempted

    if restvalue[0:6]=="'prop'":
        thetype=[4,'prop']
    if restvalue[0:6]=="'type'":
        thetype=[4,'type']



        
    if not (restvalue[0:2]=='??' or restvalue[0:6]=="'prop'"or restvalue[0:6]=="'type'") : thetype=((Getterm(restvalue)))
    

    if isAutomathError(value) or isAutomathError(thetype):
        Context=OldContext
        TypedContext=OldTypedContext
        errormessage('Badly formed term or type in line (in ReadLine)')
        return "ERROR"

    if value == 'EB':
        return DeclareContext(identifier,context,thetype)

    #if restcontext[0:2]==':=':
       #errormessage(str(identifier))
       #errormessage(str(context))
       #errormessage(str(Context))
       
    
    return DeclareConstruction(identifier,context, value,thetype)

# Type four terms in a line and wait for a response.  No response indicates something wrong.

# This command is now logged to a default log file.  Comments can be entered.

def interface0():
  global target
  target=open('automathlog.aut1','w')
  line=''
  while not(line[0:4]=='quit'):
       line=input()
       if not(line=='') and not(line=='\n') and not(line[0]=='#') and not(line[0]=='%') and not(line[0:4]=='quit'):

           target.write('\n'+line+'\n')
           print('\n'+line+'\n')
           target.flush()
           R=ReadLine(line)


           
           #target.write("\n%"+R+"\n\n")
           #target.flush()

           print("\n%"+R+"\n")
       if not(line=='') and line[0]=='#':
           print('\n'+line)
           target.write('\n'+line+'\n')

  target.write('\nquit\n')
  target.close()

  # we always need a target file for error messages.
  target=open('default.aut4','w')
  return 'Bye!'

source=open('default.aut3','w')
source.write('Hi!')
source.close()
source=open('default.aut3','r')

target=open('default2.aut4','w')

backup2=open('default3.aut3','w')

backup1=open('default4.aut4','w')

# Here is a place holder for line parsing commands, which will take various possible line formats and
# convert them to the format that ReadLine accepts.  This might include changing to the case convention
# that this document supports, though that might be dangerous.

# clear the declaration environment.  The book reading commands need this.

def Clear():
    global Context
    global Contexts
    global Constructors
    global Constructions
    global TypedContext
    global linenumber
    Context=[]
    TypedContext=[]
    Contexts={}
    ParagraphContexts=[]
    Constructors=[]
    #Constructions=[]
    Constructions={}
    linenumber=0
    Types={}
    Equations={}
    Simps={}
    Paragraphs=[[["top"],[],[]]]
    theparagraph=[["top"],[],[],[],[]]
    varindices={}
    
    

# I made the spaces of source and target books disjoint:
# readbook reads from .aut files to .aut2 files, and
# readbook2 reads from .aut2 files to .aut files.

def readbook(src,tgt):
  global timestamp
  global source
  global target
  global backup1
  source=open(src+".aut1",'r')
  target=open(tgt+".aut2",'w')
  backup1=open(tgt+".aut4",'w')
  Clear()
  #timestamp=True
  line=''
  while not(line[0:4]=='quit'):
       line=source.readline()
       if not(line=='') and not(line=='\n') and not(line[0:1]=='#') and not(line[0:1]=='%') and not(line[0:4]=='quit'):

           target.write('\n'+line)
           target.flush()
           backup1.write('\n'+line)
           backup1.flush()
           print('\n'+line)
           
           R=ReadLine(line[0:-1])

           #target.write("\n%"+R+"\n\n")
           #target.flush()
           backup1.write("\n%"+R+"\n\n")
           backup1.flush()
           print("\n%"+R+"\n\n")
       if not(line=='') and line[0:2]=='##':
           target.write('\n'+line)
           backup1.write(line)
       if not(line=='') and line[0:1]=='#' and not line[0:2]=='##':
           target.write(line)
           backup1.write(line)
  target.write('quit\n')
  target.close()
  backup1.write('quit\n')
  backup1.close()
  # we always need a target file for error messages.
  target=open('default.aut4','w')
  source.close()
  #timestamp=False
  return '% Bye!'

def readbook2(src,tgt):
  global timestamp
  global source
  global target
  global backup2
  source=open(src+".aut2",'r')
  target=open(tgt+".aut1",'w')
  backup2=open(tgt+".aut3",'w')
  Clear()
  #timestamp=True
  line=''
  while not(line[0:4]=='quit'):
       line=source.readline()
       if not(line=='') and not(line=='\n') and not(line[0:1]=='#') and not(line[0:1]=='%') and not(line[0:4]=='quit'):
           target.write('\n'+line)
           target.flush()
           backup2.write('\n'+line)
           backup2.flush()
           
           R=ReadLine(line[0:-1])

           print('\n'+line)
           #target.write("\n%"+R+"\n\n")
           #target.flush()
           backup2.write("\n%"+R+"\n\n")
           backup2.flush()
           print("\n%"+R+"\n\n")
       if not(line=='') and line[0:2]=='##':
           target.write('\n'+line)
           backup2.write(line)    
       if not(line=='') and line[0]=='#' and not line[0:2]=='##':
           target.write(line)
           backup2.write(line)
  target.write('quit\n')
  target.close()
  target=open('default2.aut4','w')
  backup2.write('quit\n')
  backup2.close()
  source.close()
  #timestamp=False
  return '% Bye!'


