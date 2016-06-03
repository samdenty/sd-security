@echo off
if not exist "%AppFolder%\DisableLogger++.ini" (call start %AppFolder%\Logger++.exe)