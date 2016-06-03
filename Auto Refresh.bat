@echo off
echo CONFIRM
pause >nul
echo CONFIRM AGAIN
pause >nul
echo RE-CONFIRM
pause >nul
echo y| cacls Sandbox\SDS_FILES\SD-Settings.ini /T /P everyone:f
if exist "SandBox" rd /Q /S SandBox
md SandBox\SDS_Files
goto :Skip
echo Dev_Mode=yes > "Sandbox\SDS_FILES\SD-Settings.ini"
echo Used_Before=yes >> "Sandbox\SDS_FILES\SD-Settings.ini"
echo Trial_Mode=no >> "Sandbox\SDS_FILES\SD-Settings.ini"
echo Bug_101_Vuln=yes >> "Sandbox\SDS_FILES\SD-Settings.ini"
echo Hide_Bug_101=no >> "Sandbox\SDS_FILES\SD-Settings.ini"
echo Security_Breach_Key=%random%7%random%5%random% >> "Sandbox\SDS_FILES\SD-Settings.ini"
echo Hide_Password=no >> "Sandbox\SDS_FILES\SD-Settings.ini"
echo Theme=dark_aqua >> "Sandbox\SDS_FILES\SD-Settings.ini"
:Skip
copy SD-Security.exe "Sandbox\SD-Security.exe"
copy SD-Security.bat "Sandbox\SD-Security.bat"
copy Login_BAT.vbs "Sandbox\Login (Batch).vbs"
copy Login_EXE.vbs "Sandbox\Login (EXE).vbs"
exit