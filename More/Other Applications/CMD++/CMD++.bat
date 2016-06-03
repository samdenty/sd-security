@echo off
if "%NonFatalCrash%"=="1" call :Variables&set mode=normal&goto :cmdCommand
if "%restart%"=="0" goto CrashHelperActive
goto CrashHelper
:CrashHelperActive
call :Variables
:CMD
if /i "%mode%"=="speedo" goto :SpeedoMode
if /i "%mode%"=="normal" goto :NormalMode
set mode=normal&goto :NormalMode
:: Normal Mode
:NormalMode
color 07
title CMD++
echo ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
%echo% Û&call :color 0f "CMD++ " &call :color 0e " Normal Mode"&call :color 0a " [Version 1.5.1.150]"&%echo%  Û&echo.
echo ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
call :color 0f " SD-Storage¸"&call :color 07 " 2016, All Rights Reserved"&echo.
goto :cmdCommand
:: Speedo Mode
:SpeedoMode
color 07
title CMD++
echo ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo ÛCMD++ Speedo Mode [Version 1.5.1.150]Û
echo ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo  SD-Storage¸ 2016, All Rights Reserved
goto :cmdCommand
:cmdCommand
echo.
:cmdCommand2
if "%cd:~-1%"=="\" (set "Directory=%cd%") else (set "Directory=%cd%\")
set "cmdCommand="
if not "%mode%"=="speedo" (%echo% %directory%&call :color 0d "%AdminFigure%"&set /p "cmdCommand=>") else (%echo% %directory%%AdminFigure%&set /p "cmdCommand=>")
if not defined CmdCommand (goto :CmdCommand2)
set "CMDCmd=%cmdCommand:"=%"
call :commands
if /i not "%mode%"=="speedo" goto NormalCommand
if /i "%mode%"=="speedo" %echo% Output[&echo.&%cmdCommand%
goto :cmdCommand
:NormalCommand
call :color 0b "Output["&echo.&%cmdCommand%
goto :cmdCommand
:commands
if /i "%CMDCmd%"=="cmd" goto :cmd
if /i "%CMDCmd%"=="wincmd" cmd&goto :cmdCommand
if /i "%CMDCmd%"=="clear" cls&goto :cmdCommand
if /i "%CMDCmd%"=="speedo" set mode=speedo&goto :cmdCommand
if /i "%CMDCmd%"=="normal" set mode=normal&goto :cmdCommand
if /i "%CMDCmd%"=="help" call :help&goto :cmdCommand
if /i "%CMDCmd%"=="reset" goto :reset
if /i "%CMDCmd%"=="exit" exit 999
if /i "%CMDCmd%"=="close" exit 999
if /i "%CMDCmd%"=="SD-Storage" start "" "http://SD-Storage.weebly.com/#CMD++"&echo Website Launched&goto :cmdCommand
goto :EOF
:help
call :color 0f "CMD++"&%echo%, Quick Help&echo.&echo.
echo Welcome to CMD++, a powerful reinterpretation of the Windows 'Command Prompt'
echo CMD++ is a mix of the Linux and Windows terminals, a perfect combination
echo.
echo To use CMD++ type in a command and press enter.
echo Done.
echo. 
echo CMD++ overrides some commands (eg. CMD), this is necessary to keep the CMD++
echo session from ending. To perform an overriden command, prefix it with a space
echo 	'cmd' becomes ' cmd'	'reset' becomes ' reset' 
echo.
echo CMD++ has multiple modes, one of which is Speedo mode. This mode can be enabled
echo by entering 'speedo'. Speedo mode is greyscale and much quicker at performing 
echo commands (This setting is stored in the variable %%mode%%)
echo.
echo CMD++ also has a built in crash helper. This means that if CMD++ crashes,
echo it will simply show an message and you can then continue. To exit CMD++,
echo there needs to be an errorlevel of '999' to quit the session, so instead of
echo 	'exit' use 'exit 999'	or to restart CMD++ use 'exit 777'
echo. 
echo Remember, with great power comes great responcibility.
echo CMD++ will perform any command entered, so don't 'format C:'
goto :EOF
:reset
color 07&mode con: cols=80 lines=27&cls&goto :cmd
:Color
if /i "%mode%"=="speedo" %echo% %~2&goto :EOF
if not exist "C:\windows\system32\findstr.exe" %echo% %~2&goto :EOF
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2">nul 2>&1
popd
goto :EOF
:Variables
set "cmd++=goto cmdCommand"
set "echo=<nul set /p ="
net file>nul 2>&1&&set "AdminFigure=#"||set "AdminFigure=$"
goto :EOF

:CrashHelper
set restart=0
call cmd /t:f0 /c "%0"
:CrashHelperPriorityCode
@if errorlevel 999 @exit 999
@if errorlevel 777 @goto :CrashHelperActive
@call :color 0f "CMD++"&call :color 0e " Console Host"&call :color 0c " Crashed!"&call :color 0a " Restarting..."
@set NonFatalCrash=1
@goto :CrashHelper