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
:: Main Code
EXIT /B 999

:CrashHelper
set restart=0
if "%1" == "/?" call :CommandSwitchHelp&call cmd /f:f0 /c %0
call cmd /f:f0 /c %0 %*
:: Crash-Helper API Deactive (All Errors Below Result In A Crash)
if errorlevel 999 exit
:ReportCrash
echo Program Crashed / Not Exited Safely (Use 'EXIT /B 999' To Exit Safely)
Pause >nul
exit /b 999