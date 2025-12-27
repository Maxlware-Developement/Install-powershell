#!/usr/bin/env bash

LOG_PREFIX="[INSTALL]"
NODE_INSTALLER_URL="https://raw.githubusercontent.com/Maxlware-Developement/Install-powershell/refs/heads/main/nodejs/install.sh"

echo "$LOG_PREFIX Démarrage du processus d'installation..."

check_node() {
    echo "$LOG_PREFIX Vérification de Node.js..."
    if command -v node >/dev/null 2>&1; then
        echo "$LOG_PREFIX Node.js est déjà installé (version $(node -v))"
        return 0
    else
        echo "$LOG_PREFIX Node.js n'est pas installé."
        return 1
    fi
}

install_node_via_remote() {
    echo "$LOG_PREFIX Téléchargement du script d'installation Node.js distant..."
    curl -fsSL "$NODE_INSTALLER_URL" -o /tmp/node_install.sh || {
        echo "$LOG_PREFIX Erreur téléchargement install.sh Node."
        exit 1
    }

    echo "$LOG_PREFIX Script Node.js téléchargé → /tmp/node_install.sh"
    chmod +x /tmp/node_install.sh

    read -p "Voulez-vous lancer l'installation de Node.js ? (y/n) : " CONFIRM
    case "$CONFIRM" in
        y|Y)
            echo "$LOG_PREFIX Lancement installation Node.js..."
            /bin/bash /tmp/node_install.sh
            ;;
        *)
            echo "$LOG_PREFIX Installation Node.js annulée. Arrêt du script."
            exit 0
            ;;
    esac
}

choose_app() {
    echo
    echo "$LOG_PREFIX Sélectionne le logiciel à installer :"
    echo " 1) Mxlw-browser"
    echo " 2) CordLaunch"
    echo " 3) BetterShorts"
    echo " 0) Quitter"
    echo

    read -p "Choix : " CHOICE

    case "$CHOICE" in
        1) bash ./apps/mxlw-browser.sh ;;
        2) bash ./apps/cordlaunch.sh ;;
        3) bash ./apps/bettershorts.sh ;;
        0) echo "$LOG_PREFIX Arrêt demandé. Fin."; exit 0 ;;
        *) echo "$LOG_PREFIX Choix invalide. Fin."; exit 1 ;;
    esac
}

# === Pipeline ===

check_node || install_node_via_remote
choose_app
