# implementing base p arithmetic as a way to handle big integers

# Euclidean algorithm and modular inverses

def fancyeuclidstep(triple1,triple2):
    if (triple2[0]==0): return "bad"
    q = triple1[0]//triple2[0]
    newline = [triple1[0]-q*triple2[0],triple1[1]-q*triple2[1],triple1[2]-q*triple2[2]]
    #if (not(newline[0]==0)):print (newline)
    return newline

def fancyeuclid(m,n):
    done = False
    line1 = [m,1,0]
    line2 = [n,0,1]
    while (done == False):
       
       nextline = fancyeuclidstep(line1,line2)
       if (nextline[0]==0): done = True
       if (not(nextline[0]==0)):
           line1 = line2
           line2=nextline
    return line2

def modinv(m,n):
    computation = fancyeuclid(m,n)
    if (not(computation[0]==1)):  return "bad"
    return computation[1]%n

# two representations of numbers interact:  represent a number
# n by a sequence N in which N[i] = n mod primes[i] (base P) and also
# by a sequence  N2 such that n is the sum of N[i]
# multiplied by the first i primes (base p).

primes = [2,3,5,7,11,13,17,19,23,29]  # this will be updated as computations are carried out

placevalues = []

# converts base p to ordinary Python integers
# should not be used for very large numbers

def convert1(s):
   global primes
   global placevalues
   i=0
   val = 0
   placevalue=1
   while (i<len(s)):
       val = s[i]*placevalue + val
       placevalue = primes[i]*placevalue
       if i>= len(placevalues):  placevalues=placevalues+[placevalue]
       placevalues[i]=placevalue
       i=i+1
   return val

convert1(primes)

# convert a small integer to base p

def convert2(s):
    global primes
    global placevalues
    S=s
    i=0
    val=[]
    while (S>0):
        val = val+[S%primes[i]]
        S = (S-val[i])//primes[i]
        i=i+1
    return val

# convert a small integer to base P

def convert3(s):
    global primes
    i=0
    val=[]
    while(i<len(primes)):
        val = val+[s%primes[i]]
        i=i+1
    return val

# build the conversion lists for taking base p to base P
# and back

conversions = []

def buildconversions():
 global conversions
 i=0
 list=[]
 while (i<len(primes)):
   j=0
   list2=[[1,1]]
   partial=1
   while (j < i):
      partial=(partial*primes[j])%primes[i]
      partial2=modinv(partial,primes[i])
      list2=list2+[[partial,partial2]]
      j=j+1
   list=list+[list2]
   i=i+1
 conversions = list
 #print(conversions)

buildconversions()

# convert base p to base P
def convert5(s):
  global primes
  global conversions
  i=0
  val = []
  while(i < len(s)):
    j=0
    partialsum=0
    while(j < i):
        partialsum=(partialsum+(val[j]*conversions[i][j][0])%primes[i])
        j=j+1
    entry = ((s[i]-partialsum)*conversions[i][i][1])%primes[i]
    val = val + [entry]
    i=i+1
  while(val[len(val)-1]==0):
        val=val[0:len(val)-1]
  return val

# convert base P to base p

def convert6(s):
    S=s
    global primes
    global conversions
    i=0
    val = []
    while(i<len(primes)):
        j=0
        partial=0
        while (j <= i):
            partial=(partial+conversions[i][j][0]*S[j])%primes[i]
            j=j+1
        val = val + [partial]
        i=i+1
        if (i == len(S)): S=S+[0]

    return val
        
        
def addp(L,M):
    global primes
    if not(len(L)==len(M)):  return 'bad'
    i=0
    sum=[]
    while(i<len(L)):
        sum=sum+[(L[i]+M[i])%primes[i]]
        i=i+1
    return sum

def multp(L,M):
    global primes
    if not(len(L)==len(M)):  return 'bad'
    i=0
    prod=[]
    while(i<len(L)):
        prod=prod+[(L[i]*M[i])%primes[i]]
        i=i+1
    return prod

def extendprimes(n):
  global primes
  global conversions
  global placevalues
  i=0
  while(i<n):  
    A=convert3(primes[len(primes)-1])
    B=addp(A,convert3(2))
    j=2
    while(0 in B):
        B=addp(B,convert3(2))
        j=j+2
    primes=primes+[primes[len(primes)-1]+j]
    buildconversions()
    i=i+1

def addP(L,M):
    if len(primes)<max(len(L),len(M))+1:  extendprimes((max(len(L),len(M))+1)-len(primes))
    return convert5(addp(convert6(L),convert6(M)))

def multP(L,M):
    if len(primes)<len(L)+len(M): extendprimes(len(L)+len(M)-len(primes))
    return convert5(multp(convert6(L),convert6(M)))

   
        

