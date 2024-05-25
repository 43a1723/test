if ((Invoke-RestMethod 'https://ip-api.com/line/?fields=hosting' -Method Get) -eq 'True') { exit }
