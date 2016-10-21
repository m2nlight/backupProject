#!/bin/sh
file7z=\./PROJECTDIR.*.7z
dirServer=/Volumes/D/backup
rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress -- $file7z $dirServer
