# backupProject

A shell scripts what to backup your project.

## mac

Install 7z by Homebrew
`brew install p7zip`

### backup

Step 1: cp .sh file to your project directory location

Step 2: Edit .sh file: set 'projPath' and 'password' for yours

Step 3: `chmod +x backupProject.sh restoreProject.sh`

Step 4: `./backupProject.sh`

### restore

Step 1: `./restoreProject.sh YOURPROJECTNAME.DATETIME.Src.7z`

Step 2: open YOURPROJECTNAME.DATETIME.output



## windows

`制作备份.bat` only for Simplified Chinese Windows.

Download last extra file ("7z1514-extra.7z") and put it with `制作备份.bat`
* http://www.7-zip.org/
* https://sourceforge.net/projects/sevenzip/


### backup

Step 1: Copy 7za.exe and .bat to your project folder location

Step 2: Edit .bat file: set 'slnDir' and 'password'

Step 3: Run `制作备份.bat`


### restore

`7z x YOURPROJECTNAME.DATETIME.Src.7z -oOUTPUTDIR`

or

7-Zip GUI、WinRAR...
