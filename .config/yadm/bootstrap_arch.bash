sudo pacman -Sy --noconfirm --needed base-devel rustup
rustup default stable
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm

cd ..
rm -rf .cache paru

paru -Sy --noconfirm rustup
rustup default stable

paru -Sy --noconfirm git neofetch neovim tmux curl fd htop fish zoxide bat pyright rust-analyzer openssh python unzip npm topgrade yazi lsd macchina thefuck

if [[ "$(command -v gnome-shell)" ]]; then
    paru -Sy --noconfirm gnome-tweaks gnome-shell-extension-installer colloid-icon-theme-git colloid-gtk-theme-git phinger-cursors google-chrome kitty nerd-fonts-jetbrains-mono gnome-browser-connector telegram-desktop
    gnome-shell-extension-installer --yes 19 307 3193

    gsettings set org.gnome.desktop.background picture-uri-dark file:///home/astadnik/Pictures/watchtower.jpg
    gsettings set org.gnome.desktop.background picture-uri file:///home/astadnik/Pictures/watchtower.jpg
fi

run_in_background paru -Scc
sudo sh -c 'yes | pacman -Scc'
