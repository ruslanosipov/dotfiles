# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

if [ -z "$user_bashrc_already_run" ]; then
  user_bashrc_already_run=1
else
  return
fi

# => Constants ------------------------------------------------------------ {{{1

if [ `uname` == "Darwin" ]; then
   export IS_MAC=1
else
   export IS_MAC=0
fi

# => Includes ------------------------------------------------------------- {{{1

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f ~/.git_prompt.sh ]; then
    . ~/.git_prompt.sh
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Google-specific .bashrc.
if [ -f ~/.bashrc.google ]; then
    . ~/.bashrc.google
fi

# => Environment configuration -------------------------------------------- {{{1

# History settings.
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000000
HISTFILESIZE=2000000

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

# => Prompt --------------------------------------------------------------- {{{1

PS1='\w$ '

# => Include local config ------------------------------------------------- {{{1

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# => Apparix -------------------------------------------------------------- {{{1

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

alias als="apparix"

complete -F _apparix_aliases to

# => Ranger ---------------------------------------------------------------- {{{1

function ranger-cd {
  tempfile="$(mktemp -t tmp.XXXXXX)"
  /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
    cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
}

# This binds Ctrl-O to ranger-cd:
bind '"\C-o":"ranger-cd\C-m"'

# => Misc ----------------------------------------------------------------- {{{1

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Setup virtualenvwrapper.
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
   source /usr/local/bin/virtualenvwrapper.sh
   export WORKON_HOME=~/envs
fi

# Fuzzy file autocomplete.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"

# Colorized less output.
export LESS='-R'
export LESSOPEN='|~/bin/lessfilter %s'

# Allow Vim to use xclipboard during SSH/tmux sessions.
export DISPLAY=:0.0
