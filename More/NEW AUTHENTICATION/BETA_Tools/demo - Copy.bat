@echo off
set "EncryptionKeys=set encrypt=abcdefghijklmnopqrstuvwxyz!@#-= .0123456789&set decrypt=^|(7R;-U4$_JH!\* )AW@?P:C6~NGBQT95F#ZE'S.,2D"
echo Decrypting %time%
call :DecryptFile "userData.txt" "userData2.tmp"
echo Finished   %time%
type userdata2.tmp
del userdata2.tmp
pause
exit
:EncryptFile
setlocal
%EncryptionKeys%
set "fileToEncrypt=%~1"
set "OutputFile=%~2"
if "%OutputFile%" == "" set "OutputFile=%fileToEncrypt%"
set "encrypt2=%encrypt%"
set "decrypt2=%decrypt%"
(for /f "delims=" %%a in (%fileToEncrypt%) do (set "line=%%a"&call :EncryptionProcess))> "%OutputFile%"
goto :EOF
:DecryptFile
setlocal
%EncryptionKeys%
set "fileToDecrypt=%~1"
set "OutputFile=%~2"
if "%OutputFile%" == "" set "OutputFile=%fileToDecrypt%"
set "encrypt2=%decrypt%"
set "decrypt2=%encrypt%"
(for /f "delims=" %%a in (%fileToDecrypt%) do (set "line=%%a"&call :EncryptionProcess))> "%OutputFile%"
goto :EOF
:EncryptionProcess
set "EncryptedFile="
:EncryptionProcess2
set "$1=%encrypt2%"
set "$2=%decrypt2%"
:EncryptionProcess3
if /i "%line:~0,1%"=="%$1:~0,1%" set "EncryptedFile=%EncryptedFile%%$2:~0,1%"&goto EncryptionProcess4
set "$1=%$1:~1%"&set "$2=%$2:~1%"
if defined $2 goto EncryptionProcess3
set "EncryptedFile=%EncryptedFile%%line:~0,1%"
:EncryptionProcess4
set "line=%line:~1%"
if defined line goto EncryptionProcess2
echo %EncryptedFile%
goto :eof