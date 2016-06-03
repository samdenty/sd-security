@echo off
color 0f
if exist "off.tmp" del off.tmp
if exist "on.tmp" del on.tmp
:WaitForOn
if exist "on.tmp" del on.tmp&color f0&goto WaitForOff
goto :WaitForOn
:waitForOff
if exist "off.tmp" del off.tmp&color 0f&goto WaitForOn
goto WaitForOff
