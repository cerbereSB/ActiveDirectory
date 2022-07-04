####################################################################################################################################################################
#                                                                      RAPPORT GROUPES D UN USER
#Auteur     : Marc Majoral
#Date       : 04.07.22
#Version    : 1.0
#Titre      : Script interactif de rapport
#Description: Ce script permet de lister les groupes dont est membre un utilisateur . Il est situé par defaut dans C:\RapportsAD\Users\Nom_de_l'user
#             
####################################################################################################################################################################

Import-Module ActiveDirectory

#OUVERTURE DU SCRIPT#
Write-Host " BIENVENUE, CE SCRIPT PERMETS DE LISTER LES GROUPES DONT EST MEMBRE UN USER PUIS DE CREER UN RAPPORT DANS C:\RapportsAD\Users\Nom_de_l'user" -ForegroundColor Green

#BOUCLE POUR EDITER PLUSIEURS RAPPORTS SI NECESSAIRE
Do {
        $User = Read-Host "SAISISSEZ LE SAMACCOUNTNAME DE L UTILISATEUR POUR LEQUEL VOUS SOUHAITEZ EDITER UN RAPPORT"
        
#TRY/CATCH POUR GESTION D ERREUR        
        try {
                Get-ADPrincipalGroupMembership -Identity $user | Select-Object  name | Export-Csv C:\RapportsAD\Users\$User.csv -ErrorAction Stop
            }
#CATCH AVEC ERRORTYPE
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
            {
                Write-Host "L UTILISATEUR N EXISTE PAS OU EST MAL ORTOGRAPHIE" -ForegroundColor Red
            }
#MESSAGE DE CONFIRMATION     
        Write-Host " UN RAPPORT A ETE EDITE DANS C:\RapportsAD\Nom_de_l'user" -ForegroundColor Green
#QUESTION QUI APPELLE LE DECLENCHEMENT DE LA BOUCLE....
        $Response=Read-Host "SOUHAITEZ VOUS EDITER UN RAPPORT POUR UN AUTRE UTILISATEUR O/N ?"
   }
#...TANT QUE LA REPONSE A LA QUESTION EST "O"
While ($Response -eq "O")

Read-Host -Prompt "Appuyez sur une touche pour fermer le script"

    
   