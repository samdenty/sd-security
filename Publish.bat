@echo off
set "WebLoc=D:\Unlocked\Dropbox\SD-Security"
copy /Y "SD-Security.exe" "%WebLoc%\SD-Security.exe"
echo.
set /p "VerNo=Enter The Version Number: "
(echo #SD-Updater&echo OnlineVersion=%VerNo%)> "%WebLoc%\OnlineVersion.txt"
echo Press Any Key To Exit
pause >nul
exit