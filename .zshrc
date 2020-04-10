export PATH=/home/chanbakjsd/Projects/v:$PATH
export ZSH="/home/chanbakjsd/.config/oh-my-zsh"
export EDITOR=vim

alias vimwiki="vim ~/Projects/vimwiki/index.md"

ZSH_THEME="agnoster"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
