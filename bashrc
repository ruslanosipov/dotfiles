# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# => Constants ------------------------------------------------------------- {{{1

export ENABLE_ANDROID_DEVELOPMENT=0
export ENABLE_GOOGLE_STACK=0
export ENABLE_POWERLINE=0

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

# => Environment configuration -------------------------------------------- {{{1

# History settings.
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTFILESIZE=200000

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

# => Powerline ------------------------------------------------------------ {{{1

if [ $ENABLE_POWERLINE == 1 ]; then
   if [ -d "$HOME/.local/bin" ]; then
       PATH="$HOME/.local/bin:$PATH"
   fi

   powerline-daemon -q

   if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
       source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
   fi
fi

# => Google settings ------------------------------------------------------ {{{1

if [ $ENABLE_GOOGLE_STACK = 1 ]; then
   # Sorry P4DIFF
   P4DIFF=/bin/true

   # Never merge with git if git5 is available.
   git() {
     if [[ $1 == 'merge' ]]; then
       echo 'Use git5 merge!';
     else
       command git "$@";
     fi;
   }

   # The next line updates PATH for the Google Cloud SDK.
   source '/usr/local/google/home/ruslano/google-cloud-sdk/path.bash.inc'

   # The next line enables bash completion for gcloud.
   source '/usr/local/google/home/ruslano/google-cloud-sdk/completion.bash.inc'
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

# => Android development -------------------------------------------------- {{{1

if [ $ENABLE_ANDROID_DEVELOPMENT = 1 ]; then
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
fi

# => Linuxbrew ------------------------------------------------------------ {{{1

export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

# => Ranger ---------------------------------------------------------------- {{{1

# Compatible with ranger 1.4.2 through 1.7.*
#
# Automatically change the directory in bash after closing ranger
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

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

# Add "fuck" alias.
eval $(thefuck --alias)
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"

# Colorized less output.
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
