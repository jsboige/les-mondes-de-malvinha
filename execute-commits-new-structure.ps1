# Script pour ex�cuter les commits selon la nouvelle structure simplifi�e
# Ce script ex�cute les commits pour le projet Malvinaland avec la nouvelle organisation

Write-Host "Ex�cution des commits pour la nouvelle structure simplifi�e de Malvinaland" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""

# Fonction pour afficher un message color�
function Write-ColorMessage {
    param (
        [string]$Message,
        [string]$Color = "White"
    )
    
    Write-Host $Message -ForegroundColor $Color
}

# Fonction pour ex�cuter une commande Git
function Execute-GitCommand {
    param (
        [string]$Command,
        [string]$Description
    )
    
    Write-ColorMessage "Ex�cution: $Command" -Color Gray
    Write-ColorMessage "($Description)" -Color Yellow
    
    try {
        Invoke-Expression $Command
        if ($LASTEXITCODE -eq 0) {
            Write-ColorMessage "Commande ex�cut�e avec succ�s." -Color Green
            return $true
        } else {
            Write-ColorMessage "Erreur lors de l'ex�cution de la commande (code: $LASTEXITCODE)." -Color Red
            return $false
        }
    } catch {
        Write-ColorMessage "Exception lors de l'ex�cution de la commande: $_" -Color Red
        return $false
    }
}

# Fonction pour cr�er un commit
function Create-Commit {
    param (
        [string]$Name,
        [string]$Description,
        [string[]]$Files,
        [string]$Message
    )
    
    Write-ColorMessage "Cr�ation du commit: $Name" -Color Green
    Write-ColorMessage $Description -Color White
    Write-ColorMessage ""
    
    # Cr�er le fichier de message de commit
    $commitMessageFile = "commit-message-temp.txt"
    $Message | Out-File -FilePath $commitMessageFile -Encoding utf8
    
    # Ajouter les fichiers au commit
    $allFilesAdded = $true
    foreach ($file in $Files) {
        Write-ColorMessage "Ajout du fichier: $file" -Color Yellow
        $result = Execute-GitCommand -Command "git add `"$file`"" -Description "Ajout du fichier au staging"
        if (-not $result) {
            $allFilesAdded = $false
            Write-ColorMessage "Avertissement: Impossible d'ajouter le fichier $file. Il sera ignor�." -Color Yellow
        }
    }
    
    if (-not $allFilesAdded) {
        Write-ColorMessage "Certains fichiers n'ont pas pu �tre ajout�s. Voulez-vous continuer avec le commit? (O/N)" -Color Yellow
        $response = Read-Host
        if ($response -ne "O" -and $response -ne "o") {
            Write-ColorMessage "Commit annul�." -Color Red
            Remove-Item -Path $commitMessageFile -ErrorAction SilentlyContinue
            return $false
        }
    }
    
    # Cr�er le commit
    $result = Execute-GitCommand -Command "git commit -F `"$commitMessageFile`"" -Description "Cr�ation du commit"
    
    # Supprimer le fichier de message temporaire
    Remove-Item -Path $commitMessageFile -ErrorAction SilentlyContinue
    
    return $result
}

# D�finir les groupes de commits pour la nouvelle structure
$commitGroups = @(
    @{
        Name = "1. Archivage de l'ancienne structure";
        Description = "Supprime les fichiers de l'ancienne structure qui ont �t� archiv�s";
        Files = @(
            "archive/"
        );
        Message = @"
Archivage de l'ancienne structure du projet

- Suppression des fichiers de l'ancienne structure qui ont �t� archiv�s
- Pr�paration pour la nouvelle structure simplifi�e
"@
    },
    @{
        Name = "2. Mise en place de la nouvelle structure simplifi�e";
        Description = "Ajoute le README simplifi� et le tableau de bord";
        Files = @(
            "README-SIMPLIFIE.md",
            "tableau-de-bord/"
        );
        Message = @"
Mise en place de la nouvelle structure simplifi�e

- Ajout du README simplifi� expliquant la nouvelle organisation
- Ajout du tableau de bord pour faciliter la gestion du site
"@
    },
    @{
        Name = "3. Ajout du contenu";
        Description = "Ajoute les fichiers de contenu du site";
        Files = @(
            "contenu/"
        );
        Message = @"
Ajout du contenu du site

- Ajout des fichiers de contenu pour les mondes
- Ajout des fichiers de contenu pour les personnages
- Ajout des fichiers de contenu pour la carte
- Ajout des fichiers de contenu pour les organisateurs
"@
    },
    @{
        Name = "4. Ajout des guides";
        Description = "Ajoute les guides d'utilisation et de modification";
        Files = @(
            "guides/"
        );
        Message = @"
Ajout des guides d'utilisation et de modification

- Ajout des guides de consultation
- Ajout des guides de modification
- Ajout des guides de structure
"@
    },
    @{
        Name = "5. Ajout des outils techniques";
        Description = "Ajoute les scripts et outils pour la maintenance du site";
        Files = @(
            "outils-techniques/"
        );
        Message = @"
Ajout des outils techniques

- Scripts de d�ploiement simplifi�s
- Scripts de nettoyage simplifi�s
- Scripts d'organisation simplifi�s
- Scripts de v�rification simplifi�s
"@
    },
    @{
        Name = "6. Ajout du site web";
        Description = "Ajoute les fichiers g�n�r�s pour le site web";
        Files = @(
            "site-web/"
        );
        Message = @"
Ajout des fichiers du site web

- Ajout des fichiers HTML g�n�r�s
- Ajout des assets (CSS, JavaScript, images)
- Ajout des fichiers de configuration pour le d�ploiement
- Ajout des dossiers pour les mondes
"@
    },
    @{
        Name = "7. Ajout des archives techniques";
        Description = "Ajoute les archives techniques pour r�f�rence future";
        Files = @(
            "archives-techniques/"
        );
        Message = @"
Ajout des archives techniques

- Conservation des fichiers techniques importants
- Organisation des archives pour r�f�rence future
"@
    },
    @{
        Name = "8. Ajout du script de d�ploiement temporaire";
        Description = "Ajoute le script temporaire pour d�ployer le site web";
        Files = @(
            "temp-deploy-site-web.ps1"
        );
        Message = @"
Ajout du script de d�ploiement temporaire

- Script pour d�ployer le site web localement
- Bas� sur le script deploy-site-simple.ps1 mais utilisant site-web au lieu de site
"@
    }
);

# V�rifier si Git est install�
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-ColorMessage "Git n'est pas install� ou n'est pas dans le PATH. Impossible d'ex�cuter les commits." -Color Red
    exit 1
}

# V�rifier l'�tat du d�p�t Git
Write-ColorMessage "V�rification de l'�tat du d�p�t Git..." -Color Yellow
git status

Write-ColorMessage "Voulez-vous ex�cuter les commits selon le plan d�fini? (O/N)" -Color Yellow
$response = Read-Host
if ($response -ne "O" -and $response -ne "o") {
    Write-ColorMessage "Ex�cution annul�e." -Color Red
    exit 0
}

# Ex�cuter les commits
$allCommitsSuccessful = $true
foreach ($group in $commitGroups) {
    $result = Create-Commit -Name $group.Name -Description $group.Description -Files $group.Files -Message $group.Message
    if (-not $result) {
        $allCommitsSuccessful = $false
        Write-ColorMessage "Erreur lors de la cr�ation du commit $($group.Name). Voulez-vous continuer avec les commits suivants? (O/N)" -Color Yellow
        $response = Read-Host
        if ($response -ne "O" -and $response -ne "o") {
            Write-ColorMessage "Ex�cution des commits interrompue." -Color Red
            break
        }
    }
    
    Write-ColorMessage ""
}

# Pousser les commits vers le d�p�t distant
if ($allCommitsSuccessful) {
    Write-ColorMessage "Tous les commits ont �t� cr��s avec succ�s." -Color Green
    Write-ColorMessage "Voulez-vous pousser les commits vers le d�p�t distant? (O/N)" -Color Yellow
    $response = Read-Host
    if ($response -eq "O" -or $response -eq "o") {
        Execute-GitCommand -Command "git push origin main" -Description "Pousser les commits vers le d�p�t distant"
    }
} else {
    Write-ColorMessage "Certains commits n'ont pas pu �tre cr��s. Veuillez v�rifier l'�tat du d�p�t Git." -Color Yellow
}

Write-ColorMessage ""
Write-ColorMessage "Ex�cution des commits termin�e." -Color Cyan

# Mettre � jour le JOURNAL_MODIFICATIONS.md
Write-ColorMessage "Voulez-vous mettre � jour le JOURNAL_MODIFICATIONS.md avec un r�sum� des commits effectu�s? (O/N)" -Color Yellow
$response = Read-Host
if ($response -eq "O" -or $response -eq "o") {
    $date = Get-Date -Format "dd/MM/yyyy"
    $journalEntry = @"
## Date: $date - Mise en place de la nouvelle structure simplifi�e

### Modifications effectu�es

#### 1. Archivage de l'ancienne structure
- Suppression des fichiers de l'ancienne structure qui ont �t� archiv�s
- Pr�paration pour la nouvelle structure simplifi�e

#### 2. Mise en place de la nouvelle structure simplifi�e
- Ajout du README simplifi� expliquant la nouvelle organisation
- Ajout du tableau de bord pour faciliter la gestion du site

#### 3. Ajout du contenu
- Ajout des fichiers de contenu pour les mondes
- Ajout des fichiers de contenu pour les personnages
- Ajout des fichiers de contenu pour la carte
- Ajout des fichiers de contenu pour les organisateurs

#### 4. Ajout des guides
- Ajout des guides de consultation
- Ajout des guides de modification
- Ajout des guides de structure

#### 5. Ajout des outils techniques
- Scripts de d�ploiement simplifi�s
- Scripts de nettoyage simplifi�s
- Scripts d'organisation simplifi�s
- Scripts de v�rification simplifi�s

#### 6. Ajout du site web
- Ajout des fichiers HTML g�n�r�s
- Ajout des assets (CSS, JavaScript, images)
- Ajout des fichiers de configuration pour le d�ploiement
- Ajout des dossiers pour les mondes

#### 7. Ajout des archives techniques
- Conservation des fichiers techniques importants
- Organisation des archives pour r�f�rence future

#### 8. Ajout du script de d�ploiement temporaire
- Script pour d�ployer le site web localement
- Bas� sur le script deploy-site-simple.ps1 mais utilisant site-web au lieu de site

### R�sum� des changements
- Restructuration compl�te du projet pour une meilleure organisation
- Simplification de l'interface utilisateur avec le tableau de bord
- Documentation am�lior�e avec les guides
- Conservation des fichiers techniques importants dans les archives

### Prochaines �tapes
1. V�rifier le bon fonctionnement du site apr�s les commits
2. Former les utilisateurs � la nouvelle structure
3. Planifier les futures am�liorations

"@

    # Lire le contenu actuel du journal
    if (Test-Path "JOURNAL_MODIFICATIONS.md") {
        $journalContent = Get-Content -Path "JOURNAL_MODIFICATIONS.md" -Raw
        
        # Ajouter la nouvelle entr�e au d�but du journal (apr�s le titre)
        $newJournalContent = $journalContent -replace "# Journal des modifications.*?\n\n", "# Journal des modifications - Nouvelle structure simplifi�e`n`n$journalEntry`n"
        
        # �crire le nouveau contenu dans le fichier
        $newJournalContent | Out-File -FilePath "JOURNAL_MODIFICATIONS.md" -Encoding utf8
    } else {
        # Cr�er un nouveau fichier journal
        $newJournalContent = "# Journal des modifications - Nouvelle structure simplifi�e`n`n$journalEntry`n"
        $newJournalContent | Out-File -FilePath "JOURNAL_MODIFICATIONS.md" -Encoding utf8
    }
    
    Write-ColorMessage "Le journal des modifications a �t� mis � jour." -Color Green
}

# Proposer de v�rifier le site apr�s les commits
Write-ColorMessage "Voulez-vous v�rifier le site apr�s les commits? (O/N)" -Color Yellow
$response = Read-Host
if ($response -eq "O" -or $response -eq "o") {
    Write-ColorMessage "Lancement du script de d�ploiement temporaire..." -Color Yellow
    & "./temp-deploy-site-web.ps1"
}
