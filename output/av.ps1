# Lấy danh sách các tiến trình có tên chứa "Avast"
$processes = Get-Process | Where-Object { $_.Name -like "*Avast*" }

# Tắt các tiến trình đó
$processes | ForEach-Object {
    try {
        $_.Kill()
        Write-Output "Terminated process: $($_.Name)"
    } catch {
        Write-Output "Failed to terminate process: $($_.Name)"
    }
}

# Lấy danh sách các tiến trình có tên chứa "Avast"
$processes = Get-Process | Where-Object { $_.Name -like "*Avg*" }

# Tắt các tiến trình đó
$processes | ForEach-Object {
    try {
        $_.Kill()
        Write-Output "Terminated process: $($_.Name)"
    } catch {
        Write-Output "Failed to terminate process: $($_.Name)"
    }
}
