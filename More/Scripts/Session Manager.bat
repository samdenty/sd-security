@echo off
if exist "SDS_Files\Sessions\" for /f "delims=" %%a in ('dir /B /O:D SDS_Files\Sessions\^|findstr /I ".SDS_Session"') do set SessionFile=%%a&&goto RestoreSession
call :BackupSession
:RestoreSession
set SessionName=%SessionFile:~0,-12%
cls
title Restore Session - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                Restore Session                   Signed-Out
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo                 Would You Like To Restore A Previous Session?
echo.
echo Û1Û  Yes
echo Û2Û  No
echo Û3Û  No + Delete All Sessions
set /p RestoreSession="Ûþ "
if "%RestoreSession%" == "1" goto StartRestoreSession
if "%RestoreSession%" == "3" goto DeleteRestoreSession
goto home
:DeleteRestoreSession
cls
title Delete Sessions - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                 Delete Sessions                  Signed-Out
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo              Are You Sure You Want To Delete ALL Previous Sessions?
echo.
echo Û1Û  Yes
echo Û2Û  No
set /p DelRestoreSession="Ûþ "
if "%DelRestoreSession%" == "1" del SDS_Files\Sessions\*.SDS_Session
goto home
:StartRestoreSession
for /F "eol=# delims=" %%A in (SDS_Files\Sessions\%sessionFile%) do set %%A >nul
del SDS_Files\Sessions\%sessionFile%
goto SetPasswords2
:BackupSession
if not exist "SDS_Files\Sessions" md SDS_Files\Sessions
set numberForSession=1
:checkForSessionFile
if exist "SDS_Files\Sessions\Session_%numberForSession%.SDS_Session" set /a numberForSession=%numberForSession%+1 >nul&goto checkForSessionFile
set> "SDS_Files\Sessions\Session_%numberForSession%.SDS_Session"
goto :EOF