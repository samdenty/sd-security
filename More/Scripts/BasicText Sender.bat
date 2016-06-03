@Echo off
color 5D
set MessageSenderEXELocation=C:\Users\%username%\SD-Security\NetworkMsngr Sender.exe
set computerToText=SD-Laptop
set StreamFileLocation=\\%computerToText%\Unlocked\MessageStream.NetworkMsngr
call :GetIP "%computerToText%"
if "%ip%" == "" (echo Cannot Connect To %computerToText%, Check That You Are Connected To The Same WiFi Network And That %computerToText% Is On&timeout 5 /nobreak >nul&exit) else (goto :SendMessage)
:SendMessage
call start "Killing Bad Processes" /min cmd /c ""%MessageSenderEXELocation%" "%StreamFileLocation%""
echo Launching Message Sender Application...
timeout 3 /nobreak >nul
exit



:GetIp
if "%1" == "" (set GetIP=%computername%) else (set GetIP=%~1)
for /f "tokens=1,2 delims=[]" %%a in ('ping -w 1 -n 1 -4 "%GetIP%"^|findstr "Pinging"') do set IP=%%b
goto :EOF