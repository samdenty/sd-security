@echo off
color f0
title External Input
if not exist "SDS_Files" echo NO SDS INSTALLATION DETECTED!&timeout 2 >nul&goto :end
cls
echo Enter Input Below:
echo.
:loop
set /p #=
>SDS_Files\Ext.Input echo %#%
goto :loop
:end
exit