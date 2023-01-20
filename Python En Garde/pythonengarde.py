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
    # then the player to move

    if not len(B)==4: return False
    if not B[0]>=1: return False
    if not B[1]>B[0]: return False
    if not 23>=B[1]: return False
    if B[1]-B[0]>5 and not(B[2]==0): return False
    if B[2]>3 or B[2]<0:  return False
    if B[3]<1 or B[3]>2: return False
    return True

# a hand is simply a list of length 5 in which
# position i says how many i+1 cards there are

def ishand(H):
    if not(len(H)==5):  return False
    i=0
    sum=0
    while(i<5):
        if i<0:return False
        sum=sum+H[i]
        i=i+1
    if sum>5: return False
    return True
        

def makemove(M,B,H):

    if not isboard(B):  return 'board input is not a board'

    if len(M)== 2 and M[0] == "advance" and B[3] == 1:
        theboard=[B[0]+M[1],B[1],0,3-B[3]]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M)== 2 and M[0] == "advance" and B[3] == 2:
        theboard=[B[0],B[1]-M[1],0,3-B[3]]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M)== 2 and M[0] == "retreat" and B[3] == 1:
        theboard=[B[0]-M[1],B[1],0,3-B[3]]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M)== 2 and M[0] == "retreat" and B[3] == 2:
        theboard=[B[0],B[1]+M[1],0,3-B[3]]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M)== 2 and M[0] == "flee" and B[3] == 1:
        theboard=[B[0]-M[1],B[1],0,3-B[3]]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')


    if len(M)== 2 and M[0] == "flee" and B[3] == 2:
        theboard=[B[0],B[1]+M[1],0,3-B[3]]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')
            

    if len(M)== 2 and M[0] == "attack":
        if M[1]<1 or M[1]>3: return 'bad move'
        if B[1]-B[0]>5:return 'bad move'
        theboard=[B[0],B[1],M[1],3-B[3]]
        thehand=H
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1] - M[1]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M) == 3 and M[0] == "lunge" and B[3]==1:
        if M[1]<1 or M[1]>5: return('bad move')
        if M[1]>=B[1]-B[0] or (B[1]-B[0])-M[1] >5: return('bad move')
        moved = (B[1]-B[0])-M[1]
        theboard=[B[0]+moved,B[1],M[2],3-B[3]]
        thehand=H
        thehand[moved-1]=thehand[moved-1]-1
        thehand[M[1]-1]=thehand[M[1]-1]-M[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')
       
    if len(M) == 3 and M[0] == "lunge" and B[3]==2:
        if M[1]<1 or M[1]>5: return('bad move')
        if M[1]>=B[1]-B[0] or (B[1]-B[0])-M[1]>5: return('bad move')
        moved = (B[1]-B[0])-M[1]
        theboard=[B[0],B[1]-moved,M[2],3-B[3]]
        thehand=H
        thehand[moved-1]=thehand[moved-1]-1
        thehand[M[1]-1]=thehand[M[1]-1]-M[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

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

TheBoard = [1,23,0,1] #the actual state of the board
    
        
        




            
            
    
    
    

        


     

    

    
    
