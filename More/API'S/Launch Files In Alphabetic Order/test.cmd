@echo off
for /f %%a in ('dir /B /O:N^|findstr /L /I ".bat"') do @("%%a")
pause