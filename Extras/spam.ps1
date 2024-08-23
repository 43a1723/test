$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'hai1723fuckyou')
$random = Get-Random -Minimum 1000 -Maximum 9999

for ($i = 1; $i -le 200; $i++) {
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
