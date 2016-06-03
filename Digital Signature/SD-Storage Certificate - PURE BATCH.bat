@echo off
if exist "%temp%\GotAdmin.tmp" goto StartOfScript
call :CheckForCert
NET FILE 1>NUL 2>NUL
if "%errorlevel%"=="0" (goto StartOfScript) else (goto getAdmin)
:StartOfScript
call :Startup
del %temp%\GotAdmin.tmp >nul 2>&1
NET FILE 1>NUL 2>NUL
if not "%errorlevel%" == "0" goto getAdmin
call :CheckForCert
echo %action%
if "%action%" == "Uninstall" goto :uninstallCert
if "%action%" == "Install" goto :installCert

:: Certificate Installer Screen
:installCert
cls
color f8
title Certificate Installer - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                 Certificate Installer
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo            Would You Like To Install The SD-Storage Certificate?
echo Û1Û  Yes
echo Û2Û  No
set /p option="Ûþ "
if "%option%" == "1" goto StartInstallCert
if "%option%" == "2" echo Exiting... &timeout 2>nul&exit
call :ErrorCert
goto :InstallCert

:: Certificate Uninstaller Screen
:uninstallCert
cls
color f8
title Certificate Uninstaller - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ               Certificate Uninstaller
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo           Would You Like To Uninstall The SD-Storage Certificate?
echo Û1Û  Yes
echo Û2Û  No
set /p option="Ûþ "
if "%option%" == "1" goto StartUninstallCert
if "%option%" == "2" echo Exiting... &timeout 2>nul&exit
call :ErrorCert
goto :uninstallCert

:: Invalid Option Screen
:ErrorCert
color c4
echo        Invalid Option! Enter One Of The Numbers Above And Press Enter
timeout 2 >nul
goto :EOF
:Startup
mode con: cols=80 lines=27&:: Set Window Size
color f8&:: Set Window Color
cls&:: Clear The Screen Of Any Text
goto :EOF

:: Check For Certificate
:CheckForCert
ver >nul
certutil -verifystore TrustedPublisher 5d9460fb41008c9f4a26fbf270dccf63 >nul
if "%errorlevel%" == "0" (set action=Uninstall) else (set action=Install&ver >nul&goto :EOF)
certutil -verifystore root 5d9460fb41008c9f4a26fbf270dccf63 >nul
if "%errorlevel%" == "0" (set action=Uninstall) else (set action=Install)
ver >nul
goto :EOF

:StartInstallCert
echo                           Installing Certificate...
certutil -addstore TrustedPublisher SD-Storage.cer >nul
certutil -addstore root SD-Storage.cer >nul
goto FinishedCert
:StartUninstallCert
echo                          Uninstalling Certificate...
certutil -delstore TrustedPublisher 5d9460fb41008c9f4a26fbf270dccf63 >nul
certutil -delstore root 5d9460fb41008c9f4a26fbf270dccf63 >nul
:FinishedCert
echo                                 Finished!
timeout 10>nul
exit

:getAdmin
call :Startup
title Admin Permissions Required - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ            Admin Permissions Required
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo      Admin Permissions Are Required To %Action% The SD-Storage Certificate
echo          Would You Like To Restart This Program With Admin Permissions?
echo Û1Û  Yes
echo Û2Û  No
set /p option="Ûþ "
if "%option%" == "1" goto GetAdminNow
if "%option%" == "2" echo Exiting... &timeout 2>nul&exit
call :error
goto :getAdmin
:GetAdminNow
title Requesting Admin Permissions - SD-Security©
cls
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ               Admin Permissions                  %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo            R e q u e s t i n g   A d m i n   P e r m i s s i o n s
echo            -------------------------------------------------------
echo     Click ßYesß On The Following Window (You Might Have To Enter A Password)
echo.
echo                Opening User Account Control (UAC) Window...
timeout 1 >nul /nobreak
set "batchPath=%~0"
echo TEMP FILE> "%temp%\GotAdmin.tmp"
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "%batchPath%", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs"
exit