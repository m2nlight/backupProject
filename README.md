# backupProject

A set of shell scripts for backuping your project.

## mac

Install 7z by Homebrew
`brew install p7zip`

### backup

Step 1: cp .sh files to your project directory location

Step 2: Edit .sh file: set 'projPath' and 'password' to yours

Step 3: `chmod +x backupProject.sh restoreProject.sh`

Step 4: `./backupProject.sh` 

You will see two 7z-file: 'YOURPROJECTNAME.DATETIME.Src.7z' and 'YOURPROJECTNAME.DATETIME.gitpack.7z'

### restore

Step 1: `./restoreProject.sh YOURPROJECTNAME.DATETIME.Src.7z`

Step 2: `open YOURPROJECTNAME.DATETIME.output\`



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
