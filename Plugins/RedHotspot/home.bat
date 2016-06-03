@echo off
::::::::::::::::::::::
:: Booting Proccess ::
::::::::::::::::::::::
if "%appfolder%" == "" set "Appfolder=%cd%"
if "%status%" == "" set "status=Signed Out"
pushd "%AppFolder%"
set "On=þ"
set "Off= "
set "ec=<nul set /p ="
set "switch=call :Switch"
set "Set /p=call:AskString"
set "clr=call :color"
if exist "DisableNetPass.ini" (%switch% switch1 on) else (%switch% switch1 off)
:NetPass
if "%Switch1%" == "%on%" (echo.> "DisableNetPass.ini") else (del DisableNetPass.ini >nul 2>&1)
cls
title NetPass - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                     NetPass                      %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo Û1%switch1%Û  Disable NetPass On Startup
echo Û2ÛÛ  Log Now
echo Û3ÛÛ  Open Log Folder
echo Û4ÛÛ  Back
CHOICE /C 1234 /N /M "Ûþ "
IF ERRORLEVEL 4 goto :end
IF ERRORLEVEL 3 call :OpenFolder
IF ERRORLEVEL 2 call start NetPass.exe
IF ERRORLEVEL 1 %switch% switch1&goto :NetPass
goto :NetPass
:OpenFolder
if exist "Logs\" (start "" Logs) else (echo  No Logs Yet Generated!&timeout 5 >nul)
goto :EOF
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
:end
popd