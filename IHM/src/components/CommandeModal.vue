<script setup>
import { onMounted, onUnmounted } from 'vue'
import { useSimulation } from '../composables/useSimulation'
import { libelleFonction } from '../data/equipements'
defineProps({ equipement: { type: Object, required: true } })
const emit = defineEmits(['close'])
const { commander } = useSimulation()
function onKeydown(event) { if (event.key === 'Escape') emit('close') }
onMounted(() => window.addEventListener('keydown', onKeydown))
onUnmounted(() => window.removeEventListener('keydown', onKeydown))
</script>

<template>
  <div class="modal-backdrop" @click.self="$emit('close')">
    <section class="modal-panel modal-simple" role="dialog" aria-modal="true"
      :aria-label="'Commande de ' + equipement.poste + ' ' + equipement.repere">
      <header class="modal-header">
        <h2>Commande d'équipement</h2>
        <button class="modal-close" type="button" aria-label="Fermer" @click="$emit('close')">×</button>
      </header>
      <div class="modal-body">
        <h3>{{ equipement.poste }} · {{ equipement.repere }}</h3>
        <p class="muted small">{{ libelleFonction(equipement) }}</p>
        <p class="modal-position">Position actuelle :
          <strong :class="equipement.ferme ? 'state-closed' : 'state-open'">
            {{ equipement.ferme ? 'Fermé' : 'Ouvert' }}
          </strong>
        </p>
        <div class="modal-actions">
          <button type="button" class="btn action-open" :disabled="!equipement.ferme"
            @click="commander(equipement.id, false)">Ouvrir</button>
          <button type="button" class="btn action-close" :disabled="equipement.ferme"
            @click="commander(equipement.id, true)">Fermer</button>
        </div>
        <p class="muted small modal-disclaimer">Simulation locale uniquement · Aucune commande envoyée à PIRATE.</p>
      </div>
    </section>
  </div>
</template>
