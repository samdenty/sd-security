@echo off
call :DecryptFile "%file2%" "Decrypted_Version.txt"

:EncryptFile
setlocal
set encrypt=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#-/\ .0123456789
set decrypt=dbhlceaitjkzqromsyvnfwxupg/YERT-U4LKJH!OG DSWAXP1CZVN\BQMI95F#6708.32@
set fileToEncrypt=%~1
set OutputFile=%~2
if "%OutputFile%" == "" set OutputFile=%fileToEncrypt%
set encrypt2=%encrypt%
set decrypt2=%decrypt%
(for /f "delims=" %%a in (%fileToEncrypt%) do (set line=%%a&call :EncryptionProccess))> "%OutputFile%"
goto :eof
:DecryptFile
setlocal
set encrypt=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#-/\ .0123456789
set decrypt=dbhlceaitjkzqromsyvnfwxupg/YERT-U4LKJH!OG DSWAXP1CZVN\BQMI95F#6708.32@
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
if "%line:~0,1%"=="%$1:~0,1%" set EncryptedFile=%EncryptedFile%%$2:~0,1%&goto EncryptionProccess4
set $1=%$1:~1%
set $2=%$2:~1%
if defined $2 goto EncryptionProccess3
set EncryptedFile=%EncryptedFile%%line:~0,1%
:EncryptionProccess4
set line=%line:~1%
if defined line goto EncryptionProccess2
echo %EncryptedFile%
goto :eof