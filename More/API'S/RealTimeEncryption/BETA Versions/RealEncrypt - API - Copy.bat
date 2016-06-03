@echo off
setlocal enabledelayedexpansion
call :RealEncrypt "hi"
echo %RealEncrypt%
pause
exit

:RealEncrypt
set a=%%%%z%%%%&set b=%%%%y%%%%
set c=%%%%x%%%%&set d=%%%%w%%%%
set e=%%%%v%%%%&set f=%%%%u%%%%
set g=%%%%t%%%%&set h=%%%%s%%%%
set i=%%%%r%%%%&set j=%%%%q%%%%
set k=%%%%p%%%%&set l=%%%%o%%%%
set m=%%%%n%%%%&set n=%%%%m%%%%
set o=%%%%l%%%%&set p=%%%%k%%%%
set q=%%%%j%%%%&set r=%%%%i%%%%
set s=%%%%h%%%%&set t=%%%%g%%%%
set u=%%%%f%%%%&set v=%%%%e%%%%
set w=%%%%d%%%%&set x=%%%%c%%%%
set y=%%%%b%%%%&set z=%%%%a%%%%
echo %~1 > "%temp%\SD-RealEncrypt.tmp"
::SD-Security Encryption System
for /f "tokens=*" %%l in ('findstr /r /n "^" "%temp%\SD-RealEncrypt.tmp"') do @(
set "line=%%~l"&set "line=!line:*:=!"
call :strlen
if !line_len!==0 (
echo() else (
set outline_e=
for /l %%i in (0,1,!line_len!) do (
set "char=!line:~%%i,1!"
if "!char!"==" " set "outline_e=!outline_e! "
echo !char!|findstr.exe /r "[A-Za-z]" >nul
if errorlevel 1 set "outline_e=!outline_e!!char!"&set RealEncrypt=!outline_e!&del %temp%\SD-RealEncrypt.tmp&goto :EOF
set char_e=
call :enc "!char!" "char_e"
set "outline_e=!outline_e!!char_e!"
set RealEncrypt=!outline_e!))
del %temp%\SD-RealEncrypt.tmp
goto :EOF
:enc
call set "%~2=!%~1!"&goto :EOF
:strlen
(setlocal EnableDelayedExpansion&set "s=!line!#"&set "len=0"
for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (if "!s:~%%P,1!" NEQ "" (set /a "len+=%%P"&set "s=!s:~%%P!")))
endlocal&set "line_len=%len%"&goto :EOF