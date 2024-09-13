param(
    [string]$Api_Key = "5cd946adfc88d589381f4650cd34d747b24f46230c63917b08da2e471ed165e7",
    #[string]$File_Hash = ,
    [string]$Api_Aurl = "https://www.virustotal.com/api/v3/analyses/$File_Hash",
    [string]$Api_URL = "https://www.virustotal.com/api/v3/files"

)

    $File_Hash = Get-ChildItem | Get-FileHash | Out-File -FilePath "C:\Users\AbrahamEstudillo\PIA"

$headers = @{
    "x-apikey" = $Api_Key
    "User-Agent" = "AbramT"
}

if ($Api_Aurl = 200){
            $response = Invoke-RestMethod -Uri $Api_URL -Headers $headers -Method Get
    }else{
    Write-Host "Error al conectar con el API"
    }