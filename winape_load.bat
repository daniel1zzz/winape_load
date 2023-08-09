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

:: Vars global

set "DSK_FILES="
set "NOI_FILES="
set WINAPE=WinApe

setlocal enabledelayedexpansion

:: Start script
goto :start

:: Utils labels o subrutines
:syntaxError
    echo Syntax error command %1 `[arguments]`
    echo run command `--help`
    exit /b 1

:start

cls

echo.
echo  /$$        /$$$$$$   /$$$$$$  /$$$$$$$ 
echo ^| $$       /$$__  $$ /$$__  $$^| $$__  $$
echo ^| $$      ^| $$  \ $$^| $$  \ $$^| $$  \ $$
echo ^| $$      ^| $$  ^| $$^| $$$$$$$$^| $$  ^| $$
echo ^| $$      ^| $$  ^| $$^| $$__  $$^| $$  ^| $$
echo ^| $$      ^| $$  ^| $$^| $$  ^| $$^| $$  ^| $$
echo ^| $$$$$$$$^|  $$$$$$/^| $$  ^| $$^| $$$$$$$/
echo ^|________/ \______/ ^|__/  ^|__/^|_______/ 
echo.
echo This script allows you to load the WinAPE Amstrad CPC emulator on
echo Windows automatically.
echo.
echo  - Created by Daniel Andino Camacho
echo  - Version 0.1
echo  - Date 8/7/2023
echo.

:: Verify that it is not already installed
where %WINAPE% >nul 2>&1

if %errorlevel% equ 0 (
    echo WinApe is already installed. [OK]
) else (
    echo WinApe is not installed. [ERROR]
    echo.
    pause
    :: Command download & install WinApe
    winape_install
)

:: Arguments validation
if "%1"=="--auto-load" (
    goto :--auto-load
) else if "%1"=="--load-dsk" (
    if "%2"=="" (
        echo Syntax error command %1 `[arguments]`
        echo run command `--help`
        exit /b 1
    ) else if not exist "%cd%\%2" (
        echo `%2` file does not exist. !:(
        exit /b 1
    )
    goto :--load-dsk
) else if "%1"=="--load-dsk-noi" (
    if "%2"=="" (
        goto :syntaxError
    ) else if "%3"=="" (
        goto :syntaxError
    ) else if not exist "%cd%\%2" (
        echo `%2` file does not exist. !:(
        exit /b 1
    ) else if not exist "%cd%\%3" (
        echo `%3` file does not exist. !:(
        exit /b 1
    )
    goto :--load-dsk-noi
) else (
    echo run command `--help`
    goto :end
)

:: Load auto file *.dsk and \obj\*.noi
:--auto-load

:: Search for *.dsk files in the current directory
for /f "delims=" %%i in ('dir %cd%\*.dsk /b') do (
    set "DSK_FILES=!DSK_FILES!%cd%\%%i"
)

:: Search for \obj\*.noi files in the current directory
for /f "delims=" %%i in ('dir %cd%\obj\*.noi /b') do (
    set "NOI_FILES=!NOI_FILES!%cd%\obj\%%i"
)

:: No exist files *.dsk
if "%DSK_FILES%"=="" (
    echo.
    echo No *.dsk files found. !:(
    echo.
    exit /b 1
)

echo Running ...

if "%NOI_FILES%" neq "" (
	%WINAPE% "%DSK_FILES%" /A "/SYM:%NOI_FILES%"
) else (
    echo No exist \obj\*.noi files!
	%WINAPE% "%DSK_FILES%" /A
)

goto :end
    
:: Load file .dsk and run
:--load-dsk

echo Running %2 ...
echo.
%WINAPE% "%cd%%2"

goto :end

:: Load files %2=.dsk, %3=.noi and run
:--load-dsk-noi

echo Running %2 and symbols %3 ...
echo.
%WINAPE% "%cd%\%2" /A "/SYM:%cd%\%3"

goto :end

::WinApe "%cd%\%1.dsk" /A /SYM:%cd%\obj\%1.noi

:end