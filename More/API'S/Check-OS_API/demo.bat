@Echo off
call :checkOS
echo You Are Running '%winVersion%' With The Windows Version '%version%'
pause
exit
:checkOS
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