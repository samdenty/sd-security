@echo off
if not exist "%AppFolder%\DisableAutoUpdate.ini" (call start %AppFolder%\UpdtrSrvc.exe)