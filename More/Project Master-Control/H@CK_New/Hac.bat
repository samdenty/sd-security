@echo off
:start
title Hack Installer - Main Menu
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ Hack Installer ˛˛˛                    Main Screen
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo  Welcome to Hack Installer, a simple installer for complex Windows© backdoors
echo.
set "echo=<nul set /p ="
set number=1
Set Apps=Hacking
for /f %%a in ('dir /O:N /B /A:D "%Apps%"') do (
set "App=%%a"
call :Record)

set /p hack="€˛ "
echo.
%echo% Please Wait...
set App%hack%_Action|findstr /b /c:"App%hack%_Action=Uninstall" >nul&&set hackAction=Uninstall||set hackAction=Install
for /f %%a in ('set H@CKApp%hack%') do @(set "setHackApp=%%a")
for /f "tokens=2" %%a in ('echo %setHackApp%') do (set "HackApp=%%a")
:StartRolling
cls
title Hack Installer - %hackAction% %HackApp%
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ Hack Installer ˛˛˛             %hackAction% %HackApp%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
if exist "Hacking\%HackApp%\info.txt" type info.txt

pause
:: DEV SHITE
echo 4=%H@CKApp4%
pause
exit

:Record
set "H@CKApp%number%=%App%"
pushd "Hacking\%App%"
call "check.bat"
popd
set %App%|findstr /B /C:"%App%=Uninstalled" >nul&&set "status= "||set "status=˛"
if "%status%"=="˛" (set "cmd=Uninstall"&set "App%number%_Action=Uninstall") else (set "cmd=Install"&set "App%number%_Action=Install")
echo €%number%€%status%€€ %App%
set /a number=number+1 >nul
goto :eof