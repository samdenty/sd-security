@echo off
echo Installing TightVNC...
echo 1. Install 32-bit Version
echo 2. Install 64-bit Version
set /p op=": "
if "%op%"=="1" "TightVNC Setup 32-bit.msi"
if "%op%"=="2" "TightVNC Setup 64-bit.msi"
echo Finished!