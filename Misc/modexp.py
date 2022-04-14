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

# find the next odd twin primes after m

def findtwinprime(m):
    if m%2 == 0 or m<2: m=m+1
    while(1==1):
        if isprime(m) and isprime(m+2):return m
        m=m+2

# find safe prime

def findsafeprime(m):
    if m%2 == 0 or m<2: m=m+1
    while(1==1):
        if isprime(m)and isprime((m-1)//2):return m
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
    P = findprime(p)
    Q = findprime(q)
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
    return ord(s[-1])-ord('a')+11+100*numeralize(s[0:-1])

def alphabetize(n):
    if n==0:  return ''
    return alphabetize(n//100)+chr(n%100-11+ord('a'))

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

# world's stupidest phi calculator

def phi(n):

    i=1
    while(i<=n):
       if n % i == 0 and isprime(i):
           #print(i)
           n=n-n//i
           #print(n)
       i=i+1
    return n

i = 160
while(i<2000):
    if phi(i) == 160:  print (i)
    i=i+1

# huge Carmichael numbers

def carjunk(n):
    
    while(1+1==2):
        if isprime(6*n+1) and isprime(12*n+1) and isprime(18*n+1):
            return (6*n+1)*(12*n+1)*(18*n+1)
        n=n+1


def order(a,m):

    b=a
    o=1
    while(not b==1):
        b=(a*b)%m
        o=o+1
    return o

# El Gamal setup

def EGkeysetup(n):

    global noisy
    noisy=False

#find a large safe prime
    
    p = findsafeprime(n)

    q = (p-1)//2

#find a generator for p
    stop=False
    while(stop==False):
        g=random.randrange(p-4)+2
        if modexp(g,q,p)== p-1: stop =True

    x=random.randrange(p-2)+1

    y = modexp(g,x,p)

    return [p,g,y,x]

N = 2862738647

fullkey = EGkeysetup(N)

publickey = fullkey[0:3]

def EGencrypt(pub,M):
    global noisy
    noisy = False
    p=pub[0]
    r=random.randrange(pub[0])
    return [(M*modexp(pub[2],r,p))%p,modexp(pub[1],r,p)]

def EGdecrypt(full,Mprime):
    global noisy
    noisy=False
    p=full[0]
    g=full[1]
    x=full[3]
    return (Mprime[0]*modexp(Mprime[1],p-1-x,p))%p

def EGtextencrypt(pub,S):
    return EGencrypt(pub,numeralize(S))

def EGtextdecrypt(full,Mprime):
    return(alphabetize(EGdecrypt(full,Mprime)))


