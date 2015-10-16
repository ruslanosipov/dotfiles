# git
alias g="git"
alias del="git ls-files --deleted | xargs git rm"

# filesystem
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# misc
alias xclip="xclip -selection c"
alias r="fc -s"
alias cd..="cd .."

# vim
alias nerd="vim -c NERDTree"
alias vim="vim --servername loglady"
alias v="vim"

# Pipe command to this to display an alert.
alias alert='notify-send --urgency=normal -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Wrapper around git5.
if [ $ENABLE_GOOGLE_STACK == 1 ]; then
  alias g5='/google/data/ro/projects/shelltoys/g5.sar'
fi
