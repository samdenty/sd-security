@echo off
%settheme%
set "Set /p=call:AskString"
set "echo=<nul set /p ="
if /i not "%FullPermissions%"=="Yes" goto :NoPermissions
:Spoofer
cls
title Memory Spoofer - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                  Memory Spoofer                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  Account Options
echo €2€  Manual Variable Spoofer
echo €3€  Custom Command
echo €4€  Exit App
%Set /p% "SpooferOp=€˛ "
if "%SpooferOp%"=="1" goto :AccountOps
if "%SpooferOp%"=="2" call :ManualSpoofer
if "%SpooferOp%"=="3" goto :CustomCommand
if "%SpooferOp%"=="4" goto :end
goto :Spoofer
:CustomCommand
title Custom Command - SD-Security©
echo.
echo €€€€ Please Choose How To Execute Command
echo €1€  Inside SD-Security (Recommended)
echo €2€  Inside App
CHOICE /C 12 /N /M "€˛ "
IF ERRORLEVEL 2 set XType=DISABLED&set tMode=Terminal Mode&goto XCommand
IF ERRORLEVEL 1 set XType=ENABLED&set tMode=Single Command Terminal
:XCommand
cls
color 07
title terminal.sds
%echo% SD-Security &call :color 0a "%tMode%"&%echo% . [&call :color 0f "Version 1.0"&%echo% ]&echo.
echo SD-Storage∏ 2015, All Rights Reserved.
echo.
echo COMMAND REDIRECTION %XType%
:XCommand2
echo.
if "%cd:~-1%"=="\" (set "Directory=%cd%") else (set "Directory=%cd%\")
set "cmdCommand="
%echo% %directory%&call :color 0d "$Terminal"&set /p "cmdCommand=>"
if not defined CmdCommand (goto :XCommand2)
if "%XType%"=="ENABLED" goto PostCommand
call :color 0b "CMD OUTPUT("&echo.&%cmdCommand%
goto :XCommand2
:PostCommand
echo.
echo €€€€ What Would You Like To Do?
echo €1€  Terminate App And Execute Command
echo €2€  Postpone The Command
echo €3€  Change Command
echo €4€  Cancel Command
CHOICE /C 1234 /N /M "€˛ "
IF ERRORLEVEL 4 goto :Spoofer
IF ERRORLEVEL 3 goto XCommand
IF ERRORLEVEL 2 set "AppCommand=%cmdCommand%"&goto :Spoofer
IF ERRORLEVEL 1 set "AppCommand=%cmdCommand%"&echo Executing Command...&timeout 1 >nul&goto :end
goto :Spoofer
:AccountOps
cls
title Account Options - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 Account Options                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo    ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo    € USER ACCOUNT 1 €
echo €ﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo €1€ Change Username € Value="%user1%"
echo €2€ Change Password € Value="%Password1%"
echo €‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.
echo    ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo    € USER ACCOUNT 2 €
echo €ﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo €3€ Change Username € Value="%user2%"
echo €4€ Change Password € Value="%password2%"
echo €‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo €5€  Back
%Set /p% "SpooferOp=€˛ "
if "%SpooferOp%"=="1" call :ChangeAccount 1 U
if "%SpooferOp%"=="2" call :ChangeAccount 1 P
if "%SpooferOp%"=="3" call :ChangeAccount 2 U
if "%SpooferOp%"=="4" call :ChangeAccount 2 P
if "%SpooferOp%"=="5" goto :Spoofer
goto :AccountOps
:ChangeAccount
echo.
echo Enter New Value:
%set /p% "SData=€˛ "
if "%~1"=="1" (if "%~2"=="U" (set "User1=%SData%") else (set "Password1=%SData%")) else (if "%~2"=="U" (set "User2=%SData%") else (set "Password2=%SData%"))
goto :EOF
:ManualSpoofer
echo.
echo Enter Variable To Spoof, FORMAT: VarName=VarValue
echo.
set "VarSpoofer=null=null"
Set /p "VarSpoofer=set "
set %VarSpoofer%
goto :EOF
:Color
if not exist "C:\windows\system32\findstr.exe" %echo% %~2&goto :EOF
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd
goto :EOF
:AskString
set "StringName=%*"
set "StringName=%StringName:"=%"
set /p %StringName%
for /f "tokens=1" %%a in ('echo %StringName%') do set "StringName=%%a"&goto AskStringNext
:AskStringNext
(set %StringName% 2>nul|findstr /r /c:"[&|<>""]"&if not errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Enter Special Characters!&goto :AskString)) 1>nul
(set %StringName% 2>nul|findstr "Environment variable %StringName% not defined"&if errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Leave This Field Blank!&goto :AskString)) 1>nul
goto :EOF
:CheckString
set "StringName=%*"
(set %StringName% 2>nul|findstr /r /c:"[&|<>""]"&if not errorlevel 1 (set "%StringName%="&goto :EOF)) 1>nul
(set %StringName% 2>nul|findstr "Environment variable %StringName% not defined"&if errorlevel 1 (set "%StringName%="&goto :EOF)) 1>nul
goto :EOF
:NoPermissions
cls
title ERROR: Full Permissions Required - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                       ERROR                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                Full Permissions Are Required For Spoofer To Work!
echo.
echo  Why? Because Spoofer Requires Extra Permissions To Modify The Variables Of SDS
echo.
echo   How Do I Do This? Simply Type 'Full' Into The Custom Apps Launcher, Sign In
echo                         And Launch Spoofer From The Menu
echo.
echo                      Press Any Key To Return To SD-Security
pause >nul
:end