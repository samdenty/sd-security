@echo off
if not exist "Harvest" md Harvest
set Rec=1
title Project Master Control Data Harvest
echo Welcome To Project Master-Control!
echo.
echo What Would You Like To Do?
echo 1: Record Another Record
echo 2: Compile Final TXT File
set /p op=":: "
if "%op%"=="1" goto :Record
if "%op%"=="2" goto :Compile
exit
:Record
echo.
if exist "Harvest\Log%Rec%.txt" set /a rec=%rec%+1 >nul&goto :Record
echo Please Enter In The URL To Login:
set /p "url="
echo %url%>"Harvest\Log%Rec%.txt"
echo Please Enter The Username:
set /p "user="
echo %user%>>"Harvest\Log%Rec%.txt"
echo Please Enter The Password:
set /p "pass="
echo %pass%>>"Harvest\Log%Rec%.txt"
echo.
echo LOG SAVED, "SECURITY IS JUST A WORD", REMEMBER THAT.
pause >nul
exit
:Compile
set Rec=0
if exist Compile.txt del Compile.txt
:loop
set /a "Rec=%Rec%+1" >nul 2>&1
if exist "Harvest\Log%Rec%.txt" (echo.>>"Compile.txt"&type Harvest\Log%Rec%.txt>>"Compile.txt") else (echo Done!&pause >nul&exit)
goto :loop