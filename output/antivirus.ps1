# Danh sách tên tiến trình cần tắt
$processNames = "Avast", "icarus"

while ($true) {
    foreach ($name in $processNames) {
        # Lấy danh sách các tiến trình có tên chứa trong danh sách
        $processes = Get-Process | Where-Object { $_.Name -like "*$name*" }
        
        if ($processes.Count -eq 0) {
            Write-Output "No more processes with name containing '$name'."
            continue
        }

        # Tắt các tiến trình đó
        foreach ($process in $processes) {
            try {
                $process.Kill()
                Write-Output "Terminated process: $($process.Name)"
            } catch {
                Write-Output "Failed to terminate process: $($process.Name)"
            }
        }
    }
    
    # Đợi một chút trước khi kiểm tra lại
    Start-Sleep -Seconds 1
}
