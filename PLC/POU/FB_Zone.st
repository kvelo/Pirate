FUNCTION_BLOCK FB_Zone
VAR_INPUT
    IdZone : UINT;
    SourceS11Active : BOOL; // alimentation amont de PENCRAN_S11 (noeud 56)
    SourceS21Active : BOOL; // alimentation amont de PENCRAN_S21 (noeud 57)
END_VAR
VAR_OUTPUT
    ErreurConfiguration : BOOL;
END_VAR
VAR
    // Tables suivant les signatures existantes de FB_BFS (indices 0-based).
    Noeuds : ARRAY[0..399] OF ST_Noeud;
    Equipements : ARRAY[0..119] OF ST_Equipement;
    Aretes : ARRAY[0..399] OF ST_AreteZone;
    Sources : ARRAY[0..399] OF BOOL;
    NbNoeuds : UINT := 57;
    NbEquipements : UINT := 80;
    NbAretes : UINT := 80;
    ConfigurationChargee : BOOL := FALSE;
    MoteurBFS : FB_BFS;
    i : INT;
END_VAR

// Initialiser une seule fois : ne pas effacer Ferme/Defaut a chaque cycle.
IF NOT ConfigurationChargee THEN
    FOR i := 0 TO 56 DO
        Noeuds[i].IdZone := INT_TO_UINT(i + 1);
        // IdLocal est significatif uniquement dans chaque instance de poste.
        Noeuds[i].IdLocal := 0;
        Noeuds[i].SousTension := FALSE;
    END_FOR;
    // Correspondance Pencran : globaux 50..55 = locaux 1..6.
    FOR i := 49 TO 54 DO
        Noeuds[i].IdLocal := INT_TO_UINT(i - 48);
    END_FOR;
    Noeuds[55].IdLocal := 7; // point amont S11 virtuel
    Noeuds[56].IdLocal := 8; // point amont S21 virtuel
    // 0: BREST_IL1 (global 49-47; local 1-2)
    Equipements[0].Id := 1;
    Equipements[0].NoeudA := 1;
    Equipements[0].NoeudB := 2;
    Equipements[0].Ferme := FALSE;
    Equipements[0].Defaut := FALSE;
    Equipements[0].Conducteur := FALSE;
    Aretes[0].NoeudA := 48;
    Aretes[0].NoeudB := 46;
    Aretes[0].EquipementIndex := 0;
    // 1: BREST_IL2 (global 49-48; local 1-3)
    Equipements[1].Id := 2;
    Equipements[1].NoeudA := 1;
    Equipements[1].NoeudB := 3;
    Equipements[1].Ferme := FALSE;
    Equipements[1].Defaut := FALSE;
    Equipements[1].Conducteur := FALSE;
    Aretes[1].NoeudA := 48;
    Aretes[1].NoeudB := 47;
    Aretes[1].EquipementIndex := 1;
    // 2: KERIVIN_IL1 (global 19-13; local 1-2)
    Equipements[2].Id := 1;
    Equipements[2].NoeudA := 1;
    Equipements[2].NoeudB := 2;
    Equipements[2].Ferme := FALSE;
    Equipements[2].Defaut := FALSE;
    Equipements[2].Conducteur := FALSE;
    Aretes[2].NoeudA := 18;
    Aretes[2].NoeudB := 12;
    Aretes[2].EquipementIndex := 2;
    // 3: KERIVIN_IL2 (global 18-16; local 3-4)
    Equipements[3].Id := 2;
    Equipements[3].NoeudA := 3;
    Equipements[3].NoeudB := 4;
    Equipements[3].Ferme := FALSE;
    Equipements[3].Defaut := FALSE;
    Equipements[3].Conducteur := FALSE;
    Aretes[3].NoeudA := 17;
    Aretes[3].NoeudB := 15;
    Aretes[3].EquipementIndex := 3;
    // 4: KERIVIN_IL3 (global 19-21; local 1-5)
    Equipements[4].Id := 3;
    Equipements[4].NoeudA := 1;
    Equipements[4].NoeudB := 5;
    Equipements[4].Ferme := FALSE;
    Equipements[4].Defaut := FALSE;
    Equipements[4].Conducteur := FALSE;
    Aretes[4].NoeudA := 18;
    Aretes[4].NoeudB := 20;
    Aretes[4].EquipementIndex := 4;
    // 5: KERIVIN_IL4 (global 18-22; local 3-6)
    Equipements[5].Id := 4;
    Equipements[5].NoeudA := 3;
    Equipements[5].NoeudB := 6;
    Equipements[5].Ferme := FALSE;
    Equipements[5].Defaut := FALSE;
    Equipements[5].Conducteur := FALSE;
    Aretes[5].NoeudA := 17;
    Aretes[5].NoeudB := 21;
    Aretes[5].EquipementIndex := 5;
    // 6: KERIVIN_IMP (global 18-19; local 3-1)
    Equipements[6].Id := 5;
    Equipements[6].NoeudA := 3;
    Equipements[6].NoeudB := 1;
    Equipements[6].Ferme := FALSE;
    Equipements[6].Defaut := FALSE;
    Equipements[6].Conducteur := FALSE;
    Aretes[6].NoeudA := 17;
    Aretes[6].NoeudB := 18;
    Aretes[6].EquipementIndex := 6;
    // 7: KERIVIN_S13-21 (global 13-21; local 2-5)
    Equipements[7].Id := 6;
    Equipements[7].NoeudA := 2;
    Equipements[7].NoeudB := 5;
    Equipements[7].Ferme := FALSE;
    Equipements[7].Defaut := FALSE;
    Equipements[7].Conducteur := FALSE;
    Aretes[7].NoeudA := 12;
    Aretes[7].NoeudB := 20;
    Aretes[7].EquipementIndex := 7;
    // 8: KERIVIN_S18-20 (global 16-22; local 4-6)
    Equipements[8].Id := 7;
    Equipements[8].NoeudA := 4;
    Equipements[8].NoeudB := 6;
    Equipements[8].Ferme := FALSE;
    Equipements[8].Defaut := FALSE;
    Equipements[8].Conducteur := FALSE;
    Aretes[8].NoeudA := 15;
    Aretes[8].NoeudB := 21;
    Aretes[8].EquipementIndex := 8;
    // 9: KERIVIN_SAT1 (global 19-20; local 1-7)
    Equipements[9].Id := 8;
    Equipements[9].NoeudA := 1;
    Equipements[9].NoeudB := 7;
    Equipements[9].Ferme := FALSE;
    Equipements[9].Defaut := FALSE;
    Equipements[9].Conducteur := FALSE;
    Aretes[9].NoeudA := 18;
    Aretes[9].NoeudB := 19;
    Aretes[9].EquipementIndex := 9;
    // 10: KERIVIN_SAT2 (global 17-18; local 8-3)
    Equipements[10].Id := 9;
    Equipements[10].NoeudA := 8;
    Equipements[10].NoeudB := 3;
    Equipements[10].Ferme := FALSE;
    Equipements[10].Defaut := FALSE;
    Equipements[10].Conducteur := FALSE;
    Aretes[10].NoeudA := 16;
    Aretes[10].NoeudB := 17;
    Aretes[10].EquipementIndex := 10;
    // 11: LANDERNEAU_I3 (global 37-39; local 1-2)
    Equipements[11].Id := 1;
    Equipements[11].NoeudA := 1;
    Equipements[11].NoeudB := 2;
    Equipements[11].Ferme := FALSE;
    Equipements[11].Defaut := FALSE;
    Equipements[11].Conducteur := FALSE;
    Aretes[11].NoeudA := 36;
    Aretes[11].NoeudB := 38;
    Aretes[11].EquipementIndex := 11;
    // 12: LANDERNEAU_I4 (global 38-40; local 3-4)
    Equipements[12].Id := 2;
    Equipements[12].NoeudA := 3;
    Equipements[12].NoeudB := 4;
    Equipements[12].Ferme := FALSE;
    Equipements[12].Defaut := FALSE;
    Equipements[12].Conducteur := FALSE;
    Aretes[12].NoeudA := 37;
    Aretes[12].NoeudB := 39;
    Aretes[12].EquipementIndex := 12;
    // 13: LANDIVISIAU_IL1 (global 30-27; local 1-2)
    Equipements[13].Id := 1;
    Equipements[13].NoeudA := 1;
    Equipements[13].NoeudB := 2;
    Equipements[13].Ferme := FALSE;
    Equipements[13].Defaut := FALSE;
    Equipements[13].Conducteur := FALSE;
    Aretes[13].NoeudA := 29;
    Aretes[13].NoeudB := 26;
    Aretes[13].EquipementIndex := 13;
    // 14: LANDIVISIAU_IL2 (global 31-28; local 3-4)
    Equipements[14].Id := 2;
    Equipements[14].NoeudA := 3;
    Equipements[14].NoeudB := 4;
    Equipements[14].Ferme := FALSE;
    Equipements[14].Defaut := FALSE;
    Equipements[14].Conducteur := FALSE;
    Aretes[14].NoeudA := 30;
    Aretes[14].NoeudB := 27;
    Aretes[14].EquipementIndex := 14;
    // 15: LANDIVISIAU_IL3 (global 30-33; local 1-5)
    Equipements[15].Id := 3;
    Equipements[15].NoeudA := 1;
    Equipements[15].NoeudB := 5;
    Equipements[15].Ferme := FALSE;
    Equipements[15].Defaut := FALSE;
    Equipements[15].Conducteur := FALSE;
    Aretes[15].NoeudA := 29;
    Aretes[15].NoeudB := 32;
    Aretes[15].EquipementIndex := 15;
    // 16: LANDIVISIAU_IL4 (global 31-34; local 3-6)
    Equipements[16].Id := 4;
    Equipements[16].NoeudA := 3;
    Equipements[16].NoeudB := 6;
    Equipements[16].Ferme := FALSE;
    Equipements[16].Defaut := FALSE;
    Equipements[16].Conducteur := FALSE;
    Aretes[16].NoeudA := 30;
    Aretes[16].NoeudB := 33;
    Aretes[16].EquipementIndex := 16;
    // 17: LANDIVISIAU_IMP (global 30-31; local 1-3)
    Equipements[17].Id := 5;
    Equipements[17].NoeudA := 1;
    Equipements[17].NoeudB := 3;
    Equipements[17].Ferme := FALSE;
    Equipements[17].Defaut := FALSE;
    Equipements[17].Conducteur := FALSE;
    Aretes[17].NoeudA := 29;
    Aretes[17].NoeudB := 30;
    Aretes[17].EquipementIndex := 17;
    // 18: LANDIVISIAU_S30-40 (global 28-34; local 4-6)
    Equipements[18].Id := 6;
    Equipements[18].NoeudA := 4;
    Equipements[18].NoeudB := 6;
    Equipements[18].Ferme := FALSE;
    Equipements[18].Defaut := FALSE;
    Equipements[18].Conducteur := FALSE;
    Aretes[18].NoeudA := 27;
    Aretes[18].NoeudB := 33;
    Aretes[18].EquipementIndex := 18;
    // 19: LANDIVISIAU_S31-41 (global 27-33; local 2-5)
    Equipements[19].Id := 7;
    Equipements[19].NoeudA := 2;
    Equipements[19].NoeudB := 5;
    Equipements[19].Ferme := FALSE;
    Equipements[19].Defaut := FALSE;
    Equipements[19].Conducteur := FALSE;
    Aretes[19].NoeudA := 26;
    Aretes[19].NoeudB := 32;
    Aretes[19].EquipementIndex := 19;
    // 20: LANDIVISIAU_SAT1 (global 29-30; local 7-1)
    Equipements[20].Id := 8;
    Equipements[20].NoeudA := 7;
    Equipements[20].NoeudB := 1;
    Equipements[20].Ferme := FALSE;
    Equipements[20].Defaut := FALSE;
    Equipements[20].Conducteur := FALSE;
    Aretes[20].NoeudA := 28;
    Aretes[20].NoeudB := 29;
    Aretes[20].EquipementIndex := 20;
    // 21: LANDIVISIAU_SAT2 (global 31-32; local 3-8)
    Equipements[21].Id := 9;
    Equipements[21].NoeudA := 3;
    Equipements[21].NoeudB := 8;
    Equipements[21].Ferme := FALSE;
    Equipements[21].Defaut := FALSE;
    Equipements[21].Conducteur := FALSE;
    Aretes[21].NoeudA := 30;
    Aretes[21].NoeudB := 31;
    Aretes[21].EquipementIndex := 21;
    // 22: LA_FOREST_IMP1 (global 41-39; local 1-2)
    Equipements[22].Id := 1;
    Equipements[22].NoeudA := 1;
    Equipements[22].NoeudB := 2;
    Equipements[22].Ferme := FALSE;
    Equipements[22].Defaut := FALSE;
    Equipements[22].Conducteur := FALSE;
    Aretes[22].NoeudA := 40;
    Aretes[22].NoeudB := 38;
    Aretes[22].EquipementIndex := 22;
    // 23: LA_FOREST_IMP2 (global 41-40; local 1-3)
    Equipements[23].Id := 2;
    Equipements[23].NoeudA := 1;
    Equipements[23].NoeudB := 3;
    Equipements[23].Ferme := FALSE;
    Equipements[23].Defaut := FALSE;
    Equipements[23].Conducteur := FALSE;
    Aretes[23].NoeudA := 40;
    Aretes[23].NoeudB := 39;
    Aretes[23].EquipementIndex := 23;
    // 24: LA_FOREST_SAT (global 41-42; local 1-4)
    Equipements[24].Id := 3;
    Equipements[24].NoeudA := 1;
    Equipements[24].NoeudB := 4;
    Equipements[24].Ferme := FALSE;
    Equipements[24].Defaut := FALSE;
    Equipements[24].Conducteur := FALSE;
    Aretes[24].NoeudA := 40;
    Aretes[24].NoeudB := 41;
    Aretes[24].EquipementIndex := 24;
    // 25: MORLAIX_I13 (global 11-13; local 1-2)
    Equipements[25].Id := 1;
    Equipements[25].NoeudA := 1;
    Equipements[25].NoeudB := 2;
    Equipements[25].Ferme := FALSE;
    Equipements[25].Defaut := FALSE;
    Equipements[25].Conducteur := FALSE;
    Aretes[25].NoeudA := 10;
    Aretes[25].NoeudB := 12;
    Aretes[25].EquipementIndex := 25;
    // 26: MORLAIX_I14 (global 12-14; local 3-4)
    Equipements[26].Id := 2;
    Equipements[26].NoeudA := 3;
    Equipements[26].NoeudB := 4;
    Equipements[26].Ferme := FALSE;
    Equipements[26].Defaut := FALSE;
    Equipements[26].Conducteur := FALSE;
    Aretes[26].NoeudA := 11;
    Aretes[26].NoeudB := 13;
    Aretes[26].EquipementIndex := 26;
    // 27: MORLAIX_I16 (global 14-15; local 4-5)
    Equipements[27].Id := 3;
    Equipements[27].NoeudA := 4;
    Equipements[27].NoeudB := 5;
    Equipements[27].Ferme := FALSE;
    Equipements[27].Defaut := FALSE;
    Equipements[27].Conducteur := FALSE;
    Aretes[27].NoeudA := 13;
    Aretes[27].NoeudB := 14;
    Aretes[27].EquipementIndex := 27;
    // 28: MORLAIX_I18 (global 15-16; local 5-6)
    Equipements[28].Id := 4;
    Equipements[28].NoeudA := 5;
    Equipements[28].NoeudB := 6;
    Equipements[28].Ferme := FALSE;
    Equipements[28].Defaut := FALSE;
    Equipements[28].Conducteur := FALSE;
    Aretes[28].NoeudA := 14;
    Aretes[28].NoeudB := 15;
    Aretes[28].EquipementIndex := 28;
    // 29: PENCRAN_D1 (global 50-51; local 1-2)
    Equipements[29].Id := 1;
    Equipements[29].NoeudA := 1;
    Equipements[29].NoeudB := 2;
    Equipements[29].Ferme := FALSE;
    Equipements[29].Defaut := FALSE;
    Equipements[29].Conducteur := FALSE;
    Aretes[29].NoeudA := 49;
    Aretes[29].NoeudB := 50;
    Aretes[29].EquipementIndex := 29;
    // 30: PENCRAN_D2 (global 53-54; local 3-4)
    Equipements[30].Id := 2;
    Equipements[30].NoeudA := 3;
    Equipements[30].NoeudB := 4;
    Equipements[30].Ferme := FALSE;
    Equipements[30].Defaut := FALSE;
    Equipements[30].Conducteur := FALSE;
    Aretes[30].NoeudA := 52;
    Aretes[30].NoeudB := 53;
    Aretes[30].EquipementIndex := 30;
    // 31: PENCRAN_DB (global 55-36; local 5-6)
    Equipements[31].Id := 3;
    Equipements[31].NoeudA := 5;
    Equipements[31].NoeudB := 6;
    Equipements[31].Ferme := FALSE;
    Equipements[31].Defaut := FALSE;
    Equipements[31].Conducteur := FALSE;
    Aretes[31].NoeudA := 54;
    Aretes[31].NoeudB := 35;
    Aretes[31].EquipementIndex := 31;
    // 32: PENCRAN_DL (global 52-35; local 7-8)
    Equipements[32].Id := 4;
    Equipements[32].NoeudA := 7;
    Equipements[32].NoeudB := 8;
    Equipements[32].Ferme := FALSE;
    Equipements[32].Defaut := FALSE;
    Equipements[32].Conducteur := FALSE;
    Aretes[32].NoeudA := 51;
    Aretes[32].NoeudB := 34;
    Aretes[32].EquipementIndex := 32;
    // 33: PENCRAN_IS1 (global 35-33; local 8-9)
    Equipements[33].Id := 5;
    Equipements[33].NoeudA := 8;
    Equipements[33].NoeudB := 9;
    Equipements[33].Ferme := FALSE;
    Equipements[33].Defaut := FALSE;
    Equipements[33].Conducteur := FALSE;
    Aretes[33].NoeudA := 34;
    Aretes[33].NoeudB := 32;
    Aretes[33].EquipementIndex := 33;
    // 34: PENCRAN_IS2 (global 35-34; local 8-10)
    Equipements[34].Id := 6;
    Equipements[34].NoeudA := 8;
    Equipements[34].NoeudB := 10;
    Equipements[34].Ferme := FALSE;
    Equipements[34].Defaut := FALSE;
    Equipements[34].Conducteur := FALSE;
    Aretes[34].NoeudA := 34;
    Aretes[34].NoeudB := 33;
    Aretes[34].EquipementIndex := 34;
    // 35: PENCRAN_IS3 (global 36-37; local 6-11)
    Equipements[35].Id := 7;
    Equipements[35].NoeudA := 6;
    Equipements[35].NoeudB := 11;
    Equipements[35].Ferme := FALSE;
    Equipements[35].Defaut := FALSE;
    Equipements[35].Conducteur := FALSE;
    Aretes[35].NoeudA := 35;
    Aretes[35].NoeudB := 36;
    Aretes[35].EquipementIndex := 35;
    // 36: PENCRAN_IS4 (global 36-38; local 6-12)
    Equipements[36].Id := 8;
    Equipements[36].NoeudA := 6;
    Equipements[36].NoeudB := 12;
    Equipements[36].Ferme := FALSE;
    Equipements[36].Defaut := FALSE;
    Equipements[36].Conducteur := FALSE;
    Aretes[36].NoeudA := 35;
    Aretes[36].NoeudB := 37;
    Aretes[36].EquipementIndex := 36;
    // 37: PENCRAN_P1 (global 33-37; local 9-11)
    Equipements[37].Id := 9;
    Equipements[37].NoeudA := 9;
    Equipements[37].NoeudB := 11;
    Equipements[37].Ferme := FALSE;
    Equipements[37].Defaut := FALSE;
    Equipements[37].Conducteur := FALSE;
    Aretes[37].NoeudA := 32;
    Aretes[37].NoeudB := 36;
    Aretes[37].EquipementIndex := 37;
    // 38: PENCRAN_P2 (global 34-38; local 10-12)
    Equipements[38].Id := 10;
    Equipements[38].NoeudA := 10;
    Equipements[38].NoeudB := 12;
    Equipements[38].Ferme := FALSE;
    Equipements[38].Defaut := FALSE;
    Equipements[38].Conducteur := FALSE;
    Aretes[38].NoeudA := 33;
    Aretes[38].NoeudB := 37;
    Aretes[38].EquipementIndex := 38;
    // 39: PENCRAN_S11 (global 56-50; local 13-1)
    Equipements[39].Id := 11;
    Equipements[39].NoeudA := 13;
    Equipements[39].NoeudB := 1;
    Equipements[39].Ferme := FALSE;
    Equipements[39].Defaut := FALSE;
    Equipements[39].Conducteur := FALSE;
    Aretes[39].NoeudA := 55;
    Aretes[39].NoeudB := 49;
    Aretes[39].EquipementIndex := 39;
    // 40: PENCRAN_S21 (global 57-53; local 14-3)
    Equipements[40].Id := 12;
    Equipements[40].NoeudA := 14;
    Equipements[40].NoeudB := 3;
    Equipements[40].Ferme := FALSE;
    Equipements[40].Defaut := FALSE;
    Equipements[40].Conducteur := FALSE;
    Aretes[40].NoeudA := 56;
    Aretes[40].NoeudB := 52;
    Aretes[40].EquipementIndex := 40;
    // 41: PENCRAN_SB1 (global 52-55; local 7-5)
    Equipements[41].Id := 13;
    Equipements[41].NoeudA := 7;
    Equipements[41].NoeudB := 5;
    Equipements[41].Ferme := FALSE;
    Equipements[41].Defaut := FALSE;
    Equipements[41].Conducteur := FALSE;
    Aretes[41].NoeudA := 51;
    Aretes[41].NoeudB := 54;
    Aretes[41].EquipementIndex := 41;
    // 42: PENCRAN_SBP1 (global 50-53; local 1-3)
    Equipements[42].Id := 14;
    Equipements[42].NoeudA := 1;
    Equipements[42].NoeudB := 3;
    Equipements[42].Ferme := FALSE;
    Equipements[42].Defaut := FALSE;
    Equipements[42].Conducteur := FALSE;
    Aretes[42].NoeudA := 49;
    Aretes[42].NoeudB := 52;
    Aretes[42].EquipementIndex := 42;
    // 43: PENCRAN_SLB1 (global 35-36; local 8-6)
    Equipements[43].Id := 15;
    Equipements[43].NoeudA := 8;
    Equipements[43].NoeudB := 6;
    Equipements[43].Ferme := FALSE;
    Equipements[43].Defaut := FALSE;
    Equipements[43].Conducteur := FALSE;
    Aretes[43].NoeudA := 34;
    Aretes[43].NoeudB := 35;
    Aretes[43].EquipementIndex := 43;
    // 44: PENCRAN_SRB1 (global 51-52; local 2-7)
    Equipements[44].Id := 16;
    Equipements[44].NoeudA := 2;
    Equipements[44].NoeudB := 7;
    Equipements[44].Ferme := FALSE;
    Equipements[44].Defaut := FALSE;
    Equipements[44].Conducteur := FALSE;
    Aretes[44].NoeudA := 50;
    Aretes[44].NoeudB := 51;
    Aretes[44].EquipementIndex := 44;
    // 45: PENCRAN_SRB2 (global 54-55; local 4-5)
    Equipements[45].Id := 17;
    Equipements[45].NoeudA := 4;
    Equipements[45].NoeudB := 5;
    Equipements[45].Ferme := FALSE;
    Equipements[45].Defaut := FALSE;
    Equipements[45].Conducteur := FALSE;
    Aretes[45].NoeudA := 53;
    Aretes[45].NoeudB := 54;
    Aretes[45].EquipementIndex := 45;
    // 46: PLOUIGNEAU_IL1 (global 9-5; local 1-2)
    Equipements[46].Id := 1;
    Equipements[46].NoeudA := 1;
    Equipements[46].NoeudB := 2;
    Equipements[46].Ferme := FALSE;
    Equipements[46].Defaut := FALSE;
    Equipements[46].Conducteur := FALSE;
    Aretes[46].NoeudA := 8;
    Aretes[46].NoeudB := 4;
    Aretes[46].EquipementIndex := 46;
    // 47: PLOUIGNEAU_IL2 (global 8-6; local 3-4)
    Equipements[47].Id := 2;
    Equipements[47].NoeudA := 3;
    Equipements[47].NoeudB := 4;
    Equipements[47].Ferme := FALSE;
    Equipements[47].Defaut := FALSE;
    Equipements[47].Conducteur := FALSE;
    Aretes[47].NoeudA := 7;
    Aretes[47].NoeudB := 5;
    Aretes[47].EquipementIndex := 47;
    // 48: PLOUIGNEAU_IL3 (global 9-11; local 1-5)
    Equipements[48].Id := 3;
    Equipements[48].NoeudA := 1;
    Equipements[48].NoeudB := 5;
    Equipements[48].Ferme := FALSE;
    Equipements[48].Defaut := FALSE;
    Equipements[48].Conducteur := FALSE;
    Aretes[48].NoeudA := 8;
    Aretes[48].NoeudB := 10;
    Aretes[48].EquipementIndex := 48;
    // 49: PLOUIGNEAU_IL4 (global 8-12; local 3-6)
    Equipements[49].Id := 4;
    Equipements[49].NoeudA := 3;
    Equipements[49].NoeudB := 6;
    Equipements[49].Ferme := FALSE;
    Equipements[49].Defaut := FALSE;
    Equipements[49].Conducteur := FALSE;
    Aretes[49].NoeudA := 7;
    Aretes[49].NoeudB := 11;
    Aretes[49].EquipementIndex := 49;
    // 50: PLOUIGNEAU_IMP (global 8-9; local 3-1)
    Equipements[50].Id := 5;
    Equipements[50].NoeudA := 3;
    Equipements[50].NoeudB := 1;
    Equipements[50].Ferme := FALSE;
    Equipements[50].Defaut := FALSE;
    Equipements[50].Conducteur := FALSE;
    Aretes[50].NoeudA := 7;
    Aretes[50].NoeudB := 8;
    Aretes[50].EquipementIndex := 50;
    // 51: PLOUIGNEAU_S4-12 (global 6-12; local 4-6)
    Equipements[51].Id := 6;
    Equipements[51].NoeudA := 4;
    Equipements[51].NoeudB := 6;
    Equipements[51].Ferme := FALSE;
    Equipements[51].Defaut := FALSE;
    Equipements[51].Conducteur := FALSE;
    Aretes[51].NoeudA := 5;
    Aretes[51].NoeudB := 11;
    Aretes[51].EquipementIndex := 51;
    // 52: PLOUIGNEAU_S5-11 (global 5-11; local 2-5)
    Equipements[52].Id := 7;
    Equipements[52].NoeudA := 2;
    Equipements[52].NoeudB := 5;
    Equipements[52].Ferme := FALSE;
    Equipements[52].Defaut := FALSE;
    Equipements[52].Conducteur := FALSE;
    Aretes[52].NoeudA := 4;
    Aretes[52].NoeudB := 10;
    Aretes[52].EquipementIndex := 52;
    // 53: PLOUIGNEAU_SAT1 (global 9-10; local 1-7)
    Equipements[53].Id := 8;
    Equipements[53].NoeudA := 1;
    Equipements[53].NoeudB := 7;
    Equipements[53].Ferme := FALSE;
    Equipements[53].Defaut := FALSE;
    Equipements[53].Conducteur := FALSE;
    Aretes[53].NoeudA := 8;
    Aretes[53].NoeudB := 9;
    Aretes[53].EquipementIndex := 53;
    // 54: PLOUIGNEAU_SAT2 (global 7-8; local 8-3)
    Equipements[54].Id := 9;
    Equipements[54].NoeudA := 8;
    Equipements[54].NoeudB := 3;
    Equipements[54].Ferme := FALSE;
    Equipements[54].Defaut := FALSE;
    Equipements[54].Conducteur := FALSE;
    Aretes[54].NoeudA := 6;
    Aretes[54].NoeudB := 7;
    Aretes[54].EquipementIndex := 54;
    // 55: PLOUNERIN_IL1 (global 2-5; local 1-2)
    Equipements[55].Id := 1;
    Equipements[55].NoeudA := 1;
    Equipements[55].NoeudB := 2;
    Equipements[55].Ferme := FALSE;
    Equipements[55].Defaut := FALSE;
    Equipements[55].Conducteur := FALSE;
    Aretes[55].NoeudA := 1;
    Aretes[55].NoeudB := 4;
    Aretes[55].EquipementIndex := 55;
    // 56: PLOUNERIN_IL2 (global 2-6; local 1-3)
    Equipements[56].Id := 2;
    Equipements[56].NoeudA := 1;
    Equipements[56].NoeudB := 3;
    Equipements[56].Ferme := FALSE;
    Equipements[56].Defaut := FALSE;
    Equipements[56].Conducteur := FALSE;
    Aretes[56].NoeudA := 1;
    Aretes[56].NoeudB := 5;
    Aretes[56].EquipementIndex := 56;
    // 57: PLOUNERIN_IL3 (global 3-5; local 4-2)
    Equipements[57].Id := 3;
    Equipements[57].NoeudA := 4;
    Equipements[57].NoeudB := 2;
    Equipements[57].Ferme := FALSE;
    Equipements[57].Defaut := FALSE;
    Equipements[57].Conducteur := FALSE;
    Aretes[57].NoeudA := 2;
    Aretes[57].NoeudB := 4;
    Aretes[57].EquipementIndex := 57;
    // 58: PLOUNERIN_IL4 (global 3-6; local 4-3)
    Equipements[58].Id := 4;
    Equipements[58].NoeudA := 4;
    Equipements[58].NoeudB := 3;
    Equipements[58].Ferme := FALSE;
    Equipements[58].Defaut := FALSE;
    Equipements[58].Conducteur := FALSE;
    Aretes[58].NoeudA := 2;
    Aretes[58].NoeudB := 5;
    Aretes[58].EquipementIndex := 58;
    // 59: PLOUNERIN_IP (global 2-3; local 1-4)
    Equipements[59].Id := 5;
    Equipements[59].NoeudA := 1;
    Equipements[59].NoeudB := 4;
    Equipements[59].Ferme := FALSE;
    Equipements[59].Defaut := FALSE;
    Equipements[59].Conducteur := FALSE;
    Aretes[59].NoeudA := 1;
    Aretes[59].NoeudB := 2;
    Aretes[59].EquipementIndex := 59;
    // 60: PLOUNERIN_SAT1 (global 1-2; local 5-1)
    Equipements[60].Id := 6;
    Equipements[60].NoeudA := 5;
    Equipements[60].NoeudB := 1;
    Equipements[60].Ferme := FALSE;
    Equipements[60].Defaut := FALSE;
    Equipements[60].Conducteur := FALSE;
    Aretes[60].NoeudA := 0;
    Aretes[60].NoeudB := 1;
    Aretes[60].EquipementIndex := 60;
    // 61: PLOUNERIN_SAT2 (global 3-4; local 4-6)
    Equipements[61].Id := 7;
    Equipements[61].NoeudA := 4;
    Equipements[61].NoeudB := 6;
    Equipements[61].Ferme := FALSE;
    Equipements[61].Defaut := FALSE;
    Equipements[61].Conducteur := FALSE;
    Aretes[61].NoeudA := 2;
    Aretes[61].NoeudB := 3;
    Aretes[61].EquipementIndex := 61;
    // 62: ST_MARC_IL1 (global 44-39; local 1-2)
    Equipements[62].Id := 1;
    Equipements[62].NoeudA := 1;
    Equipements[62].NoeudB := 2;
    Equipements[62].Ferme := FALSE;
    Equipements[62].Defaut := FALSE;
    Equipements[62].Conducteur := FALSE;
    Aretes[62].NoeudA := 43;
    Aretes[62].NoeudB := 38;
    Aretes[62].EquipementIndex := 62;
    // 63: ST_MARC_IL2 (global 45-40; local 3-4)
    Equipements[63].Id := 2;
    Equipements[63].NoeudA := 3;
    Equipements[63].NoeudB := 4;
    Equipements[63].Ferme := FALSE;
    Equipements[63].Defaut := FALSE;
    Equipements[63].Conducteur := FALSE;
    Aretes[63].NoeudA := 44;
    Aretes[63].NoeudB := 39;
    Aretes[63].EquipementIndex := 63;
    // 64: ST_MARC_IL3 (global 44-47; local 1-5)
    Equipements[64].Id := 3;
    Equipements[64].NoeudA := 1;
    Equipements[64].NoeudB := 5;
    Equipements[64].Ferme := FALSE;
    Equipements[64].Defaut := FALSE;
    Equipements[64].Conducteur := FALSE;
    Aretes[64].NoeudA := 43;
    Aretes[64].NoeudB := 46;
    Aretes[64].EquipementIndex := 64;
    // 65: ST_MARC_IL4 (global 45-48; local 3-6)
    Equipements[65].Id := 4;
    Equipements[65].NoeudA := 3;
    Equipements[65].NoeudB := 6;
    Equipements[65].Ferme := FALSE;
    Equipements[65].Defaut := FALSE;
    Equipements[65].Conducteur := FALSE;
    Aretes[65].NoeudA := 44;
    Aretes[65].NoeudB := 47;
    Aretes[65].EquipementIndex := 65;
    // 66: ST_MARC_IMP (global 44-45; local 1-3)
    Equipements[66].Id := 5;
    Equipements[66].NoeudA := 1;
    Equipements[66].NoeudB := 3;
    Equipements[66].Ferme := FALSE;
    Equipements[66].Defaut := FALSE;
    Equipements[66].Conducteur := FALSE;
    Aretes[66].NoeudA := 43;
    Aretes[66].NoeudB := 44;
    Aretes[66].EquipementIndex := 66;
    // 67: ST_MARC_S4-10 (global 40-48; local 4-6)
    Equipements[67].Id := 6;
    Equipements[67].NoeudA := 4;
    Equipements[67].NoeudB := 6;
    Equipements[67].Ferme := FALSE;
    Equipements[67].Defaut := FALSE;
    Equipements[67].Conducteur := FALSE;
    Aretes[67].NoeudA := 39;
    Aretes[67].NoeudB := 47;
    Aretes[67].EquipementIndex := 67;
    // 68: ST_MARC_S5-11 (global 39-47; local 2-5)
    Equipements[68].Id := 7;
    Equipements[68].NoeudA := 2;
    Equipements[68].NoeudB := 5;
    Equipements[68].Ferme := FALSE;
    Equipements[68].Defaut := FALSE;
    Equipements[68].Conducteur := FALSE;
    Aretes[68].NoeudA := 38;
    Aretes[68].NoeudB := 46;
    Aretes[68].EquipementIndex := 68;
    // 69: ST_MARC_SAT1 (global 43-44; local 7-1)
    Equipements[69].Id := 8;
    Equipements[69].NoeudA := 7;
    Equipements[69].NoeudB := 1;
    Equipements[69].Ferme := FALSE;
    Equipements[69].Defaut := FALSE;
    Equipements[69].Conducteur := FALSE;
    Aretes[69].NoeudA := 42;
    Aretes[69].NoeudB := 43;
    Aretes[69].EquipementIndex := 69;
    // 70: ST_MARC_SAT2 (global 45-46; local 3-8)
    Equipements[70].Id := 9;
    Equipements[70].NoeudA := 3;
    Equipements[70].NoeudB := 8;
    Equipements[70].Ferme := FALSE;
    Equipements[70].Defaut := FALSE;
    Equipements[70].Conducteur := FALSE;
    Aretes[70].NoeudA := 44;
    Aretes[70].NoeudB := 45;
    Aretes[70].EquipementIndex := 70;
    // 71: ST_THEGONNEC_IL1 (global 24-21; local 1-2)
    Equipements[71].Id := 1;
    Equipements[71].NoeudA := 1;
    Equipements[71].NoeudB := 2;
    Equipements[71].Ferme := FALSE;
    Equipements[71].Defaut := FALSE;
    Equipements[71].Conducteur := FALSE;
    Aretes[71].NoeudA := 23;
    Aretes[71].NoeudB := 20;
    Aretes[71].EquipementIndex := 71;
    // 72: ST_THEGONNEC_IL2 (global 25-22; local 3-4)
    Equipements[72].Id := 2;
    Equipements[72].NoeudA := 3;
    Equipements[72].NoeudB := 4;
    Equipements[72].Ferme := FALSE;
    Equipements[72].Defaut := FALSE;
    Equipements[72].Conducteur := FALSE;
    Aretes[72].NoeudA := 24;
    Aretes[72].NoeudB := 21;
    Aretes[72].EquipementIndex := 72;
    // 73: ST_THEGONNEC_IL3 (global 24-27; local 1-5)
    Equipements[73].Id := 3;
    Equipements[73].NoeudA := 1;
    Equipements[73].NoeudB := 5;
    Equipements[73].Ferme := FALSE;
    Equipements[73].Defaut := FALSE;
    Equipements[73].Conducteur := FALSE;
    Aretes[73].NoeudA := 23;
    Aretes[73].NoeudB := 26;
    Aretes[73].EquipementIndex := 73;
    // 74: ST_THEGONNEC_IL4 (global 25-28; local 3-6)
    Equipements[74].Id := 4;
    Equipements[74].NoeudA := 3;
    Equipements[74].NoeudB := 6;
    Equipements[74].Ferme := FALSE;
    Equipements[74].Defaut := FALSE;
    Equipements[74].Conducteur := FALSE;
    Aretes[74].NoeudA := 24;
    Aretes[74].NoeudB := 27;
    Aretes[74].EquipementIndex := 74;
    // 75: ST_THEGONNEC_IMP (global 24-25; local 1-3)
    Equipements[75].Id := 5;
    Equipements[75].NoeudA := 1;
    Equipements[75].NoeudB := 3;
    Equipements[75].Ferme := FALSE;
    Equipements[75].Defaut := FALSE;
    Equipements[75].Conducteur := FALSE;
    Aretes[75].NoeudA := 23;
    Aretes[75].NoeudB := 24;
    Aretes[75].EquipementIndex := 75;
    // 76: ST_THEGONNEC_S20-30 (global 22-28; local 4-6)
    Equipements[76].Id := 6;
    Equipements[76].NoeudA := 4;
    Equipements[76].NoeudB := 6;
    Equipements[76].Ferme := FALSE;
    Equipements[76].Defaut := FALSE;
    Equipements[76].Conducteur := FALSE;
    Aretes[76].NoeudA := 21;
    Aretes[76].NoeudB := 27;
    Aretes[76].EquipementIndex := 76;
    // 77: ST_THEGONNEC_S21-31 (global 21-27; local 2-5)
    Equipements[77].Id := 7;
    Equipements[77].NoeudA := 2;
    Equipements[77].NoeudB := 5;
    Equipements[77].Ferme := FALSE;
    Equipements[77].Defaut := FALSE;
    Equipements[77].Conducteur := FALSE;
    Aretes[77].NoeudA := 20;
    Aretes[77].NoeudB := 26;
    Aretes[77].EquipementIndex := 77;
    // 78: ST_THEGONNEC_SAT1 (global 23-24; local 7-1)
    Equipements[78].Id := 8;
    Equipements[78].NoeudA := 7;
    Equipements[78].NoeudB := 1;
    Equipements[78].Ferme := FALSE;
    Equipements[78].Defaut := FALSE;
    Equipements[78].Conducteur := FALSE;
    Aretes[78].NoeudA := 22;
    Aretes[78].NoeudB := 23;
    Aretes[78].EquipementIndex := 78;
    // 79: ST_THEGONNEC_SAT2 (global 25-26; local 3-8)
    Equipements[79].Id := 9;
    Equipements[79].NoeudA := 3;
    Equipements[79].NoeudB := 8;
    Equipements[79].Ferme := FALSE;
    Equipements[79].Defaut := FALSE;
    Equipements[79].Conducteur := FALSE;
    Aretes[79].NoeudA := 24;
    Aretes[79].NoeudB := 25;
    Aretes[79].EquipementIndex := 79;
    ConfigurationChargee := TRUE;
END_IF;

// Indices BFS 55,56 correspondent aux noeuds metier 56,57.
Sources[55] := SourceS11Active;
Sources[56] := SourceS21Active;
MoteurBFS(
    NbNoeuds := NbNoeuds,
    NbAretes := NbAretes,
    NbEquipements := NbEquipements,
    Sources := Sources,
    Aretes := Aretes,
    Equipements := Equipements,
    Noeuds := Noeuds
);
ErreurConfiguration := MoteurBFS.ErreurConfiguration;
END_FUNCTION_BLOCK
