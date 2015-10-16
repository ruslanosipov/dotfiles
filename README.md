# dotfiles

This repository hosts my personal dotfiles in order to synchronize latest
between machines. Feel free to fork the repo or use any files as it is.

## Bare version

There's a bare version which I use to make SSHing to different machines tolerable:

    git clone -b bare-ssh --recursive git@github.com:ruslanosipov/dotfiles.git .dotfiles
    . .dotfiles/symlink.py
    vim +PluginInstall +qall

## Installation

    git clone --recursive git@github.com:ruslanosipov/dotfiles.git .dotfiles
    cd .dotfiles
    ./symlink.sh
    source ~/.bashrc
    touch ~/.gitconfig.local
    touch ~/.mutt/account_{1,2}

Replaced dotfiles are saved at `~/dotfiles-backup/`

    rm -rf ~/dotfiles-backup

You may want to have `ctags` installed for Vim to work with tags.

### Git

Edit `~/.gitconfig.local` and add following:

    [user]
        name = your name
        email = your email

You can also add some user-specific settings in this file to override any
settings specified in `.gitconfig`.

### Mutt

Mutt requires `abook` to be installed for address autocomplete. Also, you need
to create `~/.mutt/account_1`, `~/.mutt/account_2` (more or less if you need
to) files with your mailbox accounts.

    set from              = "email@address.com"
    set hostname          = address.com
    set imap_pass         = "password"
    set imap_user         = "email@address.com"
    set realname          = "John Doe"

Switch between accounts with `F2` - `FN`, you might have to adjust `~/.muttrc`
to account for number of accounts you have.
