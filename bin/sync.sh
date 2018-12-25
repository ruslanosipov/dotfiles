#!/bin/bash
cd $HOME/Dropbox/blog/img/input
mogrify -resize x620 -quality 100 -path $HOME/Dropbox/blog/img/output *
exiftool -all= $HOME/Dropbox/blog/img/output/*
cp $HOME/Dropbox/blog/posts/* $HOME/blog/source/_posts
cp $HOME/Dropbox/blog/img/output/* $HOME/blog/source/images/posts
cd $HOME/blog
rake generate
rake preview
