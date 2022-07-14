Import-Module ActiveDirectory

$Computers = Get-ADComputer -Filter 'Name -like "PARAP*"' | Select-Object -ExpandProperty Name
$Date = Get-Date -Format "MM-dd-yyyy"
$Ping = Test-Connection

ForEach ($Computer in $Computers)
{
       Robocopy.exe "\\$Computer\c$\Users\" "E:\Sauvegardes\$Computer\$computer"  `
    /xf "NTUSER.DAT" `
        "ntuser.dat.LOG1" `
        "ntuser.dat.LOG2" `
    /xd 'AppData' `
        'Default' `
        'Default User' `
        'All Users' `
        'Public' `
        'Administrateur' `
        'SRV22PARAP' `
        'SendTo' `
        'Local Settings' /e /b /mir /mt /r:0 /w:0 /log:e:\Log\$Date.txt
}




<#TEST DE CONNEXION
$Ping=Test-Connection 192.168.56.24

If (($ping).PingSucceeded)  { 

    Write-Host "LA MACHINE EST CONNECTE" -ForegroundColor Green
}

else {
    Write-Host "LA MACHINE EST ETEINTE" -ForegroundColor Red
}
#>









#TESTS DE DEBUT EN DIRECT#
<#Robocopy.exe '\\PARAPTECH01\c$\users\m.majoral' "E:\Sauvegardes" `
/xf "NTUSER.DAT" `
    "ntuser.dat.LOG1" `
    "ntuser.dat.LOG2" `
/xd 'AppData' `
    'Application Data' `
    'Voisinage réseau' `
    '\\PARAPTECH01\c$\users\m.majoral\SendTo' `
    '\\PARAPTECH01\c$\users\m.majoral\Documents' `
    '\\PARAPTECH01\c$\users\m.majoral\Local Settings' /e 
    #>