# BotGuard Setup and Run Script
# This script sets up both backend and frontend and runs them

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  BotGuard: Botnet Traffic Detector Setup" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

$projectRoot = Get-Location
Write-Host "Project Root: $projectRoot" -ForegroundColor Yellow

# Check if Python is installed
Write-Host "`n[1/6] Checking Python installation..." -ForegroundColor Green
$pythonCheck = python --version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Python found: $pythonCheck" -ForegroundColor Green
} else {
    Write-Host "✗ Python not found. Please install Python 3.8+" -ForegroundColor Red
    exit 1
}

# Check if Node.js is installed
Write-Host "`n[2/6] Checking Node.js installation..." -ForegroundColor Green
$nodeCheck = node --version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Node.js found: $nodeCheck" -ForegroundColor Green
} else {
    Write-Host "✗ Node.js not found. Please install Node.js 16+" -ForegroundColor Red
    exit 1
}

# Setup Backend
Write-Host "`n[3/6] Setting up backend..." -ForegroundColor Green
Set-Location "$projectRoot\backend"

Write-Host "  Installing Python dependencies..." -ForegroundColor Yellow
pip install -r requirements.txt -q
Write-Host "  ✓ Backend dependencies installed" -ForegroundColor Green

# Verify model files
Write-Host "`n[4/6] Verifying model files..." -ForegroundColor Green
$modelExists = Test-Path "best_botnet_model.pkl"
$metaExists = Test-Path "metadata.json"

if ($modelExists -and $metaExists) {
    Write-Host "  ✓ Model files found" -ForegroundColor Green
} else {
    Write-Host "  ✗ Model files missing!" -ForegroundColor Red
    exit 1
}

# Setup Frontend
Write-Host "`n[5/6] Setting up frontend..." -ForegroundColor Green
Set-Location "$projectRoot\frontend"

Write-Host "  Installing Node dependencies..." -ForegroundColor Yellow
npm install -q
Write-Host "  ✓ Frontend dependencies installed" -ForegroundColor Green

# Create .env.local if it doesn't exist
$envLocalExists = Test-Path ".env.local"
if ($envLocalExists -eq $false) {
    Write-Host "  Creating .env.local..." -ForegroundColor Yellow
    Add-Content ".env.local" "VITE_API_URL=http://localhost:5000"
    Write-Host "  ✓ .env.local created" -ForegroundColor Green
} else {
    Write-Host "  ✓ .env.local already exists" -ForegroundColor Green
}

Write-Host "`n[6/6] Setup complete!" -ForegroundColor Green
Write-Host "`n================================================" -ForegroundColor Cyan
Write-Host "  Ready to Run!" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

Write-Host "`n📝 Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Open TWO new terminal windows" -ForegroundColor White
Write-Host "  2. In Terminal 1, navigate to the backend folder and run:" -ForegroundColor White
Write-Host "     cd backend" -ForegroundColor Cyan
Write-Host "     python app.py" -ForegroundColor Cyan
Write-Host "  3. In Terminal 2, navigate to the frontend folder and run:" -ForegroundColor White
Write-Host "     cd frontend" -ForegroundColor Cyan
Write-Host "     npm run dev" -ForegroundColor Cyan
Write-Host "  4. Open http://localhost:5173/ in your browser" -ForegroundColor Cyan

Write-Host "`n💡 Tip: Use 'run-backend.ps1' and 'run-frontend.ps1' scripts to start servers" -ForegroundColor Yellow
Write-Host ""
