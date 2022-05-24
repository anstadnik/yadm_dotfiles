# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files source by it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# export TERM=xterm-kitty

# Kitty integration :)
# zstyle ':z4h:' iterm2-integration yes

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
zstyle ':z4h:' auto-update      'ask'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Automaticaly wrap TTY with a transparent tmux ('integrated'), or start a
# full-fledged tmux ('system'), or disable features that require tmux ('no').
zstyle ':z4h:' start-tmux       'integrated'
# zstyle ':z4h:' start-tmux       'no'
# Move prompt to the bottom when zsh starts up so that it's always in the
# same position. Has no effect if start-tmux is 'no'.
zstyle ':z4h:' prompt-at-bottom 'yes'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'

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
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over ssh to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

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
path=(/opt/cisco/anyconnect/bin/ /usr/bin ~/.cargo/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/git.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/extract/extract.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/git/git.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/virtualenvwrapper/virtualenvwrapper.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/archlinux/archlinux.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/common-aliases/common-aliases.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/git-flow-avh/git-flow-avh.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/directories.zsh
z4h source $Z4H/MichaelAquilina/zsh-auto-notify/auto-notify.plugin.zsh
eval "$(zoxide init zsh)"

# fpath+=($Z4H/ohmyzsh/ohmyzsh/plugins/supervisor)


# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/  # undo the last command line change
z4h bindkey redo Alt+/   # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

z4h bindkey z4h-forward-word    Ctrl+Space   # cd into a child directory

bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
unalias md
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
# Usage: codi [filetype]
codi() {
	local syntax="${1:-python}"
	nvim -c \
		"let g:startify_disable_at_vimenter = 1 |\
		set bt=nofile ls=0 noru nonu nornu |\
		hi ColorColumn guibg=bg |\
		hi VertSplit guifg=bg |\
		hi NonText guifg=bg |\
		Codi $syntax"
	}
sp() {
	~/.virtualenvs/repl/bin/ipython -i -c "__import__('sympy').init_session(use_unicode=True, auto_symbols=True, auto_int_to_Integer=True)"
}
compdef _directories md
# ALT-I - Paste the selected entry from locate output into the command line
fzf-locate-widget() {
  local selected
  if selected=$(locate / | fzf -q "$LBUFFER" --preview 'bat --style=numbers --color=always --line-range :500 {}'); then
    LBUFFER=$selected
  fi
  zle redisplay
}
zle     -N    fzf-locate-widget
bindkey '\ei' fzf-locate-widget

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias tree='exa --tree --long'

# Arch Linux command-not-found support, you must have package pkgfile installed
# https://wiki.archlinux.org/index.php/Pkgfile#.22Command_not_found.22_hook
[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Advanced command-not-found hook
[[ -e /usr/share/doc/find-the-command/ftc.zsh ]] && source /usr/share/doc/find-the-command/ftc.zsh

# Add flags to existing aliases.
# alias ls="${aliases[ls]:-ls} -A"

alias v="nvim"

alias py="python3"
alias _='sudo '
# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# # Changing/making/removing directory
setopt correct                                                  # Auto correct mistakes
# setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
# setopt nocaseglob                                               # Case insensitive globbing
# setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
# setopt numericglobsort                                          # Sort filenames numerically when it makes sense
# setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
# setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
# setopt autocd                                                   # if only directory path is entered, cd there.
# setopt auto_pushd
# setopt pushd_ignore_dups
# setopt pushdminus

unset KITTY_SHELL_INTEGRATION

export LESS='-iRXMx4'

export EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/google-chrome-stable
# export TERM=kitty
export TERMINAL=kitty
export MAIL=geary
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel {$_JAVA_OPTIONS}"

## Run neofetch
# neofetch
