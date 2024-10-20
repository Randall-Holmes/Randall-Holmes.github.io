# Examples from Loglan 1 to parse with the PEG parser

from loglan import *

#certain examples with additional pauses now fail,
#due to the current state of testing of pause/GUV equivalence.
#there will be a version grammatically insensitive to pauses
#which will handle the entire file.  The problems I was having with
#GE and CUE/GEU are neatly handled, because one *can* safely allow
#a pause before GE or a pause after CUE/GEU for different subtle reasons.

def u(x):  Utter(x)

# p. 57

Utter('sutori')

# Chapter 2 would benefit from a true phonetic version of the parser.

# p. 69

Utteras('Predicate', 'matma')

# p. 71

Utter('menki')
Utter('kicmu')

Utteras('Predicate','mekykiu')

Utter('la Hynt')
Utteras('NameWord','Hynt')

Utter('la Symtrr')
Utteras('NameWord','Symtrr')  #syllabic consonants to be doubled for my parser

# the use of y in ytrio and yterbio was abandoned

# also use of w in wlframo p.77 or indeed anywhere.

# p. 79

Utter('le to mrenu')
Utter('le to junti mrenu')
Utter('letojunti mrenu')  #the one space must be shown to hint at the stress,
#not because it is a pause

Utter("letojun'timrenu")  # without spaces but with stress

# p. 80

Utter('le mrenu, e le botci')

# p. 81

Utter ('la Djan Pol Djonz, mrenu');

Utter('Ia.  I mi kicmu')

Utter('la Ailin')

Utter('le igllu')

# p. 83

Utter('Le, mrenu, e, le, botci')  #not all utterances with commas everywhere
# will parse, but this one does

#p. 84

Utter('Da mrenu')
Utter('Ei da mrenu')

# p. 85

Utteras('LW','e')
Utteras('LW','ia')
Utteras('LW','le')
Utteras('LW','sui')
Utteras('LW','leva')
Utteras('LW','anoi')

# p87 description of compound cmapua remains as described
# but Cvv-V situation is now being avoided

Utteras('LW','Atai')
Utteras('LW','Ateo')
Utteras('LW','Taia')
Utteras('LW','Teoa')  # this fails -- it leaves the a unconsumed

#pp 89-91

# our take on names is different.  They satisfy phonetic rules very
# similar to those on borrowings except that y may be a stressed vowel.
# the only examples in the corpus which have to be spelled differently
# that I have encountered are those related to the rule that syllabic
# consonants must be doubled.  I make no use of close commas.  I regard
# stress and grouping of vowels as the option of the speaker, though the
# parser has its strong preference for monosyllables, and groups to the left,
# not to the right as JCB wants.

Utteras('NameWord','Frans')
Utteras('NameWord','Inglynd')
Utteras('NameWord','Doitclant')
Utteras('NameWord','Uaos')

# p 91 predicate words

Utteras('Predicate','igllu')  #changed before I started work
Utteras('Predicate','trifenilmethani')
Utteras('Predicate','dzoso')
Utteras('Predicate','jmite')
Utteras('Predicate','mrenu')
Utteras('Predicate','srite')
Utteras('Predicate','tsero')
Utteras('Predicate','vlako')
Utteras('Predicate','vrano')
Utteras('Predicate','zvoto')
Utteras('Predicate','zbuma')

# p. 94

Utteras('PREDA','neri')
Utteras('PREDA','tora')
Utteras('name', 'Dainaiza')  #major changes 8/1 introduce acronymic
#names instead of predicates

Utter('La Djan, bi le tsitoa')

# p. 95

Utteras('Predicate','mrecli')
Utteras('Predicate','fuacli')
Utteras('Predicate','mekykiu')
Utteras('Predicate','tsitoa')

#p. 96

Utteras('Predicate','ethili')
Utteras('Predicate','protoni')
Utteras('Predicate','athomi')
Utteras('Predicate','kaiakhu')  #this has the max number of vowels
#I allow after initial C  #fails now as I lowered it to 2 -- Ill raise it again
Utteras('Predicate','atlatlu')

#p. 97

Utteras('Predicate','tarsensi')
Utteras('Predicate','mrenyclika')
Utteras('Predicate','austrralopithekui')

#p. 98

Utteras('Predicate','austrralopithekuiyfoa')
#form of this changed in Appendix H before I started working

# p. 99

Utteras('Predicate','saadja')
Utteras('Predicate','baormao')

# p. 100

Utter('iodapakamla')

Utter('tabragaigra tarsensi')  # the space is mandatory, but it signals the
# stress, not a required pause

#p. 105

Utteras('Predicate','matmymatma')

# p. 187 note 12:  I come down solidly on the side of names being spelled
# as pronounced.  Foreign names with foreign spellings might be used as
# predicates via SAO.

# p. 187 note 15.  This I ignore.  Vowels in names group to the left for me
# and I deprecate very long strings of vowels in any case.

# p. 108

Utter('teproa')

Utteras('Predicate','alkali')
Utteras('Predicate','pasynaodei')  #the -y- must be added, see Appendix H.

# p. 110

Utter('tabra gaigra tarsensi')  #again, the space actually signals stress

Utter("tabragai'gratarsen'si")  # full phonetic representation now supported

# Chapter 3

# 3.3

Utter('Da mrenu')
Utter('Da blanu')
Utter('Da madzo')
Utter('Da madzo de')
Utter('Da blanu de')
Utter('Da madzo de di')

#3.5

Utter('Da pa madzo de')
Utter('Da fa godzi de')
Utter('Da na blanu')
Utter('Da cabro')
Utter('Da fa cabro')

#3.7

Utter ('Da vi madzo de')
Utter('Da fava cabro')
Utter('Da vufa vedma')

# adjacent PA words must either be run together or separated
# by an explicit pause, 5/15 no spaces in words update.

#3.8

Utter('Da pa bloda de')
Utter('De pa nu bloda da')
Utter('Da cluva de')
Utter('De nu cluva da')

Utter('Da fa nu madzo de di')
Utter('Da na nu vedma')

Utter('Di fa madzo de da')
Utter('Da fa fu madzo de di')

Utter('Do pa vedma de di da')
Utter('Da pa ju vedma de di do')

Utter('Da pa nufe ketpi de di do du')

Utter('Da pa ju vedma')
Utter('Da fa fu madzo')
Utter('Da na nu godzi')
Utter('Da nu blanu')
Utter('Da nu cluva')

# 3.9

Utter('Da no pa gudbi mrenu')
Utter('Da no fa bakso madzo')

Utter('Da pa no gudbi mrenu')
Utter('Da fa no bakso madzo')

Utter('Da no fa bakso madzo')
Utter('Da fa no bakso madzo')

#here I worked straight from L1 text and for fun uttered the transcripts too

Utter("Da po mrenu")	#X is a manhood.
Utter("Dapomre'nu")
Utter("Da po de mrenu") #	X is Y's manhood (i.e., the state of Y's being a man).
Utter("dapodemre'nu")
Utter("Da pu gudbi") #	X is a goodness (i.e., a property of something's being good).
Utter("dapugud'bi")
Utter("Da pu de gudbi di") #	X is a/the property of Y's being better than Z.
Utter("dapudegud'bidi")
Utter("Da zo blanu")	#X is an amount of blue.
Utter("dazobla'nu")
Utter("Da zo de blanu") #	X is the amount of blue in Y (i.e., the amount of Y's being blue).
Utter("dazodebla'nu")

Utter("Da corta mrenu") #	X is a short man.
Utter("dacor'tamre'nu")
Utter("Da gudbi matma") #	X is a good mother.
Utter("dagud'bimat'ma")
Utter("Da blanu hasfa") #	X is a blue house.
Utter("dabla'nuhas'fa")

Utter("Da kukra prano") #	X runs quickly (is a fast runner).
Utter("dakuk'rapra'no") 
Utter("Da bilti sucmi") #	X swims beautifully (i.e., is beautiful as a swimmer).
Utter("dabil'tisuc'mi")

Utter("Da mutce corta mrenu") #	X is a very short man.25
Utter("damut'cecor'tamre'nu")

Utter("Da mutce mrenu corta") #	X is a very man-type of short thing (?!).
Utter("damut'cemre'nucor'ta")
Utter("Da corta mutce mrenu") #	X is a shortly very man (??!!).
Utter("dacor'tamut'cemre'nu")
Utter("Da corta mrenu mutce") #	X is a shortly man-type very thing (???!!!).
Utter("dacor'tamre'numut'ce")


Utter("Da bilti cmalo nirli ckela") #	X is a beautifully small girls' school (i.e., a school for girls who are beautifully small).
Utter("dabil'ticma'lonir'licke'la")
Utter("Da bilti ge cmalo nirli ckela") #	X is beautiful for a small girls' school.
Utter("dabil'tigecma'lonir'licke'la")
Utter("Da bilti cmalo ge nirli ckela") #	X is beautifully small for a girls' school.
Utter("dabil'ticma'logenir'licke'la")
Utter("Da bilti ge cmalo ge nirli ckela") #	X is beautiful for a small (type of) girls' school.
Utter("dabil'ti, gecma'lo, genir'licke'la")  # the pauses he wants to put in are not supported

Utter("Da bilti ge cmalo nirli cue ckela")	#X is a beautiful small-girls' school (a school for beautiful small-girls).
Utter("dabil'ti, gecma'lonir'licue, cke'la")


u("Da mrenu go corta") #	X is a man who is short (i.e., a man of the short type).
u("damre'nugocor'ta")

u("Da mrenu go corta de") #	X is a man of a type which is shorter than Y.
u("damre'nugocor'tade")

u("Da hasfa, go blanu de") #	X is a house of a type that is bluer than Y.
u("dahasfa, gobla'nude")

u("Da prano, go kukra de") #	X is a runner of a type who is faster than Y (i.e., X runs faster than Y).
u("dapra'no, gokuk'rade")

u("Da matma go gudbi de")
u("damat'magogud'bide")
# The simplest English translation of this sentence is 'X is a mother who is better than Y.' But better in what? As a mother? Or in general? Of the English, one cannot be sure. Of the sense of the Loglan, we can be sure, for we know how the sentence was formed. Thus just because we know that gudbi is a displaced modifier of matma, we know that the phrase gudbi de--in this sentence at least--means 'better-as-a-mother than Y'. If we wanted to say that X is a mother and better-in-general than Y, we could easily do so. And we shall see how presently. But this is not the way.


u("Da nirli ckela go cmalo")
u("danir'licke'lagocma'lo")
#What does it mean? Exactly what Da cmalo ge nirli ckela means; for it is nothing but an inverted form of the same remark. Thus (7) means exactly what we mean in English when we say that it's a girls' school that is small. From this it follows that (7) must be equivalent to

print('The following examples fail and this is expected:  I do not allow GE to be initial in a top level sentence predicate')


u("Da ge nirli ckela go cmalo") #	X is a girls' school that is small.
u("dagenir'licke'lagocma'lo")
#with its redundant ge. And it is clear that it is. For (8), in turn, is equivalent in meaning to

#Not only is it redundant, it actually fails; we do not allow top level
#sentence predicates to begin with GE

u("Da cmalo ge nirli ckela") #	X is small for a girls' school.
u("dacma'logenir'licke'la")
#as required. Good usage in Loglan requires that we not use punctuation words like ge redundantly. So we will not ordinarily speak sentences like (8) unless we want to point something out in them...as we just have. And of course we would usually use inversion on sentences like (9) only if we then wanted to specify an argument of the modifier cmalo after doing so, as in the sentence below:

u("Da nirli ckela go cmalo de") #	X is a girls' school of a type that is smaller than Y.
u("danir'licke'lagocma'lode")

u("Da ditca, e farfu")
u("dadit'ca, efar'fu")
#the predicate ideas 'is a teacher' and 'is a father' are connected with the conjunction 'and' and with the Loglan word e. (The pause before e is obligatory, by the way, as before all such connecting words.) In Loglan, words of this kind are called connectives, and the simplest of them are the four one-letter words e, a, o, and u. (The fifth one-letter word i has a special connective role between sentences which we will not discuss until Chapter 5.) Making connections in Loglan is very similar to using conjunctions in English, as the following examples show:

u("Da gudbi mrenu, e sadji farfu") #	X is a good man and a wise father.
u("dagud'bimre'nu, esad'jifar'fu")
u("Da groda bakso, a cmalo hasfa") #	X is a large box or a small house, and possibly both.
u("dagro'dabak'so, acma'lohas'fa")
u("Da na clivi, o, na brute") #	X is now alive if and only if it is now breathing.

u("danacli'vi, o, nabru'te")
u("Da na clivi, u, na brute") #	X is now alive whether it is now breathing or not.
u("danacli'vi, u, nabru'te")
#Notice how simply the Loglan connections are made in contrast to the rather elaborate forms of the English connecting phrases. This is because connecting predicates is a grammatically simple operation in Loglan whereas frequently in English it is not.

u("Da fa crina, noa, fa cetlo") #	That X will be rained on implies (that it) will be wet.
u("dafacri'na, noa, facet'lo")

u("Da no fa crina, a, fa cetlo") #	X will not be rained on and/or will be wet.
u("danofacri'na, a, facet'lo")

u("Da redro, e blanu")	#X is red and blue.
u("dared'ro, ebla'nu")
u("Da redro ze blanu") #	It is (mixed) red-and-blue.
u("dared'rozebla'nu")
#The linkage with ze is not a connection in the logical sense at all. For a connection, we have seen, involves a claim about (at least) two other claims about the world, and sentence (4) asserts only one claim, namely that X is red- and-blue. There are many mixtures of properties in nature. In Loglan we use mixed predicates to talk about them:

u("Da pa dzoru ze prano de")#	X walked-and-ran to Y.
u("dapadzo'ruzepra'node")

u("Da tigra ze simba") #	It's a mixture of a tiger and a lion.
u("datig'razesim'ba")

u("Da gudbi ce sadji farfu") #	X is a good and wise father.
u("dagud'bicesad'jifar'fu")

u("Da groda ce redro bakso") #	X is a big, red box (i.e., big and red).
u("dagro'dacered'robak'so")
u("Da kamla ca godzi, trena") #	X is a coming or going (pause) train.
u("dakam'lacagod'zi, tre'na")

u("Da trena, go kamla ca godzi") #	X is a train which is coming or going, and possibly both.
u("datre'na, gokam'lacagod'zi")

u("Da forli cu kukra, prano") #	X is a strong--whether fast or not--runner.
u("dafor'licukuk'ra, pra'no")
u("Da clivi co brute, nimla") #	X is a living--if and only if a breathing--animal.
u("dacli'vicobur'te, nim'la")

u("Da crina noca denli cetlo") #	X is a rainy--only if a wet--day.
u("dacri'nanocacet'loden'li")

u("Da gudbi mermeu, e gudbi farfu") #	X is a good husband (married-man) and a good father.
u("dagud'bimerme'u, egud'bifar'fu")

u("Da gudbi mermeu ce farfu") #	X is a good husband and father.
u("dagud'bimerme'ucefar'fu")

u("Da bilti cmalo ci nirli ckela") #	X is a beautiful small-girls' school (a school for beautiful small-girls).
u("dabil'ticma'locinir'li, cke'la")

u("Da mutce ci sadji ce gudbi farfu") #	X is a very-wise, and a good, father.
u("damut'cecisad'jicegud'bifar'fu")
u("Da mutce ce gudbi ci sadji farfu") #	X is an extreme, and a wisely good, father.
u("damut'cecegud'bicisad'jidar'fu")
#In contrast, cui is like a left-parenthesis: it announces the beginning of a string of two or more predicate words which will ultimately be connected to an ensuing word or string of words. Thus the sense of (2) can be equally well conveyed by:

u("Da cui mutce sadji ce gudbi farfu") #	X is a (very wise) and a good, father.
u("dacuimut'cesad'jicegud'bifar'fu")
#If we wish to extend the scope of an internal connective beyond both of the single predicate words adjacent to it, we may either use ci's on both sides (the pauses are phrasing pauses and optional and nurmue [NOOR-mweh] is derived from nu mutce and means 'moderate' or 'moderately'),

u("Da nurmue ci gudbi, ce mutce ci sadji farfu") #	X is a moderately-good, and very-wise, father.
u("danur'muecigud'bi, cemut'cecisad'jifar'fu")
#or a cui on the left and a ge...cue pair on the right:

u("Da cui nurmue gudbi, ce ge mutce sadji cue, farfu") #	X is a moderately good, and a very wise, father.
u("dacuinur'muegud'bi, cegemut'cesad'jicue, far'fu")
#Some Loglanists prefer the hyphen-like word ci over the parenthesis-like cui and ge...cue because linking with an infix like ci is usually more economical. But there are some things that cannot be said with ci. These can always be said with the bulkier apparatus of cui and ge...cue. In the interests of logical completeness, then, as well as multiplying our options, these two systems of grouping words and extending the scope of connectives exist side by side in Loglan.

#Consider a final example. In this one the Loglan pattern of spoken hyphens is very similar to a rare but unequivocal style of written English:

u("Da sadji, ce mutce ci gudbi junti ci mermeu, ce farfu")#	X is a wise and very-good young-husband and father.
u("dasad'ji, cemut'cecigud'bijun'ticimerme'u, cefar'fu")

u("Da kukra ge torkrilu dampa") #	X is fast for a bicycle pump.
u("dakuk'ragetorkri'ludam'pa")

u("Da kukra torkrilu ci dampa") #	X is a fast bicycle- pump.
u("dakuk'ratorkri'lucidam'pa")
u("Da kukra ce torkrilu dampa")	#X is (both) a fast (pump) and a bicycle pump.
u("dakuk'racetorkri'ludam'pa")
u("Da bilti ce cmalo nirli ckela")	#It's a beautiful and small girls' school (that is, a school for girls who are beautiful and small).
u("dabil'ticecma'lonir'licke'la")
u("Da bilti ce cmalo ge nirli ckela") #	It's beautiful and small for a girl's school.
u("dabil'ticecma'logenir'licke'la")
