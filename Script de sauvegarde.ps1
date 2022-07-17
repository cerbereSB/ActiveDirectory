Import-Module ActiveDirectory

$Computers = Get-ADComputer -Filter 'Name -like "PARAP*"' | Select-Object -ExpandProperty Name
$Date = Get-Date -Format "MM-dd-yyyy"
$Path = "E:\Logs\Sauvegarde du $Date.txt"

ForEach ($Computer in $Computers)
{
    
    if (Test-Connection $Computer -Count 2 -ErrorAction SilentlyContinue)
    {
        Add-Content $Path "$Computer EST EN LIGNE" 
        Add-Content $Path "DEBUT DE LA COPIE ..." 
        Robocopy.exe "\\$Computer\c$\Users\" "E:\Sauvegardes\$Computer\$computer"  `
        /xf "NTUSER.DAT*" `
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
            'Local Settings' /e /b /mir /mt /r:0 /w:0 /njh /njs /log+:$Path
            Add-Content $Path "FIN DE LA COPIE DE $computer"

            Write-Host "COPIE EFFECTUEE
            
            
            " -ForegroundColor Green
    }
    else
    {
        Write-Host "MACHINE HORS LIGNE" -ForegroundColor Red
        Add-Content $Path "$Computer EST HORS LIGNE" 
        Add-Content $Path "LA COPIE EST IMPOSSIBLE
        
        
        " 
        
        
    }
        
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