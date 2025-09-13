🛡️ BotGuard - Botnet Traffic Detector
This project is a Machine Learning powered Botnet Traffic Detector built with React (frontend) and Flask (backend).
🛡️ Botnet Traffic Detector

This project is a Machine Learning powered Botnet Traffic Detector built with React (frontend) and Flask (backend).
It is trained on the CTU-13 dataset, which contains both normal and malicious (botnet attack) traffic data.

The app allows users to input 57 space-separated numerical features and predicts whether the traffic is:

✅ Normal Traffic

🚨 Attack Traffic

✨ Features

📊 ML model trained on CTU-13 dataset

🌐 Interactive frontend with React, Tailwind, DaisyUI

🔥 Backend with Flask + scikit-learn/XGBoost

📂 Downloadable sample CSV files (Normal & Attack traffic)

🎯 Visual results with probability progress bars

📸 Demo Screenshot

(Add a screenshot of your running app here)

🚀 How to Use

Download the sample CSV files (Normal & Attack traffic) from the app.

Copy a row (57 values) from the CSV or your own dataset.

Paste it into the big input box in the app.

Click Predict to see the result.

🛠️ Installation & Setup
🔹 Backend (Flask)
# Navigate to backend folder
cd backend

# Create venv (optional but recommended)
python -m venv venv
source venv/bin/activate   # Mac/Linux
venv\Scripts\activate      # Windows

# Install dependencies
pip install -r requirements.txt

# Run Flask server
python app.py

🔹 Frontend (React + Vite)
# Navigate to frontend folder
cd frontend

# Install dependencies
npm install

# Run frontend
npm run dev

📂 Project Structure
Botnet-Detector/
│── backend/           # Flask backend
│   ├── app.py         # Flask app entry
│   ├── model.pkl      # ML model (ignored if too large)
│   └── requirements.txt
│
│── frontend/          # React frontend
│   ├── src/
│   │   ├── pages/
│   │   │   └── Home.jsx
│   │   ├── components/
│   │   │   ├── InputForm.jsx
│   │   │   └── ResultCard.jsx
│   └── public/
│       ├── CTU13_Normal_Traffic.csv
│       └── CTU13_Attack_Traffic.csv
│
└── README.md

📊 Dataset

The model is trained on the CTU-13 Botnet dataset, which contains captures of normal and botnet-infected traffic.
👉 Learn more about CTU-13 Dataset

⚡ Future Improvements

📂 Upload CSV directly in the app for batch predictions

📉 Show confusion matrix & metrics on frontend

☁️ Deploy on Heroku / Render / Vercel for public use

👨‍💻 Author

Developed with ❤️ by Siddharth