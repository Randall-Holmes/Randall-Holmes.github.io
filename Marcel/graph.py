# Graph stratification version of the Marcel theorem prover, 4/30/2026,
# by (Lavinia) Randall Holmes, intellectual property
# rights to be respected to the extent of preserving this attribution, please.

# 5/5/2006: the definition facility is installed and works at least superficially,
# though it surely may be buggy in various ways.

# 5/2/2026:  notable changes are that spaces may appear in input notation. I think Ill add
# parentheses and brackets as well.  In soft substitution, displacements of occurence indices in the substituted
# term are made at each substitution, so no stratification difficulties are to be expected.


# 4/30/2026 some debugging and new capabilities.  User commands labelled.
# back() exists to undo commands in a proof -- it is a bit twitchy.
# skip() exists to pass over the current sequent to be done and go to the next one.
# considerable improvement in new variable naming.
# strange left reduction rule for membership statements under consideration:
# it enforces extensionality and makes possible a cut free proof
# that coextensionality implies Leibniz equality.

# This is an alternative development of the core of the Marcel sequent prover
# for stratified set theory.  This version was inspired by considering
# Ryan Nolan's use of the Bellman-Ford algorithm to test stratification:
# using Bellman-Ford is a bad idea, because the second time that you relax
# or even have the opportunity to extend an edge
# [something that Bellman-Ford won't even notice] you should abort and report
# stratification failure.  Here I describe a more sensible graph based
# algorithm for stratification testing, which can be thought of as a variant
# of Dijsktra's algorithm.  This is also informed by the fact that Forster
# and I are working right now, quite independently, on the properties
# of the graph determined by the atomic formulas in a formula:  we are particularly
# interested in connectedness of this graph, and the stratification
# testing in this version is very weak, even weaker than Marcel's weak stratification:
# all that is required is that occurrences of variables connected to the binding variable
# in a set abstract be typed sensibly relative to that variable.  Variables in
# terms and formulas of the language used here have occurrence data attached
# to them invisibly [and it is occurrences that have relative type, not variables per se],
# which has odd effects, not only enabling weak stratification,
# but also removing the effects of bound variable capture (though I really should
# modify the display function to warn the viewer about apparent bound variable capture:
# the system can tell when some variables in the scope of a bound variable are actually
# free with the same shape, but it does not warn the viewer when this happens;  the
# system does prevent the binding of the free "fresh variables"
# introduced by the quantifier rules.

# I owe the reader some documentation and examples, which will be forthcoming.

# This version has NF extensionality, but could easily be converted to SF or NFU.

# developing and testing graph based stratification algorithm

# building the formula type

# more constituents could be added.  We could have defined relations, defined unary predicates, propositional variables, for example.
# we could also have functions and operations.

# immediate work orders:  user commands have been identified, and scripting could be set up.

# the ability to prove and store theorems and cut on a theorem should be added.

# I am thinking about what kind of definition mechanism is wanted.

# I have a very specific idea for the definition problem which I think
# may do the trick completely all at once.  Introduce let terms for
# both terms and formulas where the body is a single capital letter (primes allowed
# so we can have lots of them):  arguments are thus supplied by explicit substitution.
# the data for a definition should of course include the body, but also the
# stratification graph, so that let terms can be stratified without expansion.
# with this, I probably do not need extra notions of pairing, application,
# lambda abstraction and such.

# it may nonetheless be good to have independent relation and/or function machinery.  But
# the let machinery should give a full idiom for compaction of reasoning by definition.

# another idea to record which might be useful for fluent use of equality
# is the notion of being able to extract the context for a variable in a given
# proposition as a lambda term.

# Construction of the definition system is underway.  Parsing is in place,
# working on substitution.  I need the lists of definitions for terms
# and formulas (which weirdly occupy the same namespace);  data to be stored
# is a simplified stratification function, just variable names to numbers,
# checking that no variable is assigned more than one type.  Then I need
# to define stratification, then do the simple business of expanding defined
# terms in the sequent engine.

# the stratification algorithm is now easier to extend, at a cost:  there
# is now a graphing function for terms, which adds a node for each entire term.  These make
# it possible to write all cases of the stratification of atomic formulas
# in a quite uniform way, but the graphs are larger, and output of the
# functions is harder to read.

relations = ["e","="]

def isrelation(s):
    return s in relations

connectives = ["&","V",">","X"]   # < is implication and X is biconditional

def isconnective(s):
    return s in connectives

# this function changes the shape of some connectives in the display.

def cexp(s):
    if s==">":  return "->"
    if s=="X":  return "=="
    return s

quantifiers = ["A","E"]

def isquantifier(s):
    return s in quantifiers

# we could add more primes to diversify the variables.  Actually, digits could play this role.

primes = ["'","*"]

def isprime(s):
    return s in primes

# other components we might want would be pairs, lambda terms.

def isformula(L):
    #atomic formula
    if isrelation(L[0]) and isterm(L[1]) and isterm(L[2]):return True
    #negation
    if L[0] == "~" and isformula(L[1]):return True
    #binary propositional connective
    if isconnective(L[0]) and isformula(L[1]) and isformula(L[2]):  return True
    #quantified formula
    if isquantifier(L[0]) and type(L[1]) == str and type(L[2]) == int and isformula(L[3]):  return True
    # formula let terms look typgraphically the same as term let terms:  what this does is force formula definitions to have arguments)
    # we allow defined constant terms but not defined constant formulas
    #let term
    if L[0] == "let" and isterm(L):  return True

    return False

def isterm(L):
    #variable
    if L[0] == "var" and type(L[1]) == str and type(L[2]) == int:  return True
    #set abstract
    if L[0] == "set" and type(L[1]) == str and type(L[2]) == int and isformula(L[3]):  return True
    #defined
    if L[0] == "defined" and type(L[1]) == str: return True
    #let term
    if L[0] == "let" and isterm(L[1]) and L[1][0]=="var" and isterm(L[2]) and isterm(L[3]) and (L[3][0]=="defined" or L[3][0]=="let"):  return True
    return False

# these functions are used to renumber occurrences of variables which are bound by the same quantifier or abstract:
# such occurrences are identified.

def reinstt(s,n,L):
    if L[0]=="var" and L[1] == s and type(L[2])==int:return [L[0],L[1],n]
    if L[0]=="var" and type(L[1])==str and type (L[2])==int:return L
    if L[0]=="set" and L[1] == s and type(L[2])==int and isformula(L[3]): return L
    if L[0]=="set" and type(L[1])==str and type (L[2])==int and isformula (L[3]):return [L[0],L[1],L[2],reinstf(s,n,L[3])]
    if L[0]=="defined": return L
    if L[0]=="let": return [L[0],L[1],reinstt(s,n,L[2]),reinstt(s,n,L[3])]
    return "!!!"

def reinstf(s,n,L):
    if isrelation(L[0]) and isterm(L[1]) and isterm(L[2]):return [L[0],reinstt(s,n,L[1]),reinstt(s,n,L[2])]
    if L[0]=="~" and isformula(L[1]):return [L[0],reinstf(s,n,L[1])]
    if isconnective(L[0]) and isformula(L[1]) and isformula(L[2]): return [L[0],reinstf(s,n,L[1]),reinstf(s,n,L[2])]
    if isquantifier(L[0]) and L[1]==s and type(L[2])== int and isformula(L[3]):  return L
    if isquantifier(L[0]) and type(L[1])==str and type(L[2])==int and isformula(L[3]):  return [L[0],L[1],L[2],reinstf(s,n,L[3])]
    if L[0]=="let": return [L[0],L[1],reinstt(s,n,L[2]),resinstt(s,n,L[3])]   # term function in the formula third argument is not a mistake
    return "???"


# display functions

# the display of terms highlights things which might be "fresh variables" introduced by the quantifier rules, though it doesn't test whether they are free
# (the parser has now been changed so that fresh variables cannot be bound, even apparently:  no bound variable can have the same surface form).

def displayf(L):
    global unknowns
    global freshvars
    if isrelation(L[0]) and isterm(L[1]) and isterm(L[2]):  return (displayt(L[1]))+" "+L[0]+" "+(displayt(L[2]))
    if L[0] == "~" and isformula(L[1]): return "~" + (displayf(L[1]))
    if isconnective(L[0]) and isformula(L[1]) and isformula(L[2]): return "("+(displayf(L[1]))+" "+cexp(L[0])+" "+(displayf(L[2]))+")"
    if isquantifier(L[0]) and type(L[1])==str and type(L[2]) == int and isformula(L[3]): return "("+L[0]+L[1]+" : "+(displayf(L[3]))+")"
    if L[0]=="defined" and type(L[1]) == str: return L[1]
    if L[0]=="let" and isterm(L[1]) and L[1][0]=="var" and isterm(L[2]) and isterm(L[3]) and (L[3][0]=="defined" or L[3][0]=="let"):
        return displayt(L[3])+"("+displayt(L[1])+":"+displayt(L[2])+")"
    return "???"

def displayt(L):
    global unknowns
    global freshvars
    if L[0]=="var" and not(findunknown(L[1])=="error"):  return L[1]+"?"
    if L[0]=="var" and L[1] in freshvars:  return L[1]+"!"
    if L[0]=="var" and type(L[1]) == str and type(L[2]) == int: return L[1]
    if L[0]=="defined" and type(L[1]) == str: return L[1]
    if L[0]=="let" and isterm(L[1]) and L[1][0]=="var" and isterm(L[2]) and isterm(L[3]) and (L[3][0]=="defined" or L[3][0]=="let"):
        return displayt(L[3])+"("+displayt(L[1])+":"+displayt(L[2])+")"
    if L[0]=="set" and type(L[1]) == str and type(L[2]) == int and isformula(L[3]): return "{"+L[1]+" | "+(displayf(L[3]))+"}"
    return "!!!"
                                                                                                 
# parser

newint = 1

# note that the parser enforces stratification of set abstract terms.
# However, it does this in quite a weak sense.  Types are assigned
# to occurrences of variables, not to variables themselves;  the only
# occurrences which are identified are those bound by the same abstract
# or quantifier.  Further, the stratification test for abstracts only
# checks variables which are connected to the variable bound in the abstract.
# this is all that is necessary;  it is even less than Marcel's weak
# stratification criterion.

# the list of all variables used

variables=[]

# the list of all "unknowns" (witnesses introduced for later specification)

unknowns=[]

# the list of all fresh variables (arbitraries and unknowns) introduced by quantifier rules

freshvars=[]

# The parser:  for rapid prototyping, this is Polish notation.  The display notation is more standard.
# Examples when they are produced will give an indication of how to enter terms and formulas.

# Weak stratification checking of set abstracts is done at parse time.  The graph generation
# and stratification functions are below.

def isspace(s):  return s==" " or s=="(" or s == ")" or s == "[" or s == "]"

def applyprime(p,L):  return [L[0]]+[L[1]+p]+L[2:]  # this makes it possible to prime both variables and definienda.

def gett(s):
    global newint
    global variables
    if len(s)==0: return "!!!"
    if isspace(s[0]): return gett(s[1:])
    if isprime(s[0]):return applyprime(s[0],gett(s[1:]))
    if "a" <= s[0] and s[0] <= "z":
        if not(s[0] in variables):  variables=variables+[s[0]]
        newint=newint+1
        return ["var",s[0],newint]
    if "A" <= s[0] and s[0] <= "Z":
        return ["defined",s[0]]
    if s[0]==":":
        V=gett(s[1:])
        T=gett(restt(s[1:]))
        B=gett(restt(restt(s[1:])))
        if not(V[0]=="var"):  return "!!!"
        if not(B[0]=="defined" or B[0]=="let"):  return "!!!"
        return ["let",V,T,B]
    if s[0]=="{":
        var=gett(s[1:])

        if not (var[0]=="var"):  return "!!!"

        if var[1] in freshvars:
            print("Attempt to bind a fresh variable")
            return "!!!"
        
        F=reinstf(var[1],var[2],getf(restt(s[1:])))
        S=stratify(graphf(F),[var[1],var[2]])
        if S[0]=="stratification failure":
            print(displayf(F))
            print(S)
            return "bad set abstract"
        return ["set",var[1],var[2],F]
    return "!!!"

def restt(s):
    if len(s)==0:  return ""
    if isspace(s[0]):  return restt(s[1:])
    if isprime(s[0]):  return restt(s[1:])
    if "a"<=s[0] and s[0]<="z": return s[1:]
    if "A"<=s[0] and s[0]<="Z": return s[1:]
    if s[0]==":":  return restt(restt(restt(s[1:])))
    if s[0]=="{":
        var=gett(s[1:])
        if not(var[0]=="var"):  return ""
        return restf(restt(s[1:]))
    return ""

def getf(s):
    global newint
    global variables
    if isspace(s[0]):  return getf(s[1:])
    if len(s)==0:return "???"
    if isrelation(s[0]):return [s[0],gett(s[1:]),gett(restt(s[1:]))]
    if s[0]=="~":return [s[0],getf(s[1:])]
    if isconnective(s[0]):return [s[0],getf(s[1:]),getf(restf(s[1:]))]
    if isquantifier(s[0]):
        var=gett(s[1:])
        if not (var[0]=="var"):  return "???"
        return [s[0],var[1],var[2],reinstf(var[1],var[2],getf(restt(s[1:])))]
    if s[0]==":": return gett(s)  # getting a term here is a trick;  let terms have same form in both classes, and in this way
    # we forbid defined formulas without assignments as arguments.
    return "???"

def restf(s):
    if len(s)==0:return "???"
    if isspace(s[0]):return restf(s[1:])
    if isrelation(s[0]): return restt(restt(s[1:]))
    if s[0]=="~":return restf(s[1:])
    if isconnective(s[0]):return restf(restf(s[1:]))
    if isquantifier(s[0]):
        var=gett(s[1:])
        if not(var[0]=="var"): return ""
        return restf(restt(s[1:]))
    if s[0]==":": return restt(s)
    return ""

def testt(s):return displayt(gett(s))

def testf(s):return displayf(getf(s))

# the range of occurrence indices in a term or formula
# needed for substitution

# I need to think about what to do with expressions which actually have
# no variables in them, possible if we have defined constants.

def occt(t):
    if t[0]=="var":  return [t[2],t[2]]
    if t[0]=="set":
        R=occf(t[3])
        return [min(t[2],R[0]),max(t[2],R[1])]
    if t[0]=="let" and t[3][0]=="defined": return occt(t[2])
    if t[0]=="let": return occt(t[2])
    return [newint,newint]

def occf(f):
    if isrelation(f[0]):
        a=occt(f[1])
        b=occt(f[2])
        if f[1][0]=="defined":  return b
        if f[2][0]=="defined":  return a
        return [min(a[0],b[0]),max(a[0],b[0])]
    if f[0]=="~":  return occf(f[1])
    if isconnective(f[0]):
        a=occf(f[1])
        b=occf(f[2])
        return [min(a[0],b[0]),max(a[0],b[0])]
    if isquantifier(f[0]):
        a=occf(f[3])
        return [min(f[2],a[0]),max(f[2],a[1])]
    if f[0]=="let" and f[3][0]=="defined":  return occt(f[2])
    if f[0]=="let":  return occt(f[2])+occt(f[3])   #use of occt is not an error
    return [newint,newint]

#this is hard substitution for variable occurrences.  The same copy is put in everywhere (with occurrences refreshed).
#this preserves stratification.  I am not sure whether soft substitution based just on surface form of variables is needed at all.
#probably it is, but it should be used sparingly. (setunknown uses it).

#amusingly, this has no compensation for bound variable collision because (though it can *look* as if it happens) it doesnt.
#but there should be a display function tweak to highlight apparent bound variable collisions.  (there isnt yet.)

# these functions compute the range of occurrence indices in a term,
# so that substitution knows how far up to displace occurrence indices
# when substituting a term into a context, and how much to increase nextint
# (the variable containing the next occurrence index)

# start here, working on definition syntax

def displaceocct(t,d):
    if t[0] == "var":  return ["var",t[1],t[2]+d]
    if t[0] == "set":  return ["set",t[1],t[2]+d,displaceoccf(t[3],d)]
    if t[0] == "let":  return ["let", t[1],displaceocct(t[2],d),displaceocct(t[3],d)]
    if t[0] == "defined":  return t

def displaceoccf(f,d):

    if isrelation(f[0]):  return [f[0],displaceocct(f[1],d),displaceocct(f[2],d)]
    if f[0]=="~":  return ["~",displaceoccf(f[1],d)]
    if isconnective(f[0]):  return [f[0],displaceoccf(f[1],d),displaceoccf(f[2],d)]
    if isquantifier(f[0]):  return [f[0],f[1],f[2]+d,displaceoccf(f[3],d)]
    if t[0] == "let":  return ["let", t[1],displaceocct(t[2],d),displaceocct(t[3],d)]

# substitution without displacement for a variable with a precise occurrence
# index (as with a bound variable)

def subs1t(v,n,t,u):

    if u == ["var",v,n]: return t
    if u[0]=="var":  return u
    if u[0]=="set" and u[1]==v and u[2]==n:  return u
    if u[0]=="set":return ["set",u[1],u[2],subs1f(v,n,t,u[3])]
    if u[0]=="defined": return u
    if u[0]== "let":  return ["let",u[1],subs1t(v,n,t,u[2]),subs1t(v,n,t,u[3])]

def subs1f(v,n,t,u):

    if isrelation(u[0]):  return [u[0],subs1t(v,n,t,u[1]),subs1t(v,n,t,u[2])]
    if u[0]=="~": return ["~",subs1f(v,n,t,u[1])]
    if isconnective(u[0]):  return [u[0],subs1f(v,n,t,u[1]),subs1f(v,n,t,u[2])]
    if isquantifier(u[0]) and u[1]==v and u[2]==n: return u
    if isquantifier(u[0]):  return [u[0],u[1],u[2],subs1f(v,n,t,u[3])]
    if u[0]== "let":  return ["let",u[1],subs1t(v,n,t,u[2]),subs1t(v,n,t,u[3])]

# substitution without displacement (soft) for a free variable
# it is used by commands for global substitution into proofs, which
# supply the needed displacement of the substituted text.

# added fresh displacement in each substitution.  This removes
# a technical stratification problem.

def freesubs1t(v,t,u):
    global newint
    if u[0]=="var" and u[1]==v:
        a=occt(t)
        d=newint-a[0]+1
        newint=a[1]+d
        T=displaceocct(t,d)
        return T
    if u[0]=="var":  return u
    if u[0]=="set" and u[1]==v:  return u
    if u[0]=="set":return ["set",u[1],u[2],freesubs1f(v,t,u[3])]
    if u[0]=="defined": return u
    if u[0]== "let":  return ["let",u[1],freesubs1t(v,n,t,u[2]),freesubs1t(v,n,t,u[3])]

def freesubs1f(v,t,u):
    if isrelation(u[0]):  return [u[0],freesubs1t(v,t,u[1]),freesubs1t(v,t,u[2])]
    if u[0]=="~": return ["~",freesubs1f(v,t,u[1])]
    if isconnective(u[0]):  return [u[0],freesubs1f(v,t,u[1]),freesubs1f(v,t,u[2])]
    if isquantifier(u[0]) and u[1]==v: return u
    if isquantifier(u[0]):  return [u[0],u[1],u[2],freesubs1f(v,t,u[3])]
    if u[0]== "let":  return ["let",u[1],freesubs1t(v,n,t,u[2]),freesubs1t(v,n,t,u[3])]

#these are the real (hard) substitution functions:  the substituted text has all its occurrence indices made fresh, so
# nothing in it cannot be bound by something outside it, and no stratification problems can be introduced if the original formula was weakly stratified
# in our very weak sense.

# it feels really weird to write a substitution function which completely ignores the variable capture problem.

# probably the display function should alert the user about apparently captured variables.  But this might actually
# be expensive.

# the only user command which would cause apparent variable capture is
# setunknown, and so far I havent installed any warning.  I should do
# a test that it actually behaves as I expect.  (Not true, one can use
# the membership sequent rules to demonstrate apparent variable capture).

# Apparent variable capture is a thing, and to all appearances the system behaves correctly;  it doesnt *show*
# you the occurrence data.

def subst(v,n,t,u):
    global newint
    a=occt(t)
    d=newint-a[0]+1
    newint=a[1]+d
    T=displaceocct(t,d)
    return subs1t(v,n,T,u)
    

def subsf(v,n,t,u):
    global newint
    a=occt(t)
    d=newint-a[0]+1
    newint=a[1]+d
    T=displaceocct(t,d)
    return subs1f(v,n,T,u)

# functions for changing variable names to fresh names.
# new names will be generated using priming if necessary.

def dropitem(v,L):
    if L==[]:  return []
    if L[0]==v:  return dropitem(v,L[1:])
    return [L[0]]+dropitem(v,L[1:])

# this function makes the generation of fresh variables much
# less cluttering.  In effect, binary notation in the primes ' and *

def nextvarname(s):
    if s[-1]=="'":
        return s[0:-1]+"*"
    if s[-1]=="*":
        return (nextvarname(s[0:-1]))+"'"
    return s+"'"

def renamevart(v,w,t):
    global variables
    #global unknowns
    if (w in variables):  return renamevart(v,nextvarname(w),t)
    variables=variables+[w]
    #if v in unknowns: unknowns=dropitem(v,unknowns)+[w]
    if t[0]=="var" and t[1]==v:  return ["var",w,t[2]]
    if t[0]=="var":  return t
    if t[0]=="set" and t[1]==v:  return t
    if t[0]=="set":  return ["set",t[0],t[1],renamevarf(v,w,t[3])]
    
def renamevarf(v,w,f):
    global variables
    if (w in variables):  return renamevarf(v,nextvarname(w),t)
    variables=variables+[w]
    if isrelation(f[0]):  return[f[0],renamevart(v,w,f[1]),renamevart(v,w,f[2])]
    if f[0]=="~": return [f[0],renamevarf(v,w,f[1])]
    if isconnective(f[0]):  return[f[0],renamevarf(v,w,f[1]),renamevarf(v,w,f[2])]
    if isquantifier(f[0]) and f[1]==v: return f
    if isquantifier(f[0]):  return [f[0],f[1],f[2],renamevarf(v,w,f[3])]

# constructing the graph from a formula

def addkey(s,x,L):
    if L==[]:return [[s,[x]]]
    if L[0][0]==s:return [[L[0][0],[x]+L[0][1]]]+L[1:]
    return [L[0]]+(addkey(s,x,L[1:]))

# I have done easy tests of stratification, but a full test of
# the type differentials involving set abstracts is probably a good idea.


def graphf(L):
    global countbase
    if isrelation(L[0]) and isterm(L[1]) and isterm(L[2]):
        c1=[str(countbase+1),-1]
        G1=grapht(L[1])
        c2=[str(countbase+1),-1]        
        G2=grapht(L[2])
        startgraph=(G1+G2)
        if L[0]=="=":
            startgraph=addkey(c1,[c1,c2,0],startgraph)
            startgraph=addkey(c2,[c2,c1,0],startgraph)
        if L[0]=="e":
            startgraph=addkey(c1,[c1,c2,1],startgraph)
            startgraph=addkey(c2,[c2,c1,-1],startgraph)
        return startgraph
 

    if L[0]=="~":  return graphf(L[1])
    if isconnective(L[0]):  return (graphf(L[1])+graphf(L[2]))
    if isquantifier(L[0]):  return graphf(L[3])
    if L[0]=="let" and L[3][0]=="defined":
        thedefquery=findvalues(L[3][1],termdefs)
        if thedefquery==[]:
            print ("undefined definition term")
            startgraph= addkey([basename,-1],[[basename,-1],[basename,-1],1],startgraph)
            return startgraph
        thetypes=thedefquery[0][1]
        thetypequery=findvalues(L[1][1],thetypes)
        if thetypequery==[]:
            print ("no type for this variable found")
            startgraph= addkey([basename,-1],[[basename,-1],[basename,-1],1],startgraph)
            return startgraph
        thetype=thetypequery[0]
        countbase=countbase+1
        c2=[str(countbase),-1]
        c1=[str(countbase+1),-1]
        G1=grapht(L2)
        
        
        startgraph=addkey(c2,[c2,c1,thetype],startgraph)
        startgraph=addkey(c1,[c1,c2,-thetype],startgraph)
    return startgraph        
    if L[0]=="let":
        thedefquery=findvalues(L[3][1],termdefs)
        if thedefquery==[]:
            print ("undefined definition term")
            startgraph= addkey([basename,-1],[[basename,-1],[basename,-1],1],startgraph)
            return startgraph
        thetypes=thedefquery[0][1]
        thetypequery=findvalues(L[1][1],thetypes)
        if thetypequery==[]:
            print ("no type for this variable found")
            startgraph= addkey([basename,-1],[[basename,-1],[basename,-1],1],startgraph)
            return startgraph
        thetype=thetypequery[0]
        c2=[str(countbase+1),-1]
        G2=grapht(L[3])
        c1=[str(countbase+1),-1]
        G1=grapht(L[2])

        
        startgraph=addkey(c2,[c2,c1,thetype],startgraph)
        startgraph=addkey(c1,[c1,c2,-thetype],startgraph)
    return startgraph        
         
        
        
    return []

#  adding in a node [base,-1] standing for the term itself in grapht

# this means there are lots of base nodes generated, one for every subterm!

def grapht0(L,basename):
    startgraph=[]
    if L[0]=="var":
        startgraph=addkey([basename,-1],[[basename,-1],[L[1],L[2]],0],startgraph)
        startgraph=addkey([L[1],L[2]],[[L[1],L[2]],[basename,-1],0],startgraph)
        return startgraph
    if L[0]=="set":
        startgraph=graphf(L[3])
        startgraph=addkey([basename,-1],[[basename,-1],[L[1],L[2]],-1],startgraph)
        startgraph=addkey([L[1],L[2]],[[L[1],L[2]],[basename,-1],1],startgraph)
        return startgraph
    if L[0]=="defined":
        startgraph=[]
        startgraph=addkey([basename,-1],[[basename,-1],[basename,-1],0],startgraph)
        return startgraph
    if L[0]=="let":
        startgraph = (grapht0(L[3],basename)+grapht0(L[2],basename+L[1][1]))
        thedefquery=findvalues(L[3][1],termdefs)
        if thedefquery==[]:
            print ("undefined definition term")
            startgraph= addkey([basename,-1],[[basename,-1],[basename,-1],1],startgraph)
            return startgraph
        thetypes=thedefquery[0][1]
        thetypequery=findvalues(L[1][1],thetypes)
        if thetypequery==[]:
            print ("no type for this variable found")
            startgraph= addkey([basename,-1],[[basename,-1],[basename,-1],1],startgraph)
            return startgraph
        thetype=thetypequery[0]
        startgraph=addkey([basename,-1],[[basename,-1],[basename+L[1][1],-1],thetype],startgraph)
        startgraph=addkey([basename+L[1][1],-1],[[basename+L[1][1],-1],[basename,-1],-thetype],startgraph)
    return startgraph

countbase=1

def grapht(L):
    global countbase
    countbase=countbase+1
    return grapht0(L,str(countbase))


        
        

# using graph method to check stratification

# with the graph as input and a starting point, compute a distance function
# (a relative type assignment) from that starting point.

# a distance function is a list of pairs of a vertex and either the empty set (for infinite distance)
# or a singleton of an integer, followed by either the empty set or a path (for data
# extraction)

# make the initial distance table from a given starting point

def makedistances(L,x):
    if L==[]:  return []
    m=makedistances(L[1:],x)
    if not(getdistance(m,L[0][0])=="error"): return m
    if L[0][0]==x:  return [[x,[0],[x]]]+m
    
    return [[L[0][0],[],[]]]+makedistances(L[1:],x)

def makedistancet(L):
    return makedistances(L,L[0][0])

# get the distance from the starting point to v (as currently estimated)

def getdistance(L,v): 

    if L==[]:  return "error"
    if L[0][0]==v:
        if L[0][1]==[]:return "infty"
        return L[0][1][0]
    return getdistance(L[1:],v)

#get the path from the starting point to V (if we have one)

def getpath(L,v):

    if L==[]:
        print ("error")
        return []
    if L[0][0]==v:
        if L[0][2]==[]:
            print ("none")
            return []
        return L[0][2]
    return getpath(L[1:],v)

# drop the distance to v (in order to replace it)

def dropkey(L,v):
    if L==[]:  return []
    if L[0][0]==v:  return L[1:]
    return [L[0]]+dropkey(L[1:],v)

# function for updating a distance function
# given an edge to work with

def updatedistances(L,v,w,n):


    vdist = getdistance(L,v)
    
    if not(type(vdist)==int):  return "error condition"
    wdist = getdistance(L,w)

    # if w already has a different distance estimate, construct and return a cyle of nonzero length
    
    if not(wdist=="infty" or wdist==vdist+n): return["stratification failure",getpath(L,v)+[[v,n,w]]+rev(getpath(L,w))]

    # if the distance estimate is new, add it (nothing to do if no updating needed)
    
    if wdist=="infty": return [[w,[vdist+n],getpath(L,v)+[[v,n,w]]]]+dropkey(L,w) # this output is now a bit more readable
    # mod the number of new nodes.
    
    return L

# reverse a list, needed in updatedistance to build the bad cycle

def rev(L):
    if L==[]:  return []
    return rev(L[1:])+[L[0]]

def stratify(G,x):

    #initialize the distances

    thedistances=makedistances(G,x)

    i=0
    while(i<len(G)):

       # move thus far uninformative vertices to the end
       j=i
       while(j<len(G) and getdistance(thedistances,G[i][0])=="infty"):
            G=G[0:i]+G[i+1:]+[G[i]]
            j=j+1

       #done if nothing informative is found
            
            
       if getdistance(thedistances,G[i][0])=="infty":  return thedistances
       k=0
       while(k<len(G[i][1])):
           thedistances = updatedistances(thedistances,G[i][1][k][0],G[i][1][k][1],G[i][1][k][2])
           #in the event of stratification failure return the bad cycle
           if thedistances[0]=="stratification failure":return thedistances
           k=k+1
       i=i+1
    # if no errors occur, return the distance table (scheme of relative types)
    return thedistances

# for the moment I only have a stratification tester for formulas.  But
# set abstracts are tested by the parser.  So testt will test any nontrivial term.

def strattest(s):
    t=getf(s)
    g=graphf(t)
    v=g[0][0]
    return stratify(g,v)

# tester for terms

def strattest2(s):
    t = gett(s)
    b=countbase+1
    g = grapht(t)
    return(stratify(g,[str(b),-1]))

# definition mechanism

# return a simplified table of relative types

def findvalues(v,L):
    if L==[]:  return []
    if len(L[0])<2:
        print ("Key list error condition")
        return []
    rest = findvalues(v,L[1:])
    if L[0][0]==v:  return [L[0][1]]+dropitem(L[0][1],rest)
    return rest

def collapsestrat(L):
    M=L
    L2=[]
    while (not (M==[])):
        var=M[0][0][0]
        if M[0][1]==[]: return [] #we want connected
        val=M[0][1][0]
        vals = findvalues(var,L2)
        if vals ==[]: L2=L2+[[var,val]]
        if not(vals == [] or vals ==[val]): return [] #conflict of values
        M=M[1:]
    return L2

def ctest(s):  return collapsestrat(strattest(s))

termdefs=[]

# USER COMMAND

# introduce a term definition

def deft(key,term):
    global termdefs

    K= gett(key)
    if not (K[0]=="defined"):
        print ("Cant define that")
        return "Cant define that"
    if not(findvalues(displayt(K),termdefs)==[]):
        print("Symbol already defined")
        return "Symbol already defined"
    T=gett(term)
    if not(isterm(T)):
        print ("Term entry error")
        return "Term entry error"
    c=[str(countbase+1),-1]
    TT=grapht(T)
    
    L=collapsestrat(stratify(TT,c))
    if L==[]:
        print("Term is unstratified or disconnected")
        return "Term is unstratified or disconnected"
    termdefs=[[displayt(K),[T,L]]]+termdefs
    print ((displayt(K))+ " = "+(displayt(T)))
    print (L)

# USER COMMAND

def showdeft(s):
     if findvalues(s,termdefs)==[]:
         print ("Undefined term symbol")
         return "Undefined term symbol"
     print (s+" = "+(displayt(findvalues(s,termdefs)[0][0])))
     print (findvalues(s,termdefs)[0][1])
     return "Done!"

# USER COMMAND

def showdeff(s):
     if findvalues(s,formuladefs)==[]:
         print ("Undefined formula symbol")
         return "Undefined formula symbol"
     print (s+" = "+(displayf(findvalues(s,formuladefs)[0][0])))
     print (findvalues(s,formuladefs)[0][1])
     return "Done!"

formuladefs=[]

# USER COMMAND

# introduce a formula definition

def deff(key,term):
    global formuladefs

    K= gett(key)
    if not (K[0]=="defined"):
        print ("Cant define that")
        return "Cant define that"
    if not(findvalues(displayt(K),termdefs)==[]):
        print("Symbol already defined")
        return "Symbol already defined"
    T=getf(term)
    if not(isformula(T)):
        print ("Formula entry error")
        return "Formula entry error"
    c=[str(countbase+1),-1]
    TT=graphf(T)
    
    L=collapsestrat(stratify(TT,TT[0][0]))
    if L==[]:
        print("Term is unstratified or disconnected")
        return "Term is unstratified or disconnected"
    formuladefs=[[displayt(K),[T,L]]]+formuladefs
    print ((displayt(K))+ " = "+(displayf(T)))
    print (L)

# definition expansion involves quite elaborate variable reshuffling

def defexpandt(t):
    # if applied to a definition term, simply expand it
    global newint
    if t[0]=="defined":
        if findvalues(t[1],termdefs) == []:
            print ("undefined symbol in defexpandt")
            return ("undefined symbol in defexpandt")
        u=findvalues(t[1],termdefs)[0][0]
        a=occt(u)
        d=newint-a[0]+1
        newint=a[1]+d
        T=displaceocct(u,d)
        
        return T
    if t[0]=="let":
        T=atify(t)
        U=cascadesubst(T)
        return deatifyt(U)

def defexpandf(t):

    if t[0]=="let":
        T=atify2(t)
        U=cascadesubsf(T)
        return deatifyf(U)

def atify(t):
    global newint
    if t[0]=="let":
        return [t[0],["var","@"+t[1][1],t[1][2]],t[2],atify(t[3])]

    if t[0]=="defined":
            if findvalues(t[1],termdefs) == []:
               print ("undefined symbol "+t[1]+" in atify")
               return ("undefined symbol in atify")
            u=findvalues(t[1],termdefs)[0][0]
            a=occt(u)
            d=newint-a[0]+1
            newint=a[1]+d
            T=displaceocct(u,d)
            return atify2t(T)

def atify2(t):
    global newint
    if t[0]=="let":
        return [t[0],["var","@"+t[1][1],t[1][2]],t[2],atify2(t[3])]

    if t[0]=="defined":
            if findvalues(t[1],formuladefs) == []:
               print ("undefined symbol "+t[1]+"  in atify2")
               return ("undefined symbol "+t[1]+"  in atify2")
            u=findvalues(t[1],formuladefs)[0][0]
            a=occf(u)
            d=newint-a[0]+1
            newint=a[1]+d
            T=displaceoccf(u,d)
 
            return atify2f(T)

def atify2t(t):
    if t[0]=="var": return ["var","@"+t[1],t[2]]
    if t[0]=="set":  return [t[0],"@"+t[1],t[2],atify2f(t[3])]
    if t[0]=="defined":  return t
    if t[0]=="left":  return [t[0],t[1],atify2t(t[2]),atify2t(t[3])]

def atify2f(f):
    if isrelation(f[0]):  return [f[0],atify2t(f[1]),atify2t(f[2])]
    if isconnective(f[0]):  return [f[0],atify2f(f[1]),atify2f(f[2])]
    if f[0]=="~":  return [f[0],atify2f(f[1])]
    if isquantifier(f[0]):  return [f[0],"@"+f[1],f[2],atify2f(f[3])]
    if t[0]=="left":  return [t[0],t[1],atify2t(t[2]),atify2t(t[3])]

def cascadesubst(t):
    if t[0] == "let" and t[1][1][0] =="@":
        return freesubs1t(t[1][1],t[2],cascadesubst(t[3]))
    return t

def cascadesubsf(t):
    if t[0] == "let" and t[1][1][0] =="@":
        return freesubs1f(t[1][1],t[2],cascadesubsf(t[3]))
    return t

def removeat(s):
    if s[0]=="@":  return s[1:]
    return s

def deatifyt(t):
    if t[0]=="var": return ["var",removeat(t[1]),t[2]]
    if t[0]=="set":  return [t[0],removeat(t[1]),t[2],deatifyf(t[3])]
    if t[0]=="defined":  return t
    if t[0]=="left":  return [t[0],t[1],deatifyt(t[2]),deatifyt(t[3])]

def deatifyf(f):
    if isrelation(f[0]):  return [f[0],deatifyt(f[1]),deatifyt(f[2])]
    if isconnective(f[0]):  return [f[0],deatifyf(f[1]),deatifyf(f[2])]
    if f[0]=="~":  return [f[0],deatifyf(f[1])]
    if isquantifier(f[0]):  return [f[0],removeat(f[1]),f[2],deatifyf(f[3])]
    if f[0]=="left":  return [f[0],f[1],deatifyt(f[2]),deatifyt(f[3])]
    
    

#start sequent development

# a proof is a list of sequents

# a sequent contains three parts, a list of left proposition, a list of right propositions,
# and a list of positions (integers) of sequents in the proof intended to justify it, or [-1] if it is not yet
# proved.  A sequent rule will take the left and right propositions and return
# one or two new sequents, inserting them at the end of the proof as
# further goals, and adjusting the third component of the original sequent
# to point to them.

def displayproplist(L):
    if L==[]: return "\n"
    n=0
    thelist="\n"
    while (n<len(L)):
        thelist = thelist+"\n\n"+str(n)+".  "+displayf(L[n])
        n=n+1
    return thelist

def displaysequent(n,S):

    return "\n\nLine number "+(str(n))+"\n\n"+displayproplist(S[0])+"\n----\n"+displayproplist(S[1])+"\n\n"+"by lines "+str(S[2])


#substitution into a sequent
#occurrence displacement is assumed already done (by setunknown, so far the only client)

def subs1s(v,t,S):
    L=S[0]
    L2=[]
    while(not(L==[])):
        L2=L2+[freesubs1f(v,t,L[0])]
        L=L[1:]
    R=S[1]
    R2=[]
    while(not(R==[])):
        R2=R2+[freesubs1f(v,t,R[0])]
        R=R[1:]
    return [L2,R2,S[2]]
        

theproof=[]

def displayproof(P):
    if P==[]: return []
    Q=P
    o=""
    n=0
    while(not(Q==[])):
        o=o+displaysequent(n,Q[0])
        Q=Q[1:]
        n=n+1
    print(o)
    return o

#the line number in the proof where we are working

theline=0

# something like the original proof graph traversal is now implemented,
#using a stack to indicate which line we want to do next

#this is the stack of lines to be dealt with
#when it is exhausted, simply proceed to the next line (if this actually happens)

linestack=[]

# the function which determines whether we are done with the current line,
# and if we are done proceeds to the next line.

proofstack=[]

def displaynextline():
    global theline
    global linestack
    global proofstack
    global variables
    global unknowns
    global freshvars
    global newint
    global theproof
    global theline
    
    if not (linestack==[]) and not(theproof[theline][2]==[-1]):
        theline = linestack[0]
        linestack=linestack[1:]
        print(displaysequent(theline,theproof[theline]))
        print ("Next!")
        proofstack=[[theproof,theline,newint,countbase,variables,freshvars,unknowns,linestack]]+proofstack
        return("Next!")
    while (theline<len(theproof) and not(theproof[theline][2]==[-1])):
        theline=theline+1
    if theline==len(theproof):
        print ("Done!")
        proofstack=[[theproof,theline,newint,countbase,variables,freshvars,unknowns,linestack]]+proofstack
        return "Done!"
    print(displaysequent(theline,theproof[theline]))
    proofstack=[[theproof,theline,newint,variables,freshvars,unknowns,linestack]]+proofstack
    print ("Next!")

# USER COMMAND
#put the current line at the bottom of the stack of sequents to be dealt with
#and bring on the next sequent

def skip():
    global theline
    global linestack
    if len(linestack)<1:
        print("Nothing to skip")
        displaynextline()
        return "Nothing to skip"
    L=theline
    theline=linestack[0]
    linestack=linestack[1:]+[L]
    displaynextline()

# USER COMMAND

def back():
    global theproof
    global theline
    global newint
    global variables
    global freshvars
    global unknowns
    global linestack
    global proofstack
    if proofstack==[]:
        print ("No back information")
        return ("No back information")
    P=proofstack[0]
    proofstack=proofstack[1:]
    theproof=P[0]
    theline=P[1]
    newint=P[2]
    countbase=P[3]
    variables=P[4]
    freshvars=P[5]
    unknowns=P[6]
    linestack=P[7]
    theproof[theline][2]=[-1]
    look()
    return ("Backed up")

# USER COMMAND

def look():
    if theproof == []:
        print("no proof to show")
        return ("No proof to show")
    if not(theline==len(theproof)): print(displaysequent(theline,theproof[theline]))
    if theline==len(theproof): print(displaysequent(theline,theproof[0]))
    if theline==len(theproof): print("Done!")

    
    
# USER COMMAND
# initialize a sequent to be proved

def start(f):
    global newint
    global theproof
    global theline
    global variables
    global unknowns
    global freshvars
    global proofstack
    global linestack
    global countbase
    newint = 1
    countbase = 1
    variables=[]
    unknowns=[]
    freshvars=[]
    linestack=[]
    proofstack=[]
    if not(isformula(getf(f))):
        print("Formula entry error")
        return("Formula entry error")
    theproof=[[[],[getf(f)],[-1]]]
    theline=0
    displaynextline()

# utility to generate the line numbers on which proof of a line depends immediately

def nextrefs(n):
    i=0
    r=[]
    l=len(theproof)
    while (i<n):
        r=r+[l+i]
        i=i+1
    return r

# USER COMMAND
# apply a left rule

def left():
    global theproof
    global linestack
    global variables
    if len(theproof[theline][0])==0:
        displaynextline()
        return "No left proposition to act on!"
    L=leftaction(theproof[theline][0][0])
    if L==[[]]:
        displaynextline()
        return "Left action unsuccessful"
    theproof[theline][2]=nextrefs(len(L))
    i=0
    while (i<len(L)):
        A=L[i][0]+theproof[theline][0][1:]
        B=L[i][1]+theproof[theline][1]
        theproof=theproof+[[A,B,[-1]]]
        i=i+1
    linestack=theproof[theline][2]+linestack
    displaynextline()

# USER COMMAND
# apply a right rule

def right():
    global theproof
    global linestack
    global variables
    if len(theproof[theline][1])==0:
        displaynextline()
        return "No left proposition to act on!"
    R=rightaction(theproof[theline][1][0])
    if R==[[]]:
        displaynextline()
        return "Right action unsuccessful"
    theproof[theline][2]=nextrefs(len(R))
    i=0
    while (i<len(R)):
        A=R[i][0]+theproof[theline][0]
        B=R[i][1]+theproof[theline][1][1:]
        theproof=theproof+[[A,B,[-1]]]
        i=i+1
    linestack=theproof[theline][2]+linestack
    displaynextline()

#because of our occurrence based mechanics, determining equality of terms takes work.
#everything has a price.

# When terms are not equal and evaluating an unknown will make them true, the appropriate
# setunknown action is executed to make them equal.

# we might want a nondynamic equality function, but for the moment done() is the only client

def equalt(t1,t2):
    global unknowns

    if t1[0]=="var" and t1[1]==t2[1]:  return True
    if t1[0]=="var" and not(findunknown(t1[1])=="error"):
        V=findunknown(t1[1])
        T=t2
        L = freshvarlistt(T)
        while(not(L==[])):
          if not(L[0] in V[1]):
            return False
          L=L[1:]
        setunknown2(t1[1],t2)
        return True
    if t2[0]=="var" and not(findunknown(t2[1])=="error"):
        V=findunknown(t2[1])
        T=t1
        L = freshvarlistt(T)
        while(not(L==[])):
          if not(L[0] in V[1]):
            return False
          L=L[1:]
        setunknown2(t2[1],t1)
        return True            
    if t1[0]=="var":  return False
    if not(t1[0]==t2[0]):  return False
    if t1[0]=="set":
        v=renamevart(t1[1],t1[1],["var",t1[1],t1[2]])
        return equalf(subsf(t1[1],t1[2],v,t1[3]),subsf(t2[1],t2[2],v,t2[3]))
    if t1[0]=="defined":
        if t1[0]==t2[0]:  return True
        return False
    if t1[0]=="let":
        if not(t1[1]==t2[1]):  return False
        if not(equalt(t1[2],t2[2])):  return False
        return equalt(t1[3],t2[3])

def equalf(f1,f2):
    if not(f1[0]==f2[0]):  return False
    if isrelation(f1[0]):
        if equalt(f1[1],f2[1]) and equalt(f1[2],f2[2]):  return True
        return False
    if f1[0]=="~":  return equalf(f1[1],f2[1])
    if isconnective(f1[0]):
        if equalf(f1[1],f2[1]) and equalf(f1[2],f2[2]):  return True
        return False
    if isquantifier(f1[0]):
        v=renamevart(f1[1],f1[1],["var",f1[1],f1[2]])
        return equalf(subsf(f1[1],f1[2],v,f1[3]),subsf(f2[1],f2[2],v,f2[3]))
    if f1[0]=="let":
        if not(t1[1]==t2[1]):  return False
        if not(equalt(t1[2],t2[2])):  return False
        return equalt(t1[3],t2[3]) #equalt is correct here

# USER COMMAND
# recognize sequent axioms.  I believe this is the only place
# where equality of terms and formulas is used so far.  Bespoke rules for equality
# would use it no doubt.

def done():
    global theproof
    global theline
    if len(theproof[theline][0])==0 or len(theproof[theline][1])==0:
        print("one of the formulas to be compared not found")
        return "one of the formulas to be compared not found"
    if not(equalf(theproof[theline][0][0],theproof[theline][1][0])):
        print("Not done!")
        return "Not done!"
    theproof[theline][2]=[]
    displaynextline()

# move a desired left or right term to the front of the list

# these had to be written differently to let the back() function work through them

# USER COMMAND

def getleft(n):
    global theproof
    if n> len(theproof[theline][0]):
        displaynextline
        return "the left proposition list is not that long"
    theproof= theproof[0:theline]+[[(theproof[theline][0][n:]+theproof[theline][0][0:n]),theproof[theline][1],theproof[theline][2]]]+theproof[theline+1:]
    displaynextline()

# USER COMMAND

def getright(n):
    global theproof
    if n> len(theproof[theline][1]):
        displaynextline()
        return "the right proposition list is not that long"
    theproof= theproof[0:theline]+[[theproof[theline][0],(theproof[theline][1][n:]+theproof[theline][1][0:n]),theproof[theline][2]]]+theproof[theline+1:]
    displaynextline()

# leftaction and rightaction are the meat of the logic

def leftaction(f):
    global unknowns
    global newint
    global freshvars
    global variables
    if f[0]=="let":  return [[[defexpandf(f)],[]]]
    if f[0]=="&":  return [[[f[1],f[2]],[]]]
    if f[0]=="V":  return [[[f[1]],[]],[[f[2]],[]]]
    if f[0]==">":  return [[[],[f[1]]],[[f[2]],[]]]
    if f[0]=="X":
        A=[">",f[1],f[2]]
        B=[">",f[2],f[1]]
        return [[[A,B],[]]]
    if f[0]=="~":  return [[[],[f[1]]]]
    if f[0]=="e" and f[2][0]=="set":
        return [[[subsf(f[2][1],f[2][2],f[1],f[2][3])],[]]]
    if f[0]=="e" and (f[2][0]=="let" or f[2][0]=="defined"):
        return [[[[f[0],f[1],defexpandt(f[2])]],[]]]
    if f[0]=="e" and (f[1][0]=="let" or f[1][0]=="defined"):
        return [[[[f[0],defexpandt(f[1]),f[2]]],[]]]
    if f[0]=="e":
        newint=newint+3
        v=renamevart(variables[0],variables[0],["var",variables[0],newint-2])
        w=renamevart(variables[0],variables[0],["var",variables[0],newint-1])
        A=["A",v[1],v[2],["V",["e",v,f[2]],["E",w[1],w[2],["~",["X",["e",w,f[1]],["e",w,v]]]]]]
        return [[[A],[]]]   
    if f[0]=="=" and (f[2][0]=="let" or f[2][0]=="defined"):
        return [[[[f[0],f[1],defexpandt(f[2])]],[]]]
    if f[0]=="=" and (f[1][0]=="let" or f[1][0]=="defined"):
        return [[[[f[0],defexpandt(f[1]),f[2]]],[]]]
         
    if f[0]=="=":
        newint=newint+1
        v=renamevart(variables[0],variables[0],["var",variables[0],newint])
        return [[[["A",v[1],v[2],["X",["e",f[1],v],["e",f[2],v]]]],[]]]
    if f[0]=="A":
        v=renamevart(f[1],f[1],["var",f[1],f[2]])
        unknowns=[[v[1],freshvars]]+unknowns
        freshvars=[v[1]]+freshvars
        return [[[subs1f(f[1],f[2],v,f[3]),f],[]]]
    if f[0]=="E":
        v=renamevart(f[1],f[1],["var",f[1],f[2]])
        freshvars=[v[1]]+freshvars
        return [[[subs1f(f[1],f[2],v,f[3])],[]]]

    return [[]]

def rightaction(f):
    global unknowns
    global newint
    global freshvars
    global variables
    if f[0]=="let":  return [[[],[defexpandf(f)]]]
    if f[0]=="&":  return[[[],[f[1]]],[[],[f[2]]]]
    if f[0]=="V":  return [[[],[f[1],f[2]]]]
    if f[0]==">":  return [[[f[1]],[f[2]]]]
    if f[0]=="X":  return [[[f[1]],[f[2]]],[[f[2]],[f[1]]]]
    if f[0]=="~":  return [[[f[1]],[]]]
    if f[0]=="e" and f[2][0]=="set":
        return [[[],[subsf(f[2][1],f[2][2],f[1],f[2][3])]]]
    if f[0]=="e" and (f[2][0]=="let" or f[2][0]=="defined"):
        return [[[],[[f[0],f[1],defexpandt(f[2])]]]]
    if f[0]=="e" and (f[1][0]=="let" or f[1][0]=="defined"):
        return [[[],[[f[0],defexpandt(f[1]),f[2]]]]]

    #if f[0]=="e":
        #newint=newint+3
        #v=renamevart(variables[0],variables[0],["var",variables[0],newint-2])
        #w=renamevart(variables[0],variables[0],["var",variables[0],newint-1])
        #A=["A",v[1],v[2],["V",["e",v,f[2]],["E",w[1],w[2],["~",["X",["e",w,f[1]],["e",w,v]]]]]]
        #return [[[],[A]]]
# this is the extensional right rule for NF;  the one for SF is obtained by
#reversing the membership statements
    if f[0]=="=" and (f[2][0]=="let" or f[2][0]=="defined"):
        return [[[],[[f[0],f[1],defexpandt(f[2])]]]]
    if f[0]=="=" and (f[1][0]=="let" or f[1][0]=="defined"):
        return [[[],[[f[0],defexpandt(f[1]),f[2]]]]]
    
    if f[0]=="=":
        newint=newint+1
        v=renamevart(variables[0],variables[0],["var",variables[0],newint])
        return [[[],[["A",v[1],v[2],["X",["e",v,f[1]],["e",v,f[2]]]]]]]
    if f[0]=="A":
        v=renamevart(f[1],f[1],["var",f[1],f[2]])
        freshvars=[v[1]]+freshvars
        return [[[],[subs1f(f[1],f[2],v,f[3])]]]
    if f[0]=="E":
        v=renamevart(f[1],f[1],["var",f[1],f[2]])
        unknowns=[[v[1],freshvars]]+unknowns
        freshvars=[v[1]]+unknowns
        return [[[],[subs1f(f[1],f[2],v,f[3]),f]]]

    return [[]]

# find the unknown with a given name:  the function is needed because unknowns have attached dependency lists

def findunknown(v):
    global unknowns
    u = unknowns
    while (1==1):
        if u==[]:
            #print("There is no such unknown")
            return "error"
        if u[0][0]==v:  return u[0]
        u=u[1:]

# lists fresh variables introduced by quantifier rules
# (arbitrary objects or "unknowns") to check fresh variable dependencies

def freshvarlistt(t):

    if t[0]=="var" and t[1] in freshvars:  return [t[1]]
    if t[0]=="var":  return []
    if t[0]=="set":  return freshvarlistf(t[3])

def freshvarlistf(f):

    if isrelation(f[0]):  return freshvarlistt(f[1])+freshvarlistt(f[2])
    if f[0]=="~":  return freshvarlistf(f[1])
    if isconnective(f[0]):  return freshvarlistf(f[1])+freshvarlistf(f[2])
    if isquantifier(f[0]):  return freshvarlist(f[3])

# we use this device to replace witnesses introduced by right
# existential or left universal rules;  in this way we do not have
# to supply them at the time we introduce them.  We do need to
# check that they are something we could have written at the time
# the rule was applied:  this is the reason we have the fresh variables
# introduced prior to an "unknown" as part of the list.

# the idea here is all the quantifier rules act in the same way
# (so they can be crushed into left() and right(), but the introduction
# of a concrete witness can be carried out later -- even some time later
# when the proof suggests what the witness should be.

# USER COMMAND

def setunknown(v,t):
    global theproof
    global newint
    V=findunknown(v)
    if V == "error":
        print ("not an unknown")
        displaynextline()
        return "error"
    T=gett(t)
    if not(isterm(T)):
        print("Bad term entered")
        displaynextline()
        return "Bad term entered"

    L = freshvarlistt(T)
    while(not(L==[])):
        if not(L[0] in V[1]):
            print("Fresh variable reference error")
            displaynextline()
            return "Fresh variable reference error"
        L=L[1:]

    T2=T

    P=theproof
    P2=[]
    while(not(P==[])):
        P2=P2+[subs1s(V[0],T2,P[0])]
        P=P[1:]
    theproof=P2
    displaynextline()

#internal version of setunknown for equality function

def setunknown2(v,t):
    global theproof
    global newint
    V=findunknown(v)
    if V == "error":
        print ("not an unknown")
        displaynextline()
        return "error"
    T=t
    if not(isterm(T)):
        print("Bad term entered")
        displaynextline()
        return "Bad term entered"

    L = freshvarlistt(T)
    while(not(L==[])):
        if not(L[0] in V[1]):
            print("Fresh variable reference error")
            displaynextline()
            return "Fresh variable reference error"
        L=L[1:]

    T2=T

    P=theproof
    P2=[]
    while(not(P==[])):
        P2=P2+[subs1s(V[0],T2,P[0])]
        P=P[1:]
    theproof=P2
    #displaynextline()


# USER COMMAND
# the Cut rule

def Cut(f):
    global theproof
    global linestack
    F=getf(f)
    if not(isformula(F)):
        print("Bad formula entry")
        displaynextlin()
        return("Bad formula entry")
    P=theproof[theline]
    P1=[[F]+P[0],P[1],[-1]]
    P2=[P[0],[F]+P[1],[-1]]
    theproof=theproof+[P1]
    theproof=theproof+[P2]
    theproof[theline][2]=[len(theproof)-2,len(theproof)-1]
    linestack = theproof[theline][2]+linestack
    displaynextline()
        
    



    

            


    


    
            
        

    
    
