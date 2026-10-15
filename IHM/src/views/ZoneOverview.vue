<script setup>
import { computed } from 'vue'
import { useSimulation } from '../composables/useSimulation'
const { equipements } = useSimulation()
// Cette vue signale au parent les demandes de sélection ou de changement d'écran.
defineEmits(['select','faults'])
// computed recalcule automatiquement le résultat si ses données réactives changent.
// Set élimine les doublons ; [...] transforme l'ensemble en tableau de postes.
const postes = computed(() => [...new Set(equipements.map(e => e.poste))])
</script>
<template>
<!-- v-for répète un élément pour chaque poste ou équipement ; :key permet à Vue
     de retrouver chaque élément. filter ne conserve que les appareils du poste courant.
     Les voyants montrent l'état actuel ; le fond jaune indique une différence de référence.
     Attention : la comparaison actuelle considère aussi une référence N/A comme différente. -->
<div class="heading"><div><h1>Le réseau à portée de main</h1><p class="muted">Zone 101 · sélectionnez un équipement pour ouvrir sa fenêtre de commande.</p></div><span class="tag">États fictifs · simulation locale</span></div>
<section class="grid-postes"><article v-for="poste in postes" :key="poste" class="card"><div class="card-header"><strong>{{poste}}</strong><span>{{equipements.filter(e=>e.poste===poste).length}} contacts</span></div>
<div class="tokens"><button v-for="e in equipements.filter(e=>e.poste===poste)" :key="e.id" class="token" :class="{ 'token-abnormal': e.ferme !== e.positionNormale }" :title="`Position simulée : ${e.ferme ? 'fermée' : 'ouverte'} · Position normale : ${e.positionNormale ? 'fermée' : 'ouverte'}`" @click="$emit('select',e.id)">{{e.repere}} <span :class="e.ferme?'state-closed':'state-open'">●</span></button></div>
<p class="muted small">Cliquer sur un repère pour commander</p></article></section>
<div class="banner"><button class="link" @click="$emit('faults')">Accéder à l’injection de défauts →</button><span class="muted small">La limite 101/102 à Plounérin reste isolée. Aucun calcul de tension effectué.</span></div>
</template>
