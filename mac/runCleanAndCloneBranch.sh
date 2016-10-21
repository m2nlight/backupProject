#!/bin/sh
## config
gitserver=mygitserver@192.168.10.10:PROJECT
gitMyPROJ1=$gitserver/MyPROJ1.git
gitlibrary=$gitserver/library.git
dirPROJECTDIR=\./PROJECTDIR
dirLibrary=$dirPROJECTDIR/library
dirMyPROJ1=$dirPROJECTDIR/MyPROJ1
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
yn=n
printWarningMsg "WARNING! WARNING! I WILL REMOVE ALL FILES THEN GIT CLONE BRANCH."
sleep 0.8
echo "Remote branches: "
git ls-remote --heads $gitMyPROJ1 | awk 'sub(/refs\/heads\//,""){print $2}'
printMsg "* Please input"
branchName=master
read -p "Branch name: (master) " branchName
if [ "$branchName" == "" ]; then
	branchName="master"
fi
depthNum=
read -p "Depth number: (no depth) " depthNum
case $depthNum in
"")
	printMsg "No Depth."
	depthStr=
	;;
[0-9]*)
	depthStr=\-\-depth\ $depthNum
	;;
*)
	printMsgNoColor "Cancelled."
	exit 0
	;;
esac

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
printMsgNoColor "  Git clone MyPROJ1 -b $branchName $depthStr ..."
git -C $dirPROJECTDIR clone -b $branchName $depthStr $gitMyPROJ1

printMsg "All Done."

exit 0
