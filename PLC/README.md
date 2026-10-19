# PLC — PIRATE dev_easy

Architecture centralisee sous Structured Text (CODESYS) :
- `POU/FB_Zone.st` : initialisation topologique, etats des equipements, sources et orchestration ;
- `POU/FB_BFS.st` : propagation logique de la tension ;
- `DUT/ST_Equipement.st`, `DUT/ST_Noeud.st`, `DUT/ST_AreteZone.st` : trois structures du graphe ;
- `Config/zone101_correspondances.csv` : mapping des 80 equipements ;
- `GVL/` et `POU/FB_InterfacePIRATE*` : declarations et copie de variables PIRATE conservees sans mapping fonctionnel vers le BFS.

Voir [README_ARCHITECTURE.md](README_ARCHITECTURE.md) pour la convention de calcul, la procedure d'appel et les limites.
