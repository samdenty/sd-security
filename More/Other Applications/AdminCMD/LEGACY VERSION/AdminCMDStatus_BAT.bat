@echo off
set "On=þ"
set "Off= "
set "switch=call :Switch"
call :AdminCMDCheck
if /i "%AdminCMDStatus%"=="Active" (%switch% switch1 on) else (%switch% switch1 off)
goto :AdminCMDScreen2A
:AdminCMDScreen2
if "%Switch1%"=="%On%" (call :AdminCMD start) else (call :AdminCMD stop)
:AdminCMDScreen2A
cls
title AdminCMD API - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                   AdminCMD API                   %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo Û1%switch1%Û  Enable/Disable AdminCMD API
echo Û2ÛÛ  Back
CHOICE /C 12 /N /M "Ûþ "
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
if not exist "SDS_Files\AdminCMD\AdminCMD.bat" (call :AdminCMDGenerate) else (if not exist "SDS_Files\AdminCMD\StartService.vbs" call :AdminCMDGenerate2)
if not exist "SDS_Files\AdminCMD\StartServiceNoAdmin.vbs" (call :AdminCMDGenerate3)
if /i "%AdminPer%"=="Yes" (set "AdminReq=NoAdmin") else (set "AdminReq=")
wscript "SDS_Files\AdminCMD\StartService%AdminReq%.vbs" "SDS_Files\AdminCMD\AdminCMD.bat"
goto :EOF
:AdminCMDGenerate
if not exist "SDS_Files\AdminCMD\" md SDS_Files\AdminCMD
(echo @echo off^&pushd "%%temp%%"^&title @AdminCMD:Auth:@
echo set S=AdminCMD.bat^&set K=KillAdminCMD.ini
echo del /F "%%S%%"^>nul 2^>^&1^&del /F "%%K%%"^>nul 2^>^&1
echo :AS
echo if exist "%%K%%" exit
echo if not exist "%%S%%" goto AS
echo call cmd /c "pushd %sds_folder%&%temp%\%%S%%"^&call :DS^&goto :AS
echo :DS
echo del /F "%%S%%"^>nul 2^>^&1^&if exist "%%S%%" (goto :DS^) else (goto :EOF^)
)> "SDS_Files\AdminCMD\AdminCMD.bat"
:AdminCMDGenerate2
(echo Set UAC = CreateObject^("Shell.Application"^)
echo UAC.ShellExecute """" ^& WScript.Arguments^(0^) ^& """", "ELEV", "", "runas", 0
)> "SDS_Files\AdminCMD\StartService.vbs"
:AdminCMDGenerate3
echo CreateObject^("Wscript.Shell"^).Run """" ^& WScript.Arguments(0) ^& """", 0, False> "SDS_Files\AdminCMD\StartServiceNoAdmin.vbs"
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