#!/usr/bin/env bash

python3 symlink.py
source $HOME/.bashrc
touch $HOME/.gitconfig.local
sudo apt install git vim ack-grep python3 tree ranger thefuck -y
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
python3 -m pip install --user virtualenvwrapper
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
source $HOME/.fzf/install
