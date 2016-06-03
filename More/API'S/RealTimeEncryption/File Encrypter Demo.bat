@echo off
set encrypt=abcdefghijklmnopqrstuvwxyz!@#-= .0123456789
set decrypt=+(7R;-h4$_JH!\* )AW@?P:C6~NGBQT95F#ZE'S.,2D
echo ENTER 'Decrypt' To Decrypt A File
set /p file="Enter The Name Of A File To Encrypt: "
if /i "%file%" == "Decrypt" goto decryptFiles
set /p file2="Enter The Name Of A File To Save Encrypted File To: "
call :EncryptFile "%file%" "%file2%"
echo Encrypted Result:
echo.
type %file2%
echo.
echo Press Any Key To De-Encrypt
pause >nul
call :DecryptFile "%file2%" "Decrypted_Version.txt"
echo Finished, Exiting
timeout 1 >nul
exit
:decryptFiles
cls
set /p file="Enter The Name Of A File To Decrypt: "
set /p file2="Enter The Name Of A File To Save Decrypted File To: "
call :DecryptFile "%file%" "%file2%"
echo Decrypted Result:
echo.
type %file2%
echo.
echo Press Any Key To exit
pause >nul
timeout 1 >nul
exit

:EncryptFile
setlocal
set fileToEncrypt=%~1
set OutputFile=%~2
if "%OutputFile%" == "" set OutputFile=%fileToEncrypt%
set encrypt2=%encrypt%
set decrypt2=%decrypt%
(for /f "delims=" %%a in (%fileToEncrypt%) do (set line=%%a&call :EncryptionProccess))> "%OutputFile%"
goto :eof
:DecryptFile
setlocal
set fileToDecrypt=%~1
set OutputFile=%~2
if "%OutputFile%" == "" set OutputFile=%fileToDecrypt%
set encrypt2=%decrypt%
set decrypt2=%encrypt%
(for /f "delims=" %%a in (%fileToDecrypt%) do (set line=%%a&call :EncryptionProccess))> "%OutputFile%"
goto :eof
:EncryptionProccess
set "EncryptedFile="
:EncryptionProccess2
set $1=%encrypt2%
set $2=%decrypt2%
:EncryptionProccess3
if /i "%line:~0,1%"=="%$1:~0,1%" set EncryptedFile=%EncryptedFile%%$2:~0,1%&goto EncryptionProccess4
set $1=%$1:~1%
set $2=%$2:~1%
if defined $2 goto EncryptionProccess3
set EncryptedFile=%EncryptedFile%%line:~0,1%
:EncryptionProccess4
set line=%line:~1%
if defined line goto EncryptionProccess2
echo %EncryptedFile%
goto :eof