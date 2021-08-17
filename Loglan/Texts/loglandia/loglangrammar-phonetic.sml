fun loglanversion() = say "2/14/2016:  installed pauses before compound VV words.  Other minor fixes between 11th and 14th.\n2/11/2016:  massive repairs to syllabification for phonetic parsing.  unordered and order lists installed.\n2/8/2016:  correct bug in CCVCVMedial\n2/7/2016:  Fixes to silly syllabic consonant situations.  fixed ne, tori.  technical repair to JunctureFix. \n2/6/2016:  added change of voice marker #\n2/5/2016 a bug affecting CVV stressed syllables in complexes in phonetic transcripts\n2/5/2016:  CV cmapua guarded from extending to monosyllables.\n2/3/2016: fixed bug in StressedSyllable2; major upgrade to abstractions, minor fix to CCVV rule\n1/31/2016:  changed shortscope abstractors.removed freemod2, freemod3 and other junk.  Installed a condition in borrowings and borrowing affixes which was already supposed to be there.  Generally removed commented alternative text.\n1/30/2016:  updated LIU, TAI with badspaces;updated stringnospaces classes with a closed version and installed it in voc and freemod;  added descpred case to inverse vocatives;  added name-final option to descpred option in vocatives and inverse vocatives.  Added LOI/LOA/SIA/SIE/SIU to class HOI.  Allowing foreign text with LIO.\n1/29/2016:  further fix to false name marker problem.\n1/27/2016:  refinements to the false name marker problem.  New letters added (including QWX)\n1/23/2016:  changes to do with output display upgrade.\n1/21/2016:  multipart foreign name vocatives; quoted names with LI LU\n1/19/2016:overhaul of capitalization; allowing quotation with LIU of CCV djifoa.\n1/18/2016:exclude CCCVV predicates for a (stupid) technical reason.\n1/17/2016:  technical fix to APA words, keeping them from including a pause\nfix to continuation of utterances.\n1/10/2016: adding NUJI\nadded ellipsis and hyphen as freemods and optional commas in KIE freemods\nand yet more Leith discoveries:\nfixed problem with utterance0 making it impossible to quote I initial utterances\nfixed comma problem after LIU Predicate\n installing bare foreign names after HOI/HUE\n12/21/2015:  slight adjustment to inverse vocatives after periods.\n  12/20/2015:  further changes suggested by parsing Leith.   Allow HUE-initial freemod after terminal punctuation.  Try to allow capitalized letterals in articles (done).  Try to distinguish A from legacy vowel letterals (done) 12/19/2015:  corrections from loglandia3.  ability to attach freemod to NO as a utterance is needed.\n11/15/2015:  fixed a bug in the KOU1 class.\n 11/14 minor adjustments motivated by parsing A Visit to Loglandia.\n Forms like rimo, a few hundred.\n the word <pau>, ago was not supported.\n hue terms changed to hue termset to allow closure avoiding a confusion with hue sentence in initial position.\n 10/22 further fixes to NI and PA\nallows pauses in PA words and totally different solution to APA problem.  Completely kills pause/GU equivalence.\n 10/19 corrects silly error in SA class\nVersion of 10/17 no pause/GU equivalence now preferred.  Modifications to class NI.\nVersion of 9/24:  gaps adjusted:  gap = non-pause gap introduced.  je/jue links more sensitive.\nVersion of 9/22/2015:  extensive adjustment of freemods; class freemod defined (non-pause freemods).\nVersion(s) of 9/19/2015:  two versions of gasent supported.  \nTo build it with the more general definition, change the comments.  \nRevision of commas before vowel initial names.\nVersion of 9/17/2015:  no two\n successive syllables with syllabic consonants in borrowings \n(makes sense, and fixes a subtle problem with the spec for\nborrowing affixes) and no significant pauses before names without false name markers.\nVersion of 9/16/2015:  experimentally restricted\n the (ga terms) component of gasent to contain just one argument\n";


(* Loglan grammar to be run under pegparser.sml, by Randall Holmes *)

(*  FRONT END:  users please read this.

The contents of this file are intellectual property of Randall Holmes
and of the Loglan Institute.  You are free to use them for private
noncommercial purposes as you wish but we reserve all rights.  Members
of the Logical Language Group are entirely welcome to adapt anything
here for use in Lojban.

This is a file full of Standard ML commands which should be run after
compiling, loading and opening pegparser.sml in the Moscow ML interpreter.

Once you have achieved that state, you run this file by typing

use "loglangrammar.sml";

in the ML window.

User commands for the parser engine, which you *will* want to know
about, are in the FRONT END section of pegparser.sml

there are a couple of commands in this file:

utter "<string>"  (* parses <string> as type utterance -- same as
                  parsetest "utterance" "<string>"; *)

loglanversion();  (* shows you the version info about this file *)

niceprecs();  (* You want to run this to see things in a nice format *)

                  (* if you make your own versions, you might want to edit
                  the text below in the definition of this function *)

The grammar is now fairly stable and reliable, but there certainly could be bugs.

I have an ambition to write something that will check for unintended readings mechanically in PEG's; I see how this should work but it is hard to write.

If you know what a PEG is you are welcome to try to fix bugs, at the
risk of your own sanity.

My quotation operators are nonstandard.

The comments throughout should be accessible; this isn't like pegparser.sml
where I expect the naive to stay in the front end section.

Again, EXPECT bugs (less often than before, but surely they exist) and tell me about them.  Use the commands in
pegparser.sml to manage the level of detail in parser display.  The
parser simply fails when it fails: it does not report partial parses
(now it can, with viewcache();)
[I am planning to work on getting pegparser.sml to report partial parse
information and also to pretty-print its output]. (DONE)
However, you can use parsetest to get information about parsing of
strings in other classes than the top level "utterance" and of course
you can make repeated attempts.  And you can ask me for help.

The PEG grammar as a standalone text is also available (the pegparser.sml
file contains functions that generate this text).

Much but not all of the trial.85 Loglan official grammar is or used to be embedded
in comments here.

*)



fun utter s = (say s;parsetest "utterance" s; errormessage "next?");

fun utteras t s = (say s;parsetest t s; errormessage "next?");


Parsedef "lowercase <- (!([qwx]) [a-z])";  (*test*)

Parsedef "uppercase <- (!([QWX]) [A-Z])";

Parsedef "letter <- (!([QWXqwx]) [A-Za-z])";

Parsedef "juncture <- (([-] &(letter)) / ['*] !(juncture))";

Parsedef "stress <- ['*] !juncture";

Parsedef "juncture2 <- ((([-] &letter)/(['*] !([ ]* Predicate) (', ' [ ]* &Predicate)?)) !juncture)";

Parsedef "Lowercase <- (lowercase / juncture letter?)";

Parsedef "Letter <- (letter / juncture)";

Parsedef "comma <- [,] [ ]+ &letter";

Parsedef "comma2 <- [,]? [ ]+ &letter";

Parsedef "end <- ([ ]* '#' [ ]+ utterance/[ ]+ !./!.)";

Parsedef "period <- ([!.:;?] (&end/ [ ]+ &letter)) (&HUE freemod period?)? ";

Parsedef "V1 <- [AEIOUYaeiouy]";

Parsedef "V2 <- [AEIOUaeiou]";

Parsedef "C1 <- (!(V1) letter)";

Parsedef "Mono <- ([Aa][o] / (V2 [i]) / ([Ii] V2) / ([Uu] V2))";

Parsedef "EMono<- ([Aa][o]/[AaEeOo][i])";

Parsedef "NextVowels <- (EMono/V2 &EMono/Mono/V2)";

Parsedef "BrokenMono <- (([a] juncture [o]) / ([aeo] juncture [i]))";

Parsedef "CVVSyll <- (C1 Mono)";

Parsedef "LWunit <- (((CVVSyll (juncture)? V2) / (C1 !(BrokenMono) V2 (juncture)? V2) / [Zz] 'iy' juncture? 'ma'?/(C1 V2)) (juncture2)?)";

Parsedef "LW1 <- (((V2 V2) / (C1 !(BrokenMono) V2 (juncture)? V2) / (C1 V2)) (juncture)?)";

Parsedef "caprule <- ((uppercase / lowercase) (('z' V1/lowercase / juncture caprule?/TAI0))* !(letter))";

Parsedef "InitialCC <- ('bl' / 'br' / 'ck' / 'cl' / 'cm' / 'cn' / 'cp' / 'cr' / 'ct' / 'dj' / 'dr' / 'dz' / 'fl' / 'fr' / 'gl' / 'gr' / 'jm' / 'kl' / 'kr' / 'mr' / 'pl' / 'pr' / 'sk' / 'sl' / 'sm' / 'sn' / 'sp' / 'sr' / 'st' / 'tc' / 'tr' / 'ts' / 'vl' / 'vr' / 'zb' / 'zv' / 'zl' / 'sv' / 'Bl' / 'Br' / 'Ck' / 'Cl' / 'Cm' / 'Cn' / 'Cp' / 'Cr' / 'Ct' / 'Dj' / 'Dr' / 'Dz' / 'Fl' / 'Fr' / 'Gl' / 'Gr' / 'Jm' / 'Kl' / 'Kr' / 'Mr' / 'Pl' / 'Pr' / 'Sk' / 'Sl' / 'Sm' / 'Sn' / 'Sp' / 'Sr' / 'St' / 'Tc' / 'Tr' / 'Ts' / 'Vl' / 'Vr' / 'Zb' / 'Zv' / 'Zl' / 'Sv')";

Parsedef "MaybeInitialCC <- ([bB] juncture? [l] / [bB] juncture? [r] / [cC] juncture? [k] / [cC] juncture? [l] / [cC] juncture? [m] / [cC] juncture? [n] / [cC] juncture? [p] / [cC] juncture? [r] / [cC] juncture? [t] / [dD] juncture? [j] / [dD] juncture? [r] / [dD] juncture? [z] / [fF] juncture? [l] / [fF] juncture? [r] / [gG] juncture? [l] / [gG] juncture? [r] / [jJ] juncture? [m] / [kK] juncture? [l] / [kK] juncture? [r] / [mM] juncture? [r] / [pP] juncture? [l] / [pP] juncture? [r] / [sS] juncture? [k] / [sS] juncture? [l] / [sS] juncture? [m] / [sS] juncture? [n] / [sS] juncture? [p] / [sS] juncture? [r] / [sS] juncture? [t] / [tT] juncture? [c] / [tT] juncture? [r] / [tT] juncture? [s]/ [vV] juncture? [l]/ [vV] juncture? [r] / [zZ] juncture? [b] / [zZ] juncture? [v] / [zZ] juncture? [l] / [sS] juncture? [v])";

Parsedef "NonmedialCC <- (([b] (juncture)? [b]) / ([c] (juncture)? [c]) / ([d] (juncture)? [d]) / ([f] (juncture)? [f]) / ([g] (juncture)? [g]) / ([h] (juncture)? [h]) / ([j] (juncture)? [j]) / ([k] (juncture)? [k]) / ([l] (juncture)? [l]) / ([m] (juncture)? [m]) / ([n] (juncture)? [n]) / ([p] (juncture)? [p]) / ([q] (juncture)? [q]) / ([r] (juncture)? [r]) / ([s] (juncture)? [s]) / ([t] (juncture)? [t]) / ([v] (juncture)? [v]) / ([z] (juncture)? [z]) / ([h] (juncture)? C1) / ([cjsz] (juncture)? [cjsz]) / ([f] (juncture)? [v]) / ([k] (juncture)? [g]) / ([p] (juncture)? [b]) / ([t] (juncture)? [d]) / ([fkpt] (juncture)? [jz]) / ([b] (juncture)? [j]) / ([s] (juncture)? [b]))";

Parsedef "NonjointCCC <- (([c] (juncture)? [d] (juncture)? [z]) / ([c] (juncture)? [v] (juncture)? [l]) / ([n] (juncture)? [d] (juncture)? [j]) / ([n] (juncture)? [d] (juncture)? [z]) / ([d] (juncture)? [c] (juncture)? [m]) / ([d] (juncture)? [c] (juncture)? [t]) / ([d] (juncture)? [t] (juncture)? [s]) / ([p] (juncture)? [d] (juncture)? [z]) / ([g] (juncture)? [t] (juncture)? [s]) / ([g] (juncture)? [z] (juncture)? [b]) / ([s] (juncture)? [v] (juncture)? [l]) / ([j] (juncture)? [d] (juncture)? [j]) / ([j] (juncture)? [t] (juncture)? [c]) / ([j] (juncture)? [t] (juncture)? [s]) / ([j] (juncture)? [v] (juncture)? [r]) / ([t] (juncture)? [v] (juncture)? [l]) / ([k] (juncture)? [d] (juncture)? [z]) / ([v] (juncture)? [t] (juncture)? [s]) / ([m] (juncture)? [z] (juncture)? [b]))";

Parsedef "Oddvowel <- ((juncture)? (((V2 (juncture)? V2 juncture?))* V2) (juncture)?)";

Parsedef "RepeatedVowel <- (([Aa] (juncture)? [a]) / ([Ee] (juncture)? [e]) / ([Oo] (juncture)? [o])/[Ii] juncture [i]/[Uu] juncture [u])";

Parsedef "RepeatedVocalic <- (([Mm] [m]) / ([Nn] [n]) / ([Ll] [l]) / ([Rr] [r]))";

Parsedef "Syllabic <- [lmnr]";

Parsedef "Nonsyllabic <- (!(Syllabic) C1)";

Parsedef "Badfinalpair <- (Nonsyllabic !('mr') !(RepeatedVocalic) Syllabic !((V2 / [y] / RepeatedVocalic)))";

Parsedef "FirstConsonants <- (((!((C1 C1 RepeatedVocalic)) &(InitialCC) (C1 InitialCC)) / (!((C1 RepeatedVocalic)) InitialCC) / ((!(RepeatedVocalic) C1) !([y]))) !(juncture))";

Parsedef "FirstConsonants2 <- (((!((C1 C1 RepeatedVocalic)) &(InitialCC) (C1 InitialCC)) / (!((C1 RepeatedVocalic)) InitialCC) / (!(RepeatedVocalic) C1)) !(juncture))";

Parsedef "VowelSegment <- (NextVowels (!RepeatedVocalic)/ (!(C1 RepeatedVocalic)) RepeatedVocalic)";

Parsedef "VowelSegment2 <- (NextVowels/!(C1 RepeatedVocalic) RepeatedVocalic)";

Parsedef "SyllableA <- ((C1 V2 &C1 !Badfinalpair (FinalConsonant)?(!Syllable FinalConsonant)?) (juncture)?)";

Parsedef "SyllableB <- (FirstConsonants? !RepeatedVowel !(&Mono V2 RepeatedVowel) VowelSegment !(Badfinalpair) (!Syllable FinalConsonant)?(!Syllable FinalConsonant)? (juncture)?)";

Parsedef "Syllable <- SyllableA / SyllableB";

(* this rule is under construction *)

Parsedef "BrokenInitialCC <- &MaybeInitialCC C1 juncture C1 &V2";

Parsedef "JunctureFix <- (InitialCC V2 BrokenInitialCC/(C1 V2)? V2 BrokenInitialCC/C1 V2 !stress juncture InitialCC V2 Letter/C1 BrokenInitialCC V2)";

Parsedef "SyllableFinal1 <- ((FirstConsonants)? !RepeatedVocalic VowelSegment !stress juncture? !V2 (&Syllable/&[y]/!Letter))";

Parsedef "SyllableFinal2 <-  (FirstConsonants)? !RepeatedVocalic VowelSegment !stress juncture? (&[y]/!Letter)";

Parsedef "SyllableFinal2a <- ((FirstConsonants)? !RepeatedVocalic VowelSegment juncture? (&([y])/(!Letter)))";

Parsedef "SyllableFinal2b <- ((FirstConsonants)? !RepeatedVocalic VowelSegment stress (&([y])/(!Letter)))";

Parsedef "StressedSyllable <- (((FirstConsonants)? !RepeatedVowel !(&Mono V2 RepeatedVowel) VowelSegment !(Badfinalpair) (FinalConsonant)?(FinalConsonant)?) stress)";

Parsedef "FinalConsonant <- (!RepeatedVocalic !(NonmedialCC) !(NonjointCCC) C1 !((juncture? V2)))";

Parsedef "Syllable2 <- (((FirstConsonants2)? (VowelSegment2 / [y]) !(Badfinalpair) (!Syllable2 FinalConsonant2)? (!Syllable2 FinalConsonant2)?) (juncture)?)";

Parsedef "FinalConsonant2 <- (!RepeatedVocalic !(NonmedialCC) !(NonjointCCC) C1 !((juncture? V2)))";


Parsedef "Name <- (([ ])* &(((uppercase / lowercase) ((!((C1 (stress)? !(Letter))) Lowercase))* C1 (stress)? !(Letter) (&end / comma / &(period) / &(Name)/&CI))) ((Syllable2)+ (&end / comma / &(period) / &(Name)/&CI)))";

Parsedef "CCSyllableB <- (((FirstConsonants)? RepeatedVocalic !(Badfinalpair) (!Syllable FinalConsonant)? (!Syllable FinalConsonant)?) juncture?)";

Parsedef "BorrowingTail <-  (!JunctureFix !CCSyllableB StressedSyllable (!StressedSyllable CCSyllableB)? !StressedSyllable SyllableFinal1/!CCSyllableB !JunctureFix Syllable (!StressedSyllable CCSyllableB)? !StressedSyllable SyllableFinal2)";

Parsedef "PreBorrowing <- ((!BorrowingTail !StressedSyllable !JunctureFix !(CCSyllableB CCSyllableB) Syllable)* !CCSyllableB BorrowingTail)";

Parsedef "HasCCPair <- (C1? (V2 (!stress juncture)?)+ !(Borrowing) !(&MaybeInitialCC C1 (!stress juncture) (!CCVV) PreBorrowing) stress?)? C1 juncture? C1";

(* I believe this rule is redundant *)

Parsedef "CVCBreak <- C1 V2 juncture? &MaybeInitialCC C1 juncture? &(PreComplex/ComplexTail)";

Parsedef "CCVV <- (&BorrowingTail C1 C1 C1? V2 stress !Mono V2) /(&BorrowingTail C1 C1 C1? V2 juncture? V2 (!Letter/juncture? [y]))";

Parsedef "Borrowing <- &HasCCPair !CVCBreak !CCVV !((C1? (V2 juncture?) (V2 juncture? &V2)+)? V2 juncture? MaybeInitialCC V2) !CCSyllableB ((!BorrowingTail !StressedSyllable !(CCSyllableB CCSyllableB) !JunctureFix Syllable)* !CCSyllableB BorrowingTail)";

Parsedef "PreBorrowingAffix <- ((!StressedSyllable!SyllableFinal2a !(CCSyllableB CCSyllableB)!JunctureFix Syllable)+ (SyllableFinal2a)) juncture? [y] !stress juncture? ([, ] [ ]*)?";

Parsedef "BorrowingAffix <- &HasCCPair !CVCBreak !CCVV !((C1? (V2 juncture?) (V2 juncture? &V2)+)? V2 juncture? MaybeInitialCC V2) !CCSyllableB ((!StressedSyllable!SyllableFinal2a !(CCSyllableB CCSyllableB) !JunctureFix Syllable)+ (SyllableFinal2a)) juncture? [y] !stress juncture? (comma)?";

Parsedef "StressedBorrowingAffix <- &HasCCPair !CVCBreak !CCVV !((C1? (V2 juncture?) (V2 juncture? &V2)+)? V2 juncture? MaybeInitialCC V2) !CCSyllableB((!StressedSyllable!SyllableFinal2a !(CCSyllableB CCSyllableB)!JunctureFix Syllable)* (SyllableFinal2b)) juncture? [y] !stress juncture? ![,]";

Parsedef "yhyphen <-  juncture? [y] !stress juncture? ![y] &letter";

Parsedef "CV <- C1 V2 !stress juncture? !V2";

Parsedef "Cfinal <- ((C1 yhyphen) / (!(NonmedialCC) !(NonjointCCC) C1 !(((juncture)? V2))))";

Parsedef "hyphen <- (!(NonmedialCC) !(NonjointCCC) (([r] !(((juncture)? [r])) !(((juncture)? V2))) / ([n] juncture? &[r]) / ((juncture)? [y] !stress)) (((juncture)? &letter)) !(((juncture)? [y])))";

Parsedef "noyhyphen <- (!(NonmedialCC) !(NonjointCCC) (([r] !(((juncture)? [r])) !(((juncture)? V2))) / ([n] juncture? &[r])) &(((juncture)? &letter)) !(((juncture)? [y])))";

Parsedef "StressedSyllable2 <- (((FirstConsonants)? VowelSegment !(Badfinalpair) (FinalConsonant?) (FinalConsonant)?) stress yhyphen?)";

Parsedef "CVVStressed <- ((C1 &(RepeatedVowel) V2 !stress juncture? !(RepeatedVowel) V2 (noyhyphen)?) juncture? yhyphen?)/ C1 !BrokenMono V2 !stress juncture V2 noyhyphen? stress yhyphen?/ C1 !Mono V2 V2 noyhyphen? stress yhyphen?";

Parsedef "CVVStressed2 <- C1 Mono noyhyphen? stress yhyphen?";

Parsedef "CVV <-  !(C1 V2 stress V2 hyphen? stress)((C1 !(BrokenMono) V2 (juncture)? !(RepeatedVowel) V2 (noyhyphen)?) (juncture)? !V2 yhyphen?)";

Parsedef "CVVFinal1 <- C1 !BrokenMono V2 stress !RepeatedVowel V2 !stress juncture? !V2";

Parsedef "CVVFinal2 <- ((C1 !(Mono) V2 V2) / (C1 !(BrokenMono) V2 juncture !RepeatedVowel V2)) !Letter";

Parsedef "CVVFinal5 <- ((C1 !(Mono) V2 V2) / (C1 !(BrokenMono) V2 juncture V2)) &(juncture? [y])";

Parsedef "CVVFinal3 <- C1 &Mono V2 V2 !stress juncture? !V2";

Parsedef "CVVFinal4 <- C1 Mono !Letter";

Parsedef "CVC <- ((C1 V2 Cfinal) (juncture)?)";

Parsedef "CVCStressed <- C1 V2 !(NonmedialCC) !(NonjointCCC) C1 stress !V2 yhyphen?";

Parsedef "CCV <- (InitialCC !RepeatedVowel V2 juncture? !V2 yhyphen?)";

Parsedef "CCVStressed <- InitialCC !RepeatedVowel V2 stress !V2 yhyphen?";

Parsedef "CCVFinal1 <- InitialCC !RepeatedVowel V2 !stress juncture? !V2";

Parsedef "CCVFinal2 <- InitialCC V2 !Letter";


Parsedef "CCVCVMedial <- InitialCC V2 juncture? C1 [y] !stress juncture? &letter";

Parsedef "CCVCVMedialStressed <- CCV stress C1 [y] !stress juncture? &letter";

Parsedef "CCVCVFinal1 <- InitialCC V2 stress CV";

Parsedef "CCVCVFinal2 <- InitialCC V2 juncture? CV !Letter";

Parsedef "CCVCVY <- InitialCC V2 juncture? CV [y]";

Parsedef "CVCCVMedial <- C1 V2 (juncture &InitialCC)? !NonmedialCC C1 juncture? C1 [y] !stress juncture? &(letter)";

Parsedef "CVCCVMedialStressed <- (C1 V2 (stress &InitialCC) !NonmedialCC C1 C1 [y] !stress juncture? &(letter)/C1 V2  !NonmedialCC C1 stress C1 [y] !stress juncture? &(letter))";

Parsedef "CVCCVFinal1a <- C1 V2 stress InitialCC V2 !stress juncture? !V2";

Parsedef "CVCCVYa <- C1 V2 juncture? InitialCC V2 !stress juncture? [y]";

Parsedef "CVCCVFinal1b <- C1 V2 !NonmedialCC C1 stress CV";

Parsedef "CVCCVYb <- C1 V2 !NonmedialCC C1 juncture? CV [y]";

Parsedef "CVCCVFinal2 <- C1 V2 (juncture &InitialCC)? !NonmedialCC C1 juncture? CV !Letter";

Parsedef "FiveLetterY <- CCVCVY / CVCCVYa / CVCCVYb";

Parsedef "GenericFinal <- CVVFinal3/CVVFinal4/CCVFinal1/CCVFinal2";

Parsedef "GenericTerminalFinal <- CVVFinal4/CCVFinal2";

Parsedef "Affix1 <- (CCVCVMedial / CVCCVMedial / CCV / CVV / CVC)";

Parsedef "Peelable <- &PreBorrowingAffix !CVVFinal1 !CVVFinal5 Affix1 (!Affix1/&(&PreBorrowingAffix !CVVFinal1 !CVVFinal5 Affix1 !PreBorrowingAffix!Affix1)/Peelable)";

Parsedef "FiveLetterFinal <- CCVCVFinal1/ CCVCVFinal2 /CVCCVFinal1a/CVCCVFinal1b/CVCCVFinal2";

Parsedef "Peelable2 <- &PreBorrowing !CVVFinal1 !CVVFinal2 !CVVFinal5 !FiveLetterFinal Affix1 !FiveLetterFinal (!Affix1/&(&PreBorrowing !FiveLetterFinal !CVVFinal1 !CVVFinal2 !CVVFinal5 Affix1  !(PreBorrowing)!FiveLetterFinal!Affix1)/Peelable2)";

Parsedef "Affix <- (!Peelable !Peelable2 Affix1)/!FiveLetterY BorrowingAffix";

Parsedef "Affix2 <- !StressedSyllable2!CVVStressed Affix";

Parsedef "ComplexTail <- (Affix GenericTerminalFinal/ !(!Peelable Affix1) !FiveLetterY StressedBorrowingAffix GenericFinal/ CCVCVMedialStressed GenericFinal/CVCCVMedialStressed GenericFinal/CCVStressed GenericFinal/CVCStressed GenericFinal/CVVStressed GenericFinal/CVVStressed2 GenericFinal/Affix2 CVVFinal1/Affix2 CVVFinal2/CCVCVFinal1/ CCVCVFinal2 /CVCCVFinal1a/CVCCVFinal1b/CVCCVFinal2/!(CVVStressed/StressedSyllable2) Affix !(!Peelable2 Affix1) Borrowing !(juncture? [y]))";

Parsedef "Primitive <-(CCVCVFinal1/CCVCVFinal2/CVCCVFinal1a/CVCCVFinal1b/CVCCVFinal2)";

Parsedef "PreComplex <- (ComplexTail/(!(CVCStressed/CCVStressed/CVVStressed/ComplexTail/StressedSyllable2) Affix) PreComplex)";

Parsedef "Complex <- !(C1 V2 juncture? V2? juncture? CVV) !(C1 V2 !stress juncture? (V2)? !stress juncture? (Primitive/PreComplex/Borrowing/CVV)) !(C1 V2 juncture? &MaybeInitialCC C1 juncture? &(PreComplex/ComplexTail)) PreComplex";

Parsedef "Predicate <- (&(caprule) ((Primitive / Complex / Borrowing) ([ ]* Z AO ', '?[ ]* Predicate)?)/ C1 V2 V2? [ ]* Z AO comma? [ ]* Predicate) !(juncture? [y])";

Parsedef "Fourvowels <- C1 V2 juncture? V2 juncture? V2 juncture? V2";

Parsedef "B <- !Predicate !Fourvowels [Bb]";

Parsedef "C <- !Predicate !Fourvowels  [Cc]";

Parsedef "D <- !Predicate !Fourvowels  [Dd]";

Parsedef "F <- !Predicate !Fourvowels  [Ff]";

Parsedef "G <- !Predicate !Fourvowels  [Gg]";

Parsedef "H <- !Predicate !Fourvowels  [Hh]";

Parsedef "J <- !Predicate!Fourvowels  [Jj]";

Parsedef "K <- !Predicate!Fourvowels  [Kk]";

Parsedef "L <- !Predicate!Fourvowels  [Ll]";

Parsedef "M <- !Predicate!Fourvowels  [Mm]";

Parsedef "N <- !Predicate!Fourvowels  [Nn]";

Parsedef "P <- !Predicate!Fourvowels  [Pp]";

Parsedef "R <- !Predicate!Fourvowels  [Rr]";

Parsedef "S <- !Predicate!Fourvowels  [Ss]";

Parsedef "T <- !Predicate!Fourvowels  [Tt]";

Parsedef "V <- !Predicate!Fourvowels  [Vv]";

Parsedef "Z <- !Predicate!Fourvowels  [Zz]";

Parsedef "a <- ([Aa]  (juncture2)? !V2)";

Parsedef "e <- ( [Ee] (juncture2)?) !V2";

Parsedef "i <- ([Ii]  (juncture2)? !V2)";

Parsedef "o <- ([Oo]  (juncture2)? !V2)";

Parsedef "u <- ([Uu]   (juncture2)? !V2)";

Parsedef "AA <- ([Aa] (juncture)? [a] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "AE <- ([Aa] (juncture)? [e] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "AI <- ([Aa] [i] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "AO <- ([Aa] [o] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "AU <- ([Aa] (juncture)? [u] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "EA <- ([Ee] (juncture)? [a] (juncture2)?(&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "EE <- ([Ee] (juncture)? [e] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "EI <- ([Ee] [i] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "EO <- ([Ee] (juncture)? [o] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "EU <- ([Ee] (juncture)? [u] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "IA <- ([Ii] (juncture)? [a] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "IE <- ([Ii] (juncture)? [e] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "II <- ([Ii] (juncture)? [i] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "IO <- ([Ii] (juncture)? [o] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "IU <- ([Ii] (juncture)? [u] (juncture2)? (&(V2 juncture?  !V2)/!Oddvowel))";

Parsedef "OA <- ([Oo] (juncture)? [a] (juncture2)? (&(V2 juncture?  !V2)/!Oddvowel))";

Parsedef "OE <- ([Oo] (juncture)? [e] (juncture2)? (&(V2 juncture?  !V2)/!Oddvowel))";

Parsedef "OI <- ([Oo] [i] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "OO <- ([Oo] (juncture)? [o] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "OU <- ([Oo] (juncture)? [u] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "UA <- ([Uu] (juncture)? [a] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "UE <- ([Uu] (juncture)? [e] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "UI <- ([Uu] (juncture)? [i] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "UO <- ([Uu] (juncture)? [o] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "UU <- ([Uu] (juncture)? [u] (juncture2)? (&(V2 juncture? !V2)/!Oddvowel))";

Parsedef "__LWinit <- (([ ])* !(Predicate) &(caprule))";

Parsedef "__LWbreak <- !Oddvowel !(!([ ]* Predicate) !(&nonamemarkers Name) (A / ICI /ICA/IGE/I)) (comma &(!(&nonamemarkers Name) (V1/A)))?";

Parsedef "CANCELPAUSE <- (comma ('y' comma / C UU __LWbreak))";

Parsedef "PAUSE <- (!(CANCELPAUSE) comma !((A / ICI / ICA / IGE / I)) !((&(V2) Predicate))) !([ ]* &nonamemarkers Name)";

Parsedef "TAI0 <- !Predicate (((V1 (juncture)? !(Predicate) !(Name) M a(juncture)?) / (V1 (juncture)? !(Predicate) !(Name) F i (juncture)?) / (C1 AI u?) / (C1 EI u?) / (C1 EO) / (Z [i] (juncture)? V1 (juncture)? (M a)? (juncture)?)) (!(Oddvowel)/(![ ]&TAI0)))";


Parsedef "NOI <- N OI !Oddvowel";

Parsedef "A0 <- !Predicate !(Mono/BrokenMono) ((([AEOUaeou]) / (H a)) (juncture)? !V2 !(Oddvowel))";


Parsedef "A <- (__LWinit !TAI0 (((N [u]) &((u / N [o]))))? ((N [o]))? A0 ((NOI))? !([ ]+ PANOPAUSES comma !(A / ICI /ICA/IGE/I)) !(PANOPAUSES [ ]) ((PANOPAUSES)(F i/comma))? !(Oddvowel))";

Parsedef "ANOFI <- (__LWinit !TAI0 (((N [u]) &((u / N [o]))))? ((N [o]))? A0 ((NOI))? ((PANOPAUSES))? !(Oddvowel))";

Parsedef "A1 <- (A __LWbreak)";

Parsedef "ACI <- (ANOFI  C i __LWbreak)";

Parsedef "AGE <- (ANOFI G e __LWbreak)";


Parsedef "CA0 <- ((N o)? ((C a) / (C e) / (C o) / (C u) / (Z e) / (C i H a)) !(Oddvowel)) ((NOI))?";

Parsedef "CA1 <- ((((N u) &((C u / N o))))? ((N o))? CA0 !([ ]+ PANOPAUSES comma !(A / ICI /ICA/IGE/I)) !(PANOPAUSES [ ]) ((PANOPAUSES)(F i/comma))? !(Oddvowel))";

Parsedef "CA1NOFI <- ((((N u) &((C u / N o))))? ((N o))? CA0 ((PANOPAUSES))? !(Oddvowel))";


Parsedef "CA <- (__LWinit &(caprule) CA1 __LWbreak)";

Parsedef "ZE2 <- (__LWinit (Z e) __LWbreak)";

Parsedef "I <- (__LWinit !TAI0 i !([ ]+ PANOPAUSES comma !(A / ICI /ICA/IGE/I)) !(PANOPAUSES [ ]) ((PANOPAUSES)(F i/comma))? __LWbreak)";

Parsedef "ICA <- (__LWinit !(Predicate) i ((H a) / CA1) __LWbreak)";

Parsedef "ICI <- (__LWinit i (CA1NOFI)? C i __LWbreak)";

Parsedef "IGE <- (__LWinit i (CA1NOFI)? G e __LWbreak)";

Parsedef "KA0 <-  (((K a) / (K e) / (K o) / (K u) / (K i H a)) !(Oddvowel))";

Parsedef "KOU <- (((K OU) / (M OI) / (R AU) / (S OA)) !(Oddvowel))";

Parsedef "KOU1 <- (((N u N o)/ (N u) / (N o)) KOU)";

Parsedef "KA <- (__LWinit &(caprule) (((((N u) &(K u)))? KA0) / ((KOU1 / KOU) K i)) ((NOI))? __LWbreak)";

Parsedef "KI <- (__LWinit (K i) ((NOI))? __LWbreak)";

Parsedef "BadNIStress <- (C1 V2 V2? stress (M a)? (M OA)? NI RA/ C1 V2 stress V2 (M a)? (M OA)? NI RA)"; 

Parsedef "NI0 <- !BadNIStress (((K UA) / (G IE) / (G IU) / (H IE) / (H IU) / (K UE) / (N EA) / (N IO) / (P EA) / (P IO) / (S UU) /  (S UA) / (T IA) / (Z OA) / (Z OO) / (H o) / (N i) / (N e) / (T o) / (T e) / (F o) / (F e) / (V o) / (V e) / (P i) / (R e) / (R u) / (S e) / (S o) / (H i)) !(Oddvowel))";

Parsedef "SA <- !BadNIStress (S a / S i / S u) (NOI)?  !Oddvowel";

Parsedef "RA <- !BadNIStress (((R a) / (R i) / (R o)) !(Oddvowel))";

Parsedef "NI1 <- ((NI0 (!BadNIStress M a)?  (!BadNIStress M OA NI0*)? !Oddvowel) (comma2 !(NI RA) &NI)?)";

Parsedef "RA1 <- ((RA (!BadNIStress M a)? (!BadNIStress M OA NI0*)? !Oddvowel) (comma2 !(NI RA) &NI)?)";

Parsedef "IE1 <- (__LWinit IE __LWbreak)";

Parsedef "NI2 <- (SA? (NI1+/RA1)/SA) NOI? (CA0 (SA? (NI1+/RA1)/SA) NOI?)*";

Parsedef "NI <- (__LWinit (IE1)? NI2 (&(M UE) Acronym (comma/&end/&period) !(C u))?  (C u)? !(Oddvowel))";

Parsedef "mex <- (__LWinit NI __LWbreak)";

Parsedef "CI <- (__LWinit (C i) __LWbreak)";

Parsedef "Acronym <- (([ ])* &caprule (M UE/TAI0/[Zz] V2 !V2) ((NI1 / TAI0 / ([Zz] V2 (!(V2) / ([Zz] &(V2))))))+)";

Parsedef "TAI <- (__LWinit (TAI0 / ((G AO) !badspaces !(V2) ([ ])* (Name / Predicate / (C1 V2 V2 (!(Oddvowel) / &(TAI0))) / (C1 V2 (!(Oddvowel) / &(TAI0)))))) __LWbreak)";

Parsedef "DA0 <- (((T AO) / (T IO) / (T UA) / (M IO) / (M IU) / (M UO) / (M UU) / (T OA) / (T OI) / (T OO) / (T OU) / (T UO) / (T UU) / (S UO) / (H u) / (B a) / (B e) / (B o) / (B u) / (D a) / (D e) / (D i) / (D o) / (D u) / (M i) / (T u) / (M u) / (T i) / (T a) / (M o)) !(Oddvowel))";

Parsedef "DA1 <- ((TAI0 / DA0) ((C i ![ ] NI0))? !(Oddvowel))";

Parsedef "DA <- (__LWinit DA1 __LWbreak)";

Parsedef "PA0 <-  (((G IA) / (G UA) /P AU/ (P IA) / (P UA) / (N IA) / (N UA) / (B IU) / (F EA) / (F IA) / (F UA) / (V IA) / (V II) / (V IU) / (C IU) / (C OI) / (D AU) / (D II) / (D UO) / (F OI) / (F UI) / (G AU) / (H EA) / (K AU) / (K II) / (K UI) / (L IA) / (L UI) / (M IA) / (M OU) / (N UI) / (P EU) / (R OI) / (R UI) / (S EA) / (S IO) / (T IE) / (V a) / (V i) / (V u) / (P a) / (N a) / (F a) / (V a) / KOU) !(Oddvowel))";

Parsedef "PANOPAUSES <-  (((!(PA0) NI))?  ((KOU1 / PA0))+ (((CA0) ((KOU1 / PA0))+))* ZI? !(Oddvowel))";

Parsedef "PA3 <- __LWinit PANOPAUSES __LWbreak freemod?";

Parsedef "PA <-  (!PA0 NI)? (KOU1/PA0)+ ((comma2? CA0 comma2?/comma2 !mod1a) (KOU1/PA0)+)* ZI? !(Oddvowel)";

Parsedef "PA2 <- ((__LWinit PA __LWbreak) (freemod)?)";

Parsedef "GA <- (__LWinit (G a) __LWbreak)";

Parsedef "PA1 <- (((PA2 / (GA)) __LWbreak) (freemod)?)";

Parsedef "ZI <-  ((Z i) / (Z a) / (Z u))";


Parsedef "LE <- (__LWinit ((L EA) / (L EU) / (L OE) / (L EE) / (L AA) / (L e) / (L o) / (L a) !badspaces) ((DA1 / TAI0))? !([ ]+PA) (PA)? __LWbreak)";

Parsedef "LEFORPO <- (__LWinit ((L e) / (L o) / NI2) __LWbreak)"; 

Parsedef "LIO <- (__LWinit (L IO) __LWbreak)";

Parsedef "LAU <- (__LWinit ((L AU)) __LWbreak)";

Parsedef "LOU <- (__LWinit ((L OU)) __LWbreak)";


Parsedef "LUA <- (__LWinit ((L UA)) __LWbreak)";
Parsedef "LUO <- (__LWinit ((L UO)) __LWbreak)";

Parsedef "ZEIA <- __LWinit Z EI a __LWbreak";

Parsedef "ZEIO <- __LWinit Z EI o __LWbreak";


Parsedef "LI1 <- (L i)";

Parsedef "LU1 <- (L u)";

Parsedef "Quotemod <- (((Z a) / (Z i)) !(Oddvowel))";


Parsedef "LI <- (__LWinit LI1 !(V2) (Quotemod)? ((([,])? ([ ])+))? utterance0 (', ')? __LWinit LU1 __LWbreak)/(__LWinit LI1 !(V2) (Quotemod)? comma name comma? __LWinit LU1 __LWbreak)";

Parsedef "stringnospaces <- [,]?(([ ])+ ((!([ ,]) !(period) .))+) ([,]? [ ]+ &letter/&period/&end)";

Parsedef "stringnospacesclosed <- [,]?(([ ])+ ((!([ ,]) !(period) .))+) ([,] [ ]+/&period/&end)";

Parsedef "stringnospacesclosedblock <- (stringnospaces (!([y] stringnospacesclosed) [y] stringnospaces)* ([y] stringnospacesclosed) / stringnospacesclosed)";

Parsedef "LAO1 <- (L AO)";

Parsedef "LAO <- [ ]* (LAO1 stringnospaces ([y] stringnospaces)*)";

Parsedef "LIE1 <- (L IE)";

Parsedef "CII1 <- ((C II) / [y])";

Parsedef "LIE <- [ ]* LIE1 (![ ] NI0)? Quotemod? stringnospaces (CII1 (![ ] NI0)? stringnospaces)*";

Parsedef "LW <- (&(caprule) (((!(Predicate) V2 V2))+ / ((!(Predicate) (V2)? ((!(Predicate) LWunit))+) / V2)))";

Parsedef "LIU0 <-  ((L IU) / (N IU))";

Parsedef "LIU1 <- (__LWinit ((LIU0 !badspaces !(V2) (Quotemod)? ((([,])? ([ ])+))? (Name /Predicate comma?/CCV comma?/ (LW (([,] ([ ])+ !([,])) / &(period) / &end / &((([ ])* Predicate)))))) / (L II (Quotemod)? TAI __LWbreak)))";


Parsedef "SUE <- (__LWinit ((S UE) / (S AO)) stringnospaces)";


Parsedef "CUI <- (__LWinit (C UI) __LWbreak)";

Parsedef "GA2 <- (__LWinit (G a) __LWbreak)";

Parsedef "GE <- (__LWinit (G e) __LWbreak)";

Parsedef "GEU <- (__LWinit ((C UE) / (G EU)) __LWbreak)";

Parsedef "GI <- (__LWinit ((G i) / (G OI)) __LWbreak)";

Parsedef "GO <- (__LWinit (G o) __LWbreak)";

Parsedef "GU <- (__LWinit (G u) __LWbreak)";

Parsedef "GUI <- (__LWinit (G UI) __LWbreak)";

Parsedef "GUO <- (__LWinit (G UO) __LWbreak)";

Parsedef "GUOA <- (__LWinit (G UO Z? a) __LWbreak)";

Parsedef "GUOE <- (__LWinit (G UO  e) __LWbreak)";

Parsedef "GUOI <- (__LWinit (G UO Z? i) __LWbreak)";

Parsedef "GUOO <- (__LWinit (G UO  o) __LWbreak)";

Parsedef "GUOU <- (__LWinit (G UO Z? u) __LWbreak)";

Parsedef "GUU <- (__LWinit (G UU) __LWbreak)";

Parsedef "GUE <- (__LWinit (G UE) __LWbreak)";

Parsedef "JE <- (__LWinit (J e) __LWbreak)";

Parsedef "JUE <- (__LWinit (J UE) __LWbreak)";

Parsedef "JI <- (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a)/ N u J i) __LWbreak)";

Parsedef "JIO <- (__LWinit ((J IO) / (J AO)) __LWbreak)";


Parsedef "DIO <- (__LWinit ((B EU) / (C AU) / (D IO) / (F OA) / (K AO) / (J UI) / (N EU) / (P OU) / (G OA) / (S AU) / (V EU) / (Z UA) / (Z UE) / (Z UI) / (Z UO) / (Z UU) / (L AE) / (L UE)) __LWbreak)";

(* not used yet, actual case markers *)

Parsedef "DIO2 <- (__LWinit ((B EU) / (C AU) / (D IO) / (F OA) / (K AO) / (J UI) / (N EU) / (P OU) / (G OA) / (S AU) / (V EU) / (Z UA) / (Z UE) / (Z UI) / (Z UO) / (Z UU)) __LWbreak)";

Parsedef "ME <- (__LWinit ((M EA) / (M e)) __LWbreak)";

Parsedef "NU0 <-  (((N UO) / (F UO) / (J UO) / (N u) / (F u) / (J u)) !(Oddvowel))";


Parsedef "NU <- (__LWinit ((NU0 !([ ]+(NI0/RA)) (NI0/RA)? freemod?))+ __LWbreak)";

Parsedef "PO1 <- (__LWinit ((P o) / (P u) / (Z o)) !(Oddvowel))";

Parsedef "PO1A <- (__LWinit ((P OI  a) / (P UI  a) / (Z OI  a)/P o Z a/P u Z a/Z o Z a) !(Oddvowel))";

Parsedef "PO1E <- (__LWinit ((P OI  e) / (P UI  e) / (Z OI  e)) !(Oddvowel))";

Parsedef "PO1I <- (__LWinit ((P OI  i) / (P UI  i) / (Z OI  i)/P o Z i/P u Z i/Z o Z i) !(Oddvowel))";

Parsedef "PO1O <- (__LWinit ((P OI  o) / (P UI  o) / (Z OI  o)) !(Oddvowel))";

Parsedef "PO1U <- (__LWinit ((P OI  u) / (P UI  u) / (Z OI  u)/P o Z u/P u Z u /Z o Z u) !(Oddvowel))";

Parsedef "POSHORT1 <- (__LWinit ((P OI) / (P UI) / (Z OI)) !(Oddvowel))";


Parsedef "PO <- (__LWinit PO1 __LWbreak)";

Parsedef "POA <- (__LWinit PO1A __LWbreak)";

Parsedef "POE <- (__LWinit PO1E __LWbreak)";

Parsedef "POI <- (__LWinit PO1E __LWbreak)";

Parsedef "POO <- (__LWinit PO1O __LWbreak)";

Parsedef "POU <- (__LWinit PO1U __LWbreak)";

Parsedef "POSHORT <- (__LWinit POSHORT1 __LWbreak)";

Parsedef "DIE <- (__LWinit ((D IE) / (F IE) / (K AE) / (N UE) / (R IE)) __LWbreak)";

Parsedef "HOI <- (__LWinit ((H OI)/L OI/L OA/S IA/S IE/S IU)  __LWbreak)";

Parsedef "JO <- (__LWinit ((NI0 / RA))? (J o) __LWbreak)";

Parsedef "KIE <- (__LWinit (K IE) __LWbreak)";

Parsedef "KIU <- (__LWinit (K IU) __LWbreak)";

Parsedef "SOI <- (__LWinit (S OI) __LWbreak)";

Parsedef "UI0 <- ((UA / UE / UI / UO / UU / OA / OE / OI / OU / OO/ IA / II / IO / IU / EA /EE/ EI / EO / EU /AA/ AE / AI / AO / AU / (B EA) / (B UO) / (C EA) / (C IA) / (C OA) / (D OU) / (F AE) / (F AO) / (F EU) / (G EA) / (K UO) / (K UU) / (R EA) / (N AO) / (N IE) / (P AE) / (P IU) / (S AA) / (S UI) / (T AA) / (T OE) / (V OI) / (Z OU) / (L OI) / (L OA) / (S IA) / (S II) / (T OE) / (S IU) / (C AO) / (C EU) / (S IE)/S EU) !(Oddvowel))";

Parsedef "NOUI <- ((__LWinit N [o] [ ]*  UI0 __LWbreak) / (__LWinit UI0 NOI __LWbreak))";

Parsedef "UI1 <- (__LWinit (UI0/ (NI  F i)) __LWbreak)";

Parsedef "HUE <- (__LWinit (H UE) __LWbreak)";

Parsedef "NO1 <- (__LWinit !(KOU1) !(NOUI) (N o) !(__LWinit KOU) !((([ ])* (JIO / JI))) __LWbreak)";

Parsedef "AcronymicName <- Acronym (&end / ',' / &(period) / &(Name)/&CI)";

Parsedef "DJAN <- (Name/AcronymicName)";

Parsedef "BI <- (__LWinit (N u)? ((B IA) / (B IE) / (C IE) / (C IO) / (B IA) / (B [i])) __LWbreak)";

Parsedef "LWPREDA <- (((H e) / (D UA) / (D UI) / (B UA) / (B UI)) !(Oddvowel))";

Parsedef "PREDA <- (([ ])* &(caprule) (Predicate / LWPREDA / (!([ ]) NI RA)) !(!(&nonamemarkers Name) (A / ICI / ICA / IGE / I)) (',' ([ ])+ &(!(&nonamemarkers Name) (V1/A)))?)";

Parsedef "guo <- PAUSE? (GUO/GU) freemod?";

Parsedef "guoa <- PAUSE? (GUOA/GU) freemod?";

Parsedef "guoe <- PAUSE? (GUOE/GU) freemod?";

Parsedef "guoi <- PAUSE? (GUOI/GU) freemod?";

Parsedef "guoo <- PAUSE? (GUOO/GU) freemod?";

Parsedef "guou <- PAUSE? (GUOU/GU) freemod?";


Parsedef "gui <- PAUSE?  (GUI / GU) freemod?";

Parsedef "gue <- PAUSE? (GUE/GU) freemod?";

Parsedef "guu <- PAUSE? (GUU/GU) freemod?";

Parsedef "geu <- GEU";

Parsedef "gap <- PAUSE?  GU freemod?";

Parsedef "juelink <- (JUE (freemod)? term)";

Parsedef "links1 <- (juelink (freemod? juelink)* (gue)?)";

Parsedef "links <- ((links1 / (KA (freemod)? links freemod? KI (freemod)? links1)) ((freemod? A1 (freemod)? links1))*)";

Parsedef "jelink <- (JE (freemod)? term)";

Parsedef "linkargs1 <- (jelink freemod? (links)? (gue)?)";

Parsedef "linkargs <- ((linkargs1 / (KA (freemod)? linkargs freemod? KI (freemod)? linkargs1)) ((freemod? A1 (freemod)? linkargs1))*)";

Parsedef "abstractpred <- (POA freemod? uttAx  guoa?/ POA freemod? sentence  guoa?/  POE freemod? uttAx  guoe?/ POE freemod? sentence  guoe?/  POI freemod? uttAx  guoi?/ POI freemod? sentence  guoi?/POO freemod? uttAx  guoo?/ POO freemod? sentence  guoo?/  POU freemod? uttAx  guou?/ POU freemod? sentence  guou?/  PO freemod? uttAx  guo?/ PO freemod? sentence  guo?)";

Parsedef "predunit1 <- ((SUE / (NU (freemod)? GE (freemod)? despredE (freemod? (geu) comma?)?) / (NU (freemod)? PREDA) / (comma? GE (freemod)? descpred (freemod? (geu) comma?)?) / abstractpred / (ME (freemod)? argument (gap)?) / PREDA) (freemod)?)";

Parsedef "predunit2 <- (((NO1 (freemod)?))* predunit1)";

Parsedef "NO2 <- (!(predunit2) NO1)";

Parsedef "predunit3 <- ((predunit2 freemod? linkargs) / predunit2)";

Parsedef "predunit <- (((POSHORT (freemod)?))? predunit3)";

Parsedef "kekpredunit <- (((NO1 (freemod)?))* KA (freemod)? predicate freemod? KI (freemod)? predicate)";

Parsedef "despredA <- (predunit/kekpredunit) (freemod? CI freemod? (predunit/kekpredunit))*";

Parsedef "despredB <- ((!(PREDA) CUI (freemod)? despredC freemod? CA (freemod)? despredB) / despredA)";

Parsedef "despredC <- despredB (freemod? despredB)*";

Parsedef "despredD <- (despredB ((freemod? CA (freemod)? despredB))*)";

Parsedef "despredE <- despredD (freemod? despredD)*";

Parsedef "descpred <- ((despredE freemod? GO (freemod)? descpred) / despredE)";

Parsedef "senpred1 <- predunit (freemod? CI freemod? predunit)*";

Parsedef "senpred2 <- (senpred1 / (CUI (freemod)? despredC freemod? CA (freemod)? despredB))";

Parsedef "senpred3 <- (senpred2 ((freemod? CA (freemod)? despredB))*)";

Parsedef "senpred4 <- (senpred3 (freemod? despredD)*)";

Parsedef "sentpred <- ((senpred4 freemod? GO (freemod)? barepred) / senpred4)";

Parsedef "mod1a <- PA3 argument gap?";

Parsedef "mod1 <- ((PA3 argument (gap)?) / (PA2 !(barepred) (gap)?))";

Parsedef "kekmod <- (((NO1 (freemod)?))* (KA (freemod)? modifier freemod? KI (freemod)? mod))";

Parsedef "mod <- (mod1 / (((NO1 (freemod)?))* mod1) / kekmod)";

Parsedef "modifier <- ((mod / kekmod) ((A1 (freemod)? mod))*)";

Parsedef ("maybebreak <- V1 stress? ' ' !([ ]* V1)");

Parsedef("realbreak <- !maybebreak letter stress? ([,]? ' '/period/&end)");

Parsedef("consonantbreak <- C1 stress? ([,]? ' '/period/&end)");

Parsedef("badspaces <- !([,] ' ')(!(maybebreak/realbreak).)* maybebreak (!realbreak .)* consonantbreak");

(* Parsedef "badspaces <- !([,] ' ')(!((V1 [*']? ' ' !([ ]* V1))/C1 stress?([,]? ' '/period/!.)).)* V1 stress? ' '!([ ]* V1) (!(. stress?(([,]' ')/period/!.)).)* C1 stress?([,] ' '/period/!.)"; *)

Parsedef "namemarker <- (([ ])* ((L a) / (H OI) / (L OI)/ (L OA)/ (S IE)/ S IA/ S IU/ (C i) / (H UE) / (L IU) / (G AO))) !badspaces";

Parsedef "nonamemarkers <- [ ]* ((!(namemarker DJAN)) Letter)+ !Letter";

Parsedef "CI0 <- [Cc] i (&([ ]*C1)/CANCELPAUSE)";

Parsedef "name <- ((DJAN (((([ ])* freemod? CI0 DJAN) /  ([ ]* freemod? CI !badspaces (freemod)? predunit) !((&nonamemarkers) (!AcronymicName) DJAN) / (([ ])* freemod? CI ((',' ([ ])+)) DJAN)/(&(nonamemarkers) (!AcronymicName) DJAN)))*) (freemod)?)";

Parsedef "LA0 <- ([Ll] a) !badspaces";

Parsedef "LANAME <- (([ ])* LA0 (CANCELPAUSE/[ ]* &C1) name (gap)?)";

Parsedef "LANAME2 <- (([ ])* LA0 ((',' ([ ])+)/[ ]*&V1) name (gap)?)";

Parsedef "HOI0 <- (([Hh] OI) /([Ll] OI)/[Ll] OA/[Ss] IA/[Ss] IE/[Ss] IU) !badspaces";

Parsedef "voc <- ( (([ ])* HOI0 (CANCELPAUSE/[ ]*&C1)  name (gap)?) /  (HOI !badspaces (freemod)? descpred ((comma? CI comma?/comma &nonamemarkers !AcronymicName) name)? (gap)?) / (HOI !badspaces (freemod)? argument (gap)?) /(([ ])* HOI0 ((',' ([ ])+)/[ ]*&V1) name (gap)?) /H OI stringnospacesclosedblock)";

Parsedef "descriptn <- (!(LANAME) (LAU wordset1/LOU  wordset2/(LE (freemod)? descpred) / (LE (freemod)? mex (freemod)? descpred) / (LE (freemod)? arg1 descpred) / (LE (freemod)? mex (freemod)? arg1a) / (GE (freemod)? mex (freemod)? descpred)))";

Parsedef "abstractn <- (LEFORPO freemod? POA freemod? uttAx guoa? / LEFORPO freemod? POA freemod? sentence guoa? / LEFORPO freemod? POE freemod? uttAx guoe? / LEFORPO freemod? POE freemod? sentence guoe? /LEFORPO freemod? POI freemod? uttAx guoi? / LEFORPO freemod? POI freemod? sentence guoi? / LEFORPO freemod? POO freemod? uttAx guoo? / LEFORPO freemod? POO freemod? sentence guoo? / LEFORPO freemod? POU freemod? uttAx guou? / LEFORPO freemod? POU freemod? sentence guou?/LEFORPO freemod? PO freemod? uttAx guo? / LEFORPO freemod? PO freemod? sentence guo?)";

Parsedef "arg1 <- (abstractn / (LIO (freemod)? descpred (gap)?) / (LIO (freemod)? term (gap)?) / (LIO (freemod)? mex (gap)?) /LIO stringnospaces/ LAO / LANAME / (descriptn (freemod)? ((comma? CI comma?/comma &nonamemarkers !AcronymicName) name)? (gap)?) / LANAME2/ LIU1 / LIE / LI)";

Parsedef "arg1a <- ((DA / TAI / arg1 / (GE (freemod)? arg1a)) (freemod)?)";

Parsedef "argmod1 <- (((__LWinit (N o) ([ ])*))? ((JI (freemod)? predicate (gui)?) / (JIO (freemod)? sentence (gui)?) / (JIO (freemod)? uttAx (gui)?) / (JI (freemod)? modifier gui?) / (JI (freemod)? argument gui?)))";

Parsedef "argmod <- (argmod1 ((A1 (freemod)? argmod1))*)";

Parsedef "arg2 <- (arg1a ((argmod (gap)?))*)";

Parsedef "arg3 <- (arg2 / (mex (freemod)? arg2))";

Parsedef "indef1 <- (mex (freemod)? descpred)";

Parsedef "indef2 <- (indef1 (gap)? ((argmod (gap)?))*)";

Parsedef "indefinite <- indef2";

Parsedef "arg4 <- ((arg3 / indefinite) ((ZE2 (freemod)? (arg3 / indefinite)))*)";

Parsedef "arg5 <- (arg4 / (KA (freemod)? argument freemod? KI (freemod)? argx))";

Parsedef "arg6 <- (arg5 / (DIO (freemod)? arg6) / (IE1 (freemod)? arg6))";

Parsedef "argx <- (((NO1 (freemod)?))* arg6)";

Parsedef "arg7 <- (argx ((ACI (freemod)? arg7))?)";

Parsedef "arg8 <- (!(GE) (arg7 ((A1 (freemod)? arg7))*))";

Parsedef "argument <- (( (arg8 AGE (freemod)? argument) / arg8) ((GUU (freemod)? argmod (gap)?))*)";

Parsedef "term <- (argument / modifier)";

Parsedef "terms <- term ((freemod)? term)*";

Parsedef "modifiers <- modifier (freemod? modifier)*";


Parsedef "word <- (arg1a/indef2)";

Parsedef "words1 <- word (ZEIA word)*";

Parsedef "words2 <- word (ZEIO word)*";

Parsedef "wordset1 <- ((words1)? LUA)";

Parsedef "wordset2 <- ((words2)? LUO)";


Parsedef "termset1 <- ((terms (guu)?) / (KA (freemod)? termset2 (freemod)? KI (freemod)? termset1))";

Parsedef "termset2 <- (termset1 ((A1 (freemod)? termset1))*)";

Parsedef "termset <- ((terms (freemod)? GO (freemod)? barepred) / termset2 / guu)";

Parsedef "kekpred <- (kekpredunit (((freemod)? despredD))*)";

Parsedef "barepred <- ((sentpred (freemod)? (termset)?) / (kekpred (freemod)? (termset)?))";

Parsedef "markpred <- ((PA1 barepred))";

Parsedef "backpred1 <- (((NO2 (freemod)?))* (barepred / markpred))";

Parsedef "backpred <- (((backpred1 ((ACI (freemod)? backpred1))+ (freemod)? (termset)?) ((((ACI (freemod)? backpred))+ (freemod)? (termset)?))?) / backpred1)";

Parsedef "predicate2 <- (!(GE) (((backpred ((A1 !(GE) (freemod)? backpred))+ (freemod)? (termset)?) ((((A1 (freemod)? predicate2))+ (freemod)? (termset)?))?) / backpred))";

Parsedef "predicate1 <- ((predicate2 AGE (freemod)? predicate1) / predicate2)";

Parsedef "identpred <- (((NO1 (freemod)?))* (BI (freemod)? termset))";

Parsedef "predicate <- (predicate1 / identpred)";

(* Here the commented version gives the official definition
of gasent *)

(*  BEGIN block for original gasent definition

 Parsedef  "gasent <- ((NO1 (freemod)?))* (PA1 (freemod)? barepred (GA2 (freemod)? terms)?)"; 

END *)

(* BEGIN fancy definition of gasent--the ga terms must
contain all arguments or exactly one *)

Parsedef "oneargument <- ((modifiers freemod?)? argument (modifiers freemod?)?)";

Parsedef  "gasent1 <- ((NO1 (freemod)?))* (PA1 (freemod)? barepred (GA2 (freemod)? oneargument)?)"; 

Parsedef "gasent2 <-((NO1 (freemod)?))* (PA1 (freemod)? sentpred modifiers? (GA2 (freemod)? terms))";

Parsedef "gasent <- (gasent2/gasent1)";

(* END *)

Parsedef "statement <- (gasent / (modifiers (freemod)? gasent) / (terms (freemod)? predicate))";

Parsedef "keksent <- (((NO1 (freemod)?))* ((KA (freemod)? sentence freemod? KI (freemod)? uttA1) / (KA sentence freemod? KI (freemod)? uttA1) / (KA (freemod)? headterms (freemod)? sentence freemod? KI (freemod)? uttA1)))";

Parsedef "sen1 <- (modifiers freemod? !gasent predicate/ statement / predicate / keksent)";

Parsedef "sentence <- (sen1 ((ICA freemod? sen1))*)";

Parsedef "headterms <- ((terms GI))+";

Parsedef "uttAx <- (headterms (freemod)? sentence (gap)?)";

Parsedef "HUE0 <- [Hh] UE";

Parsedef "freemod <- ((NOUI / (SOI (freemod)? descpred  (gap)?) / DIE / (NO1 DIE) / (KIE comma? utterance0 comma? KIU) / (([ ])* (HUE0) (CANCELPAUSE/[ ]* &C1) name (gap)?) / HUE !badspaces freemod? descpred ((comma? CI comma?/comma &nonamemarkers !AcronymicName) name)? gap?/ (HUE !badspaces (freemod)? statement (gap)?) / (HUE !badspaces (freemod)? termset1) /(([ ])* (HUE0) ((',' ([ ])+)/[ ]* &V1) name (gap)?) / HUE stringnospacesclosedblock/  voc / CANCELPAUSE / PAUSE / JO /UI1 /[ ]* '...' ([ ]* &letter)?/[ ]* '--' ([ ]* &letter)?) (freemod)?)";

Parsedef "uttA <- ((A1 / IE1 / mex) (freemod)?)";

Parsedef "uttA1 <- ((sen1 / uttAx / NO1 / links / linkargs / argmod / (terms (freemod)? keksent) / terms / uttA) (freemod?) (period)?)";


Parsedef "neghead <- (NO1 (gap/PAUSE))";

Parsedef "uttC <- ((neghead uttC) / uttA1)";

Parsedef "uttD <- (uttC ((ICI (freemod)? uttD))*)";

Parsedef "uttE <- (uttD ((ICA (freemod)? uttD))*)";

Parsedef "uttF <- (uttE ((I (freemod)? uttF))*)";

Parsedef "utterance0 <- !GE ((!PAUSE freemod (period)? utterance0) / (!PAUSE freemod (period)?) / (uttE IGE utterance0) / uttF / (I (freemod)? uttF?) / I freemod?  period?/ (ICA (freemod)? uttF)) (&I utterance0)?";



Parsedef "utterance <- !GE ((!PAUSE freemod (period)? utterance) / (!PAUSE freemod (period)? (&I utterance)? end) / (uttE IGE utterance) / (I (freemod)? (period)? (&I utterance)? end) / (uttF (&I utterance)? end) / (I (freemod)? uttF (&I utterance)? end) / (ICA (freemod)? uttF (&I utterance)? end))";

fun niceprecs() = (unreallyverbose();
hide "Predicate";
hide "Name";

hide "A";
hide "ACI";
hide "Acronym";
hide "AGE";
hide "BI";
hide "CA";
hide "CI";
hide "CUI";
hide "NI";
hide "DA";
hide "DIO";
hide "DIE";
hide "LIO";
hide "GA";
hide "GE";
hide "GU";
hide "GI";
hide "GO";
hide "GUE";
hide "GEU";
hide "GUI";
hide "GUO";
hide "GUU";
hide "HOI";
hide "HOI0";
hide "ICA";
hide "ICI";
hide "IE1";
hide "IGE";
hide "JE";
hide "JI";
hide "JIO";
hide "JO";
hide "JUE";
hide "KA";
hide "KI";
hide "KIE";
hide "KIU";
hide "LAU";
hide "stringnospaces";
hide "LW";
hide "LWPREDA";
hide "LUA";
hide "LI1";
hide "LU1";
hide "LIE1";
hide "CII1";
hide "LAO1";
hide "LIU0";
hide "SOI";
hide "ME";
hide "LEPO";
hide "NOUI";
hide "UI1";
hide "NO1";
hide "mex";
hide "NU";
hide "PA2";
hide "RA";
hide "LE";
hide "LA";
hide "LA0";
hide "I";
hide "GA2";
hide "CANCELPAUSE";
hide "PO";
hide "POSHORT";
hide "HUE";
hide "SUE";
hide "ZE2";
hide "LEFORPO";

dontskip "juelink";
dontskip "jelink";
dontskip "links";
dontskip "linkargs";
dontskip "predunit";
dontskip "descpred";
dontskip "sentpred";
dontskip "modifier";
dontskip "name";
dontskip "voc";
dontskip "argmod";
dontskip "argument";
dontskip "barepred";
dontskip "predicate";
dontskip "statement";
dontskip "sentence";
dontskip "freemod";
dontskip "uttC";
dontskip "uttF";




setdepth 100);


