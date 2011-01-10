#!/usr/bin/env sh 
if [ X`which zsh` = X ]; then 
	echo Zsh seems unavailable. Install it prior to installing fizsh. 
fi
if [ X`which md5sum` = X ]; then 
	echo Coreutils seems unavailable. Install it prior to installing fizsh. 
fi
if [ ! X`which zsh` = X ]; then 
	if [ ! X`which md5sum` = X ]; then 
		echo All fizsh\'s requirements seem to be satisfied. 
	fi
fi
