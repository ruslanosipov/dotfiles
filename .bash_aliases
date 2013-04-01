# git
alias g="git"
alias last="head -5 | grep commit | awk '{print \$2}'"
alias del="git ls-files --deleted | xargs git rm"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# misc
alias xclip="xclip -selection c"
alias ping="ping -c 5"
alias r="fc -s"
