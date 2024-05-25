# Define the URL to fetch the content from
$url = "https://raw.githubusercontent.com/43a1723/test/main/Extras/hash.ps1"

# Download the content from the URL
$webClient = New-Object System.Net.WebClient
$downloadedContent = $webClient.DownloadString($url)

# Read the content from the hash file
$fileContent = Get-Content -Path $hashFilePath -Raw

# Compare the contents and print the appropriate message
if ($fileContent -eq $downloadedContent) {
    Write-Output "last version"
} else {
    Write-Output "old version"
}
