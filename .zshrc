export EDITOR=vim
export PATH=/home/chanbakjsd/go/bin:/home/chanbakjsd/.local/bin:$PATH
export ZSH="/home/chanbakjsd/.config/oh-my-zsh"

source /home/chanbakjsd/.config/secret.zsh
shorten() {
	curl -d"url=$1" -d"pass=$FILEHOST_PASS" https://file.teamortix.com/shorten | xclip -selection clipboard
}
up() {
	curl -F"file=@$1" -F"pass=$FILEHOST_PASS" https://file.teamortix.com/upload | xclip -selection clipboard
}

alias vf="vim ${fzf}"
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
