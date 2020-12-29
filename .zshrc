# If you come from bash you might have to change your $PATH
export PATH=$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


ZSH_THEME="sunrise"

ZSH_DISABLE_COMPFIX="true"

"~/.zshrc" 145L, 5992C

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow web-search osx sudo common-aliases zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

source $HOME/.aliases
