command_exists() {
  [[ -x $(command -v $1) ]]
}

run_in_background() {
  if [[ command_exists gnome-shell && command_exists kitty ]]; then
		kitty bash -c $@ &
	else
		$@ &
	fi
}


# export -f install_gnome_extension_ubuntu install_theme_ubuntu install_icons_ubuntu install_fonts_ubuntu install_rustup_ubuntu
