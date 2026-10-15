<script setup>
import { computed } from 'vue'
import { useSimulation } from '../composables/useSimulation'
import { libelleFonction } from '../data/equipements'

const { equipements, definirPositionNormale } = useSimulation()
const postes = computed(() => [...new Set(equipements.map(e => e.poste))])
const nbOuverts = computed(() => equipements.filter(e => e.positionNormale === false).length)
const nbFermes = computed(() => equipements.filter(e => e.positionNormale === true).length)
</script>

<template>
  <div class="heading">
    <div>
      <h1>Positions normales des équipements</h1>
      <p class="muted">Zone 101 · Définir la position de référence de chaque équipement, indépendamment de son état simulé.</p>
    </div>
    <span class="tag">Configuration locale</span>
  </div>

  <section class="metrics normal-metrics">
    <div class="metric"><b>{{ equipements.length }}</b><span class="muted">équipements</span></div>
    <div class="metric"><b>{{ nbFermes }}</b><span class="muted">normalement fermés</span></div>
    <div class="metric"><b>{{ nbOuverts }}</b><span class="muted">normalement ouverts</span></div>
  </section>

  <section v-for="poste in postes" :key="poste" class="card normal-station">
    <div class="card-header"><h2>{{ poste }}</h2><span>{{ equipements.filter(e => e.poste === poste).length }} équipements</span></div>
    <div class="tablewrap">
      <table class="normal-table">
        <thead><tr><th>ID</th><th>Repère</th><th>Fonction</th><th>Position actuelle (simulation)</th><th>Position normale</th></tr></thead>
        <tbody>
          <tr v-for="e in equipements.filter(e => e.poste === poste)" :key="e.id">
            <td>{{ String(e.id).padStart(2, '0') }}</td>
            <td><strong>{{ e.repere }}</strong></td>
            <td>{{ libelleFonction(e) }}</td>
            <td><span :class="e.ferme ? 'state-closed' : 'state-open'">{{ e.ferme ? 'Fermé' : 'Ouvert' }}</span></td>
            <td>
              <select class="normal-select" :aria-label="'Position normale ' + poste + ' ' + e.repere"
                :value="e.positionNormale === null ? 'na' : e.positionNormale ? 'ferme' : 'ouvert'"
                @change="definirPositionNormale(e.id, $event.target.value === 'na' ? null : $event.target.value === 'ferme')">
                <option value="na">N/A — Aucune position normale</option>
                <option value="ferme">Normalement fermé</option>
                <option value="ouvert">Normalement ouvert</option>
              </select>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </section>
  <p class="muted small normal-footnote">Les positions normales sont enregistrées localement dans ce navigateur. Elles ne commandent pas les équipements et ne sont pas synchronisées avec PIRATE ni CODESYS.</p>
</template>
