#!/usr/bin/env python3
import os, sys, requests, zipfile
from bs4 import BeautifulSoup

if len(sys.argv) != 2 or not sys.argv[1].startswith("https://www.dafont.com/"):
    print("Usage: tf <dafont-url>")
    sys.exit(1)

url = sys.argv[1]
print("🌐 Fetching font page...")

res = requests.get(url)
soup = BeautifulSoup(res.text, 'html.parser')

div = soup.find("div", {"class": "dlbox"})
a = div.find("a")
download_url = "https://www.dafont.com" + a['href']
font_name = download_url.split("=", 1)[-1]

print(f"📦 Downloading {font_name} from {download_url}")
zip_path = f"{font_name}.zip"
res = requests.get(download_url)

with open(zip_path, "wb") as f:
    f.write(res.content)

print("📂 Extracting fonts...")
extract_path = os.path.expanduser("~/.local/share/fonts")
os.makedirs(extract_path, exist_ok=True)

with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extractall(extract_path)

print("🧹 Cleaning up...")
os.remove(zip_path)

print("🔄 Refreshing font cache...")
os.system("fc-cache -f")

print(f"✅ Installed '{font_name}' font!")
