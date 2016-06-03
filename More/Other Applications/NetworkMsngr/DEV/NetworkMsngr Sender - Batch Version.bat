@echo off
if exist "SDS_Files\NetworkMsngr\Settings.ini" (for /F "eol=# delims=" %%A in (SDS_FILES\NetworkMsngr\Settings.ini) do set %%A) else (call :FirstRun)
if not "%~1" == "" goto setVariableSwitches
goto CreateMessage
:SendMessage
call :Settime
call :getSerial
echo MessageReceiver=%MessageReceiver%> "%MessageStream%"
echo Sender=%Sender%>> "%MessageStream%"
echo SendTime=%twelve%>> "%MessageStream%"
echo SenderSerial=%serial%>> "%MessageStream%"
echo %message% >> "%MessageStream%"
goto :End

:setVariableSwitches
if not "%~1" == "" (set MessageStream=%~1) else (call :BrowseForStream)
if not "%~3" == "" (set MessageReceiver=%~3) else (set MessageReceiver=everyone)
if not "%~4" == "" (set Sender=%~4) else (set Sender=%computername%)
if not "%~2" == "" (set Message=%~2) else (call :CreateMessage2)
goto :SendMessage

:CreateMessage
call :BrowseForStream
set MessageReceiver=everyone
set Sender=%computername%
call :CreateMessage2
goto Recipents
:CreateMessage2
set /p Message="Enter Your Message: "
goto :EOF
:Recipents
set /p MessageReceiver="PC To Send To (Type 'Everyone' To Send To Everyone): "
goto :SendMessage

:BrowseForStream
set /p MessageReceiver= "Location Of The Message Stream File: "
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
:SetTimeFinished
set fulldate=%date:~4%
set date2=%daydig%/%monthDig%/%year%
goto :EOF
:GetSerial
for /f "skip=1 delims=" %%a in ('vol %SystemDrive%') do set serial=%%a
set serial=%serial:~-9,9%
goto :EOF
:end