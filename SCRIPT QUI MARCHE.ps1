Import-Module ActiveDirectory 

#OUVERTURE DU SCRIPT
Write-Host " Bienvenue. Ce script vous permet d'ajouter un utilisateur dans l'Active Directory et de lui mapper un dossier personnel stocké sur le serveur" -ForegroundColor Green

########DEFINITION DES VARIABLES########
do {
[String]$givenname = Read-Host "Prenom de l'utilisateur a ajouter" 
[String]$surname = Read-Host "Nom de l'utilisateur a ajouter"   



If (Get-ADUser -f { Surname -eq $surname }) {     
      $sam = $givenname.Substring(0, 2) + "." + $surname.ToLower()
      $upn = $givenname.tolower().substring(0, 2) + "." + $surname.ToLower() + "@" + "axeplane.loc"
      $Mail = $givenname.tolower().substring(0, 2) + "." + $surname.ToLower() + "@" + "axeplane.loc"
      $login = $givenname.Substring(0, 2).ToLower() + "." + $surname.ToLower()
}
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

# Defini l'emplacement du dossier personnel"
[String]$fullPath = "\\SRV22PARAP\Users\$login"
# Poste de l'utilisateur 
[String]$poste = Read-Host "Renseignez le poste occupe par l'utilisateur" 
# Place l'utilisateur dans son OU
[String]$service = Read-Host "Renseignez le service de l'utilisateur,celui ci le rattachera a l'OU correspondante"  
# Defini que le service dans lequel travaille l'utilisateur = OU
[String]$OU = $service 
# Mot de passe 
$Pswd = Read-Host -AsSecureString "Veuillez renseigner le mot de passe de l'utilisateur" 
     

      # Création de l'user dans l'Active Directory                  
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

      # Ajoute l'utilisateur a un groupe de sécurité, 
      do {
            # Variables pour l'ajout de l'utilisateur aux groupe de sécurité
            [String]$Groupe = Read-Host "Renseignez le groupe de securite. Choisir parmi cette liste : Informatique / Marketing / Direction / Finance / RH / Logistique / Commercial / Stagiaires "
            [String]$responsegroup = Read-Host -Prompt "Souhaitez vous ajouter l'utilisateur a un autre groupe de sécurite ? [O/N] "
            
            # Ajout de l'utilisateur a un groupe de sécurité
            Add-ADGroupMember -Identity $Groupe -Members $login               
      }     
      # tant que la réponse est "O"
      while ($responsegroup -eq "O") 
      
      # Mise en place du partage du dossier crée avec l'utilisateur
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
      
      # Mise en place des droits NTFS pour que seul l'user puisse avoir acces a son dossier.

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