# dotfiles

This repository hosts my personal dotfiles in order to synchronize latest
between machines. Feel free to fork the repo or use any files as it is.

## Bare version

There's a bare version which I use to make SSHing to different machines tolerable:

    git clone -b bare-ssh --recursive git@github.com:ruslanosipov/dotfiles.git .dotfiles
    . .dotfiles/symlink.py
    vim +PluginInstall +qall

## Installation

Run `./install.sh`.

Replaced dotfiles are saved at `~/dotfiles-backup/`

    rm -rf ~/dotfiles-backup

### Git

Edit `~/.gitconfig.local` and add following:

    [user]
        name = your name
        email = your email

You can also add some user-specific settings in this file to override any
settings specified in `.gitconfig`.
