@echo off

:: Global config

set WINAPE_LOAD_DIR=winape_load
set WINAPE_LOAD_PATH=%USERPROFILE%\%WINAPE_LOAD_DIR%

cls

echo.
echo   /$$$$$$ /$$   /$$  /$$$$$$  /$$$$$$$$  /$$$$$$  /$$       /$$       
echo  ^|_  $$_/^| $$$ ^| $$ /$$__  $$^|__  $$__/ /$$__  $$^| $$      ^| $$       
echo    ^| $$  ^| $$$$^| $$^| $$  \__/   ^| $$   ^| $$  \ $$^| $$      ^| $$       
echo    ^| $$  ^| $$ $$ $$^|  $$$$$$    ^| $$   ^| $$$$$$$$^| $$      ^| $$       
echo    ^| $$  ^| $$  $$$$ \____  $$   ^| $$   ^| $$__  $$^| $$      ^| $$       
echo    ^| $$  ^| $$\  $$$ /$$  \ $$   ^| $$   ^| $$  ^| $$^| $$      ^| $$       
echo   /$$$$$$^| $$ \  $$^|  $$$$$$/   ^| $$   ^| $$  ^| $$^| $$$$$$$$^| $$$$$$$$ 
echo  ^|______/^|__/  \__/ \______/    ^|__/   ^|__/  ^|__/^|________/^|________/ 
echo.
echo.
echo This script allows you to install the winape_load scripts to the system.
echo.
echo  - Created by Daniel Andino Camacho
echo  - Version 1.0
echo  - Date 8/6/2023
echo.

:: Verify that it is not already installed
if exist %WINAPE_LOAD_PATH% (
    echo Is already installed!
    exit /b 0
)

:: Continue to install question
echo Do you want to continue?
choice /c YN

if errorlevel 2 (
    echo Permission denied. The process has been cancelled.
    exit /b 1
)

echo.
echo Installing ...
echo.
mkdir %WINAPE_LOAD_PATH%
copy "winape_load.bat" "%WINAPE_LOAD_PATH%" /Y
copy "winape_install.bat" "%WINAPE_LOAD_PATH%" /Y
copy "LICENSE" "%WINAPE_LOAD_PATH%" /Y
echo.
echo Adding to the path $PATH$ ...
setx path "%WINAPE_LOAD_PATH%;%path%" /M
echo.

if %errorlevel% equ 0 (
    echo Installing completed. [OK]
) else (
    echo There was a problem during setting. [ERROR]
    exit /b 1
)