@echo off
if "%1" == "/?" goto Help
if /i "%1" == "?" goto Help
if /i "%1" == "help" goto Help
if /i "%1" == "/help" goto Help
if "%1" == "" goto Help
if "%2" == "" goto Help
if "%3" == "" goto Help
set file=%1
set newfile2=%2
set newfileExtension=%3
set filePrefix= (
set fileSuffix=)
set /a "number=0" >nul
if not exist "%file%" goto NoFile
if not exist "%newfile2%%newfileExtension%" copy %file% "%newfile2%%newFileExtension%" >nul&set NumberOnEnd=no&goto copyDone
:loop
set /a number=%number% +1 >nul
if exist "%newfile2%%filePrefix%%number%%fileSuffix%%newFileExtension%" goto loop
copy %file% "%newfile2%%filePrefix%%number%%fileSuffix%%newFileExtension%" >nul
if not exist "%newfile2%%filePrefix%%number%%fileSuffix%%newFileExtension%" goto CannotCreateFile
set NumberOnEnd=yes
:copyDone
if %NumberOnEnd%==no goto noCopyNum
:CopyNum
set newfile=%newfile2%%filePrefix%%number%%fileSuffix%%newfileExtension%
goto endCopy
:NoCopyNum
set newfile=%newfile2%%newfileExtension%
goto endCopy
:NoFile
echo Cannot Find The File Specified
goto end
:CannotCreateFile
Echo Cannot Copy The File, No Permissions / Read-Only
goto end
:VariblesSetAfter
echo Is there A Number On The End: %NumberOnEnd%
echo New File Name: %newfile%
echo File Used To Copy: %file%
echo New File Extension: %newfileExtension%
echo File Name: %newfile2%
:endCopy
if not exist "%newfile2%%newFileExtension%" goto CannotCreateFile
echo Copied 1 File (%file% - %newfile%)
goto end
:help
echo Advanced Copy Commands For Windows, Allows You To Easily Copy A File
echo With Numbering. Here Is How You Use The Clone Command:
echo.
echo Clone [File To Be Cloned] [New File Name] [New File Extension]
echo.
echo /Help               Displays this help screen
echo.
echo When A File Has Successfully Been Cloned It Will Set The Below Variables:
echo.
echo %%NumberOnEnd%%       Specifies Whether Numbering Was Used
echo                     Value: 'yes' , 'no'
echo.
echo %%File%%              Specifies The File That Was Cloned
echo                     Value: User Defined
echo.
echo %%NewFile%%           Specifies The Full Name Of The Clone File
echo                     Value: User Defined
echo.
echo %%NewFile2%%          Specifies The Name Of The Clone File
echo                     Value: User Defined
echo.
echo %%NewFileExtension%%  Specifies The Extension Of The Clone File
echo                     Value: User Defined
echo                        Press Any Key To Continue
pause >nul
echo A Basic Script That Would Copy A File To A Folder And Automatically Rename It:
echo.
echo ^@echo off
echo set fileToCopy=C:\test.png
echo set NewFileName=C:\temp\picture
echo set NewFileExt=.png
echo Clone %%fileToCopy%% %%NewFileName%% %%NewFileExt%%
echo.
echo That Script Would Copy 'C:\test.png' To 'C:\temp' With The File 'picture' And
echo The Extension '.png'. If The File Already Existed It Would Rename Them To:
echo (1) , (2) , (3).... Forever, This Is A Feature That The Copy Command Lacks.
echo.
echo Clone Command Designed By XLR8 From SD-Storage
echo This Is A SD-Security API, (C) SD-Security All Rights Reserved.
goto end
:end
