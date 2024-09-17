#Script Principal del menu

function Menu{

$OP=Read-Host @"
Elije una de la opciones del menu: 
    1.Consulta del API 
    2.Archivos Ocultos 
    3.Uso de recursos 
    4.Analisis del Firewall

"@ 
try{

    switch ($OP){
    1{
        Import-Module C:\Users\AbrahamEstudillo\PIA\VirusTotal.psm1
        VirusTotal_Report
    }
    2{
        Import-Module C:\Users\AbrahamEstudillo\PIA\ArchOc.psm1
        Hidden_Files
    }
    3{
        Import-Module C:\Users\AbrahamEstudillo\PIA\UsoSistema.psm1
        System_Results  
    }
    4{        
        Import-Module C:\Users\AbrahamEstudillo\PIA\Firewall.psm1
        Check_Firewall
    }
}
    
}catch{
    Write-Host "No se encontro ningun modulo con ese nombre" 
}
}


Menu