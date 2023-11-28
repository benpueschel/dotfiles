# install homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install packages formulae
brew install wget
brew install git
brew install docker
brew install colima
brew install tmux
brew install neovim
brew install ripgrep

# install packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim 

# install zsh extensions
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# clone git repo to ~/dotfiles and copy contents to HOME directory
git clone --recursive https://github.com/benpueschel/dotfiles.git ~/dotfiles && cd ~/dotfiles
sh copy-dotfiles.sh

# install casks
brew install cask git-credential-manager-core
brew install cask iterm2
brew install cask spectacle
brew install cask firefox-developer-edition
brew install cask alfred
brew install cask spotify
