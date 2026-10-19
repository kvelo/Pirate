# PIRATE — Architecture simplifiee (dev_easy)

## Moteur
La simulation de la zone 101 repose sur deux blocs :
- **FB_Zone** : possede les 57 noeuds, les 80 equipements, les 80 aretes et les 2 sources de Pencran. Initialise le graphe une seule fois, calcule `Conducteur` et appelle le moteur.
- **FB_BFS** : parcourt le graphe a chaque cycle depuis les sources actives, traite une arete uniquement si elle est conductrice et actualise `SousTension`.

Les 57 noeuds comprennent 49 noeuds de zone, 6 internes Pencran et 2 points virtuels d'injection amont des sectionneurs S11/S21. Les indices de tableau sont 0-based et les IDs metier 1-based.

## Structures conservees
- `ST_Equipement` : Id, Ferme, Defaut, Conducteur. Les deux extremites de l'equipement sont stockees exclusivement dans `ST_AreteZone`.
- `ST_AreteZone` : NoeudA, NoeudB, EquipementIndex.
- `ST_Noeud` : IdZone, SousTension.

## Convention
`Conducteur = Ferme AND NOT Defaut`. Un equipement en defaut reste dans sa position mecanique simulee mais ne propage plus l'alimentation. Toutes les positions commencent ouvertes et les deux sources inactives. La valeur `Ferme` doit etre mise a jour depuis une interface de simulation **validee**.

## Interface
- Les listes de variables `GVL_PIRATE` et `GVL_PIRATE_Interne` restent inchangees.
- `FB_InterfacePIRATE` et ses methodes de copie restent disponibles pour preparer l'interface PIRATE ; aucune correspondance automatique avec `Equipements[index]` n'est active.
- Les 80 indices d'equipement sont donnes dans `Config/zone101_correspondances.csv`.
- L'IHM Vue n'est pas modifiee ; aucune integration IHM/PLC n'est revendiquee.

## Supprime
`FB_Poste`, `PosteSSP`, `ST_Port`, `ST_RefNoeud`, `ST_ConnexionPorts`, `ST_Source` : objets du modele par poste, hors du graphe unique.

## Demarrage et cycle
1. Instancier `FB_Zone` et le programmer dans une tache cyclique.
2. Au premier appel, le bloc initialise son graphe, positions ouvertes et defauts a FALSE.
3. Aux cycles suivants, fournir `SourceS11Active` / `SourceS21Active` et mettre a jour `Equipements[i].Ferme` et `.Defaut` (mapping de simulation valide uniquement).
4. Apres l'appel au FB, lire `Noeuds[i].SousTension` et `ErreurConfiguration`.
5. Ne jamais reinitialiser les donnees a chaque cycle.

## Limites
Code non compile sur cible CODESYS dans cette intervention. Tester imports des types, appel des FB, propagation, defauts et activation des sources. Les dispositifs AT/TSA ne sont pas modelises comme continuites et les variables PIRATE ne sont pas encore associees ; ne pas utiliser pour un reseau reel.
