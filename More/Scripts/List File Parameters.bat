@echo off
set File=0&if "%~1"=="" goto :NoParams
:Loop
if "%~1" == "" (goto TaskComplete)
if not exist "%~1" call :BadFile
echo %~1&shift&goto Loop


:TaskComplete
if not "%file%"=="0" (echo %File% File^(s^) don't exist )
echo.
:End
echo Press Any Key To Exit
pause >nul
exit /b
:BadFile
set /a file=%file%+1 >nul 2>&1
goto :EOF
:NoParams
echo No Parameters!!
goto :END