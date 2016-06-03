@echo off
:loop
call :Randomo 1 >nul
if "%randomo%" GEQ "5" (set chance=1) else (set chance=2)
echo The Chance Of This Program (100%% Random)
echo It Chose The Number '%chance%' Out Of 1 Or 2
echo.
echo The Number It Choose From 0-9 Was:
echo '%randomo%' - Magic!
echo.
echo If There Is A Number Between The '' Then It Picked That Number From The Time:
echo '%Randomo2%'
pause
exit





:Randomo
set nolength=%1
call :SetRandomoNo
set TimeRandom=0
set nolength3=%nolength%
set /a NoLength=%NoLength% -1 >nul
set NoLength2=-1
set Randomo=%randomNo%
:RandomoLoop
set /a NoLength2=%NoLength2% +1 >nul
echo %NoLength2%/%NoLength3% Complete
call :setRandomoNo
set Randomo=%Randomo%%randomoNo%
if "%NoLength2%" == "%NoLength%" cls&goto :EOF
goto RandomoLoop
:setRandomoNo
set randomo3=%random:~-1,1%
if "%randomo3%" == "8" set randomoNo=%time:~-1,1%&set Randomo2=%Randomo2%%randomoNo%&goto :EOF
if "%randomo3%" == "9" set randomoNo=%time:~-1,1%&set Randomo2=%Randomo2%%randomoNo%&goto :EOF
if "%randomo3%" == "1" set randomoNo=%time:~-2,1%&set Randomo2=%Randomo2%%randomoNo%&goto :EOF
set randomoNo=%random:~-1,1%
goto :EOF