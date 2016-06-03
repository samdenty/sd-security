@echo off
if "%appfolder%" == "" set "appfolder=%cd%"
if exist "%appfolder%\DisableLogger++.ini" exit 999
:: Logger++ Plugin By SD-Storage
if not exist "%appfolder%\Logs\" md %appfolder%\Logs >nul 2>&1
if exist "%appfolder%\SameFile.ini" (set "LogFile=%appfolder%\Logs\Log.log") else (call :getNewLogFile)
for /f "tokens=14" %%a in ('ipconfig^|findstr "IPv4 Address*"') do set Ip2=%%a
call :getip
call :checkOSInfo
echo SD-Security Log V%SDS_Version%, Time: %time%, Date: %date%>> "%logfile%"
echo Win OS  : %WinVersion% >> "%logfile%"
echo Serial  : %serial%>> "%logfile%"
echo Username: %username%>> "%logfile%"
echo PC Name : %computername%>> "%logfile%"
echo Local IP: #1:%ip% #2:%ip2%>> "%logfile%"
for /f %%a in ('wmic path softwarelicensingservice get OA3xOriginalProductKey^|findstr "\-"') do echo WinKey  : %%a>> "%logfile%"
echo.>> "%logfile%"
pause
exit

:GetNewLogFile
set Number=1
:loop
if exist "%appfolder%\Logs\#%Number%_Log.log" set /a Number=%number%+1 >nul&goto :Loop
set "LogFile=%appfolder%\Logs\#%Number%_Log.log"
goto :EOF
:GetIp
if "%1" == "" (set GetIP=%computername%) else (set GetIP=%~1)
for /f "tokens=1,2 delims=[]" %%a in ('ping -w 1 -n 1 -4 "%GetIP%"^|findstr "Pinging"') do set IP=%%b
goto :EOF
:checkOSInfo
for /f "skip=1 delims=" %%a in ('vol') do set serial=%%a
set serial=%serial:~-9,9%
for /f "tokens=4-5 delims=. " %%i in ('ver') do set version=%%i.%%j
if "%version%"=="10.0" set winVersion=Windows 10&goto :EOF
if "%version%"=="6.4" set winVersion=Windows 10 Preview&goto :EOF
if "%version%"=="6.3" set winVersion=Windows 8&goto :EOF
if "%version%"=="6.1" set winVersion=Windows 7&goto :EOF
if "%version%"=="6.0" set winVersion=Windows Vista&goto :EOF
if "%version%"=="5.2" set winVersion=Windows Server 2003&goto :EOF
if "%version%"=="5.1" set winVersion=Windows XP&goto :EOF
if "%version%"=="5.00" set winVersion=Windows 2000&goto :EOF
if "%version%"=="4.90" set winVersion=Windows ME&goto :EOF
if "%version%"=="4.10" set winVersion=Windows 98&goto :EOF
if "%version%"=="4.00" set winVersion=Windows 95&goto :EOF
set winVersion=Windows Version %version%
goto :EOF