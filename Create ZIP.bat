@echo off
if not exist "ZipFiles\" md ZipFiles
if exist "SD-Security.zip" del SD-Security.zip
if exist "SD-Security.exe" copy /y SD-Security.exe "ZipFiles\SD-Security.exe"
if exist "SD-Security.chm" copy /y SD-Security.chm "ZipFiles\Help.chm"
if exist "..\Archives\History.SDS_History" copy /y "..\Archives\History.SDS_History" "ZipFiles\What's New.txt"
if exist "Portable Compiler\Installer\SD-SecurInstaller.exe" copy /y "Portable Compiler\Installer\SD-SecurInstaller.exe" "ZipFiles\Installer.exe"
%extd% /zip ZipFiles SD-Security.zip
pause