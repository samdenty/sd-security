@echo off
color f0
cls
title Helpfile Generator - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                Helpfile Generator                %status%
echo �������������������������������������������������������������������������������
echo.
set /p "GenName=App Name �� "
set /p "GenAuthor=Author �� "
set /p "GenDate=App Release Date �� "
set /p "GenUpdate=App Update Date �� "
set /p "GenSupport=SD-Security Version Support �� "
set /p "GenWinSupport=Windows OS Support �� "
set /p "GenScriptLanguage=Script Programming Language �� "
echo.
echo App Details/Info ��
set /p "FormInfo=�� "
echo Other ��
set /p "FormInfo=�� "
echo.
echo                          Launching Save File Dialog...                        
%extd% /savefiledialog "Save App Help File As" "About.txt" "Help Files (About.txt)|About.txt"
if "%Result%" == "" (set File=About.txt) else (set "File=%result%")
(echo �������������������������������������������������������������������������������
 echo � App/Plugin Name �� "%GenName%"
 echo � Author          �� "%GenAuthor%"
 echo � Creation Date   �� "%GenDate%"
 echo � Update Date     �� "%GenUpdate%"
 echo � SDS Support     �� "%GenSupport%"
 echo � Windows Support �� "%GenWinSupport%"
 echo � Script Language �� "%GenScriptLanguage%"
 echo �������������������������������������������������������������������������������
 echo.
 echo                                    ����������
 echo                                    � INFO �:�
 echo �������������������������������������������������������������������������������
 echo.
 echo �� "%FormInfo%"
 echo.
 echo                                    �����������
 echo                                    � OTHER �:�
 echo �������������������������������������������������������������������������������
 echo.
 echo �� "%FormSettings%")> "%File%"