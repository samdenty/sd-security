@echo off
set /p ExeToGetVer="Enter The SDS EXE To Get The Version: "
call :EXEVer "%ExeToGetVer%"
echo %EXE_Version%
pause
exit

:EXEVer
for /f "tokens=2-3 delims=: " %%a in ('powershell "(Get-Item %~1).VersionInfo|fl *"^|findstr ProductVersion') do set EXE_Version=%%a
if not "%EXE_Version%" == "" set EXE_Version=%EXE_Version:~0,5%
goto :EOF