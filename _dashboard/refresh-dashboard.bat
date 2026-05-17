@echo off
title Diana's Team — Refresh Dashboard
cd /d "%~dp0"
echo.
echo ============================================
echo   Diana's Team AI -- Refresh Dashboard
echo ============================================
echo.
echo Reading deal files...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0refresh-dashboard.ps1"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Refresh failed. See message above.
    echo.
    pause
    exit /b 1
)

echo.
echo Open dashboard.html in your browser to see the updated view.
echo.
pause
