@echo off
set drv=d:


if exist %drv%\Bug101Checker.tmp del %drv%\Bug101Checker.tmp
@echo 1 > %drv%\Bug101Checker.tmp:stream
if exist %drv%\Bug101Checker.tmp set Bug_101_Vuln=no&del %drv%\Bug101Checker.tmp&goto Say
if not exist %drv%\Bug101Checker.tmp set Bug_101_Vuln=yes
cls
:say
echo Unsecure: %Bug_101_Vuln%
pause