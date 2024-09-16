@echo off
setlocal enabledelayedexpansion

REM Check if Python is installed
python --version 2>nul
if %errorlevel% neq 0 (
    echo Python is not installed. Downloading and installing Python...

    REM Download and install Python
    bitsadmin.exe /transfer PythonInstaller https://www.python.org/ftp/python/3.12.1/python-3.12.1-amd64.exe %temp%\python_installer.exe
    %temp%\python_installer.exe /quiet InstallAllUsers=1 PrependPath=1

    REM Add Python to PATH
    setx PATH "%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python312"

    REM Check again after installation
    python --version 2>nul
    if %errorlevel% neq 0 (
        echo An error occurred while installing Python. Please install it manually.
        exit /b 1
    ) else (
        echo Python has been successfully installed.
    )
) else (
    echo Python is already installed.
)

REM Check if Git is installed
git --version 2>nul
if %errorlevel% neq 0 (
    echo Git is not installed. Downloading and installing Git...

    REM Download and install Git
    bitsadmin.exe /transfer GitInstaller https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.1/Git-2.42.0-64-bit.exe %temp%\git_installer.exe
    %temp%\git_installer.exe /quiet

    REM Add Git to PATH
    setx PATH "%PATH%;C:\Program Files\Git\bin"

    REM Check again after installation
    git --version 2>nul
    if %errorlevel% neq 0 (
        echo An error occurred while installing Git. Please install it manually.
        exit /b 1
    ) else (
        echo Git has been successfully installed.
    )
) else (
    echo Git is already installed.
)

REM Run the Python script
python main.py
