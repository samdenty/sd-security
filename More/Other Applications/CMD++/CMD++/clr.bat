@if "%~1" == "/?" @goto :Help
@if "%~1" == "" @goto :Help
@for /F "tokens=1,2 delims=#" %%a in ('"@prompt #$H#$E# & @for %%b in (1) do @rem"') do (@set "DEL=%%a")
@pushd %temp%
@<nul set /p ".=%DEL%" > "%~2"
@findstr /v /a:%~1 /R "^$" "%~2" nul
@del "%~2" >nul 2>&1
@popd
@goto :end
:Help
@echo Text Color Command Help
@echo %~0 [Color] ["Text"]
@echo.
@echo Color   The Color Number (See Color /?)
@echo "Text"  The Text To Display (It Is Displayed On The Same Line)
:end