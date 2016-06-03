@echo off
echo Uninstalling Netcat...
taskkill /f /im nc.exe
del /F C:\windows\system32\nc.exe >nul 2>&1
reg delete HKLM\software\microsoft\windows\currentversion\run /v nc /f
echo Finished!