@echo off
title AdminCMD++ Generator
echo AdminCMD++ Version 2.1.0 (18-11-2015 / 18th of November 2015)
echo.
:: Copy below code, to integrate the generator to your program
      (echo ^@echo off^&pushd %%temp%%^&title ^@AdminCMD++:Auth:^@^&set VBS=ClipboardAdminCMD++.vbs^&set Clip=Clipboard.AdminCMD++
      echo set "chk=type "%%Clip%%"|findstr /B /C:"^&set "password=run"^&set "echo=<nul set /p ="
      echo net file^>nul 2^>^&1^&^&echo $ADMINCMD$.Initiate.Success^|clip^&^&echo      лллллллл л Initiate: Successful л Admin Permissions Granted л лллллллл^&^&echo.^|^|echo $ADMINCMD$.Initiate.Fail.NoAdmin^|clip^&^&echo     лллллллл л Initiate: Unsuccessful л Admin Permissions Denied л лллллллл^&^&echo                      AdminCMD++ Detection Has Been Disabled^&^&echo.
      echo :AS
      echo if not exist "%%VBS%%" call :Gen
      echo ^@del "%%Clip%%"^>nul 2^>^&1^&cscript "%%VBS%%"^>nul 2^>^&1
      echo %%chk%%"$ADMINCMD$.Kill"^>nul 2^>^&1^&^&echo AdminCMD-Kill Command Executed...^&^&echo $ADMINCMD$.Kill.Success^|clip^&^&exit 999
      echo %%chk%%"$ADMINCMD$.Execute*%%password%%*&"^>nul 2^>^&1^|^|goto :AS
      echo echo.^&echo                     лллллллл л PASSWORD ACCEPTED л лллллллл
      echo ^@del AdminCMD++.bat^>nul 2^>^&1
      echo ^@ren "%%Clip%%" "AdminCMD++.bat"
      echo @%%echo%%$ADMINCMD$.Success^|clip
      echo call cmd /c "prompt $LAdminCMD++$G &%%temp%%\AdminCMD++.bat" 2^>nul^&goto :AS
      echo :Gen
      echo ^(echo set Shell = CreateObject^^^("WScript.Shell"^^^)
      echo echo set HTML = CreateObject^^^("htmlfile"^^^)^&echo AdminCMD = "%%Clip%%"
      echo echo set FileSystem = CreateObject^^^("Scripting.FileSystemObject"^^^)
      echo echo set File = FileSystem.OpenTextFile^^^(AdminCMD, 2, true^^^)
      echo echo file.writeLine HTML.ParentWindow.ClipboardData.GetData^^^("text"^^^)
      echo echo file.close^)^>%%VBS%%^&goto :EOF)> "AdminCMD++_V210_(18-11-15).bat"
:: This is the end of the generator,                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
::::::::::::::::::::::::::::::::::::         Change THIS text, to save to a different file/location
echo Generated Executable .bat File
pause >nul