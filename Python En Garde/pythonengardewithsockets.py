# Python implementation of En Garde

#  1/30/2023

# next work order:  reduce repeated text by creating functions.
#  create scoreboard so it can play a full match of 5 rounds.

# 1/30/2023, further update: modularized win handlers, probably
# ready to start setting up scoreboard.

# 1/31/2023 wee hours, played a complete match

# this seems to be a working version which will play single EG rounds.
# It will now play a full match!

# move notation is different, not based directly on hands played.

# all moves except flee will parry first, one can also parry as a move

#  aN  advance N
#  rN  retreat N (parry if needed)
#  fN  flee N (no parry, only legal if under attack)
#  AN  attack with strength N (1-3)
#  LMN  advance to distance N from opponent and lunge with strength M
#  p  parry (optional to do this as separate move except when it is last)

#  this notation can be used (quoted) as an argument to the play
#  function to make a move.  showboard() will show the state of the board.

# new interface() command allows one to just type move notation and hit
# return

# a board position consists of positions of the two players
# and a level of attack from 0 to 3 and which player is to move

import random

import socket
import pickle

conn1 = None

conn2 = None

def printq(s):
    s='\n'+s
    conn1.sendall(s.encode())
    conn2.sendall(s.encode())

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

scoreboard=[0,0]

thehands=[[0,0,0,0,0],[0,0,0,0,0]]

TheBoard = [1,23,0,1,0] #the actual state of the board


    

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

def initialize():
    global thedeck
    global TheBoard
    global thehands
    global startingplayer
    global scoreboard

    scoreboard =[0,0]
    
    thedeck = [5,10,15,20,25]

    thehands=[fillhand([0,0,0,0,0]),fillhand([0,0,0,0,0])]

    TheBoard = [1,23,0,1,0]

    startingplayer = 1

startingboard = [1,23,0,0,0] # starting board with no starting player specified

# smallest card in hand which does not have to be used to parry

# this function determines who wins except in attack or trapped situations

startingplayer=1

def newmatch(n):

    global TheBoard
    global thedeck
    global thehands
    global startingplayer
    global scoreboard
    if n>0: scoreboard[n-1]=scoreboard[n-1]+1
    if n>0 and scoreboard[n-1]==5:
        printq('Player '+str(n)+' wins the match!')
        return 0
    printq('New round starts')
    if n>0: startingplayer=3-n
    TheBoard=[1,23,0,0,0]
    TheBoard[3]=startingplayer
    thedeck[0]=5
    thedeck[1]=10
    thedeck[2]=15
    thedeck[3]=20
    thedeck[4]=25
    thehands=[fillhand([0,0,0,0,0]),fillhand([0,0,0,0,0])]
    showboard()

def whowon(fleeing):

    global TheBoard
    global thehands
    global thedeck
    global startingplayer


    # fleeing is set to True if the command being executed
    # is "flee" and there were no cards left before flight, false otherwise

    if TheBoard[2]>0: return 0 #attack to be resolved
    if thedeck[4]>0: return 0 #hands still left
    if not(fleeing) and TheBoard[1]-TheBoard[0]<=5:
        if thehands[0][TheBoard[1]-TheBoard[0]-1]>thehands[1][TheBoard[1]-TheBoard[0]-1]:
            showboard()
            printq('Player 1 wins by LSA')
            newmatch(1)
            return 1
        if thehands[1][TheBoard[1]-TheBoard[0]-1]>thehands[0][TheBoard[1]-TheBoard[0]-1]:
            showboard()
            printq('Player 2 wins by LSA')
            newmatch(2)
            return 2
        if  thehands[1][TheBoard[1]-TheBoard[0]-1]>0:
            printq('LSA attacks were tied')
    if TheBoard[0]-1>23-TheBoard[1]:
        showboard()
        printq('Player 1 wins on position')
        newmatch(1)
        return 1
    if 23-TheBoard[1]>TheBoard[0]-1:
        showboard()
        printq('Player 2 wins on position')
        newmatch(2)
        return 2
    showboard()
    printq('The round is a tie')
    newmatch(0)
    return 3

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

    if B[3]==1 and B[0]-smallestcard(thehands[0])<1 and B[0]+smallestcard(thehands[0]) >B[1]:
        showboard()
        printq("Player 1 is trapped:  Player 2 wins")
        newmatch(2)
        return True
    if B[3]==2 and B[1]+smallestcard(thehands[1])>24 and B[1]-smallestcard(thehands[1])<B[0]:
        showboard()
        printq("Player 2 is trapped:  Player 1 wins")
        newmatch(1)
        return True
    return False

# trapped after lunge, no need to parry if moving back

def trapped2():

    global TheBoard

    B=TheBoard

    if B[3]==1 and B[0]-smallestcard2(thehands[0])<1 and B[0]+smallestcard(thehands[0]) >B[1]:
        showboard()
        newmatch(2)
        printq("Player 1 is trapped:  Player 2 wins")
        return True

    if B[3]==2 and B[1]+smallestcard2(thehands[1])>24 and B[1]-smallestcard(thehands[1])<B[0]:
        showboard()
        newmatch(1)
        printq("Player 2 is trapped: Player 1 wins")
        return True
    return False
       

def makeamove(M):
    global thedeck
    global TheBoard
    global thehands

    B = TheBoard
    H = thehands[B[3]-1]

    # save hands and board to reset on error
    # could also be used to support history function
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

    if len(M)== 2 and M[0] == "advance" and B[3] == 1 and not(thedeck[4]==0):
        theboard=[B[0]+M[1],B[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if B[2]>0:
            printq ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[fillhand(thehand),thehands[1]]


            if whowon(False)==0:
              if trapped(): return 0
              showboard()
              printq("Player 1 advanced "+str(M[1]))
              return 'Player 1 advanced'
            return 0
        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move')
        return('bad move')

    if len(M)== 2 and M[0] == "advance" and B[3] == 2  and not(thedeck[4]==0):
        theboard=[B[0],B[1]-M[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if B[2]>0:
            printq ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[thehands[0],fillhand(thehand)]


            if whowon(False)==0:
              if trapped(): return 0
              showboard()
              printq('Player 2 advanced '+str(M[1]))
              return 'Player 2 advanced'
            return 0
        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move')
        return('bad move')

    if len(M)== 2 and M[0] == "retreat" and B[3] == 1 and not(thedeck[4]==0):
        theboard=[B[0]-M[1],B[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if B[2]>0:
            printq ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[fillhand(thehand),thehands[1]]


            if whowon(False)==0:
              if trapped(): return 0
              showboard()
              printq('Player 1 retreated '+str(M[1]))
              return 'Player 1 retreated'
            return 0

        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move')           
        return('bad move')

    if len(M)== 2 and M[0] == "retreat" and B[3] == 2 and not(thedeck[4]==0):
        theboard=[B[0],B[1]+M[1],0,3-B[3],0]
        thehand=H
        thehand[M[1]-1] = thehand[M[1]-1]-1
        if B[2]>0:
            printq ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[thehands[0],fillhand(thehand)]


            if whowon(False)==0:         
              if trapped(): return 0
              showboard()
              printq('Player 2 retreated '+str(M[1]))
              return 'Player 2 retreated'
            return 0
        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move') 
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


            if whowon(not(canlsa)) == 0:
              if trapped(): return 0
              showboard()
              printq('Player 1 fled '+str(M[1]))
              return 'Player 1 fled'
            return 0


        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move')
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

            if whowon(not(canlsa))==0:
              if trapped(): return 0
              showboard()
              printq( 'Player 2 fled '+str(M[1]))
              return 0
            return 0
        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move')
        return('bad move')
            

    if len(M)== 2 and M[0] == "attack" and not(thedeck[4]==0):
        if M[1]<1 or M[1]>3:
            TheBoard=saveboard
            thehands=savehands
            showboard()
            printq( 'bad move')
            return 0
        if B[1]-B[0]>5:

            TheBoard=saveboard
            thehands=savehands
            showboard()
            printq( 'bad move')
            return 0
        theboard=[B[0],B[1],M[1],3-B[3],0]
        thehand=H
        if B[2]>0:
            printq ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1] - M[1]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            if B[3]==2:thehands=[fillhand(thehand),thehands[1]]
            if B[3]==1:thehands=[thehands[0],fillhand(thehand)]
            if B[2]>thehands[B[3]-1][B[1]-B[0]-1] and B[3]==1:
                showboard()
                printq( "Player 2 wins by touch")
                newmatch(2)
                return 0
            if B[2]>thehands[B[3]-1][B[1]-B[0]-1] and B[3]==2:
                showboard()
                printq("Player 1 wins by touch")
                newmatch(1)
                return 0
            
            if trapped(): return 0
            showboard()
            printq( 'Player '+str(3-B[3])+' attacked from '+str(B[1]-B[0]))
            return 0

        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move')
    
        return 0

    if len(M) == 3 and M[0] == "lunge" and B[3]==1  and not(thedeck[4]==0):
        if M[1]<1 or M[1]>5:
            TheBoard=saveboard
            thehands=savehands
            showboard()
            printq('bad move')
            return 0
        if M[1]>=B[1]-B[0] or (B[1]-B[0])-M[1] >5:

            TheBoard=saveboard
            thehands=savehands
            showboard()
            printq('bad move')
            return 0
        moved = (B[1]-B[0])-M[1]
        theboard=[B[0]+moved,B[1],M[2],3-B[3],1]
        thehand=H
        if B[2]>0:
            printq ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        thehand[moved-1]=thehand[moved-1]-1
        thehand[M[1]-1]=thehand[M[1]-1]-M[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[fillhand(thehand),thehands[1]]
            if B[2]>thehands[B[3]-1][B[1]-B[0]-1] and B[1]+smallestcard2(thehands[1])>23:
                showboard()
                printq( "Player 1 wins by touch")
                newmatch(1)
                return 0
            if trapped2(): return 0
            showboard()
            printq( 'Player 1 advanced '+str(moved)+' and lunged from '+str(M[1])+' with strength '+str(M[2]))
            return 0
        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move')
        return 0
       
    if len(M) == 3 and M[0] == "lunge" and B[3]==2  and not(thedeck[4]==0):
        if M[1]<1 or M[1]>5:
            TheBoard=saveboard
            thehands=savehands
            showboard()
            printq('bad move')
            return 0
        if M[1]>=B[1]-B[0] or (B[1]-B[0])-M[1]>5:
            showboard()
            printq('bad move')
            return 0
        moved = (B[1]-B[0])-M[1]
        theboard=[B[0],B[1]-moved,M[2],3-B[3],1]
        thehand=H
        if B[2]>0:
            printq ("Parries the attack")
            thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        thehand[moved-1]=thehand[moved-1]-1
        thehand[M[1]-1]=thehand[M[1]-1]-M[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            thehands=[thehands[0],fillhand(thehand)]
            if B[2]>thehands[B[3]-1][B[1]-B[0]-1] and B[0]-smallestcard2(thehands[0])<1:
                showboard();
                printq( "Player 2 wins by touch")
                newmatch(2)
                return 0
            if trapped2():  return 0
            showboard()
            printq( 'Player 2 advanced '+str(moved)+' and lunged from '+str(M[1])+' with strength '+str(M[2]))
            return 0
        TheBoard=saveboard
        thehands=savehands
        showboard()
        printq('bad move')
        return 0

    if len(M) == 1 and M[0]=="parry":

        if not(B[2]>0):
            TheBoard=saveboard
            thehands=savehands
            showboard()
            printq('bad move')
            return 0
        theboard = [B[0],B[1],0,B[3],0]
        thehand=H
        printq ("Parries the attack")
        thehand[B[1]-B[0]-1]=thehand[B[1]-B[0]-1]-B[2]
        if isboard(theboard) and ishand(thehand):
            TheBoard=theboard
            B=theboard
            if B[3]==1:thehands=[(thehand),thehands[1]]
            if B[3]==2:thehands=[thehands[0],(thehand)]
            if whowon(False)==0:
              if trapped():  return 0
              showboard()
              printq("Player "+str(B[3])+ " parried")
              return 0
            return 0

        TheBoard=saveboard
        thehands=savehands
        showboard()    
        printq('bad move')
        return 0
    TheBoard=saveboard
    thehands=savehands
    showboard()
            
    printq('bad move')
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
    if B[3]==1:  printq ("Player 1 to play")
    if B[3]==2: printq ("Player 2 to play")
    conn1.sendall(('\n' + printhand(thehands[0])).encode())
    conn2.sendall(('\n' + printhand(thehands[1])).encode())
    display=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    display[B[0]-1]=1
    display[B[1]-1]=2
    printq(displayboard(display))
    printq('Player 1: '+str(scoreboard[0])+' ; Player 2: '+str(scoreboard[1]))
    printq('Distance to other player: '+str(B[1]-B[0]))
    printq('Cards remaining: '+str(thedeck[4]))
    if B[2]==1 and B[4]==0: printq('under single direct attack')
    if B[2]==2 and B[4]==0: printq('under double direct attack')
    if B[2]==3 and B[4]==0: printq('under triple direct attack') #shouldnt happen?    
    if B[2]==1 and B[4]==1: printq('under single indirect attack')
    if B[2]==2 and B[4]==1: printq('under double indirect attack')
    if B[2]==3 and B[4]==1: printq('under triple indirect attack')    
    printq(printmany("1",(5-thedeck[0]-thehands[0][0]-thehands[1][0])))
    printq(printmany("2",(5-thedeck[1]+thedeck[0]-thehands[0][1]-thehands[1][1])))
    printq(printmany("3",(5-thedeck[2]+thedeck[1]-thehands[0][2]-thehands[1][2])))
    printq(printmany("4",(5-thedeck[3]+thedeck[2]-thehands[0][3]-thehands[1][3])))
    printq(printmany("5",(5-thedeck[4]+thedeck[3]-thehands[0][4]-thehands[1][4])))

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

def actioncode(c):
    if c=='a':  return "advance"
    if c=='r':  return "retreat"
    if c=="f":  return "flee"
    if c=='A': return "attack"
    if c=="L":  return "lunge"
    if c=="p": return "parry"
    return "bogus"

def numcode(n):
    if n=='1':  return 1
    if n=='2':  return 2
    if n=='3':  return 3
    if n=='4':  return 4
    if n=='5':  return 5
    return 0

def decodemove(s):
    if len(s)==1: return [actioncode(s[0])]
    if len(s)==2: return [actioncode(s[0]),numcode(s[1])]
    if len(s)==3: return [actioncode(s[0]),numcode(s[1]),numcode(s[2])]
    return ["bogus"]

def play(s):
    if s[0]=='"':  printq('\nPlayer '+str(TheBoard[3])+ ":  "+s[1:])
                          
    if not(s[0]=='"'):  makeamove(decodemove(s))



def serverinterface():
    global TheBoard
    global thehands
    global thedeck
    global startingplayer
    global conn1
    global conn2

    initialize()
    
    hostname=socket.gethostname()   
    IPAddr=socket.gethostbyname(hostname)   
    print("Your Computer Name is:"+hostname)   
    print("Your Computer IP Address is:"+IPAddr)   


    HOST = ""  # Standard loopback interface address (localhost)
    PORT1 = 65433  # Port to listen on (non-privileged ports are > 1023)
    PORT2 = 65434
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s1:

      with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s2:  
         s1.bind((HOST, PORT1))
         s2.bind((HOST, PORT2))
         print('waiting for Godot 1')
         s1.listen()
       
         print('waiting for Godot 2')
         s2.listen()

         print('listen acceptingly.')
         conn1, addr1 = s1.accept()

         print('listen acceptingly again')
         conn2, addr2 = s2.accept()
         print('are we there yet?')
         with conn1:

          with conn2:   
            #print(f"Connected by {addr}")
            #while True:
            # data = conn1.recv(1024)
            #  if not data:
            #      break
            #  conn1.sendall(b"Bad Move")

            cline=b""
            dataBytes = b""
            firstpass=True
            while not(cline.decode()=='bye'):
               if firstpass==True: showboard()
               firstpass=False
               conn1.sendall(b"" + chr(4).encode())
               conn2.sendall(b"" + chr(4).encode())
               if TheBoard[3]==1:
                   conn1.sendall(b"Zork!" + chr(4).encode())
                   index = dataBytes.find(b"" + chr(4).encode())
                   while index == -1:
                       dataBytes = dataBytes + conn1.recv(1024)
                       index = dataBytes.find(b"" + chr(4).encode())
                   cline = dataBytes[0:index]
                   dataBytes = dataBytes[index+1:]
               if TheBoard[3]==2:
                   conn2.sendall(b"Zork!" + chr(4).encode())
                   index = dataBytes.find(b"" + chr(4).encode())
                   while index == -1:
                       dataBytes = dataBytes + conn2.recv(1024)
                       index = dataBytes.find(b"" + chr(4).encode())
                   cline = dataBytes[0:index]
                   dataBytes = dataBytes[index+1:]
               print(cline.decode())
               if not(cline.decode()=='bye'):play(cline.decode())

def clientinterface():
    print("enter the host's IP address")
    hostaddress = input()
    print("enter a port")
    portnumber = int(input())

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((hostaddress, portnumber))
        dataBytes = b""
        while True:
            
            index = dataBytes.find(b"" + chr(4).encode())
            while index == -1:
                dataBytes = dataBytes + s.recv(1024)
                index = dataBytes.find(b"" + chr(4).encode())
            data = dataBytes[0:index]
            dataBytes = dataBytes[index+1:]
            if data.decode() == "Zork!":
                print('Your turn!')
                cline=input()+chr(4)
                s.sendall(cline.encode())
            else:
                print(data.decode())

def interface():
    print ('You have challenged someone to a duel.  Are you (1) hosting the duel here or (2) fighting elsewhere?')
    s=input()
    if s == '1': serverinterface()
    if s == '2': clientinterface()

interface()
    

        
        




            
            
    
    
    

        


     

    

    
    
