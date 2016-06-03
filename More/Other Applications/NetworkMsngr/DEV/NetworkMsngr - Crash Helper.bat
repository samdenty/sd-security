@echo off
if exist "SDS_Files\NetworkMsngr\Disable*" goto :CrashHelperActive
set appName=%~n0
setlocal&cls
if "%restart%" == "0" goto CrashHelperActive
goto CrashHelper
:CrashHelperActive
if /i "%IgnoreCrash%" == "yes" (if "%CrashTimes%" == "100" goto :ConstantCrashing) else (if "%CrashTimes%" == "5" goto :ConstantCrashing)
color f0
title NetworkMsngr, By SD-Storage
if exist "notifyIcon.ico" attrib +h +s "notifyIcon.ico"
if exist "ring.wav" attrib +h +s "ring.wav"
if "%extd%" == "" set extd=REM
if '%b2eextd%' == '' set b2eextd=%extd%
if exist "SDS_Files\NetworkMsngr\Settings.ini" (for /F "eol=# delims=" %%A in (SDS_FILES\NetworkMsngr\Settings.ini) do set %%A) else (call :FirstRun)
if not "%1" == "" call :CommandSwitchEntered
if /i "%Show_Popup_Screen_On_Startup%" == "yes" %extd% /messagebox "NetworkMsngr Started" "The NetworkMsngr Service Has Successfully Been Started"
if /i not "%Default_Message_Stream_Location%" == "no" (set MessageStream=%Default_Message_Stream_Location%) else (call :BrowseForStream)
:: Message Stream Configuration
set LocalMessageStream=SDS_Files\NetworkMsngr\MessageStream.NetworkMsngr
call :GetSerial
if not exist "%localMessageStream%" copy /Y %messageStream% "%LocalMessageStream%" >nul 2>&1
:CheckForMessages
if not exist "%MessageStream%" goto StreamInterrupted
if not exist "%LocalMessageStream%" goto StreamInterrupted
call :Settime
echo                            Checking For Messages
if not "%Refresh_Speed%" == "0" timeout /t %refresh_Speed% >nul 2>&1
for /f "skip=4 delims=" %%a in (%MessageStream%) do set MessageStreamText=%%a
for /f "skip=4 delims=" %%a in (%LocalMessageStream%) do set LocalMessageStreamText=%%a
if not "%LocalMessageStreamText%" == "%MessageStreamText%" goto :newMessage
echo Negative %twelve%
goto CheckForMessages

:newMessage
echo Positive %twelve%
copy /Y %messageStream% "%LocalMessageStream%" >nul 2>&1
for /f "delims=" %%a in ('type %MessageStream%^|findstr /I "Sender="') do set %%a
for /f "delims=" %%a in ('type %MessageStream%^|findstr /I "SendTime="') do set %%a
for /f "delims=" %%a in ('type %MessageStream%^|findstr /I "MessageReceiver="') do set %%a
for /f "delims=" %%a in ('type %MessageStream%^|findstr /I "SenderSerial="') do set %%a
if /i "%SenderSerial%" == "%serial%" goto NewLocalMessage
if /i "%MessageReceiver%" == "everyone" goto ShowMessage
if /i "%MessageReceiver%" == "all" goto ShowMessage
if /i "%MessageReceiver%" == "*" goto ShowMessage
if /i not "%MessageReceiver%" == "%computername%" goto :CheckForMessages
:ShowMessage
if /i "%Show_Extra_Information%" == "yes" goto :NewMessageAdvanced
if "%extd%" == "" goto :CheckForMessages
set WinTitle=New Message Command Window #%Random%
set MessageID=%random%
set MessageWinTitle=Message received from %Sender% - NetworkMsngr ID:%MessageID%
call start "%WinTitle%" /min %b2eextd% /messagebox "%MessageWinTitle%" "%sendTime%: %messageStreamText%"
call :ConfigMessageWindow
call :settime&echo ^|^|Log^|^|  ^|Message: Received^| ^|ID: %MessageID%^| From: %sender%^| ^|Send-Time: %sendTime%^| ^|Receive-Time: %twelve%^|>> "SDS_Files\NetworkMsngr\Message_Log.txt"
goto :CheckForMessages

:NewMessageAdvanced
if "%extd%" == "" goto :CheckForMessages
set WinTitle=New Message Command Window #%Random%
set MessageID=%random%
set MessageWinTitle=Message received from %Sender% - NetworkMsngr ID:%MessageID%
call start "%WinTitle%" /min %b2eextd% /messagebox "%messageWinTitle%" "Message From '%Sender%' with the serial '%senderSerial%' at %SendTime%: '%messageStreamText%'"
call :ConfigMessageWindow
call :settime&echo ^|^|Log^|^|  ^|Message: Received^| ^|ID: %MessageID%^| From: %sender%^| ^|Send-Time: %sendTime%^| ^|Receive-Time: %twelve%^|>> "SDS_Files\NetworkMsngr\Message_Log.txt"
goto :CheckForMessages

:ConfigMessageWindow
%extd% /sleep 5
%extd% /hidewindow "%WinTitle%"
%extd% /maketoolwindow "%MessageWinTitle%"
%extd% /setforegroundwindow "%MessageWinTitle%"
%extd% /windowontop "%MessageWinTitle%"
goto :EOF

:NewLocalMessage
call :notify "Message: '%messageStreamText%' If you didn't send this message, then the sender '%sender%' spoofed your serial" "Message Sent Successfully"
goto :CheckForMessages

:StreamInterrupted
if /i "%Hide_All_Error_Popups%" == "yes" goto :CheckForMessages
%extd% /messagebox "Error - NetworkMsngr" "Failed to connect to message transfer stream!" 5
if "%result%" == "4" cls&goto :CheckForMessages

if "%result%" == "2" goto :end
goto :end

:BrowseForStream
%extd% /browseforfile "Browse for the message stream file" "" "NetworkMsngr Streams (*.NetworkMsngr)|*.NetworkMsngr"
if "%result%" == "" (goto :end) else (set MessageStream=%result%&if not exist "%MessageStream%" goto InvalidStream)
echo ^|^|Log^|^|  ^|Stream: Received^| ^|Location: %messageStream%^|>> "SDS_Files\NetworkMsngr\Message_Log.txt"
goto :EOF

:InvalidStream
set "result="
%extd% /messagebox "Error" "The Specified File Doesn't Seem To Exist BUT Click Continue If It's On A Network Drive Or If You Know It Exists" 6
IF %result% EQU 2 goto end
IF %result% EQU 10 goto :BrowseForStream
IF %result% EQU 11 goto :EOF
goto :BrowseForStream

:CommandSwitchEntered
if /i not "%Enable_Command_Line_Options%" == "yes" goto :EOF
set Default_Message_Stream_Location=%~1
if not "%2" == "" (set Refresh_Speed=%~2) else (set Refresh_Speed=0)
goto :EOF

:FirstRun
md SDS_Files\NetworkMsngr
call :settime
echo ^|^|First Time Install^|^|  ^|Time: %twelve%^| ^|Date: %date2%^|>> "SDS_Files\NetworkMsngr\Message_Log.txt"
echo # Settings for NetworkMsngr, by SD-Storage> "SDS_Files\NetworkMsngr\Settings.ini"
echo # If configured incorrectly, Then delete this file and the settings will be reset>> "SDS_Files\NetworkMsngr\Settings.ini"
echo # Here are all the options that you can set (* stands for the location of a file): >> "SDS_Files\NetworkMsngr\Settings.ini"
echo # #1 : no, *>> "SDS_Files\NetworkMsngr\Settings.ini"
echo # #2 : no, yes>> "SDS_Files\NetworkMsngr\Settings.ini"
echo # #3 : no, yes>> "SDS_Files\NetworkMsngr\Settings.ini"
echo # #4 : no, yes>> "SDS_Files\NetworkMsngr\Settings.ini"
echo # #5 : no, yes>> "SDS_Files\NetworkMsngr\Settings.ini"
echo # #6 : 0,1,2,3,,,99999>> "SDS_Files\NetworkMsngr\Settings.ini"
echo # Below are the actual settings: >> "SDS_Files\NetworkMsngr\Settings.ini"
echo ############################ >> "SDS_Files\NetworkMsngr\Settings.ini"
echo Default_Message_Stream_Location=no>> "SDS_Files\NetworkMsngr\Settings.ini"
echo Hide_All_Error_Popups=no>> "SDS_Files\NetworkMsngr\Settings.ini"
echo Show_Extra_Information=no>> "SDS_Files\NetworkMsngr\Settings.ini"
echo Enable_Command_Line_Options=yes>> "SDS_Files\NetworkMsngr\Settings.ini"
echo Show_Popup_Screen_On_Startup=no>> "SDS_Files\NetworkMsngr\Settings.ini"
echo Refresh_Speed=0 >> "SDS_Files\NetworkMsngr\Settings.ini"
if exist "SDS_Files\NetworkMsngr\Settings.ini" for /F "eol=# delims=" %%A in (SDS_FILES\NetworkMsngr\Settings.ini) do set %%A
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
:GetSerial
for /f "skip=1 delims=" %%a in ('vol %windir:~0,2%') do set serial=%%a
set serial=%serial:~-9,9%
goto :EOF
:Notify
:: Notify API, This API Uses Powershell To Show A Popup In The Notification Tray That Can Display Custom Text
:: Usage: CALL :Notify [Message] [Message Title] [Tray Icon File]
set one=%~1
set two=%~2
set three=%~3
if "%one%" == "" set one=Switch To SD-Security
if "%two%" == "" set two=SD-Security
if "%three%" == "" set three=notifyIcon.ico
set NotifyWinTitle=Notify API #%random%
echo $host.ui.RawUI.WindowTitle = "%NotifyWinTitle%" > "%temp%\Notify_API_SDS.ps1"
echo [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify = New-Object System.Windows.Forms.NotifyIcon >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.Icon = "%three%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipIcon = "None" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipText = "%one%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.BalloonTipTitle = "%two%" >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.Visible = ^$True >> "%temp%\Notify_API_SDS.ps1"
echo ^$Notify.ShowBalloonTip(10000) >> "%temp%\Notify_API_SDS.ps1"
call start "%NotifyWinTitle%" /min cmd /c "powershell -executionpolicy bypass -File "%temp%\Notify_API_SDS.ps1""
%extd% /hidewindow "%NotifyWinTitle%"
goto :EOF
:CommandSwitchHelp
set HelpWinTitle=Command Line Switches #%random% - NetworkMsngr
call start cmd /c "mode con: cols=79 lines=23&color f8&title %HelpWinTitle%&echo.&echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ&echo  ÛÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßÛÛÛÛ&echo  þþþþ N e t w o r k M s n g r   C o m m a n d   L i n e   S w i t c h e s þþþþ&echo  ÛÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÛ&echo  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ&echo  ÛÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿Û&echo  Û³  NetworkMsngr is a windows application that can replace the 'net send'  ³Û&echo  Û³           command that was removed a few operating systems ago.         ³Û&echo  Û³    You can use NetworkMsngr by launching the EXE, or you can use the    ³Û&echo  Û³             command line switches. Here are all the switches            ³Û&echo  ÛÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´Û&echo  Û³ Usage: %appname% [StreamFile] [RefreshSpeed]&echo  Û³                                                                         ³Û&echo  Û³    StreamFile     The File Which Transfers Message Data To Other        ³Û&echo  Û³                     Computers (.NetworkMsngr File)                      ³Û&echo  Û³                                                                         ³Û&echo  Û³    RefreshSpeed   The Amount Of Time (In Seconds) It Waits To Check     ³Û&echo  Û³                     For New Messages (0 Is The Quickest 99999 Is The    ³Û&echo  Û³                     Slowest)                                            ³Û&echo  ÛÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÛ&echo  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß&pause >nul&exit"
%extd% /maketoolwindow "%HelpWinTitle%"
%extd% /setforegroundwindow "%HelpWinTitle%"
goto :Start
:CrashHelper
set restart=0
if "%1" == "/?" call :CommandSwitchHelp&call cmd /f:f0 /c %0
call cmd /c %*
if errorlevel 999 exit
endlocal
if "%CrashTimes%" == "" set CrashTimes=0
set /a "CrashTimes=%CrashTimes%+1" >nul
call start cmd /c %0
exit 999
:ConstantCrashing
%extd% /messagebox "Program Crash Report" "NetworkMsngr Has Crashed %CrashTimes% Times,  This Could Be A Hack Attempt, Misconfigured Settings Or A Bug In The Software. What Would You Like To Do?" 50
if "%result%" == "3" exit 999
if "%result%" == "4" exit
if "%result%" == "5" set IgnoreCrash=yes&exit
exit
:end
exit 999