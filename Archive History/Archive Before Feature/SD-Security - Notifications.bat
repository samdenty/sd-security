@echo off
:StartOfScript
if exist "SafeMode.*" goto Safe_Mode
REM Rename SD-Security Application To SD-Security.exe
if exist "SDS_Files\Delete_Old_SD-Security.tmp" goto deleteOldSDsecurity
cls
color f0
Title Loading - SD-Security
mode con: cols=24 lines=3
echo.
echo        Loading...
goto securitylog
:back1
set notifications=0
if not exist "autorun.inf" goto makeautorun
:back2
goto Killpcres
:back3
if not exist "SDS_FILES" goto makeSDSFILES
if not exist "SDS_FILES\SD-Settings.ini" goto makesettings
:back4
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f
for /F "delims=" %%A in (SDS_FILES\SD-Settings.ini) do set %%A
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:n
cls
echo.
echo        Loading...
if exist "SDS_FILES\SD-Settings.ini" if %Dev_Mode%==yes goto back5
if not exist "Favicon.ico" goto makefavicon
:back5b
if not exist "SD-Security.*" goto rename
:back5
mode con: cols=80 lines=26
if %Used_Before%==no goto welcome
:back6
cls
:Bug101checker
set drv=%cd:~0,2%
if %Hide_Bug_101%==yes goto setpasswords
if exist %drv%\Bug101Checker.tmp del %drv%\Bug101Checker.tmp
@echo 1 > %drv%\Bug101Checker.tmp:stream
if exist %drv%\Bug101Checker.tmp set Bug_101_Vuln_2=no&del %drv%\Bug101Checker.tmp&goto Bug101SettingsChecker
if not exist %drv%\Bug101Checker.tmp set Bug_101_Vuln_2=yes&cls
:Bug101SettingsChecker
cls
if %Bug_101_Vuln%==%Bug_101_Vuln_2% goto skipBug101ReWrite
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f
echo Dev_Mode=%Dev_Mode% > "SDS_FILES\SD-Settings.ini"
echo Used_Before=%Used_Before% >> "SDS_FILES\SD-Settings.ini"
echo Trial_Mode=%Trial_Mode% >> "SDS_FILES\SD-Settings.ini"
echo Bug_101_Vuln=%Bug_101_Vuln_2% >> "SDS_FILES\SD-Settings.ini"
echo Hide_Bug_101=%Hide_Bug_101% >> "SDS_FILES\SD-Settings.ini"
echo Security_Breach_Key=%Security_Breach_Key% >> "SDS_FILES\SD-Settings.ini"
echo Theme=%Theme% >> "SDS_FILES\SD-Settings.ini"
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:n
:skipBug101ReWrite
if %Bug_101_Vuln_2%==yes goto Bug101Yes

:SetPasswords
goto encryptVaribles
:SetPasswords2
REM Account 1 (ADMIN ACCOUNT)
@echo off
set user21=%h%%z%%n%%w%%v%%m%%g%%b%%ad%%ad% >nul
@echo off
set %k%%z%%h%%h%%d%%l%%i%%w%=%v%%v%%y%%y%%x%%z%%u%%y%%ag%%aj%%aj%%ae% >nul

REM Account 2 (FALSE USER)
@echo off
set user%ag%%ag%=admin >nul
@echo off
set %k%%z%%h%%h%%d%%l%%i%%w%%ag%=%v%%v%%y%%y%%x%%z%%u%%y%%ag%%aj%%aj%%ae% >nul
goto home


REM           Homescreens
REM Logged Out
:Home
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
attrib +h +s "Favicon.ico"
cls
echo ^|^|Log^|^|  ^|Info: Home^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if %status%==Signed-In goto home2
if %status%==HACKED! goto home2
cls
title Home - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                   Home                           %status%
echo ===============================================================================
echo.
echo л1л  Lost ^& Found
echo л2л  Sign In
echo л3л  About
echo л4л  Commands
echo л5л  Encrypto
echo л6л  Exit
echo.
set /p op="л: "
if %op%==1 goto Lost
if %op%==2 goto signin
if %op%==3 goto about
if %op%==4 goto commands
if %op%==p goto portableapps
if %op%==P goto portableapps
if %op%==5 goto signin
if %op%==6 goto end
goto error

REM Logged-In
:Home2
set notifications=0
if exist "SDS_Files\*.SDS_Found_LOG" set/a notifications=%notifications% +1
cls
if not %status%==Signed-In goto home
if exist ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" set unLockOrLock=Unlock&goto Home2Skip
if exist "Unlocked" set unLockOrLock=Lock&goto Home2Skip
set unLockOrLock=Create
:Home2Skip
if not %status%==Signed-In goto home
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
cls
if %notifications%==0 title Home - SD-Security&goto home2skip2
title (%notifications%) Home - SD-Security
:home2skip2
if %notifications%==0 set thirdBar================================================================================&goto home2Skip3
set thirdBar=========================== You Have %Notifications% Notifications ===========================
:home2skip3
if not %status%==Signed-In goto home
cls
echo ===============================================================================
echo ====SD-Security====                   Home                           %status%
echo %thirdbar%
echo.
echo л1л  %unLockOrLock% Private Data
echo л2л  Sign In
echo л3л  About
echo л4л  Other
echo л5л  Encrypto
echo л6л  Exit
echo.
set /p op="л: "
if %op%==1 goto privatedata
if %op%==2 goto signin
if %op%==3 goto about
if %op%==4 goto other
if %op%==5 goto encrypto
if %op%==6 goto end
goto error
:error
echo ^|^|Log^|^|  ^|Info: Error_Command; '%op'^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
color c4
echo л%op%л is not a valid option, Please enter a number above and press enter
pause >nul
goto Home


REM Lost And Found
:lost
echo ^|^|Log^|^|  ^|Info: Lost ^& Found^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
title Lost ^& Found - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                 Lost ^& Found                    %status%
echo ===============================================================================
echo     This Log Is A OFFLINE One Meaning That You Have To Complete The One At
echo      SD-Storage.weebly.com/usb.html (Website Will Be Launched Automatically)
echo ===============================================================================
echo.
set /p firstname="First Name л: "
set /p surname="Surname л: "
set /p phonenumber="Phone Number л: "
set /p email="Email Address л: "
goto devicelog
:devicelog
cls
echo ===============================================================================
echo ====SD-Security====                 Lost ^& Found                    %status%
echo ===============================================================================
echo     This Log Is A OFFLINE One Meaning That You Have To Complete The One At
echo      SD-Storage.weebly.com/usb.html (Website Will Be Launched Automatically)
echo ===============================================================================
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
echo Time: %time%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Date: %date%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Email: %email%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Phone: %phonenumber%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo.>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Computer Info >> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo ------------- >> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
echo Username: %username%>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
net user>> "SDS_Files\Device Found By %firstname%.SDS_Found_LOG"
:lostCompleted
echo ^|^|Log^|^|  ^|Info: Lost ^& Found^| ^|Name: %Firstname% %surname%^| ^|Email: %email%^| ^|Phone: %phonenumber%^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Thank You - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                Lost and Found                    %status%
echo ===============================================================================
echo.
echo                           Your Details Have Been Logged.
echo       Please go to "http://sd-storage.weebly.com/usb" and complete the form
echo         There Is A 80%% Chance That You Will Get A Reward (Maybe Cash)
echo                                    Website Opened
start http://sd-storage.weebly.com/usb
goto home


REM Private Data
:Privatedata
if not %status%==Signed-In goto home
echo ^|^|Log^|^|  ^|Info: Private Data^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Private Data - SD-Security
if exist ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" goto unlock
if not exist Unlocked goto mdlocker
:CONFIRM
if not %status%==Signed-In goto home
title Please Confirm - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo Press any key to start encrypting Private Data
pause >nul
:lock
if not %status%==Signed-In goto home
title Locking - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
ren Unlocked ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
echo Stage 1 completed
attrib +h +s +r +a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
echo Stage 2 completed
echo y| cacls .Locked.{645FF040-5081-101B-9F08-00AA002F954E} /T /P everyone:N
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo Stage 1 completed
echo Stage 2 completed
echo Stage 3 completed
color 2a
echo PRIVATE DATA EN-CRYPTED!
echo ^|^|Log^|^|  ^|Info: Private Data Locked^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
pause >nul
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
goto home

:unlock
if not %status%==Signed-In goto home
cls
title Enter Password - SD-Security
If Exist "%sds%" goto breach
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
set/p "pass=Enter Password л: "
if NOT %pass%==%password% goto denied
goto unlocking
:Unlocking
if not %status%==Signed-In goto home
title Unlocking - SD-Security
echo ^|^|Log^|^|  ^|Info: Private Data Unlocked^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
echo y| cacls .Locked.{645FF040-5081-101B-9F08-00AA002F954E} /T /P everyone:F
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo Enter Password л: ********
echo.
echo Stage 1 completed
attrib -h -s -r -a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
echo Stage 2 completed
ren .Locked.{645FF040-5081-101B-9F08-00AA002F954E} "Unlocked"
echo Stage 3 Completed
color 2a
echo PRIVATE DATA DE-CRYPTED
pause >nul
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
goto home
:breach
if not exist "%sds%" goto home
title Security Breach - SD-Security
echo ^|^|Log^|^|  ^|Info: Master Overide Attempted^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
color C4
title WARNING - SD-Security
echo          _    _    ___   ______   _   _  _____   _   _   ______
echo         : :  : :  / _ \  : ___ \ : \ : ::_   _: : \ : : :  ____\
echo         : :  : : : /_\ : : :_/ / :  \: :  : :   :  \: : : :
echo         : :/\: : :  _  : :    /  : . ` :  : :   : . ` : : :  ___
echo         \  /\  / : : : : : :\ \  : :\  : _: :_  : :\  : : :__\ \
echo          \/  \/  \_: :_/ \_: \_\ :_: \_/ \___/  \_: \_/  \_____/
echo.
echo    Due to no password being entered, the Vault can't be decrypted normally
echo                 (Files Are Lightly Encrypted With Password)
echo          DO YOU WISH TO TRY TO HACK SD-SECURITY DATA VAULT Y/N ?
set /p optionHACK="л: "
if %optionHACK%==y goto HACKloopSTART
if %optionhack%==Y goto HACKloopSTART
del %sds%
goto home
:HACKloopSTART
set ic=-
:loop
if not exist "%sds%" goto home
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
if %loopnums%==29 set ender=%ic%                                   s
if %loopnums%==30 set ender=
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo Enter Password л: %wholebreachnum%%ender%
if %loopnums%==30 goto outofloopnum
echo ACCESS DENIED!
color 4c
ping 192.0.2.1 -n 1 -w 1 >nul
color df
goto loop
:outofloopnum
if not exist "%sds%" goto home
color 4f
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 25%%                       л лллллллл                         л
timeout 1 >nul /nobreak
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 50%%                       л лллллллллллллллл                 л
timeout 1 >nul /nobreak
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 75%%                       л лллллллллллллллллллллллл         л
timeout 1 >nul /nobreak
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo                    Please Wait.. Converting To ASCII Text...
echo.
echo 100%%                      л лллллллллллллллллллллллллллллллл л
echo.
echo                                      FINSIHED
timeout 1 >nul /nobreak
echo ^|^|Log^|^|  ^|Info: Master Overide Successful^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
color 2a
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo Enter Password л: ******************************
echo ACCESS GRANTED!
echo y| cacls .Locked.{645FF040-5081-101B-9F08-00AA002F954E} /T /P everyone:F
cls
echo ===============================================================================
echo ====SD-Security====                Private Data                      %status%
echo ===============================================================================
echo.
echo Enter Password л: ******************************
echo ACCESS GRANTED!
echo.
echo Stage 1 completed
attrib -h -s -r -a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
echo Stage 2 completed
ren .Locked.{645FF040-5081-101B-9F08-00AA002F954E} "Unlocked"
echo Stage 3 Completed
color 2a
echo PRIVATE DATA DE-CRYPTED
echo ^|^|Log^|^|  ^|Info: Private Data Unlocked^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
del "%sds%"
pause >nul
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
goto home
:denied
title Access Denied - SD-Security
echo ^|^|Log^|^|  ^|Info: Login Failed^| ^|Username: %Username2%^| ^|Password: %userpaswrd% ^| %pass%^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
color 4C
echo THE INFORMATION YOU ENTERED IS INCORRECT!
pause >nul
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
goto home
:MDLOCKER
echo ^|^|Log^|^|  ^|Info: Private Data Folder Created^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Setting Up Vault Folder - SD-Security
md Unlocked
echo Private Data Vault Created (Use the Unlocked Folder)
echo Press Any Key To Go Home
pause >nul
goto home


REM About
:about
cls
echo ^|^|Log^|^|  ^|Info: About^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title About - SD-Security
start http://SD-Storage.weebly.com
echo ===============================================================================
echo ====SD-Security====                      About                       %status%
echo ===============================================================================
echo              Our Website Has Just Been Opened In Your Default Browser
echo   If You Have Found This On A SD-card Or USB That Doesnt Belong To You Please
echo   Choose лLost ^& Foundл On The Homescreen And Enter Your Details, There Is
echo             A 50%% Chance That You Will Get A Reward For Returning It
echo.
echo                 This security was designed by Samuel D. Denty
echo This security can be breached by the 'Master Overide' feature that is randomly
echo                             made for each Security App
echo                    This security uses 128-bit AES Encryption
echo.
echo                             Press any key to go home
pause >nul
goto home


REM Sign In
:SIGNIN
echo ^|^|Log^|^|  ^|Info: Sign In^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if %status%==Signed-In goto signout
If Exist "%sds%" goto AdminSignIn
title Sign In - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                      Sign In                     Signing In
echo ===============================================================================
echo Enter лUSBл To Login With USB
set/p username2="Enter Username л: "
if %username2%==USB goto usblogin
if %username2%==usb goto usblogin
if %username2%==Usb goto usblogin
set/p userpaswrd="Enter Password л: "
REM enter account goto here
:passwordchecker
if %username2%==%user21% goto user21
if %username2%==%user22% goto user22
goto denied
:SIGNINUSB
echo ^|^|Log^|^|  ^|Info: Sign In^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Sign In - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                      Sign In                     Signing In
echo ===============================================================================
set/p username2="Enter Username л: "
set/p userpaswrd="Enter Password л: "
REM Goto Account Login Credidentials Checker
if %username2%==%user21% goto user21b
if %username2%==%user22% goto user22b
goto denied

:signout
echo ^|^|Log^|^|  ^|Info: Sign Out^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Sign Out - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                      Sign Out                           N/A
echo ===============================================================================
echo You are all ready signed in as "%username2%",
echo Would you like to sign out?
echo л1л  Yes
echo л2л  No
set/p signout2="л: "
if %signout2%==1 goto signoutyes
if %signout2%==2 goto home
goto ERROR
:signoutyes
%h%%v%%g% %h%%g%%z%%g%%f%%h%=S%r%%t%%m%%v%%w%-O%f%%g%
goto home


REM Other
:other
echo ^|^|Log^|^|  ^|Info: Other^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Other - SD-Security
echo ===============================================================================
echo ====SD-Security====                         Other                    %status%
echo ===============================================================================
echo л1л  Notifictions
echo л2л  Open Security Log
echo л3л  Back
set /p other="л: "
if %other%==1 goto Notifications
if %other%==2 goto openlog
if %other%==3 goto home
goto home
:Notifications
cls
echo ^|^|Log^|^|  ^|Info: Notifications^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Notifications - SD-Security
echo ===============================================================================
echo ====SD-Security====                  Notifications                   %status%
echo ===============================================================================
echo.
echo                       You Have %Notifications% Notifications
if %Notifications%==0 goto noNotifications
if exist "SDS_Files\*.SDS_Found_LOG" set lstnfnd=1
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo л No. Of Lost ^& Found Logs      л %lstnfnd%
echo л No. Of Security Hack Attempts л 0
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo                             Press Any Key To Go Home
pause >Nul
goto home
:noNotifications
echo                             Press Any Key To Go Home
pause >Nul
goto home
:Slfdrct
echo ^|^|Log^|^|  ^|Info: Quick Erase^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
Start %MYFILES%\SDS_FILES\copy.bat
goto quickend
:openlog
echo ^|^|Log^|^|  ^|Info: Security Log Viewed^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Opening Log - SD-Security
copy SDS_Files\SD-Security.SDS_LOG "SDS_Files\tmp.txt"
echo /////////////////////// >> "SDS_Files\tmp.txt"
echo DON'T RESAVE THIS FILE! >> "SDS_Files\tmp.txt"
echo /////////////////////// >> "SDS_Files\tmp.txt"
start SDS_Files\tmp.txt
set/a deletenum=10
:deleteloop
title %deletenum% Seconds Until Temp. Log Deleted - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                         Other                    %status%
echo ===============================================================================
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
goto home
:cantdeletelog
:deletelogloop2
if not exist "SDS_Files\tmp.txt" goto home
cls
echo ===============================================================================
echo ====SD-Security====                         Other                    %status%
echo ===============================================================================
echo.
echo          Can't Delete Tempory Log, Please Close Log When Done
del SDS_Files\tmp.txt
goto deletelogloop2
:commands
echo ^|^|Log^|^|  ^|Info: SD-Commandr^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
color 07
title C:\windows\system32\cmd.exe
cls
echo Microsoft Windows [Version 6.3.9600]
echo (c) 2013 Microsoft Corporation. All rights reserved.
echo.
set /p cmd="C:\Users\%username%>"
if %cmd%==minecraft goto minecraft
if %cmd%==exitEXIT goto end
if %cmd%==CLOSE goto end
if %cmd%==SHUTDOWN shutdown /p
if %cmd%==HOME goto check
echo Please Enter A Valid Command
pause >nul
goto commands
REM accounts
:user21
if NOT %userpaswrd%==%password% goto denied
echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %username2%^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto home
:autologinhack
echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: USB Drive| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto home
:user22
if NOT %userpaswrd%==%password2% goto denied
echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %username2%^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto home
:user21b
if NOT %userpaswrd%==%password% goto denied
echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %username2%^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto setupusb
:user22b
if NOT %userpaswrd%==%password2% goto denied
echo ^|^|Log^|^|  ^|Info: Signed In^| ^|User: %username2%^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-In
goto setupusb


REM Security Breach
:AdminSignIn
title Security Breach - SD-Security
set status=   HACKED!
echo ^|^|Log^|^|  ^|Info: Overide Password Successful^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
goto home

REM Loading Sequence
:securitylog
echo.>> "SDS_Files\SD-Security.SDS_LOG"
echo ^|^|SD-Security Opened^|^|  ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
set status=Signed-Out
goto back1
:makeautorun
echo ^|^|Log^|^|  ^|Info: Autorun File Created^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Loading - SD-Security
echo [autorun]>> "autorun.inf"
echo Open=SD-Security.exe>> "autorun.inf"
echo ShellExecute=System\SD-Security.exe>> "autorun.inf"
echo shell\open\command=SD-Security.exe>> "autorun.inf"
echo shell\open=Open SD-Security>> "autorun.inf"
echo Action=Open SD-Security>> "autorun.inf"
echo Icon=Favicon.ico>> "autorun.inf"
echo Label=SD-SecurityЎ>> "autorun.inf"
echo UseAutoplay=1 >> "autorun.inf"
echo.>> "autorun.inf"
echo [Content]>> "autorun.inf"
echo MusicFiles=false>> "autorun.inf"
echo PictureFiles=false>> "autorun.inf"
echo VideoFiles=false>> "autorun.inf"
attrib +h +s "autorun.inf"
cls
goto back2
:KillPcRES
REM this kills the time limit for PC_Reservation
taskkill /f /im "PCRes_Client.exe"
cls
goto back3
:makeSDSFILES
echo ^|^|Log^|^|  ^|Info: SD-Security Folder Made^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
md SDS_FILES
attrib +h +s "SDS_FILES"
echo This Folder (SDS_FILES) exists to store Temp Files and other things that SD-Security Uses>> "%MYFILES%\SDS_FILES\README.TXT"
echo If you Delete this folder it will be made again but making it again occours at the start of sam denty security>> "%MYFILES%\SDS_FILES\README.TXT"
echo Meaning That SD-Security Will Take Longer To Load and some features will not work correctly, you can delete this file (README.TXT) if you want>> "%MYFILES%\SDS_FILES\README.TXT"
goto back3
:rename
echo ^|^|Log^|^|  ^|Error: 100^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
COLOR C4
mode con: cols=80 lines=26
echo.
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo  л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л  л
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл л
echo  л лллл         лллл        лллллл        лллллллл     ллллллл        ллллллллл
echo  лллллл лллллллллллл ллллллл ллллл ллллллл лллллл ллллл лллллл ллллллл лллллл л
echo  л лллл лллллллллллл лллллллл лллл лллллллл лллл ллллллл ллллл лллллллл ллллллл
echo  лллллл лллллллллллл ллллллл ллллл ллллллл лллл ллллллллл лллл ллллллл лллллл л
echo  л лллл         лллл        лллллл        ллллл ллллллллл лллл        ллллллллл
echo  лллллл лллллллллллл лллл лллллллл лллл ллллллл ллллллллл лллл лллл ллллллллл л
echo  л лллл лллллллллллл ллллл ллллллл ллллл ллллллл ллллллл ллллл ллллл ллл100лллл
echo  лллллл лллллллллллл лллллл лллллл лллллл ллллллл ллллл лллллл лллллл ллллллл л
echo  л лллл         лллл ллллллл ллллл ллллллл ллллллл     ллллллл ллллллл лллллллл
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл л
echo  л л                                                                        ллл
echo  ллл      Due To Security Reasons, The SD-Security EXE Has To Be Named      л л
echo  л л      SD-Security.exe, We Could Automate This Process By Doing It       ллл
echo  ллл        For You, But It Would Require A Additional EXE. So Just         л л
echo  л л    Do It Yourself. TASK: Rename The SD-Security EXE To SD-Security     ллл
echo  ллл                                                                        л л
echo  л лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo  ллл Would You Like To Hide This Error Next Time? Recommended Not To Ignore л л
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo л1л Yes
echo л2л No
set /p HideError100="л: "
if %Hideerror100%==1 echo This File Hides Error101>> "SD-Security.tmp"&attrib +h +s "SD-Security.tmp"&goto back5
goto back5
:rename2
cls
copy *.exe "SD-Security.exe"
echo Delete_Exe=%0 >> "SDS_Files\Delete_Old_SD-Security.tmp"
SD-Security.exe
:makefavicon
attrib +h +s "Favicon.ico"
goto back5b
:welcome
echo ^|^|Log^|^|  ^|Info: Welcome To SD-Security^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Welcome To SD-Security
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f
cls
echo Dev_Mode=%Dev_Mode% > "SDS_FILES\SD-Settings.ini"
echo Used_Before=yes >> "SDS_FILES\SD-Settings.ini"
echo Trial_Mode=%Trial_Mode% >> "SDS_FILES\SD-Settings.ini"
echo Bug_101_Vuln=%Bug_101_Vuln% >> "SDS_FILES\SD-Settings.ini"
echo Hide_Bug_101=%Hide_Bug_101% >> "SDS_FILES\SD-Settings.ini"
echo Security_Breach_Key=%Security_Breach_Key% >> "SDS_FILES\SD-Settings.ini"
echo Theme=%Theme% >> "SDS_FILES\SD-Settings.ini"
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:n
cls
echo ===============================================================================
echo ====SD-Security====                    Welcome                       %status%
echo ===============================================================================
echo                               Welcome to SD-Security,
echo.
echo               A very compatible software, that runs entirely on CMD
echo               And uses ony the keyboard to navigate your way around
echo                    Here are the basics to using this software:
echo.
echo.
echo 1. To navigate around: Use the numbers (0-9) on the keyboard to select a option
echo         after you type the number you want, press ENTER on the keyboard
echo.
echo 2.               Everything in this application is CASe SENsitIVE
echo.
echo                           Press Any Key To Continue
pause >nul
cls
echo ===============================================================================
echo ====SD-Security====                    Welcome                       %status%
echo ===============================================================================
echo                               Welcome to SD-Security,
echo.
echo               A very compatible software, that runs entirely on CMD
echo               And uses ony the keyboard to navigate your way around
echo                    Here are the basics to using this software:
echo.
echo.
echo 1. To navigate around: Use the numbers (0-9) on the keyboard to select a option
echo         after you type the number you want, press ENTER on the keyboard
echo.
echo 2.               Everything in this application is CASe SENsitIVE
echo.
echo 3. This application is meant for USB sticks, but works fine on hard drives too
echo.
echo 4.     This programs source code was written by Samuel D. Denty (XLR8) as
echo                                Open-Source software
echo.
echo Would You Like To Navigate Around A Demo Menu?
echo л1л  Yes
echo л2л  No (Start Using Now)
set /p demo="л: "
if %demo%==1 goto demo
if %demo%==2 goto back6
color 4C
echo Please press the number 1 or 2 on your keyboard and then press ENTER
pause >nul
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
goto welcome
:demo
echo ^|^|Log^|^|  ^|Info: Demo^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Demo - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                    Welcome                       %status%
echo ===============================================================================
echo  Welcome to SD-Security, A very compatible software, that runs entirely on CMD
echo          And uses ony the keyboard to navigate your way around
echo ===============================================================================
echo.
echo Here is a demo:
echo.
echo л1л  Home
echo л2л  Back
echo л3л  About
echo [exit] : Exit this application (CaSe SeNsItIvE)
set /p demo="л: "
if %demo%==1 goto back6
if %demo%==2 goto welcome
if %demo%==3 goto about
if %demo%==exit goto end
color 4C
echo л%demo%л is not a valid choice, enter a number from 1-3 or exit and press ENTER
echo Press any key to go back.
pause >nul
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
goto demo

REM Portable Apps
:portableapps
echo ^|^|Log^|^|  ^|Info: Portable Apps^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Portable Apps - SD-Security
echo ===============================================================================
echo ====SD-Security====                 Portable Apps                    %status%
echo ===============================================================================
Echo Searching For Application...
if not exist "Start.exe" goto noportableapps
start "Start.exe"
goto end
:noportableapps
echo ^|^|Log^|^|  ^|Info: No Portable Apps^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
title Error - SD-Security
color 4C
echo ===============================================================================
echo ====SD-Security====                       Error                      %status%
echo ===============================================================================
echo We Have Not Detected A Installation Of лPortable Appsл On This Drive,
echo Please Install It At лPortableApps.comл And Choose The Root Of This Drive.
echo If It Is Already Installed Make Sure The Application Has The Name лStart.exeл
pause >nul
goto home

REM START OF USB LOGIN
:usblogin
echo ^|^|Log^|^|  ^|Info: Sign In With USB^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title USB Authentication
echo ===============================================================================
echo ====SD-USB====                        Home                                  %drive%
echo ===============================================================================
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
echo ===============================================================================
echo ====SD-USB====                        Home                                  %drive%
echo ===============================================================================
echo.
echo The Current USB Drive Hasn't Been Setup, Do You Want To Replace Current USB
echo With This One?
echo.
echo л1л  Yes
echo л2л  No
set /p replaceusbkeyanddelteoldone="л:"
if %replaceusbkeyanddelteoldone%==1 goto continuetosignin
if %replaceusbkeyanddelteoldone%==2 goto home
echo INVALID CHOICE
pause >nul
goto setupusb
:continuetosignin
if %status%==Signed-In goto continue
if %status%==HACKED! goto continue
goto SIGNINUSB
:continue
echo ^|^|Log^|^|  ^|Info: USB Drive Keys Updated^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
echo ===============================================================================
echo ====SD-USB====                        Home                                  %drive%
echo ===============================================================================
echo.
echo Configuring Drive...
set newkey=%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%
if exist "%drive%SD-Security.sds_usb_key" del %drive%SD-Security.sds_usb_key
echo key=%newkey%> "%drive%SD-Security.sds_usb_key"
attrib +a +s +h +r "%drive%SD-Security.sds_usb_key"
attrib -a -s -h -r "%lk%"
echo last_key=%newkey%> "%lk%"
attrib +a +s +h +r "%lk%"
:LOADING
echo ^|^|Log^|^|  ^|Info: USB Drive Setup^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo ===============================================================================
echo ====SD-USB====                        Home                                  %drive%
echo ===============================================================================
echo.
echo Configuring Drive...
echo.
set load=%load%л
echo ===============================================================================
echo       Loading %loadnumber%     =   %load%
echo ===============================================================================
echo                              DO NOT REMOVE USB DRIVE!
ping localhost -n 1 >nul
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
echo ===============================================================================
echo ====SD-USB====                        Home                                  %drive%
echo ===============================================================================
echo.
echo We Have Found A Key Stored On The Current USB, Would You Like To Overwrite?
echo If This USB Was Used By Another Computer, Then You Should Select No
echo л1л  No
echo л2л  Yes
set /p erasecurrentkeyforsdusb="л: "
if %erasecurrentkeyforsdusb%==2 goto setupusb
goto home
:incorrect
echo ^|^|Log^|^|  ^|Info: Sign In Failed (USB)^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo ===============================================================================
echo ====SD-USB====                        Home                                  %drive%
echo ===============================================================================
echo.
echo                            U S B   I N C O R R E C T !
pause >nul
goto home
:correct
cls
echo ===============================================================================
echo ====SD-USB====                        Home                                  %drive%
echo ===============================================================================
echo.
echo                               Drive Authenticated!
echo                           RE-BUILDING ENCRYPTION KEYS...
echo.
set newkey=%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%-%random%
echo                              ллллллллллллллллллллллл
echo                              л Step 1 : Successful л
attrib -a -s -h -r "%drive%SD-Security.sds_usb_key"
echo                              л Step 2 : Successful л
echo key=%newkey%> "%drive%SD-Security.sds_usb_key"
echo                              л Step 3 : Successful л
attrib +a +s +h +r "%drive%SD-Security.sds_usb_key"
echo                              л Step 4 : Successful л
attrib -a -s -h -r "%lk%"
echo                              л Step 5 : Successful л
echo last_key=%newkey%> "%lk%"
echo                              л Step 6 : Successful л
attrib +a +s +h +r "%lk%"
echo                              л Step 7 : Successful л
echo                              ллллллллллллллллллллллл
echo                              л Steps  : Successful л
echo                              ллллллллллллллллллллллл
timeout 1 >nul
goto autologinhack
REM END OF USB LOGIN

:makesettings
echo ^|^|Log^|^|  ^|Info: Settings For SD-Security Made^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if exist %drv%\Bug101Checker del %drv%\Bug101Checker
@echo 1 > %drv%\Bug101Checker:stream
if exist %drv%\Bug101Checker set Bug_101_Vuln=no&del %drv%\Bug101Checker
if not exist %drv%\Bug101Checker set Bug_101_Vuln=yes
cls
echo Dev_Mode=no > "SDS_FILES\SD-Settings.ini"
echo Used_Before=no >> "SDS_FILES\SD-Settings.ini"
echo Trial_Mode=yes >> "SDS_FILES\SD-Settings.ini"
echo Bug_101_Vuln=%Bug_101_Vuln% >> "SDS_FILES\SD-Settings.ini"
echo Hide_Bug_101=no >> "SDS_FILES\SD-Settings.ini"
echo Security_Breach_Key=%random%7%random%5%random% >> "SDS_FILES\SD-Settings.ini"
echo Theme=dark_aqua >> "SDS_FILES\SD-Settings.ini"
goto back4

:Bug101Yes
echo ^|^|Log^|^|  ^|Error: 101^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
title Bug 101 Vulnerable- SD-Security
color C4
mode con: cols=80 lines=26
echo.
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo  л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л  л
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл л
echo  л лллл         лллл        лллллл        лллллллл     ллллллл        ллллллллл
echo  лллллл лллллллллллл ллллллл ллллл ллллллл лллллл ллллл лллллл ллллллл лллллл л
echo  л лллл лллллллллллл лллллллл лллл лллллллл лллл ллллллл ллллл лллллллл ллллллл
echo  лллллл лллллллллллл ллллллл ллллл ллллллл лллл ллллллллл лллл ллллллл лллллл л
echo  л лллл         лллл        лллллл        ллллл ллллллллл лллл        ллллллллл
echo  лллллл лллллллллллл лллл лллллллл лллл ллллллл ллллллллл лллл лллл ллллллллл л
echo  л лллл лллллллллллл ллллл ллллллл ллллл ллллллл ллллллл ллллл ллллл ллл101лллл
echo  лллллл лллллллллллл лллллл лллллл лллллл ллллллл ллллл лллллл лллллл ллллллл л
echo  л лллл         лллл ллллллл ллллл ллллллл ллллллл     ллллллл ллллллл лллллллл
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл л
echo  л л                                                                        ллл
echo  ллл    Security Is Compromised On FAT / FAT32 Drives Due To The Lack Of    л л
echo  л л Permissions. We Recommend To Format This Drive In NTFS To Fix This Bug ллл
echo  ллл   This Bug Isn't A Unfixed Problem, More Like A Un-Added Feature That  л л
echo  л л                         FAT Drives Don't Have                          ллл
echo  ллл                                                                        л л
echo  л лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo  ллл Would You Like To Hide This Error Next Time? Recommended Not To Ignore л л
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo л1л No
echo л2л Yes
Set errorlevel=0
CHOICE /C 12 /N /M "л: "
IF ERRORLEVEL 2 goto NeverShowError101
IF ERRORLEVEL 1 goto setpasswords
goto setpasswords

:NeverShowError101
cls
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo  л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л  л
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл л
echo  л лллл         лллл        лллллл        лллллллл     ллллллл        ллллллллл
echo  лллллл лллллллллллл ллллллл ллллл ллллллл лллллл ллллл лллллл ллллллл лллллл л
echo  л лллл лллллллллллл лллллллл лллл лллллллл лллл ллллллл ллллл лллллллл ллллллл
echo  лллллл лллллллллллл ллллллл ллллл ллллллл лллл ллллллллл лллл ллллллл лллллл л
echo  л лллл         лллл        лллллл        ллллл ллллллллл лллл        ллллллллл
echo  лллллл лллллллллллл лллл лллллллл лллл ллллллл ллллллллл лллл лллл ллллллллл л
echo  л лллл лллллллллллл ллллл ллллллл ллллл ллллллл ллллллл ллллл ллллл ллл101лллл
echo  лллллл лллллллллллл лллллл лллллл лллллл ллллллл ллллл лллллл лллллл ллллллл л
echo  л лллл         лллл ллллллл ллллл ллллллл ллллллл     ллллллл ллллллл лллллллл
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл л
echo  л л Would You Like To Hide This Error Next Time? Recommended Not To Ignore ллл
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo лллллллллллллллллллллллллллллллл Please Confirm ллллллллллллллллллллллллллллллл
echo л1л No
echo л2л Yes
Set errorlevel=0
CHOICE /C 12 /N /M "л: "
IF ERRORLEVEL 2 goto NeverShowError101b
IF ERRORLEVEL 1 goto setpasswords
goto setpasswords
:NeverShowError101b
echo ^|^|Log^|^|  ^|Info: Error 101 Hidden^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f
echo Dev_Mode=%Dev_Mode% > "SDS_FILES\SD-Settings.ini"
echo Used_Before=%Used_Before% >> "SDS_FILES\SD-Settings.ini"
echo Trial_Mode=%Trial_Mode% >> "SDS_FILES\SD-Settings.ini"
echo Bug_101_Vuln=%Bug_101_Vuln_2% >> "SDS_FILES\SD-Settings.ini"
echo Hide_Bug_101=yes >> "SDS_FILES\SD-Settings.ini"
echo Security_Breach_Key=%Security_Breach_Key% >> "SDS_FILES\SD-Settings.ini"
echo Theme=%Theme% >> "SDS_FILES\SD-Settings.ini"
echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:n
cls
goto setpasswords

:encryptVaribles
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
set aa=6
set ab=7
set ae=0
set ac=8
set ag=2
set ad=9
set af=1
set ah=3
set ai=4
set aj=5
goto setpasswords2

:deleteOldSDsecurity
for /F "delims=" %%A in (SDS_FILES\Delete_Old_SD-Security.tmp) do set %%A
del %Delete_Exe%
del SDS_FILES\Delete_Old_SD-Security.tmp
goto StartOfScript

:encryptoINSECURE
echo ^|^|Log^|^|  ^|Info: Encrypto Insecure ^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
echo.
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo  л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л л  л
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл л
echo  л лллл         лллл        лллллл        лллллллл     ллллллл        ллллллллл
echo  лллллл лллллллллллл ллллллл ллллл ллллллл лллллл ллллл лллллл ллллллл лллллл л
echo  л лллл лллллллллллл лллллллл лллл лллллллл лллл ллллллл ллллл лллллллл ллллллл
echo  лллллл лллллллллллл ллллллл ллллл ллллллл лллл ллллллллл лллл ллллллл лллллл л
echo  л лллл         лллл        лллллл        ллллл ллллллллл лллл        ллллллллл
echo  лллллл лллллллллллл лллл лллллллл лллл ллллллл ллллллллл лллл лллл ллллллллл л
echo  л лллл лллллллллллл ллллл ллллллл ллллл ллллллл ллллллл ллллл ллллл ллл101лллл
echo  лллллл лллллллллллл лллллл лллллл лллллл ллллллл ллллл лллллл лллллл ллллллл л
echo  л лллл         лллл ллллллл ллллл ллллллл ллллллл     ллллллл ллллллл лллллллл
echo  лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл л
echo  л л                                                                        ллл
echo  ллл    Security Is Compromised On FAT / FAT32 Drives Due To The Lack Of    л л
echo  л л Permissions. We Recommend To Format This Drive In NTFS To Fix This Bug ллл
echo  ллл   This Bug Isn't A Unfixed Problem, More Like A Un-Added Feature That  л л
echo  л л   FAT Drives Don't Have, DO NOT STORE ANY PERSONAL INFO IN ENCRYPTO    ллл
echo  ллл                   RECORD BECUASE IT IS *NOT SECURE*                    л л
echo  л лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo  ллл Would You Like To Hide This Error Next Time? Recommended Not To Ignore л л
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo л1л No
echo л2л Yes (SD-Security Will Restart)
Set errorlevel=0
CHOICE /C 12 /N /M "л: "
IF ERRORLEVEL 2 goto NeverShowError101
IF ERRORLEVEL 1 goto Backtoencrypto
goto encrypto
:encrypto
echo ^|^|Log^|^|  ^|Info: Encrypto^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
cls
title Enter Password ^| Encrypto - SD-Security
If Exist "%sds%" goto breach
echo ===============================================================================
echo ====SD-Security====                    Encrypto                      %status%
echo ===============================================================================
echo.
set/p "pass=Enter Password л: "
set drv=%cd:~0,2%
if %Hide_Bug_101%==yes goto backtoencrypto
if exist %drv%\Bug101Checker.tmp del %drv%\Bug101Checker.tmp
@echo 1 > %drv%\Bug101Checker.tmp:stream
if exist %drv%\Bug101Checker.tmp set Bug_101_Vuln_2=no&del %drv%\Bug101Checker.tmp&goto backToEncrypto
if not exist %drv%\Bug101Checker.tmp set Bug_101_Vuln_2=yes&cls&goto encryptoINSECURE
:backToEncrypto
if NOT %pass%==%password% goto denied
if not exist "SDS_Files\Encrypto.SDS_Encrypted" goto make_encrypto
cls
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
:encryptoOptions
echo ^|^|Log^|^|  ^|Info: Encrypto Options^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if not exist "SDS_Files\Encrypto.SDS_Encrypted" goto make_encrypto
cls
if %theme%==blue color 91
if %theme%==dark_blue color 19
if %theme%==black color 0f
if %theme%==grey color 78
if %theme%==dark_grey color 87
if %theme%==green color a2
if %theme%==dark_green color 2a
if %theme%==aqua color b3
if %theme%==dark_aqua color 3b
if %theme%==red color c4
if %theme%==dark_red color 4c
if %theme%==purple color d5
if %theme%==dark_purple color 5d
if %theme%==yellow color e6
if %theme%==dark_yellow color 6e
if %theme%==white color f7
if %theme%==black_white color 0f
if not %status%==Signed-In goto home
echo ===============================================================================
echo ====SD-Security====                    Encrypto                      %status%
echo ===============================================================================
echo.
echo л1л  View Encrypto Record
echo л2л  Add More To Encrypto Record
echo л3л  Delete Encrypto Record / Start Over
echo л4л  Back
set /p EncryptoOp="л: "
if %EncryptoOp%==1 goto ViewEncryptoRecord
if %EncryptoOp%==2 goto EditEncrypto
if %EncryptoOp%==3 goto DeleteEncrypto
if %EncryptoOp%==4 goto home
color C4
echo Error: л%encryptoOpл Is Not A Valid Option!
pause >nul
goto encryptoOptions
:DeleteEncrypto
cls
echo ===============================================================================
echo ====SD-Security====                    Encrypto                      %status%
echo ===============================================================================
echo.
echo                  ARE YOU SURE YOU WANT TO DELETE ENCRYPTO RECORD
echo л1л  No
echo л2л  Yes
set /p DeleteEncrypto="л: "
if %DeleteEncrypto%==2 goto deleteEncryptoVerified
goto EncryptoOptions
:deleteEncryptoVerified
cls
title Enter Password ^| Encrypto - SD-Security
If Exist "%sds%" goto breach
echo ===============================================================================
echo ====SD-Security====                    Encrypto                      %status%
echo ===============================================================================
echo.
echo Please Verify Password To Delete Encrypto Record:
set/p "pass=Enter Password л: "
if NOT %pass%==%password% goto denied
echo ^|^|Log^|^|  ^|Info: Encrypto Record Deleted^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:f
if exist "SDS_Files\Encrypto.SDS_Encrypted" del SDS_Files\Encrypto.SDS_Encrypted
goto EncryptoOptions
:ViewEncryptoRecord
echo ^|^|Log^|^|  ^|Info: Encrypto Record Opened^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
if not %status%==Signed-In goto home
echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:f
copy SDS_Files\Encrypto.SDS_Encrypted "SDS_Files\Encrypto_Tmp.txt"
echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:n
start SDS_Files\Encrypto_Tmp.txt
set/a deletenum=10
:deleteloop2
if not %status%==Signed-In goto home
title %deletenum% Seconds Until Temp. Encrypto File Deleted - SD-Security
cls
echo ===============================================================================
echo ====SD-Security====                    Encrypto                      %status%
echo ===============================================================================
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
if exist "SDS_Files\Encrypto_Tmp.txt" goto cantdeletetmp
goto home
:cantdeletetmp
if not %status%==Signed-In goto home
:deletelogloop3
if not %status%==Signed-In goto home
title Can't Delete Temp. Encrypto File - SD-Security
if not exist "SDS_Files\Encrypto_Tmp.txt" goto home
cls
echo ===============================================================================
echo ====SD-Security====                    Encrypto                      %status%
echo ===============================================================================
echo.
echo          Can't Delete Temporary Fileg, Please Close Log When Done
del SDS_Files\Encrypto_Tmp.txt
goto deletelogloop3
:make_encrypto
echo ^|^|Log^|^|  ^|Info: Make Encrypto Record^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if not %status%==Signed-In goto home
cls
echo ===============================================================================
echo ====SD-Security====                    Encrypto                      %status%
echo ===============================================================================
echo.
echo           You Haven't Yet Made A Encrypto Record, Please Do So Now
echo               Please Enter The Data For An Encrypto Record Here
echo       TIPS: You Can Have Multiple Lines, When Finished Exit The Window
echo              Don't Use Special Characters Such As ^& ^% ^| ^Ѓ ^"
echo     If You Want To Use Them Please Insert A ^^ Before Them eg. ^^^& ^^^%% etc.
echo                                 Press Any Key To Start
pause >nul
goto MakeEncryptoLoop
:EditEncrypto
echo ^|^|Log^|^|  ^|Info: Edit Encrypto Record^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
if not %status%==Signed-In goto home
cls
echo ===============================================================================
echo ====SD-Security====                    Encrypto                      %status%
echo ===============================================================================
echo.
echo               You Are About To Edit Encrypto Record Please Read:
echo           You Can Have Multiple Lines, When Finished Exit The Window
echo              Don't Use Special Characters Such As ^& ^% ^| ^Ѓ ^"
echo     If You Want To Use Them Please Insert A ^^ Before Them eg. ^^^& ^^^%% etc.
echo                             Press Any Key To Start Editing
pause >nul
:MakeEncryptoLoop
if not %status%==Signed-In goto home
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:f
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" copy SDS_Files\Encrypto.SDS_Encrypted "SDS_Files\EncryptoTMP.SDS_Encrypted"
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:n
cls
if exist "SDS_Files\Encrypto.SDS_Encrypted" type SDS_Files\EncryptoTMP.SDS_Encrypted
if exist "SDS_Files\Encrypto.SDS_Encrypted" del SDS_Files\EncryptoTMP.SDS_Encrypted
set /p Encrypto_Data=" "
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:f
echo %Encrypto_Data% >> "SDS_Files\Encrypto.SDS_Encrypted"
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_FILES\Encrypto.SDS_Encrypted /T /P everyone:n
goto MakeEncryptoLoop

:Safe_Mode
title SAFE MODE - SD-SECURITY
echo ^|^|Log^|^|  ^|Info: LAUNCHED IN SAFE MODE^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
cls
REM UNFINISHED
if exist "SafeMode.*" del SafeMode.*
:sfmd
cls
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo ллл                                                                         ллл
echo ллл  л  л  л  л  л  л  л    SD-Security SAFE MODE      л  л  л  л  л  л  л  ллл
echo ллл                                                                         ллл
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo лллл1л Troubleshoot SD-Security
echo ллл2л Uninstall
echo лл3л Reset SD-Security's Preferences
echo л4л Reboot Into Normal Mode
set /p SafeModeOp="л: "
if %SafeModeOp%==1 goto trblesht
if %SafeModeOp%==2 goto uninstl
if %SafeModeOp%==3 goto ResetSDSecurity
if %SafeModeOp%==4 goto StartOfScript
echo INVALID CHOICE!
pause >nul
goto sfmd
:sfmd2
cls
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo ллл                                                                         ллл
echo ллл  л  л  л  л  л  л  л    SD-Security SAFE MODE      л  л  л  л  л  л  л  ллл
echo ллл                                                                         ллл
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo лллл1л Troubleshoot SD-Security
echo ллл2л Uninstall
echo лл3л Reset SD-Security's Preferences
echo л4л Reboot Into Normal Mode
echo л: %SafeModeOp%
echo.
echo                                   Command Completed
echo                            Press Any Key To Exit SD-Security
pause >nul
exit

:trblesht
cls
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo ллл                                                                         ллл
echo ллл  л  л  л  л  л  л  л    SD-Security SAFE MODE      л  л  л  л  л  л  л  ллл
echo ллл                                                                         ллл
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo лллл1л Troubleshoot SD-Security
echo ллл2л Uninstall
echo лл3л Reset SD-Security's Preferences
echo л4л Reboot Into Normal Mode
echo л: %SafeModeOp%
echo.
echo                              Troubleshooting...
echo                         Troubleshooting Autorun.inf...
if exist "autorun.inf" echo y| cacls autorun.inf /T /P everyone:f
if exist "autorun.inf" del autorun.inf
cls
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo ллл                                                                         ллл
echo ллл  л  л  л  л  л  л  л    SD-Security SAFE MODE      л  л  л  л  л  л  л  ллл
echo ллл                                                                         ллл
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo лллл1л Troubleshoot SD-Security
echo ллл2л Uninstall
echo лл3л Reset SD-Security's Preferences
echo л4л Reboot Into Normal Mode
echo л: %SafeModeOp%
echo.
echo                              Troubleshooting...
echo                         Troubleshooting Autorun.inf...
echo                         Troubleshooting Favicon.Ico...
if exist "favicon.ico" echo y| cacls favicon.ico /T /P everyone:f
if exist "favicon.ico" del favicon.ico
timeoout 1 >nul /nobreak
cls
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo ллл                                                                         ллл
echo ллл  л  л  л  л  л  л  л    SD-Security SAFE MODE      л  л  л  л  л  л  л  ллл
echo ллл                                                                         ллл
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo лллл1л Troubleshoot SD-Security
echo ллл2л Uninstall
echo лл3л Reset SD-Security's Preferences
echo л4л Reboot Into Normal Mode
echo л: %SafeModeOp%
echo.
echo                              Troubleshooting...
echo                         Troubleshooting Autorun.inf...
echo                         Troubleshooting Favicon.Ico...
echo                       Troubleshooting SD-Security.exe...
if exist "SD-Security.*" set trbsht1=Resolved-(No)&goto trbNext
set trbsht1=Unresolved-(Yes)
:trbNext
timeout 5 >nul /nobreak
cls
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo ллл                                                                         ллл
echo ллл  л  л  л  л  л  л  л    SD-Security SAFE MODE      л  л  л  л  л  л  л  ллл
echo ллл                                                                         ллл
echo ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo лллл1л Troubleshoot SD-Security
echo ллл2л Uninstall
echo лл3л Reset SD-Security's Preferences
echo л4л Reboot Into Normal Mode
echo л: %SafeModeOp%
echo.
echo                              Troubleshooting...
echo.
echo                                     Results:
echo         Problem Info          ---                        Status
echo -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
echo SD-Security Exe Name Issue     : %trbsht1%
echo Favicon.ico Issue              : Resolved-(No)
echo Autorun.inf Issue              : Resolved-(No)
echo SD-Security Compatibility Issue: Resolved-(No)
echo -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
echo         If Issues Still Persist, Reboot SD-Security Into Safe Mode And
echo                         Reset SD-Security's Preferences
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo -----If It Still Does Not Work Then Uninstall And Then Install SD-Security-----
pause >nul
goto sfmd2
:ResetSDSecurity
cls
if exist "SDS_Files\SD-Settings.ini" echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f
if exist "SDS_Files\SD-Settings.ini" del SDS_FILES\SD-Settings.ini
goto sfmd2
:uninstl
echo Confirm
echo л1л  No
echo л2л  Yes
set /p sfmd3="л:"
if %sfmd3%==2 goto uninstl2
goto sfmd
:uninstl2
if exist "SDS_Files\SD-Settings.ini" echo y| cacls SDS_FILES\SD-Settings.ini /T /P everyone:f
if exist "SDS_Files\SD-Settings.ini" del SDS_FILES\SD-Settings.ini
if exist "SDS_Files\SD-Security.SDS_LOG" del SDS_Files\SD-Security.SDS_LOG
if exist "autorun.inf" attrib -h -s -r "autorun.inf"
if exist "autorun.inf" del autorun.inf
if exist "favicon.ico" del favicon.ico
if exist "SDS_Files\Encrypto.SDS_Encrypted" echo y| cacls SDS_Files\Encrypto.SDS_Encrypted /T /P everyone:f
if exist "SDS_Files\Encrypto.SDS_Encrypted" del SDS_Files\Encrypto.SDS_Encrypted
if exist "SDS_Files\" rd SDS_Files\
if exist "SD-Security.*" set uninVar1=Files For SD-Security Deleted&goto uninfinsh
set uninVar1=SD-Security Files Deleted, Cannot Automatically Delete EXE
cls
:uninfinsh
cls
title %uninVar1%
echo ===============================================================================
echo ====SD-Security====             Uninstall Finished                  Signed Out
echo ===============================================================================
echo.
echo                              Uninstall Finished
echo -------------------------------------------------------------------------------
echo                 SD-Security's Files Were Removed Successfully
if not exist "SD-Security.*" goto uninNoSDExe
echo             The Only Remaining File Is The SD-Security Executable
echo                         Press Any Key To Delete It
pause >nul
if exist "SD-Security.*" echo del SD-Security.*|cmd&exit
exit
:uninNoSDExe
echo  But We Cannot Automatically Delete The EXE So You Can Just Delete It Yourself
echo                             Press Any Key To Exit
pause >nul
goto end



:end
mode con: cols=38 lines=19
color f0
cls
title Exit - SD-Security
echo =====================================
echo ====SD-Security====  EXIT  Signed Out
echo =====================================
echo.
echo     ллллллллллллллллллллллллллллл
echo.    лл л л л л л л л л л л л л лл
echo     л ллллллллллллллллллллллллл л
echo     ллл     -------           ллл
echo     л л      \  /^| \          л л
echo     ллл       \/ ^|   \        ллл
echo     л л      / \ ^|     \      л л
echo     ллл    /    \^|       \    ллл
echo     л л   -----------------   л л
echo     ллл  All Rights Reserved  ллл
echo     л л-----------------------л л
echo     ллллллллллллллллллллллллллллл
echo     лл л л л л л л л л л л л л лл
echo     ллллллллллллллллллллллллллллл
echo ^|^|Log^|^|  ^|Info: EXIT^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
timeout 3 >nul
exit
:Quickend
echo ^|^|Log^|^|  ^|Info: EXIT^| ^|Time: %time%^| ^|Date: %date%^| ^|PC: %computername%^| ^|Username: %username%^| >> "SDS_Files\SD-Security.SDS_LOG"
exit