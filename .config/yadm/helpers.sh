run_in_background() {
	if [[ $GUI -eq 1 && -x $(command -v kitty) ]]; then
		kitty $@ &
	else
		$@ &
	fi
}

install_gnome_extension_ubuntu() {
	cd /tmp
	wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
	chmod +x gnome-shell-extension-installer
	./gnome-shell-extension-installer 19 307 3193
}

install_theme_ubuntu() {
	if [[ ! -d ~/.themes ]]; then
		cd /tmp
		git clone https://github.com/vinceliuice/Colloid-icon-theme
		cd Colloid-icon-theme/
		./install.sh -s nord
	fi

}

install_icons_ubuntu() {
	if [[ ! -d ~/.icons ]]; then
		cd /tmp
		git clone https://github.com/vinceliuice/Colloid-gtk-theme
		cd Colloid-gtk-theme/
		./install.sh --tweaks nord
	fi
}

install_fonst_ubuntu() {
	if [[ ! -d ~/.fonts ]]; then
		cd /tmp
		curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
		unar JetBrainsMono.zip
		rm -rf ~/.fonts
		mkdir ~/.fonts
		mv /tmp/JetBrainsMono/*.ttf ~/.fonts/
		fc-cache -fv
	fi
}

install_cursors_ubuntu() {
	cd /tmp
	wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C ~/.icons
}

install_chrome_ubuntu() {
	cd /tmp
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb
	rm -rf ./google-chrome-stable_current_amd64.deb
}

install_rustup_ubuntu() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	/home/astadnik/.cargo/bin/rustup default stable
}

install_gnome_deps_arch() {
	yay -Sy --noconfirm --answerdiff=None gnome-tweaks gnome-shell-extension-installer colloid-icon-theme-git colloid-gtk-theme-git phinger-cursors google-chrome kitty nerd-fonts-jetbrains-mono
}