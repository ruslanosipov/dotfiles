# dotfiles

This repository hosts my personal dotfiles in order to synchronize latest between machines. Feel free to fork the repo or use any files as it is.

## Installation

    git clone git@github.com:rvosipov/dotfiles.git .dotfiles
    cd .dotfiles
    git submodule update --init
    ./symlink.sh
    source ~/.bashrc

Replaced dotfiles are saved at ~/dotfiles-backup

    rm -rf ~/dotfiles-backup

## What's inside

Vim plugins:
* `pathogen` for plugin version control
* `git.vim` for using git without exiting vim
* `nerdtree` for awesome IDE-like direcotry tree in a sidebar
* `pydoc.vim` for accessing python documentation
* `tcomment` for easy to use comment shortcuts
* `easymotion` for lightning speed movement
* `scrollcolor` for interactively checking out color schemes
* `color_sample_pack` for being able to choose out of 100 best color schemes
