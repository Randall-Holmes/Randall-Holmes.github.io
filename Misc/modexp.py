import random

noisy=True

def modexp(b,e,m):

    global noisy

# make table of exponents
    
    table=[]
    while (e>0):
        table=[e]+table
        e=e//2
    table2=[]

# make table of powers
    
    result=1
    while (len(table)>0):
        result = (result*result)%m
        if table[0]%2==1:
            result = (result*b)%m
        table2 = [[table[0],result]]+table2
        table=table[1:]
        if noisy ==True: print(table2[0])
    return result

def rabinmiller(b,m):

    global noisy

    if m==2: return 'prime'
    if m%2 == 0: return 'composite'

    e=m-1

# make table of exponents
    
    table=[]
    while (e>0):
        table=[e]+table
        e=e//2
    table2=[]

# make table of powers
    
    result=1
    while (len(table)>0):
        result = (result*result)%m
        if table[0]%2==1:
            result = (result*b)%m
        table2 = [[table[0],result]]+table2
        table=table[1:]
        if noisy == True: print(table2[0])

# if m fails the Fermat test it is composite

    if noisy == True:print('\n')
    if noisy == True: print(table2[0])

    if not table2[0][1] == 1:  return 'composite'

#if top exponent is even, strip it off.  If the
# power found is -1, the number might be prime.
    
    while table2[0][0]%2 == 0:
        table2=table2[1:]
        if noisy==True: print('\n')
        if noisy == True:  print(table2[0])
        if table2[0][1]==m-1:  return 'might be prime'

# if the first power found with odd exponent is 1,
# m might be prime.  Otherwise it is composite.

    if not table2[0][1] == 1:  return 'composite'
    return 'might be prime'
    
# check for primality using fifty queries to the Rabin Miller test

def isprime(m):
    global noisy
    noisy=False
    if m<2:  return False
    i=0
    while i<50:
        a=random.randrange(m)
        if a>0 and a<m and rabinmiller(a,m) == 'composite':
            noisy=True
            return False
        i=i+1
    noisy=True
    return True

# find the next odd prime after m

def findprime(m):
    if m%2 == 0 or m<2: m=m+1
    while(1==1):
        if isprime(m):return m
        m=m+2

# find safe prime

def findsafeprime(m):
    if m%2 == 0 or m<2: m=m+1
    while(1==1):
        if isprime(m)and isprime(2*m+1):return m
        m=m+2

# Euclidean algorithm (extended)

# construction of the table

def EEAstep(L):
    quotient = (L[1][0])//(L[0][0])
    newtriple = [L[1][0] - quotient*L[0][0],L[1][1] - quotient*L[0][1],L[1][2] - quotient*L[0][2]]
    return [newtriple]+L

def EEAengine(L):
    while not((L[1][0])%(L[0][0])==0):
        L=EEAstep(L)
    return L

def EEAtable(a,b):
    if a==0 and b==0:  return 'undefined'
    if a<0:  return EEAtable(-a,b)
    if b<0:  return EEAtable(a,-b)
    if a<b:  return EEAtable(b,a)
    return EEAengine([[b,0,1],[a,1,0]])

# gcd function

def gcd(a,b):
    return EEAtable(a,b)[0][0]

# modular inverse function

def modinv(a,m):
    if m<2:  return 'bad modulus'
    if a>=m or a<0:  return modinv(a%m,m)
    table=EEAtable(a,m)
    if table[0][0]==1:
       return table[0][2]%m
    return 'bad'

# RSA setup

def makekey(p,q,r):
    P = findsafeprime(p)
    Q = findsafeprime(q)
    R=r
    phi = (P-1)*(Q-1)
    while(not(gcd(R,phi)==1)):
          R=R+1
    S=modinv(R,phi)
    return [P*Q,R,S]

def makepublickey(p,q,r):
    return makekey(p,q,r)[0:2]

def encrypt(m,key):
    global noisy
    noisy=False
    output=modexp(m,key[1],key[0])
    noisy=True
    return output

def decrypt(m,key):
    global noisy
    noisy=False
    output=modexp(m,key[2],key[0])
    noisy=True
    return output

def numeralize(s):
    if s=='': return 0
    return ord(s[0])+1000*numeralize(s[1:])

def alphabetize(n):
    if n==0:  return ''
    return chr(n%1000)+alphabetize(n//1000)

def textencrypt(s,key):
    global noisy
    return encrypt(numeralize(s),key)

def textdecrypt(n,key):
    global noisy
    return alphabetize(decrypt(n,key))

# look for three factor Carmichael numbers

def threefactor(p,q,n):
    P = findprime(p)
    Q = findprime(q)
    if P==Q: Q = findprime(Q)
    i=0
    j=0
    while(i<n):
        increment=((P-1)*(Q-1))//gcd(P-1,Q-1)
        R = increment*j+1
        if R%(P*Q)==0 and isprime(R//(P*Q)) and (R-1)%(R//(P*Q)-1)==0 and not P==R//(P*Q) and not Q==R//P*Q:
            print([P,Q,R//(P*Q),R,j])
            i=i+1
        j=j+1
