# colors
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

# locale
export LANG=ja_JP.UTF-8

# editor
export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient

# Go
if command -v go &> /dev/null; then
  [ -d "$HOME/go" ] || mkdir "$HOME/go"
  export GOPATH="$HOME/.go"
  export GOROOT=/usr/local/opt/go/libexec
  export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"
fi

# Load rbenv
if [ -e "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - zsh)"
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"


export PATH=/usr/local/bin:$PATH
#export PATH=$HOME/activator/bin:$PATH

export PATH="$HOME/miniconda3/bin:$PATH"
alias julia="/Applications/Julia-0.5.app/Contents/Resources/julia/bin/julia"

export PATH=$HOME/google-cloud-sdk/bin:$PATH

export PATH=$HOME/llvm-3.7.1/build/bin:$PATH
export LLVM_CONFIG=$HOME/llvm-3.7.1/build/bin/llvm-config

export PATH=$HOME/.local/bin:$PATH

export PATH=$HOME/.opam/system/bin:$PATH
