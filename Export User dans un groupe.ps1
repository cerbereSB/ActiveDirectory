

$1="Stagiaires"
$2="Informatique"
$3="Finance"
$4="Commercial"
$5="Direction"
$6="Logistique"
$7="RH"
$8="Marketing"

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
  write-host "Q. Quitter"
  write-host "--------------------------------------------------------"
  $choix = read-host A PARTIR DE QUEL GROUPE SOUHAITEZ VOUS LISTER LES UTILISATEURS?:
    switch ($choix){
       
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
           
        
        $Rapport| Export-Csv -Path "c:\RapportsAD\$1.csv" -NoTypeInformation
     }

    2{
        $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Informatique,DC=axeplane,DC=loc'
  
          Get-ADGroup -Filter * -SearchBase 'CN=Informatique,OU=Informatique,DC=axeplane,dc=loc'
  
          $Rapport = foreach( $Group in $Groups ){
          Get-ADGroupMember -Identity $Group | ForEach-Object {
          
                                                                               [pscustomobject]@{
                                                                                                  GROUPE = $Group.Name        
                                                                                                  NOM = $_.Name        
                                                                                                }
                                                                         }
                                                                        }
             
          
          $Rapport| Export-Csv -Path "c:\RapportsAD\$2.csv" -NoTypeInformation
     }  

    3{
      $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Finance,DC=axeplane,DC=loc'

        Get-ADGroup -Filter * -SearchBase 'CN=Finance,OU=Finance,DC=axeplane,dc=loc'

        $Rapport = foreach( $Group in $Groups ){
        Get-ADGroupMember -Identity $Group | ForEach-Object {
        
                                                                             [pscustomobject]@{
                                                                                                GROUPE = $Group.Name        
                                                                                                NOM = $_.Name        
                                                                                              }
                                                                       }
                                                                      }
           
        
        $Rapport| Export-Csv -Path "c:\RapportsAD\$3.csv" -NoTypeInformation
     }    

    4{
        $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Commercial,DC=axeplane,DC=loc'
  
          Get-ADGroup -Filter * -SearchBase 'CN=Commercial,OU=Commercial,DC=axeplane,dc=loc'
  
          $Rapport = foreach( $Group in $Groups ){
          Get-ADGroupMember -Identity $Group | ForEach-Object {
          
                                                                               [pscustomobject]@{
                                                                                                  GROUPE = $Group.Name        
                                                                                                  NOM = $_.Name        
                                                                                                }
                                                                         }
                                                                        }
             
          
          $Rapport| Export-Csv -Path "c:\RapportsAD\$4.csv" -NoTypeInformation
     }  

    5{
            $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Direction,DC=axeplane,DC=loc'
      
              Get-ADGroup -Filter * -SearchBase 'CN=Direction,OU=Direction,DC=axeplane,dc=loc'
      
              $Rapport = foreach( $Group in $Groups ){
              Get-ADGroupMember -Identity $Group | ForEach-Object {
              
                                                                                   [pscustomobject]@{
                                                                                                      GROUPE = $Group.Name        
                                                                                                      NOM = $_.Name        
                                                                                                    }
                                                                             }
                                                                            }
                 
              
              $Rapport| Export-Csv -Path "c:\RapportsAD\$5.csv" -NoTypeInformation
     }  
            
    6{
                $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Logistique,DC=axeplane,DC=loc'
          
                  Get-ADGroup -Filter * -SearchBase 'CN=Logistique,OU=Logistique,DC=axeplane,dc=loc'
          
                  $Rapport = foreach( $Group in $Groups ){
                  Get-ADGroupMember -Identity $Group | ForEach-Object {
                  
                                                                                       [pscustomobject]@{
                                                                                                          GROUPE = $Group.Name        
                                                                                                          NOM = $_.Name        
                                                                                                        }
                                                                                 }
                                                                                }
                     
                  
                  $Rapport| Export-Csv -Path "c:\RapportsAD\$6.csv" -NoTypeInformation
     }    
                
    7{
                    $Groups = Get-ADGroup -Filter * -SearchBase 'OU=RH,DC=axeplane,DC=loc'
              
                      Get-ADGroup -Filter * -SearchBase 'CN=RH,OU=RH,DC=axeplane,dc=loc'
              
                      $Rapport = foreach( $Group in $Groups ){
                      Get-ADGroupMember -Identity $Group | ForEach-Object {
                      
                                                                                           [pscustomobject]@{
                                                                                                              GROUPE = $Group.Name        
                                                                                                              NOM = $_.Name        
                                                                                                            }
                                                                                     }
                                                                                    }
                         
                      
                      $Rapport| Export-Csv -Path "c:\RapportsAD\$7.csv" -NoTypeInformation
     }        
                    
    8{
                        $Groups = Get-ADGroup -Filter * -SearchBase 'OU=Marketing,DC=axeplane,DC=loc'
                  
                          Get-ADGroup -Filter * -SearchBase 'CN=Marketing,OU=Marketing,DC=axeplane,dc=loc'
                  
                          $Rapport = foreach( $Group in $Groups ){
                          Get-ADGroupMember -Identity $Group | ForEach-Object {
                          
                                                                                               [pscustomobject]@{
                                                                                                                  GROUPE = $Group.Name        
                                                                                                                  NOM = $_.Name        
                                                                                                                }
                                                                                         }
                                                                                        }
                             
                          
                          $Rapport| Export-Csv -Path "c:\RapportsAD\$8.csv" -NoTypeInformation
     }
    "Q" {$continue = $false}
    default {Write-Host "Choix invalide"-ForegroundColor Red}
  }
}