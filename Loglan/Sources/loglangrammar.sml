fun loglanversion() = say "Parser version of 9/16/2017:  adapted for multiple ML versions\n5/16/2017:  see texts for info.\nParser version of 4/27/2017: Added alternative syllable articulation of y-hyphenated CVC djifoa\n3/18 converse and negatives of PA words; also slight fix to JE PA or JUE PA links\n3/9 fixes bug in KOUKI forethought connectives and moves CIU and MOU to KOU\n1/16 minor fixes\n1/8 no parser change, functions for batch processing\n 11/4: correction to period, explicitly using class invvoc\n11/19: technical edits eliminating LWbreak and reducing use of Oddvowel.";

(* ML version stuff *)

fun desome x = x;

(* BEGIN for PolyML decomment this; 
for Moscow ML 2.10 in addition comment out first line 

(*open PolyML*)

fun desome (SOME x) = x |

desome NONE = "";

 END *)

fun Inputline x = desome(TextIO.inputLine x);


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
                  Parsedef "utterance" "<string>"; *)

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
However, you can use Parsedef to get information about parsing of
strings in other classes than the top level "utterance" and of course
you can make repeated attempts.  And you can ask me for help.

The PEG grammar as a standalone text is also available (the pegparser.sml
file contains functions that generate this text).

Much but not all of the trial.85 Loglan official grammar is or used to be embedded
in comments here.

*)



fun startlogging2 filename = if (!LOGGING)
    then say ("You are already logging using file "^(!LOGFILENAME))
    else (
    LOGGING:=true;LOGFILE:=
    (TextIO.openOut((filename^".txt"))); 
LOGFILENAME:=filename^".txt";
say ("Opened log file "^filename^".txt"));

fun utter s = (say s;parsetest "utterance" s; errormessage "next?");

fun utteras t s = (say s;parsetest t s; errormessage "next?");

(* create commands for file processing *)

val ZAP = TextIO.openOut("default2");

val _ = TextIO.closeOut(ZAP);

val READFILE = ref(TextIO.openIn("default2"));

val READFILENAME = ref("default2");

val READING = ref false;

fun batch filename = 

(if (not(!READING)) then READFILENAME:= (filename^".txt") else ();
if (not(!READING)) then READFILE := TextIO.openIn(filename^".txt") else ();
READING:=true;
let val A = (Inputline(!READFILE)) in

if A = "###\n" then READING:=false
else (if hd(explode A) <> #"#" andalso hd(explode A) <> #"%" andalso length(explode A)>=2 then (utter (implode(rev(tl(rev (explode A))))); ()) else (if hd(explode A)= #"#" then writelogline A else (); ()); batch filename) end);

fun batch2 filename = 

(if (not(!READING)) then (stoplogging();startlogging2 filename) else ();

(if (not(!READING)) then READFILENAME:= (filename^".llg") else ();
if (not(!READING)) then READFILE := TextIO.openIn(filename^".llg") else ();
READING:=true;
let val A = (Inputline(!READFILE)) in

if A = "###\n" then READING:=false
else (if length (explode A) >= 2 andalso hd(explode A) <> #"%" then writelogline (A) else (); batch2 filename) end));


Parsedef "lowercase <- (!([qwx]) [a-z])";

Parsedef "uppercase <- (!([QWX]) [A-Z])";

Parsedef "letter <- (!([QWXqwx]) [A-Za-z])";

Parsedef "juncture <- (([-] &(letter)) / ([\\'*] !(juncture)))";

Parsedef "stress <- ([\\'*] !(juncture))";

Parsedef "juncture2 <- ((([-] &(letter)) / ([\\'*] !((([ ])* &C1 Predicate)) ((', ' ([ ])* &C1 &(Predicate)))?)) !(juncture))";

Parsedef "Lowercase <- (lowercase / (juncture (letter)?))";

Parsedef "Letter <- (letter / juncture)";

Parsedef "comma <- ([,] ([ ])+ &(letter))";

Parsedef "comma2 <- (([,])? ([ ])+ &(letter) &caprule)";

Parsedef "end <- ((([ ])* '#' ([ ])+ utterance) / (([ ])+ !(.)) / !(.))";

Parsedef "period <- (([!.:;?] (&(end) / (([ ])+ &(letter)))) ((invvoc (period)?))?)";

Parsedef "V1 <- [AEIOUYaeiouy]";

Parsedef "V2 <- [AEIOUaeiou]";

Parsedef "C1 <- (!(V1) letter)";

Parsedef "Mono <- (([Aa] [o]) / (V2 [i])![i] / ([Ii] ![i] V2) / ([Uu] V2))";

Parsedef "EMono <- (([Aa] [o]) / ([AEOaeo] [i])![i])";

Parsedef "NextVowels <- (EMono / (V2 &(EMono)) / Mono / V2)";

Parsedef "BrokenMono <- (([a] juncture [o]) / ([aeo] juncture [i]))";

Parsedef "CVVSyll <- (C1 Mono)";

Parsedef "LWunit <- (((CVVSyll (juncture)? V2) / (C1 !(BrokenMono) V2 (juncture)? V2) / (C1 V2)) (juncture2)?)";

Parsedef "caprule <- [\"()]? ((uppercase / lowercase) ((('z' V1) / lowercase / (juncture (caprule)?) / TAI0))* !(letter))";

Parsedef "InitialCC <- ('bl' / 'br' / 'ck' / 'cl' / 'cm' / 'cn' / 'cp' / 'cr' / 'ct' / 'dj' / 'dr' / 'dz' / 'fl' / 'fr' / 'gl' / 'gr' / 'jm' / 'kl' / 'kr' / 'mr' / 'pl' / 'pr' / 'sk' / 'sl' / 'sm' / 'sn' / 'sp' / 'sr' / 'st' / 'tc' / 'tr' / 'ts' / 'vl' / 'vr' / 'zb' / 'zv' / 'zl' / 'sv' / 'Bl' / 'Br' / 'Ck' / 'Cl' / 'Cm' / 'Cn' / 'Cp' / 'Cr' / 'Ct' / 'Dj' / 'Dr' / 'Dz' / 'Fl' / 'Fr' / 'Gl' / 'Gr' / 'Jm' / 'Kl' / 'Kr' / 'Mr' / 'Pl' / 'Pr' / 'Sk' / 'Sl' / 'Sm' / 'Sn' / 'Sp' / 'Sr' / 'St' / 'Tc' / 'Tr' / 'Ts' / 'Vl' / 'Vr' / 'Zb' / 'Zv' / 'Zl' / 'Sv')";

Parsedef "MaybeInitialCC <- (([Bb] (juncture)? [l]) / ([Bb] (juncture)? [r]) / ([Cc] (juncture)? [k]) / ([Cc] (juncture)? [l]) / ([Cc] (juncture)? [m]) / ([Cc] (juncture)? [n]) / ([Cc] (juncture)? [p]) / ([Cc] (juncture)? [r]) / ([Cc] (juncture)? [t]) / ([Dd] (juncture)? [j]) / ([Dd] (juncture)? [r]) / ([Dd] (juncture)? [z]) / ([Ff] (juncture)? [l]) / ([Ff] (juncture)? [r]) / ([Gg] (juncture)? [l]) / ([Gg] (juncture)? [r]) / ([Jj] (juncture)? [m]) / ([Kk] (juncture)? [l]) / ([Kk] (juncture)? [r]) / ([Mm] (juncture)? [r]) / ([Pp] (juncture)? [l]) / ([Pp] (juncture)? [r]) / ([Ss] (juncture)? [k]) / ([Ss] (juncture)? [l]) / ([Ss] (juncture)? [m]) / ([Ss] (juncture)? [n]) / ([Ss] (juncture)? [p]) / ([Ss] (juncture)? [r]) / ([Ss] (juncture)? [t]) / ([Tt] (juncture)? [c]) / ([Tt] (juncture)? [r]) / ([Tt] (juncture)? [s]) / ([Vv] (juncture)? [l]) / ([Vv] (juncture)? [r]) / ([Zz] (juncture)? [b]) / ([Zz] (juncture)? [v]) / ([Zz] (juncture)? [l]) / ([Ss] (juncture)? [v]))";

Parsedef "NonmedialCC <- (([b] (juncture)? [b]) / ([c] (juncture)? [c]) / ([d] (juncture)? [d]) / ([f] (juncture)? [f]) / ([g] (juncture)? [g]) / ([h] (juncture)? [h]) / ([j] (juncture)? [j]) / ([k] (juncture)? [k]) / ([l] (juncture)? [l]) / ([m] (juncture)? [m]) / ([n] (juncture)? [n]) / ([p] (juncture)? [p]) / ([q] (juncture)? [q]) / ([r] (juncture)? [r]) / ([s] (juncture)? [s]) / ([t] (juncture)? [t]) / ([v] (juncture)? [v]) / ([z] (juncture)? [z]) / ([h] (juncture)? C1) / ([cjsz] (juncture)? [cjsz]) / ([f] (juncture)? [v]) / ([k] (juncture)? [g]) / ([p] (juncture)? [b]) / ([t] (juncture)? [d]) / ([fkpt] (juncture)? [jz]) / ([b] (juncture)? [j]) / ([s] (juncture)? [b]))";

Parsedef "NonjointCCC <- (([c] (juncture)? [d] (juncture)? [z]) / ([c] (juncture)? [v] (juncture)? [l]) / ([n] (juncture)? [d] (juncture)? [j]) / ([n] (juncture)? [d] (juncture)? [z]) / ([d] (juncture)? [c] (juncture)? [m]) / ([d] (juncture)? [c] (juncture)? [t]) / ([d] (juncture)? [t] (juncture)? [s]) / ([p] (juncture)? [d] (juncture)? [z]) / ([g] (juncture)? [t] (juncture)? [s]) / ([g] (juncture)? [z] (juncture)? [b]) / ([s] (juncture)? [v] (juncture)? [l]) / ([j] (juncture)? [d] (juncture)? [j]) / ([j] (juncture)? [t] (juncture)? [c]) / ([j] (juncture)? [t] (juncture)? [s]) / ([j] (juncture)? [v] (juncture)? [r]) / ([t] (juncture)? [v] (juncture)? [l]) / ([k] (juncture)? [d] (juncture)? [z]) / ([v] (juncture)? [t] (juncture)? [s]) / ([m] (juncture)? [z] (juncture)? [b]))";

Parsedef "Oddvowel <- ((juncture)? (((V2 (juncture)? V2 (juncture)?))* V2) (juncture)?)";

Parsedef "RepeatedVowel <- (([Aa] (juncture)? [a]) / ([Ee] (juncture)? [e]) / ([Oo] (juncture)? [o]) / ([Ii] juncture [i]) / ([Uu] juncture [u]))";

Parsedef "RepeatedVocalic <- (([Mm] [m]) / ([Nn] [n]) / ([Ll] [l]) / ([Rr] [r]))";

Parsedef "Syllabic <- [lmnr]";

Parsedef "Nonsyllabic <- (!(Syllabic) C1)";

Parsedef "Badfinalpair <- (Nonsyllabic !('mr') !(RepeatedVocalic) Syllabic !((V2 / [y] / RepeatedVocalic)))";

Parsedef "FirstConsonants <- (((!((C1 C1 RepeatedVocalic)) &(InitialCC) (C1 InitialCC)) / (!((C1 RepeatedVocalic)) InitialCC) / ((!(RepeatedVocalic) C1) !([y]))) !(juncture))";

Parsedef "FirstConsonants2 <- (((!((C1 C1 RepeatedVocalic)) &(InitialCC) (C1 InitialCC)) / (!((C1 RepeatedVocalic)) InitialCC) / (!(RepeatedVocalic) C1)) !(juncture))";

Parsedef "VowelSegment <- (!BrokenMono(NextVowels !(RepeatedVocalic)) / (!((C1 RepeatedVocalic)) RepeatedVocalic))";

Parsedef "VowelSegment2 <- (NextVowels / (!((C1 RepeatedVocalic)) RepeatedVocalic))";

Parsedef "SyllableA <- ((C1 V2 &(C1) !(Badfinalpair) (FinalConsonant)? ((!(Syllable) FinalConsonant))?) (juncture)?)";

Parsedef "SyllableB <- ((FirstConsonants)? !(RepeatedVowel) !((&(Mono) V2 RepeatedVowel)) VowelSegment !(Badfinalpair) ((!(Syllable) FinalConsonant))? ((!(Syllable) FinalConsonant))? (juncture)?)";

Parsedef "Syllable <- (SyllableA / SyllableB)";

Parsedef "BrokenInitialCC <- (&(MaybeInitialCC) C1 juncture C1 &(V2))";

Parsedef "JunctureFix <- ((InitialCC V2 BrokenInitialCC) / (((C1 V2))? V2 BrokenInitialCC) / (C1 V2 !(stress) juncture InitialCC V2 Letter) / (C1 BrokenInitialCC V2))";

Parsedef "SyllableFinal1 <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment !(stress) (juncture)? !(V2) (&(Syllable) / &([y]) / !(Letter)))";

Parsedef "SyllableFinal2 <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment !(stress) (juncture)? (&([y]) / !(Letter)))";

Parsedef "SyllableFinal2a <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment (juncture)? (&([y])))";

Parsedef "SyllableFinal2b <- ((FirstConsonants)? !(RepeatedVocalic) VowelSegment stress (&([y])))";

Parsedef "StressedSyllable <- (((FirstConsonants)? !(RepeatedVowel) !((&(Mono) V2 RepeatedVowel)) VowelSegment !(Badfinalpair) (FinalConsonant)? (FinalConsonant)?) stress)";

Parsedef "FinalConsonant <- (!(RepeatedVocalic) !(NonmedialCC) !(NonjointCCC) C1 !(((juncture)? V2)))";

Parsedef "Syllable2 <- (((FirstConsonants2)? (VowelSegment2 / [y]) !(Badfinalpair) ((!(Syllable2) FinalConsonant))? ((!(Syllable2) FinalConsonant))?) (juncture)?)";

(* Parsedef "FinalConsonant2 <- (!(RepeatedVocalic) !(NonmedialCC) !(NonjointCCC) C1 !(((juncture)? V2)))"; *)

Parsedef "Name <- (([ ])* &(((uppercase / lowercase) ((!((C1 (stress)? !(Letter))) Lowercase))* C1 (stress)? !(Letter) (&(end) / comma / &(period) / &(Name) / &(CI)))) ((Syllable2)+ (&(end) / comma / &(period) / &(Name) / &(CI))))";

Parsedef "CCSyllableB <- (((FirstConsonants)? RepeatedVocalic !(Badfinalpair) ((!(Syllable) FinalConsonant))? ((!(Syllable) FinalConsonant))?) (juncture)?)";

Parsedef "BorrowingTail <- ((!(JunctureFix) !(CCSyllableB) StressedSyllable ((!(StressedSyllable) CCSyllableB))? !(StressedSyllable) SyllableFinal1) / (!(CCSyllableB) !(JunctureFix) Syllable ((!(StressedSyllable) CCSyllableB))? !(StressedSyllable) SyllableFinal2))";

Parsedef "PreBorrowing <- (((!(BorrowingTail) !(StressedSyllable) !(JunctureFix) !((CCSyllableB CCSyllableB)) Syllable))* !(CCSyllableB) BorrowingTail)";

Parsedef "HasCCPair <- ((((C1)? ((V2 ((!(stress) juncture))?))+ !(Borrowing) !((&(MaybeInitialCC) C1 (!(stress) juncture) !(CCVV) PreBorrowing)) (stress)?))? C1 (juncture)? C1)";

Parsedef "CVCBreak <- (C1 V2 (juncture)? &(MaybeInitialCC) C1 (juncture)? &((PreComplex / ComplexTail)))";

Parsedef "CCVV <- ((&(BorrowingTail) C1 C1 (C1)? V2 stress !(Mono) V2) / (&(BorrowingTail) C1 C1 (C1)? V2 (juncture)? V2 (!(Letter) / ((juncture)? [y]))))";

Parsedef "Borrowing <- (&(HasCCPair) !(CVCBreak) !(CCVV) !(((((C1)? (V2 (juncture)?) ((V2 (juncture)? &(V2)))+))? V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(BorrowingTail) !(StressedSyllable) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))* !(CCSyllableB) BorrowingTail))";

Parsedef "PreBorrowingAffix <- ((((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))+ SyllableFinal2a) (juncture)? [y] !(stress) (juncture)? (([ ,] ([ ])*))?)";

Parsedef "BorrowingAffix <- (&(HasCCPair) !(CVCBreak) !(CCVV) !(((((C1)? (V2 (juncture)?) ((V2 (juncture)? &(V2)))+))? V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))+ SyllableFinal2a) (juncture)? [y] !(stress) (juncture)? (comma)?)";

Parsedef "StressedBorrowingAffix <- (&(HasCCPair) !(CVCBreak) !(CCVV) !(((((C1)? (V2 (juncture)?) ((V2 (juncture)? &(V2)))+))? V2 (juncture)? MaybeInitialCC V2)) !(CCSyllableB) (((!(StressedSyllable) !(SyllableFinal2a) !((CCSyllableB CCSyllableB)) !(JunctureFix) Syllable))* SyllableFinal2b) (juncture)? [y] !(stress) (juncture)? !([,]))";

Parsedef "yhyphen <- ((juncture)? [y] !(stress) (juncture)? !([y]) &(letter))";

Parsedef "CV <- (C1 V2 !(stress) (juncture)? !(V2))";

Parsedef "Cfinal <- (((juncture &(C1 !juncture))? C1 yhyphen) / (!(NonmedialCC) !(NonjointCCC) C1 !(((juncture)? V2))))";

Parsedef "hyphen <- (!(NonmedialCC) !(NonjointCCC) (([r] !(((juncture)? [r])) !(((juncture)? V2))) / ([n] (juncture)? &([r])) / ((juncture)? [y] !(stress))) ((juncture)? &(letter)) !(((juncture)? [y])))";

Parsedef "noyhyphen <- (!(NonmedialCC) !(NonjointCCC) (([r] !(((juncture)? [r])) !(((juncture)? V2))) / ([n] (juncture)? &([r]))) &(((juncture)? &(letter))) !(((juncture)? [y])))";

Parsedef "StressedSyllable2 <- (((FirstConsonants)? VowelSegment !(Badfinalpair) (FinalConsonant)? (FinalConsonant)?) stress (yhyphen)?)";

Parsedef "CVVStressed <- (((C1 &(RepeatedVowel) V2 !(stress) (juncture)? !(RepeatedVowel) V2 (noyhyphen)?) (juncture)? (yhyphen)?) / (C1 !(BrokenMono) V2 !(stress) juncture V2 (noyhyphen)? stress (yhyphen)?) / (C1 !(Mono) V2 V2 (noyhyphen)? stress (yhyphen)?))";

Parsedef "CVVStressed2 <- (C1 Mono (noyhyphen)? stress (yhyphen)?)";

Parsedef "CVV <- (!((C1 V2 stress V2 (hyphen)? stress)) ((C1 !(BrokenMono) V2 (juncture)? !(RepeatedVowel) V2 (noyhyphen)?) (juncture)? !(V2) (yhyphen)?))";

Parsedef "CVVFinal1 <- (C1 !(BrokenMono) V2 stress !(RepeatedVowel) V2 !(stress) (juncture)? !(V2))";

Parsedef "CVVFinal2 <- (((C1 !(Mono) V2 V2) / (C1 !(BrokenMono) V2 juncture !(RepeatedVowel) V2)) !(Letter))";

Parsedef "CVVFinal3 <- (C1 &(Mono) V2 V2 !(stress) (juncture)? !(V2))";

Parsedef "CVVFinal4 <- (C1 Mono !(Letter))";

Parsedef "CVVFinal5 <- (((C1 !(Mono) V2 V2) / (C1 !(BrokenMono) V2 juncture V2)) &(((juncture)? [y])))";

Parsedef "CVC <- ((C1 V2 Cfinal) (juncture)?)";

Parsedef "CVCStressed <- (C1 V2 !(NonmedialCC) !(NonjointCCC) C1 stress !(V2) (yhyphen)?)/(C1 V2 stress C1 !juncture (yhyphen))";

Parsedef "CCV <- (InitialCC !(RepeatedVowel) V2 (juncture)? !(V2) (yhyphen)?)";

Parsedef "CCVStressed <- (InitialCC !(RepeatedVowel) V2 stress !(V2) (yhyphen)?)";

Parsedef "CCVFinal1 <- (InitialCC !(RepeatedVowel) V2 !(stress) (juncture)? !(V2))";

Parsedef "CCVFinal2 <- (InitialCC V2 !(Letter))";

Parsedef "CCVCVMedial <- (InitialCC V2 (juncture)? C1 [y] !(stress) (juncture)? &(letter))";

Parsedef "CCVCVMedialStressed <- (CCV stress C1 [y] !(stress) (juncture)? &(letter))";

Parsedef "CCVCVFinal1 <- (InitialCC V2 stress CV)";

Parsedef "CCVCVFinal2 <- (InitialCC V2 (juncture)? CV !(Letter))";

Parsedef "CCVCVY <- (InitialCC V2 (juncture)? CV [y])";

Parsedef "CVCCVMedial <- (C1 V2 ((juncture &(InitialCC)))? !(NonmedialCC) C1 (juncture)? C1 [y] !(stress) (juncture)? &(letter))";

Parsedef "CVCCVMedialStressed <- ((C1 V2 (stress &(InitialCC)) !(NonmedialCC) C1 C1 [y] !(stress) (juncture)? &(letter)) / (C1 V2 !(NonmedialCC) C1 stress C1 [y] !(stress) (juncture)? &(letter)))";

Parsedef "CVCCVFinal1a <- (C1 V2 stress InitialCC V2 !(stress) (juncture)? !(V2))";

Parsedef "CVCCVYa <- (C1 V2 (juncture)? InitialCC V2 !(stress) (juncture)? [y])";

Parsedef "CVCCVFinal1b <- (C1 V2 !(NonmedialCC) C1 stress CV)";

Parsedef "CVCCVYb <- (C1 V2 !(NonmedialCC) C1 (juncture)? CV [y])";

Parsedef "CVCCVFinal2 <- (C1 V2 ((juncture &(InitialCC)))? !(NonmedialCC) C1 (juncture)? CV !(Letter))";

Parsedef "FiveLetterY <- (CCVCVY / CVCCVYa / CVCCVYb)";

Parsedef "GenericFinal <- (CVVFinal3 / CVVFinal4 / CCVFinal1 / CCVFinal2)";

Parsedef "FiveLetterFinal <- (CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2)";


Parsedef "GenericTerminalFinal <- (CVVFinal4 / CCVFinal2)";

Parsedef "Affix1 <- (CCVCVMedial / CVCCVMedial / CCV / CVV / CVC)";

Parsedef "Peelable <- (&(PreBorrowingAffix) !(CVVFinal1) !(CVVFinal5) Affix1 (!(Affix1) / &((&(PreBorrowingAffix) !(CVVFinal1) !(CVVFinal5) Affix1 !(PreBorrowingAffix) !(Affix1))) / Peelable))";


Parsedef "Peelable2 <- (&(PreBorrowing) !(CVVFinal1) !(CVVFinal2) !(CVVFinal5) !(FiveLetterFinal) Affix1 !(FiveLetterFinal) (!(Affix1) / &((&(PreBorrowing) !(FiveLetterFinal) !(CVVFinal1) !(CVVFinal2) !(CVVFinal5) Affix1 !(PreBorrowing) !(FiveLetterFinal) !(Affix1))) / Peelable2))";

Parsedef "Affix <- ((!(Peelable) !(Peelable2) Affix1) / (!(FiveLetterY) BorrowingAffix))";

Parsedef "Affix2 <- (!(StressedSyllable2) !(CVVStressed) Affix)";

Parsedef "ComplexTail <- ((Affix GenericTerminalFinal) / (!((!(Peelable) Affix1)) !(FiveLetterY) StressedBorrowingAffix GenericFinal) / (CCVCVMedialStressed GenericFinal) / (CVCCVMedialStressed GenericFinal) / (CCVStressed GenericFinal) / (CVCStressed GenericFinal) / (CVVStressed GenericFinal) / (CVVStressed2 GenericFinal) / (Affix2 CVVFinal1) / (Affix2 CVVFinal2) / CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2 / (!((CVVStressed / StressedSyllable2)) Affix !((!(Peelable2) Affix1)) Borrowing !(((juncture)? [y]))))";

Parsedef "Primitive <- (CCVCVFinal1 / CCVCVFinal2 / CVCCVFinal1a / CVCCVFinal1b / CVCCVFinal2)";

Parsedef "PreComplex <- (ComplexTail / ((!((CVCStressed / CCVStressed / CVVStressed / ComplexTail / StressedSyllable2)) Affix) PreComplex))";

Parsedef "Complex <- (!((C1 V2 (juncture)? (V2)? (juncture)? CVV)) !((C1 V2 !(stress) (juncture)? (V2)? !(stress) (juncture)? (Primitive / PreComplex / Borrowing / CVV))) !((C1 V2 (juncture)? &(MaybeInitialCC) C1 (juncture)? &((PreComplex / ComplexTail)))) PreComplex)";

Parsedef "Predicate <- (((&(caprule) ((Primitive / Complex / Borrowing) ((([ ])* Z AO (', ')? ([ ])* Predicate))?)) / (C1 V2 (V2)? ([ ])* Z AO (comma)? ([ ])* Predicate)) !(((juncture)? [y])))";

Parsedef "Fourvowels <- (C1 V2 (juncture)? V2 (juncture)? V2 (juncture)? V2)";

Parsedef "B <- (!(Predicate) !(Fourvowels) [Bb])";

Parsedef "C <- (!(Predicate) !(Fourvowels) [Cc])";

Parsedef "D <- (!(Predicate) !(Fourvowels) [Dd])";

Parsedef "F <- (!(Predicate) !(Fourvowels) [Ff])";

Parsedef "G <- (!(Predicate) !(Fourvowels) [Gg])";

Parsedef "H <- (!(Predicate) !(Fourvowels) [Hh])";

Parsedef "J <- (!(Predicate) !(Fourvowels) [Jj])";

Parsedef "K <- (!(Predicate) !(Fourvowels) [Kk])";

Parsedef "L <- (!(Predicate) !(Fourvowels) [Ll])";

Parsedef "M <- (!(Predicate) !(Fourvowels) [Mm])";

Parsedef "N <- (!(Predicate) !(Fourvowels) [Nn])";

Parsedef "P <- (!(Predicate) !(Fourvowels) [Pp])";

Parsedef "R <- (!(Predicate) !(Fourvowels) [Rr])";

Parsedef "S <- (!(Predicate) !(Fourvowels) [Ss])";

Parsedef "T <- (!(Predicate) !(Fourvowels) [Tt])";

Parsedef "V <- (!(Predicate) !(Fourvowels) [Vv])";

Parsedef "Z <- (!(Predicate) !(Fourvowels) [Zz])";

Parsedef "a <- ([Aa] (juncture2)? !(V2))";

Parsedef "e <- (([Ee] (juncture2)?) !(V2))";

Parsedef "i <- ([Ii] (juncture2)? !(V2))";

Parsedef "o <- ([Oo] (juncture2)? !(V2))";

Parsedef "u <- ([Uu] (juncture2)? !(V2))";

Parsedef "V3 <- !Predicate V2";

Parsedef "AA <- ([Aa] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !Oddvowel))";

Parsedef "AE <- ([Aa] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "AI <- ([Aa] [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "AO <- ([Aa] [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "AU <- ([Aa] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "EA <- ([Ee] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "EE <- ([Ee] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "EI <- ([Ee] [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "EO <- ([Ee] (juncture)? [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "EU <- ([Ee] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "IA <- ([Ii] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "IE <- ([Ii] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "II <- ([Ii] (juncture)? [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "IO <- ([Ii] (juncture)? [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "IU <- ([Ii] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "OA <- ([Oo] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "OE <- ([Oo] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "OI <- ([Oo] [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "OO <- ([Oo] (juncture)? [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "OU <- ([Oo] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "UA <- ([Uu] (juncture)? [a] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "UE <- ([Uu] (juncture)? [e] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "UI <- ([Uu] (juncture)? [i] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "UO <- ([Uu] (juncture)? [o] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "UU <- ([Uu] (juncture)? [u] (juncture2)? (&((V3 (juncture)? !(V2))) / !(Oddvowel)))";

Parsedef "__LWinit <- (([ ])* !(Predicate) &(caprule))";

Parsedef "CANCELPAUSE <- (comma (('y' comma) / (C UU (!connective))))";

Parsedef "PAUSE <- (!(CANCELPAUSE) comma !connective !V1)";

Parsedef "TAI0 <- (!(Predicate) (((V1 (juncture)? !(Predicate) !(Name) M a (juncture2)?) / (V1 (juncture)? !(Predicate) !(Name) F i (juncture2)?) / (V1 (juncture)? !(Predicate) !(Name) Z i (juncture2)?) / (C1 AI (u)?) / (C1 EI (u)?) / (C1 EO) / (Z [i] (juncture)? V1 (juncture2)? ((M a))? (juncture2)?)) (!(Oddvowel) / (!([ ]) &(TAI0)))))";

Parsedef "NOI <- (N OI )";

Parsedef "A0 <- (!(Predicate) !((Mono / BrokenMono)) (([AEOUaeou] / (H a)) (juncture2)? !(V2) ))";

Parsedef "A <- (__LWinit !(TAI0) (((N [u]) &((u / (N [o])))))? ((N [o]))? A0 (NOI)? !((([ ])+ PANOPAUSES PAUSE)) !((PANOPAUSES !PAUSE [, ])) ((PANOPAUSES ((F i) / &PAUSE)))? )";

Parsedef "ANOFI <- (__LWinit !(TAI0) (((N [u]) &((u / (N [o])))))? ((N [o]))? A0 (NOI)? (PANOPAUSES)? )";

Parsedef "A1 <- (A (!connective))";

Parsedef "ACI <- (ANOFI C i (!connective))";

Parsedef "AGE <- (ANOFI G e (!connective))";

Parsedef "CA0 <- ((((N o))? ((C a) / (C e) / (C o) / (C u) / (Z e) / (C i H a)) ) (NOI)?)";

Parsedef "CA1 <- ((((N u) &(((C u) / (N o)))))? ((N o))? CA0 !((([ ])+ PANOPAUSES PAUSE)) !((PANOPAUSES !PAUSE [, ])) ((PANOPAUSES ((F i) / &PAUSE)))? )";

Parsedef "CA1NOFI <- ((((N u) &(((C u) / (N o)))))? ((N o))? CA0 (PANOPAUSES)? )";

Parsedef "CA <- (__LWinit &(caprule) CA1 (!connective))";

Parsedef "ZE2 <- (__LWinit (Z e) (!connective))";

Parsedef "I <- (__LWinit !(TAI0) i !((([ ])+ PANOPAUSES PAUSE)) !((PANOPAUSES !PAUSE [, ])) ((PANOPAUSES ((F i) / &PAUSE)))? (!connective))";

Parsedef "ICA <- (__LWinit !(Predicate) i ((H a) / CA1) (!connective))";

Parsedef "ICI <- (__LWinit i (CA1NOFI)? C i (!connective))";

Parsedef "IGE <- (__LWinit i (CA1NOFI)? G e (!connective))";

Parsedef "connective <- (ACI/AGE /A1 / ICI / ICA / IGE / I /&V1 TAI0)";

Parsedef "KA0 <- (((K a) / (K e) / (K o) / (K u) / (K i H a)) )";

Parsedef "KOU <- (((K OU) / (M OI) / (R AU) / (S OA)/M OU/C IU) )";

Parsedef "KOU1 <- (((N u N o) / (N u) / (N o)) KOU)";

Parsedef "KA <- (__LWinit &(caprule) (((((N u) &((K u))))? KA0) / ((KOU1 / KOU) K i)) (NOI)? (!connective))";

Parsedef "KI <- (__LWinit (K i) (NOI)? (!connective))";

Parsedef "KOU2 <- KOU1 !KI";

Parsedef "BadNIStress <- ((C1 V2 (V2)? stress ((M a))? ((M OA))? NI RA) / (C1 V2 stress V2 ((M a))? ((M OA))? NI RA))";

Parsedef "NI0 <- (!(BadNIStress) (((K UA) / (G IE) / (G IU) / (H IE) / (H IU) / (K UE) / (N EA) / (N IO) / (P EA) / (P IO) / (S UU) / (S UA) / (T IA) / (Z OA) / (Z OO) / (H o) / (N i) / (N e) / (T o) / (T e) / (F o) / (F e) / (V o) / (V e) / (P i) / (R e) / (R u) / (S e) / (S o) / (H i)) ))";

Parsedef "SA <- (!(BadNIStress) ((S a) / (S i) / (S u) / (IE (comma2? !IE SA)?)) (NOI)? )";

Parsedef "RA <- (!(BadNIStress) (((R a) / (R i) / (R o)) ))";

Parsedef "NI1 <- ((NI0 ((!(BadNIStress) M a))? ((!(BadNIStress) M OA (NI0)*))? ) ((comma2 !((NI RA)) &(NI)))?)";

Parsedef "RA1 <- ((RA ((!(BadNIStress) M a))? ((!(BadNIStress) M OA (NI0)*))? ) ((comma2 !((NI RA)) &(NI)))?)";

(* Parsedef "IE1 <- (__LWinit IE (!connective))"; *)

Parsedef "NI2 <- ((((SA)? ((NI1)+ / RA1)) / SA) (NOI)? ((CA0 (((SA)? ((NI1)+ / RA1)) / SA) (NOI)?))*)";

Parsedef "NI <- (__LWinit NI2 ((&((M UE)) Acronym (comma / &(end) / &(period)) !((C u))))? ((C u))? )";

Parsedef "mex <- (__LWinit NI (!connective))";

Parsedef "CI <- (__LWinit (C i) (!connective))";

Parsedef "Acronym <- (([ ])* &(caprule) ((M UE) / TAI0 / ([Zz] V2 !(V2))) ((comma &Acronym M UE / NI1 / TAI0 / ([Zz] V2 (!(V2) / ([Zz] &(V2))))))+)";

Parsedef "TAI <- (__LWinit (TAI0 / ((G AO) !(badspaces) !(V2) ([ ])* (Name / Predicate / (C1 V2 V2 (!(Oddvowel) / &(TAI0))) / (C1 V2 (!(Oddvowel) / &(TAI0)))))) (!connective))";

Parsedef "DA0 <- (((T AO) / (T IO) / (T UA) / (M IO) / (M IU) / (M UO) / (M UU) / (T OA) / (T OI) / (T OO) / (T OU) / (T UO) / (T UU) / (S UO) / (H u) / (B a) / (B e) / (B o) / (B u) / (D a) / (D e) / (D i) / (D o) / (D u) / (M i) / (T u) / (M u) / (T i) / (T a) / (M o)) )";

Parsedef "DA1 <- ((TAI0 / DA0) ((C i !([ ]) NI0))? )";

Parsedef "DA <- (__LWinit DA1 (!connective))";

Parsedef "PA0 <- (N u !KOU)? (((G IA) / (G UA) / (P AU) / (P IA) / (P UA) / (N IA) / (N UA) / (B IU) / (F EA) / (F IA) / (F UA) / (V IA) / (V II) / (V IU) / (C OI) / (D AU) / (D II) / (D UO) / (F OI) / (F UI) / (G AU) / (H EA) / (K AU) / (K II) / (K UI) / (L IA) / (L UI) / (M IA) / (N UI) / (P EU) / (R OI) / (R UI) / (S EA) / (S IO) / (T IE) / (V a) / (V i) / (V u) / (P a) / (N a) / (F a) / (V a) / KOU !(N OI) !(KI)) ) (N OI)?";

Parsedef "PANOPAUSES <- (((!(PA0) NI))? ((KOU2 / PA0))+ ((((comma2)? CA0 (comma2)?) ((KOU2 / PA0))+))* (ZI)? )";

Parsedef "PA3 <- (__LWinit PANOPAUSES (!connective))";

Parsedef "PA <- (((!(PA0) NI))? ((KOU2 / PA0))+ (((((comma2)? CA0 (comma2)?) / (comma2 !(mod1a))) ((KOU2 / PA0))+))* (ZI)? )";

Parsedef "PA2 <- ((__LWinit PA (!connective)))";

Parsedef "GA <- (__LWinit (G a) (!connective))";

Parsedef "PA1 <- (((PA2 / GA) (!connective)))";

Parsedef "ZI <- ((Z i) / (Z a) / (Z u))";

Parsedef "LE <- (__LWinit ((L EA) / (L EU) / (L OE) / (L EE) / (L AA) / (L e) / (L o) / ((L a) !(badspaces))) (!connective))";

Parsedef "LEFORPO <- (__LWinit ((L e) / (L o) / NI2) (!connective))";

Parsedef "LIO <- (__LWinit (L IO) (!connective))";

Parsedef "LAU <- (__LWinit (L AU) (!connective))";

Parsedef "LOU <- (__LWinit (L OU) (!connective))";

Parsedef "LUA <- (__LWinit (L UA) (!connective))";

Parsedef "LUO <- (__LWinit (L UO) (!connective))";

Parsedef "ZEIA <- (__LWinit Z EI a (!connective))";

Parsedef "ZEIO <- (__LWinit Z EI o (!connective))";

Parsedef "LI1 <- (L i)";

Parsedef "LU1 <- (L u)";

Parsedef "LI2 <- ([\"] L i/L i [\"])";

Parsedef "LU2 <- (L u [\"]/[\"] L u)";

Parsedef "Quotemod <- (((Z a) / (Z i)) )";

Parsedef "LI <- ((__LWinit LI1 !(V2) (Quotemod)? ((([,])? ([ ])+))? utterance0 (', ')? __LWinit LU1 (!connective)) / (__LWinit LI1 !(V2) (Quotemod)? comma name (comma)? __LWinit LU1 (!connective)))/((__LWinit LI2 !(V2) (Quotemod)? ((([,])? ([ ])+))? utterance0 (', ')? __LWinit LU2 (!connective)) / (__LWinit LI2 !(V2) (Quotemod)? comma name (comma)? __LWinit LU2 (!connective)))";

Parsedef "stringnospaces <- (([,])? (([ ]+ [\"]/([ ])+ ![\"]) ((!([,\"]?[ ,]) !([\"]?(period/!.)) .))+) (&([\"])/(([,])? ([ ])+ &(letter)) / &(period) / &(end)))";

Parsedef "stringnospacesclosed <- (([,])? (([ ]+ [\"]/([ ])+ ![\"]) ((!([,\"]?[ ,]) !([\"]? (period/!.)) .))+) ((([,] ([ ])+) / &(period) / &(end))))";

Parsedef "stringnospacesclosedblock <- ((stringnospaces ((!(([y] stringnospacesclosed)) [y] stringnospaces))* ([y] stringnospacesclosed)) / stringnospacesclosed)";

Parsedef "LAO1 <- (L AO)";

Parsedef "LAO <- (([ ])* (LAO1 stringnospaces (([y] stringnospaces))*))";

Parsedef "LIE1 <- (L IE)";

(*Parsedef "LIE <- (([ ])* LIE1 ((!([ ]) NI0))? (Quotemod)? stringnospaces ((CII1 ((!([ ]) NI0))? stringnospaces))* )"; *)

Parsedef "LIE <- ((([ ])* (LIE1 Quotemod? &([ ]+ [\"]) stringnospaces (([y]stringnospaces))*)) [\"] comma?)/(([ ])* (LIE1 Quotemod? &([ ]+ ![\"]) stringnospaces (([y]stringnospaces))*))";

Parsedef "LW <- (&(caprule) (((!(Predicate) V2 V2))+ / ((!(Predicate) (V2)? ((!(Predicate) LWunit))+) / V2)))";

Parsedef "LIU0 <- ((L IU) / (N IU))";

Parsedef "LIU1 <- (__LWinit ((LIU0 !(badspaces) !(V2) (Quotemod)? ((([,])? ([ ])+))? (Name / (Predicate (comma)?) / (CCV (comma)?) / (LW (([,] ([ ])+ !([,])) / &(period) / &(end) / &((([ ])* Predicate)))))) / (L II (Quotemod)? TAI (!connective))))";

Parsedef "SUE <- (__LWinit ((S UE) / (S AO)) stringnospaces)";

Parsedef "CUI <- (__LWinit (C UI) (!connective))";

Parsedef "GA2 <- (__LWinit (G a) (!connective))";

Parsedef "GE <- (__LWinit (G e) (!connective))";

Parsedef "GEU <- (__LWinit ((C UE) / (G EU)) (!connective))";

Parsedef "GI <- (__LWinit ((G i) / (G OI)) (!connective))";

Parsedef "GO <- (__LWinit (G o) (!connective))";

Parsedef "GIO <- (__LWinit (G IO) (!connective))";

Parsedef "GU <- (__LWinit (G u) (!connective))";

Parsedef "GUIZA <- (__LWinit (G UI) (Z a) (!connective))";

Parsedef "GUIZI <- (__LWinit (G UI) (Z i) (!connective))";

Parsedef "GUIZU <- (__LWinit (G UI) (Z u) (!connective))";

Parsedef "GUI <- !GUIZA !GUIZI !GUIZU (__LWinit (G UI) (!connective))";

(* Parsedef "GUIA <- (__LWinit (G UI a) (!connective))"; *)

Parsedef "GUO <- (__LWinit (G UO) (!connective))";

Parsedef "GUOA <- (__LWinit (G UO (Z)? a) (!connective))";

Parsedef "GUOE <- (__LWinit (G UO e) (!connective))";

Parsedef "GUOI <- (__LWinit (G UO (Z)? i) (!connective))";

Parsedef "GUOO <- (__LWinit (G UO o) (!connective))";

Parsedef "GUOU <- (__LWinit (G UO (Z)? u) (!connective))";

Parsedef "GUU <- (__LWinit (G UU) (!connective))";

Parsedef "GUUA <- (__LWinit (G UU a) (!connective))";

Parsedef "GIUO <- (__LWinit (G IU o) (!connective))";

Parsedef "GUE <- (__LWinit (G UE) (!connective))";

Parsedef "GUEA <- (__LWinit (G UE a) (!connective))";

Parsedef "JE <- (__LWinit (J e) (!connective))";

Parsedef "JUE <- (__LWinit (J UE) (!connective))";

Parsedef "JIZA <- (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) (Z a) (!connective))";

Parsedef "JIOZA <- (__LWinit ((J IO) / (J AO)) (Z a) (!connective))";

Parsedef "JIZI <- (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) (Z i) (!connective))";

Parsedef "JIOZI <- (__LWinit ((J IO) / (J AO)) (Z i) (!connective))";


Parsedef "JIZU <- (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) (Z u) (!connective))";

Parsedef "JIOZU <- (__LWinit ((J IO) / (J AO)) (Z u) (!connective))";


Parsedef "JI <- !JIZA !JIZI !JIZU (__LWinit ((J IE) / (J AE) / (P e) / (J i) / (J a) / (N u J i)) (!connective))";

Parsedef "JIO <- !JIOZA !JIOZI !JIOZU (__LWinit ((J IO) / (J AO)) (!connective))";

Parsedef "DIO <- (__LWinit ((B EU) / (C AU) / (D IO) / (F OA) / (K AO) / (J UI) / (N EU) / (P OU) / (G OA) / (S AU) / (V EU) / (Z UA) / (Z UE) / (Z UI) / (Z UO) / (Z UU)) (!connective))";

Parsedef "LAE <- (__LWinit ((L AE) / (L UE)) (!connective))";

Parsedef "ME <- (__LWinit (M EA/(M e)) (!connective))";

Parsedef "MEU <- __LWinit M EU !connective";

Parsedef "NU0 <- (((N UO) / (F UO) / (J UO) / (N u) / (F u) / (J u)) )";

Parsedef "NU <- (__LWinit ((NU0 !((([ ])+ (NI0 / RA))) ((NI0 / RA))? (freemod)?))+ (!connective))";

Parsedef "PO1 <- (__LWinit ((P o) / (P u) / (Z o)) )";

Parsedef "PO1A <- (__LWinit ((P OI a) / (P UI a) / (Z OI a) / (P o Z a) / (P u Z a) / (Z o Z a)) )";

Parsedef "PO1E <- (__LWinit ((P OI e) / (P UI e) / (Z OI e)) )";

Parsedef "PO1I <- (__LWinit ((P OI i) / (P UI i) / (Z OI i) / (P o Z i) / (P u Z i) / (Z o Z i)) )";

Parsedef "PO1O <- (__LWinit ((P OI o) / (P UI o) / (Z OI o)) )";

Parsedef "PO1U <- (__LWinit ((P OI u) / (P UI u) / (Z OI u) / (P o Z u) / (P u Z u) / (Z o Z u)) )";

Parsedef "POSHORT1 <- (__LWinit ((P OI) / (P UI) / (Z OI)) )";

Parsedef "PO <- (__LWinit PO1 (!connective))";

Parsedef "POA <- (__LWinit PO1A (!connective))";

Parsedef "POE <- (__LWinit PO1E (!connective))";

Parsedef "POI <- (__LWinit PO1E (!connective))";

Parsedef "POO <- (__LWinit PO1O (!connective))";

Parsedef "POU <- (__LWinit PO1U (!connective))";

Parsedef "POSHORT <- (__LWinit POSHORT1 (!connective))";

Parsedef "DIE <- (__LWinit ((D IE) / (F IE) / (K AE) / (N UE) / (R IE)) (!connective))";

Parsedef "HOI <- (__LWinit ((H OI) / (L OI) / (L OA) / (S IA) / (S IE) / (S IU)) (!connective))";

Parsedef "JO <- (__LWinit ((NI0 / RA))? (J o) (!connective))";

Parsedef "KIE <- (__LWinit (K IE) (!connective))";

Parsedef "KIU <- (__LWinit (K IU) (!connective))";

Parsedef "KIE2 <- (__LWinit [(] (K IE) (!connective))/(__LWinit (K IE) [(] (!connective))";

Parsedef "KIU2 <- (__LWinit (K IU)[)] (!connective))/(__LWinit [)] (K IU) (!connective))";

Parsedef "SOI <- (__LWinit (S OI) (!connective))";

Parsedef "UI0 <- !Predicate ((UA / UE / UI / UO / UU / OA / OE / OI / OU / OO / IA / II / IO / IU / EA / EE / EI / EO / EU / AA / AE / AI / AO / AU / (B EA) / (B UO) / (C EA) / (C IA) / (C OA) / (D OU) / (F AE) / (F AO) / (F EU) / (G EA) / (K UO) / (K UU) / (R EA) / (N AO) / (N IE) / (P AE) / (P IU) / (S AA) / (S UI) / (T AA) / (T OE) / (V OI) / (Z OU) / (L OI) / (L OA) / (S IA) / (S II) / (T OE) / (S IU) / (C AO) / (C EU) / (S IE) / (S EU)) )";

Parsedef "NOUI <- ((__LWinit N [o] juncture? ([ ])* UI0 (!connective)) / (__LWinit UI0 NOI (!connective)))";

Parsedef "UI1 <- (__LWinit (UI0 / (NI F i)) (!connective))";

Parsedef "HUE <- (__LWinit (H UE) (!connective))";

Parsedef "NO1 <- (__LWinit !(KOU1) !(NOUI) (N o) !((__LWinit KOU)) !((([ ])* (JIO / JI/JIZA/JIOZA/JIZI/JIOZI/JIZU/JIOZU))) (!connective))";

Parsedef "AcronymicName <- (Acronym (&(end) / ',' / &(period) / &(Name) / &(CI)))";

Parsedef "DJAN <- (Name / AcronymicName)";

Parsedef "BI <- (__LWinit ((N u))? ((B IA) / (B IE) / (C IE) / (C IO) / (B IA) / (B [i])) (!connective))";

Parsedef "LWPREDA <- (((H e) / (D UA) / (D UI) / (B UA) / (B UI)) )";

Parsedef "PREDA <- (([ ])* &(caprule) (Predicate / LWPREDA /!([ ]) NI RA) !connective)";

Parsedef "guoa <- ((PAUSE)? (GUOA / GU) (freemod)?)";

Parsedef "guoe <- ((PAUSE)? (GUOE / GU) (freemod)?)";

Parsedef "guoi <- ((PAUSE)? (GUOI / GU) (freemod)?)";

Parsedef "guoo <- ((PAUSE)? (GUOO / GU) (freemod)?)";

Parsedef "guou <- ((PAUSE)? (GUOU / GU) (freemod)?)";

Parsedef "guo <- !guoa !guoi !guou ((PAUSE)? (GUO / GU) (freemod)?)";

Parsedef "guiza <- ((PAUSE)? (GUIZA / GU) (freemod)?)";

Parsedef "guizi <- ((PAUSE)? (GUIZI / GU) (freemod)?)";

Parsedef "guizu <- ((PAUSE)? (GUIZU / GU) (freemod)?)";

Parsedef "gui <- ((PAUSE)? (GUI / GU) (freemod)?)";

(* Parsedef "guia <- ((PAUSE)? (GUIA / GU) (freemod)?)"; *)

Parsedef "gue <- ((PAUSE)? (GUE / GU) (freemod)?)";

Parsedef "guea <- ((PAUSE)? (GUEA / GU) (freemod)?)";

Parsedef "guu <- ((PAUSE)? (GUU / GU) (freemod)?)";

Parsedef "guua <- ((PAUSE)? (GUUA / GU) (freemod)?)";

Parsedef "giuo <- ((PAUSE)? (GIUO / GU) (freemod)?)";

Parsedef "meu <- ((PAUSE)? (MEU / GU) (freemod)?)";

Parsedef "geu <- GEU";

Parsedef "gap <- ((PAUSE)? GU (freemod)?)";

Parsedef "juelink <- (JUE (freemod)? (term/PA2 freemod? gap?))";

Parsedef "links1 <- (juelink (((freemod)? juelink))* (gue)?)";

Parsedef "links <- ((links1 / (KA (freemod)? links (freemod)? KI (freemod)? links1)) (((freemod)? A1 (freemod)? links1))*)";

Parsedef "jelink <- (JE (freemod)? (term/PA2 freemod? gap?))";

Parsedef "linkargs1 <- (jelink (freemod)? (links/gue)?)";

Parsedef "linkargs <- ((linkargs1 / (KA (freemod)? linkargs (freemod)? KI (freemod)? linkargs1)) (((freemod)? A1 (freemod)? linkargs1))*)";

Parsedef "abstractpred <- ((POA (freemod)? uttAx (guoa)?) / (POA (freemod)? sentence (guoa)?) / (POE (freemod)? uttAx (guoe)?) / (POE (freemod)? sentence (guoe)?) / (POI (freemod)? uttAx (guoi)?) / (POI (freemod)? sentence (guoi)?) / (POO (freemod)? uttAx (guoo)?) / (POO (freemod)? sentence (guoo)?) / (POU (freemod)? uttAx (guou)?) / (POU (freemod)? sentence (guou)?) / (PO (freemod)? uttAx (guo)?) / (PO (freemod)? sentence (guo)?))";

Parsedef "predunit1 <- ((SUE / (NU (freemod)? GE (freemod)? despredE (((freemod)? geu (comma)?))?) / (NU (freemod)? PREDA) / ((comma)? GE (freemod)? descpred (((freemod)? geu (comma)?))?) / abstractpred / (ME (freemod)? argument1 (meu)?) / PREDA)) (freemod)?";

Parsedef "predunit2 <- (((NO1 (freemod)?))* predunit1)";

Parsedef "NO2 <- (!(predunit2) NO1)";

Parsedef "predunit3 <- ((predunit2 (freemod)? linkargs) / predunit2)";

Parsedef "predunit <- (((POSHORT (freemod)?))? predunit3)";

Parsedef "kekpredunit <- (((NO1 (freemod)?))* KA (freemod)? predicate (freemod)? KI (freemod)? predicate guu?)";

Parsedef "despredA <- ((predunit / kekpredunit) (((freemod)? CI (freemod)? (predunit / kekpredunit)))*)";

Parsedef "despredB <- ((!(PREDA) CUI (freemod)? despredC (freemod)? CA (freemod)? despredB) / despredA)";

Parsedef "despredC <- (despredB (((freemod)? despredB))*)";

Parsedef "despredD <- (despredB (((freemod)? CA (freemod)? despredB))*)";

Parsedef "despredE <- (despredD (((freemod)? despredD))*)";

Parsedef "descpred <- ((despredE (freemod)? GO (freemod)? descpred) / despredE)";



Parsedef "sentpred <- ((despredE (freemod)? GO (freemod)? barepred) / despredE)"; 

Parsedef "mod1a <- (PA3 freemod? argument1 (guua)?)";

Parsedef "mod1 <- ((PA3 freemod? argument1 (guua)?) / (PA2 freemod? !(barepred) (gap)?))";

Parsedef "kekmod <- (((NO1 (freemod)?))* (KA (freemod)? modifier (freemod)? KI (freemod)? mod))";

Parsedef "mod <- (mod1 / (((NO1 (freemod)?))* mod1) / kekmod)";

Parsedef "modifier <- ((mod) ((A1 (freemod)? mod))*)";



Parsedef "maybebreak <- (V1 stress? ' ' !((([ ])* V1)))";

Parsedef "realbreak <- (!(maybebreak) letter (stress)? ((([,])? ' ') / period / &(end)))";

Parsedef "consonantbreak <- (C1 (stress)? ((([,])? ' ') / period / &(end)))";

Parsedef "badspaces <- (!(([,] ' ')) ((!((maybebreak / realbreak)) .))* maybebreak ((!(realbreak) .))* consonantbreak)";

Parsedef "namemarker <- ((([ ])* ((L a) / (H OI) / (L OI) / (L OA) / (S IE) / (S IA) / (S IU) / (C i) / (H UE) / (L IU) / (G AO))) !(badspaces))";

Parsedef "nonamemarkers <- (([ ])* ((!((namemarker Name)) Letter))+ !(Letter))";

Parsedef "CI0 <- ([Cc] i &([ ]* C1))";

Parsedef "name <- DJAN (CI0 DJAN / CI !badspaces comma? predunit !(&nonamemarkers Name) / CI comma? DJAN / &nonamemarkers Name)* freemod?";

Parsedef "LA0 <- (([Ll] a) !(badspaces))";

Parsedef "LANAME <- (([ ])* LA0 (CANCELPAUSE / (([ ])* &(C1))) name)";

Parsedef "LANAME2 <- (([ ])* LA0 ((',' ([ ])+) / (([ ])* &(V1))) name)";

Parsedef "HOI0 <- ((([Hh] OI) / ([Ll] OI) / ([Ll] OA) / ([Ss] IA) / ([Ss] IE) / ([Ss] IU)) !(badspaces))";

Parsedef "voc <- ((([ ])* HOI0 (CANCELPAUSE / (([ ])* &(C1))) name) / (HOI !(badspaces) (freemod)? descpred guea? (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))?) / (HOI !(badspaces) (freemod)? argument1 (guua)?) / (([ ])* HOI0 ((',' ([ ])+) / (([ ])* &(V1))) name) / (H OI stringnospacesclosedblock))";

Parsedef "descriptn <- (!(LANAME) ((LAU wordset1) / (LOU wordset2) / (LE (freemod)? ((((!(mex) arg1a (freemod)?))? ((PA2 (freemod)?))?))? mex (freemod)? descpred) /(LE (freemod)? ((((!(mex) arg1a (freemod)?))? ((PA2 (freemod)?))?))? mex (freemod)? arg1a) / (GE (freemod)? mex (freemod)? descpred) / (LE (freemod)? ((((!(mex) arg1a (freemod)?))? ((PA2 (freemod)?))?))? descpred)))";

Parsedef "abstractn <- ((LEFORPO (freemod)? POA (freemod)? uttAx (guoa)?) / (LEFORPO (freemod)? POA (freemod)? sentence (guoa)?) / (LEFORPO (freemod)? POE (freemod)? uttAx (guoe)?) / (LEFORPO (freemod)? POE (freemod)? sentence (guoe)?) / (LEFORPO (freemod)? POI (freemod)? uttAx (guoi)?) / (LEFORPO (freemod)? POI (freemod)? sentence (guoi)?) / (LEFORPO (freemod)? POO (freemod)? uttAx (guoo)?) / (LEFORPO (freemod)? POO (freemod)? sentence (guoo)?) / (LEFORPO (freemod)? POU (freemod)? uttAx (guou)?) / (LEFORPO (freemod)? POU (freemod)? sentence (guou)?) / (LEFORPO (freemod)? PO (freemod)? uttAx (guo)?) / (LEFORPO (freemod)? PO (freemod)? sentence (guo)?))";

Parsedef "arg1 <- (abstractn / (LIO (freemod)? descpred (guea)?) / (LIO (freemod)? argument1 (guua)?) / (LIO (freemod)? mex (gap)?) / (LIO stringnospaces) / LAO / LANAME /(descriptn  guua? (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))?) / LANAME2 / LIU1 / LIE / LI)";

Parsedef "arg1a <- ((DA / TAI / arg1 / (GE (freemod)? arg1a))) (freemod)?";

Parsedef "argmod1 <- ( ((__LWinit (N o) ([ ])*))? ((JI (freemod)? predicate) / (JIO (freemod)? sentence) / (JIO (freemod)? uttAx) / (JI (freemod)? modifier) / (JI (freemod)? argument1))) / (((__LWinit (N o) ([ ])*))? ((JIZA (freemod)? predicate) guiza? / (JIOZA (freemod)? sentence) guiza? / (JIOZA (freemod)? uttAx) guiza?/ (JIZA (freemod)? modifier) guiza?/ (JIZA (freemod)? argument1 guiza?)))/( ((__LWinit (N o) ([ ])*))? ((JIZI (freemod)? predicate guizi?) / (JIOZI (freemod)? sentence guizi?) / (JIOZI (freemod)? uttAx guizi?) / (JIZI (freemod)? modifier guizi?) / (JIZI (freemod)? argument1 guizi?))) /( ((__LWinit (N o) ([ ])*))? ((JIZU (freemod)? predicate guizu?) / (JIOZU (freemod)? sentence guizu?) / (JIOZU (freemod)? uttAx guizu?) / (JIZU (freemod)? modifier guizu?) / (JIZU (freemod)? argument1 guizu?))) ";

Parsedef "argmod <- (argmod1 ((A1 (freemod)? argmod1))* gui?)";

Parsedef "arg2 <- (arg1a freemod? ((argmod))*)";

Parsedef "arg3 <- (arg2 / (mex (freemod)? arg2))";

Parsedef "indef1 <- (mex (freemod)? descpred)";

Parsedef "indef2 <- (indef1 (guua)? ((argmod))*)";

Parsedef "indefinite <- indef2";

Parsedef "arg4 <- ((arg3 / indefinite) ((ZE2 (freemod)? (arg3 / indefinite)))*)";

Parsedef "arg5 <- (arg4 / (KA (freemod)? argument1 (freemod)? KI (freemod)? argx))";

Parsedef "argx <- (((NO1 (freemod)?))* (((LAE) (freemod)?))* arg5)";

Parsedef "arg7 <- (argx freemod? ((ACI (freemod)? argx))?)";

Parsedef "arg8 <- (!(GE) (arg7 freemod? ((A1 (freemod)? arg7))*))";

Parsedef "argument1 <- (((arg8 freemod? AGE (freemod)? argument1) / arg8) ((GUU (freemod)? argmod))*)";

Parsedef "argument <- (((NO1 (freemod)?))* ((DIO (freemod)?))* argument1)";

Parsedef "argumentA <- argument";

Parsedef "argumentB <- argument";

Parsedef "argumentC <- argument";

Parsedef "argumentD <- argument";

Parsedef "argxx <- (&((((NO1 (freemod)?))* DIO)) argument)";

Parsedef "term <- (argument / modifier)";

Parsedef "modifiers <- (modifier (((freemod)? modifier))*)";

Parsedef "modifiersx <- ((modifier / argxx) (((freemod)? (modifier / argxx)))*)";

Parsedef "terms <- (((modifiersx)? argumentA (((freemod)? modifiersx))? (argumentB)? (((freemod)? modifiersx))? (argumentC)? (((freemod)? modifiersx))? (argumentD)?) / modifiersx)";

Parsedef "word <- (arg1a / indef2)";

Parsedef "words1 <- (word ((ZEIA word))*)";

Parsedef "words2 <- (word ((ZEIO word))*)";

Parsedef "wordset1 <- ((words1)? LUA)";

Parsedef "wordset2 <- ((words2)? LUO)";

Parsedef "termset1 <- ((terms / (KA (freemod)? termset2 (freemod)? guu? KI (freemod)? termset1)))";

Parsedef "termset2 <- (termset1 (guu &A1)? ((A1 (freemod)? termset1 (guu &A1)?))*)";

Parsedef "termset <- ((terms (freemod)? GO (freemod)? barepred) / termset2)";

(* Parsedef "kekpred <- (kekpredunit (((freemod)? despredD))* )"; *)

(* Parsedef "barepred <- ((sentpred (freemod)? (termset)?) / (kekpred (freemod)? (termset)?))"; *)

Parsedef "barepred <- ((sentpred (freemod)? (termset guu?/guu &termset)?))";

Parsedef "markpred <- (PA1 freemod? barepred)";

Parsedef "backpred1 <- (((NO2 (freemod)?))* (barepred / markpred))";

Parsedef "backpred <- (((backpred1 ((ACI (freemod)? backpred1))+ (freemod)? (termset guu?/guu &termset)?) ((((ACI (freemod)? backpred))+ (freemod)? (termset guu?/guu &termset)?))?) / backpred1)";

Parsedef "predicate2 <- (!(GE) (((backpred ((A1 !(GE) (freemod)? backpred))+ (freemod)? (termset guu?/guu &termset)?) ((((A1 (freemod)? predicate2))+ (freemod)? (termset guu?/guu &termset)?))?) / backpred))";

Parsedef "predicate1 <- ((predicate2 AGE (freemod)? predicate1) / predicate2)";

Parsedef "identpred <- (((NO1 (freemod)?))* (BI (freemod)? argument1 guu?))";

Parsedef "predicate <- (predicate1 / identpred)";

Parsedef "subject <- (((modifiers (freemod)?))? ((argxx subject) / (argument ((modifiersx (freemod)?))?)))";

Parsedef "gasent1 <- (((NO1 (freemod)?))* (PA1 (freemod)? barepred ((GA2 (freemod)? subject))?))";

Parsedef "gasent2 <- (((NO1 (freemod)?))* (PA1 (freemod)? sentpred (modifiers)? (GA2 (freemod)? subject freemod? GIO? freemod? terms?)))";

Parsedef "gasent <- (gasent2 / gasent1)";

Parsedef "statement <- (gasent / (modifiers (freemod)? gasent) / (subject (freemod)? ((GIO (freemod)? terms))? predicate))";

Parsedef "keksent <- (((NO1 (freemod)?))* ((KA (freemod)? sentence (freemod)? KI (freemod)? uttA1) / (KA sentence (freemod)? KI (freemod)? uttA1) / (KA (freemod)? headterms (freemod)? sentence (freemod)? KI (freemod)? uttA1)))";

Parsedef "neghead <- (NO1 freemod? gap/NO2 PAUSE)";

Parsedef "sen1 <- (neghead freemod?)* ((modifiers (freemod)? !(gasent) predicate) / statement / predicate / keksent)";

Parsedef "sentence <- (sen1 ((ICA (freemod)? sen1))*)";

Parsedef "headterms <- ((terms GI))+";

Parsedef "uttAx <- (headterms (freemod)? sentence (giuo)?)";

Parsedef "HUE0 <- ([Hh] UE)";

Parsedef "invvoc <- ( (([ ])* HUE0 (CANCELPAUSE / (([ ])* &(C1))) name) / (HUE !(badspaces) (freemod)? descpred guea? (((((comma)? CI (comma)?) / (comma &(nonamemarkers) !(AcronymicName))) name))?) / (HUE !(badspaces) (freemod)? statement (giuo)?) /(HUE !(badspaces) (freemod)? argument1 guu?) / (([ ])* HUE0 ((',' ([ ])+) / (([ ])* &(V1))) name) / (HUE stringnospacesclosedblock) )";

Parsedef "freemod <- ((NOUI / (SOI (freemod)? descpred (guea)?) / DIE / (NO1 DIE) / (KIE (comma)? utterance0 (comma)? KIU) / (KIE2 (comma)? utterance0 (comma)? KIU2) / invvoc / voc / CANCELPAUSE / comma !(&nonamemarkers Name) / JO / UI1 / (([ ])* '...' ((([ ])* &(letter)))?) / (([ ])* '--' ((([ ])* &(letter)))?)) (freemod)?)";

Parsedef "uttA <- ((A1 /  mex) (freemod)?)";

Parsedef "uttA1 <- ((sen1 / uttAx / links / linkargs / argmod / (modifiers (freemod)? keksent) / terms / uttA /NO1) (freemod)? (period)?)";

(* Parsedef "neghead <- (NO1 gap/NO2 PAUSE)"; *)

Parsedef "uttC <- ((neghead freemod? uttC) / uttA1)";

(* Parsedef "uttD <- (&neghead(uttC ((ICI (freemod)? uttD))* )/(sentence (period)? !(ICI) !(ICA))/(uttC ((ICI (freemod)? uttD))* ))"; *)
Parsedef "uttD <- ((sentence (period)? !(ICI) !(ICA))/(uttC ((ICI (freemod)? uttD))*))"; 
Parsedef "uttE <- (uttD ((ICA (freemod)? uttD))*)";

Parsedef "uttF <- (uttE ((I (freemod)? uttE))*)";

Parsedef "utterance0 <- (!(GE) ((!(PAUSE) freemod (period)? utterance0) / (!(PAUSE) freemod (period)?) / (uttF IGE utterance0) / uttF / (I (freemod)? (uttF)?) / (I (freemod)? (period)?) / (ICA (freemod)? uttF)) ((&(I) utterance0))?)";

Parsedef "utterance <- (!(GE) ((!(PAUSE) freemod (period)? utterance) / (!(PAUSE) freemod (period)? ((&(I) utterance))? end) / (uttF IGE utterance) / (I (freemod)? (period)? ((&(I) utterance))? end) / (uttF ((&(I) utterance))? end) / (I (freemod)? uttF ((&(I) utterance))? end) / (ICA (freemod)? uttF ((&(I) utterance))? end)))";

fun niceprecs() = (unreallyverbose();
hide "Predicate";
hide "Name";
hide "LAE";
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
(* hide "IE1"; *)
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


