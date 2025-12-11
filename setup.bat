@echo off
REM BotGuard Setup and Run Script
REM This script sets up both backend and frontend

echo.
echo ================================================
echo   BotGuard: Botnet Traffic Detector Setup
echo ================================================
echo.

set PROJECTROOT=%cd%
echo Project Root: %PROJECTROOT%

REM Check Python
echo.
echo [1/6] Checking Python installation...
python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Python found
) else (
    echo [ERROR] Python not found. Please install Python 3.8+
    exit /b 1
)

REM Check Node.js
echo [2/6] Checking Node.js installation...
node --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Node.js found
) else (
    echo [ERROR] Node.js not found. Please install Node.js 16+
    exit /b 1
)

REM Setup Backend
echo.
echo [3/6] Setting up backend...
cd %PROJECTROOT%\backend
echo  Installing Python dependencies...
pip install -r requirements.txt -q
echo  [OK] Backend dependencies installed

REM Verify model files
echo.
echo [4/6] Verifying model files...
if exist "best_botnet_model.pkl" (
    if exist "metadata.json" (
        echo  [OK] Model files found
    ) else (
        echo  [ERROR] metadata.json missing!
        exit /b 1
    )
) else (
    echo  [ERROR] best_botnet_model.pkl missing!
    exit /b 1
)

REM Setup Frontend
echo.
echo [5/6] Setting up frontend...
cd %PROJECTROOT%\frontend
echo  Installing Node dependencies...
npm install -q
echo  [OK] Frontend dependencies installed

REM Create .env.local
if not exist ".env.local" (
    echo  Creating .env.local...
    (echo VITE_API_URL=http://localhost:5000) > .env.local
    echo  [OK] .env.local created
) else (
    echo  [OK] .env.local already exists
)

echo.
echo [6/6] Setup complete!
echo.
echo ================================================
echo   Ready to Run!
echo ================================================
echo.
echo Next Steps:
echo   1. Open TWO new command prompt windows
echo   2. In Terminal 1, run:
echo      cd backend
echo      python app.py
echo   3. In Terminal 2, run:
echo      cd frontend
echo      npm run dev
echo   4. Open http://localhost:5173/ in your browser
echo.
pause
