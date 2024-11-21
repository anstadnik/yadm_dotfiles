# Auto dark mode:
https://github.com/bouk/dark-mode-notify

```bash
#!/usr/bin/env bash

# Set the theme based on the DARKMODE environment variable
if [[ "$DARKMODE" == "1" ]]; then
    THEME="dark"
    CATPPUCCIN_THEME="mocha"
    CATPPUCCIN_THEME_CAP="Mocha"
else
    THEME="light"
    CATPPUCCIN_THEME_CAP="Latte"
fi

export PATH="/opt/homebrew/bin:$PATH"

echo "$(date) Setting theme to $THEME"

# Update Neovim servers via nvr
NVR_SERVERS=$(nvr --serverlist)
if [[ -z "$NVR_SERVERS" ]]; then
    echo "$(date) Neovim: No active servers found"
else
    for SERVER in $NVR_SERVERS; do
        echo "$(date) Neovim server ($SERVER): Sending command"
        nvr --servername "$SERVER" --remote-send ":set background=$THEME<CR>" &
    done
fi

# Update Neovim configuration file
NVIM_CONFIG="$HOME/.config/nvim/lua/plugins/color.lua"
sed -i "" "s/vim.opt.background = \".*\"/vim.opt.background = \"$THEME\"/g" "$NVIM_CONFIG" && \
echo "$(date) Updated Neovim configuration file" &

# Update Kitty configuration
KITTY_THEME="Catppuccin-${CATPPUCCIN_THEME_CAP}"
kitty +kitten themes --reload-in=all --config-file-name themes.conf "$KITTY_THEME" && \
echo "$(date) Updated Kitty theme" &

# Update Tmux configuration
tmux set -g @catppuccin_flavor "$CATPPUCCIN_THEME" && \
tmux run-shell "~/.tmux/plugins/tpm/tpm" && \
echo "$(date) Updated Tmux theme" &

# Update Bat configuration
BAT_CONFIG="$HOME/.config/bat/config"
BAT_THEME="Catppuccin ${CATPPUCCIN_THEME_CAP}"
sed -i "" "s/--theme=\".*\"/--theme=\"$BAT_THEME\"/g" "$BAT_CONFIG" && \
echo "$(date) Updated Bat theme" &
```
