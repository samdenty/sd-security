@echo off
title Autorun++
color F0
:Refresh
setlocal
echo                 ÛÛ Creating Map Of Currently Connected Drives ÛÛ
echo                 ÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛ
set "AD=set "AllDrives=ABCDEFGHIJKLMNOPQRSTUVWXYZ""
set "Refresh="
set "Drive="
call :InitiateSearch
:Autorun_Loop
call :InitiateCheck
if "%Refresh%"=="1" (echo                 ÛÛßßßßßßßßßßßßß %Drive%:\ Disconnected ßßßßßßßßßßßßßÛÛ&endlocal&goto :Refresh)
if defined Drive (echo                 ÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛÛ&echo                 ÛÛ ÛÛ ÛÛ ÛÛ  New Drive Detected E:\  ÛÛ ÛÛ ÛÛ ÛÛ&call :Autorun++&set "Drive="&endlocal&goto :Refresh)
set "Drive="
goto :Autorun_Loop
:InitiateCheck
%AD%
:CheckDrives
if "%AllDrives%"=="" goto :EOF
if exist "%AllDrives:~0,1%:\" (set "%AllDrives:~0,1%"|findstr "%AllDrives:~0,1%=0">nul 2>&1&&set "Drive=%AllDrives:~0,1%"&&goto :EOF) else (set "%AllDrives:~0,1%"|findstr "%AllDrives:~0,1%=1">nul 2>&1&&set "Drive=%AllDrives:~0,1%"&&set Refresh=1&&goto :EOF)
set AllDrives=%AllDrives:~1%
goto :CheckDrives
:InitiateSearch
  %AD%
  :SearchDrives
    if "%AllDrives%"=="" goto :EOF
    if exist "%AllDrives:~0,1%:\" (set "%AllDrives:~0,1%=1") else (set "%AllDrives:~0,1%=0")
    set AllDrives=%AllDrives:~1%
  goto :SearchDrives

:Autorun++
echo                 ÛÛ ÜÜ                                      ÜÜ ÛÛ
if exist "%Drive%:\Autorun++.inf" (echo                 ÛÛ ßß           Running Autorun++          ßß ÛÛ&goto RunAutorun++) else (echo                 ÛÛ ßß   Autorun++ not configured on %Drive%:\    ßß ÛÛ)
goto :EOF
:RunAutorun++
(pushd %Drive%:\
if not exist "SDS_Files\Autorun++" md SDS_Files\Autorun++
attrib +h +s "SDS_Files"
attrib -h -s "Autorun++.inf"
copy "Autorun++.inf" "SDS_Files\Autorun++\Autorun++.bat"
attrib +h +s "Autorun++.inf"
call start "" "SDS_Files\Autorun++\Autorun++.bat") >nul 2>&1
goto :EOF