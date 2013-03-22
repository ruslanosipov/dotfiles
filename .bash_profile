# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi
