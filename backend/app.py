from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import numpy as np
import json

# Load model
model = joblib.load("best_botnet_model.pkl")

# Load metadata if available
try:
    with open("metadata.json") as f:
        metadata = json.load(f)
    feature_order = metadata["feature_order"]
except:
    feature_order = None

app = Flask(__name__)
CORS(app)  # Allow requests from frontend

@app.route("/predict", methods=["POST"])
def predict():
    try:
        data = request.get_json()
        features = data.get("features")   # <-- directly take the list

        arr = np.array(features).reshape(1, -1)
        pred = model.predict(arr).tolist()

        prob = None
        if hasattr(model, "predict_proba"):
            prob = model.predict_proba(arr).tolist()

        return jsonify({
            "prediction": pred[0],
            "probabilities": prob[0] if prob else None
        })
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(debug=True)
