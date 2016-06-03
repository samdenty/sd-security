@echo off
set /p 1="Enter Notification Message: "
set /p 2="Enter Notification Title: "
call :Notify "%1%" "%2%"
echo DONE
pause >nul
exit
:Notify
:: Notify API, This API Uses Powershell To Show A Popup In The Notification Tray That Can Display Custom Text
:: Usage: CALL :Notify [Message] [Message Title] [Tray Icon File]
set one=%~1
set two=%~2
set three=%~3
if "%one%" == "" set one=Switch To SD-Security
if "%two%" == "" set two=SD-Security
if "%three%" == "" set three=Favicon.ico
echo [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") > "%temp%\Notify_API_SDS.ps1"
echo ^$Notify = New-Object System.Windows.Forms.NotifyIcon >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.Icon = "%three%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipIcon = "None" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipText = "%one%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipTitle = "%two%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.Visible = ^$True >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.ShowBalloonTip(10000) >> "%temp%\Notify_API_SDS.ps1"
call start "Notify API" /min cmd /c "powershell -executionpolicy bypass -File "%temp%\Notify_API_SDS.ps1""
goto :EOF