@echo off

:: MIT License
::
:: Copyright (c) 2023 Daniel Andino Camacho
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files (the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions:
::
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

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
echo  - Version 0.1
echo  - Date 8/7/2023
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