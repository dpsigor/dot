# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# --------------- prompt -------------------
__PS1_BUILD() {
  local EXIT="$?"
  PS1=""
  local RCol='\[\e[0m\]'
  local Red='\[\e[0;31m\]'
  local Gre='\[\e[0;32m\]'
  local Yel='\[\e[0;33m\]'
  local Blu='\[\e[0;34m\]'
  local __PS1_LOCATION="${Yel}\A${Blu}:${Gre}\w${RCol}"
  local __PS1_GIT_STATUS=$([[ $(git status -s 2>/dev/null | wc -l) != 0 ]] && echo -en " \e[1;33;44m" || echo -en " \e[39;44m")
  local __PS1_GIT_BRANCH=$(git branch 2>/dev/null | grep \* | { read tmpv; [[ -n $tmpv ]] && echo " ${tmpv##* } \e[0m" || echo "\e[0m"; })
  local __PS1_AFTER="†"
  PS1+="$__PS1_LOCATION$__PS1_GIT_STATUS$__PS1_GIT_BRANCH"
  [[ $EXIT != 0 ]] && PS1+=" ${Red}$EXIT${RCol} " || :
  PS1+="\n${Yel}$__PS1_AFTER${RCol} "
}
PROMPT_COMMAND=__PS1_BUILD

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.config/ls/dircolors && eval "$(dircolors -b ~/.config/ls/dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias vi=nvim

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias c=clear
alias b=batcat
alias ?=ddgr
alias top=htop
alias k=kubectl
complete -F __start_kubectl k
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias g='git status'
alias yd='npm run dev'
alias ya='npm run start:api'
alias ys='npm run start'
alias yb='npm run build'
alias npmscripts='jq .scripts package.json'
alias ascii='man ascii | grep -m 1 -A 88 --color=never Oct | grep -P -v "Tables|For|^\s*$"'
alias lessf='less -F'
alias prw='gh pr view -w'
alias sumatra='/mnt/c/Users/dpsig/Área\ de\ Trabalho/SumatraPDF-3.4.6-64.exe'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

owncomp=(s01)
for i in ${owncomp[@]}; do complete -C $i $i; done

export GITUSER="$USER"
export MAIN_REPOS_PATH="$HOME/repos/github.com/$GITUSER"
export DOTFILES="$MAIN_REPOS_PATH/dot"
export SCRIPTS="$DOTFILES/scripts"
export EDITOR="/usr/bin/vim"
export VISUAL=vim
export PYTHONDONTWRITEBYTECODE=1
export GOBIN=/usr/local/go/bin
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

updateScripts() {
  if [[ -d $SCRIPTS ]]; then
    myscripts="$(ls $SCRIPTS)"
    for myscript in $myscripts; do
      if [ ! -f /usr/sbin/$myscript ]; then
        sudo ln -s $SCRIPTS/$myscript  /usr/sbin/$myscript
        echo "ln -s em /usr/sbin seu $myscript"
      fi
    done
  fi
}

cdp() {
  TEMP_PWD=`pwd`
  while ! [[ -d .git ]]; do
    [[ $HOME = `pwd` ]] && break
    cd ..
  done
  OLDPWD=$TEMP_PWD
}

now() {
  printf "\e[34m      \n"; date '+%H : %M : %S' | figlet -c; printf "\n\e[32m"; cal -A 1 -B 1; printf "\e[0m\n"
}

if [ -f ~/.config/.secrets/envsecrets ]; then
  . ~/.config/.secrets/envsecrets
fi

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/zig
export PATH="/home/dpsigor/.ebcli-virtual-env/executables:$PATH"
export PATH="/home/dpsigor/.node-v16.11.1-linux-x64/bin:$PATH"
export PATH="/opt/nvim-linux64/bin:$PATH"
bind '"\t":menu-complete'
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export DENO_INSTALL="/home/dpsigor/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export CDPATH=".:$MAIN_REPOS_PATH"

# Para disable ctrl+s e ctrl+q padrao do terminal
stty -ixon

# Cores em man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export PAGER="less"
# export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

set -o vi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function acrpurge {
  registryName=$1
  repositoryName=$2
  timestamp=$3
  timestampLen=${#timestamp}
  [[ -z "$registryName" ]] && echo "usage: registryName repositoryName timestamp" && return || :
  [[ -z "$repositoryName" ]] && echo "usage: registryName repositoryName timestamp" && return || :
  [[ -z "$timestamp" ]] && echo "usage: registryName repositoryName timestamp" && return || :
  [[ "$timestampLen" -ne 10 ]] && echo "invalid timestamp" && return || :
  az acr manifest list-metadata --registry $registryName --name $repositoryName --query "[?createdTime < '$timestamp'].tags[]" | \
  jq .[] | sed 's/"//g' | while read line; do
    az acr manifest delete --registry $registryName --name $repositoryName:"$line" --yes;
  done
}

function acrlist {
  [[ -z "$1" ]] && echo "usage: registryName repositoryName" && return || :
  [[ -z "$2" ]] && echo "usage: registryName repositoryName" && return || :
  az acr manifest list-metadata --registry $1 --name $2 --orderby time_asc --query "[].createdTime" | jq .[]
}

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
