TYPE ST_Equipement :
STRUCT
    Id : UINT; // identifiant unique dans la zone (1..80)
    Ferme : BOOL; // commande ou position simulee
    Defaut : BOOL; // indisponibilite : coupe la conduction
    Asservi : BOOL; // TRUE si l'equipement est soumis a un asservissement (non implemente)
    Conducteur : BOOL; // resultat calcule par FB_Zone
END_STRUCT
END_TYPE
