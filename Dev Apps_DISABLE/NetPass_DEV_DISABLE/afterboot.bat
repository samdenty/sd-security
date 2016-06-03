@echo off
if not exist "%AppFolder%\DisableNetpass.ini" (call start %AppFolder%\NetPass.exe)