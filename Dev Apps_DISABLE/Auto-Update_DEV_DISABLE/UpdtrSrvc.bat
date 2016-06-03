@echo off
if exist "%appfolder%\DisableAutoUpdate.ini" exit 999
:: SD-Updater
:CheckForUpdates
for /F "eol=# delims=" %%A in (SDS_FILES\SD-Updater.ini) do set %%A>nul 2>&1
if exist "SDS_Files\LatestVersion.ini" del SDS_Files\LatestVersion.ini >nul 2>&1
powershell -nologo Invoke-WebRequest -OutFile "SDS_Files\LatestVersion.ini" "%Latest_Version_Log%" >nul 1>&2
if not "%errorlevel%" == "0" if "%errorlevel%" == "9009" goto InstallPowershell||goto UpdaterError
if not exist "SDS_Files\LatestVersion.ini" goto UpdaterError
for /F "eol=# delims=" %%A in (SDS_FILES\LatestVersion.ini) do set %%A
if "%OnlineVersion%" GTR "%SDS_Version%" goto UpdateAvailable
:NoUpdates
exit 999
:UpdaterError
if exist "%appfolder%\HideErrorMessages.ini" exit 999
call :Notify "There was an error while checking for updates, please check your internet connection." "Error - SD-Security"
%extd% /messagebox "Error while checking for updates - SD-Security" "There was an error while checking for updates, please check your internet connection.  If you keep getting this error, check that your firewall isn't blocking Windows Powershell."
exit 999
:UpdaterError2
if exist "%appfolder%\HideErrorMessages.ini" exit 999
call :Notify "There was an error while downloading the update, please check your internet connection." "Error - SD-Security"
%extd% /messagebox "Error while downloading update - SD-Security" "There was an error while downloading the update, please check your internet connection. Would you like to try again?" 4
if "%result%" == "6" goto :DownloadUpdate
exit 999
:UpdateAvailable
call :Notify "An Update For SD-Security Has Published, V.%onlineVersion%" "Update SD-Security"
%extd% /messagebox  "Update SD-Security" "SD-Security V.%onlineVersion% is available to download, would you like to update SD-Security?" 4
if "%result%" == "6" goto :DownloadUpdate
exit 999
:DownloadUpdate
call :Notify "Downloading Update..." "SD-Security"
powershell -nologo Invoke-WebRequest -OutFile "SD-Security2.exe" "%Latest_Version_EXE%" >nul 1>&2
if not "%errorlevel%" == "0" goto UpdaterError2
if not exist "SD-Security2.exe" goto UpdaterError2
:InstallUpdateNow
%extd% /messagebox  "Install Update" "The update for SD-Security has been downloaded, would you like to install it now?" 4
if "%result%" == "6" goto :StartInstallingUpdate
exit 999
:StartInstallingUpdate
call start "Updating SD-Security" cmd /c "color f0&title SD-Security EXE Updater&mode con: cols=90 lines=25&echo -----------------------------===============================-----------------------------&echo -------------------------------= SD-Security EXE Updater =-------------------------------&echo -----------------------------===============================-----------------------------&echo -----------------------------===============================-----------------------------&timeout 2 >nul&echo                     Renaming Old SD-Security To 'SD-Security_old.exe'&ren SD-Security.exe "SD-Security_old.exe"&echo                       Renaming New SD-Security To 'SD-Security.exe'&ren SD-Security2.exe "SD-Security.exe"&echo                               Finished! SD-Security Updated&echo.&echo                    Press Any Key To Exit The Updater And Start SD-Security&pause >nul&call start SD-Security.exe&exit 999"
exit 999
:InstallPowershell
if exist "%appfolder%\HideErrorMessages.ini" exit 999
%extd% /messagebox "Install Powershell" "Powershell is required to install updates for SD-Security!"
exit 999
:Notify
:: Notify API, This API Uses Powershell To Show A Popup In The Notification Tray That Can Display Custom Text
:: Usage: CALL :Notify [Message] [Message Title] [Tray Icon File]
@set one=%~1
@set two=%~2
@set three=%~3
@if "%one%" == "" @set one=Switch To SD-Security
@if "%two%" == "" @set two=SD-Security
@if "%three%" == "" @set three=Favicon.ico
@echo [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") > "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify = New-Object System.Windows.Forms.NotifyIcon >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.Icon = "%three%" >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.BalloonTipIcon = "None" >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.BalloonTipText = "%one%" >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.BalloonTipTitle = "%two%" >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.Visible = ^$True >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.ShowBalloonTip(10000) >> "%temp%\Notify_API_SDS.ps1"
@call start "Notify API" /min cmd /c "powershell -executionpolicy bypass -File "%temp%\Notify_API_SDS.ps1""
@goto :EOF