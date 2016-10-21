#!/bin/sh
## config
file7z=\./PROJECTDIR.*.7z
dirServer=/Volumes/D/backup
## output
function printMsg() {
	echo "\033[4;33m$1\033[0m"
}
function printMsgNoColor() {
	echo "\033[1;m$1\033[0m"
}
## start
printMsgNoColor "Before run backup batch, please use SMB://ServerIP to connect server."
read -p "Ready to run backup batch (Y/N) :" yn
if [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then 
	printMsg "* Updating ..."
	./updateProject.sh
	printMsg "* Removing local backup files ..."
	rm $file7z
	printMsg "* Backuping git version ..."
	./backupProject.sh
	printMsg "* Backuping nogit version ..."
	./backupProject_nogit.sh
	printMsg "* Copying to server ..."
	rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress -- $file7z $dirServer
	printMsg "All Done."
else
	printMsgNoColor "Cancelled."
fi
exit 0
