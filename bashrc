# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ------------------------------------------------------------------------------
# INCLUDES {{{1
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
# FUNCTIONS {{{1
# ------------------------------------------------------------------------------

##
# Set current prompt style
#
# Available styles to pick from:
# 0 "user@host:dir$ ", no color
# 1 "user@host dir (git branch) $ ", colorful and bold
# 2 "dir (git branch) $ ", colorful and bold
# 3 "dir$ ", no color
# 4 same as 1, but user@host replaced with ~/.username cat
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
        prompt='\[\033[01;34m\]\w\[\033[01;33m\]'
        prompt+='$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
    elif [ "$1" == 3 ]; then
        prompt='\w$ '
    elif [ "$1" == 4 ]; then
        if [ -f ~/.username ]; then
            prompt='\[\033[01;32m\]$(cat ~/.username)'
            prompt+='\[\033[01;34m\] \w\[\033[01;33m\]'
            prompt+='$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
        else
            printf "Can't find ~/.username file!\n" && return 10
        fi
    elif [ "$1" == 5 ]; then
        prompt='\[\033[01;32m\]$(cat ~/.username)'
        prompt+='\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
    elif [ "$1" == 6 ]; then
        prompt='\u@\h\$ '
    fi

    PS1=$prompt
}

export -f set_prompt

# ------------------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION {{{1
# ------------------------------------------------------------------------------

# history settings
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
HISTFILESIZE=20000

# write history after every command
export PROMPT_COMMAND='history -a'

# shell opts
shopt -s histappend
shopt -s checkwinsize

# more colors in aterminal
export TERM=xterm-256color

# more color if running tmux
[ -n "$TMUX" ] && export TERM=screen-256color

# text editor
export EDITOR=vim

# put ~/bin on PATH if it exists
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

# ------------------------------------------------------------------------------
# PROMPT {{{1
# ------------------------------------------------------------------------------

# choose current prompt style (see set_prompt for details)
set_prompt 2

# ------------------------------------------------------------------------------
# INCLUDE LOCAL CONFIG {{{1
# ------------------------------------------------------------------------------

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# ------------------------------------------------------------------------------
# POWERLINE {{{1
# ------------------------------------------------------------------------------

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

powerline-daemon -q

if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi

# ------------------------------------------------------------------------------
# GOOGLE SETTINGS {{{1
# ------------------------------------------------------------------------------

# fuck P4DIFF
P4DIFF=/bin/true
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ------------------------------------------------------------------------------
# APPARIX {{{1
# ------------------------------------------------------------------------------

function to () {
   if test "$2"; then
     cd "$(apparix "$1" "$2" || echo .)";
   else
     cd "$(apparix "$1" || echo .)";
   fi
   pwd
}
function bm () {
   if test "$2"; then
      apparix --add-mark "$1" "$2";
   elif test "$1"; then
      apparix --add-mark "$1";
   else
      apparix --add-mark;
   fi
}
function portal () {
   if test "$1"; then
      apparix --add-portal "$1";
   else
      apparix --add-portal;
   fi
}
# function to generate list of completions from .apparixrc
function _apparix_aliases ()
{   cur=$2
    dir=$3
    COMPREPLY=()
    if [ "$1" == "$3" ]
    then
        COMPREPLY=( $( cat $HOME/.apparix{rc,expand} | \
                       grep "j,.*$cur.*," | cut -f2 -d, ) )
    else
        dir=`apparix -favour rOl $dir 2>/dev/null` || return 0
        eval_compreply="COMPREPLY=( $(
            cd "$dir"
            \ls -d *$cur* | while read r
            do
                [[ -d "$r" ]] &&
                [[ $r == *$cur* ]] &&
                    echo \"${r// /\\ }\"
            done
            ) )"
        eval $eval_compreply
    fi
    return 0
}
# command to register the above to expand when the 'to' command's args are
# being expanded
complete -F _apparix_aliases to

# ------------------------------------------------------------------------------
# ANDROID DEVELOPMENT {{{1
# ------------------------------------------------------------------------------

# Crow (Android emulator)
source /google/data/ro/teams/mobile_eng_prod/crow/crow-complete.bash
alias crow=/google/data/ro/teams/mobile_eng_prod/crow/crow.par

# Use adb.turbo when possible, otherwise fall back to standard adb.
function adb() {
  EMU_DEPS=/google/data/ro/teams/mobile_eng_prod/emu/live/google3/
  ANDROID_SDK=${EMU_DEPS}/third_party/java/android/android_sdk_linux/
  EMU_SUPPORT=${EMU_DEPS}/tools/android/emulator/support/
  ANDROID_ADB=${ANDROID_SDK}/platform-tools/adb
  ANDROID_ADB=${ANDROID_ADB} $EMU_SUPPORT/adb.turbo "$@"
}

# Add the internal Android SDK to your PATH
export ANDROID_SDK_HOME=/google/data/ro/teams/mobile_eng_prod/android_sdk_linux
export PATH=${PATH}:${ANDROID_SDK_HOME}/tools:${ANDROID_SDK_HOME}/platform-tools

# ------------------------------------------------------------------------------
# LINUXBREW {{{1
# ------------------------------------------------------------------------------

export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
