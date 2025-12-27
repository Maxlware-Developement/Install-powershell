# install.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$LOG_PREFIX = "[INSTALL]"

Write-Host "$LOG_PREFIX Demarrage du processus dinstallation..."

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
    Write-Host "$LOG_PREFIX Node.js non trouvé."
    $nodeInstaller = "$env:TEMP\node-v24.12.0-x64.msi"
    Write-Host "$LOG_PREFIX Telechargement Node.js MSI..."
    Invoke-WebRequest "https://nodejs.org/dist/v24.12.0/node-v24.12.0-x64.msi" -OutFile $nodeInstaller
    Read-Host "$LOG_PREFIX Appuyez sur Entree pour lancer linstallation de Node.js"
    Start-Process msiexec.exe -ArgumentList "/i `"$nodeInstaller`" /quiet /norestart" -Wait
    Write-Host "$LOG_PREFIX Node.js installe."
} else {
    Write-Host "$LOG_PREFIX Node.js trouve : $($node.Version)"
}

Write-Host "`n$LOG_PREFIX Selectionnez le logiciel à installer :"
Write-Host "1) Mxlw-browser"
Write-Host "2) CordLaunch"
Write-Host "3) BetterShorts"
Write-Host "0) Quitter"

$choice = Read-Host "Votre choix"

function Install-App($name, $zipUrl) {
    $targetDir = "$env:USERPROFILE\$name"
    Write-Host "$LOG_PREFIX Installation de $name dans $targetDir"
    Read-Host "Appuyez sur Entree pour confirmer"
    
    # Créer le dossier cible
    if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir | Out-Null }

    # Télécharger le ZIP
    $tmpZip = "$env:TEMP\$name.zip"
    Write-Host "$LOG_PREFIX Telechargement du ZIP..."
    Invoke-WebRequest $zipUrl -OutFile $tmpZip

    # Extraire le ZIP
    Write-Host "$LOG_PREFIX Extraction..."
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($tmpZip, $targetDir)

    # Nettoyer
    Remove-Item $tmpZip
    Write-Host "$LOG_PREFIX $name installe avec succes dans $targetDir"
}

switch ($choice) {
    "1" { Install-App "Mxlw-browser" "https://github.com/Maxlware-Developement/Mxlw-browser/archive/refs/heads/main.zip" }
    "2" { Install-App "CordLaunch" "https://github.com/Maxlware-Developement/CordLaunch/archive/refs/heads/main.zip" }
    "3" { Install-App "BetterShorts" "https://github.com/Maxlware-Developement/BetterShorts/archive/refs/heads/main.zip" }
    "0" { Write-Host "$LOG_PREFIX Arrêt demandé."; exit }
    default { Write-Host "$LOG_PREFIX Choix invalide."; exit 1 }
}
