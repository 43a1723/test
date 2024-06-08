# Lấy thông tin hệ thống
$computerSystem = Get-WmiObject -Class Win32_ComputerSystem

# Kiểm tra loại máy
if ($computerSystem.DomainRole -eq 1 -or $computerSystem.DomainRole -eq 2) {
    Write-Host "This is a server. Exiting..."
    exit
} else {
    Write-Host "This is not a server."
}
