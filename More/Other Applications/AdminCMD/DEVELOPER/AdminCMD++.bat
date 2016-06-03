@echo off&pushd %temp%&title @AdminCMD++:Auth:@&set VBS=ClipboardAdminCMD++.vbs&set Clip=Clipboard.AdminCMD++&echo $AdminCMD$.Initiated|clip
set "chk=type "%Clip%"|findstr /B /C:"&set "password=run"
:AS
if not exist "%VBS%" call :Gen
@del "%Clip%">nul 2>&1&cscript "%VBS%">nul 2>&1
%chk%"$ADMINCMD$.Kill">nul 2>&1&&echo AdminCMD-Kill Command Executed...&&echo $ADMINCMD$.Kill.Success|clip&&exit 999
%chk%"$ADMINCMD$.Execute*%password%*&">nul 2>&1||goto :AS
echo PASSWORD ACCEPTED! Executing Command With ADMIN Permissions...
@del AdminCMD++.bat>nul 2>&1
ren "%Clip%" "AdminCMD++.bat"
echo $AdminCMD$.Success|clip
call cmd /c "prompt $LAdmin$G&%temp%\AdminCMD++.bat" 2>nul&goto :AS
:Gen
(echo set Shell = CreateObject^("WScript.Shell"^)
echo set HTML = CreateObject^("htmlfile"^)&echo AdminCMD = "%Clip%"
echo set FileSystem = CreateObject^("Scripting.FileSystemObject"^)
echo set File = FileSystem.OpenTextFile^(AdminCMD, 2, true^)
echo file.writeLine HTML.ParentWindow.ClipboardData.GetData^("text"^)
echo file.close)>%VBS%&goto :EOF
