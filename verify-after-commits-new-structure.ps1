# Script de v�rification apr�s les commits pour la nouvelle structure simplifi�e
# Ce script v�rifie que le site fonctionne correctement apr�s les commits

Write-Host "V�rification du site apr�s les commits (nouvelle structure)" -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host ""

# Fonction pour afficher un message color�
function Write-ColorMessage {
    param (
        [string]$Message,
        [string]$Color = "White"
    )
    
    Write-Host $Message -ForegroundColor $Color
}

# Fonction pour v�rifier l'existence d'un fichier ou dossier
function Test-FileExists {
    param (
        [string]$FilePath,
        [string]$Description
    )
    
    if (Test-Path -Path $FilePath) {
        Write-ColorMessage "[OK] $Description existe: $FilePath" -Color Green
        return $true
    } else {
        Write-ColorMessage "[ERREUR] $Description n'existe pas: $FilePath" -Color Red
        return $false
    }
}

# Fonction pour v�rifier la structure simplifi�e
function Test-SimplifiedStructure {
    Write-ColorMessage "V�rification de la structure simplifi�e..." -Color Yellow
    
    $requiredDirectories = @(
        @{ Path = "contenu"; Description = "Dossier de contenu" },
        @{ Path = "contenu/mondes"; Description = "Dossier des mondes" },
        @{ Path = "contenu/personnages"; Description = "Dossier des personnages" },
        @{ Path = "contenu/carte"; Description = "Dossier de la carte" },
        @{ Path = "contenu/organisateurs"; Description = "Dossier des organisateurs" },
        @{ Path = "guides"; Description = "Dossier des guides" },
        @{ Path = "guides/consultation"; Description = "Dossier des guides de consultation" },
        @{ Path = "guides/modification"; Description = "Dossier des guides de modification" },
        @{ Path = "guides/structure"; Description = "Dossier des guides de structure" },
        @{ Path = "tableau-de-bord"; Description = "Dossier du tableau de bord" },
        @{ Path = "outils-techniques"; Description = "Dossier des outils techniques" },
        @{ Path = "archives-techniques"; Description = "Dossier des archives techniques" },
        @{ Path = "site-web"; Description = "Dossier du site web" },
        @{ Path = "site-web/assets"; Description = "Dossier des assets du site web" },
        @{ Path = "site-web/content"; Description = "Dossier du contenu du site web" }
    )
    
    $requiredFiles = @(
        @{ Path = "README-SIMPLIFIE.md"; Description = "README simplifi�" },
        @{ Path = "tableau-de-bord/index.html"; Description = "Tableau de bord" },
        @{ Path = "temp-deploy-site-web.ps1"; Description = "Script de d�ploiement temporaire" },
        @{ Path = "site-web/index.html"; Description = "Page d'accueil du site web" },
        @{ Path = "site-web/manifest.json"; Description = "Manifest du site web" },
        @{ Path = "site-web/service-worker.js"; Description = "Service worker du site web" }
    )
    
    $allDirectoriesExist = $true
    foreach ($dir in $requiredDirectories) {
        $exists = Test-FileExists -FilePath $dir.Path -Description $dir.Description
        if (-not $exists) {
            $allDirectoriesExist = $false
        }
    }
    
    $allFilesExist = $true
    foreach ($file in $requiredFiles) {
        $exists = Test-FileExists -FilePath $file.Path -Description $file.Description
        if (-not $exists) {
            $allFilesExist = $false
        }
    }
    
    return $allDirectoriesExist -and $allFilesExist
}

# Fonction pour v�rifier les mondes
function Test-Mondes {
    Write-ColorMessage "V�rification des mondes..." -Color Yellow
    
    $mondes = @(
        "assemblee", "grange", "jeux", "reves", "damier", 
        "linge", "verger", "zob", "elysee", "karibu", "sphinx"
    )
    
    $allMondesExist = $true
    foreach ($monde in $mondes) {
        # V�rifier le dossier du monde dans contenu
        $mondePath = "contenu/mondes/$monde"
        $mondeExists = Test-FileExists -FilePath $mondePath -Description "Dossier du monde $monde"
        
        # V�rifier le dossier du monde dans site-web
        $siteWebMondePath = "site-web/content/mondes/$monde"
        $siteWebMondeExists = Test-FileExists -FilePath $siteWebMondePath -Description "Dossier du monde $monde dans site-web"
        
        if (-not ($mondeExists -and $siteWebMondeExists)) {
            $allMondesExist = $false
        }
    }
    
    return $allMondesExist
}

# Fonction pour v�rifier le tableau de bord
function Test-TableauDeBord {
    Write-ColorMessage "V�rification du tableau de bord..." -Color Yellow
    
    $tableauDeBordPath = "tableau-de-bord/index.html"
    $tableauDeBordExists = Test-FileExists -FilePath $tableauDeBordPath -Description "Fichier index.html du tableau de bord"
    
    if ($tableauDeBordExists) {
        $tableauDeBordContent = Get-Content -Path $tableauDeBordPath -Raw
        
        # V�rifier que le tableau de bord contient des liens vers les sections importantes
        $requiredLinks = @(
            "contenu/mondes",
            "contenu/personnages",
            "contenu/carte",
            "guides/modification",
            "guides/consultation"
        )
        
        $allLinksExist = $true
        foreach ($link in $requiredLinks) {
            if ($tableauDeBordContent -notmatch [regex]::Escape($link)) {
                Write-ColorMessage "[ERREUR] Le tableau de bord ne contient pas de lien vers $link" -Color Red
                $allLinksExist = $false
            }
        }
        
        if ($allLinksExist) {
            Write-ColorMessage "[OK] Le tableau de bord contient tous les liens n�cessaires" -Color Green
        }
        
        return $allLinksExist
    }
    
    return $false
}

# Fonction pour v�rifier le script de d�ploiement temporaire
function Test-DeploymentScript {
    Write-ColorMessage "V�rification du script de d�ploiement temporaire..." -Color Yellow
    
    $scriptPath = "temp-deploy-site-web.ps1"
    $scriptExists = Test-FileExists -FilePath $scriptPath -Description "Script de d�ploiement temporaire"
    
    if ($scriptExists) {
        $scriptContent = Get-Content -Path $scriptPath -Raw
        
        # V�rifier que le script contient les �l�ments n�cessaires
        $requiredElements = @(
            "site-web",
            "http-server",
            "localhost:8080"
        )
        
        $allElementsExist = $true
        foreach ($element in $requiredElements) {
            if ($scriptContent -notmatch [regex]::Escape($element)) {
                Write-ColorMessage "[ERREUR] Le script de d�ploiement ne contient pas l'�l�ment $element" -Color Red
                $allElementsExist = $false
            }
        }
        
        if ($allElementsExist) {
            Write-ColorMessage "[OK] Le script de d�ploiement contient tous les �l�ments n�cessaires" -Color Green
        }
        
        return $allElementsExist
    }
    
    return $false
}

# Fonction pour v�rifier le site web
function Test-SiteWeb {
    Write-ColorMessage "V�rification du site web..." -Color Yellow
    
    $requiredFiles = @(
        @{ Path = "site-web/index.html"; Description = "Page d'accueil du site web" },
        @{ Path = "site-web/manifest.json"; Description = "Manifest du site web" },
        @{ Path = "site-web/service-worker.js"; Description = "Service worker du site web" },
        @{ Path = "site-web/assets/css/main.css"; Description = "CSS principal du site web" },
        @{ Path = "site-web/assets/js/navigation.js"; Description = "Script de navigation du site web" }
    )
    
    $allFilesExist = $true
    foreach ($file in $requiredFiles) {
        $exists = Test-FileExists -FilePath $file.Path -Description $file.Description
        if (-not $exists) {
            $allFilesExist = $false
        }
    }
    
    return $allFilesExist
}

# Ex�cuter les v�rifications
$structureOk = Test-SimplifiedStructure
Write-ColorMessage ""

$mondesOk = Test-Mondes
Write-ColorMessage ""

$tableauDeBordOk = Test-TableauDeBord
Write-ColorMessage ""

$deploymentScriptOk = Test-DeploymentScript
Write-ColorMessage ""

$siteWebOk = Test-SiteWeb
Write-ColorMessage ""

# Afficher le r�sum�
Write-ColorMessage "=== R�sum� des v�rifications ===" -Color Cyan
Write-ColorMessage "Structure simplifi�e: $(if ($structureOk) { "OK" } else { "Probl�mes d�tect�s" })" -Color $(if ($structureOk) { "Green" } else { "Red" })
Write-ColorMessage "Mondes: $(if ($mondesOk) { "OK" } else { "Probl�mes d�tect�s" })" -Color $(if ($mondesOk) { "Green" } else { "Red" })
Write-ColorMessage "Tableau de bord: $(if ($tableauDeBordOk) { "OK" } else { "Probl�mes d�tect�s" })" -Color $(if ($tableauDeBordOk) { "Green" } else { "Red" })
Write-ColorMessage "Script de d�ploiement: $(if ($deploymentScriptOk) { "OK" } else { "Probl�mes d�tect�s" })" -Color $(if ($deploymentScriptOk) { "Green" } else { "Red" })
Write-ColorMessage "Site web: $(if ($siteWebOk) { "OK" } else { "Probl�mes d�tect�s" })" -Color $(if ($siteWebOk) { "Green" } else { "Red" })
Write-ColorMessage ""

# Conclusion
if ($structureOk -and $mondesOk -and $tableauDeBordOk -and $deploymentScriptOk -and $siteWebOk) {
    Write-ColorMessage "Toutes les v�rifications ont r�ussi. Le site est pr�t � �tre d�ploy�." -Color Green
} else {
    Write-ColorMessage "Certaines v�rifications ont �chou�. Veuillez corriger les probl�mes identifi�s avant de d�ployer le site." -Color Yellow
}

# Proposer de lancer le script de d�ploiement temporaire si tout est OK
if ($structureOk -and $mondesOk -and $tableauDeBordOk -and $deploymentScriptOk -and $siteWebOk) {
    Write-ColorMessage "Voulez-vous lancer le script de d�ploiement temporaire? (O/N)" -Color Yellow
    $response = Read-Host
    if ($response -eq "O" -or $response -eq "o") {
        Write-ColorMessage "Lancement du script de d�ploiement temporaire..." -Color Yellow
        & "./temp-deploy-site-web.ps1"
    }
}
