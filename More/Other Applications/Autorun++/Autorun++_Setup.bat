@echo off
echo Please Enter The Drive Letter That You Want To Setup Autorun++ On:
set /p "Drive=: "
if exist "%Drive%:\Autorun++.inf" attrib -h -s "%Drive%:\Autorun++.inf"&goto :Notepad
(echo Enter the autorun++ commands in this file,
echo use the programming language "Batch CMD Scripting", A MS-DOS based language)>"%Drive%:\Autorun++.inf"
:Notepad
call notepad.exe "%Drive%:\Autorun++.inf"
echo SAVED!
echo Autorun++ entry saved
echo.
attrib +h +s "%Drive%:\Autorun++.inf"
pause
exit
