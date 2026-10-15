# PIRATE — Zone 101 (Vue 3)

IHM pédagogique de simulation locale issue de [Figma Zone 101](https://www.figma.com/design/MgnmKQ8iqTnLs5C1koSLrA).

## Installation

Node.js compatible Vite 7 nécessaire.

```bash
cd IHM
npm install
npm run dev
```

Trois écrans : **Vue d’ensemble**, **Injection de défauts** et **Positions normales**. Dans la vue d’ensemble, cliquer sur le repère d’un équipement ouvre une fenêtre modale pour demander son ouverture ou sa fermeture. Les changements d'état sont partagés entre composants Vue.

Aucune communication avec PIRATE ni CODESYS. États et défauts fictifs ; le BFS, l’état sous tension, les protections, les interverrouillages et l'impact des défauts ne sont pas implémentés. Usage pédagogique isolé uniquement.

L’architecture cible prévoit de remplacer les données locales par des valeurs confirmées par le simulateur CODESYS via une passerelle WebSocket. Ne pas connecter les commandes de cette maquette à une installation opérationnelle.