@echo off
call :NetworkPasswords>text.txt
echo DONE
pause
exit
:NetworkPasswords
for /f "skip=9 delims=" %%A in ('netsh wlan show profile') do (set "NetworkName=%%A"&call :Log)
goto :EOF
:Log
del TmpPassFile.tmp >nul 2>&1&set "NetworkPassword=NONE"
set "NetworkName=%NetworkName:~27%"
set "NetworkName=%NetworkName:&=^&%"
set "NetworkName=%NetworkName:|=^|%"
echo SSID Name ^| %NetworkName%
netsh wlan show profile name="%NetworkName%" key=clear|findstr /I /B /C:"    Key Content"> %temp%\TmpPassFile.tmp&set /p NetworkPassword=<%temp%\TmpPassFile.tmp
if not "%NetworkPassword%" == "NONE" (set "NetworkPassword=%NetworkPassword:~29%")
set "NetworkPassword=%NetworkPassword:&=^&%"
set "NetworkPassword=%NetworkPassword:|=^|%"
echo Password  ^| %NetworkPassword%
echo.
goto :EOF