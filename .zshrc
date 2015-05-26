# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 
#setopt histignorealldups sharehistory

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

# Use modern completion system(compsys)
autoload -Uz compinit
compinit

setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt nolistbeep

# setopt predict-on
# predict-on

zstyle ':completion:*' verbose true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
# color
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


case "${TERM}" in
    kterm*|xterm*)
	export LSCOLORS=exfxcxdxbxegedabagacad
	export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
	;;
    cons25)
	unset LANG
	export LSCOLORS=ExFxCxdxBxegedabagacad
	export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
	;;
esac
export LANG=ja_JP.UTF-8

[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

#aliases
alias where="command -v"
alias j="jobs -l"

alias ls="ls -G --color=auto"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias -g gp='| grep -i'
alias -s log="less -MN"

# for tmux in ubuntu
# sudo apt-get install xsel
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias tmux-copy='tmux save-buffer - | pbcopy'

# OPAM configuration
. /home/inamura/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#virtualenv python
export PIP_DOWNLOAD_CACHE=$HOME/.pip
export PIP_SRC=$PIP_DOWNLOAD_CACHE
export PIP_RESPECT_VIRTUALENV=true

#for server setting
export PATH=/share/usr-x86_64/bin:$PATH
export LD_RUN_PATH=/share/usr-x86_64/lib:/share/usr-x86_64/lib64
ulimit -m 10000000
ulimit -v 10000000


function fxg() {
  find -name "$1" -print |xargs grep -inH "$2"
}

#alias agi="sudo apt-get install"

#export PATH=/home/inamura/anaconda/bin:$PATH

export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient
alias e='emacsclient -nw -a ""'
alias emacs='emacsclient -nw -a ""'

alias clang-format='clang-format-3.6'

