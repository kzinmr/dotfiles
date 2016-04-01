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

[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

# editor
export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient


# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
# enable shims and autocompletion
eval eval "$(pyenv init -)"

# enable auto-activation of virtualenvs
eval "$(pyenv virtualenv-init -)"

# Java
export PATH=$HOME/eclipse:$PATH

# Go
export PATH=/opt/go/bin:$PATH
export GOPATH=$HOME/.go


# cpanm
export PATH=$HOME/local/lib/perl/bin/:$PATH
export PERL_CPANM_OPT="--local-lib=$HOME/local/lib/perl"
export PERL_MM_OPT="$HOME/local/lib/perl"
export PERL_MB_OPT="$HOME/local/lib/perl"
export PERL5LIB=$HOME/local/lib/perl/lib/perl5/:$PERL5LIB

export PERL5LIB=$HOME/workspace/pm/kawahara-pm/perl:$HOME/workspace/pm/Utils/perl:$PERL5LIB


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export DATABASE_URL=postgres:///$(whoami)

export SRILM=$HOME/workspace/srilm
export PATH=$SRILM/bin/i686-m64:$SRILM/bin:$PATH
export MANPATH=$SRILM/man:$MANPATH
export RNNLM=$HOME/workspace/rnnlm
