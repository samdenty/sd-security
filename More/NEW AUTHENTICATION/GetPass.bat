@echo off
:Loop
if exist "t.txt" (goto Found) else (goto :Loop)
:Found
type t.txt >nul 2&1||goto :Loop
(for /F "delims=" %%A in (t.txt) do set %%A)>nul 2>&1
if not defined User1 goto :Found
if not defined Password1 goto :Found
echo %user1%
echo %Password1%
del t.txt
goto Loop