@echo off
REM setlocal enabledelayedexpansion
set _tempid=%random%
set ZHg5=dx9ware
if exist C:\ProgramData\$CheckAgent$\output.txt del C:\ProgramData\$CheckAgent$\output.txt
if exist C:\ProgramData\$CheckAgent$\exe.txt del C:\ProgramData\$CheckAgent$\exe.txt
title %_tempid% [%date%]
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
goto :var





:var
set ZHg5Zm9sZGVy=false
set ZHg5ZGxs=false
set dx9injector=false
set fnd_dx9ware=false
cd C:\ProgramData
md $CheckAgent$
cls
goto :main

:main
::
CHOICE /N /M "Do you consent to a pc check? [Y/N]"

IF ERRORLEVEL == 2 (
	shutdown /r /t 000
	EXIT /B 1
)
::

cls
if exist C:\Users\%USERNAME%\AppData\Roaming\%ZHg5% set fnd_dx9ware=true
if exist C:\Users\%USERNAME%\AppData\Roaming\%ZHg5%\%ZHg5%.dll set fnd_dx9ware=true
cls
cd C:\
echo Please wait, the following check(s) can take a while depending on your computer hardware
::
(
for /r %%x in (*.exe) do echo "%%x"
) > "C:\ProgramData\$CheckAgent$\exe.txt"
::
goto :next

:next
cls
findstr /I "dx9injector.exe" C:\ProgramData\$CheckAgent$\exe.txt
if errorlevel 0 set dx9injector=true
if errorlevel 1 set dx9injector=false
if %dx9injector% == true set fnd_dx9ware=true
cls
echo [40;34mSearching for folder(s)[40;0m 
echo [40;34mSearching for dll(s)[40;0m 
echo [40;34mSearching for injector(s)[40;0m 
:output
if %fnd_dx9ware% == true echo [%time%+%date%] Found dx9ware! > C:\ProgramData\$CheckAgent$\output.txt && echo [40;31mDetected Violation[40;0m
if %fnd_dx9ware% == false echo [%time%+%date%] Couldn't find dx9ware! > C:\ProgramData\$CheckAgent$\output.txt
echo [40;34mOpening log file[40;0m 
timeout 1 >nul
start C:\ProgramData\$CheckAgent$\output.txt
if %fnd_dx9ware% == true start dx9injector.exe && echo Exposed by kxfps ;)
pause >nul