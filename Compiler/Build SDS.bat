@echo off
title SD-Security Compiler V.1.1.0
mode con: cols=80 lines=30
color 37
set settings=SD-Compiler.ini
if not exist "%Settings%" call :makesettings
for /F "eol=# delims=" %%A in (%settings%) do set %%A>nul
set OutputFile=%outputFileName%%OutputFileExtension%

:: Get SDS Version
cls
echo SD-Compiler V.1.1.0
if not exist "%BatchFile%" call :color FF "!!"&echo  Cannot Find The SDS Batch File!&pause >nul&exit
echo Enter The Version Number For SDS (3 Decimal Digits)
set /p SDS_Version=": "
set SDS_Version=%SDS_Version:.=,%
set SDS_Version2=%SDS_Version:,=.%
title Compiling SD-Security V%SDS_Version2%...
echo.
set SDS_Version=%SDS_Version%,0
set number=1
:Build
if not exist "%OutputFile%" goto :BuildNow
if not exist "%outputFileName%[%number%]%OutputFileExtension%" set OutputFile=%outputFileName%[%number%]%OutputFileExtension%&goto :BuildNow
if exist "%outputFile%" set /a number=%number%+1>nul&goto :Build
:BuildNow
call :color FF "!!"&echo  %time:~0,-3%: Building SDS EXE...
"%B2ExeConverterEXE%" -bat "%BatchFile%" -save "%OutputFile%" -icon "%ExeIcon%" -nodelete -overwrite -include "%Include%" -fileversion "%SDS_Version%" -productversion "%SDS_Version%" -company "%company%" -productname "%productname%" -internalname "%internalname%" -description "%description%" -copyright "%copyright%"
if not exist "%OutputFile%" call :color cc "!!"&echo  %time:~0,-3%: Task Failed (Reason Unknown)&goto :FailedBuild
call :color aa "!!!"&echo  %time:~0,-3%: Task Complete
if /i not "%SignBuild%" == "yes" goto :endBuild
call :color FF "!!"&echo  %time:~0,-3%: Signing SDS EXE...
"%signTool%" sign /a /d "%description% %SDS_Version2%" /du "%HelpWebsite%" /f "%Certificate%" /p "%Certificate_Password%" "%OutputFile%"
call :color aa "!!!"&echo  %time:~0,-3%: Task Complete
:EndBuild
call :color aa "!!!"&echo  %time:~0,-3%: Build Complete!
call :color BB "!!"&call :color 37 " SDS Compiled To The File"&call :color 33 "'"&call :color B3 "'%outputFile%'"
echo.
call :color EE "!!"&echo  You Should Check The Build For Any Compilation Errors
echo.
echo Press Any Key To Build Installer
pause >nul
call :color FF "!!"&echo  %time:~0,-3%: Compiling Installer...
"%ISCC.exe%" /Qp "%ProjectFile%"
if not exist "%OutputFile%" call :color cc "!!"&echo  %time:~0,-3%: Task Failed (Reason Unknown)&goto :FailedBuild
call :color aa "!!!"&echo  %time:~0,-3%: Task Complete
call :color FF "!!"&echo  %time:~0,-3%: Signing Installer EXE...
"%signTool%" sign /a /d "%InstallerDescription%" /du "%InstallerHelpWebsite%" /f "%Certificate%" /p "%Certificate_Password%" "%InstallerOutputFile%"
call :color aa "!!!"&echo  %time:~0,-3%: Task Complete
if not exist "ZipFiles\" (md ZipFiles) else (rd /s /q ZipFiles&md ZipFiles)
if exist "SD-Security.zip" del SD-Security.zip
call :color FF "!!"&echo  %time:~0,-3%: Creating ZIP...
copy /y %outputFile% "ZipFiles\SD-Security.exe">nul 2>&1
  if not exist "ZipFiles\SD-Security.exe" call :color cc "!!"&echo  %time:~0,-3%: Error Copying '%OutputFile%'!&goto FailedZip
if exist "%HelpFile%" copy /y %HelpFile% "ZipFiles\Help.chm">nul 2>&1
  if not exist "ZipFiles\Help.chm" call :color cc "!!"&echo  %time:~0,-3%: Error Copying '%HelpFile%'!&goto FailedZip
if exist "%VerHistory%" copy /y "%VerHistory%" "ZipFiles\What's New.txt">nul 2>&1
  if not exist "ZipFiles\What's New.txt" call :color cc "!!"&echo  %time:~0,-3%: Error Copying '%VerHistory%'!&goto FailedZip
if exist "%InstallerOutputFile%" copy /y "%InstallerOutputFile%" "ZipFiles\SDS_V%SDS_Version2%_Installer.exe">nul 2>&1
if not exist "ZipFiles\SDS_V%SDS_Version2%_Installer.exe" call :color cc "!!"&echo  %time:~0,-3%: Error Copying '%InstallerOutputFile%'!&goto FailedZip
%extd% /zip ZipFiles SD-Security.zip
if not exist "SD-Security.zip" goto :FailedZip
call :color aa "!!!"&echo  %time:~0,-3%: Zip Created Successfully!
if defined PostBuildCommand goto :PostBuildCommand
echo Press Any Key To Exit
pause >nul
exit /b 999
:PostBuildCommand
call :color FF "!!"&echo  %time:~0,-3%: Executing Post-Build Command...
%PostBuildCommand%
call :color aa "!!!"&echo  %time:~0,-3%: Task Complete
echo Press Any Key To Exit
pause >nul
exit /b 999
:FailedBuild
call :color cc "!!"&echo  %time:~0,-3%: Build Failed!
echo.
echo Press Any Key To Exit
pause >nul
exit /b 999
:FailedZip
call :color cc "!!"&echo  %time:~0,-3%: Failed To Create Zip!
echo.
echo Press Any Key To Exit
pause >nul
exit /b 999
:Color
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd
goto :EOF
:makesettings
(echo # SD-Security Compiler V.1.1.0 Settings File
echo.
echo # Options
echo SignBuild=yes
echo B2ExeConverterEXE=Compiler\Bat_To_Exe_Converter.exe
echo.
echo # Post Build Command, This Is A Script/Command To Be Run After Build
echo PostBuildCommand=
echo.
echo # Batch Files
echo BatchFile=SD-Security.bat
echo OutputFileName=SD-Security
echo OutputFileExtension=.exe
echo HelpFile=SD-Security.chm
echo VerHistory=..\..\Archives\History.SDS_History
echo Extd=Compiler\extd.exe
echo.
echo # Icon Files
echo ExeIcon=Icons\SD-Security.ico
echo Include=Icons\favicon.ico
echo.
echo # Signtool Files
echo Certificate=Digital Signature\SD-Storage.pfx
echo Certificate_Password=eebbcafb2550
echo SignTool=Digital Signature\Signtool
echo.
echo # Product Info
echo Company=SD-Storage©
echo HelpWebsite=http://SD-Storage.weebly.com/#SDS
echo ProductName=SD-Security© by Samuel Denty
echo InternalName=SD-Security© by Samuel Denty
echo Description=SD-Security©
echo Copyright=SD-Security© 2015
echo # Installer Product Info
echo InstallerDescription=SD-SecurInstaller©
echo InstallerHelpWebsite=http://SD-Storage.weebly.com/#SdSecurInstaller
echo ISCC.exe=Installer\Compiler\ISCC.exe
echo ProjectFile=Installer\SD-Security.iss
echo InstallerOutputFile=Installer\SD-SecurInstaller.exe
)> "%settings%"
goto :EOF