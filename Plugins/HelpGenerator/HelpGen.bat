@echo off
color f0
cls
title Helpfile Generator - SD-Security©
echo ÛÛÛßßßßßßßßßßßßßÛÛÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
echo þþþ SD-Security þþþ                Helpfile Generator                %status%
echo ÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÛÛÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
echo.
set /p "GenName=App Name Ûþ "
set /p "GenAuthor=Author Ûþ "
set /p "GenDate=App Release Date Ûþ "
set /p "GenUpdate=App Update Date Ûþ "
set /p "GenSupport=SD-Security Version Support Ûþ "
set /p "GenWinSupport=Windows OS Support Ûþ "
set /p "GenScriptLanguage=Script Programming Language Ûþ "
echo.
echo App Details/Info Ûþ
set /p "FormInfo=Ûþ "
echo Other Ûþ
set /p "FormInfo=Ûþ "
echo.
echo                          Launching Save File Dialog...                        
%extd% /savefiledialog "Save App Help File As" "About.txt" "Help Files (About.txt)|About.txt"
if "%Result%" == "" (set File=About.txt) else (set "File=%result%")
(echo ÛßßßßßßßßßßßßßßßßßÛßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
 echo Û App/Plugin Name Ûþ "%GenName%"
 echo Û Author          Ûþ "%GenAuthor%"
 echo Û Creation Date   Ûþ "%GenDate%"
 echo Û Update Date     Ûþ "%GenUpdate%"
 echo Û SDS Support     Ûþ "%GenSupport%"
 echo Û Windows Support Ûþ "%GenWinSupport%"
 echo Û Script Language Ûþ "%GenScriptLanguage%"
 echo ÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
 echo.
 echo                                    ÛßßßßßßÛßÛ
 echo                                    Û INFO Û:Û
 echo ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛÜÜÜÜÜÜÛÜÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
 echo.
 echo Ûþ "%FormInfo%"
 echo.
 echo                                    ÛßßßßßßßÛßÛ
 echo                                    Û OTHER Û:Û
 echo ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛÜÜÜÜÜÜÜÛÜÛÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
 echo.
 echo Ûþ "%FormSettings%")> "%File%"