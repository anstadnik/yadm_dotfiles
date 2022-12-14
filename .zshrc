# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files source by it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Kitty integration :)
zstyle ':z4h:' iterm2-integration yes
# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Automaticaly wrap TTY with a transparent tmux ('integrated'), or start a
# full-fledged tmux ('system'), or disable features that require tmux ('no').
# zstyle ':z4h:' start-tmux       'integrated'
zstyle ':z4h:' start-tmux       'no'
# Move prompt to the bottom when zsh starts up so that it's always in the
# same position. Has no effect if start-tmux is 'no'.
zstyle ':z4h:' prompt-at-bottom 'yes'

# Keyboard type: 'mac' or 'pc'.
if [[ "$OSTYPE" == "darwin"* ]]; then
    zstyle ':z4h:bindkey' keyboard  'mac'
else
    zstyle ':z4h:bindkey' keyboard  'pc'
fi

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'yes'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Allow fuzzy fzf search
zstyle ':z4h:(fzf-history|fzf-complete|cd-down)' fzf-flags '--no-exact'
zstyle ':z4h:fzf-complete' fzf-command my-fzf

function my-fzf() {
    emulate -L zsh
    # Replace all arguments that start with "--query=^" with "--query=".
    fzf "${@/#--query=^/--query=}"
}

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# ssh when connecting to these hosts.
zstyle ':z4h:ssh:159.89.0.168'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over ssh to the
# enabled hosts.
# zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)
path=(/usr/local/share/python $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/git.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/extract/extract.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/git/git.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/virtualenvwrapper/virtualenvwrapper.plugin.zsh
if [[ "$(uname)" == 'Linux' ]] then
    z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/archlinux/archlinux.plugin.zsh
fi
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/common-aliases/common-aliases.plugin.zsh
# z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/git-flow-avh/git-flow-avh.plugin.zsh
# z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/docker/_docker
# z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/docker-compose/_docker-compose
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/directories.zsh
z4h source $Z4H/MichaelAquilina/zsh-auto-notify/auto-notify.plugin.zsh
eval "$(zoxide init zsh)"

# Define key bindings.
z4h bindkey z4h-forward-word    Ctrl+Space   # cd into a child directory


# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
unalias md
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
function sudo () {
    unset -f sudo
    if [[ "$(uname)" == 'Darwin' ]]
    then
        if ! command grep 'pam_tid.so' /etc/pam.d/sudo --silent
        then
            command sudo sed -i -e '1s;^;auth       sufficient     pam_tid.so\n;' /etc/pam.d/sudo
        fi
        if ! command grep '/opt/homebrew/lib/pam/pam_reattach.so' /etc/pam.d/sudo --silent
        then
            command sudo sed -i -e '1s;^;auth     optional     /opt/homebrew/lib/pam/pam_reattach.so ignore_ssh\n;' /etc/pam.d/sudo
        fi
    fi
    command sudo "$@"
}
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
# alias ls="${aliases[ls]:-ls} -A"
alias ls=exa

alias v="nvim"

alias py="python3"
alias _='sudo '
# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
# setopt no_auto_menu  # require an extra TAB press to open the completion menu
setopt auto_menu
setopt appendhistory                                            # Immediately append history instead of overwriting

export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3

export VISUAL=nvim
export EDITOR="$VISUAL"
