@echo off
goto start
set  "On=[On] Off"
set "Off= On [Off]"
:Start
set  "On=���"
set "Off=� �"
set "switch=call :Switch"
%switch% Virus
%switch% Menu1
%switch% Menu2
:menu
cls
echo   �Ŀ
echo �1%Virus%�� Enable Advanced Security
echo �2%Menu1%�� Enable Some Sugar
echo �3%Menu2%�� Enable Pre-Boot Checking
echo   ���
set /p "list=:"
if "%list%" == "1" %switch% virus
if "%list%" == "2" %switch% Menu1
if "%list%" == "3" %switch% Menu2
goto :menu
exit


:Switch
set "SwitchName=%~1"
set "SwitchType=%~2"
if "%SwitchType%" == "" (call :InvertSwitch&goto :EOF)
if /i "%switchType%" == "ON" (set "%SwitchName%=%ON%") else (if /i "%switchType%" == "OFF" set "%SwitchName%=%Off%")
goto :EOF
:InvertSwitch
for /f "tokens=1-2 delims==" %%a in ('set %SwitchName% 2^>nul') do set "SwitchStatus=%%b">nul 2>&1
if "%SwitchStatus%" == "%Off%" (set "%SwitchName%=%ON%") else (set "%SwitchName%=%OFF%")
goto :EOF