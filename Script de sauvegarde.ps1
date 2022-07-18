####################################################################################################################################################################
#                                                                      SCRIPT DE SAUVEGARDE
#Auteur     : Marc Majoral
#Date       : 18.07.22
#Version    : 1.0
#Titre      : Script de sauvegarde
#Description: Ce script permet de sauvegarder le dossier C:\Utilisateurs de chacuns des postes (connectés) présents dans l'Active Directory
#             Il s'execute via la plannificateur de tache du serveur
#             La sauvegarde est réalisée sur SRV22PARAP dans E:\Sauvegardes\NomDuPoste
#             Un log est crée a la date du jour et s'incrémente des nouvelles entrées. Il est situé dans E:\Logs
#             
####################################################################################################################################################################

Import-Module ActiveDirectory

#DEFINITION DES VARIABLES


#Ici je liste les machines présentes dans l'AD qui commencent par "PARAP" en rapport avec ma convention de nommage
$Computers = Get-ADComputer -Filter 'Name -like "PARAP*"' | Select-Object -ExpandProperty Name
#Ici je crée une variable date qui servira pour mes logs
$Date = Get-Date -Format "dd-MM-yyyy"
#Ici la variable du chemin de sauvegarde. Pour pouvoir modifier le chemin sans avoir a modifier tout le script.
$Path = "E:\Logs\Sauvegarde du $Date.txt"


#BOUCLE FOREACH POUR TRAITER TOUS LES PC DANS L AD
ForEach ($Computer in $Computers)
{
 
    #SI le pc est connecté ...
    if (Test-Connection $Computer -Count 2 -ErrorAction SilentlyContinue)
    {   #Création dans le log du texte ...
        Add-Content $Path "$Computer EST EN LIGNE" 
        Add-Content $Path "DEBUT DE LA COPIE ..." 
        #...puis lancement de Robocopy depuis le serveur via partage administrat
        Robocopy.exe "\\$Computer\c$\Users\" "E:\Sauvegardes\$Computer\$computer"  `
        <#exclusion de fichiers et dossiers puis definition des parametres de Robocopy :
           /e    = copie les sous répertoires meme vide
           /b    = copie en mode sauvegarde, conserve les ACL NTFS
           /mir  = copie en mode mirroir
           /r:0  = nombre de tentatives en cas d echec
           /w:0  = delai entre les tentatives
           /njs  = supprimer l'entete de fin dans le log
           /log+ = ajoute les entrées au log #> `
        /xf "NTUSER.DAT*" `
        /xd 'AppData' `
            'Documents' `
            'Application Data' `
            'Default' `
            'Default User' `
            'All Users' `
            'Public' `
            'Administrateur' `
            'SendTo' `
            'Local Settings' /e /b /mir /mt /r:0 /w:0 /njs /log+:$Path
            Add-Content $Path "FIN DE LA COPIE DE $computer
            
            "

            Write-Host "COPIE EFFECTUEE" -ForegroundColor Green
    }
    #SI L ORDINATEUR N EST PAS CONNECTE...
    else
    {
        #Retourne que la machine est hors ligne et que la copie n'est pas possible
        Write-Host "MACHINE "$Computer" HORS LIGNE" -ForegroundColor Red
        Add-Content $Path "$Computer EST HORS LIGNE" 
        Add-Content $Path "LA SAUVEGARDE EST IMPOSSIBLE SUR CE POSTE
        
        
        " 
        
        
    }
        
}