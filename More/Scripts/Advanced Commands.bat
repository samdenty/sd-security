@echo off
:: Detects Windows Version
ver |findstr 6.3

:: Compares File Text
FC /L D:\old_file D:\New_file

:: Checks If A Task Is Running And Kills It
Tasklist |findstr process.exe>nul&&taskkill /t /f /IM proccess.exe
UPDATE: taskkill /t /f /im proccess.exe >nul 2>&1

:: Converts A Drive To NTFS
convert F: /X /FS:NTFS

:: Label (Requires Admin)
label F SD-Security

:: Create A Drive From A Directory
Subst F: Folder
::Remove IT
subst /d F: