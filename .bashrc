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
function ps1_git_status {
  MODIFIED=$(git status -s 2> /dev/null | wc -l)
  if [ $MODIFIED != 0 ]; then
    echo -en "\e[1;33;44m"
  else
    echo -en "\e[39;44m"
  fi
}

__PS1_LOCATION='\[\e[39;43m\]\w '
__PS1_GIT_STATUS='$(ps1_git_status)'
__PS1_GIT_BRANCH='$(git branch 2>/dev/null | grep \* | { read tmpv; echo " ${tmpv##* } "; })'
__PS1_AFTER='\[\e[0m\] † '
export PS1="${__PS1_LOCATION}\[${__PS1_GIT_STATUS}\]${__PS1_GIT_BRANCH}${__PS1_AFTER}"

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
alias vim=vi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias c=clear
alias ?=duck
alias top=htop
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias g='git status'
alias yd='yarn dev'
alias ya='yarn start:api'
alias ys='yarn start'
alias yb='yarn build'
alias ascii='man ascii | grep -m 1 -A 88 --color=never Oct | grep -P -v "Tables|For|^\s*$"'

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

if [ -f ~/.config/.secrets/envsecrets ]; then
  . ~/.config/.secrets/envsecrets
fi

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin
export PATH="/home/dpsigor/.ebcli-virtual-env/executables:$PATH"
export PATH="/home/dpsigor/.node-v16.11.1-linux-x64/bin:$PATH"
bind '"\t":menu-complete'

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

set -o vi
