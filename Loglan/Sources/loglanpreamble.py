# recent updates

#try out the new interface.   It does basically everything that
#I typically exit to the shell for :-)

#  Termination testing is now enabled.  This version is now independent
# of the ML version.  I have also added the ability to export PEG files
# and to run PEG files using the grammarbatch command.

# to run a file of utterances (one per line) as
# batch, exit the interface and use the filebatch(Yourfilename) command--
# it will read from Yourfilename.txt and output to Yourfilename.llg
# lines beginning with # are comments that are preserved,
# those beginning with % are commants to throw away
# output files can be renamed as .txt and run again!
# with care, you can continue lines with backslashes.

# if you edit Yourfilename.llg then run revbatch('Yourfilename')
# it will rewrite Yourfilename.txt with your changes and without the
# parses (so you can run filebatch again).

# to see the parse of a *word* exit the interface and type
# borrow("<YourWord>")  I suggest double quotes because the single
# quote is the apostrophe, which can appear as a stress marker in a
# word.  One of the uses of this is to test possible syllable break
# and stress patterns.

# 5/16 main parser loglan.py and test parser loglantest.py
# the main parser has a different treatment of guu,
# also in the test parser, with few effects.
# gui closes afterthought linked chains of subordinate clauses,
# including chains of one, which is what it should have done all along. In general
# terms, the main parser is less likely to absorb closers
# unexpectedly; a simple gu is more likely to do what you want.
# the test parser has a different treatment of guo,
# and does not allow an untagged argument to be added
# to a termset if it would begin a non-gasent sentence.
# This means that the "main verb" does not close LEPO
# or subordinate clause structures;  it recovers intended
# parses in the Visit very frequently.  The marker GAA after
# a subject turns off the termset closure protection; new
# jiza...guiza (also with i and u) allow closure of nested
# subordinate clauses with one closer.

# 12/6 new ability to export to a PEG file from the interface.
# new function grammarbatch will run a PEG file directly
# (this is not in the interface!)

# 5/9 added new closures.  Fixed double closure bug with linkargs1.
# final tweaks to arg2, and to LIO argl's.

# 5/8 removed gap closure of names, which is almost always unneeded.

# 5/7 sentence scope negation extended to sen1.  Other rationalizations
# of utterance structure.  neghead requires gu if the negation would
# otherwise form a predunit2.

# 5/6 various technical refinements.  ao-o and au-u are allowed.
# IGE rationalized (I think) as looser than I.
# CII1 rule deleted.
# Acronym refined to allow pauses followed by mue in long acronyms.

# 5/5/17 slight repair to IE behavior in SA class.  Forced pauses
# before legacy vowel names outside of acronyms
# by adding them to class connective.

# 5/4/2017 tweak to stringnospaces to allow commas not followed
# by spaces in alien text; eliminated redundant FinalConsonants2 rule.

# additional tweak to punctuation in NOUI.  Added Greek vowels.

# 5/1/2017 rationalization of the sentpred/descpred distinction.

# 4/28/2017 simplified the grammar by moving IE into class SA
# (with some subtleties).  Refined rules for capitalization so that
# they work in "word" classes which allow internal pauses.

# 4/27/2017 added additional articulation of CVCy hyphenated syllables
# as CV-Cy, alternative to CVC-y.  This allows one to avoid the syllable-
# final allophone of h.  Rules Cfinal and CVCStressed are modified.  Also
# fixed bug in VV vowel pairs for cmapua which allowed them to be followed
# without pause by a vowel-initial predicate.

# 3/18/2017 added ability to convert and negate PA words not in class
# KOU:  convert with NU- prefix, negate with -NOI suffix.  The use of a
# suffix avoids the special phonetic problems of the negated KOU
# words (which we can live with for six special roots, four of which
# are common in existing text, for the time being.)

# also a subtle bug fix in JELINK and JUELINK:  a JE PA phrase should
# not fail if followed by a barepred, as a PA clause without an argument
# validly does.

# 3/9/17 added CIU and MOU to class KOU to allow formation of words listed
# in paradigm K.  Fixed a bug with KOUKI forethought connectives, preventing
# the KOU- part from being read as a modal operator.

# 11/19/16 extensive systematic changes which should not affect
# parsing behavior at all.  Class __LWbreak deleted and replaced with !connective.
# Occurrences of !Oddvowel omitted except in cmapua vowel pairs TAI0 and TAI.

# 11/4/2016 very minor fix to period class, replacing an indirect
# description of invvoc with invvoc itself, fixing a slight bug

# 9/24/2016 the rule requiring pauses between a finally stressed
# cmapua and a predicate applies only to consonant initial predicates.
# This fixes a bug.

# 9/19 another refinement of the definition of commas
# which are freemods, previous definition was messing up
# phonetic transcripts with name final segments.

# 9/18  a tiny bug fix to UI0, inserting check that it doesn't start
# a predicate.  Allows <no aurmo> to parse.  Hard to detect as VV
# initial predicates are rare!

# 9/16/2016 A round of minor changes motivated by observations
# made in the reference grammar or in commenting the latest version
# of the PEG.  This includes debugging a problem with serial names
# created by the recent change in handling in pauses due to a bug
# in APA words.  I hope it is all stabilized!

# 8/30/2016 A bug fix to the rule for arg7 (ACI connected arguments)

# 8/30 2016 alternative parsers loglantest1, loglantest2 supported which
# deal with the problem that most SOV parses are actually unintended
# by changing or restricting the SOV construction in different ways.

# 6/25/2016 implemented function which looks for the point of
# first parse failure in a backhanded way.

# 7/23/2016 restricted the term keksent alternative in uttA1 to
# modifiers keksent.  Retooled the definition of uttD so that an
# uttE which is actually a sentence is parsed as a single uttD component,
# properly labelled as a sentence.

# 7/23/2016 corrected juncture to juncture2 in rules A0, TAI0 to enforce
# pause-after-stress-before-predicate rule.

# 2/27/2016  LE compound words eliminated.  New interface2 has same
# extra functionality as interface, guarding parser output.

# 2/18/2016  a bit behind on documenting updates.  Complete overhaul
# of APA;  APA words are now closed with either a comma pause or -FI
# and there is no obligation to pause between A connectives and following
# PA words.  There are some tricky technical rules defending
# against ambiguity with the legacy APA(pause) words, but they are
# much less likely to raise errors than the previous APA fix (except
# that they do catch unclosed APA words in legacy text).  Also updated
# behavior of parser when a name marker precedes a vowel initial word,
# when of course there is a pause (but CANCELPAUSE can be used).

# 2/12/2016 very slight fix to HasCCPair:  it was accepting certain
#bad borrowings if the initial CC joint was broken by a hyphen!

# 2/11/2016 a solution for ordered and unordered lists installed.

# 2/11/2016 what I hope is the completely final word on default syllabification
# of names and borrowings and prevention of creation of legal borrowings
# by bad structure breaks in precomplexes.

# a Predicate cannot be followed immediately by y (to avoid
# confusion with an initial borrowing affix).  

# modified final consonants class and its use so that the default
# syllabification of borrowings is allowed as an explicit syllabification
# by JunctureFix.  This should make things more intelligible :-)

#also fixes to final CCV and CVV so that borrowings extending complexes with
#vowels will be recognized when stress is explicit

#bug fix in JunctureFix and HasCCPair

#fixed a bug in CCVCVMedial.  Enforced stress rules on numerical predicates.
#they allow some freedom when final bit before the RA is ma or moa.

# fixes to certain djifoa classes, hyphens were omitted from subclass definitions.
# global fix to representation of stresses and syllable breaks.

# 2/7/2016  fixed trailing spaces issue once and for all.  Repaired the technical rule
# JunctureFix in a way that no one may ever notice.   Made ne, tori mean the expected thing.
# also fixed silliness with syllabic consonants no one would be likely to try.

# added the silence/change of voice marker #.  This absolutely
# cannot appear in quoted Loglan speech.  Note that in batch files
# the # initially makes a comment, but # later in a line will be change of
# voice.

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

mainclass='utterance'

def utter(s):
    global TheString
    global verbose
    global shallow
    global mainclass
    while not(s=='') and (s[len(s)-1]==' ' or s[len(s)-1]=='\r' or s[len(s)-1]=='\n'):s=s[0:len(s)-1]
    if s=='': return ''
    return printparse(Parse(loglan,mainclass,s))

def uttertest(s):
    global TheString
    global verbose
    global shallow
    global mainclass
    while not(s=='') and (s[len(s)-1]==' ' or s[len(s)-1]=='\r' or s[len(s)-1]=='\n'):s=s[0:len(s)-1]
    if s=='': return ''
    out=printparse(Parse(loglan,mainclass,s))
    if not out == 'fail\n':
        print(s)
        return printparse(Parse(loglan,mainclass,s))
    if not len(s)==0 : return uttertest(s[0:len(s)-1])
    return 'fail\n'

def utteras(c,s):
    global TheString
    return printparse(Parse(loglan,c,s))

def utteras2(c,s):
    global TheString
    x=Parse(loglan,c,s)
    if not(x[1]==len(s)):  return 'fail'
    return printparse(Parse(loglan,c,s))

def Showrule(s):
    print(s+ "<-" + showrule(loglan[s]))

Shallow()

def niceprecs():
    Compact('TAI0')
    Compact('A1')
    Compact('ACI')
    Compact('AGE')
    Compact('CA')
    Compact('ZE2')
    Compact('I')
    Compact('ICA')
    Compact('ICI')
    Compact('IGE')
    Compact('KA')
    Compact('KI')
    Compact('NI')
    Compact('mex')
    Compact('CI')
    Compact('TAI')
    Compact('DA')
    Compact('IE1')
    Compact('PA1')
    Compact('PA2')
    Compact('PA3')
    Compact('LE')
    Compact('LEFORPO')
    Compact('LIO')
    Compact('LAO')
    Compact('LOU')
    Compact('LUA')
    Compact('LUO')
    Compact('ZEIA')
    Compact('ZEIO')
    Compact('LI1')
    Compact('LU1')
    Compact('stringnospaces')
    Compact('stringnospacesclosed')
    Compact('LAO1')
    Compact('LIE1')
    Compact('CII1')
    Compact('LIU1')
    Compact('CUI')
    Compact('GA2')
    Compact('GE')
    Compact('GEU')
    Compact('GI')
    Compact('GO')
    Compact('GIO')
    Compact('GU')
    Compact('GUI')
    Compact('GUO')
    Compact('GUOA')
    Compact('GUOE')
    Compact('GUOI')
    Compact('GUOO')
    Compact('GUOU')
    Compact('GUU')
    Compact('GUE')
    Compact('JE')
    Compact('JUE')
    Compact('JI')
    Compact('JIO')
    Compact('DIO')
    Compact('ME')
    Compact('NU')
    Compact('PO')
    Compact('PO')
    Compact('POA')
    Compact('POE')
    Compact('POI')
    Compact('POO')
    Compact('POU')
    Compact('POSHORT')
    Compact('DIE')
    Compact('HOI')
    Compact('JO')
    Compact('KIE')
    Compact('KIU')
    Compact('SOI')
    Compact('SUE')
    Compact('NOUI')
    Compact('UI1')
    Compact ('HUE')
    Compact('NO1')
    Compact('DJAN')
    Compact('BI')
    Compact('PREDA')
    Compact('LA0')
    Compact('HOI0')
    Compact('HUE0')
    Compact('CI0')
    Compact('LAE')
    Compact('DIO2')
    Compact('Name')
    Compact('NameWord')
    Compact('PreName')
    Compact('Borrowing')
    Compact('Complex')
    Compact('Cmapua')


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
    MakeImportant('argumentA')
    MakeImportant('argumentB')
    MakeImportant('argumentC')
    MakeImportant('argumentD')
    MakeImportant('argumentE')
    MakeImportant('barepred')
    MakeImportant('predicate')
    MakeImportant('statement')
    MakeImportant('sentence')
    MakeImportant('freemod')
    MakeImportant('uttC')
    MakeImportant('uttF')
    MakeImportant('termsA')
    MakeImportant('DefaultStressedSyllable')
    MakeImportant('imperative')


Indent()
niceprecs()

# Greedy()  # will parse slowly, a disagreement with the usual parse
#indicates a formal problem with the grammar

# Verbose()  #this would suppress class names

def Utter(x):
    global mainclass
    if x=='': return ''
    print(x)
    print(' ')
    print(utter(x))
    print('Parser cache size '+str(len(thecache)))
    print('------')

def Uttertest(x):
    global mainclass
    if x=='': return ''
    print(x)
    print(' ')
    print(uttertest(x))
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
    Utteras('PreName',s)
    print('\nparse as cmapua:\n\n')
    Utteras('LW',s)

thelog=open('dummylog','a')

def setlog(s):
    global thelog
    thelog = open(s+'log.txt','a')
    
def interface():
 global mainclass
 done = False
 while 0==0:
    item=input('Type an utterance to parse (or ... to exit, ? for command help):\n')
    done = False
    if item == '...': return 'done'
    if not item == "" and item=='?':
        print("? for help\n% (filename)\
to open log file (filename)log.txt\
\n# comment to comment to the log\n\
?? for verbose parses\n!! to restore terse parses and default class\n\
| to toggle verbosity (display of class names)\n\
* (rule name) to show a parse rule\n@ (PEG rule) to edit the grammar (eep!)\n\
$ (file name) to export your rules to a new executable \
(filename).py\n\
` (file name) to export your rules to (file name).peg\n \
>(file name) to run a batch file .txt extension (output to .llg file)\n\
< file name to save edits to an .llg file back to the text file \n\
:(word) to parse a word\n\
^(grammar class) change default class from utterance to (grammar class)\n\
&(line)  utter (line) without logging\n\
?(line) uttertest line --\n this will parse the longest initial segment without failure\n\
don't do this on long utterances, it would be very slow\n\
...to exit")
        done = True
    if not item =='' and item[0]==":":
        borrow(item[1:])
        done = True
    if item=="??":
        Decompact()
        done = True
    if item=="!!":
         niceprecs()
         mainclass='utterance'
         done = True
    if not item == '' and item[0]==">":
        filebatch(item[1:])
        done = True
    if not item == '' and item[0]=="<":
        revbatch(item[1:])
        done = True

    if not item == '' and item[0]=='*':
        Showrule(item[1:])
        done=True
    if not item == '' and item[0]=='@':
        L(item[1:])
        done=True
    if not item == '' and item[0]=='$':
        saverules(item[1:])
        done=True
    if not item == '' and item[0]=='`':
        saverules2(item[1:])
        done=True
    if not item=='' and item[0]=='%':
        setlog(item[1:])
        done=True
    if not item=='' and item[0]=='#':
        thelog.write(item+'\n\n')
        done=True
    if not item=='' and item[0]=='^':
        mainclass=item[1:]
        done=True
    if not item=='' and item[0]=='&':
        Utter(item[1:])
        done=True
    if not item=='' and item[0]=='?':
        Uttertest(item[1:])
        done=True
       
    if item=='|':
        Verbose()
        done=True
    if not done==True:
        thelog.write(item+'\n\n')
        Utter(item)
    

def Utter2(x):
    if x=='': return ''
    print(x)
    print(' ')
    print(commentize(utter(x)))
    print('Parser cache size '+str(len(thecache)))
    print('------')

def Uttertest2(x):
    if x=='': return ''
    print(x)
    print(' ')
    print(commentize(uttertest(x)))
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
 global mainclass
 done = False
 while 0==0:
    item=input('Type an utterance to parse (or ... to exit, ? for command help):\n')
    done = False
    if item == '...': return 'done'
    if not item == "" and item=='?':
        print("? for help\n% (filename)\
to open log file (filename)log.txt\
\n# comment to comment to the log\n\
?? for verbose parses\n!! to restore terse parses and default class\n\
| to toggle verbosity (display of class names)\n\
* (rule name) to show a parse rule\n@ (PEG rule) to edit the grammar (eep!)\n\
$ (file name) to export your rules to a new executable \
` (file name) to export your rules to (file name).peg\n \
loglantest(filename).py\n\
>(file name) to run a batch file .txt extension (output to .llg file)\n\
< file name to save edits to an .llg file back to the text file \n\
:(word) to parse a word\n\
^(grammar class) change default class from utterance to (grammar class)\n\
&(line)  utter (line) without logging\n\
?(line) uttertest line --\n this will parse the longest initial segment without failure\n\
don't do this on long utterances, it would be very slow\n\
...to exit")
        done = True
    if not item =='' and item[0]==":":
        borrow2(item[1:])
        done = True
    if item=="??":
        Decompact()
        done = True
    if item=="!!":
         niceprecs()
         mainclass='utterance'
         done = True
    if not item == '' and item[0]==">":
        filebatch(item[1:])
        done = True
    if not item == '' and item[0]=="<":
        revbatch(item[1:])
        done = True

    if not item == '' and item[0]=='*':
        Showrule(item[1:])
        done=True
    if not item == '' and item[0]=='@':
        L(item[1:])
        done=True
    if not item == '' and item[0]=='$':
        saverules(item[1:])
        done=True
    if not item == '' and item[0]=='`':
        saverules2(item[1:])
        done=True
    if not item=='' and item[0]=='%':
        setlog(item[1:])
        done=True
    if not item=='' and item[0]=='#':
        thelog.write(item+'\n\n')
        done=True
    if not item=='' and item[0]=='^':
        mainclass=item[1:]
        done=True
    if not item=='' and item[0]=='&':
        Utter2(item[1:])
        done=True
    if not item=='' and item[0]=='?':
        Uttertest2(item[1:])
        done=True
    if item=='|':
        Verbose()
        done=True
    if not done==True:
        thelog.write(item+'\n\n')
        Utter2(item)

xxx=open('dummy','w')
xxx.write('')
xxx.close()

thefile = open('dummy','r')

theout = open('dummy2','w')

therules = open('dummy2','w')

def opening(s):
    global thefile
    thefile=open(s+'.txt','r')

def openout(s):
    global theout
    theout=open(s+'.llg','w')

def openrules(s):
    global therules
    therules = open(s+'.py','w')

def openrules2(s):
    global therules
    therules = open(s+'.peg','w')

def saverules(s):
    global therules
    openrules(s)
    therules.write('from loglanpreamble import *\n\n')
    for r in loglan:
        therules.write('L("'+r+' <- '+showrule(loglan[r])+'")\n\n')
    therules.write("if __name__ == '__main__':interface();")
    therules.close()

def saverules2(s):
    global therules
    openrules2(s)
    #therules.write('from loglanpreamble import *\n\n')
    for r in loglan:
        therules.write(r+' <- '+showrule(loglan[r])+'\n\n')
    #therules.write("if __name__ == '__main__':interface();")
    therules.close()

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

def Loglan():
     global loglan
     return loglan

def grammarbatch(gfile):
    global loglan
    loglan = {}
    thefile=open(gfile+'.peg','r')
    for line in thefile:
        print ('('+line+')')
        line1=line
        while not line1=='' and (line1[len(line1)-1]==' ' or line1[len(line1)-1]=='\n' or line1[len(line1)-1]=='\r'):line1=line1[0:len(line1)-1]
        while not line1=='' and line1[0]==' ':line1=line1[1:]
        if not(line1=='' or line1[0]=='#'):  rundef(loglan,line1)
    
