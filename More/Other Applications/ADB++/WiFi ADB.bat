@echo off
cls
mode con: cols=27 lines=3
cd C:\android-sdk\platform-tools
:wait
color af
title Loading...
echo.
echo       Loading...
adb kill-server
adb start-server
cls
title Connect
echo.
echo  Please Connect Android...
adb wait-for-device
color e0
cls
title Please Wait
echo.
echo  Relaunching In USB Mode..
adb usb
cls
echo.
echo  Starting Wireless Server.
adb tcpip 5555
cls
title Enter IP
echo Enter Android IP Address:
set /p androidip="192.168."
cls
title Connecting
echo.
echo  Connecting To Android....
adb connect 192.168.%androidip%
cls
echo.
echo  Finished, Disconnect USB
pause >nul
cls
echo.
echo         Connecting...
adb wait-for-device
color 2a
echo         Sucessful !
timeout 5 >nul
exit