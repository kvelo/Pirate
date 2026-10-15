import { reactive, ref } from 'vue'
import { initialEquipements } from '../data/equipements'

// Ce « composable » regroupe les données et actions utilisées par plusieurs composants.
// Les variables placées hors de useSimulation sont créées une seule fois au chargement
// du module : tous les écrans manipulent donc les mêmes objets en mémoire.
const STORAGE_KEY = 'pirate-zone101-positions-normales-v1'
// localStorage conserve du texte dans ce navigateur, même après un rechargement.
function chargerPositionsNormales() {
  try {
    // JSON.parse reconstruit un objet à partir du texte ; '{}' est la valeur par défaut.
    const donnees = JSON.parse(localStorage.getItem(STORAGE_KEY) || '{}')
    if (!donnees || typeof donnees !== 'object' || Array.isArray(donnees)) return {}
    return donnees
  } catch {
    return {}
  }
}
const positionsSauvegardees = chargerPositionsNormales()
// reactive permet à Vue de suivre les changements des propriétés des équipements.
// map crée un nouvel objet par équipement ; ...e recopie ses propriétés initiales.
const equipements = reactive(initialEquipements.map(e => ({
  ...e,
  // À défaut de configuration, reprendre la position fictive initiale.
  positionNormale: positionsSauvegardees[e.id] === null || typeof positionsSauvegardees[e.id] === 'boolean'
    ? positionsSauvegardees[e.id] : e.ferme
})))
// Ces deux valeurs sont partagées, mais ne sont pas sauvegardées dans le navigateur.
const defaut = ref('Défaut équipement')
const defautActif = ref(false)

export function useSimulation() {
  function commander(id, fermer) {
    // fermer est un booléen : true = fermé, false = ouvert.
    const e = equipements.find(e => e.id === id)
    if (!e) return
    // États locaux fictifs. Aucune commande extérieure n'est émise.
    e.ferme = fermer
  }
  function definirPositionNormale(id, ferme) {
    const e = equipements.find(e => e.id === id)
    if (!e) return
    // La référence est distincte de l'état actuel ; null représente l'option N/A.
    e.positionNormale = ferme === null ? null : Boolean(ferme)
    try {
      // fromEntries crée { identifiant: position, ... } ; stringify le convertit en texte.
      localStorage.setItem(STORAGE_KEY, JSON.stringify(
        Object.fromEntries(equipements.map(item => [item.id, item.positionNormale]))
      ))
    } catch {
      // L'interface reste utilisable si le navigateur refuse le stockage.
    }
  }
  // ! inverse le booléen. Cette action ne simule aucun effet électrique.
  function basculerDefaut() { defautActif.value = !defautActif.value }
  // Les composants récupèrent les données et les fonctions par cet objet de retour.
  return { equipements, commander, definirPositionNormale, defaut, defautActif, basculerDefaut }
}
