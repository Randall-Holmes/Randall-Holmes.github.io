(* mark2 representation of CAPSL *)
(* Implementation of modal logic *)
(* This file contains "declarations" and "logic axioms" *)


script "structural";
script "typestuff";
script "prop_logic";



(* declarations of logical operators *)

(* declareconstant "prop";  (* type of statements *) *)
declareconstant "Principal";
declareconstant "Message";
declareconstant "Fresh";

declareconstant "Key";     (* Pkey and Skey are Key *)
declareconstant "Skey";
declareconstant "Pkey";    (* pkey and skey are Pkey *)
declareconstant "pkey";
declareconstant "skey";
declareconstant "keypair"; (* syntax keypair@?key1,?key2 *)


declareunary "`INV";  
declareinfix "`RECEIVED";
declareinfix "`RECEIVED_FROM";
declareinfix "`SAID";
declareinfix "`SEES";
declareinfix "`SAYS";
declareinfix "`BELIEVES";
declareinfix "`HOLDS";
declareinfix "`KNOWS";
declareinfix "`CONTROLS";

declareinfix "`se";            (* encryption *)
declareinfix "`sd";            (* decryption *)
declareinfix "`sed";           (* encrpt-decrypt *)
declareunary "`sha";
declareinfix "`pe";            (* encrypting with secret key *)
declareinfix "`pd";            (* decrypting with public key *)
declareinfix "`ped";           (* public key encrypt-decrypt *)




(* more definations *)



(* for shared key   *)
declareconstant "shared_key"; (* syntax: shared_key@?prin1,?prin2,?key *)

(* for public key encryption *)
declareconstant "pke"; (* syntax: pke?prin,?key *)

(* for public key agreement *)
declareconstant "pka"; (* syntax agreement@Principal:?x,?key *)

(* for public key signature *)
declareconstant "pks"; (*syntax pks@?Principal,?key *)

(* for signature verification *)
declareconstant "sv"; (* syntax sv@?messg1,?key,?messg2 *)

(* logical axioms *)

(*axioms for AND *)

axiom "AND_TYPE" "?x&?y" "prop:(prop:?x)&prop:?y"; 

initializecounter();
s "?x&?y";
ri "CTYPE";ex();
ri "PROP";ex();
right();left();
ri "PROP";ex();
up();right();
ri "PROP";ex();
top();
proveanaxiom "AND_TYPE";

axiom "AND_COMM" "?x&?y" "?y&?x"; 

s "?x&?y";
ri "DUAL@DSYM";
ex();
proveanaxiom "AND_COMM";

axiom "AND_TRUE" "true&?x" "prop:?x";   

s "true&?x";
ri "AND_COMM";ex();
ri "DUAL@DID"; ex();
ri "PROP";ex();
proveanaxiom "AND_TRUE";

axiom "AND_FALSE" "false&?x" "false";     

s "false&?x";
ri "AND_COMM";ex();
ri "DUAL@DZER";ex();
proveanaxiom "AND_FALSE";


axiom "AND_ASSOC" "?x&(?y&?z)" "(?x&?y)&?z"; 

s "?x&(?y&?z)";
rri "CASSOC";ex();
proveanaxiom "AND_ASSOC";




(*axioms for OR *)

axiom "OR_TYPE" "?x|?y" "prop:(prop:?x)|prop:?y";
s "?x|?y";
ri "DTYPE"; ex();
ri "EVERYWHERE2@PROP"; ex();
proveanaxiom "OR_TYPE";

axiom "OR_COMM" "?x|?y" "?y|?x"; 

s "?x|?y";
ri "DSYM"; ex();
proveanaxiom "OR_COMM";

axiom "OR_TRUE" "true|?x" "true";

s "true|?x";
ri "DSYM"; ri "DZER"; ex();
proveanaxiom "OR_TRUE";

axiom "OR_FALSE" "false|?x" "prop:?x";

s "false|?x";
ri "DSYM"; ri "DID"; ri "PROP"; ex();
proveanaxiom "OR_FALSE";

axiom "OR_ASSOC" "?x|(?y|?z)" "(?x|?y)|?z";

s "?x|(?y|?z)";
rri "DASSOC"; ex();
proveanaxiom "OR_ASSOC";




(*axioms for NOT *)
axiom "NOT_TYPE" "~?x" "prop: ~prop:?x";

s "prop: ~prop:?x";
ri "EVERYWHERE2@ $PROP"; ri "NRULE1"; ri "NRULE2"; ex();
wb();
proveanaxiom "NOT_TYPE";

axiom "NOT_TRUE" "~true" "false";

s "~true";
rri "FDEF"; ex();
proveanaxiom "NOT_TRUE";

axiom "NOT_FALSE" "~false" "true";

s "~false";
ri "NEGF"; ex();
proveanaxiom "NOT_FALSE";



(*axioms for IMP *)

axiom "IMP_TYPE" "?x -> ?y" "prop:(prop:?x) -> prop:?y";

s "?x -> ?y";
ri "IMPTYPE"; ri "EVERYWHERE2@PROP"; ex();
proveanaxiom "IMP_TYPE";

axiom "IMP_TRUE" "true->?x" "prop:?x";

s "true->?x";
ri "ILID"; ri "PROP"; ex();
proveanaxiom "IMP_TRUE";

axiom "IMP_FALSE" "false->?x" "true";

s "false->?x";
ri "3pt75"; ex();
proveanaxiom "IMP_FALSE";


quit();
