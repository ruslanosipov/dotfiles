#!/usr/bin/env python3

##############################################################################
# Automatically symlink all dotfiles to the user's home directory.
#
# Copyright (c) 2013, Martey Dodoo.
#
# This has been made cross-platform and ported to Python 3 by Ruslan Osipov.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
##############################################################################

import errno
import os
import shutil
import sys

IS_WINDOWS = sys.platform == 'win32'

if IS_WINDOWS:
    HOME_ENV = 'USERPROFILE'
else:
    HOME_ENV = 'HOME'

home_dir = os.environ[HOME_ENV]
# Name of the directory where dotfiles are located.
dotfiles_dir = os.path.join(
        home_dir, ('_' if IS_WINDOWS else '.') + "dotfiles")
# List of things we should ignore in the dotfiles directory.
ignore = [
    ".git",
    ".gitignore",
    ".gitmodules",
    "LICENSE",
    "README.md",
    "symlink.py",
]
# Windows needs very few of these, explicitly whitelist:
windows_whitelist = {
    'gvimrc': '_gvimrc',
    'vim': 'vimfiles',
    'vimrc': '_vimrc',
}
# Name of the directory where already-existing dotfiles should be moved.
backup_dir = os.path.join(home_dir, "dotfiles-backup")

# Create backup directory if needed.
try:
    os.mkdir(backup_dir)
    print("Backup directory %s created." % backup_dir)
except OSError as backup_creation_err:
    if backup_creation_err.errno == errno.EEXIST:
        print("Backup directory %s already exists." % backup_dir)
    else:
        raise

# Generate a list of dotfiles from $dotfiles that we will need to link.
dotfiles = os.listdir(dotfiles_dir)
# For each file/directory in this list, attempt to symlink to the
# home directory.
for filename in dotfiles:
    if filename in ignore:
        continue

    # Add dots to dotfile names.
    if IS_WINDOWS:
        try:
            dotfile = windows_whitelist[filename]
        except KeyError:
            continue
    else:
        if filename == 'bin':
            dotfile = 'bin'  # Just keep bin/ as is.
        else:
            dotfile = '.' + filename

    # Assume that this is a directory and try to create a symlink.
    try:
        os.symlink(os.path.join(dotfiles_dir, filename),
                   os.path.join(home_dir, dotfile))
        print("Linked %s to %s." % (os.path.join(dotfiles_dir, dotfile),
                                    os.path.join(home_dir, dotfile)))
    except OSError as link_err:
        if link_err.errno == errno.EEXIST:
            # Check to see if this is a symlink, which means it has
            # already been copied.
            if os.path.islink(os.path.join(home_dir, dotfile)):
                print("%s is already a symlink." % os.path.join(
                        home_dir, dotfile))
                continue

            # This file already exists in the home directory,
            # so we move the old file to the backup directory.
            print("%s already exists in %s." % (dotfile, home_dir))
            shutil.move(os.path.join(home_dir, dotfile),
                        os.path.join(backup_dir, dotfile))
            print("Moved %s to %s" % (dotfile, backup_dir))
            os.symlink(os.path.join(dotfiles_dir, dotfile),
                       os.path.join(home_dir, dotfile))
            print("Linked %s to %s." % (os.path.join(dotfiles_dir, filename),
                                        os.path.join(home_dir, dotfile)))
        else:
            raise
