# Configuration topologique

La Zone 101 et la sous-station Pencran sont integrees au modele de simulation par `FB_Zone` : 57 noeuds et 80 aretes d'equipements, sur la base des feuilles « Noeuds » et « Sous-Station » corrigees.

Voir [ZONE101.md](ZONE101.md) et [zone101_correspondances.csv](zone101_correspondances.csv) pour les numeros de noeuds, reperes, sources et limites de validation.

Conventions conservees : `Conducteur = Ferme AND NOT Defaut` ; les noeuds globaux sont distincts des identifiants locaux de poste ; les sources sont internes au perimetre Pencran et inactives par defaut.

Les mappings vers les entrees/sorties PIRATE ne sont pas encore actifs. Le programme doit etre compile et teste dans CODESYS avant exploitation du simulateur.
