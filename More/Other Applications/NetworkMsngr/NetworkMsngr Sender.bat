@echo off
set appName=%~n0
if "%extd%" == "" set extd=REM
if not "%~1" == "" goto setVariableSwitches
goto CreateMessage
:SendMessage
call :Settime
call :GetSerial
set TempFile=%Temp%\TmpMessage_#%random%.NetworkMsngr
if /i not "%SerialOveride%" == "" set serial=%SerialOveride%
echo MessageReceiver=%MessageReceiver%> "%TempFile%"
echo Sender=%Sender%>> "%TempFile%"
echo SendTime=%twelve%>> "%TempFile%"
echo SenderSerial=%serial%>> "%TempFile%"
echo %message% >> "%TempFile%"
attrib -r "%MessageStream%"
set Trys=0
:TryAgainToCopyFile
set /a Trys=%trys%+1 >Nul
if "%Trys%" == "20" goto NoGoCopy
if "%Trys%" == "50" goto NoGoCopy
if "%Trys%" == "100" goto NoGoCopy
if "%Trys%" == "200" goto NoGoCopy
if "%Trys%" == "300" goto NoGoCopy
if "%Trys%" == "400" goto NoGoCopy
copy /Y %tempFile% "%MessageStream%" >nul 2>&1
if not "%errorlevel%" == "0" goto TryAgainToCopyFile
attrib +r "%MessageStream%"
goto :End

:setVariableSwitches
if "%~1" == "/?" call :HelpScreen&goto end
if not "%~1" == "" (set MessageStream=%~1) else (call :BrowseForStream)
if not "%~3" == "" (set MessageReceiver=%~3) else (set MessageReceiver=everyone)
if not "%~4" == "" (set Sender=%~4) else (set Sender=%computername%)
if not "%~5" == "" (set SerialOveride=%~5) else (set "SerialOveride=")
if not "%~2" == "" (set Message=%~2) else (call :CreateMessage2)
goto :SendMessage

:CreateMessage
call :BrowseForStream
set MessageReceiver=everyone
set Sender=%computername%
call :CreateMessage2
goto Recipients
:CreateMessage2
%extd% /inputbox "Create Message" "Enter Your Message In The Box Below" ""
if "%result%"=="" (goto :end) else (set Message=%result%)
goto :EOF
:Recipients
%extd% /inputbox "Recipients" "PC To Send To (Type 'Everyone' To Send To Everyone)" ""
if "%result%"=="" (goto :end) else (set MessageReceiver=%result%)
goto :SendMessage

:BrowseForStream
set "result="&%extd% /browseforfile "Browse for the message stream file" "" "NetworkMsngr Streams (*.NetworkMsngr)|*.NetworkMsngr"
if "%result%"=="" (goto :end) else (set MessageStream=%result%&if not exist "%MessageStream%" goto InvalidStream)
goto :EOF

:InvalidStream
set "result="
%extd% /messagebox "Error" "The Specified File Doesn't Seem To Exist BUT Click Continue If It's On A Network Drive Or If You Know It Exists" 6
IF %result% EQU 2 goto end
IF %result% EQU 10 goto :BrowseForStream
IF %result% EQU 11 goto :EOF
goto :BrowseForStream

:: Time API
:setTime
set "time="
set seconds=%time:~0,-3%
set seconds=%seconds:~-2%
echo %seconds%
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
set Twelve=%hour%:%minutes%: %Seconds%
:SetTimeFinished
set fulldate=%date:~4%
set date2=%daydig%/%monthDig%/%year%
goto :EOF
:GetSerial
for /f "skip=1 delims=" %%a in ('vol %windir:~0,2%') do set serial=%%a
set serial=%serial:~-9,9%
goto :EOF
:HelpScreen
call start cmd /c "mode con: cols=79 lines=31&color f8&title Command Line Switches - NetworkMsngr&echo.&echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ&echo  ÛÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛÛÛÛ&echo  þþþþ N e t w o r k M s n g r   C o m m a n d   L i n e   S w i t c h e s þþþþ&echo  ÛÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÛ&echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ&echo  ÛÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿Û&echo  Û³  NetworkMsngr is a windows application that can replace the 'net send'  ³Û&echo  Û³           command that was removed a few operating systems ago.         ³Û&echo  Û³    You can use NetworkMsngr by launching the EXE, or you can use the    ³Û&echo  Û³             command line switches. Here are all the switches            ³Û&echo  ÛÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´Û&echo  Û³ %appname% [StreamFile] [Message] [Recipients] [Sender] [Serial]&echo  Û³                                                                         ³Û&echo  Û³    StreamFile     The File Which Transfers Message Data To Other        ³Û&echo  Û³                   Computers                                             ³Û&echo  Û³                                                                         ³Û&echo  Û³    Message        The Message That You Want To Send To An Other PC      ³Û&echo  Û³                                                                         ³Û&echo  Û³    Recipent       The Computer(s) That Should Receive Your Messages     ³Û&echo  Û³                                                                         ³Û&echo  Û³    Sender         The Name That You Want The Message To Be From         ³Û&echo  Û³                   (Default Is The Computers Name)                       ³Û&echo  Û³                                                                         ³Û&echo  Û³    Serial         You Can Spoof Your Serial Number By Using This Option ³Û&echo  Û³                   The Default Is The Drive Serial Number. When You      ³Û&echo  Û³                   Override It, The Recipients Can't See The Original    ³Û&echo  Û³                   Sender, Making The Message Anonymous                  ³Û&echo  ÛÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÛ&echo  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß&pause >nul"
goto :EOF
:NoGoCopy
%extd% /messagebox "Failed To Send Message" "Failed To Send Message, %Trys% Times! What Would You Like To Do?" 5
if "%result%" == "2" goto :end
if "%result%" == "4" goto :TryAgainToCopyFile
goto :End
:end
exit