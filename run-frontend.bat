@echo off
REM BotGuard Frontend Server Start Script

echo.
echo ================================================
echo   BotGuard: Starting Frontend Server
echo ================================================
echo.

cd /d "%~dp0frontend"

echo Starting Vite frontend on http://localhost:5173
echo Backend must be running on http://localhost:5000
echo Press Ctrl+C to stop the server
echo.

npm run dev
pause
