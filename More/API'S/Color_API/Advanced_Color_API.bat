@echo off



call :color 1a "Û"
pause
exit

:color
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E#&for %%b in (1) do rem"') do (set "DEL=%%a")
set Old_CD=%cd%&cd %temp%
<nul > X set /p ".=."
set "param=%~2"
set "param=%param:"=\"%"
findstr /p /A:%1 "." "%param%\..\X" nul&<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
del X
cd %Old_CD%
goto :EOF