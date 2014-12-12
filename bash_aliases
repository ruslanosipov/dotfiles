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
