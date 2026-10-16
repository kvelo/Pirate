# PIRATE — Socle CODESYS (architecture)

## Etat
Squelettes de code et DUT uniquement. Aucun runtime, compilateur, appareil ou
topologie complete n'a ete valide. Les fichiers ST sont destines a etre importes
en tant que DUT (TYPE), POU (FUNCTION_BLOCK) et GVL dans CODESYS.

## Principes valides
- Tout equipement simule est un interrupteur logique a deux bornes.
- Conducteur = Ferme AND NOT Defaut ; Defaut ne modifie pas Ferme.
- Identifiants des noeuds locaux au poste, numerotation distincte par zone.
- Ports generiques ; un port peut participer a plusieurs liaisons externes.
- Les voies sont des liaisons entre ports. Les jeux de barres existent
  dans le tableur topologique, pas comme objets de l'automate.
- Sources internes aux sous-stations uniquement ; Pencran source de la zone 101.
- La tension logique des ports resulte d'un BFS depuis les sources internes.
- La zone gere le graphe interpostes, les postes leurs equipements locaux.
- La correspondance vers les variables PIRATE doit etre validee avant activation.

## Interface du BFS
- `ST_AreteZone.NoeudA/NoeudB` sont des indices dans le tableau des noeuds de la zone.
- `EquipementIndex = -1` indique une liaison permanente ; sinon l'arete suit l'equipement correspondant.
- Un equipement ne conduit que si `Ferme = TRUE` et `Defaut = FALSE`.
- `Sources[i]` active le noeud d'indice `i` ; le resultat est ecrit dans `Noeuds[i].SousTension`.
- Capacites actuelles de `FB_BFS` : 400 noeuds, 400 aretes et 120 equipements, a ajuster apres validation des topologies.

## Prochaines etapes
1. Verifier la syntaxe et importer les DUT dans CODESYS.
2. Dimensionner les collections apres validation de la topologie.
3. Definir les interfaces et tests des FB.
4. Importer la configuration du reseau puis implementer le BFS.
5. Mettre au point et tester les associations PIRATE.
