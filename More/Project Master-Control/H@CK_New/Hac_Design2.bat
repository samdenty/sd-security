@echo off
:start
set "echo=<nul set /p ="
set number=1
Set Apps=Hacking
for /f %%a in ('dir /O:N /B /A:D "%Apps%"') do (
set "App=%%a"
call :Record)

set /p hack="�� "
(set %StringName% 2>nul|findstr /r /c:""&if not errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Enter Special Characters!&goto :AskString)) 1>nul
set H@CKApp%hack%


echo 4=%H@CKApp4%
pause
exit

:Record
set "status="
set "H@CKApp%number%=%App%"
pushd "Hacking\%App%"
call "check.bat"
popd
set %App%|findstr /B /C:"%App%=Uninstalled" >nul&&set "status=Uninstalled"||set "status=Installed"

echo ��������������������������
echo �%number%� %App%
if /i "%Status%"=="Installed" (%echo% ��� Status � Installed   �) else (%echo% ��� Status � Uninstalled �)
echo.
echo   ������������������������
set /a number=number+1 >nul
goto :eof