#Revision de Firewall de Windows

<#
.SYNOPSIS
Revisa el firewall, hace pruebas de conexion y muestra registros de entrada y salida

.DESCRIPTION
La función Status_Firewall muestra el estatus del firewall y si tiene buena conexion el equipo
La función Performance verifica los puertos  y los filtra con ayuda del firewall
La función Imput/Output_Rules solo muestra las reglas de entrada y salida del firewall

.PARAMETER PATHH
Parametros que solo vamos a ocupar para la conexion de puertos
$port es el puerto al que nos queremos conectar
$PC_Name nombre del equipo que va a hacer la conexion (En este caso el mismo nombre del equipo)

.EXAMPLE
--|Status_Firewall|--
Estado del Firewall

Name    Enabled
----    -------
Domain     True
...

--|Performance|--
Estado de la conexion

Name                                                          Enabled Direction Action
----                                                          ------- --------- ------
SNMPTRAP-In-UDP                                                 False   Inbound  Allow
SNMPTRAP-In-UDP-NoScope                                         False   Inbound  Allow
...
Verificar puertos
Prueba de conexion
ADVERTENCIA: TCP connect to (fe80::b6b:c537:6f57:f13%13 : 80) failed
ADVERTENCIA: TCP connect to (fe80::43a1:ac4a:7619:f345%2 : 80) failed
...

--|Output/Input_Rules|--
Reglas de Entrada

ComputerName           : DESKTOP-I5235OO
RemoteAddress          : fe80::b6b:c537:6f57:f13%13
RemotePort             : 80
...

Name                                                 Enabled Action
----                                                 ------- ------
SNMPTRAP-In-UDP                                        False  Allow
SNMPTRAP-In-UDP-NoScope                                False  Allow
...
#>

Param(
    [string]$port = 80,
    [string]$PC_Name = $env:COMPUTERNAME
)

function Status_Firewall{
    Write-Host "Estado del Firewall"
    Get-NetFirewallProfile | Format-Table Name, Enabled
    Write-Host "Estado de la conexion"
    Get-NetFirewallRule | Format-Table -Property Name, Enabled, Direction, Action

}

function Performance{
try{   
    Write-Host "Verificar puertos"
    Get-NetFirewallPortFilter | Where-Object { $_.Port -eq 80 }
    Write-Host "Prueba de conexion"
    Test-NetConnection -Port $port -ComputerName $PC_Name
}catch{
    Write-Host "Error con el nombre del equipo"
}
}

function Output/Input_Rules{
Write-Host "Reglas de Entrada"
Get-NetFirewallRule | Where-Object {$_.Direction -eq 'Inbound'} | Format-Table -Property Name, Enabled, Action
Write-Host "Reglas de Salida"
Get-NetFirewallRule | Where-Object {$_.Direction -eq 'Outbound'} | Format-Table -Property Name, Enabled, Action

}


function Check_Firewall{
    Status_Firewall
    Performance
    Output/Input_Rules
}
