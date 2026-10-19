# Zone 101 / Pencran — reference topologique

- 49 noeuds de zone (IDs 1..49).
- 6 noeuds internes Pencran (IDs 50..55).
- 2 noeuds virtuels d'injection (IDs 56 et 57 ; indices BFS 55 et 56).
- 80 equipements modelises comme interrupteurs a deux bornes.
- 80 aretes reliant des **indices** de noeuds (ID - 1).
- Sources amont S11 et S21 desactivees par defaut.
- Toute continuite = `Ferme AND NOT Defaut`.
- Correspondance equipement/indice dans `zone101_correspondances.csv`.

`FB_Zone` stocke directement le graphe complet et appelle `FB_BFS` de facon cyclique. Aucun objet poste/port n'est requis. Les noms des equipements sont conserves en commentaire dans `FB_Zone.st`.

Les dispositifs AT/TSA sans deux bornes documentees ne sont pas ajoutes comme aretes. Les positions des equipements et les sources ne sont pas encore raccordees aux variables PIRATE. Le graphe est un **simulateur** et non un calcul electrique pour exploitation reelle.
