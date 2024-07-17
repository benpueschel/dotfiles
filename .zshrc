# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set zinit theme and plugin directory
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download Zinit if it's not already installed
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "$ZINIT_HOME/zinit.zsh"

# Add Powerlevel10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# configure zsh-vi-mode. Needs to be set before sourcing zsh-vi-mode
function zvm_config() {
	ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
	ZVM_INIT_MODE=sourcing
}

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light jeffreytse/zsh-vi-mode

# Load completions
autoload -U compinit && compinit

# complete sudo commands
# WARNING: This will let Zsh completion scripts run commands with sudo
# privileges. You should not enable this if you use untrusted autocompletion
# scripts.
zstyle ':completion::complete:*' gain-privileges 1

# vi mode
bindkey -v

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '^y' autosuggest-execute

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Shell integrations
# eval fzf if installed
if command -v fzf &> /dev/null; then
	eval "$(fzf --zsh)"
fi

# Aliases

alias -g ...='../..'
alias ls='ls -A --color=auto'

# The superior text editor
export EDITOR='nvim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

export PATH="$PATH:$HOME/.local/scripts:$HOME/.cargo/bin"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
