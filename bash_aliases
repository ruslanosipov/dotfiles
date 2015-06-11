# git
alias g="git"
alias last="head -5 | grep commit | awk '{print \$2}'"
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
alias fuck="reset"
alias cd..="cd .."

# vim
alias nerd="vim -c NERDTree"
alias v="vim"

# Pipe command to this to display an alert.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Apparix aliases.
alias als="apparix"

# Blaze test DoubleCheck project.
alias blest='blaze test //experimental/pdscrt/javatests/com/google/partnerservices/pds/pdscrt:UnitTests --test_output errors --test_summary none'

# Run JavaScript linter on unsubmitted changes.
alias git5jslint="git5 diff --name-only | sed -e 's,google3/,,' | (cd ${PWD%%/google3*}/google3 && xargs gjslint --strict)"

# Wrapper around git5.
alias g5='/google/data/ro/projects/shelltoys/g5.sar'

# Launch Vim with X to use event (async commands).
alias vim="vim --servername loglady"
