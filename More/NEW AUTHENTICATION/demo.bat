@echo off
set "EncryptionKeys=set encrypt=abcdefghijklmnopqrstuvwxyz!@#-= .0123456789&set decrypt=+(7R;-h4$_JH!\* )AW@?P:C6~NGBQT95F#ZE'S.,2D"
echo Decrypting %time%
setlocal
set U=&set P=
call :Encrypt /decrypt "UserProfile.sys"
endlocal&set "User1=%U%"&set "Password1=%P%"
echo Finished   %time%
echo %User1%
echo %Password1%
pause
exit

:Encrypt
%EncryptionKeys%&set "file=%~2"
if /i "%~1"=="/decrypt" (set "encrypt2=%decrypt%"&set "decrypt2=%encrypt%") else (set "encrypt2=%encrypt%"&set "decrypt2=%decrypt%")
(for /f "delims=" %%a in (%file%) do (set "#=%%a"&call:RealEn))&goto :EOF
:RealEn
set "EncryptedFile="
:RealEn2
set "En1=%encrypt2%"&set "En2=%decrypt2%"
:RealEn3
if /i not "%#:~0,1%"=="%En1:~0,1%" (set "En1=%En1:~1%"&set "En2=%En2:~1%") else (set "EncryptedFile=%EncryptedFile%%En2:~0,1%"&goto RealEn4)
if defined En2 (goto RealEn3) else (set "EncryptedFile=%EncryptedFile%%#:~0,1%")
:RealEn4
set "#=%#:~1%"
if defined # (goto RealEn2) else (set "%EncryptedFile%"&goto :EOF)