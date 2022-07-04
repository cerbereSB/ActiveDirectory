####################################################################################################################################################################
#                                                                      RAPPORT USERS MEMBRES D UN GROUPE
#Auteur     : Marc Majoral
#Date       : 28.06.22
#Version    : 1.0
#Titre      : Script interactif de rapport
#Description: Ce script permet de lister les membres d'un groupe de securite puis d'editer un rapport au format csv . Il est situé par defaut dans C:\RapportsAD
#
####################################################################################################################################################################

Write-Host " BIENVENUE, CE SCRIPT PERMETS DE LISTER LES UTILISATEURS D UN GROUPE DE SECURITE PUIS DE CREER UN RAPPORT DANS C:\RapportsAD\Groupes" -ForegroundColor Green

#DEFINITIONS DES VARIABLES

$1="Stagiaires"
$2="Informatique"
$3="Finance"
$4="Commercial"
$5="Direction"
$6="Logistique"
$7="RH"
$8="Marketing"

#MISE EN PLACE D UN MENU DE SELECTION

$Continue = $true
while ($Continue){
  write-host ----------------------LISTE DES GROUPE DE SECURITE PRESENTS DANS L ACTIVE DIRECTORY -----------------------
  write-host "1. STAGIAIRES"
  write-host "2. INFORMATIQUE"
  write-host "3. FINANCE"
  write-host "4. COMMERCIAL"
  write-host "5. DIRECTION"
  write-host "6. LOGISTIQUE"
  write-host "7. RH"
  write-host "8. MARKETING"
  write-host "Q. xxxxx QUITTER LE SCRIPT xxxxx" -ForegroundColor DarkYellow
  write-host "--------------------------------------------------------"
  $choix = read-host A PARTIR DE QUEL GROUPE SOUHAITEZ VOUS LISTER LES UTILISATEURS?:

  #SWITCH POUR , EN FONCTION , LISTER LES UTILISATEURS D UN GROUPE
    switch ($choix){
     
    #STAGIAIRES  
    1{
      $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Stagiaires,DC=axeplane,DC=loc'

        Get-ADGroup -Filter * -SearchBase 'CN=Grp_Stagiaire,OU=Stagiaires,DC=axeplane,dc=loc'

        $Rapport = foreach( $Group in $Groups ){
        Get-ADGroupMember -Identity $Group | ForEach-Object {
        
                                                                             [pscustomobject]@{
                                                                                                GROUPE = $Group.Name        
                                                                                                NOM = $_.Name        
                                                                                              }
                                                                       }
                                                                      }
           
        
        $Rapport| Export-Csv -Path "c:\RapportsAD\Groupes\$1.csv" -NoTypeInformation
     }
    
    #INFORMATIQUE 
    2{
        $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Informatique,DC=axeplane,DC=loc'
  
          Get-ADGroup -Filter * -SearchBase 'CN=Grp_Informatique,OU=Informatique,DC=axeplane,dc=loc'
  
          $Rapport = foreach( $Group in $Groups ){
          Get-ADGroupMember -Identity $Group | ForEach-Object {
          
                                                                               [pscustomobject]@{
                                                                                                  GROUPE = $Group.Name        
                                                                                                  NOM = $_.Name        
                                                                                                }
                                                                         }
                                                                        }
             
          
          $Rapport| Export-Csv -Path "c:\RapportsAD\Groupes\$2.csv" -NoTypeInformation
     }  
    #FINANCE
    3{
      $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Finance,DC=axeplane,DC=loc'

        Get-ADGroup -Filter * -SearchBase 'CN=Grp_Finance,OU=Finance,DC=axeplane,dc=loc'

        $Rapport = foreach( $Group in $Groups ){
        Get-ADGroupMember -Identity $Group | ForEach-Object {
        
                                                                             [pscustomobject]@{
                                                                                                GROUPE = $Group.Name        
                                                                                                NOM = $_.Name        
                                                                                              }
                                                                       }
                                                                      }
           
        
        $Rapport| Export-Csv -Path "c:\RapportsAD\Groupes\$3.csv" -NoTypeInformation
     }    
    #COMMERCIAL
    4{
        $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Commercial,DC=axeplane,DC=loc'
  
          Get-ADGroup -Filter * -SearchBase 'CN=Grp_Commercial,OU=Commercial,DC=axeplane,dc=loc'
  
          $Rapport = foreach( $Group in $Groups ){
          Get-ADGroupMember -Identity $Group | ForEach-Object {
          
                                                                               [pscustomobject]@{
                                                                                                  GROUPE = $Group.Name        
                                                                                                  NOM = $_.Name        
                                                                                                }
                                                                         }
                                                                        }
             
          
          $Rapport| Export-Csv -Path "c:\RapportsAD\Groupes\$4.csv" -NoTypeInformation
     }  
    #DIRECTION
    5{
            $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Direction,DC=axeplane,DC=loc'
      
              Get-ADGroup -Filter * -SearchBase 'CN=Grp_Direction,OU=Direction,DC=axeplane,dc=loc'
      
              $Rapport = foreach( $Group in $Groups ){
              Get-ADGroupMember -Identity $Group | ForEach-Object {
              
                                                                                   [pscustomobject]@{
                                                                                                      GROUPE = $Group.Name        
                                                                                                      NOM = $_.Name        
                                                                                                    }
                                                                             }
                                                                            }
                 
              
              $Rapport| Export-Csv -Path "c:\RapportsAD\Groupes\$5.csv" -NoTypeInformation
     } 
    #LOGISTIQUE      
    6{
                $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Logistique,DC=axeplane,DC=loc'
          
                  Get-ADGroup -Filter * -SearchBase 'CN=Grp_Logistique,OU=Logistique,DC=axeplane,dc=loc'
          
                  $Rapport = foreach( $Group in $Groups ){
                  Get-ADGroupMember -Identity $Group | ForEach-Object {
                  
                                                                                       [pscustomobject]@{
                                                                                                          GROUPE = $Group.Name        
                                                                                                          NOM = $_.Name        
                                                                                                        }
                                                                                 }
                                                                                }
                     
                  
                  $Rapport| Export-Csv -Path "c:\RapportsAD\Groupes\$6.csv" -NoTypeInformation
     }    
    #RH        
    7{
                    $Groups = Get-ADGroup -Filter * -SearchBase 'OU=RH,DC=axeplane,DC=loc'
              
                      Get-ADGroup -Filter * -SearchBase 'CN=Grp_RH,OU=RH,DC=axeplane,dc=loc'
              
                      $Rapport = foreach( $Group in $Groups ){
                      Get-ADGroupMember -Identity $Group | ForEach-Object {
                      
                                                                                           [pscustomobject]@{
                                                                                                              GROUPE = $Group.Name        
                                                                                                              NOM = $_.Name        
                                                                                                            }
                                                                                     }
                                                                                    }
                         
                      
                      $Rapport| Export-Csv -Path "c:\RapportsAD\Groupes\$7.csv" -NoTypeInformation
     }        
    #MARKETING            
    8{
                        $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Marketing,DC=axeplane,DC=loc'
                  
                          Get-ADGroup -Filter * -SearchBase 'CN=Grp_Marketing,OU=Marketing,DC=axeplane,dc=loc'
                  
                          $Rapport = foreach( $Group in $Groups ){
                          Get-ADGroupMember -Identity $Group | ForEach-Object {
                          
                                                                                               [pscustomobject]@{
                                                                                                                  GROUPE = $Group.Name        
                                                                                                                  NOM = $_.Name        
                                                                                                                }
                                                                                         }
                                                                                        }
                             
                          
                          $Rapport| Export-Csv -Path "c:\RapportsAD\Groupes\$8.csv" -NoTypeInformation
     }

    #Q = FIN DE LA BOUCLE
    "Q" {$continue = $false}

    #SI RIEN N EST TAPE ALORS "CHOIX INVALIDE"
    default {Write-Host "Choix invalide"-ForegroundColor Red}
  }
}

Write-host "VOS RAPPORTS ONT ETES CORRECTEMENT EDITES DANS C:\RapportsAD\Groupes" -ForegroundColor Green
Read-Host -Prompt "Appuyez sur une touche pour fermer le script"