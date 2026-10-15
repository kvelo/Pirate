// Données de démonstration : chaque ligne contient un poste et ses repères séparés par des espaces.
const rows = [
['Plounérin','IL3 IL4'],['Plouigneau','IL1 IL2 IL3 IL4 IMP S5_11 S4_12'],
['Morlaix','I13 I14 I16 I18'],['Kerivin','IL1 IL2 IL3 IL4 IMP S13_21 S18_20'],
['Saint-Thégonnec','IL1 IL2 IL3 IL4 IMP S21_31 S20_30'],
['Landivisiau','IL1 IL2 IL3 IL4 IMP S31_41 S30_40'],
['Pencran','IS1 IS2 IS3 IS4 P1 P2 SLB1'],['Landerneau','I3 I4'],
['La Forest','IMP1 IMP2'],['Saint-Marc','I5 IL1 IL2 IL3 IL4 IMP S5_11 S4_10'],
['Brest','IL1 IL2'],['Pencran','DL DB SB1'],['Plounérin','IP']
]
// split découpe les repères ; map fabrique les équipements ; flatMap réunit les listes.
// Au démarrage, tous les appareils sont fermés sauf IP. L'identifiant suit l'ordre des lignes :
// modifier cet ordre change les identifiants utilisés pour sauvegarder les positions normales.
export const initialEquipements = rows.flatMap(([poste, labels]) =>
  labels.split(' ').map(repere => ({poste, repere, ferme: repere !== 'IP'}))
).map((value, i) => ({...value, id:i+1}))
// Traduit un repère technique en libellé lisible selon les conventions de cette maquette.
// startsWith teste le début d'un texte ; les cas précis sont examinés avant les préfixes.
export function libelleFonction(e) {
 if(e.repere==='DB') return 'Disjoncteur départ Brest'
 if(e.repere==='DL') return 'Disjoncteur départ Le Mans'
 if(e.repere==='IP') return 'Inter. de pontage · limite 101/102'
 if(e.repere.startsWith('IMP')) return 'Mise en parallèle'
 if(e.repere.startsWith('S')) return 'Sectionneur / appareil de coupure'
 return 'Interrupteur / contact'
}
