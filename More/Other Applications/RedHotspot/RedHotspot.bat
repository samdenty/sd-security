@echo off
if "%extd%"=="" set extd=REM
if '%b2eextd%'=='' set b2eextd=%extd%
title RedHotspot
set "WinTitle=RedHotspot#%random%"
set "win=RedHotspot Error!"
net file>nul 2>&1||call start "%WinTitle%" /min %b2eextd% /messagebox "%win%" "The RedHotspot service needs to be launched as admin!" 16&&call :ConfigWin&&exit
netsh wlan start hostednetwork>"%temp%\RedHotspot_Log"||goto :ErrorSetup
exit
:ErrorSetup
call start "%WinTitle%" /min %b2eextd% /messagebox "%win%" "The RedHotspot service cannot be started, the log will be opened" 16&call :ConfigWin
notepad "%temp%\RedHotspot_Log"
exit
:ConfigWin
%extd% /sleep 5
%extd% /hidewindow "%WinTitle%"
%extd% /maketoolwindow "%Win%"
%extd% /setforegroundwindow "%Win%"
%extd% /windowontop "%Win%"
goto :EOF