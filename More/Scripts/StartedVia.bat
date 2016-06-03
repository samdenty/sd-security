@echo off
set SCRIPT=%0
set Ap2="
echo %SCRIPT:~0,1% | findstr /l %Ap2% > NUL
if "%ERRORLEVEL%" == "0" (set StartedVia=explorer) else (set StartedVia=cmd)
echo %startedVia%
pause