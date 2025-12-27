# install.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$LOG_PREFIX = "[INSTALL]"

$COLOR_INFO = "Yellow"
$COLOR_SUCCESS = "Green"
$COLOR_ERROR = "Red"

Write-Host "$LOG_PREFIX Démarrage du processus d'installation..." -ForegroundColor $COLOR_INFO

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
    Write-Host "$LOG_PREFIX Node.js non trouvé." -ForegroundColor $COLOR_ERROR
    $nodeInstaller = "$env:TEMP\node-v24.12.0-x64.msi"
    Write-Host "$LOG_PREFIX Téléchargement Node.js MSI..." -ForegroundColor $COLOR_INFO
    Invoke-WebRequest "https://nodejs.org/dist/v24.12.0/node-v24.12.0-x64.msi" -OutFile $nodeInstaller
    Read-Host "$LOG_PREFIX Appuyez sur Entrée pour lancer l'installation de Node.js"
    Start-Process msiexec.exe -ArgumentList "/i `"$nodeInstaller`" /quiet /norestart" -Wait
    Write-Host "$LOG_PREFIX Node.js installé." -ForegroundColor $COLOR_SUCCESS
} else {
    Write-Host "$LOG_PREFIX Node.js trouvé : $($node.Version)" -ForegroundColor $COLOR_SUCCESS
}

Write-Host "`n$LOG_PREFIX Sélectionnez le logiciel à installer :" -ForegroundColor $COLOR_INFO
Write-Host "1) Mxlw-browser" -ForegroundColor $COLOR_INFO
Write-Host "2) CordLaunch" -ForegroundColor $COLOR_INFO
Write-Host "3) BetterShorts" -ForegroundColor $COLOR_INFO
Write-Host "0) Quitter" -ForegroundColor $COLOR_INFO

$choice = Read-Host "Votre choix"

function Install-App($name, $zipUrl) {
    $targetDir = "$env:USERPROFILE\$name"
    Write-Host "$LOG_PREFIX Installation de $name dans $targetDir" -ForegroundColor $COLOR_INFO
    Read-Host "Appuyez sur Entrée pour confirmer"
    
    if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir | Out-Null }

    $tmpZip = "$env:TEMP\$name.zip"
    Write-Host "$LOG_PREFIX Téléchargement du ZIP..." -ForegroundColor $COLOR_INFO
    Invoke-WebRequest $zipUrl -OutFile $tmpZip

    Write-Host "$LOG_PREFIX Extraction..." -ForegroundColor $COLOR_INFO
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($tmpZip, $targetDir)

    Remove-Item $tmpZip
    Write-Host "$LOG_PREFIX $name installé avec succès dans $targetDir" -ForegroundColor $COLOR_SUCCESS
}

switch ($choice) {
    "1" { Install-App "Mxlw-browser" "https://github.com/Maxlware-Developement/Mxlw-browser/archive/refs/heads/main.zip" }
    "2" { Install-App "CordLaunch" "https://github.com/Maxlware-Developement/CordLaunch/archive/refs/heads/main.zip" }
    "3" { Install-App "BetterShorts" "https://github.com/Maxlware-Developement/BetterShorts/archive/refs/heads/main.zip" }
    "0" { Write-Host "$LOG_PREFIX Arrêt demandé." -ForegroundColor $COLOR_ERROR; exit }
    default { Write-Host "$LOG_PREFIX Choix invalide." -ForegroundColor $COLOR_ERROR; exit 1 }
}
