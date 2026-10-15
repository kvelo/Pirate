// Point d'entrée : charger Vue, le composant principal et les styles communs.
import { createApp } from 'vue'
import App from './App.vue'
import '../styles.css'
// Vue affiche l'application dans l'élément HTML portant id="app" (index.html).
createApp(App).mount('#app')
