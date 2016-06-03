@echo off
:Loop
echo PLEASE PRESS CTRL+C
(cmd /c start /wait "SD-Security" cmd /c "mode con: cols=25 lines=4&color 3f&echo.&echo  To Lock The Data Vault,&echo       Press CTRL+C&timeout /t -1 /nobreak >nul">"%Temp%\CTRL+C.DETECTOR" 2>&1)
type "%Temp%\CTRL+C.DETECTOR"|findstr C>nul 2>&1&&echo Window Closed||echo CTRL+C Pressed
goto :Loop