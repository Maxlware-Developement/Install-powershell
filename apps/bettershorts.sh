#!/usr/bin/env bash

LOG_PREFIX="[BETTERSHORTS]"
REPO_ZIP="https://github.com/Maxlware-Developement/BetterShorts/archive/refs/heads/main.zip"
TARGET_DIR="$HOME/bettershorts"

echo "$LOG_PREFIX Installation demandée."

read -p "Confirmer l'installation de BetterShorts ? (y/n) : " CONFIRM
case "$CONFIRM" in
    y|Y) echo "$LOG_PREFIX Confirmation reçue."; ;;
    *) echo "$LOG_PREFIX Installation annulée."; exit 0 ;;
esac

echo "$LOG_PREFIX Téléchargement du dépôt (ZIP)..."
mkdir -p "$TARGET_DIR"
curl -L "$REPO_ZIP" -o /tmp/cordlaunch.zip || {
    echo "$LOG_PREFIX Erreur téléchargement ZIP."
    exit 1
}

echo "$LOG_PREFIX Extraction..."
unzip -oq /tmp/bettershorts.zip -d /tmp

mv /tmp/Mxlw-browser-*/* "$TARGET_DIR"/

echo "$LOG_PREFIX Nettoyage..."
rm -rf /tmp/mxlw-browser.zip /tmp/bettershorts-*

echo "$LOG_PREFIX Installation terminée dans : $TARGET_DIR"
echo "$LOG_PREFIX Fin du script."
exit 0
