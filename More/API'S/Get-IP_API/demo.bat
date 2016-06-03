@echo off
set /p tmp1="Enter A Computer Name To Get IP Of: "
call :GetIP "%tmp1%"
echo The Ip Address For '%GetIP%' Is '%IP%'
exit /b

:GetIp
if "%1" == "" (set GetIP=%computername%) else (set GetIP=%~1)
for /f "tokens=1,2 delims=[]" %%a in ('ping -w 1 -n 1 -4 "%GetIP%"^|findstr "Pinging"') do set IP=%%b
goto :EOF