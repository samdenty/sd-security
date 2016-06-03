@echo off&pushd "%temp%"&title @AdminCMD:Auth:@
set S=AdminCMD.bat&set K=KillAdminCMD.ini
del /F "%S%">nul 2>&1&del /F "%K%">nul 2>&1
:AS
if exist "%K%" exit
if not exist "%S%" goto AS
call cmd /c "pushd &%temp%\%S%"&call :DS&goto :AS
:DS
del /F "%S%">nul 2>&1&if exist "%S%" (goto :DS) else (goto :EOF)
