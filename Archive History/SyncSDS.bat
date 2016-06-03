copy /Y "%outputFile%" "Archive History\Temp EXE Archives\%SDS_Version2%.exe" >nul
if not exist "D:\Unlocked\Dropbox\SD-Security" goto :EOF
copy /Y "%outputFile%" "D:\Unlocked\Dropbox\SD-Security\SD-Security.exe" >nul
copy /Y "%VerHistory%" "D:\Unlocked\Dropbox\SD-Security\History.SDS_History" >nul
copy /Y "SD-Security.zip" "D:\Unlocked\Dropbox\SD-Security\SD-Security.zip" >nul
set "VersionLetter="
set /p VersionLetter="Enter Version Letter {A,B,C} (If Applicable): "
(
echo #SD-Updater
echo OnlineVersion=%SDS_Version2%%VersionLetter%
)>"D:\Unlocked\Dropbox\SD-Security\OnlineVersion.txt"