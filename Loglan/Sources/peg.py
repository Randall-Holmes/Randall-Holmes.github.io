#  version of 2/7/2022 2 pm

# 2/7/2022 declutter no longer removes spaces.  This is preparatory
# to making sure comments are included in grammar and developing a tool
# for changing rule names.  The effect on parses is if anything good.

# 1/20/22 declutter was a bit too energetic and removed some
# occurrences of important classes

# 12/6 fixed bug in parsing of grammar rules with double quotes in them.
# improved display of escape sequences.  Query:  are escape sequences
# in explicit strings handled rationally?  Installed termination checking.

# This version is now self-sufficient, and has no essential
# need of the ML version.

# output display improvements, time leak fixed.

# major performance optimizations
# all parses are cached
# caches and cache keys use only position in string being parsed,
# not a tail of the string
# sequence and iterated parses are iterative rather than recursive

# added greedy parsing option

# added indented display
#  changed shallow so it shows outermost class only, reduces clutter
#  further changes to Shallow display.   4/21 further fine-tuning of
#  shallow display and fixed the recursion so it runs at acceptable speed.

#  corrected shallow printing so it works sensibly with compacted classes
#  (just added work orders for new features at end)

#useful settings:

# Verbose() toggles display of grammar class names
# Shallow() makes the grammar display shallower in a way that is best
# found out by using it
# Numberbrackets() puts numbers <n> next to brackets indicating depth
# Indent() turns on indented display
# Compact (<name of grammar class>) will cause it to display that class
# as an unlabelled unparsed string
# Decompact() turns off all Compact settings

# Greedy() toggles greedy parsing, which always takes the first permissible
# alternative which is *longest*.  A difference between greedy and regular parsing
# indicates a formal problem with the grammar.  Greedy parsing is *slow*

# This file provides PEG parsing services for loglan.py.  User
# advice appears in loglan.py.   This file contains intellectual property
# of Randall Holmes, to which all rights are reserved, though I have no
# objection to anyone playing with it for noncommercial purposes (such as
# the intended application to Loglan).

#  implement PEG parsers for the Loglan grammar and other applications

peggrammar={}  #this is the index of defined classes for the PEG language

def charlistfind(c,L):
    if len(L)==0:  return False
    if (L[0][0]==c or L[0][0]<c) and (L[0][1]==c or L[0][1]>c): return True
    return charlistfind(c,L[1:])

# parser output is a list of two elements, the first a list of items
# (recording parse information) the second the remainder of the string
# still to be consumed

# a proper parser expression is a list of one or two items

# caching is crucial to reasonable performance!  Every parse
# done with an identifier is saved, key being the rule and the string being
# parsed

# features of the ML version should be added:  the circularity checker
# is really useful, and the greedy option would be useful and easy to
# install.  It desperately needs sensible parse display.

cachehits=0

thecache={}
label=0
greedy=False

def Greedy():
    global greedy
    greedy=not(greedy)

TheString = ""

#string is a very deceptive name:  this argument is the position in
#the global variable TheString at which the parse is starting.  Originally
#it was the string to be parsed.

def parse(thegrammar,expression,string):
   global cachehits 
   global thecache
   global greedy
   global TheString
   # ['literal',string]

   SE=showrule(expression)

   if len (expression) == 0 or len(expression)>2 :  return 'bad expression'
   if expression[0]=='identifier' and(SE,(string)) in thecache.keys():
       cachehits=cachehits+1
       #print(cachehits)
       return thecache[(SE,(string))]
   if expression[0]=='literal':
       s=expression[1]
       if len(TheString)-(string)<len(s):
           #thecache[(SE,(string))] = 'fail'
           return 'fail'
       if TheString[string:string+len(s)]==s:
           #thecache[(SE,(string))] = [[s],string+len(s)]
           return [[s],string+len(s)]
       #thecache[(SE,(string))] = 'fail'
       return 'fail'
   if expression[0]=='class':
       L=expression[1]  #L is a list of pairs of characters
       if len(TheString)-(string)==0:
           if L == []:
               #thecache[(SE,(string))] = [[],string]
               return [[],string]
           #thecache[(SE,(string))] = 'fail'
           return 'fail'
       if charlistfind(TheString[string],L)==True:
           #thecache[(SE,(string))] = [[TheString[string]],string+1]
           return [[TheString[string]],string+1]
       #thecache[(SE,(string))] = 'fail'
       return 'fail'
   if expression[0]=='dot':
        if len(TheString)-string==0:
            #thecache[(SE,(string))] = 'fail'
            return 'fail'
        #thecache[(SE,(string))] = [[TheString[string]],string+1]
        return [[TheString[string]],string+1]
   if expression[0]=='sequence':
        L=expression[1]
        currentparse = [[],string]
        while (not(L==[])):
            M=parse(thegrammar,L[0],currentparse[1])
            if M=='fail':
                #thecache[(SE,(string))] = 'fail'
                return 'fail'
            if not(currentparse == 'fail'): currentparse = [currentparse[0]+M[0],M[1]]
            L=L[1:]
        #thecache[(SE,(string))] = currentparse
        return currentparse
        
        #if len(L)==0:
            #thecache[(SE,(string))] = [[],string]
            #return [[],string]
        #M=parse(thegrammar,L[0],string)
        #if M=='fail':
            #thecache[(SE,(string))] = 'fail'
            #return 'fail'
        #N=parse(thegrammar,['sequence',L[1:]],M[1])
        #if N=='fail':
            #thecache[(SE,(string))] = 'fail'
            #return 'fail'
        #thecache[(SE,(string))] = [M[0]+N[0],N[1]]
        #return [M[0]+N[0],N[1]]
   if expression[0]=='alternatives' and greedy == False:
        L=expression[1]
        if len(L)==0:
            #thecache[(SE,(string))] = 'fail'
            return 'fail'
        M=parse(thegrammar,L[0],string)
        if M=='fail':
            Q = parse(thegrammar,['alternatives',L[1:]],string)
            #thecache[(SE,(string))] = Q
            return Q
        #thecache[(SE,(string))] = M
        return M
   if expression[0]=='alternatives' and greedy == True:
        L=expression[1]
        if len(L)==0:
            #thecache[(SE,(string))] = 'fail'
            return 'fail'
        M2=parse(thegrammar,['alternatives',L[1:]],string)
        M1=parse(thegrammar,L[0],string)
        if M2=='fail':
            #thecache[(SE,(string))] = M1
            return M1
        if M1=='fail':
            #thecache[(SE,(string))] = M2
            return M2
        if (M2[1])> (M1[1]):
            #thecache[(SE,(string))] = M2
            return M2
        #thecache[(SE,(string))] = M1
        return M1
   if expression[0]=='not':
        M = parse(thegrammar,expression[1],string)
        if M=='fail':
            #thecache[(SE,(string))] = [[],string]
            return [[],string]
        #thecache[(SE,(string))] = 'fail'
        return 'fail'
   if expression[0]=='and':
        M = parse(thegrammar,expression[1],string)
        if M=='fail':
            #thecache[(SE,(string))] = 'fail'
            return 'fail'
        #thecache[(SE,(string))] = [[],string]
        return [[],string]
   if expression[0]=='optional':
        #M= parse(thegrammar,expression[1],string)
        #if M=='fail':
            #thecache[(SE,(string))] = [[],string]
            #return [[],string]
        M=parse(thegrammar,['alternatives',[expression[1],['sequence',[]]]],string)
        #thecache[(SE,(string))] = M
        return M
   if expression[0]=='zeroormore':
        #if M=='fail':
            #thecache[(SE,(string))] = [[],string]
            #return [[],string]
        #if M[1]==string:
            #thecache[(SE,(string))] = [[],string]
            #return [[],string]
        #N=parse(thegrammar,expression,M[1])
        #thecache[(SE,(string))] = [M[0]+N[0],N[1]]
        #return [M[0]+N[0],N[1]]
       #M=parse(thegrammar,['alternatives',[['sequence',
            #[expression[1],expression]],['sequence',[]]]],string)
       #thecache[(SE,(string))] = M
       #return M

       currentparse=[[],string]
       while 1==1:
           M=parse(thegrammar,expression[1],currentparse[1])
           if M=='fail':
               #thecache[(SE,(string))] = currentparse
               return currentparse
           currentparse=[currentparse[0]+M[0],M[1]]
                     
   if expression[0]=='oneormore':
        #M=parse(thegrammar,expression[1],string)
        #if M=='fail':
            #thecache[(SE,(string))] = 'fail'
            #return 'fail'
        #N=parse(thegrammar,['zeroormore',expression[1]],M[1])
        #thecache[(SE,(string))] = [M[0]+N[0],N[1]]
        #return [M[0]+N[0],N[1]]
       #M=parse(thegrammar,['sequence',[expression[1],['zeroormore',expression[1]]]],string)
       #thecache[(SE,(string))] = M
       #return M

       currentparse=parse(thegrammar,expression[1],string)
       if currentparse=='fail':
           #thecache[(SE,(string))] = currentparse
           return currentparse
       while 1==1:
           M=parse(thegrammar,expression[1],currentparse[1])
           if M=='fail':
               #thecache[(SE,(string))] = currentparse
               return currentparse
           currentparse=[currentparse[0]+M[0],M[1]]
       
   if expression[0]=='identifier':
        if not expression[1] in thegrammar.keys():
            print('bad class name '+expression[1])
            return 'fail'
        M=parse(thegrammar,thegrammar[expression[1]],string)
        thecache[(SE,(string))]=M
        if M=='fail':
            thecache[(SE,(string))]='fail'
            return 'fail'
        thecache[(SE,(string))]=[[[label,expression[1],M[0]]],M[1]]
        return [[[label,expression[1],M[0]]],M[1]]
   print ('badly formed expression encountered '+str(expression[0]))
   return 'fail'

def subs(s,t,expression):

     if expression[0]=='sequence':
        if expression[1]==[]:  return ['sequence',[]]
        L=expression[1]
        return ['sequence',[subs(s,t,L[0])]+subs(s,t,['sequence',L[1:]])[1]]
     if expression[0]=='alternatives':
        if expression[1]==[]:  return ['alternatives',[]]
        L=expression[1]
        return ['alternatives',[subs(s,t,L[0])]+subs(s,t,['alternatives',L[1:]])[1]]
     if expression[0] in ['not','and','optional','zeroormore','oneormore']:
        return [expression[0],subs(s,t,expression[1])]
     if expression[0] == 'identifier':
          if expression[1]==s:  return ['identifier',t]
          if expression[1]==t:  print('variable name collision')
          return expression
     return expression

def subslist(s,expression):

     if expression[0]=='sequence':
        if expression[1]==[]:  return ['sequence',[]]
        L=expression[1]
        return ['sequence',[subslist(s,L[0])]+subslist(s,['sequence',L[1:]])[1]]
     if expression[0]=='alternatives':
        if expression[1]==[]:  return ['alternatives',[]]
        L=expression[1]
        return ['alternatives',[subslist(s,L[0])]+subslist(s,['alternatives',L[1:]])[1]]
     if expression[0] in ['not','and','optional','zeroormore','oneormore']:
        return [expression[0],subslist(s,expression[1])]
     if expression[0] == 'identifier':
          if len(s)<2:  return expression
          if expression[1]==s[0]:  return ['identifier',s[1]]
          if expression[1]==s[1]:  print('variable name collision')
          return subslist(s[2:],expression)
     return expression


substarget = {}

def stringsub(s,t):
    if len(s)<2:  return t
    if s[0]==t: return s[1]
    return stringsub(s[2:],t)

def sub(s,t,grammar1):
    global substarget
    for r in grammar1:
        if r==s:substarget[t] = subs(s,t,grammar1[r])
        if not(r==s):  substarget[r]= subs(s,t,grammar1[r])

def sublist(s,grammar1):
    global substarget
    for r in grammar1:
        substarget[stringsub(s,r)]=subslist(s,grammar1[r])  

def guardform(c):

   if c=='"':  return '\\\"'
   if c=="'":  return '\\\''
   if c=='\n':  return '\\n'
   if c=='\r':  return '\\r'
   if c=='\t':  return '\\t'
   if c=='\\':  return '\\\\'
   if c==']': return '\\]'
   return c
        
def showrule(expression):

    #  this actually needs a clause to determine which quote to use
    if expression[0]=='literal':  return "'"+expression[1]+"'"
    if expression[0]=='class':
        if len(expression[1])==0:  return '[]'
        if len(expression[1])==1:
            if expression[1][0][0]==expression[1][0][1]:
               return '['+guardform(expression[1][0][0])+']'
            return '['+  guardform(expression[1][0][0])+'-'+guardform(expression[1][0][1])+ ']'
        if expression[1][0][0]==expression[1][0][1]: return '['+guardform(expression[1][0][0])+showrule(['class',expression[1][1:]])[1:]
        return '['+guardform(expression[1][0][0])+'-'+guardform(expression[1][0][1])+showrule(['class',expression[1][1:]])[1:]
    if expression[0]=='dot':  return '.'
    if expression[0]=='sequence':
        if len(expression[1])==0:  return '()'
        if len(expression[1])==1:  return '('+showrule(expression[1][0])+')'
        return '('+showrule(expression[1][0])+' '+showrule(['sequence',expression[1][1:]])[1:]
    if expression[0]=='alternatives':
        if len(expression[1])==0:  return '---'
        if len(expression[1])==1:  return '('+showrule(expression[1][0])+')'
        return '('+showrule(expression[1][0])+'/'+showrule(['alternatives',expression[1][1:]])[1:]
    if expression[0]=='not':  return '!'+showrule(expression[1])
    if expression[0]=='and':  return '&'+showrule(expression[1])
    if expression[0]=='optional':  return showrule(expression[1])+'?'
    if expression[0]=='zeroormore':  return showrule(expression[1])+'*'
    if expression[0]=='oneormore':  return showrule(expression[1])+'+'
    if expression[0]=='identifier':  return expression[1]

# termination checking function

def stopcheck(thegrammar,expression):
    if len(expression)==0: return False
    if expression[0]=='literal':
        return len(expression[1])>0
    if expression[0]=='class':
        return True
    if expression[0]=='dot':
        return True
    if expression[0]=='alternatives':
        if len(expression[1]) == 0:  return True
        return stopcheck(thegrammar,expression[1][0]) \
               and stopcheck(thegrammar,['alternatives',expression[1][1:]])
    if expression[0]=='not' and expression[1][0]=='dot': return True
    if expression[0]=='not': return False
    if expression[0]=='and':  return False
    if expression[0]=='optional': return False
    if expression[0]=='zeroormore': return False
    if expression[0]=='oneormore': return stopcheck(thegrammar,expression[1])
    if expression[0]=='identifier': return expression[1] in thegrammar.keys()
    if expression[0]=='sequence':
        if len(expression[1])==0: return False
        if stopcheck(thegrammar,expression[1][0]): return True
        if (expression[1][0][0]=='not'or expression[1][0][0]=='and' \
            or expression[1][0][0]=='optional'or expression[1][0][0]=='zeroormore')\
            and stopcheck(thegrammar,expression[1][0][1]):
                return stopcheck(thegrammar,['sequence',expression[1][1:]])
        return False
    return False
    
def additem1(thegrammar,name,R):
    thegrammar[name]=R

def additem2(thegrammar,name,R):
    if stopcheck(thegrammar,R) == True or (len(name)>0 and name[0]=='_'):
        additem1(thegrammar,name,R)
        return True
    print('Termination check failure in '+name+'\n\n')
    return False
        

# manually building the parser of PEG expressions -- bootstrap time!

# mod errors, here is Ford's grammar of PEG expressions, minus ASCII escape sequences

additem1(peggrammar,'Grammar',['sequence',[['identifier','Spacing'],['oneormore',['identifier','Definition']],['identifier','EndOfFile']]])


additem1(peggrammar,'Definition',['sequence',[['identifier','Identifier'],['identifier','LEFTARROW'],['identifier','Expression']]])

additem1(peggrammar,'Expression',['sequence',[['identifier','Sequence'],['zeroormore',['sequence',[['identifier','SLASH'],['identifier','Sequence']]]]]])

additem1(peggrammar,'Sequence',['zeroormore',['identifier','Prefix']])

additem1(peggrammar,'Prefix',['sequence',[['optional',['alternatives',[['identifier','AND'],['identifier','NOT']]]],['identifier','Suffix']]])

additem1(peggrammar,'Suffix',['sequence',[['identifier','Primary'],['optional',['alternatives',[['identifier','QUESTION'],['identifier','STAR'],['identifier','PLUS']]]]]])

additem1(peggrammar,'Primary',['alternatives',[['sequence',[['identifier','Identifier'],['not',['identifier','LEFTARROW']]]],
                ['sequence',[['identifier','OPEN'],['identifier','Expression'],['identifier','CLOSE']]],
                ['identifier','Literal'],['identifier','Class'],['identifier','DOT']]])
additem1(peggrammar,'Identifier',['sequence',[['identifier','IdentStart'],['zeroormore',['identifier','IdentCont']],['identifier','Spacing']]])

additem1(peggrammar,'IdentStart',['class',[['a','z'],['A','Z'],['_','_']]])

additem1(peggrammar,'IdentCont',['alternatives',[['identifier','IdentStart'],['class',[['0','9']]]]])

additem1(peggrammar,'Literal',['alternatives',[['sequence',[['literal',"'"],['zeroormore',['sequence',[['not',['literal',"'"]],['identifier','Char']]]],['literal',"'"],['identifier','Spacing']]],
         ['sequence',[['literal','"'],['zeroormore',['sequence',[['not',['literal','"']],['identifier','Char']]]],['literal','"'],['identifier','Spacing']]]]])

additem1(peggrammar,'Class',['sequence',[['literal','['],['zeroormore',['sequence',[['not',['literal',']']],['identifier','Range']]]],['literal',']'],['identifier','Spacing']]])

additem1(peggrammar,'Range',['alternatives',[['sequence',[['identifier','Char'],['literal','-'],['identifier','Char']]],['identifier','Char']]])

#  I left out ASCII code escape sequences from the PEG expression grammar as I will not make use of them

additem1(peggrammar,'Char',['alternatives',
                 [['sequence',[['literal','\\'],['class',[['n','n'],['r','r'],['t','t'],["'","'"],["\"","\""],['[','['],[']',']'],['\\','\\']]]]],
                  ['sequence',[['not',['literal','\\']],['dot']]]]])

additem1(peggrammar,'LEFTARROW',['sequence',[['literal','<-'],['identifier','Spacing']]])
additem1(peggrammar,'SLASH',['sequence',[['literal','/'],['identifier','Spacing']]])
additem1(peggrammar,'AND',['sequence',[['literal','&'],['identifier','Spacing']]])
additem1(peggrammar,'NOT',['sequence',[['literal','!'],['identifier','Spacing']]])
additem1(peggrammar,'QUESTION',['sequence',[['literal','?'],['identifier','Spacing']]])
additem1(peggrammar,'STAR',['sequence',[['literal','*'],['identifier','Spacing']]])
additem1(peggrammar,'PLUS',['sequence',[['literal','+'],['identifier','Spacing']]])
additem1(peggrammar,'OPEN',['sequence',[['literal','('],['identifier','Spacing']]])
additem1(peggrammar,'CLOSE',['sequence',[['literal',')'],['identifier','Spacing']]])
additem1(peggrammar,'DOT',['sequence',[['literal','.'],['identifier','Spacing']]])

additem1(peggrammar,'Spacing',['zeroormore',['alternatives',[['identifier','Space'],['identifier','Comment']]]])

additem1(peggrammar,'Comment',
         ['sequence',[['literal','#'],['zeroormore',['sequence',[['not',['identifier','EndOfLine']],['dot']]]],['identifier','EndOfLine']]])
additem1(peggrammar,'Html',
         ['sequence',[['literal','<'],['zeroormore',['sequence',[['not',['identifier','EndOfLine']],['dot']]]],['identifier','EndOfLine']]])
additem1(peggrammar,'Space',['alternatives',[['literal',' '],['literal','\t'],['identifier','EndOfLine']]])

additem1(peggrammar,'EndOfLine',['alternatives',[['literal','\r\n'],['literal','\n'],['literal','\r']]])

additem1(peggrammar,'EndOfFile',['not',['dot']])


# I then need a function which will convert PEG expression parses into the internal representation of expressions

def getchar(P):
    if (not P[0]==label) or not (P[1]=='Char'):
        print('bad character')
        return ' '
    if len(P[2])==1: return P[2][0][0]
    if P[2][1]=='n':  return '\n'
    if P[2][1]=='t':  return '\t'
    if P[2][1]=='r':  return '\r'
    return P[2][1]

def getchar2(P):
    if len(P)==1 and len(P[0])==1:  return P[0]
    if len(P)==1:  return getchar2(P[0])
    return getchar2(P[2])

def getrange(R):
    if len(R[2])==1:  return [getchar(R[2][0]),getchar(R[2][0])]
    return [getchar(R[2][0]),getchar(R[2][2])]

def parsetopeg(P):
    if len(P)==1 and P[0][0]==label:  return parsetopeg(P[0])
    if P[1]=='Expression':
        if len(P[2])==0: return ['bad']
        if len(P[2])==1:  return parsetopeg(P[2][0])
        if len(P[2])==3:  return ['alternatives',[parsetopeg(P[2][0]),parsetopeg(P[2][2])]]
        return ['alternatives',list([parsetopeg(P[2][0])])+ parsetopeg([P[0],P[1],P[2][2:]])[1]]
    if P[1]=='Sequence':
        # zero length is quite possible for sequences
        if len(P[2])==1:  return parsetopeg(P[2][0])
        return ['sequence',list(map(parsetopeg,P[2]))]
    if P[1]=='Prefix':
        if P[2][0][1]=='AND':  return ['and',parsetopeg(P[2][1])]
        if P[2][0][1]=='NOT':  return ['not',parsetopeg(P[2][1])]
        return parsetopeg(P[2][0])
    if P[1]=='Primary':
        if P[2][0][1]=='OPEN':  return parsetopeg (P[2][1])
        return parsetopeg (P[2][0])
    if P[1]=='Suffix':
        if len(P[2])==1:  return parsetopeg(P[2][0])
        if P[2][1][1]=='QUESTION':  return ['optional',parsetopeg(P[2][0])]
        if P[2][1][1]=='STAR':  return ['zeroormore',parsetopeg(P[2][0])]
        if P[2][1][1]=='PLUS':  return ['oneormore',parsetopeg(P[2][0])]
    if P[1]=='Identifier':
        if P[2][0][1]=='Spacing':  return ['identifier','']
        return ['identifier',getchar2(P[2][0][2])+parsetopeg([P[0],P[1],P[2][1:]])[1]]
    if P[1]=='Literal':
        if P[2][1]=='"' or P[2][1]=="'":  return ['literal','']
        return ['literal',getchar(P[2][1])+((parsetopeg([P[0],P[1],[P[2][0]]+P[2][2:]]))[1])]
    if P[1]=='Class':
        return ['class',list(map(getrange,P[2][1:-2]))]
    if P[1]=='DOT':  return ['dot']
    return ['fail']

def classtest(s):
    return parsetopeg(parse(peggrammar,['identifier','Expression'],s)[0])

commentcounter=0

def rundef(thegrammar,s):
    global TheString
    global thecache
    global commentcounter
    thecache.clear();
    if s[0] =='#' or s[0] == '<':
        commentcounter=commentcounter+1
        additem2(thegrammar,s[0]+str(commentcounter),['literal',s[1:]])
        return 'comment'
    TheString=s
    T=parse(peggrammar,['identifier','Definition'],0)
    if T[0]=='fail' or not T[1]==len(TheString):
        print('Failed to define '+TheString)
        return 'failed'
    
    additem2(thegrammar,parsetopeg(T[0][0][2][0])[1],parsetopeg(T[0][0][2][2]))



def Parse(thegrammar,rule, string):
    #print(len(thecache))
    global TheString
    global thecache
    TheString=string
    thecache.clear()
    return parse(thegrammar,thegrammar[rule],0)

compactclasses=[]

def Compact(s):
    global compactclasses
    compactclasses=[s]+compactclasses

def Decompact():
    global compactclasses
    compactclasses=[]

importantclasses=[]

def MakeImportant(s):
    global importantclasses
    importantclasses=[s]+importantclasses

def DevalueImportance():
    global importantclasses
    importantclasses=[]

verbose=True

shallow=False

def Verbose():
    global verbose
    verbose=not(verbose)

def Shallow():
    global shallow
    shallow=not(shallow)

def declutter(P):
    if len(P)==0:  return []
    #if P==' ': return []
    if P==str(P):  return P
    if len(P)==1:
        R=declutter(P[0])
        #if R==' ' or R==[' ']:  return []
        if R==str(R):  return [R]
        return declutter(R)
    if P[0]==label:
        #if len(P[2])==0 or P[2]==' ' or P[2]==[' ']:  return []
        if len(P[2])==0: return []
        if P[1] in compactclasses:  return P
        if P[2]==str(P[2]):  return P
        W= declutter(P[2])
        if len(W)==1: W=W[0]
        #if len(W)==0 or W== ' ' or W==[' ']:  return []
        if len(W)==0:return[]
        if W==str(W): return [P[0],P[1],W]
        if W[0]==label:
            if W[1] in compactclasses:  return [P[0],P[1],W]
            Q= (W[2])
            #if len(Q)==0 or Q==' ' or Q==[' ']:  return []
            if len(Q)==0: return[]
            if Q==str(Q):  return [P[0],P[1],W]
            if Q[0]==label and Q[1] in compactclasses:  return [P[0],P[1],W]
            if Q[0]==label and W[1] in importantclasses and not Q[1] in importantclasses:  return ([P[0],P[1],[W[0],W[1],Q[2]]])
            #if Q[0]==label:  return ([P[0],P[1],Q])
            if Q[0]==label and not W[1] in importantclasses : return ([P[0],P[1],Q])
        return ([P[0],P[1],W])
    Q=declutter(P[0])
    #if Q==[] or Q==' ' or Q==[' ']:  return declutter(P[1:])
    if Q == []: return declutter(P[1:])
    X=declutter(P[1:])
    if X==[] and not Q==str(Q): return Q
    return [Q]+X

def compactprint(P):
    if len(P)==0:  return ''
    if P==str(P):  return P
    if len(P)==1:  return compactprint(P[0])
    if P[0]==label:  return compactprint(P[2])
    return compactprint(P[0])+compactprint(P[1:])

numberbrackets=False

def Numberbrackets():
    global numberbrackets
    numberbrackets=not(numberbrackets)

def bracketnumber(n):
    global numberbrackets
    if numberbrackets==True: return '<'+str(n)+'>'
    return ''

indent=False
def Indent():
    global indent
    indent=not(indent)

indentlevel=3

def spaces(n):
    if n==0:  return ''
    return ' '+spaces(n-1)

def indenting(n):
    if indent==False:  return ''
    if n==0: return "\n"
    return indenting(n-1)+spaces(indentlevel)

def printparse0(n,P):
    global compactclasses
    global verbose
    global shallow
    global numberbrackets
    if len(P)==0:  return ''
    if P==str(P):  return indenting(n)+P
    if len(P)==1:  return printparse0(n,P[0])
    if P[0]==label:
        if P[1] in compactclasses:  return indenting(n)+compactprint(P)
        if(P)==[]:  return ''
        if verbose==False:
            if shallow==True:  return indenting(n)+'['+bracketnumber(n)+printparse0(n+1,(P[2]))+bracketnumber(n)+']'
            return indenting(n)+'['+bracketnumber(n)+printparse(n+1,P[2])+bracketnumber(n)+']'
        Q=(P[2])
        if shallow==True and Q[0]==label and not Q[1] in compactclasses:
            return indenting(n)+'['+bracketnumber(n)+P[1]+': '+Q[1]+":"+printparse0(n+2,Q[2])+bracketnumber(n)+']'
        if shallow==True:  return indenting(n)+'['+bracketnumber(n)+P[1]+':'+printparse0(n+1,Q)+bracketnumber(n)+']'
#use core instead of core2 in line above for just outermost classes
        return indenting(n)+'['+bracketnumber(n)+P[1]+':'+printparse0(n+1,P[2])+bracketnumber(n)+']'
    A=printparse0(n,P[0])
    B=printparse0(n,P[1:])
    if A=='':  return B
    if B=='':  return A
    return A+' '+B

def printparse(P):
    if P=='fail': return 'fail\n'
    return printparse0(1,declutter(P[0]))+"\n"+TheString[P[1]:]

# work orders:  the termination check of the ML version is really useful.  Probably file I/O commands would also be useful,
# though it seems that this version will be slaved to the ML version for now, since I can now export files thence to here.

# more feedback from commands will be useful.
