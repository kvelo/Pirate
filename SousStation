(* ======================================================================
   SS PENCRAN - ZONE 101 - EXTENSION DU MODELE SSP
   Version de travail d'apres la capture d'ecran PIRATE.

   ATTENTION : topologie provisoire, NON VALIDEE par schema unifilaire.
   SLB2 et la nature exacte des arrivees DL/DB restent a confirmer.
   Ce code est un modele de connexite pour simulation, pas une logique
   de commande/protection exploitable sur une installation reelle.

   Utilise les variables et fonctions de reseau definies ci-dessus.
   10 equipements => 20 noeuds locaux; 11 liaisons fixes.
   21 aretes ajoutees au graphe.
   ====================================================================== *)

(* ---------- 5. CONSTANTES DE PENCRAN ---------- *)
VAR_GLOBAL CONSTANT
    PEN_NB_EQUIP    : INT := 10;
    PEN_NB_NOEUDS   : INT := 20;
    PEN_NB_LIAISONS : INT := 11;

    PEN_EQ_DL   : INT := 0;
    PEN_EQ_DB   : INT := 1;
    PEN_EQ_SLB1 : INT := 2;
    PEN_EQ_SLB2 : INT := 3;
    PEN_EQ_IS1  : INT := 4;
    PEN_EQ_IS2  : INT := 5;
    PEN_EQ_IS3  : INT := 6;
    PEN_EQ_IS4  : INT := 7;
    PEN_EQ_P1   : INT := 8;
    PEN_EQ_P2   : INT := 9;

    PEN_N_DL_A   : INT := 0;
    PEN_N_DL_B   : INT := 1;
    PEN_N_DB_A   : INT := 2;
    PEN_N_DB_B   : INT := 3;
    PEN_N_SLB1_A : INT := 4;
    PEN_N_SLB1_B : INT := 5;
    PEN_N_SLB2_A : INT := 6;
    PEN_N_SLB2_B : INT := 7;
    PEN_N_IS1_A  : INT := 8;
    PEN_N_IS1_B  : INT := 9;
    PEN_N_IS2_A  : INT := 10;
    PEN_N_IS2_B  : INT := 11;
    PEN_N_IS3_A  : INT := 12;
    PEN_N_IS3_B  : INT := 13;
    PEN_N_IS4_A  : INT := 14;
    PEN_N_IS4_B  : INT := 15;
    PEN_N_P1_A   : INT := 16;
    PEN_N_P1_B   : INT := 17;
    PEN_N_P2_A   : INT := 18;
    PEN_N_P2_B   : INT := 19;

    (* Liaisons fixes supposees d'apres la vue PIRATE.
       Chaque paire (a,b) represente une liaison permanente. *)
    PEN_LIENS : ARRAY[0..21] OF INT := [
        1, 4,    (* DL_B - SLB1_A *)
        5, 6,    (* SLB1_B - SLB2_A *)
        7, 3,    (* SLB2_B - DB_B *)
        1, 8,    (* DL_B - IS1_A *)
        1, 10,   (* DL_B - IS2_A *)
        3, 12,   (* DB_B - IS3_A *)
        3, 14,   (* DB_B - IS4_A *)
        9, 16,   (* IS1_B - P1_A : V1 amont *)
        13, 17,  (* IS3_B - P1_B : V1 aval *)
        11, 18,  (* IS2_B - P2_A : V2 amont *)
        15, 19   (* IS4_B - P2_B : V2 aval *)
    ];
END_VAR


(* ---------- 6. CONSTRUCTION DU GRAPHE PENCRAN ---------- *)
FUNCTION Init_Pencran : BOOL
VAR_INPUT
    BaseNoeud : INT;
    BaseEquip : INT;
END_VAR
VAR
    i : INT;
END_VAR

    Init_Pencran := FALSE;

    IF (BaseNoeud < 0) OR (BaseEquip < 0) OR (Nb_Aretes < 0)
       OR (Nb_Aretes + PEN_NB_LIAISONS + PEN_NB_EQUIP > RES_MAX_ARETES)
       OR (BaseEquip + PEN_NB_EQUIP > RES_MAX_EQUIP) THEN
        RETURN;
    END_IF;

    (* Arêtes permanentes *)
    FOR i := 0 TO PEN_NB_LIAISONS - 1 DO
        Arete_N1[Nb_Aretes]    := BaseNoeud + PEN_LIENS[2 * i];
        Arete_N2[Nb_Aretes]    := BaseNoeud + PEN_LIENS[2 * i + 1];
        Arete_Equip[Nb_Aretes] := -1;
        Nb_Aretes := Nb_Aretes + 1;
    END_FOR;

    (* Aretes de coupure : actives si Equip_Ferme[] = TRUE *)
    FOR i := 0 TO PEN_NB_EQUIP - 1 DO
        Arete_N1[Nb_Aretes]    := BaseNoeud + 2 * i;
        Arete_N2[Nb_Aretes]    := BaseNoeud + 2 * i + 1;
        Arete_Equip[Nb_Aretes] := BaseEquip + i;
        Nb_Aretes := Nb_Aretes + 1;
    END_FOR;

    Init_Pencran := TRUE;
END_FUNCTION


(* ---------- 7. EXEMPLE DE DEPLOIEMENT ----------
   Les lignes suivantes sont des exemples, NON executables telles quelles
   sans programme d'appel ni declaration des variables de terrain.

   Initialisation UNE SEULE FOIS (Landivisiau puis Pencran) :

       Nb_Aretes := 0;
       ok_LDV := Init_SSP(0, 0);
       ok_PEN := Init_Pencran(SSP_NB_NOEUDS, SSP_NB_EQUIP);

   Pour Pencran : BaseNoeud=18, BaseEquip=9 ; noeuds globaux 18..37,
   equipements globaux 9..18.

   A CHAQUE CYCLE : mettre a jour les dix etats depuis les signaux
   de simulation/verifies; toutes les variables *_FERME sont a declarer :

       Equip_Ferme[9 + PEN_EQ_DL]   := PEN_DL_FERME;
       Equip_Ferme[9 + PEN_EQ_DB]   := PEN_DB_FERME;
       Equip_Ferme[9 + PEN_EQ_SLB1] := PEN_SLB1_FERME;
       Equip_Ferme[9 + PEN_EQ_SLB2] := PEN_SLB2_FERME;
       Equip_Ferme[9 + PEN_EQ_IS1]  := PEN_IS1_FERME;
       Equip_Ferme[9 + PEN_EQ_IS2]  := PEN_IS2_FERME;
       Equip_Ferme[9 + PEN_EQ_IS3]  := PEN_IS3_FERME;
       Equip_Ferme[9 + PEN_EQ_IS4]  := PEN_IS4_FERME;
       Equip_Ferme[9 + PEN_EQ_P1]   := PEN_P1_FERME;
       Equip_Ferme[9 + PEN_EQ_P2]   := PEN_P2_FERME;

   Interfaces de la zone (indices globaux) :
       V1 amont : 18 + PEN_N_P1_A = 34
       V1 aval  : 18 + PEN_N_P1_B = 35
       V2 amont : 18 + PEN_N_P2_A = 36
       V2 aval  : 18 + PEN_N_P2_B = 37
       Arrivee DL : 18 + PEN_N_DL_A = 18
       Arrivee DB : 18 + PEN_N_DB_A = 20

   ATTENTION : aucune liaison aux objets Zone101/voies ni source
   d'alimentation n'est creee automatiquement ici. Ces interfaces,
   ainsi que les circuits 2x25 kV, doivent etre valides et cables
   explicitement dans le graphe global.
   --------------------------------------------------------------- *)
