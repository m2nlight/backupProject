#!/bin/sh
# -------- CONFIG --------
projPath=PROJECTDIR
password=Demo
## level=0,1,3,5,7,9   Level 0 is no compression, 5 is normal, 9 is Ultra.
level=5
## gitgc=0,1   0 is not gc, 1 is git gc
gitgc=1
now=`date +%Y-%m-%d-%H-%M-%S`
branchname=`git -C $projPath/MyPROJ1 symbolic-ref --short -q HEAD`
if [[ ${#branchname} -gt 0 ]]; then
	output=$projPath.$now.\($branchname\).Src.7z
	output2=$projPath.$now.\($branchname\).gitpack.7z
else
	output=$projPath.$now.Src.7z
	output2=$projPath.$now.gitpack.7z
fi
# -------- FUNCTION --------
function printMsg() {
	echo "\033[1;34m$1\033[0m"
}

function printMsgNoColor() {
	echo "\033[1;m$1\033[0m"
}

# -------- START --------
printMsg "Ready..."
xrdirs=-xr!.idea
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
7za a -t7z -scsUTF-8 -mx=$level -mhe -p$password $xrdirs $output "$projPath/" 
printMsg "Backuping(2/2): $output2"
7za a -t7z -scsUTF-8 -mx=0 -mhe -p$password $output2 $packs
printMsg "Done."
