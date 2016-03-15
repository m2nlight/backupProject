#!/bin/sh
projPath=PROJECTDIR
password=Demo
## level=0,1,3,5,7,9   Level 0 is no compression, 5 is normal, 9 is Ultra.
level=9
now=`date +%Y-%m-%d-%H-%M-%S`
output=$projPath.$now.Src_nogit.7z
echo "Backuping: $output"
7za a -t7z -mx=$level $output "$projPath/" -xr!.git -xr!.gitignore -xr!.idea -xr!.DS_Store -scsUTF-8 -p$password
echo "Completed: $output"