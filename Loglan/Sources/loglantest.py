from loglanpreamble import *

L("sp <- [ ]+")

L("V1 <- [aeiouyAEIOUY]")

L("V2 <- [aeiouAEIOU]")

L("C1 <- [bcdfghjklmnprstvzBCDFGHJKLMNPRSTVZ]")

L("Cvoiced <- [bdgjvzBDGJVZ]")

L("Cunvoiced <- [ptkcfsPTKCFS]")

L("Badvoice <- ((Cvoiced (Cunvoiced/[Hh]))/(Cunvoiced (Cvoiced/[Hh])))")

L("letter <- (![qwxQWX] [a-zA-Z])")

L("lowercase <- (![qwx] [a-z])")

L("uppercase <- (![QWX] [A-Z])")

L("caprule <- ([\"(]? &(([z] V1 (!uppercase/&TAI0))/(lowercase TAI0 (!uppercase/&TAI0))/(!(lowercase uppercase) .)) letter (&(([z] V1 (!uppercase/&TAI0))/(lowercase TAI0 (!uppercase/&TAI0))/(!(lowercase uppercase) .)) (letter/juncture))* !(letter/juncture))")

L("stress2 <- [\'*]")

L("juncture <- ((([-] &letter)/stress2) !juncture)")

L("stress <- ([\'*] !juncture)")

L("terminal <- [.:?!;#]")

L("character <- (letter/juncture)")

L("AlienText <- (([,]? sp [\"] (![\"] .)+ [\"])/([,]? sp (![, ] !terminal .)+ ([,]? sp [Yy] [,]? sp (![, ] !terminal .)+)*))")

L("HOIalien <- ([Hh] [Oo] [Ii])")

L("HUEalien <- ([Hh] [Uu] juncture? [Ee])")

L("LIEalien <- ([Ll] [Ii] juncture? [Ee])")

L("LAOalien <- ([Ll] [Aa] [Oo])")

L("LIOalien <- ([Ll] [Ii] juncture? [Oo])")

L("SAOalien <- ([Ss] [Aa] [Oo])")

L("SUEalien <- ([Ss] [Uu] juncture? [Ee])")

L("AlienWord <- (&caprule ((HOIalien juncture? &([,]? sp [\"]))/(HUEalien juncture? &([,]? sp [\"]))/(LIEalien juncture?)/(LAOalien juncture?)/(LIOalien juncture?)/(SAOalien juncture?)/(SUEalien juncture?)) AlienText)")

L("alienmarker <- ((([Hh] [Oo] [Ii] juncture? &([,]? sp [\"]))/([Hh] [Uu] juncture? [Ee] juncture? &([,]? sp [\"]))/([Ll] [Ii] juncture? [Ee] juncture?)/([Ll] [Aa] [Oo] juncture?)/([Ll] [Ii] juncture? [Oo] juncture?)/([Ss] [Aa] [Oo] juncture?)/([Ss] [Uu] juncture? [Ee] juncture?)) !V1)")

L("continuant <- [mnlrMNLR]")

L("syllabic <- (([mM] [mM] !(juncture? [mM]))/([nN] [nN] !(juncture? [nN]))/([rR] [rR] !(juncture? [rR]))/([lL] [lL] !(juncture? [lL])))")

L("MustMono <- (([aeoAEO] [iI] ![iI])/([aA] [oO]))")

L("BrokenMono <- (([aeoAEO] juncture [iI] ![iI])/([aA] juncture [oO]))")

L("Mono <- (MustMono/([iI] !([uU] [uU]) V2)/([uU] !([iI] [iI]) V2))")

L("VV <- (!(!MustMono V2 juncture? V2 juncture? [Rr] [Rr]) (!BrokenMono V2 juncture? V2))")

L("NextVowels <- (MustMono/(V2 &MustMono)/Mono/(!([Ii] juncture [Ii] V1) !([Uu] juncture [Uu] V1) V2))")

L("DoubleVowel <- (([aA] juncture? [aA])/([eE] juncture? [eE])/([oO] juncture? [oO])/([iI] juncture [iI])/([uU] juncture [uU])/([iI] [Ii] &[iI])/([Uu] [uU] &[uU]))")

L("Vocalic <- (NextVowels/syllabic/[Yy])")

L("Initial <- (([Bb] [Ll])/([Bb] [Rr])/([Cc] [Kk])/([Cc] [Ll])/([Cc] [Mm])/([Cc] [Nn])/([Cc] [Pp])/([Cc] [Rr])/([Cc] [Tt])/([Dd] [Jj])/([Dd] [Rr])/([Dd] [Zz])/([Ff] [Ll])/([Ff] [Rr])/([Gg] [Ll])/([Gg] [Rr])/([Jj] [Mm])/([Kk] [Ll])/([Kk] [Rr])/([Mm] [Rr])/([Pp] [Ll])/([Pp] [Rr])/([Ss] [Kk])/([Ss] [Ll])/([Ss] [Mm])/([Ss] [Nn])/([Ss] [Pp])/([Ss] [Rr])/([Ss] [Tt])/([Ss] [Vv])/([Tt] [Cc])/([Tt] [Rr])/([Tt] [Ss])/([Vv] [Ll])/([Vv] [Rr])/([Zz] [Bb])/([Zz] [Ll])/([Zz] [Vv]))")

L("MaybeInitial <- (([Bb] juncture? [Ll])/([Bb] juncture? [Rr])/([Cc] juncture? [Kk])/([Cc] juncture? [Ll])/([Cc] juncture? [Mm])/([Cc] juncture? [Nn])/([Cc] juncture? [Pp])/([Cc] juncture? [Rr])/([Cc] juncture? [Tt])/([Dd] juncture? [Jj])/([Dd] juncture? [Rr])/([Dd] juncture? [Zz])/([Ff] juncture? [Ll])/([Ff] juncture? [Rr])/([Gg] juncture? [Ll])/([Gg] juncture? [Rr])/([Jj] juncture? [Mm])/([Kk] juncture? [Ll])/([Kk] juncture? [Rr])/([Mm] juncture? [Rr])/([Pp] juncture? [Ll])/([Pp] juncture? [Rr])/([Ss] juncture? [Kk])/([Ss] juncture? [Ll])/([Ss] juncture? [Mm])/([Ss] juncture? [Nn])/([Ss] juncture? [Pp])/([Ss] juncture? [Rr])/([Ss] juncture? [Tt])/([Ss] juncture? [Vv])/([Tt] juncture? [Cc])/([Tt] juncture? [Rr])/([Tt] juncture? [Ss])/([Vv] juncture? [Ll])/([Vv] juncture? [Rr])/([Zz] juncture? [Bb])/([Zz] juncture? [Ll])/([Zz] juncture? [Vv]))")

L("InitialConsonants <- ((!syllabic C1 &Vocalic)/(!(C1 syllabic) Initial &Vocalic)/(&Initial C1 !(C1 syllabic) Initial !syllabic &Vocalic))")

L("NoMedial2 <- (([Bb] juncture? [Bb])/([Cc] juncture? [Cc])/([Dd] juncture? [Dd])/([Ff] juncture? [Ff])/([Gg] juncture? [Gg])/([Hh] juncture? C1)/([Jj] juncture? [Jj])/([Kk] juncture? [Kk])/([Ll] juncture? [Ll])/([Mm] juncture? [Mm])/([Nn] juncture? [Nn])/([Pp] juncture? [Pp])/([Rr] juncture? [Rr])/([Ss] juncture? [Ss])/([Tt] juncture? [Tt])/([Vv] juncture? [Vv])/([Zz] juncture? [Zz])/([CJSZcjsz] juncture? [CJSZcjsz])/([Ff] juncture? [Vv])/([Kk] juncture? [Gg])/([Pp] juncture? [Bb])/([Tt] juncture? [Dd])/([FKPTfkpt] juncture? [JZjz])/([Bb] juncture? [Jj])/([Ss] juncture? [Bb]))")

L("NoMedial3 <- (([Cc] juncture? [Dd] juncture? [Zz])/([Cc] juncture? [Vv] juncture? [Ll])/([Nn] juncture? [Dd] juncture? [Jj])/([Nn] juncture? [Dd] juncture? [Zz])/([Dd] juncture? [Cc] juncture? [Mm])/([Dd] juncture? [Cc] juncture? [Tt])/([Dd] juncture? [Tt] juncture? [Ss])/([Pp] juncture? [Dd] juncture? [Zz])/([Gg] juncture? [Tt] juncture? [Ss])/([Gg] juncture? [Zz] juncture? [Bb])/([Ss] juncture? [Vv] juncture? [Ll])/([Jj] juncture? [Dd] juncture? [Jj])/([Jj] juncture? [Tt] juncture? [Cc])/([Jj] juncture? [Tt] juncture? [Ss])/([Jj] juncture? [Vv] juncture? [Rr])/([Tt] juncture? [Vv] juncture? [Ll])/([Kk] juncture? [Dd] juncture? [Zz])/([Vv] juncture? [Tt] juncture? [Ss])/([Mm] juncture? [Zz] juncture? [Bb]))")

L("SyllableA <- (C1 V2 FinalConsonant (!Syllable FinalConsonant)?)")

L("SyllableB <- (InitialConsonants? Vocalic (!Syllable FinalConsonant)? (!Syllable FinalConsonant)?)")

L("Syllable <- ((SyllableA/SyllableB) juncture?)")

L("FinalConsonant <- (!syllabic !(&Badvoice C1 !Syllable) (!(!continuant C1 !Syllable continuant) !NoMedial2 !NoMedial3 C1 !(juncture? (V2/syllabic))))")

L("SyllableD <- (&(InitialConsonants? ([Yy]/DoubleVowel/BrokenMono/(&Mono V2 DoubleVowel)/(!MustMono &Mono V2 BrokenMono))) Syllable)")

L("BorrowingSyllable <- (!syllabic !SyllableD Syllable)")

L("VowelFinal <- (InitialConsonants? Vocalic juncture? !V2)")

L("SyllableC <- (&(InitialConsonants? syllabic) Syllable)")

L("SyllableY <- (&(InitialConsonants? [Yy]) Syllable)")

L("StressedSyllable <- ((SyllableA/SyllableB) stress2)")

L("NameEndSyllable <- (InitialConsonants? (syllabic/(Vocalic &FinalConsonant)) FinalConsonant? FinalConsonant? stress? !letter)")

L("maybepause <- (V1 stress2? sp C1)")

L("pause <- ((C1 stress2? sp &letter)/(letter stress2? sp &V1)/(letter stress2? [,] sp &letter))")

L("MaybePauseSyllable <- (InitialConsonants? Vocalic stress2? &(sp &C1))")

L("PreName <- ((Syllable &Syllable)* NameEndSyllable)")

L("BadPreName <- (((MaybePauseSyllable sp)/(Syllable &Syllable))* NameEndSyllable)")

L("LAname <- ([Ll] [Aa])")

L("HOIname <- ([Hh] [Oo] [Ii])")

L("CIname <- ([Cc] [Ii])")

L("LIUname <- ([Ll] [Ii] juncture? [Uu])")

L("MUEname <- ([Mm] [Uu] juncture? [Ee])")

L("GAOname <- ([Gg] [Aa] [Oo])")

L("HUEname <- ([Hh] [Uu] juncture? [Ee])")

L("LAname2 <- ([Ll] !pause [Aa])")

L("HOIname2 <- ([Hh] [Oo] !pause [Ii])")

L("LIUname2 <- ([Ll] [Ii] juncture? !pause [Uu])")

L("MUEname2 <- ([Mm] [Uu] juncture? !pause [Ee])")

L("GAOname2 <- ([Gg] [Aa] !pause [Oo])")

L("HUEname2 <- ([Hh] [Uu] juncture? !pause [Ee])")

L("MarkedName <- (&caprule ((LAname2 juncture?)/(HOIname2 juncture?)/(HUEname2 juncture?)/(LIUname2 juncture?)/(GAOname2 juncture?)/(MUEname2 juncture?)) sp? &C1 &caprule PreName)")

L("FalseMarked <- (&PreName (!MarkedName character)* MarkedName)")

L("NameWord <- (((&caprule MarkedName)/([,] sp !FalseMarked &caprule PreName)/(&V1 !FalseMarked &caprule PreName)/(&caprule (((LAname juncture?)/(HOIname juncture?)/(HUEname juncture?)/(CIname juncture? &([,]? sp))/(LIUname juncture?)/(MUEname juncture?)/(GAOname juncture?)) !V1 [,]? sp? &caprule PreName))) (([,]? sp !FalseMarked &caprule PreName)/([,]? sp &([Cc] [Ii]) NameWord))* &((sp? [Cc] [Ii] predunit)/(&(([,] sp)/terminal/[\")]/!.) .)/!.))")

L("namemarker <- ((([Ll] [Aa] juncture?)/([Hh] [Oo] [Ii] juncture?)/([Hh] [Uu] juncture? [Ee] juncture?)/([Cc] &(pause/([Ii] juncture? sp PreName)) [Ii] juncture?)/([Ll] [Ii] juncture? [Uu] juncture?)/([Gg] [Aa] [Oo] juncture?)/([Mm] [Uu] juncture? [Ee] juncture?)) !V1)")

L("badnamemarker <- (namemarker !V1 [, ]? sp? BadPreName)")

L("Vthree <- ((V2 juncture?) (V2 juncture?) (V2 juncture?))")

L("Vfour <- ((V2 juncture?) (V2 juncture?) (V2 juncture?) (V2 juncture?))")

L("predstartA1 <- (((&MaybeInitial C1 juncture? MaybeInitial)/MaybeInitial) &V2 !(V2 stress !Mono V2) !(V2 juncture? V2 !character) !(V2 juncture? !character))")

L("predstartA2 <- (C1 V2 juncture? (V2 juncture?)? !predstartA1 C1 juncture? C1)")

L("predstartA3 <- (C1 !Vthree (!StressedSyllable V2 juncture?)? &StressedSyllable V2 V2? juncture? C1 juncture? C1)")

L("predstartA4 <- (C1? V2 juncture? (V2 juncture?)? (V2 juncture?)? !predstartA1 !(MaybeInitial V2) C1 juncture? C1)")

L("predstartA5 <- (C1? !Vfour (!StressedSyllable V2 juncture?)? (!StressedSyllable V2 juncture?)? &StressedSyllable V2 V2? juncture? !(MaybeInitial V2) C1 juncture? C1)")

L("predstartA6 <- (C1 (V2 juncture?) ((V2 juncture? [Hh]?)/(C1 juncture? (C1 juncture?)?)) [Yy])")

L("predstart <- (predstartA1/predstartA2/predstartA3/predstartA4/predstartA5/predstartA6)")

L("a <- ([Aa] !badstress juncture? !V1)")

L("e <- ([Ee] !badstress juncture? !V1)")

L("i <- ([Ii] !badstress juncture? !V1)")

L("o <- ([Oo] !badstress juncture? !V1)")

L("u <- ([Uu] !badstress juncture? !V1)")

L("Hearly <- (!predstart [Hh])")

L("Nearly <- (!predstart [Nn])")

L("connective <- (sp? !predstart ([Nn] [Oo] juncture? !i)? (a/e/i/o/u/(Hearly a)/(Nearly UU)) juncture? !V2 !(!predstart [Ff] [Ii]) !(!predstart [Mm] [Aa]) !(!predstart [Zz] [Ii]))")

L("CmapuaUnit <- ((C1 Mono juncture? V2 !(stress2 sp? &C1 predstart) juncture? !V1)/(C1 (VV/([Ii] [Yy])/([Uu] [Yy])) !(stress2 sp? &C1 predstart) juncture? !V1)/(C1 V2 !(stress2 sp? &C1 predstart) juncture? !V1))")

L("likie <- (([Ll] [Ii] juncture? !V1)/([Ki] [Ii] juncture? [Ee] juncture? !V1))")

L("Cmapua <- (&caprule !badnamemarker ((!predstart (VV/([Ii] [Yy])/([Uu] [Yy])) !(stress2 sp? &C1 predstart) juncture? NOI)/(!predstart [Nn] [Oo] juncture? !predstart (VV/([Ii] [Yy])/([Uu] [Yy])) !(stress2 sp? &C1 predstart) juncture?)/((!predstart (VV/([Ii] [Yy])/([Uu] [Yy])) !(stress2 sp? &C1 predstart) juncture?)+/(((!predstart V1 !(stress2 sp? &C1 predstart) juncture?)/(!predstart CmapuaUnit)) (!namemarker !alienmarker !likie !predstart CmapuaUnit)*))/(!predstart V2 !(stress2 sp? &C1 predstart) juncture?)) !V1 !(C1+ juncture) !(sp? connective))")

L("why <- [Yy]")

L("arr <- [Rr]")

L("enn <- [Nn]")

L("aitch <- [Hh]")

L("dash <- [-]")

L("CVV <- (C1 VV ((juncture? aitch? why dash? &Complex)/(juncture? arr arr? juncture? &C1)/(enn juncture? &arr)/(juncture? !V2)))")

L("CVVNoHyphen <- (C1 VV juncture? !V2)")

L("CVVHiddenStress <- (C1 &DoubleVowel V1 dash? V1 ((dash? aitch? why dash? &Complex)/(arr dash? &C1)/(enn dash? &arr)/(dash? !V2)))")

L("CVVFinalStress <- (C1 VV ((stress2 aitch? why dash? &Complex)/(arr stress2 &C1)/(stress2 arr arr juncture? &C1)/(enn stress2 &arr)/(stress2 !V2)))")

L("CVVNOY <- (C1 VV ((juncture? arr arr? juncture? &C1)/(enn juncture? &arr)/(juncture? !V2)))")

L("CVVNOYFinalStress <- (C1 VV ((arr stress2 &C1)/(stress2 arr arr juncture? &C1)/(enn stress2 &arr)/(stress2 !V2)))")

L("CVVNOYMedialStress <- (C1 !BrokenMono V2 stress2 V2 dash? !V2)")

L("CCV <- (Initial V2 ((juncture? why dash? &letter)/(juncture? !V2)))")

L("CCVStressed <- (Initial V2 ((stress2 why dash? &letter)/(stress2 !V2)))")

L("CCVNOY <- (Initial V2 juncture? !V2)")

L("CCVBad <- (MaybeInitial V2 juncture? !V2)")

L("CCVBadStressed <- (MaybeInitial V2 stress2 !V2)")

L("CVC <- ((C1 V2 !NoMedial2 !NoMedial3 C1 ((juncture? why dash? &letter)/(juncture? &C1)))/(C1 V2 juncture C1 why dash? &letter))")

L("CVCStressed <- ((C1 V2 !NoMedial2 !NoMedial3 C1 ((stress2 why dash? &letter)/(stress2 &letter)))/(C1 V2 stress2 C1 why dash? &letter))")

L("CVCNOY <- (C1 V2 !NoMedial2 !NoMedial3 C1 juncture? &C1)")

L("CVCBad <- (C1 V2 !NoMedial2 !NoMedial3 juncture? C1 &C1)")

L("CVCNOYStressed <- (C1 V2 !NoMedial2 !NoMedial3 C1 stress2 &C1)")

L("CVCBadStressed <- (C1 V2 !NoMedial2 !NoMedial3 stress2 C1 &C1)")

L("CCVCV <- (Initial V2 juncture? C1 V2 dash? !V2)")

L("CCVCVStressed <- (Initial V2 stress2 C1 V2 dash? !V2)")

L("CCVCVBad <- (MaybeInitial V2 juncture? C1 V2 dash? !V2)")

L("CCVCVBadStressed <- (MaybeInitial V2 stress2 C1 V2 dash? !V2)")

L("CVCCV <- ((C1 V2 juncture? Initial V2 dash? !V2)/(C1 V2 !NoMedial2 C1 juncture? C1 V2 dash? !V2))")

L("CVCCVStressed <- ((C1 V2 stress2 Initial V2 dash? !V2)/(C1 V2 !NoMedial2 C1 stress2 C1 V2 dash? !V2))")

L("CCVCY <- (Initial V2 juncture? C1 why dash?)")

L("CVCCY <- ((C1 V2 juncture? Initial why dash?)/(C1 V2 !NoMedial2 C1 juncture? C1 why dash?))")

L("CCVCYStressed <- (Initial V2 stress2 C1 why dash?)")

L("CVCCYStressed <- ((C1 V2 stress2 Initial why dash?)/(C1 V2 !NoMedial2 C1 stress2 C1 why dash?))")

L("BorrowingTail1 <- (!SyllableC &StressedSyllable BorrowingSyllable (!StressedSyllable &SyllableC BorrowingSyllable)? !StressedSyllable &BorrowingSyllable VowelFinal)")

L("BorrowingTail2 <- (!SyllableC BorrowingSyllable (!StressedSyllable &SyllableC BorrowingSyllable)? !StressedSyllable &BorrowingSyllable VowelFinal (&why/!character))")

L("BorrowingTail3 <- (!SyllableC !StressedSyllable BorrowingSyllable (!StressedSyllable &SyllableC BorrowingSyllable)? &BorrowingSyllable InitialConsonants? Vocalic stress2 &why)")

L("BorrowingTail <- (BorrowingTail1/BorrowingTail2)")

L("CCVV <- ((InitialConsonants V2 juncture? V2 juncture? !character)/(InitialConsonants V2 stress2 !Mono V2 juncture?))")

L("PreBorrowing <- (&predstart !CCVV !Cmapua !SyllableC (!BorrowingTail !StressedSyllable !(SyllableC SyllableC) BorrowingSyllable)* BorrowingTail)")

L("StressedPreBorrowing <- (&predstart !CCVV !Cmapua !SyllableC (!BorrowingTail !StressedSyllable !(SyllableC SyllableC) BorrowingSyllable)* BorrowingTail1)")

L("PreBorrowing2 <- (&predstart !CCVV !Cmapua !SyllableC (!BorrowingTail !StressedSyllable !(SyllableC SyllableC) BorrowingSyllable)* BorrowingTail2)")

L("PreBorrowing3 <- (&predstart !CCVV !Cmapua !SyllableC (!BorrowingTail3 !StressedSyllable !(SyllableC SyllableC) BorrowingSyllable)* BorrowingTail3)")

L("RFinalDjifoa <- ((CCVCVBad/CVCCV/CVVNoHyphen/CCVBad/CVCBad) (&why/!character))")

L("RMediallyStressed <- (CCVCVBadStressed/CVCCVStressed/CVVNOYMedialStress)")

L("RFinallyStressed <- (CVVNOYFinalStress/CCVBadStressed/CVCBadStressed/CVCNOYStressed)")

L("BorrowingComplexTail <- (RMediallyStressed/(RFinallyStressed ((&(C1 Mono) CVVNoHyphen)/CCVBad))/RFinalDjifoa)")

L("ResolvedBorrowing <- ((!BorrowingComplexTail (CVVNOY/CCVBad/CVCBad))* BorrowingComplexTail)")

L("Borrowing <- (!ResolvedBorrowing &caprule PreBorrowing !(sp? connective))")

L("StressedBorrowing <- (!ResolvedBorrowing &caprule StressedPreBorrowing !(sp? &V1 Cmapua))")

L("BorrowingDjifoa <- (!ResolvedBorrowing &caprule PreBorrowing2 ((stress2 why [,] sp)/(juncture? why dash?)))")

L("StressedBorrowingDjifoa <- (!ResolvedBorrowing &caprule PreBorrowing3 why dash? ([,] sp)?)")

L("DefaultStressedSyllable <- Syllable")

L("PhoneticComplexTail1 <- (!SyllableC !SyllableY &StressedSyllable DefaultStressedSyllable (!StressedSyllable &(SyllableC/SyllableY) Syllable)? !StressedSyllable !SyllableY VowelFinal !V1)")

L("PhoneticComplexTail2 <- (!SyllableC !SyllableY DefaultStressedSyllable (!StressedSyllable &(SyllableC/SyllableY) Syllable)? !StressedSyllable !SyllableY VowelFinal !character)")

L("PhoneticComplexTail <- (PhoneticComplexTail1/PhoneticComplexTail2)")

L("PhoneticComplex <- (&predstart !CCVV !Cmapua !SyllableC ((StressedBorrowingDjifoa &PhoneticComplex)/(!PhoneticComplexTail !StressedSyllable !(SyllableC SyllableC) Syllable))* PhoneticComplexTail)")

L("FinalDjifoa <- ((Borrowing/CCVCV/CVCCV/CVVNoHyphen/CCVNOY) !character)")

L("MediallyStressed <- (StressedBorrowing/CCVCVStressed/CVCCVStressed/CVVNOYMedialStress)")

L("FinallyStressed <- (StressedBorrowingDjifoa/CCVCYStressed/CVCCYStressed/CVVFinalStress/CCVStressed/CVCStressed)")

L("ComplexTail <- ((CVVHiddenStress ((&(C1 Mono) CVVNoHyphen)/CCVNOY) !character)/(FinallyStressed ((&(C1 Mono) CVVNoHyphen)/CCVNOY))/MediallyStressed/FinalDjifoa)")

L("PreComplex <- ((!CVVHiddenStress !ComplexTail ((StressedBorrowingDjifoa &PhoneticComplex)/BorrowingDjifoa/CVCCY/CCVCY/CVV/CCV/CVC))* ComplexTail)")

L("Complex <- (&caprule &PreComplex PhoneticComplex !(sp? connective))")

L("LiQuote <- ((&caprule [Ll] [Ii] juncture? comma2? [\"] phoneticutterance [\"] comma2? &caprule [Ll] [Uu] juncture? !(sp? connective))/(&caprule [Kk] [Ii] juncture? [Ee] juncture? comma2? [(] phoneticutterance [)] comma2? &caprule [Kk] [Ii] juncture? [Uu] juncture? !(sp? connective)))")

L("Word <- (NameWord/Cmapua/Complex/CCVNOY)")

L("SingleWord <- (((Borrowing !.)/(Complex !.)/(Word !.)/(PreName !.)/CCVNOY) !.)")

L("phoneticutterance1 <- (NameWord/(sp? LiQuote)/(sp? NameWord)/(sp? AlienWord)/(sp? Cmapua)/(sp? '--')/(sp? '...')/(sp? Borrowing !why)/(sp? Complex)/(sp? CCVNOY))+")

L("phoneticutterance <- (phoneticutterance1/([,] sp)/terminal)+")

L("badstress <- (stress2 sp? &C1 predstart)")

L("B <- (!predstart [Bb])")

L("C <- (!predstart [Cc])")

L("D <- (!predstart [Dd])")

L("F <- (!predstart [Ff])")

L("G <- (!predstart [Gg])")

L("H <- (!predstart [Hh])")

L("J <- (!predstart [Jj])")

L("K <- (!predstart [Kk])")

L("L <- (!predstart [Ll])")

L("M <- (!predstart [Mm])")

L("N <- (!predstart [Nn])")

L("P <- (!predstart [Pp])")

L("R <- (!predstart [Rr])")

L("S <- (!predstart [Ss])")

L("T <- (!predstart [Tt])")

L("V <- (!predstart [Vv])")

L("Z <- (!predstart [Zz])")

L("V3 <- (juncture? V2 !badstress)")

L("AA <- ([Aa] juncture? [Aa] !badstress juncture? !V1)")

L("AE <- ([Aa] juncture? [Ee] !badstress juncture? !V1)")

L("AI <- ([Aa] [Ii] !badstress juncture? !V1)")

L("AO <- ([Aa] [Oo] !badstress juncture? !V1)")

L("AIb <- ([Aa] [Ii] !badstress juncture? &(V2 juncture? !V1))")

L("AOb <- ([Aa] [Oo] !badstress juncture? &(V2 juncture? !V1))")

L("AU <- ([Aa] juncture? [Uu] !badstress juncture? !V1)")

L("EA <- ([Ee] juncture? [Aa] !badstress juncture? !V1)")

L("EE <- ([Ee] juncture? [Ee] !badstress juncture? !V1)")

L("EI <- ([Ee] [Ii] !badstress juncture? !V1)")

L("EIb <- ([Ee] [Ii] !badstress juncture? &(V2 juncture? !V1))")

L("EO <- ([Ee] juncture? [Oo] !badstress juncture? !V1)")

L("EU <- ([Ee] juncture? [Uu] !badstress juncture? !V1)")

L("IA <- ([Ii] juncture? [Aa] !badstress juncture? !V1)")

L("IE <- ([Ii] juncture? [Ee] !badstress juncture? !V1)")

L("II <- ([Ii] juncture? [Ii] !badstress juncture? !V1)")

L("IO <- ([Ii] juncture? [Oo] !badstress juncture? !V1)")

L("IU <- ([Ii] juncture? [Uu] !badstress juncture? !V1)")

L("IAb <- ([Ii] juncture? [Aa] !badstress juncture? &(V2 juncture? !V1))")

L("IEb <- ([Ii] juncture? [Ee] !badstress juncture? &(V2 juncture? !V1))")

L("IIb <- ([Ii] juncture? [Ii] !badstress juncture? &(V2 juncture? !V1))")

L("IOb <- ([Ii] juncture? [Oo] !badstress juncture? &(V2 juncture? !V1))")

L("IUb <- ([Ii] juncture? [Uu] !badstress juncture? &(V2 juncture? !V1))")

L("OA <- ([Oo] juncture? [Aa] !badstress juncture? !V1)")

L("OE <- ([Oo] juncture? [Ee] !badstress juncture? !V1)")

L("OI <- ([Oo] [Ii] !badstress juncture? !V1)")

L("OIb <- ([Oo] [Ii] !badstress juncture? &(V2 juncture? !V1))")

L("OO <- ([Oo] juncture? [Oo] !badstress juncture? !V1)")

L("OU <- ([Oo] juncture? [Uu] !badstress juncture? !V1)")

L("UA <- ([Uu] juncture? [Aa] !badstress juncture? !V1)")

L("UE <- ([Uu] juncture? [Ee] !badstress juncture? !V1)")

L("UI <- ([Uu] juncture? [Ii] !badstress juncture? !V1)")

L("UO <- ([Uu] juncture? [Oo] !badstress juncture? !V1)")

L("UU <- ([Uu] juncture? [Uu] !badstress juncture? !V1)")

L("UAb <- ([Uu] juncture? [Aa] !badstress juncture? &(V2 juncture? !V1))")

L("UEb <- ([Uu] juncture? [Ee] !badstress juncture? &(V2 juncture? !V1))")

L("UIb <- ([Uu] juncture? [Ii] !badstress juncture? &(V2 juncture? !V1))")

L("UOb <- ([Uu] juncture? [Oo] !badstress juncture? &(V2 juncture? !V1))")

L("UUb <- ([Uu] juncture? [Uu] !badstress juncture? &(V2 juncture? !V1))")

L("IY <- ([Ii] [Yy] !badstress juncture? !V1)")

L("UY <- ([Uu] [Yy] !badstress juncture? !V1)")

L("PAUSE <- ([,] sp !(V1/connective) &caprule)")

L("comma <- ([,] sp &caprule)")

L("comma2 <- ([,]? sp &caprule)")

L("end <- ((sp? '#' sp utterance)/(sp !.)/!.)")

L("period <- (([!.:;?] (&end/(sp &caprule))) (invvoc period?)?)")

L("TAI0 <- ((V1 juncture? M a)/(V1 juncture? F i)/(V1 juncture? Z i)/(!predstart C1 AI)/(!predstart C1 EI)/(!predstart C1 AIb u)/(!predstart C1 EIb u)/(!predstart C1 EO)/(Z [Ii] V1 !badstress juncture? !V1 (M a)?))")

L("NOI <- (N OI)")

L("A0 <- (&Cmapua (a/e/o/u/(H a)/(N UU)))")

L("A <- (sp? !predstart !TAI0 (N [o])? A0 NOI? !(sp PANOPAUSES PAUSE) !(PANOPAUSES !PAUSE [ ,]) (PANOPAUSES ((F i)/&PAUSE))?)")

L("ANOFI <- (sp? (!predstart !TAI0 ((N [o])? A0 NOI? PANOPAUSES?)))")

L("A1 <- A")

L("ACI <- (ANOFI C i)")

L("AGE <- (ANOFI G e)")

L("CA0 <- (((N o)? ((C a)/(C e)/(C o)/(C u)/(Z e)/(C i H a)/(N u C u))) NOI?)")

L("CA1 <- (CA0 !(sp PANOPAUSES PAUSE) !(PANOPAUSES !PAUSE [ ,]) (PANOPAUSES ((F i)/&PAUSE))?)")

L("CA1NOFI <- (CA0 PANOPAUSES?)")

L("CA <- (sp? CA1)")

L("ZE2 <- (sp? (Z e))")

L("I <- (sp? !predstart !TAI0 i !(sp PANOPAUSES PAUSE) !(PANOPAUSES !PAUSE [ ,]) (PANOPAUSES ((F i)/&PAUSE))?)")

L("ICA <- (sp? i ((H a)/CA1))")

L("ICI <- (sp? i CA1NOFI? C i)")

L("IGE <- (sp? i CA1NOFI? G e)")

L("KA0 <- ((K a)/(K e)/(K o)/(K u)/(K i H a)/(N u K u))")

L("KOU <- ((K OU)/(M OI)/(R AU)/(S OA)/(M OU)/(C IU))")

L("KOU1 <- (((N u N o)/(N u)/(N o)) KOU)")

L("KA <- (sp? (KA0/((KOU1/KOU) K i)) NOI?)")

L("KI <- (sp? (K i) NOI?)")

L("KOU2 <- (KOU1 !KI)")

L("BadNIStress <- ((C1 V2 V2? stress (M a)? (M OA)? NI RA)/(C1 V2 stress V2 (M a)? (M OA)? NI RA))")

L("NI0 <- (!BadNIStress ((K UA)/(G IE)/(G IU)/(H IE)/(H IU)/(N EA)/(N IO)/(P EA)/(P IO)/(S UU)/(S UA)/(T IA)/(Z OA)/(Z OO)/(H o)/(N i)/(N e)/(T o)/(T e)/(F o)/(F e)/(V o)/(V e)/(P i)/(R e)/(R u)/(S e)/(S o)/(H i)))")

L("SA <- (!BadNIStress ((S a)/(S i)/(S u)/(IE (comma2? !IE SA)?)) NOI?)")

L("RA <- (!BadNIStress ((R a)/(R i)/(R o)/(R e)/(R u)/(B AO)))")

L("NI1 <- ((NI0 (!BadNIStress M a)? (!BadNIStress M OA NI0*)?) (comma2 !(NI RA) &NI)?)")

L("RA1 <- ((RA (!BadNIStress M a)? (!BadNIStress M OA NI0*)?) (comma2 !(NI RA) &NI)?)")

L("NI2 <- (((SA? (NI1+/RA1))/SA) NOI? (CA0 ((SA? (NI1+/RA1))/SA) NOI?)*)")

L("NI <- (sp? (P i)? NI2 ((&(M UE) Acronym (comma/&end/&period) !(C u))/(comma2? M UE comma2? PreName !(C u)))? (C u)?)")

L("mex <- (sp? NI)")

L("CI <- (sp? (C i))")

L("Acronym <- (sp? &caprule ((M UE)/TAI0/(Z V2 !V2)) ((comma &Acronym M UE)/NI1/TAI0/(Z V2 (!V2/(Z &V2))))+)")

L("TAI <- (sp? (TAI0/((G AO) !V2 sp? (PreName/Predicate/CmapuaUnit))))")

L("DA0 <- ((T AO)/(T IO)/(T UA)/(M IO)/(M IU)/(M UO)/(M UU)/(T OA)/(T OI)/(T OO)/(T OU)/(T UO)/(T UU)/(S UO)/(H u)/(B a)/(B e)/(B o)/(B u)/(D a)/(D e)/(D i)/(D o)/(D u)/(M i)/(T u)/(M u)/(T i)/(T a)/(M o)/(K OO)/(D AO))")

L("DA1 <- ((TAI0/DA0) (C i ![ ] NI0)?)")

L("DA <- (sp? DA1)")

L("PAX <- ((G IA)/(G UA)/(P AU)/(P IA)/(P UA)/(N IA)/(N UA)/(B IU)/(F EA)/(F IA)/(F UA)/(V IA)/(V II)/(V IU)/(C OI)/(D AU)/(D II)/(D UO)/(F OI)/(F UI)/(G AU)/(H EA)/(K AU)/(K II)/(K UI)/(L IA)/(L UI)/(M IA)/(N UI)/(P EU)/(R OI)/(R UI)/(S EA)/(S IO)/(T IE)/(V IE)/(V a)/(V i)/(V u)/(P a)/(N a)/(F a)/(V a)/(KOU !(N OI) !KI))")

L("PA0 <- (NI2? (N u !KOU)? PAX (N OI)? ZI?)")

L("PANOPAUSES <- ((KOU2/PA0)+ ((comma2? CA0 comma2?) (KOU2/PA0)+)*)")

L("PA3 <- (sp? PANOPAUSES)")

L("PA <- (((KOU2/PA0)+ (((comma2? CA0 comma2?)/(comma2 !mod1a)) (KOU2/PA0)+)*) !modifier)")

L("PA2 <- (sp? PA)")

L("GA <- (sp? (G a))")

L("PA1 <- (PA2/GA)")

L("ZI <- ((Z i)/(Z a)/(Z u))")

L("LE <- (sp? ((L EA)/(L EU)/(L OE)/(L EE)/(L AA)/(L e)/(L o)/(L a)))")

L("LEFORPO <- (sp? ((L e)/(L o)/NI2))")

L("LIO <- (sp? (L IO))")

L("LAU <- (sp? (L AU))")

L("LOU <- (sp? (L OU))")

L("LUA <- (sp? (L UA))")

L("LUO <- (sp? (L UO))")

L("ZEIA <- (sp? Z EIb a)")

L("ZEIO <- (sp? Z EIb o)")

L("LI1 <- (L i)")

L("LU1 <- (L u)")

L("LI <- ((sp? LI1 comma2? utterance0 comma2? LU1)/(sp? LI1 comma2? [\"] utterance0 [\"] comma2? LU1))")

L("LAO <- (sp? &(LAOalien juncture?) AlienWord)")

L("LIE <- (sp? &(LIEalien juncture?) AlienWord)")

L("LIO1 <- (sp? &(LIOalien juncture?) AlienWord)")

L("LW <- Cmapua")

L("LIU0 <- ((L IU)/(N IU))")

L("LNIU <- (([Ll]/[Nn]) [iI] juncture? [Uu])")

L("LIU1 <- ((sp? LNIU juncture? !V1 comma2? (PreName/Word) &(comma/terminal/end))/(sp? (L II TAI)))")

L("SUE <- (sp? &(([Ss] [Uu] juncture? [Ee] juncture?)/([Ss] [Aa] [Oo] juncture?)) AlienWord)")

L("CUI <- (sp? (C UI))")

L("GA2 <- (sp? (G a))")

L("GE <- (sp? (G e))")

L("GEU <- (sp? ((C UE)/(G EU)))")

L("GI <- (sp? ((G i)/(G OI)))")

L("GO <- (sp? (G o))")

L("GIO <- (sp? (G IO))")

L("GU <- (sp? (G u))")

L("GUIZA <- (sp? (G UI) (Z a))")

L("GUIZI <- (sp? (G UI) (Z i))")

L("GUIZU <- (sp? (G UI) (Z u))")

L("GUI <- (!GUIZA !GUIZI !GUIZU (sp? (G UI)))")

L("GUO <- (sp? (G UO))")

L("GUOA <- (sp? ((G UOb a)/(G UO Z a)))")

L("GUOE <- (sp? (G UOb e))")

L("GUOI <- (sp? ((G UOb i)/(G UO Z i)))")

L("GUOO <- (sp? (G UOb o))")

L("GUOU <- (sp? ((G UOb u)/(G UO Z u)))")

L("GUU <- (sp? (G UU))")

L("GUUA <- (sp? (G UUb a))")

L("GIUO <- (sp? (G IUb o))")

L("GUE <- (sp? (G UE))")

L("GUEA <- (sp? (G UEb a))")

L("JE <- (sp? (J e))")

L("JUE <- (sp? (J UE))")

L("JIZA <- (sp? ((J IE)/(J AE)/(P e)/(J i)/(J a)) (Z a))")

L("JIOZA <- (sp? ((J IO)/(J AO)) (Z a))")

L("JIZI <- (sp? ((J IE)/(J AE)/(P e)/(J i)/(J a)) (Z i))")

L("JIOZI <- (sp? ((J IO)/(J AO)) (Z i))")

L("JIZU <- (sp? ((J IE)/(J AE)/(P e)/(J i)/(J a)) (Z u))")

L("JIOZU <- (sp? ((J IO)/(J AO)) (Z u))")

L("JI <- (!JIZA !JIZI !JIZU (sp? ((J IE)/(J AE)/(P e)/(J i)/(J a))))")

L("NUJI <- (sp? N u !sp JI)")

L("JIO <- (!JIOZA !JIOZI !JIOZU (sp? ((J IO)/(J AO))))")

L("DIO <- ((sp? ((B EU)/(C AU)/(D IO)/(F OA)/(K AO)/(J UI)/(N EU)/(P OU)/(G OA)/(S AU)/(V EU)/(Z UA)/(Z UE)/(Z UI)/(Z UO)/(Z UU))) ((C i ![ ] NI0)/ZI)?)")

L("LAE <- (sp? ((L AE)/(L UE)))")

L("ME <- (sp? ((M EA)/(M e)))")

L("MEU <- (sp? M EU)")

L("NU0 <- ((N UO)/(F UO)/(J UO)/(N u)/(F u)/(J u)/(K UE))")

L("NU <- (sp? ((((N u)/(N UO)/(K UE)) !(sp (NI0/RA)) (NI0/RA)?)/NU0)+ freemod?)")

L("PO1 <- (sp? ((P o)/(P u)/(Z o)))")

L("PO1A <- (sp? ((P OIb a)/(P UIb a)/(Z OIb a)/(P o Z a)/(P u Z a)/(Z o Z a)))")

L("PO1E <- (sp? ((P OIb e)/(P UIb e)/(Z OIb e)))")

L("PO1I <- (sp? ((P OIb i)/(P UIb i)/(Z OIb i)/(P o Z i)/(P u Z i)/(Z o Z i)))")

L("PO1O <- (sp? ((P OIb o)/(P UIb o)/(Z OIb o)))")

L("PO1U <- (sp? ((P OIb u)/(P UIb u)/(Z OIb u)/(P o Z u)/(P u Z u)/(Z o Z u)))")

L("POSHORT1 <- (sp? ((P OI)/(P UI)/(Z OI)))")

L("PO <- (sp? PO1)")

L("POA <- (sp? PO1A)")

L("POE <- (sp? PO1E)")

L("POI <- (sp? PO1E)")

L("POO <- (sp? PO1O)")

L("POU <- (sp? PO1U)")

L("POSHORT <- (sp? POSHORT1)")

L("DIE <- (sp? ((D IE)/(F IE)/(K AE)/(N UE)/(R IE)))")

L("HOI <- (sp? ((H OI)/(L OI)/(L OA)/(S IA)/(S IE)/(S IU)))")

L("JO <- (sp? (NI0/RA/SA)? (J o))")

L("KIE <- (sp? (K IE))")

L("KIU <- (sp? (K IU))")

L("KIE2 <- (sp? K IE comma2? [(])")

L("KIU2 <- (sp? [)] comma2? K IU)")

L("SOI <- (sp? (S OI))")

L("UI0 <- (!predstart ((!([Ii] juncture? [Ee]) VV juncture?)/(B EA)/(B UO)/(C EA)/(C IA)/(C OA)/(D OU)/(F AE)/(F AO)/(F EU)/(G EA)/(K UO)/(K UU)/(R EA)/(N AO)/(N IE)/(P AE)/(P IU)/(S AA)/(S UI)/(T AA)/(T OE)/(V OI)/(Z OU)/(L OI)/(L OA)/(S IA)/(S II)/(T OE)/(S IU)/(C AO)/(C EU)/(S IE)/(S EU)/(S IEb i)))")

L("NOUI <- ((sp? UI0 NOI)/(sp? N [o] juncture? comma? sp? UI0))")

L("UI1 <- (sp? (UI0+/(NI F i)))")

L("HUE <- (sp? (H UE))")

L("NO1 <- (sp? !KOU1 !NOUI (N o) !(comma2? Z AO comma2? Predicate) !(sp? KOU) !(sp? (JIO/JI/JIZA/JIOZA/JIZI/JIOZI/JIZU/JIOZU)))")

L("AcronymicName <- (Acronym &(comma/period/end))")

L("DJAN <- (PreName/AcronymicName)")

L("BI <- (sp? (N u)? ((B IA)/(B IE)/(C IE)/(C IO)/(B IA)/(B i)/(B II)))")

L("LWPREDA <- ((H e)/(D UA)/(D UI)/(B UA)/(B UI))")

L("Predicate <- ((CmapuaUnit comma2? Z AO comma2?)* Complex (comma2? Z AO comma2? Predicate)?)")

L("PREDA <- (sp? &caprule (Predicate/LWPREDA/(![ ] NI RA)))")

L("guoa <- (PAUSE? (GUOA/GU) freemod?)")

L("guoe <- (PAUSE? (GUOE/GU) freemod?)")

L("guoi <- (PAUSE? (GUOI/GU) freemod?)")

L("guoo <- (PAUSE? (GUOO/GU) freemod?)")

L("guou <- (PAUSE? (GUOU/GU) freemod?)")

L("guo <- (!guoa !guoe !guoi !guoo !guou (PAUSE? (GUO/GU) freemod?))")

L("guiza <- (PAUSE? (GUIZA/GU) freemod?)")

L("guizi <- (PAUSE? (GUIZI/GU) freemod?)")

L("guizu <- (PAUSE? (GUIZU/GU) freemod?)")

L("gui <- (PAUSE? (GUI/GU) freemod?)")

L("gue <- (PAUSE? (GUE/GU) freemod?)")

L("guea <- (PAUSE? (GUEA/GU) freemod?)")

L("guu <- (PAUSE? (GUU/GU) freemod?)")

L("guua <- (PAUSE? (GUUA/GU) freemod?)")

L("giuo <- (PAUSE? (GIUO/GU) freemod?)")

L("meu <- (PAUSE? (MEU/GU) freemod?)")

L("geu <- GEU")

L("gap <- (PAUSE? GU freemod?)")

L("HOI0 <- ((sp? (([Hh] OI)/([Ll] OI)/([Ll] OA)/([Ss] IA)/([Ss] IE)/([Ss] IU))) juncture? !V1)")

L("voc <- ((HOI0 comma2? name)/(HOI comma2? descpred guea? namesuffix?)/(HOI comma2? argument1 guua?)/(sp? &([Hh] [Oo] [Ii] juncture?) AlienWord))")

L("HUE0 <- (sp? &caprule [Hh] [Uu] juncture? [Ee] juncture? !V1)")

L("invvoc <- ((HUE0 comma2? name)/(HUE freemod? descpred guea? namesuffix?)/(HUE freemod? statement giuo?)/(HUE freemod? argument1 guu?)/(sp? &([Hh] [Uu] juncture? [Ee] juncture?) AlienWord))")

L("kiamod <- (comma2? !(!PreName !predstart K IA) ((PreName/LIU1/AlienWord/(Cmapua (sp? !(K IA) !PreName !predstart Cmapua)*)/Word) kiamod* comma2? !PreName !predstart K IA) comma2?)")

L("freemod <- ((kiamod/NOUI/(SOI freemod? descpred guea?)/DIE/(NO1 DIE)/(KIE comma? utterance0 comma? KIU)/(KIE2 comma? utterance0 comma? KIU2)/invvoc/voc/(comma !(!FalseMarked PreName))/JO/UI1/(sp? '...' (sp? &letter)?)/(sp? '--' (sp? &letter)?)) freemod?)")

L("juelink <- (JUE freemod? (term/(PA2 freemod? gap?)))")

L("links1 <- (juelink (freemod? juelink)* gue?)")

L("links <- ((links1/(KA freemod? links freemod? KI freemod? links1)) (freemod? A1 freemod? links1)*)")

L("jelink <- (JE freemod? (term/(PA2 freemod? gap?)))")

L("linkargs1 <- (jelink freemod? (links/gue)?)")

L("linkargs <- ((linkargs1/(KA freemod? linkargs freemod? KI freemod? linkargs1)) (freemod? A1 freemod? linkargs1)*)")

L("abstractpred <- ((POA freemod? uttAxclone guoa?)/(POA freemod? sentenceclone guoa?)/(POE freemod? uttAxclone guoe?)/(POE freemod? sentenceclone guoe?)/(POI freemod? uttAxclone guoi?)/(POI freemod? sentenceclone guoi?)/(POO freemod? uttAxclone guoo?)/(POO freemod? sentenceclone guoo?)/(POU freemod? uttAxclone guou?)/(POU freemod? sentenceclone guou?)/(PO freemod? uttAxclone guo?)/(PO freemod? sentenceclone guo?))")

L("predunit1 <- ((SUE/(NU freemod? GE freemod? despredE (freemod? geu comma?)?)/(NU freemod? PREDA)/(comma? GE freemod? descpred (freemod? geu comma?)?)/abstractpred/(ME freemod? argument1 meu?)/PREDA) freemod?)")

L("predunit2 <- ((NO1 freemod?)* predunit1)")

L("NO2 <- (!predunit2 NO1)")

L("predunit3 <- ((predunit2 freemod? linkargs)/predunit2)")

L("predunit <- ((POSHORT freemod?)? predunit3)")

L("kekpredunit <- ((NO1 freemod?)* KA freemod? predicate freemod? KI freemod? predicate guu?)")

L("despredA <- ((predunit/kekpredunit) (freemod? CI freemod? (predunit/kekpredunit))*)")

L("despredB <- ((!PREDA CUI freemod? despredC freemod? CA freemod? despredB)/despredA)")

L("despredC <- (despredB (freemod? despredB)*)")

L("despredD <- (despredB (freemod? CA freemod? despredB)*)")

L("despredE <- (despredD (freemod? despredD)*)")

L("descpred <- ((despredE freemod? GO freemod? descpred)/despredE)")

L("sentpred <- ((despredE freemod? GO freemod? barepred)/despredE)")

L("mod1a <- (PA3 freemod? argument1 guua?)")

L("mod1 <- ((PA3 freemod? argument1 guua?)/(PA2 freemod? !barepred gap?))")

L("kekmod <- ((NO1 freemod?)* (KA freemod? modifier freemod? KI freemod? mod))")

L("mod <- (mod1/((NO1 freemod?)* mod1)/kekmod)")

L("modifier <- (mod (A1 freemod? mod)*)")

L("name <- ((PreName/AcronymicName) ((comma2? !FalseMarked PreName)/(comma2? &([Cc] [Ii]) NameWord)/(comma2? CI predunit !(comma2? (!FalseMarked PreName)))/(comma2? CI AcronymicName))* freemod?)")

L("LA0 <- (sp? [Ll] [Aa] juncture?)")

L("LANAME <- (LA0 comma2? name)")

L("descriptn <- (!LANAME ((LAU wordset1)/(LOU wordset2)/(LE freemod? ((!mex arg1a freemod?)? (PA2 freemod?)?)? ((mex freemod? arg1a)/(mex freemod? descpred)/descpred))/(GE freemod? mex freemod? descpred)))")

L("abstractn <- ((LEFORPO freemod? POA freemod? uttAxclone guoa?)/(LEFORPO freemod? POA freemod? sentenceclone guoa?)/(LEFORPO freemod? POE freemod? uttAxclone guoe?)/(LEFORPO freemod? POE freemod? sentenceclone guoe?)/(LEFORPO freemod? POI freemod? uttAxclone guoi?)/(LEFORPO freemod? POI freemod? sentenceclone guoi?)/(LEFORPO freemod? POO freemod? uttAxclone guoo?)/(LEFORPO freemod? POO freemod? sentenceclone guoo?)/(LEFORPO freemod? POU freemod? uttAxclone guou?)/(LEFORPO freemod? POU freemod? sentenceclone guou?)/(LEFORPO freemod? PO freemod? uttAxclone guo?)/(LEFORPO freemod? PO freemod? sentenceclone guo?))")

L("CIforsuffix <- ([Cc] [Ii])")

L("namesuffix <- (&((comma2 !FalseMarked PreName)/(sp? CIforsuffix juncture? comma2? (PreName/AcronymicName))) ((sp? CIforsuffix juncture? comma2?)/comma2)? name)")

L("arg1 <- (abstractn/(LIO freemod? descpred guea?)/(LIO freemod? argument1 guua?)/(LIO freemod? mex gap?)/LIO1/LAO/LANAME/(descriptn guua? namesuffix?)/LIU1/LIE/LI)")

L("arg1a <- ((DA/TAI/arg1/(GE freemod? arg1a)) freemod?)")

L("argmod1 <- (((sp? (N o) sp?)? ((JI freemod? predicate)/(JIO freemod? sentence)/(JIO freemod? uttAx)/(JI freemod? modifier)/((JI/NUJI) freemod? argument1)))/((sp? (N o) sp?)? (((JIZA freemod? predicate) guiza?)/((JIOZA freemod? sentence) guiza?)/((JIOZA freemod? uttAx) guiza?)/((JIZA freemod? modifier) guiza?)/(JIZA freemod? argument1 guiza?)))/((sp? (N o) sp?)? ((JIZI freemod? predicate guizi?)/(JIOZI freemod? sentence guizi?)/(JIOZI freemod? uttAx guizi?)/(JIZI freemod? modifier guizi?)/(JIZI freemod? argument1 guizi?)))/((sp? (N o) sp?)? ((JIZU freemod? predicate guizu?)/(JIOZU freemod? sentence guizu?)/(JIOZU freemod? uttAx guizu?)/(JIZU freemod? modifier guizu?)/(JIZU freemod? argument1 guizu?))))")

L("argmod <- (argmod1 (A1 freemod? argmod1)* gui?)")

L("arg2 <- (arg1a freemod? argmod*)")

L("arg3 <- (arg2/(mex freemod? arg2))")

L("indef1 <- (mex freemod? descpred)")

L("indef2 <- (indef1 guua? argmod*)")

L("indefinite <- indef2")

L("arg4 <- ((arg3/indefinite) (ZE2 freemod? (arg3/indefinite))*)")

L("arg5 <- (arg4/(KA freemod? argument1 freemod? KI freemod? argx))")

L("argx <- ((NO1 freemod?)* (LAE freemod?)* arg5)")

L("arg7 <- (argx freemod? (ACI freemod? argx)?)")

L("arg8 <- (!GE (arg7 freemod? (A1 freemod? arg7)*))")

L("argument1 <- (((arg8 freemod? AGE freemod? argument1)/arg8) (GUU freemod? argmod)*)")

L("argument <- ((NO1 freemod?)* (DIO freemod?)* argument1)")

L("argxx <- (&((NO1 freemod?)* DIO) argument)")

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

L("termset2 <- (termset1 (guu &A1)? (A1 freemod? termset1 (guu &A1)?)*)")

L("termset <- ((terms freemod? GO freemod? barepred)/termset2)")

L("barepred <- (sentpred freemod? ((termset guu?)/(guu &termset))?)")

L("markpred <- (PA1 freemod? barepred)")

L("backpred1 <- ((NO2 freemod?)* (barepred/markpred))")

L("backpred <- (((backpred1 (ACI freemod? backpred1)+ freemod? ((termset guu?)/(guu &termset))?) ((ACI freemod? backpred)+ freemod? ((termset guu?)/(guu &termset))?)?)/backpred1)")

L("predicate2 <- (!GE (((backpred (A1 !GE freemod? backpred)+ freemod? ((termset guu?)/(guu &termset))?) ((A1 freemod? predicate2)+ freemod? ((termset guu?)/(guu &termset))?)?)/backpred))")

L("predicate1 <- ((predicate2 AGE freemod? predicate1)/predicate2)")

L("identpred <- ((NO1 freemod?)* (BI freemod? argument1 guu?))")

L("predicate <- (predicate1/identpred)")

L("gasent1 <- ((NO1 freemod?)* (freemod? &markpred predicate (GA2 freemod? subject)?))")

L("gasent2 <- ((NO1 freemod?)* (PA1 freemod? sentpred modifiers? (GA2 freemod? subject freemod? GIO? freemod? terms?)))")

L("gasent <- (gasent2/gasent1)")

L("statement <- (gasent/(modifiers freemod? gasent)/(subject freemod? freemod? (GIO? freemod? terms1)? predicate))")

L("keksent <- (modifiers? freemod? (NO1 freemod?)* (KA freemod? headterms? freemod? sentence freemod? KI freemod? uttA0))")

L("keksentclone <- (modifiers? freemod? (NO1 freemod?)* (KA freemod? headterms? freemod? sentenceclone freemod? KI freemod? uttA0clone))")

L("neghead <- ((NO1 freemod? gap)/(NO2 PAUSE))")

L("imperative <- ((modifiers freemod?)? !gasent predicate)")

L("nosubject <- ((modifiers freemod?)? !gasent predicate)")

L("sen1 <- ((neghead freemod?)* (imperative/statement/keksent))")

L("sen1clone <- ((neghead freemod?)* (nosubject/statement/keksent))")

L("sentence <- (sen1 ([!.:;?]? ICA freemod? sen1)*)")

L("sentenceclone <- (sen1clone ([!.:;?]? ICA freemod? sen1clone)*)")

L("headterms <- (terms GI freemod?)+")

L("uttAx <- (headterms freemod? sentence giuo?)")

L("uttAxclone <- (headterms freemod? sentenceclone giuo?)")

L("uttA <- ((A1/mex) freemod?)")

L("uttA0 <- (sen1/uttAx)")

L("uttA0clone <- (sen1clone/uttAxclone)")

L("uttA1 <- ((sen1/uttAx/links/linkargs/argmod/(modifiers freemod? keksent)/terms/uttA/NO1) freemod? period?)")

L("uttC <- ((neghead freemod? uttC)/uttA1)")

L("uttD <- ((sentence period? !ICI !ICA)/(uttC (ICI freemod? uttD)*))")

L("uttE <- (uttD (ICA freemod? uttD)*)")

L("uttF <- (uttE (I freemod? uttE)*)")

L("utterance0 <- (!GE ((ICA freemod? uttF)/(!PAUSE freemod period? utterance0)/(!PAUSE freemod period?)/(uttF IGE utterance0)/uttF/(I freemod? uttF?)/(I freemod? period?)) (&I utterance0)?)")

L("utterance <- (&(phoneticutterance end) (!GE ((ICA freemod? uttF (&I utterance)? end)/(!PAUSE freemod period? utterance)/(!PAUSE freemod period? (&I utterance)? end)/(uttF IGE utterance)/(I freemod? period? (&I utterance)? end)/(uttF (&I utterance)? end)/(I freemod? uttF (&I utterance)? end))))")

if __name__ == '__main__':interface();
