# Check if the shell is interactive before applying configurations
if status is-interactive
    # Add homebrew to the path if it exists
    if test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    end

    # Set the fish greeting
    set -g fish_greeting

    # Fix typos
    thefuck --alias | source 

    # Initialize starship prompt and other tools
    starship init fish | source
    zoxide init fish | source
    fzf_configure_bindings --directory=\cf
    set fzf_fd_opts --hidden

    # Set Micromamba environment
    set -x MAMBA_ROOT_PREFIX $HOME/micromamba
    eval "micromamba shell hook --shell fish"

    # Configure NNN file manager
    set -x NNN_OPENER $HOME/.config/nnn/plugins/nuke
    set -x NNN_PLUG 's:preview-tui;p:dragdrop;z:autojump;d:diffs;f:fzcd'
    set -x NNN_OPTS "ac"
    abbr -a n nnn

    # Set default editor and visual editor
    set -x VISUAL nvim
    set -x EDITOR $VISUAL

    # Set XDG base directories
    set -q XDG_DATA_HOME || set -U XDG_DATA_HOME $HOME/.local/share
    set -q XDG_CONFIG_HOME || set -U XDG_CONFIG_HOME $HOME/.config
    set -q XDG_STATE_HOME || set -U XDG_STATE_HOME $HOME/.local/state
    set -q XDG_CACHE_HOME || set -U XDG_CACHE_HOME $HOME/.cache

    # Configure Android, Rust, and Python environments
    set -x ANDROID_HOME "$XDG_DATA_HOME/android"
    set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"
    set -x WORKON_HOME "$XDG_DATA_HOME/virtualenvs"
    set -x DOT_SAGE "$XDG_CONFIG_HOME/sage"

    # Set Gazebo plugin and resource paths
    # set --path -x GZ_SIM_SYSTEM_PLUGIN_PATH $GZ_SIM_SYSTEM_PLUGIN_PATH
    # set --path -x GZ_SIM_RESOURCE_PATH $GZ_SIM_RESOURCE_PATH
    set --path -x GZ_SIM_SYSTEM_PLUGIN_PATH $HOME/work/gz_ws/src/ardupilot_gazebo/build $GZ_SIM_SYSTEM_PLUGIN_PATH
    set --path -x GZ_SIM_RESOURCE_PATH $HOME/work/gz_ws/src/ardupilot_gazebo/models $HOME/work/gz_ws/src/ardupilot_gazebo/worlds $GZ_SIM_RESOURCE_PATH

    # Bindings and Abbreviations
    bind -k nul forward-word
    abbr -a ls lsd
    abbr -a v nvim
    abbr -a -p anywhere G "| grep"
    abbr -a -p anywhere L "| less"

    # Run macchina for system information on shell start
    macchina
end
