#!/bin/sh
projPath=PROJECTDIR
password=Demo
## level=0,1,3,5,7,9   Level 0 is no compression, 5 is normal, 9 is Ultra.
level=5
## gitgc=0,1   0 is not gc, 1 is git gc
gitgc=1
now=`date +%Y-%m-%d-%H-%M-%S`
output=$projPath.$now.Src.7z
output2=$projPath.$now.gitpack.7z

function printMsg() {
	echo "\033[1;34m$1\033[0m"
}

function printMsgNoColor() {
	echo "\033[1;m$1\033[0m"
}

## start
printMsg "Ready..."
for gitdir in `find $projPath -iname ".git"`; do
	if [[ $gitgc -eq 1 ]]; then
		printMsg "git gc: $gitdir"
		git -C $gitdir/.. gc
	else
		printMsgNoColor "$gitdir"
	fi
	pack="$gitdir/objects/pack/"
	xrdirs="$xrdirs -xr!$pack"
	packs="$packs $pack"
done
printMsg "Backuping(1/2): $output"
7za a -t7z -mx=$level $output "$projPath/" -scsUTF-8 -p$password $xrdirs
printMsg "Backuping(2/2): $output2"
7za a -t7z -mx=0 $output2 $packs -scsUTF-8 -p$password
printMsg "Done."