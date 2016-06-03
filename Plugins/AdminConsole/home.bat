@echo off
set "On=þ"
set "Off= "
set "switch=call :Switch"
call :AdminCMDCheck
if /i "%AdminCMDStatus%"=="Active" (%switch% switch1 on) else (%switch% switch1 off)
:AdminCMDScreen2
cls
title AdminConsole - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                   AdminConsole                   %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo Û1%switch1%Û  Perform AdminCMD Command
echo Û2ÛÛ  Back
CHOICE /C 12 /N /M "Ûþ "
IF ERRORLEVEL 2 goto :EOF
IF ERRORLEVEL 1 call :AdminCMD
goto :AdminCMDScreen2
:AdminCMD
set /p "Command=Ûþ "
call :AdminCMDRunCheck "%Command%"
goto :AdminCMDScreen2
:AdminCMDCheck
set "AdminCMDStatus=Deactive"
tasklist /NH /FI "WINDOWTITLE eq Administrator:  @AdminCMD:Auth:@"|findstr /V /B /C:"INFO:">nul 2>&1&&set "AdminCMDStatus=Active"
goto :EOF
:AdminCMDRunCheck
call :AdminCMDCheck
if /i "%AdminCMDStatus%"=="Deactive" (echo AdminCMD API Deactive!&timeout 3 >nul)
:AdminCMDRun
:: RUN ADMIN COMMMAND
pushd "%temp%"
set "AdminCMD=AdminCMD%random%.ini"
<nul set /p "=%~1"> "%AdminCMD%"
del /F "AdminCMD.bat" >nul 2>&1
:AdminCMDRun3
copy /Y %AdminCMD% "AdminCMD.bat" >nul 2>&1
if not "%errorlevel%"=="0" (goto :AdminCMDRun3) else (popd&goto :EOF)
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