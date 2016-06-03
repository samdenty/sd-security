if "%~1" == "" (set "SDS=SD-Security.exe") else (set "SDS=%~1")
if exist "DEVWrapper.txt" goto start
attrib +h +s background.bmp
attrib +h +s econsole.exe
attrib +h +s econsole.ini
attrib +h +s NViewLib.dll
:start
econsole -c /k SD-Security.exe