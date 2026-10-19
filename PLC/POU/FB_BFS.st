FUNCTION_BLOCK FB_BFS
VAR_INPUT
    NbNoeuds : UINT;
    NbAretes : UINT;
    NbEquipements : UINT;
    Sources : ARRAY[0..56] OF BOOL;
    Aretes : ARRAY[0..79] OF ST_AreteZone;
    Equipements : ARRAY[0..79] OF ST_Equipement;
END_VAR
VAR_IN_OUT
    Noeuds : ARRAY[0..56] OF ST_Noeud;
END_VAR
VAR_OUTPUT
    ErreurConfiguration : BOOL;
END_VAR
VAR
    FileNoeuds : ARRAY[0..56] OF UINT;
    TeteFile : UINT;
    FinFile : UINT;
    NoeudCourant : UINT;
    NoeudVoisin : UINT;
    i : INT;
    j : INT;
    k : INT;
    IndexEquipement : INT;
    AreteActive : BOOL;
END_VAR

// Validation des dimensions AVANT toute propagation.
ErreurConfiguration := (NbNoeuds > 57) OR (NbAretes > 80)
    OR (NbEquipements > 80);

IF NOT ErreurConfiguration THEN
    // Verification structurelle : pas d'indices invalides.
    FOR j := 0 TO UINT_TO_INT(NbAretes) - 1 DO
        IndexEquipement := Aretes[j].EquipementIndex;
        IF (Aretes[j].NoeudA >= NbNoeuds)
            OR (Aretes[j].NoeudB >= NbNoeuds)
            OR (IndexEquipement < -1)
            OR (IndexEquipement >= UINT_TO_INT(NbEquipements)) THEN
            ErreurConfiguration := TRUE;
        END_IF;
    END_FOR;
END_IF;

// Un graphe invalide ne doit jamais exposer un etat SousTension obsolete.
FOR i := 0 TO 56 DO
    Noeuds[i].SousTension := FALSE;
END_FOR;

IF NOT ErreurConfiguration THEN
    TeteFile := 0;
    FinFile := 0;

    FOR i := 0 TO UINT_TO_INT(NbNoeuds) - 1 DO
        IF Sources[i] THEN
            Noeuds[i].SousTension := TRUE;
            FileNoeuds[FinFile] := INT_TO_UINT(i);
            FinFile := FinFile + 1;
        END_IF;
    END_FOR;

    WHILE TeteFile < FinFile DO
        NoeudCourant := FileNoeuds[TeteFile];
        TeteFile := TeteFile + 1;

        FOR k := 0 TO UINT_TO_INT(NbAretes) - 1 DO
            IndexEquipement := Aretes[k].EquipementIndex;
            AreteActive := IndexEquipement = -1;
            IF IndexEquipement >= 0 THEN
                AreteActive := Equipements[IndexEquipement].Ferme
                    AND NOT Equipements[IndexEquipement].Defaut;
            END_IF;

            IF AreteActive THEN
                IF Aretes[k].NoeudA = NoeudCourant THEN
                    NoeudVoisin := Aretes[k].NoeudB;
                ELSIF Aretes[k].NoeudB = NoeudCourant THEN
                    NoeudVoisin := Aretes[k].NoeudA;
                ELSE
                    CONTINUE;
                END_IF;

                IF NOT Noeuds[NoeudVoisin].SousTension THEN
                    // Au plus un enfilement par noeud : capacite 57.
                    Noeuds[NoeudVoisin].SousTension := TRUE;
                    FileNoeuds[FinFile] := NoeudVoisin;
                    FinFile := FinFile + 1;
                END_IF;
            END_IF;
        END_FOR;
    END_WHILE;
END_IF;

END_FUNCTION_BLOCK
