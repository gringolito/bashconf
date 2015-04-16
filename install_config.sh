#!/bin/sh
CURDIR=`pwd`
FILELIST="bash_aliases bash_functions bashrc profile"

# create backups, for blind sighted users that doesnt even look what
# scripts does
for file in $FILELIST; do
	if [ -f ~/.$file ]; then
		mv -f ~/.$file ~/.${file}.bk
	fi
done

# create simlinks for the current dir, so our configuration is updated
# if its modified in the git repository
for file in $FILELIST; do
	ln -sf $CURDIR/$file ~/.$file
done

