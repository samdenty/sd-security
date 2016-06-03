@echo off
setlocal enabledelayedexpansion
set encrypted_file=encrypted.txt
set unencrypted_file=plain.txt
set /p unencrypted_text="Enter Text To Encrypt: "
echo %unencrypted_text%> "%unencrypted_file%"
call :init_cipher

::SD-Security Encryption System
for /f "tokens=*" %%l in ('findstr.exe /r /n "^" "%unencrypted_file%"') do @(
set "line=%%~l"&set "line=!line:*:=!"
call :strlen
if !line_len!==0 (
echo() else (
set outline_e=
for /l %%i in (0,1,!line_len!) do (
set "char=!line:~%%i,1!"
if "!char!"==" " set "outline_e=!outline_e! "
echo !char!|findstr.exe /r "[A-Za-z]" >nul
if errorlevel 1 set "outline_e=!outline_e!!char!"&set EncryptedText=!outline_e!&del %unencrypted_file%&goto finishedEncrypting
set char_e=
call :enc "!char!" "char_e"
set "outline_e=!outline_e!!char_e!"
set EncryptedText=!outline_e!))
del %unencrypted_file%
goto finishedEncrypting
:enc
call set "%~2=!%~1!"
goto :EOF
:strlen
(setlocal EnableDelayedExpansion&set "s=!line!#"&set "len=0"
for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (if "!s:~%%P,1!" NEQ "" (set /a "len+=%%P"&set "s=!s:~%%P!")))
endlocal&set "line_len=%len%"&goto :EOF

:init_cipher
set a=%%%%z%%%%
set b=%%%%y%%%%
set c=%%%%x%%%%
set d=%%%%w%%%%
set e=%%%%v%%%%
set f=%%%%u%%%%
set g=%%%%t%%%%
set h=%%%%s%%%%
set i=%%%%r%%%%
set j=%%%%q%%%%
set k=%%%%p%%%%
set l=%%%%o%%%%
set m=%%%%n%%%%
set n=%%%%m%%%%
set o=%%%%l%%%%
set p=%%%%k%%%%
set q=%%%%j%%%%
set r=%%%%i%%%%
set s=%%%%h%%%%
set t=%%%%g%%%%
set u=%%%%f%%%%
set v=%%%%e%%%%
set w=%%%%d%%%%
set x=%%%%c%%%%
set y=%%%%b%%%%
set z=%%%%a%%%%
goto :EOF

:finishedEncrypting
echo @echo off> "encrypted_batch_file.bat"
echo set a=%%%%a%%%%>> "encrypted_batch_file.bat"
echo set b=%%%%b%%%%>> "encrypted_batch_file.bat"
echo set c=%%%%c%%%%>> "encrypted_batch_file.bat"
echo set d=%%%%d%%%%>> "encrypted_batch_file.bat"
echo set e=%%%%e%%%%>> "encrypted_batch_file.bat"
echo set f=%%%%f%%%%>> "encrypted_batch_file.bat"
echo set g=%%%%g%%%%>> "encrypted_batch_file.bat"
echo set h=%%%%h%%%%>> "encrypted_batch_file.bat"
echo set i=%%%%i%%%%>> "encrypted_batch_file.bat"
echo set j=%%%%j%%%%>> "encrypted_batch_file.bat"
echo set k=%%%%k%%%%>> "encrypted_batch_file.bat"
echo set l=%%%%l%%%%>> "encrypted_batch_file.bat"
echo set m=%%%%m%%%%>> "encrypted_batch_file.bat"
echo set n=%%%%n%%%%>> "encrypted_batch_file.bat"
echo set o=%%%%o%%%%>> "encrypted_batch_file.bat"
echo set p=%%%%p%%%%>> "encrypted_batch_file.bat"
echo set q=%%%%q%%%%>> "encrypted_batch_file.bat"
echo set r=%%%%r%%%%>> "encrypted_batch_file.bat"
echo set s=%%%%s%%%%>> "encrypted_batch_file.bat"
echo set t=%%%%t%%%%>> "encrypted_batch_file.bat"
echo set u=%%%%u%%%%>> "encrypted_batch_file.bat"
echo set v=%%%%v%%%%>> "encrypted_batch_file.bat"
echo set w=%%%%w%%%%>> "encrypted_batch_file.bat"
echo set x=%%%%x%%%%>> "encrypted_batch_file.bat"
echo set y=%%%%y%%%%>> "encrypted_batch_file.bat"
echo set z=%%%%z%%%%>> "encrypted_batch_file.bat"
echo echo Without Decryption, The Encrypted Variables Can't Be Read And So Are Blank,>> "encrypted_batch_file.bat"
echo echo But Here Is What The Variable Would Be:>> "encrypted_batch_file.bat"
echo echo "%encryptedText%">> "encrypted_batch_file.bat"
echo echo.>> "encrypted_batch_file.bat"
echo call :decrypt>> "encrypted_batch_file.bat"
echo echo With Decryption:>> "encrypted_batch_file.bat"
echo echo %encryptedText%>> "encrypted_batch_file.bat"
echo echo.>> "encrypted_batch_file.bat"
echo echo Press Any Key To Exit>> "encrypted_batch_file.bat"
echo pause^>nul >> "encrypted_batch_file.bat"
echo exit>> "encrypted_batch_file.bat"
echo :decrypt>> "encrypted_batch_file.bat"
echo set a=z>> "encrypted_batch_file.bat"
echo set b=y>> "encrypted_batch_file.bat"
echo set c=x>> "encrypted_batch_file.bat"
echo set d=w>> "encrypted_batch_file.bat"
echo set e=v>> "encrypted_batch_file.bat"
echo set f=u>> "encrypted_batch_file.bat"
echo set g=t>> "encrypted_batch_file.bat"
echo set h=s>> "encrypted_batch_file.bat"
echo set i=r>> "encrypted_batch_file.bat"
echo set j=q>> "encrypted_batch_file.bat"
echo set k=p>> "encrypted_batch_file.bat"
echo set l=o>> "encrypted_batch_file.bat"
echo set m=n>> "encrypted_batch_file.bat"
echo set n=m>> "encrypted_batch_file.bat"
echo set o=l>> "encrypted_batch_file.bat"
echo set p=k>> "encrypted_batch_file.bat"
echo set q=j>> "encrypted_batch_file.bat"
echo set r=i>> "encrypted_batch_file.bat"
echo set s=h>> "encrypted_batch_file.bat"
echo set t=g>> "encrypted_batch_file.bat"
echo set u=f>> "encrypted_batch_file.bat"
echo set v=e>> "encrypted_batch_file.bat"
echo set w=d>> "encrypted_batch_file.bat"
echo set x=c>> "encrypted_batch_file.bat"
echo set y=b>> "encrypted_batch_file.bat"
echo set z=a>> "encrypted_batch_file.bat"
echo goto :EOF>> "encrypted_batch_file.bat"
call start encrypted_batch_file.bat
echo Started Extenal Batch File With Decryption Protocol
pause
exit

Rem Beta Features:
:: Below Reads The Encrypted Text From A The File BUT Cannot Decrypt It Due To No Script To Remove The % From Some Text And Convert It Into An Actual Variable
for /f "delims=" %%A in ('type %encrypted_file%') do set realtime=%%A
echo %realtime%
pause