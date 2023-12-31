if status is-interactive
    fish_add_path /opt/homebrew/bin
    set -g fish_greeting

    starship init fish | source
    zoxide init fish | source
    fzf_configure_bindings --directory=\cf
    set fzf_fd_opts --hidden
    export MAMBA_ROOT_PREFIX=~/micromamba
    eval "$(micromamba shell hook --shell fish)"

    export NNN_OPENER={$HOME}/.config/nnn/plugins/nuke
    export NNN_PLUG='s:preview-tui;p:dragdrop;z:autojump;d:diffs;f:fzcd'
    export NNN_OPTS="ac"
    abbr -a n nnn

    export VISUAL=nvim
    export EDITOR="$VISUAL"

    set -q XDG_DATA_HOME || set -U XDG_DATA_HOME $HOME/.local/share
    set -q XDG_CONFIG_HOME || set -U XDG_CONFIG_HOME $HOME/.config
    set -q XDG_STATE_HOME || set -U XDG_STATE_HOME $HOME/.local/state
    set -q XDG_CACHE_HOME || set -U XDG_CACHE_HOME $HOME/.cache

    export ANDROID_HOME="$XDG_DATA_HOME"/android
    export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
    export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
    export DOT_SAGE="$XDG_CONFIG_HOME"/sage

    bind -k nul forward-word

    abbr -a ls lsd
    abbr -a v nvim
    abbr -a -p anywhere G "| grep"
    abbr -a -p anywhere L "| less"

    macchina
end
