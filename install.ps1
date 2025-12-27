#!/usr/bin/env bash

LOG_PREFIX="[INSTALL]"

echo "$LOG_PREFIX Démarrage du processus d'installation..."

# === Vérification Node.js ===
if ! command -v node >/dev/null 2>&1; then
    echo "$LOG_PREFIX Node.js non trouvé. Téléchargement et installation..."
    curl -fsSL https://raw.githubusercontent.com/Maxlware-Developement/Install-powershell/refs/heads/main/nodejs/install.sh | sh
else
    echo "$LOG_PREFIX Node.js détecté (version $(node -v))"
fi

# === Choix logiciel ===
echo
echo "$LOG_PREFIX Sélectionnez le logiciel à installer :"
echo " 1) Mxlw-browser"
echo " 2) CordLaunch"
echo " 3) BetterShorts"
echo " 0) Quitter"
echo

read -p "Choix : " CHOICE

case "$CHOICE" in
    1) curl -fsSL https://raw.githubusercontent.com/Maxlware-Developement/Mxlw-browser/main/install.sh | sh ;;
    2) curl -fsSL https://raw.githubusercontent.com/Maxlware-Developement/CordLaunch/main/install.sh | sh ;;
    3) curl -fsSL https://raw.githubusercontent.com/Maxlware-Developement/BetterShorts/main/install.sh | sh ;;
    0) echo "$LOG_PREFIX Arrêt."; exit 0 ;;
    *) echo "$LOG_PREFIX Choix invalide."; exit 1 ;;
esac
