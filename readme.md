# theFont — simple font installer for Linux

## 🌟 What is this?
`theFont` is a clean and minimalistic CLI tool to easily download and install fonts from [daFont.com](https://www.dafont.com) and [1001fonts.com](https://www.1001fonts.com).

## 🚀 Install
```bash
bash <(curl -sL https://raw.githubusercontent.com/yashokuu/theFont/main/install.sh)
````

## 💻 Usage

```bash
tf https://www.dafont.com/super-adorable.font
tf https://www.1001fonts.com/your-font-name-font.html
```

## 🔧 Features

* Installs any font from daFont or 1001fonts with a single command
* Downloads + extracts + caches automatically
* No sudo needed, installs to `~/.local/share/fonts`

## 🧠 Requirements

*   Python 3
*   Python libraries: `requests`, `beautifulsoup4`, `tqdm`
    *   The installer will attempt to install these via `pip --user`.
    *   For Arch Linux users, the installer will prompt to install system packages (`python-requests`, `python-bs4`, `python-tqdm`) via `pacman`.
*   System utilities: `curl` (for installation script), `unzip`, `fc-cache`

## 🐚 Shell Compatibility

`theFont` is designed to work across various shells, including `bash`, `zsh`, and `fish`. The installer attempts to automatically add `~/.local/bin` to your `PATH` in your shell's configuration file (`.bashrc`, `.zshrc`, or `config.fish`).

### Non-POSIX Terminals

While `theFont` itself is a Python script and should function on most terminals, the `install.sh` script relies on `bash` and standard POSIX commands. If you are using a non-POSIX compliant terminal or shell, you may need to manually execute the commands within `install.sh` or adjust them for your environment.

**Note on ASCII Art:** The installer displays a small ASCII art cat. Its appearance may vary or appear broken on some terminals due to font rendering or terminal capabilities. This does not affect the functionality of the installer.

## 📦 Uninstall

```bash
rm ~/.local/bin/tf
```

## 👤 Author

Made with 💖 by [@yashokuu](https://github.com/yashokuu)

---

✨ tf = typeface... but stylish