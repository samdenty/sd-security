@echo Local Network PC Finder
@setlocal
@set "IP="
@if "%~1" == "" @echo Error: No PC Name Specified!&goto :EOF
@set GetIP=%~1
@for /f "tokens=1,2 delims=[]" %%a in ('ping -w 1 -n 1 -4 "%GetIP%"^|findstr "Pinging"') do @set IP=%%b
@if "%IP%" == "" (@echo Cannot Find '%GetIP%' On Network&goto :EOF) else (@echo Found '%GetIP%' On Network With The IP '%IP%')
@endlocal