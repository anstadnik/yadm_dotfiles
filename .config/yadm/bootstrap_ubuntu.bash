VERSION=$(cut -f2 <<<$(lsb_release -r))
export DEBIAN_FRONTEND=noninteractive

# sudo apt install -y software-properties-common
# # sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

sudo -E apt install -y build-essential neofetch python3-pip tmux curl fd-find telegram-desktop htop systemd-coredump fish bat unar neovim unzip nodejs

if [[ "$VERSION" =~ ^(22.04|22.10)$ ]]; then
    sudo apt install -y zoxide
fi

install_rustup_ubuntu
export PATH="$HOME/.cargo/bin:$PATH"
cargo install macchina yazi-fm


(
    cd /tmp
    curl -LO https://github.com/r-darwish/topgrade/releases/latest/download/topgrade-v9.0.1-x86_64-unknown-linux-gnu.tar.gz
    tar xf topgrade-*
    sudo mv topgrade /usr/local/bin
    rm -rf topgrade-*
)

if [[ "$(command -v gnome-shell)" ]]; then
    sudo -E apt install -y kitty gnome-tweaks chrome-gnome-shell gtk2-engines-murrine gnome-themes-extra sassc

    run_in_background install_gnome_extension_ubuntu
    run_in_background install_theme_ubuntu
    run_in_background install_icons_ubuntu
    run_in_background install_fonts_ubuntu
    run_in_background install_chrome_ubuntu

    sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty
    gsettings set org.gnome.desktop.background picture-uri-dark file:///home/astadnik/Pictures/watchtower.jpg
    gsettings set org.gnome.desktop.background picture-uri file:///home/astadnik/Pictures/watchtower.jpg
fi

sudo apt autoremove -y
sudo apt clean -y
