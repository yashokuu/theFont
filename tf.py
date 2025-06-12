#!/usr/bin/env python3

import requests
import os
import sys
import zipfile
import shutil
from bs4 import BeautifulSoup
from tqdm import tqdm

print("🌐 Fetching font page...")

if len(sys.argv) < 2:
    print("Usage: tf <dafont-font-url>")
    sys.exit(1)

url = sys.argv[1]
r = requests.get(url)
soup = BeautifulSoup(r.text, "html.parser")

div = soup.find("div", class_="dlbox")
if div is None:
    print("❌ Couldn't find the download box. Make sure it's a valid DaFont URL.")
    sys.exit(1)

a = div.find("a")
if a is None:
    print("❌ Couldn't find the <a> tag inside the download box.")
    sys.exit(1)

part = a.get("href")
if not part:
    print("❌ Couldn't find the download link.")
    sys.exit(1)

font_name = url.split("/")[-1].split(".")[0].replace("-", "_")
download_url = f"https://www.dafont.com{part}"

print(f"📦 Downloading {font_name} from {download_url}")

# Download with progress bar
response = requests.get(download_url, stream=True)
zip_path = f"{font_name}.zip"
total = int(response.headers.get('content-length', 0))

with open(zip_path, "wb") as file, tqdm(
    desc=f"⬇️  {zip_path}",
    total=total,
    unit='B',
    unit_scale=True,
    unit_divisor=1024,
) as bar:
    for data in response.iter_content(chunk_size=1024):
        size = file.write(data)
        bar.update(size)

print("📂 Extracting fonts...")

temp_dir = "./.tf-temp"
try:
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(temp_dir)
except zipfile.BadZipFile:
    print("❌ File is not a valid zip file.")
    os.remove(zip_path)
    sys.exit(1)

os.remove(zip_path)

ttf_fonts = [f for f in os.listdir(temp_dir) if f.endswith(".ttf") or f.endswith(".otf")]

if not ttf_fonts:
    print("❌ No font files found in the zip.")
    shutil.rmtree(temp_dir)
    sys.exit(1)

font_dir = os.path.expanduser("~/.local/share/fonts")
os.makedirs(font_dir, exist_ok=True)

for font_file in ttf_fonts:
    src = os.path.join(temp_dir, font_file)
    dst = os.path.join(font_dir, font_file)
    shutil.move(src, dst)

shutil.rmtree(temp_dir)

print("🔄 Refreshing font cache...")
os.system("fc-cache -f")

print(f"✅ Installed '{font_name}' font!")
