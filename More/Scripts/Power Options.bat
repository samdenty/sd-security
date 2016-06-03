@echo off
:APO
cls
title A.P.O - SD-Security
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Advanced Power Options               %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  Basic Timer
echo �2�  Advanced Timer
echo �3�  Cancel Shutdown
echo �4�  Back
set /p powerOptions="�: "
if %powerOptions%==1 set APOvar1=basicTimer&goto Timer
if %powerOptions%==2 set APOvar1=advancedTimer&goto Timer
if %powerOptions%==3 shutdown -a&goto home
if %powerOptions%==4 goto other
goto APO
:Timer
cls
title What Do You Want The PC To Do? - SD-Security
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Advanced Power Options               %status%
echo �������������������������������������������������������������������������������
echo.
echo                             What Do You Want The PC To Do?
echo �1�  Shutdown
if %APOvar1%==advancedTimer goto TimerAdvancedDisablesIt
echo �2�  Hibernate
echo �3�  Cancel
set /p APOvar2="�: "
if %apovar2%==1 set timerCommand=/p&set timerCommand2=Shutdown&goto timerTime
if %apovar2%==2 set timerCommand=/h&set timerCommand2=Hibernate&goto timerTime
goto APO
:TimerAdvancedDisablesIt
echo ���  HIBERNATE (Option Disabled, Select Cancel And Use Basic Timer Instead)
echo �3�  Cancel
set /p APOvar2="�: "
if %apovar2%==1 set timerCommand=/p&set timerCommand2=Shutdown&goto timerTime
goto APO
:timerTime
cls
title How Long To Wait? - SD-Security
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Advanced Power Options               %status%
echo �������������������������������������������������������������������������������
echo.
echo How Long Should The Timer Wait To %timerCommand2%? (In Seconds)
if /i %APOvar1%==basicTimer goto ShowBasicTimer
goto ShowAdvancedTImer
:ShowAdvancedTImer
echo Range Is 0-315360000 Seconds With The Advanced Timer
goto ShowNextTimer
:ShowBasicTImer
echo Range Is 0-99999 Seconds With The Basic Timer
:ShowNextTimer
set /p timerSec="�: "
goto confirmTimer
:confirmTimer
cls
title Confirm - SD-Security
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Advanced Power Options               %status%
echo �������������������������������������������������������������������������������
echo.
echo       Are You Sure You Want To Schedule A %timerCommand2% Command To This PC?
echo.
echo �1�  Confirm
echo �2�  Cancel
set /p confirm="�: "
if %confirm%==1 goto startTimer
goto APO
:startTimer
cls
if /i %APOvar1%==basicTimer goto StartBasicTimer
:StartAdvancedTimer
shutdown %timerCommand% /f /t %timerSec% /c "SD-Security"
goto home
:StartBasicTimer
set TimerLeft=%timersec%
:TimerLoop
cls
title %timerCommand2% Active - SD-Security
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 Shutdown Active                  %status%
echo �������������������������������������������������������������������������������
echo.
echo                   A %timerCommand2% Command Has Been Enabled,
echo    If You Close This Window Or Press CTRL+C The %timerCommand2% Will Be Disabled
echo                             %timerLeft% Seconds Until %timercommand2%
timeout 1 >nul /nobreak
set /a TimerLeft=%Timerleft%-1 >nul
if %TimerLeft%==0 goto InitiateTimer
if %TimerLeft%==-1 goto InitiateTimer
if %TimerLeft%==-2 goto InitiateTimer
if %TimerLeft%==10 color c4
goto TimerLoop
:InitiateTimer
shutdown %timerCommand% /f /c "SD-Security"
goto end