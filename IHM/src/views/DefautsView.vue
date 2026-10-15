<script setup>
import { computed, ref, watch } from 'vue'
import { useSimulation } from '../composables/useSimulation'
const { equipements, defaut, defautActif, basculerDefaut } = useSimulation()

const types = [
 { id:'Défaut équipement', detail:'Défaut simulé sur un équipement sélectionné', cible:'equipement' },
 { id:'Perte de communication', detail:'Perte de liaison simulée avec un poste', cible:'poste' },
 { id:'Défaut ITE', detail:'Secteur amont/aval puis SEL', cible:'ite' },
 { id:'Défaut EALE', detail:'Défauts configurés par zone et sous-station', cible:'eale' }
]

// À renseigner uniquement avec les identifiants SEL validés. Maximum deux SEL par zone.
const defautsEALEParZone = { '101': { Pencran: [ {id:'DL',nom:'Défaut DL'}, {id:'DB',nom:'Défaut DB'}, {id:'PC-PA',nom:'Défaut liaison PC-PA'} ] } }
const sousStationEALE = ref('')
const sousStationsEALE = Object.keys(defautsEALEParZone['101'])
const cible = ref('')
const secteurITE = ref('')
// Identifiants SEL fictifs au format SEL suivi de 1 à 4 chiffres ; à remplacer après validation des schémas.
// Trois SEL fictives par secteur pour la démonstration, sans valeur métier réelle.
const selITEParSecteur = {
 amont: [
  {id:'SEL35', nom:'SEL35 (démo)'},
  {id:'SEL105', nom:'SEL105 (démo)'},
  {id:'SEL210', nom:'SEL210 (démo)'}
 ],
 aval: [
  {id:'SEL310', nom:'SEL310 (démo)'},
  {id:'SEL420', nom:'SEL420 (démo)'},
  {id:'SEL1050', nom:'SEL1050 (démo)'}
 ]
}
const posteSelectionne = ref('')
const equipementsDuPoste = computed(() => equipements.filter(e => e.poste === posteSelectionne.value))
const typeCourant = computed(() => types.find(t => t.id === defaut.value) || types[0])
const postes = computed(() => [...new Set(equipements.map(e => e.poste))])
const ciblesDisponibles = computed(() => {
 if (typeCourant.value.cible === 'equipement')
   return equipementsDuPoste.value.map(e => ({ valeur: String(e.id), libelle: `${e.repere} (ID ${e.id})` }))
 if (typeCourant.value.cible === 'ite')
   return (selITEParSecteur[secteurITE.value] || []).map(s => ({valeur:String(s.id),libelle:String(s.nom)}))
 if (typeCourant.value.cible === 'eale')
   return (defautsEALEParZone['101'][sousStationEALE.value] || []).map(d => ({valeur:d.id,libelle:d.nom}))
 if (typeCourant.value.cible === 'poste')
   return postes.value.map(p => ({ valeur: p, libelle: p }))
 return []
})
const libelleCible = computed(() => {
 const libelle = ciblesDisponibles.value.find(c => c.valeur === cible.value)?.libelle || ''
 if (typeCourant.value.cible === 'equipement' && libelle) return `${posteSelectionne.value} · ${libelle}`
 if (typeCourant.value.cible === 'ite' && libelle)
   return `Secteur ${secteurITE.value} · ${libelle}`
 if (typeCourant.value.cible === 'eale' && libelle) return `${sousStationEALE.value} · ${libelle}`
 return libelle
})
watch(defaut, () => { posteSelectionne.value = ''; secteurITE.value = ''; sousStationEALE.value = ''; cible.value = '' })
watch(sousStationEALE, () => { if (!defautActif.value) cible.value = '' })
watch(secteurITE, () => { if (!defautActif.value) cible.value = '' })
watch(posteSelectionne, () => { if (!defautActif.value) cible.value = '' })
const scenario = ref(null)
function basculer() {
 if (!defautActif.value) {
   if (!cible.value) return
   scenario.value = { defaut:defaut.value, cible:libelleCible.value }
 }
 basculerDefaut()
 if (!defautActif.value) scenario.value = null
}
</script>
<template>
<div class="heading">
 <div><h1>Simulation des défauts</h1><p class="muted">Configuration de scénarios pédagogiques · aucune action sur PIRATE ou CODESYS.</p></div>
 <span class="tag">États fictifs</span>
</div>
<section class="split">
 <article class="card">
  <h2>1. Choisir le défaut</h2>
  <label v-for="t in types" :key="t.id" class="fault-option">
   <input v-model="defaut" type="radio" :value="t.id" :disabled="defautActif">
   <b>{{t.id}}</b>
   <small>{{t.detail}}</small>
  </label>
 </article>
 <article class="card">
  <h2>2. Définir la cible</h2>
  <template v-if="typeCourant.cible==='equipement'">
   <label class="muted small" for="fault-poste">Poste ou sous-station</label>
   <select id="fault-poste" v-model="posteSelectionne" class="fault-target-select" :disabled="defautActif">
    <option value="">— Choisir un poste ou une sous-station —</option>
    <option v-for="p in postes" :key="p" :value="p">{{p}}</option>
   </select>
  </template>
  <template v-if="typeCourant.cible==='ite'">
   <label class="muted small" for="fault-secteur">Secteur de la zone 101</label>
   <select id="fault-secteur" v-model="secteurITE" class="fault-target-select" :disabled="defautActif">
    <option value="">— Choisir un secteur —</option>
    <option value="amont">Amont de la sous-station Pencran</option>
    <option value="aval">Aval de la sous-station Pencran</option>
   </select>
  </template>
  <template v-if="typeCourant.cible==='eale'">
   <label class="muted small" for="fault-eale-station">Sous-station</label>
   <select id="fault-eale-station" v-model="sousStationEALE" class="fault-target-select" :disabled="defautActif">
    <option value="">— Choisir une sous-station —</option>
    <option v-for="p in sousStationsEALE" :key="p" :value="p">{{p}}</option>
   </select>
  </template>
  <label class="muted small" for="fault-target" :style="['equipement','ite','eale'].includes(typeCourant.cible) ? {display:'block',marginTop:'18px'} : {}">
   {{typeCourant.cible==='equipement'?'Équipement':typeCourant.cible==='ite'?'SEL concernée':typeCourant.cible==='eale'?'Défaut EALE':'Poste concerné'}}
  </label>
  <select id="fault-target" v-model="cible" class="fault-target-select" :disabled="defautActif || !ciblesDisponibles.length">
   <option value="">{{typeCourant.cible==='equipement' ? '— Choisir un équipement —' : typeCourant.cible==='ite' ? '— Choisir une SEL —' : typeCourant.cible==='eale' ? '— Choisir un défaut EALE —' : '— Choisir une cible —'}}</option>
   <option v-for="c in ciblesDisponibles" :key="c.valeur" :value="c.valeur">{{c.libelle}}</option>
  </select>
  <p v-if="typeCourant.cible==='ite'" class="muted small" style="margin-top:12px">
   SEL repérées par numéro noir sur fond mauve dans les synoptiques. Numéros fictifs pour la démonstration.
  </p>
  <p v-if="typeCourant.cible==='eale'" class="muted small" style="margin-top:12px">Défauts EALE propres à la sous-station sélectionnée, configurables pour chaque zone.</p>
  <h2 style="margin-top:28px">3. {{defautActif?'Suivre le scénario':'Vérifier le scénario'}}</h2>
  <p><strong>{{scenario?.defaut || defaut}}</strong></p>
  <p class="muted">{{scenario?.cible || libelleCible || 'Aucune cible sélectionnée'}}</p>
  <div v-if="defautActif" class="notice" style="margin:15px 0">Défaut activé dans l’interface de démonstration</div>
  <button class="btn" :class="defautActif?'warn':'primary'" :disabled="!defautActif && !cible" @click="basculer">
   {{defautActif?'Retirer le défaut':'Injecter le défaut'}}
  </button>
  <p class="muted small" style="margin-top:16px">La sélection et l'injection sont fictives. Aucun effet électrique ou réseau n'est actuellement simulé.</p>
 </article>
</section>
<article class="card log">
 <h2>Journal du scénario</h2>
 <p class="muted">{{defautActif ? `${scenario?.defaut} · ${scenario?.cible} · défaut actif localement` : 'Aucun défaut actif'}}</p>
</article>
</template>
