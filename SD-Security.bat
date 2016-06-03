@echo off
if "%restart%"=="0" goto CrashHelperActive
:StartOfScript
setlocal disabledelayedexpansion
set SDS_Version=1.4.2B
set Version_Type=STABLE
set currentyear=2016&set "sds_file=%~nx0"&set "sds_extension=%~x0"&set "sds_folder=%~dp0"
set "sds_extension=%sds_extension:~1%" sds_file
set "HelpEmail=SamDenty99@outlook.com"
set "Set /p=call:AskString"
set "echo=<nul set /p ="&set "cd="&set "random="
call :checkOSInfo
if exist "SafeMode.*" goto Safe_Mode
if /i "%1"=="/safemode" goto Safe_Mode
if exist "SDS_Files\Security\Lockdown.sys" (goto :Lockdown)
goto CrashHelper

:: Start Of Crash Helper Enabled Code:
:CrashHelperActive
call :LoadingScreen&goto sLScrn
call :Plugins Preboot
:LoadingScreen
color f7
mode con: cols=21 lines=5
title Loading - SD-Security
cls
echo.
echo   �����������������
echo   �    Loading    �
echo   �����������������
color f7&call :Wait 2&color f8&call :Wait 2&color f0
goto :EOF
:sLScrn
call :SecurityLog
net file>nul 2>&1&&set "adminPer=Yes"||set "adminPer=No"
call :plugins inboot
call :MakeFiles
if exist "favicon.ico" attrib +h +s "favicon.ico">nul 2>&1
if exist "SDS_Files\Sessions\" for /f "delims=" %%a in ('dir /B /O:D SDS_Files\Sessions\^|findstr /I ".SDS_Session"') do (set "SessionFile=%%a"&&goto RestoreSession)
:NoRestore
call :sectimer start>nul 2>&1
del SDS_Files\Per.tmp>nul 2>&1&copy nul SDS_Files\Per.tmp>nul 2>&1||goto NoPermissions
del SDS_Files\Per.tmp>nul 2>&1
call :Statistics
if not exist "SDS_FILES\SD-Settings.ini" call :makesettings
call :FilePer unlock "SDS_FILES\SD-Settings.ini"
type SDS_Files\SD-Settings.ini>nul 2>&1||goto SettingsFileError
for /F "eol=# delims=" %%A in (SDS_FILES\SD-Settings.ini) do set "%%A">nul 2>&1
call :FilePer lock "SDS_FILES\SD-Settings.ini"
call :GetTheme&call :CheckUpdateSettings
if %Dev_Mode%==yes (attrib -h -s "favicon.ico"&del favicon.ico&del autorun.inf)>nul 2>&1
if %Used_Before%==no call :SecTimer Stop>nul 2>&1&call :SetWindow&call :welcome
:: Bug 101
set "Bug_101_Vuln2=%Bug_101_Vuln%"
for /f "tokens=5" %%a in ('@fsutil fsinfo volumeinfo %cd:~0,2%^|findstr /B "File System Name : "') do set "DriveType=%%a"
if /i "%DriveType%"=="NTFS" (set Bug_101_Vuln=no) else (set Bug_101_Vuln=yes)
if /i not "%Bug_101_Vuln2%"=="%Bug_101_Vuln%" call :OverwriteSettings
if /i not %Hide_Bug_101%==yes (if /i %Bug_101_Vuln%==yes call :SecTimer Stop>nul 2>&1&call :Bug101Yes)

:SetPasswords
call :AllowEncryption
:SetPasswords2
:: Account 1 (ADMIN ACCOUNT)
@set "%f%%h%%v%%i%1=%z%%w%%n%%r%%m%">nul 2>&1
@set "%k%%z%%h%%h%%d%%l%%i%%w%1=1234">nul 2>&1
    :: if not exist "SDS_Files\UserProfile.sys" call :MakeProfile
    :: setlocal
    :: set U=&set P=&call :Decrypt "SDS_Files\UserProfile.sys"
    :: endlocal&set "User1=%U%"&set "Password1=%P%"
    :: Account 2 (FALSE USER)
@set "%f%%h%%v%%i%2=%w%%v%%e%%v%%o%%l%%k%%v%%i%">nul 2>&1
@set "%k%%z%%h%%h%%d%%l%%i%%w%2=%w%%v%%e%">nul 2>&1
if "%Lockdown%"=="Yes" goto :EOF
:: Command Line Switches
if not "%CMDSwitch%"=="" call :SecTimer Stop>nul 2>&1&call :CommandSwitches %CMDSwitch%
if not exist "SDS_Files\Version_No.ini" call :updateUpdaterInfo&goto VersionSkip
:takeVersion
for /F "eol=# delims=" %%A in (SDS_FILES\Version_No.ini) do set %%A>nul 2>&1
call :updateUpdaterInfo
if not "%Old_SDS_Version%"=="%SDS_Version%" call :SecTimer Stop>nul 2>&1&call :updated
:VersionSkip
call :plugins afterboot
if "%endTime%"=="" (call :SecTimer Stop>nul 2>&1)&call :SecTimer Log
call :SetWindow
call :SecTimer Report
goto home


:Home
call :SetWindow
%SetTheme%
call :setTime&echo ^|^|Log^|^|  ^|Info: Home^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
call :CheckStatus Yes "goto :home2"
title Home - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                   Home                           %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  Sign In
echo �2�  How To Use
echo �3�  About
echo �4�  Other
echo �5�  Encrypto
echo �6�  Exit
echo.
%set /p% op="�� "
if "%op%"=="1" goto signin
if "%op%"=="2" color f0&call :HowToUse&goto :home
if "%op%"=="3" goto about
if "%op%"=="4" goto other2
if "%op%"=="5" goto signin
if "%op%"=="6" goto end
if /i "%op%"=="exit" goto end
if /i "%op%"=="x" goto end
if /i "%op%"=="quit" goto end
if /i "%op%"=="kill" goto end
if /i "%op%"=="close" goto end
if /i "%op%"=="backup" goto backupSession
call :error
goto home

:Home2
call :CheckStatus No "goto :home"
if exist "Unlocked" (set UnlockOrLock=Lock) else (if exist ".Locked.{645*" (set unLockOrLock=Unlock) else (set unLockOrLock=Create))
%SetTheme%
title Home - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                   Home                           %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  Sign Out
echo �2�  %unLockOrLock% Data Vault
echo �3�  About
echo �4�  Other
echo �5�  Encrypto
echo �6�  Exit
echo.
%set /p% op="�� "
if "%op%"=="1" goto signin
if "%op%"=="2" goto privatedata
if "%op%"=="3" goto about
if "%op%"=="4" goto other
if "%op%"=="5" goto encrypto
if "%op%"=="6" goto end
if /i "%op%"=="exit" goto end
if /i "%op%"=="x" goto end
if /i "%op%"=="quit" goto end
if /i "%op%"=="kill" goto end
if /i "%op%"=="close" goto end
if /i "%op%"=="backup" goto backupSession
call :error
goto home2
:error
call :setTime&echo ^|^|Log^|^|  ^|Error: Invalid Option Entered^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
echo.
color C4
call :color CF "         Invalid Option, Please Enter A Number Above And Press Enter"
call :beep&cls
goto :EOF


:: Data Vault
:Privatedata
call :CheckStatus No "goto :home"
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
if exist ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" goto unlock
if not exist "Unlocked" goto mdlocker
:confirm
call :CheckStatus No "goto :home"
if /i not %Bug_101_Vuln%==yes goto confirm2
title Encrypt Data Vault - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo              The Data Vault Is Unlocked And Anyone Can Access It,
:Loop
(cmd /c start /wait "SD-Security" cmd /c "mode con: cols=25 lines=4&color 3f&echo.&echo  To Lock The Data Vault,&echo       Press CTRL+C&timeout /t -1 /nobreak >nul">"%Temp%\CTRL+C.DETECTOR" 2>&1)
type "%Temp%\CTRL+C.DETECTOR"|findstr C>nul 2>&1&&echo                               Operation Cancelled!&& timeout 3 >nul&&goto :home||goto :lock
:confirm2
%SetTheme%
cls
call :CheckStatus No "goto :home"
title Data Vault Encryption Method - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  Advanced Encryption, You Can Only Decrypt The Vault With This User Account
echo �2�  Basic Encryption, You Can Decrypt The Vault With Any User Account
echo �3�  Back
%set /p% lockOption="�� "
if "%lockOption%"=="1" goto lock
if "%lockOption%"=="2" goto lock2
if "%lockOption%"=="3" goto home
color C4
call :color CF "         Invalid Option, Please Enter A Number Above And Press Enter"
call :beep&cls
goto confirm2
:lock
call :CheckStatus No "goto :home"
title Encrypting Data Vault - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
ren Unlocked ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul 2>&1
if exist "Unlocked" goto DataVaultError2
echo                            Protocol 1 �� Successful
attrib +h +s +r +a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul 2>&1
echo                            Protocol 2 �� Successful
call :FilePer lock ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
color 2a
echo                            Protocol 3 �� Successful
echo                            ������������������������
call :color 2f "                             Data Vault Encrypted"
echo.
title Locked Data Vault - SD-Security�
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Locked^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
pause >nul
%SetTheme%
goto home
:lock2
call :CheckStatus No "goto :home"
title Locking Data Vault - SD-Security�
cls
color 2a
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
ren Unlocked ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul
if exist "Unlocked" goto DataVaultError2
echo                            Protocol 1 �� Successful
attrib +h +s +r +a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul
echo                            Protocol 2 �� Successful
echo                            ������������������������
call :color 2f "                             Data Vault Encrypted"
echo.
title Locked Data Vault - SD-Security�
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Locked^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
pause >nul
%SetTheme%
goto home

:unlock
call :CheckStatus No "goto :home"
cls
title Enter Password - SD-Security�
if exist "%Security_Breach_Key%" goto breach
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                      %status%
echo �������������������������������������������������������������������������������
echo.
if not %Hide_Password%==yes (%set /p% password="Enter Password �� ") else (call :MaskPassword)
call :SignInNow "%User%" "%password%"
call :checkstatus No "goto :denied"
call :ClearLockdown
goto unlocking
:Unlocking
call :CheckStatus No "goto :home"
title Unlocking Data Vault - SD-Security�
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Unlocked^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
echo                            Protocol 1 �� Loading...
call :FilePer unlock ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
echo                            Protocol 1 �� Successful
attrib -h -s -r -a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul
echo                            Protocol 2 �� Successful
ren .Locked.{645FF040-5081-101B-9F08-00AA002F954E} "Unlocked" >nul
if not exist "Unlocked" goto DataVaultError
cls
color 2a
title Unlocked Data Vault - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
echo                            Protocol 1 �� Successful
echo                            Protocol 2 �� Successful
echo                            Protocol 3 �� Successful
echo                            ������������������������
call :color 2f "                             Data Vault Decrypted"
echo.
pause >nul
%SetTheme%
goto home
:DataVaultError
title Decryption Failed - SD-Security�
cls
color 4c
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
echo                            Protocol 1 �� Unsuccessful - Error
echo                            Protocol 2 �� Unsuccessful
echo                            Protocol 3 �� Unsuccessful
echo                            ��������������������������
echo                                Decryption Failed
echo.
echo  �����������������������������������������������������������������������������
echo.
echo   The Data Vault Was Unsuccessfully Decrypted Due To It Being Encrypted With
echo                   SD-Security's Advanced Security Feature.
echo.
echo   To Decrypt It, You Need To Connect �%cd:~0,3%� To The PC That The Vault Was
echo                                    Encrypted On
pause >nul
goto home
:DataVaultError2
cls
title Encryption Failed - SD-Security�
color 4c
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
echo                            Protocol 1 �� Unsuccessful - Error
echo                            Protocol 2 �� Unsuccessful - Error
echo                            Protocol 3 �� Unsuccessful - Error
echo                            ��������������������������
echo                                Encryption Failed
echo.
echo  �����������������������������������������������������������������������������
echo.
echo       The Data Vault Was Unsuccessfully Decrypted Due To The Permissions
echo                          Disallowing Write Access To It
echo.
echo   To Decrypt It, You Need To Close Any Program Using The Folder And Possibly
echo Change The Permissions Of �%cd%\Unlocked�
echo                                To �Everyone: Allow All�
pause >nul
goto home
:breach
if not exist "%Security_Breach_Key%" goto home
del %security_Breach_Key%
title Security Breach - SD-Security�
call :setTime&echo ^|^|Log^|^|  ^|Info: Master Override Attempted^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
color C4
title WARNING - SD-Security�
color C4
call :beep&cls
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
call :color CF "Continue Y,N"
%set /p% optionHACK="�� "
if /i "%optionHACK%"=="y" goto HACKloopSTART
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
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� %wholebreachnum%%ender%
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
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 25%%                       � ��������                         �
timeout 1 >nul /nobreak
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 50%%                       � ����������������                 �
timeout 1 >nul /nobreak
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 75%%                       � ������������������������         �
timeout 1 >nul /nobreak
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 100%%                      � �������������������������������� �
echo.
echo                                      FINSIHED
timeout 2 >nul /nobreak
call :Randomo 1 >nul
if "%randomo%" GEQ "5" :goto denied
call :setTime&echo ^|^|Log^|^|  ^|Info: Master Override Successful^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
echo                            Protocol 1 �� Loading...
call :FilePer unlock ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
echo                            Protocol 1 �� Successful
attrib -h -s -r -a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" >nul
echo                            Protocol 2 �� Successful
ren .Locked.{645FF040-5081-101B-9F08-00AA002F954E} "Unlocked" >nul
cls
color 2a
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo Enter Password �� ����������
echo.
echo                            Protocol 1 �� Successful
echo                            Protocol 2 �� Successful
echo                            Protocol 3 �� Successful
echo                            ������������������������
call :color 2F "                             Data Vault Decrypted"
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Unlocked^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
del %Security_Breach_Key%
pause >nul
%SetTheme%
goto home
:Denied
title Access Denied - SD-Security�
call :setTime&echo ^|^|Log^|^|  ^|Info: Login Failed^| ^|Username: %User%^| ^|Password: %password% ^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
color 4C
echo.
echo                  Error: Password / Username Is Incorrect!
if exist "SDS_Files\Security\PasswordAttempts.sys" (for /F "eol=# delims=" %%A in (SDS_Files\Security\PasswordAttempts.sys) do set "%%A">nul 2>&1) else (echo "PasswordAttempts=5">"SDS_Files\Security\PasswordAttempts.sys"&set "PasswordAttempts=5")
set /a PasswordAttempts=%PasswordAttempts% -1 >nul
if "%PasswordAttempts%"=="0" (call :ClearLockdown&echo.>"SDS_Files\Security\Lockdown.sys"&attrib +h +s "SDS_Files\Security\Lockdown.sys"&set "ExitLockdown=Yes"&goto :Lockdown) else (attrib -h -s "SDS_Files\Security\PasswordAttempts.sys"&echo "PasswordAttempts=%PasswordAttempts%">"SDS_Files\Security\PasswordAttempts.sys"&attrib +h +s "SDS_Files\Security\PasswordAttempts.sys")
timeout 10 >nul
%SetTheme%
goto home
:MDLOCKER
call :setTime&echo ^|^|Log^|^|  ^|Info: Data Vault Folder Created^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title Data Vault Created - SD-Security�
md Unlocked
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Data Vault                        %status%
echo �������������������������������������������������������������������������������
echo.
echo             The SD-Security Data Vault Directory Has Been Created
echo            Put All Your Private Data In The Folder Named 'Unlocked'
echo    When You Have Finished Go Back Into SD-Security, Sign In And Lock The Data
echo                                       Vault.
echo.
call :color %themeColor:~0,1%f "                            Press Any Key To Go Home"
pause >nul
goto home


:: About
:about
cls
call :setTime&echo ^|^|Log^|^|  ^|Info: About^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title About - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                      About                       %status%
echo �������������������������������������������������������������������������������
echo.
echo  SD-Security V.%SDS_Version% %Version_Type% Build
echo.
echo  SD-Security, The Free Open-Source Security Software For Windows
echo  This Software Is For Personal ^& Professional Use, But Must Not Be:
echo    * Re-Distributed, Without Prior Permission From The Developer.
echo    * Included In Software Bundles, Without Prior Permission From The Developer.
echo  You Are Allowed To:
echo    * Create Links To The Official Download Page.
echo    * Create And Publish Apps ^& Plugins For SD-Security
echo   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
echo  Developer Contact Details:
echo  Name   : Sam (Samuel) Denty
echo  Email  : %HelpEmail%
echo  Webpage: http://SD-Storage.weebly.com/
echo.
echo                             Press Any Key To Go Home
pause >nul
goto home


:: Sign In
:SignIn
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
call :CheckStatus Yes "goto :Signout"
if exist "%Security_Breach_Key%" goto :adminSignIn
title Sign In - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                      Sign In                     Signing In
echo �������������������������������������������������������������������������������
echo.
echo Enter �USB� To Login With USB
%set /p% user="Enter Username �� "
if /i "%user%"=="usb" goto usblogin
if not %Hide_Password%==yes (%set /p% password="Enter Password �� ") else (call :MaskPassword)
:passwordchecker
call :SignInNow "%User%" "%Password%"
call :checkstatus No "goto :denied"
call :ClearLockdown
goto :home
:Verify
set "User=%~1"
set "Password=%~2"
call :SignInNow "%User%" "%Password%"
call :checkstatus No "goto :denied"
call :ClearLockdown
goto :EOF
:SignInUSB
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title Sign In - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                      Sign In                     Signing In
echo �������������������������������������������������������������������������������
echo.
%set /p% user="Enter Username �� "
if not %Hide_Password%==yes (%set /p% password="Enter Password �� ") else (call :MaskPassword)
call :SignInNow "%User%" "%Password%"
call :checkstatus No "goto :denied"
call :ClearLockdown
goto ConfigUsbKey

:signout
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign Out^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title Sign Out - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                      Sign Out                    %status%
echo �������������������������������������������������������������������������������
echo.
echo                    You Are Currently Signed In As �%user%�,
echo                         Are You Sure You Want To Sign Out?
echo �1�  Yes
echo �2�  No
%set /p% signout2="�� "
if "%signout2%"=="1" set "status=Signed Out"&goto :home
goto home

:: Other When Signed Out
:other2
%SetTheme%
call :CheckStatus Yes "goto :Other"
call :setTime&echo ^|^|Log^|^|  ^|Info: Other^| ^|Time: %twelve%^| ^|Date: %date2%^|  >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Other - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                         Other                    %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  SD-Software Folder
echo �2�  Developer Options Folder
echo �3�  Installation Information
echo �4�  Check For Updates (BETA)
echo �5�  Custom Apps
echo �6�  Home
%set /p% other2="�� "
if "%other2%"=="1" goto SDSoftware
if "%other2%"=="2" goto DevOptions
if "%other2%"=="3" goto installInfo
if "%other2%"=="4" goto CheckForUpdates
if "%other2%"=="5" goto CustomApps
goto home
:: Other When Signed In
:other
call :CheckStatus No "goto :other2"
call :setTime&echo ^|^|Log^|^|  ^|Info: Other^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Other - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                       Other                      %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  SD-Software Folder
echo �2�  Developer Options Folder
echo �3�  Installation Information
echo �4�  Check For Updates (BETA)
echo �5�  Custom Apps
echo �6�  Admin Options Folder
echo �7�  Home
%set /p% other="�� "
if "%other%"=="1" goto SDSoftware
if "%other%"=="2" goto DevOptions
if "%other%"=="3" goto installInfo
if "%other%"=="4" goto CheckForUpdates
if "%other%"=="5" goto CustomApps
if "%other%"=="6" goto AdminOps
goto home
:AdminOps
cls
title Admin Options Folder - Other - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Admin Options Folder               %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  SD-Statistics
echo �2�  Open Security Log
echo �3�  Change SD-Settings
echo �4�  Back
%set /p% other4="�� "
if "%other4%"=="1" goto showStatistics
if "%other4%"=="2" goto openlog
if "%other4%"=="3" goto changesettings
goto other
:SDSoftware
cls
title SD-Software Folder - Other - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                SD-Software Folder                %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  CMD++
echo �2�  SD-Hotspot
echo �3�  SD-SecurChecker
echo �4�  Advanced Power Options
echo �5�  Get IP
echo �6�  Emailer
echo �7�  File Downloader
echo �8�  Back
%set /p% other3="�� "
if "%other3%"=="1" goto CMDPlus
if "%other3%"=="2" goto hotspothome
if "%other3%"=="3" goto SDSecurChecker
if "%other3%"=="4" goto APO
if "%other3%"=="5" goto GetIPGUI
if "%other3%"=="6" goto Emailer
if "%other3%"=="7" goto FileDownloader
goto other
:openlog
call :setTime&echo ^|^|Log^|^|  ^|Info: Security Log Viewed^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title Opening Log - SD-Security�
copy SDS_Files\Security\SD-Security.SDS_LOG "SDS_Files\tmp.txt">nul 2>&1
echo ///////////////////////>> "SDS_Files\tmp.txt"
echo DON'T RESAVE THIS FILE!>> "SDS_Files\tmp.txt"
echo ///////////////////////>> "SDS_Files\tmp.txt"
start SDS_Files\tmp.txt
set/a deletenum=10
:deleteloop
title %deletenum% Seconds Until Temp. Log Deleted - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                         Other                    %status%
echo �������������������������������������������������������������������������������
echo.
echo                   %deletenum% Seconds Until Temp. Log Deleted
timeout 1 /nobreak >nul
set/a deletenum=%deletenum% -1
if "%deletenum%"=="0" goto deletelog
goto deleteloop
:deletelog
del SDS_Files\tmp.txt >nul 2>&1
if exist "SDS_Files\tmp.txt" goto cantdeletelog
call :setTime&echo ^|^|Log^|^|  ^|Info: Tmp Log Deleted^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
goto home
:cantdeletelog
:deletelogloop2
if not exist "SDS_Files\tmp.txt" goto home
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                         Other                    %status%
echo �������������������������������������������������������������������������������
echo.
echo           Can't Delete Temporary Log, Please Close Log When Done
del SDS_Files\tmp.txt
goto deletelogloop2
:CMDPlus
call :CheckStatus No "goto :CMDPlus_2"
call :setTime&echo ^|^|Log^|^|  ^|Info: CMD++^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
set "cmd++=goto cmdCommand"
net file>nul 2>&1&&set "AdminFigure=#"||set "AdminFigure=$"
cls
if /i "%mode%"=="speedo" goto :SpeedoMode
if /i "%mode%"=="normal" goto :NormalMode
set mode=normal&goto :NormalMode
:: Normal Mode
:NormalMode
color 07
title CMD++ REMIX for SD-Security
echo ���������������������������������������
%echo% �&call :color 0f "CMD++ " &call :color 0e " Normal Mode"&call :color 0a " [Version 1.5.1.150]"&%echo%  �&echo.
echo ���������������������������������������
call :color 0f " SD-Storage�"&call :color 07 " 2016, All Rights Reserved"&echo.
goto :cmdCommand
:: Speedo Mode
:SpeedoMode
color 07
title CMD++ REMIX for SD-Security
echo ���������������������������������������
echo �CMD++ Speedo Mode [Version 1.5.1.150]�
echo ���������������������������������������
echo  SD-Storage� 2016, All Rights Reserved
goto :cmdCommand
:cmdCommand
echo.
:cmdCommand2
if "%cd:~-1%"=="\" (set "Directory=%cd%") else (set "Directory=%cd%\")
set "cmdCommand="
if not "%mode%"=="speedo" (%echo% %directory%&call :color 0d "%AdminFigure%"&set /p "cmdCommand=>") else (%echo% %directory%%AdminFigure%&set /p "cmdCommand=>")
if not defined CmdCommand (goto :CmdCommand2)
set "CMDCmd=%cmdCommand:"=%"
call :commands
if /i not "%mode%"=="speedo" goto NormalCommand
if /i "%mode%"=="speedo" %echo% Output[&echo.&%cmdCommand%
goto :cmdCommand
:NormalCommand
call :color 0b "Output["&echo.&%cmdCommand%
goto :cmdCommand
:commands
if /i "%CMDCmd%"=="cmd" goto :cmd
if /i "%CMDCmd%"=="wincmd" cmd&goto :cmdCommand
if /i "%CMDCmd%"=="clear" cls&goto :cmdCommand
if /i "%CMDCmd%"=="speedo" set mode=speedo&goto :cmdCommand
if /i "%CMDCmd%"=="normal" set mode=normal&goto :cmdCommand
if /i "%CMDCmd%"=="help" call :helpCMDPlus&goto :cmdCommand
if /i "%CMDCmd%"=="reset" goto :resetCMDPlus
if /i "%CMDCmd%"=="exit" goto :home
if /i "%CMDCmd%"=="close" goto :home
if /i "%CMDCmd%"=="sds" goto :home
if /i "%CMDCmd%"=="back" goto :home
if /i "%CMDCmd%"=="SD-Storage" start "" "http://SD-Storage.weebly.com/#CMD++"&echo Website Launched&goto :cmdCommand
goto :EOF
:helpCMDPlus
call :color 0f "CMD++"&%echo%, Quick Help&echo.&echo.
echo Welcome to CMD++, a powerful reinterpretation of the Windows 'Command Prompt'
echo CMD++ is a mix of the Linux and Windows terminals, a perfect combination
echo.
echo This version of CMD++ is a remix, designed for use in SD-Security. 
echo.
echo To use CMD++ type in a command and press enter.
echo Done.
echo. 
echo CMD++ overrides some commands (eg. CMD), this is necessary to keep the CMD++
echo session from ending. To perform an overriden command, prefix it with a space
echo 	'cmd' becomes ' cmd'	'reset' becomes ' reset' 
echo.
echo CMD++ has multiple modes, one of which is Speedo mode. This mode can be enabled
echo by entering 'speedo'. Speedo mode is greyscale and much quicker at performing 
echo commands (This setting is stored in the variable %%mode%%)
echo. 
echo Remember, with great power comes great responcibility.
echo CMD++ will perform any command entered, so don't 'format C:'
goto :EOF
:resetCMDPlus
color 07&mode con: cols=80 lines=27&cls&goto :cmd

:CMDPlus_2
(echo @echo off
echo if "%%NonFatalCrash%%"=="1" call :Variables^&set mode=normal^&goto :cmdCommand
echo if "%%restartCMD%%"=="0" goto CrashHelperActive
echo goto CrashHelper
echo :CrashHelperActive
echo call :Variables
echo :CMD
echo if /i "%%mode%%"=="speedo" goto :SpeedoMode
echo if /i "%%mode%%"=="normal" goto :NormalMode
echo set mode=normal^&goto :NormalMode
echo :: Normal Mode
echo :NormalMode
echo color 07
echo title CMD++
echo echo ���������������������������������������
echo %%echo%% �^&call :color 0f "CMD++ " ^&call :color 0e " Normal Mode"^&call :color 0a " [Version 1.5.1.150]"^&%%echo%%  �^&echo.
echo echo ���������������������������������������
echo call :color 0f " SD-Storage�"^&call :color 07 " 2016, All Rights Reserved"^&echo.
echo goto :cmdCommand
echo :: Speedo Mode
echo :SpeedoMode
echo color 07
echo title CMD++
echo echo ���������������������������������������
echo echo �CMD++ Speedo Mode [Version 1.5.1.150]�
echo echo ���������������������������������������
echo echo  SD-Storage� 2016, All Rights Reserved
echo goto :cmdCommand
echo :cmdCommand
echo echo.
echo :cmdCommand2
echo if "%%cd:~-1%%"=="\" (set "Directory=%%cd%%"^) else (set "Directory=%%cd%%\"^)
echo set "cmdCommand="
echo if not "%%mode%%"=="speedo" (%%echo%% %%directory%%^&call :color 0d "%%AdminFigure%%"^&set /p "cmdCommand=>"^) else (%%echo%% %%directory%%%%AdminFigure%%^&set /p "cmdCommand=>"^)
echo if not defined CmdCommand (goto :CmdCommand2^)
echo set "CMDCmd=%%cmdCommand:"=%%"
echo call :commands
echo if /i not "%%mode%%"=="speedo" goto NormalCommand
echo if /i "%%mode%%"=="speedo" %%echo%% Output[^&echo.^&%%cmdCommand%%
echo goto :cmdCommand
echo :NormalCommand
echo call :color 0b "Output["^&echo.^&%%cmdCommand%%
echo goto :cmdCommand
echo :commands
echo if /i "%%CMDCmd%%"=="cmd" goto :cmd
echo if /i "%%CMDCmd%%"=="wincmd" cmd^&goto :cmdCommand
echo if /i "%%CMDCmd%%"=="clear" cls^&goto :cmdCommand
echo if /i "%%CMDCmd%%"=="speedo" set mode=speedo^&goto :cmdCommand
echo if /i "%%CMDCmd%%"=="normal" set mode=normal^&goto :cmdCommand
echo if /i "%%CMDCmd%%"=="help" call :help^&goto :cmdCommand
echo if /i "%%CMDCmd%%"=="reset" goto :reset
echo if /i "%%CMDCmd%%"=="exit" exit 999
echo if /i "%%CMDCmd%%"=="close" exit 999
echo if /i "%%CMDCmd%%"=="SD-Storage" start "" "http://SD-Storage.weebly.com/#CMD++"^&echo Website Launched^&goto :cmdCommand
echo goto :EOF
echo :help
echo call :color 0f "CMD++"^&%%echo%%, Quick Help^&echo.^&echo.
echo echo Welcome to CMD++, a powerful reinterpretation of the Windows 'Command Prompt'
echo echo CMD++ is a mix of the Linux and Windows terminals, a perfect combination
echo echo.
echo echo CMD++ executable for SD-Security 1.4.2+
echo echo.
echo echo To use CMD++ type in a command and press enter.
echo echo Done.
echo echo. 
echo echo CMD++ overrides some commands (eg. CMD^), this is necessary to keep the CMD++
echo echo session from ending. To perform an overriden command, prefix it with a space
echo echo 	'cmd' becomes ' cmd'	'reset' becomes ' reset' 
echo echo.
echo echo CMD++ has multiple modes, one of which is Speedo mode. This mode can be enabled
echo echo by entering 'speedo'. Speedo mode is greyscale and much quicker at performing 
echo echo commands (This setting is stored in the variable %%%%mode%%%%^)
echo echo.
echo echo CMD++ also has a built in crash helper. This means that if CMD++ crashes,
echo echo it will simply show an message and you can then continue. To exit CMD++,
echo echo there needs to be an errorlevel of '999' to quit the session, so instead of
echo echo 	'exit' use 'exit 999'	or to restart CMD++ use 'exit 777'
echo echo. 
echo echo Remember, with great power comes great responcibility.
echo echo CMD++ will perform any command entered, so don't 'format C:'
echo goto :EOF
echo :reset
echo color 07^&mode con: cols=80 lines=27^&cls^&goto :cmd
echo :Color
echo if /i "%%mode%%"=="speedo" %%echo%% %%~2^&goto :EOF
echo if not exist "C:\windows\system32\findstr.exe" %%echo%% %%~2^&goto :EOF
echo for /F "tokens=1,2 delims=#" %%%%a in ('"prompt #$H#$E# & for %%%%b in (1) do rem"'^) do (set "DEL=%%%%a"^)
echo pushd %%temp%%
echo ^<nul set /p ".=%%DEL%%" ^> "%%~2"
echo findstr /v /a:%%1 /R "^$" "%%~2" nul
echo del "%%~2"^>nul 2^>^&1
echo popd
echo goto :EOF
echo :Variables
echo set "cmd++=goto cmdCommand"
echo set "echo=<nul set /p ="
echo net file^>nul 2^>^&1^&^&set "AdminFigure=#"^|^|set "AdminFigure=$"
echo goto :EOF
echo. 
echo :CrashHelper
echo set restartCMD=0
echo call cmd /t:f0 /c "%%0"
echo :CrashHelperPriorityCode
echo @if errorlevel 999 @exit 999
echo @if errorlevel 777 @goto :CrashHelperActive
echo @call :color 0f "CMD++"^&call :color 0e " Console Host"^&call :color 0c " Crashed!"^&call :color 0a " Restarting..."
echo @set NonFatalCrash=1
echo @goto :CrashHelper)> "%temp%\CMD++.bat"
setlocal
call :ClearPrivate
call start %temp%\CMD++.bat
endlocal
goto :Home
:: accounts
:autologinhack
set "user=USB Drive"
call :setTime&echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: USB Drive^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
set "status=Signed In"
goto home
:SignInNow
set "status=Signed Out"
@if "%~1"=="%Security_Breach_Key%" (set "status=Signed In"&goto :EOF)
@if not "%user1%"=="%~1" (if not "%user2%"=="%~1" goto :EOF)
@if not "%password1%"=="%~2" (if not "%password2%"=="%~2" goto :EOF)
call :setTime&echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %user%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
set "status=Signed In"
goto :EOF


:: Security Breach
:AdminSignIn
color 07
title $Terminal
%echo% SD-Security &call :color 0a "Terminal Mode"&%echo% . [&call :color 0f "Version 1.4.1000"&%echo% ]&echo.
echo SD-Storage� 2015, All Rights Reserved.
echo.
%echo% TERMINAL^>load "scripts\mstr-ovrde_v.10.sds" "root\terminal.sds"&echo.
timeout 1 /nobreak >nul
%echo% scripts\&call :Color 0d "mstr-ovrde_v.10.sds"&%echo% ^>echo SDS 1.1.4+ master override program&echo.
echo this script will override the sd-security security system.
echo you are only allowed to use this tool IF THIS COPY OF SDS BELONG TO YOU!
echo.
echo Are you sure you want to continue? [Y,N]
%echo% files\&call :Color 0d "terminal.sds"&set /p decide=">"
if /i "%decide%"=="y" goto :StartBreach
if /i "%decide%"=="yes" goto :StartBreach
attrib -h -s "%security_breach_key%"&del %security_breach_key%
goto :home
:StartBreach
%echo% files\&call :Color 0d "terminal.sds"&%echo% ^>capturehash -sha256 -t "password.aes256"&echo.
%echo% Input file '&call :Color 0e "password.aes256"&%echo%' AES.256.BIT ENCRYPTION DETECTED&echo.
echo Capturing SHA-256 ^& MD5 hashes...
timeout 1 /nobreak>nul
%echo% SHA-256_&call :Color 0c "d6674b56c85e02918ea3514bcf3795f3f29105eadb6855a96dfe1c96cdeb7001"&echo.
%echo% MD5hash_&call :Color 0c "845a3a466c6c1b37f31383341b536c9c"&echo.
call :color 02 "FILE SCAN"&%echo% : ASCII pattern detected! #%random%&echo.&echo.
timeout 1 /nobreak>nul
%echo% files\&call :Color 0d "terminal.com"&%echo% ^>decRkey -SHA "%%SHA-256%%" -MD5 "%%MD5hash%%" -key "0VeR!|}E"&echo.
timeout 1 /nobreak>nul
echo DecrKey VERSION 5.23BETA, GonigII-Soft
echo decrypting file from key and SHA-256 (MD5 not neccesary)...
timeout 5 /nobreak >nul
echo errorlevel=0^&ouptut=^$RAM^$\decryptedpassword.NAND#4524&echo.
%echo% files\&call :Color 0d "terminal.sds"&%echo% ^>read -file "decryptedpassword.NAND#4524"^|login.sds -nogui&echo.
call :color 2a "login successful"&%echo% ! &call :color 0f "username"&%echo% :"Master Override" &call :color 08 "password"&%echo% : "p������$�����;��f��"&echo.
%echo% files\&call :Color 0d "terminal.sds"&%echo% ^>reboot -return ":home" -5&echo.
echo Waiting 5 Seconds, Then Returning Home
timeout 5 >nul
set "User=Master Override"
call :SignInNow "%Security_Breach_Key%"
call :setTime&echo ^|^|Log^|^|  ^|Info: Master Override Successful!^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
goto home

:: Loading Sequence/Startup
:securitylog
:: Set Some Variables, Used By SD-Security
set "status=Signed Out"
set notifications=0
if not exist "SDS_Files" call :makeSDSFiles
if not exist "SDS_Files\Security" md SDS_Files\Security
call :setTime
echo.>> "SDS_Files\Security\SD-Security.SDS_LOG"
echo ^|^|Version %SDS_Version%^|^|  ^|Time: %twelve%^| ^|Date: %date2%^| ^|OS: %WinVersion%^| ^|Serial: %serial%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
goto :EOF
:MakeFiles
if not exist "SDS_Files\SD-Updater.ini" call :MakeSDUpdaterSettings
if "%cd%"=="%cd:~0,3%" (if not exist "%cd:~0,3%autorun.inf" (call :CreateAutorun))
goto :EOF
:MakeSDUpdaterSettings
echo # SD-Updater Server Settings> "SDS_Files\SD-Updater.ini"
echo # To Reset The Servers To The Default Values, Delete This File>> "SDS_Files\SD-Updater.ini"
echo # The Below Settings Are Used By SD-Security To Check For Updates>> "SDS_Files\SD-Updater.ini"
echo Latest_Version_Log=http://www.dropbox.com/s/kue59qjeasq0tp7/OnlineVersion.txt?dl=1 >> "SDS_Files\SD-Updater.ini"
echo Latest_Version_EXE=http://www.dropbox.com/s/r6gyfh9kc9sqy3t/SD-Security.exe?dl=1 >> "SDS_Files\SD-Updater.ini"
goto :EOF
:CreateAutorun
(call :FilePer unlock "autorun.inf"&del autorun.inf)>nul 2>&1
(echo [autorun]&echo Open=%SDS_File%
echo ShellExecute=System\%SDS_File%
echo Shell\Open\Command=%SDS_File%&echo Shell\Open=Launch SD-Security�
echo Action=Launch SD-Security�&echo Icon=favicon.ico
echo Label=SD-Security�&echo UseAutoplay=1
echo.&echo [Content]&echo MusicFiles=false
echo PictureFiles=false&echo VideoFiles=false)> "autorun.inf"
attrib +h +s "autorun.inf" >nul
call :setTime&echo ^|^|Log^|^|  ^|Info: Autorun File Created^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
goto :EOF
:makeSDSFILES
md SDS_Files\Security
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Security Folder Made^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
attrib +h +s "SDS_Files"
echo This folder is used by SD-Security to store %username%'s data, so please don't delete it :D >> "SDS_FILES\README.TXT"
goto :EOF
:welcome
call :setTime&echo ^|^|Log^|^|  ^|Info: Welcome To SD-Security^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title Welcome To SD-Security
set Used_Before=yes
call :OverwriteSettings
:HowToUse
cls
set "ClR=call :color"
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Welcome                       %status%
echo �������������������������������������������������������������������������������
echo �                                                                             �
echo �                         ���������������������������                         �
echo �                         � Welcome To SD-Security! �                         �
echo �                         ���������������������������                         �
echo �                                                                             �
echo �  Welcome To SD-Security! A Portable, MS-DOS Security Program For Windows.   �
echo �     Featuring Easy-To-Use Menus, Sounds, Loads Of Customizable Settings     �
%echo% �                 And Best Of All, Loads Of Colourful &%Clr% b3 "T"&%Clr% e6 "h"&%Clr% c4 "e"&%Clr% a2 "m"&%Clr% 91 "e"&%Clr% d5 "s"&echo !                 �
echo �             To Use SD-Security, You Need To Know These 3 Things:            �
echo.�                                                                             �
echo � 1. To Select An Option From A Menu, Type The Number/Letter At The Left      �
echo �               Of The Option And Press ENTER On The Keyboard                 �
echo.�                                                                             �
echo � 2. Never Enter Any Special Symbols Into SDS (EG: ^& ^| ^/ %%), Or SDS Could     �
echo �    Crash. If SDS Does Crash, Report It To The Us Via The Report Crash Screen�
echo �                                                                             �
echo � 3. SD-Security Is An Open-Source Application Wrote And Updated By Sam Denty �
%echo% �    http://&%Clr% f9 "facebook.com"&%echo% /&%clr% f9 "SamuelDenty"&%echo%/    �  http://&%Clr% f9 "SD-Storage.weebly.com"&echo /     �
echo �                                                                             �
echo � Would You Like To Navigate Around A Demo Menu?                              �
echo � �1�  Yes                                                                    �
echo � �2�  No (Start Using)
set /p demo="� �� "
if "%demo%"=="1" goto demo
if "%demo%"=="2" goto :EOF
color 4C
call :color f0 "Please Press 1 Or 2 On Your Keyboard And Then Type ENTER"
pause >nul
%SetTheme%
goto welcome
:demo
call :setTime&echo ^|^|Log^|^|  ^|Info: Demo^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title Demo - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Welcome                       %status%
echo �������������������������������������������������������������������������������
echo  Welcome to SD-Security, A very compatible software, that runs entirely on CMD
echo             And uses only the keyboard to navigate your way around
echo �������������������������������������������������������������������������������
echo.
echo Here is a demo:
echo.
echo �1�  Home
echo �2�  Back
%set /p% demo="�� "
if "%demo%"=="1" goto :EOF
if "%demo%"=="2" goto HowToUse
color 4C
echo That is not a valid choice, enter a number from 1-2 and press ENTER
echo                           Press any key to go back.
pause >nul
%SetTheme%
goto demo


:: START OF USB LOGIN
:usblogin
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In With USB^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title USB Authentication
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                USB Authentication                %status%
echo �������������������������������������������������������������������������������
echo.
echo                         Please Take Out USB, Then Insert
set "uv1=if exist ""
set "uv2=:\" (set dv"
set "uv3=) else (set dv"
%uv1%A%uv2%A=yes%uv3%A=no)&%uv1%B%uv2%B=yes%uv3%B=no)
%uv1%C%uv2%C=yes%uv3%C=no)&%uv1%D%uv2%D=yes%uv3%D=no)
%uv1%E%uv2%E=yes%uv3%E=no)&%uv1%F%uv2%F=yes%uv3%F=no)
%uv1%G%uv2%G=yes%uv3%G=no)&%uv1%H%uv2%H=yes%uv3%H=no)
%uv1%I%uv2%I=yes%uv3%I=no)&%uv1%J%uv2%J=yes%uv3%J=no)
%uv1%K%uv2%K=yes%uv3%K=no)&%uv1%L%uv2%L=yes%uv3%L=no)
%uv1%M%uv2%M=yes%uv3%M=no)&%uv1%N%uv2%N=yes%uv3%N=no)
%uv1%O%uv2%O=yes%uv3%O=no)&%uv1%P%uv2%P=yes%uv3%P=no)
%uv1%Q%uv2%Q=yes%uv3%Q=no)&%uv1%R%uv2%R=yes%uv3%R=no)
%uv1%S%uv2%S=yes%uv3%S=no)&%uv1%T%uv2%T=yes%uv3%T=no)
%uv1%U%uv2%U=yes%uv3%U=no)&%uv1%V%uv2%V=yes%uv3%V=no)
%uv1%W%uv2%W=yes%uv3%W=no)&%uv1%Y%uv2%Y=yes%uv3%Y=no)
%uv1%Z%uv2%Z=yes%uv3%Z=no)
:CheckForUSBChange
set "uv1=if exist ""
set "uv2=:\" (set dv2"
set "uv3=) else (set dv2"
%uv1%A%uv2%A=yes%uv3%A=no)&%uv1%B%uv2%B=yes%uv3%B=no)
%uv1%C%uv2%C=yes%uv3%C=no)&%uv1%D%uv2%D=yes%uv3%D=no)
%uv1%E%uv2%E=yes%uv3%E=no)&%uv1%F%uv2%F=yes%uv3%F=no)
%uv1%G%uv2%G=yes%uv3%G=no)&%uv1%H%uv2%H=yes%uv3%H=no)
%uv1%I%uv2%I=yes%uv3%I=no)&%uv1%J%uv2%J=yes%uv3%J=no)
%uv1%K%uv2%K=yes%uv3%K=no)&%uv1%L%uv2%L=yes%uv3%L=no)
%uv1%M%uv2%M=yes%uv3%M=no)&%uv1%N%uv2%N=yes%uv3%N=no)
%uv1%O%uv2%O=yes%uv3%O=no)&%uv1%P%uv2%P=yes%uv3%P=no)
%uv1%Q%uv2%Q=yes%uv3%Q=no)&%uv1%R%uv2%R=yes%uv3%R=no)
%uv1%S%uv2%S=yes%uv3%S=no)&%uv1%T%uv2%T=yes%uv3%T=no)
%uv1%U%uv2%U=yes%uv3%U=no)&%uv1%V%uv2%V=yes%uv3%V=no)
%uv1%W%uv2%W=yes%uv3%W=no)&%uv1%Y%uv2%Y=yes%uv3%Y=no)
%uv1%Z%uv2%Z=yes%uv3%Z=no)
if not "%DVA%"=="%DV2A%" set TheDv=A&goto :FoundUSB
if not "%DVB%"=="%DV2B%" set TheDv=B&goto :FoundUSB
if not "%DVC%"=="%DV2C%" set TheDv=C&goto :FoundUSB
if not "%DVD%"=="%DV2D%" set TheDv=D&goto :FoundUSB
if not "%DVE%"=="%DV2E%" set TheDv=E&goto :FoundUSB
if not "%DVF%"=="%DV2F%" set TheDv=F&goto :FoundUSB
if not "%DVG%"=="%DV2G%" set TheDv=G&goto :FoundUSB
if not "%DVH%"=="%DV2H%" set TheDv=H&goto :FoundUSB
if not "%DVI%"=="%DV2I%" set TheDv=I&goto :FoundUSB
if not "%DVJ%"=="%DV2J%" set TheDv=J&goto :FoundUSB
if not "%DVK%"=="%DV2K%" set TheDv=K&goto :FoundUSB
if not "%DVL%"=="%DV2L%" set TheDv=L&goto :FoundUSB
if not "%DVM%"=="%DV2M%" set TheDv=M&goto :FoundUSB
if not "%DVN%"=="%DV2N%" set TheDv=N&goto :FoundUSB
if not "%DVO%"=="%DV2O%" set TheDv=O&goto :FoundUSB
if not "%DVP%"=="%DV2P%" set TheDv=P&goto :FoundUSB
if not "%DVQ%"=="%DV2Q%" set TheDv=Q&goto :FoundUSB
if not "%DVR%"=="%DV2R%" set TheDv=R&goto :FoundUSB
if not "%DVS%"=="%DV2S%" set TheDv=S&goto :FoundUSB
if not "%DVT%"=="%DV2T%" set TheDv=T&goto :FoundUSB
if not "%DVU%"=="%DV2U%" set TheDv=U&goto :FoundUSB
if not "%DVV%"=="%DV2V%" set TheDv=V&goto :FoundUSB
if not "%DVW%"=="%DV2W%" set TheDv=W&goto :FoundUSB
if not "%DVX%"=="%DV2X%" set TheDv=X&goto :FoundUSB
if not "%DVY%"=="%DV2Y%" set TheDv=Y&goto :FoundUSB
if not "%DVZ%"=="%DV2Z%" set TheDv=Z&goto :FoundUSB
goto :CheckForUSBChange
:FoundUSB
cls
title USB Authentication
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                USB Authentication                %status%
echo �������������������������������������������������������������������������������
echo.
echo                              Connecting To USB...
:FoundUSBLoop
if not exist "%theDV%:\" goto :FoundUSBLoop
set "drive=%theDV%:"
set "localKey=SDS_Files\Last_Key.sds_usb_key"
set "UsbKey=%drive%\SD-Security.sds_usb_key"
if not exist "%UsbKey%" goto setupusb
if not exist "%localKey%" goto nolocalkey
for /F "delims=" %%A in (%UsbKey%) do set "%%A"
for /F "delims=" %%A in (%localKey%) do set "%%A"
if not "%key%"=="%last_key%" goto badKey
goto authByKey
:setupusb
cls
call :CheckStatus Yes "goto :configUSBKey"
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                USB Authentication                %status%
echo �������������������������������������������������������������������������������
echo.
echo     The Current USB Hasn't Been Setup, Would You Like To Setup This Key And
echo                     Replace Your Current Key With This One?
echo.
echo �1�  Yes
echo �2�  No
%set /p% ReplaceUSB="�� "
if "%ReplaceUSB%"=="1" goto getAuthUSB
goto :home
:getAuthUSB
call :CheckStatus Yes "goto configUSBKey"
goto SignInUSB
:configUSBKey
cls
call :setTime&echo ^|^|Log^|^|  ^|Info: USB Auth Key Updated^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                USB Authentication                %status%
echo �������������������������������������������������������������������������������
echo.
echo                   Configuring USB Drive Authentication Key...
echo.
set "newkey=%random%.%random%,%time%%random%*%random%?%random%#%random%%random%;%random%L%random%J%random%%random%t%random%%random%%errorlevel%"
if exist "%USBKEY%" attrib -a -s -h -r "%UsbKey%">nul 2>&1
echo key=%newkey%> "%UsbKey%"
attrib +a +s +h +r "%UsbKey%"
echo last_key=%newkey%> "%LocalKey%"
call :setTime&echo ^|^|Log^|^|  ^|Info: USB Drive Setup^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                USB Authentication                %status%
echo �������������������������������������������������������������������������������
echo.
echo    Drive Successfully Activated, You Can Now Use This Drive To Authenticate
echo                                  SD-Security!
echo.
echo                          Press Any Key To Return Home
timeout 10 >nul
goto home
:nolocalkey
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                USB Authentication                %status%
echo �������������������������������������������������������������������������������
echo.
echo  The Current USB Already Contains A Key, Would You Like To Overwrite This Key?
echo.
echo �1�  Yes
echo �2�  No
%set /p% EraseKey="�� "
if "%EraseKey%"=="1" goto setupusb
goto home
:badKey
color c4
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign In Failed (USB)^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                USB Authentication                %status%
echo �������������������������������������������������������������������������������
echo.
echo                        ��������������������������������
echo                        � Drive Authentication Failed! �
echo                        ��������������������������������
echo.
echo                          Press Any Key To Return Home
timeout 10 >nul
goto home
:authByKey
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                USB Authentication                %status%
echo �������������������������������������������������������������������������������
echo.
echo                            ������������������������
echo                            � Drive Authenticated! �
echo                            ������������������������
echo.
set "newkey=%random%.%random%,%time%%random%*%random%?%random%#%random%%random%;%random%L%random%J%random%%random%t%random%%random%%errorlevel%"
attrib -a -s -h -r "%UsbKey%">nul 2>&1
echo key=%newkey%> "%UsbKey%"
attrib +a +s +h +r "%UsbKey%"
echo last_key=%newkey%> "%LocalKey%"
timeout 2 >nul
goto autologinhack
:: END OF USB LOGIN

:makesettings
call :setTime&echo ^|^|Log^|^|  ^|Info: Settings For SD-Security Made^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
for /f "tokens=5" %%a in ('@fsutil fsinfo volumeinfo %cd:~0,2%^|findstr /B "File System Name : "') do (@set DriveType=%%a)
if /i not "%DriveType%"=="NTFS" (set Bug_101_Vuln=yes) else (set Bug_101_Vuln=no)
echo # SD-Security Settings File, Do Not Edit Unless You Are A Developer > "SDS_FILES\SD-Settings.ini"
echo Dev_Mode=no>> "SDS_FILES\SD-Settings.ini"
echo New_AdminCMD_API=yes>> "SDS_FILES\SD-Settings.ini"
echo Used_Before=no>> "SDS_FILES\SD-Settings.ini"
echo Trial_Mode=no>> "SDS_FILES\SD-Settings.ini"
echo Bug_101_Vuln=%Bug_101_Vuln%>> "SDS_FILES\SD-Settings.ini"
echo Hide_Bug_101=no>> "SDS_FILES\SD-Settings.ini"
echo Security_Breach_Key=%random%7%random%5%random%>> "SDS_FILES\SD-Settings.ini"
echo Hide_Password=no>> "SDS_FILES\SD-Settings.ini"
echo Theme=aqua>> "SDS_FILES\SD-Settings.ini"
goto :EOF

:Bug101Yes
call :setTime&echo ^|^|Log^|^|  ^|Error: 101^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Bug 101 Vulnerable - SD-Security
color C4
call :SetWindow
echo.
echo  ������������������������������������������������������������������������������
echo  � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �  �
echo  ���������������������������������������������������������������������������� �
echo  � ����         ����        ������        ��������     �������        ���������
echo  ������ ������������ ������� ����� ������� ������ ����� ������ ������� ������ �
echo  � ���� ������������ �������� ���� �������� ���� ������� ����� �������� �������
echo  ������ ������������ ������� ����� ������� ���� ��������� ���� ������� ������ �
echo  � ����         ����        ������        ����� ��������� ����        ���������
echo  ������ ������������ ���� �������� ���� ������� ��������� ���� ���� ��������� �
echo  � ���� ������������ ����� ������� ����� ������� ������� ����� ����� ���101����
echo  ������ ������������ ������ ������ ������ ������� ����� ������ ������ ������� �
echo  � ����         ���� ������� ����� ������� �������     ������� ������� ��������
echo  ���������������������������������������������������������������������������� �
echo  � �                                                                        ���
echo  ���    Security Is Compromised On FAT / FAT32 Drives Due To The Lack Of    � �
echo  � � Permissions. We Recommend To Format This Drive In NTFS To Fix This Bug ���
echo  ���   This Bug Isn't A Unfixed Problem, More Like A Un-Added Feature That  � �
echo  � �                         FAT Drives Don't Have                          ���
echo  ���                                                                        � �
echo  � ����������������������������������������������������������������������������
echo  ��� Would You Like To Hide This Error Next Time? Recommended Not To Ignore � �
echo �������������������������������������������������������������������������������
echo �1� No
echo �2� Yes
CHOICE /C 12 /N /M "�� "
IF ERRORLEVEL 2 goto NeverShowError101
IF ERRORLEVEL 1 goto :EOF
goto setpasswords

:NeverShowError101
cls
echo  ������������������������������������������������������������������������������
echo  � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �  �
echo  ���������������������������������������������������������������������������� �
echo  � ����         ����        ������        ��������     �������        ���������
echo  ������ ������������ ������� ����� ������� ������ ����� ������ ������� ������ �
echo  � ���� ������������ �������� ���� �������� ���� ������� ����� �������� �������
echo  ������ ������������ ������� ����� ������� ���� ��������� ���� ������� ������ �
echo  � ����         ����        ������        ����� ��������� ����        ���������
echo  ������ ������������ ���� �������� ���� ������� ��������� ���� ���� ��������� �
echo  � ���� ������������ ����� ������� ����� ������� ������� ����� ����� ���101����
echo  ������ ������������ ������ ������ ������ ������� ����� ������ ������ ������� �
echo  � ����         ���� ������� ����� ������� �������     ������� ������� ��������
echo  ���������������������������������������������������������������������������� �
echo  � � Would You Like To Hide This Error Next Time? Recommended Not To Ignore ���
echo �������������������������������������������������������������������������������
echo �������������������������������� Please Confirm �������������������������������
echo �1� No
echo �2� Yes
CHOICE /C 12 /N /M "�� "
IF ERRORLEVEL 2 goto NeverShowError101b
IF ERRORLEVEL 1 goto :EOF
goto setpasswords
:NeverShowError101b
call :setTime&echo ^|^|Log^|^|  ^|Info: Error 101 Hidden^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
set Hide_Bug_101=yes
call :OverwriteSettings
cls
goto :EOF

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
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto Insecure ^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
echo.
echo  ������������������������������������������������������������������������������
echo  � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �  �
echo  ���������������������������������������������������������������������������� �
echo  � ����         ����        ������        ��������     �������        ���������
echo  ������ ������������ ������� ����� ������� ������ ����� ������ ������� ������ �
echo  � ���� ������������ �������� ���� �������� ���� ������� ����� �������� �������
echo  ������ ������������ ������� ����� ������� ���� ��������� ���� ������� ������ �
echo  � ����         ����        ������        ����� ��������� ����        ���������
echo  ������ ������������ ���� �������� ���� ������� ��������� ���� ���� ��������� �
echo  � ���� ������������ ����� ������� ����� ������� ������� ����� ����� ���101����
echo  ������ ������������ ������ ������ ������ ������� ����� ������ ������ ������� �
echo  � ����         ���� ������� ����� ������� �������     ������� ������� ��������
echo  ���������������������������������������������������������������������������� �
echo  � �                                                                        ���
echo  ���    Security Is Compromised On FAT / FAT32 Drives Due To The Lack Of    � �
echo  � � Permissions. We Recommend To Format This Drive In NTFS To Fix This Bug ���
echo  ���   This Bug Isn't A Unfixed Problem, More Like A Un-Added Feature That  � �
echo  � �   FAT Drives Don't Have, DO NOT STORE ANY PERSONAL INFO IN ENCRYPTO    ���
echo  ���                   RECORD BECUASE IT IS *NOT SECURE*                    � �
echo  � ����������������������������������������������������������������������������
echo  ��� Would You Like To Hide This Error Next Time? Recommended Not To Ignore � �
echo �������������������������������������������������������������������������������
echo �1� No
echo �2� Yes (SD-Security Will Restart)
CHOICE /C 12 /N /M "�� "
IF ERRORLEVEL 2 goto NeverShowError101
IF ERRORLEVEL 1 goto BackToEncrypto
goto encrypto
:encrypto
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
%SetTheme%
cls
title Enter Password ^| Encrypto - SD-Security�
if exist "%Security_Breach_Key%" goto breach
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Encrypto                      %status%
echo �������������������������������������������������������������������������������
echo.
set "passwordA=%password%"
if not %Hide_Password%==yes (%set /p% password="Enter Password �� ") else (call :MaskPassword)
if %Hide_Bug_101%==yes goto backtoencrypto
for /f "tokens=5" %%a in ('@fsutil fsinfo volumeinfo %cd:~0,2%^|findstr /B "File System Name : "') do (@set DriveType=%%a)
if /i not "%DriveType%"=="NTFS" (set Bug_101_Vuln=yes&goto encryptoINSECURE)
:BackToEncrypto
if not "%password%"=="%passwordA%" goto :denied
call :ClearLockdown
if not exist "SDS_Files\Encrypto.SDS_Encrypted" goto make_encrypto
cls
%SetTheme%
:encryptoOptions
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto Options^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
if not exist "SDS_Files\Encrypto.SDS_Encrypted" goto make_encrypto
cls
%SetTheme%
call :CheckStatus No "goto :home"
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Encrypto                      %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  View Encrypto Record
echo �2�  Add More To Encrypto Record
echo �3�  Delete Encrypto Record / Start Over
echo �4�  Back
%set /p% EncryptoOp="�� "
if "%EncryptoOp%"=="1" goto ViewEncryptoRecord
if "%EncryptoOp%"=="2" goto EditEncrypto
if "%EncryptoOp%"=="3" goto DeleteEncrypto
if "%EncryptoOp%"=="4" goto home
color C4
echo Error: �%encryptoOp� Is Not A Valid Option!
pause >nul
goto encryptoOptions
:DeleteEncrypto
call :CheckStatus No "goto :home"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Encrypto                      %status%
echo �������������������������������������������������������������������������������
echo.
echo                  ARE YOU SURE YOU WANT TO DELETE ENCRYPTO RECORD
echo �1�  No
echo �2�  Yes
%set /p% DeleteEncrypto="�� "
if "%DeleteEncrypto%"=="2" goto deleteEncryptoVerified
goto EncryptoOptions
:deleteEncryptoVerified
call :CheckStatus No "goto :home"
cls
title Enter Password ^| Encrypto - SD-Security�
If Exist "%Security_Breach_Key%" goto breach
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Encrypto                      %status%
echo �������������������������������������������������������������������������������
echo.
echo Please Verify Password To Delete Encrypto Record:
%set /p% pass="Enter Password �� "
if not "%pass%"=="%password%" goto :denied
call :ClearLockdown
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto Record Deleted^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
if exist "SDS_Files\Encrypto.SDS_Encrypted" call :FilePer unlock "SDS_FILES\Encrypto.SDS_Encrypted"
if exist "SDS_Files\Encrypto.SDS_Encrypted" del SDS_Files\Encrypto.SDS_Encrypted
goto EncryptoOptions
:ViewEncryptoRecord
call :CheckStatus No "goto :home"
call :setTime&echo ^|^|Log^|^|  ^|Info: Encrypto Record Opened^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
call :FilePer unlock "SDS_FILES\Encrypto.SDS_Encrypted"
copy SDS_Files\Encrypto.SDS_Encrypted "SDS_Files\Encrypto_Tmp.txt"
call :FilePer lock "SDS_FILES\Encrypto.SDS_Encrypted"
start SDS_Files\Encrypto_Tmp.txt
set/a deletenum=10
:deleteloop2
call :CheckStatus No "goto :home"
title %deletenum% Seconds Until Temp. Encrypto File Deleted - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Encrypto                      %status%
echo �������������������������������������������������������������������������������
echo.
echo               %deletenum% Seconds Until Temp. Encrypto File Deleted
timeout 1 /nobreak >nul
set/a deletenum=%deletenum% -1
if %deletenum%==0 goto deletetmp
goto deleteloop2
:deletetmp
call :CheckStatus No "goto :home"
cls
del SDS_Files\Encrypto_Tmp.txt
if exist "SDS_Files\Encrypto_Tmp.txt" goto deleteloop3
goto home
:cantdeletetmp
call :CheckStatus No "goto :home"
:deletelogloop3
cls
call :CheckStatus No "goto :home"
title Can't Delete Temp. Encrypto File - SD-Security�
if exist "SDS_Files\Encrypto_Tmp.txt" del SDS_Files\Encrypto_Tmp.txt
if not exist "SDS_Files\Encrypto_Tmp.txt" goto home
echo          Can't Delete Temporary File, Please Close Log When Done
goto deletelogloop3
:make_encrypto
call :setTime&echo ^|^|Log^|^|  ^|Info: Make Encrypto Record^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
call :CheckStatus No "goto :home"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Encrypto                      %status%
echo �������������������������������������������������������������������������������
echo.
echo           You Haven't Yet Made A Encrypto Record, Please Do So Now
echo               Please Enter The Data For An Encrypto Record Here
echo       TIPS: You Can Have Multiple Lines, When Finished Exit The Window
echo              Don't Use Special Characters Such As ^& ^% ^| ^� ^"
echo     If You Want To Use Them Please Insert A ^^ Before Them eg. ^^^& ^^^%% etc.
echo                          When You Are Finished Exit The Window
echo                                 Press Any Key To Start
pause >nul
goto MakeEncryptoLoop
:EditEncrypto
call :setTime&echo ^|^|Log^|^|  ^|Info: Edit Encrypto Record^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
call :CheckStatus No "goto :home"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Encrypto                      %status%
echo �������������������������������������������������������������������������������
echo.
echo               You Are About To Edit Encrypto Record Please Read:
echo           You Can Have Multiple Lines, When Finished Exit The Window
echo              Don't Use Special Characters Such As ^& ^% ^| ^� ^"
echo     If You Want To Use Them Please Insert A ^^ Before Them eg. ^^^& ^^^%% etc.
echo                          When You Are Finished Exit The Window
echo                             Press Any Key To Start Editing
pause >nul
:MakeEncryptoLoop
call :CheckStatus No "goto :home"
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" call :FilePer unlock "SDS_FILES\Encrypto.SDS_Encrypted"
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" copy SDS_Files\Encrypto.SDS_Encrypted "SDS_Files\EncryptoTMP.SDS_Encrypted" >nul
if exist "SDS_Files\Encrypto.SDS_Encrypted" call :FilePer lock "SDS_FILES\Encrypto.SDS_Encrypted"
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" type SDS_Files\EncryptoTMP.SDS_Encrypted
if exist "SDS_Files\Encrypto.SDS_Encrypted" del SDS_Files\EncryptoTMP.SDS_Encrypted
%set /p% Encrypto_Data=" "
if exist "SDS_Files\Encrypto.SDS_Encrypted" call :FilePer unlock "SDS_FILES\Encrypto.SDS_Encrypted"
echo %Encrypto_Data% >> "SDS_Files\Encrypto.SDS_Encrypted"
if exist "SDS_Files\Encrypto.SDS_Encrypted" call :FilePer lock "SDS_FILES\Encrypto.SDS_Encrypted"
goto MakeEncryptoLoop

:Safe_Mode
color 87
mode con: cols=80 lines=15
title Safemode - SD-Security�
call :setTime
if exist "SDS_Files\Security\SD-Security.SDS_LOG" echo.>> "SDS_Files\Security\SD-Security.SDS_LOG"
if exist "SDS_Files\Security\SD-Security.SDS_LOG" echo ^|^|Safemode^|^| ^|^|Version %SDS_Version%^|^|  ^|Time: %twelve%^| ^|Date: %date2%^| ^|OS: %WinVersion%^| ^|Serial: %serial%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
if exist "SafeMode.*" del SafeMode.*
:sfmd
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security SAFEMODE ���            Options                        Disabled
echo �������������������������������������������������������������������������������
echo �������������������������������������������������������������������������������
echo � All The Features Of SD-Security Are Disabled While In Safemode, Choose 6 To �
echo ������������������������  Reboot Into The Normal Mode  ������������������������
echo �������������������������������������������������������������������������������
echo ���
echo �1�  Troubleshoot SD-Security
echo �2�  Uninstall SD-Security
echo �3�  Reset SD-Security
echo �4�  Reset Saved Sessions ^& Auto Save-Session Setting
echo �5�  Uninstall A Plugin(s)
echo �6�  Reboot
%set /p% SafeModeOp="�� "
if "%SafeModeOp%"=="1" goto trblesht
if "%SafeModeOp%"=="2" goto uninstl
if "%SafeModeOp%"=="3" goto ResetSDSecurity
if "%SafeModeOp%"=="4" goto sfmdResetSessions
if "%SafeModeOp%"=="5" goto sfmdUninstallPlugin
if "%SafeModeOp%"=="6" goto StartOfScript
echo INVALID CHOICE!
pause >nul
goto sfmd
:sfmdResetSessions
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security SAFEMODE ���              Task Completed               Disabled
echo �������������������������������������������������������������������������������
echo �������������������������������������������������������������������������������
echo �������� All The Features Of SD-Security Are Disabled While In Safemode �������
echo �������������������������������������������������������������������������������
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
echo �������������������������������������������������������������������������������
echo ��� SD-Security SAFEMODE ���              Task Completed               Disabled
echo �������������������������������������������������������������������������������
echo �������������������������������������������������������������������������������
echo �������� All The Features Of SD-Security Are Disabled While In Safemode �������
echo �������������������������������������������������������������������������������
echo.
echo              Task Completed, Press Any Key To Exit SD-Security
pause >nul
endlocal
exit 999
:sfmdUninstallPlugin
mode con: cols=80 lines=30
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security SAFEMODE ���              Task Completed               Disabled
echo �������������������������������������������������������������������������������
echo �������������������������������������������������������������������������������
echo �������� All The Features Of SD-Security Are Disabled While In Safemode �������
echo �������������������������������������������������������������������������������
echo.
echo              Enter The Name Of The App You Want To Uninstall:
for /f %%a in ('dir /O:-D /B /A:D SDS_Files\Plugins') do (echo � %%a)
if "%customApp%"=="none" echo No Apps Installed, Press Any Key To Exit&pause >nul&exit 999
set /p UninstallApp="�� "
if not exist "SDS_Files\Plugins\%UninstallApp%" echo App Not Installed!&timeout 2 >nul&goto :sfmdUninstallPlugin
rd /s SDS_Files\Plugins\%UninstallApp%
goto :sfmdUninstallPlugin
:NoCustomApps
cls
title Custom Apps - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  Custom Apps                     %status%
echo �������������������������������������������������������������������������������
echo.
echo                      No Custom Apps Have Been Installed Yet!
echo                            Press Any Key To Go Home
pause >nul
goto :home
:trblesht
title Troubleshooting - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security SAFEMODE ���             Troubleshooting               Disabled
echo �������������������������������������������������������������������������������
echo �������������������������������������������������������������������������������
echo �������� All The Features Of SD-Security Are Disabled While In Safemode �������
echo �������������������������������������������������������������������������������
echo.
echo                              Troubleshooting...
echo                         Troubleshooting Autorun.inf...
if exist "autorun.inf" call :FilePer unlock "autorun.inf"
del autorun.inf >nul 2>&1
echo                         Troubleshooting Favicon.ico...
if exist "favicon.ico" call :FilePer unlock "favicon.ico"
del favicon.ico >nul 2>&1
echo                        Troubleshooting Saved Sessions...
del SDS_Files\Sessions\*.SDS_Session >nul 2>&1
echo.
echo                            Press Any Key To Continue
:trbNext
timeout 5 >nul /nobreak
cls
mode con: cols=80 lines=21
echo �������������������������������������������������������������������������������
echo ��� SD-Security SAFEMODE ���             Troubleshooting               Disabled
echo �������������������������������������������������������������������������������
echo �������������������������������������������������������������������������������
echo �������� All The Features Of SD-Security Are Disabled While In Safemode �������
echo �������������������������������������������������������������������������������
echo.
echo                             Troubleshooting Completed
echo                                     Results:
echo         Problem Info          ---                        Status
echo �������������������������������������������������������������������������������
echo Favicon.ico Issue              : Good (File Reset)
echo Autorun.inf Issue              : Good (File Reset)
echo Saved Sessions                 : Good (All Sessions Cleared)
if exist "SDS_FILES\Sessions\Disable*" (set trbsht2=Good ^(File Exists, No Action^)) else (set trbsht2=Good ^(No Action^))
if exist "SDS_FILES\Sessions\Default*" (set trbsht3=Neutral ^(File Exists, Could Cause SD-Security To Crash^)) else (set trbsht3=Good ^(No Action^))
echo Disable Auto-Restore File      : %trbsht2%
echo Always Save Sessions File      : %trbsht3%
echo SD-Security Compatibility Issue: Good (No Action)
echo � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �
echo         If Issues Still Persist, Reboot SD-Security Into Safe Mode And
echo                         Reset SD-Security's Preferences
echo � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �
echo �����If It Still Does Not Work Then Uninstall And Then Install SD-Security�����
pause >nul
goto sfmd2
:ResetSDSecurity
cls
if exist "SDS_Files\SD-Settings.ini" call :FilePer unlock "SDS_FILES\SD-Settings.ini"
if exist "SDS_Files\SD-Settings.ini" del SDS_FILES\SD-Settings.ini
goto sfmd2
:uninstl
echo Are You Sure You Want To Uninstall SD-Security?
echo Enter 1234 To Uninstall SD-Security Or Enter Anything Else To Go Back
%set /p% sfmd3="�� "
if "%sfmd3%"=="1234" goto uninstl2
goto sfmd
:uninstl2
if exist "autorun.inf" attrib -h -s -r -a "autorun.inf"&del autorun.inf
if exist "favicon.ico" attrib -h -s -r -a "favicon.ico"&del favicon.ico
if exist "SDS_Files\" attrib -h -s -r -a "SDS_Files"&rd /S /Q SDS_Files
:uninfinsh
cls
title Uninstall Finished - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Uninstall Finished                  Signed Out
echo �������������������������������������������������������������������������������
echo.
echo                              Uninstall Finished
echo �������������������������������������������������������������������������������
echo                 SD-Security's Files Were Removed Successfully
echo                 The Only Remaining File Is The SD-Security %sds_extension%
echo                      Starting SD-Security EXE Uninstaller...
timeout 3 /nobreak >nul
call start "Uninstalling SD-Security " cmd /c "color f0&title SD-Security EXE Uninstaller&mode con: cols=90 lines=25&echo -----------------------------===============================-----------------------------&echo -----------------------------= SD-Security EXE Uninstaller =-----------------------------&echo -----------------------------===============================-----------------------------&echo.&echo                                   Deleting SD-Security.*&del /f /p %SDS_File%&echo       Finished Uninstalling SD-Security, SD-Security Is Now Uninstalled&echo                                   Press Any Key To Exit&pause >Nul&start call SD-Secrity.exe&exit 999"exit 999
goto end
:HotspotHome
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-Hotspot^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
%SetTheme%
title SD-Hotspot - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 SD-Hotspot                       %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  Enable Hotspot
echo �2�  Disable Hotspot
echo �3�  Configure Hotspot
echo �4�  Back
echo.
%set /p% wifiadhoc="�� "
if "%wifiadhoc%"=="1" goto enableHot
if "%wifiadhoc%"=="2" goto disableHot
if "%wifiadhoc%"=="3" goto apsettings
goto :SDsoftware
:enableHot
echo                   Enabling Network (Waiting For AdminCMD API)
call :AdminCMD run "netsh wlan start hostednetwork"
echo.
echo                                 Network Enabled
timeout 2 >nul
goto :HotspotHome
:disableHot
netsh wlan stop hostednetwork
echo                                Network Disabled
timeout 2 >nul
goto :HotspotHome
:apsettings
set password=
call :setTime&echo ^|^|Log^|^|  ^|Info: Setting Up SD-Hotspot^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title Choose A SSID - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 SD-Hotspot                       %status%
echo �������������������������������������������������������������������������������
echo.
Echo                            Choose A SSID (Network Name)
%set /p% apname="�� "
if "%apname%"=="" goto error1Hot
:backtothereHot
set password=
title Choose A Password - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 SD-Hotspot                       %status%
echo �������������������������������������������������������������������������������
echo.
Echo                                Choose A Password
%set /p% appassword="�� "
if "%appassword%"=="" goto error2Hot
cls
:confirmingHot
cls
set password=
title Please Confirm - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 SD-Hotspot                       %status%
echo �������������������������������������������������������������������������������
echo.
echo Network Name     �� %apname%
echo Network Password �� %appassword%
echo.
echo �1�  Confirm
echo �2�  Choose Different Details
echo �3�  Cancel
%set /p% confirmHotspot="�� "
if "%confirmHotspot%"=="1" goto enableHot2
if "%confirmHotspot%"=="2" goto apsettings
if "%confirmHotspot%"=="3" goto :HotspotHome
goto enableHot2
:enableHot2
title Starting SD-Network - SD-Security�
call :AdminCMD run "netsh wlan set hostednetwork mode=allow ssid=%apname% key=%appassword%&netsh wlan start hostednetwork"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 SD-Hotspot                       %status%
echo �������������������������������������������������������������������������������
echo.
echo                         Network Configured Successfully
echo.
echo ��������������������
echo � Connection  Info �
echo ��������������������
echo � Network Name     �� %apname%
echo � Network Password �� %appassword%
echo �������������������������������������������������������������������������������
echo                     How To Connect To The Network On Your Device
echo �������������������������������������������������������������������������������
echo 1. On Your Device, Open Settings And Select WiFi
echo 2. Turn The WiFi On If It Isn't On Already Switched On
echo 3. Tap On �%apname%�, Then Enter �%appassword%� In The Password Field
echo 4. Wait For It To Connect
echo 5. If It Takes More Than A Minute To Connect To The Network, Then Maybe Your
echo    Device Doesn't Support Connecting To AD-Hoc Networks
echo.
echo                            Press Any Key To Go Home
pause >nul
goto home
:error1Hot
Echo Please Enter A Name For Your Network
pause >nul
goto apsettings
:error2Hot
echo You Have To Enter A Password, Due To This Being A �Security� Program!
pause >nul
goto backtothereHot
:SDSecurChecker
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title SD-SecurChecker - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  SD-SecurChecker                 %status%
echo �������������������������������������������������������������������������������
echo.
echo Welcome To SD-SecurChecker, A Tool That Allows You To Test The Security Of Your
echo   Antivirus (Using The Eicar Test) By Making A EXE File With Some Text In It
echo   (This Test Is 100% Safe, The Reason Why It Makes An EXE File Is So Your
echo               Antivirus Scans The File For The Eicar Test Code)
echo.
echo                Would You Like To Check Your Antivirus' Strength?
echo �1�  Yes (In This Directory)
echo �2�  Yes (On The Desktop)
echo �3�  No
%set /p% checkAntivirus="�� "
if "%checkAntivirus%"=="1" goto TestAnti1
if "%checkAntivirus%"=="2" goto TestAnti2
if "%checkAntivirus%"=="3" goto home
goto other
:TestAnti2
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Test Desktop^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
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
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Test Current Directory^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
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
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Testing Security^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
:testinganti2
set /a testTimeRemaining=200-%testTime%
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  SD-SecurChecker                 %status%
echo �������������������������������������������������������������������������������
echo.
echo                                 Testing Security...
echo                   %testTimeRemaining% Seconds Remaining Until Test Is A Fail
if not exist "%testAntiFileLoc%" set antiResult=Passed&goto antiVirusFinished
timeout 1 >nul /nobreak
set /a testTime=%testTime% +1
if %testTime%==200 set antiResult=Failed&goto antiVirusFinished
goto testinganti2
:antiVirusFinished
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Result: %antiResult% ; Time: %testtime% Seconds ^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  SD-SecurChecker                 %status%
echo �������������������������������������������������������������������������������
echo.
echo                                    Result ��
echo.
echo Status Of Test �� %antiResult%
echo Time It Took   �� %testtime% Seconds
pause >nul
goto home
:AntiTestCannot
call :setTime&echo ^|^|Log^|^|  ^|Info: SD-SecureChecker Access Denied^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  SD-SecurChecker                 %status%
echo �������������������������������������������������������������������������������
echo.
echo Cannot Write File In Choosen Directory ��
echo %testAntiFileLoc%
echo.
echo  Try Running SD-Security As A Administrator, If It Still Shows This Error Then
echo            You Might Have To Change Permissions Of The Folder
pause >nul
goto home
:MaskPassword
set "password="
echo tmp> "%temp%\tmp.tmp"
pushd %temp%
if "%~1"=="" (set "MskPswrdTxt=Enter Password �� ") else (set "MskPswrdTxt=%~1")
set/p "=%MskPswrdTxt%"<nul
call :MaskPassword2
popd
goto :EOF
:MaskPassword2
SetLocal EnableExtensions EnableDelayedExpansion
for /F "skip=1 eol=" %%a in ('"echo.|Replace "tmp.tmp" . /U /W"') do (set "CR=%%a")
for /F %%a in ('"Prompt $H &For %%_ In (_) Do Rem"') do (set "BS=%%a")
set "pass="
:MaskPassword2b
set "CHR="&for /f "skip=1 delims= eol=" %%a in ('replace "%~f0" . /U /W') do (set "CHR=%%a")
if !CHR!==!CR! echo.&endlocal&set "password=%password%"&goto :EOF
if !CHR!==!BS! (if defined password (set/p "=!BS! !BS!"<nul&set "password=!password:~0,-1!")) else (set/p =�<nul&if !CHR!==! (set "password=!password!^!") else set "password=!password!!CHR!")
goto :MaskPassword2b
:APO
cls
title A.P.O - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Advanced Power Options               %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  Basic Timer
echo �2�  Advanced Timer
echo �3�  Cancel Shutdown
echo �4�  Back
%set /p% powerOptions="�� "
if "%powerOptions%"=="1" set APOvar1=basicTimer&goto Timer
if "%powerOptions%"=="2" set APOvar1=advancedTimer&goto Timer
if "%powerOptions%"=="3" shutdown -a&goto home
if "%powerOptions%"=="4" goto other
goto APO
:Timer
cls
title What Do You Want The PC To Do? - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Advanced Power Options               %status%
echo �������������������������������������������������������������������������������
echo.
echo                             What Do You Want The PC To Do?
echo �1�  Shutdown
if %APOvar1%==advancedTimer goto TimerAdvancedDisablesIt
echo �2�  Hibernate
echo �3�  Cancel
%set /p% APOvar2="�� "
if "%apovar2%"=="1" set timerCommand=/s&set timerCommand2=Shutdown&goto timerTime
if "%apovar2%"=="2" set timerCommand=/h&set timerCommand2=Hibernate&goto timerTime
goto APO
:TimerAdvancedDisablesIt
echo ���  HIBERNATE (Option Disabled, Select Cancel And Use Basic Timer Instead)
echo �3�  Cancel
%set /p% APOvar2="�� "
if "%apovar2%"=="1" set timerCommand=/s&set timerCommand2=Shutdown&goto timerTime
goto APO
:timerTime
cls
title How Long To Wait? - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Advanced Power Options               %status%
echo �������������������������������������������������������������������������������
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
%set /p% timerSec="�� "
goto confirmTimer
:confirmTimer
cls
title Confirm - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Advanced Power Options               %status%
echo �������������������������������������������������������������������������������
echo.
echo       Are You Sure You Want To Schedule A %timerCommand2% Command To This PC?
echo.
echo �1�  Confirm
echo �2�  Cancel
%set /p% confirm="�� "
if "%confirm%"=="1" goto startTimer
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
title %timerCommand2% Active - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 Shutdown Active                  %status%
echo �������������������������������������������������������������������������������
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
call :setTime&echo ^|^|Log^|^|  ^|Info: Command Switch Entered^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
%SetTheme%
:: DONT FORGET TO ADD TO :commandSwitchViewAll
set "CheckParam=if /i "%1" =="
%CheckParam% "/help" goto commandSwitchHelp
%CheckParam% "help" goto commandSwitchHelp
%CheckParam% "/?" goto commandSwitchHelp
%CheckParam% "?" goto commandSwitchHelp
%CheckParam% "Verify" call :Verify "%~2" "%~3"&goto :EOF
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
call :setTime&echo ^|^|Log^|^|  ^|Error: Command Switch '%1'^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Command Switch Error - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Command Switch Error                 %status%
echo �������������������������������������������������������������������������������
echo.
echo          The Switch You Used (�%1�) Is Not A Valid SD-Security Switch
echo        Would You Like To View All The Switches Available For SD-Security?
echo �1�  Yes
echo �2�  No (Return Home)
%set /p% viewCommandHelp="�� "
if "%viewcommandhelp%"=="1" goto commandSwitchViewAll
goto :EOF
:commandSwitchHelp
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Info: Command Switch Help^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Command Switch Help - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���              Command Switch Help                 %status%
echo �������������������������������������������������������������������������������
echo.
echo     As Well As The Full User Interface SD-Security Has Command Line Switches
echo             To Use A Switch:
echo.
echo METHOD 1: Create A Shortcut
echo  1. Right Click In Explorer
echo  2. New ^> Shortcut
echo  3. Type In The Location Of SD-Security (Hold Shift, Right Click On The
echo     SD-Security %sds_extension% Then Click On �Copy As Path�) Then With A Switch On The End
echo.
echo METHOD 2: Command Line
echo  1. Hold Shift And Right Click In The Folder Of SD-Security
echo  2. Select �Open Command Window Here�
echo  3. A Command Window Should Appear, Type �SD-Security� And Then A Space
echo     Followed With A Switch
echo  4. Press Enter (It Should Boot Into SD-Security)
echo.
echo                  Press Any Key To View All The Available Switches
pause >nul
goto commandSwitchViewAll
:commandSwitchViewAll
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Info: Command Switches^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Command Switches - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Command Switches                  %status%
echo �������������������������������������������������������������������������������
echo.
echo                      List Of All Available Command Switches:
echo �  /help             ^| Displays SD-Security's Command Switch Help
echo �  /safemode         ^| Boots SD-Security Into SafeMode
echo �  /hotspot          ^| Displays The Hotspot Screen
echo �  /signin           ^| Displays The Sign In Screen
echo �  /about            ^| Displays The About Screen
echo �  /other            ^| Displays The Other Screen
echo �  /apo              ^| Displays The Advanced Power Options Screen
echo �  /commands         ^| Displays The Commands Screen
echo �  /SD-SecurChecker  ^| Displays The SD-SecurChecker Screen
echo �  /exit             ^| Exits SD-Security (This Works Well As A Logger)
echo.
echo                      Press Any Key To See The Alternative Words
pause >nul
cls
title Command Switches - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Command Switches                  %status%
echo �������������������������������������������������������������������������������
echo.
echo                      List Of All Available Command Switches:
echo �  /?                ^| Displays SD-Security's Command Switch Help
echo �  ?                 ^| Displays SD-Security's Command Switch Help
echo �  help              ^| Displays SD-Security's Command Switch Help
echo �  /login            ^| Displays The Sign In Screen
echo �  /power            ^| Displays The Advanced Power Options Screen
echo �  /SD-Network       ^| Displays The Hotspot Screen
echo �  /SD-Hotspot       ^| Displays The Hotspot Screen
echo �  /SD-Commands      ^| Displays The Commands Screen
echo �  /cmd              ^| Displays The Commands Screen
echo �  /SD-SecureChecker ^| Displays The SD-SecurChecker Screen
echo �  /SDSecureChecker  ^| Displays The SD-SecurChecker Screen
echo �  /SDSecurChecker   ^| Displays The SD-SecurChecker Screen
echo �  /quit             ^| Exits SD-Security (This Works Well As A Logger)
echo �  /end              ^| Exits SD-Security (This Works Well As A Logger)
echo                                 Press Any Key To Go Home
pause >nul
goto :EOF
:statistics
if exist "SDS_Files\SD-Statistics.ini" (for /F "eol=# delims=" %%A in (SDS_FILES\SD-Statistics.ini) do set "%%A">nul 2>&1) else (set times_opened=-1)
set /a times_opened2=%times_opened%+1 >nul
call :setTime
(echo last_computer=%computername%
echo last_username=%username%
echo last_time=%twelve%
echo last_time_twenty_four=%twentyfour%
echo last_date=%date2%
echo last_date_full=%fulldate%
echo last_opened=%day% %daydig%%daySuffix% %month% %year%
echo times_opened=%times_opened2%)> "SDS_Files\SD-Statistics.ini"
goto :EOF
:: Time API
:setTime
for /f "tokens=1-2 delims=:." %%a in ('time /t') do set hourTwentyFour=%%a&set Minutes=%%b
set TwentyFour=%hourTwentyFour%:%minutes%
if "%hourTwentyFour%"=="00" set hour=12&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="01" set hour=1&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="02" set hour=2&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="03" set hour=3&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="04" set hour=4&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="05" set hour=5&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="06" set hour=6&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="07" set hour=7&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="08" set hour=8&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="09" set hour=9&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="10" set hour=10&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="11" set hour=11&set hourtype=AM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="12" set hour=12&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="13" set hour=1&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="14" set hour=2&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="15" set hour=3&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="16" set hour=4&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="17" set hour=5&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="18" set hour=6&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="19" set hour=7&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="20" set hour=8&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="21" set hour=9&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="22" set hour=10&set hourtype=PM&goto SetTwelveHourTime
if "%hourTwentyFour%"=="23" set hour=11&set hourtype=PM&goto SetTwelveHourTime
:SetTwelveHourTime
set Twelve=%hour%:%minutes%%hourtype%
:SetDays
set abbOfDay=%date:~0,3%
for /f "tokens=2-3 delims=/ " %%a in ('date /t') do set daydig=%%a&set MonthDig=%%b&set year=%currentYear:~0,2%%date:~-2%
if "%daydig:~0,1%"=="0" set daydig=%daydig:~1,1%
if "%MonthDig:~0,1%"=="0" set MonthDig=%MonthDig:~1,1%
if "%daydig%"=="1" set daySuffix=st&goto SetDayNames
if "%daydig%"=="2" set daySuffix=nd&goto SetDayNames
if "%daydig%"=="3" set daySuffix=rd&goto SetDayNames
set daySuffix=th
:SetDayNames
if "%abbOfDay%"=="Mon" set day=Monday&goto SetMonthNames
if "%abbOfDay%"=="Tue" set day=Tuesday&goto SetMonthNames
if "%abbOfDay%"=="Wed" set day=Wednesday&goto SetMonthNames
if "%abbOfDay%"=="Thu" set day=Thursday&goto SetMonthNames
if "%abbOfDay%"=="Fri" set day=Friday&goto SetMonthNames
if "%abbOfDay%"=="Sat" set day=Saturday&goto SetMonthNames
if "%abbOfDay%"=="Sun" set day=Sunday&goto SetMonthNames
:SetMonthNames
if "%MonthDig%"=="1" set month=January&goto SetTimeFinished
if "%MonthDig%"=="2" set month=February&goto SetTimeFinished
if "%MonthDig%"=="3" set month=March&goto SetTimeFinished
if "%MonthDig%"=="4" set month=April&goto SetTimeFinished
if "%MonthDig%"=="5" set month=May&goto SetTimeFinished
if "%MonthDig%"=="6" set month=June&goto SetTimeFinished
if "%MonthDig%"=="7" set month=July&goto SetTimeFinished
if "%MonthDig%"=="8" set month=August&goto SetTimeFinished
if "%MonthDig%"=="9" set month=September&goto SetTimeFinished
if "%MonthDig%"=="10" set month=October&goto SetTimeFinished
if "%MonthDig%"=="11" set month=November&goto SetTimeFinished
if "%MonthDig%"=="12" set month=December&goto SetTimeFinished
:SetTimeFinished
set fulldate=%date:~4%
set date2=%daydig%/%monthDig%/%year%
goto :EOF
:showStatistics
cls
title Statistics - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                   Statistics                     %status%
echo �������������������������������������������������������������������������������
echo.
echo     Every Time SD-Security Is Opened It Logs Some Information Of The User,
echo                      This Is The Information It Logged Last Time:
echo.
echo �������������������������������������������������������������������������������
echo � Opened On          �� %last_time% %last_opened%
echo � Opened On          �� %last_date%
echo � Last Computer      �� %last_computer%
echo � Last Username      �� %last_username%
echo � Total Times Opened �� %times_opened%
echo �������������������������������������������������������������������������������
echo.
echo                            Press Any Key To Go Home
pause >nul
goto home
:getTheme
:: This Is The Theme Code For SD-Security
if "%theme%"=="" set SetTheme=color F0&goto :EOF
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
if %theme%==white_black set themeColor=f0
set SetTheme=color %themecolor%
goto :EOF
:checkUpdateSettings
set numberOfErrors=0
if "%theme%"=="" set theme1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%dev_mode%"=="" set dev_mode1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%used_before%"=="" set used_before1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%trial_mode%"=="" set trial_mode1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%bug_101_vuln%"=="" set bug_101_vuln1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%hide_bug_101%"=="" set hide_bug_1011=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%security_breach_key%"=="" set security_breach_key1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%Hide_password%"=="" set hide_password1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if "%New_AdminCMD_API%"=="" set New_AdminCMD_API1=no&set /a numberOfErrors=%numberOfErrors% +1 >nul
if not "%numberOfErrors%"=="0" goto SettingsFileError2
goto :EOF

:SettingsFileError2
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Error: Settings File Error^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
color f0
cls
title Settings File Error - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���              Settings File Error                 %status%
echo �������������������������������������������������������������������������������
echo.
call :color fc "         SD-Security's Settings File (SD-Settings.ini) Is Out Of Date!"
echo.
echo �������������������������������������������������������������������������������
echo.
echo     There Is A Error With The Settings File For SD-Security SD-Settings.ini
echo.
echo  This Could Be Because You Updated SD-Security, It's Been Edited Incorrectly
echo       Or SD-Security Detected An Attempt To Override The Security System
echo.
echo ��� To Fix This, You Would Have To Reset Them, If You Want To Use SD-Security
echo �1�  Reset Them (Recommended)
echo �2�  Cancel ^& Exit SD-Security
%set /p% resetSettings="�� "
if "%resetsettings%"=="1" goto ResetSDSecurity
goto end
:SettingsFileError
call :SetWindow
call :setTime&echo ^|^|Log^|^|  ^|Error: Settings File Error (Access Denied)^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
color f0
cls
title Settings File Error - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���              Settings File Error                 %status%
echo �������������������������������������������������������������������������������
echo.
call :color fc "           You Don't Have Permission To Access SD-Security's Settings!"
echo.
echo �������������������������������������������������������������������������������
echo.
echo     There Is A Error With The Settings File For SD-Security SD-Settings.ini
echo.
echo ��� To Fix This, You Would Have To Reset The Settings, If You Want To Use SDS
echo �1�  Reset Them
echo �2�  Cancel ^& Exit SD-Security (Recommended)
%set /p% resetSettings="�� "
if "%resetsettings%"=="1" goto ResetSDSecurity
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
if "%waitfor%"=="0" set waitfor=1
:waitLoop
set /a waitnum=%waitnum% +1>nul
if %waitnum%==%waitFor% goto :EOF
goto waitLoop
:installInfo
%SetTheme%
call :setTime&echo ^|^|Log^|^|  ^|Info: Installation Information^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���             Installation Information             %status%
echo �������������������������������������������������������������������������������
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
echo Times Opened        : %times_opened% ^| Startup Time: %TimerTime% Seconds
echo SD-Security Version : SD-Security V.%sds_version%
echo SDS Build Type      : %Version_Type%
echo Installation Folder : %cd%
echo.
echo ���  Would You Like To Save This To A File?
echo �1�  Yes
echo �2�  No
%set /p% saveTofile="�� "
if "%savetofile%"=="1" goto SaveInfoToFile
goto home
:SaveInfoToFile
echo General Information > "Installation Information.txt"
echo. >> "Installation Information.txt"
echo Operating System : %winVersion% >> "Installation Information.txt"
echo Drive Serial : %serial% >> "Installation Information.txt"
echo Current PC Name : %computername% >> "Installation Information.txt"
echo Current Username : %username% >> "Installation Information.txt"
call:settime&echo ^|^|Log^|^|  ^|Info: Saved Installation Information^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
echo Current Date ^& Time : %twelve% %day% %daydig%%daySuffix% %month% %year% >> "Installation Information.txt"
echo. >> "Installation Information.txt"
echo SD-Security Information >> "Installation Information.txt"
echo. >> "Installation Information.txt"
echo Times Opened : %times_opened% ^| Startup Time: %TimerTime% Seconds>> "Installation Information.txt"
echo SD-Security Version : SD-Security V.%sds_version%>> "Installation Information.txt"
echo SDS Build Type : %Version_Type%>> "Installation Information.txt"
echo Installation Folder : %cd% >> "Installation Information.txt"
goto home
:updated
%SetTheme%
call :SetWindow
if "%Old_SDS_Version%" GTR "%SDS_Version%" goto Downgraded
call :settime&echo ^|^|Log^|^|  ^|Info: SD-Security Updated^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Update Successful - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Update Successful                  %status%
echo �������������������������������������������������������������������������������
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
call :settime&echo ^|^|Log^|^|  ^|Info: SD-Security Downgraded^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Downgrade Successful - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Update Successful                  %status%
echo �������������������������������������������������������������������������������
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
(echo Old_SDS_Version=%SDS_Version%
echo Old_Version_Type=%Version_Type%)> "SDS_Files\Version_No.ini"
goto :EOF
:SetWindow
mode con: cols=80 lines=27
goto :EOF
:Color
if not exist "C:\windows\system32\findstr.exe" %echo% %~2&goto :EOF
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd %temp%
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
popd
goto :EOF
:GUI
set "sGUIinput="
set SdGuiText=%~1
if "%SdGuiText%"=="" set SdGuiText=Please Enter The Password:
set SdGuiTitle=%~2
if "%SdGuiTitle%"=="" set SdGuiTitle=Enter Password - SD-Security�
echo Wscript.echo inputbox(WScript.Arguments(0),WScript.Arguments(1)) >"%temp%\SD-GUI.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\SD-GUI.vbs" "%SdGuiText%" "%SdGuiTitle%"') do set GUIinput=%%a
exit /b
:NoPermissions
call :setWindow
cls
color f0
title Error: No Permissions - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 No Permissions                   %status%
echo �������������������������������������������������������������������������������
echo.
call :color fc "      SD-Security Has No Permissions To Write To The SDS_Files Folder!"
echo.
echo �������������������������������������������������������������������������������
echo.
echo    SD-Security Can't Write To The SDS_Files Folder Because Of The Lack Of
echo    Permissions And SD-Security Has To Be Able To Write+Read To This Folder
echo  To Log Information About SD-Security's Use And To Write To The Statistics File
echo  You Can Continue To Use SD-Security If You Want It In Read-Only Mode But You
echo          Will Be Limited In What You Can Do And SDS Could Crash!
echo.
echo  To Fix This, Try Launching SD-Security With Admin Permissions. If That Doesn't
echo    Fix It, Then You Should Try Editing The Permissions Of The SDS_Files Folder
echo.
echo �1�  Continue (If You Believe This Is An Error)
echo �2�  Launch As Administrator
echo �3�  Change Permissions (Requires Admin Permissions)
echo �4�  Exit SD-Security (Recommended)
%set /p% NoPermissions="�� "
if "%NoPermissions%"=="1" call :loadingScreen&goto :EOF
if "%NoPermissions%"=="2" goto startAdmin
if "%NoPermissions%"=="3" goto ChangePerSDSFILES
goto end
:ChangePerSDSFILES
cls
title Change Permissions - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���              Change Permissions                  %status%
echo �������������������������������������������������������������������������������
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
net file >nul 2>&1
if '%errorlevel%' == '0' ( goto home ) else ( goto getAdmin )
:getAdmin
title Requesting Admin Permissions - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Admin Permissions                  %status%
echo �������������������������������������������������������������������������������
echo.
echo.
echo             �������������������������������������������������������
echo             � A d m i n   P e r m i s s i o n s   R e q u i r e d �
echo             �������������������������������������������������������
echo.
echo,
echo       Admin Permissions Are Required To Perform The Action You Requested.
echo       When The User Account Control (UAC) Window Appears, Click On �Yes�.
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
if "%NoLength2%"=="%NoLength%" cls&goto :EOF
goto RandomoLoop
:setRandomoNo
set randomo3=%random:~-1,1%
if "%randomo3%"=="8" set randomoNo=%time:~-1,1%&set Randomo2=%Randomo2%%randomoNo%&goto :EOF
if "%randomo3%"=="9" set randomoNo=%time:~-1,1%&set Randomo2=%Randomo2%%randomoNo%&goto :EOF
if "%randomo3%"=="1" set randomoNo=%time:~-2,1%&set Randomo2=%Randomo2%%randomoNo%&goto :EOF
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
@echo �������������������  �������������������������������������  �������������������
@echo � � � � � � � � � ���� SD-Security Crashed! Due To Above ���� � � � � � � � � �
@echo �������������������  �������������������������������������  �������������������
@call :Notify "SD-Security Has Just Crashed, Please Report This Crash To SD-Security" "SD-Security Crashed!"
@pause >nul
color F0
set "echo=<nul set /p ="
cls
call :SetWindow
title Crash Handler - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Crash Handler
echo �������������������������������������������������������������������������������
echo.
echo                         ���������������������������������
call :color FF "''''''''''''''''''''''''"&%echo% �&call :color FC " SD-Security Has Just Crashed!"&call :color ff "b"&%echo% �&echo.
echo                         ���������������������������������
echo.
echo     SD-Security Has Just Crashed, This Could Be Because You Entered Special
echo         Characters Into SD-Security, Such As: "& | / \ @ # " ^~ ^< ^> ^( ^)"
echo     Or Because Of A Bug In The Software. If You Believe That It Was A Bug,
echo    Then You Should Report The Bug To The Developers, So That We Can Fix It.
echo.
echo                Would You Like To Send A Email To The Developers?
echo.
if "%FakeCrash%"=="yes" goto ReportCrashFake
echo �1�  Yes (Internet Connection ^& Email Account Required)
echo �2�  Yes ^& Reboot SDS
echo �3�  Reboot To Safemode (To Reset Cache/Bad Preferences)
echo �4�  No ^& Reboot SDS
echo �5�  No
echo.
%set /p% sendCrashEmail="�� "
if "%sendCrashEmail%"=="1" "set crashCommand=rem"&goto sendEmail
if "%sendCrashEmail%"=="2" "set crashCommand=endlocal&goto :StartOfScript"&goto sendEmail
if "%sendCrashEmail%"=="3" goto Safe_Mode
if "%sendCrashEmail%"=="4" endlocal&goto :StartOfScript
goto quickend
:ReportCrashFake
@call :color cc "'"&@call :color 44 "'"&@call :color cc "'"&@echo   Yes (Internet Connection ^& Email Account Required) -- Disabled
echo �2�  No ^& Reboot SDS
echo �3�  No
echo.
%set /p% sendCrashEmail="�� "
if "%sendCrashEmail%"=="2" endlocal&goto :StartOfScript
@goto quickend
:sendEmail
start mailto:%HelpEmail%?Subject=SD-Security%%20Crash%%20Report^&Body=Where%%20Was%%20SD-Security%%20Installed%%3F%%0AWhat%%20Version%%20Of%%20Windows%%20Are%%20You%%20Running%%3F%%0AWhich%%20Version%%20Of%%20SD-Security%%20Are%%20You%%20Running%%3F%%20%SDS_Version%%%0A-------------------------------------%%0ATo%%20SD-Security%%2C%%0AI%%20would%%20like%%20to%%20report%%20a%%20bug%%2C%%20here%%20is%%20the%%20details%%20of%%20what%%20happened%%3A%%0A
%crashCommand%
goto quickend
:CrashHelper
set restart=0
if exist "SDS_Files\DisableCrashHelper.ini" (goto :CrashHelperActive)
if not "%~2"=="" (if not "%~3"=="" (set "CMDSwitch=%1 %2 %3") else (set "CMDSwitch=%1 %2")) else (set "CMDSwitch=%1")
if "%1"=="/?" call :CommandSwitchHelp&call cmd /t:f0 /c %0&goto :CrashHelperPriorityCode
if not "%~2"=="" (if not "%~3"=="" (if not "%~2"=="" call cmd /t:f0 /c %0 %CMDSwitch% %2 %3&goto :CrashHelperPriorityCode)) else (call cmd /t:f0 /c %0 %CMDSwitch% %2&goto :CrashHelperPriorityCode)
call cmd /t:f0 /c %0 %CMDSwitch%
:CrashHelperPriorityCode
@if errorlevel 999 @exit 999
@if errorlevel 777 @goto :StartOfScript
@if errorlevel 666 @set FakeCrash=yes
@goto ReportCrash
:DevOptions
call :setTime&echo ^|^|Log^|^|  ^|Info: Developer Options^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Developer Options - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Developer Options                 %status%
echo �������������������������������������������������������������������������������
echo.
echo �1�  Crash SD-Security
echo �2�  Reboot SD-Security
echo �3�  Reboot To Safemode
echo �4�  Debugging Stats
echo �5�  AdminCMD API Config
echo �6�  Regenerate Autorun.inf File
echo �7�  Back
%set /p% DevOptions="�� "
if "%DevOptions%"=="1" exit /b 666
if "%DevOptions%"=="2" endlocal&exit 777
if "%DevOptions%"=="3" goto Safe_Mode
if "%DevOptions%"=="4" goto DebugStats
if "%DevOptions%"=="5" goto AdminCMDScreen
if "%DevOptions%"=="6" call :CreateAutorun&echo Successful!&timeout 5 >nul&goto :DevOptions
goto other
:: SD-Updater
:CheckForUpdates
cls
title Checking For Updates - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Checking For Updates               %status%
echo �������������������������������������������������������������������������������
echo.
echo                                   Checking For Updates...
for /F "eol=# delims=" %%A in (SDS_FILES\SD-Updater.ini) do set %%A>nul 2>&1
call :Download "%Latest_Version_Log%" "SDS_Files\LatestVersion.ini"
if not "%Downloaded%"=="Yes" goto home
for /F "eol=# delims=" %%A in (SDS_FILES\LatestVersion.ini) do set "%%A" >nul 2>&1
if not %SDS_Version%==%OnlineVersion% goto UpdateAvailable
:NoUpdates
cls
title No Updates Available - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               No Updates Available               %status%
echo �������������������������������������������������������������������������������
echo.
echo             There Are Currently No Updates Available For SD-Security
echo                            Press Any Key To Go Home
pause >nul
goto home
:UpdateAvailable
call :setTime&echo ^|^|Log^|^|  ^|Update Available: %OnlineVersion%^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
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
call :Notify "An Update For SD-Security Has Published, V.%onlineVersion%" "Update SD-Security"
%set /p% UpdateSDS="�� "
if "%UpdateSDS%"=="1" goto DownloadUpdate
goto Home
:DownloadUpdate
call :setTime&echo ^|^|Log^|^|  ^|Update Downloading...^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Update Downloading... - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Update Downloading                 %status%
echo �������������������������������������������������������������������������������
echo.
echo                              Downloading Update...
echo.
call :Download "%Latest_Version_EXE%" "SD-Security2.exe"
if not "%Downloaded%"=="Yes" goto home
echo                                Downloaded Update
timeout 3 /nobreak >nul
:InstallUpdateNow
call :setTime&echo ^|^|Log^|^|  ^|Update Downloaded^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
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
%set /p% InstallSDS="�� "
if "%InstallSDS%"=="1" call start SD-Security2.exe&goto UpdateCheckComplete
if "%InstallSDS%"=="2" goto StartInstallingUpdate
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
%set /p% InstallSDS2="�� "
if "%InstallSDS2%"=="1" goto StartInstallingUpdate
goto home
:StartInstallingUpdate
call start "Updating SD-Security" cmd /c "color f0&title SD-Security EXE Updater&mode con: cols=90 lines=25&echo -----------------------------===============================-----------------------------&echo -------------------------------= SD-Security EXE Updater =-------------------------------&echo -----------------------------===============================-----------------------------&echo -----------------------------===============================-----------------------------&timeout 2 >nul&echo                     Renaming Old SD-Security To 'SD-Security_old.exe'&ren SD-Security.exe "SD-Security_old.exe"&echo                       Renaming New SD-Security To 'SD-Security.exe'&ren SD-Security2.exe "SD-Security.exe"&echo                               Finished! SD-Security Updated&echo.&echo                    Press Any Key To Exit The Updater And Start SD-Security&pause >nul&call start SD-Security.exe&exit 999"
exit 999
:InstallPowershell
cls
title Install Powershell - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Install Powershell                 %status%
echo �������������������������������������������������������������������������������
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
@set one=%~1
@set two=%~2
@set three=%~3
@if "%one%"=="" @set one=Switch To SD-Security
@if "%two%"=="" @set two=SD-Security
@if "%three%"=="" @set three=Favicon.ico
@echo [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") > "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify = New-Object System.Windows.Forms.NotifyIcon >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.Icon = "%three%" >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.BalloonTipIcon = "None" >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.BalloonTipText = "%one%" >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.BalloonTipTitle = "%two%" >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.Visible = ^$True >> "%temp%\Notify_API_SDS.ps1"
@echo ^$Notify.ShowBalloonTip(10000) >> "%temp%\Notify_API_SDS.ps1"
@call start "Notify API" /min cmd /c "powershell -executionpolicy bypass -File "%temp%\Notify_API_SDS.ps1""
@goto :EOF
:GetIp
if "%1"=="" (set GetIP=%computername%) else (set GetIP=%~1)
for /f "tokens=1,2 delims=[]" %%a in ('ping -w 1 -n 1 -4 "%GetIP%"^|findstr "Pinging"') do set IP=%%b
goto :EOF
:GetIPGUI
call :setTime&echo ^|^|Log^|^|  ^|Info: Get IP^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
:GetIPGUI2
cls
title Home - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                   Get IP                         %status%
echo �������������������������������������������������������������������������������
echo.
echo          Enter The Name Of A PC (On This Network) To Get The IP Address
echo.
%set /p% getIpFromThis="�� "
call :GetIP "%getIpFromThis%"
if "%IP%"=="" goto GetIPGUIError
echo.
echo The IP Address For %getIpFromThis% Is %IP%
goto GetIPTryAgain
:GetIPGUIError
echo                 Cannot Connect To PC! Check The Spelling And
echo         Check That The PC Is Connected To The Network And Try Again
:GetIPTryAgain
echo.
echo                         Would You Like To Try Again?
echo �1�  Yes
echo �2�  No
%set /p% TryAgain="�� "
if "%TryAgain%"=="1" goto GetIPGUI2
goto home
:RestoreSession
if not exist "SDS_FILES\Sessions\Disable*" goto StartRestoreSession
call :setwindow
set SessionName=%SessionFile:~0,-12%
cls
title Restore Session - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Restore Session                   Signed-Out
echo �������������������������������������������������������������������������������
echo.
echo                 Would You Like To Restore A Previous Session?
echo.
echo �1�  Yes
echo �2�  No
echo �3�  No + Delete All Sessions
%set /p% RestoreSession="�� "
if "%RestoreSession%"=="1" goto StartRestoreSession
if "%RestoreSession%"=="3" goto DeleteRestoreSession
goto noRestore
:DeleteRestoreSession
cls
title Delete Sessions - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 Delete Sessions                  Signed-Out
echo �������������������������������������������������������������������������������
echo.
echo              Are You Sure You Want To Delete ALL Previous Sessions?
echo.
echo �1�  Yes
echo �2�  No
%set /p% DelRestoreSession="�� "
if "%DelRestoreSession%"=="1" del SDS_Files\Sessions\*.SDS_Session
goto noRestore
:StartRestoreSession
for /F "eol=# delims=" %%A in (SDS_Files\Sessions\%sessionFile%) do set %%A>nul
del SDS_Files\Sessions\%sessionFile%>nul 2>&1
goto SetPasswords
:BackupSession
call :ClearPrivate
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
if "%OutputFile%"=="" set OutputFile=%fileToEncrypt%
set encrypt2=%encrypt%
set decrypt2=%decrypt%
(for /f "delims=" %%a in (%fileToEncrypt%) do (set line=%%a&call :EncryptionProcess))> "%OutputFile%"
goto :eof
:DecryptFile
setlocal
set encrypt=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#-/\ .0123456789
set decrypt=dbhlceaitjkzqromsyvnfwxupg/YERT-U4LKJH!OG DSWAXP1CZVN\BQMI95F#6708.32@
set fileToDecrypt=%~1
set OutputFile=%~2
if "%OutputFile%"=="" set OutputFile=%fileToDecrypt%
set encrypt2=%decrypt%
set decrypt2=%encrypt%
(for /f "delims=" %%a in (%fileToDecrypt%) do (set line=%%a&call :EncryptionProcess))> "%OutputFile%"
goto :eof
:EncryptionProcess
set "EncryptedFile="
:EncryptionProcess2
set $1=%encrypt2%
set $2=%decrypt2%
:EncryptionProcess3
if "%line:~0,1%"=="%$1:~0,1%" set EncryptedFile=%EncryptedFile%%$2:~0,1%&goto EncryptionProcess4
set $1=%$1:~1%
set $2=%$2:~1%
if defined $2 goto EncryptionProcess3
set EncryptedFile=%EncryptedFile%%line:~0,1%
:EncryptionProcess4
set line=%line:~1%
if defined line goto EncryptionProcess2
echo %EncryptedFile%
goto :eof
:OverwriteSettings
call :FilePer unlock "SDS_FILES\SD-Settings.ini"
(echo # SD-Security Settings File, Do Not Edit Unless You Are A Developer
echo Dev_Mode=%Dev_Mode%
echo New_AdminCMD_API=%New_AdminCMD_API%
echo Used_Before=%Used_Before%
echo Trial_Mode=%Trial_Mode%
echo Bug_101_Vuln=%Bug_101_Vuln%
echo Hide_Bug_101=%Hide_Bug_101%
echo Security_Breach_Key=%Security_Breach_Key%
echo Hide_Password=%Hide_Password%
echo Theme=%Theme%)> "SDS_FILES\SD-Settings.ini"
call :FilePer lock "SDS_FILES\SD-Settings.ini"
goto :EOF
:Switch
set "SwitchName=%~1"
set "SwitchType=%~2"
if "%SwitchType%"=="" (call :InvertSwitch&goto :EOF)
if /i "%switchType%"=="ON" (set "%SwitchName%=%ON%") else (if /i "%switchType%"=="OFF" set "%SwitchName%=%Off%")
goto :EOF
:InvertSwitch
for /f "tokens=1-2 delims==" %%a in ('set %SwitchName% 2^>nul') do set "SwitchStatus=%%b">nul 2>&1
if "%SwitchStatus%"=="%Off%" (set "%SwitchName%=%ON%") else (set "%SwitchName%=%OFF%")
goto :EOF
:changesettings
call :setTime&echo ^|^|Log^|^|  ^|Info: Home^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
set "On=�"
set "Off= "
set "switch=call :Switch"
if /i %Dev_Mode%==yes (%switch% switch1 on) else (%switch% switch1 off)
if /i %Hide_Bug_101%==yes (%switch% switch2 on) else (%switch% switch2 off)
if /i %Hide_Password%==yes (%switch% switch3 on) else (%switch% switch3 off)
if exist "SDS_Files\Sessions\default*" (%switch% switch4 on) else (%switch% switch4 off)
if exist "SDS_Files\Sessions\disable*" (%switch% switch5 on) else (%switch% switch5 off)
if exist "SDS_Files\HideBootTime.ini" (%switch% switch6 on) else (%switch% switch6 off)
if exist "DisableCrashHelper.ini" (%switch% switch7 on) else (%switch% switch7 off)
if /i "%New_AdminCMD_API%"=="no" (%switch% switch8 on) else (%switch% switch8 off)
if exist "SDS_Files\ExtInput.ini" (%switch% switch9 on) else (%switch% switch9 off)
:ChangeSettingsRefresh
cls
call :CheckStatus No "goto :other"
title Change Settings - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Change Settings                    %status%
echo �������������������������������������������������������������������������������
echo.
echo                                 Yes/No Settings
echo �1%switch1%�  Launch SDS In Developer Mode
echo �2%switch2%�  Hide Bug 101 Error Screens
echo �3%switch3%�  Mask The Password Fields
echo �4%switch4%�  Always Auto-Save Session
echo �5%switch5%�  Disable Auto-Restore
echo �6%switch6%�  Hide Slow Boot Time Errors
echo �7%switch7%�  Disable Crash Helper API (USE WITH CAUTION)
echo �8%switch8%�  Use Legacy Version Of AdminCMD API
echo �9%switch9%�  Use External Input (Delete �SDS_Files\ExtInput.ini� To Disable)
echo.
echo                              User Defined Settings
echo �A�  Change Master Override Key
echo �B�  Change Application Colour Theme
echo.
echo �C�  Save Settings
echo �D�  Cancel (Discard Settings)
CHOICE /C 123456789ABCD /N /M "�� "
IF ERRORLEVEL 13 %settheme%&goto :AdminOps
IF ERRORLEVEL 12 goto :SaveNewSdsSettings
IF ERRORLEVEL 11 call :ChangeTheme&goto :ChangeSettingsRefresh
IF ERRORLEVEL 10 call :ChangeBreachKey&goto :ChangeSettingsRefresh
IF ERRORLEVEL 9 %switch% switch9&goto :ChangeSettingsRefresh
IF ERRORLEVEL 8 %switch% switch8&goto :ChangeSettingsRefresh
IF ERRORLEVEL 7 %switch% switch7&goto :ChangeSettingsRefresh
IF ERRORLEVEL 6 %switch% switch6&goto :ChangeSettingsRefresh
IF ERRORLEVEL 5 %switch% switch5&goto :ChangeSettingsRefresh
IF ERRORLEVEL 4 %switch% switch4&goto :ChangeSettingsRefresh
IF ERRORLEVEL 3 %switch% switch3&goto :ChangeSettingsRefresh
IF ERRORLEVEL 2 %switch% switch2&goto :ChangeSettingsRefresh
IF ERRORLEVEL 1 %switch% switch1&goto :ChangeSettingsRefresh
goto :ChangeSettingsRefresh
:ChangeTheme
%settheme%
title Choose Theme - SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 Choose Theme                     %status%
echo �������������������������������������������������������������������������������
echo.
%echo% "�A�  "&call :Color 91 "Light Blue"&echo.
%echo% "�B�  "&call :Color 19 "Dark  Blue"&echo.
%echo% "�C�  "&call :Color a2 "Light Green"&echo.
%echo% "�D�  "&call :Color 2a "Dark  Green"&echo.
%echo% "�E�  "&call :Color b3 "Light Aqua"&echo.
%echo% "�F�  "&call :Color 3b "Dark  Aqua"&echo.
%echo% "�G�  "&call :Color c4 "Light Red"&echo.
%echo% "�H�  "&call :Color 4c "Dark  Red"&echo.
%echo% "�I�  "&call :Color d5 "Light Purple"&echo.
%echo% "�J�  "&call :Color 5d "Dark  Purple"&echo.
%echo% "�K�  "&call :Color e6 "Light Yellow"&echo.
%echo% "�L�  "&call :Color 6e "Dark  Yellow"&echo.
%echo% "�M�  "&call :Color 78 "Light Grey"&echo.
%echo% "�N�  "&call :Color 87 "Dark  Grey"&echo.
%echo% "�O�  "&call :Color 0f "Black"&echo.
%echo% "�P�  "&call :Color f7 "White"&echo.
%echo% "�Q�  "&call :Color f0 "White And Black"&echo.
CHOICE /C abcdefghijklmnopq /N /M "�� "
IF ERRORLEVEL 17 set "NewColorNum=f0"&set NewThemeColor=white_black&goto ConfirmNewTheme
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
echo �1�  Confirm Theme
echo �2�  Choose Another Theme
CHOICE /C 12 /N /M "�� "
IF ERRORLEVEL 2 goto :ChangeTheme
IF ERRORLEVEL 1 goto :EOF
:ChangeBreachKey
%set /p% NewBreachKey="Enter A New Security Breach Key: "
if not "%NewBreachKey%"=="" goto :EOF
echo Please Enter A Security Breach Key!
pause >nul
goto :EOF
:SaveNewSdsSettings
call :CheckStatus No "goto :other"
echo                      Press Any Key To Save Settings
pause >nul
if "%switch1%"=="%on%" (set Dev_Mode=yes) else (set Dev_Mode=no)
if "%switch2%"=="%on%" (set Hide_Bug_101=yes) else (set Hide_Bug_101=no)
if "%switch3%"=="%on%" (set Hide_Password=yes) else (set Hide_Password=no)
if "%switch4%"=="%on%" (md SDS_Files\Sessions >nul 2>&1&echo SDS> "SDS_Files\Sessions\DefaultEnable.ini") else (del SDS_Files\Sessions\Default*>nul 2>&1)
if "%switch5%"=="%on%" (md SDS_Files\Sessions >nul 2>&1&echo SDS> "SDS_Files\Sessions\DisableAutoRestore.ini") else (del SDS_Files\Sessions\Disable*>nul 2>&1)
if "%switch6%"=="%on%" (echo SDS> "SDS_Files\HideBootTime.ini") else (del SDS_Files\HideBootTime.ini >nul 2>&1)
if "%switch7%"=="%on%" (echo SDS> "DisableCrashHelper.ini") else (del DisableCrashHelper.ini >nul 2>&1)
if "%switch8%"=="%on%" (set "New_AdminCMD_API=no") else (set "New_AdminCMD_API=yes")
if "%switch9%"=="%on%" (echo.>"SDS_Files\ExtInput.ini") else (del SDS_Files\ExtInput.ini >nul 2>&1)
if not "%NewBreachKey%"=="" (set Security_Breach_Key=%NewBreachKey%)
if not "%newThemeColor%"=="" (set theme=%newThemeColor%&set "settheme=color %NewColorNum%")
call :OverwriteSettings
:Restart
cls
call :CheckStatus No "goto :other"
title Restart SDS - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  Restart SDS                     %status%
echo �������������������������������������������������������������������������������
echo.
echo   In Order To Apply The Selected Settings, You May Need To Restart SD-Security
echo.
echo �1�  Restart Now
echo �2�  Postpone
echo �3�  Exit
%set /p% RestartSDS="�� "
if "%RestartSDS%"=="1" goto :RestartSDS
if "%RestartSDS%"=="3" goto :end
goto home
:RestartSDS
endlocal
exit 777
:AskString
set "StringName=%*"
set "StringName=%StringName:"=%"
if exist "SDS_Files\ExtInput.ini" goto :ExtInput
set /p %StringName%
for /f "tokens=1" %%a in ('echo %StringName%') do set "StringName=%%a"&goto AskStringNext
:AskStringNext
(set %StringName% 2>nul|findstr /r /c:"[&|<>""]"&if not errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Enter Special Characters!&goto :AskString)) 1>nul
(set %StringName% 2>nul|findstr "Environment variable %StringName% not defined"&if errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Leave This Field Blank!&goto :AskString)) 1>nul
goto :EOF
:ExtInput
del SDS_Files\Ext.Input>nul 2>&1
set /p %StringName%<nul&%echo% EXT INPUT
:CheckExtInput
if exist "SDS_Files\Ext.Input" (set /p %StringName%<SDS_Files\Ext.Input>nul&del SDS_Files\Ext.Input >nul 2>&1) else (goto :CheckExtInput)
for /f "tokens=1" %%a in ('echo %StringName%') do set "StringName=%%a"&goto ExtInputNext
:ExtInputNext
(set %StringName% 2>nul|findstr /r /c:"[&|<>""]"&if not errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Enter Special Characters!&goto :ExtInput)) 1>nul
(set %StringName% 2>nul|findstr "Environment variable %StringName% not defined"&if errorlevel 1 (set "%StringName%="&1>&2 echo Do Not Leave This Field Blank!&goto :ExtInput)) 1>nul&echo  RECEIVED
goto :EOF
:CheckStatus
if /i "%~3"=="else" (set "StatusCommand=(%~2) else (%~4)") else (set "StatusCommand=(%~2)")
if /i "%status%"=="Signed In" (if /i "%~1"=="yes" %StatusCommand%) else (if /i "%~1"=="no" %StatusCommand%)
goto :EOF
:beep
echo.|choice /n>nul 2>&1
goto :EOF
:plugins
if not exist "SDS_Files\Plugins\" md SDS_Files\Plugins\ >nul 2>&1&goto :EOF
if /i "%~1"=="PreBoot" (call :LoadPlugins "PreBoot.bat"&goto :EOF)
if /i "%~1"=="InBoot" (call :LoadPlugins "InBoot.bat"&goto :EOF)
if /i "%~1"=="AfterBoot" (call :LoadPlugins "AfterBoot.bat"&goto :EOF)
if /i "%~1"=="PreExit" (call :LoadPlugins "PreExit.bat"&goto :EOF)
if /i "%~1"=="OnExit" (call :LoadPlugins "OnExit.bat"&goto :EOF)
goto :EOF
:LoadPlugins
setlocal
call :ClearPrivate
for /f "delims=" %%a in ('dir /O:-D /B /A:D SDS_Files\Plugins^|findstr /V /I "_DISABLE"') do (if "%%a"=="" (goto :EOF) else (if exist "SDS_Files\Plugins\%%a\%~1" set "FullAppFolder=%cd%\SDS_Files\Plugins\%%a"&set "AppFolder=SDS_Files\Plugins\%%a"&call SDS_Files\Plugins\%%a\%~1))
endlocal
goto :EOF
:CustomApps
cls
title Custom Apps - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  Custom Apps                     %status%
echo �������������������������������������������������������������������������������
echo.
echo    Enter The Name Of The App You Want To Launch (Enter �Cancel� To Cancel) :
echo      Enter �Uninstall� To Uninstall App(s) Or Enter �Info� To View App Info
echo              (To Launch An App With Full Permissions, Enter �Full�)
for /f %%a in ('dir /O:-D /B /A:D SDS_Files\Plugins^|findstr /V /I "_DISABLE"') do (if exist "SDS_Files\Plugins\%%a\home.bat" (set "CustomApp=yes"&echo � %%a) else (set "CustomApp=none"))
if "%customApp%"=="none" goto :NoCustomApps
%set /p% LaunchApp="�� "
if /i "%LaunchApp%"=="Cancel" goto :home
if /i "%LaunchApp%"=="Uninstall" goto :UninstallApp
if /i "%LaunchApp%"=="Info" goto :AppInfo
if /i "%LaunchApp%"=="Help" goto :AppInfo
if /i "%LaunchApp%"=="Full" goto :LaunchAppFull
if /i "%LaunchApp%"=="Details" goto :AppInfo
if not exist "SDS_Files\Plugins\%LaunchApp%" echo App Not Installed!&timeout 2 >nul&goto :CustomApps
call :LoadApp "%LaunchApp%"
goto :home
:LaunchAppFull
call :CheckStatus Yes "goto :LaunchAppFull2"
cls
title Sign In - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                     Sign In                      %status%
echo �������������������������������������������������������������������������������
echo.
echo               Please Sign In To Launch Apps With Full Permissions
echo.
%set /p% user="Enter Username �� "
if not %Hide_Password%==yes (%set /p% password="Enter Password �� ") else (call :MaskPassword)
call :SignInNow "%User%" "%Password%"
call :checkstatus No "goto :denied"
call :ClearLockdown
:LaunchAppFull2
cls
title Custom Apps - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  Custom Apps                     %status%
echo �������������������������������������������������������������������������������
echo.
echo        Enter The Name Of The App You Want To Launch With Full Permissions
echo     WARNING: This Gives An App Access To Your Data And Allows It To Perform
echo                Any Command Within SD-Security, Use With Caution!
echo                           (Enter �Cancel� To Cancel) :
for /f %%a in ('dir /O:-D /B /A:D SDS_Files\Plugins') do (if exist "SDS_Files\Plugins\%%a\home.bat" (set "CustomApp=yes"&echo � %%a) else (set "CustomApp=none"))
if "%customApp%"=="none" echo No Apps Installed, Press Any Key To Exit&pause >nul&goto :CustomApps
%set /p% lApp="�� "
if /i "%lApp%"=="Cancel" goto :home
if not exist "SDS_Files\Plugins\%lApp%" echo App Not Installed!&timeout 2 >nul&goto :LaunchAppFull2
call :LoadAppFull "%lApp%"
goto :home
:UninstallApp
cls
title Uninstall App(s) - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Uninstall App(s)                  %status%
echo �������������������������������������������������������������������������������
echo.
echo  Enter The Name Of The App You Want To Uninstall (Enter �Cancel� To Cancel) :
for /f %%a in ('dir /O:-D /B /A:D SDS_Files\Plugins') do (if exist "SDS_Files\Plugins\%%a\" (set "CustomApp=yes"&echo � %%a) else (set "CustomApp=none"))
if "%customApp%"=="none" echo No Apps Installed, Press Any Key To Exit&pause >nul&goto :CustomApps
%set /p% UninstallApp="�� "
if /i "%UninstallApp%"=="Cancel" goto :home
if not exist "SDS_Files\Plugins\%UninstallApp%" echo App Not Installed!&timeout 2 >nul&goto :UninstallApp
rd /s SDS_Files\Plugins\%UninstallApp%
goto :UninstallApp
:AppInfo
cls
title App Info - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                     App Info                     %status%
echo �������������������������������������������������������������������������������
echo.
echo     Enter The Name Of The App You Want To Info (Enter �Cancel� To Cancel) :
for /f %%a in ('dir /O:-D /B /A:D SDS_Files\Plugins') do (if exist "SDS_Files\Plugins\%%a\About.txt" (set "CustomApp=yes"&echo � %%a) else (set "CustomApp=none"))
if "%customApp%"=="none" echo No Apps/Help Files Installed, Press Any Key To Exit&pause >nul&goto :CustomApps
%set /p% AppInfo="�� "
if /i "%AppInfo%"=="Cancel" goto :home
if not exist "SDS_Files\Plugins\%AppInfo%" echo App Not Installed!&timeout 2 >nul&goto :AppInfo
if /i not exist "SDS_Files\Plugins\%AppInfo%\About.txt" echo No Help File Available For App!&timeout 2 >nul&goto :AppInfo
cls
mode con: lines=40
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                     App Info                     %status%
echo �������������������������������������������������������������������������������
echo.
type "SDS_Files\Plugins\%AppInfo%\About.txt"|more
echo.
echo                             Press Any Key To Return
pause >nul
call :setWindow
goto :AppInfo
:NoCustomApps
cls
title Custom Apps - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  Custom Apps                     %status%
echo �������������������������������������������������������������������������������
echo.
echo                      No Custom Apps Have Been Installed Yet!
echo                            Press Any Key To Go Home
pause >nul
goto :home
:LoadApp
setlocal
title Custom App '%~1'
call :ClearPrivate
if "%~1"=="" (goto :EOF) else (if exist "SDS_Files\Plugins\%~1\home.bat" (set "FullAppFolder=%cd%\SDS_Files\Plugins\%~1"&set "AppFolder=SDS_Files\Plugins\%~1"&set "FullPermissions=No"&call SDS_Files\Plugins\%~1\home.bat))
endlocal
goto :EOF
:LoadAppFull
call :checkstatus No "goto :home"
title -FULL PERMISSIONS- Custom App '%~1'
if "%~1"=="" (goto :EOF) else (if exist "SDS_Files\Plugins\%~1\home.bat" (set "FullAppFolder=%cd%\SDS_Files\Plugins\%~1"&set "AppFolder=SDS_Files\Plugins\%~1"&set "FullPermissions=Yes"&call SDS_Files\Plugins\%~1\home.bat))
if not defined AppCommand (goto :EOF)
%AppCommand%
goto :EOF
:ClearPrivate
set "password="&set "passwordA="set "password1="&set "password2="&set "user="&set "user1="&set "user2="&set "Security_Breach_Key="
goto :EOF
:Emailer
cls
title Emailer - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                    Emailer                       %status%
echo �������������������������������������������������������������������������������
echo.
echo             SD-Security Emailer Service, Enter �Cancel� To Cancel:
echo                     (This Service Generates A MAILTO Link)
echo.
echo                 Do Not Include Any Of These Symbols: " " ^& ^| "
%set /p% email="Recipent �� "
if /i "%email%"=="cancel" goto home
%set /p% subject="Subject  �� "
if /i "%subject%"=="cancel" goto home
echo Message  ��
%set /p% message=""
if /i "%message%"=="cancel" goto home
set "link=mailto:%email%?Subject=%subject%&Body=%message%"
echo.
echo "%link%"|clip
echo                       Link Generated, Copied To Clipboard
echo.
echo                        Would You Like To Open This Link?
echo �1�  Open In Default Email Program
echo �2�  Open In Notepad
echo �3�  No
%set /p% howToOpen="�� "
if "%howToOpen%"=="1" start "" "%link%"
if "%howToOpen%"=="2" echo Here Is Your Emailer-Email=^> > "SD-Emailer Email.txt"&echo "%link%">> "SD-Emailer Email.txt"&notepad "SD-Emailer Email.txt"
goto home
:SecTimer
if /i "%~1"=="report" goto :ReportSecTimer
if /i "%~1"=="log" goto :LogSecTimer
set "Timer=%time:~0,8%"
set "Timer2=%Timer::=%"
set /a "Timer=(%Timer2:~2,2%*60)+(%Timer2:~0,2%*3600)+%Timer2:~-2%"
if /i not "%~1"=="stop" (set "StartTime=%timer%") else (set "endTime=%Timer%"&set /a "TimerTime=%Timer%-%StartTime%">nul)
goto :EOF
:LogSecTimer
echo ^|^|Startup Time: %TimerTime% Seconds^|^|  >> "SDS_Files\Security\SD-Security.SDS_LOG"
goto :EOF
:ReportSecTimer
if exist "SDS_Files\HideBootTime.ini" goto :EOF
if "%timerTime%"=="10" goto :EOF
if not "%timertime%"=="" (echo %timerTime%|findstr "..">nul&&goto ReportSecTimer2)
goto :EOF
:ReportSecTimer2
call :setwindow
%settheme%
cls
title Boot Time Of %timerTime% Seconds - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 Slow Boot Time                   %status%
echo �������������������������������������������������������������������������������
echo.
echo      It Was Detected That It Took Longer Than 10 Seconds For SDS To Boot,
echo        This Could Be Due To An Antivirus Or Because Of A Lack Of Memory,
echo                  The Average Startup Time For SDS Is 2 Seconds!
echo.
echo What Would You Like To Do?
echo �1�  Continue (Ignore)
echo �2�  Never Show Again
echo �3�  Reboot
%set /p% SlowTime="�� "
if "%SlowTime%"=="2" echo SDS> "SDS_Files\HideBootTime.ini"&goto :EOF
if "%SlowTime%"=="3" endlocal&exit 777
goto :EOF
:DebugStats
%SetTheme%
cls
title Debugging Stats - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Debugging Stats                   %status%
echo �������������������������������������������������������������������������������
echo.
call :setTime&echo ^|^|Log^|^|  ^|Info: Debugging Stats^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
if "%CMDSwitch%"=="" (set "CMDSwitch2=N/A") else (set "CMDSwitch2=Yes �CMDSwitch�")
if /i "%Hide_Password%"=="yes" (set HidePswd=On) else (set HidePswd=Off)
if /i "%Bug_101_Vuln%"=="yes" (set Bug_101_Vuln=Yes) else (set Bug_101_Vuln=No)
if /i "%Dev_Mode%"=="yes" (set DevMode=On) else (set DevMode=Off)
if exist "SDS_Files\ExtInput.ini" (set ExtInput=On) else (set ExtInput=Off)
if defined SessionFile (set "BootType=From Session File") else (set "BootType=Normal")
call :AdminCMDCheck
echo �������������������������������������������������������������������������������
echo � Admin Permissions  �� %AdminPer%
echo � Boot Time Seconds  �� %timerTime% (Started�� %startTime% ^& Finished�� %endTime%)
echo � Last Boot Type     �� %BootType%
echo � Command Switch     �� %CMDswitch2%
echo � Bug 101 Vulnerable �� %Bug_101_Vuln% ^& Drive Type�� %DriveType% ^& Serial�� %serial%
echo � Developer Mode     �� %DevMode%
echo � AdminCMD API       �� %AdminCMDStatus%
echo � Hide Password API  �� %HidePswd%
echo � Use External Input �� %ExtInput%
echo � SD-Security Build  �� SDS V%SDS_Version% (%Version_Type% Build)
echo � Executable Filename�� %SDS_File% (%sds_extension% Mode)
echo � SDS Theme Colour   �� %theme% ^& Colour Code�� %settheme:~-2%
call :CheckStatus Yes "echo � Security Status    �� %status% ^& User�� %User%" else "echo � Security Status    �� %status%"
echo � Operating System   �� %WinVersion% ^& Version�� %version%
echo �������������������������������������������������������������������������������
echo.
echo                                  Save To File?
echo �1�  Yes
echo �2�  No
%set /p% SaveToFile="�� "
if "%SaveToFile%"=="1" goto DebugStatsSave
goto :devoptions
:DebugStatsSave
call :SetTime
(echo Debugging Stats For SD-Security. TIME: %twelve% ^| Date: %date2%
echo Admin Permissions  : %AdminPer%
echo Boot Time Seconds  : %timerTime% ^(Started: %startTime% ^| Finished: %endTime%^)
echo Last Boot Type     : %BootType%
echo Command Switch     : %CMDswitch2%
echo Bug 101 Vulnerable : %Bug_101_Vuln% ^| Drive Type: %DriveType% ^| Serial: %serial%
echo Developer Mode     : %DevMode%
echo AdminCMD API       : %AdminCMDStatus%
echo Hide Password API  : %HidePswd%
echo SD-Security Build  : SDS V%SDS_Version% ^(%Version_Type% Build^)
echo Executable Filename: %SDS_File% ^(%sds_extension% Mode^)
echo SDS Theme Colour   : Colour: %theme% ^| Colour Code: %settheme:~-2%
call :CheckStatus Yes "echo Security Status    : %status% ^| User: %User%" else "echo Security Status    : %status%"
echo Operating System   : %WinVersion% ^| Version: %version%
)> "Debugging Stats.txt"
echo Saved To �Debugging Stats.txt�!
timeout 3 >nul
goto DevOptions
:AdminCMDScreen
set "On=�"
set "Off= "
set "switch=call :Switch"
call :AdminCMDCheck
if /i "%AdminCMDStatus%"=="Active" (%switch% switch1 on) else (%switch% switch1 off)
if exist "SDS_Files\AdminCMD\AlwaysShowWindow.ini" (%switch% switch2 on) else (%switch% switch2 off)
goto :AdminCMDScreen2A
:AdminCMDScreen2
if "%Switch1%"=="%On%" (call :AdminCMD start) else (call :AdminCMD stop)
if "%Switch2%"=="%On%" (echo. >"SDS_Files\AdminCMD\AlwaysShowWindow.ini"&call :AdminCMDGenerateVBS) else (del "SDS_Files\AdminCMD\AlwaysShowWindow.ini" >Nul 2>&1&call :AdminCMDGenerateVBS)
:AdminCMDScreen2A
cls
title AdminCMD API - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                   AdminCMD API                   %status%
echo �������������������������������������������������������������������������������
echo.
echo �1%switch1%�  Enable/Disable AdminCMD API
echo �2%switch2%�  Show The AdminCMD API Window When Active
echo �3��  Reset AdminCMD Installation Cache
echo �4��  Back
CHOICE /C 1234 /N /M "�� "
IF ERRORLEVEL 4 goto :DevOptions
IF ERRORLEVEL 3 goto :ResetAdminCMD
IF ERRORLEVEL 2 %switch% switch2&goto :AdminCMDScreen2
IF ERRORLEVEL 1 %switch% switch1&goto :AdminCMDScreen2
goto :AdminCMDScreen2
:ResetAdminCMD
pushd "%temp%"
del /F /Q "Clipboard.AdminCMD++" "ClipboardAdminCMD++.vbs" "AdminCMD.bat" "KillAdminCMD.ini" >nul 2>&1
popd
rd /S /Q SDS_Files\AdminCMD >nul 2>&1
goto :AdminCMDScreen2
:AdminCMD
if /i "%~1"=="start" (call :AdminCMDStart)
if /i "%~1"=="stop" (call :AdminCMDStop&goto :EOF)
if /i "%~1"=="run" (call :AdminCMDRun "%~2")
goto :EOF
:AdminCMDStart
call :AdminCMDStop
if not exist "SDS_Files\AdminCMD\" md SDS_Files\AdminCMD
if not exist "SDS_Files\AdminCMD\StartService.vbs" call :AdminCMDGenerateVBS
if /i not "%New_AdminCMD_API%"=="yes" (set "AdminCMDVersion=AdminCMD") else (set "AdminCMDVersion=AdminCMD++")
if not exist "SDS_Files\AdminCMD\%AdminCMDVersion%.bat" (call :AdminCMDGenerate)
wscript "SDS_Files\AdminCMD\StartService.vbs" "SDS_Files\AdminCMD\%AdminCMDVersion%.bat"
goto :EOF
:AdminCMDCheck
set "AdminCMDStatus=Deactive"
if /i not "%New_AdminCMD_API%"=="yes" (set "AdminCMDVersion=AdminCMD") else (set "AdminCMDVersion=AdminCMD++")
tasklist /NH /FI "WINDOWTITLE eq Administrator:  @%AdminCMDVersion%:Auth:@"|findstr /V /B /C:"INFO:">nul 2>&1&&set "AdminCMDStatus=Active"
goto :EOF
:AdminCMDRun
call :AdminCMDCheck
if /i "%AdminCMDStatus%"=="Deactive" (call :AdminCMDStart&timeout 1 >nul)
if /i not "%New_AdminCMD_API%"=="yes" (call :AdminCMDRunCMD "%~1") else (call :AdminCMDPlusPlusRunCMD "%~1")
goto :EOF
:AdminCMDStop
if /i not "%New_AdminCMD_API%"=="yes" (echo.>"%Temp%\KillAdminCMD.ini") else (echo $ADMINCMD$.Kill|clip)
goto :EOF
::: AdminCMD (V1)
:AdminCMDGenerate
if /i not "%New_AdminCMD_API%"=="no" (goto AdminCMDPlusPlusGenerate)
(echo @echo off^&pushd "%%temp%%"^&title @AdminCMD:Auth:@&echo set S=AdminCMD.bat^&set K=KillAdminCMD.ini
echo del /F "%%S%%"^>nul 2^>^&1^&del /F "%%K%%"^>nul 2^>^&1&echo :AS
echo if exist "%%K%%" exit&echo if not exist "%%S%%" goto AS
echo call cmd /c "%%temp%%\%%S%%"^&call :DS^&goto :AS&echo :DS
echo del /F "%%S%%"^>nul 2^>^&1^&if exist "%%S%%" (goto :DS^) else (goto :EOF^))> "SDS_Files\AdminCMD\AdminCMD.bat"
goto :EOF
:AdminCMDGenerateVBS
if exist "SDS_Files\AdminCMD\AlwaysShowWindow.ini" (set HideOrShow=1) else (set HideOrShow=0)
(echo Set UAC = CreateObject^("Shell.Application"^)
echo UAC.ShellExecute """" ^& WScript.Arguments^(0^) ^& """", "ELEV", "", "runas", %HideOrShow%)> "SDS_Files\AdminCMD\StartService.vbs"
goto :EOF
:AdminCMDRunCMD
pushd "%temp%"&set "AdminCMD=AdminCMD%random%.ini"
<nul set /p "=%~1"> "%AdminCMD%"&del /F "AdminCMD.bat" >nul 2>&1
:AdminCMDRunCMDLoop
copy /Y %AdminCMD% "AdminCMD.bat" >nul 2>&1
if not "%errorlevel%"=="0" (goto :AdminCMDRunCMDLoop) else (popd&goto :EOF)
::: AdminCMD++ (V2)
:AdminCMDPlusPlusGenerate
(echo ^@echo off^&pushd %%temp%%^&title ^@AdminCMD++:Auth:^@^&set VBS=ClipboardAdminCMD++.vbs^&set Clip=Clipboard.AdminCMD++
echo set "chk=type "%%Clip%%"|findstr /B /C:"^&set "password=run"^&set "echo=<nul set /p ="
echo net file^>nul 2^>^&1^&^&echo $ADMINCMD$.Initiate.Success^|clip^&^&echo      �������� � Initiate: Successful � Admin Permissions Granted � ��������^&^&echo.^|^|echo $ADMINCMD$.Initiate.Fail.NoAdmin^|clip^&^&echo     �������� � Initiate: Unsuccessful � Admin Permissions Denied � ��������^&^&echo                      AdminCMD++ Detection Has Been Disabled^&^&echo.
echo :AS
echo if not exist "%%VBS%%" call :Gen
echo ^@del "%%Clip%%"^>nul 2^>^&1^&cscript "%%VBS%%"^>nul 2^>^&1
echo %%chk%%"$ADMINCMD$.Kill"^>nul 2^>^&1^&^&echo AdminCMD-Kill Command Executed...^&^&echo $ADMINCMD$.Kill.Success^|clip^&^&exit 999
echo %%chk%%"$ADMINCMD$.Execute*%%password%%*&"^>nul 2^>^&1^|^|goto :AS
echo echo.^&echo                     �������� � PASSWORD ACCEPTED � ��������
echo ^@del AdminCMD++.bat^>nul 2^>^&1
echo ^@ren "%%Clip%%" "AdminCMD++.bat"
echo @%%echo%%$ADMINCMD$.Success^|clip
echo call cmd /c "prompt $LAdminCMD++$G &%%temp%%\AdminCMD++.bat" 2^>nul^&goto :AS
echo :Gen
echo ^(echo set Shell = CreateObject^^^("WScript.Shell"^^^)
echo echo set HTML = CreateObject^^^("htmlfile"^^^)^&echo AdminCMD = "%%Clip%%"
echo echo set FileSystem = CreateObject^^^("Scripting.FileSystemObject"^^^)
echo echo set File = FileSystem.OpenTextFile^^^(AdminCMD, 2, true^^^)
echo echo file.writeLine HTML.ParentWindow.ClipboardData.GetData^^^("text"^^^)
echo echo file.close^)^>%%VBS%%^&goto :EOF)> "SDS_Files\AdminCMD\AdminCMD++.bat"
goto :EOF
:AdminCMDPlusPlusRunCMD
<nul set /p "= $ADMINCMD$.Execute*run*&%~1"|clip
goto :EOF
:FilePer
if /i "%~1"=="lock" (icacls "%~2" /deny everyone:F /T /C /Q>nul 2>&1) else (icacls "%~2" /grant everyone:F /T /C /Q>nul 2>&1)
goto :EOF
:Decrypt
::: REAL ENCRYPTION SYSTEM!! DECRYPT TYPE
set decrypt2=abcdefghijklmnopqrstuvwxyz!@#-= .0123456789&set encrypt2=+(7R;-h4$_JH!\* )AW@?P:C6~NGBQT95F#ZE'S.,2D&set "file=%~1"
(for /f "delims=" %%a in (%file%) do (set "#=%%a"&call:RealDe))&goto :EOF
:RealDe
set "EncryptedFile="
:RealDe2
set "En1=%encrypt2%"&set "En2=%decrypt2%"
:RealDe3
if /i not "%#:~0,1%"=="%En1:~0,1%" (set "En1=%En1:~1%"&set "En2=%En2:~1%") else (set "EncryptedFile=%EncryptedFile%%En2:~0,1%"&goto RealDe4)
if defined En2 (goto RealDe3) else (set "EncryptedFile=%EncryptedFile%%#:~0,1%")
:RealDe4
set "#=%#:~1%"
if defined # (goto RealDe2) else (set "%EncryptedFile%"&goto :EOF)
:Encrypt
set encrypt2=abcdefghijklmnopqrstuvwxyz!@#-= .0123456789&set decrypt2=+(7R;-h4$_JH!\* )AW@?P:C6~NGBQT95F#ZE'S.,2D&set "file=%~1"&set "OutputFile=%~2"&if "%~2"=="" set "OutputFile=%file%"
(for /f "delims=" %%a in (%file%) do (set "#=%%a"&call:RealEn))> "%OutputFile%"&goto :EOF
:RealEn
set "EncryptedFile="
:RealEn2
set "En1=%encrypt2%"&set "En2=%decrypt2%"
:RealEn3
if /i not "%#:~0,1%"=="%En1:~0,1%" (set "En1=%En1:~1%"&set "En2=%En2:~1%") else (set "EncryptedFile=%EncryptedFile%%En2:~0,1%"&goto RealEn4)
if defined En2 (goto RealEn3) else (set "EncryptedFile=%EncryptedFile%%#:~0,1%")
:RealEn4
set "#=%#:~1%"
if defined # (goto RealEn2) else (echo.%EncryptedFile%&goto :EOF)
:MakeProfile
call :SetWindow
%SetTheme%
call :setTime&echo ^|^|Log^|^|  ^|Info: Sign Up Screen^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
title Sign Up For SD-Security�
cls
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                      Sign Up                    Signing Up
echo �������������������������������������������������������������������������������
echo.
echo                In Order To Use SD-Security, You Need To Sign Up
echo For Best Performance, Use Between 1-10 Characters In Your Username And Password
echo.
%set /p% User1="Choose An Username �� "
if not %Hide_Password%==yes (%set /p% password="Choose A Password  �� ") else (call :MaskPassword "Choose A Password  �� ")
set "Password1=%password%"&set "User=%User1%"
>SDS_Files\UserProfile-tmp.sys echo U=%User1%
>>SDS_Files\UserProfile-tmp.sys echo P=%Password1%
call :Encrypt "SDS_Files\UserProfile-tmp.sys" "SDS_Files\UserProfile.sys"
del SDS_Files\UserProfile-tmp.sys
call :SignInNow "%User1%" "%Password1%"
goto :EOF

:: Lockdown API
:60Bk_Finished
attrib -h -s "SDS_Files\Security\60Bk.sys"&del "SDS_Files\Security\60Bk.sys" >nul 2>&1&sgoto :StartLockdown
:Lockdown
set "status=Signed Out"&mode con: cols=51 lines=13
color cf&if exist "SDS_Files\Security\60Bk.sys" (goto :60Bk)
:StartLockdown
cls&set "Lockdown=Yes"&call :SetPasswords&title Enter Password - SD-Security�
echo ��������������������������������������������������
echo �    SD-Security Is Currently In Lockdown Mode   �
echo ��������������������������������������������������
echo �                                                �
echo �  The Password Was Entered 5 Times Incorrectly. �
echo �                                                �
echo � To Prevent Data Theft, SD-Security Has Blocked �
echo �     Access To Everything Until The Correct     �
echo �               Password Is Entered              �
echo �                                                �
echo ��������������������������������������������������
if "%ExitLockdown%"=="Yes" timeout 10 >nul&exit 999
%set /p% "password=� Enter Password � "
call :SignInNow "%User1%" "%Password%"
call :CheckStatus Yes "set Lockdown=No"
call :SignInNow "%User2%" "%Password%"
call :CheckStatus Yes "set Lockdown=No"
if "%Lockdown%"=="No" goto :Lockdown_Over&cls
echo.>"SDS_Files\Security\60Bk.sys"&attrib +h +s "SDS_Files\Security\60Bk.sys"
title Password Incorrect! - SD-Security�&mode con: cols=51 lines=11&color fc
echo ��������������������������������������������������
echo �    SD-Security Is Currently In Lockdown Mode   �
echo ��������������������������������������������������
echo �                                                �
echo �     The Password You Entered Was Incorrect!    �
echo �                                                �
echo �      Access To Everything Has Been Blocked     �
echo �      Until The Correct Password Is Entered     �
echo �                                                �
echo ��������������������������������������������������
timeout 10 >nul&exit 999
:60Bk
mode con: cols=51 lines=11&set "Timeout=61"
:60Bk_Loop
set /a Timeout=%Timeout%-1 >nul 2>&1
title %Timeout% Seconds Remaining...&cls
echo ��������������������������������������������������
echo �    SD-Security Is Currently In Lockdown Mode   �
echo ��������������������������������������������������
echo �                                                �
echo �             Please Wait 60 Seconds             �
echo �   Then You Can Attempt To Unblock SD-Security  �
echo �                                                �
echo ��������������������������������������������������
echo.&echo               %Timeout% Seconds Remaining...&timeout 1 /nobreak >nul
if "%Timeout%"=="0" goto :60Bk_Finished
goto :60Bk_Loop
:Lockdown_Over
if exist "SDS_Files\Security\Lockdown.sys" (attrib -h -s "SDS_Files\Security\Lockdown.sys"&del "SDS_Files\Security\Lockdown.sys")&goto :CrashHelper
:ClearLockdown
if not exist "SDS_Files\Security\PasswordAttempts.sys" goto :EOF
attrib -h -s "SDS_Files\Security\PasswordAttempts.sys"
del "SDS_Files\Security\PasswordAttempts.sys"
goto :EOF
:Download
set "Downloaded=No"
if "%~1"=="" (goto :EOF) else (if "%~2"=="" goto :EOF)
set "DownloadSource=%~1"
set "SaveLocation=%~2"
:DownloadRetry
if exist "%SaveLocation%" del "%SaveLocation%" >nul 2>&1
powershell -nologo Invoke-WebRequest -OutFile "%SaveLocation%" "%DownloadSource%" >nul 1>&2
if not "%errorlevel%"=="0" if "%errorlevel%"=="9009" call Download_Error_Powershell&goto :EOF||goto :Download_Error_Average
if not exist "%SaveLocation%" (goto :Download_Error_Average) else (set "Downloaded=Yes"&goto :EOF)
:Download_Error_Powershell
cls
title ERROR: Please Install Powershell - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���               Install Powershell                 %status%
echo �������������������������������������������������������������������������������
echo.
echo         In Order To Download Files, The Latest Version Of Powershell Has
echo  To Be Installed On This PC! This Is Required To Download Updates From The Web
echo.
echo                            Press Any Key To Continue
pause >nul
goto :EOF
:Download_Error_Average
echo.
echo ^^                      ERROR! See Above For More Details                      ^^
pause >nul
cls
title ERROR: Unexpected Download Problem - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 SD-Updater Error                 %status%
echo �������������������������������������������������������������������������������
echo.
echo           There Was An Error While Downloading The Requested Resource,
echo               Please Check Your Internet Connection And Try Again
echo.
echo     If You Keep Getting This Error, Check That Your Firewall Isn't Blocking
echo     Windows Powershell From Accessing The Internet. If This Issue Persists
echo                 Then Please Manually Download The Requested File
echo.
echo �1�  Retry
echo �2�  Cancel Download
%set /p% Download_Error_Average="�� "
if "%Download_Error_Average%"=="1" goto :DownloadRetry
goto :EOF
:FileDownloader
cls
title File Downloader - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                  File Downloader                 %status%
echo �������������������������������������������������������������������������������
echo.
echo Please Enter The File URL To Download:
echo.
echo   eg. http://SD-Storage.weebly.com/files/theme/favicon.ico
%set /p% FileToDownload="�� "
echo.
echo Please Enter Where To Save The File To:
echo   eg. C:\Users\%username%\Downloads\My New Favicon.ico
echo.
%set /p% FileToSave="�� "
echo.
call :Download "%FileToDownload%" "%FileToSave%"
if "%Downloaded%"=="Yes" (echo File Downloaded) else (echo There Was An Error Whilst Downloading The File)
echo.
echo Do You Want To Download Another File?
echo �1�  Yes
echo �2�  No
%set /p% "DwNewFile=�� "
if "%DwNewFile%"=="1" goto :FileDownloader
goto :home


:end
call :plugins preexit
if exist "SDS_FILES\Sessions\Default*" goto backupSession
color f0
:end2
mode con: cols=38 lines=18
call :setTime&echo ^|^|Log^|^|  ^|Info: EXIT^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
cls
title Exit - SD-Security�
echo �������������������������������������
echo ��� SD-Security ���  EXIT  Signed Out
echo �������������������������������������
echo.
echo     �����������������������������
echo.    � � � � � � � � � � � � � � �
echo     �����������������������������
echo     � �    �������.           � �
echo     ���     \  /�  \.         ���
echo     � �      \/ �    \.       � �
echo     ���      /\ �      \.     ���
echo     � �     /  \�        \    � �
echo     ���   �����������������   ���
echo     � �   �%year% SD-Security   � �
echo     �����������������������������
echo     � � � � � � � � � � � � � � �
echo     �����������������������������
timeout 2 >nul /nobreak
color f8&call :Wait 1&color f7&call :Wait 1&cls
call :plugins onexit
endlocal
exit 999
:Quickend
call :setTime&echo ^|^|Log^|^|  ^|Info: EXIT^| ^|Time: %twelve%^| ^|Date: %date2%^| >> "SDS_Files\Security\SD-Security.SDS_LOG"
call :plugins onexit
endlocal
exit 999