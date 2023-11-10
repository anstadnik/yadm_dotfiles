if status is-interactive
    set -g fish_greeting

    starship init fish | source
    zoxide init fish | source
    fzf_configure_bindings --directory=\cf
    export MAMBA_ROOT_PREFIX=~/micromamba
    eval "$(micromamba shell hook --shell fish)"

    export VISUAL=nvim
    export EDITOR="$VISUAL"

    abbr -a ls lsd
    abbr -a v nvim

    switch (uname)
        case Linux
            abbr -a pacupg sudo pacman -Syu
            abbr -a pacin sudo pacman -S
            abbr -a paclean sudo pacman -Sc
            abbr -a pacins sudo pacman -U
            abbr -a paclr sudo pacman -Scc
            abbr -a pacre sudo pacman -R
            abbr -a pacrem sudo pacman -Rns
            abbr -a pacrep pacman -Si
            abbr -a pacreps pacman -Ss
            abbr -a pacloc pacman -Qi
            abbr -a paclocs pacman -Qs
            abbr -a pacinsd sudo pacman -S --asdeps
            abbr -a pacmir sudo pacman -Syy
            abbr -a paclsorphans sudo pacman -Qdt
            abbr -a pacrmorphans sudo pacman -Rs $(pacman -Qtdq)
            abbr -a pacfileupg sudo pacman -Fy
            abbr -a pacfiles pacman -F
            abbr -a pacls pacman -Ql
            abbr -a pacown pacman -Qo
            abbr -a pacupd sudo pacman -Sy

            abbr -a paclean paru -Sc
            abbr -a paclr paru -Scc
            abbr -a paupg paru -Syu
            abbr -a pasu paru -Syu --noconfirm
            abbr -a pain paru -S
            abbr -a pains paru -U
            abbr -a pare paru -R
            abbr -a parem paru -Rns
            abbr -a parep paru -Si
            abbr -a pareps paru -Ss
            abbr -a paloc paru -Qi
            abbr -a palocs paru -Qs
            abbr -a palst paru -Qe
            abbr -a paorph paru -Qtd
            abbr -a painsd paru -S --asdeps
            abbr -a pamir paru -Syy
            abbr -a paupd paru -Sy
    end

    macchina
end
