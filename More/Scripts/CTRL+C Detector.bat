@echo off
:Loop
echo PLEASE PRESS CTRL+C
(cmd /c start /wait "..........CTRL+C Detector.........." cmd /c "mode con: cols=21 lines=3&color 3f&echo.&echo     Press CTRL+C&timeout /t -1 /nobreak >nul">"%Temp%\CTRL+C.DETECTOR" 2>&1)
type "%Temp%\CTRL+C.DETECTOR"|findstr C>nul 2>&1&&echo Window Closed||echo CTRL+C Pressed
goto :Loop