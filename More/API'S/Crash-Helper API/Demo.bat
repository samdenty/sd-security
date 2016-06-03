@echo off
:: Crash-Helper API, By SD-Security
:: SD-Security Is A Windows Batch Security Program That Is Provided By XLR8 (Samuel Denty) From SD-Storage.weebly.com
:: - - - - - -
:: Crash-Helper API, Allows A Batch File To Run Code When A Batch File Crashes. This Could Allow A User To Report A Crash To Developers By Email / Write A Log / Restart Application / Anything You Want
:: This API Requires No Additional Files And No Special Commands, Compatible With: Windows XP And Higher
::::::::::::: WHEN EXITING YOUR BATCH FILE USE 'EXIT /B 999', You Have To Exit Like This Or Crash-Helper API Will See The Exit As A Crash
:: Known Bug: When Passing A Command Switch, All Of Them Work Like Normal Except '/?', So It Has To Be Specially Call'ed
::   KEYS:
::   Priority Code: This Is Code That Always Has To Be Run First (eg. Safemode Code), But Crash-Helper API Won't Protect This Code
::   Main Code    : This Is Where You Paste Your Batch Files Source
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

if "%restart%" == "0" goto CrashHelperActive
:: Priority Code
goto CrashHelper
:CrashHelperActive
echo.
echo What Would You Like To Simulate?
echo #1# A Crash
echo #2# A Exit  (EXIT /B 999)
set /p WhatToDo="# "
if "%WhatToDo%" == "1" set WhatToDo="
if "%WhatToDo%" == "2" EXIT /B 999
:CrashHelper
set restart=0
:: If You Want To Activate The '/?' Command Switch, Replace '::Help' With 'call :' Followed By The Batch Label That Should Be Used. At End Of Batch Label Put 'Goto :EOF'
if "%1" == "/?" call :CommandSwitchHelp&call cmd /f:f0 /c %0
call cmd /f:f0 /c %0 %*
:: Crash-Helper API Deactive (ALL ERRORS BELOW RESULT IN A CRASH)
if errorlevel 999 exit
:ReportCrash
echo.
echo Program Crashed! Or Not Exited Safely (Use 'EXIT /B 999' To Exit Safely)
pause >nul
exit /b 999

