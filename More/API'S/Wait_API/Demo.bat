@echo off
echo This Program Will Loop This API A Number Of Times
set /p waitforInput="Enter A Number From 1-Infinity: "
:loop
call :wait %waitforInput%
color f0
call :wait %waitforInput%
color 0f
goto loop

:: Wait API Below
:wait
set waitNum=0
set waitFor=%1
if "%waitfor%" == "0" set waitfor=1
:waitLoop
set /a waitnum=%waitnum% +1>nul
if %waitnum%==%waitFor% goto :EOF
goto waitLoop