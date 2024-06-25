# Define the toggle function
toggle_key_mode() {
  if [[ $KEYMAP == vicmd || $KEYMAP == viins ]]; then
    bindkey -e  # Switch to emacs mode
    echo "Switched to emacs mode"
  else
    bindkey -v  # Switch to vi mode
    echo "Switched to vi mode"
  fi
}

# Create a zle widget for the toggle function
zle -N toggle_key_mode


bindkey -M emacs '^T' toggle_key_mode

# Bind the toggle function to Ctrl+T for vi command mode
bindkey -M vicmd '^T' toggle_key_mode

# Bind the toggle function to Ctrl+T for vi insert mode
bindkey -M viins '^T' toggle_key_mode
