install_gnome_extension_ubuntu() {
    cd /tmp
    wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
    chmod +x gnome-shell-extension-installer
    ./gnome-shell-extension-installer --yes 19 307 3193
    rm -rf ./gnome-shell-extension-installer
}

install_theme_ubuntu() {
    cd /tmp
    git clone https://github.com/vinceliuice/Colloid-gtk-theme
    cd Colloid-gtk-theme/
    ./install.sh --tweaks nord
    rm -rf /tmp/Colloid-gtk-theme
}

install_icons_ubuntu() {
    cd /tmp
    git clone https://github.com/vinceliuice/Colloid-icon-theme
    cd Colloid-icon-theme/
    ./install.sh -s nord
    rm -rf /tmp/Colloid-icon-theme
    wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C ~/.icons
}

install_font() {
    cd /tmp
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$1.zip
    unar $1.zip
    mv /tmp/$1/*.ttf ~/.fonts/
    rm -rf /tmp/$1.zip /tmp/$1
}

install_fonts_ubuntu() {
    if [[ ! -d ~/.fonts ]]; then
        mkdir ~/.fonts
        (install_font JetBrainsMono)
        (install_font NerdFontsSymbolsOnly)
        fc-cache -fv
    fi
}

install_rustup_ubuntu() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    $HOME/.cargo/bin/rustup default stable
}

# install_chrome_ubuntu ()
# {
#     cd /tmp
#     wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#     sudo apt install ./google-chrome-stable_current_amd64.deb
#     rm -rf ./google-chrome-stable_current_amd64.deb
# }
