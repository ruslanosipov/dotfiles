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

# ------------------------------------------------------------------------------
# PROMPT
# ------------------------------------------------------------------------------

# choose current prompt type
PSTYPE=2

if [ "$PSTYPE" == 0 ]; then
    prompt='\u@\h:\w\$ '
elif [ "$PSTYPE" == 1 ]; then
    prompt='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]'
    prompt+='$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
elif [ "$PSTYPE" == 2 ]; then
    prompt='\[\033[01;34m\] \w\[\033[01;33m\]'
    prompt+='$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
fi

PS1=$prompt
