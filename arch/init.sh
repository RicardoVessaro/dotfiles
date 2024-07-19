#!/bin/bash

#------------------------------------------------------------
# FUNCTIONS
#------------------------------------------------------------

has_command() {
	command -v "$1" >/dev/null 2>&1
}

is_nvidia() {
	lspci | grep -I "NVIDIA" >/dev/null 2>&1
}

#------------------------------------------------------------
# YAY
#------------------------------------------------------------

URL_PIKAUR="https://aur.archlinux.org/pikaur.git"

if ! has_command pikaur; then
	cd $(mktemp -d) && sudo pacman -S --needed base-devel git && git clone $URL_PIKAUR && cd pikaur && makepkg -fsri && cd $HOME
fi

pikaur -S --needed \
	helix fd xclip bat fish ripgrep exa base-devel zip less git clang \
	cuda-tools tmux tmux-plugin-manager cmake llvm v4l-utils bottom \
	vivaldi alacritty lightdm-gtk-greeter-settings tk tree \
	qalculate-gtk neovim neovide virt-manager pavucontrol unrar unzip \
	ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-cascadia-code-nerd \
	ttf-droid ttf-monaco ttf-fira-sans ttf-liberation noto-fonts \
	noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nordvpn-bin \
	docker docker-compose papirus-icon-theme bluez bluez-utils \
	qemu-full dnsmasq

if has_command bluetoothctl; then
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service
fi

if is_nvidia; then
	sudo pacman -S --needed --noconfirm nvidia nvidia-utils && sudo mkinitcpio -p linux
fi

if has_command nvidia-xconfig; then
	sudo mkinitcpio -p linux
fi

if has_command nordvpn; then
	sudo groupadd -r nordvpn
	sudo gpasswd -a $USER nordvpn
	sudo usermod -aG nordvpn $USER
	sudo systemctl enable nordvpnd
fi

if has_command docker; then
	sudo usermod -aG docker $USER
	sudo systemctl enable docker.service docker.socket
fi

if has_command virt-manager; then
	sudo usermod -aG libvirt $USER
	sudo virsh net-start default
	sudo systemctl enable libvirtd
	sudo systemctl start libvirtd
fi

#------------------------------------------------------------
# OH MY FISH
#------------------------------------------------------------

URL_OMF="https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install"

if ! has_command omf; then
	curl -Lfs $URL_OMF | fish -c "source - --noninteractive --yes" &&
		fish -c "omf install sdk nvm pure ghcup rustup"
fi

#------------------------------------------------------------
# VERSION MANAGER
#------------------------------------------------------------

URL_GHCUP="https://get-ghcup.haskell.org"
URL_RUSTUP="https://sh.rustup.rs"
URL_SDKMAN="https://get.sdkman.io"
URL_NVM="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh"

curl -Lfs $URL_GHCUP | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
	BOOTSTRAP_HASKELL_ADJUST_BASHRC=1 \
	BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
	bash
curl -Lfs $URL_RUSTUP | bash -s -- -y
curl -Lfs $URL_SDKMAN | bash
curl -Lfs $URL_NVM | bash

#------------------------------------------------------------
# FISH CONFIG
#------------------------------------------------------------

# SHELL VARIABLES

if is_nvidia; then
    echo "$(
        cat <<-EOF
            set -Ux LD_LIBRARY_PATH /opt/cuda/lib64
        EOF
    )" | fish -c "source -"
fi

# SHELL PATH

if is_nvidia; then
    echo "$(
        cat <<-EOF
            fish_add_path /opt/cuda/bin
        EOF
    )" | fish -c "source -"
fi

# KORA

mkdir -p $HOME/.local/bin

echo "$(
	cat <<-EOF
		#!/bin/sh

		rm -rf ~/.bash_history
		rm -rf ~/.lesshst
		rm -rf ~/.profile
		rm -rf ~/.python_history
	EOF
)" >$HOME/.local/bin/kora

echo "$(
	cat <<-EOF
		fish_add_path $HOME/.local/bin
	EOF
)" | fish -c "source -"

chmod +x $HOME/.local/bin/*

# ALIASES

echo "$(
	cat <<-EOF
		alias -s b   "bat"
		alias -s c   "builtin history clear && history -c && kora && printf '\033[2J\033[3J\033[1;1H'"
		alias -s l   "exa"
		alias -s la  "exa -a"
		alias -s ll  "exa -l"
		alias -s lla "exa -la"
		alias -s r   "rm -r"
		alias -s rf  "rm -rf"
		alias -s hx  "helix"
	EOF
)" | fish -c "source -"

# FISH COLORS

echo "$(
	cat <<-EOF
		set -U fish_color_autosuggestion brblack
		set -U fish_color_cancel -r
		set -U fish_color_command brgreen
		set -U fish_color_comment brmagenta
		set -U fish_color_cwd green
		set -U fish_color_cwd_root red
		set -U fish_color_end brmagenta
		set -U fish_color_error brred
		set -U fish_color_escape brcyan
		set -U fish_color_history_current --bold
		set -U fish_color_host normal
		set -U fish_color_match --background=brblue
		set -U fish_color_normal normal
		set -U fish_color_operator cyan
		set -U fish_color_param brblue
		set -U fish_color_quote yellow
		set -U fish_color_redirection bryellow
		set -U fish_color_search_match bryellow --background=brblack
		set -U fish_color_selection white --bold --background=brblack
		set -U fish_color_status red
		set -U fish_color_user brgreen
		set -U fish_color_valid_path --underline
		set -U fish_pager_color_completion normal
		set -U fish_pager_color_description yellow
		set -U fish_pager_color_prefix white --bold --underline
		set -U fish_pager_color_progress brwhite --background=cyan
	EOF
)" | fish -c "source -"

#------------------------------------------------------------
# CREATE CONFIG FOLDERS
#------------------------------------------------------------

ln -s $HOME/Projects/dotfiles/tmux $HOME/.config/tmux
ln -s $HOME/Projects/dotfiles/nvim $HOME/.config/nvim
ln -s $HOME/Projects/dotfiles/helix $HOME/.config/helix
ln -s $HOME/Projects/dotfiles/bottom $HOME/.config/bottom
ln -s $HOME/Projects/dotfiles/bat $HOME/.config/bat
ln -s $HOME/Projects/dotfiles/alacritty $HOME/.config/alacritty
