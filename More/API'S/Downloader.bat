@echo off
set SDS_Version=1.2.6
if not exist "SDS_Files\SD-Updater.ini" call :MakeSDUpdaterSettings
goto CheckForUpdates

:MakeSDUpdaterSettings
echo # SD-Updater Server Settings> "SDS_Files\SD-Updater.ini"
echo # The Below Settings Are Used By SD-Security To Check For Updates>> "SDS_Files\SD-Updater.ini"
echo Latest_Version_Log=http://localhost/SD-Security/OnlineVersion.txt>> "SDS_Files\SD-Updater.ini"
echo Latest_Version_EXE=http://localhost/SD-Security/SD-Security.exe>> "SDS_Files\SD-Updater.ini"
goto :EOF

:CheckForUpdates
for /F "eol=# delims=" %%A in (SDS_FILES\SD-Updater.ini) do set %%A >nul
powershell -nologo Invoke-WebRequest -OutFile "SDS_Files\LatestVersion.ini" "%Latest_Version_Log%" >nul 1>&2
if not "%errorlevel%" == "0" goto UpdaterError
if not exist "SDS_Files\LatestVersion.ini" goto UpdaterError
for /F "eol=# delims=" %%A in (SDS_FILES\LatestVersion.ini) do set %%A >nul
if not "%SDS_Version%" == "%OnlineVersion%" goto UpdateAvailable
goto NoUpdates
pause

:NoUpdates
cls
title No Updates Available - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               No Updates Available               %status%
echo �������������������������������������������������������������������������������
echo.
echo             There Are Currently No Updates Available For SD-Security
echo                                Press Any Key To Go Home
pause >nul
goto home
:UpdaterError
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Updater Error^| ^|Time: %twelve%^| ^|Date: %date2%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title SD-Updater Error - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 SD-Updater Error                 %status%
echo �������������������������������������������������������������������������������
echo.
echo                 There Was An Error While Checking For Updates,
echo              Please Check Your Internet Connection And Try Again
echo.
echo     If You Keep Getting This Error, Check That Your Firewall Isn't Blocking
echo       Windows Powershell From Accessing The Internet. If You Still Cannot
echo     Update SD-Security Then You Should Just Manually Update SD-Security By
echo            Downloading The Latest SD-Security EXE From The Internet
echo.
echo �1�  Retry
echo �2�  Return Home
set /p UpdaterError="�� "
if "%UpdaterError%" == "1" goto :CheckForUpdates
goto home
:UpdaterError2
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Updater Error^| ^|Time: %twelve%^| ^|Date: %date2%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title SD-Updater Error - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 SD-Updater Error                 %status%
echo �������������������������������������������������������������������������������
echo.
echo                There Was An Error While Downloading The Update,
echo              Please Check Your Internet Connection And Try Again
echo.
echo     If You Keep Getting This Error, Check That Your Firewall Isn't Blocking
echo       Windows Powershell From Accessing The Internet. If You Still Cannot
echo     Update SD-Security Then You Should Just Manually Update SD-Security By
echo            Downloading The Latest SD-Security EXE From The Internet
echo.
echo �1�  Retry
echo �2�  Return Home
set /p UpdaterError="�� "
if "%UpdaterError%" == "1" goto :DownloadUpdate
goto home
:UpdateAvailable
call :setTime&echo ^|^|Log^|^|  ^|Update Available: %OnlineVersion%^| ^|Time: %twelve%^| ^|Date: %date2%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Update Available - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 Update Available                 %status%
echo �������������������������������������������������������������������������������
echo.
echo      An Update To SD-Security Is Available %OnlineVersion%, This Update May Include
echo       New Features, Bug Fixes, Security Patches, Speed Increases And More
echo.
echo                   Would You Like To Download This Update Now?
echo �1�  Yes
echo �2�  No
set /p UpdateSDS="�� "
if "%UpdateSDS%" == "1" goto DownloadUpdate
goto Home
:DownloadUpdate
call :setTime&echo ^|^|Log^|^|  ^|Update Downloading...^| ^|Time: %twelve%^| ^|Date: %date2%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Update Downloading... - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Update Downloading                 %status%
echo �������������������������������������������������������������������������������
echo.
echo                              Downloading Update...
echo.
powershell -nologo Invoke-WebRequest -OutFile "SD-Security2.exe" "%Latest_Version_EXE%" >nul 1>&2
if not "%errorlevel%" == "0" goto UpdaterError2
if not exist "SD-Security2.exe" goto UpdaterError2
echo                                Downloaded Update
timeout 3 /nobreak >nul
:InstallUpdateNow
call :setTime&echo ^|^|Log^|^|  ^|Update Downloaded^| ^|Time: %twelve%^| ^|Date: %date2%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Update Downloaded - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Update Downloaded                  %status%
echo �������������������������������������������������������������������������������
echo.
echo   The Update For SD-Security Has Been Downloaded, It Is Recommended That You
echo               Check The Download Isn't Corrupt Before Installing
echo.
echo �1�  Check The Download
echo �2�  Install Update (Without Checking)
echo �3�  Cancel
set /p InstallSDS="�� "
if "%InstallSDS%" == "1" call start SD-Security2.exe&goto UpdateCheckComplete
if "%InstallSDS%" == "2" goto StartInstallingUpdate
goto home
:UpdateCheckComplete
cls
title Update Downloaded - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Update Downloaded                  %status%
echo �������������������������������������������������������������������������������
echo.
echo      If SD-Security Just Opened Then You Can Install The Update OTHERWISE
echo                            The Download Could Be Corrupt
echo.
echo �1�  Install Update
echo �2�  Cancel
set /p InstallSDS2="�� "
if "%InstallSDS2%" == "1" goto StartInstallingUpdate
goto home
:StartInstallingUpdate
call start "Updating SD-Security" cmd /c "color f0&title SD-Security EXE Updater&mode con: cols=90 lines=25&echo -----------------------------===============================-----------------------------&echo -------------------------------= SD-Security EXE Updater =-------------------------------&echo -----------------------------===============================-----------------------------&echo -----------------------------===============================-----------------------------&timeout 4 >nul&echo                     Renaming Old SD-Security To 'SD-Security_old.exe'&ren SD-Security.exe "SD-Security_old.exe"&echo                       Renaming New SD-Security To 'SD-Security.exe'&ren SD-Security2.exe "SD-Security.exe"&echo                               Finished! SD-Security Updated&echo.&echo                    Press Any Key To Exit The Updater And Start SD-Security&pause >nul&call start SD-Security.exe&exit /B 999"
