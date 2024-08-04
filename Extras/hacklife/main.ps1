$u = ("u$env:username" -replace '[^a-zA-Z0-9\-]+', '')[0..63] -join ''
$c = ("c$env:computername" -replace '[^a-zA-Z0-9\-]+', '')[0..63] -join ''
$id = ""
1..8 | ForEach-Object { $id += ([Char[]] "abcdefhijklmnonpqrstuvwxyz0123456789" | Get-Random) }
Resolve-DnsName -Name "$c.UN.$u.CMD.$id.ocsl48dyskzry0kauj0mh8li3.canarytokens.com"
