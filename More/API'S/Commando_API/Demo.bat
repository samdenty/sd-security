@echo off
:: Replace Command With The Command You Want
:: add /min to minimise the window when commando API used
set command=pause
call start "Hiya" cmd /c %command%
echo Parent Window
pause