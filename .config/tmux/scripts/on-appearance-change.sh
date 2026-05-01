#!/bin/sh
# Wrapper invoked by dark-mode-notify on macOS appearance change.
# Runs the legacy change_theme.sh (kitty/nvim/bat updates) then syncs tmux.
# DARKMODE env var ("1" or unset) is forwarded by dark-mode-notify.

[ -x /usr/local/bin/change_theme.sh ] && /usr/local/bin/change_theme.sh
exec "$HOME/.config/tmux/scripts/sync-flavor.sh"
