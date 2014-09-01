# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# INCLUDES ---------------------------------------------------------------- {{{1

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f ~/.git_prompt.sh ]; then
    . ~/.git_prompt.sh
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# ENVIRONMENT CONFIGURATION ----------------------------------------------- {{{1

# History settings.
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
HISTFILESIZE=20000

# Write history after every command.
export PROMPT_COMMAND='history -a'

# Shell opts.
shopt -s histappend
shopt -s checkwinsize

# More colors in a terminal.
export TERM=xterm-256color

# More color if running tmux.
[ -n "$TMUX" ] && export TERM=screen-256color

# Text editor.
export EDITOR=vim

# Put ~/bin on PATH if it exists.
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"
