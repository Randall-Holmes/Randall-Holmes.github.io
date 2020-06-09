(* mark2 representation of CAPSL *)
(* Implementation of modal logic *)
(* This file contains capsl related "axioms" *)



script "capsl_defination_file";



(*axioms for se, sd, sed *)

(* TYPE axioms           *)

axiom "SD_TYPE" "?x `sd ?y" "Message:(Skey:?x) `sd Message:?y";
axiom "SE_TYPE" "?x `se ?y" "Message:(Skey:?x) `se Message:?y";
axiom "SED_TYPE" "?x `sed ?y" "Message:(Skey:?x) `sed Message:?y";

axiom "SED_AXIOM1" "?k `sd (?k `se ?x)" "Message:?x";
axiom "SED_AXIOM2" "?k `se (?k `sd ?x)" "Message:?x";
axiom "SED_AXIOM3" "?k `sed (?k `sed ?x)" "Message:?x";



(*axioms for Pkey, Skey, Keypair and INV *)

axiom "PKEY_IS_KEY" "Pkey:?x" "Key:Pkey:?x";
axiom "pKEY_IS_PKEY" "pkey:?x" "Pkey:pkey:?x";
axiom "sKEY_IS_PKEY" "skey:?x" "Pkey:skey:?x";

axiom "SKEY_IS_KEY" "Skey:?x" "Key:Skey:?x";
axiom "INV_TYPE" "`INV(?x)" "Key:(`INV(Key:?x))"; 
axiom "SYMM_KEY_INV" "`INV(Skey:?x)" "Skey:?x";

a "KEYPAIR_TYPE"  "keypair@?x,?y" "prop:keypair@(pkey:?x),skey:?y";
a "PKEY_INV1" "(keypair@?pkey,?skey)-> (`INV ?pkey) = Pkey:?skey" "true"; 
a "PKEY_INV2" "(keypair@?pkey,?skey)-> (`INV ?skey) = Pkey:?pkey" "true"; 




(*axioms for pe, pd, ped *)

axiom "PE_TYPE" "?x `pe ?y" "Message: (pkey:?x) `pe Message:?y";
axiom "PD_TYPE" "?x `pe ?y" "Message: (skey:?x) `pd Message:?y";
axiom "PED_TYPE" "?x `ped ?y" "Message: (Pkey:?x) `ped Message:?y";

a "PED_AXIOM1" "(keypair@?pk,?sk)->?pk `pd (?sk `pe ?x) = Message:?x" "true";
a "PED_AXIOM2" "(keypair@?pk,?sk)->?sk `pd (?pk `pe ?x) = Message:?x" "true";
a "PED_AXIOM3" "(keypair@?pk,?sk)->?pk `pe (?sk `pd ?x) = Message:?x" "true";
a "PED_AXIOM4" "(keypair@?pk,?sk)->?sk `pe (?pk `pd ?x) = Message:?x" "true";
a "PED_AXIOM5" "(keypair@?pk,?sk)->?sk `ped (?pk `ped ?x) = Message:?x" "true";
a "PED_AXIOM6" "(keypair@?pk,?sk)->?pk `ped (?sk `ped ?x) = Message:?x" "true";



(*axioms for PKE, PKA, PKS, SV *)

axiom "SHARED_TYPE" "shared_key@?x,?y,?k" "prop:shared_key@((Principal:?x),(Principal:?y),Skey:?k)";
axiom "PKE_TYPE" "pke@?x,?k" "prop:pke@(Principal:?x),pkey:?k";
axiom "PKS_TYPE" "pks@?x,?k" "prop:pks@(Principal:?x),skey:?k";
axiom "PKA_TYPE" "pka@?x,?k" "prop:pka@(Principal:?x),Pkey:?k";
axiom "SV_TYPE" "sv@?x,?k,?y" "prop:sv@((Message:?x),(Pkey:?k),(Message:?y))";




(* Message Axioms *)

axiom "KEY_IS_MESSAGE" "Key:?y" "Message:Key:?y";
axiom "PRINCIPAL_IS_MESSAGE" "Principal:?x" "Message:Principal:?x";
axiom "PROP_IS_MESSAGE" "prop:?y" "Message:prop:?y";
axiom "MESSAGE_TYPE" "Message:?x,?y" "Message:(Message:?x),Message:?y";



(* Believe Axioms *)

axiom "BELIEVE_TYPE" "?x `BELIEVES ?y" "prop:(Principal:?x) `BELIEVES prop:?y";
axiom "BELIEVE_AND" "?P `BELIEVES (?x & ?y)" "((?P `BELIEVES ?x) & (?P `BELIEVES ?y))";
axiom "BELIEVE_IMP" "((?P `BELIEVES (?x -> ?y)) -> ((?P `BELIEVES ?x) -> (?P `BELIEVES ?y)))" "true";



(* Holds axioms *)

axiom "HOLDS_TYPE" "?x `HOLDS ?y" "prop:Principal:?x `HOLDS Key:?y";
axiom "HOLDS_AXIOM" "?P `HOLDS (?x,?y)" "((?P `HOLDS ?x)& (?P `HOLDS ?y))";



(* Recieve and Recieve_from axioms *)

a "RECEIVED_TYPE" "?x `RECEIVED ?y" "prop:Principal:?x `RECEIVED Message:?y";
axiom "RECEIVE_FROM_TYPE" "?x `RECEIVED_FROM (?y,?z)" "prop:(Principal:?x `RECEIVED_FROM (Principal:?y,Message:?z))";
axiom "RECEIVED_AXIOM" "?P `RECEIVED (?x,?y)" "((?P `RECEIVED ?x) & (?P `RECEIVED ?y))";



(* said, says, sees axioms *)

axiom "SAID_TYPE" "?x `SAID ?y" "prop:Principal:?x `SAID Message:?y";
axiom "SAID_AXIOM" "?P `SAID (?x,?y)" "((?P `SAID ?x) & (?P `SAID ?y))";
axiom "SAYS_TYPE" "?x `SAYS ?y" "prop:Principal:?x `SAYS Message:?y";
axiom "SAYS_AXIOM" "?P `SAYS (?x,?y)" "((?P `SAYS ?x) & (?P `SAYS ?y))";
axiom "SEES_TYPE" "?x `SEES ?y" "prop:Principal:?x `SEES Message:?y";



(* Misc. axioms *)

axiom "CONTROLS_TYPE" "?x `CONTROLS ?y" "prop:Principal:?x `CONTROLS prop:?y";
axiom "FRESH_TYPE" "Fresh@?x" "prop:Fresh@Message:?x";
a "SHARED_KEY_IMP_SEES_KEY" "((shared_key@?x,?y,?k) -> (?x `SEES ?k))" "true";
a "RECEIVEDFROM_IS_RECEIVED" "((?x `RECEIVED_FROM (?y , ?z)) -> (?x `RECEIVED ?z))" "true";
a "BELIEVES_BELIEVES_IS_BELIEVES" "?P `BELIEVES ?P `BELIEVES ?si" "?P `BELIEVES ?si";


axiom "NECESSITATION" "?A `BELIEVES true" "true";

axiom "SAID_IMP1" "((?P `SAID (?x , ?y)) -> (?P `SAID ?x))" "true";

axiom "SAID_IMP2" "((?P `SAID (?x , ?y)) -> (?P `SAID ?x))" "true";


quit();




