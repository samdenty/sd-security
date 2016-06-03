@echo off
set privateKey=%random%1
set /a publicKey1b=%privatekey%*%random%
set /a publicKey1=%publickey1b%+2
set /a publicKey2b=%privatekey%*%random%
set /a publicKey2=%publickey2b%+2
set /a publicKey3b=%privatekey%*%random%
set /a publicKey3=%publickey3b%+2
set /a publicKey4b=%privatekey%*%random%
set /a publicKey4=%publickey4b%+2
cls
set /p "Message=Message [Yes/No]: "
if /i "%message%" == "Yes" set message=0&goto GenerateMyKey
set message=1
:GenerateMyKey
set /a MyKey=%PublicKey3%+%publicKey1%+%message%
echo My Key=%MyKey%
echo PrivateKey=%PrivateKey%
echo.
echo Get Value By %MyKey%/%PrivateKey%
echo If The Remainder Is Even, Then The Message Was 'Yes' Else It Was 'No'
pause