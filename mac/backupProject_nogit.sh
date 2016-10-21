#!/bin/sh
projPath=PROJECTDIR
password=Demo
## level=0,1,3,5,7,9   Level 0 is no compression, 5 is normal, 9 is Ultra.
level=9
now=`date +%Y-%m-%d-%H-%M-%S`
branchname=`git -C $projPath/MyPROJ1 symbolic-ref --short -q HEAD`
if [[ ${#branchname} -gt 0 ]]; then
	output=$projPath.$now.\($branchname\).Src_nogit.7z
else
	output=$projPath.$now.Src_nogit.7z
fi
#start
echo "Backuping: $output"
7za a -t7z -scsUTF-8 -mx=$level -mhe -p$password -xr!.git -xr!.gitignore -xr!.idea -xr!.DS_Store $output "$projPath/"
echo "Completed: $output"