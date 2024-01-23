VERSION=$(cut -f2 <<<$(lsb_release -r))
export DEBIAN_FRONTEND=noninteractive

# sudo apt install -y software-properties-common
# # sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update
sudo -E apt install -y build-essential neofetch python3-pip tmux curl fd-find telegram-desktop htop systemd-coredump fish bat unar neovim unzip nodejs thefuck

if [[ "$VERSION" =~ ^(22.04|22.10)$ ]]; then
    sudo apt install -y zoxide
fi

install_rustup_ubuntu
export PATH="$HOME/.cargo/bin:$PATH"
cargo install macchina yazi-fm topgrade lsd starship
yes | "${SHELL}" <(curl -L https://micro.mamba.pm/install.sh)

if [[ "$(command -v gnome-shell)" ]]; then
    sudo -E apt install -y kitty gnome-tweaks chrome-gnome-shell gtk2-engines-murrine gnome-themes-extra sassc

    run_in_background "source $HOME/.config/yadm/helpers/helpers.bash && source $HOME/.config/yadm/helpers/ubuntu.bash && install_gnome_extension_ubuntu"
    run_in_background "source $HOME/.config/yadm/helpers/helpers.bash && source $HOME/.config/yadm/helpers/ubuntu.bash && install_theme_ubuntu"
    run_in_background "source $HOME/.config/yadm/helpers/helpers.bash && source $HOME/.config/yadm/helpers/ubuntu.bash && install_icons_ubuntu"
    run_in_background "source $HOME/.config/yadm/helpers/helpers.bash && source $HOME/.config/yadm/helpers/ubuntu.bash && install_fonts_ubuntu"
    # run_in_background "source $HOME/.config/yadm/helpers/helpers.bash && source $HOME/.config/yadm/helpers/ubuntu.bash && install_chrome_ubuntu"

    sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty
    gsettings set org.gnome.desktop.background picture-uri-dark file://$HOME/Pictures/watchtower.jpg
    gsettings set org.gnome.desktop.background picture-uri file://$HOME/Pictures/watchtower.jpg
fi

sudo apt autoremove -y
sudo apt clean -y
