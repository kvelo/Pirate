TYPE ST_AreteZone :
STRUCT
    NoeudA : UINT; // indice dans le tableau des noeuds de la zone
    NoeudB : UINT; // indice dans le tableau des noeuds de la zone
    EquipementIndex : INT; // -1 pour une liaison permanente, sinon indice equipement
END_STRUCT
END_TYPE
