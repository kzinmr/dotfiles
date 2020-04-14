#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file


if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

# enhancd config
export ENHANCD_COMMAND=ed
export ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco

# Vanilla shell
zplug "yous/vanilli.sh"

# Additional completion definitions for Zsh
zplug "zsh-users/zsh-completions"

# Load the theme.
zplug "yous/lime"
export LIME_DIR_DISPLAY_COMPONENTS=2

# Syntax highlighting bundle. zsh-syntax-highlighting must be loaded after
# excuting compinit command and sourcing other plugins.
zplug "zsh-users/zsh-syntax-highlighting", defer:1

# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search", defer:2

# Tracks your most used directories, based on 'frecency'.
zplug "rupa/z", use:"*.sh"

# A next-generation cd command with an interactive filter
zplug "b4b4r07/enhancd", use:init.sh

# This plugin adds many useful aliases and functions.
zplug "plugins/git",   from:oh-my-zsh

# Powerline
# pip install --user git+git://github.com/Lokaltog/powerline
# See. pip show powerline-status
PYTHON_DIST_DIR="/usr/local/lib/python3.7/site-packages"
PATH=$PATH:$PYTHON_DIST_DIR
source "${PYTHON_DIST_DIR}/powerline/bindings/zsh/powerline.zsh"

# Powerlevel9k Theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs root_indicator background_jobs ram disk_usage time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir command_execution_time anaconda docker_machine rbenv ssh)

# Add color to ls command
export CLICOLOR=1
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Better history searching with arrow keys
if zplug check "zsh-users/zsh-history-substring-search"; then
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
fi

zplug "modules/prompt", from:prezto
setopt EXTENDED_GLOB


# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

# The next line enables shell command completion for awscli.
if [ -f "/usr/local/bin/aws_zsh_completer.sh" ]; then . "/usr/local/bin/aws_zsh_completer.sh"; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
if [ -f "${HOME}/.iterm2_shell_integration.zsh" ]; then . "${HOME}/.iterm2_shell_integration.zsh"; fi

source <(kubectl completion zsh)


alias pg_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias pg_stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias docekr=docker
alias lsdir="ls -l | grep '^d'"
alias diff="/usr/local/bin/grc diff"

