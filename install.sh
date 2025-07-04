#!/bin/bash

INSTALL_PATH="$HOME/.local/bin"
SCRIPT_NAME="tf"
SCRIPT_URL="https://raw.githubusercontent.com/yashokuu/theFont/main/tf.py"
VERSION="v1"

ASCII_CAT="
  /\_/\
 ( >.< ) theFont Installer
  / - \
 /_ _ _\
"

echo "$ASCII_CAT"
echo "🌟 Installing theFont $VERSION..."

install_python_libs() {
  # Check if Arch (super basic)
  if grep -qi arch /etc/os-release 2>/dev/null; then
    echo "Detected Arch Linux."

    echo "Installing Python libs with pip using --break-system-packages..."
    pip install --break-system-packages --user requests beautifulsoup4 tqdm
  else
    echo "Non-Arch system detected. Installing Python libs with pip --user..."
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

echo "🚀 Done! Run 'tf <font-url>' to install fonts from dafont.com or 1001fonts.com"
