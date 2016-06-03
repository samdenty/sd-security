@echo off
if exist "%temp%\GotAdmin.tmp" goto StartOfScript
call :CheckForCert
NET FILE 1>NUL 2>NUL
if "%errorlevel%" == "0" ( goto StartOfScript ) else ( goto getAdmin )
:StartOfScript
call :CheckForCert
del %temp%\GotAdmin.tmp >nul 2>&1
NET FILE 1>NUL 2>NUL
if not "%errorlevel%" == "0" goto getAdmin
echo Switching To %action% Mode
if "%action%" == "Uninstall" goto :uninstallCert
if "%action%" == "Install" goto :installCert

:: Certificate Installer Screen
:installCert
%extd% /messagebox "SD-Storage Certificate Installer" "Would you like to install the SD-Storage certificate?" 36
if "%result%" == "6" goto StartInstallCert
echo Result: 'No', Exiting...
exit /b

:: Certificate Uninstaller Screen
:uninstallCert
%extd% /messagebox "SD-Storage Certificate Uninstaller" "Would you like to uninstall the SD-Storage certificate?" 36
if "%result%" == "6" goto StartUninstallCert
echo Result: 'No', Exiting...
exit /b

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
echo Installing Certificate...
certutil -addstore TrustedPublisher SD-Storage.cer >nul
certutil -addstore root SD-Storage.cer >nul
goto FinishedCert
:StartUninstallCert
echo Uninstalling Certificate...
certutil -delstore TrustedPublisher 5d9460fb41008c9f4a26fbf270dccf63 >nul
certutil -delstore root 5d9460fb41008c9f4a26fbf270dccf63 >nul
:FinishedCert
echo Successfully %action%ed Certificate
%extd% /messagebox "%action%ed Successfully" "The SD-Storage Certificate Has Successfully Been %action%ed!"
exit /b

:getAdmin
echo Admin Permissions Required, Querying User
%extd% /messagebox "ERROR" "Admin Permissions Are Required To %action% The Certificate, Request?" 1
if "%result%" == "1" goto :GetAdminNow
echo Result: 'No', Exiting...
exit /b
:GetAdminNow
echo Result: 'Yes', Launching UAC
set "batchPath=%~0"
echo TEMP FILE> "%temp%\GotAdmin.tmp"
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "%batchPath%", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs"
exit /B