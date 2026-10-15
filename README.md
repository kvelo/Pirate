# PIRATE

Simulateur de formation du logiciel PIRATE pour RSS.

## Organisation

- `IHM/` : interface Vue 3 (vue d’ensemble, injection de défauts, positions normales).
- `PLC/` : programmes automate et structures CODESYS en Structured Text.
- `documentation/` : documentation générale et guide de lancement.
- `assets/` : icône du raccourci Windows.

## Lancer l’IHM

Sous Windows, double-cliquer sur `Lancer-PIRATE.bat` à la racine. Voir [le guide de lancement](documentation/LANCEMENT.md) pour les prérequis et l’ouverture sur l’écran 2.

Pour le développement :

```bash
cd IHM
npm install
npm run dev
```

Compilation : `npm run build` depuis `IHM/`.

Les programmes automate sont décrits dans [PLC/README.md](PLC/README.md) et [PLC/README_ARCHITECTURE.md](PLC/README_ARCHITECTURE.md).

## Regroupement des dépôts

Le contenu de `PIRATE_API/dev` a été intégré dans ce dépôt sans importer son historique Git. Les développements regroupés se poursuivent sur `dev`.
