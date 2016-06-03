@echo off
if exist "RemoteConsole_SYNC\Client.bat" del RemoteConsole_SYNC\Client.bat
:Get_Remote_Command
if exist "RemoteConsole_SYNC\Command_%RemoteConsole_Band%.bat" (call RemoteConsole_SYNC\Command_%RemoteConsole_Band%.bat&del RemoteConsole_SYNC\Client.bat)
goto :Get_Remote_Command