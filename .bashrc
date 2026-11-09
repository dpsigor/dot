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
  local __PS1_GIT_STATUS=$([[ $(($(git status -s 2>/dev/null | wc -l))) != 0 ]] && echo -en " \e[1;33;44m" || echo -en " \e[39;44m")
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
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export CLICOLOR=1

alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias vi=nvim

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias c=clear
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
  elif [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
    . /opt/homebrew/etc/profile.d/bash_completion.sh
  fi
  if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
  fi
fi

#owncomp=(s01)
#for i in ${owncomp[@]}; do complete -C $i $i; done

export GITUSER="$USER"
export MAIN_REPOS_PATH="$HOME/repos/github.com/$GITUSER"
export DOTFILES="$MAIN_REPOS_PATH/dot"
# export SCRIPTS="$DOTFILES/scripts"
# export EDITOR="/usr/bin/vim"
export VISUAL=vim
export PYTHONDONTWRITEBYTECODE=1
# export GOBIN=/usr/local/go/bin
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG=en_US.UTF-8

if [ -f ~/.config/.secrets/envsecrets ]; then
  . ~/.config/.secrets/envsecrets
fi

# export PATH=$PATH:/usr/local/go/bin
export PATH=~/.local/bin:$PATH
# export PATH=$PATH:~/go/bin
export PATH="/opt/nvim-macos-arm64/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # does not have column, nor grep
export PATH="/opt/homebrew/opt/util-linux/bin:$PATH"
export PATH="/opt/homebrew/opt/util-linux/sbin:$PATH"
bind '"\t":menu-complete'

export CDPATH=".:$MAIN_REPOS_PATH"

export DISCERN_REPOS_PATH="$HOME/repos/github.com/discernhq"
export CDPATH="$CDPATH:$DISCERN_REPOS_PATH"

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
bind 'set bell-style none'

eval "$(fzf --bash)"

# . "$HOME/.asdf/asdf.sh"
# . "$HOME/.asdf/completions/asdf.bash"

[ -f ~/.config/.secrets/secrets.bash ] && source ~/.config/.secrets/secrets.bash

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

function bbr {
  but status --json | jq -r '.stacks[].branches[] | "\u001b[0m\u001b[1m\(.cliId) \u001b[0m\u001b[36m\(.name)"'
}

function bpr {
  if [[ ! $1 =~ ^[a-zA-Z]{2}$ ]]; then
    echo "Usage: bpr <branch-cliId>"
    return 1
  fi
  but pr new "$1"
}

function bshow {
  if [[ ! $1 =~ ^[a-zA-Z]{2}$ ]]; then
    echo "Usage: bshow <branch-cliId>"
    return 1
  fi
  but show "$1" --json | jq -r '.commits[].files[] | select(.status != "deleted") | .path' | sort -u
}

function bstat {
  if [[ ! $1 =~ ^[a-zA-Z]{2}$ ]]; then
    echo "Usage: bstat <branch-cliId>"
    return 1
  fi
  but show "$1" --json | jq -r '.commits[] | "\u001b[1;34m\(.files_changed)f\u001b[0m  \u001b[1;32m+\(.insertions)\u001b[0m  \u001b[1;31m-\(.deletions)\u001b[0m  \(.message)"'
}

function b {
  but tui
}

function npxprettier {
  if [[ ! $1 =~ ^[a-zA-Z]{2}$ ]]; then
    echo "Usage: npxprettier <branch-cliId>"
    return 1
  fi
  bshow "$1" | grep -v '\.go$' | xargs npx prettier -w
}
