import math
def double(x):
    return x+x;
    
def euclidstep(pair):

    if (pair[0]<pair[1]):
       return (euclidstep([pair[1],pair[0]]))
    if (pair[1]==0):
       return (pair)
    return [pair[1],pair[0] % pair[1]]

def euclid(m,n):

    p = euclidstep([m,n])
    print(p)
    if (p[1]==0):  return p[0]
    euclid(p[0],p[1])

def fancyeuclidstep(triple1,triple2):
    if (triple2[0]==0): return "bad"
    q = triple1[0]//triple2[0]
    newline = [triple1[0]-q*triple2[0],triple1[1]-q*triple2[1],triple1[2]-q*triple2[2]]
    if (not(newline[0]==0)):print (newline)
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

# this is not the smartest prime tester

def isprime(p):

    if (p<1): return "bad"
    divisorpaircount=0
    if(p==1):  return False
    productlist=[]
    n=1
    while( n**2 <= p):
        if (p%n == 0):
            divisorpaircount=divisorpaircount+1
            productlist=[[n,p//n]]+productlist
        n=n+1
    print (productlist)
    return (divisorpaircount == 1)

def isprimesilent(p):

    if (p<1): return "bad"
    if(p==1):return False
    divisorpaircount=0
    productlist=[]
    n=1
    while(divisorpaircount<2 and n**2 <= p):
        if (p%n == 0):
            divisorpaircount=divisorpaircount+1
            productlist=[[n,p//n]]+productlist
        n=n+1
    #print (productlist)
    return (divisorpaircount == 1)

# I investigated the question of the point after which pi(n) < n/5
# and got an answer

def primecount(n):
    if (n<1):  return "bad"
    count=0
    i=1
    while(i<=n):
        if isprimesilent(i):count = count+1
        i=i+1
    return count

def primesweep():

    i=1
    done=False
    runningcount=0
    thecount=0
    while(done==False):
        if (isprimesilent(i)):thecount = thecount+1
        if (thecount <= i//5):  runningcount=runningcount+1
        if (thecount >= i//5): runningcount=0
        if (runningcount >= 30030):done=True
        i=i+1
    return [i-runningcount,runningcount]

def primereport(n):
    i=1
    thecount=0
    while(True):
        if (isprimesilent(i)): thecount=thecount+1
        if (thecount>i//n):print([i,thecount])
        i=i+1

def primescan(r):

    i=1
    ratio=1
    while(ratio>r):
        i=i+1
        if (isprimesilent(i)): ratio = ratio*(1-1/i)
        print([i,ratio])
        
    print([i,ratio])
    return i

def isitlog(n):

    i = 1
    prod = 1
    while(i^2<=n):
        if isprimesilent(i):prod=prod*(1-1/i)
        i=i+1
    print(prod)
    print((primecount(n+math.ceil(n**.5))-primecount(n))/((n**0.5)))
    return(prod)

# determine whether d can be expressed as a linear combination
# with nonnegative indices of a,b,c

def frobenius3(a,b,c,d):

   x=0
   y=0
   z=0
   t=False
   while (a*x <= d):
       #print([x,y,z])
       while ((a*x)+(b*y) <= d):
           #print([x,y,z])
           while(a*x+b*y+c*z <= d):
               #print([x,y,z])
               if (a*x)+(b*y)+(c*z) == d:
                   print([a,x,b,y,c,z,d])
                   t=True

               z=z+1
           z=0
           y=y+1
       y=0
       x=x+1
   return t

def frobenius3b(a,b,c,d,a2,b2,c2,d2):

   x=0
   y=0
   z=0
   t=False
   while (a*x <= d):
       #print([x,y,z])
       while ((a*x)+(b*y) <= d):
           #print([x,y,z])
           while(a*x+b*y+c*z <= d):
               #print([x,y,z])
               if ((a*x)+(b*y)+(c*z) == d
                   and a2*x+b2*y+c2*z==d2) :
                   print([a,x,b,y,c,z,d])
                   t=True

               z=z+1
           z=0
           y=y+1
       y=0
       x=x+1
   return t

def Frobenius3(a,b,c):
    dd=0
    count = 0
    while(dd<(a+b)*(c-1)):
        if not(frobenius3(a,b,c,dd)):
            print([dd])
            count=count+1
        dd=dd+1
    return count

        
def Ltest():
    x=0
    while(x<=1000):
       y=((x**2+1)/2)**.25
       if (x**2-2*(math.floor(y))**4== -1):print([x,math.floor(y)])
       x=x+1

    
