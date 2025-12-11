# BotGuard Frontend Run Script
# This script starts the frontend development server

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  BotGuard: Starting Frontend" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

$projectRoot = Get-Location
$frontendPath = Join-Path $projectRoot "frontend"

# Check if frontend dependencies are installed
if (-not (Test-Path "$frontendPath\node_modules")) {
    Write-Host "⚠️  node_modules not found. Installing dependencies..." -ForegroundColor Yellow
    Set-Location $frontendPath
    npm install -q
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
}

Write-Host "Starting Frontend Server..." -ForegroundColor Green
Set-Location $frontendPath

Write-Host ""
Write-Host "📱 Frontend will be available at: http://localhost:5173/" -ForegroundColor Cyan
Write-Host "🔌 Make sure Backend is running on: http://localhost:5000/" -ForegroundColor Yellow
Write-Host "⏹️  Press Ctrl+C to stop the frontend server" -ForegroundColor Yellow
Write-Host ""

npm run dev
