@echo Off
set userpaswrd=hih
set /p "=Enter Password Ûþ " < Nul
call :MaskPassword
echo.
Echo Your input was: %userpaswrd%
Pause >nul
exit

:MaskPassword
for /F "skip=1 delims= eol=" %%a in ('"Echo(|Replace "%~f0" . /U /W"') do set CR=%%a
for /F %%a In ('"Prompt $H &For %%_ In (_) Do Rem"') do set BS=%%a
set userpaswrd=
:MaskPasswordLoop
set CHR=&For /F "skip=1 delims= eol=" %%a in ('Replace "%~f0" . /U /W') do set CHR=%%a
If "%CHR%" == "%CR%" goto :eof
If "%CHR%" == "%BS%" (If Defined userpaswrd (Set /P "=%BS% %BS%" <nul&Set userpaswrd=%userpaswrd:~0,-1%)) Else (
Set /P "=þ" <Nul
if not "%CHR%" == "" set userpaswrd=%userpaswrd%%CHR%)
goto MaskPasswordLoop