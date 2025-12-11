BotGuard: ML-Powered Botnet Traffic Detector

This project is a Machine Learning powered Botnet Traffic Detection System built using the CTU-13 dataset.
The CTU-13 dataset contains both normal network traffic and malicious botnet traffic.

Our ML model is trained on 57 numerical features that represent network flow characteristics and is capable of classifying traffic as:

>✅ Normal Traffic

>🚨 Attack Traffic (Botnet)

The project consists of a Flask backend (for serving the ML model) and a React + Vite frontend (for user interaction), styled with DaisyUI + TailwindCSS.

📊 Features

(1)Machine Learning Model trained on 57 CTU-13 features.
(2)Prediction API served via Flask.
(3)Interactive Frontend built with React, Vite, and DaisyUI.
(4)CSV Downloads for testing with Normal Traffic & Attack Traffic samples.
(5)Visual Output with prediction result + probability bars.
(6)Ready for Deployment.

Model Information

Dataset: CTU-13 Botnet Traffic Dataset
Features Used: 57 numerical features (network flow statistics)

Labels:

0 → Normal Traffic

1 → Attack Traffic

Algorithm: (e.g., Random Forest, Logistic Regression, XGBoost .

Final prediction (Normal or Attack)

Probability scores (confidence of classification)

How to Use

Download the sample CSV files (Normal & Attack) from the UI.

Copy a row (57 space-separated values) from the CSV.

Paste the row into the big input box on the web app.

Click Predict.

View results:

       ✅ Prediction = 0 → Normal Traffic

       🚨 Prediction = 1 → Attack Traffic

         Probabilities are shown with progress bars for better visualization.

Tech Stack

1.Machine Learning: scikit-learn, NumPy

2.Backend: Flask (Python)

3.Frontend: React + Vite, DaisyUI, TailwindCSS

