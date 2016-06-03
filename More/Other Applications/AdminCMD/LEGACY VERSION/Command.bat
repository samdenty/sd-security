@echo off
set "Stream=%Temp%\AdminCMD.bat"
:start
set /p "Command=ENTER CMD: "
:SendCommand
set "TempFile=%Temp%\Tmp%random%.ini"
echo %Command%> "%TempFile%"
del /F "%Stream%" >nul 2>&1
:SendCommand2
copy /Y %tempFile% "%Stream%" >nul 2>&1
if not "%errorlevel%"=="0" goto :SendCommand2
goto :start