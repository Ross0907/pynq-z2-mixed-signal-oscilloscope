@echo off
setlocal EnableExtensions
title Publish PYNQ-Z2 Mixed-Signal Oscilloscope as NEW GitHub Repo

REM ============================================================================
REM SAFE ROOT RESOLUTION
REM %~dp0 ends in a backslash. Using it directly with git -C can break quoting.
REM Canonicalize "%~dp0." first so ROOT has NO trailing backslash.
REM ============================================================================

for %%I in ("%~dp0.") do set "ROOT=%%~fI"

set "OWNER=Ross0907"
set "REPO_NAME=pynq-z2-mixed-signal-oscilloscope"

echo Repository root:
echo   %ROOT%
echo.

REM ============================================================================
REM HARD SAFETY CHECKS
REM ============================================================================

if not exist "%ROOT%\README.md" (
    echo ERROR: README.md not found in repository root:
    echo   %ROOT%
    exit /b 10
)

findstr /C:"PYNQ-Z2 Mixed-Signal Oscilloscope / MDO" "%ROOT%\README.md" >nul
if errorlevel 1 (
    echo ERROR: Expected project signature not found in README.md.
    echo Refusing to initialize or publish.
    exit /b 11
)

if /I "%ROOT%"=="%USERPROFILE%\Downloads" (
    echo ERROR: Repository root resolved to Downloads.
    echo Refusing to continue.
    exit /b 12
)

if exist "%USERPROFILE%\Downloads\.git\" (
    echo ERROR: Accidental Git metadata still exists at:
    echo   %USERPROFILE%\Downloads\.git
    echo.
    echo Remove ONLY that metadata with:
    echo   rmdir /s /q "%USERPROFILE%\Downloads\.git"
    echo.
    echo Then rerun this BAT.
    exit /b 13
)

pushd "%ROOT%"
if errorlevel 1 (
    echo ERROR: Could not enter repository root.
    exit /b 14
)

REM ============================================================================
REM GITHUB CLI
REM ============================================================================

where gh >nul 2>nul
if errorlevel 1 (
    echo GitHub CLI not found. Attempting installation with winget...
    winget install --id GitHub.cli -e --source winget
    if errorlevel 1 (
        echo ERROR: GitHub CLI installation failed.
        popd
        exit /b 20
    )

    if exist "C:\Program Files\GitHub CLI\gh.exe" (
        set "PATH=%PATH%;C:\Program Files\GitHub CLI"
    )
)

gh auth status >nul 2>nul
if errorlevel 1 (
    echo GitHub authentication required.
    gh auth login --web --git-protocol https
    if errorlevel 1 (
        echo ERROR: GitHub authentication failed.
        popd
        exit /b 21
    )
)

REM ============================================================================
REM REFUSE TO OVERWRITE AN EXISTING REMOTE REPOSITORY
REM ============================================================================

gh repo view "%OWNER%/%REPO_NAME%" >nul 2>nul
if not errorlevel 1 (
    echo ERROR: GitHub repository already exists:
    echo   https://github.com/%OWNER%/%REPO_NAME%
    echo Refusing to overwrite or push into it.
    popd
    exit /b 40
)

REM ============================================================================
REM LOCAL GIT INITIALIZATION
REM ============================================================================

if not exist ".git\" (
    echo Initializing fresh Git repository in:
    echo   %CD%
    git init -b main
    if errorlevel 1 (
        echo ERROR: git init failed.
        popd
        exit /b 30
    )
) else (
    echo Existing .git found in the intended repository root.
)

REM Force branch name to main if needed.
git branch -M main
if errorlevel 1 (
    echo ERROR: Could not set branch name to main.
    popd
    exit /b 31
)

REM Stage ONLY intended standalone-repository content.
git add -- README.md docs verification tools fpga software .gitignore .gitattributes PUBLISH_NEW_GITHUB_REPO.bat
if errorlevel 1 (
    echo ERROR: git add failed.
    popd
    exit /b 32
)

REM Commit only when there are staged changes.
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Initial release: PYNQ-Z2 mixed-signal oscilloscope"
    if errorlevel 1 (
        echo ERROR: git commit failed.
        echo.
        echo If Git says your identity is not configured, run:
        echo   git config --global user.name "Roshan Tripathy"
        echo   git config --global user.email "140931356+Ross0907@users.noreply.github.com"
        echo.
        popd
        exit /b 33
    )
) else (
    echo No new staged changes; using existing local commit.
)

REM Ensure at least one commit exists before gh repo create --push.
git rev-parse --verify HEAD >nul 2>nul
if errorlevel 1 (
    echo ERROR: No Git commit exists. Cannot publish an empty history.
    popd
    exit /b 34
)

REM ============================================================================
REM CREATE A COMPLETELY NEW GITHUB REPOSITORY AND PUSH
REM ============================================================================

echo.
echo Creating NEW repository:
echo   https://github.com/%OWNER%/%REPO_NAME%
echo.

gh repo create "%OWNER%/%REPO_NAME%" ^
    --public ^
    --description "PYNQ-Z2 dual-channel 16-bit mixed-signal oscilloscope and AD9102 function generator: analog front end, PCB, SPICE, SI/PI and FPGA integration." ^
    --source . ^
    --remote origin ^
    --push

set "RC=%ERRORLEVEL%"

if not "%RC%"=="0" (
    echo ERROR: gh repo create/push failed with exit code %RC%.
    popd
    exit /b %RC%
)

echo.
echo ============================================================
echo SUCCESS
echo ============================================================
echo https://github.com/%OWNER%/%REPO_NAME%
echo.

popd
pause
exit /b 0
