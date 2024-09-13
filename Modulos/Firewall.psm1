#Revision de Firewall de Windows

#Funcion que muestra el estatus del firewall y si tiene buena conexion el equipo
function Status_Firewall{
    Write-Host "Estado del Firewall"
    Get-NetFirewallProfile | Format-Table Name, Enabled
    Write-Host "Estado de la conexion"
    Get-NetFirewallRule | Format-Table -Property Name, Enabled, Direction, Action

}

#Funcion que verifica los puertos  y los filtra con ayuda del firewall
function Performance{
Write-Host "Verificar puertos"
Get-NetFirewallPortFilter | Where-Object { $_.Port -eq 80 }
Write-Host "Prueba de conexion"
Test-NetConnection -Port 80 -ComputerName $env:COMPUTERNAME

}

#Funcion que solo muestra las reglas de entrada y salida del firewall
function Output/Input_Rules{
Write-Host "Reglas de Entrada"
Get-NetFirewallRule | Where-Object {$_.Direction -eq 'Inbound'} | Format-Table -Property Name, Enabled, Action
Write-Host "Reglas de Salida"
Get-NetFirewallRule | Where-Object {$_.Direction -eq 'Outbound'} | Format-Table -Property Name, Enabled, Action

}


function Check_Log{
Write-Host "Registros del Firewall"
Get-WinEvent -LogName Firewall | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize
Write-Host "Registros que generan una Alerta"
Get-WinEvent -LogName 'Microsoft-Windows-Windows Firewall Whit Advanced Security/Firewall' | Where-Object {$_.Id -eq 5157} | Format-Table TimeCreated, Id, LevelDisplayName, Message -AutoSize

}

Status_Firewall
Performance
Output/Input_Rules
#Check_Log