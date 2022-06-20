##############################################################################################################################################
#                                                                      NEW AD USER
#Auteur     : Marc Majoral
#Date       : 20.06.22
#Version    : 1.0
#Titre      : Script interactif de création d'un utilisateur dans l'Active Directory
#Description: Ce script permet d'ajouter un utilisateur dans l'Active Directory et de lui créer un dossier sur le serveur.
#             Les informations prises en compte sont les suivantes : PRENOM
#                                                                    NOM
#                                                                    NOM COMPLET
#                                                                    ADRESSE DE MESSAGERIE
#                                                                    DEPARTEMENT OU REGION
#                                                                    UPN
#                                                                    SAMAccountName
#                                                                    GROUPE DE SECURITE(s)
#                                                                    FONCTION
#                                                                    SERVICE
#                                                                    SOCIETE
#
##############################################################################################################################################





Import-Module ActiveDirectory 

#OUVERTURE DU SCRIPT##
Write-Host " Bienvenue. Ce script vous permet d'ajouter un utilisateur dans l'Active Directory et de lui mapper un dossier personnel stocke sur le serveur" -ForegroundColor Green

#DE 32 > 141 BOUCLE POUR LOOPER LA CREATION D USER##
do {
[String]$givenname = Read-Host "Prenom de l'utilisateur a ajouter" 
[String]$surname = Read-Host "Nom de l'utilisateur a ajouter"   


#SI LE NOM EST DEJA UTILISE , ALORS ON UTILISERA LES DEUX LETTRES DU PRENOM (EX AU.MARNIER)##
If (Get-ADUser -f { Surname -eq $surname }) {     
      $sam = $givenname.Substring(0, 2) + "." + $surname.ToLower()
      $upn = $givenname.tolower().substring(0, 2) + "." + $surname.ToLower() + "@" + "axeplane.loc"
      $Mail = $givenname.tolower().substring(0, 2) + "." + $surname.ToLower() + "@" + "axeplane.loc"
      $login = $givenname.Substring(0, 2).ToLower() + "." + $surname.ToLower()
}
#SINON ON UTILISERA UNIQUEMENT LA PREMIERE LETTRE DU PRENOM (EX A.MARNIER)##
else {
      # Premiere lettre du prénom en min + "." + "nom" (ex a.marnier)
      [String]$sam = $givenname.Substring(0, 1) + "." + $surname.ToLower()   
      # Idem + "@axeplane.loc"
      [String]$upn = $givenname.tolower().substring(0, 1) + "." + $surname.ToLower() + "@" + "axeplane.loc" 
      # Idem pour Mail
      [String]$Mail = $givenname.tolower().substring(0, 1) + "." + $surname.ToLower() + "@" + "axeplane.loc" 
      # Premiere lettre du prénom en min + "." + "nom" (ex a.marnier) 
      [String]$login = $givenname.Substring(0, 1).ToLower() + "." + $surname.ToLower() 
}

#DEFINITION DE L'EMPLACEMENT DU DOSSIER PERSONNEL##
[String]$fullPath = "\\SRV22PARAP\Users\$login"
#POSTE DE L UTILISATEUR
[String]$poste = Read-Host "Renseignez le poste occupe par l'utilisateur" 
#PLACE L UTILISATEUR DANS L OU 
[String]$service = Read-Host "Renseignez le service de l'utilisateur,celui ci le rattachera a l'OU correspondante"  
#SERVICE=OU
[String]$OU = $service 
#MOT DE PASSE
$Pswd = Read-Host -AsSecureString "Veuillez renseigner le mot de passe de l'utilisateur" 
     

      ##CREATION DE L UTILISATEUR DANS L ACTIVE DIRECTORY##                 
      try {
            New-ADUser `
                  -Name "$givenname $surname" `
                  -GivenName $givenname `
                  -Surname $surname `
                  -Path  "OU=$OU,dc=axeplane,dc=loc"`
                  -Enabled $true `
                  -SamAccountName $sam.ToLower() `
                  -UserPrincipalName $upn `
                  -AccountPassword $Pswd `
                  -Company "Axeplane" `
                  -Title $poste `
                  -State "France" `
                  -Department $service `
                  -DisplayName "$givenname $surname" `
                  -HomeDrive "Z:" `
                  -HomeDirectory "\\SRV22PARAP\Users\$login" `
                  -EmailAddress $Mail 
      }
      catch {
            # Qu'est ce qu'on fait ?
      }

      ##AJOUTE L UTILISATEUR A UN OU PLUSIEURS GROUPES DE SECURITE 
      do {
            
            [String]$Groupe = Read-Host "Renseignez le groupe de securite. Choisir parmi cette liste : Informatique / Marketing / Direction / Finance / RH / Logistique / Commercial / Stagiaires "
            [String]$responsegroup = Read-Host -Prompt "Souhaitez vous ajouter l'utilisateur a un autre groupe de securite ? [O/N] "
            
            # Ajout de l'utilisateur a un groupe de sécurité
            Add-ADGroupMember -Identity $Groupe -Members $login               
      }     
      # tant que la réponse est "O"
      while ($responsegroup -eq "O") 
      
      # MISE EN PLACE DU DOSSIER PERSONNEL
      New-Item `
            -path $fullPath `
            -ItemType Directory `
            -force 

      New-SmbShare `
            -Name $Login `
            -Path "E:\Users\$Login"
      
      Grant-SmbShareAccess `
            -Name $login `
            -AccountName $login `
            -AccessRight Full `
            -Force
      
      # MISE EN PLACE DES DROITS NTFS

      #Localisation du dossier
      [String]$folderPath = "E:\Users\$Login"  
      #Nom de l'user
      $user = $login                 
      #Droits (full,readonly etc)
      [String]$AccesType = "FullControl"      
      #Authoriser ou Refuser
      [String]$AlloworDeny = "Allow"          
      #Liste des arguments a prendre en comptes pour creer la regle ACL 
      $argList = $user , $AccesType , $AlloworDeny  
      $acl = Get-Acl $folderPath  
      
      #Création d'une Acces Rule
      $AccesRule = New-Object System.Security.AccessControl.FileSystemAccessRule -ArgumentList $argList 
      #Mise en service de l'ACL
      $acl.setAccessRule($AccesRule) 
      $acl | Set-Acl $folderPath
      
      # Prompt d'un message pour créer un autre utilisateur                
      [String]$response = Read-Host -Prompt  "L'utilisateur a ete correctement ajoute, voulez vous ajouter un autre utilisateur dans l'Active Directory? [O/N]"       
} 
while ($response -eq "O") 

Read-Host -Prompt "Appuyez sur une touche pour fermer le script"