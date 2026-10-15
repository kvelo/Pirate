import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
// Vite lance le serveur de développement et prépare les fichiers de production.
// Le plugin Vue compile les fichiers .vue ; 127.0.0.1 limite le serveur à cet ordinateur.
export default defineConfig({ plugins: [vue()], server: {host:'127.0.0.1'} })
