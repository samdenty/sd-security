@echo off
echo call sd-security.bat|cmd
exit
if errorlevel 999 exit
color F0
mode con: cols=80 lines=27
cls
title Crash Handler - SD-Security�
echo �������������������������������������������������������������������������������
echo ��� SD-Security ���                 Crash Handler                    %status%
echo �������������������������������������������������������������������������������
echo.
echo              It Was Detected That SD-Security Has Just Crashed
echo      This Crash Happened Due To A Bug, Would You Like To Send An Email To
echo                        SD-Security Explaining What Happened?
echo.
echo ���
echo �1�  Yes (You Need An Email Account)
echo �2�  No
set /p sendCrashEmail="�� "
if "%sendCrashEmail%" == "1" goto sendEmail
goto end
:sendEmail
start mailto:Samdenty99@outlook.com
goto end
:end
set year=20%date:~-2,2%
cls
title Exit - SD-Security�
echo �������������������������������������
echo ��� SD-Security ���  EXIT  Signed Out
echo �������������������������������������
echo.
echo     �����������������������������
echo.    �� � � � � � � � � � � � � ��
echo     � ������������������������� �
echo     ���     -------           ���
echo     � �      \  /^| \          � �
echo     ���       \/ ^|   \        ���
echo     � �      / \ ^|     \      � �
echo     ���    /    \^|       \    ���
echo     � �   �����������������   � �
echo     ���   �%year% SD-Security   ���
echo     � ������������������������� �
echo     �����������������������������
echo     �� � � � � � � � � � � � � ��
echo     �����������������������������
timeout 2 >nul /nobreak
exit