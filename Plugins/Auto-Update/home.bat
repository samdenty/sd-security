@echo off
%settheme%
if "%appfolder%" == "" set "Appfolder=%cd%"
pushd "%AppFolder%"
set "Set /p=call:AskString"
set "echo=<nul set /p ="
set "On=þ"
set "Off= "
set "switch=call :Switch"
%switch% switch2 off
if exist "DisableAutoUpdate.ini" (%switch% switch1 off) else (%switch% switch1 on)
if exist "HideErrorMessages.ini" (%switch% switch2 on) else (%switch% switch2 off)
:AutoUpdater
if "%switch1%" == "%off%" (echo.> "DisableAutoUpdate.ini") else (del "DisableAutoUpdate.ini" >nul 2>&1)
if "%switch2%" == "%off%" (del "HideErrorMessages.ini" >nul 2>&1) else (echo.> "HideErrorMessages.ini")
cls
title SDS Auto-Updater - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                    Auto-Updater                  %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo Û1%switch1%Û  Enable Auto-Updater
echo Û2%switch2%Û  Hide All Error Messages
echo Û3ÛÛ  Check For Updates
echo Û4ÛÛ  Back
CHOICE /C 1234 /N /M "Ûþ "
IF ERRORLEVEL 4 goto :end
IF ERRORLEVEL 3 popd&call start %appfolder%\UpdtrSrvc.exe&pushd "%appfolder%"&goto :AutoUpdater
IF ERRORLEVEL 2 %switch% switch2&goto :AutoUpdater
IF ERRORLEVEL 1 %switch% switch1&goto :AutoUpdater
goto :AutoUpdater


:Switch
set "SwitchName=%~1"
set "SwitchType=%~2"
if "%SwitchType%" == "" (call :InvertSwitch&goto :EOF)
if /i "%switchType%" == "ON" (set "%SwitchName%=%ON%") else (if /i "%switchType%" == "OFF" set "%SwitchName%=%Off%")
goto :EOF
:InvertSwitch
for /f "tokens=1-2 delims==" %%a in ('set %SwitchName% 2^>nul') do set "SwitchStatus=%%b">nul 2>&1
if "%SwitchStatus%" == "%Off%" (set "%SwitchName%=%ON%") else (set "%SwitchName%=%OFF%")
goto :EOF
:Color

if not exist "C:\windows\system32\findstr.exe" %echo% %~2&goto :EOF
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd
goto :EOF

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