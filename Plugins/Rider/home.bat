@echo off
set "Set /p=call:AskString"
set "echo=<nul set /p ="
color 07
title TERMINAL.MODE.SDSECURITY
cls
%echo% SD-Security &call :color 0a "Terminal Mode"&%echo% . [&call :color 0f "Version 1.4.1000"&%echo% ]&echo.
echo SD-Storage¸ 2015, All Rights Reserved.
echo.
%echo% TERMINAL^>load "plugins\mstr-ovrde_v.10.sds" "root\terminal.sds"&echo.
timeout 1 /nobreak >nul
%echo% scripts\&call :Color 0d "mstr-ovrde_v.10.sds"&%echo% ^>echo SDS 1.1.4+ master override program&echo.
echo this script will override the sd-security security system.
echo you are only allowed to use this tool IF THIS COPY OF SDS BELONG TO YOU!
echo.
echo Are you sure you want to continue? [Y,N]
%echo% files\&call :Color 0d "terminal.sds"&set /p decide=">"
if /i "%decide%" == "y" goto :StartBreach
if /i "%decide%" == "yes" goto :StartBreach
goto :home
:StartBreach
%echo% files\&call :Color 0d "terminal.sds"&%echo% ^>capturehash -sha256 -t "password.aes256"&echo.
%echo% Input file '&call :Color 0e "password.aes256"&%echo%' AES.256.BIT ENCRYPTION DETECTED&echo.
echo Capturing SHA-256 ^& MD5 hashes...
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f >nul 2>&1
for /F "eol=# delims=" %%A in (SDS_FILES\SD-Settings.ini) do set %%A>nul 2>&1
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:n >nul 2>&1
timeout 1 /nobreak>nul
%echo% SHA-256_&call :Color 0c "d6674b56c85e02918ea3514bcf3795f3f29105eadb6855a96dfe1c96cdeb7001"&echo.
%echo% MD5hash_&call :Color 0c "845a3a466c6c1b37f31383341b536c9c"&echo.
call :color 02 "FILE SCAN"&%echo% : ASCII pattern detected! #%random%&echo.&echo.
timeout 1 /nobreak>nul
%echo% files\&call :Color 0d "terminal.com"&%echo% ^>decrkey -SHA "%%SHA-256%%" -MD5 "%%MD5hash%%" -key "0VeR!|}E"&echo.
timeout 1 /nobreak>nul
echo DecrKey VERSION 5.23BETA, GonigII-Soft
echo decrypting file from key and SHA-256 (MD5 not neccesary)...
timeout 5 /nobreak >nul
echo errorlevel=0^&ouptut=^$RAM^$\decryptedpassword.NAND#4524&echo.
%echo% files\&call :Color 0d "terminal.sds"&%echo% ^>read -file "decryptedpassword.NAND#4524"^|login.sds -nogui&echo.
call :color 2a "login successful"&%echo% ! &call :color 0f "username"&%echo% :"Master Overide" &call :color 08 "password"&%echo% : "pþþþþþþ$þþþþþ;þþfþþ"&echo.
%echo% files\&call :Color 0d "terminal.sds"&%echo% ^>reboot -return ":home" -10sec&echo.
echo Cannot Auto-Sign In!
echo Select Sign-In On Home Screen And Repeat Proccess!
echo Waiting 10 Seconds, Then Returning Home
timeout 10 >nul
echo tmp> "%Security_Breach_Key%"
attrib +h +s "%Security_Breach_Key%"
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