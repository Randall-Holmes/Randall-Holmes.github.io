import random

# For Math 189 Fall 2022 I am adding some comments explaining what the
# functions do.

# does the modexp function show all its calculation?

noisy=True

# The modexp function modexp(b,e,m) computes b^e mod m by the method of repeated squaring.

# If you can read the Python code you should see that it does the same thing
#as my board work or spreadsheet.

# modular exponentiation:  compute b^e mod m.

# try modexp(27,100,211):  this is an example in the notes
# and the work will look like my board work except upside down ;-)

# try 3^1000000000 mod 211.  Try simplifying this calculation using
# Fermat's little theorem and checking that you get the same answer.

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

# excute the Rabin-Miller test

# is b a witness to m being composite?

# I explained in class that this is a slight extension of
# the Fermat test, adding the provision that whenever we
# compute a square a^2 mod m, if a^2 mod m is 1 and a mod m is not
# 1 or m-1 (think of this as 1 or -1), we know that m is
# composite.

# In fact, this allows an improvement of the code which I am making here.

# this code is a little stronger than the official Rabin Miller test,
# because if it finds a bad square root of 1 while computing even or odd
# powers at any stage of the computation it stops and reports
# compositeness.  The official form of the test only does this after
# computing the last odd power.

# also added check for gcd(b,m) =/= 1, which of course means m is composite

def rabinmiller(b,m):

    global noisy

    if m==2: return 'prime'
    if m%2 == 0: return 'composite'
    if not(gcd(b,m)==1):
        if noisy==True: print(str(b)+' has common factors')
        return 'composite'

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
        preresult = (result*result)%m
        if preresult==1 and not(result==1 or result==m-1):
            if noisy==True: print ('Found bad square root of 1')
            return 'composite'
        result = preresult
        if table[0]%2==1:
            result = (result*b)%m
        table2 = [[table[0],result]]+table2
        table=table[1:]
        if noisy == True: print(table2[0])

    # if m fails the Fermat test it is composite

    if noisy == True:print('\n')
    if noisy == True: print(table2[0])

    if not table2[0][1] == 1:  return 'composite'

    # this code commented out:  it is much simpler to
    # just check for bad square roots of 1 at every squaring step

    #if top exponent is even, strip it off.  If the
    # power found is -1, the number might be prime.
    
    #while table2[0][0]%2 == 0:
        #table2=table2[1:]
        #if noisy==True: print('\n')
        #if noisy == True:  print(table2[0])
        #if table2[0][1]==m-1:  return 'might be prime'

    # if the first power found with odd exponent is 1,
    # m might be prime.  Otherwise it is composite.

    #if not table2[0][1] == 1:  return 'composite'
    return 'might be prime'
    
# check for primality using fifty queries to the Rabin Miller test

# This function is quiet (noisy is set to false so it wont
# display tables);  it will just tell you, with overwhelming likelihood
# of correctness, whether m is prime.

# You can comment out the line noisy=False if you want to see what it does

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

# this finds the next odd prime after a number.  Try it out.

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

# we haven't talked about safe primes.  These are a little safer
# to use with RSA:  m is safe if it is odd, prime, and (m-1)/2 is also prime.

# find safe prime

def findsafeprime(m):
    if m%2 == 0 or m<2: m=m+1
    while(1==1):
        if isprime(m)and isprime((m-1)//2):return m
        m=m+2

# This implements the same table format for computing
# the gcd as a linear combination of its arguments that we
# have used.

# Try using the EEATable function to generate complete tables:
# compare with work by hand or with the spreadsheet.

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

# Compute a^{-1} mod m, modular multiplicative inverse

# this uses the extended Euclidean algorithm table just as we do.

# modinv(a,m) computes a^(-1) mod m, the reciprocal of a in mod m arithmetic

def modinv(a,m):
    if m<2:  return 'bad modulus'
    if a>=m or a<0:  return modinv(a%m,m)
    table=EEAtable(a,m)
    if table[0][0]==1:
       return table[0][2]%m
    return 'bad'

# RSA setup

# this function builds an RSA key, N = P*Q where
# P is the first prime after p, Q is the first prime after q,
# and exponent R the first number after the argument r
# which is relatively prime to N

# the third component is the decryption exponent

def makekey(p,q,r):
    P = findprime(p)
    Q = findprime(q)
    R=r
    phi = (P-1)*(Q-1)
    while(not(gcd(R,phi)==1)):
          R=R+1
    S=modinv(R,phi)
    return [P*Q,R,S]

# this function returns the RSA key in public form, just N and R

def makepublickey(p,q,r):
    return makekey(p,q,r)[0:2]

# make a sample key

#change the values P,Q,R to get a different key --
# the keys will be found as values of theRSAkey, theRSApubkey

P = 2793792749

Q = 3853485385

R = 438568436

theRSAkey = makekey(P,Q,R)

theRSApubkey = makepublickey(P,Q,R)

print('the RSA key is '+str(theRSAkey))





# encrypt and decrypt numbers using an RSA key

# the encrypt will work with either a public or a private
# version of the key

def encrypt(m,key):
    global noisy
    noisy=False
    output=modexp(m,key[1],key[0])
    noisy=True
    return output

# the decrypt will throw an error if you use just the public key

def decrypt(m,key):
    global noisy
    noisy=False
    output=modexp(m,key[2],key[0])
    noisy=True
    return output

# this shows the example of encrypting and decrypting 42
# using the example keys generated above

encrypt42 = encrypt(42,theRSAkey)

print('encrypting 42 gives '+str(encrypt(42,theRSAkey)))

print('decryption of '+ str(encrypt42) + ' gives '+ str(decrypt(encrypt42,theRSAkey)))



# convert a numeral to a string of lower case letters

def numeralize(s):
    if s=='': return 0
    return ord(s[-1])-ord('a')+11+100*numeralize(s[0:-1])

# convert a string of lower case letters to a number
# as we saw in class, it wont work even with spaces.  Just lower
# case letters.  I should soup this up!

def alphabetize(n):
    if n==0:  return ''
    return alphabetize(n//100)+chr(n%100-11+ord('a'))

# encryption and decryption of text (lower case letters, no spaces)/
# be careful that the message is shorter than N, as it were/

# If you want to try this out, make a very large key (use lots of
# digits for p and q in makekey) and then type a text message with
# nothing but lowercase letters (no spaces)

def textencrypt(s,key):
    global noisy
    return encrypt(numeralize(s),key)

def textdecrypt(n,key):
    global noisy
    return alphabetize(decrypt(n,key))

# Nothing beyond here is covered in Math 189 Fall 2022.

# look for three factor Carmichael numbers

# this one is strange, use the 6-12-18 one below.

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

# this finds the first n after the number you enter such
# that (6n+1)(12n+1)(18n+1) is a product of three primes and so a Carmichael number.

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

# this function does a full key setup using the first
# safe prime after n as its p

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

# Here is an example of setting up a key.  Change this
# number and run the file to get a key.

N = 2862738647

fullkey = EGkeysetup(N)

# the key it generates will be announced in output

print('the key is '+str(fullkey))

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




# square root algorithm

def modsqrt(n,p):
    if not(p%2==1 and isprime(p)):  return 'not odd prime'

    if (modexp(n,(p-1)//2,p)== p-1): return 'not a QR'

    S=0
    Q=p-1
    while(Q%2==0):
        S=S+1
        Q=Q//2

    print('S is '+str(S))
    print('Q is '+str(Q))

    z=2
    while(modexp(z,(p-1)//2,p)==1):
       z=z+1

    print('z is ',str(z))

    M=S
    c=modexp(z,Q,p)
    t=modexp(n,Q,p)
    R=modexp(n,(Q+1)//2,p)

    while(1==1):
        if (t==0): return 0
        if (t==1): return R
        i=0
        T=t
        while(not(T==1)):
            T=(T*T)%p
            i=i+1
        b=modexp(c,2**(M-i-1),p)
        M=i
        c=(b*b)%p
        t=(t*b*b)%p
        R=(R*b)%p

# from my lecture
    
def Modsqrt(x,p):

    if (not(isprime(p) and p%2 == 1)): return 'Not an odd prime modulus'

    if (not(modexp(x,(p-1)//2,p)==1)):  return 'Not a quadratic residue'

    q=p-1
    k=0

    while(q%2==0):
        k=k+1
        q=q//2

    z=2

    while(modexp(z,(p-1)//2,p)==1):
        z=z+1

    R= modexp(x,(q+1)//2,p)

    t= modexp(x,q,p)

    i=k-1
    y=0

    print('invariant check: '+str((R*R)%p)+' =? '+str((x*t)%p))
    print('invariant check (should be 1): '+str(modexp(t,2**i,p)))

    while(not(t==1)):

        print('invariant check (should be 1): '+str(modexp(t,2**i,p)))

        i=i-1

        
        input(y)

        if(modexp(t,2**i,p)==p-1):
            print('t = '+str(t)+' is a 2^'+str(i)+' root of -1, so b^2 should be too')
            b=modexp(z,q*(2**((k-1)-(i+1))),p)
            print('b is '+str(b))
            print('b test '+str(modexp(b*b,2**(i),p)))
            R=(R*b)%p
            print('R is '+str(R))
            t=(t*b*b)%p
            print('t is '+str(t))

            print('invariant check: '+str((R*R)%p)+' =? '+str((x*t)%p))
            

    return R
            
            
RSAprivatekey=makekey(45775497,48548958,389545)

RSApublickey=RSAprivatekey[0:2]

print('the RSA public key is '+str(RSApublickey))

#private key is [2222353104355463, 389549, 510706076662949]

# ELGprivatekey=EGkeysetup(9573497394)

ELGprivatekey = [9573497699, 3640286961, 1833913461, 1267702745]

ELGpublickey = [9573497699, 3640286961, 1833913461]



    
        


           
