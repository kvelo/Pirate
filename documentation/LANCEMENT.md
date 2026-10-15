# Lancer l’IHM sous Windows

Prerequis : Git pour Windows (Git Bash), Node.js compatible avec Vite 7 et Google Chrome.

1. Recuperer la branche `dev` : `git switch dev`, puis `git pull origin dev`.
2. Double-cliquer sur `Lancer-PIRATE.bat` a la racine du depot Pirate.
3. Pour un raccourci bureau : clic droit sur ce fichier → Envoyer vers → Bureau (creer un raccourci). Ne pas deplacer le fichier BAT seul.

Le script installe les dependances si Vite est absent, demarre le serveur sur le port fixe 5173, attend sa disponibilite puis ouvre Chrome en mode kiosque (plein ecran), dans un profil dedie. Le premier lancement peut demander un acces Internet pour npm. Garder le terminal ouvert.

Alt+F4 ferme Chrome. Ctrl+C dans le terminal arrete Vue. Fermer Chrome seul ne coupe pas le serveur. Si un serveur occupe deja le port 5173, le fermer avant de relancer. Les positions normales sauvegardees dans votre profil Chrome habituel ne sont pas partagees avec le profil dedie.
