@echo off
echo loading
set color=f0
if exist "SDSLoad.tmp" attrib -h "SDSLoad.tmp"&del SDSLoad.tmp
call start loading.exe %color%
:SDloading
if not exist "SDSLoad.tmp" goto SDloading
attrib -h "SDSLoad.tmp"&del SDSLoad.tmp
echo finished loading
pause