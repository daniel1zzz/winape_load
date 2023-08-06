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

set WINAPE_DOWNLOAD=http://winape.net/download/WinAPE20B2.zip
set WINAPE_ZIP=WinAPE20B2.zip
set WINAPE_ZIP_DIR=%USERPROFILE%\%WINAPE_ZIP%
set WINAPE_DIR=WinAPE20B2
set WINAPE=WinApe.exe
set WINAPE_PATH=%USERPROFILE%\%WINAPE_DIR%

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
echo  This script allows you to install WinAPE Amstrad CPC emulator on 
echo  Windows in an automated way.
echo.
echo  - Created by Daniel Andino Camacho
echo  - Version 0.1
echo  - Date 8/6/2023
echo.

:: Verify if curl is installed and accessible in the system PATH
curl --version >nul 2>&1
if errorlevel 1 (
    echo Curl is not installed or not in the system PATH.
    echo Please install curl and make sure to configure it in the PATH.
    exit /b 1
)

:: Verify that it is not already installed
where %WINAPE% >nul 2>&1

if %errorlevel% equ 0 (
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
echo Downloading ...
echo.

:: Download WinApe from url
curl -# -o %WINAPE_ZIP_DIR% %WINAPE_DOWNLOAD%

if %errorlevel% equ 0 (
	echo.
    echo The download was successful. [OK]
) else (
	echo.
    echo There was a problem during the download. [ERROR]
    exit /b 1
)

:: Decompressing %WINAPE_ZIP%
echo.
echo Decompressing %WINAPE_ZIP% ...

powershell -command "Expand-Archive -Path '%WINAPE_ZIP_DIR%' -DestinationPath '%WINAPE_PATH%'"

if %errorlevel% equ 0 (
    echo Extraction completed. [OK]
) else (
    echo There was a problem during extraction. [ERROR]
    exit /b 1
)

echo.
echo Configuring ...
echo.
::xcopy %WINAPE_DIR% "%WINAPE_PATH%" /E /I /H /Y
echo.
echo Adding to the path $PATH$ ...
setx path "%WINAPE_PATH%;%path%" /M
echo.

if %errorlevel% equ 0 (
    echo Configuration completed. [OK]
) else (
    echo There was a problem during setting. [ERROR]
    exit /b 1
)

::rmdir /q /s %WINAPE_DIR%
del /q %WINAPE_ZIP_DIR%

echo Installed in %WINAPE_PATH%
echo.
echo Installation completed successfully! :)
echo Please open another terminal or (cmd or powershell) to apply the changes and you can continue! Thank you :).
echo.
