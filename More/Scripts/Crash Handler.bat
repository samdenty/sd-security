@echo off
echo call sd-security.bat|cmd
exit
if errorlevel 999 exit
color F0
mode con: cols=80 lines=27
cls
title Crash Handler - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                 Crash Handler                    %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo              It Was Detected That SD-Security Has Just Crashed
echo      This Crash Happened Due To A Bug, Would You Like To Send An Email To
echo                        SD-Security Explaining What Happened?
echo.
echo ÛÛÛ
echo Û1Û  Yes (You Need An Email Account)
echo Û2Û  No
set /p sendCrashEmail="Ûþ "
if "%sendCrashEmail%" == "1" goto sendEmail
goto end
:sendEmail
start mailto:Samdenty99@outlook.com
goto end
:end
set year=20%date:~-2,2%
cls
title Exit - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ  EXIT  Signed Out
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo     ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo.    ÛÛ Û Û Û Û Û Û Û Û Û Û Û Û ÛÛ
echo     Û ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ Û
echo     ÛÛÛ     -------           ÛÛÛ
echo     Û Û      \  /^| \          Û Û
echo     ÛÛÛ       \/ ^|   \        ÛÛÛ
echo     Û Û      / \ ^|     \      Û Û
echo     ÛÛÛ    /    \^|       \    ÛÛÛ
echo     Û Û   þþþþþþþþþþþþþþþþþ   Û Û
echo     ÛÛÛ   ¸%year% SD-Security   ÛÛÛ
echo     Û ÛþþþþþþþþþþþþþþþþþþþþþþþÛ Û
echo     ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
echo     ÛÛ Û Û Û Û Û Û Û Û Û Û Û Û ÛÛ
echo     ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
timeout 2 >nul /nobreak
exit