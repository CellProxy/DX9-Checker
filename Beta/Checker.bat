@echo off
set _tempid=%random%
set ZHg5=dx9ware
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
set 1=%username%
set 2=%appdata%
set ZHg5Zm9sZGVy=false
set ZHg5ZGxs=false
set ZHg5aW5qZWN0=false
cd C:\ProgramData
md $CheckAgent$
cls
goto :main
:main
CHOICE /N /M "Do you consent to a pc check? [Y/N]"

IF ERRORLEVEL == 2 (
	shutdown /r /t 000
	EXIT /B 1
)
cls
if exist C:\Users\%USERNAME%\AppData\Roaming\%ZHg5% set ZHg5Zm9sZGVy=true
timeout 1 >nul
echo [40;34mSearching for folder(s)[40;0m 
timeout 1 >nul
if exist C:\Users\%USERNAME%\AppData\Roaming\%ZHg5%\%ZHg5%.dll set ZHg5ZGxs=true
echo [40;34mSearching for dll(s)[40;0m 
:output
if %ZHg5Zm9sZGVy% == true echo [%time%+%date%] Found Folder > C:\ProgramData\$CheckAgent$\output.txt && echo [40;31mDetected Violation[40;0m 
if %ZHg5ZGxs% == true echo [%time%+%date%] Found DLL >> C:\ProgramData\$CheckAgent$\output.txt && echo [40;31mDetected Violation[40;0m 
if %ZHg5aW5qZWN0% == true echo [%time%+%date%] Found Injector!  >> C:\ProgramData\$CheckAgent$\output.txt && echo [40;31mDetected Violation[40;0m 
if %ZHg5Zm9sZGVy% == false echo [%time%+%date%] Couldn't find Folder > C:\ProgramData\$CheckAgent$\output.txt
if %ZHg5ZGxs% == false echo [%time%+%date%] Couldn't find DLL >> C:\ProgramData\$CheckAgent$\output.txt
if %ZHg5aW5qZWN0% == false echo [%time%+%date%] Counldn't find Injector! >> C:\ProgramData\$CheckAgent$\output.txt
echo [40;34mOpening log file[40;0m 
timeout 1 >nul
start C:\ProgramData\$CheckAgent$\output.txt
pause >nul