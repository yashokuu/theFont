#!/bin/bash

INSTALL_PATH="$HOME/.local/bin"
SCRIPT_NAME="tf"
SCRIPT_URL="https://raw.githubusercontent.com/yashokuu/theFont/main/tf.py"
VERSION="V0"

ASCII_CAT="
 /\_/\  
( o.o )  theFont Installer
 > ^ <  
"

echo "$ASCII_CAT"
echo "🌟 Installing theFont $VERSION..."

# Check OS (basic Arch check)
is_arch() {
  grep -qi arch /etc/os-release 2>/dev/null
}

# Install Python libs helper
install_python_libs() {
  if is_arch; then
    echo "Detected Arch Linux."

    echo "Need to install Python dependencies: python-requests, python-bs4, python-tqdm"
    read -rp "Install via pacman? This may ask to overwrite files and could break packages. (y/N): " yn
    case "$yn" in
      [Yy]* )
        sudo pacman -S --needed python-requests python-bs4 python-tqdm
        ;;
      * )
        echo "Skipping system package install. Installing with pip in user mode..."
        pip install --user requests beautifulsoup4 tqdm
        ;;
    esac
  else
    echo "Non-Arch system detected. Installing Python libs via pip --user..."
    pip install --user requests beautifulsoup4 tqdm
  fi
}

install_python_libs

mkdir -p "$INSTALL_PATH"

echo "Downloading theFont script..."
curl -sL "$SCRIPT_URL" -o "$INSTALL_PATH/$SCRIPT_NAME"
chmod +x "$INSTALL_PATH/$SCRIPT_NAME"

echo "✅ Installed as $INSTALL_PATH/$SCRIPT_NAME"

# Add to PATH if needed
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
  SHELL_RC="$HOME/.bashrc"
  [ -n "$ZSH_VERSION" ] && SHELL_RC="$HOME/.zshrc"
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
  echo "🔁 Added ~/.local/bin to PATH. Restart your shell or run 'source $SHELL_RC'"
fi

echo "🚀 Done! Run 'tf <dafont-font-url>' to install fonts from dafont.com"
