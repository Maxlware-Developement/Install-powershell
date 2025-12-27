<p align="center">
<img width="600" height="140" alt="Maxlware Developement" src="https://github.com/user-attachments/assets/5e3773fe-b95c-4c1a-b64a-6f7376933da1" />
</p>

<h1 align="center">
Installation en mode développement
</h1>

Ce script permet à tout utilisateur Windows de préparer rapidement son environnement de développement.
Il installe Node.js si nécessaire, télécharge et installe les applications sans avoir besoin de Git.
Les applications de Maxlware Developement sont directement prêtes à l’usage dans votre dossier utilisateur.
Les logs colorés permettent de suivre chaque étape du processus facilement.

```powershell
$dest="$env:TEMP\install.ps1"; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Maxlware-Developement/Install-powershell/main/install.ps1" -OutFile $dest; powershell -NoProfile -ExecutionPolicy Bypass -File $dest
```
