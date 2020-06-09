(* mark2 representation of CAPSL *)
(* Implementation of modal logic *)
(* This file contains "declarations" and "logic axioms" *)

(* Needham-Schroeder Protocol *)

script "capsl_svo";


(* The Messages *)
(* 1. A->S: A,B,Na                        *)
(* 2. S->A: {Na,B,Kab,{Kab,A}Kbs}Kas      *)
(* 3. A->B: {Kab,A}Kbs                    *)
(* 4: B->A: {Nb}Kab                       *)
(* 5: A->B: {Nb-1}Kab                     *)

declareinfix "-";

declareconstant "A";
declareconstant "B";
declareconstant "S";
declareconstant "Kab";
declareconstant "Kas";
declareconstant "Kbs";
declareconstant "Na";
declareconstant "Nb";

(* Axioms from the above Protocol *)


axiom "P_1A" "A `BELIEVES (Fresh@(Na))" "true";

axiom "P_1B" "B `BELIEVES (Fresh@(Nb))" "true";

axiom "P_2A" "A `BELIEVES (S `CONTROLS (shared_key@(A,B,Kab)))" "true";

axiom "P_2B" "B `BELIEVES (S `CONTROLS (shared_key@(A,B,Kab)))" "true";

axiom "P_3A" "A `BELIEVES (S `CONTROLS (Fresh@(Skey:Kab)))" "true";

axiom "P_3B" "B `BELIEVES (S `CONTROLS (Fresh@(Skey:Kab)))" "true";

axiom "P_4A" "A `BELIEVES (shared_key@(A,S,Kas))" "true";

axiom "P_4B" "B `BELIEVES (shared_key@(B,S,Kbs))" "true";

axiom "P_5" "A `RECEIVED (Kas `se ((Na),(Principal:B),(Key:Kab),(Kbs `se ((Key:Kab),(Principal:A)))))" "true";

axiom "P_6" "B `RECEIVED (Kbs `se ((Key:Kab),(Principal:A)))" "true";

axiom "P_7" "A `RECEIVED (Kab `se Nb)" "true";

axiom "P_8" "B `RECEIVED (Kab `se (Nb - 1))" "true";

axiom "P_9" "A `BELIEVES (A `RECEIVED (Kas `se ((Na),(Principal:B),(Message:?x),(Message:?y))))" "true";

axiom "P_10" "B `BELIEVES (B `RECEIVED (Kbs `se ((Message:?z),(Principal:A))))" "true";

axiom "P_11" "B `BELIEVES (B `RECEIVED ((Message:?z) `se (Nb - 1)))" "true";

axiom "P_12A" "A `BELIEVES ((A `RECEIVED (Kas `se ((Na),(Principal:B),(Message:?x),(Message:?y)))) -> (A `RECEIVED (Kas `se ((Na),(Principal:B),((shared_key@(A,B,Kab)),(Fresh@(Skey:Kab))),(Message:?y)))))" "true";

axiom "P_13B" "B `BELIEVES ((B `RECEIVED (Kbs `se ((Message:?z),(Principal:A)))) -> (B `RECEIVED (Kbs `se (((shared_key@(A,B,Kab)),(Fresh@(Skey:Kab))),(Principal:A)))))" "true";

axiom "P_14" "B `BELIEVES (((B `RECEIVED (Kbs `se ((Message:?z),(Principal:A)))) & (B `RECEIVED ((Message:?z) `se (Nb - 1)))) -> (B `RECEIVED (Kab `se (Nb - 1))))" "true";

(* HOLMES: axiom handling verification that message S->A is from S *)

axiom "P_15" "A `BELIEVES ((A `RECEIVED Kas `se Na,?x)->(A `RECEIVED_FROM S,Kas `se Na,?x))" "true";

quit();



