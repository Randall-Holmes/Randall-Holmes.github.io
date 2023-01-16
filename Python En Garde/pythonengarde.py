# Python implementation of En Garde

# a board position consists of positions of the two players
# and a level of attack from -3 to 3 (the sign indicates
# which player is attacking)

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

def ishand(H):
    if not(len(H)==5):  return False
    i=0
    sum=0
    while(i<5):
        if H[i]<0:  return False
        if H[i]>5: return False
        sum=sum+H[i]
    if sum>5: return False
        

def makemove(M,B,H):

    if not isboard(B):  return 'board input is not a board'

    if len(M)== 2 and M[0] == "advance" and B[3] == 1:
        theboard=[B[0]+M[1],B[1],0,3-B[3]]
        thehand[M[1]] = thehand[M[1]]-1
        thehand[B[1]-B[0]]=thehand[B[1]-B[0]]-B[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M)== 2 and M[0] == "advance" and B[3] == 2:
        theboard=[B[0],B[1]-M[1],0,3-B[3]]
        thehand[M[1]] = thehand[M[1]]-1
        thehand[B[1]-B[0]]=thehand[B[1]-B[0]]-B[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M)== 2 and M[0] == "retreat" and B[3] == 1:
        theboard=[B[0]-M[1],B[1],0,3-B[3]]
        thehand[M[1]] = thehand[M[1]]-1
        thehand[B[1]-B[0]]=thehand[B[1]-B[0]]-B[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M)== 2 and M[0] == "retreat" and B[3] == 2:
        theboard=[B[0],B[1]+M[1],0,3-B[3]]
        thehand[M[1]] = thehand[M[1]]-1
        thehand[B[1]-B[0]]=thehand[B[1]-B[0]]-B[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M)== 2 and M[0] == "flee" and B[3] == 1:
        theboard=[B[0]-M[1],B[1],0,3-B[3]]
        thehand[M[1]] = thehand[M[1]]-1
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')


    if len(M)== 2 and M[0] == "flee" and B[3] == 2:
        theboard=[B[0],B[1]+M[1],0,3-B[3]]
        thehand[M[1]] = thehand[M[1]]-1
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')
            

    if len(M)== 2 and M[0] == "attack":
        if M[1]<1 or M[1]>3: return 'bad move'
        theboard=[B[0],B[1],M[1],3-B[3]]
        thehand[B[1]-B[0]]=thehand[B[1]-B[0]] - M[1]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')

    if len(M) == 3 and M[0] == "lunge" and B[3]==1:
        if M[1]<1: return('bad move')
        if M[1]>=B[1]-B[0]: return('bad move')
        moved = (B[1]-B[0])-M[1]
        theboard=[B[0]+moved,B[1],M[2],3-B[3]]
        thehand[moved]=thehand[moved]-1
        thehand[M[1]]=thehand[M[1]]-M[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')
       
    if len(M) == 3 and M[0] == "lunge" and B[3]==2:
        if M[1]<1: return('bad move')
        if M[1]>=B[1]-B[0]: return('bad move')
        moved = (B[1]-B[0])-M[1]
        theboard=[B[0],B[1]-moved,M[2],3-B[3]]
        thehand[moved]=thehand[moved]-1
        thehand[M[1]]=thehand[M[1]]-M[2]
        if isboard(theboard) and ishand(thehand):  return([theboard,thehand])
        return('bad move')
    
    

        


     

    

    
    
