# Post's implementation of the system of PM in a nutshell

# compute first digit in a string

# read a digit from the head of a string

def digit(d):
    if d=="0": return 0
    if d=="1":  return 1
    if d=="2":  return 2
    if d=="3":  return 3
    if d=="4":  return 4
    if d=="5":  return 5
    if d=="6":  return 6
    if d=="7":  return 7
    if d=="8":  return 8
    if d=="9":  return 9
    return ~1

# read a numeral from the head of a string

def getnumeral(s):

    if s=="" or digit(s[0]) == ~1:  return "bad"
    if (len(s) == 1 or digit(s[1]) == ~1):  return [digit(s[0]),s[1:],1]
    D=getnumeral(s[1:])
    return [digit(s[0])*10**D[2]+D[0],D[1],D[2]+1]

# read a logical expression from the head of a string

# added the notation *<numeral> for line <numeral> in the history

def readexpression(s):
    global history
    if len(s)==0:return 'bad'

    #strip spaces from the beginning
    
    if s[0] == ' ': return readexpression(s[1:])

    # variables -- p,q or r followed by a numeral
    
    if s[0]=='p' or s[0] == 'q' or s[0] == 'r':
        D=getnumeral(s[1:])
        if D=='bad':  return 'bad'
        while (len(D[1])>0 and D[1][0]==' '):
               D[1]=D[1][1:]
        return [[0,s[0],D[0]],D[1]]

    #negations
    
    if s[0] == '~':
        X=readexpression(s[1:])
        if X=='bad':return 'bad'
        return [[1,'~',X[0]],X[1]]

    #reference to lines in the history
    
    if s[0] == '*':
        X=getnumeral(s[1:])
        if X[0]==~1:return 'bad'
        return [history[len(history)-X[0]][0],X[1]]

    # infix expressions -- V is primitive, but . for conjunction,
    # > for implication, = for biconditional are supported

    # parentheses are required, though the outermost one is supplied
    # by the propose function
    
    if s[0] == '(':
        X=readexpression(s[1:])
        if X =='bad':  return 'bad'
        while (len(X[1]) > 0 and X[1][0]==' '):
            X[1]=X[1][1:]
        if X[1]=="" or len(X[1])==1 or not(X[1][0] in ['V','.','>','=']):
            return 'bad'
        Y=readexpression(X[1][1:])
        if Y=='bad':return 'bad'
        if len(Y[1])==0 or not(Y[1][0]==")"):  return 'bad'
        return [[2,X[0],X[1][0],Y[0]],Y[1][1:]]
    return 'bad'
                     
def inttostring(n):

    if n<0: return ~1
    if n==0:  return '0'
    if n==1:  return '1'
    if n==2:  return '2'
    if n==3: return '3'
    if n==4:  return '4'
    if n==5: return '5'
    if n==6:  return '6'
    if n==7: return '7'
    if n==8:  return '8'
    
    if n==9:  return '9'
    return (inttostring(n//10))+(inttostring(n%10))

# compute string form of a proposition.  This is also used for type checking.

def propprint(s):
    if len(s)<2: return 'bad'
    if s[0] == 0:
        if not(len(s)==3):  return 'bad'
        if not(s[1]=='p' or s[1] == 'q' or s[1]=='r'):  return 'bad'
        I = inttostring(s[2])
        if I== ~1:  return 'bad'
        return s[1]+I
    if s[0] == 1:
        if not(len(s)==3):  return 'bad'
        if not (s[1]=='~'):  return 'bad'
        S=propprint(s[2])
        if S == 'bad':  return 'bad'
        return s[1]+S
    if s[0] == 2:
        if not (len(s)==4):  return 'bad'
        if not (s[2] in ['V','.','>','=']):  return 'bad'
        S=propprint(s[1])
        if S=='bad':  return 'bad'
        T = propprint(s[3])
        if T=='bad':  return 'bad'
        return '('+S+' '+s[2]+' '+T+')'
    return 'bad'

# parse a string then print it.
            
def proptest(s):
    S=readexpression(s)
    if S=='bad':  return 'bad'
    if not(S[1]==''):
        print ("Didn't read whole expression")
        return 'bad'
    return propprint(S[0])

# one step of definition expansion for binary connectives

def propexpand(s):
    if propprint(s)=='bad':  return 'bad'
    if not(s[0]==2):  return s
    if s[2]=='V':return s
    if s[2]=='>':return [2,[1,'~',s[1]],'V',s[3]]
    if s[2]=='.':return [1,'~',[2,[1,'~',s[1]],'V',[1,'~',s[3]]]]
    if s[2]=='=':return [2,[2,s[1],'>',s[3]],'.',[2,s[3],'>',s[1]]]
    return 'bad'

def expandtest(s):
    return (propprint(propexpand(readexpression(s)[0])))

# manipulations of matching lists

def find(s,L):
    if propprint (s) == 'bad':  return 'bad'
    if L==[]: return []
    if propprint (L[0][0]) == 'bad' or propprint (L[0][1]) == 'bad':
        return 'bad'
    if propprint (s) == propprint (L[0][0]):
        return [L[0][1]]
    return find(s,L[1:])

def drop(s,L):
    if propprint (s) =='bad':  return 'bad'
    if L==[]:  return []
    if propprint (L[0][0]) == 'bad' or propprint (L[0][1]) == 'bad':
        return 'bad'
    if propprint(s) == propprint (L[0][0]):
        return L[1:]
    return [L[0]]+(drop(s,L[1:]))

def merge(L,M):
    if L == 'bad':  return 'bad'
    if M == 'bad': return 'bad'
    if L==[]: return M
    if M == []: return L
    s=L[0][0]
    if find(s,M)==[]:
        M2 = merge(L[1:],M)
        if M2=='bad':return 'bad'
        return [L[0]]+M2
    A=propprint(find(s,M)[0])
    B=propprint(L[0][1])
    if A==B:
        M2=merge(L[1:],drop(s,M))
        if M2=='bad':return 'bad'
        return [L[0]]+M2
    #print(A+" does not match "+B)
    return 'bad'

# match a proposition to another proposition, return
# a list of matches for variables or 'bad'       
    
def propmatch(s,t):
       if propprint(s) == 'bad':
           #print ('error 1')
           return 'bad'
       if propprint(t) == 'bad':
           #print('error 2')
           return 'bad'
       if s[0] == 0:  return [[s,t]]

       # defined notions are expanded out of both source and target

       if s[0]==2 and not(s[2]=='V'):
           return propmatch(propexpand(s),t)
       if t[0]==2 and not(t[2]=='V'):
           return propmatch(s,propexpand(t))
       if not(s[0] == t[0]):
           #print((propprint(s))+ " doesnt match "+ (propprint(t)))
           return 'bad'
       #print(s[2])
       #print(t[2])
       if s[0]==1:  return propmatch(s[2],t[2])
       if s[0]==2:
           Q=merge(propmatch(s[1],t[1]),propmatch(s[3],t[3]))
           #if not(Q=='bad'):  print (propprint(s)+' matches '+(propprint (t)))
           return Q
       return 'bad'

# parse two string and match the resulting propositions
       
def propmatchtest(s,t):
    #print(readexpression(s)[0])
    #print(readexpression(t)[0])
    return propmatch(readexpression(s)[0],readexpression(t)[0])

# Our list of derived statements

history = []

# introduce an axiom

def axiom(s):
    global history

    S=readexpression(s)
    if S=='bad':
        print('parse failure in proposed axiom')
        return 'bad'
    if not(S[1]==''):
        print ('Proposed axiom not completely parsed')
        return 'bad'
    history = [[S[0],'axiom']]+history
    print((propprint(S[0]))+'\naxiom\n')
    return 'good'

# antecedent and consequent of an implication
# (or equivalent disjunction)

def antecedent(s):
    if propprint(s)=='bad':
        return 'bad'
    if not(s[0])==2:  return 'bad'
    if s[2]=='>':  return s[1]
    if s[2]=='V':
        if not(s[1][0]==1):  return 'bad'
        return s[1][2]
    return 'bad'

def consequent(s):
    if propprint(s)=='bad':
        return 'bad'
    if not(s[0])==2:  return 'bad'
    if s[2]=='>':  return s[3]
    if s[2]=='V':
        if not(s[1][0]==1):  return 'bad'
        return s[3]
    return 'bad'

def consequentn(s):
    C = consequent(s)
    if C=='bad':  return 'bad'
    if consequent(C) == 'bad':  return C
    return consequentn(C)

# make a substitution dictated by a matching list

def matchsubs(L,s):
    if propprint(s)=='bad': return 'bad'
    if L==[]:return s
    if propprint(L[0][0])=='bad' or propprint(L[0][1])=='bad':
        return 'bad'
    if s[0]==0 and propprint(L[0][0]) == propprint (s):
        return L[0][1]
    if s[0]==0:  return matchsubs(L[1:],s)
    if s[0]==1:  return [1,'~',matchsubs(L,s[2])]
    if s[0]==2: return [2,matchsubs(L,s[1]),s[2],matchsubs(L,s[3])]
    return 'bad'

# print a matching list in a readable format

def printmatch(L):
    if L==[]: return 'done printing match'
    print ((propprint(L[0][0])+":  "+(propprint(L[0][1]))))
    printmatch(L[1:])

# this is the central proof engine.  It first attempts to prove a statement
# by matching it with an already proved theorem (application of rule 2).

# it then searches for a proof of the statement by modus ponens (with added applications
# of rule 2.  It searches for an implication whose consequent matches the statement,
# makes substitutions dictated by the match into the antecedent, then tries to prove
# the modified antecedent by matching with all statements in the history.

# if a statement is proved by modus ponens, it then automatically attempts to prove its
# consequent, if it has one.  This neatly handles proofs using line reference terms as
# antecedents.

def propose(s):
     global history
     S = readexpression(s)
     if S=='bad':
         print('parse failure of expression to be derived')
         return 'bad'
     if not(S[1]==''):
         return propose('('+s+')')
     #search for applications of rule 2
     i=0
     while(i<len(history)):
        M=propmatch(history[i][0],S[0])
        if not(M=='bad'):
            i2 = len(history)-i
            history=[[S[0],[i2,M]]]+history
            print((inttostring(len(history)))+": "+'Rule 2 from '+(inttostring(i2)+": "+(propprint(history[len(history)-i2][0]))))
            printmatch(M)
            return 'good'
        i=i+1
     #search for applications of rule 3
     i=0
     while(i<len(history)):
         M = propmatch(consequent(history[i][0]),S[0])
         if (not(M=='bad') and not(propprint(antecedent(history[i][0]))
                   ==propprint(consequent(history[i][0])))):
             L1a = history[i][0]
             i2 = len(history)-i
             L1 = matchsubs(M,history[i][0])
             #print('matching consequent '+(propprint(matchsubs(M,consequent(history[i][0])))))
             #printmatch (M)
             # print ("\n")
             j=0
             A = matchsubs(M,antecedent(history[i][0]))
             #print ('proposed antecedent '+(propprint(A)))
             while(j<len(history)):
                M2=propmatch(history[j][0],A)
                if not(M2=='bad'):
                   L2a = history[j][0]
                   j2=len(history)-j
                   L2=matchsubs(M2,history[j][0])
                   # printmatch (M2)
                   history=[[S[0],[i2,M,j2,M2]]]+history
                   print((inttostring(len(history)))+": "+(propprint(S[0])+' by Rule 3 with \n'
                         +propprint(L2)+'\n   [by Rule 2 from '+(inttostring(j2))+": "+propprint(L2a)+')\n and \n'+(propprint(L1))
                           +"]\n   [by Rule 2 from "+(inttostring(i2))+": "+(propprint (L1a))+']\n'))
                   if not(consequent(S[0])=='bad'):  propose(propprint(consequent(S[0])))
                   return 'good'
            
                j=j+1
         i=i+1
     
     return 'bad'

# this shows the n most recent theorems, or shows all of
# them if n=0.

def showhistory(n):
    global history
    i=0
    while(i<len(history) and (i<n or n==0)):
        print((inttostring(len(history)-i)+": "+(propprint(history[i][0]))))
        if history[i][1]=='axiom': print('axiom \n')
        if len(history[i][1])==2:
            print('By Rule 2 from '+(inttostring(history[i][1][0]))+": "+
                  propprint(history[len(history)-history[i][1][0]][0])+"\n")
        if len(history[i][1])==4:
            print('By Rule 3 from '+
                  propprint(matchsubs(history[i][1][3],history[len(history)-history[i][1][2]][0]))
                  +'\n    [by rule 2 from '+(inttostring(history[i][1][2]))+": "+
                  (propprint(history[len(history)-history[i][1][2]][0])+"]\n and "+
                  propprint(matchsubs(history[i][1][1],history[len(history)-history[i][1][0]][0]))
                  +'\n    [by rule 2 from '+(inttostring(history[i][1][0]))+": "+
                  (propprint(history[len(history)-history[i][1][0]][0]))+"]\n"))
               
        
        i=i+1
                   
axiom('(~(p1 Vp1)V p1)')

axiom('(~q1 V(p1Vq1))')

axiom('(~(p1Vq1)V(q1Vp1))')

axiom('(~(p1 V (q1 V r1))V (q1 V(p1 V r1)))')

axiom('(~(~q1 V r1) V (~(p1 V q1)V(p1 V r1)))')

def book():

  propose('(p1V(~q1 V q1))')

  propose('(~q1 V q1)')

  propose('(p1V ~p1)')

  propose('p1>p1')

  propose('(p1Vp1)>p1')

  propose ('(p1Vq1)>(q1Vp1)')

  propose('(p1>q1)>((q1>r1)>(p1>r1))')

  propose('(p1>(p1>q1))>(p1>(q1V~p1))')

  propose ('((p1 > (q1 V ~p1)) > (q1 V (~p1 V ~p1)))')

  propose('(*14 > ((p1 > (p1 > q1)) > (q1 V (~p1 V ~p1))))')

  propose('((p1 > (p1 > q1)) > (q1 V (~p1 V ~p1)))')

  propose('(q1V(~p1V~p1))>(q1V~p1)')

  propose('*18>((p1>(p1>q1))>(q1V~p1))')

  propose('((p1>(p1>q1))>(q1V~p1))')

  propose('(q1V~p1)>(p1>q1)')

  propose('*21>((p1>(p1>q1))>(p1>q1))')

