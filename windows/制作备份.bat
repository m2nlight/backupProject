@echo off
rem /------------------------------------\
rem ˵����
rem slnDir   [��ѡ] ��ѹ�����ļ�������
rem slnFile  [��ѡ] ��sln�ļ�����������չ���������ڡ�slnFile=���ұ�
rem password [��ѡ] ���ʱʹ�õ�����
rem *------------------------------------*
set slnDir=
set slnFile=
set password=
rem \------------------------------------/
set output="%slnDir%.%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%-%time:~3,2%-%time:~6,2%.Src.7z"
:: set output=%slnDir%_Src.7z
if "%slnFile%"=="" set slnFile=%slnDir%
set exe7z=7za.exe
set excludeFile=exclude.txt
title ��������
cls
if "%slnDir%"=="" goto :ERR1
if not exist %slnDir% goto :ERR1
if not exist %exe7z% goto :ERR2
:: color
if exist %excludeFile% goto :COMPRESS
echo bin\>%excludeFile%
echo obj\>>%excludeFile%
echo PerformanceLogs\>>%excludeFile%
echo %slnFile%.suo>>%excludeFile%
echo _ReSharper.%slnFile%>>%excludeFile%
::echo %slnFile%.5.1.ReSharper.user>>%excludeFile%
::echo %slnFile%.sln.cache>>%excludeFile%
echo Thumbs.db>>%excludeFile%
echo �Ѿ������ų��嵥�ļ�%excludeFile%��������Ҫ�༭����
set /p tmpCont=��ѡ��(y-�༭,N-���༭����ִ��)?
if "%tmpCont%"=="y" goto :EDITEXCLUDEFILE
if "%tmpCont%"=="Y" goto :EDITEXCLUDEFILE
:COMPRESS
title ���ڱ��ݣ�%output%
if exist %output% del %output% /F /Q
if "%password%"=="" (set pwd=) else (set pwd=-p%password%)
%exe7z% a -t7z -mx=9 %output% %slnDir%\ -xr@%excludeFile% -scsWIN %pwd%
echo ����ļ���%output%
title ������ɣ�%output%
set /p key=���س����˳�...
goto :END
:EDITEXCLUDEFILE
start "" %windir%\notepad.exe %excludeFile%
goto :END
:ERR1
title ���� - ��������
color 0E
echo ����Դ�ļ��У���%slnDir%�� �����ڣ�
echo.
echo ���޸�slnDir��������������ԡ�
echo.
echo ���������ʼ�༭...
pause>nul
start "" %windir%\notepad.exe "%~0"
goto :END
:ERR2
title ���� - ��������
color 0E
echo ����ѹ���������%exe7z%�������ڣ�
echo.
echo ����7zѹ����������߱༭�������޸�exe7z������
echo.
echo ��������˳�...
pause>nul
goto :END
:END