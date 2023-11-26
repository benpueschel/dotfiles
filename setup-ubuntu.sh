#!/bin/bash

#####################
### GENERAL SETUP ###
#####################

apt update -y
apt upgrade -y

apt install curl -y
apt install wget -y
apt install tmux -y
apt install git -y
apt install ripgrep -y

#####################
######## ZSH ########
#####################

apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
chsh -s $(which zsh)

# clone git repo to ~/dotfiles and copy contents to HOME directory
git clone --recursive https://github.com/benpueschel/dotfiles.git ~/dotfiles && cd ~/dotfiles
sh copy-dotfiles.sh

######################
####### NEOVIM #######
######################

# install neovim from github
curl -L "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz" -o "nvim.tar.gz" && \
tar -x nvim.tar.gz -C /usr/local/ && \
rm nvim.tar.gz

# install packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim 

# add nvim installation to .zshrc $PATH
echo -n 'export PATH=$PATH:/usr/local/nvim-linux64/bin' >> ~/.zshrc 

