@echo off
setlocal EnableExtensions
cd /d "%~dp0\..\.."

set "REPO_NAME=pynq-z2-mixed-signal-oscilloscope"
set "OWNER=Ross0907"

where gh >nul 2>nul
if errorlevel 1 (
    echo GitHub CLI not found. Installing with winget...
    winget install --id GitHub.cli -e --source winget
    if errorlevel 1 (
        echo Failed to install GitHub CLI.
        exit /b 1
    )
    set "PATH=%PATH%;C:\Program Files\GitHub CLI"
)

gh auth status >nul 2>nul
if errorlevel 1 (
    echo GitHub authentication required.
    gh auth login --web --git-protocol https
    if errorlevel 1 exit /b 1
)

if not exist ".git" (
    git init -b main
)

git add .
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Initial release: PYNQ-Z2 mixed-signal oscilloscope engineering repository"
)

gh repo view "%OWNER%/%REPO_NAME%" >nul 2>nul
if not errorlevel 1 (
    echo Repository %OWNER%/%REPO_NAME% already exists. Refusing to overwrite it.
    exit /b 2
)

gh repo create "%OWNER%/%REPO_NAME%" ^
    --public ^
    --description "PYNQ-Z2 dual-channel 16-bit mixed-signal oscilloscope and AD9102 function generator: analog front end, PCB, SPICE, SI/PI and FPGA integration." ^
    --source . ^
    --remote origin ^
    --push

if errorlevel 1 exit /b 1

echo.
echo Created:
echo https://github.com/%OWNER%/%REPO_NAME%
pause
