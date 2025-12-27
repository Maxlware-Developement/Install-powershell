#!/usr/bin/env bash

LOG_PREFIX="[CORDLAUNCH]"
REPO_ZIP="https://github.com/Maxlware-Developement/CordLaunch/archive/refs/heads/main.zip"
TARGET_DIR="$HOME/Mxlw-browser"

echo "$LOG_PREFIX Installation demandée."

read -p "Confirmer l'installation de Cordlaunch ? (y/n) : " CONFIRM
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
unzip -oq /tmp/mxlw-browser.zip -d /tmp

mv /tmp/Mxlw-browser-*/* "$TARGET_DIR"/

echo "$LOG_PREFIX Nettoyage..."
rm -rf /tmp/mxlw-browser.zip /tmp/Cordlaunch-*

echo "$LOG_PREFIX Installation terminée dans : $TARGET_DIR"
echo "$LOG_PREFIX Fin du script."
exit 0
