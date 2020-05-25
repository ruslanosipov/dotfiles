#!/bin/bash
rclone sync googledrive:blog drive_blog
cd $HOME/drive_blog/img/input
mogrify -resize x620 -quality 100 -path $HOME/drive_blog/img/output *
exiftool -all= $HOME/drive_blog/img/output/*
cp $HOME/drive_blog/posts/* $HOME/blog/source/_posts
cp $HOME/drive_blog/img/output/* $HOME/blog/source/images/posts
cd $HOME/blog
rake generate
rake preview
