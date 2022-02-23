from loglanpreamble import *

L("sp <- [ ]+")

L("Vo1 <- [aeiouyAEIOUY]")

L("Vo2 <- [aeiouAEIOU]")

L("Co1 <- [bcdfghjklmnprstvzBCDFGHJKLMNPRSTVZ]")

L("Cvoiced <- [bdgjvzBDGJVZ]")

L("Cunvoiced <- [ptkcfsPTKCFS]")

L("Badvoice <- ((Cvoiced (Cunvoiced/[Hh]))/(Cunvoiced (Cvoiced/[Hh])))")

L("Letter <- (![qwxQWX] [a-zA-Z])")

L("Lowercase <- (![qwx] [a-z])")

L("Uppercase <- (![QWX] [A-Z])")

L("caprule <- ([\"(]? &(([z] Vo1 (!Uppercase/&TAI0))/(Lowercase TAI0 (!Uppercase/&TAI0))/(!(Lowercase Uppercase) .)) Letter (&(([z] Vo1 (!Uppercase/&TAI0))/(Lowercase TAI0 (!Uppercase/&TAI0))/(!(Lowercase Uppercase) .)) (Letter/Juncture))* !(Letter/Juncture))")

L("Stress2 <- [\'*]")

L("Juncture <- ((([-] &Letter)/Stress2) !Juncture)")

L("Stress <- ([\'*] !Juncture)")

L("Terminal <- [.:?!;#]")

L("Character <- (Letter/Juncture)")

L("AlienText <- (([,]? sp [\"] (![\"] .)+ [\"])/([,]? sp (![, ] !Terminal .)+ ([,]? sp [Yy] [,]? sp (![, ] !Terminal .)+)*))")

L("HOIalien <- ([Hh] [Oo] [Ii])")

L("HUEalien <- ([Hh] [Uu] Juncture? [Ee])")

L("LIEalien <- ([Ll] [Ii] Juncture? [Ee])")

L("LAOalien <- ([Ll] [Aa] [Oo])")

L("LIOalien <- ([Ll] [Ii] Juncture? [Oo])")

L("SAOalien <- ([Ss] [Aa] [Oo])")

L("SUEalien <- ([Ss] [Uu] Juncture? [Ee])")

L("AlienWord <- (&caprule ((HOIalien Juncture? &([,]? sp [\"]))/(HUEalien Juncture? &([,]? sp [\"]))/(LIEalien Juncture?)/(LAOalien Juncture?)/(LIOalien Juncture?)/(SAOalien Juncture?)/(SUEalien Juncture?)) AlienText)")

L("Alienmarker <- ((([Hh] [Oo] [Ii] Juncture? &([,]? sp [\"]))/([Hh] [Uu] Juncture? [Ee] Juncture? &([,]? sp [\"]))/([Ll] [Ii] Juncture? [Ee] Juncture?)/([Ll] [Aa] [Oo] Juncture?)/([Ll] [Ii] Juncture? [Oo] Juncture?)/([Ss] [Aa] [Oo] Juncture?)/([Ss] [Uu] Juncture? [Ee] Juncture?)) !Vo1)")

L("Continuant <- [mnlrMNLR]")

L("Syllabic <- (([mM] [mM] !(Juncture? [mM]))/([nN] [nN] !(Juncture? [nN]))/([rR] [rR] !(Juncture? [rR]))/([lL] [lL] !(Juncture? [lL])))")

L("MustMono <- (([aeoAEO] [iI] ![iI])/([aA] [oO]))")

L("BrokenMono <- (([aeoAEO] Juncture [iI] ![iI])/([aA] Juncture [oO]))")

L("Mono <- (MustMono/([iI] !([uU] [uU]) Vo2)/([uU] !([iI] [iI]) Vo2))")

L("Vv <- (!(!MustMono Vo2 Juncture? Vo2 Juncture? [Rr] [Rr]) (!BrokenMono Vo2 Juncture? Vo2))")

L("NextVowels <- (MustMono/(Vo2 &MustMono)/Mono/(!([Ii] Juncture [Ii] Vo1) !([Uu] Juncture [Uu] Vo1) Vo2))")

L("DoubleVowel <- (([aA] Juncture? [aA])/([eE] Juncture? [eE])/([oO] Juncture? [oO])/([iI] Juncture [iI])/([uU] Juncture [uU])/([iI] [Ii] &[iI])/([Uu] [uU] &[uU]))")

L("Vocalic <- (NextVowels/Syllabic/[Yy])")

L("Initial <- (([Bb] [Ll])/([Bb] [Rr])/([Cc] [Kk])/([Cc] [Ll])/([Cc] [Mm])/([Cc] [Nn])/([Cc] [Pp])/([Cc] [Rr])/([Cc] [Tt])/([Dd] [Jj])/([Dd] [Rr])/([Dd] [Zz])/([Ff] [Ll])/([Ff] [Rr])/([Gg] [Ll])/([Gg] [Rr])/([Jj] [Mm])/([Kk] [Ll])/([Kk] [Rr])/([Mm] [Rr])/([Pp] [Ll])/([Pp] [Rr])/([Ss] [Kk])/([Ss] [Ll])/([Ss] [Mm])/([Ss] [Nn])/([Ss] [Pp])/([Ss] [Rr])/([Ss] [Tt])/([Ss] [Vv])/([Tt] [Cc])/([Tt] [Rr])/([Tt] [Ss])/([Vv] [Ll])/([Vv] [Rr])/([Zz] [Bb])/([Zz] [Ll])/([Zz] [Vv]))")

L("MaybeInitial <- (([Bb] Juncture? [Ll])/([Bb] Juncture? [Rr])/([Cc] Juncture? [Kk])/([Cc] Juncture? [Ll])/([Cc] Juncture? [Mm])/([Cc] Juncture? [Nn])/([Cc] Juncture? [Pp])/([Cc] Juncture? [Rr])/([Cc] Juncture? [Tt])/([Dd] Juncture? [Jj])/([Dd] Juncture? [Rr])/([Dd] Juncture? [Zz])/([Ff] Juncture? [Ll])/([Ff] Juncture? [Rr])/([Gg] Juncture? [Ll])/([Gg] Juncture? [Rr])/([Jj] Juncture? [Mm])/([Kk] Juncture? [Ll])/([Kk] Juncture? [Rr])/([Mm] Juncture? [Rr])/([Pp] Juncture? [Ll])/([Pp] Juncture? [Rr])/([Ss] Juncture? [Kk])/([Ss] Juncture? [Ll])/([Ss] Juncture? [Mm])/([Ss] Juncture? [Nn])/([Ss] Juncture? [Pp])/([Ss] Juncture? [Rr])/([Ss] Juncture? [Tt])/([Ss] Juncture? [Vv])/([Tt] Juncture? [Cc])/([Tt] Juncture? [Rr])/([Tt] Juncture? [Ss])/([Vv] Juncture? [Ll])/([Vv] Juncture? [Rr])/([Zz] Juncture? [Bb])/([Zz] Juncture? [Ll])/([Zz] Juncture? [Vv]))")

L("InitialConsonants <- ((!Syllabic Co1 &Vocalic)/(!(Co1 Syllabic) Initial &Vocalic)/(&Initial Co1 !(Co1 Syllabic) Initial !Syllabic &Vocalic))")

L("NoMedial2 <- (([Bb] Juncture? [Bb])/([Cc] Juncture? [Cc])/([Dd] Juncture? [Dd])/([Ff] Juncture? [Ff])/([Gg] Juncture? [Gg])/([Hh] Juncture? Co1)/([Jj] Juncture? [Jj])/([Kk] Juncture? [Kk])/([Ll] Juncture? [Ll])/([Mm] Juncture? [Mm])/([Nn] Juncture? [Nn])/([Pp] Juncture? [Pp])/([Rr] Juncture? [Rr])/([Ss] Juncture? [Ss])/([Tt] Juncture? [Tt])/([Vv] Juncture? [Vv])/([Zz] Juncture? [Zz])/([CJSZcjsz] Juncture? [CJSZcjsz])/([Ff] Juncture? [Vv])/([Kk] Juncture? [Gg])/([Pp] Juncture? [Bb])/([Tt] Juncture? [Dd])/([FKPTfkpt] Juncture? [JZjz])/([Bb] Juncture? [Jj])/([Ss] Juncture? [Bb]))")

L("NoMedial3 <- (([Cc] Juncture? [Dd] Juncture? [Zz])/([Cc] Juncture? [Vv] Juncture? [Ll])/([Nn] Juncture? [Dd] Juncture? [Jj])/([Nn] Juncture? [Dd] Juncture? [Zz])/([Dd] Juncture? [Cc] Juncture? [Mm])/([Dd] Juncture? [Cc] Juncture? [Tt])/([Dd] Juncture? [Tt] Juncture? [Ss])/([Pp] Juncture? [Dd] Juncture? [Zz])/([Gg] Juncture? [Tt] Juncture? [Ss])/([Gg] Juncture? [Zz] Juncture? [Bb])/([Ss] Juncture? [Vv] Juncture? [Ll])/([Jj] Juncture? [Dd] Juncture? [Jj])/([Jj] Juncture? [Tt] Juncture? [Cc])/([Jj] Juncture? [Tt] Juncture? [Ss])/([Jj] Juncture? [Vv] Juncture? [Rr])/([Tt] Juncture? [Vv] Juncture? [Ll])/([Kk] Juncture? [Dd] Juncture? [Zz])/([Vv] Juncture? [Tt] Juncture? [Ss])/([Mm] Juncture? [Zz] Juncture? [Bb]))")

L("SyllableA <- (Co1 Vo2 FinalConsonant (!Syllable FinalConsonant)?)")

L("SyllableB <- (InitialConsonants? Vocalic (!Syllable FinalConsonant)? (!Syllable FinalConsonant)?)")

L("Syllable <- ((SyllableA/SyllableB) Juncture?)")

L("FinalConsonant <- (!Syllabic !(&Badvoice Co1 !Syllable) (!(!Continuant Co1 !Syllable Continuant) !NoMedial2 !NoMedial3 Co1 !(Juncture? (Vo2/Syllabic))))")

L("SyllableD <- (&(InitialConsonants? ([Yy]/DoubleVowel/BrokenMono/(&Mono Vo2 DoubleVowel)/(!MustMono &Mono Vo2 BrokenMono))) Syllable)")

L("BorrowingSyllable <- (!Syllabic !SyllableD Syllable)")

L("VowelFinal <- (InitialConsonants? Vocalic Juncture? !Vo2)")

L("SyllableC <- (&(InitialConsonants? Syllabic) Syllable)")

L("SyllableY <- (&(InitialConsonants? [Yy]) Syllable)")

L("StressedSyllable <- ((SyllableA/SyllableB) Stress2)")

L("NameEndSyllable <- (InitialConsonants? (Syllabic/(Vocalic &FinalConsonant)) FinalConsonant? FinalConsonant? Stress? !Letter)")

L("Maybepause <- (Vo1 Stress2? sp Co1)")

L("Explicitpause <- ((Co1 Stress2? sp &Letter)/(Letter Stress2? sp &Vo1)/(Letter Stress2? [,] sp &Letter))")

L("MaybePauseSyllable <- (InitialConsonants? Vocalic Stress2? &(sp &Co1))")

L("PRENAME <- ((Syllable &Syllable)* NameEndSyllable)")

L("BadPreName <- (((MaybePauseSyllable sp)/(Syllable &Syllable))* NameEndSyllable)")

L("LAname <- ([Ll] [Aa])")

L("HOIname <- ([Hh] [Oo] [Ii])")

L("CIname <- ([Cc] [Ii])")

L("LIUname <- ([Ll] [Ii] Juncture? [Uu])")

L("MUEname <- ([Mm] [Uu] Juncture? [Ee])")

L("GAOname <- ([Gg] [Aa] [Oo])")

L("HUEname <- ([Hh] [Uu] Juncture? [Ee])")

L("LAname2 <- ([Ll] !Explicitpause [Aa])")

L("HOIname2 <- ([Hh] [Oo] !Explicitpause [Ii])")

L("LIUname2 <- ([Ll] [Ii] Juncture? !Explicitpause [Uu])")

L("MUEname2 <- ([Mm] [Uu] Juncture? !Explicitpause [Ee])")

L("GAOname2 <- ([Gg] [Aa] !Explicitpause [Oo])")

L("HUEname2 <- ([Hh] [Uu] Juncture? !Explicitpause [Ee])")

L("MarkedName <- (&caprule ((LAname2 Juncture?)/(HOIname2 Juncture?)/(HUEname2 Juncture?)/(LIUname2 Juncture?)/(GAOname2 Juncture?)/(MUEname2 Juncture?)) sp? &Co1 &caprule PRENAME)")

L("FalseMarked <- (&PRENAME (!MarkedName Character)* MarkedName)")

L("NAMEWORD <- (((&caprule MarkedName)/([,] sp !FalseMarked &caprule PRENAME)/(&Vo1 !FalseMarked &caprule PRENAME)/(&caprule (((LAname Juncture?)/(HOIname Juncture?)/(HUEname Juncture?)/(CIname Juncture? &([,]? sp))/(LIUname Juncture?)/(MUEname Juncture?)/(GAOname Juncture?)) !Vo1 [,]? sp? &caprule PRENAME))) (([,]? sp !FalseMarked &caprule PRENAME)/([,]? sp &([Cc] [Ii]) NAMEWORD))* &((sp? [Cc] [Ii] predunit)/(&(([,] sp)/Terminal/[\")]/!.) .)/!.))")

L("Namemarker <- ((([Ll] [Aa] Juncture?)/([Hh] [Oo] [Ii] Juncture?)/([Hh] [Uu] Juncture? [Ee] Juncture?)/([Cc] &(Explicitpause/([Ii] Juncture? sp PRENAME)) [Ii] Juncture?)/([Ll] [Ii] Juncture? [Uu] Juncture?)/([Gg] [Aa] [Oo] Juncture?)/([Mm] [Uu] Juncture? [Ee] Juncture?)) !Vo1)")

L("Badnamemarker <- (Namemarker !Vo1 [, ]? sp? BadPreName)")

L("Vthree <- ((Vo2 Juncture?) (Vo2 Juncture?) (Vo2 Juncture?))")

L("Vfour <- ((Vo2 Juncture?) (Vo2 Juncture?) (Vo2 Juncture?) (Vo2 Juncture?))")

L("Predstart1 <- (((&MaybeInitial Co1 Juncture? MaybeInitial)/MaybeInitial) &Vo2 !(Vo2 Stress !Mono Vo2) !(Vo2 Juncture? Vo2 !Character) !(Vo2 Juncture? !Character))")

L("Predstart2 <- (Co1 Vo2 Juncture? (Vo2 Juncture?)? !Predstart1 Co1 Juncture? Co1)")

L("Predstart3 <- (Co1 !Vthree (!StressedSyllable Vo2 Juncture?)? &StressedSyllable Vo2 Vo2? Juncture? Co1 Juncture? Co1)")

L("Predstart4 <- (Co1? Vo2 Juncture? (Vo2 Juncture?)? (Vo2 Juncture?)? !Predstart1 !(MaybeInitial Vo2) Co1 Juncture? Co1)")

L("Predstart5 <- (Co1? !Vfour (!StressedSyllable Vo2 Juncture?)? (!StressedSyllable Vo2 Juncture?)? &StressedSyllable Vo2 Vo2? Juncture? !(MaybeInitial Vo2) Co1 Juncture? Co1)")

L("Predstart6 <- (Co1 (Vo2 Juncture?) ((Vo2 Juncture? [Hh]?)/(Co1 Juncture? (Co1 Juncture?)?)) [Yy])")

L("Predstart <- (Predstart1/Predstart2/Predstart3/Predstart4/Predstart5/Predstart6)")

L("a <- ([Aa] !Badstress Juncture? !Vo1)")

L("e <- ([Ee] !Badstress Juncture? !Vo1)")

L("i <- ([Ii] !Badstress Juncture? !Vo1)")

L("o <- ([Oo] !Badstress Juncture? !Vo1)")

L("u <- ([Uu] !Badstress Juncture? !Vo1)")

L("Hearly <- (!Predstart [Hh])")

L("Nearly <- (!Predstart [Nn])")

L("Connective <- (sp? !Predstart ([Nn] [Oo] Juncture? !i)? (a/e/i/o/u/(Hearly a)/(Nearly uu)) Juncture? !Vo2 !(!Predstart [Ff] [Ii]) !(!Predstart [Mm] [Aa]) !(!Predstart [Zz] [Ii]))")

L("CmapuaUnit <- ((Co1 Mono Juncture? Vo2 !(Stress2 sp? &Co1 Predstart) Juncture? !Vo1)/(Co1 (Vv/([Ii] [Yy])/([Uu] [Yy])) !(Stress2 sp? &Co1 Predstart) Juncture? !Vo1)/(Co1 Vo2 !(Stress2 sp? &Co1 Predstart) Juncture? !Vo1))")

L("Likie <- (([Ll] [Ii] Juncture? !Vo1)/([Ki] [Ii] Juncture? [Ee] Juncture? !Vo1))")

L("Cmapua <- (&caprule !Badnamemarker ((!Predstart (Vv/([Ii] [Yy])/([Uu] [Yy])) !(Stress2 sp? &Co1 Predstart) Juncture? NOI0)/(!Predstart [Nn] [Oo] Juncture? !Predstart (Vv/([Ii] [Yy])/([Uu] [Yy])) !(Stress2 sp? &Co1 Predstart) Juncture?)/((!Predstart (Vv/([Ii] [Yy])/([Uu] [Yy])) !(Stress2 sp? &Co1 Predstart) Juncture?)+/(((!Predstart Vo1 !(Stress2 sp? &Co1 Predstart) Juncture?)/(!Predstart CmapuaUnit)) (!Namemarker !Alienmarker !Likie !Predstart CmapuaUnit)*))/(!Predstart Vo2 !(Stress2 sp? &Co1 Predstart) Juncture?)) !Vo1 !(Co1+ Juncture) !(sp? Connective))")

L("wy <- [Yy]")

L("ar <- [Rr]")

L("en <- [Nn]")

L("hh <- [Hh]")

L("Dash <- [-]")

L("Cvv <- (Co1 Vv ((Juncture? hh? wy Dash? &Complex)/(Juncture? ar ar? Juncture? &Co1)/(en Juncture? &ar)/(Juncture? !Vo2)))")

L("CvvNoHyphen <- (Co1 Vv Juncture? !Vo2)")

L("CvvHiddenStress <- (Co1 &DoubleVowel Vo1 Dash? Vo1 ((Dash? hh? wy Dash? &Complex)/(ar Dash? &Co1)/(en Dash? &ar)/(Dash? !Vo2)))")

L("CvvFinalStress <- (Co1 Vv ((Stress2 hh? wy Dash? &Complex)/(ar Stress2 &Co1)/(Stress2 ar ar Juncture? &Co1)/(en Stress2 &ar)/(Stress2 !Vo2)))")

L("CvvNoY <- (Co1 Vv ((Juncture? ar ar? Juncture? &Co1)/(en Juncture? &ar)/(Juncture? !Vo2)))")

L("CvvNoYFinalStress <- (Co1 Vv ((ar Stress2 &Co1)/(Stress2 ar ar Juncture? &Co1)/(en Stress2 &ar)/(Stress2 !Vo2)))")

L("CvvNoYMedialStress <- (Co1 !BrokenMono Vo2 Stress2 Vo2 Dash? !Vo2)")

L("Ccv <- (Initial Vo2 ((Juncture? wy Dash? &Letter)/(Juncture? !Vo2)))")

L("CcvStressed <- (Initial Vo2 ((Stress2 wy Dash? &Letter)/(Stress2 !Vo2)))")

L("CcvNoY <- (Initial Vo2 Juncture? !Vo2)")

L("CcvBad <- (MaybeInitial Vo2 Juncture? !Vo2)")

L("CCVBadStressed <- (MaybeInitial Vo2 Stress2 !Vo2)")

L("Cvc <- ((Co1 Vo2 !NoMedial2 !NoMedial3 Co1 ((Juncture? wy Dash? &Letter)/(Juncture? &Co1)))/(Co1 Vo2 Juncture Co1 wy Dash? &Letter))")

L("CvcStressed <- ((Co1 Vo2 !NoMedial2 !NoMedial3 Co1 ((Stress2 wy Dash? &Letter)/(Stress2 &Letter)))/(Co1 Vo2 Stress2 Co1 wy Dash? &Letter))")

L("CvcNoY <- (Co1 Vo2 !NoMedial2 !NoMedial3 Co1 Juncture? &Co1)")

L("CvcBad <- (Co1 Vo2 !NoMedial2 !NoMedial3 Juncture? Co1 &Co1)")

L("CvcNoYStressed <- (Co1 Vo2 !NoMedial2 !NoMedial3 Co1 Stress2 &Co1)")

L("CvcBadStressed <- (Co1 Vo2 !NoMedial2 !NoMedial3 Stress2 Co1 &Co1)")

L("CcvCv <- (Initial Vo2 Juncture? Co1 Vo2 Dash? !Vo2)")

L("CcvCvStreased <- (Initial Vo2 Stress2 Co1 Vo2 Dash? !Vo2)")

L("CcvCvBad <- (MaybeInitial Vo2 Juncture? Co1 Vo2 Dash? !Vo2)")

L("CcvCvBadStressed <- (MaybeInitial Vo2 Stress2 Co1 Vo2 Dash? !Vo2)")

L("CvcCv <- ((Co1 Vo2 Juncture? Initial Vo2 Dash? !Vo2)/(Co1 Vo2 !NoMedial2 Co1 Juncture? Co1 Vo2 Dash? !Vo2))")

L("CvcCvStressed <- ((Co1 Vo2 Stress2 Initial Vo2 Dash? !Vo2)/(Co1 Vo2 !NoMedial2 Co1 Stress2 Co1 Vo2 Dash? !Vo2))")

L("CcvCy <- (Initial Vo2 Juncture? Co1 wy Dash?)")

L("CvcCy <- ((Co1 Vo2 Juncture? Initial wy Dash?)/(Co1 Vo2 !NoMedial2 Co1 Juncture? Co1 wy Dash?))")

L("CcvCyStressed <- (Initial Vo2 Stress2 Co1 wy Dash?)")

L("CvcCyStressed <- ((Co1 Vo2 Stress2 Initial wy Dash?)/(Co1 Vo2 !NoMedial2 Co1 Stress2 Co1 wy Dash?))")

L("BorrowingTail1 <- (!SyllableC &StressedSyllable BorrowingSyllable (!StressedSyllable &SyllableC BorrowingSyllable)? !StressedSyllable &BorrowingSyllable VowelFinal)")

L("BorrowingTail2 <- (!SyllableC BorrowingSyllable (!StressedSyllable &SyllableC BorrowingSyllable)? !StressedSyllable &BorrowingSyllable VowelFinal (&wy/!Character))")

L("BorrowingTail3 <- (!SyllableC !StressedSyllable BorrowingSyllable (!StressedSyllable &SyllableC BorrowingSyllable)? &BorrowingSyllable InitialConsonants? Vocalic Stress2 &wy)")

L("BorrowingTail <- (BorrowingTail1/BorrowingTail2)")

L("Ccvv <- ((InitialConsonants Vo2 Juncture? Vo2 Juncture? !Character)/(InitialConsonants Vo2 Stress2 !Mono Vo2 Juncture?))")

L("PreBorrowing <- (&Predstart !Ccvv !Cmapua !SyllableC (!BorrowingTail !StressedSyllable !(SyllableC SyllableC) BorrowingSyllable)* BorrowingTail)")

L("StressedPreBorrowing <- (&Predstart !Ccvv !Cmapua !SyllableC (!BorrowingTail !StressedSyllable !(SyllableC SyllableC) BorrowingSyllable)* BorrowingTail1)")

L("PreBorrowing2 <- (&Predstart !Ccvv !Cmapua !SyllableC (!BorrowingTail !StressedSyllable !(SyllableC SyllableC) BorrowingSyllable)* BorrowingTail2)")

L("PreBorrowing3 <- (&Predstart !Ccvv !Cmapua !SyllableC (!BorrowingTail3 !StressedSyllable !(SyllableC SyllableC) BorrowingSyllable)* BorrowingTail3)")

L("RfinalDjifoa <- ((CcvCvBad/CvcCv/CvvNoHyphen/CcvBad/CvcBad) (&wy/!Character))")

L("RmediallyStressed <- (CcvCvBadStressed/CvcCvStressed/CvvNoYMedialStress)")

L("RfinallyStressed <- (CvvNoYFinalStress/CCVBadStressed/CvcBadStressed/CvcNoYStressed)")

L("BorrowingComplexTail <- (RmediallyStressed/(RfinallyStressed ((&(Co1 Mono) CvvNoHyphen)/CcvBad))/RfinalDjifoa)")

L("ResolvedBorrowing <- ((!BorrowingComplexTail (CvvNoY/CcvBad/CvcBad))* BorrowingComplexTail)")

L("Borrowing <- (!ResolvedBorrowing &caprule PreBorrowing !(sp? Connective))")

L("StressedBorrowing <- (!ResolvedBorrowing &caprule StressedPreBorrowing !(sp? &Vo1 Cmapua))")

L("BorrowingDjifoa <- (!ResolvedBorrowing &caprule PreBorrowing2 ((Stress2 wy [,] sp)/(Juncture? wy Dash?)))")

L("StressedBorrowingDjifoa <- (!ResolvedBorrowing &caprule PreBorrowing3 wy Dash? ([,] sp)?)")

L("DefaultStressedSyllable <- Syllable")

L("PhoneticComplexTail1 <- (!SyllableC !SyllableY &StressedSyllable DefaultStressedSyllable (!StressedSyllable &(SyllableC/SyllableY) Syllable)? !StressedSyllable !SyllableY VowelFinal !Vo1)")

L("PhoneticComplexTail2 <- (!SyllableC !SyllableY DefaultStressedSyllable (!StressedSyllable &(SyllableC/SyllableY) Syllable)? !StressedSyllable !SyllableY VowelFinal !Character)")

L("PhoneticComplexTail <- (PhoneticComplexTail1/PhoneticComplexTail2)")

L("PhoneticComplex <- (&Predstart !Ccvv !Cmapua !SyllableC ((StressedBorrowingDjifoa &PhoneticComplex)/(!PhoneticComplexTail !StressedSyllable !(SyllableC SyllableC) Syllable))* PhoneticComplexTail)")

L("FinalDjifoa <- ((Borrowing/CcvCv/CvcCv/CvvNoHyphen/CcvNoY) !Character)")

L("MediallyStressed <- (StressedBorrowing/CcvCvStreased/CvcCvStressed/CvvNoYMedialStress)")

L("FinallyStressed <- (StressedBorrowingDjifoa/CcvCyStressed/CvcCyStressed/CvvFinalStress/CcvStressed/CvcStressed)")

L("ComplexTail <- ((CvvHiddenStress ((&(Co1 Mono) CvvNoHyphen)/CcvNoY) !Character)/(FinallyStressed ((&(Co1 Mono) CvvNoHyphen)/CcvNoY))/MediallyStressed/FinalDjifoa)")

L("PreComplex <- ((!CvvHiddenStress !ComplexTail ((StressedBorrowingDjifoa &PhoneticComplex)/BorrowingDjifoa/CvcCy/CcvCy/Cvv/Ccv/Cvc))* ComplexTail)")

L("Complex <- (&caprule &PreComplex PhoneticComplex !(sp? Connective))")

L("LiQuote <- ((&caprule [Ll] [Ii] Juncture? Comma2? [\"] PhoneticUtterance [\"] Comma2? &caprule [Ll] [Uu] Juncture? !(sp? Connective))/(&caprule [Kk] [Ii] Juncture? [Ee] Juncture? Comma2? [(] PhoneticUtterance [)] Comma2? &caprule [Kk] [Ii] Juncture? [Uu] Juncture? !(sp? Connective)))")

L("Word <- (NAMEWORD/Cmapua/Complex/CcvNoY)")

L("SingleWord <- (((Borrowing !.)/(Complex !.)/(Word !.)/(PRENAME !.)/CcvNoY) !.)")

L("PhoneticUtterance1 <- (NAMEWORD/(sp? LiQuote)/(sp? NAMEWORD)/(sp? AlienWord)/(sp? Cmapua)/(sp? '--')/(sp? '...')/(sp? Borrowing !wy)/(sp? Complex)/(sp? CcvNoY))+")

L("PhoneticUtterance <- (PhoneticUtterance1/([,] sp)/Terminal)+")

L("Badstress <- (Stress2 sp? &Co1 Predstart)")

L("b <- (!Predstart [Bb])")

L("c <- (!Predstart [Cc])")

L("d <- (!Predstart [Dd])")

L("f <- (!Predstart [Ff])")

L("g <- (!Predstart [Gg])")

L("h <- (!Predstart [Hh])")

L("j <- (!Predstart [Jj])")

L("k <- (!Predstart [Kk])")

L("l <- (!Predstart [Ll])")

L("m <- (!Predstart [Mm])")

L("n <- (!Predstart [Nn])")

L("p <- (!Predstart [Pp])")

L("r <- (!Predstart [Rr])")

L("s <- (!Predstart [Ss])")

L("t <- (!Predstart [Tt])")

L("v <- (!Predstart [Vv])")

L("z <- (!Predstart [Zz])")

L("Vo3 <- (Juncture? Vo2 !Badstress)")

L("aa <- ([Aa] Juncture? [Aa] !Badstress Juncture? !Vo1)")

L("ae <- ([Aa] Juncture? [Ee] !Badstress Juncture? !Vo1)")

L("ai <- ([Aa] [Ii] !Badstress Juncture? !Vo1)")

L("ao <- ([Aa] [Oo] !Badstress Juncture? !Vo1)")

L("ai2 <- ([Aa] [Ii] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("ao2 <- ([Aa] [Oo] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("au <- ([Aa] Juncture? [Uu] !Badstress Juncture? !Vo1)")

L("ea <- ([Ee] Juncture? [Aa] !Badstress Juncture? !Vo1)")

L("ee <- ([Ee] Juncture? [Ee] !Badstress Juncture? !Vo1)")

L("ei <- ([Ee] [Ii] !Badstress Juncture? !Vo1)")

L("ei2 <- ([Ee] [Ii] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("eo <- ([Ee] Juncture? [Oo] !Badstress Juncture? !Vo1)")

L("eu <- ([Ee] Juncture? [Uu] !Badstress Juncture? !Vo1)")

L("ia <- ([Ii] Juncture? [Aa] !Badstress Juncture? !Vo1)")

L("ie <- ([Ii] Juncture? [Ee] !Badstress Juncture? !Vo1)")

L("ii <- ([Ii] Juncture? [Ii] !Badstress Juncture? !Vo1)")

L("io <- ([Ii] Juncture? [Oo] !Badstress Juncture? !Vo1)")

L("iu <- ([Ii] Juncture? [Uu] !Badstress Juncture? !Vo1)")

L("ia2 <- ([Ii] Juncture? [Aa] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("ie2 <- ([Ii] Juncture? [Ee] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("ii2 <- ([Ii] Juncture? [Ii] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("io2 <- ([Ii] Juncture? [Oo] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("iu2 <- ([Ii] Juncture? [Uu] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("oa <- ([Oo] Juncture? [Aa] !Badstress Juncture? !Vo1)")

L("oe <- ([Oo] Juncture? [Ee] !Badstress Juncture? !Vo1)")

L("oi <- ([Oo] [Ii] !Badstress Juncture? !Vo1)")

L("oi2 <- ([Oo] [Ii] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("oo <- ([Oo] Juncture? [Oo] !Badstress Juncture? !Vo1)")

L("ou <- ([Oo] Juncture? [Uu] !Badstress Juncture? !Vo1)")

L("ua <- ([Uu] Juncture? [Aa] !Badstress Juncture? !Vo1)")

L("ue <- ([Uu] Juncture? [Ee] !Badstress Juncture? !Vo1)")

L("ui <- ([Uu] Juncture? [Ii] !Badstress Juncture? !Vo1)")

L("uo <- ([Uu] Juncture? [Oo] !Badstress Juncture? !Vo1)")

L("uu <- ([Uu] Juncture? [Uu] !Badstress Juncture? !Vo1)")

L("ua2 <- ([Uu] Juncture? [Aa] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("ue2 <- ([Uu] Juncture? [Ee] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("ui2 <- ([Uu] Juncture? [Ii] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("uo2 <- ([Uu] Juncture? [Oo] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("uu2 <- ([Uu] Juncture? [Uu] !Badstress Juncture? &(Vo2 Juncture? !Vo1))")

L("iy <- ([Ii] [Yy] !Badstress Juncture? !Vo1)")

L("uy <- ([Uu] [Yy] !Badstress Juncture? !Vo1)")

L("OptPause <- ([,] sp !(Vo1/Connective) &caprule)")

L("Comma <- ([,] sp &caprule)")

L("Comma2 <- ([,]? sp &caprule)")

L("End <- ((sp? '#' sp utterance)/(sp !.)/!.)")

L("Period <- (([!.:;?] (&End/(sp &caprule))) (invvoc Period?)?)")

L("TAI0 <- ((Vo1 Juncture? m a)/(Vo1 Juncture? f i)/(Vo1 Juncture? z i)/(!Predstart Co1 ai)/(!Predstart Co1 ei)/(!Predstart Co1 ai2 u)/(!Predstart Co1 ei2 u)/(!Predstart Co1 eo)/(z [Ii] Vo1 !Badstress Juncture? !Vo1 (m a)?))")

L("NOI0 <- (n oi)")

L("A0 <- (&Cmapua (a/e/o/u/(h a)/(n uu)))")

L("A <- (sp? !Predstart !TAI0 (n [o])? A0 NOI0? !(sp PAWORD0 OptPause) !(PAWORD0 !OptPause [ ,]) (PAWORD0 ((f i)/&OptPause))?)")

L("ANOFI <- (sp? (!Predstart !TAI0 ((n [o])? A0 NOI0? PAWORD0?)))")

L("AONE <- A")

L("ACI <- (ANOFI c i)")

L("AGE <- (ANOFI g e)")

L("CA0 <- (((n o)? ((c a)/(c e)/(c o)/(c u)/(z e)/(c i h a)/(n u c u))) NOI0?)")

L("CA1 <- (CA0 !(sp PAWORD0 OptPause) !(PAWORD0 !OptPause [ ,]) (PAWORD0 ((f i)/&OptPause))?)")

L("CANOFI1 <- (CA0 PAWORD0?)")

L("CA <- (sp? CA1)")

L("ZE <- (sp? (z e))")

L("I <- (sp? !Predstart !TAI0 i !(sp PAWORD0 OptPause) !(PAWORD0 !OptPause [ ,]) (PAWORD0 ((f i)/&OptPause))?)")

L("ICA <- (sp? i ((h a)/CA1))")

L("ICI <- (sp? i CANOFI1? c i)")

L("IGE <- (sp? i CANOFI1? g e)")

L("KA0 <- ((k a)/(k e)/(k o)/(k u)/(k i h a)/(n u k u))")

L("KOU0 <- ((k ou)/(m oi)/(r au)/(s oa)/(m ou)/(c iu))")

L("KOU1 <- (((n u n o)/(n u)/(n o)) KOU0)")

L("KA <- (sp? (KA0/((KOU1/KOU0) k i)) NOI0?)")

L("KI <- (sp? (k i) NOI0?)")

L("KOU2 <- (KOU1 !KI)")

L("BadNIStress <- ((Co1 Vo2 Vo2? Stress (m a)? (m oa)? NI RA0)/(Co1 Vo2 Stress Vo2 (m a)? (m oa)? NI RA0))")

L("NI0 <- (!BadNIStress ((k ua)/(g ie)/(g iu)/(h ie)/(h iu)/(n ea)/(n io)/(p ea)/(p io)/(s uu)/(s ua)/(t ia)/(z oa)/(z oo)/(h o)/(n i)/(n e)/(t o)/(t e)/(f o)/(f e)/(v o)/(v e)/(p i)/(r e)/(r u)/(s e)/(s o)/(h i)))")

L("SA0 <- (!BadNIStress ((s a)/(s i)/(s u)/(ie (Comma2? !ie SA0)?)) NOI0?)")

L("RA0 <- (!BadNIStress ((r a)/(r i)/(r e)/(r u)/(r o)/(b ao)))")

L("NI1 <- ((NI0 (!BadNIStress m a)? (!BadNIStress m oa NI0*)?) (Comma2 !(NI RA0) &NI)?)")

L("RA1 <- ((RA0 (!BadNIStress m a)? (!BadNIStress m oa NI0*)?) (Comma2 !(NI RA0) &NI)?)")

L("NI2 <- (((SA0? (NI1+/RA1))/SA0) NOI0? (CA0 ((SA0? (NI1+/RA1))/SA0) NOI0?)*)")

L("NI <- (sp? (p i)? NI2 ((&(m ue) ACRONYM (Comma/&End/&Period) !(c u))/(Comma2? m ue Comma2? PRENAME !(c u)))? (c u)?)")

L("mex <- (sp? NI)")

L("CI <- (sp? (c i))")

L("ACRONYM <- (sp? &caprule ((m ue)/TAI0/(z Vo2 !Vo2)) ((Comma &ACRONYM m ue)/NI1/TAI0/(z Vo2 (!Vo2/(z &Vo2))))+)")

L("TAI <- (sp? (TAI0/((g ao) !Vo2 sp? (PRENAME/Predicate/CmapuaUnit))))")

L("DA0 <- ((t ao)/(t io)/(t ua)/(m io)/(m iu)/(m uo)/(m uu)/(t oa)/(t oi)/(t oo)/(t ou)/(t uo)/(t uu)/(s uo)/(h u)/(b a)/(b e)/(b o)/(b u)/(d a)/(d e)/(d i)/(d o)/(d u)/(m i)/(t u)/(m u)/(t i)/(t a)/(m o)/(k oo)/(d ao))")

L("DA1 <- ((TAI0/DA0) (c i ![ ] NI0)?)")

L("DA <- (sp? DA1)")

L("PA00 <- ((g ia)/(g ua)/(p au)/(v au)/(f au)/(p ia)/(p ua)/(n ia)/(n ua)/(b iu)/(f ea)/(f ia)/(f ua)/(v ia)/(v ii)/(v iu)/(c oi)/(d au)/(d ii)/(d uo)/(f oi)/(f ui)/(g au)/(h ea)/(k au)/(k ii)/(k ui)/(l ia)/(l ui)/(m ia)/(n ui)/(p eu)/(r oi)/(r ui)/(s ea)/(s io)/(t ie)/(v ie)/(v a)/(v i)/(v u)/(p a)/(n a)/(f a)/(v a)/(KOU0 !(n oi) !KI))")

L("PA0 <- (NI2? (n u !KOU0)? PA00 (n oi)? ZI?)")

L("PAWORD0 <- ((KOU2/PA0)+ ((Comma2? CA0 Comma2?) (KOU2/PA0)+)*)")

L("PAWORD <- (sp? PAWORD0)")

L("PAPHRASE0 <- (((KOU2/PA0)+ (((Comma2? CA0 Comma2?)/(Comma2 !mod1a)) (KOU2/PA0)+)*) !modifier)")

L("PAPHRASE <- (sp? PAPHRASE0)")

L("GA <- (sp? (g a))")

L("TENSE <- (PAPHRASE/GA)")

L("ZI <- ((z i)/(z a)/(z u))")

L("LE <- (sp? ((l ea)/(l eu)/(l oe)/(l ee)/(l aa)/(l e)/(l o)/(l a)))")

L("LEFORPO <- (sp? ((l e)/(l o)/NI2))")

L("LIO <- (sp? (l io))")

L("LAU <- (sp? (l au))")

L("LOU <- (sp? (l ou))")

L("LUA <- (sp? (l ua))")

L("LUO <- (sp? (l uo))")

L("ZEIA <- (sp? z ei2 a)")

L("ZEIO <- (sp? z ei2 o)")

L("LIWORD <- (l i)")

L("LUWORD <- (l u)")

L("liquote <- ((sp? LIWORD Comma2? utterance0 Comma2? LUWORD)/(sp? LIWORD Comma2? [\"] utterance0 [\"] Comma2? LUWORD))")

L("LAO <- (sp? &(LAOalien Juncture?) AlienWord)")

L("LIE <- (sp? &(LIEalien Juncture?) AlienWord)")

L("LIOALIEN <- (sp? &(LIOalien Juncture?) AlienWord)")

L("Lw <- Cmapua")

L("LIU0 <- ((l iu)/(n iu))")

L("LNIU <- (([Ll]/[Nn]) [iI] Juncture? [Uu])")

L("LIU <- ((sp? LNIU Juncture? !Vo1 Comma2? (PRENAME/Word) &(Comma/Terminal/End))/(sp? (l ii TAI)))")

L("SUE <- (sp? &(([Ss] [Uu] Juncture? [Ee] Juncture?)/([Ss] [Aa] [Oo] Juncture?)) AlienWord)")

L("CUI <- (sp? (c ui))")

L("GATWO <- (sp? (g a))")

L("GE <- (sp? (g e))")

L("GEU <- (sp? ((c ue)/(g eu)))")

L("GI <- (sp? ((g i)/(g oi)))")

L("GO <- (sp? (g o))")

L("GIO <- (sp? (g io))")

L("GU <- (sp? (g u))")

L("GUIZA <- (sp? (g ui) (z a))")

L("GUIZI <- (sp? (g ui) (z i))")

L("GUIZU <- (sp? (g ui) (z u))")

L("GUI <- (!GUIZA !GUIZI !GUIZU (sp? (g ui)))")

L("GUO <- (sp? (g uo))")

L("GUOA <- (sp? ((g uo2 a)/(g uo z a)))")

L("GUOE <- (sp? (g uo2 e))")

L("GUOI <- (sp? ((g uo2 i)/(g uo z i)))")

L("GUOO <- (sp? (g uo2 o))")

L("GUOU <- (sp? ((g uo2 u)/(g uo z u)))")

L("GUU <- (sp? (g uu))")

L("GUUA <- (sp? (g uu2 a))")

L("GIUO <- (sp? (g iu2 o))")

L("GUE <- (sp? (g ue))")

L("GUEA <- (sp? (g ue2 a))")

L("JE <- (sp? (j e))")

L("JUE <- (sp? (j ue))")

L("JIZA <- (sp? ((j ie)/(j ae)/(p e)/(j i)/(j a)) (z a))")

L("JIOZA <- (sp? ((j io)/(j ao)) (z a))")

L("JIZI <- (sp? ((j ie)/(j ae)/(p e)/(j i)/(j a)) (z i))")

L("JIOZI <- (sp? ((j io)/(j ao)) (z i))")

L("JIZU <- (sp? ((j ie)/(j ae)/(p e)/(j i)/(j a)) (z u))")

L("JIOZU <- (sp? ((j io)/(j ao)) (z u))")

L("JI <- (!JIZA !JIZI !JIZU (sp? ((j ie)/(j ae)/(p e)/(j i)/(j a))))")

L("NUJI <- (sp? n u !sp JI)")

L("JIO <- (!JIOZA !JIOZI !JIOZU (sp? ((j io)/(j ao))))")

L("DIO <- ((sp? ((b eu)/(c au)/(d io)/(f oa)/(k ao)/(j ui)/(n eu)/(p ou)/(g oa)/(s au)/(v eu)/(z ua)/(z ue)/(z ui)/(z uo)/(z uu))) ((c i ![ ] NI0)/ZI)?)")

L("LAE <- (sp? ((l ae)/(l ue)))")

L("ME <- (sp? ((m ea)/(m e)))")

L("MEU <- (sp? m eu)")

L("NU0 <- ((n uo)/(f uo)/(j uo)/(n u)/(f u)/(j u)/(k ue))")

L("NU <- (sp? ((((n u)/(n uo)/(k ue)) !(sp (NI0/RA0)) (NI0/RA0)?)/NU0)+ freemod?)")

L("PO1 <- (sp? ((p o)/(p u)/(z o)))")

L("PO1A <- (sp? ((p oi2 a)/(p ui2 a)/(z oi2 a)/(p o z a)/(p u z a)/(z o z a)))")

L("PO1E <- (sp? ((p oi2 e)/(p ui2 e)/(z oi2 e)))")

L("PO1I <- (sp? ((p oi2 i)/(p ui2 i)/(z oi2 i)/(p o z i)/(p u z i)/(z o z i)))")

L("PO1O <- (sp? ((p oi2 o)/(p ui2 o)/(z oi2 o)))")

L("PO1U <- (sp? ((p oi2 u)/(p ui2 u)/(z oi2 u)/(p o z u)/(p u z u)/(z o z u)))")

L("POSHORT1 <- (sp? ((p oi)/(p ui)/(z oi)))")

L("PO <- (sp? PO1)")

L("POA <- (sp? PO1A)")

L("POE <- (sp? PO1E)")

L("POI <- (sp? PO1E)")

L("POO <- (sp? PO1O)")

L("POU <- (sp? PO1U)")

L("POSHORT <- (sp? POSHORT1)")

L("DIE <- (sp? ((d ie)/(f ie)/(k ae)/(n ue)/(r ie)))")

L("HOI <- (sp? ((h oi)/(l oi)/(l oa)/(s ia)/(s ie)/(s iu)))")

L("JO <- (sp? (NI0/RA0/SA0)? (j o))")

L("KIE <- (sp? (k ie))")

L("KIU <- (sp? (k iu))")

L("KIE2 <- (sp? k ie Comma2? [(])")

L("KIU2 <- (sp? [)] Comma2? k iu)")

L("SOI <- (sp? (s oi))")

L("UI0 <- (!Predstart ((!([Ii] Juncture? [Ee]) Vv Juncture?)/(b ea)/(b uo)/(c ea)/(c ia)/(c oa)/(d ou)/(f ae)/(f ao)/(f eu)/(g ea)/(k uo)/(k uu)/(r ea)/(n ao)/(n ie)/(p ae)/(p iu)/(s aa)/(s ui)/(t aa)/(t oe)/(v oi)/(z ou)/(l oi)/(l oa)/(s ia)/(s ii)/(t oe)/(s iu)/(c ao)/(c eu)/(s ie)/(s eu)/(s ie2 i)))")

L("NOUI <- ((sp? UI0 NOI0)/(sp? n [o] Juncture? Comma? sp? UI0))")

L("UI <- (sp? (UI0+/(NI f i)))")

L("HUE <- (sp? (h ue))")

L("NOWORD <- (sp? !KOU1 !NOUI (n o) !(Comma2? z ao Comma2? Predicate) !(sp? KOU0) !(sp? (JIO/JI/JIZA/JIOZA/JIZI/JIOZI/JIZU/JIOZU)))")

L("ACRONYMICNAME <- (ACRONYM &(Comma/Period/End))")

L("DJAN <- (PRENAME/ACRONYMICNAME)")

L("BI <- (sp? (n u)? ((b ia)/(b ie)/(c ie)/(c io)/(b ia)/(b i)/(b ii)))")

L("LWPREDA0 <- ((h e)/(d ua)/(d ui)/(b ua)/(b ui))")

L("Predicate <- ((CmapuaUnit Comma2? z ao Comma2?)* Complex (Comma2? z ao Comma2? Predicate)?)")

L("PREDA <- (sp? &caprule (Predicate/LWPREDA0/(![ ] NI RA0)))")

L("guoa <- (OptPause? (GUOA/GU) freemod?)")

L("guoe <- (OptPause? (GUOE/GU) freemod?)")

L("guoi <- (OptPause? (GUOI/GU) freemod?)")

L("guoo <- (OptPause? (GUOO/GU) freemod?)")

L("guou <- (OptPause? (GUOU/GU) freemod?)")

L("guo <- (!guoa !guoe !guoi !guoo !guou (OptPause? (GUO/GU) freemod?))")

L("guiza <- (OptPause? (GUIZA/GU) freemod?)")

L("guizi <- (OptPause? (GUIZI/GU) freemod?)")

L("guizu <- (OptPause? (GUIZU/GU) freemod?)")

L("gui <- (OptPause? (GUI/GU) freemod?)")

L("gue <- (OptPause? (GUE/GU) freemod?)")

L("guea <- (OptPause? (GUEA/GU) freemod?)")

L("guu <- (OptPause? (GUU/GU) freemod?)")

L("guua <- (OptPause? (GUUA/GU) freemod?)")

L("giuo <- (OptPause? (GIUO/GU) freemod?)")

L("meu <- (OptPause? (MEU/GU) freemod?)")

L("geu <- GEU")

L("gap <- (OptPause? GU freemod?)")

L("HOI0 <- ((sp? (([Hh] oi)/([Ll] oi)/([Ll] oa)/([Ss] ia)/([Ss] ie)/([Ss] iu))) Juncture? !Vo1)")

L("voc <- ((HOI0 Comma2? name)/(HOI Comma2? descpred guea? namesuffix?)/(HOI Comma2? argument1 guua?)/(sp? &([Hh] [Oo] [Ii] Juncture?) AlienWord))")

L("HUE0 <- (sp? &caprule [Hh] [Uu] Juncture? [Ee] Juncture? !Vo1)")

L("invvoc <- ((HUE0 Comma2? name)/(HUE freemod? descpred guea? namesuffix?)/(HUE freemod? statement giuo?)/(HUE freemod? argument1 guu?)/(sp? &([Hh] [Uu] Juncture? [Ee] Juncture?) AlienWord))")

L("kiamod <- (Comma2? !(!PRENAME !Predstart k ia) ((PRENAME/LIU/AlienWord/(Cmapua (sp? !(k ia) !PRENAME !Predstart Cmapua)*)/Word) kiamod* Comma2? !PRENAME !Predstart k ia) Comma2?)")

L("freemod <- ((kiamod/NOUI/(SOI freemod? descpred guea?)/DIE/(NOWORD DIE)/(KIE Comma? utterance0 Comma? KIU)/(KIE2 Comma? utterance0 Comma? KIU2)/invvoc/voc/(Comma !(!FalseMarked PRENAME))/JO/UI/(sp? '...' (sp? &Letter)?)/(sp? '--' (sp? &Letter)?)) freemod?)")

L("juelink <- (JUE freemod? (term/(PAPHRASE freemod? gap?)))")

L("links1 <- (juelink (freemod? juelink)* gue?)")

L("links <- ((links1/(KA freemod? links freemod? KI freemod? links1)) (freemod? AONE freemod? links1)*)")

L("jelink <- (JE freemod? (term/(PAPHRASE freemod? gap?)))")

L("linkargs1 <- (jelink freemod? (links/gue)?)")

L("linkargs <- ((linkargs1/(KA freemod? linkargs freemod? KI freemod? linkargs1)) (freemod? AONE freemod? linkargs1)*)")

L("abstractpred <- ((POA freemod? uttAxclone guoa?)/(POA freemod? sentenceclone guoa?)/(POE freemod? uttAxclone guoe?)/(POE freemod? sentenceclone guoe?)/(POI freemod? uttAxclone guoi?)/(POI freemod? sentenceclone guoi?)/(POO freemod? uttAxclone guoo?)/(POO freemod? sentenceclone guoo?)/(POU freemod? uttAxclone guou?)/(POU freemod? sentenceclone guou?)/(PO freemod? uttAxclone guo?)/(PO freemod? sentenceclone guo?))")

L("predunit1 <- ((SUE/(NU freemod? GE freemod? despredE (freemod? geu Comma?)?)/(NU freemod? PREDA)/(Comma? GE freemod? descpred (freemod? geu Comma?)?)/abstractpred/(ME freemod? argument1 meu?)/PREDA) freemod?)")

L("predunit2 <- ((NOWORD freemod?)* predunit1)")

L("neg2 <- (!predunit2 NOWORD)")

L("predunit3 <- ((predunit2 freemod? linkargs)/predunit2)")

L("predunit <- ((POSHORT freemod?)? predunit3)")

L("kekpredunit <- ((NOWORD freemod?)* KA freemod? predicate freemod? KI freemod? predicate guu?)")

L("despredA <- ((predunit/kekpredunit) (freemod? CI freemod? (predunit/kekpredunit))*)")

L("despredB <- ((!PREDA CUI freemod? despredC freemod? CA freemod? despredB)/despredA)")

L("despredC <- (despredB (freemod? despredB)*)")

L("despredD <- (despredB (freemod? CA freemod? despredB)*)")

L("despredE <- (despredD (freemod? despredD)*)")

L("descpred <- ((despredE freemod? GO freemod? descpred)/despredE)")

L("sentpred <- ((despredE freemod? GO freemod? barepred)/despredE)")

L("mod1a <- (PAWORD freemod? argument1 guua?)")

L("mod1 <- ((PAWORD freemod? argument1 guua?)/(PAPHRASE freemod? !barepred gap?))")

L("kekmod <- ((NOWORD freemod?)* (KA freemod? modifier freemod? KI freemod? mod))")

L("mod <- (mod1/((NOWORD freemod?)* mod1)/kekmod)")

L("modifier <- (mod (AONE freemod? mod)*)")

L("name <- ((PRENAME/ACRONYMICNAME) ((Comma2? !FalseMarked PRENAME)/(Comma2? &([Cc] [Ii]) NAMEWORD)/(Comma2? CI predunit !(Comma2? (!FalseMarked PRENAME)))/(Comma2? CI ACRONYMICNAME))* freemod?)")

L("LAWORD <- (sp? [Ll] [Aa] Juncture?)")

L("LANAME <- (LAWORD Comma2? name)")

L("descriptn <- (!LANAME ((LAU wordset1)/(LOU wordset2)/(LE freemod? ((!mex arg1a freemod?)? (PAPHRASE freemod?)?)? ((mex freemod? arg1a)/(mex freemod? descpred)/descpred))/(GE freemod? mex freemod? descpred)))")

L("abstractn <- ((LEFORPO freemod? POA freemod? uttAxclone guoa?)/(LEFORPO freemod? POA freemod? sentenceclone guoa?)/(LEFORPO freemod? POE freemod? uttAxclone guoe?)/(LEFORPO freemod? POE freemod? sentenceclone guoe?)/(LEFORPO freemod? POI freemod? uttAxclone guoi?)/(LEFORPO freemod? POI freemod? sentenceclone guoi?)/(LEFORPO freemod? POO freemod? uttAxclone guoo?)/(LEFORPO freemod? POO freemod? sentenceclone guoo?)/(LEFORPO freemod? POU freemod? uttAxclone guou?)/(LEFORPO freemod? POU freemod? sentenceclone guou?)/(LEFORPO freemod? PO freemod? uttAxclone guo?)/(LEFORPO freemod? PO freemod? sentenceclone guo?))")

L("Ciforsuffix <- ([Cc] [Ii])")

L("namesuffix <- (&((Comma2 !FalseMarked PRENAME)/(sp? Ciforsuffix Juncture? Comma2? (PRENAME/ACRONYMICNAME))) ((sp? Ciforsuffix Juncture? Comma2?)/Comma2)? name)")

L("arg1 <- (abstractn/(LIO freemod? descpred guea?)/(LIO freemod? argument1 guua?)/(LIO freemod? mex gap?)/LIOALIEN/LAO/LANAME/(descriptn guua? namesuffix?)/LIU/LIE/liquote)")

L("arg1a <- ((DA/TAI/arg1/(GE freemod? arg1a)) freemod?)")

L("argmod1 <- (((sp? (n o) sp?)? ((JI freemod? predicate)/(JIO freemod? sentence)/(JIO freemod? uttAx)/(JI freemod? modifier)/((JI/NUJI) freemod? argument1)))/((sp? (n o) sp?)? (((JIZA freemod? predicate) guiza?)/((JIOZA freemod? sentence) guiza?)/((JIOZA freemod? uttAx) guiza?)/((JIZA freemod? modifier) guiza?)/(JIZA freemod? argument1 guiza?)))/((sp? (n o) sp?)? ((JIZI freemod? predicate guizi?)/(JIOZI freemod? sentence guizi?)/(JIOZI freemod? uttAx guizi?)/(JIZI freemod? modifier guizi?)/(JIZI freemod? argument1 guizi?)))/((sp? (n o) sp?)? ((JIZU freemod? predicate guizu?)/(JIOZU freemod? sentence guizu?)/(JIOZU freemod? uttAx guizu?)/(JIZU freemod? modifier guizu?)/(JIZU freemod? argument1 guizu?))))")

L("argmod <- (argmod1 (AONE freemod? argmod1)* gui?)")

L("arg2 <- (arg1a freemod? argmod*)")

L("arg3 <- (arg2/(mex freemod? arg2))")

L("indef1 <- (mex freemod? descpred)")

L("indef2 <- (indef1 guua? argmod*)")

L("indefinite <- indef2")

L("arg4 <- ((arg3/indefinite) (ZE freemod? (arg3/indefinite))*)")

L("arg5 <- (arg4/(KA freemod? argument1 freemod? KI freemod? argx))")

L("argx <- ((NOWORD freemod?)* (LAE freemod?)* arg5)")

L("arg7 <- (argx freemod? (ACI freemod? argx)?)")

L("arg8 <- (!GE (arg7 freemod? (AONE freemod? arg7)*))")

L("argument1 <- (((arg8 freemod? AGE freemod? argument1)/arg8) (GUU freemod? argmod)*)")

L("argument <- ((NOWORD freemod?)* (DIO freemod?)* argument1)")

L("argxx <- (&((NOWORD freemod?)* DIO) argument)")

L("term <- (argument/modifier)")

L("modifiers <- (modifier (freemod? modifier)*)")

L("modifiersx <- ((modifier/argxx) (freemod? (modifier/argxx))*)")

L("subject <- ((modifiers freemod?)? ((argxx subject)/(argument (modifiersx freemod?)?)))")

L("argumentA <- argument")

L("argumentB <- argument")

L("argumentC <- argument")

L("argumentD <- argument")

L("argumentA1 <- argument")

L("argumentB1 <- argument")

L("argumentC1 <- argument")

L("argumentD1 <- argument")

L("terms <- ((modifiersx? argumentA (freemod? modifiersx)? argumentB? (freemod? modifiersx)? argumentC? (freemod? modifiersx)? argumentD?)/modifiersx)")

L("terms1 <- ((modifiersx? argumentA1 (freemod? modifiersx)? argumentB1? (freemod? modifiersx)? argumentC1? (freemod? modifiersx)? argumentD1?)/modifiersx)")

L("word <- (arg1a/indef2)")

L("words1 <- (word (ZEIA? word)*)")

L("words2 <- (word (ZEIO? word)*)")

L("wordset1 <- (words1? LUA)")

L("wordset2 <- (words2? LUO)")

L("termset1 <- (terms/(KA freemod? termset2 freemod? guu? KI freemod? termset1))")

L("termset2 <- (termset1 (guu &AONE)? (AONE freemod? termset1 (guu &AONE)?)*)")

L("termset <- ((terms freemod? GO freemod? barepred)/termset2)")

L("barepred <- (sentpred freemod? ((termset guu?)/(guu &termset))?)")

L("markpred <- (TENSE freemod? barepred)")

L("backpred1 <- ((neg2 freemod?)* (barepred/markpred))")

L("backpred <- (((backpred1 (ACI freemod? backpred1)+ freemod? ((termset guu?)/(guu &termset))?) ((ACI freemod? backpred)+ freemod? ((termset guu?)/(guu &termset))?)?)/backpred1)")

L("predicate2 <- (!GE (((backpred (AONE !GE freemod? backpred)+ freemod? ((termset guu?)/(guu &termset))?) ((AONE freemod? predicate2)+ freemod? ((termset guu?)/(guu &termset))?)?)/backpred))")

L("predicate1 <- ((predicate2 AGE freemod? predicate1)/predicate2)")

L("identpred <- ((NOWORD freemod?)* (BI freemod? argument1 guu?))")

L("predicate <- (predicate1/identpred)")

L("gasent1 <- ((NOWORD freemod?)* (freemod? &markpred predicate (GATWO freemod? subject)?))")

L("gasent2 <- ((NOWORD freemod?)* (TENSE freemod? sentpred modifiers? (GATWO freemod? subject freemod? GIO? freemod? terms?)))")

L("gasent <- (gasent2/gasent1)")

L("statement <- (gasent/(modifiers freemod? gasent)/(subject freemod? freemod? (GIO? freemod? terms1)? predicate))")

L("keksent <- (terms? freemod? (NOWORD freemod?)* (KA freemod? headterms? freemod? sentence freemod? KI freemod? sen1))")

L("keksentclone <- (terms? freemod? (NOWORD freemod?)* (KA freemod? headterms? freemod? sentenceclone freemod? KI freemod? sen1clone))")

L("neghead <- ((NOWORD freemod? gap)/(neg2 OptPause))")

L("imperative <- ((modifiers freemod?)? !gasent predicate)")

L("nosubject <- ((modifiers freemod?)? !gasent predicate)")

L("headterms <- (terms GI freemod?)+")

L("uttAx <- (headterms freemod? sentence giuo?)")

L("uttAxclone <- (headterms freemod? sentenceclone giuo?)")

L("sen1 <- ((neghead freemod?)* (imperative/statement/keksent/uttAx))")

L("sen1clone <- ((neghead freemod?)* (nosubject/statement/keksentclone/uttAxclone))")

L("sentence1 <- (sen1 (ICI freemod? sen1)*)")

L("sentence1clone <- (sen1clone (ICI freemod? sen1clone)*)")

L("sentence <- (sentence1 ([!.:;?]? ICA freemod? sentence1)*)")

L("sentenceclone <- (sentence1clone ([!.:;?]? ICA freemod? sentence1clone)*)")

L("uttA <- ((AONE/mex) freemod?)")

L("uttA1 <- ((links/linkargs/argmod/terms/uttA/NOWORD) freemod? Period?)")

L("uttC <- ((sentence Period?)/(neghead freemod? uttC)/uttA1)")

L("uttE <- (uttC (ICA freemod? uttC)*)")

L("uttF <- (uttE (I freemod? uttE)*)")

L("utterance0 <- (!GE ((ICA freemod? uttF)/(!OptPause freemod Period? utterance0)/(!OptPause freemod Period?)/(uttF IGE utterance0)/uttF/(I freemod? uttF?)/(I freemod? Period?)) (&I utterance0)?)")

L("utterance <- (&(PhoneticUtterance End) (!GE ((ICA freemod? uttF (&I utterance)? End)/(!OptPause freemod Period? utterance)/(!OptPause freemod Period? (&I utterance)? End)/(uttF IGE utterance)/(I freemod? Period? (&I utterance)? End)/(uttF (&I utterance)? End)/(I freemod? uttF (&I utterance)? End))))")

if __name__ == '__main__':interface();