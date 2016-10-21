#!/bin/sh
## config
gitserver=mygitserver@192.168.10.10:PROJECT
gitMyPROJ1=$gitserver/MyPROJ1.git
gitlibrary=$gitserver/library.git
dirPROJECTDIR=\./PROJECTDIR
dirLibrary=$dirPROJECTDIR/library
dirMyPROJ1=$dirPROJECTDIR/MyPROJ1
file7z=\./PROJECTDIR.*.7z
dirServer=/Volumes/D/backup
## output
function printMsg() {
	echo "\033[4;33m$1\033[0m"
}
function printMsgNoColor() {
	echo "\033[1;m$1\033[0m"
}
function printWarningMsg() {
	echo "\033[1;31m$1\033[0m"
}
## start
printMsgNoColor "Before run backup batch, please use SMB://ServerIP to connect server."
read -p "Ready to run backup batch? (Y/N) :" yn
if [ "$yn" != "Y" ] && [ "$yn" != "y" ]; then
	printMsgNoColor "Cancelled."
	exit 0
fi

yn=n
printWarningMsg "WARNING! WARNING! I WILL REMOVE ALL FILES THEN REGIT IT."
read -p "ARE YOU SURE? (Y/N) :" yn
if [ "$yn" != "Y" ] && [ "$yn" != "y" ]; then
	printMsgNoColor "Cancelled."
	exit 0
fi

printMsg "* Clean files and create dirs..."
printMsgNoColor "  Removing MyPROJ1 ..."
rm -rf $dirMyPROJ1
mkdir -p $dirPROJECTDIR

printMsg "* Git clone ..."
if [ ! -d "$dirLibrary" ]; then
	printMsgNoColor "  Git clone --recursive library ..."	
	git -C $dirPROJECTDIR clone --recursive $gitlibrary
	# printMsgNoColor "  - Git submodule init and update ..."	
	# git -C $dirLibrary submodule init
	# git -C $dirLibrary submodule update
fi
printMsgNoColor "  Git clone --depth 1 MyPROJ1 ..."
git -C $dirPROJECTDIR clone --depth 1 $gitMyPROJ1

printMsg "* Removing local backup files ..."
rm $file7z

printMsg "* Backuping git version ..."
./backupProject.sh

printMsg "* Backuping nogit version ..."
./backupProject_nogit.sh

printMsg "* Copying to server ..."
rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress -- $file7z $dirServer
printMsg "All Done."

exit 0
