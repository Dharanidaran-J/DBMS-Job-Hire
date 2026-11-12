@echo off
title ChallengeHire - Localhost Server
color 0a

echo ========================================================
echo   Starting ChallengeHire on Localhost (127.0.0.1:5000)
echo ========================================================
echo.

cd /d "%~dp0"

echo [1/2] Checking Python...
python --version >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH!
    pause
    exit /b
)

echo [2/2] Starting ChallengeHire Web Server...
echo.
echo ========================================================
echo   SERVER RUNNING! 
echo   Open your browser to: http://127.0.0.1:5000
echo   Keep this black window OPEN while using the site!
echo ========================================================
echo.

start http://127.0.0.1:5000
python run.py
pause
