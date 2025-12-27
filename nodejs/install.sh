#!/usr/bin/env bash

LOG_PREFIX="[NODE-MSI]"
MSI_URL="https://nodejs.org/dist/v24.12.0/node-v24.12.0-x64.msi"
MSI_PATH="/tmp/node-setup.msi"

echo "$LOG_PREFIX Téléchargement Node.js MSI..."
curl -L "$MSI_URL" -o "$MSI_PATH" || {
    echo "$LOG_PREFIX Erreur téléchargement MSI."
    exit 1
}

read -p "Lancer l'installateur MSI maintenant ? (y/n) : " CONFIRM
case "$CONFIRM" in
    y|Y)
        echo "$LOG_PREFIX Lancement installateur..."
        wine msiexec /i "$MSI_PATH" || echo "$LOG_PREFIX (ou lance-le manuellement sous Windows)"
        ;;
    *)
        echo "$LOG_PREFIX Installation annulée."
        ;;
esac
