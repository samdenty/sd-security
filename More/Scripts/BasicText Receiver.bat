@echo off
call :GetIP "GD-Laptop"
echo %IP%
pause
netss|findstr "\\"
for /f "delims=\\" %%a in ('netss^|findstr "^\\"') do set tmp1=%%a
echo %tmp1%
pause
call :GetIP "%tmp1%"

:GetIp
if "%1" == "" (set GetIP=%computername%) else (set GetIP=%~1)
for /f "tokens=1,2 delims=[]" %%a in ('ping -w 1 -n 1 -4 "%GetIP%"^|findstr "Pinging"') do set IP=%%b
goto :EOF