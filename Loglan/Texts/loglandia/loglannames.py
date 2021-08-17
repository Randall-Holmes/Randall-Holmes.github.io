from loglanpreamble import *


L("_Grammar <- (_Spacing (_Definition)+ _EndOfFile)")

L("_Definition <- (_Identifier _LEFTARROW _Expression)")

L("_Expression <- (_Sequence ((_SLASH _Sequence))*)")

L("_Sequence <- (_Prefix)*")

L("_Prefix <- (((_AND / _NOT))? _Suffix)")

L("_Suffix <- (_Primary ((_QUESTION / _STAR / _PLUS))?)")

L("_Primary <- ((_Identifier !(_LEFTARROW)) / (_OPEN _Expression _CLOSE) / _Literal / _Class / _DOT)")

L("_Identifier <- (_IdentStart (_IdentCont)* _Spacing)")

L("_IdentStart <- [a-zA-Z_]")

L("_IdentCont <- (_IdentStart / [0-9])")

L("_Literal <- (([\'] ((!([\']) _Char))* [\'] _Spacing) / ([\"] ((!([\"]) _Char))* [\"] _Spacing))")

L("_Class <- ([\[] ((!([\]]) _Range))* [\]] _Spacing)")

L("_Range <- ((_Char [-] _Char) / _Char)")

L("_Char <- (([\\] [nrt\'\"\[\]\\]) / ([\\] [0-2] [0-7] [0-7]) / ([\\] [0-7] ([0-7])?) / (!([\\]) .))")

L("_LEFTARROW <- ('<-' _Spacing)")

L("_SLASH <- ('/' _Spacing)")

L("_AND <- ('&' _Spacing)")

L("_NOT <- ('!' _Spacing)")

L("_QUESTION <- ('?' _Spacing)")

L("_STAR <- ('*' _Spacing)")

L("_PLUS <- ('+' _Spacing)")

L("_OPEN <- ('(' _Spacing)")

L("_CLOSE <- (')' _Spacing)")

L("_DOT <- ('.' _Spacing)")

L("_Spacing <- ((_Space / _Comment))*")

L("_Comment <- ([#] ((!(_EndOfLine) .))* _EndOfLine)")

L("_Space <- ([ ] / [\t] / _EndOfLine)")

L("_EndOfLine <- (([\r] [\n]) / [\r] / [\n])")

L("_EndOfFile <- !(.)")

L("lowercase <- (!([qwx]) [a-z])")

L("uppercase <- (!([QWX]) [A-Z])")

L("letter <- (!([QWXqwx]) [A-Za-z])")

L("juncture <- (([-] &(letter)) / ([\'*] !(juncture)))")

L("stress <- ([\'*] !(juncture))")

L("juncture2 <- ((([-] &(letter)) / ([\'*] !((([ ])* &(C1) Predicate)) ((', ' ([ ])* &(C1) &(Predicate)))?)) !(juncture))")

L("Lowercase <- (lowercase / (juncture (letter)?))")

L("Letter <- (letter / juncture)")

L("comma <- ([,] ([ ])+ &(letter))")

L("comma2 <- (([,])? ([ ])+ &(letter) &(caprule))")

L("end <- ((([ ])* '#' ([ ])+ utterance) / (([ ])+ !(.)) / !(.))")

L("period <- (([!.:;?] (&(end) / (([ ])+ &(letter)))) ((invvoc (period)?))?)")

L("V1 <- [AEIOUYaeiouy]")

L("V2 <- [AEIOUaeiou]")

L("C1 <- (!(V1) letter)")

L("Mono <- (([Aa] [o]) / ((V2 [i]) !([i])) / ([Ii] !([i]) V2) / ([Uu] V2))")

L("EMono <- (([Aa] [o]) / (([AEOaeo] [i]) !([i])))")

L("NextVowels <- (EMono / (V2 &(EMono)) / Mono / V2)")

L("BrokenMono <- (([a] juncture [o]) / ([aeo] juncture [i]))")

L("CVVSyll <- (C1 Mono)")

L("LWunit <- (((CVVSyll (juncture)? V2) / (C1 !(BrokenMono) V2 (juncture)? V2) / (C1 V2)) (juncture2)?)")

L("caprule <- (([\"()])? ((uppercase / lowercase) ((('z' V1) / lowercase / (juncture (caprule)?) / TAI0))* !(letter)))")

L("InitialCC <- ('bl' / 'br' / 'ck' / 'cl' / 'cm' / 'cn' / 'cp' / 'cr' / 'ct' / 'dj' / 'dr' / 'dz' / 'fl' / 'fr' / 'gl' / 'gr' / 'jm' / 'kl' / 'kr' / 'mr' / 'pl' / 'pr' / 'sk' / 'sl' / 'sm' / 'sn' / 'sp' / 'sr' / 'st' / 'tc' / 'tr' / 'ts' / 'vl' / 'vr' / 'zb' / 'zv' / 'zl' / 'sv' / 'Bl' / 'Br' / 'Ck' / 'Cl' / 'Cm' / 'Cn' / 'Cp' / 'Cr' / 'Ct' / 'Dj' / 'Dr' / 'Dz' / 'Fl' / 'Fr' / 'Gl' / 'Gr' / 'Jm' / 'Kl' / 'Kr' / 'Mr' / 'Pl' / 'Pr' / 'Sk' / 'Sl' / 'Sm' / 'Sn' / 'Sp' / 'Sr' / 'St' / 'Tc' / 'Tr' / 'Ts' / 'Vl' / 'Vr' / 'Zb' / 'Zv' / 'Zl' / 'Sv')")

L("MaybeInitialCC <- (([Bb] (juncture)? [l]) / ([Bb] (juncture)? [r]) / ([Cc] (juncture)? [k]) / ([Cc] (juncture)? [l]) / ([Cc] (juncture)? [m]) / ([Cc] (juncture)? [n]) / ([Cc] (juncture)? [p]) / ([Cc] (juncture)? [r]) / ([Cc] (juncture)? [t]) / ([Dd] (juncture)? [j]) / ([Dd] (juncture)? [r]) / ([Dd] (juncture)? [z]) / ([Ff] (juncture)? [l]) / ([Ff] (juncture)? [r]) / ([Gg] (juncture)? [l]) / ([Gg] (juncture)? [r]) / ([Jj] (juncture)? [m]) / ([Kk] (juncture)? [l]) / ([Kk] (juncture)? [r]) / ([Mm] (juncture)? [r]) / ([Pp] (juncture)? [l]) / ([Pp] (juncture)? [r]) / ([Ss] (juncture)? [k]) / ([Ss] (juncture)? [l]) / ([Ss] (juncture)? [m]) / ([Ss] (juncture)? [n]) / ([Ss] (juncture)? [p]) / ([Ss] (juncture)? [r]) / ([Ss] (juncture)? [t]) / ([Tt] (juncture)? [c]) / ([Tt] (juncture)? [r]) / ([Tt] (juncture)? [s]) / ([Vv] (juncture)? [l]) / ([Vv] (juncture)? [r]) / ([Zz] (juncture)? [b]) / ([Zz] (juncture)? [v]) / ([Zz] (juncture)? [l]) / ([Ss] (juncture)? [v]))")

L("NonmedialCC <- (([b] (juncture)? [b]) / ([c] (juncture)? [c]) / ([d] (juncture)? [d]) / ([f] (juncture)? [f]) / ([g] (juncture)? [g]) / ([h] (juncture)? [h]) / ([j] (juncture)? [j]) / ([k] (juncture)? [k]) / ([l] (juncture)? [l]) / ([m] (juncture)? [m]) / ([n] (juncture)? [n]) / ([p] (juncture)? [p]) / ([q] (juncture)? [q]) / ([r] (juncture)? [r]) / ([s] (juncture)? [s]) / ([t] (juncture)? [t]) / ([v] (juncture)? [v]) / ([z] (juncture)? [z]) / ([h] (juncture)? C1) / ([cjsz] (juncture)? [cjsz]) / ([f] (juncture)? [v]) / ([k] (juncture)? [g]) / ([p] (juncture)? [b]) / ([t] (juncture)? [d]) / ([fkpt] (juncture)? [jz]) / ([b] (juncture)? [j]) / ([s] (juncture)? [b]))")

L("NonjointCCC <- (([c] (juncture)? [d] (juncture)? [z]) / ([c] (juncture)? [v] (juncture)? [l]) / ([n] (juncture)? [d] (juncture)? [j]) / ([n] (juncture)? [d] (juncture)? [z]) / ([d] (juncture)? [c] (juncture)? [m]) / ([d] (juncture)? [c] (juncture)? [t]) / ([d] (juncture)? [t] (juncture)? [s]) / ([p] (juncture)? [d] (juncture)? [z]) / ([g] (juncture)? [t] (juncture)? [s]) / ([g] (juncture)? [z] (juncture)? [b]) / ([s] (juncture)? [v] (juncture)? [l]) / ([j] (juncture)? [d] (juncture)? [j]) / ([j] (juncture)? [t] (juncture)? [c]) / ([j] (juncture)? [t] (juncture)? [s]) / ([j] (juncture)? [v] (juncture)? [r]) / ([t] (juncture)? [v] (juncture)? [l]) / ([k] (juncture)? [d] (juncture)? [z]) / ([v] (juncture)? [t] (juncture)? [s]) / ([m] (juncture)? [z] (juncture)? [b]))")

L("Oddvowel <- ((juncture)? (((V2 (juncture)? V2 (juncture)?))* V2) (juncture)?)")

L("RepeatedVowel <- (([Aa] (juncture)? [a]) / ([Ee] (juncture)? [e]) / ([Oo] (juncture)? [o]) / ([Ii] juncture [i]) / ([Uu] juncture [u]))")

L("RepeatedVocalic <- (([Mm] [m]) / ([Nn] [n]) / ([Ll] [l]) / ([Rr] [r]))")

L("Syllabic <- [lmnr]")

L("Nonsyllabic <- (!(Syllabic) C1)")

L("Badfinalpair <- (Nonsyllabic !('mr') !(RepeatedVocalic) Syllabic !((V2 / [y] / RepeatedVocalic)))")

L("FirstConsonants <- (((!((C1 C1 RepeatedVocalic)) &(InitialCC) (C1 InitialCC)) / (!((C1 RepeatedVocalic)) InitialCC) / ((!(RepeatedVocalic) C1) !([y]))) !(juncture))")

L("FirstConsonants2 <- (((!((C1 C1 RepeatedVocalic)) &(InitialCC) (C1 InitialCC)) / (!((C1 RepeatedVocalic)) InitialCC) / (!(RepeatedVocalic) C1)) !(juncture))")

L("VowelSegment <- ((!(BrokenMono) (NextVowels !(RepeatedVocalic))) / (!((C1 RepeatedVocalic)) RepeatedVocalic))")

L("VowelSegment2 <- (NextVowels / (!((C1 RepeatedVocalic)) RepeatedVocalic))")

L("SyllableA <- ((C1 V2 &(C1) !(Badfinalpair) (FinalConsonant)? ((!(Syllable) FinalConsonant))?) (juncture)?)")

L("SyllableB <- ((FirstConsonants)? !(RepeatedVowel) !((&(Mono) V2 RepeatedVowel)) VowelSegment !(Badfinalpair) ((!(Syllable) FinalConsonant))? ((!(Syllable) FinalConsonant))? (juncture)?)")

L("Syllable <- (SyllableA / SyllableB)")

L("BrokenInitialCC <- (&(MaybeInitialCC) C1 juncture C1 &(V2))")

L("JunctureFix <- ((InitialCC V2 BrokenInitialCC) / (((C1 V2))? V2 BrokenInitialCC) / (C1 V2 !(stress) juncture InitialCC V2 Letter) / (C1 BrokenInitialCC V2))")

L("SyllableFinal1 <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment !(stress) (juncture)? !(V2) (&(Syllable) / &([y]) / !(Letter)))")

L("SyllableFinal2 <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment !(stress) (juncture)? (&([y]) / !(Letter)))")

L("SyllableFinal2a <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment (juncture)? &([y]))")

L("SyllableFinal2b <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment stress &([y]))")

L("StressedSyllable <- (((FirstConsonants)? !(RepeatedVowel) !((&(Mono) V2 RepeatedVowel)) VowelSegment !(Badfinalpair) (FinalConsonant)? (FinalConsonant)?) stress)")

L("FinalConsonant <- (!(RepeatedVocalic) !(NonmedialCC) !(NonjointCCC) C1 !(((juncture)? V2)))")

L("Syllable2 <- (((FirstConsonants2)? (VowelSegment2 / [y]) !(Badfinalpair) ((!(Syllable2) FinalConsonant))? ((!(Syllable2) FinalConsonant))?) (juncture)?)")

L("Name <- (([ ])* &(((uppercase / lowercase) ((!((C1 (stress)? !(Letter))) Lowercase))* C1 (stress)? !(Letter) (&(end) / comma / &(period) / &(Name) / &(CI)))) ((Syllable2)+ (&(end) / comma / &(period) / &(Name) / &(CI))))")

L("CCSyllableB <- (((FirstConsonants)? RepeatedVocalic !(Badfinalpair) ((!(Syllable) FinalConsonant))? ((!(Syllable) FinalConsonant))?) (juncture)?)")

L("BorrowingTail <- ((!(JunctureFix) !(CCSyllableB) StressedSyllable ((!(StressedSyllable) CCSyllableB))? !(StressedSyllable) SyllableFinal1) / (!(CCSyllableB) !(JunctureFix) Syllable ((!(StressedSyllable) CCSyllableB))? !(StressedSyllable) SyllableFinal2))")

L("PreBorrowing <- (((!(BorrowingTail) !(StressedSyllable) !(JunctureFix) !((CCSyllableB CCSyllableB)) Syllable))* !(CCSyllableB) BorrowingTail)")

L("HasCCPair <- ((((C1)? ((V2 ((!(stress) juncture))?))+ !(Borrowing) !((&(MaybeInitialCC) C1 (!(stress) juncture) !(CCVV) PreBorrowing)) (stress)?))? C1 (juncture)? C1)")

L("CVCBreak <- (C1 V2 (juncture)? &(MaybeInitialCC) C1 (juncture)? &((PreComplex / ComplexTail)))")

L("CCVV <- ((&(BorrowingTail) C1 C1 (C1)? V2 stress !(Mono) V2) / (&(BorrowingTail) C1 C1 (C1)? V2 (juncture)? V2 (!(Letter) / ((juncture)? [y]))))")

L("Borrowing <- (&(HasCCPair) !(CVCBreak) !(CCVV) !(((((C1)? (V2 (juncture)?) ((V2 (juncture)? &(V2)))+))? V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(BorrowingTail) !(StressedSyllable) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))* !(CCSyllableB) BorrowingTail))")

L("PreBorrowingAffix <- ((((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))+ SyllableFinal2a) (juncture)? [y] !(stress) (juncture)? (([ ,] ([ ])*))?)")

L("BorrowingAffix <- (&(HasCCPair) !(CVCBreak) !(CCVV) !(((((C1)? (V2 (juncture)?) ((V2 (juncture)? &(V2)))+))? V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))+ SyllableFinal2a) (juncture)? [y] !(stress) (juncture)? (comma)?)")

L("StressedBorrowingAffix <- (&(HasCCPair) !(CVCBreak) !(CCVV) !(((((C1)? (V2 (juncture)?) ((V2 (juncture)? &(V2)))+))? V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))* SyllableFinal2b) (juncture)? [y] !(stress) (juncture)? !([,]))")

L("yhyphen <- ((juncture)? [y] !(stress) (juncture)? !([y]) &(letter))")

L("CV <- (C1 V2 !(stress) (juncture)? !(V2))")

L("Cfinal <- ((((juncture &((C1 !(juncture)))))? C1 yhyphen) / (!(NonmedialCC) !(NonjointCCC) C1 !(((juncture)? V2))))")

L("hyphen <- (!(NonmedialCC) !(NonjointCCC) (([r] !(((juncture)? [r])) !(((juncture)? V2))) / ([n] (juncture)? &([r])) / ((juncture)? [y] !(stress))) ((juncture)? &(letter)) !(((juncture)? [y])))")

L("noyhyphen <- (!(NonmedialCC) !(NonjointCCC) (([r] !(((juncture)? [r])) !(((juncture)? V2))) / ([n] (juncture)? &([r]))) &(((juncture)? &(letter))) !(((juncture)? [y])))")

L("StressedSyllable2 <- (((FirstConsonants)? VowelSegment !(Badfinalpair) (FinalConsonant)? (FinalConsonant)?) stress (yhyphen)?)")

L("CVVStressed <- (((C1 &(RepeatedVowel) V2 !(stress) (juncture)? !(RepeatedVowel) V2 (noyhyphen)?) (juncture)? (yhyphen)?) / (C1 !(BrokenMono) V2 !(stress) juncture V2 (noyhyphen)? stress (yhyphen)?) / (C1 !(Mono) V2 V2 (noyhyphen)? stress (yhyphen)?))")

L("CVVStressed2 <- (C1 Mono (noyhyphen)? stress (yhyphen)?)")

L("CVV <- (!((C1 V2 stress V2 (hyphen)? stress)) ((C1 !(BrokenMono) V2 (juncture)? !(RepeatedVowel) V2 (noyhyphen)?) (juncture)? !(V2) (yhyphen)?))")

L("CVVFinal1 <- (C1 !(BrokenMono) V2 stress !(RepeatedVowel) V2 !(stress) (juncture)? !(V2))")

L("CVVFinal2 <- (((C1 !(Mono) V2 V2) / (C1 !(BrokenMono) V2 juncture !(RepeatedVowel) V2)) !(Letter))")

L("CVVFinal3 <- (C1 &(Mono) V2 V2 !(stress) (juncture)? !(V2))")

L("CVVFinal4 <- (C1 Mono !(Letter))")

L("CVVFinal5 <- (((C1 !(Mono) V2 V2) / (C1 !(BrokenMono) V2 juncture V2)) &(((juncture)? [y])))")

L("CVC <- ((C1 V2 Cfinal) (juncture)?)")

L("CVCStressed <- ((C1 V2 !(NonmedialCC) !(NonjointCCC) C1 stress !(V2) (yhyphen)?) / (C1 V2 stress C1 !(juncture) yhyphen))")

L("CCV <- (InitialCC !(RepeatedVowel) V2 (juncture)? !(V2) (yhyphen)?)")

L("CCVStressed <- (InitialCC !(RepeatedVowel) V2 stress !(V2) (yhyphen)?)")

L("CCVFinal1 <- (InitialCC !(RepeatedVowel) V2 !(stress) (juncture)? !(V2))")

L("CCVFinal2 <- (InitialCC V2 !(Letter))")

L("CCVCVMedial <- (InitialCC V2 (juncture)? C1 [y] !(stress) (juncture)? &(letter))")

L("CCVCVMedialStressed <- (CCV stress C1 [y] !(stress) (juncture)? &(letter))")

L("CCVCVFinal1 <- (InitialCC V2 stress CV)")

L("CCVCVFinal2 <- (InitialCC V2 (juncture)? CV !(Letter))")

L("CCVCVY <- (InitialCC V2 (juncture)? CV [y])")

L("CVCCVMedial <- (C1 V2 ((juncture &(InitialCC)))? !(NonmedialCC) C1 (juncture)? C1 [y] !(stress) (juncture)? &(letter))")

L("CVCCVMedialStressed <- ((C1 V2 (stress &(InitialCC)) !(NonmedialCC) C1 C1 [y] !(stress) (juncture)? &(letter)) / (C1 V2 !(NonmedialCC) C1 stress C1 [y] !(stress) (juncture)? &(letter)))")

L("CVCCVFinal1a <- (C1 V2 stress InitialCC V2 !(stress) (juncture)? !(V2))")

L("CVCCVYa <- (C1 V2 (juncture)? InitialCC V2 !(stress) (juncture)? [y])")

L("CVCCVFinal1b <- (C1 V2 !(NonmedialCC) C1 stress CV)")

L("CVCCVYb <- (C1 V2 !(NonmedialCC) C1 (juncture)? CV [y])")

L("CVCCVFinal2 <- (C1 V2 ((juncture &(InitialCC)))? !(NonmedialCC) C1 (juncture)? CV !(Letter))")

L("FiveLetterY <- (CCVCVY / CVCCVYa / CVCCVYb)")

L("GenericFinal <- (CVVFinal3 / CVVFinal4 / CCVFinal1 / CCVFinal2)")

L("FiveLetterFinal <- (CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2)")

L("GenericTerminalFinal <- (CVVFinal4 / CCVFinal2)")

L("Affix1 <- (CCVCVMedial / CVCCVMedial / CCV / CVV / CVC)")

L("Peelable <- (&(PreBorrowingAffix) !(CVVFinal1) !(CVVFinal5) Affix1 (!(Affix1) / &((&(PreBorrowingAffix) !(CVVFinal1) !(CVVFinal5) Affix1 !(PreBorrowingAffix) !(Affix1))) / Peelable))")

L("Peelable2 <- (&(PreBorrowing) !(CVVFinal1) !(CVVFinal2) !(CVVFinal5) !(FiveLetterFinal) Affix1 !(FiveLetterFinal) (!(Affix1) / &((&(PreBorrowing) !(FiveLetterFinal) !(CVVFinal1) !(CVVFinal2) !(CVVFinal5) Affix1 !(PreBorrowing) !(FiveLetterFinal) !(Affix1))) / Peelable2))")

L("Affix <- ((!(Peelable) !(Peelable2) Affix1) / (!(FiveLetterY) BorrowingAffix))")

L("Affix2 <- (!(StressedSyllable2) !(CVVStressed) Affix)")

L("ComplexTail <- ((Affix GenericTerminalFinal) / (!((!(Peelable) Affix1)) !(FiveLetterY) StressedBorrowingAffix GenericFinal) / (CCVCVMedialStressed GenericFinal) / (CVCCVMedialStressed GenericFinal) / (CCVStressed GenericFinal) / (CVCStressed GenericFinal) / (CVVStressed GenericFinal) / (CVVStressed2 GenericFinal) / (Affix2 CVVFinal1) / (Affix2 CVVFinal2) / CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2 / (!((CVVStressed / StressedSyllable2)) Affix !((!(Peelable2) Affix1)) Borrowing !(((juncture)? [y]))))")

L("Primitive <- (CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2)")

L("PreComplex <- (ComplexTail / ((!((CVCStressed / CCVStressed / CVVStressed / ComplexTail / StressedSyllable2)) Affix) PreComplex))")

L("Complex <- (!((C1 V2 (juncture)? (V2)? (juncture)? CVV)) !((C1 V2 !(stress) (juncture)? (V2)? !(stress) (juncture)? (Primitive / PreComplex / Borrowing / CVV))) !((C1 V2 (juncture)? &(MaybeInitialCC) C1 (juncture)? &((PreComplex / ComplexTail)))) PreComplex)")

L("Predicate <- (((&(caprule) ((Primitive / Complex / Borrowing) ((([ ])* Z AO (', ')? ([ ])* Predicate))?)) / (C1 V2 (V2)? ([ ])* Z AO (comma)? ([ ])* Predicate)) !(((juncture)? [y])))")

L("Fourvowels <- (C1 V2 (juncture)? V2 (juncture)? V2 (juncture)? V2)")

L("B <- (!(Predicate) !(Fourvowels) [Bb])")

L("C <- (!(Predicate) !(Fourvowels) [Cc])")

L("D <- (!(Predicate) !(Fourvowels) [Dd])")

L("F <- (!(Predicate) !(Fourvowels) [Ff])")

L("G <- (!(Predicate) !(Fourvowels) [Gg])")

L("H <- (!(Predicate) !(Fourvowels) [Hh])")

L("J <- (!(Predicate) !(Fourvowels) [Jj])")

L("K <- (!(Predicate) !(Fourvowels) [Kk])")

L("L <- (!(Predicate) !(Fourvowels) [Ll])")

L("M <- (!(Predicate) !(Fourvowels) [Mm])")

L("N <- (!(Predicate) !(Fourvowels) [Nn])")

L("P <- (!(Predicate) !(Fourvowels) [Pp])")

L("R <- (!(Predicate) !(Fourvowels) [Rr])")

L("S <- (!(Predicate) !(Fourvowels) [Ss])")

L("T <- (!(Predicate) !(Fourvowels) [Tt])")

L("V <- (!(Predicate) !(Fourvowels) [Vv])")

L("Z <- (!(Predicate) !(Fourvowels) [Zz])")

L("a <- ([Aa] (juncture2)? !(V2))")

L("e <- (([Ee] (juncture2)?) !(V2))")

L("i <- ([Ii] (juncture2)? !(V2))")

L("o <- ([Oo] (juncture2)? !(V2))")

L("u <- ([Uu] (juncture2)? !(V2))")

L("V3 <- (!(Predicate) V2)")

L("AA <- ([Aa] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("AE <- ([Aa] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("AI <- ([Aa] [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("AO <- ([Aa] [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("AU <- ([Aa] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("EA <- ([Ee] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("EE <- ([Ee] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("EI <- ([Ee] [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("EO <- ([Ee] (juncture)? [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("EU <- ([Ee] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("IA <- ([Ii] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("IE <- ([Ii] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("II <- ([Ii] (juncture)? [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("IO <- ([Ii] (juncture)? [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("IU <- ([Ii] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("OA <- ([Oo] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("OE <- ([Oo] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("OI <- ([Oo] [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("OO <- ([Oo] (juncture)? [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("OU <- ([Oo] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("UA <- ([Uu] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("UE <- ([Uu] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("UI <- ([Uu] (juncture)? [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("UO <- ([Uu] (juncture)? [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("UU <- ([Uu] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))")

L("__LWinit <- (([ ])* !(Predicate) &(caprule))")

L("CANCELPAUSE <- (comma (('y' comma) / (C UU !(connective))))")

L("PAUSE <- (!(CANCELPAUSE) comma !(connective) !(V1))")

L("TAI0 <- (!(Predicate) (((V1 (juncture)? !(Predicate) !(Name) M a (juncture2)?) / (V1 (juncture)? !(Predicate) !(Name) F i (juncture2)?) / (V1 (juncture)? !(Predicate) !(Name) Z i (juncture2)?) / (C1 AI (u)?) / (C1 EI (u)?) / (C1 EO) / (Z [i] (juncture)? V1 (juncture2)? ((M a))? (juncture2)?)) (!(Oddvowel) / (!([ ]) &(TAI0)))))")

L("NOI <- (N OI)")

L("A0 <- (!(Predicate) !((Mono / BrokenMono)) (([AEOUaeou] / (H a)) (juncture2)? !(V2)))")

L("A <- (__LWinit !(TAI0) (((N [u]) &((u / (N [o])))))? ((N [o]))? A0 (NOI)? !((([ ])+ PANOPAUSES PAUSE)) !((PANOPAUSES !(PAUSE) [ ,])) ((PANOPAUSES ((F i) / &(PAUSE))))?)")

L("ANOFI <- (__LWinit !(TAI0) (((N [u]) &((u / (N [o])))))? ((N [o]))? A0 (NOI)? (PANOPAUSES)?)")

L("A1 <- (A !(connective))")

L("ACI <- (ANOFI C i !(connective))")

L("AGE <- (ANOFI G e !(connective))")

L("CA0 <- ((((N o))? ((C a) / (C e) / (C o) / (C u) / (Z e) / (C i H a))) (NOI)?)")

L("CA1 <- ((((N u) &(((C u) / (N o)))))? ((N o))? CA0 !((([ ])+ PANOPAUSES PAUSE)) !((PANOPAUSES !(PAUSE) [ ,])) ((PANOPAUSES ((F i) / &(PAUSE))))?)")

L("CA1NOFI <- ((((N u) &(((C u) / (N o)))))? ((N o))? CA0 (PANOPAUSES)?)")

L("CA <- (__LWinit &(caprule) CA1 !(connective))")

L("ZE2 <- (__LWinit (Z e) !(connective))")

L("I <- (__LWinit !(TAI0) i !((([ ])+ PANOPAUSES PAUSE)) !((PANOPAUSES !(PAUSE) [ ,])) ((PANOPAUSES ((F i) / &(PAUSE))))? !(connective))")

L("ICA <- (__LWinit !(Predicate) i ((H a) / CA1) !(connective))")

L("ICI <- (__LWinit i (CA1NOFI)? C i !(connective))")

L("IGE <- (__LWinit i (CA1NOFI)? G e !(connective))")

L("connective <- (ACI / AGE / A1 / ICI / ICA / IGE / I / (&(V1) TAI0))")

L("KA0 <- ((K a) / (K e) / (K o) / (K u) / (K i H a))")

L("KOU <- ((K OU) / (M OI) / (R AU) / (S OA) / (M OU) / (C IU))")

L("KOU1 <- (((N u N o) / (N u) / (N o)) KOU)")

L("KA <- (__LWinit &(caprule) (((((N u) &((K u))))? KA0) / ((KOU1 / KOU) K i)) (NOI)? !(connective))")

L("KI <- (__LWinit (K i) (NOI)? !(connective))")

L("KOU2 <- (KOU1 !(KI))")

L("BadNIStress <- ((C1 V2 (V2)? stress ((M a))? ((M OA))? NI RA) / (C1 V2 stress V2 ((M a))? ((M OA))? NI RA))")

L("NI0 <- (!(BadNIStress) ((K UA) / (G IE) / (G IU) / (H IE) / (H IU) / (K UE) / (N EA) / (N IO) / (P EA) / (P IO) / (S UU) / (S UA) / (T IA) / (Z OA) / (Z OO) / (H o) / (N i) / (N e) / (T o) / (T e) / (F o) / (F e) / (V o) / (V e) / (P i) / (R e) / (R u) / (S e) / (S o) / (H i)))")

L("SA <- (!(BadNIStress) ((S a) / (S i) / (S u) / (IE (((comma2)? !(IE) SA))?)) (NOI)?)")

L("RA <- (!(BadNIStress) ((R a) / (R i) / (R o)))")

L("NI1 <- ((NI0 ((!(BadNIStress) M a))? ((!(BadNIStress) M OA (NI0)*))?) ((comma2 !((NI RA)) &(NI)))?)")

L("RA1 <- ((RA ((!(BadNIStress) M a))? ((!(BadNIStress) M OA (NI0)*))?) ((comma2 !((NI RA)) &(NI)))?)")

L("NI2 <- ((((SA)? ((NI1)+ / RA1)) / SA) (NOI)? ((CA0 (((SA)? ((NI1)+ / RA1)) / SA) (NOI)?))*)")

L("NI <- (__LWinit NI2 ((&((M UE)) Acronym (comma / &(end) / &(period)) !((C u))))? ((C u))?)")

L("mex <- (__LWinit NI !(connective))")

L("CI <- (__LWinit (C i) !(connective) !(badspaces))")

L("Acronym <- (([ ])* &(caprule) ((M UE) / TAI0 / ([Zz] V2 !(V2))) (((comma &(Acronym) M UE) / NI1 / TAI0 / ([Zz] V2 (!(V2) / ([Zz] &(V2))))))+)")

L("TAI <- (__LWinit (TAI0 / ((G AO) !(badspaces) !(V2) ([ ])* (Name / Predicate / (C1 V2 V2 (!(Oddvowel) / &(TAI0))) / (C1 V2 (!(Oddvowel) / &(TAI0)))))) !(connective))")

L("DA0 <- ((T AO) / (T IO) / (T UA) / (M IO) / (M IU) / (M UO) / (M UU) / (T OA) / (T OI) / (T OO) / (T OU) / (T UO) / (T UU) / (S UO) / (H u) / (B a) / (B e) / (B o) / (B u) / (D a) / (D e) / (D i) / (D o) / (D u) / (M i) / (T u) / (M u) / (T i) / (T a) / (M o))")

L("DA1 <- ((TAI0 / DA0) ((C i !([ ]) NI0))?)")

L("DA <- (__LWinit DA1 !(connective))")

L("PA0 <- (((N u !(KOU)))? ((G IA) / (G UA) / (P AU) / (P IA) / (P UA) / (N IA) / (N UA) / (B IU) / (F EA) / (F IA) / (F UA) / (V IA) / (V II) / (V IU) / (C OI) / (D AU) / (D II) / (D UO) / (F OI) / (F UI) / (G AU) / (H EA) / (K AU) / (K II) / (K UI) / (L IA) / (L UI) / (M IA) / (N UI) / (P EU) / (R OI) / (R UI) / (S EA) / (S IO) / (T IE) / (V a) / (V i) / (V u) / (P a) / (N a) / (F a) / (V a) / (KOU !((N OI)) !(KI))) ((N OI))?)")

L("PANOPAUSES <- (((!(PA0) NI))? ((KOU2 / PA0))+ ((((comma2)? CA0 (comma2)?) ((KOU2 / PA0))+))* (ZI)?)")

L("PA3 <- (__LWinit PANOPAUSES !(connective))")

L("PA <- (((!(PA0) NI))? ((KOU2 / PA0))+ (((((comma2)? CA0 (comma2)?) / (comma2 !(mod1a))) ((KOU2 / PA0))+))* (ZI)?)")

L("PA2 <- (__LWinit PA !(connective))")

L("GA <- (__LWinit (G a) !(connective))")

L("PA1 <- ((PA2 / GA) !(connective))")

L("ZI <- ((Z i) / (Z a) / (Z u))")

L("LE <- (__LWinit ((L EA) / (L EU) / (L OE) / (L EE) / (L AA) / (L e) / (L o) / ((L a) !(badspaces))) !(connective))")

L("LEFORPO <- (__LWinit ((L e) / (L o) / NI2) !(connective))")

L("LIO <- (__LWinit (L IO) !(connective))")

L("LAU <- (__LWinit (L AU) !(connective))")

L("LOU <- (__LWinit (L OU) !(connective))")

L("LUA <- (__LWinit (L UA) !(connective))")

L("LUO <- (__LWinit (L UO) !(connective))")

L("ZEIA <- (__LWinit Z EI a !(connective))")

L("ZEIO <- (__LWinit Z EI o !(connective))")

L("LI1 <- (L i)")

L("LU1 <- (L u)")

L("LI2 <- (([\"] L i) / (L i [\"]))")

L("LU2 <- ((L u [\"]) / ([\"] L u))")

L("Quotemod <- ((Z a) / (Z i))")

L("LI <- (((__LWinit LI1 !(V2) (Quotemod)? ((([,])? ([ ])+))? utterance0 (', ')? __LWinit LU1 !(connective)) / (__LWinit LI1 !(V2) (Quotemod)? comma name (comma)? __LWinit LU1 !(connective))) / ((__LWinit LI2 !(V2) (Quotemod)? ((([,])? ([ ])+))? utterance0 (', ')? __LWinit LU2 !(connective)) / (__LWinit LI2 !(V2) (Quotemod)? comma name (comma)? __LWinit LU2 !(connective))))")

L("stringnospaces <- (([,])? (((([ ])+ [\"]) / (([ ])+ !([\"]))) ((!((([\",])? [ ,])) !((([\"])? (period / !(.)))) .))+) (&([\"]) / (([,])? ([ ])+ &(letter)) / &(period) / &(end)))")

L("stringnospacesclosed <- (([,])? (((([ ])+ [\"]) / (([ ])+ !([\"]))) ((!((([\",])? [ ,])) !((([\"])? (period / !(.)))) .))+) (([,] ([ ])+) / &(period) / &(end)))")

L("stringnospacesclosedblock <- ((stringnospaces ((!(([y] stringnospacesclosed)) [y] stringnospaces))* ([y] stringnospacesclosed)) / stringnospacesclosed)")

L("LAO1 <- (L AO)")

L("LAO <- (([ ])* (LAO1 stringnospaces (([y] stringnospaces))*))")

L("LIE1 <- (L IE)")

L("LIE <- (((([ ])* (LIE1 (Quotemod)? &((([,])? ([ ])+ [\"])) stringnospaces (([y] stringnospaces))*)) [\"] (comma)?) / (([ ])* (LIE1 (Quotemod)? &((([,])? ([ ])+ !([\"]))) stringnospaces (([y] stringnospaces))*)))")

L("LW <- (&(caprule) (((!(Predicate) V2 V2))+ / ((!(Predicate) (V2)? ((!(Predicate) LWunit))+) / V2)))")

L("LIU0 <- ((L IU) / (N IU))")

L("LIU1 <- (__LWinit ((LIU0 !(badspaces) !(V2) (Quotemod)? ((([,])? ([ ])+))? (Name / (Predicate (comma)?) / (CCV (comma)?) / (LW (([,] ([ ])+ !([,])) / &(period) / &(end) / &((([ ])* Predicate)))))) / (L II (Quotemod)? TAI !(connective))))")

L("SUE <- (__LWinit ((S UE) / (S AO)) stringnospaces)")

L("CUI <- (__LWinit (C UI) !(connective))")

L("GA2 <- (__LWinit (G a) !(connective))")

L("GE <- (__LWinit (G e) !(connective))")

L("GEU <- (__LWinit ((C UE) / (G EU)) !(connective))")

L("GI <- (__LWinit ((G i) / (G OI)) !(connective))")

L("GO <- (__LWinit (G o) !(connective))")

L("GIO <- (__LWinit (G IO) !(connective))")

L("GU <- (__LWinit (G u) !(connective))")

L("GUIZA <- (__LWinit (G UI) (Z a) !(connective))")

L("GUIZI <- (__LWinit (G UI) (Z i) !(connective))")

L("GUIZU <- (__LWinit (G UI) (Z u) !(connective))")

L("GUI <- (!(GUIZA) !(GUIZI) !(GUIZU) (__LWinit (G UI) !(connective)))")

L("GUO <- (__LWinit (G UO) !(connective))")

L("GUOA <- (__LWinit (G UO (Z)? a) !(connective))")

L("GUOE <- (__LWinit (G UO e) !(connective))")

L("GUOI <- (__LWinit (G UO (Z)? i) !(connective))")

L("GUOO <- (__LWinit (G UO o) !(connective))")

L("GUOU <- (__LWinit (G UO (Z)? u) !(connective))")

L("GUU <- (__LWinit (G UU) !(connective))")

L("GUUA <- (__LWinit (G UU a) !(connective))")

L("GIUO <- (__LWinit (G IU o) !(connective))")

L("GUE <- (__LWinit (G UE) !(connective))")

L("GUEA <- (__LWinit (G UE a) !(connective))")

L("JE <- (__LWinit (J e) !(connective))")

L("JUE <- (__LWinit (J UE) !(connective))")

L("JIZA <- (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) (Z a) !(connective))")

L("JIOZA <- (__LWinit ((J IO) / (J AO)) (Z a) !(connective))")

L("JIZI <- (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) (Z i) !(connective))")

L("JIOZI <- (__LWinit ((J IO) / (J AO)) (Z i) !(connective))")

L("JIZU <- (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) (Z u) !(connective))")

L("JIOZU <- (__LWinit ((J IO) / (J AO)) (Z u) !(connective))")

L("JI <- (!(JIZA) !(JIZI) !(JIZU) (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) !(connective)))")

L("JIO <- (!(JIOZA) !(JIOZI) !(JIOZU) (__LWinit ((J IO) / (J AO)) !(connective)))")

L("DIO <- (__LWinit ((B EU) / (C AU) / (D IO) / (F OA) / (K AO) / (J UI) / (N EU) / (P OU) / (G OA) / (S AU) / (V EU) / (Z UA) / (Z UE) / (Z UI) / (Z UO) / (Z UU)) !(connective))")

L("LAE <- (__LWinit ((L AE) / (L UE)) !(connective))")

L("ME <- (__LWinit ((M EA) / (M e)) !(connective))")

L("MEU <- (__LWinit M EU !(connective))")

L("NU0 <- ((N UO) / (F UO) / (J UO) / (N u) / (F u) / (J u))")

L("NU <- (__LWinit ((NU0 !((([ ])+ (NI0 / RA))) ((NI0 / RA))? (freemod)?))+ !(connective))")

L("PO1 <- (__LWinit ((P o) / (P u) / (Z o)))")

L("PO1A <- (__LWinit ((P OI a) / (P UI a) / (Z OI a) / (P o Z a) / (P u Z a) / (Z o Z a)))")

L("PO1E <- (__LWinit ((P OI e) / (P UI e) / (Z OI e)))")

L("PO1I <- (__LWinit ((P OI i) / (P UI i) / (Z OI i) / (P o Z i) / (P u Z i) / (Z o Z i)))")

L("PO1O <- (__LWinit ((P OI o) / (P UI o) / (Z OI o)))")

L("PO1U <- (__LWinit ((P OI u) / (P UI u) / (Z OI u) / (P o Z u) / (P u Z u) / (Z o Z u)))")

L("POSHORT1 <- (__LWinit ((P OI) / (P UI) / (Z OI)))")

L("PO <- (__LWinit PO1 !(connective))")

L("POA <- (__LWinit PO1A !(connective))")

L("POE <- (__LWinit PO1E !(connective))")

L("POI <- (__LWinit PO1E !(connective))")

L("POO <- (__LWinit PO1O !(connective))")

L("POU <- (__LWinit PO1U !(connective))")

L("POSHORT <- (__LWinit POSHORT1 !(connective))")

L("DIE <- (__LWinit ((D IE) / (F IE) / (K AE) / (N UE) / (R IE)) !(connective))")

L("HOI <- (__LWinit ((H OI) / (L OI) / (L OA) / (S IA) / (S IE) / (S IU)) !(connective) !(badspaces))")

L("JO <- (__LWinit ((NI0 / RA))? (J o) !(connective))")

L("KIE <- (__LWinit (K IE) !(connective))")

L("KIU <- (__LWinit (K IU) !(connective))")

L("KIE2 <- ((__LWinit [(] (K IE) !(connective)) / (__LWinit (K IE) [(] !(connective)))")

L("KIU2 <- ((__LWinit (K IU) [)] !(connective)) / (__LWinit [)] (K IU) !(connective)))")

L("SOI <- (__LWinit (S OI) !(connective))")

L("UI0 <- (!(Predicate) (UA / UE / UI / UO / UU / OA / OE / OI / OU / OO / IA / II / IO / IU / EA / EE / EI / EO / EU / AA / AE / AI / AO / AU / (B EA) / (B UO) / (C EA) / (C IA) / (C OA) / (D OU) / (F AE) / (F AO) / (F EU) / (G EA) / (K UO) / (K UU) / (R EA) / (N AO) / (N IE) / (P AE) / (P IU) / (S AA) / (S UI) / (T AA) / (T OE) / (V OI) / (Z OU) / ((L OI) !(badspaces)) / ((L OA) !(badspaces)) / ((S IA) !(badspaces)) / (S II) / (T OE) / ((S IU) !(badspaces)) / (C AO) / (C EU) / ((S IE) !(badspaces)) / (S EU)))")

L("NOUI <- ((__LWinit N [o] (juncture)? ([ ])* UI0 !(connective)) / (__LWinit UI0 NOI !(connective)))")

L("UI1 <- (__LWinit (UI0 / (NI F i)) !(connective))")

L("HUE <- (__LWinit (H UE) !(connective) !(badspaces))")

L("NO1 <- (__LWinit !(KOU1) !(NOUI) (N o) !((__LWinit KOU)) !((([ ])* (JIO / JI / JIZA / JIOZA / JIZI / JIOZI / JIZU / JIOZU))) !(connective))")

L("AcronymicName <- (Acronym (&(end) / ',' / &(period) / &(Name) / &(CI)))")

L("DJAN <- (Name / AcronymicName)")

L("BI <- (__LWinit ((N u))? ((B IA) / (B IE) / (C IE) / (C IO) / (B IA) / (B [i])) !(connective))")

L("LWPREDA <- ((H e) / (D UA) / (D UI) / (B UA) / (B UI))")

L("PREDA <- (([ ])* &(caprule) (Predicate / LWPREDA / (!([ ]) NI RA)) !(connective))")

L("guoa <- ((PAUSE)? (GUOA / GU) (freemod)?)")

L("guoe <- ((PAUSE)? (GUOE / GU) (freemod)?)")

L("guoi <- ((PAUSE)? (GUOI / GU) (freemod)?)")

L("guoo <- ((PAUSE)? (GUOO / GU) (freemod)?)")

L("guou <- ((PAUSE)? (GUOU / GU) (freemod)?)")

L("guo <- (!(guoa) !(guoi) !(guou) ((PAUSE)? (GUO / GU) (freemod)?))")

L("guiza <- ((PAUSE)? (GUIZA / GU) (freemod)?)")

L("guizi <- ((PAUSE)? (GUIZI / GU) (freemod)?)")

L("guizu <- ((PAUSE)? (GUIZU / GU) (freemod)?)")

L("gui <- ((PAUSE)? (GUI / GU) (freemod)?)")

L("gue <- ((PAUSE)? (GUE / GU) (freemod)?)")

L("guea <- ((PAUSE)? (GUEA / GU) (freemod)?)")

L("guu <- ((PAUSE)? (GUU / GU) (freemod)?)")

L("guua <- ((PAUSE)? (GUUA / GU) (freemod)?)")

L("giuo <- ((PAUSE)? (GIUO / GU) (freemod)?)")

L("meu <- ((PAUSE)? (MEU / GU) (freemod)?)")

L("geu <- GEU")

L("gap <- ((PAUSE)? GU (freemod)?)")

L("juelink <- (JUE (freemod)? (term / (PA2 (freemod)? (gap)?)))")

L("links1 <- (juelink (((freemod)? juelink))* (gue)?)")

L("links <- ((links1 / (KA (freemod)? links (freemod)? KI (freemod)? links1)) (((freemod)? A1 (freemod)? links1))*)")

L("jelink <- (JE (freemod)? (term / (PA2 (freemod)? (gap)?)))")

L("linkargs1 <- (jelink (freemod)? ((links / gue))?)")

L("linkargs <- ((linkargs1 / (KA (freemod)? linkargs (freemod)? KI (freemod)? linkargs1)) (((freemod)? A1 (freemod)? linkargs1))*)")

L("abstractpred <- ((POA (freemod)? uttAx (guoa)?) / (POA (freemod)? sentence (guoa)?) / (POE (freemod)? uttAx (guoe)?) / (POE (freemod)? sentence (guoe)?) / (POI (freemod)? uttAx (guoi)?) / (POI (freemod)? sentence (guoi)?) / (POO (freemod)? uttAx (guoo)?) / (POO (freemod)? sentence (guoo)?) / (POU (freemod)? uttAx (guou)?) / (POU (freemod)? sentence (guou)?) / (PO (freemod)? uttAx (guo)?) / (PO (freemod)? sentence (guo)?))")

L("predunit1 <- ((SUE / (NU (freemod)? GE (freemod)? despredE (((freemod)? geu (comma)?))?) / (NU (freemod)? PREDA) / ((comma)? GE (freemod)? descpred (((freemod)? geu (comma)?))?) / abstractpred / (ME (freemod)? argument1 (meu)?) / PREDA) (freemod)?)")

L("predunit2 <- (((NO1 (freemod)?))* predunit1)")

L("NO2 <- (!(predunit2) NO1)")

L("predunit3 <- ((predunit2 (freemod)? linkargs) / predunit2)")

L("predunit <- (((POSHORT (freemod)?))? predunit3)")

L("kekpredunit <- (((NO1 (freemod)?))* KA (freemod)? predicate (freemod)? KI (freemod)? predicate (guu)?)")

L("despredA <- ((predunit / kekpredunit) (((freemod)? CI (freemod)? (predunit / kekpredunit)))*)")

L("despredB <- ((!(PREDA) CUI (freemod)? despredC (freemod)? CA (freemod)? despredB) / despredA)")

L("despredC <- (despredB (((freemod)? despredB))*)")

L("despredD <- (despredB (((freemod)? CA (freemod)? despredB))*)")

L("despredE <- (despredD (((freemod)? despredD))*)")

L("descpred <- ((despredE (freemod)? GO (freemod)? descpred) / despredE)")

L("sentpred <- ((despredE (freemod)? GO (freemod)? barepred) / despredE)")

L("mod1a <- (PA3 (freemod)? argument1 (guua)?)")

L("mod1 <- ((PA3 (freemod)? argument1 (guua)?) / (PA2 (freemod)? !(barepred) (gap)?))")

L("kekmod <- (((NO1 (freemod)?))* (KA (freemod)? modifier (freemod)? KI (freemod)? mod))")

L("mod <- (mod1 / (((NO1 (freemod)?))* mod1) / kekmod)")

L("modifier <- (mod ((A1 (freemod)? mod))*)")

L("maybebreak <- (V1 (stress)? ' ' !((([ ])* V1)))")

L("realbreak <- (!(maybebreak) letter (stress)? ((([,])? ' ') / period / &(end)))")

L("consonantbreak <- (C1 (stress)? ((([,])? ' ') / period / &(end)))")

L("badspaces <- ((([,])? ([ ])+) ((!((maybebreak / realbreak)) .))* maybebreak ((!(realbreak) .))* consonantbreak)")

L("namemarker <- ((([ ])* ((L a) / (H OI) / (L OI) / (L OA) / (S IE) / (S IA) / (S IU) / (C i) / (H UE) / (L IU) / (G AO))) !(badspaces))")

L("nonamemarkers <- (([ ])* ((!((namemarker Name)) Letter))+ !(Letter))")

L("CI0 <- ([Cc] i &((([ ])* C1)))")

L("name <- (DJAN (((CI (comma)? DJAN) / (CI !(badspaces) (comma)? predunit !((&(nonamemarkers) Name))) / (&(nonamemarkers) Name)))* (freemod)?)")

L("LA0 <- (([Ll] a) !(badspaces))")

L("LANAME <- (([ ])* LA0 (comma)? name)")

L("HOI0 <- (([ ])* ((([Hh] OI) / ([Ll] OI) / ([Ll] OA) / ([Ss] IA) / ([Ss] IE) / ([Ss] IU)) !(badspaces)))")

L("voc <- ((HOI0 !(V1) (comma)? name) / (HOI !(badspaces) (freemod)? descpred (guea)? (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))?) / (HOI !(badspaces) (freemod)? argument1 (guua)?) / (([ ])* H OI stringnospacesclosedblock))")

L("descriptn <- (!(LANAME) ((LAU wordset1) / (LOU wordset2) / (LE (freemod)? ((((!(mex) arg1a (freemod)?))? ((PA2 (freemod)?))?))? mex (freemod)? descpred) / (LE (freemod)? ((((!(mex) arg1a (freemod)?))? ((PA2 (freemod)?))?))? mex (freemod)? arg1a) / (GE (freemod)? mex (freemod)? descpred) / (LE (freemod)? ((((!(mex) arg1a (freemod)?))? ((PA2 (freemod)?))?))? descpred)))")

L("abstractn <- ((LEFORPO (freemod)? POA (freemod)? uttAx (guoa)?) / (LEFORPO (freemod)? POA (freemod)? sentence (guoa)?) / (LEFORPO (freemod)? POE (freemod)? uttAx (guoe)?) / (LEFORPO (freemod)? POE (freemod)? sentence (guoe)?) / (LEFORPO (freemod)? POI (freemod)? uttAx (guoi)?) / (LEFORPO (freemod)? POI (freemod)? sentence (guoi)?) / (LEFORPO (freemod)? POO (freemod)? uttAx (guoo)?) / (LEFORPO (freemod)? POO (freemod)? sentence (guoo)?) / (LEFORPO (freemod)? POU (freemod)? uttAx (guou)?) / (LEFORPO (freemod)? POU (freemod)? sentence (guou)?) / (LEFORPO (freemod)? PO (freemod)? uttAx (guo)?) / (LEFORPO (freemod)? PO (freemod)? sentence (guo)?))")

L("arg1 <- (abstractn / (LIO (freemod)? descpred (guea)?) / (LIO (freemod)? argument1 (guua)?) / (LIO (freemod)? mex (gap)?) / (LIO stringnospaces) / LAO / LANAME / (descriptn (guua)? (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))?) / LIU1 / LIE / LI)")

L("arg1a <- ((DA / TAI / arg1 / (GE (freemod)? arg1a)) (freemod)?)")

L("argmod1 <- ((((__LWinit (N o) ([ ])*))? ((JI (freemod)? predicate) / (JIO (freemod)? sentence) / (JIO (freemod)? uttAx) / (JI (freemod)? modifier) / (JI (freemod)? argument1))) / (((__LWinit (N o) ([ ])*))? (((JIZA (freemod)? predicate) (guiza)?) / ((JIOZA (freemod)? sentence) (guiza)?) / ((JIOZA (freemod)? uttAx) (guiza)?) / ((JIZA (freemod)? modifier) (guiza)?) / (JIZA (freemod)? argument1 (guiza)?))) / (((__LWinit (N o) ([ ])*))? ((JIZI (freemod)? predicate (guizi)?) / (JIOZI (freemod)? sentence (guizi)?) / (JIOZI (freemod)? uttAx (guizi)?) / (JIZI (freemod)? modifier (guizi)?) / (JIZI (freemod)? argument1 (guizi)?))) / (((__LWinit (N o) ([ ])*))? ((JIZU (freemod)? predicate (guizu)?) / (JIOZU (freemod)? sentence (guizu)?) / (JIOZU (freemod)? uttAx (guizu)?) / (JIZU (freemod)? modifier (guizu)?) / (JIZU (freemod)? argument1 (guizu)?))))")

L("argmod <- (argmod1 ((A1 (freemod)? argmod1))* (gui)?)")

L("arg2 <- (arg1a (freemod)? (argmod)*)")

L("arg3 <- (arg2 / (mex (freemod)? arg2))")

L("indef1 <- (mex (freemod)? descpred)")

L("indef2 <- (indef1 (guua)? (argmod)*)")

L("indefinite <- indef2")

L("arg4 <- ((arg3 / indefinite) ((ZE2 (freemod)? (arg3 / indefinite)))*)")

L("arg5 <- (arg4 / (KA (freemod)? argument1 (freemod)? KI (freemod)? argx))")

L("argx <- (((NO1 (freemod)?))* ((LAE (freemod)?))* arg5)")

L("arg7 <- (argx (freemod)? ((ACI (freemod)? argx))?)")

L("arg8 <- (!(GE) (arg7 (freemod)? ((A1 (freemod)? arg7))*))")

L("argument1 <- (((arg8 (freemod)? AGE (freemod)? argument1) / arg8) ((GUU (freemod)? argmod))*)")

L("argument <- (((NO1 (freemod)?))* ((DIO (freemod)?))* argument1)")

L("argumentA <- argument")

L("argumentB <- argument")

L("argumentC <- argument")

L("argumentD <- argument")

L("argxx <- (&((((NO1 (freemod)?))* DIO)) argument)")

L("term <- (argument / modifier)")

L("modifiers <- (modifier (((freemod)? modifier))*)")

L("modifiersx <- ((modifier / argxx) (((freemod)? (modifier / argxx)))*)")

L("terms <- (((modifiersx)? argumentA (((freemod)? modifiersx))? (argumentB)? (((freemod)? modifiersx))? (argumentC)? (((freemod)? modifiersx))? (argumentD)?) / modifiersx)")

L("word <- (arg1a / indef2)")

L("words1 <- (word ((ZEIA word))*)")

L("words2 <- (word ((ZEIO word))*)")

L("wordset1 <- ((words1)? LUA)")

L("wordset2 <- ((words2)? LUO)")

L("termset1 <- (terms / (KA (freemod)? termset2 (freemod)? (guu)? KI (freemod)? termset1))")

L("termset2 <- (termset1 ((guu &(A1)))? ((A1 (freemod)? termset1 ((guu &(A1)))?))*)")

L("termset <- ((terms (freemod)? GO (freemod)? barepred) / termset2)")

L("barepred <- (sentpred (freemod)? (((termset (guu)?) / (guu &(termset))))?)")

L("markpred <- (PA1 (freemod)? barepred)")

L("backpred1 <- (((NO2 (freemod)?))* (barepred / markpred))")

L("backpred <- (((backpred1 ((ACI (freemod)? backpred1))+ (freemod)? (((termset (guu)?) / (guu &(termset))))?) ((((ACI (freemod)? backpred))+ (freemod)? (((termset (guu)?) / (guu &(termset))))?))?) / backpred1)")

L("predicate2 <- (!(GE) (((backpred ((A1 !(GE) (freemod)? backpred))+ (freemod)? (((termset (guu)?) / (guu &(termset))))?) ((((A1 (freemod)? predicate2))+ (freemod)? (((termset (guu)?) / (guu &(termset))))?))?) / backpred))")

L("predicate1 <- ((predicate2 AGE (freemod)? predicate1) / predicate2)")

L("identpred <- (((NO1 (freemod)?))* (BI (freemod)? argument1 (guu)?))")

L("predicate <- (predicate1 / identpred)")

L("subject <- (((modifiers (freemod)?))? ((argxx subject) / (argument ((modifiersx (freemod)?))?)))")

L("gasent1 <- (((NO1 (freemod)?))* (PA1 (freemod)? barepred ((GA2 (freemod)? subject))?))")

L("gasent2 <- (((NO1 (freemod)?))* (PA1 (freemod)? sentpred (modifiers)? (GA2 (freemod)? subject (freemod)? (GIO)? (freemod)? (terms)?)))")

L("gasent <- (gasent2 / gasent1)")

L("statement <- (gasent / (modifiers (freemod)? gasent) / (subject (freemod)? ((GIO (freemod)? terms))? predicate))")

L("keksent <- (((NO1 (freemod)?))* ((KA (freemod)? sentence (freemod)? KI (freemod)? uttA1) / (KA sentence (freemod)? KI (freemod)? uttA1) / (KA (freemod)? headterms (freemod)? sentence (freemod)? KI (freemod)? uttA1)))")

L("neghead <- ((NO1 (freemod)? gap) / (NO2 PAUSE))")

L("sen1 <- (((neghead (freemod)?))* ((modifiers (freemod)? !(gasent) predicate) / statement / predicate / keksent))")

L("sentence <- (sen1 ((ICA (freemod)? sen1))*)")

L("headterms <- ((terms GI))+")

L("uttAx <- (headterms (freemod)? sentence (giuo)?)")

L("HUE0 <- (([ ])* ([Hh] UE))")

L("invvoc <- ((HUE0 !(V1) (comma)? name) / (HUE !(badspaces) (freemod)? descpred (guea)? (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))?) / (HUE !(badspaces) (freemod)? statement (giuo)?) / (HUE !(badspaces) (freemod)? argument1 (guu)?) / (HUE stringnospacesclosedblock))")

L("freemod <- ((NOUI / (SOI (freemod)? descpred (guea)?) / DIE / (NO1 DIE) / (KIE (comma)? utterance0 (comma)? KIU) / (KIE2 (comma)? utterance0 (comma)? KIU2) / invvoc / voc / CANCELPAUSE / (comma !((&(nonamemarkers) Name))) / JO / UI1 / (([ ])* '...' ((([ ])* &(letter)))?) / (([ ])* '--' ((([ ])* &(letter)))?)) (freemod)?)")

L("uttA <- ((A1 / mex) (freemod)?)")

L("uttA1 <- ((sen1 / uttAx / links / linkargs / argmod / (modifiers (freemod)? keksent) / terms / uttA / NO1) (freemod)? (period)?)")

L("uttC <- ((neghead (freemod)? uttC) / uttA1)")

L("uttD <- ((sentence (period)? !(ICI) !(ICA)) / (uttC ((ICI (freemod)? uttD))*))")

L("uttE <- (uttD ((ICA (freemod)? uttD))*)")

L("uttF <- (uttE ((I (freemod)? uttE))*)")

L("utterance0 <- (!(GE) ((!(PAUSE) freemod (period)? utterance0) / (!(PAUSE) freemod (period)?) / (uttF IGE utterance0) / uttF / (I (freemod)? (uttF)?) / (I (freemod)? (period)?) / (ICA (freemod)? uttF)) ((&(I) utterance0))?)")

L("utterance <- (!(GE) ((!(PAUSE) freemod (period)? utterance) / (!(PAUSE) freemod (period)? ((&(I) utterance))? end) / (uttF IGE utterance) / (I (freemod)? (period)? ((&(I) utterance))? end) / (uttF ((&(I) utterance))? end) / (I (freemod)? uttF ((&(I) utterance))? end) / (ICA (freemod)? uttF ((&(I) utterance))? end)))")
if __name__ == '__main__':interface();