@echo off
title Push ChallengeHire to DBMS-Job-Hire
color 0a

echo ========================================================
echo   Pushing ChallengeHire to:
echo   https://github.com/Dharanidaran-J/DBMS-Job-Hire.git
echo ========================================================
echo.

cd /d "%~dp0"
set "PATH=C:\Program Files\Git\cmd;%PATH%"

git branch -M main
git remote set-url origin https://github.com/Dharanidaran-J/DBMS-Job-Hire.git

echo Uploading all files to GitHub...
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo [Notice] Syncing with remote...
    git push -u origin main --force
)

echo.
echo ========================================================
echo   SUCCESS! Website is uploaded to GitHub!
echo   Repository: https://github.com/Dharanidaran-J/DBMS-Job-Hire
echo ========================================================
echo.
pause
