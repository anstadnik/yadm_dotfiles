# Only run interactive goodies for interactive shells
if status is-interactive
    # ---------- PATHs ----------
    # macOS Homebrew (only if present)
    if test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    end
    # User-local bin (Linux/macOS)
    if test -d "$HOME/.local/bin"
        fish_add_path "$HOME/.local/bin"
    end

    # ---------- Prompt / tools (guarded) ----------
    set -g fish_greeting

    if type -q starship
        starship init fish | source
    end

    # Google Cloud SDK via Homebrew (macOS only, guarded)
    if type -q brew
        set -l gcloud_inc (brew --prefix)/share/google-cloud-sdk/path.fish.inc
        if test -f "$gcloud_inc"
            source "$gcloud_inc"
        end
    end

    if type -q zoxide
        zoxide init fish | source
    end

    # fzf keybindings (only if provided by your setup)
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --directory=\cf
    end

    # ---------- Editors ----------
    set -x VISUAL nvim
    set -x EDITOR $VISUAL

    # # ---------- XDG base dirs ----------
    # set -q XDG_DATA_HOME  || set -Ux XDG_DATA_HOME  $HOME/.local/share
    # set -q XDG_CONFIG_HOME|| set -Ux XDG_CONFIG_HOME$HOME/.config
    # set -q XDG_STATE_HOME || set -Ux XDG_STATE_HOME $HOME/.local/state
    # set -q XDG_CACHE_HOME || set -Ux XDG_CACHE_HOME $HOME/.cache
    #
    # # ---------- Dev envs ----------
    # set -x ANDROID_HOME "$XDG_DATA_HOME/android"
    # set -x RUSTUP_HOME  "$XDG_DATA_HOME/rustup"
    # set -x WORKON_HOME  "$XDG_DATA_HOME/virtualenvs"
    # set -x DOT_SAGE     "$XDG_CONFIG_HOME/sage"

    # ---------- Helpers / Abbrs ----------
    bind ctrl-space forward-word
    abbr -a ls lsd
    abbr -a v nvim
    abbr -a -p anywhere G "| grep"
    abbr -a -p anywhere L "| less"
    abbr -a cope gh copilot explain
    abbr -a cops gh copilot suggest

    # yazi-aware cd helper (prints a hint if yazi isn't installed)
    function ya
        if not type -q yazi
            echo "yazi is not installed." >&2
            return 127
        end
        set tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
            cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # Pretty sysinfo if available
    if type -q macchina
        macchina
    end
end

# ---------- Micromamba / Mamba (guarded, works on macOS & Linux) ----------
# Prefer micromamba if present
if type -q micromamba
    set -gx MAMBA_ROOT_PREFIX "$HOME/mamba"
    micromamba shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
else if test -x /opt/homebrew/opt/micromamba/bin/mamba
    # Homebrew micromamba on macOS (legacy path in your old config)
    set -gx MAMBA_EXE "/opt/homebrew/opt/micromamba/bin/mamba"
    set -gx MAMBA_ROOT_PREFIX "$HOME/mamba"
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
else if type -q mamba
    # If plain mamba is installed
    set -gx MAMBA_ROOT_PREFIX "$HOME/mamba"
    mamba shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
end

# ---------- Optional: LM Studio CLI path (guarded) ----------
if test -d "$HOME/.lmstudio/bin"
    fish_add_path "$HOME/.lmstudio/bin"
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/astadnik/.lmstudio/bin
# End of LM Studio CLI section

if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end
