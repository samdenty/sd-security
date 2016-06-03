@echo off
if "%~1"=="" exit
set "File=%random%"
md "%temp%\%file%"
%extd% /unzip "%~1" "%temp%\%File%"
if exist "%temp%\%file%\res\drawable-hdpi\ic_launcher.png" (copy "%temp%\%file%\res\drawable-hdpi\ic_launcher.png" "%temp%\%File%.png"&goto :Next)
if exist "%temp%\%file%\res\drawable-xhdpi\ic_launcher.png" (copy "%temp%\%file%\res\drawable-xhdpi\ic_launcher.png" "%temp%\%File%.png"&goto :Next)
if exist "%temp%\%file%\res\drawable-xhdpi-v4\icon.png" (copy "%temp%\%file%\res\drawable-xhdpi-v4\icon.png" "%temp%\%File%.png"&goto :Next)
if exist "%temp%\%file%\res\drawable-hdpi\theme_icon.png" (copy "%temp%\%file%\res\drawable-hdpi\theme_icon.png" "%temp%\%File%.png"&goto :Next)
:Next
start "" "%temp%\%File%.png"
rd /S /Q "%temp%\%file%"
