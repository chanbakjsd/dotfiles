export EDITOR=vim
export PATH=/home/chanbakjsd/Projects/v:$PATH
export ZSH="/home/chanbakjsd/.config/oh-my-zsh"
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$HOST-$ZSH_VERSION"

alias vim="nvim"
alias vimwiki="vim ~/Projects/vimwiki/index.md"

ZSH_THEME="agnoster"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
