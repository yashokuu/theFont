
# theFont — simple daFont installer for Linux

## 🌟 What is this?
`theFont` is a clean and minimalistic CLI tool to easily download and install fonts from [daFont.com](https://www.dafont.com).

## 🚀 Install
```bash
bash <(curl -sL https://raw.githubusercontent.com/yashokuu/theFont/main/install.sh)
````

## 💻 Usage

```bash
tf https://www.dafont.com/super-adorable.font
```

## 🔧 Features

* Installs any daFont font with a single command
* Downloads + extracts + caches automatically
* No sudo needed, installs to `~/.local/share/fonts`

## 🧠 Requirements

* Python 3
* `requests`, `beautifulsoup4`
* `unzip`, `fc-cache`

Install Python packages (if needed):

```bash
pip install --user requests beautifulsoup4 tqdm
```

## 📦 Uninstall

```bash
rm ~/.local/bin/tf
```

## 👤 Author

Made with 💖 by [@yashokuu](https://github.com/yashokuu)

---

✨ tf = typeface... but stylish
