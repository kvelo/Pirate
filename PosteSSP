(* ======================================================================
   SSP - Poste standard (modèle : Landivisiau, zone 101)
   9 équipements x 2 nœuds = 18 nœuds locaux, 16 liaisons fixes.

   Règle de numérotation :
     équipement e (0..8) -> nœud A = 2*e, nœud B = 2*e + 1 (indices locaux)
     indice global d'un nœud = BaseNoeud + indice local

   Principe de propagation :
     - une liaison fixe est toujours active
     - les nœuds A et B d'un équipement sont reliés si l'équipement est fermé
   ====================================================================== *)


(* ---------- 1. CONSTANTES DU MODÈLE SSP ---------- *)
VAR_GLOBAL CONSTANT
    SSP_NB_EQUIP    : INT := 9;
    SSP_NB_NOEUDS   : INT := 18;
    SSP_NB_LIAISONS : INT := 16;

    (* Indices locaux des équipements *)
    SSP_EQ_SAT1 : INT := 0;    (* sectionneur autotransformateur 1 *)
    SSP_EQ_IL1  : INT := 1;    (* interrupteur de ligne 1 : voie 1 amont *)
    SSP_EQ_IL3  : INT := 2;    (* interrupteur de ligne 3 : voie 1 aval *)
    SSP_EQ_IMP  : INT := 3;    (* interrupteur de mise en parallèle V1/V2 *)
    SSP_EQ_IL2  : INT := 4;    (* interrupteur de ligne 2 : voie 2 amont *)
    SSP_EQ_IL4  : INT := 5;    (* interrupteur de ligne 4 : voie 2 aval *)
    SSP_EQ_SAT2 : INT := 6;    (* sectionneur autotransformateur 2 *)
    SSP_EQ_SPV1 : INT := 7;    (* sectionnement de pontage voie 1 (S31-41 à Landivisiau) *)
    SSP_EQ_SPV2 : INT := 8;    (* sectionnement de pontage voie 2 (S30-40 à Landivisiau) *)

    (* Indices locaux des nœuds *)
    SSP_N_SAT1_A : INT := 0;   (* barre V1 *)
    SSP_N_SAT1_B : INT := 1;   (* côté AT1 *)
    SSP_N_IL1_A  : INT := 2;   (* barre V1 *)
    SSP_N_IL1_B  : INT := 3;   (* tronçon voie 1 amont *)
    SSP_N_IL3_A  : INT := 4;   (* barre V1 *)
    SSP_N_IL3_B  : INT := 5;   (* tronçon voie 1 aval *)
    SSP_N_IMP_A  : INT := 6;   (* côté barre V1 *)
    SSP_N_IMP_B  : INT := 7;   (* côté barre V2 *)
    SSP_N_IL2_A  : INT := 8;   (* barre V2 *)
    SSP_N_IL2_B  : INT := 9;   (* tronçon voie 2 amont *)
    SSP_N_IL4_A  : INT := 10;  (* barre V2 *)
    SSP_N_IL4_B  : INT := 11;  (* tronçon voie 2 aval *)
    SSP_N_SAT2_A : INT := 12;  (* barre V2 *)
    SSP_N_SAT2_B : INT := 13;  (* côté AT2 *)
    SSP_N_SPV1_A : INT := 14;  (* tronçon voie 1 amont *)
    SSP_N_SPV1_B : INT := 15;  (* tronçon voie 1 aval *)
    SSP_N_SPV2_A : INT := 16;  (* tronçon voie 2 amont *)
    SSP_N_SPV2_B : INT := 17;  (* tronçon voie 2 aval *)

    (* Liaisons fixes : la liaison i relie SSP_LIENS[2*i] et SSP_LIENS[2*i + 1] *)
    SSP_LIENS : ARRAY[0..31] OF INT := [
        0, 2,     (* SAT1_A - IL1_A    barre V1 *)
        0, 4,     (* SAT1_A - IL3_A *)
        0, 6,     (* SAT1_A - IMP_A *)
        2, 4,     (* IL1_A  - IL3_A *)
        2, 6,     (* IL1_A  - IMP_A *)
        4, 6,     (* IL3_A  - IMP_A *)
        7, 8,     (* IMP_B  - IL2_A    barre V2 *)
        7, 10,    (* IMP_B  - IL4_A *)
        7, 12,    (* IMP_B  - SAT2_A *)
        8, 10,    (* IL2_A  - IL4_A *)
        8, 12,    (* IL2_A  - SAT2_A *)
        10, 12,   (* IL4_A  - SAT2_A *)
        3, 14,    (* IL1_B  - SPV1_A   tronçon voie 1 amont *)
        5, 15,    (* IL3_B  - SPV1_B   tronçon voie 1 aval *)
        9, 16,    (* IL2_B  - SPV2_A   tronçon voie 2 amont *)
        11, 17    (* IL4_B  - SPV2_B   tronçon voie 2 aval *)
    ];

    (* Dimensionnement du réseau : À AJUSTER selon la zone *)
    RES_MAX_EQUIP  : INT := 120;
    RES_MAX_ARETES : INT := 400;
END_VAR


(* ---------- 2. VARIABLES GLOBALES DU RÉSEAU ---------- *)
VAR_GLOBAL
    (* Arêtes du graphe : nœud 1, nœud 2, équipement qui commande l'arête.
       Arete_Equip = -1 pour une liaison fixe, sinon indice global de l'équipement *)
    Arete_N1    : ARRAY[0..399] OF INT;
    Arete_N2    : ARRAY[0..399] OF INT;
    Arete_Equip : ARRAY[0..399] OF INT;
    Nb_Aretes   : INT := 0;

    (* État des équipements (TRUE = fermé), recopié depuis les variables PIRATE *)
    Equip_Ferme : ARRAY[0..119] OF BOOL;
END_VAR


(* ---------- 3. CONSTRUCTION DES NŒUDS D'UN SSP ---------- *)
(* Ajoute au graphe les arêtes d'un poste SSP.
   BaseNoeud : indice global du 1er nœud du poste
   BaseEquip : indice global du 1er équipement du poste
   Retourne FALSE si les tableaux sont trop petits (rien n'est ajouté). *)
FUNCTION Init_SSP : BOOL
VAR_INPUT
    BaseNoeud : INT;
    BaseEquip : INT;
END_VAR
VAR
    i : INT;
END_VAR

    IF (Nb_Aretes + SSP_NB_LIAISONS + SSP_NB_EQUIP > RES_MAX_ARETES)
       OR (BaseEquip + SSP_NB_EQUIP > RES_MAX_EQUIP) THEN
        Init_SSP := FALSE;
        RETURN;
    END_IF;

    (* Liaisons fixes : toujours actives *)
    FOR i := 0 TO SSP_NB_LIAISONS - 1 DO
        Arete_N1[Nb_Aretes]    := BaseNoeud + SSP_LIENS[2 * i];
        Arete_N2[Nb_Aretes]    := BaseNoeud + SSP_LIENS[2 * i + 1];
        Arete_Equip[Nb_Aretes] := -1;
        Nb_Aretes := Nb_Aretes + 1;
    END_FOR;

    (* Équipements : un équipement relie ses nœuds A (2*e) et B (2*e + 1) *)
    FOR i := 0 TO SSP_NB_EQUIP - 1 DO
        Arete_N1[Nb_Aretes]    := BaseNoeud + 2 * i;
        Arete_N2[Nb_Aretes]    := BaseNoeud + 2 * i + 1;
        Arete_Equip[Nb_Aretes] := BaseEquip + i;
        Nb_Aretes := Nb_Aretes + 1;
    END_FOR;

    Init_SSP := TRUE;
END_FUNCTION


(* Une arête est active si c'est une liaison fixe ou si son équipement est fermé *)
FUNCTION Arete_Active : BOOL
VAR_INPUT
    k : INT;    (* indice de l'arête *)
END_VAR

    IF Arete_Equip[k] < 0 THEN
        Arete_Active := TRUE;
    ELSE
        Arete_Active := Equip_Ferme[Arete_Equip[k]];
    END_IF;
END_FUNCTION


(* ---------- 4. EXEMPLE D'UTILISATION : poste de Landivisiau ----------
   Landivisiau = 1er poste du réseau : nœuds globaux 0..17, équipements 0..8.

   Au démarrage, une seule fois :
       Nb_Aretes := 0;
       ok := Init_SSP(0, 0);
   Un 2e poste SSP viendrait ensuite avec :
       ok := Init_SSP(SSP_NB_NOEUDS, SSP_NB_EQUIP);

   À chaque cycle, recopier les variables PIRATE d'état (TRUE = fermé).
   Les noms à droite sont des PLACEHOLDERS, à remplacer par les variables réelles :
       Equip_Ferme[0 + SSP_EQ_SAT1] := LDV_SAT1_FERME;
       Equip_Ferme[0 + SSP_EQ_IL1]  := LDV_IL1_FERME;
       Equip_Ferme[0 + SSP_EQ_IL3]  := LDV_IL3_FERME;
       Equip_Ferme[0 + SSP_EQ_IMP]  := LDV_IMP_FERME;
       Equip_Ferme[0 + SSP_EQ_IL2]  := LDV_IL2_FERME;
       Equip_Ferme[0 + SSP_EQ_IL4]  := LDV_IL4_FERME;
       Equip_Ferme[0 + SSP_EQ_SAT2] := LDV_SAT2_FERME;
       Equip_Ferme[0 + SSP_EQ_SPV1] := LDV_S31_41_FERME;
       Equip_Ferme[0 + SSP_EQ_SPV2] := LDV_S30_40_FERME;
   ---------------------------------------------------------------------- *)