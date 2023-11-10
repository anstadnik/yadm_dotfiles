if status is-interactive
    set -g fish_greeting

    starship init fish | source
    zoxide init fish | source
    fzf_configure_bindings --directory=\cf
    export MAMBA_ROOT_PREFIX=~/micromamba
    eval "$(micromamba shell hook --shell fish)"

    export VISUAL=nvim
    export EDITOR="$VISUAL"

    alias ls lsd
    alias v=nvim


    macchina
end
