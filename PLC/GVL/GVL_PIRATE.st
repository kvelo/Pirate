// PIRATE zone 101 — declarations extraites de variable_pirate.plclib
// Entrees : autres variables ; sorties : TT et Defaut.
// Cette direction est LOGIQUE : GVL VAR_GLOBAL n'impose pas un sens materiel d'E/S.
// Ne pas ajouter AT %I/%Q sans mapping materiel valide.
VAR_GLOBAL
    // _101_St_Thegonnec
    ST_THEGONNEC_S20_30_Sect__de_pontage_V2 : BOOL; // ENTREE
    ST_THEGONNEC_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    ST_THEGONNEC_AT2_Defaut_Auto_transfo_2 : BOOL; // SORTIE
    ST_THEGONNEC_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    ST_THEGONNEC_IL2_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    ST_THEGONNEC_U_Cat__TT_2C_Etat_tension_voie_2 : BOOL; // SORTIE
    ST_THEGONNEC_IL4_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    ST_THEGONNEC_SAT1___25kV_Sect__alimentation_auto_transfo1 : BOOL; // ENTREE
    ST_THEGONNEC_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    ST_THEGONNEC_S21_31_Sect__de_pontage_V1 : BOOL; // ENTREE
    ST_THEGONNEC_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    ST_THEGONNEC_IL3_Inter__de_ligne_2x25kv_V1 : BOOL; // ENTREE
    ST_THEGONNEC_SA_Manque_SA : BOOL; // ENTREE
    ST_THEGONNEC_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    ST_THEGONNEC_IMP___25kV_Interrupteur_mise_en_parallele : BOOL; // ENTREE
    ST_THEGONNEC_U_Cat__TT_3C_Etat_tension_voie_1 : BOOL; // SORTIE
    ST_THEGONNEC_IL1_Inter__de_ligne_2x25kv_V1 : BOOL; // ENTREE
    ST_THEGONNEC_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    ST_THEGONNEC_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    ST_THEGONNEC_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    ST_THEGONNEC_FICTIF_Organe_Fictif : BOOL; // ENTREE
    ST_THEGONNEC_SAT2___25kV_Sect__alimentation_auto_transfo2 : BOOL; // ENTREE
    ST_THEGONNEC_AT1_Defaut_Auto_transfo_1 : BOOL; // SORTIE
    ST_THEGONNEC_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    ST_THEGONNEC_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE

    // _101_Brest
    BREST_SA_Manque_SA : BOOL; // ENTREE
    BREST_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    BREST_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    BREST_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    BREST_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    BREST_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    BREST_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    BREST_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    BREST_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    BREST_IA6_Automatisme_Automat_Ouv_PLUS_Bloc_Debloc_IA__Ouv_ : BOOL; // ENTREE // Nom PIRATE original : BREST_IA6_Automatisme_Automat_Ouv+Bloc_Debloc_IA__Ouv_
    BREST_IL2_Inter__de_ligne_25kv_V2 : BOOL; // ENTREE
    BREST_SA_Defaut_Chauffage_Commandes : BOOL; // SORTIE
    BREST_U_Cat__TT_IA6_Etat_tension_voie : BOOL; // SORTIE
    BREST_IA1_Automatisme_Automat_Ouv_PLUS_Bloc_Debloc_IA__Ouv_ : BOOL; // ENTREE // Nom PIRATE original : BREST_IA1_Automatisme_Automat_Ouv+Bloc_Debloc_IA__Ouv_
    BREST_IA6_Interrupteur_d_Alimentation__IA_ : BOOL; // ENTREE
    BREST_IL1_Inter__de_ligne_25kv_V1 : BOOL; // ENTREE
    BREST_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    BREST_U_Cat__TT_IA1_Etat_tension_voie : BOOL; // SORTIE
    BREST_IA1_Interrupteur_d_Alimentation__IA_ : BOOL; // ENTREE
    BREST_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    BREST_U_Cat__TT_2C_Etat_tension_voie_2 : BOOL; // SORTIE
    BREST_FICTIF_Organe_Fictif : BOOL; // ENTREE

    // _101_Pencran
    PENCRAN_1_U_Feeder_TT_3F_Etat_tension_voie_1 : BOOL; // SORTIE
    PENCRAN_1_U_Feeder_TT_4F_Etat_tension_voie_2 : BOOL; // SORTIE
    PENCRAN_1_TT_Feeder_DL_Etat_tension : BOOL; // SORTIE
    PENCRAN_1_U_Cat__TT_2C_Etat_tension_voie_2 : BOOL; // SORTIE
    PENCRAN_1_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    PENCRAN_1_U_Cat__TT_4C_Etat_tension_voie_2 : BOOL; // SORTIE
    PENCRAN_1_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    PENCRAN_1_U_Feeder_TT_1F_Etat_tension_voie_1 : BOOL; // SORTIE
    PENCRAN_1_U_Cat__TT_3C_Etat_tension_voie_1 : BOOL; // SORTIE
    PENCRAN_1_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    PENCRAN_1_U_Cat__TT_1C_Etat_tension_voie_1 : BOOL; // SORTIE
    PENCRAN_1_UHT_1_Absence_tension_ligne_HT : BOOL; // ENTREE
    PENCRAN_1_TT_Cat__DB_Etat_tension : BOOL; // SORTIE
    PENCRAN_1_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    PENCRAN_1_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    PENCRAN_1_UHT_1_Fusion_fusible_s_ : BOOL; // ENTREE
    PENCRAN_1_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    PENCRAN_1_UHT_2_Absence_tension_ligne_HT : BOOL; // ENTREE
    PENCRAN_1_U_Feeder_TT_2F_Etat_tension_voie_2 : BOOL; // SORTIE
    PENCRAN_1_UHT_2_Fusion_fusible_s_ : BOOL; // ENTREE
    PENCRAN_1_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    PENCRAN_1_TT_Cat__DL_Etat_tension : BOOL; // SORTIE
    PENCRAN_1_TT_Feeder_DB_Etat_tension : BOOL; // SORTIE
    PENCRAN_1_SLB1_Sect__de_barre_de_ligne_25Kv : BOOL; // ENTREE
    PENCRAN_1_DL_Disj_depart_2x25kV_Le_Mans : BOOL; // ENTREE
    PENCRAN_1_S11___63kV_Sect__de_ligne_Haute_Tension : BOOL; // ENTREE
    PENCRAN_1_GT2_Defaut_Alim__Protection__W_D_ : BOOL; // SORTIE
    PENCRAN_1_SA_Manque_SA2 : BOOL; // ENTREE
    PENCRAN_1_IS1_Inter__de_S_Station_2x25Kv_V1 : BOOL; // ENTREE
    PENCRAN_1_SRB1___25kV_Sect__a_rupture_brusque_GT1 : BOOL; // ENTREE
    PENCRAN_1_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    PENCRAN_1_DL__TSS__Defaut_Alim__Protection__W_D_ : BOOL; // SORTIE
    PENCRAN_1_SA_Manque_SA1 : BOOL; // ENTREE
    PENCRAN_1_GT1_Defaut_Alim__Protection__W_D_ : BOOL; // SORTIE
    PENCRAN_1_SA_Manque_48V_ : BOOL; // ENTREE
    PENCRAN_1_GT1_Defaut_Transfo__Groupe_Traction : BOOL; // SORTIE
    PENCRAN_1_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    PENCRAN_1_GT2_Defaut_Transfo__Groupe_Traction : BOOL; // SORTIE
    PENCRAN_1_DL__TSS__Defaut_SF6 : BOOL; // SORTIE
    PENCRAN_1_P1_Sect__de_pontage_V1 : BOOL; // ENTREE
    PENCRAN_1_SB1___25kV_Sect__de_section_de_barre_25Kv : BOOL; // ENTREE
    PENCRAN_1_SA_Defaut_Chargeur : BOOL; // SORTIE
    PENCRAN_1_SBP1___63kV_Sect__de_section_de_barre_HT : BOOL; // ENTREE
    PENCRAN_1_IS3_Inter__de_S_Station_25Kv_V1 : BOOL; // ENTREE
    PENCRAN_1_P2_Sect__de_pontage_V2 : BOOL; // ENTREE
    PENCRAN_1_IS2_Inter__de_S_Station_2x25Kv_V2 : BOOL; // ENTREE
    PENCRAN_1_S21___63kV_Sect__de_ligne_Haute_Tension : BOOL; // ENTREE
    PENCRAN_1_IS4_Inter__de_S_Station_2x25Kv_V2 : BOOL; // ENTREE
    PENCRAN_1_SRB2___25kV_Sect__a_rupture_brusque_GT2 : BOOL; // ENTREE
    PENCRAN_1_D2___63kV_Disjoncteur_Groupe_Traction_2 : BOOL; // ENTREE
    PENCRAN_1_DB_Disj_depart_2x25kV_Brest : BOOL; // ENTREE
    PENCRAN_1_D2___25kV_Defaut_SF6_2eme_seuil : BOOL; // SORTIE
    PENCRAN_1_DB__TSS__Defaut_Alim__Protection__W_D_ : BOOL; // SORTIE
    PENCRAN_1_D2___25kV_Alarme_SF6_1er_seuil : BOOL; // ENTREE
    PENCRAN_1_Automate_Defaut_Relais_PROM : BOOL; // SORTIE
    PENCRAN_1_D2___25kV_Defaut_Commande_disjoncteur : BOOL; // SORTIE
    PENCRAN_1_Automate_Relais_PROM__TC_ : BOOL; // ENTREE
    PENCRAN_1_Automate_Defaut_Reenclencheur : BOOL; // SORTIE
    PENCRAN_1_DB__TSS__Defaut_SF6 : BOOL; // SORTIE
    PENCRAN_1_Contrile_Local_Commande_Locale : BOOL; // ENTREE
    PENCRAN_1_D1___63kV_Disjoncteur_Groupe_Traction_1 : BOOL; // ENTREE
    PENCRAN_1_VF_Veille_Franchissement__TC_ : BOOL; // ENTREE
    PENCRAN_1_FICTIF_Organe_Fictif : BOOL; // ENTREE
    PENCRAN_1_D2___25kV_Disjoncteur_Groupe_Traction_2 : BOOL; // ENTREE

    // _101_Landivisiau
    LANDIVISIAU_AT2_Defaut_Auto_transfo_2 : BOOL; // SORTIE
    LANDIVISIAU_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    LANDIVISIAU_S30_40_Sect__de_pontage_V2 : BOOL; // ENTREE
    LANDIVISIAU_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    LANDIVISIAU_S31_41_Sect__de_pontage_V1 : BOOL; // ENTREE
    LANDIVISIAU_IL1_Inter__de_ligne_2x25kv_V1 : BOOL; // ENTREE
    LANDIVISIAU_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    LANDIVISIAU_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    LANDIVISIAU_IL3_Inter__de_ligne_2x25kv_V1 : BOOL; // ENTREE
    LANDIVISIAU_SA_Manque_SA : BOOL; // ENTREE
    LANDIVISIAU_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    LANDIVISIAU_IL2_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    LANDIVISIAU_IMP___25kV_Interrupteur_mise_en_parallele : BOOL; // ENTREE
    LANDIVISIAU_SAT1___25kV_Sect__alimentation_auto_transfo1 : BOOL; // ENTREE
    LANDIVISIAU_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    LANDIVISIAU_IL4_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    LANDIVISIAU_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    LANDIVISIAU_U_Cat__TT_2C_Etat_tension_voie_2 : BOOL; // SORTIE
    LANDIVISIAU_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    LANDIVISIAU_AT1_Defaut_Auto_transfo_1 : BOOL; // SORTIE
    LANDIVISIAU_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    LANDIVISIAU_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    LANDIVISIAU_SAT2___25kV_Sect__alimentation_auto_transfo2 : BOOL; // ENTREE
    LANDIVISIAU_U_Cat__TT_3C_Etat_tension_voie_1 : BOOL; // SORTIE
    LANDIVISIAU_FICTIF_Organe_Fictif : BOOL; // ENTREE

    // _101_St_Marc
    ST_MARC_S4_10_Sect__de_pontage_V2 : BOOL; // ENTREE
    ST_MARC_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    ST_MARC_IA3_Interrupteur_d_Alimentation__IA_ : BOOL; // ENTREE
    ST_MARC_SA_Manque_SA_Satellite_2 : BOOL; // ENTREE
    ST_MARC_IL2_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    ST_MARC_IMP___25kV_Interrupteur_mise_en_parallele : BOOL; // ENTREE
    ST_MARC_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    ST_MARC_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    ST_MARC_U_Cat__TT_3C_Etat_tension_voie_1 : BOOL; // SORTIE
    ST_MARC_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    ST_MARC_AT1_Defaut_Auto_transfo_1 : BOOL; // SORTIE
    ST_MARC_I5_Interrupteur_2x25kV_V1 : BOOL; // ENTREE
    ST_MARC_SA_Manque_SA : BOOL; // ENTREE
    ST_MARC_IL4_Inter__de_ligne_25kv_V2 : BOOL; // ENTREE
    ST_MARC_SA_Manque_SA_Satellite_1 : BOOL; // ENTREE
    ST_MARC_U_Cat__TT_2C_Etat_tension_voie_2 : BOOL; // SORTIE
    ST_MARC_IL1_Inter__de_ligne_2x25kv_V1 : BOOL; // ENTREE
    ST_MARC_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    ST_MARC_IL3_Inter__de_ligne_25kv_V1 : BOOL; // ENTREE
    ST_MARC_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    ST_MARC_SAT2___25kV_Sect__alimentation_auto_transfo2 : BOOL; // ENTREE
    ST_MARC_S5_11_Sect__de_pontage_V1 : BOOL; // ENTREE
    ST_MARC_IA3_Automatisme_Automat_Ouv_PLUS_Bloc_Debloc_IA__Ouv_ : BOOL; // ENTREE // Nom PIRATE original : ST_MARC_IA3_Automatisme_Automat_Ouv+Bloc_Debloc_IA__Ouv_
    ST_MARC_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    ST_MARC_AT2_Defaut_Auto_transfo_2 : BOOL; // SORTIE
    ST_MARC_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    ST_MARC_SAT1___25kV_Sect__alimentation_auto_transfo1 : BOOL; // ENTREE
    ST_MARC_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    ST_MARC_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    ST_MARC_FICTIF_Organe_Fictif : BOOL; // ENTREE

    // _101_La_Forest
    LA_FOREST_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    LA_FOREST_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    LA_FOREST_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    LA_FOREST_AT_Defaut_Auto_transfo : BOOL; // SORTIE
    LA_FOREST_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    LA_FOREST_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    LA_FOREST_IMP2_Inter__mise_parallele_2x25kv_V2 : BOOL; // ENTREE
    LA_FOREST_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    LA_FOREST_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    LA_FOREST_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    LA_FOREST_IMP1_Inter__mise_parallele_2x25kv_V1 : BOOL; // ENTREE
    LA_FOREST_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    LA_FOREST_SAT___25kV_Sect__alimentation_auto_transfo : BOOL; // ENTREE
    LA_FOREST_SA_Manque_SA : BOOL; // ENTREE
    LA_FOREST_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    LA_FOREST_FICTIF_Organe_Fictif : BOOL; // ENTREE

    // _101_Kerivin
    KERIVIN_SAT1___25kV_Sect__alimentation_auto_transfo1 : BOOL; // ENTREE
    KERIVIN_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    KERIVIN_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    KERIVIN_IL1_Inter__de_ligne_2x25kv_V1 : BOOL; // ENTREE
    KERIVIN_S18_20_Sect__de_pontage_V2 : BOOL; // ENTREE
    KERIVIN_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    KERIVIN_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    KERIVIN_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    KERIVIN_U_Cat__TT_2C_Etat_tension_voie_2 : BOOL; // SORTIE
    KERIVIN_IL3_Inter__de_ligne_2x25kv_V1 : BOOL; // ENTREE
    KERIVIN_SA_Manque_SA : BOOL; // ENTREE
    KERIVIN_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    KERIVIN_AT2_Defaut_Auto_transfo_2 : BOOL; // SORTIE
    KERIVIN_IMP___25kV_Interrupteur_mise_en_parallele : BOOL; // ENTREE
    KERIVIN_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    KERIVIN_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    KERIVIN_IL2_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    KERIVIN_SAT2___25kV_Sect__alimentation_auto_transfo2 : BOOL; // ENTREE
    KERIVIN_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    KERIVIN_AT1_Defaut_Auto_transfo_1 : BOOL; // SORTIE
    KERIVIN_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    KERIVIN_S13_21_Sect__de_pontage_V1 : BOOL; // ENTREE
    KERIVIN_IL4_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    KERIVIN_U_Cat__TT_3C_Etat_tension_voie_1 : BOOL; // SORTIE
    KERIVIN_FICTIF_Organe_Fictif : BOOL; // ENTREE

    // _101_Landerneau
    LANDERNEAU_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    LANDERNEAU_SA_Manque_SA : BOOL; // ENTREE
    LANDERNEAU_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    LANDERNEAU_I4_Interrupteur_2x25kV_V2 : BOOL; // ENTREE
    LANDERNEAU_I3_Interrupteur_2x25kV_V1 : BOOL; // ENTREE
    LANDERNEAU_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    LANDERNEAU_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    LANDERNEAU_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    LANDERNEAU_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    LANDERNEAU_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    LANDERNEAU_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    LANDERNEAU_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    LANDERNEAU_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    LANDERNEAU_FICTIF_Organe_Fictif : BOOL; // ENTREE

    // _101_Morlaix
    MORLAIX_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    MORLAIX_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    MORLAIX_SA_Manque_SA : BOOL; // ENTREE
    MORLAIX_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    MORLAIX_SA_Manque_SA_Satellite_1 : BOOL; // ENTREE
    MORLAIX_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    MORLAIX_SA_Manque_SA_Satellite_2 : BOOL; // ENTREE
    MORLAIX_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    MORLAIX_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    MORLAIX_I14_Interrupteur_2x25kV_V2 : BOOL; // ENTREE
    MORLAIX_I16_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    MORLAIX_I13_Interrupteur_2x25kV_V1 : BOOL; // ENTREE
    MORLAIX_I18_Interrupteur_2x25kV_V2 : BOOL; // ENTREE
    MORLAIX_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    MORLAIX_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    MORLAIX_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    MORLAIX_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    MORLAIX_FICTIF_Organe_Fictif : BOOL; // ENTREE

    // _101_Plouigneau
    PLOUIGNEAU_IL3_Inter__de_ligne_2x25kv_V1 : BOOL; // ENTREE
    PLOUIGNEAU_IMP___25kV_Interrupteur_mise_en_parallele : BOOL; // ENTREE
    PLOUIGNEAU_SYSTEME_PA_SNCF_PA_Carte_s__TS : BOOL; // ENTREE
    PLOUIGNEAU_SYSTEME_PC_SNCF_PA_Liaison_PC______PA : BOOL; // ENTREE
    PLOUIGNEAU_U_Cat__TT_3C_Etat_tension_voie_1 : BOOL; // SORTIE
    PLOUIGNEAU_SA_Manque_SA : BOOL; // ENTREE
    PLOUIGNEAU_IL2_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    PLOUIGNEAU_SYSTEME_PA_SNCF_PA_Carte_s__TC : BOOL; // ENTREE
    PLOUIGNEAU_S4_12_Sect__de_pontage_V2 : BOOL; // ENTREE
    PLOUIGNEAU_SAT1___25kV_Sect__alimentation_auto_transfo1 : BOOL; // ENTREE
    PLOUIGNEAU_U_Cat__TT_2C_Etat_tension_voie_2 : BOOL; // SORTIE
    PLOUIGNEAU_IL4_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    PLOUIGNEAU_AT1_Defaut_Auto_transfo_1 : BOOL; // SORTIE
    PLOUIGNEAU_SYSTEME_PC_SNCF_PA_Douteux_vu_du_PC : BOOL; // ENTREE
    PLOUIGNEAU_SYSTEME_PC_SNCF_PA_Non_date : BOOL; // ENTREE
    PLOUIGNEAU_SAT2___25kV_Sect__alimentation_auto_transfo2 : BOOL; // ENTREE
    PLOUIGNEAU_SYSTEME_PA_SNCF_PA_Perte_Date : BOOL; // ENTREE
    PLOUIGNEAU_U_Cat__TT_4C_Etat_tension_voie_2 : BOOL; // SORTIE
    PLOUIGNEAU_IL1_Inter__de_ligne_25kv_V1 : BOOL; // ENTREE
    PLOUIGNEAU_S5_11_Sect__de_pontage_V1 : BOOL; // ENTREE
    PLOUIGNEAU_SYSTEME_PC_SNCF_PA_Titulaire : BOOL; // ENTREE
    PLOUIGNEAU_AT2_Defaut_Auto_transfo_2 : BOOL; // SORTIE
    PLOUIGNEAU_Contrile_Local_Commande_locale_individuelle : BOOL; // ENTREE
    PLOUIGNEAU_SYSTEME_PA_SNCF_PA_Perte_Information : BOOL; // ENTREE
    PLOUIGNEAU_SYSTEME_PC_SNCF_PA_Defaut_Controle_General : BOOL; // SORTIE
    PLOUIGNEAU_FICTIF_Organe_Fictif : BOOL; // ENTREE

    // _101_Plounerin
    PLOUNERIN_IL4_Inter__de_ligne_2x25kv_V2 : BOOL; // ENTREE
    PLOUNERIN_IL3_Inter__de_ligne_25kv_V1 : BOOL; // ENTREE
    PLOUNERIN_AT2_Defaut_Auto_transfo_2 : BOOL; // SORTIE
    PLOUNERIN_SAT2___25kV_Sect__alimentation_auto_transfo2 : BOOL; // ENTREE
    PLOUNERIN_U_Cat__TT_3C_Etat_tension_voie_1 : BOOL; // SORTIE
    PLOUNERIN_FICTIF_Organe_Fictif : BOOL; // ENTREE

END_VAR