TYPE ST_Equipement :
STRUCT
    Id : UINT; // identifiant unique dans la zone (1..80)
    Ferme : BOOL; // commande ou position simulee
    Defaut : BOOL; // indisponibilite : coupe la conduction
    Conducteur : BOOL; // resultat calcule par FB_Zone
END_STRUCT
END_TYPE
