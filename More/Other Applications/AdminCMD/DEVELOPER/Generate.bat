@echo off
(echo @echo off^&pushd %%temp%%^&title @AdminCMD++:Auth:@^&set VBS=ClipboardAdminCMD++.vbs^&set Clip=Clipboard.AdminCMD++^&echo $AdminCMD$.Initiated^|clip
echo set "chk=type "%%Clip%%"|findstr /B /C:"^&set "password=run"
echo :AS&echo if not exist "%%VBS%%" call :Gen&echo @del "%%Clip%%"^>nul 2^>^&1^&cscript "%%VBS%%"^>nul 2^>^&1
echo %%chk%%"$ADMINCMD$.Kill"^>nul 2^>^&1^&^&echo AdminCMD-Kill Command Executed...^&^&echo $ADMINCMD$.Kill.Success^|clip^&^&exit 999
echo %%chk%%"$ADMINCMD$.Execute*%%password%%*&"^>nul 2^>^&1^|^|goto :AS&echo echo PASSWORD ACCEPTED! Executing Command With ADMIN Permissions...
echo @del AdminCMD++.bat^>nul 2^>^&1&echo ren "%%Clip%%" "AdminCMD++.bat"&echo echo $AdminCMD$.Success^|clip
echo call cmd /c "prompt $LAdmin$G&%%temp%%\AdminCMD++.bat" 2^>nul^&goto :AS&echo :Gen
echo ^(echo set Shell = CreateObject^^^("WScript.Shell"^^^)&echo echo set HTML = CreateObject^^^("htmlfile"^^^)^&echo AdminCMD = "%%Clip%%"
echo echo set FileSystem = CreateObject^^^("Scripting.FileSystemObject"^^^)&echo echo set File = FileSystem.OpenTextFile^^^(AdminCMD, 2, true^^^)
echo echo file.writeLine HTML.ParentWindow.ClipboardData.GetData^^^("text"^^^)&echo echo file.close^)^>%%VBS%%^&goto :EOF)> "AdminCMD++.bat"
echo Generated!
pause >nul
%0
exit