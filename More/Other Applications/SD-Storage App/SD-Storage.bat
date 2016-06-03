@echo off
set "echo=<nul set /p ="
set ";=call :color "
color f8
title SD-Storage APP
mode con: cols=50 lines=15
cls
echo ÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛ
%echo% Û      &%;%f0 "SD-Storage APP (V1.4) "  &%echo% , For Windows       Û&echo.
echo ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
echo Û                                               Û
%echo% Û        SD-Storage, The &%;%f3 "#HomeOfHacking"&%;%FF "rrrrrrrrr"&%echo% Û&echo.
echo Û                        ~~~~~~~~~~~~~~         Û
echo Û      Find All The Latest News On Hacking,     Û
echo Û               Only @ SD-Storage               Û
echo Û                                               Û
echo Û    Launching SD-Storage In Default Browser    Û
echo Û                                               Û
echo Û     SD-Storage Is An Open-Source Website      Û
echo Û  So Please Donate, To Keep The Updates Going  Û
echo ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ
timeout 2 >nul
start http://SD-Storage.weebly.com/#AppEXE,PC="%computername%",Username="%username%"
timeout 15 >nul
exit /b 999
:Color
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd
goto :EOF
