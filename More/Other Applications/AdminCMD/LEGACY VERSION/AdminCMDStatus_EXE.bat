@echo off
set "On=?"
set "Off= "
set "switch=call :Switch"
call :AdminCMDCheck
if /i "%AdminCMDStatus%"=="Active" (%switch% switch1 on) else (%switch% switch1 off)
goto :AdminCMDScreen2A
:AdminCMDScreen2
if "%Switch1%"=="%On%" (call :AdminCMD start) else (call :AdminCMD stop)
:AdminCMDScreen2A
cls
title AdminCMD API - SD-Security?
echo ???????????????????????????????????????????????????????????????????????????????
echo ??? SD-Security ???                   AdminCMD API                   %status%
echo ???????????????????????????????????????????????????????????????????????????????
echo.
echo ?1%switch1%?  Enable/Disable AdminCMD API
echo ?2??  Back
CHOICE /C 12 /N /M "?? "
IF ERRORLEVEL 2 goto :DevOptions
IF ERRORLEVEL 1 %switch% switch1&goto :AdminCMDScreen2
goto :AdminCMDScreen2
:AdminCMD
if /i "%~1"=="start" (goto :AdminCMDStart)
if /i "%~1"=="stop" (echo.>"%Temp%\KillAdminCMD.ini"&goto :EOF)
if /i "%~1"=="run" (call :AdminCMDRunCheck "%~2")
goto :EOF
:AdminCMDCheck
set "AdminCMDStatus=Deactive"
tasklist /NH /FI "WINDOWTITLE eq Administrator:  @AdminCMD:Auth:@"|findstr /V /B /C:"INFO:">nul 2>&1&&set "AdminCMDStatus=Active"
goto :EOF
:AdminCMDRunCheck
call :AdminCMDCheck
if /i "%AdminCMDStatus%"=="Deactive" (call :AdminCMDStart&timeout 1 >nul)
:AdminCMDRun
:: RUN ADMIN COMMMAND
pushd "%temp%"
set "AdminCMD=AdminCMD%random%.ini"
<nul set /p "=%~1"> "%AdminCMD%"
del /F "AdminCMD.bat" >nul 2>&1
:AdminCMDRun3
copy /Y %AdminCMD% "AdminCMD.bat" >nul 2>&1
if not "%errorlevel%"=="0" (goto :AdminCMDRun3) else (popd&goto :EOF)
:AdminCMDStart
echo.>"%Temp%\KillAdminCMD.ini"
if not exist "SDS_Files\AdminCMD\StartService.vbs" call :AdminCMDGenerate2
if /i "%AdminPer%"=="Yes" (start AdminCMD.exe) else (wscript "SDS_Files\AdminCMD\StartService.vbs" "AdminCMD.exe")
goto :EOF
:AdminCMDGenerate2
(echo Set UAC = CreateObject^("Shell.Application"^)
echo UAC.ShellExecute """" ^& WScript.Arguments^(0^) ^& """", "ELEV", "", "runas", 0
)> "SDS_Files\AdminCMD\StartService.vbs"
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