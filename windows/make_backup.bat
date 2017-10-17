@echo off
rem /------------------------------------\
rem Configuration:
rem slnDir   [must] The folder that include sln file.
rem slnFile  [optional] The sln file name(exclude extension).
rem password [optional] Your password for the 7z file.
rem *------------------------------------*
set slnDir=
set slnFile=
set password=
rem \------------------------------------/
for /f "delims=" %%t in ('powershell /command "Get-Date -Format 'yyyy-MM-dd HH-mm-ss'"') do set datetime=%%t
set output="%slnDir%.%datetime%.Src.7z"
:: set output=%slnDir%_Src.7z
if "%slnFile%"=="" set slnFile=%slnDir%
set exe7z=7z.exe
set excludeFile=exclude.txt
title MAKE BACKUP
cls
if "%slnDir%"=="" goto :ERR1
if not exist %slnDir% goto :ERR1
::if not exist %exe7z% goto :ERR2
:: color
if exist %excludeFile% goto :COMPRESS
echo ^.vs\>%excludeFile%
::echo bin\>>%excludeFile%
echo obj\>>%excludeFile%
echo PerformanceLogs\>>%excludeFile%
echo %slnFile%.suo>>%excludeFile%
echo %slnFile%.sln.DotSettings.user>>%excludeFile%
echo _ReSharper.%slnFile%>>%excludeFile%
echo Thumbs.db>>%excludeFile%
echo The exclude file(%excludeFile%) is OK. Are you edit it now?
set /p tmpCont=Please input:(y-Edit it,N-Go on)?
if /i "%tmpCont%"=="y" goto :EDITEXCLUDEFILE
:COMPRESS
title Backuping£º%output%
if exist %output% del %output% /F /Q
if "%password%"=="" (set pwd=) else (set pwd=-p%password%)
%exe7z% a -t7z -mx=9 %output% %slnDir%\ -xr@%excludeFile% -scsWIN %pwd%
echo Output file£º%output%
title Completed£º%output%
echo Press any key to EXIT...
pause>nul
goto :END
:EDITEXCLUDEFILE
start "" %windir%\notepad.exe %excludeFile%
goto :END
:ERR1
title ERROR - MAKE BACKUP
color 0E
echo ERROR: The source folder(%slnDir%) is don't exist.
echo.
echo Please set the slnDir variable first.
echo.
echo Press any key to edit me...
pause>nul
start "" %windir%\notepad.exe "%~0"
goto :END
:ERR2
title ERROR - MAKE BACKUP
color 0E
echo ERROR: The 7za tool(%exe7z%) is don't exist.
echo.
echo Please set the exe7z variable.
echo.
echo Press any key to EXIT...
pause>nul
goto :END
:END