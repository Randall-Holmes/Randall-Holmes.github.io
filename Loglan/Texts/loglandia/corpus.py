

from draftgrammar import *

#  9/24  The actual parses (for both versions) need to be checked
#  over in all examples with pause/GU equivalence intended.  The 9/22
#  and 9/24 revisions have strong effects on how this works.

# 9/20/2014  PO always long scope.  changes mostly involve putting in poi for short scope po.

# 5/15/2015:  fixed an occurrence of ANOIGE with an internal space,
# rejected by the 5/15 update of the parser.

# version of 8/2/14:  fixes a nasty bug in acronyms created by the 8/1 edit;
# fixes an unrelated missing freemod bug which broke words like icebuo
# reintroduces mandatory MUE before dimensions
# some cosmetic fixes to comma and period rules

# version of 8/1/14:  changes to acronymns.  Comments still need to be changed.

# uses new indented display.  I also made the shallow setting report
#only outermost classes, which makes it less cluttered.  4/21 further
# tuning of shallow display and fixed recursion so it runs faster.
# added some missing medial freemods (notably to sentence)

#  corpus of parsed Loglan sentences using PEG grammar.
#starting with sentences in the NB3 appendix.

#grammar repair 3/39/2014 allows commas to be omitted
#between name words in a serial name

#  NB3 appendix

#A Imperatives and Responses

Utter ('Hapci!')

Utter('Eo skitu')

Utter('Stali eo')

Utter('Hompi ti')

Utter('Ao kerju tu')

Utter('Ai mi kerju mi')

Utter('Eo helba mi')

Utter ('Ao no mi helba tu')

Utter('No takna')

Utter('Ae no takna mi')

Utter('Eo no godzi')

Utter('No totco mi')

Utter('No mi totco tu')

Utter('Ae no mi puncko tu')

Utter('Eo no nordri mi')

Utter('No eo nordri mi')

Utter('No nordri eo mi')

Utter('No nordri mi eo')

#B  Address and Response, offers and replies

Utter('Hoi Djim')  #no unmarked vocatives now

Utter('Loi')

Utter('Eo nenkaa')  # definition is exactly wrong in the dictionary?

#nenkaa should be enter?

Utter('Sia ai')

Utter('Loi, hoi Fred')

Utter('Hoi Djin, loi')

Utter('Sia, hoi Ted')

Utter('Oi resto')

Utter('Sia ao no')  # should this be no ao?

Utter('Oi titci ti')

Utter('Sia ao')

Utter('Siu, hoi Selis')

Utter('Sia ae no')

Utter('Ea mu godzi')  # corrected old form(?) gotso in original

Utter('Ao')

Utter('Eo mi titci ti')

Utter('Oi')

Utter('Eo no mi titci ti')

Utter('Oi no')

Utter('Loa, hoi Tcet')

#  C. addressing versus naming

Utter('Hoi Djan, santi')

Utter('La Djan, santi')

Utter('Prano, hoi Mel')

Utter('Prano la Mel')

Utter('Prano ta, hoi Mel')

Utter('Prano ta hoi Mel, e ti hoi Pol')

Utter('Hoi Keit, skesa mi')

Utter('Skesa hoi Keit, mi')

Utter('Skesa mi hoi Keit')  #c09 and c10 same for us now

Utter('Skesa la Bab, hoi Keit')  # again, c11 and c12 are the same for us

Utter('Hoi Karl, kukra la Dik')

Utter('La Karl, kukra la Dik')

Utter('La Stivnn, sunho hoi Ruf')  #vocalic consonants are doubled now

Utter('La Stivnn, sunho la Ruf')

Utter('La An, takna la Ritcrrd, mi')

Utter('Hoi An, takna la Ritcrrd, mi')

Utter('La Djeik, farfu hoi Djan, mi la Suznn')

Utter('La Djeik, farfu la Djan, mi hoi Suznn')

Utter('Hoi Mel, prano la Djan Pol Djonz')  

Utter('Prano la Djan Pol Djonz, hoi Mel')  #removing unmarked vocatives removes the point of C22

# D, descriptions

Utter('Bleka le nirda')

Utter('Eo penso le nable')

Utter('Eo penso ne nable')

Utter('Eo penso su nable')

Utter('Ai mi ckano le bunbo')

Utter('Mi driki le purda')

Utter('La Celdnn, godzi le sitci')

Utter('Le rodlu ga gudbi le fitrua')

Utter('Le ditca ga fundi mi le groda')

Utter('Le troli ga plizo la Frenk, ne mipli')

Utter('Le tcaro ga djipo le ponsu le kolro')

#E questions with HE, demonstratives and plurals, replacement with DA

Utter('tu he')
Utter('Mi djela')
Utter('Ta he')
Utter('Da muzgi')
Utter('Le cersi ga he')
Utter('Da komfu')
Utter('Da he komfu')
Utter('Da nurmue komfu')
Utter ('Le nurtci he')
Utter('Le nurtci herba')
Utter('Le botci ga he sucmi')
Utter('Le botci ga tarle sucmi')
Utter('Leva he tcaro')
Utter('Leva tcaro he')
Utter('Levi ri herba ga he')
Utter('Da vendu')
Utter('Leva ro junti na he')
Utter('Da na takna')

#F  identity questions and sentences; replacement with de and dui

Utter('Da mrenu')
Utter('Ie da')
Utter('La Bab')
Utter('Ie la Bab')
Utter('La Bab, bi le hapci')
Utter('Da hapci hu')
Utter('Le ckela')
Utter('Ie le ckela')
Utter('Le cninu ckela')
Utter('Ta bi le cninu ckela')
Utter('La Selis, cluva')
Utter('Da cluva hu')
Utter('Da cluva la Pit')
Utter('I de cluva hu')
Utter('La Alis')
Utter('Ie la Alis')
Utter('La Muhamed Alis')

Utter('Da godzi la Italias')
Utter('Da godzi de hu')
Utter('Da godzi de la Danmark')
Utter('Hu matma leva botci')
Utter('Ti dui')
Utter('Mi gudbi tu')
Utter('Tu gudbi mi hu')
Utter('Mi gudbi tu ti')

# G  Yes/no questions and answers, utterance demonstratives

Utter('Ei ti breba')
Utter('Ia da breba')
Utter('Ei ti ckela')
Utter('No.  I da hasfa')
Utter('Ei ta hasfa')
Utter('Ia no.  I da vemsia')
Utter('Ei tu cidja')
Utter('No.  I mi sonli')
Utter('Ei tu cluva mi')
Utter('Ia mi cluva tu')
Utter('Ei toi tradu')
Utter('Ei toa logla')

# H  tenses, time questions and answers, local modification, punctuation

Utter('Ei tu na bleka mi')
Utter('No.  Ibuo mi fa bleka tu')  # buo is a new form
Utter('Ei tu pa tidjo mi')
Utter('Ia mi pa mutce tidjo tu')
Utter('Eo tu fa helba mi')
Utter('Ai mi fa helba tu')
Utter('Mi groda tu')
Utter('Tu nahu groda mi')
Utter('Mi groda tu fa ti')
Utter('Mi penso toi fa')
Utter('Na gi mi penso da')
Utter('Na mi, penso da')
Utter('Na mi penso da')
Utter('Na gi la Djan, totco tu')
Utter('Na la Djan, totco tu')
Utter('Mi na totco tu')
Utter('Mi ji na, totco tu')
Utter('Mi na fundi tu ji pa')
Utter('Mi no fundi tu pa')
Utter('Ei tu na saadja toi')
Utter('Ia mi dui')
Utter('No mi dui')

#I Time Phrases

Utter('Ai mi ditca')
Utter('Nahu')
Utter('Fa la Netomen')
Utter('Pa la Torin')
Utter('Na le monza')
Utter('Pahu')
Utter('Pa le natli')
Utter('Fahu')
Utter('Fa le cimra')
Utter('Fazi')
Utter('Fa la Nevesonin')
Utter('Na tio gi mi fa clafo')  #why tiu?
Utter('Fa ta gi ti rodja')
Utter('Fa ta, rodja')
Utter('Fa gi ti rodja')
Utter('Ti fa rodja')
Utter('Mi kicmu pazu tu')  # I think this might equally mean
# I was a doctor long before you were born.  In fact, I think this more likely.
Utter('Ai mi fa traci na la Nenimen')
Utter('Na la Nenimen, gi mi fa traci la Frans') # comma omitted in original
Utter('Mi fa traci da pa la Netomen')
Utter('Mi fa traci pa la Netomen, da')  #comma omitted in original

#J  Space Questions, Answers, Phrases

Utter('La Djan, titci vi')
Utter('Ei tu stolo vi')
Utter('No.  I mi stolo va')
Utter('Ei tu stude vi')
Utter('No.  I mi stude vu')
Utter('Ei tu ji vi, stude')
Utter('Vihu tu sonli')
Utter ('Va tu')
Utter('Vi le hasfa')
Utter('Vahu')
Utter('Va la Rain')
Utter('Vuhu')
Utter('Vu le mursi')
Utter('Vi la Ditroit, gi da pa malbi')
Utter('Da pa zbuma va le vrici')
Utter('Da na genbalci de vu le monca')
Utter('Da na genbalci de ji vu le monca')

#K  Existentials and Universals, completion

Utter('Ba najda')
Utter('Ei ba smano')
Utter('Ia ba smano')
Utter('Ei ba breba')
Utter('Ia.  I ba breba vi')  #this motivated the 4/3/14 fix
Utter ('Ei ba bukcu vi')
Utter('Uu no ba bukcu vi')

Utter('No ba cutri vina')
Utter('Vihu ba najda')
Utter('Ba najda vi levi drara')
Utter('Nahu ba nilboi')
Utter ('Ba nilboi na la Nevevonin')
Utter('Ei raba cninu')

Utter('No.  I ba no cninu')
Utter('Ei raba cluva rabe')
Utter('No.  I ba no cluva rabe')
Utter('Ifeu ba no cluva be')
Utter('Ei raba kunci be')  # is it really someone *else*?
Utter('No.  I ba kunci ni be')
Utter('Raba gudbi be bo')
Utter('Ba pasylinkui rabe bo')  #paslinkui becomes pasylinkui
Utter ('Ba vegri be rabo')  #parses but I dont think vegri has this argument
Utter('La Djan, godzi la Frans')
Utter('Inusoa, de godzi da ba')
Utter('Ti groda')
Utter('Inusoa, da groda ba be')
Utter('Ti bitsa')
Utter('Inusoa, da bitsa ba be')
Utter('Ti vedma')
Utter('Inusoa, da vedma ba be bo')
Utter('Ti racyketpi')  #another place where the y must be inserted
Utter('Inusoa, da ketpi ba be bo bu')
Utter('Mi no vizka')
Utter('Inusoa, mi no vizka raba rabe')

#L  Predicate strings, grouping, hyphenation, connection and inversion

Utter('La Frans, grada gunti')
Utter('Da he grada gunti')
Utter('Da bilca grada gunti')
Utter('La Spat, simba janto kangu')
Utter('Da he simba janto kangu')
Utter('Da frika simba janto kangu')
Utter('Da cmalo ge janto kangu')
Utter('Da cmalo janto ci kangu')
Utter('La Mmbelis, dorja cefli')  #syllabic consonant doubled
Utter('Da he dorja cefli')
Utter('Da he ge dorja cefli')
Utter('Da ckano ge dorja cefli')
Utter('Da junti ge terla famvo bilra')
Utter('Da kusti ge slano torkrilu ci dampa')
Utter('Da junti famva ce terla ci sadji')
Utter('Da junti ke famva ki terla ci sadji')
Utter('Da junti ce terla ci famva sadji')
Utter('Da kubra kanpi ci tcaro rodlu')
Utter('La Djan, prano go kukra la Djek')
Utter('Da botsu go vedji groda')
Utter('Da slano takna go staryfoa')

# Utter('Da ge slano takna go staryfoa') does not parse because I
# excluded initial GE in top level predicates to avoid ambiguity with AGE
# It has the same metaphor structure as the previous.

#M  More connections and groupings in predicate strings

# some of these mean absurd things (quite deliberately)

# a lot of the point of these examples is semantics rather than parsing,
# it would be good to add the translations

Utter('Da bilti cmalo ce nirli')
Utter('Da bilti ke cmalo ki nirli')
Utter('Da bilti ge cmalo nirli geu ckela')  #word geu is new form
Utter('Da bilti cmalo ge nirli ckela')
Utter('Da bilti cmalo nirli ci ckela')
Utter('Da bilti ge cmalo ge nirli ckela')
Utter('Da bilti cmalo ci nirli ci ckela')
Utter('Da bilti ce cmalo nirli ckela')
Utter('Da bilti cmalo ca nirli ckela')
Utter('Da bilti ka cmalo ki nirli ckela')
Utter('Da bilti cmalo nirli ce ckela')
Utter('Da bilti ge cmalo ce nirli ckela')
Utter('Da bilti ge cmalo nirli ce ckela')
Utter ('Da cui bilti cmalo ce nirli ckela')
Utter('Da bilti ci cmalo ce nirli ckela')

Utter('Da bilti canoi cmalo ce nirli ckela')
Utter('Da bilti ce cmalo ge nirli ckela')
Utter('Da bilti ce cmalo nirli ci ckela')
Utter('Da bilti cui cmalo nirli ce ckela')
Utter('Da bilti cmalo ci nirli ce ckela')
Utter('Da bilti cmalo ce ge nirli ckela')
Utter('Da bilti ce cmalo ca nirli ckela')
Utter('Da bilti ce kanoi cmalo ki nirli ckela')
Utter('Da bilti ce cmalo nirli ce ckela')
Utter('Da bilti cmalo ce nirli ca ckela')  #typo in the original
Utter('Da bilti cmalo ce ka nirli ki ckela')

#N  Event/State Predicates; Other Abstractions

# changes for long po version

Utter ('Da zbuma')
Utter('Da poi zbuma')
Utter ('Da pa clado poi zbuma')
Utter('Da poi mrenu')
Utter('Da pa corta poi mrenu')
Utter('Da pa corta poi mrenu bukcu')
Utter('Da pa corta ge poi mrenu bukcu')
Utter('Da po corta mrenu')
Utter('Da po, corta mrenu')  # pause has no effect now
Utter('Da pa mutce po corta mrenu')
Utter('Da po mi corta la Djan')
Utter('Da po la Pit, mutce corta la Djan')
Utter('Da pu de fotli di')
Utter('Da pu de fotli')
Utter('Da zo de blanu di')
Utter('Da zo de blanu')

# Mass, Event, and Mass Event Descriptions

Utter ('Ei do fundi lo malna')
Utter ('Ei tu pa titci lo nikri')
Utter('Ei tu fa janto lo simba')
Utter('Ia mi fa janto da')
Utter('Ei lo nirda vi sucmi')
Utter('Ei lo nirda vi, sucmi')   # there is a difference
Utter('Ei lo nirda ji vi, sucmi')  # without the pause, it is an argument!
Utter ('Ei lovi nirda ga sucmi')
Utter('No. I da fleti')
Utter('Leva sonda ga he')
Utter('Lopo zbuma')
Utter('Ei tu pa hirti lepo zbuma')
Utter('Ia mi pa hirti da.  I lopo zbuma ga clado')
Utter('Ei tu pa hirti le clado po zbuma')
Utter('Ei tu hirti lo clado po zbuma')
Utter('Ei tu fundi lopo sucmi')
Utter('Ei lepo prano pa nardu')
Utter('Ei lopo nilboi ga treci')
Utter('Ei lopo mormao lo simba ga nardu')
Utter('Lo ficli ga spalii lo mursi')
Utter('Lo tongu ga trime lopo takna')
Utter('Lo tcina ga hasfa lo tongu')
Utter('Lopo takna ga proju lo sonda')
Utter('Lopo dirlu ga ckozu lopo kecri')
Utter('Lepo kanpi sucmi pa valna')
Utter('Le poi kanpi sucmi pa valna')  #the infamous distinction--short scope PO is now POI
Utter('Lo, poi kanpi sucmi pa valna')

# the pause actually *works* because it is recognized as a freemod

#P  Specified and Nested Event Descriptions

Utter('Ei tu djano lepo mi stude')
Utter('Tu danza lepo jmite hu')
Utter('Le nirli pa takna mi lopo da traci')
Utter('Le farfu pa takna le detra lepo de nu fatru')
Utter('Ei tu danza lepo mi tcihea tu')
Utter('Mi krido lepo la Paris, garsitci la Frans')
Utter('Mi djacue lepo la Marz, redro vi levi curta')  #vocab correction
Utter('Le stude pa djadou le surva lepo da pluci de')
Utter('La Ruprrt, djacue lepo la Denvrr, bitsa le vrici lepo kamda')
Utter('La Dag, furmoi lepo trati lepo skesa la Meris')
Utter('Ei la Degol, pa krido lepo kanmo lepo rilnamdou la Frans')
Utter('Lepo le mrenu pa trati ga fekto')
Utter('Lepo le botci pa fundi lopo sucmi ga gudcae')
Utter('Lepo lepo le matma pa kamla pa tradu pa fatru')
Utter('Mi pa viadja lepo lepo prano pa kukra')
Utter('Mi jupni lepo lepo mi danza lepo helba la Meris, pa gudcae')
Utter('Mi penso lopo firpa lopo crina')
Utter('Mi pa rulkao lepo santi gu, lepo helba la Bab')
Utter('Lo nimla ga cnida lopo cluva gu, lopo clivi')
Utter('Lo humni ga cnida lopo nu cluva gu, lopo hapci clivi')
Utter('Da pa djano lepo fa crina gu, pa lepo le neri drida fa felda')
Utter('Da pa djano lepo fa nicfea pa lepo le neri clife fa felda')

#Q  Attitude Indication;  Conversion, negation, and superlatives

Utter('Uo, la Keit, pa dupma mi')
Utter('Ue, tu nu dupma')
Utter('Ua tu no nu dupma')
Utter('Tu nu vegri de di')  #extra argument to color words again
Utter('Da gutra nu begco de')
Utter('Uu tu nu fatru')
Utter('Eo no nu fatru mi')
Utter('Ui tu no nu fatru')
Utter('Da nu gudbi de ba')
Utter('Di no nu gudbi raba rabe')
Utter('No nu gudbi')
Utter('No ge kukra prano')
Utter('No, kukra prano')  # the comma doesnt do anything
Utter('No kukra prano')  # grammar fix 4/9/2014 makes this work right
Utter ('Da fu ge briga stuci')
Utter('Da fu brigystuci')
Utter('Ei da nu kamla de')
Utter('Da fu lerci de')
Utter ('Ei da sanpa de di')
Utter('Ia de nu sanpa da di')
Utter('Ia di fu sanpa de da')
Utter('No fu sanpa mi ta')
Utter('No nu takna')
Utter('No fu takna')
Utter('Da fu gudbi')
Utter('Mi fu namci da')
Utter('Ta fu garti')
Utter('Nu garti mi ta')
Utter('Uu no ba nu hompi vi')
Utter('Da nu vizka ba be')
Utter('De no nu vizka raba rabe')
Utter('Da no nu kukra rutma de ti raba')
Utter('Da no nu plizo raba lopo roadru')

#R Counting, quantifying, and numerical questions

Utter('Konduo le batpi')
Utter('Ne.  I to.  I te.  I fo.  I foba batpi.')
# Utter('Ne. To.  Te.  Fo.  Foba batpi.')  #fails, as it is not a single utterance
Utter('Bleka le fo batpi')
Utter('Totco to le fo batpi')
Utter('Kambei mi ne le to batpi')
Utter('Su levi fe batpi ga veslo lo viski')
Utter('Iesu de dui')
Utter('Levi to de dui')
Utter('Foba tugle levi tobme')
Utter('Hova tugle leva tobme')
Utter('Leva tobme ga nu tugle soba')
Utter('Mi nu tugle hoba')
Utter('Ne uu')
Utter('Ho mu nu tugle toba')
Utter('Ho le se tobme ga nu tugle soba')
Utter('Iene da')
Utter('Ho le bekti ji vi levi kruma, ga nu tugle teba')  #the comma is not needed
Utter('Ho le bekti ji vi, nu tugle') 
Utter('Ho le bekti ji vi nu tugle')
Utter('Ho le bekti vi levi kruma ga nu tugle foba')

# S  Quantified descriptions and questions

Utter ('Ne mrenu pa kamla')
Utter('Su mrenu pa kamla')
Utter('Ru mrenu pa kamla')
Utter ('Le fo mrenu pa kamla')
Utter('Te le fo mrenu pa kamla')
Utter('Ru le fo mrenu pa kamla')
Utter('To le te le fo mrenu pa kamla')
Utter('Le to le te le fo mrenu pa kamla')
Utter('Ho le te mrenu')
Utter('Le ho mrenu')
Utter('Te le ho mrenu')
Utter ('Iete le mrenu')
Utter('Ie le ho mrenu')
Utter('Iesu le ho mrenu')
Utter('Ieho le ho mrenu')
Utter('Se sorme pa mercea le se brudi')
Utter('Se sorme pa mercea ne le se brudi')

#T  Measurement dimensioned numbers and numerical description

#  this will be distinctly different because -mue- marks dimensions

Utter('Ti dalri lio te')
Utter('Ti dalri')
Utter('Ta gramo lio tema')
Utter ('Ti langa ta lio tomuemeimei')
Utter('Ti skabubra lio nemuemei')  #just mei will not do
Utter('La Djan, pa donsu le botci le to dalri')
Utter('La Djan, pa penti lio totomuedai, le mrenu le torkrilu')
Utter('Lepa ckemo pa sekmi lio to')
Utter('Lepo da clivi pa nirne lio voto')
Utter('Ta pa miksekmi lio to')

#U  Linked description, identity clauses, replacement with letter words
# Mixed predicates and arguments

Utter('Mi pa takna da ta')
Utter('Hu bi da')
Utter('Da bi le fremi je le botci')
Utter ('Ie le botci')
Utter('Le botci ji le brudi je le merfua je le furvea')
Utter('Le furvea je hu')
Utter('Le furvea je le hasfa jue la Djonz, jue lio nemoatomuedai')
# nemomodai is now nemoatomuedai
Utter('Ie la Djonz')
Utter('La Djonz, ji le farfu je la Meris, ze la Selis')
Utter('La Djonz, ji le farfu je la Meris, e je la Selis')
Utter('Dai bi le farfu sui je le matma je la Bab, jue la ditca')
Utter('Dai bi le farfu sui je le matma je la Bab, gue jue la ditca')
# I need the full gue to do this sentence, one gu does not do it, and one
# cannot put the pause for Bab after the gu.  This is actually due to a decision
# of mine:  I do not allow 'gu comma' to be two gaps.  LIP does, so parses
# this as JCB intended.  I think I am right.
Utter('Dai bi le farfu je Mai jue le sorme je la Pidrr')
Utter('Le sorme je Pai jue hu')
Utter('Jue la Rabrrt, ze la Celis')
Utter('Inusoa, Dai bi le farfu je Mai jue la sorme je Pai jue Rai ze Cai')
Utter('Inusoa, Dai bi le farfu je Mai jue la sorme je Pai jue Rai, e jue Cai')
Utter('Dai bi le farfu je Mai jue la sorme je Pai jue Rai, e la Celis')
Utter('Dai bi le farfu je Mai jue la sorme je Pai jue Rai gu, e je Cai')
Utter('Dai bi le brudi je Mai jue la sorme je Pai jue Rai, e jue Cai')
Utter('Eo vedma mi le ketpi je la Paris, jue la Romas, jue le kukra trena jue lio fenimuedai') #comma after le kukra trena became GUE
Utter('Da nigro ze redro bakso')
Utter('Da nigro ze no nigro')
Utter('Da po nigro ze no nigro')  # this now parses as JCB intended, oddly enough

#V  Identifying versus Claiming subordinate clauses

Utter('Le mrenu jio pa merji na la Somen, haimro de jio pa merji na la Nenimen')
Utter('Mi ji la Djan, merji la Meris, ji le detra je la Solomon')
Utter('Mi jao ditca ga merji la Meris, jao detra je la Solomon')
Utter('La Meris, jao ditca la Franses, di')  #jao has replaced jia
Utter('La Meris, jao la Pit, ditca la Franses, di')
Utter('Raba jio katma ga titci be jio ratcu')
Utter('Raba jio redro nu herfa, e pa brana na la Nenemen Nevovoton, pa cenja be jio narmykoi')

#notice the gu inserted to prevent e pa from becoming epa

#W  Sentence, predicate, and argument negation

Utter('La Djan, pa no gudbi prano')
Utter('La Djan, no pa gudbi prano')
Utter('La Djan, no pa godzi la Paris')
Utter('La Djan, no pa titci le pligo')
Utter('La Djan, pa titci ni le pligo')
Utter('La Djan, pa godzi ni la Paris')
Utter('Ni la Djan, pa godzi la Paris')
Utter('La Djan, no pa kukra godzi la Paris')
Utter('La Djan, pa no kukra godzi la Paris')
Utter('La Djan, pa kukra no godzi la Paris')
Utter('Ni la Djan, pa kukra godzi la Paris, la Romas')
Utter('No, la Djan, pa kukra godzi la Paris, la Romas')
Utter('La Djan, no pa kukra godzi la Paris, la Romas')
Utter('La Djan, no ga kukra godzi la Paris, la Romas')  #duplicate sentence
Utter('La Djan, no kukra godzi la Paris, la Romas')

#X.  Quotation of Loglan.  Fronted arguments.

# I want a solution to the problem that the last argument is
# a fronted set must be literally the last (and so likely an unfamiliar)
# argument.  A convention involving numbering the lead argument
# in a fronted set might work.

# Proposal:  A first numerical case tag appearing
# before any untagged argument in a fronted
# argument set sets the argument position, and subsequent arguments are from
# following positions.

Utter('La Djan, pa cutse li, Ai, lu la Tam')
Utter('La Tam, gi la Djan, pa cutse liu Ai')
Utter('Liu Ai, la Tam, gi la Djan, pa cutse')
Utter('La Tam, gi la Djan, pa cutse')
Utter('La Frans, gi la Djan, pa takna')
Utter('La Frans, gi la Djan, pa takna da')
Utter('La Tam, la Frans, gi la Djan, pa takna')
Utter('Ti gi lo redro litla ga sanpa lo denro raba')
Utter('Lopo stise gu, ti gi lo redro litra ga sanpa')

#Y  Predicates from arguments and prenex quantifiers

# I should review commas in LI LU expressions

Utter('Liu tcemu, mela Djenis, rutma purda, e sackaa liu mutce')
Utter('Liu tcemu jao sackaa liu mutce, mela Djenis, rutma purda')
Utter('Ba pa meliu me forma holdu le lengu')
Utter('Ra ba ra bua goi, ko ba melo bua, ki ba bua')
# I have reservations about the form of the prenex second order
# quantifier, but it may be the best solution.  The problem is that
# ra bua by itself does not mean the right thing.
Utter('Ra ba ra bua goi, ko ba melea bua, ki ba bua')
Utter('Ra ba ra bua goi, ko ba bie lea bua, ki ba bua')
Utter('Li, Da melo preda, lu durduo snola li, Da preda, lu')
Utter('Ta meda po muvdo')
Utter('Ta memi tcaro')
Utter('Le kangu pa meli, Mi danza lepo hasfa godzi, lu bleka mi')
Utter('Le kangu pa bleka je mi go meli, Mi danza lepo hasfa godzi, lu')
# it is interesting that one can delete the je here and it still parses
# with the same meaning, due to an odd extension of the termset class

#Z  Prenex quantifiers

# should I add an optional pause after headterms?

# I amend JCBs logical usage in some of these.  His sentences parse,
#  they just dont make sense to me.

Utter ('Raba be goi, be matmaa ba')
Utter('Be raba goi, be matmaa ba')
Utter('Ba lea humni goi, ba pasylinkui da')
# it parses but I dont buy the format, my correction follows
Utter('Ba rabe ji humni goi, ba pasylinkui da')
Utter('Raba goi cluva ba')  #my parser doesnt allow a comma after goi here (it does now)
Utter ('Lea humni goi cluva da')  #again, it parses but I dont buy it,
#correction follows
Utter('Raba ji humni goi cluva ba')
# after this I am redoing his forms
Utter('Raba ji humni go clivi goi cluva ba')
Utter('Raba ji clivi humni goi ba gi cluva')  #pause/GU equivalence crashed it with a comma after goi, now fixed

#AA  Connected arguments and predicates, joint argument sets

# JCB is fond of apa words, which I changed to apafi or apa,

# there are a lot of changes here:  things which he wanted to close off with a single
# gu often did not close; he may have been counting comma pauses as gaps in a way I
# dont approve.  The notes make it clear that guu and its kin didnt exist yet, and if
# guu or in one case gui are used, it all comes out according to his intent.

Utter('La Djan, e la Meris, fundi la Bab')
Utter('La Djan, efafi la Meris, fundi la Bab')
Utter('Ke la Djan, ki la Meris, fundi la Bab')
Utter('Di, e de ke fundi da ki tsodi la Pit')
Utter('Di, e da fundi da, epafi tsodi la Pit')
Utter('Di, e da fundi da, e tsodi gu, la Pit')
Utter('Di, e de fundi, e tsodi gu, la Pit')
Utter('La Pol, farfu la Bab, efafi la Pit')
Utter('La Pol, farfu la Bab, la Selis, onoi la Bet')
Utter('La Pol, farfu la Bab, la Selis, guu, onoi la Bet')  # here JCB
# tries to use gu comma as two pauses -- I get desired meaning with guu
Utter('La Pol, jao farfu la Bab, e la Pit')
Utter('La Pol, jao farfu la Bab, gu, e la Pit')
Utter('La Pol, jao farfu la Bab, gugu, e la Pit') # this does NOT mean what he says it does,
# it is probably because I am less liberal with pauses
Utter('La Pol, jao farfu la Bab, gui, e la Pit')  # used a new closure operator to get the effect
#three GUs do it, and even for him a pause cannot work here
Utter('La Pol, farfu, e perdia la Bab, e la Pit')
Utter('La Pol, farfu, e perdia gu, la Bab, e la Pit')
Utter('Da farfu ke la Bab, ki la Pit, la Meris')
Utter('Da farfu kanoi la Bab, guu, ki la Pit, la Meris')  # JCB had gu, which did not work
Utter('Da farfu kanoi la Bab, ki la Pit, la Meris')
Utter('Da farfu la Bab, guu, e la Pit, la Meris, a la Betis')  #again, one gu wasnt enough
Utter('Da farfu la Bab, anoi la Pit, la Meris, a la Betis')
Utter('Da farfu la Bab, anoi la Pit, la Meris, guu, a la Betis') #again, one gu didnt work
Utter('Da farfu la Bab, e la Pit, ka la Meris, ki la Betis')
Utter('Da farfu ke la Bab, ki la Pit, ka la Meris, ki la Betis')
Utter('Da farfu la Bab, guu, e la Pit, la Meris, e lendia') #didnt even try without guu
Utter('Da farfu la Bab, e la Bet, e ditca la Franses, di, e do')
Utter('Da farfu, e ditca la Franses, guu, di, e do')
Utter('Da farfu, e ditca la Franses, di, e do')
Utter('Da farfu, e ditca la Franses, di guu, e do')
Utter('Da farfu ba be, noa ditca la Franses, ba, e be')
Utter('Da kanoi farfu ba be, ki ditca la Franses, ba, e be')
Utter('Liu tcemu kanoi sackaa liu mutce, ki me la Djenis, rutma purda')

# causal inflectors, modifiers and phrases

Utter('Mi pa godzi moi')
Utter('Mi moipa godzi')
Utter('Mi ji moi, pa godzi')  #these examples are different
Utter('Mi ji moipa, godzi')  #pause/GU at work
Utter('Moi mi, godzi')
Utter('Moi gi mi godzi')
Utter('Soa ta gi da bi de')
Utter('Soa lepo da bi de gi, da tsidru')
Utter('Da tsidru soa lepo da bi de')
Utter('Mi pa tokna ti moi ta')
Utter('Moi ta gi mi pa tokna ti')
Utter('Mi pa danza ta numoi ti')
Utter('Ti pa rodja kou lepo tu cuidru da')
Utter('Da pa rodja kou lepo cuidru')
Utter('Da pa rodja kou lo cutri')
Utter('Ti pa rodja kouhu')
Utter('Tu pa cuidra da moihu')
Utter('Ti pa rodja nukouhu')
Utter('Kouhu da pa rodja')
Utter('Nukouhu da pa rodja')
Utter('Moihu tu pa cuidru da')
Utter('Moihu tu pa danza lepo da rodja')
Utter('Kou ta gi ti pa rodja')
Utter('Mi moi ditca')
Utter('Moi gi mi ditca')
Utter('Moi mi, ditca')
Utter('Moi ba gi mi ditca')
Utter('Mi ditca moi ba')
Utter('Mi ditca moi lepo mi snire le junti')
Utter('Mi ditca kou lepo mi cluva lo junti')
Utter('Mi ditca rau lepo mi bremao lo junti lopo clivi')

# CC compound term connectives

# I require that APA be closed with gu or a comma; here I used GU

Utter('Mi, enumoifi la Djan, pa godzi')
Utter('Mi, efafi la Djan, pa godzi')
Utter('Mi pa vizka la Meris, enukoufi la Pit')
Utter('Da farfu la Djek, la Meris, enukoufi ni la Selis')
Utter('Mi pa godzi, enukoufi pa vizka la Djan')
Utter('Mi pa godzi, evafi pa vizka la Djan')
Utter('Mi pa godzi, epafi vizka la Djan')
Utter('Mi pa godzi, enumoifi, vizka la Djan')

#DD  connective questions

#  I used guu here to simplify closing termsets
#  the last one requires no,  not for meaning but for his intended parse

Utter('Tu danza lo skafi,  ha lo tcati')
Utter('Enoi eo')
Utter('Tu farfu la Djein, ha la Alis')
Utter('E')
Utter('Tu farfu la Djein, e la Alis, la Meris, ha la Betis')
Utter('Noenoi.  I mi farfu la Djein, la Meris, guu, e la Alis, la Betis')
Utter('Inusoa, tu farfu la Djein, a la Alis, la Meris, e la Betis')
Utter('Ibuo no, tu farfu la Djein, e la Alis, la Meris, a la Betis')

#EE  Internal arguments

Utter('Da grobou go kukra lo litra')
Utter('Da kukra je lo litla gue grobou')
Utter('Da kukra je lo litla, grobou')  #also works, same as previous
Utter('Da penso go kukra mi')
Utter('Da kukra je mi penso')

Utter('Ta rutma je la Mineapolis, go kukra ti')
Utter('Ta rutma je la Mineapolis, jue la Cikagos, go kukra ti')
Utter('Ta kukra je ti rutma la Mineapolis, la Cikagos')
Utter('Da farbru je la Djan, go plumro la Pit, la Djan')
Utter('Da plumro je la Pit, jue la Djan, farbru la Djan')
Utter('Ba pa korfro je liu me holdu le lengu')
Utter('Ba pa holdu je le lengu gue go korfro liu me')
Utter('Ba pa holdu je le lengu, go korfro liu me')  #again, pause/GU works
# without the pause would mean something different

##FF  Argument ordinals

#  the words have changed from PUV to ZUV

Utter('Da sanpa de di do du')
Utter('Zua da sanpa')
Utter('Zue de sanpa')
Utter('Zui di sanpa')
Utter('Zuo do sanpa')
Utter('Zuu du sanpa')
Utter('Zuu lopo tcaro bapra ga sanpa zua lo redro litla zue lo humni')
Utter('Lopo tcaro bapra ga nufe sanpa zua lo redro litla zue lo humni')
Utter('Zue lo denra ga danri sanpa zui lo nimla')
Utter('Zuo lopo prano ga danri sanpa zue lo denro')
Utter('Lopo prano ga danri ju sanpa zue lo denro')
Utter('Lo nimla ga fu sanpa zuu lopo do clivi')
Utter('La Miniapolis, danri nu godzi zui la Seint Pol')
Utter('Ba godzi la Miniapolis, la Seint Pol')
Utter('Zuo ta vedma')
Utter('Ta ju vedma')
Utter('Ba vedma be bo ta')
Utter('Le farfu je zui la Meris')
Utter('Le farfu je ba jue la Meris')
Utter('Le farfu je raba jio nu matma la Meris')
Utter('Da kukra je zui lio nenimuemeikuasei, tcaro')
Utter('Zui lio nenimuemeikuasei, fu kukra')
Utter('Ba kukra be lio nenimuemeikuasei')

#GG compound and connected tenses

Utter('Mi fapa sucmi')
Utter('Mi nepa sucmi')
Utter('Mi nipa sucmi')
Utter('Mi nina sucmi')
Utter('Mi rana sucmi')
Utter('Mi no na sucmi')

# noi- initial tenses removed

Utter('Mi pacenoina sucmi')
Utter('Mi no pacana sucmi')

# again noi initial forbidden, so noipacenoina becomes no pacana

Utter('Mi pacefa bragai')
Utter('Mi no pacanafa bragai')

# again, noipacenoinacenoifa is not good -- initial noi is a problem

Utter('Facenoina mi, garni levi landi')

#HH  Logically connected clauses

# it is a global fact in this section that everything parses,
# and that all of JCBs parses treat initial negations incorrectly.
#  Modern LIP is on my side of the disagreement.  see below.

Utter('Kanoi no tu fa kamla, ki no mi hijra va')
Utter('No tu fa kamla, inoca no mi hijra va')
Utter('No, tu fa kamla, inoca no, mi hijra va')
#notice the different logical form (seen in the parse)
#though the meaning is the same.  In the first sentence,
#pauses can be added after the NOs but are interpreted as freemods.

#throughout the section, JCB seems to think that NOs negate entire
#sentences, but these NOs actually negate the initial argument.
# The present form of LIP agrees
#with my parser on this.  A gap is needed for the formal negation of
#the entire sentence.  The meaning is unaffected.

#this might be due to a later change in the grammar, of course.

Utter('No mi fa hijra va, icanoi no tu kamla')
Utter('No, mi fa hijra va, icanoi no, tu kamla') #same issue
Utter('Kanoi no tu fa kamla ki ke no mi hijra va ki tu fa kecdri')
Utter('No mi fa hijra va, icanoi no tu fapa kamla')
Utter('Tu fapa kamla, icanoi mi hijra va')
Utter('Mi fa hijra va, inoca tu fapa kamla')
Utter('Kanoi mi fa hijra va ki tu pa kamla')
Utter('Ka no mi fa hijra va ki tu pa kamla')
Utter('No mi fa hijra va, ica tu pa kamla')
Utter('Tu fapa kamla, ica no mi hijra va')
Utter('Tu fapa kamla, ica ke no hijra va ki tu kecdri')
Utter('Ice mi sui fa hijra va')

# II causality connected clauses

#pause or GU is required by my parser to close an IPA (e.g. an IKOU) word

#had to repair my parser here, didnt have the KOUKI words

Utter('Ti pa rodja, ikou, tu cuidru da')
Utter('Nukouki ti pa rodja, ki tu cuidru da')
Utter('Tu pa cuidru ti, inukou, da rodja')
Utter('Mi pa cuidru da, imoi, da pafa rodja')
Utter('Kouki tu pa cuidru ti ki da rodja')
Utter('Mi pa danza ti, imoi, mi pafa ponsu ta')
Utter('Mi ditca, imoi, mi bremao lo junti')

# JJ Indirect designation; foreign quotation

# for this section it is important to note that sae became lue
# (Appendix H) and my strong quotation mechanism is different.

Utter('Eo kambei mi lae li, la Loglan Nen, lu')
# la has to be added to the quoted utterance because names by themselves
# are no longer accomodated as utterances
Utter('Eo kambei mi lae lie War cii and cii Peace')
# this is an example of my new strong quotation
Utter ('La Djan, melaelie stingy')
Utter('Ei tu pa ridle laeli, la Loglan Nen, lu')
Utter('Ei tu fundi laeli, la Loglan Nen, lu')
Utter('Da pa cutse lue lepo la Djan, pa prano') #lue superseded sae
Utter('Ei tu vizka lue la Djan')
Utter('Ei tu vizka laeli, la Djan, lu')
Utter('Ei tu vizka lae la Djan')
Utter('Ei tu vizka lo sanpa je la Djan')
Utter('Ei tu vizka lo nu sanpa je la Djan')
Utter('Ei tu vizka lue lue lue la Djan')
Utter('Ei tu vizka lo sanpa je lo sanpa je lo sanpa je la Djan')
Utter('Ei tu vizka lae lue lae la Djan')

# KK Metaphor Marking or Figurative Quotation

#  I had somehow lost JO from my freemod list, but in any case
#  these examples made it clear that I needed to improve the rule
#  for use of JO

Utter ('Mi farfu jo la Loglan')
Utter('Ia no.  I tu matma jo la Loglan')
Utter('I la Uorf, pa farfu jo de')
Utter('Da smina huigro tojo')
Utter('Da smina huicma jo')
Utter('La Djan, pa brahea rajo na lepo la Loglan, brana')
Utter('Ia no.  I la Djan, pa bremao ckela ditca tejo la Loglan')
Utter('La Djan, pa bremao ckela ditca la Loglan, rajo')
Utter('La Djan, pa rajo bremao ckela ditca la Loglan')

# LL Letter-Variables and Acronyms

#using new vowel letterals:  a is zia, A is Ziama
#Improvement to grammar: space after mie allowed;
# This allows
# use of "words" like lemie, lamie

#new strong quotation used

Utter('Le mrenu pa vedma le kangu le cmalo nirli')
Utter('Nei fa cluva kei')
Utter('La Ned, farfu nei')
Utter('Nai cluva nei, e fundi lo kangu, enumoi, fa cluva kei')
Utter('Nai merji la Meris, ice Mai no fundi lo kangu')
Utter('Bai merji la Alis, ice Ziama fundi lo kangu')
Utter('Inusoa, ba nu dakli lepo Mai no fa cluva kei')
Utter('Nai nu perpli lae lie Central cii Intelligence cii Committee')
Utter('Nai nu perpli la Caiziza')  #changes in acronyms
Utter('Mai nu perpli la Zunai')  #pause in the original not supportable
Utter('Nei danza lepo fa nu perpli la Zunaizesaicaizo')
Utter('Ibuo nei danza lepo na nu perpli la Saipaicaiza')
Utter('Meo ponsu ba jio kasni')  #shape of greek letters changed
Utter('Lomela Haitozo, bi lo cutri')
Utter('Ta mela haitosaizofo')
Utter('Zia groda bei cei')  #no pause needed

#MM  Predicates as names and vocatives

Utter('Hoi Mrenu')
Utter('Hoi Ganfua go Redro nu Herfa')
Utter('Ei tu vizka Hoi Ganbra, lepo mi pana nu ganble turka letu fothaa')
Utter('Ei tu pa vizka la Mrenu')
Utter('La Garfua go Redro nu Herfa ga matma mi')
Utter('La Blabi Garfua pa korji la Redro Garfua lepo godzi la Hatro Sitfa')
Utter('La Musmu pa djadou la Ratcu lepo de fa damgoo la Vrici')

#NN Grouped and ungrouped afterthought connections

Utter('Mi pa prano.  Ifa, mi sucmi.  Ifa,  mi fleti.  Ifa, mi dzoru.')
Utter('Mi pa prano, e sucmi, e fleti, e dzoru')
#I'm not sure the grouping here is what I want.  Restored left
# grouping in the grammar of predicates at the cost of limiting (?)
# use of shared termsets.  This is an argument between the left grouping
# in Loglan's logic and the limitations on left grouping in PEGs

Utter('Mi pa takna da, e de, e di, efafi do')
Utter('Muvdo, icanoi da redro, icaci de nigro')
Utter('Muvdo, icanoi da redro, ica de nigro')
Utter('Muvdo, icanoige da redro, ica de nigro, ica di verdi')
Utter('Da muvdo, anoi redro, aci nigro')
Utter('Da muvdo, anoi redro, a nigro')
Utter('Da muvdo, anoige redro, a nigro, epafi vegri')
Utter('Mi godzi da, anoi de, e di')
Utter('Mi godzi da, anoi de, eci di')
Utter('Mi godzi da, anoifage de, a di, a do')

#OO Spelling

#different solution given for spelling

Utter('Liu artomi purkaa lie atom, e nu leasri liu Zareiteizomeizi')
Utter('Liu atmo sui purkaa lie atom, e nu leasri liu Zateimeizo')
#a lie string does not need to be followed by a comma before A
# words -- there is a mandatory pause at end of such a word, and the
# quote mechanism would eat a comma.

Utter('Ie le to po purkaa ga nu fundi tu')
Utter('Liu protoni, purkaa lie proton, e nu leasri liu peireizoteizonei')
Utter('Liu purkaa purkaa li purda kamla lu, e nu leasri liu peizureikeizaza')

#the last three sentences involve an approach to spelling which to my mind
# does not give a Loglan utterance.

# PP Sentences in VOS order.

# the LW pattern for this has changed.  Otherwise the section works cleanly.

Utter('Ga seidjo lea no nu trecymro bekti ji vi lo rardza ga lea surpernova')
# there is a semantic problem with attachment of the argmod here which
#also exists in JCBs original sentence

Utter('Ga gudbi lo cutci lopo pucblo lo naldi ga lo mroza')
#this is repeated in the original

Utter('Na levi delnai ga bilti lo blabi flora ga rui re lea floryclu lo redro')




