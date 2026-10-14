TYPE ST_Equipement :
STRUCT
    Id : UINT; // identifiant local au poste
    NoeudA : UINT; // noeud local
    NoeudB : UINT; // noeud local
    Ferme : BOOL;
    Defaut : BOOL;
    Conducteur : BOOL; // calcule, ne pas commander
END_STRUCT
END_TYPE
