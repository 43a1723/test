$response = Invoke-RestMethod -Uri "https://ip-api.com/line/?fields=hosting"

if ($response.hosting -eq $true) {
    Write-Host "Hosting detected. Disabling code execution."
    exit
} else {
    Write-Host "No hosting detected. Continuing code execution."
    # Add code to continue execution here
}
