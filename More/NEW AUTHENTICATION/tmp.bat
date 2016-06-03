@echo off
call :Encrypt "t.txt" "t2.txt"
pause
exit
:Encrypt
set encrypt2=abcdefghijklmnopqrstuvwxyz!@#-= .0123456789&set decrypt2=+(7R;-h4$_JH!\* )AW@?P:C6~NGBQT95F#ZE'S.,2D&set "file=%~1"&set "OutputFile=%~2"&if "%~2"=="" set "OutputFile=%file%"
(for /f "delims=" %%a in (%file%) do (set "#=%%a"&call:RealEn))> "%OutputFile%"&goto :EOF
:RealEn
set "EncryptedFile="
:RealEn2
set "En1=%encrypt2%"&set "En2=%decrypt2%"
:RealEn3
if /i not "%#:~0,1%"=="%En1:~0,1%" (set "En1=%En1:~1%"&set "En2=%En2:~1%") else (set "EncryptedFile=%EncryptedFile%%En2:~0,1%"&goto RealEn4)
if defined En2 (goto RealEn3) else (set "EncryptedFile=%EncryptedFile%%#:~0,1%")
:RealEn4
set "#=%#:~1%"
if defined # (goto RealEn2) else (echo.%EncryptedFile%&goto :EOF)