@echo off
color 9B
Title Loading...  (SD-Security-TRIAL)
echo Loading Files...
echo WARNING THIS IS A TRIAL VERSION, SECURITY IS COMPROMISED!
goto securitylog
:back1
if Not exist "autorun.inf" goto makeautorun
:back2
goto Killpcres
:back3
if Not exist "SDS_FILES" goto makeSDSFILES
:back4
if not exist "Favicon.ico" goto makefavicon
:back5
REM SKIP THIS BIT BECAUSE OF TRIAL VERSION
:back5
if not exist "NoWelcomeOnStartup.txt" goto welcome
:back6
cls


REM Account 1 (ADMIN ACCOUNT)
set user21=test
set password=testpassword

REM Account 2 (FALSE USER) NOT AVAILABLE!

REM SECURITY BREACHER CODE
REM UNAVAILABLE



REM           Homescreens
REM Logged Out
:Home
attrib +h +s "Favicon.ico"
cls
echo [Home:] Time: %time% ; Date: %date% UPGRADE TO PRO TO GET MORE INFO like>> "SD-Security-TRIAL.SDS_LOG"
if %status%==Signed-In goto home2
cls
color 9F
title Home - SD-Security-TRIAL
cls
echo ===============================================================================
echo ====SD-Security-TRIAL====                   Home                     %status%
echo ===============================================================================
echo.
echo [1] Lost and Found
echo [2] Sign In
echo [3] About
echo [4] Commands
echo [5] Exit
echo.
set /p op=
if %op%==1 goto Lost
if %op%==2 goto signin
if %op%==3 goto about
if %op%==4 goto commands
if %op%==p goto portableapps
if %op%==P goto portableapps
if %op%==5 goto end
goto error

REM Logged-In
:Home2
cls
color 9F
title Home - SD-Security-TRIAL
cls
echo ===============================================================================
echo ====SD-Security-TRIAL====                   Home                     %status%
echo ===============================================================================
echo.
echo [1] (Un)Lock Private Data
echo [2] Sign In
echo [3] About
echo [4] Other
echo [5] Exit
echo.
set /p op=
if %op%==1 goto privatedata
if %op%==2 goto signin
if %op%==3 goto about
if %op%==4 goto other
if %op%==5 goto end
goto error
:error
echo [Home:] [ERROR-COMMAND: UPGRADE!] Time: %time% ; Date: %date% UPGRADE TO PRO TO GET MORE INFO>> "SD-Security-TRIAL.SDS_LOG"
color 1C
echo '%op%' is not a valid option, Please enter a number above and press enter
pause >nul
goto Home


REM Lost And Found
:lost
echo [Lost and Found:] Time: %time% ; Date: %date% UPGRADE TO PRO TO GET MORE INFO>> "SD-Security-TRIAL.SDS_LOG"
color 9F
title Lost and Found - SD-Security-TRIAL
cls
echo ===============================================================================
echo ====SD-Security-TRIAL====                Lost and Found              %status%
echo ===============================================================================
echo Please goto http://sd-storage.weebly.com/usb.html
echo and enter your details in one of the boxes
echo and fill in your details here just to keep a
echo log on this device
echo ===============================================================================
echo.
set /p firstname="First Name: "
set /p surname="Surname: "
set /p phonenumber="*Phone Number*: "
set /p email="*Email Address*: "
goto devicelog
:devicelog
color 9F
echo ====================================>> "%firstname% Found This Device.txt"
attrib +h "%firstname% Found This Device.txt"
echo              Found Log>> "%firstname% Found This Device.txt"
echo ====================================>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo ..........>> "%firstname% Found This Device.txt"
echo Basic Info>> "%firstname% Found This Device.txt"
echo ..........>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo First Name Entered:%firstname%>> "%firstname% Found This Device.txt"
echo Surname Entered:%surname%>> "%firstname% Found This Device.txt"
echo Time Found:%time%>> "%firstname% Found This Device.txt"
echo Date Found:%date%>> "%firstname% Found This Device.txt"
echo Email Address Entered:%email%>> "%firstname% Found This Device.txt"
echo Phone Number Entered:%phonenumber%>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo .............>> "%firstname% Found This Device.txt"
echo Advanced Info>> "%firstname% Found This Device.txt"
echo .............>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo Computer Username:%username%>> "%firstname% Found This Device.txt"
echo Computer Name:%computername%>> "%firstname% Found This Device.txt"
echo Computer Ip Address:%ipconfig%>> "%firstname% Found This Device.txt"
echo Sam Denty Security>> "%firstname% Found This Device.txt"
attrib +h "%firstname% Found This Device.txt"
echo LOGGING
echo Log Sucessfully Captured! :)
:lostCompleted
echo [Lost and Found:] [Submitted] Name: UPGRADE! ; Surname: %surname%; Time: %time% ; Date: %date% UPGRADE TO PRO TO GET MORE INFO>> "SD-Security-TRIAL.SDS_LOG"
title Thank You - SD-Security-TRIAL
color 9F
cls
echo ===============================================================================
echo ====SD-Security-TRIAL====                Lost and Found              %status%
echo ===============================================================================
echo.
echo Your details have been logged THANK YOU
echo.
echo Please go to "http://sd-storage.weebly.com/usb" to complete the form
echo                                    Website Opened
echo.
start http://sd-storage.weebly.com/usb
goto home


REM Private Data
:Privatedata
echo [Private Data:] Time: %time% ; Date: %date% UPGRADE TO PRO TO GET MORE INFO>> "SD-Security-TRIAL.SDS_LOG"
color 9F
title Private Data - SD-Security-TRIAL
if exist ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}" goto unlock
if not exist Unlocked goto mdlocker
:CONFIRM
title Please Confirm - SD-Security-TRIAL
color 9F
cls
echo ===============================================================================
echo ====SD-Security-TRIAL====                Private Data                %status%
echo ===============================================================================
echo.
color 9F
echo Press any key to start hiding Private Data (Upgrade To Use Encryption!)
pause >nul
echo Loading next command Press any key to confirm to lock (Upgrade to lock straight
echo away)
pause >nul
:lock
title Locking:... -SD-Security-TRIAL
color 9F
cls
echo ===============================================================================
echo ====SD-Security-TRIAL====                Private Data                %status%
echo ===============================================================================
ren Unlocked ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
echo Stage 1 completed
attrib +h +s +r +a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
echo Stage 2 completed
color 9A
echo PRIVATE DATA EN-CRYPTED!
echo [Private Data:] [EN-CRYPTED] Time: %time% ; Date: %date% UPGRADE TO PRO TO GET MORE INFO>> "SD-Security-TRIAL.SDS_LOG"
pause >nul
goto end

:unlock
title Please Enter Password - SD-Security-TRIAL
echo ===============================================================================
echo ====SD-Security-TRIAL====                Private Data                %status%
echo ===============================================================================
echo.
color 9F
set/p "pass=Enter Password: "
if NOT %pass%==%password% goto denied
goto unlocking
:Unlocking
title Unlocking - SD-Security-TRIAL
echo [Private Data:] [DE-CRYPTED] Time: %time% ; Date: %date% UPGRADE TO PRO TO GET MORE INFO>> "SD-Security-TRIAL.SDS_LOG"
attrib -h -s -r -a ".Locked.{645FF040-5081-101B-9F08-00AA002F954E}"
echo Stage 1 completed
ren .Locked.{645FF040-5081-101B-9F08-00AA002F954E} "Unlocked"
echo Stage 2 completed
color 9A
echo PRIVATE DATA DE-CRYPTED
pause >nul
goto end
:denied
title ACCESS DENIED - SD-Security-TRIAL
echo [Sign In:] [WRONG INFO: Username: %username2% ; Password: %userpaswrd% / %pass%] Time: %time% ; Date: %date% ; Computer-Name: %computername% ; User-name: %username%>> "SD-Security-TRIAL.SDS_LOG"
color 1C
echo THE INFORMATION YOU ENTERED IS INCORRECT!
pause >nul
goto end
:MDLOCKER
title Making Private Data Folder - SD-Security-TRIAL
color 9F
md Unlocked
echo Private Data Vault Created (Use the Unlocked Folder)
echo Press Any Key To Go Home
pause >nul
goto home


REM About
:about
cls
echo [About:] Time: %time% ; Date: %date% ; Computer-Name: %computername% ; User-name: %username%>> "SD-Security-TRIAL.SDS_LOG"
color 9F
title About - SD-Security-TRIAL
start http://SD-Storage.weebly.com
echo ===============================================================================
echo ====SD-Security-TRIAL====                      About                 %status%
echo ===============================================================================
echo                           Our Website Has Just Been Opened
echo   If You Have Found This On A SD-card Or USB That Doesnt Belong To You Please
echo   Choose 'Lost and found' On The Homescreen And Enter Your Details, There Is
echo             A 70%% Chance That You Will Get A Prize For Returning It
echo.
echo                 This security was designed by Samuel D. Denty
echo This security can be breached by the 'Master Overide' feature that is randomly
echo                             made for each Security App
echo                    This security uses 128-bit AES Encryption
echo.
echo                            Press any key to go home.
pause >nul
goto home


REM Sign In
:SIGNIN
if %status%==Signed-In goto signout
If Exist "%sds%" goto AdminSignIn
title Sign In - SD-Security-TRIAL
cls
color 9F
echo ===============================================================================
echo ====SD-Security-TRIAL====                      Sign In               Signing In
echo ===============================================================================
echo Username: test
echo Password: testpassword
echo Upgrade To Full Version/Register For Free To Stop This Info From Showing
echo CASE SENSITIVE!
echo.
set/p username2="Enter Username: "
set/p userpaswrd="Enter Password: "
REM enter account g0to here (I had to use 0 instead of o)
if %username2%==%user21% goto user21
if %username2%==%user22% goto user22
goto denied
:signout
title Sign Out - SD-Security-TRIAL
cls
color 9F
echo ===============================================================================
echo ====SD-Security-TRIAL====                      Sign Out                     N/A
echo ===============================================================================
echo You are all ready signed in as "%username2%",
echo Would you like to sign out?
echo [1] Yes
echo [2] No
set/p signout2=""
if %signout2%==1 goto signoutyes
if %signout2%==2 goto home
goto ERROR
:signoutyes
set status=Signed-Out
goto home


REM Other
:other
cls
title Other - SD-Security-TRIAL
color 9F
echo ===============================================================================
echo ====SD-Security-TRIAL====                         Other              %status%
echo ===============================================================================
echo [1] Quick Erase (Close and Erase history for Google Chrome) (UPGRADE)
echo [2] Open Security Log
set /p other=""
if %other%==1 goto upgrade
if %other%==2 goto openlog
goto end
:upgrade
cls
title UPGRADE
echo ===============================================================================
echo ====SD-Security-TRIAL====                       Upgrade              %status%
echo ===============================================================================
echo.
echo This program is only a trial version and should not be used as proffesional use
echo without upgrading, to upgrade please send a email to SamDenty99@outlook.com
echo with your name, phone number (Not necessary) and your email DO NOT INCLUDE
echo PASSWORDS OR CREDIT CARD INFO OVER E-MAIL! We are sorry that this proccess has
echo to be done in-proffesionally because we are not yet using php to deliver these
echo small things, becuase of this site being Open-Source/Free
echo.
echo There are two types of Upgrades:
echo Pro: Get every unique feature that is possible, which is 76 altogether :€20-€40
echo Pre-Pro : Get 40% of the pro features, which is 30 altogether          :€5-€10
echo Licensed: Get started using this program by getting a license          :FREE!
echo.
echo To get a free license please send your Name, Address and Phone (Required)
echo to SamDenty99@outlook.com with the subject 'FREE_LICENSE' and within 1-7 days
echo you will get a email with the download in the link, Phone number is required,
echo to verify you are over 13, We will give you it on some occassions though! as
echo the person who was/is writing this script was 12 at the time (11 when this
echo project was started)
pause >nul
goto home
:openlog
title Opening Log - SD-Security-TRIAL
start SD-Security-TRIAL.SDS_LOG
goto home
:commands
title Commands - SD-Security-TRIAL
cls
echo !!IN_CAPITALS_ONLY!!
echo ENTER_A_SDS_COMMAND:
set /p cmd=
if %cmd%==MINECRAFT goto minecraft
if %cmd%==EXIT goto end
if %cmd%==CLOSE goto end
if %cmd%==SHUTDOWN shutdown /p
if %cmd%==HOME goto check
echo Please Enter A Valid Command

REM accounts
:user21
if NOT %userpaswrd%==%password% goto denied
set status=Signed-In
goto home
:user22
if NOT %userpaswrd%==%password2% goto denied
set status=Signed-In
goto home


REM Security Breach
:AdminSignIn
title HACKED - SD-Security-TRIAL
set status=   HACKED!
echo [Sign In:] [BREACHED] Time: %time% ; Date: %date% ; Computer-Name: %computername% ; User-name: %username%>> "SD-Security-TRIAL.SDS_LOG"
goto home

REM Loading Sequence
:securitylog
echo.>> "SD-Security-TRIAL.SDS_LOG"
echo [OPENED:] Time: %time% ; Date: %date% ; Computer-Name: %computername% ; User-name: %username%>> "SD-Security-TRIAL.SDS_LOG"
attrib +h "SD-Security-TRIAL.SDS_LOG"
set status=Signed-Out
goto back1
:makeautorun
title Loading:... -SD-Security-TRIAL
echo [autorun]>> "autorun.inf"
echo Open=SD-Security-TRIAL.exe>> "autorun.inf"
echo ShellExecute=System\SD-Security-TRIAL.exe>> "autorun.inf"
echo shell\open\command=SD-Security-TRIAL.exe>> "autorun.inf"
echo shell\open=Open SD-Security-TRIAL>> "autorun.inf"
echo Action=Open SD-Security-TRIAL>> "autorun.inf"
echo Icon=Favicon.ico>> "autorun.inf"
echo Label=SD-Security-TRIAL®>> "autorun.inf"
echo UseAutoplay=1>> "autorun.inf"
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
md SDS_FILES
attrib +h +s "SDS_FILES"
echo This Folder (SDS_FILES) exists to store Temp Files and other things that Sam Denty Security Uses>> "%MYFILES%\SDS_FILES\README.TXT"
echo If you Delete this folder it will be made again but making it again occours at the start of sam denty security>> "%MYFILES%\SDS_FILES\README.TXT"
echo Meaning That Sam Denty Security Will Take Longer To Load and some features will not work correctly, you can delete this file (README.TXT) if you want>> "%MYFILES%\SDS_FILES\README.TXT"
goto back4
:rename
cls
ren %0 "SD-Security-TRIAL.exe"
goto back5
:makefavicon
copy "%MYFILES%\Favicon.ico" "Favicon.ico"
attrib +h +s "Favicon.ico"
goto back5
:welcome
color 9F
cls
title Welcome To SD-Security-TRIAL - SD-Security-TRIAL
echo This file is here so the application knows not to show the welcome screen on startup>> "NoWelcomeOnStartup.txt"
attrib +h +s +r +a "NoWelcomeOnStartup.txt"
echo ===============================================================================
echo ====SD-Security-TRIAL====                    Welcome                 %status%
echo ===============================================================================
echo  Welcome to SD-Security-TRIAL, A very compatible software, that runs entirely on CMD
echo          And uses ony the keyboard to navigate your way around
echo ===============================================================================
echo             Here I will show you the basics to using this software:
echo.
echo 1. To navigate around: Use the numbers (1-9) on your keyboard to do a operation
echo    After you have typed the number you want, press the ENTER key on the keyboard
echo 2. Sometimes you can enter words (A Password or Username), But everything in
echo    This application is CaSe SeNsItIvE
echo.
echo 3. This application works best on USB sticks, but works fine on a hard drive too
echo.
echo 4. And last of all of this program was coded by Samuel D. Denty (XLR8)
echo.
echo Would you like to have a demo?
echo [1] Yes
echo [2] No
set /p demo=""
if %demo%==1 goto demo
if %demo%==2 goto back6
color 1C
echo Please press the number 1 or 2 on your keyboard and then press ENTER
pause >nul
goto welcome
:demo
title Demo - SD-Security-TRIAL
color 9F
cls
echo ===============================================================================
echo ====SD-Security-TRIAL====                    Welcome                 %status%
echo ===============================================================================
echo  Welcome to SD-Security-TRIAL, A very compatible software, that runs entirely on CMD
echo          And uses ony the keyboard to navigate your way around
echo ===============================================================================
echo.
echo Here is a demo:
echo.
echo [1]    : Home
echo [2]    : Back
echo [3]    : About
echo [exit] : Exit this application (CaSe SeNsItIvE)
set /p demo=""
if %demo%==1 goto back6
if %demo%==2 goto welcome
if %demo%==3 goto about
if %demo%==exit goto end
color 1C
echo '%demo%' is not a valid choice, enter a number from 1-3 or exit and press ENTER
echo Press any key to go back.
pause >nul
goto demo

REM Portable Apps
:portableapps
title Portable Apps - SD-Security-TRIAL
echo ===============================================================================
echo ====SD-Security-TRIAL====                 Portable Apps              %status%
echo ===============================================================================
Echo Searching For Application...
if not exist "Start.exe" goto noportableapps
start "Start.exe"
goto end
:noportableapps
title Error - SD-Security-TRIAL
color 1C
echo ===============================================================================
echo ====SD-Security-TRIAL====                       Error                %status%
echo ===============================================================================
echo We Have Not Detected A Installation Of 'Portable Apps' On This Drive,
echo Please Install It At 'PortableApps.com' And Choose The Root Of This Drive.
echo If It Is Already Installed Make Sure The Application Has The Name 'Start.exe'
pause >nul
goto home



:end
cls
Echo Clearing Cache: Stage 1
Echo Clearing Cache: Stage 2
Echo Clearing Cache: Stage 3
Echo Clearing Cache: Stage 4
ECHO COMPLETE
color 9E
cls
title ..::Exit::.. -SD-Security-TRIAL
echo ===============================================================================
echo ====SD-Security-TRIAL====              EXIT                              Signed Out
echo ===============================================================================
echo                                  ------
echo                                   \  /!\
echo                                    \  ! \
echo                                   / \ !  \
echo                                  /   \!   \
echo                               ----------------
echo                             All Rights Reserved
echo                            ----------------------
echo TEMPORARY ENCRYPTION KEY: %RANDOM%--No Need To Remember!
echo [Exit (Safely):] Time: %time% ; Date: %date% ; Computer-Name: %computername% ; User-name: %username%>> "SD-Security-TRIAL.SDS_LOG"
pause >nul
exit
:Quickend
echo [Exit (Quick):] Time: %time% ; Date: %date% ; Computer-Name: %computername% ; User-name: %username%>> "SD-Security-TRIAL.SDS_LOG"
exit