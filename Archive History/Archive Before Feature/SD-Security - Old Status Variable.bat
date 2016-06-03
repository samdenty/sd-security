@echo off
if "%restart%" == "0" goto CrashHelperActive
:StartOfScript
setlocal disabledelayedexpansion
set SDS_Version=1.3.2B
set Version_Type=STABLE
set currentyear=2015&set sds_file=%~nx0&set sds_extension=%~x0
set sds_extension=%sds_extension:~1%
set "HelpEmail=SamDenty99@outlook.com"
set "Set /p=call:AskString"
set "cd="
set "random="
call :checkOSInfo
if exist "SafeMode.*" goto Safe_Mode
if /i "%1" == "/safemode" goto Safe_Mode
goto CrashHelper
:: NO CODE ABOVE THIS (This Is The Safemode Code!)
:CrashHelperActive
call :LoadingScreen&goto sLScrn
:LoadingScreen
color f7
mode con: cols=21 lines=5
title Loading - SD-Security
cls
echo.
echo  €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo  €    Loading     €
echo  €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
color f7&call :Wait 2&color f8&call :Wait 2&color f0
goto :EOF
:sLScrn
call :securitylog
:: Check If SD-Security Has ADMIN Permissions
NET FILE 1>NUL 2>NUL
if "%errorlevel%" == "0" (set adminPer=yes) else (set adminPer=no)
if "%adminPer%" == "yes" if exist "%temp%\Enable_Hotspot.SD_PROGRESS_FILE" del %temp%\Enable_Hotspot.SD_PROGRESS_FILE&call :SetWindow&goto adminenable
if "%adminPer%" == "yes" if exist "%temp%\Enable_Hotspot2.SD_PROGRESS_FILE" del %temp%\Enable_Hotspot2.SD_PROGRESS_FILE&call :SetWindow&goto confirmedHot
call :MakeFiles
if exist "favicon.ico" attrib +h +s "Favicon.ico">nul
if exist "SDS_Files\Sessions\" for /f "delims=" %%a in ('dir /B /O:D SDS_Files\Sessions\^|findstr /I ".SDS_Session"') do set SessionFile=%%a&&goto RestoreSession
:NoRestore
if exist "SDS_Files\Check_Permissions.tmp" del SDS_Files\Check_Permissions.tmp&if exist "SDS_Files\Check_Permissions.tmp" goto noPermissions
echo. > "SDS_Files\Check_Permissions.tmp"&if not exist "SDS_Files\Check_Permissions.tmp" goto NoPermissions
del SDS_Files\Check_Permissions.tmp
:backFromNoPermissions
:: Makes The Statistics.ini File
if not exist "SDS_Files\SD-Statistics.ini" set times_opened=-1&call :statistics
for /F "eol=# delims=" %%A in (SDS_FILES\SD-Statistics.ini) do set %%A>nul 2>&1&call :statistics
:: Makes The SD-Settings.ini File
if not exist "SDS_FILES\SD-Settings.ini" call :makesettings
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f >nul 2>&1
type SDS_Files\SD-Settings.ini >nul
if not "%errorlevel%" == "0" goto SettingsFileError
for /F "eol=# delims=" %%A in (SDS_FILES\SD-Settings.ini) do set %%A>nul 2>&1
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:n >nul 2>&1
call :GetTheme
call :checkUpdateSettings
if %Dev_Mode%==yes if exist "favicon.ico" attrib -h -s "favicon.ico"&del favicon.ico >nul&if exist "autorun.inf" del autorun.inf >nul&goto skipBack5
:skipBack5
if %Used_Before%==no call :SetWindow&call :welcome
:: Checks if bug 101 applies
:Bug101checker
set Bug_101_Vuln2=%Bug_101_Vuln%
for /f "tokens=5" %%a in ('@fsutil fsinfo volumeinfo %cd:~0,2%^|findstr /B "File System Name : "') do (@set DriveType=%%a)
if /i not "%DriveType%" == "NTFS" (set Bug_101_Vuln=yes) else (set Bug_101_Vuln=no)
if /i not "%Bug_101_Vuln2%" == "%Bug_101_Vuln%" call :OverwriteSettings
if /i %Hide_Bug_101%==yes goto EndBug101
if /i %Bug_101_Vuln%==yes goto Bug101Yes
:EndBug101

:SetPasswords
call :AllowEncryption
:SetPasswords2
:: Account 1 (ADMIN ACCOUNT)
@echo off
set user21=%h%%z%%n%%w%%v%%m%%g%%b%%ad%%ad% >nul
@echo off
set %k%%z%%h%%h%%d%%l%%i%%w%=%v%%v%%y%%y%%x%%z%%u%%y%%ag%%aj%%aj%%ae% >nul
:: Account 2 (FALSE USER)
@echo off
set user%ag%%ag%=admin >nul
@echo off
set %k%%z%%h%%h%%d%%l%%i%%w%%ag%=%v%%v%%y%%y%%x%%z%%u%%y%%ag%%aj%%aj%%ae% >nul
:: Command Line Switches
if not "%switch%" == "" call :CommandSwitches %switch%
if not exist "SDS_Files\Version_No.ini" call :updateUpdaterInfo&goto VersionSkip
:takeVersion
for /F "eol=# delims=" %%A in (SDS_FILES\Version_No.ini) do set %%A>nul 2>&1
call :updateUpdaterInfo
if not "%Old_SDS_Version%" == "%SDS_Version%" call :updated
:VersionSkip
goto home


::           Homescreens
:: Logged Out
:Home
call :SetWindow
%SetTheme%
call :setTime&echo ^|^|Log^|^|  ^|Info: Home^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
set "op="
cls
if %status%==Signed-In goto home2
title Home - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                   Home                           %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  Lost ^& Found
echo €2€  Sign In
echo €3€  About
echo €4€  Other
echo €5€  Encrypto
echo €6€  Exit
echo.
%set /p% op="€˛ "
if "%op%" == "1" goto Lost
if "%op%" == "2" goto signin
if "%op%" == "3" goto about
if "%op%" == "4" goto other2
if "%op%" == "5" goto signin
if "%op%" == "6" goto end
if /i "%op%" == "exit" goto end
if /i "%op%" == "x" goto end
if /i "%op%" == "quit" goto end
if /i "%op%" == "kill" goto end
if /i "%op%" == "close" goto end
if /i "%op%" == "backup" goto backupSession
call :error
goto home

:: Logged-In
:Home2
if not %status%==Signed-In goto home
set notifications=0
if exist "SDS_Files\*.SDS_Found_LOG" set/a notifications=%notifications% +1 >nul
if exist "Unlocked" (set unLockOrLock=Lock) else (if exist ".Locked.{645*" (set unLockOrLock=Unlock) else (set unLockOrLock=Create))
%SetTheme%
if "%notifications%" == "0" (set thirdBar=€€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹&title Home - SD-Security©) else (set thirdBar=€€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹ You Have %Notifications% Notifications ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹&title ^(%notifications%^) Home - SD-Security©)
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                   Home                           %status%
echo %thirdbar%
echo.
echo €1€  %unLockOrLock% Data Vault
echo €2€  Sign Out
echo €3€  About
echo €4€  Other
echo €5€  Encrypto
echo €6€  Exit
echo.
%set /p% op="€˛ "
if "%op%" == "1" goto privatedata
if "%op%" == "2" goto signin
if "%op%" == "3" goto about
if "%op%" == "4" goto other
if "%op%" == "5" goto encrypto
if "%op%" == "6" goto end
if /i "%op%" == "exit" goto end
if /i "%op%" == "x" goto end
if /i "%op%" == "quit" goto end
if /i "%op%" == "kill" goto end
if /i "%op%" == "close" goto end
call :error
goto home2
:error
call :setTime&echo ^|^|Log^|^|  ^|Error: Invalid Option Entered^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
echo.
color C4
call :color CF "         Invalid Option, Please Enter A Number Above And Press Enter"
echo.|choice /n >nul&cls
goto :EOF


:: Lost And Found
:lost
call :setTime&echo ^|^|Log^|^|  ^|Info: Lost ^& Found^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
%SetTheme%
title Lost ^& Found - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 Lost ^& Found                    %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo     This Log Is A OFFLINE Log Meaning That You Have To Complete The Form At
echo      SD-Storage.weebly.com/usb.html (Website Will Be Launched Automatically)
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo.
:redo1
%set /p% firstname="First Name €˛ "
if "%firstname%" == "" goto redo1
:redo2
%set /p% surname="Surname €˛ "
if "%surname%" == "" goto redo2
:redo3
%set /p% phonenumber="Phone Number €˛ "
if "%phonenumber=%" == "" goto redo3
:redo4
%set /p% email="Email Address €˛ "
if "%email%" == "" goto redo4
goto devicelog
:devicelog
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 Lost ^& Found                    %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo     This Log Is A OFFLINE Log Meaning That You Have To Complete The Form At
echo      SD-Storage.weebly.com/usb.html (Website Will Be Launched Automatically)
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo.
echo                    Logging Infomation... (Please Be Patient)
echo Device Found>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
attrib +h "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo ------------>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo.>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Info>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo ---->> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo.>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo First Name: %firstname%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Surname: %surname%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
call :setTime&echo Time: %twelve%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Date: %date2%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Email: %email%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Phone: %phonenumber%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo.>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Computer Info >> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo ------------- >> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Username: %username%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
net user>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
timeout 2 >nul /nobreak
:lostCompleted
call :setTime&echo ^|^|Log^|^|  ^|Info: Lost ^& Found^| ^|Name: %Firstname% %surname%^| ^|Email: %email%^| ^|Phone: %phonenumber%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Thank You - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Lost and Found                    %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                           Your Details Have Been Logged.
echo       Please go to "http://SD-Storage.weebly.com/usb" And Complete The Form
echo         There Is A 80%% Chance That You Will Get A Reward (Maybe Cash)
echo                                    Website Opened
start http://sd-storage.weebly.com/usb
goto home


:: Data Vault
:Privatedata
if not %status%==Signed-In goto home
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
if exist ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" goto unlock
if not exist "Unlocked" goto mdlocker
:confirm
if not %status%==Signed-In goto home
if /i not %Bug_101_Vuln%==yes goto confirm2
title Encrypt Data Vault - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo              The Data Vault Is Unlocked And Anyone Can Access It,
echo                    Press Any Key To Encrypt The Data Vault
pause >nul
goto lock
:confirm2
%SetTheme%
cls
if not %status%==Signed-In goto home
title Data Vault Encryption Method - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  Advanced Encryption, You Can Only Decrypt The Vault With This User Account
echo €2€  Basic Encryption, You Can Decrypt The Vault With Any User Account
echo €3€  Back
%set /p% lockOption="€˛ "
if "%lockOption%" == "1" goto lock
if "%lockOption%" == "2" goto lock2
if "%lockOption%" == "3" goto home
color C4
call :color CF "         Invalid Option, Please Enter A Number Above And Press Enter"
echo.|choice /n >nul&cls
goto confirm2
:lock
if not %status%==Signed-In goto home
title Encrypting Data Vault - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
ren Unlocked ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul 2>&1
if exist "Unlocked" goto DataVaultError2
echo                            Protocol 1 €˛ Successful
attrib +h +s +r +a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul 2>&1
echo                            Protocol 2 €˛ Successful
echo y| cacls .Locked.{645FF040-5081-101B-9F08-00AA002F954E} /T /P everyone:N >nul 2>&1
color 2a
echo                            Protocol 3 €˛ Successful
echo                            ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
call :color 2f "                             Data Vault Encrypted"
echo.
title Locked Data Vault - SD-Security©
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Locked^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
pause >nul
%SetTheme%
goto home
:lock2
if not %status%==Signed-In goto home
title Locking Data Vault - SD-Security©
cls
color 2a
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
ren Unlocked ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul
if exist "Unlocked" goto DataVaultError2
echo                            Protocol 1 €˛ Successful
attrib +h +s +r +a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul
echo                            Protocol 2 €˛ Successful
echo                            ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
call :color 2f "                             Data Vault Encrypted"
echo.
title Locked Data Vault - SD-Security©
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Locked^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
pause >nul
%SetTheme%
goto home

:unlock
if not %status%==Signed-In goto home
cls
title Enter Password - SD-Security©
if exist "%Security_Breach_Key%" goto breach
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
if %Hide_Password%==yes set user21q=unlocking&set user22q=unlocking&set showUsernameField=no&goto HidePassword
%set /p% pass="Enter Password €˛ "
if NOT %pass%==%password% goto denied
goto unlocking
:Unlocking
if not %status%==Signed-In goto home
title Unlocking Data Vault - SD-Security©
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Unlocked^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
echo                            Protocol 1 €˛ Loading...
echo y| cacls .Locked.{645FF040-5081-101B-9F08-00AA002F954E} /T /P everyone:F >nul 2>&1
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
echo                            Protocol 1 €˛ Successful
attrib -h -s -r -a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul
echo                            Protocol 2 €˛ Successful
ren .Locked.{645FF040-5081-101B-9F08-00AA002F954E} "Unlocked" >nul
if not exist "Unlocked" goto DataVaultError
cls
color 2a
title Unlocked Data Vault - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
echo                            Protocol 1 €˛ Successful
echo                            Protocol 2 €˛ Successful
echo                            Protocol 3 €˛ Successful
echo                            ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
call :color 2f "                             Data Vault Decrypted"
echo.
pause >nul
%SetTheme%
goto home
:DataVaultError
title Decryption Failed - SD-Security©
cls
color 4c
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
echo                            Protocol 1 €˛ Unsuccessful - Error
echo                            Protocol 2 €˛ Unsuccessful
echo                            Protocol 3 €˛ Unsuccessful
echo                            ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo                                Decryption Failed
echo.
echo  ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo.
echo   The Data Vault Was Unsuccessfully Decrypted Due To It Being Encrypted With
echo                   SD-Security's Advanced Security Feature.
echo.
echo   To Decrypt It, You Need To Connect ﬂ%cd:~0,3%ﬂ To The PC That The Vault Was
echo                                    Encrypted On
pause >nul
goto home
:DataVaultError2
cls
title Encryption Failed - SD-Security©
color 4c
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
echo                            Protocol 1 €˛ Unsuccessful - Error
echo                            Protocol 2 €˛ Unsuccessful - Error
echo                            Protocol 3 €˛ Unsuccessful - Error
echo                            ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo                                Encryption Failed
echo.
echo  ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo.
echo       The Data Vault Was Unsuccessfully Decrypted Due To The Permissions
echo                          Disallowing Write Access To It
echo.
echo   To Decrypt It, You Need To Close Any Program Using The Folder And Possibly
echo Change The Permissions Of ﬂ%cd%\Unlockedﬂ
echo                                To ﬂEveryone: Allow Allﬂ
pause >nul
goto home
:breach
if not exist "%Security_Breach_Key%" goto home
title Security Breach - SD-Security©
call :setTime&echo ^|^|Log^|^|  ^|Info: Master Overide Attempted^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
color C4
title WARNING - SD-Security©
color C4
echo.|choice /n >nul&cls
echo          _    _    ___   ______   _   _  _____   _   _   ______
echo         : :  : :  / _ \  : ___ \ : \ : ::_   _: : \ : : :  ____\
echo         : :  : : : /_\ : : :_/ / :  \: :  : :   :  \: : : :
echo         : :/\: : :  _  : :    /  : . ` :  : :   : . ` : : :  ___
echo         \  /\  / : : : : : :\ \  : :\  : _: :_  : :\  : : :__\ \
echo          \/  \/  \_: :_/ \_: \_\ :_: \_/ \___/  \_: \_/  \_____/
echo.
echo    Due To No Password Being Entered, The Vault Can't Be Decrypted Normally
echo                       (Files Are Encrypted With Password)
echo          Failing To Decrypt The Files Could Possibly Corrupt Them
call :color CF "         DO YOU WISH TO TRY TO HACK SD-SECURITY DATA VAULT Y/N ?"
%set /p% optionHACK="€˛ "
if /i "%optionHACK%" == "y" goto HACKloopSTART
del %Security_Breach_Key%
goto home
:HACKloopSTART
set ic=-
:loop
if not exist "%Security_Breach_Key%" goto home
cls
SET /A loopnums=%loopnums% +1
SET /A breachnum=%RANDOM:~-1%
set wholebreachnum=%wholebreachnum%%breachnum%
if %loopnums%==1 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==2 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==3 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==4 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==5 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==6 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==7 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==8 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==9 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==10 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==11 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==12 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==13 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==14 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==15 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==16 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==17 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==18 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==19 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==20 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==21 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==22 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==23 set ender=%ic%%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==24 set ender=%ic%%ic%%ic%%ic%%ic%%ic%
if %loopnums%==25 set ender=%ic%%ic%%ic%%ic%%ic%
if %loopnums%==26 set ender=%ic%%ic%%ic%%ic%
if %loopnums%==27 set ender=%ic%%ic%%ic%
if %loopnums%==28 set ender=%ic%%ic%
if %loopnums%==29 set ender=%ic%
if %loopnums%==30 set ender=
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                        %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ %wholebreachnum%%ender%
if %loopnums%==30 goto outofloopnum
echo ACCESS DENIED!
color 4c
ping 192.0.2.1 -n 1 -w 1 >nul
color cf
goto loop
:outofloopnum
if not exist "%Security_Breach_Key%" goto home
color 4c
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                        %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 25%%                       € €€€€€€€€                         €
timeout 1 >nul /nobreak
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                        %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 50%%                       € €€€€€€€€€€€€€€€€                 €
timeout 1 >nul /nobreak
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                        %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 75%%                       € €€€€€€€€€€€€€€€€€€€€€€€€         €
timeout 1 >nul /nobreak
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                        %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 100%%                      € €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ €
echo.
echo                                      FINSIHED
timeout 2 >nul /nobreak
call :Randomo 1 >nul
if "%randomo%" GEQ "5" goto denied
call :setTime&echo ^|^|Log^|^|  ^|Info: Master Overide Successful^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
echo                            Protocol 1 €˛ Loading...
echo y| cacls .Locked.{645FF040-5081-101B-9F08-00AA002F954E} /T /P everyone:F >nul 2>&1
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
echo                            Protocol 1 €˛ Successful
attrib -h -s -r -a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul
echo                            Protocol 2 €˛ Successful
ren .Locked.{645FF040-5081-101B-9F08-00AA002F954E} "Unlocked" >nul
cls
color 2a
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter Password €˛ ˛˛˛˛˛˛˛˛˛˛
echo.
echo                            Protocol 1 €˛ Successful
echo                            Protocol 2 €˛ Successful
echo                            Protocol 3 €˛ Successful
echo                            ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
call :color 2F "                             Data Vault Decrypted"
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Unlocked^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
del %Security_Breach_Key%
pause >nul
%SetTheme%
goto home
:denied
title Access Denied - SD-Security©
call :setTime&echo ^|^|Log^|^|  ^|Info: Login Failed^| ^|Username: %Username2%^| ^|Password: %userpaswrd% ^| %pass%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
color 4C
echo.
echo                  Error: Password / Username Is Incorrect!
pause >nul
%SetTheme%
goto home
:MDLOCKER
color 3b
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Folder Created^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Data Vault Created - SD-Security©
md Unlocked
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Data Vault                        %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo             The SD-Security Data Vault Directory Has Been Created
echo            Put All Your Private Data In The Folder Named 'Unlocked'
echo    When You Have Finished Go Back Into SD-Security, Sign In And Lock The Data
echo                                       Vault.
echo.
call :color 3f "                            Press Any Key To Go Home"
pause >nul
goto home


:: About
:about
cls
call :setTime&echo ^|^|Log^|^|  ^|Info: About^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title About - SD-Security©
start http://SD-Storage.weebly.com
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                      About                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo              Our Website Has Just Been Opened In Your Default Browser
echo  If You Have Found This On A SD-Card Or USB That Doesn't Belong To You Please
echo   Choose €Lost ^& Found€ On The Homescreen And Enter Your Details, There Is
echo             A 50%% Chance That You Will Get A Reward For Returning It
echo.
echo                 This Security Was Designed By Samuel D. Denty
echo This Security Can Be Breached By The 'Master Overide' Feature That Is Randomly
echo                             Made For Each Security App
echo                    This Security Uses 256-bit AES Encryption
echo.
echo                             Press Any Key To Go Home
pause >nul
goto home


:: Sign In
:SIGNIN
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
if %status%==Signed-In goto signout
If Exist "%Security_Breach_Key%" goto AdminSignIn
title Sign In - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                      Sign In                     Signing In
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Enter ﬂUSBﬂ To Login With USB
%set /p% username2="Enter Username €˛ "
if /i "%username2%" == "usb" goto usblogin
if %Hide_Password%==yes set user21q=user21&set user22q=user22&set showUsernameField=yes&goto HidePassword
%set /p% userpaswrd="Enter Password €˛ "
:: enter account goto here
:passwordchecker
if %username2%==%user21% goto user21
if %username2%==%user22% goto user22
goto denied
:SIGNINUSB
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Sign In - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                      Sign In                     Signing In
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
%set /p% username2="Enter Username €˛ "
if %Hide_Password%==yes set user21q=user21b&set user22q=user22b&set showUsernameField=yes&goto HidePassword
%set /p% userpaswrd="Enter Password €˛ "
:: Goto Account Login Credidentials Checker
if %username2%==%user21% goto user21b
if %username2%==%user22% goto user22b
goto denied

:signout
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign Out^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Sign Out - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                      Sign Out                     status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                    You Are Currently Signed In As ﬂ%username2%ﬂ,
echo €€€                     Are You Sure You Want To Sign Out?
echo €1€  Yes
echo €2€  No
%set /p% signout2="€˛ "
if "%signout2%" == "1" goto signoutyes
goto home
:signoutyes
%h%%v%%g% %h%%g%%z%%g%%f%%h%=S%r%%t%%m%%v%%w%-O%f%%g%
goto home

:: Other When Signed Out
:other2
%SetTheme%
if %status%==Signed-In goto other
call :setTime&echo ^|^|Log^|^|  ^|Info: Other^| ^|Time: %twelve%^| ^|Date: %date2%^|  >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Other - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                         Other                    %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  SD-Software Folder
echo €2€  Developer Options Folder
echo €3€  Installation Information
echo €4€  Check For Updates (BETA)
echo €5€  Home
%set /p% other2="€˛ "
if "%other2%" == "1" goto SDSoftware
if "%other2%" == "2" goto DevOptions
if "%other2%" == "3" goto installInfo
if "%other2%" == "4" goto CheckForUpdates
goto home
:: Other When Signed In
:other
if not %status%==Signed-In goto other2
call :setTime&echo ^|^|Log^|^|  ^|Info: Other^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Other - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                       Other                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  SD-Software Folder
echo €2€  Developer Options Folder
echo €3€  Installation Information
echo €4€  Check For Updates (BETA)
echo €5€  Admin Options Folder
echo €6€  Home
%set /p% other="€˛ "
if "%other%" == "1" goto SDSoftware
if "%other%" == "2" goto DevOptions
if "%other%" == "3" goto installInfo
if "%other%" == "4" goto CheckForUpdates
if "%other%" == "5" goto AdminOps
goto home
:AdminOps
cls
title Admin Options Folder - Other - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Admin Options Folder               %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  Notifications
echo €2€  SD-Statistics
echo €3€  Open Security Log
echo €4€  Change SD-Settings
echo €5€  Back
%set /p% other4="€˛ "
if "%other4%" == "1" goto Notifications
if "%other4%" == "2" goto showStatistics
if "%other4%" == "3" goto openlog
if "%other4%" == "4" goto changesettings
goto other
:SDSoftware
cls
title SD-Software Folder - Other - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                SD-Software Folder                %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  SD-Commands
echo €2€  SD-Hotspot
echo €3€  SD-SecurChecker
echo €4€  Advanced Power Options
echo €5€  Get IP
echo €6€  Back
%set /p% other3="€˛ "
if "%other3%" == "1" goto commands
if "%other3%" == "2" goto hotspothome
if "%other3%" == "3" goto SDSecurChecker
if "%other3%" == "4" goto APO
if "%other3%" == "5" goto GetIPGUI
goto other
:Notifications
cls
call :setTime&echo ^|^|Log^|^|  ^|Info: Notifications^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Notifications - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                  Notifications                   %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                       You Have %Notifications% Notifications
if %Notifications%==0 goto noNotifications
if exist "SDS_Files\*.SDS_Found_LOG" set lstnfnd=1
echo €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo € No. Of Lost ^& Found Logs      € %lstnfnd%
echo € No. Of Security Hack Attempts € 0
echo €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo.
echo                             Press Any Key To Go Home
pause >Nul
goto home
:noNotifications
echo                             Press Any Key To Go Home
pause >Nul
goto home
:openlog
call :setTime&echo ^|^|Log^|^|  ^|Info: Security Log Viewed^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Opening Log - SD-Security©
copy SDS_Files\SD-Security.SDS_LOG "SDS_Files\tmp.txt" >nul
echo /////////////////////// >> "SDS_Files\tmp.txt"
echo DON'T RESAVE THIS FILE! >> "SDS_Files\tmp.txt"
echo /////////////////////// >> "SDS_Files\tmp.txt"
start SDS_Files\tmp.txt
set/a deletenum=10
:deleteloop
title %deletenum% Seconds Until Temp. Log Deleted - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                         Other                    %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                   %deletenum% Seconds Until Temp. Log Deleted
timeout 1 /nobreak >nul
set/a deletenum=%deletenum% -1
if %deletenum%==0 goto deletelog
goto deleteloop
:deletelog
cls
del SDS_Files\tmp.txt
if exist "SDS_Files\tmp.txt" goto cantdeletelog
call :setTime&echo ^|^|Log^|^|  ^|Info: Tmp Log Deleted^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
goto home
:cantdeletelog
:deletelogloop2
if not exist "SDS_Files\tmp.txt" goto home
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                         Other                    %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo           Can't Delete Temporary Log, Please Close Log When Done
del SDS_Files\tmp.txt
goto deletelogloop2
:commands
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Commandr^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
color 07
title C:\windows\system32\cmd.exe
cls
echo Microsoft Windows [Version 6.3.9600]
echo (c) 2013 Microsoft Corporation. All rights reserved.
echo.
:commandsEntered
%set /p% cmd="C:\Users\%username%>"
if /i "%cmd%" == "exit" goto end
if /i "%cmd%" == "close" goto end
if /i "%cmd%" == "shutdown" shutdown /s
if /i "%cmd%" == "home" goto home
if /i "%cmd%" == "cls" cls&goto commandsEntered
if /i "%cmd%" == "clear" cls&goto commandsEntered
if /i "%cmd%" == "pause" pause&goto commandsEntered
if /i "%cmd%" == "pause >nul" pause >nul&goto commandsEntered
if /i "%cmd%" == "ver" ver&goto commandsEntered
call :color f0 "Command Disabled!"
pause >nul
goto commands
:: accounts
:user21
if NOT %userpaswrd%==%password% goto denied
call :setTime&echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %username2%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto home
:autologinhack
set username2=USB Drive
call :setTime&echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: USB Drive^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto home
:user22
if NOT %userpaswrd%==%password2% goto denied
call :setTime&echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %username2%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto home
:user21b
if NOT %userpaswrd%==%password% goto denied
call :setTime&echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %username2%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto setupusb
:user22b
if NOT %userpaswrd%==%password2% goto denied
call :setTime&echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %username2%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto setupusb


:: Security Breach
:AdminSignIn
title Security Breach - SD-Security©
set status=Signed-In
call :setTime&echo ^|^|Log^|^|  ^|Info: Overide Password Successful^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
goto home

:: Loading Sequence/Startup
:securitylog
:: Set Some Variables, Used By SD-Security
set status=Signed-Out
set notifications=0
if not exist "SDS_Files" call :makeSDSFiles
call :setTime
echo.>> "SDS_Files\SD-Security.SDS_LOG"
echo ^|^|Version %SDS_Version%^|^|  ^|Time: %twelve%^| ^|Date: %date2%^| ^|OS: %WinVersion%^| ^|Serial: %serial%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
goto :EOF
:MakeSDUpdaterSettings
echo # SD-Updater Server Settings> "SDS_Files\SD-Updater.ini"
echo # If You Want To Reset The Servers To The Default, Delete This File>> "SDS_Files\SD-Updater.ini"
echo # The Below Settings Are Used By SD-Security To Check For Updates, If You Change The Servers>> "SDS_Files\SD-Updater.ini"
echo Latest_Version_Log=http://www.dropbox.com/s/kue59qjeasq0tp7/OnlineVersion.txt?dl=1 >> "SDS_Files\SD-Updater.ini"
echo Latest_Version_EXE=http://www.dropbox.com/s/r6gyfh9kc9sqy3t/SD-Security.exe?dl=1 >> "SDS_Files\SD-Updater.ini"
goto :EOF
:MakeFiles
if not exist "SDS_Files\SD-Updater.ini" call :MakeSDUpdaterSettings
if not exist "desktop.ini" call :makeDesktopINI
if exist "autorun.inf" goto :EOF
if exist "%cd:~0,3%autorun.inf" goto :EOF
call :SetWindow
if "%cd%" == "%cd:~0,3%" goto currentDrv
call :setTime&echo ^|^|Log^|^|  ^|Info: Show SD-Security Icon On Drive^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Show SD-Security Icon On Drive - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛          Show SD-Security Icon On Drive          %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo       Would You Like To Display The SD-Security Icon On The ﬂ%cd:~0,1%ﬂ Drive?
echo   Info: This Uses A File Called ﬂAutorun.infﬂ, If You Select ﬂNoﬂ A File Will
echo    Still Be Created (To Show The Option To Launch SD-Security) But You Won't
echo                  See The SD-Security Logo Or Text On Your Drive
echo.
echo €1€  Yes (On The Drive)
echo €2€  Yes (On This Folder, DEV)
echo €3€  No
%set /p% showSDIcon="€˛ "
if "%showSDIcon%" == "1" goto OnCurrentDrv
if "%showSDIcon%" == "2" goto NormalModeAutorun
goto NoButCreateStill
goto :EOF
:CurrentDrv
call :setTime&echo ^|^|Log^|^|  ^|Info: Show SD-Security Icon On Drive^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Show SD-Security Icon On Drive - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛          Show SD-Security Icon On Drive          %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo         Would You Like To Display The SD-Security Icon On The %cd:~0,1% Drive?
echo   Info: This Uses A File Called ﬂAutorun.infﬂ, If You Select ﬂNoﬂ A File Will
echo    Still Be Created (To Show The Option To Launch SD-Security) But You Won't
echo                  See The SD-Security Logo Or Text On Your Drive
echo.
echo €1€  Yes
echo €2€  No
%set /p% showSDIcon="€˛ "
if "%showSDIcon%" == "1" goto OnCurrentDrv
goto NoButCreateStill
:OnCurrentDrv
set driveLocSlash=%cd:~0,3%
if exist "%driveLocSlash%autorun.inf" attrib -h -s -r "%driveLocSlash%autorun.inf"&copy %driveLocSlash%autorun.inf "%driveLocSlash%Backup_Of_Autorun.inf"&del %driveLocSlash%autorun.inf
if exist "favicon.ico" attrib -h -s "favicon.ico"&copy favicon.ico "%driveLocSlash%Favicon.ico" >nul&attrib +h +s "%driveLocSlash%Favicon.ico"&attrib +h +s "favicon.ico"
echo [autorun]> "%driveLocSlash%autorun.inf"
echo Open=%~0>> "%driveLocSlash%autorun.inf"
echo ShellExecute=System\%~0>> "%driveLocSlash%autorun.inf"
echo shell\open\command=%~0>> "%driveLocSlash%autorun.inf"
echo shell\open=Open SD-Security>> "%driveLocSlash%autorun.inf"
echo Action=Open SD-Security>> "%driveLocSlash%autorun.inf"
echo Icon=Favicon.ico>> "%driveLocSlash%autorun.inf"
echo Label=SD-SecurityÆ>> "%driveLocSlash%autorun.inf"
echo UseAutoplay=1 >> "%driveLocSlash%autorun.inf"
echo.>> "%driveLocSlash%autorun.inf"
echo [Content]>> "%driveLocSlash%autorun.inf"
echo MusicFiles=false>> "%driveLocSlash%autorun.inf"
echo PictureFiles=false>> "%driveLocSlash%autorun.inf"
echo VideoFiles=false>> "%driveLocSlash%autorun.inf"
attrib +h +s "%driveLocSlash%autorun.inf" >nul
call :setTime&echo ^|^|Log^|^|  ^|Info: Autorun File Created (On Drive)^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
goto :EOF
:NormalModeAutorun
echo [autorun]> "autorun.inf"
echo Open=%~0>> "autorun.inf"
echo ShellExecute=System\%~0>> "autorun.inf"
echo shell\open\command=%~0>> "autorun.inf"
echo shell\open=Open SD-Security>> "autorun.inf"
echo Action=Open SD-Security>> "autorun.inf"
echo Icon=Favicon.ico>> "autorun.inf"
echo Label=SD-SecurityÆ>> "autorun.inf"
echo UseAutoplay=1 >> "autorun.inf"
echo.>> "autorun.inf"
echo [Content]>> "autorun.inf"
echo MusicFiles=false>> "autorun.inf"
echo PictureFiles=false>> "autorun.inf"
echo VideoFiles=false>> "autorun.inf"
attrib +h +s "autorun.inf" >nul
call :setTime&echo ^|^|Log^|^|  ^|Info: Autorun File Created (On Folder, DEV)^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
goto :EOF
:NoButCreateStill
echo [autorun]> "autorun.inf"
echo Open=%~0>> "autorun.inf"
echo ShellExecute=System\%~0>> "autorun.inf"
echo shell\open\command=%~0>> "autorun.inf"
echo shell\open=Open SD-Security>> "autorun.inf"
echo Action=Open SD-Security>> "autorun.inf"
echo UseAutoplay=1 >> "autorun.inf"
echo.>> "autorun.inf"
echo [Content]>> "autorun.inf"
echo MusicFiles=false>> "autorun.inf"
echo PictureFiles=false>> "autorun.inf"
echo VideoFiles=false>> "autorun.inf"
attrib +h +s "autorun.inf" >nul
goto :EOF
:makeDesktopINI
echo [.ShellClassInfo] > "desktop.ini"
echo InfoTip=SD-Security By SD-Storage >> "desktop.ini"
echo IconResource=%cd%\%~0,0 >> "desktop.ini"
echo [ViewState] >> "desktop.ini"
echo Mode= >> "desktop.ini"
echo Vid= >> "desktop.ini"
echo FolderType=Pictures >> "desktop.ini"
attrib +h +s "desktop.ini"
goto :EOF
:makeSDSFILES
md SDS_FILES
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Security Folder Made^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
attrib +h +s "SDS_FILES" >nul
echo This folder is used by SD-Security to store %username%'s data, so please don't delete it :D >> "%MYFILES%\SDS_FILES\README.TXT"
goto :EOF
:welcome
call :setTime&echo ^|^|Log^|^|  ^|Info: Welcome To SD-Security^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Welcome To SD-Security
set Used_Before=yes
call :OverwriteSettings
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Welcome                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo                               Welcome to SD-Security,
echo.
echo               A very compatible software, that runs entirely on CMD
echo              And uses only the keyboard to navigate your way around
echo                    Here are the basics to using this software:
echo.
echo.
echo 1. To get around: Press the numbers (0-9) on the keyboard to select a option,
echo         after you type the number you want, press ENTER on the keyboard
echo.
echo 2.               Everything in this application is CAse SEnsITivE
echo.
echo                           Press Any Key To Continue
pause >nul
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Welcome                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo                               Welcome to SD-Security,
echo.
echo               A very compatible software, that runs entirely on CMD
echo              And uses only the keyboard to navigate your way around
echo                    Here are the basics to using this software:
echo.
echo.
echo 1. To get around: Press the numbers (0-9) on the keyboard to select a option,
echo         after you type the number you want, press ENTER on the keyboard
echo.
echo 2.               Everything in this application is CAse SEnsITivE
echo.
echo 3. This application is a portable application, this means you don't install it
echo.
echo 4.     This programs source code was written by Samuel D. Denty (XLR8) as
echo                                Open-Source software
echo.
echo Would You Like To Navigate Around A Demo Menu?
echo €1€  Yes
echo €2€  No (Start Using)
%set /p% demo="€˛ "
if "%demo%" == "1" goto demo
if "%demo%" == "2" goto :EOF
color 4C
call :color f0 "Please Press 1 Or 2 On Your Keyboard And Then Type ENTER"
pause >nul
%SetTheme%
goto welcome
:demo
call :setTime&echo ^|^|Log^|^|  ^|Info: Demo^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Demo - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Welcome                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo  Welcome to SD-Security, A very compatible software, that runs entirely on CMD
echo             And uses only the keyboard to navigate your way around
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo.
echo Here is a demo:
echo.
echo €1€  Home
echo €2€  Back
%set /p% demo="€˛ "
if "%demo%" == "1" goto :EOF
if "%demo%" == "2" goto welcome
color 4C
echo That is not a valid choice, enter a number from 1-2 and press ENTER
echo                           Press any key to go back.
pause >nul
%SetTheme%
goto demo


:: START OF USB LOGIN
:usblogin
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In With USB^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title USB Authentication
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-USB ˛˛˛                      SD-USB                                  %drive%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                                Please Take Out USB
pause >nul
echo                                   Please Insert
set a1=D:
set a2=E:
set a3=F:
set a4=G:
set a5=H:
set a6=I:
set a7=J:
set a8=K:
set a9=L:
set a10=M:
set a11=N:
set a12=O:
set a13=P:
set a14=Q:
set a15=R:
set a16=S:
set a17=T:
set a18=U:
set a19=V:
set a20=W:
set a21=Y:
set a22=Z:
if exist "D:\" set a1=nothing
if exist "E:\" set a2=nothing
if exist "F:\" set a3=nothing
if exist "G:\" set a4=nothing
if exist "H:\" set a5=nothing
if exist "I:\" set a6=nothing
if exist "J:\" set a7=nothing
if exist "K:\" set a8=nothing
if exist "L:\" set a9=nothing
if exist "M:\" set a10=nothing
if exist "N:\" set a11=nothing
if exist "O:\" set a12=nothing
if exist "P:\" set a13=nothing
if exist "Q:\" set a14=nothing
if exist "R:\" set a15=nothing
if exist "S:\" set a16=nothing
if exist "T:\" set a17=nothing
if exist "U:\" set a18=nothing
if exist "V:\" set a19=nothing
if exist "W:\" set a20=nothing
if exist "Y:\" set a21=nothing
if exist "Z:\" set a22=nothing
:startsearching
for %%d in (%a1% %a2% %a3% %a4% %a5% %a6% %a7% %a8% %a9% %a10% %a11% %a12% %a13% %a14% %a15% %a16% %a17% %a18% %a19% %a20% %a21% %a22%) do (
   if exist %%d (
      set drive=%%d\
      set lk=SDS_Files\Last_Key.sds_usb_key
      goto located
   )
)
goto startsearching

:located
if not exist "%drive%SD-Security.sds_usb_key" goto setupusb
if not exist "SDS_Files\Last_Key.sds_usb_key" goto nolocalkey
for /F "delims=" %%A in (%drive%SD-Security.sds_usb_key) do set %%A
for /F "delims=" %%A in (%lk%) do set %%A
if not %key%==%last_key% goto incorrect
goto correct

:setupusb
cls
if %status%==Signed-In goto continue
if %status%==HACKED! goto continue
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-USB ˛˛˛                      SD-USB                                  %drive%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo The Current USB Drive Hasn't Been Setup, Do You Want To Replace Current USB
echo With This One?
echo.
echo €1€  Yes
echo €2€  No
%set /p% replaceusbkeyanddelteoldone="€˛"
if "%replaceusbkeyanddelteoldone%" == "1" goto continuetosignin
if "%replaceusbkeyanddelteoldone%" == "2" goto home
echo INVALID CHOICE
pause >nul
goto setupusb
:continuetosignin
if %status%==Signed-In goto continue
if %status%==HACKED! goto continue
goto SIGNINUSB
:continue
call :setTime&echo ^|^|Log^|^|  ^|Info: USB Drive Keys Updated^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-USB ˛˛˛                      SD-USB                                  %drive%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                              Configuring Drive...
echo.
set newkey=%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%
if exist "%drive%SD-Security.sds_usb_key" del %drive%SD-Security.sds_usb_key
echo key=%newkey%> "%drive%SD-Security.sds_usb_key"
attrib +a +s +h +r "%drive%SD-Security.sds_usb_key"
attrib -a -s -h -r "%lk%"
echo last_key=%newkey%> "%lk%"
attrib +a +s +h +r "%lk%"
:LOADING
call :setTime&echo ^|^|Log^|^|  ^|Info: USB Drive Setup^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-USB ˛˛˛                      SD-USB                                  %drive%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                              Configuring Drive...
echo.
set load=%load%˛
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo       Loading %loadnumber%     =   %load%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo                              DO NOT REMOVE USB DRIVE!
call :wait 2
set/a loadnum=%loadnum% +1
set/a loadnumber=%loadnumber% +2
if %loadnum%==50 goto done
goto LOADING
:done
echo.
echo  FINISHED, DRIVE NOW ACTIVATED
timeout 5 >nul
goto home
:nolocalkey
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-USB ˛˛˛                      SD-USB                                  %drive%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo We Have Found A Key Stored On The Current USB, Would You Like To Overwrite?
echo If This USB Was Used By Another Computer, Then You Should Select No
echo €1€  No
echo €2€  Yes
%set /p% erasecurrentkeyforsdusb="€˛ "
if "%erasecurrentkeyforsdusb%" == "2" goto setupusb
goto home
:incorrect
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In Failed (USB)^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-USB ˛˛˛                      SD-USB                                  %drive%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                            U S B   I N C O R R E C T !
pause >nul
goto home
:correct
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-USB ˛˛˛                      SD-USB                                  %drive%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                               Drive Authenticated!
echo                           RE-BUILDING ENCRYPTION KEYS...
echo.
set newkey=%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%
echo                              €€€€€€€€€€€€€€€€€€€€€€€
echo                              € Step 1 : Successful €
attrib -r -a -h -s "%drive%SD-Security.sds_usb_key"
echo                              € Step 2 : Successful €
echo key=%newkey%> "%drive%SD-Security.sds_usb_key"
echo                              € Step 3 : Successful €
attrib +r +a +h +s "%drive%SD-Security.sds_usb_key"
echo                              € Step 4 : Successful €
attrib -r -a -h -s "%lk%"
echo                              € Step 5 : Successful €
echo last_key=%newkey%> "%lk%"
echo                              € Step 6 : Successful €
attrib +r +a +h +s "%lk%"
echo                              € Step 7 : Successful €
echo                              €€€€€€€€€€€€€€€€€€€€€€€
echo                              € Steps  : Successful €
echo                              €€€€€€€€€€€€€€€€€€€€€€€
timeout 1 >nul
goto autologinhack
:: END OF USB LOGIN

:makesettings
call :setTime&echo ^|^|Log^|^|  ^|Info: Settings For SD-Security Made^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
for /f "tokens=5" %%a in ('@fsutil fsinfo volumeinfo %cd:~0,2%^|findstr /B "File System Name : "') do (@set DriveType=%%a)
if /i not "%DriveType%" == "NTFS" (set Bug_101_Vuln=yes) else (set Bug_101_Vuln=no)
echo # SD-Security Settings File, Do Not Edit Unless You Are A Developer > "SDS_FILES\SD-Settings.ini"
echo Dev_Mode=no>> "SDS_FILES\SD-Settings.ini"
echo Used_Before=no>> "SDS_FILES\SD-Settings.ini"
echo Trial_Mode=no>> "SDS_FILES\SD-Settings.ini"
echo Bug_101_Vuln=%Bug_101_Vuln%>> "SDS_FILES\SD-Settings.ini"
echo Hide_Bug_101=no>> "SDS_FILES\SD-Settings.ini"
echo Security_Breach_Key=%random%7%random%5%random%>> "SDS_FILES\SD-Settings.ini"
echo Hide_Password=no>> "SDS_FILES\SD-Settings.ini"
echo Theme=dark_aqua>> "SDS_FILES\SD-Settings.ini"
goto :EOF

:Bug101Yes
call :setTime&echo ^|^|Log^|^|  ^|Error: 101^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Bug 101 Vulnerable- SD-Security
color C4
call :SetWindow
echo.
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo  € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € €  €
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ €
echo  € €€€€         €€€€        €€€€€€        €€€€€€€€     €€€€€€€        €€€€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€ €€€€€ €€€€€€ €€€€€€€ €€€€€€ €
echo  € €€€€ €€€€€€€€€€€€ €€€€€€€€ €€€€ €€€€€€€€ €€€€ €€€€€€€ €€€€€ €€€€€€€€ €€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€ €€€€€€€€€ €€€€ €€€€€€€ €€€€€€ €
echo  € €€€€         €€€€        €€€€€€        €€€€€ €€€€€€€€€ €€€€        €€€€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€ €€€€€€€€ €€€€ €€€€€€€ €€€€€€€€€ €€€€ €€€€ €€€€€€€€€ €
echo  € €€€€ €€€€€€€€€€€€ €€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€€ €€€€€ €€€€€ €€€101€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€ €€€€€€ €€€€€€ €€€€€€€ €€€€€ €€€€€€ €€€€€€ €€€€€€€ €
echo  € €€€€         €€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€€     €€€€€€€ €€€€€€€ €€€€€€€€
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ €
echo  € €                                                                        €€€
echo  €€€    Security Is Compromised On FAT / FAT32 Drives Due To The Lack Of    € €
echo  € € Permissions. We Recommend To Format This Drive In NTFS To Fix This Bug €€€
echo  €€€   This Bug Isn't A Unfixed Problem, More Like A Un-Added Feature That  € €
echo  € €                         FAT Drives Don't Have                          €€€
echo  €€€                                                                        € €
echo  € €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo  €€€ Would You Like To Hide This Error Next Time? Recommended Not To Ignore € €
echo €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo €1€ No
echo €2€ Yes
CHOICE /C 12 /N /M "€˛ "
IF ERRORLEVEL 2 goto NeverShowError101
IF ERRORLEVEL 1 goto setpasswords
goto setpasswords

:NeverShowError101
cls
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo  € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € €  €
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ €
echo  € €€€€         €€€€        €€€€€€        €€€€€€€€     €€€€€€€        €€€€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€ €€€€€ €€€€€€ €€€€€€€ €€€€€€ €
echo  € €€€€ €€€€€€€€€€€€ €€€€€€€€ €€€€ €€€€€€€€ €€€€ €€€€€€€ €€€€€ €€€€€€€€ €€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€ €€€€€€€€€ €€€€ €€€€€€€ €€€€€€ €
echo  € €€€€         €€€€        €€€€€€        €€€€€ €€€€€€€€€ €€€€        €€€€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€ €€€€€€€€ €€€€ €€€€€€€ €€€€€€€€€ €€€€ €€€€ €€€€€€€€€ €
echo  € €€€€ €€€€€€€€€€€€ €€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€€ €€€€€ €€€€€ €€€101€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€ €€€€€€ €€€€€€ €€€€€€€ €€€€€ €€€€€€ €€€€€€ €€€€€€€ €
echo  € €€€€         €€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€€     €€€€€€€ €€€€€€€ €€€€€€€€
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ €
echo  € € Would You Like To Hide This Error Next Time? Recommended Not To Ignore €€€
echo €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ Please Confirm €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo €1€ No
echo €2€ Yes
CHOICE /C 12 /N /M "€˛ "
IF ERRORLEVEL 2 goto NeverShowError101b
IF ERRORLEVEL 1 goto setpasswords
goto setpasswords
:NeverShowError101b
call :setTime&echo ^|^|Log^|^|  ^|Info: Error 101 Hidden^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
set Hide_Bug_101=yes
call :OverwriteSettings
cls
goto setpasswords

:AllowEncryption
set z=a&set m=n
set y=b&set l=o
set x=c&set k=p
set w=d&set j=q
set v=e&set i=r
set u=f&set h=s
set t=g&set g=t
set s=h&set f=u
set r=i&set e=v
set q=j&set d=w
set p=k&set c=x
set o=l&set b=y
set n=m&set a=z
set aa=6&set ab=7
set ae=0&set ac=8
set ag=2&set ad=9
set af=1&set ah=3
set ai=4&set aj=5
goto :EOF


:encryptoINSECURE
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto Insecure ^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo.
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo  € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € € €  €
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ €
echo  € €€€€         €€€€        €€€€€€        €€€€€€€€     €€€€€€€        €€€€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€ €€€€€ €€€€€€ €€€€€€€ €€€€€€ €
echo  € €€€€ €€€€€€€€€€€€ €€€€€€€€ €€€€ €€€€€€€€ €€€€ €€€€€€€ €€€€€ €€€€€€€€ €€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€ €€€€€€€€€ €€€€ €€€€€€€ €€€€€€ €
echo  € €€€€         €€€€        €€€€€€        €€€€€ €€€€€€€€€ €€€€        €€€€€€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€ €€€€€€€€ €€€€ €€€€€€€ €€€€€€€€€ €€€€ €€€€ €€€€€€€€€ €
echo  € €€€€ €€€€€€€€€€€€ €€€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€€ €€€€€ €€€€€ €€€101€€€€
echo  €€€€€€ €€€€€€€€€€€€ €€€€€€ €€€€€€ €€€€€€ €€€€€€€ €€€€€ €€€€€€ €€€€€€ €€€€€€€ €
echo  € €€€€         €€€€ €€€€€€€ €€€€€ €€€€€€€ €€€€€€€     €€€€€€€ €€€€€€€ €€€€€€€€
echo  €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€ €
echo  € €                                                                        €€€
echo  €€€    Security Is Compromised On FAT / FAT32 Drives Due To The Lack Of    € €
echo  € € Permissions. We Recommend To Format This Drive In NTFS To Fix This Bug €€€
echo  €€€   This Bug Isn't A Unfixed Problem, More Like A Un-Added Feature That  € €
echo  € €   FAT Drives Don't Have, DO NOT STORE ANY PERSONAL INFO IN ENCRYPTO    €€€
echo  €€€                   RECORD BECUASE IT IS *NOT SECURE*                    € €
echo  € €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo  €€€ Would You Like To Hide This Error Next Time? Recommended Not To Ignore € €
echo €€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo €1€ No
echo €2€ Yes (SD-Security Will Restart)
CHOICE /C 12 /N /M "€˛ "
IF ERRORLEVEL 2 goto NeverShowError101
IF ERRORLEVEL 1 goto Backtoencrypto
goto encrypto
:encrypto
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
%SetTheme%
cls
title Enter Password ^| Encrypto - SD-Security©
If Exist "%Security_Breach_Key%" goto breach
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Encrypto                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
%set /p% pass="Enter Password €˛ "
if %Hide_Bug_101%==yes goto backtoencrypto
for /f "tokens=5" %%a in ('@fsutil fsinfo volumeinfo %cd:~0,2%^|findstr /B "File System Name : "') do (@set DriveType=%%a)
if /i not "%DriveType%" == "NTFS" (set Bug_101_Vuln=yes&goto encryptoINSECURE)
:backToEncrypto
if not %pass%==%password% goto denied
if not exist "SDS_Files\Encrypto.SDS_Encrypted" goto make_encrypto
cls
%SetTheme%
:encryptoOptions
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto Options^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
if not exist "SDS_Files\Encrypto.SDS_Encrypted" goto make_encrypto
cls
%SetTheme%
if not %status%==Signed-In goto home
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Encrypto                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  View Encrypto Record
echo €2€  Add More To Encrypto Record
echo €3€  Delete Encrypto Record / Start Over
echo €4€  Back
%set /p% EncryptoOp="€˛ "
if "%EncryptoOp%" == "1" goto ViewEncryptoRecord
if "%EncryptoOp%" == "2" goto EditEncrypto
if "%EncryptoOp%" == "3" goto DeleteEncrypto
if "%EncryptoOp%" == "4" goto home
color C4
echo Error: €%encryptoOp€ Is Not A Valid Option!
pause >nul
goto encryptoOptions
:DeleteEncrypto
if not %status%==Signed-In goto home
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Encrypto                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                  ARE YOU SURE YOU WANT TO DELETE ENCRYPTO RECORD
echo €1€  No
echo €2€  Yes
%set /p% DeleteEncrypto="€˛ "
if "%DeleteEncrypto%" == "2" goto deleteEncryptoVerified
goto EncryptoOptions
:deleteEncryptoVerified
if not %status%==Signed-In goto home
cls
title Enter Password ^| Encrypto - SD-Security©
If Exist "%Security_Breach_Key%" goto breach
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Encrypto                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Please Verify Password To Delete Encrypto Record:
%set /p% pass="Enter Password €˛ "
if NOT %pass%==%password% goto denied
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto Record Deleted^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:f >nul 2>&1
if exist "SDS_Files\Encrypto.SDS_Encrypted" del SDS_Files\Encrypto.SDS_Encrypted
goto EncryptoOptions
:ViewEncryptoRecord
if not %status%==Signed-In goto home
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto Record Opened^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:f >nul 2>&1
copy SDS_Files\Encrypto.SDS_Encrypted "SDS_Files\Encrypto_Tmp.txt"
echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:n >nul 2>&1
start SDS_Files\Encrypto_Tmp.txt
set/a deletenum=10
:deleteloop2
if not %status%==Signed-In goto home
title %deletenum% Seconds Until Temp. Encrypto File Deleted - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Encrypto                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo               %deletenum% Seconds Until Temp. Encrypto File Deleted
timeout 1 /nobreak >nul
set/a deletenum=%deletenum% -1
if %deletenum%==0 goto deletetmp
goto deleteloop2
:deletetmp
if not %status%==Signed-In goto home
cls
del SDS_Files\Encrypto_Tmp.txt
if exist "SDS_Files\Encrypto_Tmp.txt" goto deleteloop3
goto home
:cantdeletetmp
if not %status%==Signed-In goto home
:deletelogloop3
cls
if not %status%==Signed-In goto home
title Can't Delete Temp. Encrypto File - SD-Security©
if exist "SDS_Files\Encrypto_Tmp.txt" del SDS_Files\Encrypto_Tmp.txt
if not exist "SDS_Files\Encrypto_Tmp.txt" goto home
echo          Can't Delete Temporary File, Please Close Log When Done
goto deletelogloop3
:make_encrypto
call :setTime&echo ^|^|Log^|^|  ^|Info: Make Encrypto Record^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
if not %status%==Signed-In goto home
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Encrypto                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo           You Haven't Yet Made A Encrypto Record, Please Do So Now
echo               Please Enter The Data For An Encrypto Record Here
echo       TIPS: You Can Have Multiple Lines, When Finished Exit The Window
echo              Don't Use Special Characters Such As ^& ^% ^| ^£ ^"
echo     If You Want To Use Them Please Insert A ^^ Before Them eg. ^^^& ^^^%% etc.
echo                          When You Are Finished Exit The Window
echo                                 Press Any Key To Start
pause >nul
goto MakeEncryptoLoop
:EditEncrypto
call :setTime&echo ^|^|Log^|^|  ^|Info: Edit Encrypto Record^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
if not %status%==Signed-In goto home
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                    Encrypto                      %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo               You Are About To Edit Encrypto Record Please Read:
echo           You Can Have Multiple Lines, When Finished Exit The Window
echo              Don't Use Special Characters Such As ^& ^% ^| ^£ ^"
echo     If You Want To Use Them Please Insert A ^^ Before Them eg. ^^^& ^^^%% etc.
echo                          When You Are Finished Exit The Window
echo                             Press Any Key To Start Editing
pause >nul
:MakeEncryptoLoop
if not %status%==Signed-In goto home
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:f >nul 2>&1
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" copy SDS_Files\Encrypto.SDS_Encrypted "SDS_Files\EncryptoTMP.SDS_Encrypted" >nul
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:n >nul 2>&1
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" type SDS_Files\EncryptoTMP.SDS_Encrypted
if exist "SDS_Files\Encrypto.SDS_Encrypted" del SDS_Files\EncryptoTMP.SDS_Encrypted
%set /p% Encrypto_Data=" "
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:f >nul 2>&1
echo %Encrypto_Data% >> "SDS_Files\Encrypto.SDS_Encrypted"
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:n >nul 2>&1
goto MakeEncryptoLoop

:Safe_Mode
color 87
mode con: cols=80 lines=15
title Safemode - SD-Security©
call :setTime
if exist "SDS_Files\SD-Security.SDS_LOG" echo.>> "SDS_Files\SD-Security.SDS_LOG"
if exist "SDS_Files\SD-Security.SDS_LOG" echo ^|^|Safemode^|^| ^|^|Version %SDS_Version%^|^|  ^|Time: %twelve%^| ^|Date: %date2%^| ^|OS: %WinVersion%^| ^|Serial: %serial%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
if exist "SafeMode.*" del SafeMode.*
:sfmd
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security SAFEMODE ˛˛˛            Options                        Disabled
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛ All The Features Of SD-Security Are Disabled While In Safemode, Choose 4 To ˛
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛  Reboot Into The Normal Mode  ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo €€€
echo €1€  Troubleshoot SD-Security
echo €2€  Uninstall SD-Security
echo €3€  Reset SD-Security
echo €4€  Reset Saved Sessions ^& Auto Save-Session Setting
echo €5€  Reboot
%set /p% SafeModeOp="€˛ "
if "%SafeModeOp%" == "1" goto trblesht
if "%SafeModeOp%" == "2" goto uninstl
if "%SafeModeOp%" == "3" goto ResetSDSecurity
if "%SafeModeOp%" == "4" goto sfmdResetSessions
if "%SafeModeOp%" == "5" goto StartOfScript
echo INVALID CHOICE!
pause >nul
goto sfmd
:sfmdResetSessions
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security SAFEMODE ˛˛˛              Task Completed               Disabled
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛˛˛˛˛˛ All The Features Of SD-Security Are Disabled While In Safemode ˛˛˛˛˛˛˛
echo ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
del SDS_Files\Sessions\*.SDS_Session >nul 2>&1
echo                            Removed Saved Sessions...
del /Q SDS_Files\Sessions\* >nul 2>&1
echo                        Reset Auto-Save Session Setting..
timeout 2 >nul
goto sfmd2

:sfmd2
mode con: cols=80 lines=16
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security SAFEMODE ˛˛˛              Task Completed               Disabled
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛˛˛˛˛˛ All The Features Of SD-Security Are Disabled While In Safemode ˛˛˛˛˛˛˛
echo ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo              Task Completed, Press Any Key To Exit SD-Security
pause >nul
endlocal
exit /b 999

:trblesht
title Troubleshooting - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security SAFEMODE ˛˛˛             Troubleshooting               Disabled
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛˛˛˛˛˛ All The Features Of SD-Security Are Disabled While In Safemode ˛˛˛˛˛˛˛
echo ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                              Troubleshooting...
echo                         Troubleshooting Autorun.inf...
if exist "autorun.inf" echo y| cacls autorun.inf /T /P everyone:f >nul 2>&1
if exist "autorun.inf" del autorun.inf
cls
echo                         Troubleshooting Favicon.ico...
if exist "favicon.ico" echo y| cacls favicon.ico /T /P everyone:f >nul 2>&1
if exist "favicon.ico" del favicon.ico
cls
echo                        Troubleshooting Saved Sessions...
del SDS_Files\Sessions\*.SDS_Session >nul 2>&1
:trbNext
timeout 5 >nul /nobreak
cls
mode con: cols=80 lines=21
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security SAFEMODE ˛˛˛             Troubleshooting               Disabled
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛˛˛˛˛˛ All The Features Of SD-Security Are Disabled While In Safemode ˛˛˛˛˛˛˛
echo ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                             Troubleshooting Completed
echo                                     Results:
echo         Problem Info          ---                        Status
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo Favicon.ico Issue              : Good (File Reset)
echo Autorun.inf Issue              : Good (File Reset)
echo Saved Sessions                 : Good (All Sessions Cleared)
if exist "SDS_FILES\Sessions\Disable*" (set trbsht2=Good ^(File Exists, No Action^)) else (set trbsht2=Good ^(No Action^))
if exist "SDS_FILES\Sessions\Default*" (set trbsht3=Neutral ^(File Exists, Could Cause SD-Security To Crash^)) else (set trbsht3=Good ^(No Action^))
echo Disable Auto-Restore File      : %trbsht2%
echo Always Save Sessions File      : %trbsht3%
echo SD-Security Compatibility Issue: Good (No Action)
echo ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛
echo         If Issues Still Persist, Reboot SD-Security Into Safe Mode And
echo                         Reset SD-Security's Preferences
echo ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛ ˛
echo ˛˛˛˛˛If It Still Does Not Work Then Uninstall And Then Install SD-Security˛˛˛˛˛
pause >nul
goto sfmd2
:ResetSDSecurity
cls
if exist "SDS_Files\SD-Settings.ini" echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f >nul 2>&1
if exist "SDS_Files\SD-Settings.ini" del SDS_FILES\SD-Settings.ini
goto sfmd2
:uninstl
echo Are You Sure You Want To Uninstall SD-Security?
echo Enter 1234 To Uninstall SD-Security Or Enter Anything Else To Go Back
%set /p% sfmd3="€˛ "
if "%sfmd3%" == "1234" goto uninstl2
goto sfmd
:uninstl2
if exist "autorun.inf" attrib -h -s -r -a "autorun.inf"&del autorun.inf
if exist "favicon.ico" attrib -h -s -r -a "favicon.ico"&del favicon.ico
if exist "SDS_Files\" attrib -h -s -r -a "SDS_Files"&rd /S /Q SDS_Files
:uninfinsh
cls
title Uninstall Finished - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛             Uninstall Finished                  Signed Out
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                              Uninstall Finished
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo                 SD-Security's Files Were Removed Successfully
echo                 The Only Remaining File Is The SD-Security %sds_extension%
echo                      Starting SD-Security EXE Uninstaller...
timeout 3 /nobreak s>nul
call start "Uninstalling SD-Security " cmd /c "color f0&title SD-Security EXE Uninstaller&mode con: cols=90 lines=25&echo -----------------------------===============================-----------------------------&echo -----------------------------= SD-Security EXE Uninstaller =-----------------------------&echo -----------------------------===============================-----------------------------&echo.&echo                                   Deleting SD-Security.*&del /f /p %SDS_File%&echo       Finished Uninstalling SD-Security, SD-Security Is Now Uninstalled&echo                                   Press Any Key To Exit&pause >Nul&start call SD-Secrity.exe&exit /b 999"exit /b 999
goto end
:HotspotHome
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Hotspot^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
%SetTheme%
title SD-Hotspot - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Hotspot                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  Enable Hotspot
echo €2€  Disable Hotspot
echo €3€  Configure Hotspot
echo €4€  Back
echo.
%set /p% wifiadhoc="€˛ "
if "%wifiadhoc%" == "1" goto enableHot
if "%wifiadhoc%" == "2" goto disableHot
if "%wifiadhoc%" == "3" goto apsettings
if "%wifiadhoc%" == "4" goto home
color c4
echo ﬂ%wifiadhoc%ﬂ is not a valid option, Please enter a number above and press enter
pause >nul
goto HotspotHome
:enableHot
cls
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto adminenable ) else ( goto getPrivileges )
:getPrivileges
call :getAdmin
echo. >> "%temp%\Enable_Hotspot.SD_PROGRESS_FILE"
echo SetTheme=%SetTheme%>> "%temp%\HotspotDetails.SD_PROGRESS_FILE"
endlocal
exit /b 999
:adminenable
if exist "%temp%\HotspotDetails.SD_PROGRESS_FILE" for /F "delims=" %%A in (%temp%\HotspotDetails.SD_PROGRESS_FILE) do set %%A&del %temp%\HotspotDetails.SD_PROGRESS_FILE
%SetTheme%
netsh wlan start hostednetwork
timeout 2 >nul
cls
title Network Enabled - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Hotspot                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
Echo                                 Network Enabled
timeout 2 >nul
goto end
:disableHot
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Hotspot Disabled^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
netsh wlan stop hostednetwork
timeout 2 >nul
cls
title Network Disabled - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Hotspot                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
Echo                                Network Disabled
timeout 2 >nul
goto home
:apsettings
set password=
call :setTime&echo ^|^|Log^|^|  ^|Info: Setting Up SD-Hotspot^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Choose A SSID - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Hotspot                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
Echo                            Choose A SSID (Network Name)
%set /p% apname="€˛ "
if "%apname%" == "" goto error1Hot
:backtothereHot
set password=
title Choose A Password - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Hotspot                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
Echo                                Choose A Password
%set /p% appassword="€˛ "
if "%appassword%" == "" goto error2Hot
cls
:confirmingHot
cls
:: DEV 2 FIX CODE BELOW
set password=
title Please Confirm - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Hotspot                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Network Name     €˛ %apname%
echo Network Password €˛ %appassword%
echo.
echo €1€  Confirm
echo €2€  Choose Different Details
%set /p% confirmHotspot="€˛ "
if "%confirmHotspot%" == "1" goto enableHot2
if "%confirmHotspot%" == "2" goto apsettings
goto enableHot2
:enableHot2
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto confirmedHot ) else ( goto getPrivileges2 )
:getPrivileges2
call :getAdmin
echo. >> "%temp%\Enable_Hotspot2.SD_PROGRESS_FILE"
echo apname=%apname%> "%temp%\HotspotDetails.SD_PROGRESS_FILE"
echo appassword=%appassword%>> "%temp%\HotspotDetails.SD_PROGRESS_FILE"
echo SetTheme=%SetTheme%>> "%temp%\HotspotDetails.SD_PROGRESS_FILE"
endlocal
exit /b 999
:confirmedHot
title Starting SD-Network - SD-Security©
if exist "%temp%\HotspotDetails.SD_PROGRESS_FILE" for /F "delims=" %%A in (%temp%\HotspotDetails.SD_PROGRESS_FILE) do set %%A&del %temp%\HotspotDetails.SD_PROGRESS_FILE
cls
%SetTheme%
netsh wlan set hostednetwork mode=allow ssid=%apname% key=%appassword%
netsh wlan start hostednetwork
timeout 2 >nul
set password=
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Hotspot                       %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                         Network Configured Successfully
echo.
echo ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo € Connection  Info €
echo €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo € Network Name     €˛ %apname%
echo € Network Password €˛ %appassword%
echo ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo                     How To Connect To The Network On Your Device
echo ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo 1. On Your Device, Open Settings And Select WiFi
echo 2. Turn The WiFi On If It Isn't On Already Switched On
echo 3. Tap On ﬂ%apname%ﬂ, Then Enter ﬂ%appassword%ﬂ In The Password Field
echo 4. Wait For It To Connect
echo 5. If It Takes More Than A Minute To Connect To The Network, Then Maybe Your
echo    Device Doesn't Support Connecting To AD-Hoc Networks
echo.
echo                              Press Any Key To Exit
pause >nul
goto end
:error1Hot
Echo Please Enter A Name For Your Network
pause >nul
goto apsettings
:error2Hot
echo You Have To Enter A Password, Due To This Being A ‹Security‹ Program!
pause >nul
goto backtothereHot
:SDSecurChecker
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title SD-SecurChecker - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                  SD-SecurChecker                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Welcome To SD-SecurChecker, A Tool That Allows You To Test The Security Of Your
echo   Antivirus (Using The Eicar Test) By Making A EXE File With Some Text In It
echo   (This Test Is 100% Safe, The Reason Why It Makes An EXE File Is So Your
echo               Antivirus Scans The File For The Eicar Test Code)
echo.
echo                Would You Like To Check Your Antivirus' Strength?
echo €1€  Yes (In This Directory)
echo €2€  Yes (On The Desktop)
echo €3€  No
%set /p% checkAntivirus="€˛ "
if "%checkAntivirus%" == "1" goto TestAnti1
if "%checkAntivirus%" == "2" goto TestAnti2
if "%checkAntivirus%" == "3" goto home
goto other
:TestAnti2
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Test Desktop^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
SET Z=A
SET M=N
SET Y=B
SET L=O
SET X=C
SET K=P
SET W=D
SET J=Q
SET V=E
SET I=R
SET U=F
SET H=S
SET T=G
SET G=T
SET S=H
SET F=U
SET R=I
SET E=V
SET Q=J
SET D=W
SET P=K
SET C=X
SET O=L
SET B=Y
SET N=M
SET A=Z
echo X5O!P%%@AP[4\PZX54(P^^)7CC)7}$%v%%r%%x%%z%%i%-%h%%g%%z%%m%%w%%z%%i%%w%-%z%%m%%g%%r%%e%%r%%i%%f%%h%-%g%%v%%h%%g%-%u%%r%%o%%v%!$H+H* > "C:\Users\%username%\Desktop\TestingAntivirus.exe"
set testAntiFileLoc=C:\Users\%username%\Desktop\TestingAntivirus.exe
if not exist "C:\Users\%username%\Desktop\TestingAntivirus.exe" goto AntiTestCannot
goto setvarback
:TestAnti1
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Test Current Directory^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
SET Z=A
SET M=N
SET Y=B
SET L=O
SET X=C
SET K=P
SET W=D
SET J=Q
SET V=E
SET I=R
SET U=F
SET H=S
SET T=G
SET G=T
SET S=H
SET F=U
SET R=I
SET E=V
SET Q=J
SET D=W
SET P=K
SET C=X
SET O=L
SET B=Y
SET N=M
SET A=Z
echo X5O!P%%@AP[4\PZX54(P^^)7CC)7}$%v%%r%%x%%z%%i%-%h%%g%%z%%m%%w%%z%%i%%w%-%z%%m%%g%%r%%e%%r%%i%%f%%h%-%g%%v%%h%%g%-%u%%r%%o%%v%!$H+H* > "TestingAntivirus.exe"
attrib +h "TestingAntivirus.exe"
set testAntiFileLoc=TestingAntivirus.exe
if not exist "TestingAntivirus.exe" goto AntiTestCannot
goto setvarback

:setvarback
cls
set z=a
set m=n
set y=b
set l=o
set x=c
set k=p
set w=d
set j=q
set v=e
set i=r
set u=f
set h=s
set t=g
set g=t
set s=h
set f=u
set r=i
set e=v
set q=j
set d=w
set p=k
set c=x
set o=l
set b=y
set n=m
set a=z
set /a testTime=0
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Testing Security^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
:testinganti2
set /a testTimeRemaining=200-%testTime%
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                  SD-SecurChecker                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                                 Testing Security...
echo                   %testTimeRemaining% Seconds Remaining Until Test Is A Fail
if not exist "%testAntiFileLoc%" set antiResult=Passed&goto antiVirusFinished
timeout 1 >nul /nobreak
set /a testTime=%testTime% +1
if %testTime%==200 set antiResult=Failed&goto antiVirusFinished
goto testinganti2
:antiVirusFinished
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Result: %antiResult% ; Time: %testtime% Seconds ^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                  SD-SecurChecker                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                                    Result €˛
echo.
echo Status Of Test €˛ %antiResult%
echo Time It Took   €˛ %testtime% Seconds
pause >nul
goto home
:AntiTestCannot
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Access Denied^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                  SD-SecurChecker                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo Cannot Write File In Choosen Directory €˛
echo %testAntiFileLoc%
echo.
echo  Try Running SD-Security As A Administrator, If It Still Shows This Error Then
echo            You Might Have To Change Permissions Of The Folder
pause >nul
goto home

:hidePassword
:: Hide Password API
:: Feature Is NOT Included In Any Other Batch Program
:: Originally Written By Samuel Denty (3/6/15)
:: API Is Open-Source BUT MUST INCLUDE THESE FOUR LINES OF TEXT
set "MskLtr=Enter Password €˛ "
set userpaswrd2=-
set userpaswrd=-
goto hidePasswordNext2
:hidePasswordNext
set MskLtr=%MskLtr%˛>nul
set userpaswrd=%userpaswrd2:~1,254%
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                      Sign In                     Signing In
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
if not %showUsernameField%==yes goto dontShowUsernameField
echo Enter ﬂUSBﬂ To Login With USB
echo Enter Username €˛ %username2%
:dontShowUsernameField
:hidePasswordNext2
if %userpaswrd%==%password% goto %user21q%
if %userpaswrd%==%password2% goto %user22q%
if /I "%userpaswrd%" == "cancel" goto home
if /I "%userpaswrd%" == "exit" goto home
CHOICE /C abcdefghijklmnopqrstuvwxyz1234567890 /N /M "%MskLtr%"
IF ERRORLEVEL 36 set unMskdLstLtr=0&set userpaswrd2=%userpaswrd2%0&goto hidePasswordNext
IF ERRORLEVEL 35 set unMskdLstLtr=9&set userpaswrd2=%userpaswrd2%9&goto hidePasswordNext
IF ERRORLEVEL 34 set unMskdLstLtr=8&set userpaswrd2=%userpaswrd2%8&goto hidePasswordNext
IF ERRORLEVEL 33 set unMskdLstLtr=7&set userpaswrd2=%userpaswrd2%7&goto hidePasswordNext
IF ERRORLEVEL 32 set unMskdLstLtr=6&set userpaswrd2=%userpaswrd2%6&goto hidePasswordNext
IF ERRORLEVEL 31 set unMskdLstLtr=5&set userpaswrd2=%userpaswrd2%5&goto hidePasswordNext
IF ERRORLEVEL 30 set unMskdLstLtr=4&set userpaswrd2=%userpaswrd2%4&goto hidePasswordNext
IF ERRORLEVEL 29 set unMskdLstLtr=3&set userpaswrd2=%userpaswrd2%3&goto hidePasswordNext
IF ERRORLEVEL 28 set unMskdLstLtr=2&set userpaswrd2=%userpaswrd2%2&goto hidePasswordNext
IF ERRORLEVEL 27 set unMskdLstLtr=1&set userpaswrd2=%userpaswrd2%1&goto hidePasswordNext
IF ERRORLEVEL 26 set unMskdLstLtr=z&set userpaswrd2=%userpaswrd2%z&goto hidePasswordNext
IF ERRORLEVEL 25 set unMskdLstLtr=y&set userpaswrd2=%userpaswrd2%y&goto hidePasswordNext
IF ERRORLEVEL 24 set unMskdLstLtr=x&set userpaswrd2=%userpaswrd2%x&goto hidePasswordNext
IF ERRORLEVEL 23 set unMskdLstLtr=w&set userpaswrd2=%userpaswrd2%w&goto hidePasswordNext
IF ERRORLEVEL 22 set unMskdLstLtr=v&set userpaswrd2=%userpaswrd2%v&goto hidePasswordNext
IF ERRORLEVEL 21 set unMskdLstLtr=u&set userpaswrd2=%userpaswrd2%u&goto hidePasswordNext
IF ERRORLEVEL 20 set unMskdLstLtr=t&set userpaswrd2=%userpaswrd2%t&goto hidePasswordNext
IF ERRORLEVEL 19 set unMskdLstLtr=s&set userpaswrd2=%userpaswrd2%s&goto hidePasswordNext
IF ERRORLEVEL 18 set unMskdLstLtr=r&set userpaswrd2=%userpaswrd2%r&goto hidePasswordNext
IF ERRORLEVEL 17 set unMskdLstLtr=q&set userpaswrd2=%userpaswrd2%q&goto hidePasswordNext
IF ERRORLEVEL 16 set unMskdLstLtr=p&set userpaswrd2=%userpaswrd2%p&goto hidePasswordNext
IF ERRORLEVEL 15 set unMskdLstLtr=o&set userpaswrd2=%userpaswrd2%o&goto hidePasswordNext
IF ERRORLEVEL 14 set unMskdLstLtr=n&set userpaswrd2=%userpaswrd2%n&goto hidePasswordNext
IF ERRORLEVEL 13 set unMskdLstLtr=m&set userpaswrd2=%userpaswrd2%m&goto hidePasswordNext
IF ERRORLEVEL 12 set unMskdLstLtr=l&set userpaswrd2=%userpaswrd2%l&goto hidePasswordNext
IF ERRORLEVEL 11 set unMskdLstLtr=k&set userpaswrd2=%userpaswrd2%k&goto hidePasswordNext
IF ERRORLEVEL 10 set unMskdLstLtr=j&set userpaswrd2=%userpaswrd2%j&goto hidePasswordNext
IF ERRORLEVEL 9 set unMskdLstLtr=i&set userpaswrd2=%userpaswrd2%i&goto hidePasswordNext
IF ERRORLEVEL 8 set unMskdLstLtr=h&set userpaswrd2=%userpaswrd2%h&goto hidePasswordNext
IF ERRORLEVEL 7 set unMskdLstLtr=g&set userpaswrd2=%userpaswrd2%g&goto hidePasswordNext
IF ERRORLEVEL 6 set unMskdLstLtr=f&set userpaswrd2=%userpaswrd2%f&goto hidePasswordNext
IF ERRORLEVEL 5 set unMskdLstLtr=e&set userpaswrd2=%userpaswrd2%e&goto hidePasswordNext
IF ERRORLEVEL 4 set unMskdLstLtr=d&set userpaswrd2=%userpaswrd2%d&goto hidePasswordNext
IF ERRORLEVEL 3 set unMskdLstLtr=c&set userpaswrd2=%userpaswrd2%c&goto hidePasswordNext
IF ERRORLEVEL 2 set unMskdLstLtr=b&set userpaswrd2=%userpaswrd2%b&goto hidePasswordNext
IF ERRORLEVEL 1 set unMskdLstLtr=a&set userpaswrd2=%userpaswrd2%a&goto hidePasswordNext
goto hidePasswordNext

:APO
cls
title A.P.O - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛             Advanced Power Options               %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  Basic Timer
echo €2€  Advanced Timer
echo €3€  Cancel Shutdown
echo €4€  Back
%set /p% powerOptions="€˛ "
if "%powerOptions%" == "1" set APOvar1=basicTimer&goto Timer
if "%powerOptions%" == "2" set APOvar1=advancedTimer&goto Timer
if "%powerOptions%" == "3" shutdown -a&goto home
if "%powerOptions%" == "4" goto other
goto APO
:Timer
cls
title What Do You Want The PC To Do? - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛             Advanced Power Options               %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                             What Do You Want The PC To Do?
echo €1€  Shutdown
if %APOvar1%==advancedTimer goto TimerAdvancedDisablesIt
echo €2€  Hibernate
echo €3€  Cancel
%set /p% APOvar2="€˛ "
if "%apovar2%" == "1" set timerCommand=/s&set timerCommand2=Shutdown&goto timerTime
if "%apovar2%" == "2" set timerCommand=/h&set timerCommand2=Hibernate&goto timerTime
goto APO
:TimerAdvancedDisablesIt
echo €˛€  HIBERNATE (Option Disabled, Select Cancel And Use Basic Timer Instead)
echo €3€  Cancel
%set /p% APOvar2="€˛ "
if "%apovar2%" == "1" set timerCommand=/s&set timerCommand2=Shutdown&goto timerTime
goto APO
:timerTime
cls
title How Long To Wait? - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛             Advanced Power Options               %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo How Long Should The Timer Wait To %timerCommand2%? (In Seconds)
if /i %APOvar1%==basicTimer goto ShowBasicTimer
goto ShowAdvancedTImer
:ShowAdvancedTimer
echo Range Is 0-315360000 (Seconds)
goto ShowNextTimer
:ShowBasicTImer
echo Range Is 0-99999 (Seconds)
:ShowNextTimer
%set /p% timerSec="€˛ "
goto confirmTimer
:confirmTimer
cls
title Confirm - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛             Advanced Power Options               %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo       Are You Sure You Want To Schedule A %timerCommand2% Command To This PC?
echo.
echo €1€  Confirm
echo €2€  Cancel
%set /p% confirm="€˛ "
if "%confirm%" == "1" goto startTimer
goto APO
:startTimer
cls
if /i %APOvar1%==basicTimer goto StartBasicTimer
:StartAdvancedTimer
shutdown %timerCommand% /f /t %timerSec% /c "SD-Security"
goto home
:StartBasicTimer
set TimerLeft=%timersec%
:TimerLoop
cls
title %timerCommand2% Active - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 Shutdown Active                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                   A %timerCommand2% Command Has Been Enabled,
echo    If You Close This Window Or Press CTRL+C The %timerCommand2% Will Be Disabled
echo                             %timerLeft% Seconds Until %timercommand2%
timeout 1 >nul /nobreak
set /a TimerLeft=%Timerleft%-1 >nul
if %TimerLeft%==0 goto InitiateTimer
if %TimerLeft%==-1 goto InitiateTimer
if %TimerLeft%==-2 goto InitiateTimer
if %TimerLeft%==10 color c4
goto TimerLoop
:InitiateTimer
shutdown %timerCommand% /f
goto end

:CommandSwitches
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Info: Command Switch Entered^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
%SetTheme%
:: DONT FORGET TO ADD TO :commandSwitchViewAll
set "CheckParam=if /i "%1" =="
%CheckParam% "/help" goto commandSwitchHelp
%CheckParam% "help" goto commandSwitchHelp
%CheckParam% "/?" goto commandSwitchHelp
%CheckParam% "?" goto commandSwitchHelp
%CheckParam% "/signin" goto signin
%CheckParam% "/login" goto signin
%CheckParam% "/about" goto about
%CheckParam% "/other" goto other
%CheckParam% "/APO" goto APO
%CheckParam% "/Power" goto APO
%CheckParam% "/SD-Network" goto hotspothome
%CheckParam% "/Hotspot" goto hotspothome
%CheckParam% "/SD-Hotspot" goto hotspothome
%CheckParam% "/commands" goto commands
%CheckParam% "/SD-Commands" goto commands
%CheckParam% "/cmd" goto commands
%CheckParam% "/SD-SecurChecker" goto SDSecurChecker
%CheckParam% "/SD-SecureChecker" goto SDSecurChecker
%CheckParam% "/sdsecurechecker" goto SDSecureChecker
%CheckParam% "/sdsecurchecker" goto SDSecureChecker
%CheckParam% "/quit" goto end
%CheckParam% "/end" goto end
%CheckParam% "/exit" goto end
:: DONT FORGET TO ADD TO :commandSwitchViewAll
goto CommandSwitchError
:CommandSwitchError
call :setTime&echo ^|^|Log^|^|  ^|Error: Command Switch '%1'^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Command Switch Error - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛             Command Switch Error                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo          The Switch You Used (ﬂ%1ﬂ) Is Not A Valid SD-Security Switch
echo        Would You Like To View All The Switches Available For SD-Security?
echo €1€  Yes
echo €2€  No (Return Home)
%set /p% viewCommandHelp="€˛ "
if "%viewcommandhelp%" == "1" goto commandSwitchViewAll
goto :EOF
:commandSwitchHelp
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Info: Command Switch Help^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Command Switch Help - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛              Command Switch Help                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo     As Well As The Full User Interface SD-Security Has Command Line Switches
echo             To Use A Switch:
echo.
echo METHOD 1: Create A Shortcut
echo  1. Right Click In Explorer
echo  2. New ^> Shortcut
echo  3. Type In The Location Of SD-Security (Hold Shift, Right Click On The
echo     SD-Security %sds_extension% Then Click On ﬂCopy As Pathﬂ) Then With A Switch On The End
echo.
echo METHOD 2: Command Line
echo  1. Hold Shift And Right Click In The Folder Of SD-Security
echo  2. Select ﬂOpen Command Window Hereﬂ
echo  3. A Command Window Should Appear, Type ﬂSD-Securityﬂ And Then A Space
echo     Followed With A Switch
echo  4. Press Enter (It Should Boot Into SD-Security)
echo.
echo                  Press Any Key To View All The Available Switches
pause >nul
goto commandSwitchViewAll
:commandSwitchViewAll
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Info: Command Switches^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Command Switches - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Command Switches                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                      List Of All Available Command Switches:
echo €  /help             ^| Displays SD-Security's Command Switch Help
echo €  /safemode         ^| Boots SD-Security Into SafeMode
echo €  /hotspot          ^| Displays The Hotspot Screen
echo €  /signin           ^| Displays The Sign In Screen
echo €  /about            ^| Displays The About Screen
echo €  /other            ^| Displays The Other Screen
echo €  /apo              ^| Displays The Advanced Power Options Screen
echo €  /commands         ^| Displays The Commands Screen
echo €  /SD-SecurChecker  ^| Displays The SD-SecurChecker Screen
echo €  /exit             ^| Exits SD-Security (This Works Well As A Logger)
echo.
echo                      Press Any Key To See The Alternative Words
pause >nul
cls
title Command Switches - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Command Switches                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                      List Of All Available Command Switches:
echo €  /?                ^| Displays SD-Security's Command Switch Help
echo €  ?                 ^| Displays SD-Security's Command Switch Help
echo €  help              ^| Displays SD-Security's Command Switch Help
echo €  /login            ^| Displays The Sign In Screen
echo €  /power            ^| Displays The Advanced Power Options Screen
echo €  /SD-Network       ^| Displays The Hotspot Screen
echo €  /SD-Hotspot       ^| Displays The Hotspot Screen
echo €  /SD-Commands      ^| Displays The Commands Screen
echo €  /cmd              ^| Displays The Commands Screen
echo €  /SD-SecureChecker ^| Displays The SD-SecurChecker Screen
echo €  /SDSecureChecker  ^| Displays The SD-SecurChecker Screen
echo €  /SDSecurChecker   ^| Displays The SD-SecurChecker Screen
echo €  /quit             ^| Exits SD-Security (This Works Well As A Logger)
echo €  /end              ^| Exits SD-Security (This Works Well As A Logger)
echo                                 Press Any Key To Go Home
pause >nul
goto :EOF
:statistics
call :setTime
set /a times_opened2=%times_opened%+1 >nul
echo last_computer=%computername% > "SDS_Files\SD-Statistics.ini"
echo last_username=%username% >> "SDS_Files\SD-Statistics.ini"
echo last_time=%twelve% >> "SDS_Files\SD-Statistics.ini"
echo last_time_twenty_four=%twentyfour% >> "SDS_Files\SD-Statistics.ini"
echo last_date=%date2% >> "SDS_Files\SD-Statistics.ini"
echo last_date_full=%fulldate% >> "SDS_Files\SD-Statistics.ini"
echo last_opened=%day% %daydig%%daySuffix% %month% %year%>> "SDS_Files\SD-Statistics.ini"
echo times_opened=%times_opened2% >> "SDS_Files\SD-Statistics.ini"
goto :EOF
:: Time API
:setTime
for /f "tokens=1-2 delims=:." %%a in ('time /t') do set hourTwentyFour=%%a&set Minutes=%%b
set TwentyFour=%hourTwentyFour%:%minutes%
if "%hourTwentyFour%" == "00" set hour=12&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "01" set hour=1&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "02" set hour=2&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "03" set hour=3&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "04" set hour=4&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "05" set hour=5&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "06" set hour=6&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "07" set hour=7&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "08" set hour=8&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "09" set hour=9&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "10" set hour=10&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "11" set hour=11&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "12" set hour=12&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "13" set hour=1&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "14" set hour=2&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "15" set hour=3&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "16" set hour=4&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "17" set hour=5&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "18" set hour=6&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "19" set hour=7&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "20" set hour=8&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "21" set hour=9&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "22" set hour=10&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%" == "23" set hour=11&set hourtype=PM&goto SetTwelveHourTime
:SetTwelveHourTime
set Twelve=%hour%:%minutes%%hourtype%
:SetDays
set abbOfDay=%date:~0,3%
for /f "tokens=2-3 delims=/ " %%a in ('date /t') do set daydig=%%a&set MonthDig=%%b&set year=%currentYear:~0,2%%date:~-2%
if "%daydig:~0,1%" == "0" set daydig=%daydig:~1,1%
if "%MonthDig:~0,1%" == "0" set MonthDig=%MonthDig:~1,1%
if "%daydig%" == "1" set daySuffix=st&goto SetDayNames
if "%daydig%" == "2" set daySuffix=nd&goto SetDayNames
if "%daydig%" == "3" set daySuffix=rd&goto SetDayNames
set daySuffix=th
:SetDayNames
if "%abbOfDay%" == "Mon" set day=Monday&goto SetMonthNames
if "%abbOfDay%" == "Tue" set day=Tuesday&goto SetMonthNames
if "%abbOfDay%" == "Wed" set day=Wednesday&goto SetMonthNames
if "%abbOfDay%" == "Thu" set day=Thursday&goto SetMonthNames
if "%abbOfDay%" == "Fri" set day=Friday&goto SetMonthNames
if "%abbOfDay%" == "Sat" set day=Saturday&goto SetMonthNames
if "%abbOfDay%" == "Sun" set day=Sunday&goto SetMonthNames
:SetMonthNames
if "%MonthDig%" == "1" set month=January&goto SetTimeFinished
if "%MonthDig%" == "2" set month=February&goto SetTimeFinished
if "%MonthDig%" == "3" set month=March&goto SetTimeFinished
if "%MonthDig%" == "4" set month=April&goto SetTimeFinished
if "%MonthDig%" == "5" set month=May&goto SetTimeFinished
if "%MonthDig%" == "6" set month=June&goto SetTimeFinished
if "%MonthDig%" == "7" set month=July&goto SetTimeFinished
if "%MonthDig%" == "8" set month=August&goto SetTimeFinished
if "%MonthDig%" == "9" set month=September&goto SetTimeFinished
if "%MonthDig%" == "10" set month=October&goto SetTimeFinished
if "%MonthDig%" == "11" set month=November&goto SetTimeFinished
if "%MonthDig%" == "12" set month=December&goto SetTimeFinished
:SetTimeFinished
set fulldate=%date:~4%
set date2=%daydig%/%monthDig%/%year%
goto :EOF
:showStatistics
cls
title Statistics - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                   Statistics                     %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo     Every Time SD-Security Is Opened It Logs Some Information Of The User,
echo                      This Is The Information It Logged Last Time:
echo.
echo €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo € Opened On          €˛ %last_time% %last_opened%
echo € Opened On          €˛ %last_date%
echo € Last Computer      €˛ %last_computer%
echo € Last Username      €˛ %last_username%
echo € Total Times Opened €˛ %times_opened%
echo €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                                  Press Any Key To Go Home
pause >nul
goto home
:getTheme
:: This Is The Theme Code For SD-Security
if "%theme%" == "" set SetTheme=color F0&goto :EOF
if %theme%==blue set themeColor=91
if %theme%==dark_blue set themeColor=19
if %theme%==black set themeColor=0f
if %theme%==grey set themeColor=78
if %theme%==dark_grey set themeColor=87
if %theme%==green set themeColor=a2
if %theme%==dark_green set themeColor=2a
if %theme%==aqua set themeColor=b3
if %theme%==dark_aqua set themeColor=3b
if %theme%==red set themeColor=c4
if %theme%==dark_red set themeColor=4c
if %theme%==purple set themeColor=d5
if %theme%==dark_purple set themeColor=5d
if %theme%==yellow set themeColor=e6
if %theme%==dark_yellow set themeColor=6e
if %theme%==white set themeColor=f7
if %theme%==black_white set themeColor=0f
set SetTheme=color %themecolor%
goto :EOF
:checkUpdateSettings
set numberOfErrors=0
if "%theme%" == "" set theme1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%dev_mode%" == "" set dev_mode1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%used_before%" == "" set used_before1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%trial_mode%" == "" set trial_mode1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%bug_101_vuln%" == "" set bug_101_vuln1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%hide_bug_101%" == "" set hide_bug_1011=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%security_breach_key%" == "" set security_breach_key1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%Hide_password%" == "" set hide_password1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if not "%numberOfErrors%" == "0" goto SettingsFileError2
goto :EOF

:SettingsFileError2
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Error: Settings File Error^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
color f0
cls
title Settings File Error - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛              Settings File Error                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
call :color fc "         SD-Security's Settings File (SD-Settings.ini) Is Out Of Date!"
echo.
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo.
echo     There Is A Error With The Settings File For SD-Security SD-Settings.ini
echo.
echo                This Could Be Because You Updated SD-Security,
echo                It's Been Edited Incorrectly In A Text Editor,
echo         Or It's Been Edited To Try To Hack SD-Security's Interface.
echo.
echo €€€ To Fix This, You Would Have To Reset Them, If You Want To Use SD-Security
echo €1€  Reset Them (Recommended)
echo €2€  Cancel ^& Exit SD-Security
%set /p% resetSettings="€˛ "
if "%resetsettings%" == "1" goto ResetSDSecurity
goto end
:SettingsFileError
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Error: Settings File Error (Access Denied)^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
color f0
cls
title Settings File Error - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛              Settings File Error                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
call :color fc "           You Don't Have Permission To Access SD-Security's Settings!"
echo.
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo.
echo     There Is A Error With The Settings File For SD-Security SD-Settings.ini
echo.
echo €€€ To Fix This, You Would Have To Reset The Settings, If You Want To Use SDS
echo €1€  Reset Them
echo €2€  Cancel ^& Exit SD-Security (Recommended)
%set /p% resetSettings="€˛ "
if "%resetsettings%" == "1" goto ResetSDSecurity
goto end
:checkOSInfo
for /f "skip=1 delims=" %%a in ('vol') do set serial=%%a
set serial=%serial:~-9,9%
for /f "tokens=4-5 delims=. " %%i in ('ver') do set version=%%i.%%j
if "%version%"=="10.0" set winVersion=Windows 10&goto :EOF
if "%version%"=="6.4" set winVersion=Windows 10 Preview&goto :EOF
if "%version%"=="6.3" set winVersion=Windows 8&goto :EOF
if "%version%"=="6.1" set winVersion=Windows 7&goto :EOF
if "%version%"=="6.0" set winVersion=Windows Vista&goto :EOF
if "%version%"=="5.2" set winVersion=Windows Server 2003&goto :EOF
if "%version%"=="5.1" set winVersion=Windows XP&goto :EOF
if "%version%"=="5.00" set winVersion=Windows 2000&goto :EOF
if "%version%"=="4.90" set winVersion=Windows ME&goto :EOF
if "%version%"=="4.10" set winVersion=Windows 98&goto :EOF
if "%version%"=="4.00" set winVersion=Windows 95&goto :EOF
set winVersion=Windows Version %version%
goto :EOF
:wait
set waitNum=0
set waitFor=%1
if "%waitfor%" == "0" set waitfor=1
:waitLoop
set /a waitnum=%waitnum% +1>nul
if %waitnum%==%waitFor% goto :EOF
goto waitLoop
:installInfo
%SetTheme%
call :setTime&echo ^|^|Log^|^|  ^|Info: Installation Information^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛             Installation Information             %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                                 General Information
echo.
echo Operating System    : %winVersion%
echo Drive Serial        : %serial%
echo Current PC Name     : %computername%
echo Current Username    : %username%
echo Current Date ^& Time : %twelve% %day% %daydig%%daySuffix% %month% %year%
echo.
echo                               SD-Security Information
echo.
echo Times Opened        : %times_opened%
echo SD-Security Version : SD-Security V.%sds_version%
echo SDS Build Type      : %Version_Type%
echo Installation Folder : %cd%
echo.
echo €€€  Would You Like To Save This To A File?
echo €1€  Yes
echo €2€  No
%set /p% saveTofile="€˛ "
if "%savetofile%" == "1" goto SaveInfoToFile
goto home
:SaveInfoToFile
echo General Information > "Installation Information.txt"
echo. >> "Installation Information.txt"
echo Operating System : %winVersion% >> "Installation Information.txt"
echo Drive Serial : %serial% >> "Installation Information.txt"
echo Current PC Name : %computername% >> "Installation Information.txt"
echo Current Username : %username% >> "Installation Information.txt"
call:settime&echo ^|^|Log^|^|  ^|Info: Saved Installation Information^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
echo Current Date ^& Time : %twelve% %day% %daydig%%daySuffix% %month% %year% >> "Installation Information.txt"
echo. >> "Installation Information.txt"
echo SD-Security Information >> "Installation Information.txt"
echo. >> "Installation Information.txt"
echo Times Opened : %times_opened% >> "Installation Information.txt"
echo SD-Security Version : SD-Security V.%sds_version% >> "Installation Information.txt"
echo SDS Build Type : %Version_Type% >> "Installation Information.txt"
echo Installation Folder : %cd% >> "Installation Information.txt"
goto home
:updated
%SetTheme%
call :SetWindow
if "%Old_SDS_Version%" GTR "%SDS_Version%" goto Downgraded
call :settime&echo ^|^|Log^|^|  ^|Info: SD-Security Updated^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Update Successful - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Update Successful                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo        S D - S e c u r i t y    S u c c e s s f u l l y    U p d a t e d
echo        -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -
echo.
echo         SD-Security Has Successfully Been Updated From V%Old_SDS_Version% To V%SDS_Version%
echo   This Update Could Have Security Errors (You Updated From %Old_Version_Type% To %Version_Type%)
echo       Its Best To Stick To The Stable Versions (This Is A %Version_Type% Version)
echo               For Most Of The Latest Features, Use BETA Versions
echo       BUT If You Want ALL The New Features You Should Use A DEV Version,
echo      DEV Versions Are Often Highly Unstable And Not Really Meant For Use
echo.
echo       If You Find Any Bugs In This Update, Email %HelpEmail%
echo      With A Brief Description Of The Bug And We Will Work Quickly To Fix
echo                                     The Bug(s)
echo.
echo                              Press Any Key To Return
call :Notify "The Update For SD-Security Has Successfully Been Installed" "Update Successful"
pause >nul
goto :EOF
:Downgraded
call :settime&echo ^|^|Log^|^|  ^|Info: SD-Security Downgraded^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Downgrade Successful - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Update Successful                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo      S D - S e c u r i t y    S u c c e s s f u l l y    D o w n g r a d e d
echo      -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  -
echo.
echo      SD-Security Has Successfully Been Downgraded From v.%Old_SDS_Version% To v.%SDS_Version%
echo    Because You Downgraded, There Are Going To Be Less Features And Some Bugs
echo   Security Could Be Comprimised In This Version (See The SDS Version History)
echo.
echo     Because This Is A Old Version There Could Be A Few Bugs That Are Fixed
echo  In Later Versions, So Please Don't Email Us About Them Unless They Are In The
echo                            Latest SD-Security Version
echo.
echo                              Press Any Key To Return
pause >nul
goto :EOF
:updateUpdaterInfo
echo Old_SDS_Version=%SDS_Version%> "SDS_Files\Version_No.ini"
echo Old_Version_Type=%Version_Type%>> "SDS_Files\Version_No.ini"
goto :EOF
:SetWindow
mode con: cols=80 lines=27
goto :EOF
:Color
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd
goto :EOF
:GUI
set GUIinput=
set SdGuiText=%~1
if "%SdGuiText%" == "" set SdGuiText=Please Enter The Password:
set SdGuiTitle=%~2
if "%SdGuiTitle%" == "" set SdGuiTitle=Enter Password - SD-Security©
echo Wscript.echo inputbox(WScript.Arguments(0),WScript.Arguments(1)) >"%temp%\SD-GUI.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\SD-GUI.vbs" "%SdGuiText%" "%SdGuiTitle%"') do set GUIinput=%%a
exit /b
:NoPermissions
call :setWindow
cls
color f0
title Error: No Permissions - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 No Permissions                   %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
call :color fc "      SD-Security Has No Permissions To Write To The SDS_Files Folder!"
echo.
echo ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛
echo.
echo    SD-Security Can't Write To The SDS_Files Folder Because Of The Lack Of
echo    Permissions And SD-Security Has To Be Able To Write+Read To This Folder
echo  To Log Information About SD-Security's Use And To Write To The Statistics File
echo  You Can Continue To Use SD-Security If You Want It In Read-Only Mode But You
echo          Will Be Limited In What You Can Do And SDS Could Crash!
echo.
echo   To Fix This Try Launching SD-Security With Admin Permissions, If It Doesn't
echo      Work You Should Try Editing The Permissions Of The SDS_Files Folder
echo     SD-SECURITY IS NOT ACCOUNTABLE IF YOU EDIT THE PERMISSIONS INCORRECTLY
echo.
echo €1€  Continue (If You Belive This Is An Error)
echo €2€  Launch As Administrator
echo €3€  Change Permissions (Requires Admin Permissions)
echo €4€  Exit SD-Security (Recommended)
%set /p% NoPermissions="€˛ "
if "%NoPermissions%" == "1" call :loadingScreen&goto backFromNoPermissions
if "%NoPermissions%" == "2" goto startAdmin
if "%NoPermissions%" == "3" goto ChangePerSDSFILES
goto end
:ChangePerSDSFILES
cls
title Change Permissions - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛              Change Permissions                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo    When You Press Any Key The SDS_Files Folder Will Open, Right Click In It
echo   Then Select 'Properties'. You Can Now Change The Permissions By Using The
echo                                    Security Tab
echo.
echo                    Press Any Key To Open The SDS_Files Folder
pause >nul
start SDS_Files
goto home
:StartAdmin
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto home ) else ( goto getAdmin )
:getAdmin
title Requesting Admin Permissions - SD-Security©
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Admin Permissions                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo.
echo             €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
echo             € A d m i n   P e r m i s s i o n s   R e q u i r e d €
echo             €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.
echo,
echo       Admin Permissions Are Required To Perform The Action You Requested.
echo       When The User Account Control (UAC) Window Appears, Click On ﬂYesﬂ.
echo                   (You Might Have To Enter Your Password In)
echo.
echo                                Launching UAC...
timeout 2 >nul
set "batchPath=%cd%\%sds_file%"
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\SDSgetAdmin.vbs"
echo UAC.ShellExecute "%batchPath%", "ELEV","", "runas", 1 >> "%temp%\SDSgetAdmin.vbs"
"%temp%\SDSgetAdmin.vbs"
goto :EOF
:::: Randomo API
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
:::: RealTimeEncryption API
:RealTimeEncrypt
set a=%%%%z%%%%&set b=%%%%y%%%%
set c=%%%%x%%%%&set d=%%%%w%%%%
set e=%%%%v%%%%&set f=%%%%u%%%%
set g=%%%%t%%%%&set h=%%%%s%%%%
set i=%%%%r%%%%&set j=%%%%q%%%%
set k=%%%%p%%%%&set l=%%%%o%%%%
set m=%%%%n%%%%&set n=%%%%m%%%%
set o=%%%%l%%%%&set p=%%%%k%%%%
set q=%%%%j%%%%&set r=%%%%i%%%%
set s=%%%%h%%%%&set t=%%%%g%%%%
set u=%%%%f%%%%&set v=%%%%e%%%%
set w=%%%%d%%%%&set x=%%%%c%%%%
set y=%%%%b%%%%&set z=%%%%a%%%%
echo %~1 > "%temp%\SD-RealEncrypt.tmp"
::SD-Security Encryption System
for /f "tokens=*" %%l in ('findstr /r /n "^" "%temp%\SD-RealEncrypt.tmp"') do @(
set "line=%%~l"&set "line=!line:*:=!"
call :strlen
if !line_len!==0 (
echo() else (
set outline_e=
for /l %%i in (0,1,!line_len!) do (
set "char=!line:~%%i,1!"
if "!char!"==" " set "outline_e=!outline_e! "
echo !char!|findstr.exe /r "[A-Za-z]" >nul
if errorlevel 1 set "outline_e=!outline_e!!char!"&set RealEncrypt=!outline_e!&del %temp%\SD-RealEncrypt.tmp&goto :EOF
set "char_e="
call :enc "!char!" "char_e"
set "outline_e=!outline_e!!char_e!"
set RealEncrypt=!outline_e!))
del %temp%\SD-RealEncrypt.tmp
set z=a&set m=n
set y=b&set l=o
set x=c&set k=p
set w=d&set j=q
set v=e&set i=r
set u=f&set h=s
set t=g&set g=t
set s=h&set f=u
set r=i&set e=v
set q=j&set d=w
set p=k&set c=x
set o=l&set b=y
set n=m&set a=z
goto :EOF
:enc
call set "%~2=!%~1!"&goto :EOF
:strlen
(setlocal EnableDelayedExpansion&set "s=!line!#"&set "len=0"
for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (if "!s:~%%P,1!" NEQ "" (set /a "len+=%%P"&set "s=!s:~%%P!")))
endlocal&set "line_len=%len%"&goto :EOF
:ReportCrash
@echo.
@echo ^^                   SD-Security Crashed! Due To Above                          ^^
@call :Notify "SD-Security Has Just Crashed, Please Report This Crash To SD-Security" "SD-Security Crashed!"
@pause >nul
color F0
cls
call :SetWindow
title Crash Handler - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Crash Handler
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                         €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
call :color FF "''''''''''''''''''''''''"&call :color 11 "a"&call :color FC " SD-Security Has Just Crashed!"&call :color ff "b"&call :color 11 "a"&echo.
echo                         €‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
echo.
echo     SD-Security Has Just Crashed, This Could Be Because You Entered Special
echo         Characters Into SD-Security, Such As: "& | / \ @ # " ^~ ^< ^> ^( ^)"
echo     Or Because Of A Bug In The Software. If You Believe That It Was A Bug,
echo       Then You Should Report The Bug To The Developers So We Can Fix It.
echo.
echo                Would You Like To Send A Email To The Developers?
echo.
if "%FakeCrash%" == "yes" goto ReportCrashFake
echo €1€  Yes (Internet Connection ^& Email Account Required)
echo €2€  No
%set /p% sendCrashEmail="€˛ "
if "%sendCrashEmail%" == "1" goto sendEmail
goto quickend
:ReportCrashFake
@call :color 44 "'"&@call :color 88 "'"&@call :color 44 "'"&@echo   Yes (Internet Connection ^& Email Account Required) -- Disabled
@echo €2€  No
@%set /p% sendCrashEmail="€˛ "
@goto quickend
:sendEmail
start mailto:%HelpEmail%?Subject=SD-Security%%20Crash%%20Report^&Body=Where%%20Was%%20SD-Security%%20Installed%%3F%%0AWhat%%20Version%%20Of%%20Windows%%20Are%%20You%%20Running%%3F%%0AWhich%%20Version%%20Of%%20SD-Security%%20Are%%20You%%20Running%%3F%%20%SDS_Version%%%0A-------------------------------------%%0ATo%%20SD-Security%%2C%%0AI%%20would%%20like%%20to%%20report%%20a%%20bug%%2C%%20here%%20is%%20the%%20details%%20of%%20what%%20happened%%3A%%0A
goto quickend
:CrashHelper
set restart=0
set switch=%1
if "%1" == "/?" call :CommandSwitchHelp&call cmd /t:f0 /c %0
call cmd /t:f0 /c %0 %switch%
@if errorlevel 999 @exit
@if errorlevel 666 @set FakeCrash=yes
@goto ReportCrash
:DevOptions
call :setTime&echo ^|^|Log^|^|  ^|Info: Developer Options^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Developer Options - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Developer Options                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo €1€  Crash SD-Security
echo €2€  Reboot To Safemode
echo €3€  Back
%set /p% DevOptions="€˛ "
if "%DevOptions%" == "1" exit /b 666
if "%DevOptions%" == "2" goto Safe_Mode
goto other
:: SD-Updater
:CheckForUpdates
cls
title Checking For Updates - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Checking For Updates               %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                                   Checking For Updates...
for /F "eol=# delims=" %%A in (SDS_FILES\SD-Updater.ini) do set %%A >nul 2>&1
if exist "SDS_Files\LatestVersion.ini" del SDS_Files\LatestVersion.ini >nul 2>&1
powershell -nologo Invoke-WebRequest -OutFile "SDS_Files\LatestVersion.ini" "%Latest_Version_Log%" >nul 1>&2
if not "%errorlevel%" == "0" if "%errorlevel%" == "9009" goto InstallPowershell||goto UpdaterError
if not exist "SDS_Files\LatestVersion.ini" goto UpdaterError
for /F "eol=# delims=" %%A in (SDS_FILES\LatestVersion.ini) do set %%A
if not %SDS_Version%==%OnlineVersion% goto UpdateAvailable
:NoUpdates
cls
title No Updates Available - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               No Updates Available               %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo             There Are Currently No Updates Available For SD-Security
echo                            Press Any Key To Go Home
pause >nul
goto home
:UpdaterError
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Updater Error^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
echo.
echo ^^                      ERROR! See Above For More Details                      ^^
timeout 4 >nul
cls
title SD-Updater Error - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Updater Error                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                 There Was An Error While Checking For Updates,
echo              Please Check Your Internet Connection And Try Again
echo.
echo     If You Keep Getting This Error, Check That Your Firewall Isn't Blocking
echo       Windows Powershell From Accessing The Internet. If You Still Cannot
echo     Update SD-Security Then You Should Just Manually Update SD-Security By
echo            Downloading The Latest SD-Security EXE From The Internet
echo.
echo €1€  Retry
echo €2€  Return Home
%set /p% UpdaterError="€˛ "
if "%UpdaterError%" == "1" goto :CheckForUpdates
goto home
:UpdaterError2
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Updater Error^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
timeout 3 /nobreak >nul
cls
title SD-Updater Error - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 SD-Updater Error                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                There Was An Error While Downloading The Update,
echo              Please Check Your Internet Connection And Try Again
echo.
echo     If You Keep Getting This Error, Check That Your Firewall Isn't Blocking
echo       Windows Powershell From Accessing The Internet. If You Still Cannot
echo     Update SD-Security Then You Should Just Manually Update SD-Security By
echo            Downloading The Latest SD-Security EXE From The Internet
echo.
echo €1€  Retry
echo €2€  Return Home
%set /p% UpdaterError="€˛ "
if "%UpdaterError%" == "1" goto :DownloadUpdate
goto home
:UpdateAvailable
call :setTime&echo ^|^|Log^|^|  ^|Update Available: %OnlineVersion%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Update Available - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 Update Available                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo      An Update To SD-Security Is Available %OnlineVersion%, This Update May Include
echo       New Features, Bug Fixes, Security Patches, Speed Increases And More
echo.
echo                   Would You Like To Download This Update Now?
echo €1€  Yes
echo €2€  No
call :Notify "An Update For SD-Security Has Published, V.%onlineVersion%" "Update SD-Security"
%set /p% UpdateSDS="€˛ "
if "%UpdateSDS%" == "1" goto DownloadUpdate
goto Home
:DownloadUpdate
call :setTime&echo ^|^|Log^|^|  ^|Update Downloading...^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Update Downloading... - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Update Downloading                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                              Downloading Update...
echo.
powershell -nologo Invoke-WebRequest -OutFile "SD-Security2.exe" "%Latest_Version_EXE%" >nul 1>&2
if not "%errorlevel%" == "0" goto UpdaterError2
if not exist "SD-Security2.exe" goto UpdaterError2
echo                                Downloaded Update
timeout 3 /nobreak >nul
:InstallUpdateNow
call :setTime&echo ^|^|Log^|^|  ^|Update Downloaded^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Update Downloaded - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Update Downloaded                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo   The Update For SD-Security Has Been Downloaded, It Is Recommended That You
echo               Check The Download Isn't Corrupt Before Installing
echo.
echo €1€  Check The Download
echo €2€  Install Update (Without Checking)
echo €3€  Cancel
%set /p% InstallSDS="€˛ "
if "%InstallSDS%" == "1" call start SD-Security2.exe&goto UpdateCheckComplete
if "%InstallSDS%" == "2" goto StartInstallingUpdate
goto home
:UpdateCheckComplete
cls
title Update Downloaded - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Update Downloaded                  %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo      If SD-Security Just Opened Then You Can Install The Update OTHERWISE
echo                            The Download Could Be Corrupt
echo.
echo €1€  Install Update
echo €2€  Cancel
%set /p% InstallSDS2="€˛ "
if "%InstallSDS2%" == "1" goto StartInstallingUpdate
goto home
:StartInstallingUpdate
call start "Updating SD-Security" cmd /c "color f0&title SD-Security EXE Updater&mode con: cols=90 lines=25&echo -----------------------------===============================-----------------------------&echo -------------------------------= SD-Security EXE Updater =-------------------------------&echo -----------------------------===============================-----------------------------&echo -----------------------------===============================-----------------------------&timeout 2 >nul&echo                     Renaming Old SD-Security To 'SD-Security_old.exe'&ren SD-Security.exe "SD-Security_old.exe"&echo                       Renaming New SD-Security To 'SD-Security.exe'&ren SD-Security2.exe "SD-Security.exe"&echo                               Finished! SD-Security Updated&echo.&echo                    Press Any Key To Exit The Updater And Start SD-Security&pause >nul&call start SD-Security.exe&exit /B 999"
exit /b 999
:InstallPowershell
cls
title Install Powershell - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Install Powershell                 %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo     In Order For This Feature To Work, The Latest Version Of Powershell Has
echo  To Be Installed On This PC! This Is Required To Download Updates From The Web
echo.
echo                               Press Any Key To Go Home
pause >nul
goto home
:Notify
:: Notify API, This API Uses Powershell To Show A Popup In The Notification Tray That Can Display Custom Text
:: Usage: CALL :Notify [Message] [Message Title] [Tray Icon File]
set one=%~1
set two=%~2
set three=%~3
if "%one%" == "" set one=Switch To SD-Security
if "%two%" == "" set two=SD-Security
if "%three%" == "" set three=Favicon.ico
echo [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") > "%temp%\Notify_API_SDS.ps1"
echo ^$Notify = New-Object System.Windows.Forms.NotifyIcon >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.Icon = "%three%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipIcon = "None" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipText = "%one%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipTitle = "%two%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.Visible = ^$True >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.ShowBalloonTip(10000) >> "%temp%\Notify_API_SDS.ps1"
call start "Notify API" /min cmd /c "powershell -executionpolicy bypass -File "%temp%\Notify_API_SDS.ps1""
goto :EOF
:GetIp
if "%1" == "" (set GetIP=%computername%) else (set GetIP=%~1)
for /f "tokens=1,2 delims=[]" %%a in ('ping -w 1 -n 1 -4 "%GetIP%"^|findstr "Pinging"') do set IP=%%b
goto :EOF
:GetIPGUI
call :setTime&echo ^|^|Log^|^|  ^|Info: Get IP^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
:GetIPGUI2
cls
title Home - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                   Get IP                         %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo          Enter The Name Of A PC (On This Network) To Get The IP Address
echo.
%set /p% getIpFromThis="€˛ "
call :GetIP "%getIpFromThis%"
if "%IP%" == "" goto GetIPGUIError
echo.
echo The IP Address For %getIpFromThis% Is %IP%
goto GetIPTryAgain
:GetIPGUIError
echo                 Cannot Connect To PC! Check The Spelling And
echo         Check That The PC Is Connected To The Network And Try Again
:GetIPTryAgain
echo.
echo                         Would You Like To Try Again?
echo €1€  Yes
echo €2€  No
%set /p% TryAgain="€˛ "
if "%TryAgain%" == "1" goto GetIPGUI2
goto home
:RestoreSession
if not exist "SDS_FILES\Sessions\Disable*" goto StartRestoreSession
call :setwindow
set SessionName=%SessionFile:~0,-12%
cls
title Restore Session - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                Restore Session                   Signed-Out
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                 Would You Like To Restore A Previous Session?
echo.
echo €1€  Yes
echo €2€  No
echo €3€  No + Delete All Sessions
%set /p% RestoreSession="€˛ "
if "%RestoreSession%" == "1" goto StartRestoreSession
if "%RestoreSession%" == "3" goto DeleteRestoreSession
goto noRestore
:DeleteRestoreSession
cls
title Delete Sessions - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 Delete Sessions                  Signed-Out
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo              Are You Sure You Want To Delete ALL Previous Sessions?
echo.
echo €1€  Yes
echo €2€  No
%set /p% DelRestoreSession="€˛ "
if "%DelRestoreSession%" == "1" del SDS_Files\Sessions\*.SDS_Session
goto noRestore
:StartRestoreSession
for /F "eol=# delims=" %%A in (SDS_Files\Sessions\%sessionFile%) do set %%A>nul
del SDS_Files\Sessions\%sessionFile%>nul 2>&1
goto SetPasswords
:BackupSession
set "password="
set "password2="
set "pass="
set "Security_Breach_Key="
if not exist "SDS_Files\Sessions" md SDS_Files\Sessions
set numberForSession=1
:checkForSessionFile
if exist "SDS_Files\Sessions\Session_%numberForSession%.SDS_Session" set /a numberForSession=%numberForSession%+1 >nul&goto checkForSessionFile
set /a SessionBackupDate=%dayDig%+3>nul
set> "SDS_Files\Sessions\Session_%numberForSession%.SDS_Session"
color f1
goto :end2
:: File Encryption API
:EncryptFile
setlocal
set encrypt=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#-/\ .0123456789
set decrypt=dbhlceaitjkzqromsyvnfwxupg/YERT-U4LKJH!OG DSWAXP1CZVN\BQMI95F#6708.32@
set fileToEncrypt=%~1
set OutputFile=%~2
if "%OutputFile%" == "" set OutputFile=%fileToEncrypt%
set encrypt2=%encrypt%
set decrypt2=%decrypt%
(for /f "delims=" %%a in (%fileToEncrypt%) do (set line=%%a&call :EncryptionProccess))> "%OutputFile%"
goto :eof
:DecryptFile
setlocal
set encrypt=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#-/\ .0123456789
set decrypt=dbhlceaitjkzqromsyvnfwxupg/YERT-U4LKJH!OG DSWAXP1CZVN\BQMI95F#6708.32@
set fileToDecrypt=%~1
set OutputFile=%~2
if "%OutputFile%" == "" set OutputFile=%fileToDecrypt%
set encrypt2=%decrypt%
set decrypt2=%encrypt%
(for /f "delims=" %%a in (%fileToDecrypt%) do (set line=%%a&call :EncryptionProccess))> "%OutputFile%"
goto :eof
:EncryptionProccess
set "EncryptedFile="
:EncryptionProccess2
set $1=%encrypt2%
set $2=%decrypt2%
:EncryptionProccess3
if "%line:~0,1%"=="%$1:~0,1%" set EncryptedFile=%EncryptedFile%%$2:~0,1%&goto EncryptionProccess4
set $1=%$1:~1%
set $2=%$2:~1%
if defined $2 goto EncryptionProccess3
set EncryptedFile=%EncryptedFile%%line:~0,1%
:EncryptionProccess4
set line=%line:~1%
if defined line goto EncryptionProccess2
echo %EncryptedFile%
goto :eof
:OverwriteSettings
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f >nul 2>&1
echo # SD-Security Settings File, Do Not Edit Unless You Are A Developer> "SDS_FILES\SD-Settings.ini"
echo Dev_Mode=%Dev_Mode%>> "SDS_FILES\SD-Settings.ini"
echo Used_Before=%Used_Before%>> "SDS_FILES\SD-Settings.ini"
echo Trial_Mode=%Trial_Mode%>> "SDS_FILES\SD-Settings.ini"
echo Bug_101_Vuln=%Bug_101_Vuln%>> "SDS_FILES\SD-Settings.ini"
echo Hide_Bug_101=%Hide_Bug_101%>> "SDS_FILES\SD-Settings.ini"
echo Security_Breach_Key=%Security_Breach_Key%>> "SDS_FILES\SD-Settings.ini"
echo Hide_Password=%Hide_Password%>> "SDS_FILES\SD-Settings.ini"
echo Theme=%Theme%>> "SDS_FILES\SD-Settings.ini"
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:n >nul 2>&1
goto :EOF
:Switch
set "SwitchName=%~1"
set "SwitchType=%~2"
if "%SwitchType%" == "" (call :InvertSwitch&goto :EOF)
if /i "%switchType%" == "ON" (set "%SwitchName%=%ON%") else (if /i "%switchType%" == "OFF" set "%SwitchName%=%Off%")
goto :EOF
:InvertSwitch
for /f "tokens=1-2 delims==" %%a in ('set %SwitchName% 2^>nul') do set "SwitchStatus=%%b">nul 2>&1
if "%SwitchStatus%" == "%Off%" (set "%SwitchName%=%ON%") else (set "%SwitchName%=%OFF%")
goto :EOF
:changesettings
call :setTime&echo ^|^|Log^|^|  ^|Info: Home^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
set "On=˛"
set "Off= "
set "switch=call :Switch"
if /i %Dev_Mode%==yes (%switch% switch1 on) else (%switch% switch1 off)
if /i %Hide_Bug_101%==yes (%switch% switch2 on) else (%switch% switch2 off)
if /i %Hide_Password%==yes (%switch% switch3 on) else (%switch% switch3 off)
if /i exist "SDS_Files\Sessions\default*" (%switch% switch4 on) else (%switch% switch4 off)
if /i exist "SDS_Files\Sessions\disable*" (%switch% switch5 on) else (%switch% switch5 off)
:ChangeSettingsRefresh
cls
if not %status%==Signed-In goto other
title Change Settings - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛               Change Settings                    %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo                                 Yes/No Settings
echo €1%switch1%€  Launch SDS In Developer Mode
echo €2%switch2%€  Hide Bug 101 Error Screens
echo €3%switch3%€  Mask The Password Fields
echo €4%switch4%€  Always Auto-Save Session
echo €5%switch5%€  Disable Auto-Restore
echo.
echo                              User Defined Settings
echo €6€  Change Master Override Key
echo €7€  Change Application Colour Theme
echo.
echo €9€  Save Settings
echo €0€  Cancel (Discard Settings)
CHOICE /C 123456790 /N /M "€˛ "
IF ERRORLEVEL 9 %settheme%&goto :AdminOps
IF ERRORLEVEL 8 goto :SaveNewSdsSettings
IF ERRORLEVEL 7 call :ChangeTheme&goto :ChangeSettingsRefresh
IF ERRORLEVEL 6 call :ChangeBreachKey&goto :ChangeSettingsRefresh
IF ERRORLEVEL 5 %switch% switch5&goto :ChangeSettingsRefresh
IF ERRORLEVEL 4 %switch% switch4&goto :ChangeSettingsRefresh
IF ERRORLEVEL 3 %switch% switch3&goto :ChangeSettingsRefresh
IF ERRORLEVEL 2 %switch% switch2&goto :ChangeSettingsRefresh
IF ERRORLEVEL 1 %switch% switch1&goto :ChangeSettingsRefresh
goto :ChangeSettingsRefresh
:ChangeTheme
%settheme%
title Choose Theme - SD-Security©
set "echo=<nul set /p ="
cls
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                 Choose Theme                     %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
%echo% "€A€  "&call :Color 91 "Light Blue"&echo.
%echo% "€B€  "&call :Color 19 "Dark  Blue"&echo.
%echo% "€C€  "&call :Color a2 "Light Green"&echo.
%echo% "€D€  "&call :Color 2a "Dark  Green"&echo.
%echo% "€E€  "&call :Color b3 "Light Aqua"&echo.
%echo% "€F€  "&call :Color 3b "Dark  Aqua"&echo.
%echo% "€G€  "&call :Color c4 "Light Red"&echo.
%echo% "€H€  "&call :Color 4c "Dark  Red"&echo.
%echo% "€I€  "&call :Color d5 "Light Purple"&echo.
%echo% "€J€  "&call :Color 5d "Dark  Purple"&echo.
%echo% "€K€  "&call :Color e6 "Light Yellow"&echo.
%echo% "€L€  "&call :Color 6e "Dark  Yellow"&echo.
%echo% "€M€  "&call :Color 78 "Light Grey"&echo.
%echo% "€N€  "&call :Color 87 "Dark  Grey"&echo.
%echo% "€O€  "&call :Color 0f "Black"&echo.
%echo% "€P€  "&call :Color f7 "White"&echo.
%echo% "€Q€  "&call :Color 0f "Black And White"&echo.
CHOICE /C abcdefghijklmnopq /N /M "€˛ "
IF ERRORLEVEL 17 set "NewColorNum=0f"&set NewThemeColor=black_white&goto ConfirmNewTheme
IF ERRORLEVEL 16 set "NewColorNum=f7"&set NewThemeColor=white&goto ConfirmNewTheme
IF ERRORLEVEL 15 set "NewColorNum=0f"&set NewThemeColor=black&goto ConfirmNewTheme
IF ERRORLEVEL 14 set "NewColorNum=87"&set NewThemeColor=dark_grey&goto ConfirmNewTheme
IF ERRORLEVEL 13 set "NewColorNum=78"&set NewThemeColor=grey&goto ConfirmNewTheme
IF ERRORLEVEL 12 set "NewColorNum=6e"&set NewThemeColor=dark_yellow&goto ConfirmNewTheme
IF ERRORLEVEL 11 set "NewColorNum=e6"&set NewThemeColor=yellow&goto ConfirmNewTheme
IF ERRORLEVEL 10 set "NewColorNum=5d"&set NewThemeColor=dark_purple&goto ConfirmNewTheme
IF ERRORLEVEL 9 set "NewColorNum=d5"&set NewThemeColor=purple&goto ConfirmNewTheme
IF ERRORLEVEL 8 set "NewColorNum=4c"&set NewThemeColor=dark_red&goto ConfirmNewTheme
IF ERRORLEVEL 7 set "NewColorNum=c4"&set NewThemeColor=red&goto ConfirmNewTheme
IF ERRORLEVEL 6 set "NewColorNum=3b"&set NewThemeColor=dark_aqua&goto ConfirmNewTheme
IF ERRORLEVEL 5 set "NewColorNum=b3"&set NewThemeColor=aqua&goto ConfirmNewTheme
IF ERRORLEVEL 4 set "NewColorNum=2a"&set NewThemeColor=dark_green&goto ConfirmNewTheme
IF ERRORLEVEL 3 set "NewColorNum=a2"&set NewThemeColor=green&goto ConfirmNewTheme
IF ERRORLEVEL 2 set "NewColorNum=19"&set NewThemeColor=dark_blue&goto ConfirmNewTheme
IF ERRORLEVEL 1 set "NewColorNum=91"&set NewThemeColor=blue&goto ConfirmNewTheme
:ConfirmNewTheme
color %NewColorNum%
echo €1€  Confirm Theme
echo €2€  Choose Another Theme
CHOICE /C 12 /N /M "€˛ "
IF ERRORLEVEL 2 goto :ChangeTheme
IF ERRORLEVEL 1 goto :EOF
:ChangeBreachKey
%set /p% NewBreachKey="Enter A New Security Breach Key: "
if not "%NewBreachKey%" == "" goto :EOF
echo Please Enter A Security Breach Key!
pause >nul
goto :EOF
:SaveNewSdsSettings
if not %status%==Signed-In goto :other
echo                      Press Any Key To Save Settings
pause >nul
if "%switch1%" == "%on%" (set Dev_Mode=yes) else (set Dev_Mode=no)
if "%switch2%" == "%on%" (set Hide_Bug_101=yes) else (set Hide_Bug_101=no)
if "%switch3%" == "%on%" (set Hide_Password=yes) else (set Hide_Password=no)
if "%switch4%" == "%on%" (md SDS_Files\Sessions >nul 2>&1&echo SDS> "SDS_Files\Sessions\DefaultEnable.ini") else (del SDS_Files\Sessions\Default*>nul 2>&1)
if "%switch5%" == "%on%" (md SDS_Files\Sessions >nul 2>&1&echo SDS> "SDS_Files\Sessions\DisableAutoRestore.ini") else (del SDS_Files\Sessions\Disable*>nul 2>&1)
if not "%NewBreachKey%" == "" (set Security_Breach_Key=%NewBreachKey%)
if not "%newThemeColor%" == "" (set theme=%newThemeColor%&set "settheme=color %NewColorNum%")
call :OverwriteSettings
:Restart
cls
if not %status%==Signed-In goto other
title Restart SDS - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛                  Restart SDS                     %status%
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo    In Order To Apply The Selected Settings, You Need To Restart SD-Security.
echo.
echo €1€  Restart Now
echo €2€  Postpone
echo €3€  Exit
%set /p% RestartSDS="€˛ "
if "%RestartSDS%" == "1" goto :RestartSDS
if "%RestartSDS%" == "3" exit /b 999
goto home
:RestartSDS
endlocal
goto :StartOfScript
:AskString
set "StringName=%*"
set "StringName=%StringName:"=%"
set /p %StringName%
for /f "tokens=1" %%a in ('echo %StringName%') do set "StringName=%%a"&goto AskStringNext
:AskStringNext
(set %StringName% 2>nul|findstr /r /c:"[&|<>""]"&if not errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Enter Special Characters!&goto :AskString)) 1>nul
(set %StringName% 2>nul|findstr "Environment variable %StringName% not defined"&if errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Leave This Field Blank!&goto :AskString)) 1>nul
goto :EOF
:CheckString
set "StringName=%*"
(set %StringName% 2>nul|findstr /r /c:"[&|<>""]"&if not errorlevel 1 (set "%StringName%="&goto :EOF)) 1>nul
(set %StringName% 2>nul|findstr "Environment variable %StringName% not defined"&if errorlevel 1 (set "%StringName%="&goto :EOF)) 1>nul
goto :EOF




:end
if exist "SDS_FILES\Sessions\Default*" goto backupSession
color f0
:end2
mode con: cols=38 lines=18
call :setTime&echo ^|^|Log^|^|  ^|Info: EXIT^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Exit - SD-Security©
echo €€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€€€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
echo ˛˛˛ SD-Security ˛˛˛  EXIT  Signed Out
echo €€€‹‹‹‹‹‹‹‹‹‹‹‹‹€€€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.
echo     €€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo.    € € € € € € € € € € € € € € €
echo     €€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo     € €    ⁄ƒƒƒƒ¬ƒ.           € €
echo     €€€     \  /≥  \.         €€€
echo     € €      \/ ≥    \.       € €
echo     €€€      /\ ≥      \.     €€€
echo     € €     /  \≥        \    € €
echo     €€€   ˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛˛   €€€
echo     € €   ∏%year% SD-Security   € €
echo     €€€€€€€€€€€€€€€€€€€€€€€€€€€€€
echo     € € € € € € € € € € € € € € €
echo     €€€€€€€€€€€€€€€€€€€€€€€€€€€€€
timeout 2 >nul /nobreak
color f8&call :Wait 1&color f7&call :Wait 1&cls
endlocal
exit /b 999
:Quickend
call :setTime&echo ^|^|Log^|^|  ^|Info: EXIT^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\SD-Security.SDS_LOG"
endlocal
exit /b 999