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
#zplug "yous/lime"
#export LIME_DIR_DISPLAY_COMPONENTS=2

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
PYTHON_DIST_DIR="${HOME}/.local/lib/python3.6/site-packages"
source "${PYTHON_DIST_DIR}/powerline/bindings/zsh/powerline.zsh"
# Powerlevel9k Theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# For minikube
function minikube-docker-env(){
  eval $(minikube docker-env)
  export DOCKER_MACHINE_NAME="minikube"
}
function minikube-docker-env-u(){
  eval $(minikube docker-env -u)
  unset DOCKER_MACHINE_NAME
}

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs root_indicator background_jobs ram disk_usage time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir command_execution_time anaconda docker_machine rbenv ssh)
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

# Add color to ls command
export CLICOLOR=1

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

GCSDK=/Users/a14673/google-cloud-sdk
# The next line updates PATH for the Google Cloud SDK.
if [ -f "${GCSDK}/path.zsh.inc" ]; then source "${GCSDK}/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${GCSDK}/completion.zsh.inc" ]; then source "${GCSDK}/completion.zsh.inc"; fi

alias k=kubectl

function gch() {
    if [[ -z "$1" ]]; then
        echo "need env"
        exit 1
    fi
    source activate py2
    if [[ "$1" = "prod" ]]; then
        gcloud config configurations activate swallow-prod
    elif [[ "$1" != "local" ]]; then
        gcloud config configurations activate swallow
    fi
    if [[ "$1" = "local" ]]; then
        kubectl config use-context minikube
    else
        env="$1"
        gcloud container clusters get-credentials ${env}-cluster
    fi
}

alias gch-check='cat ~/.kube/config|grep current-context'
