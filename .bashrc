# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ------------------------------------------------------------------------------
# INCLUDES
# ------------------------------------------------------------------------------

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f ~/.git_prompt.sh ]; then
    . ~/.git_prompt.sh
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

##
# Set current prompt style
#
# Available styles to pick from:
# 0 "user@host:dir$ ", no color
# 1 "user@host dir (git branch) $ ", colorful and bold
# 2 " dir (git branch) $ ", colorful and bold
#
# @param [int] prompt style ID (0-2)
set_prompt() {
    [[ -z "$1" ]] && printf "Usage: set_prompt [ID]\n" && return 10
    if [ "$1" == 0 ]; then
        prompt='\u@\h:\w\$ '
    elif [ "$1" == 1 ]; then
        prompt='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]'
        prompt+='$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
    elif [ "$1" == 2 ]; then
        prompt='\[\033[01;34m\] \w\[\033[01;33m\]'
        prompt+='$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
    fi

    PS1=$prompt
}

# ------------------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
# ------------------------------------------------------------------------------

# history settings
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
HISTFILESIZE=20000

# shell opts
shopt -s histappend
shopt -s checkwinsize

# more colors in aterminal
export TERM='xterm-256color'

# text editor
export EDITOR=vim

# put ~/bin on PATH if it exists
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

# ------------------------------------------------------------------------------
# PROMPT
# ------------------------------------------------------------------------------

# choose current prompt style (see set_prompt for details)
set_prompt 2
