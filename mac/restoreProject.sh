#!/bin/sh
password=Demo

function printError() {
	echo "FAIL!"
	echo "SAMPLE1: $0 xxxxxxxx.Src.7z"
	echo "SAMPLE2: $0 xxxxxxxx.gitpack.7z"
}

function printMsg() {
	echo "\033[1;34m$1\033[0m"
}

## start
printMsg "Ready..."
if [[ -a $1 ]]; then
	if [[ $1 == *.Src.7z ]]; then
		file1=$1
		file2=`echo $1|sed -n "s/\.Src\.7z/\.gitpack\.7z/p"`
	elif [[ $1 == *.gitpack.7z ]]; then
		file1=`echo $1|sed -n "s/\.gitpack\.7z/\.Src\.7z/p"`
		file2=$1
	else
		printError
		exit 0
	fi

	output=`echo $file1|sed -n "s/\.Src\.7z/.output/p"`
	if [[ -a $file1 ]]; then
		printMsg "Extracting $file1..."
		7za x -aoa -y $file1 -o$output -p$password
	fi
	if [[ -a $file2 ]]; then
		printMsg "Extracting $file2..."
		7za x -aoa -y $file2 -o$output -p$password
	fi
	printMsg "Output Dir: $output"
	printMsg "Done."
else
	printError
fi