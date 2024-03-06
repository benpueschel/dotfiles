export ZSH_TMUX_AUTOSTART="true"

# complete sudo commands
# WARNING: This will let Zsh completion scripts run commands with sudo 
# privileges. You should not enable this if you use untrusted autocompletion 
# scripts.
zstyle ':completion::complete:*' gain-privileges 1

# Sets color variable such as $fg, $bg, $color and $reset_color
autoload -U colors && colors
autoload -U promptinit && promptinit

# Expand variables and commands in PROMPT variables
setopt prompt_subst

# adds utility functions for themes
source "$HOME/.config/zsh/themes/util.zsh"
fpath=($HOME/.config/zsh/themes/util.zsh $fpath)
# load our theme
source "$HOME/.config/zsh/themes/af-magic.zsh-theme"

# include our plugins, all of which are in "~/.config/zsh/plugins"
plugins=(sudo zsh-autosuggestions)

# source all of our plugins and add them to the fpath
for plugin ($plugins); do
	plugin_dir="$HOME/.config/zsh/plugins/$plugin"
	source "$plugin_dir/$plugin.plugin.zsh"
	fpath=($plugin_dir $fpath)
done

# command completion
autoload -Uz compinit && compinit

# plugins=(copyfile copybuffer dirhistory zsh-autosuggestions tmux)

alias ls='ls --color=auto'

alias -g ...='../..'

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

export PATH="$PATH:$HOME/.local/scripts"
