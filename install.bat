@echo off
title Diana's Real Estate Team AI — First Time Setup
echo.
echo ============================================
echo   Diana's Real Estate Team AI -- Setup
echo ============================================
echo.

where claude >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Claude Code is not installed.
    echo.
    echo Install it at: https://claude.ai/code
    echo Then run this file again.
    echo.
    pause
    exit /b 1
)
echo [OK] Claude Code found.
echo.

set /p AGENT_NAME=Enter your first name:
if "%AGENT_NAME%"=="" (
    echo Name cannot be blank.
    pause
    exit /b 1
)
echo.

if not exist "_shared\voice" mkdir "_shared\voice"

if not exist "_shared\voice\%AGENT_NAME%.md" (
    (
        echo # Voice Profile: %AGENT_NAME%
        echo **Status: NOT SET UP**
        echo.
        echo Run launch.bat to complete your voice setup with Claude.
    ) > "_shared\voice\%AGENT_NAME%.md"
    echo [OK] Voice profile placeholder created for %AGENT_NAME%.
) else (
    echo [OK] Voice profile already exists for %AGENT_NAME%.
)
echo.

set LAUNCH_TARGET=%~dp0launch.bat
set WORK_DIR=%~dp0
powershell -NoProfile -Command ^
  "$desktop = [Environment]::GetFolderPath('Desktop');" ^
  "$s = New-Object -ComObject WScript.Shell;" ^
  "$sc = $s.CreateShortcut($desktop + '\Dianas Team AI.lnk');" ^
  "$sc.TargetPath = '%LAUNCH_TARGET%';" ^
  "$sc.WorkingDirectory = '%WORK_DIR%';" ^
  "$sc.Description = 'Diana Real Estate Team AI';" ^
  "$sc.Save();" ^
  "Write-Host 'Shortcut saved to ' + $desktop"
if %errorlevel% neq 0 (
    echo [WARN] Shortcut may not have been created. Check your Desktop manually.
) else (
    echo [OK] Desktop shortcut created.
)
echo.
echo ============================================
echo   Setup complete.
echo   Open "Dianas Team AI" on your desktop.
echo ============================================
echo.
pause
