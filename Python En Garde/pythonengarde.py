# Python implementation of En Garde

# a board position consists of positions of the two players
# and a level of attack from -3 to 3 (the sign indicates
# which player is attacking) and which player is to move

import random

def isboard(B):

    #a board is a list of integers, position of player 1,
    # position of player 2, positions being
    # integers from 1 to 23, then a degree of attack
    # (none, single double or triple),
    # then the player to move, then whether one can flee

    if not len(B)==5: return False
    if not B[0]>=1: return False
    if not B[1]>B[0]: return False
    if not 23>=B[1]: return False
    if B[1]-B[0]>5 and not(B[2]==0): return False
    if B[2]>3 or B[2]<0:  return False
    if B[3]<1 or B[3]>2: return False
    if B[4]<0 or B[4]>1 or (B[2]==0 and B[4]==1):  return False
    return True

# a hand is simply a list of length 5 in which
# position i says how many i+1 cards there are

def ishand(H):
    if not(len(H)==5):  return False
    i=0
    sum=0
    while(i<5):
        if H[i]<0:return False
        sum=sum+H[i]
        i=i+1
    if sum>5: return False
    return True
        
def printhand(H):
    if not(ishand(H)):
        print("cant print non-hand")
        return "xxxx"
    i=0
    s=""
    H0=[0,0,0,0,0]
    while(i<5):
        H0[i]=H[i]
        i=i+1
    while len(H0)>0:
        if H0[0]>0:
            s=s+str(6-len(H0))
            H0[0]=H0[0]-1
        if H0[0]==0:
            H0=H0[1:]
        
    return s
        
        


# position i in the deck representation is the number of cards
# of rank <= 1+1 in the deck.

thedeck = [5,10,15,20,25]

def isdeck(D):
    if not(len(D)==5):  return False
    if D[0]<0 or D[0]>5:  return False
    i=1
    while(i<5):
        if D[i]-D[i-1]<0 or D[i]-D[i-1]>5:  return False
        i=i+1
    return True

def drawfrom(D):
    if not(isdeck(D)):  return 'drawing from a non-deck'
    if D[4]==0:  return 'Cannot draw from an empty deck'
    i = random.randint(0,D[4]-1) # position of the card drawn
    j=0
    newdeck=D
    while(j<5):
        if i<D[j]:
            k=j
            while(k<5):
                newdeck[k]=newdeck[k]-1
                k=k+1
            return [j+1,newdeck]
        j=j+1

def fillhand(H):
    if not(ishand(H)):  return 'Cannot fill non-hand'
    thehand=H
    while(H[0]+H[1]+H[2]+H[3]+H[4]<5 and thedeck[4]>0):
        i=drawfrom(thedeck)[0]
        thehand[i-1]=thehand[i-1]+1
    return thehand

thehands=[fillhand([0,0,0,0,0]),fillhand([0,0,0,0,0])]

TheBoard = [1,23,0,1,0] #the actual state of the board

# smallest card in hand which does not have to be used to parry

def smallestcard(H):

    B=TheBoard
    if not(ishand(H)):  return "not a hand"
    j=0
    while (j<5):
        if j+1 == B[1]-B[0] and H[j]-B[2]>0: return j+1
        if not (j+1 == B[1]-B[0]) and H[j]>0:  return j+1
        j=j+1
    return 0 # this should not happen

#smallest card without needing to parry

def smallestcard2(H):

    B=TheBoard
    if not(ishand(H)):  return "not a hand"
    j=0
    while (j<5):
        if H[j]>0:  return j+1
        j=j+1
    return 0 # this should not happen

# trapped after non-lunge, either no attack level or take parry into account

def trapped():

    global TheBoard

    B=TheBoard

    if B[3]==1:
        return B[0]-smallestcard(thehands[0])<1 and B[0]+smallestcard(thehands[0]) >B[1]
    if B[3]==2:
        return B[1]+smallestcard(thehands[1])>24 and B[1]-smallestcard(thehands[1])<B[0]

# trapped after lunge, no need to parry if moving back

def trapped2():

    global TheBoard

    B=TheBoard

    if B[3]==1:
        return B[0]-smallestcard2(thehands[0])<1 and B[0]+smallestcard(thehands[0]) >B[1]
    if B[3]==2:
        return B[1]+smallestcard2(thehands[1])>24 and B[1]-smallestcard(thehands[1])<B[0]
       

def makeamove(M):
    global thedeck
    global TheBoard
    global thehands

    B = TheBoard
    H = thehands[B[3]-1]
    savehands=[[0,0,0,0,0],[0,0,0,0,0]]
    jj=0
    while(jj<5):
        savehands[0][jj]=thehands[0][jj]
        savehands[1][jj]=thehands[1][jj]
        jj=jj+1
    saveboard=[0,0,0,0,0]
    kk=0
    while(kk<5):
        saveboard[kk]=TheBoard[kk]
        kk=kk+1

    if not isboard(B):  return 'board input is not a board'

    showboard()

    if len(M)== 2 and M[0] == "advance" and B[3] == 1 and not(thedeck[4]==0):
        theboard=[B[0]+M[1],B[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if B[2]>0:
            print ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[fillhand(thehand),thehands[1]]

            if thedeck[4]==0:
               if B[thehands[0][B[1]-B[0]-1]]> B[thehands[1][B[1]-B[0]-1]]:
                    print("Player 1 wins by LSA")
                    return "Player 1 wins by LSA"
               if B[thehands[1][B[1]-B[0]-1]]> B[thehands[0][B[1]-B[0]-1]]:
                    print("Player 2 wins by LSA")
                    return "Player 2 wins by LSA"

               if B[0]>24-B[1]:
                   print("Player 1 wins")
                   return "Player 1 wins"
               if B[0]<24-B[1]:
                   print("Player 2 wins")
                   return "Player 2 wins"
               if B[0]==24-B[1]:
                   print("Its a tie!")
                   return "Its a tie!"

            if trapped():
                print("Player 2 is trapped:  Player 1 wins")
                return "Player 2 is trapped:  Player 1 wins"
            showboard()
            print("Player 1 advanced")
            return 'Player 1 advanced'
        TheBoard=saveboard
        thehands=savehands
        print('bad move')
        return('bad move')

    if len(M)== 2 and M[0] == "advance" and B[3] == 2  and not(thedeck[4]==0):
        theboard=[B[0],B[1]-M[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if B[2]>0:
            print ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[thehands[0],fillhand(thehand)]

            if thedeck[4]==0:
               if B[thehands[0][B[1]-B[0]-1]]> B[thehands[1][B[1]-B[0]-1]]:
                    print("Player 1 wins by LSA")
                    return "Player 1 wins by LSA"
               if B[thehands[1][B[1]-B[0]-1]]> B[thehands[0][B[1]-B[0]-1]]:
                    print("Player 2 wins by LSA")
                    return "Player 2 wins by LSA"


               if B[0]>24-B[1]:
                   print("Player 1 wins")
                   return "Player 1 wins"
               if B[0]<24-B[1]:
                   print("Player 2 wins")
                   return "Player 2 wins"
               if B[0]==24-B[1]:
                   print("Its a tie!")
                   return "Its a tie!"
            
            if trapped():
                print("Player 1 is trapped:  Player 2 wins")
                return "Player 1 is trapped:  Player 2 wins"
            showboard()
            print('Player 2 advanced')
            return 'Player 2 advanced'
        TheBoard=saveboard
        thehands=savehands
        print('bad move')
        return('bad move')

    if len(M)== 2 and M[0] == "retreat" and B[3] == 1 and not(thedeck[4]==0):
        theboard=[B[0]-M[1],B[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if B[2]>0:
            print ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[fillhand(thehand),thehands[1]]

            if thedeck[4]==0:

               if B[thehands[0][B[1]-B[0]-1]]> B[thehands[1][B[1]-B[0]-1]]:
                    print("Player 1 wins by LSA")
                    return "Player 1 wins by LSA"
               if B[thehands[1][B[1]-B[0]-1]]> B[thehands[0][B[1]-B[0]-1]]:
                    print("Player 2 wins by LSA")
                    return "Player 2 wins by LSA"


               if B[0]>24-B[1]:
                   print("Player 1 wins")
                   return "Player 1 wins"
               if B[0]<24-B[1]:
                   print("Player 2 wins")
                   return "Player 2 wins"
               if B[0]==24-B[1]:
                   print("Its a tie!")
                   return "Its a tie!"
     
            if trapped():
                print("Player 2 is trapped; Player 1 wins")
                return "Player 2 is trapped:  Player 1 wins"
            showboard()
            return 'Player 1 retreated'

        TheBoard=saveboard
        thehands=savehands
        print('bad move')           
        return('bad move')

    if len(M)== 2 and M[0] == "retreat" and B[3] == 2 and not(thedeck[4]==0):
        theboard=[B[0],B[1]+M[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if B[2]>0:
            print ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[thehands[0],fillhand(thehand)]


            if thedeck[4]==0:
               if B[thehands[0][B[1]-B[0]-1]]> B[thehands[1][B[1]-B[0]-1]]:
                    print("Player 1 wins by LSA")
                    return "Player 1 wins by LSA"
               if B[thehands[1][B[1]-B[0]-1]]> B[thehands[0][B[1]-B[0]-1]]:
                    print("Player 2 wins by LSA")
                    return "Player 2 wins by LSA"

               if B[0]>24-B[1]:
                   print("Player 1 wins")
                   return "Player 1 wins"
               if B[0]<24-B[1]:
                   print("Player 2 wins")
                   return "Player 2 wins"
               if B[0]==24-B[1]:
                   print("Its a tie!")
                   return "Its a tie!"            
            if trapped():
                print("Player 1 is trapped:  Player 2 wins")
                return "Player 1 is trapped:  Player 2 wins"
            showboard()
            print('Player 2 retreated')
            return 'Player 2 retreated'
        TheBoard=saveboard
        thehands=savehands
        print('bad move') 
        return('bad move')

    if len(M)== 2 and M[0] == "flee" and B[3] == 1 and B[4]==1:
        canlsa = not(thedeck[4]==0)
        theboard=[B[0]-M[1],B[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[fillhand(thehand),thehands[1]]

            if thedeck[4]==0:
                if canlsa==True and B[thehands[0][B[1]-B[0]-1]]> B[thehands[1][B[1]-B[0]-1]]:
                    print("Player 1 wins by LSA")
                    return "Player 1 wins by LSA"
                if canlsa==True and B[thehands[1][B[1]-B[0]-1]]> B[thehands[0][B[1]-B[0]-1]]:
                    print("Player 2 wins by LSA")
                    return "Player 2 wins by LSA"

                if B[0]>24-B[1]:
                    print("Player 1 wins")
                    return "Player 1 wins"
                if B[0]<24-B[1]:
                    print("Player 2 wins")
                    return "Player 2 wins"
                if B[0]==24-B[1]:
                    print("It's a tie!")
                    return "Its a tie!"

            if trapped():
                print("Player 2 is trapped:  Player 1 wins")
                return "Player 2 is trapped:  Player 1 wins"
            showboard()
            print('Player 1 fled')
            return 'Player 1 fled'


        TheBoard=saveboard
        thehands=savehands
        print('bad move')
        return('bad move')


    if len(M)== 2 and M[0] == "flee" and B[3] == 2 and B[4]==1:
        canlsa = not(thedeck[4]==0)
        theboard=[B[0],B[1]+M[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[thehands[0],fillhand(thehand)]

            if thedeck[4]==0:

                if canlsa==True and B[thehands[0][B[1]-B[0]-1]]> B[thehands[1][B[1]-B[0]-1]]:
                    print("Player 1 wins by LSA")
                    return 0
                if canlsa==True and B[thehands[1][B[1]-B[0]-1]]> B[thehands[0][B[1]-B[0]-1]]:
                    print( "Player 2 wins by LSA")
                    return 0

                if B[0]>24-B[1]:
                    print("Player 1 wins")
                    return 0
                if B[0]<24-B[1]:
                    print( "Player 2 wins")
                    return 0
                if B[0]==24-B[1]:
                    print("Its a tie!")
                    return 0
            if trapped():
                print("Player 1 is trapped:  Player 2 wins")
                return 0
            showboard()
            print( 'Player 2 fled')
            return 0
        TheBoard=saveboard
        thehands=savehands            
        return('bad move')
            

    if len(M)== 2 and M[0] == "attack" and not(thedeck[4]==0):
        if M[1]<1 or M[1]>3:
            TheBoard=saveboard
            thehands=savehands
            print( 'bad move')
            return 0
        if B[1]-B[0]>5:

            TheBoard=saveboard
            thehands=savehands
            print( 'bad move')
            return 0
        theboard=[B[0],B[1],M[1],3-B[3],0]
        thehand=H
        if B[2]>0:
            print ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1] - M[1]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            if B[3]==2:thehands=[fillhand(thehand),thehands[1]]
            if B[3]==1:thehands=[thehands[0],fillhand(thehand)]
            if B[2]>thehands[B[3]-1][B[1]-B[0]-1] and B[3]==1:
                print( "Player 2 wins")
                return 0
            if B[2]>thehands[B[3]-1][B[1]-B[0]-1] and B[3]==2:
                print("Player 1 wins")
                return 0
            
            if B[3]==1 and trapped():

                print( "Player 1 is trapped:  Player 2 wins")
                return 0
            if B[3]==2 and trapped():

                print( "Player 2 is trapped:  Player 1 wins")
                return 0
            showboard()
            print( 'The player attacked')
            return 0

        TheBoard=saveboard
        thehands=savehands
        print('bad move')
    
        return 0

    if len(M) == 3 and M[0] == "lunge" and B[3]==1  and not(thedeck[4]==0):
        if M[1]<1 or M[1]>5:
            TheBoard=saveboard
            thehands=savehands

            print('bad move')
            return 0
        if M[1]>=B[1]-B[0] or (B[1]-B[0])-M[1] >5:

            TheBoard=saveboard
            thehands=savehands

            print('bad move')
            return 0
        moved = (B[1]-B[0])-M[1]
        theboard=[B[0]+moved,B[1],M[2],3-B[3],1]
        thehand=H
        if B[2]>0:
            print ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        thehand[moved-1]=thehand[moved-1]-1
        thehand[M[1]-1]=thehand[M[1]-1]-M[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[fillhand(thehand),thehands[1]]
            if B[2]>thehands[B[3]-1][B[1]-B[0]-1] and B[1]+smallestcard2(thehands[1])>23:
                print( "Player 1 wins")
                return 0
            if trapped2():
                print( "Player 2 is trapped:  Player 1 wins")
                return 0
            showboard()
            print( 'Player 1 lunged')
            return 0
        TheBoard=saveboard
        thehands=savehands
            
        print('bad move')
        return 0
       
    if len(M) == 3 and M[0] == "lunge" and B[3]==2  and not(thedeck[4]==0):
        if M[1]<1 or M[1]>5:
            TheBoard=saveboard
            thehands=savehands

            print('bad move')
            return 0
        if M[1]>=B[1]-B[0] or (B[1]-B[0])-M[1]>5:
            print('bad move')
            return 0
        moved = (B[1]-B[0])-M[1]
        theboard=[B[0],B[1]-moved,M[2],3-B[3],1]
        thehand=H
        if B[2]>0:
            print ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        thehand[moved-1]=thehand[moved-1]-1
        thehand[M[1]-1]=thehand[M[1]-1]-M[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[thehands[0],fillhand(thehand)]
            if B[2]>thehands[B[3]-1][B[1]-B[0]-1] and B[0]-smallestcard2(thehands[0])<1:
                print( "Player 2 wins")
                return 0
            if trapped2():
                print( "Player 1 is trapped:  Player 2 wins")
                return 0
            showboard()
            print( 'Player 2 lunged')
            return 0
        TheBoard=saveboard
        thehands=savehands            
        print('bad move')
        return 0

    if len(M) == 1 and M[0]=="parry":

        if not(B[2]>0):
            TheBoard=saveboard
            thehands=savehands

            print('bad move')
            return 0
        theboard = [B[0],B[1],0,B[3],0]
        thehand=H
        print ("Parries the attack")
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            if B[3]==1:thehands=[(thehand),thehands[1]]
            if B[3]==2:thehands=[thehands[0],(thehand)]
            if thedeck[4]==0:
               
               if B[thehands[0][B[1]-B[0]-1]]> B[thehands[1][B[1]-B[0]-1]]:
                    print( "Player 1 wins by LSA")
                    return 0
               if B[thehands[1][B[1]-B[0]-1]]> B[thehands[0][B[1]-B[0]-1]]:
                    print( "Player 2 wins by LSA")
                    return 0

               if B[0]>24-B[1]:
                   print( "Player 1 wins")
                   return 0
               if B[0]<24-B[1]:
                   print("Player 2 wins")
                   return 0
               if B[0]==24-B[1]:
                   print("Its a tie!")
                   return 0
            showboard()
            print("The player parried")
            return 0

        TheBoard=saveboard
        thehands=savehands
            
        print('bad move')
        return 0
    TheBoard=saveboard
    thehands=savehands
    showboard()
            
    print('bad move')
    return 0

def displayboard(L):
    i=0
    s=""
    while i<len(L):
        if L[i]==0: s= s+"."
        if L[i]==2: s= s+"\\"
        if L[i]==1: s= s+"/"
        i=i+1
    return s

def printmany(s,n):
    s2=""
    while(n>0):
        s2=s+s2
        n=n-1
    return(s2)

def showboard():
    global TheBoard
    B=TheBoard
    if B[3]==1:  print ("Player 1 to play")
    if B[3]==2: print ("Player 2 to play")
    print (printhand(thehands[B[3]-1]))
    display=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    display[B[0]-1]=1
    display[B[1]-1]=2
    print(displayboard(display))
    print('Distance to other player: '+str(B[1]-B[0]))
    print('Cards remaining: '+str(thedeck[4]))
    if B[2]==1 and B[4]==0: print('under single direct attack')
    if B[2]==2 and B[4]==0: print('under double direct attack')
    if B[2]==3 and B[4]==0: print('under triple direct attack') #shouldnt happen?    
    if B[2]==1 and B[4]==1: print('under single indirect attack')
    if B[2]==2 and B[4]==1: print('under double indirect attack')
    if B[2]==3 and B[4]==1: print('under triple indirect attack')    
    print(printmany("1",(5-thedeck[0]-thehands[0][0]-thehands[1][0])))
    print(printmany("2",(5-thedeck[1]+thedeck[0]-thehands[0][1]-thehands[1][1])))
    print(printmany("3",(5-thedeck[2]+thedeck[1]-thehands[0][2]-thehands[1][2])))
    print(printmany("4",(5-thedeck[3]+thedeck[2]-thehands[0][3]-thehands[1][3])))
    print(printmany("5",(5-thedeck[4]+thedeck[3]-thehands[0][4]-thehands[1][4])))

def advance(n):
    makeamove(["advance",n])
def retreat(n):
    makeamove(["retreat",n])

def attack(n):
    makeamove(["attack",n])

def lunge(m,n):
    makeamove(["lunge",m,n])

def parry():
    makeamove(["parry"])

def flee(n):
    makeamove(["flee",n])

showboard()
    

        
        




            
            
    
    
    

        


     

    

    
    
