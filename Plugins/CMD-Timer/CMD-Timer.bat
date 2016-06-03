@echo off
mode con: cols=30 lines=3
title Timer by Sam Denty
color 3b
echo.
echo     CMD-Timer By Sam Denty
timeout 1 /nobreak >nul
:loop
cls
echo.
echo  Press any key to start timer
color f0
pause >nul
set "StartTime=%time%"&set "StartTime2=%time:~0,8%"
set "StartTime2=%StartTime2::=%"
set /a "StartTime=(%StartTime2:~2,2%*60)+(%StartTime2:~0,2%*3600)+%StartTime2:~-2%"
cls
title Timer in progress...
color 2a
echo.
echo  Press any key to stop timer
pause >nul
color cf
set "FinishedTime=%time%"&set "FinishedTime2=%time:~0,8%"
set "FinishedTime2=%FinishedTime2::=%"
set /a "FinishedTime=(%FinishedTime2:~2,2%*60)+(%FinishedTime2:~0,2%*3600)+%FinishedTime2:~-2%"
set /a "TimeItTook=%FinishedTime%-%StartTime%">nul
title %TimeItTook% Seconds
goto loop