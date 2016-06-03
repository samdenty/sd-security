@echo off
start "" /min taskkill /f /t /im PCRes_Client.exe >nul 2>&1
"C:\Program Files\Internet Explorer\iexplore.exe" -k  bit.ly/fakeUpdate
exit