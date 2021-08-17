
# recent updates

# 2/7/2016  fixed trailing spaces issue once and for all.  Repaired the technical rule
# JunctureFix in a way that no one may ever notice.   Made ne, tori mean the expected thing.
# also fixed silliness with syllabic consonants no one would be likely to try.

# added the silence/change of voice marker #.  This absolutely
# cannot appear in quoted Loglan speech.  Note that in batch files
# the # initially makes a comment, but # later in a line will be change of
# voice.

# if you edit Yourfilename.llg then run revbatch('Yourfilename')
# it will rewrite Yourfilename.txt with your changes and without the
# parses (so you can run filebatch again).  It destroys line continuations
# made with backlashes.

# fixed bugs in phonetic parses starting with a CVV predicate
# with explicit stress.

# a CV word cannot be followed immediately by a vowel
# making a monosyllable without explicit syllable break.
# Defends Cvv-V words.

# installed the sane fix to acronyms with legacy
# VCV letterals in them.

# 2/3/2016 fix to StressedSyllable2 -- I was right in my skeptical
# remark in the notes about why it assumed a final consonant!

# 2/3/2016 minor fix to CCVV, allowing certain pronunciations of
# CCVVV predicates

# 2/1/2016 installed additional long scope PO forms for both
# descriptions and predicates to solve the closure problem for
# abstractions.  This is a major upgrade.

# 1/31/2016  cleaned up deadwood in the PEG code.
#  all support for pause/GU equivalence removed.
# minor fix to borrowing and borrowing affixes which was
# supposed to have happened already.

#changed PUU to PUI, ZOO to ZOI
# and ZOI to ZOA, ZOA to ZOO

#1/30/2016
# added commenting to output of filebatch
# also added alternative commands which give commented parses

# to run a file of utterances (one per line) as
# batch, exit the interface and use the filebatch(Yourfilename) command--
# it will read from Yourfilename.txt and output to Yourfilename.llg
# lines beginning with # are comments that are preserved,
# those beginning with % are commants to throw away
# output files can be renamed as .txt and run again!

# if you want your parses commented in the interface,
# exit the interface and run interface2().  This is useful in
# SL, one can then type ones parses into chat correctly.

#1/30/2016 to do list  alldone
#should LIU, GAO be guarded from badspaces?
#should LOI, LOA, SIA, SIE SIU be added as vocative markers?
#add descpred to HUE, name final descriptions to HOI and HUE
#require comma after foreign name HOI/HUE?  to avoid typo problems
#

#1/29/2016 New Loglan letters Ceiu, Caiu covering qwx; refinements
# of false name marker problem, which I think is now completely fixed.

# 1/26/2016 fixed trailing spaces issue.

# 1/24/2016 added file processing capability.

# 1/23/2016 updates to do with parser display changes.  Important classes
# specified.

# 1/21/2016  serial names can be quoted with LI/LU.  LI does not
# become a name marker:  comma before the name is mandatory.  Fixed
# vocative foreign names so they handle multipart names.

# 1/19/2016 refinements of capitalization.  Lower case z may be followed
# by a capitalized vowel, for acronymic use:  la DaiNaizA.  Junctures may be followed
# by capital letters, so la Beibi-Djein.  Capitalization rules reimposed
# on acronyms, since the useful variations are now permitted.  One can now
# quote CCV djifoa with LIU.

# 1/18/2016 exclude CCCVV predicates, for stupid technical reason.
# I do not believe we have any.

# 1/17/2016:  fixed APA words so they will not include commas.  Installed
# seamless continuation of utterances (I hope).

# speculation that LIU ought to work with CCV affixes

# 1/14/2016 notes to myself:  borrowing affixes should be tested
# for not being complexes.  Or should they?  I should consider making
# it explicitly possible for any utterance beginning with an I word
# to be appended to an utterance to give a further utterance.

# 11/15/2015:  fixed a bug in KOU1

# 11/14  minor things discovered in parsing the Visit to Loglandia:
# 1.  forms like rimo, several hundred, supported in NI
# 2.  hue terms gap replaced with hue termset1 to avoid it eating sentences
# in initial position.  termset1 is much easier to close.
# 3.  the PA word <pau>, ago, wasn't supported.

# 1/11/2016 fixed bug in 1/10 version

# 1/10/2016 more updates from Leith parsing and further extras:

# particle NUJI added to JI class to allow pronouns to be assigned

# rest are Leith items:
# added ... and -- as freemods to support Leith punctuation.
#   (may be preceded by spaces, followed by spaces up to a letter)
# fixed a bug that made it impossible to quote I-initial utterances
# allowed comma after LIU Predicate
# installed vocatives and inverse vocatives of form
#   HOI/HUE followed by bare foreign name
# added optional commas before and after utterances in KIE freemods

# updates from recent parsing of Leith.  freemods can occur after
# solitary NO.  letterals can be capitalized inside cmapua.  HUE freemods
# can follow terminal punctuation.  Legacy vowel letterals are not mistaken
# for A words (though they are deprecated!)

# 10/22 fixed PA to allow pauses next to CA0 units.  rationalized the
# definition of NI.

#10/19 fixed silly error in SA class which broke many acronmyic predicate
# examples in the corpus (forgot !Oddvowel).

#10/17 loglanN.py version allows simple pauses in NI words, elsewhere than
#after SA or RA units, without ending the words.

# 10/17  upgrades to NI class to allow harmless pauses in numerals,  next to CI,
#  forms SINOI SUNOI for greater than, less than (and SANOI not near in value
# if anyone wants it)  and forms like SICIRI (no more than a few) which
# are NI forms not predicates).

#9/25 fine-tuning of pauses in predicates.  Enabled ability to turn
# pause/GUV equivalence off (defined class freemod3 covering
# things which must be pauseless)  It is turned off in loglanB.py

# 9/24  experimental modification of gap class; gap2 allows no pauses.
#  the hope is to get more consistent, less sensitive pause/GU equivalence.
# the general idea is that in most cases if gu is needed as a closure
# it must be explicit, not a pause.   Also answer attitudinal SEU.
# I believe the occurrences of gap which are left will still be wanted
# with no pause/GU equivalence.  I have not built a parser without
#pause/GU equivalence, but I am set up to do so.

#9/22 modifies treatment of freemods.  New class freemod2 =
#!PAUSE freemod.  Freemods are treated differently in metaphor chains.
# if freemod2 is set to freemod, pause/GU equivalence is disabled.

#9/18 allows ga terms in gasent to contain more than one argument
#also revision of comma behavior before vowel initial names
#loglan.py allows ga terms to have more than one argument.
#loglanA.py enforces the more precise condition that
#the ga terms component contains one argument or all arguments.

#9/17 fixes inspired by new review of the PEG parser annotations.
#forbid two successive syllables with syllabic consonants in borrowings.
#this makes sense and excludes some badly formed borrowing affixes.
#also, a significant pause cannot occur before a name word without
#false name markers (as this is the locus of a mandatory phonetic pause).

#9/16  removed restriction on names appearing after CI in
# predicate construction uses of CI, where this is not a danger.
# restricting the ga terms component of gasent to one argument

#9/13 allowing freemod pauses between predicates and linkargs;
#this is important for name defense.  This looks odd in combination
#with the previous mod!

#9/13 implementing pause/GU equivalence re shared termsets;
#the idea is not to allow freemod pauses between predicate and termset
#or within termsets.   This is experimental and the inability to
#put pauses optionally inside or before termsets may prove to be a problem.

#9/12 corrected error in definition of EMono and error in StressedSyllable.

# 9/12 modifiers unmarked predicate is imperative, as it always should have been

# 9/5 sentences with a marked tense predicate before any arguments are gasents

# 7/17 fixed nasty bug in juncture; allow converse forms of BI predicates.

# 8/1 major changes to acronyms.  Further updates and refinements to 8/4.

# 7/30  fixes to JunctureFix and to zao construction

#6/11  GUI terminates any argmod1.
# CV and CVV words can be prefixed to predicates with ZAO

#6/9 edits during revision of the grammar section of the agenda

#6/7 edits during rewrite of lexer section in agenda -- reordered the
# rules in the second section

#6/6 misc fixes when rewriting section 2.1

#6/5 pauses before CA

#6/4 improvements to juncture fix, allowing re-trr-o-vi-ri; added some
# freemods.  Also makes borrowings more modular and fixes an error
# with the test for cmapua falling off borrowings.

#6/3 further fixes to complex predicates, readmitted long chains of
#vowels early in predicates, admitted pauses in sentence pred metaphors.

#6/2 repairs to complex predicate parsing, having to do with borrowing affixes.
#Latest version introduces an explicit test for left boundaries of
#borrowings and borrowing affixes.

#midnight 5/30 fixes to functions to match the new peg.py implementation

#5/29 juncture bug fixes

#5/28 bug fixes.  Added emphatic stress *.  Improvements to name marker
# problem.

#5/27 Implemented finally stressed borrowing affixes.  Implemented
#explicit pause between a stressed syllable and a following predicate.
#Various bug fixes.

#5/26 revisions to repair bugs found in the course of editing the new
# agenda document and in the course of subsequent testing of complex
# parses.  There are likely plenty of bugs!

# 5/25 fixed bug in medial freemods in high level sentences which was
# cancelled by a bug in the ML parser.  Also, improved name marker situation.

#  5/24/2014  phonetic version, now the official release.  It recognizes the ends
# of explicitly stressed predicates without whitespace.  I still have a problem
# with stress patterns in borrowing/derived affixes.  It has more compact
# display.  It parses the corpus with a couple of failures which can be
# fixed by removing commas:  these should work soon.  It may have bugs
# in predicate parsing as I completely rebuilt the method of parsing
# both borrowings and complexes.

# the grammar rules are now automatically generated by the ML version, so
# they *will* match properly.

# commands

# utter(' <string> ') will parse a string as Loglan grammar class 'utterance'
# It is now better to use Utter rather than utter
#  Verbose() will toggle whether grammar classes are shown or not and
#  Shallow() will toggle the depth of the display (nested grammar classes
# are not all shown in the shallow mode).  The verbose deep mode is very
# thoroughly annotated!

# utteras('<classname>','<text>') will parse the text using the indicated
# Loglan grammar class rather than utterance.

# Compact('<classname>') will cause things which parse as class <classname>
# to display as entirely unlabelled strings (make blanu into a single word 
# by compacting
# Predicate).  Decompact() will clear all compact display instructions.

#  Showrule('<classname>') shows a rule <classname> of the Loglan grammar
# in PEG notation

# Loglan grammar workspace

from peg import *

loglan={}

def L(s):  rundef(loglan,s)

def utter(s):
    global TheString
    global verbose
    global shallow
    while not(s=='') and (s[len(s)-1]==' ' or s[len(s)-1]=='\r' or s[len(s)-1]=='\n'):s=s[0:len(s)-1]
    if s=='': return ''
    return printparse(Parse(loglan,'utterance',s))

def utteras(c,s):
    global TheString
    return printparse(Parse(loglan,c,s))

def utteras2(c,s):
    global TheString
    x=Parse(loglan,c,s)
    if not(x[1]==len(s)):  return 'fail'
    return printparse(Parse(loglan,c,s))

def Showrule(s):
    print(showrule(loglan[s]))

Shallow()

def niceprecs():
    Compact('Predicate')

    Compact('Name')

    Compact('A')
    Compact('ACI')
    Compact('Acronym')
    Compact('AGE')
    Compact('BI')
    Compact('CA')
    Compact('CI')
    Compact('CUI')
    Compact('NI')
    Compact('DA')
    Compact('DIO')
    Compact('DIE')
    Compact('LIO')
    Compact('GA')
    Compact('GE')
    Compact('GU')
    Compact('GI')
    Compact('GO')
    Compact('GUE')
    Compact('GUI')
    Compact('GUO')
    Compact('GUU')
    Compact('HOI')
    Compact('HOI0')
    Compact('ICA')
    Compact('ICI')
    Compact('IE1')
    Compact('IGE')
    Compact('JE')
    Compact('JI')
    Compact('JIO')
    Compact('JO')
    Compact('JUE')
    Compact('KA')
    Compact('KI')
    Compact('KIE')
    Compact('KIU')
    Compact('LAU')
    Compact('LEFORPO')
    Compact('stringnospaces')
#    Compact('LW')
    Compact('LWPREDA')
    Compact('LUA')
    Compact('LI1')
    Compact('LU1')
    Compact('LIE1')
    Compact('CII1')
    Compact('LAO1')
    Compact('LIU0')
    Compact('SOI')
    Compact('ME')
#    Compact('LEPO')
    Compact('NOUI')
    Compact('UI1')
    Compact('NO1')
    Compact('mex')
    Compact('NU')
    Compact('PA2')
    Compact('RA')
    Compact('LE')
#    Compact('LA')
    Compact('LA0')
    Compact('I')
    Compact('GA2')
    Compact('CANCELPAUSE')
    Compact('PO')
    Compact('POSHORT')
    Compact('HUE')
    Compact('SUE')
    Compact('ZE2')

    MakeImportant('juelink')
    MakeImportant('jelink')
    MakeImportant('links')
    MakeImportant('predunit')
    MakeImportant('descpred')
    MakeImportant('sentpred')
    MakeImportant('modifier')
    MakeImportant('name')
    MakeImportant('voc')
    MakeImportant('argmod')
    MakeImportant('argument')
    MakeImportant('barepred')
    MakeImportant('predicate')
    MakeImportant('statement')
    MakeImportant('sentence')
    MakeImportant('freemod')
    MakeImportant('uttC')
    MakeImportant('uttF')

Indent()
niceprecs()

# Greedy()  # will parse slowly, a disagreement with the usual parse
#indicates a formal problem with the grammar

# Verbose()  #this would suppress class names

def Utter(x):
    if x=='': return ''
    print(x)
    print(' ')
    print(utter(x))
    print('Parser cache size '+str(len(thecache)))
    print('------')

def Utteras(c,x):
    print(x)
    print(' ')
    print(utteras(c,x))
    print('------')

def borrow(s):
    print('parse as borrowing:\n\n')
    Utteras('Borrowing',s)
    print('\nparse as complex:\n\n')
    Utteras('Complex',s)
    print('\nparse as name:\n\n')
    Utteras('Name',s)
    print('\nparse as cmapua:\n\n')
    Utteras('LW',s)
    
def interface():
    item=input('Type an utterance to parse (or ... to exit):\n')
    if not (item=='...'): Utter(item)
    if not (item=='...'):  interface()

def Utter2(x):
    if x=='': return ''
    print(x)
    print(' ')
    print(commentize(utter(x)))
    print('Parser cache size '+str(len(thecache)))
    print('------')

def Utteras2(c,x):
    print(x)
    print(' ')
    print(commentize(utteras(c,x)))
    print('------')

def borrow2(s):
    print('parse as borrowing:\n\n')
    Utteras2('Borrowing',s)
    print('\nparse as complex:\n\n')
    Utteras2('Complex',s)
    print('\nparse as name:\n\n')
    Utteras2('Name',s)
    print('\nparse as cmapua:\n\n')
    Utteras2('LW',s)


def interface2():
    item=input('Type an utterance to parse (or ... to exit):\n')
    if not (item=='...'): Utter2(item)
    if not (item=='...'):  interface2()

xxx=open('dummy','w')
xxx.write('')
xxx.close()

thefile = open('dummy','r')

theout = open('dummy2','w')

def opening(s):
    global thefile
    thefile=open(s+'.txt','r')

def openout(s):
    global theout
    theout=open(s+'.llg','w')

def commentize(s):

    output='%'
    while len(s)>0:
        if s[0]=='\n':  output=output+'\n%'
        if not s[0]=='\n':  output=output+s[0]
        s=s[1:]
    return output

def batch():
    global thefile
#    print('boo')
    prevline=''
    for line in thefile:
        restart=False
        line1=line
        while not line1=='' and (line1[len(line1)-1]==' ' or line1[len(line1)-1]=='\n' or line1[len(line1)-1]=='\r'):line1=line1[0:len(line1)-1]
        while not line1=='' and line1[0]==' ':line1=line1[1:]
        if not line[0]=='%': print(line+'\n')
        if line[0]=='#': theout.write(line+'\n')
        if not len(line1)==0 and not line1[0]=='#' and not line1[0]=='%' and line1[len(line1)-1]=='\\':
            prevline=prevline+' '+line1[0:len(line1)-1]
            theout.write(line)
            restart=True
        if not len(line1)==0 and not line[0]=='#' and not line[0]=='%' and not restart==True:
            #line1=line[0:len(line)-1]
            #while not line1=='' and line1[len(line1)-1]==' ':line1=line1[0:len(line1)-1]
            Utter(prevline+' '+line1)
            theout.write(line+'\n')
            theout.write(commentize(utteras('utterance',prevline+' '+line1)))
            prevline=''
            theout.write('\n\n')



def filebatch(s):
    global thefile
    global theout
    opening(s)
    openout(s)
    batch()
    thefile.close()
    theout.close()

def batch2():
    global thefile
    lastline='\n'
    for line in thefile:
        if (line[0]=='\n'and not(lastline=='\n')) or not (len(line)>0 and line[0] == '%'):
            theout.write(line)
            lastline=line

def revbatch(s):
    global thefile
    global theout
    thefile=open(s+'.llg','r')
    theout=open(s+'.txt','w')
    batch2()
    thefile.close()
    theout.close()

    



L("lowercase <- (!([qwx]) [a-z])")

L("uppercase <- (!([QWX]) [A-Z])")

L("letter <- (!([QWXqwx]) [A-Za-z])")

L("juncture <- (([-] &(letter)) / ([\'*] !(juncture)))")

L("juncture2 <- ((([-] &(letter)) / ([\'*] !((([ ])* Predicate)) ((', ' ([ ])* &(Predicate)))?)) !(juncture))")

L("Lowercase <- (lowercase / (juncture (letter)?))")

L("Letter <- (letter / juncture)")

L("comma <- ([,] ([ ])+ &(letter))")

L("comma2 <- (([,])? ([ ])+ &(letter))")

L("end <- ((([ ])* '#' ([ ])+ utterance) / (([ ])+ !(.)) / !(.))")

L("period <- (([!.:;?] (&(end) / (([ ])+ &(letter)))) ((&(HUE) freemod (period)?))?)")

L("B <- [Bb]")

L("C <- [Cc]")

L("D <- [Dd]")

L("F <- [Ff]")

L("G <- [Gg]")

L("H <- [Hh]")

L("J <- [Jj]")

L("K <- [Kk]")

L("L <- [Ll]")

L("M <- [Mm]")

L("N <- [Nn]")

L("P <- [Pp]")

L("R <- [Rr]")

L("S <- [Ss]")

L("T <- [Tt]")

L("V <- [Vv]")

L("Z <- [Zz]")

L("a <- ([Aa] !(Mono) (juncture2)?)")

L("e <- ([Ee] !(Mono) (juncture2)?)")

L("i <- ([Ii] !(Mono) (juncture2)?)")

L("o <- ([Oo] !(Mono) (juncture2)?)")

L("u <- ([Uu] !(Mono) (juncture2)?)")

L("AA <- ([Aa] (juncture)? [a] (juncture2)?)")

L("AE <- ([Aa] (juncture)? [e] (juncture2)?)")

L("AI <- ([Aa] [i] (juncture2)?)")

L("AO <- ([Aa] [o] (juncture2)?)")

L("AU <- ([Aa] (juncture)? [u] (juncture2)?)")

L("EA <- ([Ee] (juncture)? [a] (juncture2)?)")

L("EE <- ([Ee] (juncture)? [e] (juncture2)?)")

L("EI <- ([Ee] [i] (juncture2)?)")

L("EO <- ([Ee] (juncture)? [o] (juncture2)?)")

L("EU <- ([Ee] (juncture)? [u] (juncture2)?)")

L("IA <- ([Ii] (juncture)? [a] (juncture2)?)")

L("IE <- ([Ii] (juncture)? [e] (juncture2)?)")

L("II <- ([Ii] (juncture)? [i] (juncture2)?)")

L("IO <- ([Ii] (juncture)? [o] (juncture2)?)")

L("IU <- ([Ii] (juncture)? [u] (juncture2)?)")

L("OA <- ([Oo] (juncture)? [a] (juncture2)?)")

L("OE <- ([Oo] (juncture)? [e] (juncture2)?)")

L("OI <- ([Oo] [i] (juncture2)?)")

L("OO <- ([Oo] (juncture)? [o] (juncture2)?)")

L("OU <- ([Oo] (juncture)? [u] (juncture2)?)")

L("UA <- ([Uu] (juncture)? [a] (juncture2)?)")

L("UE <- ([Uu] (juncture)? [e] (juncture2)?)")

L("UI <- ([Uu] (juncture)? [i] (juncture2)?)")

L("UO <- ([Uu] (juncture)? [o] (juncture2)?)")

L("UU <- ([Uu] (juncture)? [u] (juncture2)?)")

L("V1 <- [AEIOUYaeiouy]")

L("V2 <- [AEIOUaeiou]")

L("C1 <- (!(V1) letter)")

L("Mono <- (([Aa] [o]) / (V2 [i]) / ([Ii] V2) / ([Uu] V2))")

L("EMono <- (([Aa] [o]) / ([AEOaeo] [i]))")

L("NextVowels <- (EMono / (V2 &(EMono)) / Mono / V2)")

L("BrokenMono <- (([a] juncture [o]) / ([aeo] juncture [i]))")

L("CVVSyll <- (C1 Mono)")

L("LWunit <- (((CVVSyll (juncture)? V2) / (C1 !(BrokenMono) V2 (juncture)? V2) / ([Zz] 'iy' (juncture)? ('ma')?) / (C1 V2)) (juncture2)?)")

L("LW1 <- (((V2 V2) / (C1 !(BrokenMono) V2 (juncture)? V2) / (C1 V2)) (juncture)?)")

L("caprule <- ((uppercase / lowercase) ((('z' V1) / lowercase / (juncture (caprule)?) / TAI0))* !(letter))")

L("InitialCC <- ('bl' / 'br' / 'ck' / 'cl' / 'cm' / 'cn' / 'cp' / 'cr' / 'ct' / 'dj' / 'dr' / 'dz' / 'fl' / 'fr' / 'gl' / 'gr' / 'jm' / 'kl' / 'kr' / 'mr' / 'pl' / 'pr' / 'sk' / 'sl' / 'sm' / 'sn' / 'sp' / 'sr' / 'st' / 'tc' / 'tr' / 'ts' / 'vl' / 'vr' / 'zb' / 'zv' / 'zl' / 'sv' / 'Bl' / 'Br' / 'Ck' / 'Cl' / 'Cm' / 'Cn' / 'Cp' / 'Cr' / 'Ct' / 'Dj' / 'Dr' / 'Dz' / 'Fl' / 'Fr' / 'Gl' / 'Gr' / 'Jm' / 'Kl' / 'Kr' / 'Mr' / 'Pl' / 'Pr' / 'Sk' / 'Sl' / 'Sm' / 'Sn' / 'Sp' / 'Sr' / 'St' / 'Tc' / 'Tr' / 'Ts' / 'Vl' / 'Vr' / 'Zb' / 'Zv' / 'Zl' / 'Sv')")

L("MaybeInitialCC <- (([Bb] (juncture)? [l]) / ([Bb] (juncture)? [r]) / ([Cc] (juncture)? [k]) / ([Cc] (juncture)? [l]) / ([Cc] (juncture)? [m]) / ([Cc] (juncture)? [n]) / ([Cc] (juncture)? [p]) / ([Cc] (juncture)? [r]) / ([Cc] (juncture)? [t]) / ([Dd] (juncture)? [j]) / ([Dd] (juncture)? [r]) / ([Dd] (juncture)? [z]) / ([Ff] (juncture)? [l]) / ([Ff] (juncture)? [r]) / ([Gg] (juncture)? [l]) / ([Gg] (juncture)? [r]) / ([Jj] (juncture)? [m]) / ([Kk] (juncture)? [l]) / ([Kk] (juncture)? [r]) / ([Mm] (juncture)? [r]) / ([Pp] (juncture)? [l]) / ([Pp] (juncture)? [r]) / ([Ss] (juncture)? [k]) / ([Ss] (juncture)? [l]) / ([Ss] (juncture)? [m]) / ([Ss] (juncture)? [n]) / ([Ss] (juncture)? [p]) / ([Ss] (juncture)? [r]) / ([Ss] (juncture)? [t]) / ([Tt] (juncture)? [c]) / ([Tt] (juncture)? [r]) / ([Tt] (juncture)? [s]) / ([Vv] (juncture)? [l]) / ([Vv] (juncture)? [r]) / ([Zz] (juncture)? [b]) / ([Zz] (juncture)? [v]) / ([Zz] (juncture)? [l]) / ([Ss] (juncture)? [v]))")

L("NonmedialCC <- (([b] (juncture)? [b]) / ([c] (juncture)? [c]) / ([d] (juncture)? [d]) / ([f] (juncture)? [f]) / ([g] (juncture)? [g]) / ([h] (juncture)? [h]) / ([j] (juncture)? [j]) / ([k] (juncture)? [k]) / ([l] (juncture)? [l]) / ([m] (juncture)? [m]) / ([n] (juncture)? [n]) / ([p] (juncture)? [p]) / ([q] (juncture)? [q]) / ([r] (juncture)? [r]) / ([s] (juncture)? [s]) / ([t] (juncture)? [t]) / ([v] (juncture)? [v]) / ([z] (juncture)? [z]) / ([h] (juncture)? C1) / ([cjsz] (juncture)? [cjsz]) / ([f] (juncture)? [v]) / ([k] (juncture)? [g]) / ([p] (juncture)? [b]) / ([t] (juncture)? [d]) / ([fkpt] (juncture)? [jz]) / ([b] (juncture)? [j]) / ([s] (juncture)? [b]))")

L("NonjointCCC <- (([c] (juncture)? [d] (juncture)? [z]) / ([c] (juncture)? [v] (juncture)? [l]) / ([n] (juncture)? [d] (juncture)? [j]) / ([n] (juncture)? [d] (juncture)? [z]) / ([d] (juncture)? [c] (juncture)? [m]) / ([d] (juncture)? [c] (juncture)? [t]) / ([d] (juncture)? [t] (juncture)? [s]) / ([p] (juncture)? [d] (juncture)? [z]) / ([g] (juncture)? [t] (juncture)? [s]) / ([g] (juncture)? [z] (juncture)? [b]) / ([s] (juncture)? [v] (juncture)? [l]) / ([j] (juncture)? [d] (juncture)? [j]) / ([j] (juncture)? [t] (juncture)? [c]) / ([j] (juncture)? [t] (juncture)? [s]) / ([j] (juncture)? [v] (juncture)? [r]) / ([t] (juncture)? [v] (juncture)? [l]) / ([k] (juncture)? [d] (juncture)? [z]) / ([v] (juncture)? [t] (juncture)? [s]) / ([m] (juncture)? [z] (juncture)? [b]))")

L("RepeatedVowel <- (([Aa] (juncture)? [a]) / ([Ee] (juncture)? [e]) / ([Oo] (juncture)? [o]) / ([Ii] juncture [i]) / ([Uu] juncture [u]))")

L("RepeatedVocalic <- (([Mm] [m]) / ([Nn] [n]) / ([Ll] [l]) / ([Rr] [r]))")

L("Syllabic <- [lmnr]")

L("Nonsyllabic <- (!(Syllabic) C1)")

L("Badfinalpair <- (Nonsyllabic !('mr') !(RepeatedVocalic) Syllabic !((V2 / [y] / RepeatedVocalic)))")

L("FirstConsonants <- (((!((C1 C1 RepeatedVocalic)) &(InitialCC) (C1 InitialCC)) / (!((C1 RepeatedVocalic)) InitialCC) / ((!(RepeatedVocalic) C1) !([y]))) !(juncture))")

L("FirstConsonants2 <- (((!((C1 C1 RepeatedVocalic)) &(InitialCC) (C1 InitialCC)) / (!((C1 RepeatedVocalic)) InitialCC) / (!(RepeatedVocalic) C1)) !(juncture))")

L("VowelSegment <- ((NextVowels !(RepeatedVocalic)) / (!((C1 RepeatedVocalic)) RepeatedVocalic))")

L("VowelSegment2 <- (NextVowels / (!((C1 RepeatedVocalic)) RepeatedVocalic))")

L("Syllable <- (((FirstConsonants)? !(RepeatedVowel) !((&(Mono) V2 RepeatedVowel)) VowelSegment !(Badfinalpair) (FinalConsonant)? (FinalConsonant)?) (juncture)?)")

L("JunctureFix <- (((FirstConsonants)? V2 juncture &(InitialCC) (!(C1) RepeatedVocalic)) / ((FirstConsonants)? VowelSegment C1 !(InitialCC) &((MaybeInitialCC V2))))")

L("SyllableFinal1 <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment !([\'*]) ([-])? (&(Syllable) / &([y]) / !(Letter)))")

L("SyllableFinal2 <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment (juncture)? (&([y]) / !(Letter)))")

L("SyllableFinal2a <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment (juncture)? (&([y]) / !(Letter)))")

L("SyllableFinal2b <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment [\'*] (&([y]) / !(Letter)))")

L("StressedSyllable <- (((FirstConsonants)? !(RepeatedVowel) !((&(Mono) V2 RepeatedVowel)) VowelSegment !(Badfinalpair) (FinalConsonant)? (FinalConsonant)?) [\'*])")

L("FinalConsonant <- (!(RepeatedVocalic) !(NonmedialCC) !(NonjointCCC) !(Syllable) C1 !((juncture V2)))")

L("Syllable2 <- (((FirstConsonants2)? (VowelSegment2 / [y]) !(Badfinalpair) (FinalConsonant2)? (FinalConsonant2)?) (juncture)?)")

L("FinalConsonant2 <- (!(RepeatedVocalic) !(NonmedialCC) !(NonjointCCC) !(Syllable2) C1 !((juncture V2)))")

L("Name <- (([ ])* &(((uppercase / lowercase) ((!((C1 ([\'*])? !(Letter))) Lowercase))* C1 ([\'*])? !(Letter) (&(end) / comma / &(period) / &(Name) / &(CI)))) ((Syllable2)+ (&(end) / comma / &(period) / &(Name) / &(CI))))")

L("CCSyllableB <- (((FirstConsonants)? RepeatedVocalic !(Badfinalpair) (FinalConsonant)? (FinalConsonant)?) (juncture)?)")

L("BorrowingTail <- ((!(JunctureFix) !(CCSyllableB) StressedSyllable ((!(StressedSyllable) CCSyllableB))? !(StressedSyllable) SyllableFinal1) / (!(CCSyllableB) !(JunctureFix) Syllable ((!(StressedSyllable) CCSyllableB))? !(StressedSyllable) SyllableFinal2))")

L("PreBorrowing <- (((!(BorrowingTail) !(StressedSyllable) !(JunctureFix) !((CCSyllableB CCSyllableB)) Syllable))* !(CCSyllableB) BorrowingTail)")

L("HasCCPair <- ((((C1)? ((V2 ([-])?))+ !(Borrowing) ([\'*])?))? !((!(InitialCC) MaybeInitialCC)) C1 (juncture)? C1)")

L("CVCBreak <- (C1 V2 (juncture)? &(MaybeInitialCC) C1 (juncture)? &((PreComplex / ComplexTail)))")

L("CCVV <- ((&(BorrowingTail) C1 C1 (C1)? V2 [\'*] !(Mono) V2) / (&(BorrowingTail) C1 C1 (C1)? V2 (juncture)? V2 (!(Letter) / ((juncture)? [y]))))")

L("Borrowing <- (!(CVCBreak) !(CCVV) &(HasCCPair) !((V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(BorrowingTail) !(StressedSyllable) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))* !(CCSyllableB) BorrowingTail))")

L("PreBorrowingAffix <- ((((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))+ SyllableFinal2a) (juncture)? [y] ([-])? (([ ,] ([ ])*))?)")

L("BorrowingAffix <- (!(CVCBreak) !(CCVV) &(HasCCPair) !((V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))+ SyllableFinal2a) (juncture)? [y] ([-])? (comma)?)")

L("StressedBorrowingAffix <- (!(CVCBreak) !(CCVV) &(HasCCPair) !((V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))* SyllableFinal2b) (juncture)? [y] ([-])? !([,]))")

L("yhyphen <- ((juncture)? [y] !([\'*]) ([-])? !([y]) &(letter))")

L("CV <- ((C1 V2 !(V2)) !([\'*]) ([-])?)")

L("Cfinal <- ((C1 yhyphen) / (!(NonmedialCC) !(NonjointCCC) C1 !(((juncture)? V2))))")

L("hyphen <- (!(NonmedialCC) !(NonjointCCC) (([r] !(((juncture)? [r])) !(((juncture)? V2))) / ([n] (juncture)? &([r])) / ((juncture)? [y] !([\'*]))) ((juncture)? &(letter)) !(((juncture)? [y])))")

L("StressedSyllable2 <- (((FirstConsonants)? VowelSegment !(Badfinalpair) (FinalConsonant)? (FinalConsonant)?) [\'*])")

L("CVVStressed <- (((C1 &(RepeatedVowel) V2 !([\'*]) ([-])? !(RepeatedVowel) V2 (hyphen)?) (([\'*] / juncture))?) / (C1 !(BrokenMono) V2 [-] V2 [\'*]) / (C1 !(Mono) V2 V2 [\'*]))")

L("CVVStressed2 <- (C1 Mono [\'*])")

L("CVV <- (!((C1 V2 [\'*] V2 [\'*])) ((C1 !(BrokenMono) V2 (juncture)? !(RepeatedVowel) V2 (hyphen)?) (juncture)?))")

L("CVVFinal1 <- (C1 !(BrokenMono) V2 [\'*] V2 ([-])?)")

L("CVVFinal2 <- (((C1 !(Mono) V2 V2) / (C1 !(BrokenMono) V2 juncture V2)) !(Letter))")

L("CVVFinal5 <- (((C1 !(Mono) V2 V2) / (C1 !(BrokenMono) V2 juncture V2)) &(((juncture)? [y])))")

L("CVVFinal3 <- (C1 Mono !([\'*]) ([-])?)")

L("CVVFinal4 <- (C1 Mono !(Letter))")

L("CVC <- ((C1 V2 Cfinal) (juncture)?)")

L("CVCStressed <- (C1 V2 !(NonmedialCC) !(NonjointCCC) C1 [\'*] (yhyphen)?)")

L("CCV <- (InitialCC !(RepeatedVowel) V2 (yhyphen)? (juncture)?)")

L("CCVStressed <- (InitialCC !(RepeatedVowel) V2 [\'*])")

L("CCVFinal1 <- (InitialCC !(RepeatedVowel) V2 !([\'*]) ([-])?)")

L("CCVFinal2 <- (InitialCC V2 !(Letter))")

L("CCVCVMedial <- (CCV C1 [y] ([-])? &(letter))")

L("CCVCVMedialStressed <- (CCV [\'*] C1 [y] ([-])? &(letter))")

L("CCVCVFinal1 <- (InitialCC V2 [\'*] CV)")

L("CCVCVFinal2 <- (InitialCC V2 (juncture)? CV !(Letter))")

L("CVCCVMedial <- (C1 V2 ((juncture &(InitialCC)))? !(NonmedialCC) C1 (juncture)? C1 [y] ([-])? &(letter))")

L("CVCCVMedialStressed <- ((C1 V2 ([\'*] &(InitialCC)) !(NonmedialCC) C1 C1 [y] ([-])? &(letter)) / (C1 V2 !(NonmedialCC) C1 [\'*] C1 [y] ([-])? &(letter)))")

L("CVCCVFinal1a <- (C1 V2 [\'*] InitialCC V2 ([-])?)")

L("CVCCVFinal1b <- (C1 V2 !(NonmedialCC) C1 [\'*] CV)")

L("CVCCVFinal2 <- (C1 V2 ((juncture &(InitialCC)))? !(NonmedialCC) C1 (juncture)? CV !(Letter))")

L("GenericFinal <- (CVVFinal3 / CVVFinal4 / CCVFinal1 / CCVFinal2)")

L("GenericTerminalFinal <- (CVVFinal4 / CCVFinal2)")

L("Affix1 <- (CCVCVMedial / CVCCVMedial / CCV / CVV / CVC)")

L("Peelable <- (&(PreBorrowingAffix) !(CVVFinal1) !(CVVFinal5) Affix1 (!(Affix1) / &((&(PreBorrowingAffix) !(CVVFinal1) !(CVVFinal5) Affix1 !(PreBorrowingAffix) !(Affix1))) / Peelable))")

L("FiveLetterFinal <- (CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2)")

L("Peelable2 <- (&(PreBorrowing) !(CVVFinal1) !(CVVFinal2) !(CVVFinal5) !(FiveLetterFinal) Affix1 !(FiveLetterFinal) (!(Affix1) / &((&(PreBorrowing) !(FiveLetterFinal) !(CVVFinal1) !(CVVFinal2) !(CVVFinal5) Affix1 !(PreBorrowing) !(FiveLetterFinal) !(Affix1))) / Peelable2))")

L("Affix <- ((!(Peelable) !(Peelable2) Affix1) / BorrowingAffix)")

L("Affix2 <- (!(StressedSyllable2) !(CVVStressed) Affix)")

L("ComplexTail <- ((Affix GenericTerminalFinal) / (!((!(Peelable) Affix1)) StressedBorrowingAffix GenericFinal) / (CCVCVMedialStressed GenericFinal) / (CVCCVMedialStressed GenericFinal) / (CCVStressed GenericFinal) / (CVCStressed GenericFinal) / (CVVStressed GenericFinal) / (CVVStressed2 GenericFinal) / (Affix2 CVVFinal1) / (Affix2 CVVFinal2) / CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2 / (!((CVVStressed / StressedSyllable2)) Affix !((!(Peelable2) Affix1)) Borrowing !(((juncture)? [y]))))")

L("Primitive <- (CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2)")

L("PreComplex <- (ComplexTail / ((!((CVCStressed / CCVStressed / CVVStressed / ComplexTail / StressedSyllable2)) Affix) PreComplex))")

L("Complex <- (!((C V2 (juncture)? (V2)? (juncture)? CVV)) !((C1 V2 ([-])? (V2)? ([-])? (Primitive / PreComplex / Borrowing / CVV))) !((C1 V2 (juncture)? &(MaybeInitialCC) C1 (juncture)? &((PreComplex / ComplexTail)))) PreComplex)")

L("Predicate <- ((&(caprule) ((Primitive / Complex / Borrowing) ((([ ])* Z AO (', ')? ([ ])* Predicate))?)) / (C1 V2 (V2)? ([ ])* Z AO (comma)? ([ ])* Predicate))")

L("__LWinit <- (([ ])* !(Predicate) &(caprule))")

L("Oddvowel <- ((juncture)? (((V2 (juncture)? V2 (juncture)?))* V2) (juncture)?)")

L("__LWbreak <- (!(Oddvowel) !((!((([ ])* Predicate)) !((&(nonamemarkers) Name)) (A / ICI / ICA / IGE / I))) ((comma &((!((&(nonamemarkers) Name)) (V2 / A)))))?)")

L("CANCELPAUSE <- (comma (('y' comma) / (C UU __LWbreak)))")

L("PAUSE <- ((!(CANCELPAUSE) comma !((A / ICI / ICA / IGE / I)) !((&(V2) Predicate))) !((([ ])* &(nonamemarkers) Name)))")

L("TAI0 <- (!(Predicate) (((V1 (juncture)? !(Predicate) !(Name) M a (juncture)?) / (V1 (juncture)? !(Predicate) !(Name) F i (juncture)?) / (C1 AI (u)?) / (C1 EI (u)?) / (C1 EO) / (Z i (juncture)? V1 (juncture)? ((M a))? (juncture)?)) (!(Oddvowel) / (!([ ]) &(TAI0)))))")

L("NOI <- (!(Predicate) N OI !(Oddvowel))")

L("A0 <- (!(Predicate) ((([AEOUaeou] !([AEIOUaeiou])) / (H a)) (juncture)? !(Oddvowel)))")

L("A <- (__LWinit !(TAI0) (((N u) &((u / (N o)))))? ((N o))? A0 (NOI)? !((([ ])+ PA)) (PANOPAUSES)? ((!(Predicate) G u))? !(Oddvowel))")

L("A1 <- (A __LWbreak)")

L("ACI <- (A !(Predicate) C i __LWbreak)")

L("AGE <- (A !(Predicate) G e __LWbreak)")

L("CA0 <- ((((N o))? !(Predicate) ((C a) / (C e) / (C o) / (C u) / (Z e) / (C i H a)) !(Oddvowel)) (NOI)?)")

L("CA1 <- (!(Predicate) (((N u) &(((C u) / (N o)))))? ((N o))? CA0 !((([ ])+ PA)) (PANOPAUSES)? ((!(Predicate) G u))? !(Oddvowel))")

L("CA <- (__LWinit &(caprule) CA1 __LWbreak)")

L("ZE2 <- (__LWinit (Z e) __LWbreak)")

L("I <- (__LWinit !(TAI0) i !((([ ])+ PA)) (PANOPAUSES)? ((!(Predicate) G u))? __LWbreak)")

L("ICA <- (__LWinit !(Predicate) i ((!(Predicate) H a) / CA1) __LWbreak)")

L("ICI <- (__LWinit i (CA1)? !(Predicate) C i __LWbreak)")

L("IGE <- (__LWinit i (CA1)? !(Predicate) G e __LWbreak)")

L("KA0 <- (!(Predicate) (((K a) / (K e) / (K o) / (K u) / (K i H a)) !(Oddvowel)))")

L("KOU <- (!(Predicate) (((K OU) / (M OI) / (R AU) / (S OA)) !(Oddvowel)))")

L("KOU1 <- (((N u N o) / (N u) / (N o)) KOU)")

L("KA <- (__LWinit &(caprule) (((((N u) &((K u))))? KA0) / ((KOU1 / KOU) K i)) (NOI)? __LWbreak)")

L("KI <- (__LWinit (K i) (NOI)? __LWbreak)")

L("NI0 <- (!(Predicate) (((K UA) / (G IE) / (G IU) / (H IE) / (H IU) / (K UE) / (N EA) / (N IO) / (P EA) / (P IO) / (S UU) / (S UA) / (T IA) / (Z OA) / (Z OO) / (H o) / (N i) / (N e) / (T o) / (T e) / (F o) / (F e) / (V o) / (V e) / (P i) / (R e) / (R u) / (S e) / (S o) / (H i)) !(Oddvowel)))")

L("SA <- (!(Predicate) ((S a) / (S i) / (S u)) (NOI)? !(Oddvowel))")

L("RA <- (!(Predicate) (((R a) / (R i) / (R o)) !(Oddvowel)))")

L("NI1 <- ((NI0 ((M a))? ((M OA (NI0)*))? !(Oddvowel)) ((comma2 !((NI RA)) &(NI)))?)")

L("RA1 <- ((RA ((M a))? ((M OA (NI0)*))? !(Oddvowel)) ((comma2 !((NI RA)) &(NI)))?)")

L("IE1 <- (__LWinit IE __LWbreak)")

L("NI2 <- ((((SA)? ((NI1)+ / RA1)) / SA) (NOI)? ((CA0 (((SA)? ((NI1)+ / RA1)) / SA) (NOI)?))*)")

L("NI <- (__LWinit (IE1)? NI2 ((&((M UE)) Acronym (comma / &(end) / &(period)) !((C u))))? ((C u))? !(Oddvowel))")

L("mex <- (__LWinit NI __LWbreak)")

L("CI <- (__LWinit (C i) __LWbreak)")

L("Acronym <- (([ ])* &(caprule) ((M UE) / TAI0 / ([Zz] V2 !(V2))) ((NI1 / TAI0 / ([Zz] V2 (!(V2) / ([Zz] &(V2))))))+)")

L("TAI <- (__LWinit (TAI0 / ((G AO) !(badspaces) !(V2) ([ ])* (Name / Predicate / (C1 V2 V2 (!(Oddvowel) / &(TAI0))) / (C1 V2 (!(Oddvowel) / &(TAI0)))))) __LWbreak)")

L("DA0 <- (((T AO) / (T IO) / (T UA) / (M IO) / (M IU) / (M UO) / (M UU) / (T OA) / (T OI) / (T OO) / (T OU) / (T UO) / (T UU) / (S UO) / (H u) / (B a) / (B e) / (B o) / (B u) / (D a) / (D e) / (D i) / (D o) / (D u) / (M i) / (T u) / (M u) / (T i) / (T a) / (M o)) !(Oddvowel))")

L("DA1 <- (!(Predicate) ((TAI0 / DA0) ((C i !([ ]) NI0))? !(Oddvowel)))")

L("DA <- (__LWinit DA1 __LWbreak)")

L("PA0 <- (!(Predicate) (((G IA) / (G UA) / (P AU) / (P IA) / (P UA) / (N IA) / (N UA) / (B IU) / (F EA) / (F IA) / (F UA) / (V IA) / (V II) / (V IU) / (C IU) / (C OI) / (D AU) / (D II) / (D UO) / (F OI) / (F UI) / (G AU) / (H EA) / (K AU) / (K II) / (K UI) / (L IA) / (L UI) / (M IA) / (M OU) / (N UI) / (P EU) / (R OI) / (R UI) / (S EA) / (S IO) / (T IE) / (V a) / (V i) / (V u) / (P a) / (N a) / (F a) / (V a) / KOU) !(Oddvowel)))")

L("PANOPAUSES <- (!(Predicate) (((!(PA0) NI))? ((KOU1 / PA0))+ ((CA0 ((KOU1 / PA0))+))* (ZI)? !(Oddvowel)))")

L("PA <- (!(Predicate) (((!(PA0) NI))? (((KOU1 / PA0) ((comma2 &((((CA0 (comma2)?))? PA))))?))+ (((CA0 (comma2)?) (((KOU1 / PA0) ((comma2 &((((CA0 (comma2)?))? PA))))?))+))* (ZI)? !(Oddvowel)))")

L("PA2 <- ((__LWinit PA __LWbreak) (freemod)?)")

L("GA <- (__LWinit (G a) __LWbreak)")

L("PA1 <- (((PA2 / GA) __LWbreak) (freemod)?)")

L("ZI <- (!(Predicate) ((Z i) / (Z a) / (Z u)))")

L("LE <- (__LWinit ((L EA) / (L EU) / (L OE) / (L EE) / (L AA) / (L e) / (L o) / ((L a) !(badspaces))) ((DA1 / TAI0))? !((([ ])+ PA)) (PA)? __LWbreak)")

L("LEFORPO <- (__LWinit ((L e) / (L o) / NI2) __LWbreak)")

L("LIO <- (__LWinit (L IO) __LWbreak)")

L("LAU <- (__LWinit ((L AU) / (L OU)) __LWbreak)")

L("LUA <- (__LWinit ((L UA) / (L UO)) __LWbreak)")

L("LI1 <- (L i)")

L("LU1 <- (L u)")

L("Quotemod <- (((Z a) / (Z i)) !(Oddvowel))")

L("LI <- ((__LWinit LI1 !(V2) (Quotemod)? ((([,])? ([ ])+))? utterance0 (', ')? __LWinit LU1 __LWbreak) / (__LWinit LI1 !(V2) (Quotemod)? comma name (comma)? __LWinit LU1 __LWbreak))")

L("stringnospaces <- (([,])? (([ ])+ ((!([ ,]) !(period) .))+) ((([,])? ([ ])+ &(letter)) / &(period) / &(end)))")

L("stringnospacesclosed <- (([,])? (([ ])+ ((!([ ,]) !(period) .))+) (([,] ([ ])+) / &(period) / &(end)))")

L("stringnospacesclosedblock <- ((stringnospaces ((!(([y] stringnospacesclosed)) [y] stringnospaces))* ([y] stringnospacesclosed)) / stringnospacesclosed)")

L("LAO1 <- (L AO)")

L("LAO <- (([ ])* (LAO1 stringnospaces (([y] stringnospaces))*))")

L("LIE1 <- (L IE)")

L("CII1 <- ((C II) / [y])")

L("LIE <- (([ ])* LIE1 ((!([ ]) NI0))? (Quotemod)? stringnospaces ((CII1 ((!([ ]) NI0))? stringnospaces))*)")

L("LW <- (&(caprule) (((!(Predicate) V2 V2))+ / ((!(Predicate) (V2)? ((!(Predicate) LWunit))+) / V2)))")

L("LIU0 <- ((L IU) / (N IU))")

L("LIU1 <- (__LWinit ((LIU0 !(badspaces) !(V2) (Quotemod)? ((([,])? ([ ])+))? (Name / (Predicate (comma)?) / (CCV (comma)?) / (LW (([,] ([ ])+ !([,])) / &(period) / &(end) / &((([ ])* Predicate)))))) / (L II (Quotemod)? TAI __LWbreak)))")

L("SUE <- (__LWinit ((S UE) / (S AO)) stringnospaces)")

L("CUI <- (__LWinit (C UI) __LWbreak)")

L("GA2 <- (__LWinit (G a) __LWbreak)")

L("GE <- (__LWinit (G e) __LWbreak)")

L("GEU <- (__LWinit ((C UE) / (G EU)) __LWbreak)")

L("GI <- (__LWinit ((G i) / (G OI)) __LWbreak)")

L("GO <- (__LWinit (G o) __LWbreak)")

L("GU <- (__LWinit (G u) __LWbreak)")

L("GUI <- (__LWinit (G UI) __LWbreak)")

L("GUO <- (__LWinit (G UO) __LWbreak)")

L("GUOA <- (__LWinit (G UO a) __LWbreak)")

L("GUOE <- (__LWinit (G UO e) __LWbreak)")

L("GUOI <- (__LWinit (G UO i) __LWbreak)")

L("GUOO <- (__LWinit (G UO o) __LWbreak)")

L("GUOU <- (__LWinit (G UO u) __LWbreak)")

L("GUU <- (__LWinit (G UU) __LWbreak)")

L("GUE <- (__LWinit (G UE) __LWbreak)")

L("JE <- (__LWinit (J e) __LWbreak)")

L("JUE <- (__LWinit (J UE) __LWbreak)")

L("JI <- (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) __LWbreak)")

L("JIO <- (__LWinit ((J IO) / (J AO)) __LWbreak)")

L("DIO <- (__LWinit ((B EU) / (C AU) / (D IO) / (F OA) / (K AO) / (J UI) / (N EU) / (P OU) / (G OA) / (S AU) / (V EU) / (Z UA) / (Z UE) / (Z UI) / (Z UO) / (Z UU) / (L AE) / (L UE)) __LWbreak)")

L("DIO2 <- (__LWinit ((B EU) / (C AU) / (D IO) / (F OA) / (K AO) / (J UI) / (N EU) / (P OU) / (G OA) / (S AU) / (V EU) / (Z UA) / (Z UE) / (Z UI) / (Z UO) / (Z UU)) __LWbreak)")

L("ME <- (__LWinit ((M EA) / (M e)) __LWbreak)")

L("NU0 <- (((N UO) / (F UO) / (J UO) / (N u) / (F u) / (J u)) !(Oddvowel))")

L("NU <- (__LWinit ((NU0 !((([ ])+ (NI0 / RA))) ((NI0 / RA))? (freemod)?))+ __LWbreak)")

L("PO1 <- (__LWinit ((P o) / (P u) / (Z o)) !(Oddvowel))")

L("PO1A <- (__LWinit ((P OI a) / (P UI a) / (Z OI a)) !(Oddvowel))")

L("PO1E <- (__LWinit ((P OI e) / (P UI e) / (Z OI e)) !(Oddvowel))")

L("PO1I <- (__LWinit ((P OI i) / (P UI i) / (Z OI i)) !(Oddvowel))")

L("PO1O <- (__LWinit ((P OI o) / (P UI o) / (Z OI o)) !(Oddvowel))")

L("PO1U <- (__LWinit ((P OI u) / (P UI u) / (Z OI u)) !(Oddvowel))")

L("POSHORT1 <- (__LWinit ((P OI) / (P UI) / (Z OI)) !(Oddvowel))")

L("PO <- (__LWinit PO1 __LWbreak)")

L("POA <- (__LWinit PO1A __LWbreak)")

L("POE <- (__LWinit PO1E __LWbreak)")

L("POI <- (__LWinit PO1E __LWbreak)")

L("POO <- (__LWinit PO1O __LWbreak)")

L("POU <- (__LWinit PO1U __LWbreak)")

L("POSHORT <- (__LWinit POSHORT1 __LWbreak)")

L("DIE <- (__LWinit ((D IE) / (F IE) / (K AE) / (N UE) / (R IE)) __LWbreak)")

L("HOI <- (__LWinit ((H OI) / (L OI) / (L OA) / (S IA) / (S IE) / (S IU)) __LWbreak)")

L("JO <- (__LWinit ((NI0 / RA))? (J o) __LWbreak)")

L("KIE <- (__LWinit (K IE) __LWbreak)")

L("KIU <- (__LWinit (K IU) __LWbreak)")

L("SOI <- (__LWinit (S OI) __LWbreak)")

L("UI0 <- ((UA / UE / UI / UO / UU / OA / OE / OI / OU / OO / IA / II / IO / IU / EA / EE / EI / EO / EU / AA / AE / AI / AO / AU / (B EA) / (B UO) / (C EA) / (C IA) / (C OA) / (D OU) / (F AE) / (F AO) / (F EU) / (G EA) / (K UO) / (K UU) / (R EA) / (N AO) / (N IE) / (P AE) / (P IU) / (S AA) / (S UI) / (T AA) / (T OE) / (V OI) / (Z OU) / (L OI) / (L OA) / (S IA) / (S II) / (T OE) / (S IU) / (C AO) / (C EU) / (S IE) / (S EU)) !(Oddvowel))")

L("NOUI <- ((__LWinit (N o) ([ ])* !(Predicate) UI0 __LWbreak) / (__LWinit UI0 NOI __LWbreak))")

L("UI1 <- (__LWinit (UI0 / (NI F i)) __LWbreak)")

L("HUE <- (__LWinit (H UE) __LWbreak)")

L("NO1 <- (__LWinit !(KOU1) !(NOUI) (N o) !((__LWinit KOU)) !((([ ])* (JIO / JI))) __LWbreak)")

L("AcronymicName <- (Acronym (&(end) / ',' / &(period) / &(Name) / &(CI)))")

L("DJAN <- (Name / AcronymicName)")

L("BI <- (__LWinit ((N u))? ((B IA) / (B IE) / (C IE) / (C IO) / (B IA) / (B [i])) __LWbreak)")

L("LWPREDA <- (((H e) / (D UA) / (D UI) / (B UA) / (B UI)) !(Oddvowel))")

L("PREDA <- (([ ])* &(caprule) (Predicate / LWPREDA / (!([ ]) NI RA)) !((!((&(nonamemarkers) Name)) (A / ICI / ICA / IGE / I))) ((',' ([ ])+ &((!((&(nonamemarkers) Name)) (V2 / A)))))? (freemod)?)")

L("guo <- ((PAUSE)? (GUO / GU) (freemod)?)")

L("guoa <- ((PAUSE)? (GUOA / GU) (freemod)?)")

L("guoe <- ((PAUSE)? (GUOE / GU) (freemod)?)")

L("guoi <- ((PAUSE)? (GUOI / GU) (freemod)?)")

L("guoo <- ((PAUSE)? (GUOO / GU) (freemod)?)")

L("guou <- ((PAUSE)? (GUOU / GU) (freemod)?)")

L("gui <- ((PAUSE)? (GUI / GU) (freemod)?)")

L("gue <- ((PAUSE)? (GUE / GU) (freemod)?)")

L("guu <- ((PAUSE)? (GUU / GU) (freemod)?)")

L("lua <- LUA")

L("geu <- GEU")

L("gap <- ((PAUSE)? GU (freemod)?)")

L("gap2 <- gap")

L("guu1 <- gap")

L("juelink <- (JUE (freemod)? term)")

L("links1 <- (juelink (((freemod)? juelink))* (gue)?)")

L("links <- ((links1 / (KA (freemod)? links (freemod)? KI (freemod)? links1)) (((freemod)? A1 (freemod)? links1))*)")

L("jelink <- (JE (freemod)? term)")

L("linkargs1 <- (jelink (freemod)? (links)? (gue)?)")

L("linkargs <- ((linkargs1 / (KA (freemod)? linkargs (freemod)? KI (freemod)? linkargs1)) (((freemod)? A1 (freemod)? linkargs1))*)")

L("abstractpred <- ((POA (freemod)? uttAx (guoa)?) / (POA (freemod)? sentence (guoa)?) / (POE (freemod)? uttAx (guoe)?) / (POE (freemod)? sentence (guoe)?) / (POI (freemod)? uttAx (guoi)?) / (POI (freemod)? sentence (guoi)?) / (POO (freemod)? uttAx (guoo)?) / (POO (freemod)? sentence (guoo)?) / (POU (freemod)? uttAx (guou)?) / (POU (freemod)? sentence (guou)?) / (PO (freemod)? uttAx (guo)?) / (PO (freemod)? sentence (guo)?))")

L("predunit1 <- ((SUE / (NU (freemod)? GE (freemod)? despredE (((freemod)? geu (comma)?))?) / (NU (freemod)? PREDA) / ((comma)? GE (freemod)? descpred (((freemod)? geu (comma)?))?) / abstractpred / (ME (freemod)? argument (gap2)?) / PREDA) (freemod)?)")

L("predunit2 <- (((NO1 (freemod)?))* predunit1)")

L("NO2 <- (!(predunit2) NO1)")

L("predunit3 <- ((predunit2 (freemod)? linkargs) / predunit2)")

L("predunit <- (((POSHORT (freemod)?))? predunit3)")

L("kekpredunit <- (((NO1 (freemod)?))* KA (freemod)? predicate (freemod)? KI (freemod)? predicate)")

L("despredA <- ((predunit / kekpredunit) (((freemod)? CI (freemod)? (predunit / kekpredunit)))*)")

L("despredB <- ((!(PREDA) CUI (freemod)? despredC (freemod)? CA (freemod)? despredB) / despredA)")

L("despredC <- (despredB (((freemod)? despredB))*)")

L("despredD <- (despredB (((freemod)? CA (freemod)? despredB))*)")

L("despredE <- (despredD (((freemod)? despredD))*)")

L("descpred <- ((despredE (freemod)? GO (freemod)? descpred) / despredE)")

L("senpred1 <- (predunit (((freemod)? CI (freemod)? predunit))*)")

L("senpred2 <- (senpred1 / (CUI (freemod)? despredC (freemod)? CA (freemod)? despredB))")

L("senpred3 <- (senpred2 (((freemod)? CA (freemod)? despredB))*)")

L("senpred4 <- (senpred3 (((freemod)? despredD))*)")

L("sentpred <- ((senpred4 (freemod)? GO (freemod)? barepred) / senpred4)")

L("mod1 <- ((PA2 argument (gap2)?) / (PA2 !(barepred) (guu1)?))")

L("kekmod <- (((NO1 (freemod)?))* (KA (freemod)? modifier (freemod)? KI (freemod)? mod))")

L("mod <- (mod1 / (((NO1 (freemod)?))* mod1) / kekmod)")

L("modifier <- ((mod / kekmod) ((A1 (freemod)? mod))*)")

L("maybebreak <- (V1 ([\'*])? ' ' !((([ ])* V1)))")

L("realbreak <- (!(maybebreak) letter ([\'*])? ((([,])? ' ') / period / &(end)))")

L("consonantbreak <- (C1 ([\'*])? ((([,])? ' ') / period / &(end)))")

L("badspaces <- (!(([,] ' ')) ((!((maybebreak / realbreak)) .))* maybebreak ((!(realbreak) .))* consonantbreak)")

L("namemarker <- ((([ ])* ((L a) / (H OI) / (L OI) / (L OA) / (S IE) / (S IA) / (S IU) / (C i) / (H UE) / (L IU) / (G AO))) !(badspaces))")

L("nonamemarkers <- (([ ])* ((!((namemarker DJAN)) Letter))+ !(Letter))")

L("name <- ((DJAN (((([ ])* (freemod)? CI DJAN) / ((([ ])* (freemod)? CI !(badspaces) (freemod)? predunit) !((&(nonamemarkers) !(AcronymicName) DJAN))) / (([ ])* (freemod)? CI (',' ([ ])+) DJAN) / (&(nonamemarkers) !(AcronymicName) DJAN)))*) (freemod)?)")

L("LA0 <- ((L a) !(badspaces))")

L("LANAME <- (([ ])* LA0 name (gap2)?)")

L("LANAME2 <- (([ ])* LA0 (',' ([ ])+) name (gap2)?)")

L("HOI0 <- (((H OI) / (L OI) / (L OA) / (S IA) / (S IE) / (S IU)) !(badspaces))")

L("voc <- ((([ ])* HOI0 name (gap2)?) / (HOI !(badspaces) (freemod)? descpred (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))? (gap2)?) / (HOI !(badspaces) (freemod)? argument (gap2)?) / (([ ])* HOI0 (',' ([ ])+) name (gap2)?) / (H OI stringnospacesclosedblock))")

L("descriptn <- (!(LANAME) ((LE (freemod)? descpred) / (LE (freemod)? mex (freemod)? descpred) / (LE (freemod)? arg1 descpred) / (LE (freemod)? mex (freemod)? arg1a) / (GE (freemod)? mex (freemod)? descpred)))")

L("abstractn <- ((LEFORPO (freemod)? POA (freemod)? uttAx (guoa)?) / (LEFORPO (freemod)? POA (freemod)? sentence (guoa)?) / (LEFORPO (freemod)? POE (freemod)? uttAx (guoe)?) / (LEFORPO (freemod)? POE (freemod)? sentence (guoe)?) / (LEFORPO (freemod)? POI (freemod)? uttAx (guoi)?) / (LEFORPO (freemod)? POI (freemod)? sentence (guoi)?) / (LEFORPO (freemod)? POO (freemod)? uttAx (guoo)?) / (LEFORPO (freemod)? POO (freemod)? sentence (guoo)?) / (LEFORPO (freemod)? POU (freemod)? uttAx (guou)?) / (LEFORPO (freemod)? POU (freemod)? sentence (guou)?) / (LEFORPO (freemod)? PO (freemod)? uttAx (guo)?) / (LEFORPO (freemod)? PO (freemod)? sentence (guo)?))")

L("arg1 <- (abstractn / (LIO (freemod)? descpred (gap2)?) / (LIO (freemod)? term (gap2)?) / (LIO (freemod)? mex (gap2)?) / (LIO stringnospaces) / LAO / LANAME / (descriptn (freemod)? (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))? (gap2)?) / LANAME2 / LIU1 / LIE / LI)")

L("arg1a <- ((DA / TAI / arg1 / (GE (freemod)? arg1a)) (freemod)?)")

L("argmod1 <- (((__LWinit (N o) ([ ])*))? ((JI (freemod)? predicate (gui)?) / (JIO (freemod)? sentence (gui)?) / (JIO (freemod)? uttAx (gui)?) / (JI (freemod)? modifier (gui)?) / (JI (freemod)? argument (gui)?)))")

L("argmod <- (argmod1 ((A1 (freemod)? argmod1))*)")

L("arg2 <- (arg1a ((argmod (gap2)?))*)")

L("arg3 <- (arg2 / (mex (freemod)? arg2))")

L("indef1 <- (mex (freemod)? descpred)")

L("indef2 <- (indef1 (gap2)? ((argmod (gap2)?))*)")

L("indefinite <- indef2")

L("arg4 <- ((arg3 / indefinite) ((ZE2 (freemod)? (arg3 / indefinite)))*)")

L("arg5 <- (arg4 / (KA (freemod)? argument (freemod)? KI (freemod)? argx))")

L("arg6 <- (arg5 / (DIO (freemod)? arg6) / (IE1 (freemod)? arg6))")

L("argx <- (((NO1 (freemod)?))* arg6)")

L("arg7 <- (argx ((ACI (freemod)? arg7))?)")

L("arg8 <- (!(GE) (arg7 ((A1 (freemod)? arg7))*))")

L("argument <- (((LAU wordset) / (arg8 AGE (freemod)? argument) / arg8) ((GUU (freemod)? argmod (gap2)?))*)")

L("term <- (argument / modifier)")

L("terms <- (term (((freemod)? term))*)")

L("modifiers <- (modifier (((freemod)? modifier))*)")

L("word <- ((arg1a (gap)?) / (UI1 (gap)?) / (NI (gap)?) / (PA2 (gap)?) / (DIO (gap)?) / (predunit1 (gap)?) / indef2)")

L("words <- (word)+")

L("wordset <- ((words)? lua)")

L("termset1 <- ((terms (guu)?) / (KA (freemod)? termset2 (freemod)? KI (freemod)? termset1))")

L("termset2 <- (termset1 ((A1 (freemod)? termset1))*)")

L("termset <- ((terms (freemod)? GO (freemod)? barepred) / termset2 / guu)")

L("kekpred <- (kekpredunit (((freemod)? despredD))*)")

L("barepred <- ((sentpred (freemod)? (termset)?) / (kekpred (freemod)? (termset)?))")

L("markpred <- (PA1 barepred)")

L("backpred1 <- (((NO2 (freemod)?))* (barepred / markpred))")

L("backpred <- (((backpred1 ((ACI (freemod)? backpred1))+ (freemod)? (termset)?) ((((ACI (freemod)? backpred))+ (freemod)? (termset)?))?) / backpred1)")

L("predicate2 <- (!(GE) (((backpred ((A1 !(GE) (freemod)? backpred))+ (freemod)? (termset)?) ((((A1 (freemod)? predicate2))+ (freemod)? (termset)?))?) / backpred))")

L("predicate1 <- ((predicate2 AGE (freemod)? predicate1) / predicate2)")

L("identpred <- (((NO1 (freemod)?))* (BI (freemod)? termset))")

L("predicate <- (predicate1 / identpred)")

L("oneargument <- (((modifiers (freemod)?))? argument ((modifiers (freemod)?))?)")

L("gasent1 <- (((NO1 (freemod)?))* (PA1 (freemod)? barepred ((GA2 (freemod)? oneargument))?))")

L("gasent2 <- (((NO1 (freemod)?))* (PA1 (freemod)? sentpred (modifiers)? (GA2 (freemod)? terms)))")

L("gasent <- (gasent2 / gasent1)")

L("statement <- (gasent / (modifiers (freemod)? gasent) / (terms (freemod)? predicate))")

L("keksent <- (((NO1 (freemod)?))* ((KA (freemod)? sentence (freemod)? KI (freemod)? uttA1) / (KA sentence (freemod)? KI (freemod)? uttA1) / (KA (freemod)? headterms (freemod)? sentence (freemod)? KI (freemod)? uttA1)))")

L("sen1 <- ((modifiers (freemod)? !(gasent) predicate) / statement / predicate / keksent)")

L("sentence <- (sen1 ((ICA (freemod)? sen1))*)")

L("headterms <- ((terms GI))+")

L("uttAx <- (headterms (freemod)? sentence (gap2)?)")

L("freemod <- ((NOUI / (SOI (freemod)? descpred (gap2)?) / DIE / (NO1 DIE) / (KIE (comma)? utterance0 (comma)? KIU) / (([ ])* (H UE) name (gap2)?) / (HUE !(badspaces) (freemod)? descpred (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))? (gap2)?) / (HUE !(badspaces) (freemod)? statement (gap2)?) / (HUE !(badspaces) (freemod)? termset1) / (HUE stringnospacesclosedblock) / (([ ])* (H UE) (',' ([ ])+) name (gap2)?) / voc / CANCELPAUSE / PAUSE / JO / UI1 / (([ ])* '...' ((([ ])* &(letter)))?) / (([ ])* '--' ((([ ])* &(letter)))?)) (freemod)?)")

L("uttA <- ((A1 / IE1 / mex) (freemod)?)")

L("uttA1 <- ((sen1 / uttAx / NO1 / links / linkargs / argmod / (terms (freemod)? keksent) / terms / uttA) (freemod)? (period)?)")

L("neghead <- (NO1 (gap / PAUSE))")

L("uttC <- ((neghead uttC) / uttA1)")

L("uttD <- (uttC ((ICI (freemod)? uttD))*)")

L("uttE <- (uttD ((ICA (freemod)? uttD))*)")

L("uttF <- (uttE ((I (freemod)? uttF))*)")

L("utterance0 <- (!(GE) ((!(PAUSE) freemod (period)? utterance0) / (!(PAUSE) freemod (period)?) / (uttE IGE utterance0) / uttF / (I (freemod)? (uttF)?) / (I (freemod)? (period)?) / (ICA (freemod)? uttF)) ((&(I) utterance0))?)")

L("utterance <- (!(GE) ((!(PAUSE) freemod (period)? utterance) / (!(PAUSE) freemod (period)? ((&(I) utterance))? end) / (uttE IGE utterance) / (I (freemod)? (period)? ((&(I) utterance))? end) / (uttF ((&(I) utterance))? end) / (I (freemod)? uttF ((&(I) utterance))? end) / (ICA (freemod)? uttF ((&(I) utterance))? end)))")


if __name__ == '__main__':interface();
