# Zone 101 — topologie du simulateur

## Fichiers
- `PLC/POU/FB_Zone.st` : initialise 57 noeuds et 80 equipements dans les structures **existantes** `ST_Noeud`, `ST_Equipement`, `ST_AreteZone`, puis execute `FB_BFS`.
- `PLC/Config/zone101_correspondances.csv` : correspondance exacte entre repere d'equipement, index de tableau (0..79), identifiant local de poste et noeuds globaux/locaux.

## Indices et conventions
- Numero du classeur / IdZone = indice CODESYS + 1.
- Zone 101 : noeuds globaux 1..49. Pencran : globaux 50..55, locaux 1..6.
- Globaux 56,57 : points d'injection amont virtuels des sectionneurs PENCRAN_S11 et PENCRAN_S21 (indices BFS 55 et 56).
- Sources amont inactives par defaut ; entrées du FB : SourceS11Active et SourceS21Active.
- 80 aretes conditionnelles (EquipementIndex >= 0), aucune continuite inventee pour les autotransformateurs AT/TSA.
- Chaque equipement est interrupteur logique : Ferme AND NOT Defaut. Les variables d'etat sont initialisees uniquement lors du premier appel, puis conservées.
- Les nœuds partages entre postes possedent un identifiant global commun mais les numeros locaux se referent a chaque poste; le champ IdLocal du tableau global n'est renseigne que pour Pencran. Pour les autres postes, utiliser la table de correspondance.

## Interface PIRATE
Les noms externes `GVL_PIRATE` et `GVL_PIRATE_Interne` ne sont **pas modifies**. Il faut valider le mapping des commandes et telesignalisations par equipement avant de relier les signaux PIRATE aux champs `Ferme` et `Defaut`. En particulier, les variables de telecommande ou de position ne doivent pas etre assimilees arbitrairement aux etats internes.

## Verification avant utilisation
1. Importer le `FB_Zone` modifie dans CODESYS avec les DUT existants et `FB_BFS`.
2. Compiler sur la cible CODESYS retenue (non execute dans cette integration).
3. Tester les deux sources desactivees, puis S11 seule, S21 seule, les deux actives.
4. Tester l'ouverture et le defaut de chaque equipement, notamment `PENCRAN_DL` (index 32), `PENCRAN_DB` (index 31), `PENCRAN_SB1` (41) et `PENCRAN_SBP1` (42).
5. Verifier le comportement des 15 terminaux AT/TSA non modelises par des aretes avant de pretendre simuler l'electrique reel.

Cette integration est un modele de simulation non valide pour la commande ou la securite d'une installation reelle.
