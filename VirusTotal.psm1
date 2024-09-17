# Definición de funciones
function VirusTotal_Report {
    param (
        [Parameter(Mandatory=$true)]
        [String]$FilePath
    )
    try {
        if (-Not (Test-Path -Path $FilePath)) {
            throw "El archivo no existe en la ruta especificada."
        }
        $fileHash = (Get-FileHash -Path $FilePath -Algorithm SHA256).Hash
        $headers = @{
            'x-apikey' = "05a41458770464ac34cf17e2de4b6ed2db122847e7dbc25a98b68ee84bf0b4b2"
        }
        $response = Invoke-RestMethod -Uri "https://www.virustotal.com/api/v3/files/$fileHash" -Method Get -Headers $headers
        $response.data.attributes.last_analysis_stats
    } catch {
        Write-Error "Error al obtener el reporte hash de VirusTotal: $_"
    }
}

