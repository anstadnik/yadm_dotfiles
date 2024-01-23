git config --global url."https://github.com/".insteadOf 'git@github.com:'
yadm submodule update --init --recursive
git config --global user.email "stadnikandriy1@gmail.com"
git config --global user.name "Stadnik Andrii"

sudo chsh --shell $(which fish) $USER

yes n | ssh-keygen -t ed25519 -q -N "" -f ~/.ssh/id_ed25519

nvim --headless "+Lazy! sync" +qa

fish -c "fish_add_path $HOME/.cargo/bin"
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install edc/bass

yes | topgrade -y --disable git_repos
