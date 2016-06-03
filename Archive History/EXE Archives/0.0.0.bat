@echo off
set ztmp=C:\Users\SAMUEL~1\AppData\Local\Temp\ztmp
set MYFILES=C:\Users\SAMUEL~1\AppData\Local\Temp\afolder
set bfcec=tmp70631.exe
set cmdline=
SHIFT /0
@echo off
echo Last Time Security Opened: Date:%date% Time:%Time% Computer:%computername%>> "Security Log.txt"
attrib +h "security log.txt"
:Start
CLS
:AccountSetUp
color 0a
echo ======================================
echo                 Home
echo            Security Id:9491
echo ======================================
echo.
echo [1] If Found
echo [2] Unlock Private vault
echo [3] More options
echo.
set /p op=
if %op%==2 goto 1
if %op%==1 goto 2
if %op%==3 goto 4
goto error
:2
cls
echo ================================================
echo                     If Found
echo   Please fill in your details and press ENTER
echo   This data may take a while to send to my pc
echo ================================================
echo.
set /p firstname="First Name:"
set /p surname="Surname:"
set /p phonenumber="*Phone Number*:"
set /p email="*Email Address*:"
:inputname
echo ====================================>> "%firstname% Found This Device.txt"
attrib +h "%firstname% Found This Device.txt"
echo              Found Log>> "%firstname% Found This Device.txt"
echo ====================================>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo ..........>> "%firstname% Found This Device.txt"
echo basic info>> "%firstname% Found This Device.txt"
echo ..........>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo First Name entered:%firstname%>> "%firstname% Found This Device.txt"
echo Surname entered:%surname%>> "%firstname% Found This Device.txt"
echo Time Found:%time%>> "%firstname% Found This Device.txt"
echo Date Found:%date%>> "%firstname% Found This Device.txt"
echo Email address entered:%email%>> "%firstname% Found This Device.txt"
echo Phone Number Entered:%phonenumber%>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo .............>> "%firstname% Found This Device.txt"
echo Advanced info>> "%firstname% Found This Device.txt"
echo .............>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo.>> "%firstname% Found This Device.txt"
echo Computer username:%username%>> "%firstname% Found This Device.txt"
echo Computer Name:%computername%>> "%firstname% Found This Device.txt"
echo Users On network:%netview%>> "%firstname% Found This Device.txt"
echo Computer Ip Address:%ipconfig%>> "%firstname% Found This Device.txt"
echo Sam Denty Security>> "%firstname% Found This Device.txt"
echo Sending Found info
cd "%userprofile%\documents"
if exist "Bin" goto skip
if not exist "Bin" goto noskip
:noskip
md "Bin"
goto skip
:skip
cd "%userprofile%\documents\Bin"
if exist "%newname%.txt" goto logdone
if not exist "%newname%.txt" goto skip2
:skip2
:next1
cls
echo ============================
echo    Your Details are Sent
echo ============================
echo.
echo Your log is sent THANK YOU!
echo.
ping localhost-1>nul
goto Start
:1
CLS
@echo OFF
attrib +h +s "stuff"
title Folder Unlocked
if EXIST "Locked" goto UNLOCK
if NOT EXIST Unlocked goto MDLOCKER
if NOT EXIST stuff goto MDLOCKER
:CONFIRM
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo       Sam Denty Security
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo.
echo Enter Any Letter To Lock
color 07
set/p "cho=>"
if %cho%==q goto LOCK
if %cho%==w goto LOCK
if %cho%==e goto LOCK
if %cho%==r goto LOCK
if %cho%==t goto LOCK
if %cho%==y goto LOCK
if %cho%==u goto LOCK
if %cho%==i goto LOCK
if %cho%==o goto LOCK
if %cho%==p goto LOCK
if %cho%==a goto LOCK
if %cho%==s goto LOCK
if %cho%==d goto LOCK
if %cho%==f goto LOCK
if %cho%==g goto LOCK
if %cho%==h goto LOCK
if %cho%==j goto LOCK
if %cho%==k goto LOCK
if %cho%==l goto LOCK
if %cho%==z goto LOCK
if %cho%==x goto LOCK
if %cho%==c goto LOCK
if %cho%==v goto LOCK
if %cho%==b goto LOCK
if %cho%==n goto LOCK
if %cho%==m goto LOCK
if %cho%==Q goto LOCK
if %cho%==W goto LOCK
if %cho%==E goto LOCK
if %cho%==R goto LOCK
if %cho%==T goto LOCK
if %cho%==Y goto LOCK
if %cho%==U goto LOCK
if %cho%==I goto LOCK
if %cho%==O goto LOCK
if %cho%==P goto LOCK
if %cho%==A goto LOCK
if %cho%==S goto LOCK
if %cho%==D goto LOCK
if %cho%==F goto LOCK
if %cho%==G goto LOCK
if %cho%==H goto LOCK
if %cho%==J goto LOCK
if %cho%==K goto LOCK
if %cho%==L goto LOCK
if %cho%==Z goto LOCK
if %cho%==X goto LOCK
if %cho%==C goto LOCK
if %cho%==V goto LOCK
if %cho%==B goto LOCK
if %cho%==N goto LOCK
if %cho%==M goto LOCK
echo Enter a-q.
goto CONFIRM
:LOCK
ren Unlocked "Locked"
attrib +h +s "Locked"
echo Folder locked
goto logdone
:UNLOCK
If Exist "d6gfghfhfhfhftyfu.fgtdftydtydthydy" goto unlockme
@echo OFF
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo       Sam Denty Security
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo.
echo Enter GPS De-Activation Code:
set/p "pass=>"
if NOT %pass%== lion21 goto FAIL
goto unloockk
:unlockme
echo Vault Unlock Log>> "Unlocks.txt"
attrib +h -s "Unlocks.txt"
echo Unlocked Using A Security Breaker>> "Unlocks.txt"
echo Computer:%computername%>> "Unlocks.txt"
echo Date:%date%>> "Unlocks.txt"
net user>> "Unlocks.txt"
attrib -h -s "locked"
attrib -h -s "stuff"
ren "Locked" Unlocked
:breaker
color 0c
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo       Sam Denty Security
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo.
echo    WARNING SECURITY BREACHED
echo      PASSWORD BREAKER USED
goto logdone
:unloockk
echo Vault Unlock Log>> "Unlocks.txt"
attrib +h -s "Unlocks.txt"
echo Computer:%computername%>> "Unlocks.txt"
echo Date:%date%>> "Unlocks.txt"
net user>> "Unlocks.txt"
attrib -h -s "locked"
attrib -h -s "password protected.exe"
attrib -h -s "stuff"
attrib -h -s "border security"
ren "Locked" Unlocked
color 0a
echo.
echo Password correct
echo.
echo ACCESS GRANTED
pause >nul
goto logdone
:FAIL
echo ______________________>> "Hack attempts.txt"
attrib +h "Hack attempts.txt"
echo     Hack Attempts:>> "Hack attempts.txt"
echo ______________________>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo Time:%Time%>> "Hack attempts.txt"
echo Date:%date%>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo ___________________________>> "Hack attempts.txt"
echo    Advanced Info on Hack:>> "Hack attempts.txt"
echo ___________________________>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo Password Entered:%pass%>> "Hack attempts.txt"
echo Computer Name:%computername%>> "Hack attempts.txt"
net user>> "Hack attempts.txt"
echo *************************************>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
color 0c
echo.
echo Password Incorrect
echo.
echo ACCESS DENIED
pause >nul
goto logdone
:MDLOCKER
md Unlocked
md stuff
echo Unlocked created successfully
echo stuff created successfully
goto logdone
Set /p logname=Username:
if "%logname%"=="%logname%" goto 2.1
:2.1
echo.
set /p logpass="Password:"
if "%logpass%"=="%logpass%" goto login
:login
cd "%userprofile%\documents\Bin"
if exist "%logname%.txt" goto call
if not exist "%logname%.txt" goto errorlog
:call
call "%logname%.txt"
if "%password%"=="%logpass%" goto logdone
goto errorlog
:errorlog
color 0c
echo.
echo Username or Password incorrect.
echo Access denied.
pause >nul
goto home
:4
CLS
echo ======================
echo      More Options
echo ======================
echo.
color 0a
echo [1] Shutdown
echo [2] Hibernate
echo [3] Log Off
echo [4] Spy Record
echo [5] New
echo [6] About
echo [7] Computer Info
echo.
set /p op2=
if %op2%==1 goto shut
if %op2%==2 goto hiber
if %op2%==4 goto spyrec
if %op2%==3 goto loggoff
if %op2%==6 goto 3
if %op2%==5 goto new
if %op2%==7 goto info
:3
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo       Sam Denty Security
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo.
echo If Found
echo.
echo IF THIS DEVICE IS FOUND PLEASE ENTER YOUR
echo DETAILS ON THE "IF FOUND" SECTION
echo OR HAND IN TO THE PLACE WHERE FOUND
echo OR GO ONTO www.samdenty99.webs.com
echo AND SUBMIT YOUR DETAILS ON THE ONLINE SECTION
echo.
echo Anti Theft Info
echo.
echo This Device Has The Following Anti-Theft Security:
echo * Every Password Entered
echo * Time And Date Hack Attempted
echo * Remote Tracking Using Inbuilt Gps Tracking Chip
echo * Computer Info
echo * File Copier
echo * Live Webcam Recorder
echo.
echo (If you want a copy of this security press C and then enter)
set /p foundop=
if %Foundop%==C goto foundcopy
if %Foundop%==c goto foundcopy
goto Logdone
:foundcopy
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=->> "If Found Copy.txt"
echo       Sam Denty Security>> "If Found Copy.txt"
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=->> "If Found Copy.txt"
echo.>> "If Found Copy.txt"
echo If Found>> "If Found Copy.txt"
echo.>> "If Found Copy.txt"
echo IF THIS DEVICE IS FOUND PLEASE HAND IN TO THE PLACE WHERE FOUND>> "If Found Copy.txt"
echo OR GO ONTO www.samdenty99.webs.com>> "If Found Copy.txt"
echo AND SUBMIT YOUR DETAILS ON THE ONLINE SECTION>> "If Found Copy.txt"
echo.>> "If Found Copy.txt"
echo Anti Theft Info>> "If Found Copy.txt"
echo.>> "If Found Copy.txt"
echo This Device Has The Following Anti-Theft Security:>> "If Found Copy.txt"
echo * Every Password Entered>> "If Found Copy.txt"
echo * Time And Date Hack Attempted>> "If Found Copy.txt"
echo * Remote Tracking Using Inbuilt Gps Tracking Chip>> "If Found Copy.txt"
echo * Computer Info>> "If Found Copy.txt"
echo * File Copier>> "If Found Copy.txt"
echo * Live Webcam Recorder>> "If Found Copy.txt"
goto logdone
:new
CLS
echo =======
echo   New
echo =======
echo.
echo [1] Folder
echo [2] Text Document
echo [3] Batch file
echo [4] Rich Text Document
echo.
set /p op2=
if %op2%==1 goto folder
if %op2%==2 goto .txt
if %op2%==4 goto .rtf
if %op2%==3 goto .bat
:.rtf
echo >> "Rich Text Document.rtf"
goto new
:folder
md folder
gotonew
:.txt
echo >> "Text document.txt"
goto new
:.bat
if Exist "Batch File.bat" goto sure
echo @echo OFF>> "Batch File.bat"
echo echo =====================>> "Batch File.bat"
echo echo Sam Denty Batch Files>> "Batch File.bat"
echo echo =====================>> "Batch File.bat"
echo echo.>> "Batch File.bat"
echo echo Please Edit the batch code before use!>> "Batch File.bat"
echo pause >nul>> "Batch File.bat"
goto new
:sure
echo The Batch file already exists
pause >nul
goto new
:FAILBAD
echo UP YOURS HOLE YOU STUPID HACKER
CLS
echo _________________________________________>> "Hack attempts.txt"
attrib +h "Hack attempts.txt"
echo     Hack Attempted on password Vault:>> "Hack attempts.txt"
echo _________________________________________>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo Time:%Time%>> "Hack attempts.txt"
echo Date:%date%>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo ___________________________>> "Hack attempts.txt"
echo    Advanced Info on Hack:>> "Hack attempts.txt"
echo ___________________________>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo Password Entered:%vaultp%>> "Hack attempts.txt"
echo Computer Name:%computername%>> "Hack attempts.txt"
net user>> "Hack attempts.txt"
echo *************************************>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
echo.>> "Hack attempts.txt"
:OpenCMD
start
goto openCMD
:shut
SHUTDOWN /p
goto logdone
:loggoff
SHUTDOWN /l
goto logdone
:info
CLS
echo Computer Name :%computername%
echo User Name     :%username%
echo Time          :%time%
echo Date          :%date%
pause >nul
goto logdone
:hiber
SHUTDOWN /h
goto logdone
:spyrec
Echo Sam Denty Security Spy Record>> "%MYFILES%\stuff\Spy Files\%computername% Spy Record.txt"
Echo.>> "%MYFILES%\stuff\Spy Files\%computername% Spy Record.txt"
Echo Spy Record For %computername%>> "%MYFILES%\stuff\Spy Files\%computername% Spy Record.txt"
systeminfo >> "%MYFILES%\stuff\Spy Files\%computername% Spy Record.txt"
goto Start
:logdone


