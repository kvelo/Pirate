import { reactive, ref } from 'vue'
import { initialEquipements } from '../data/equipements'

const STORAGE_KEY = 'pirate-zone101-positions-normales-v1'
function chargerPositionsNormales() {
  try {
    const donnees = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}')
    if (!donnees || typeof donnees !== 'object' || Array.isArray(donnees)) return {}
    return donnees
  } catch {
    return {}
  }
}
const positionsSauvegardees = chargerPositionsNormales()
const equipements = reactive(initialEquipements.map(e => ({
  ...e,
  // À défaut de configuration, reprendre la position fictive initiale.
  positionNormale: positionsSauvegardees[e.id] === null || typeof positionsSauvegardees[e.id] === 'boolean'
    ? positionsSauvegardees[e.id] : e.ferme
})))
const defaut = ref('Défaut équipement')
const defautActif = ref(false)

export function useSimulation() {
  function commander(id, fermer) {
    const e = equipements.find(e => e.id === id)
    if (!e) return
    // États locaux fictifs. Aucune commande extérieure n'est émise.
    e.ferme = fermer
  }
  function definirPositionNormale(id, ferme) {
    const e = equipements.find(e => e.id === id)
    if (!e) return
    e.positionNormale = ferme === null ? null : Boolean(ferme)
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(
        Object.fromEntries(equipements.map(item => [item.id, item.positionNormale]))
      ))
    } catch {
      // L'interface reste utilisable si le navigateur refuse le stockage.
    }
  }
  function basculerDefaut() { defautActif.value = !defautActif.value }
  return { equipements, commander, definirPositionNormale, defaut, defautActif, basculerDefaut }
}
