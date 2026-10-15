#!/usr/bin/env bash
# Windows + Git Bash. Keep this terminal open while using the IHM.
set -Eeuo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/IHM"
fail() { printf '\nErreur : %s\n' "$*" >&2; exit 1; }
command -v node >/dev/null || fail "Node.js doit etre installe."
command -v npm >/dev/null || fail "npm est introuvable."
command -v cygpath >/dev/null || fail "Utilisez Git Bash pour Windows."
chrome=""
for base in "${PROGRAMFILES:-}" "$(printenv 'PROGRAMFILES(X86)' || true)" "${LOCALAPPDATA:-}"; do
  [[ -n "$base" ]] || continue
  candidate="$(cygpath -u "$base")/Google/Chrome/Application/chrome.exe"
  if [[ -f "$candidate" ]]; then chrome="$candidate"; break; fi
done
[[ -n "$chrome" ]] || fail "Google Chrome est introuvable."
[[ -f node_modules/vite/bin/vite.js ]] || npm install
server_pid=""
cleanup() {
  if [[ -n "$server_pid" ]]; then kill "$server_pid" 2>/dev/null || true; fi
}
trap cleanup EXIT
trap 'exit 130' INT TERM
printf 'Demarrage de Vue sur http://127.0.0.1:5173/\n'
node node_modules/vite/bin/vite.js --host 127.0.0.1 --port 5173 --strictPort &
server_pid=$!
ready=false
for ((i=0; i<60; i++)); do
  kill -0 "$server_pid" 2>/dev/null || fail "Vite s'est arrete. Verifiez notamment que le port 5173 est libre."
  if node --input-type=module -e 'try { const r = await fetch("http://127.0.0.1:5173/@vite/client", {signal: AbortSignal.timeout(500)}); process.exit(r.ok && (await r.text()).includes("WebSocket") ? 0 : 1); } catch { process.exit(1); }' 2>/dev/null; then
    ready=true; break
  fi
  sleep 0.5
done
[[ "$ready" == true ]] || fail "Le serveur ne repond pas."
kill -0 "$server_pid" 2>/dev/null || fail "Vite s'est arrete."
# Dedicated profile ensures fullscreen flags apply even if Chrome is already open.
profile="$(cygpath -w "${LOCALAPPDATA:-$HOME}/PIRATE_API-Chrome")"
export PIRATE_CHROME_EXE="$(cygpath -w "$chrome")"
export PIRATE_CHROME_PROFILE="$profile"
MSYS_NO_PATHCONV=1 powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(cygpath -w ../ouvrir-chrome-ecran2.ps1)"

printf '\nIHM ouverte. Alt+F4 ferme Chrome. Ctrl+C ici arrete Vue.\n'
wait "$server_pid"
