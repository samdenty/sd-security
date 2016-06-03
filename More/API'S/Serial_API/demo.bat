@echo off
for /f "skip=1 delims=" %%a in ('vol') do set serial=%%a
set serial=%serial:~-9,9%
echo Drive Serial Is: %serial%
pause >Nul