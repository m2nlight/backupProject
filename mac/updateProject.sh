#!/bin/sh
projPath=PROJECTDIR

function printMsg() {
	echo "\033[1;34m$1\033[0m"
}

## start
printMsg "Ready..."
for gitdir in `find $projPath -iname ".git"`; do
	printMsg "git status/pull: $gitdir"
	git -C $gitdir/.. status -sb
	git -C $gitdir/.. pull
done

printMsg "Done."