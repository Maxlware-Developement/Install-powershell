#!/usr/bin/env bash

LOG_PREFIX="[MXLW-BROWSER]"
REPO_ZIP="https://github.com/Maxlware-Developement/Mxlw-browser/archive/refs/heads/main.zip"
TARGET_DIR="$HOME/Mxlw-browser"

echo "$LOG_PREFIX Installation demandée."

read -p "Confirmer l'installation de Mxlw-browser ? (y/n) : " CONFIRM
case "$CONFIRM" in
    y|Y) echo "$LOG_PREFIX Confirmation reçue."; ;;
    *) echo "$LOG_PREFIX Installation annulée."; exit 0 ;;
esac

echo "$LOG_PREFIX Téléchargement du dépôt (ZIP)..."
mkdir -p "$TARGET_DIR"
curl -L "$REPO_ZIP" -o /tmp/mxlw-browser.zip || {
    echo "$LOG_PREFIX Erreur téléchargement ZIP."
    exit 1
}

echo "$LOG_PREFIX Extraction..."
unzip -oq /tmp/mxlw-browser.zip -d /tmp

mv /tmp/Mxlw-browser-*/* "$TARGET_DIR"/

echo "$LOG_PREFIX Nettoyage..."
rm -rf /tmp/mxlw-browser.zip /tmp/Mxlw-browser-*

echo "$LOG_PREFIX Installation terminée dans : $TARGET_DIR"
echo "$LOG_PREFIX Fin du script."
exit 0
