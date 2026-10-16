FUNCTION_BLOCK FB_BFS
VAR
    FileNoeuds : ARRAY[0..399] OF UINT;
    TeteFile : UINT;
    FinFile : UINT;
    NoeudCourant : UINT;
    IndexNoeud : UINT;
    IndexArete : UINT;
    IndexEquipement : INT;
    NoeudVoisin : UINT;
    AreteActive : BOOL;
END_VAR
VAR_INPUT
    NbNoeuds : UINT;
    NbAretes : UINT;
    NbEquipements : UINT;
    Sources : ARRAY[0..399] OF BOOL;
    Aretes : ARRAY[0..399] OF ST_AreteZone;
    Equipements : ARRAY[0..119] OF ST_Equipement;
END_VAR
VAR_IN_OUT
    Noeuds : ARRAY[0..399] OF ST_Noeud;
END_VAR
VAR_OUTPUT
    ErreurConfiguration : BOOL;
END_VAR

ErreurConfiguration := (NbNoeuds > 400) OR (NbAretes > 400) OR (NbEquipements > 120);
TeteFile := 0;
FinFile := 0;

IF NbNoeuds <= 400 THEN
    IF NbNoeuds > 0 THEN
        FOR IndexNoeud := 0 TO NbNoeuds - 1 DO
            Noeuds[IndexNoeud].SousTension := FALSE;
            IF Sources[IndexNoeud] THEN
                Noeuds[IndexNoeud].SousTension := TRUE;
                FileNoeuds[FinFile] := IndexNoeud;
                FinFile := FinFile + 1;
            END_IF;
        END_FOR;
    END_IF;

    IF NOT ErreurConfiguration THEN
        WHILE TeteFile < FinFile DO
            NoeudCourant := FileNoeuds[TeteFile];
            TeteFile := TeteFile + 1;

            IF NbAretes > 0 THEN
                FOR IndexArete := 0 TO NbAretes - 1 DO
                    AreteActive := FALSE;
                    IndexEquipement := Aretes[IndexArete].EquipementIndex;

                    IF (Aretes[IndexArete].NoeudA < NbNoeuds)
                       AND (Aretes[IndexArete].NoeudB < NbNoeuds) THEN
                        IF IndexEquipement = -1 THEN
                            AreteActive := TRUE;
                        ELSIF IndexEquipement >= 0 THEN
                            IF IndexEquipement < NbEquipements THEN
                                AreteActive := Equipements[IndexEquipement].Ferme
                                    AND NOT Equipements[IndexEquipement].Defaut;
                            ELSE
                                ErreurConfiguration := TRUE;
                            END_IF;
                        ELSE
                            ErreurConfiguration := TRUE;
                        END_IF;

                        IF AreteActive THEN
                            IF Aretes[IndexArete].NoeudA = NoeudCourant THEN
                                NoeudVoisin := Aretes[IndexArete].NoeudB;
                                IF NOT Noeuds[NoeudVoisin].SousTension THEN
                                    Noeuds[NoeudVoisin].SousTension := TRUE;
                                    FileNoeuds[FinFile] := NoeudVoisin;
                                    FinFile := FinFile + 1;
                                END_IF;
                            ELSIF Aretes[IndexArete].NoeudB = NoeudCourant THEN
                                NoeudVoisin := Aretes[IndexArete].NoeudA;
                                IF NOT Noeuds[NoeudVoisin].SousTension THEN
                                    Noeuds[NoeudVoisin].SousTension := TRUE;
                                    FileNoeuds[FinFile] := NoeudVoisin;
                                    FinFile := FinFile + 1;
                                END_IF;
                            END_IF;
                        END_IF;
                    ELSE
                        ErreurConfiguration := TRUE;
                    END_IF;
                END_FOR;
            END_IF;
        END_WHILE;
    END_IF;
END_IF;







END_FUNCTION_BLOCK