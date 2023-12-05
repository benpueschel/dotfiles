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

######################
####### DOCKER #######
######################

# remove all conflicting packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# get docker GPG key
sudo apt install -y ca-certificates gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y

sudo apt install -y docker-ce docker-ce-cli containerd.io

# add current use to docker usergroup
sudo usermod -aG docker ${USER}
# apply usermod by relogging
su - ${USER}
