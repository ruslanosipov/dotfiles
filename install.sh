#!/usr/bin/env bash

python3 symlink.py
source $HOME/.bashrc
touch $HOME/.gitconfig.local
sudo apt-get install git vim ack-grep python-pip tree ranger -y
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
pip install --user thefuck virtualenvwrapper
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
source $HOME/.fzf/install
