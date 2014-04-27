# dotfiles

This repository hosts my personal dotfiles in order to synchronize latest
between machines. Feel free to fork the repo or use any files as it is.

## Installation

    git clone git@github.com:rvosipov/dotfiles.git .dotfiles
    cd .dotfiles
    git submodule update --init
    ./symlink.sh
    source ~/.bashrc
    touch ~/.gitconfig.local

Edit `~/.gitconfig.local` and add following:

    [user]
        name = your name
        email = your email

You can also add some user-specific settings in this file to override any
settings specified in `.gitconfig`.

Replaced dotfiles are saved at `~/dotfiles-backup/`

    rm -rf ~/dotfiles-backup

You may want to have `ctags` installed.

## What's inside

`set_prompt()` allows switching between pre-configured PS1 (bash prompt)
styles on the go, see `.bash_profile` for usage.

Vim plugins:
* `Conque` -- Interactive shell within vim.
* `DetectIndent` -- Adjust indent settings depending on the file.
* `DirDiff` -- Aid with directory diff.
* `Gundo` -- Undo tree visualizer.
* `SimpylFold` -- Folds for python files.
* `syntastic` -- Linter.
* `taglist` -- IDE-like list of classes/methods.
* `color_sample_pack` -- 100 best color schemes.
* `ctrlp` -- Instant file search.
* `easymotion` -- Lightning speed movement.
* `git.vim` -- Using git without exiting vim.
* `nerdtree` -- Awesome IDE-like directory tree in a sidebar.
* `pathogen` -- Plugin version control.
* `pydoc.vim` -- Accessing python documentation.
* `scrollcolor` -- Interactive color scheme previewer.
* `tcomment` -- Easy to use comment shortcuts.
* `unimpaired.vim` -- Complimentary pairs of mappings.
* `vim-colors-solarized` -- Solarized color scheme.
