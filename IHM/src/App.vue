<script setup>
// Un fichier .vue associe la logique JavaScript (script) et l'affichage (template).
// Avec « script setup », les imports et variables sont accessibles dans le template.
import { ref } from 'vue'
import ZoneOverview from './views/ZoneOverview.vue'
import DefautsView from './views/DefautsView.vue'
import PositionsNormalesView from './views/PositionsNormalesView.vue'
import CommandeModal from './components/CommandeModal.vue'
import { useSimulation } from './composables/useSimulation'
// ref rend une valeur réactive : Vue actualise l'écran lorsqu'elle change.
// Dans le JavaScript, on lit/écrit cette valeur avec .value ; le template s'en charge.
const page = ref('overview')
// null signifie qu'aucun équipement n'est sélectionné : la modale est alors fermée.
const selection = ref(null)
const { equipements } = useSimulation()
// find recherche l'objet correspondant à l'identifiant reçu depuis la vue d'ensemble.
function ouvrirEquipement(id) { selection.value = equipements.find(e => e.id === id) || null }
// Changer d'écran ferme aussi la fenêtre de commande éventuellement ouverte.
function changerPage(nom) { page.value = nom; selection.value = null }
</script>
<template>
<!-- :class lie des classes CSS aux valeurs JavaScript ; @click écoute un clic.
     v-if / v-else-if / v-else créent uniquement l'écran choisi (les autres sont démontés).
     @select reçoit un événement enfant ; :equipement transmet une donnée à la modale.
     @close remet la sélection à null et retire ainsi la modale de l'affichage. -->
<div class="app" :class="{ 'app--fullscreen': page === 'overview' || page === 'faults' }">
<header><div class="stripe"></div><div class="header"><b class="brand">PIRATE</b><strong>Zone 101 / Plounérin → Brest</strong><span class="chip amber">Simulation uniquement</span><span class="chip">Session de démonstration</span></div>
<nav><button :class="{active:page==='overview'}" @click="changerPage('overview')">Vue d’ensemble · Zone 101</button><button :class="{active:page==='faults'}" @click="changerPage('faults')">Injection de défauts</button><button :class="{active:page==='normal'}" @click="changerPage('normal')">Positions normales</button></nav>
</header>
<main :class="{ 'main--overview': page === 'overview', 'main--faults': page === 'faults' }"><ZoneOverview v-if="page==='overview'" @select="ouvrirEquipement" @faults="changerPage('faults')" /><DefautsView v-else-if="page==='faults'" /><PositionsNormalesView v-else /></main>
<CommandeModal v-if="selection" :equipement="selection" @close="selection=null"/>
<footer class="app-footer">
  <img class="sncf-reseau-logo" src="data:image/webp;base64,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" alt="SNCF Réseau">
  <span class="footer-copy">© {{ new Date().getFullYear() }} · Développé par Kévin DELOT · Prototype pédagogique Zone 101 · Tous droits réservés</span>
  <span class="footer-note">Simulation locale · Aucune connexion PIRATE / CODESYS</span>
</footer>
</div>
</template>
