# Guide d'organisation des commits pour la nouvelle structure simplifi�e

Ce document explique comment organiser les commits pour la nouvelle structure simplifi�e du projet Malvinaland.

## Vue d'ensemble

La nouvelle structure simplifi�e du projet Malvinaland comprend les dossiers suivants:

- **contenu/** - Pour modifier le contenu du site
  - **mondes/** - Les diff�rents mondes de Malvinaland
  - **personnages/** - Les personnages du jeu
  - **carte/** - La carte interactive
  - **organisateurs/** - Les informations pour les organisateurs

- **guides/** - Documentation simplifi�e
  - **consultation/** - Comment consulter le site
  - **modification/** - Comment modifier le contenu
  - **structure/** - Comment comprendre la structure du projet

- **tableau-de-bord/** - Interface simplifi�e pour g�rer le site

- **outils-techniques/** - Scripts et outils simplifi�s
  - Scripts de d�ploiement simplifi�s
  - Scripts de nettoyage simplifi�s
  - Scripts d'organisation simplifi�s

- **archives-techniques/** - Anciens fichiers techniques

- **site-web/** - Version d�ployable du site

## Scripts disponibles

Deux scripts ont �t� cr��s pour faciliter l'organisation des commits:

1. **execute-commits-new-structure.ps1** - Ex�cute les commits selon la nouvelle structure simplifi�e
2. **verify-after-commits-new-structure.ps1** - V�rifie que tout fonctionne correctement apr�s les commits

## Plan des commits

Les commits sont organis�s en 8 groupes logiques:

1. **Archivage de l'ancienne structure**
   - Suppression des fichiers de l'ancienne structure qui ont �t� archiv�s
   - Pr�paration pour la nouvelle structure simplifi�e

2. **Mise en place de la nouvelle structure simplifi�e**
   - Ajout du README simplifi� expliquant la nouvelle organisation
   - Ajout du tableau de bord pour faciliter la gestion du site

3. **Ajout du contenu**
   - Ajout des fichiers de contenu pour les mondes
   - Ajout des fichiers de contenu pour les personnages
   - Ajout des fichiers de contenu pour la carte
   - Ajout des fichiers de contenu pour les organisateurs

4. **Ajout des guides**
   - Ajout des guides de consultation
   - Ajout des guides de modification
   - Ajout des guides de structure

5. **Ajout des outils techniques**
   - Scripts de d�ploiement simplifi�s
   - Scripts de nettoyage simplifi�s
   - Scripts d'organisation simplifi�s
   - Scripts de v�rification simplifi�s

6. **Ajout du site web**
   - Ajout des fichiers HTML g�n�r�s
   - Ajout des assets (CSS, JavaScript, images)
   - Ajout des fichiers de configuration pour le d�ploiement
   - Ajout des dossiers pour les mondes

7. **Ajout des archives techniques**
   - Conservation des fichiers techniques importants
   - Organisation des archives pour r�f�rence future

8. **Ajout du script de d�ploiement temporaire**
   - Script pour d�ployer le site web localement
   - Bas� sur le script deploy-site-simple.ps1 mais utilisant site-web au lieu de site

## Utilisation des scripts

### 1. Ex�cution des commits

Pour ex�cuter les commits selon la nouvelle structure simplifi�e, ex�cutez:

```powershell
.\execute-commits-new-structure.ps1
```

Ce script:
- V�rifie l'�tat du d�p�t Git
- Demande confirmation avant d'ex�cuter les commits
- Ex�cute chaque commit en ajoutant les fichiers appropri�s
- Demande confirmation avant de pousser les commits vers le d�p�t distant
- Met � jour le JOURNAL_MODIFICATIONS.md avec un r�sum� des commits effectu�s

### 2. V�rification apr�s les commits

Pour v�rifier que tout fonctionne correctement apr�s les commits, ex�cutez:

```powershell
.\verify-after-commits-new-structure.ps1
```

Ce script v�rifie:
- La structure simplifi�e (dossiers et fichiers requis)
- Les mondes (dans contenu/ et site-web/)
- Le tableau de bord (liens vers les sections importantes)
- Le script de d�ploiement temporaire (�l�ments n�cessaires)
- Le site web (fichiers requis)

Si toutes les v�rifications r�ussissent, le script propose de lancer le script de d�ploiement temporaire.

## Recommandations

1. **Avant d'ex�cuter les commits**:
   - Assurez-vous que tous les fichiers sont correctement organis�s selon la nouvelle structure
   - V�rifiez que le tableau de bord fonctionne correctement
   - V�rifiez que les liens dans les guides sont corrects

2. **Apr�s les commits**:
   - Ex�cutez le script de v�rification pour vous assurer que tout fonctionne correctement
   - Testez le site manuellement pour v�rifier les fonctionnalit�s cl�s
   - Mettez � jour la documentation si n�cessaire

3. **En cas de probl�me**:
   - Consultez le JOURNAL_MODIFICATIONS.md pour comprendre les modifications effectu�es
   - Utilisez les scripts de v�rification pour identifier les probl�mes
   - Corrigez les probl�mes et cr�ez des commits suppl�mentaires si n�cessaire

## Notes importantes

- La nouvelle structure est con�ue pour �tre plus intuitive et plus facile � utiliser
- Le tableau de bord facilite la navigation et la gestion du site
- Les guides fournissent une documentation claire et accessible
- Les outils techniques sont simplifi�s pour �tre plus faciles � utiliser
- Les archives techniques conservent les fichiers importants pour r�f�rence future
