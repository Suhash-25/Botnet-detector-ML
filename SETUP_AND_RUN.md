# BotGuard: Complete Setup and Running Guide

## Project Overview
BotGuard is an ML-powered Botnet Traffic Detection System with:
- **Backend**: Flask API serving a trained ML model
- **Frontend**: React + Vite web application
- **Model**: Trained on CTU-13 dataset with 57 network features

---

## Prerequisites
- Python 3.8+ installed
- Node.js 16+ and npm installed
- Windows PowerShell

---

## Step 1: Backend Setup

### 1.1 Navigate to Backend Directory
```powershell
cd backend
```

### 1.2 Create Python Virtual Environment (Optional but Recommended)
```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
```

### 1.3 Install Python Dependencies
```powershell
pip install -r requirements.txt
```

### 1.4 Verify Model Files Exist
Check that these files are in the backend folder:
- `best_botnet_model.pkl` ✓ (Trained ML model)
- `metadata.json` ✓ (Feature metadata)
- `app.py` ✓ (Flask application)

---

## Step 2: Frontend Setup

### 2.1 Navigate to Frontend Directory (in a new terminal)
```powershell
cd frontend
```

### 2.2 Install Node Dependencies
```powershell
npm install
```

### 2.3 Create Environment Configuration
Create a file named `.env.local` in the frontend directory:
```
VITE_API_URL=http://localhost:5000
```

---

## Step 3: Run the Application

### Step 3A: Start Backend Server
In Terminal 1:
```powershell
cd backend
python app.py
```

Expected output:
```
WARNING in app.run is not recommended for production use. Use a production WSGI server instead.
Running on http://127.0.0.1:5000
```

### Step 3B: Start Frontend Development Server
In Terminal 2:
```powershell
cd frontend
npm run dev
```

Expected output:
```
VITE v7.1.2  ready in 234 ms

➜  Local:   http://localhost:5173/
```

---

## Step 4: Access the Application

1. Open your web browser
2. Navigate to: **http://localhost:5173/**
3. You should see the BotGuard interface with:
   - Description and How to Use sections
   - Download buttons for sample CSV files
   - Input form to paste traffic data
   - Prediction results display

---

## Testing the Application

### Test with Sample Data:

1. Click **"⬇ Normal Traffic"** or **"⬇ Attacker Traffic"** to download CSV files
2. Open the CSV file (CTU13_Normal_Traffic.csv or CTU13_Attack_Traffic.csv)
3. Copy a complete row (57 space-separated values)
4. Paste into the textarea in the web app
5. Click **"Predict"** button
6. View the results:
   - ✅ Prediction (Normal Traffic = 0, Attack Traffic = 1)
   - Confidence scores with probability bars

---

## Troubleshooting

### Issue: "Error connecting to backend"
- **Solution**: 
  - Ensure backend is running on http://localhost:5000
  - Check `.env.local` has correct `VITE_API_URL`
  - Check browser console for CORS errors

### Issue: "ModuleNotFoundError" in backend
- **Solution**:
  ```powershell
  pip install -r requirements.txt
  ```

### Issue: Port 5000 already in use
- **Solution**: Kill the process or change the port in `app.py`:
  ```python
  app.run(debug=True, port=5001)
  ```

### Issue: npm install fails
- **Solution**:
  ```powershell
  npm cache clean --force
  npm install
  ```

---

## Project Structure

```
BotGuard-ML-Powered-Botnet-Traffic-Detector/
├── backend/
│   ├── app.py                    # Flask server
│   ├── best_botnet_model.pkl     # Trained ML model
│   ├── metadata.json             # Feature metadata
│   ├── requirements.txt          # Python dependencies
│   └── Procfile                  # Deployment config
│
├── frontend/
│   ├── src/
│   │   ├── App.jsx              # Main React component
│   │   ├── pages/
│   │   │   └── Home.jsx         # Home page
│   │   ├── components/
│   │   │   ├── InputForm.jsx    # Input form component
│   │   │   └── ResultCard.jsx   # Results display
│   │   ├── main.jsx
│   │   └── index.css
│   ├── public/
│   │   ├── CTU13_Normal_Traffic.csv
│   │   └── CTU13_Attack_Traffic.csv
│   ├── package.json             # Node dependencies
│   ├── vite.config.js           # Vite config
│   └── index.html
│
├── Botnet_Detector_Model/
│   └── BotNet_Detection.ipynb   # Model training notebook
│
└── Readme.md
```

---

## API Endpoint

### POST /predict
**Request:**
```json
{
  "features": [12, 0, 1, 34, ..., 45]  // 57 numerical values
}
```

**Response (Normal Traffic):**
```json
{
  "prediction": 0,
  "probabilities": [0.95, 0.05]  // [Normal, Attack]
}
```

**Response (Attack Traffic):**
```json
{
  "prediction": 1,
  "probabilities": [0.05, 0.95]  // [Normal, Attack]
}
```

---

## Technology Stack

- **Frontend**: React 19, Vite 7, TailwindCSS 4, DaisyUI 5
- **Backend**: Flask, Flask-CORS
- **ML**: scikit-learn, XGBoost, NumPy, Joblib
- **Dataset**: CTU-13 Botnet Traffic (57 features)

---

## Next Steps for Presentation

1. ✅ Ensure both servers are running
2. ✅ Test with sample CSV data
3. ✅ Demonstrate normal traffic prediction
4. ✅ Demonstrate attack traffic prediction
5. ✅ Show confidence scores and predictions
6. 📱 Optional: Deploy to cloud (Render, Heroku, AWS)

---

## Stopping the Application

### To stop:
- **Backend**: Press `Ctrl+C` in backend terminal
- **Frontend**: Press `Ctrl+C` in frontend terminal
- **Deactivate venv**: `deactivate` (if using virtual environment)

---

## For Production Deployment

See `backend/Procfile` for Render deployment configuration.

To build frontend for production:
```powershell
npm run build
```

---

**Author**: Siddharth Chaudhary
**Project**: BotGuard - ML-Powered Botnet Traffic Detector
