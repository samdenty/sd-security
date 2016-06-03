@echo off
title Randomo
set /p test="How Long Do You Want The Random Digit To Be (number)? "
call :Randomo %test%
echo.
echo %Randomo%
pause
exit

:Randomo
setlocal&set "ec=<nul set /p ="&set "random="&set "time="&set "Randomo="
set "Length=%~1"
if not "%Length:~0,1%"=="0" (call :RandomVar&set "loops=1") else (goto :EOF)
:Randomo2
set "Randomo=%Randomo%%R%"
if "%loops%"=="%length%" cls&echo 100%%&endlocal&set "randomo=%Randomo%"&goto :EOF
set /a "loops=%loops%+1">nul&set /a "percent=100/%Length%">nul
set /a "percent2=%percent%*%loops%">nul&cls
echo %Percent2%%%&call :RandomVar&goto :Randomo2
:RandomVar
set "R=%random:~-1,1%"
if "%R%"=="4" (set "R=%time:~-1,1%"&goto :EOF)
if "%R%"=="9" (set "R=%time:~-4,1%"&goto :EOF)
if "%R%"=="1" (set "R=%time:~-2,1%") else (set "R=%random:~-1,1%")
goto :EOF