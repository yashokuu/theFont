#!/bin/bash

INSTALL_PATH="$HOME/.local/bin"
SCRIPT_NAME="tf"
SCRIPT_URL="https://raw.githubusercontent.com/yashokuu/theFont/main/tf.py"

mkdir -p "$INSTALL_PATH"

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
