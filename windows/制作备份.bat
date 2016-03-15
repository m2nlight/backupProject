@echo off
rem /------------------------------------\
rem 说明：
rem slnDir   [必选] 将压缩的文件夹名称
rem slnFile  [可选] 将sln文件名（不含扩展名）设置在“slnFile=”右边
rem password [可选] 打包时使用的密码
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
title 制作备份
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
echo 已经生成排除清单文件%excludeFile%，是现在要编辑它？
set /p tmpCont=请选择(y-编辑,N-不编辑继续执行)?
if "%tmpCont%"=="y" goto :EDITEXCLUDEFILE
if "%tmpCont%"=="Y" goto :EDITEXCLUDEFILE
:COMPRESS
title 正在备份：%output%
if exist %output% del %output% /F /Q
if "%password%"=="" (set pwd=) else (set pwd=-p%password%)
%exe7z% a -t7z -mx=9 %output% %slnDir%\ -xr@%excludeFile% -scsWIN %pwd%
echo 输出文件：%output%
title 备份完成：%output%
set /p key=按回车键退出...
goto :END
:EDITEXCLUDEFILE
start "" %windir%\notepad.exe %excludeFile%
goto :END
:ERR1
title 错误 - 制作备份
color 0E
echo 错误：源文件夹：“%slnDir%” 不存在！
echo.
echo 请修改slnDir变量，保存后重试。
echo.
echo 按任意键开始编辑...
pause>nul
start "" %windir%\notepad.exe "%~0"
goto :END
:ERR2
title 错误 - 制作备份
color 0E
echo 错误：压缩软件：“%exe7z%”不存在！
echo.
echo 请检查7z压缩软件，或者编辑批处理修改exe7z变量。
echo.
echo 按任意键退出...
pause>nul
goto :END
:END