# backupProject

A set of shell scripts for backuping your project.

## mac

Install 7z by Homebrew
`brew install p7zip`

### backup

Step 1: Copy *.sh files to your project directory location

Step 2: Edit .sh file: set variables 'projPath', 'password' and etc. for yours

Step 3: `chmod +x *.sh`

Step 4: `./runCleanAndBackup.sh` or `./runCleanAndCloneBranch.sh` + `runbackup.sh`
```
runCleanAndBackup.sh = runCleanAndCloneBranch.sh + master branch + deptch 1 + runbackup.sh
```

Step 5: when copy to server failed, to run `./copytoserver.sh`

You will see tow same `DATETIME` 7z files: 
* `YOURPROJECTNAME.DATETIME.(barnch).Src.7z`
* `YOURPROJECTNAME.DATETIME.(barnch).gitpack.7z`

and other `DATETIME` 7z file:
* `YOURPROJECTNAME.OTHERDATETIME.(barnch).Src_nogit.7z`

### restore

Step 1: `./restoreProject.sh YOURPROJECTNAME.DATETIME.(barnch).Src.7z`

Step 2: `open YOURPROJECTNAME.DATETIME.(barnch).output\`

or

restore no-git source code with `7za x -aoa -y -o$output -p$password YOURPROJECTNAME.OTHERDATETIME.(barnch).Src_nogit.7z`

## windows

`制作备份.bat` only for Simplified Chinese Windows.

Download last extra file ("7z1514-extra.7z") and put it with `制作备份.bat`
* http://www.7-zip.org/
* https://sourceforge.net/projects/sevenzip/


### backup

Step 1: Copy 7za.exe(in 7zXXXX-extra.7z) and .bat to your project folder location

Step 2: Edit .bat file: set 'slnDir' and 'password' to yours

Step 3: Run `制作备份.bat`

You can see a 7z-file: YOURPROJECTNAME.DATETIME.Src.7z


### restore

`7za x YOURPROJECTNAME.DATETIME.Src.7z -oOUTPUTDIR`

or

open with 7-Zip GUI、WinRAR...
