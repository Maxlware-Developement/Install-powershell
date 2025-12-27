# install.ps1
$LOG_PREFIX = "[INSTALL]"

Write-Host "$LOG_PREFIX Démarrage de l'installation..."

# Vérification Node.js
$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
    Write-Host "$LOG_PREFIX Node.js non trouvé. Téléchargement et installation..."
    $nodeInstaller = "$env:TEMP\node-v24.12.0-x64.msi"
    Invoke-WebRequest "https://nodejs.org/dist/v24.12.0/node-v24.12.0-x64.msi" -OutFile $nodeInstaller
    Read-Host "Appuyez sur Entrée pour lancer l'installation de Node.js"
    Start-Process msiexec.exe -ArgumentList "/i `"$nodeInstaller`" /quiet /norestart" -Wait
} else {
    Write-Host "$LOG_PREFIX Node.js trouvé : $($node.Version)"
}

# Choix logiciel
Write-Host "`n$LOG_PREFIX Sélectionnez le logiciel à installer :"
Write-Host "1) Mxlw-browser"
Write-Host "2) CordLaunch"
Write-Host "3) BetterShorts"
Write-Host "0) Quitter"

$choice = Read-Host "Votre choix"
switch ($choice) {
    "1" { Write-Host "$LOG_PREFIX Installation de Mxlw-browser..." }
    "2" { Write-Host "$LOG_PREFIX Installation de CordLaunch..." }
    "3" { Write-Host "$LOG_PREFIX Installation de BetterShorts..." }
    "0" { Write-Host "$LOG_PREFIX Arrêt."; exit }
    default { Write-Host "$LOG_PREFIX Choix invalide."; exit 1 }
}
