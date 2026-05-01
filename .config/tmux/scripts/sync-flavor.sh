#!/bin/sh
# Sync catppuccin flavor with macOS appearance, then re-source tmux.conf.
#
# Sources of truth, in order:
#   1. $DARKMODE env var (set by dark-mode-notify: "1" = dark, unset/empty = light)
#   2. `defaults read -g AppleInterfaceStyle` (when invoked manually, e.g. via prefix+T)

if [ "${DARKMODE-unset}" != "unset" ]; then
  [ "$DARKMODE" = "1" ] && flavor=mocha || flavor=latte
elif [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ]; then
  flavor=mocha
else
  flavor=latte
fi

tmux set -g @catppuccin_flavor "$flavor" 2>/dev/null && \
  tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null
