from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import numpy as np
import json
import os
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)

# Determine base directory for relative files
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Load model (use absolute path so script can be run from any CWD)
MODEL_PATH = os.path.join(BASE_DIR, "best_botnet_model.pkl")
if not os.path.exists(MODEL_PATH):
    raise FileNotFoundError(f"Model file not found at {MODEL_PATH}")
model = joblib.load(MODEL_PATH)

# Load metadata if available
METADATA_PATH = os.path.join(BASE_DIR, "metadata.json")
feature_order = None
if os.path.exists(METADATA_PATH):
    try:
        with open(METADATA_PATH) as f:
            metadata = json.load(f)
        feature_order = metadata.get("feature_order")
        logging.info(f"Loaded metadata with {len(feature_order) if feature_order else 0} features")
    except Exception:
        feature_order = None

app = Flask(__name__)
CORS(app)  # Allow requests from frontend


@app.route("/", methods=["GET"])
def index():
    return jsonify({"service": "BotGuard ML backend", "status": "ok"})


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "healthy"}), 200


def _prepare_features(payload):
    """Accept either a list under key 'features' or a dict under 'feature_map'.
    If metadata.feature_order is available and a dict is provided, order values
    accordingly. Returns a 2D numpy array ready for prediction.
    """
    # If a list of features is provided, use it directly
    if isinstance(payload, list):
        arr = np.array(payload, dtype=float).reshape(1, -1)
        return arr

    if isinstance(payload, dict):
        # If feature_order is known, use it to order the dict
        if feature_order:
            try:
                ordered = [float(payload[name]) for name in feature_order]
                return np.array(ordered, dtype=float).reshape(1, -1)
            except KeyError as e:
                raise KeyError(f"Missing feature in payload: {e}")
            except ValueError:
                raise ValueError("All feature values must be numeric")
        else:
            # No feature order; accept dict values in insertion order
            try:
                vals = [float(v) for v in payload.values()]
                return np.array(vals, dtype=float).reshape(1, -1)
            except ValueError:
                raise ValueError("All feature values must be numeric")

    raise TypeError("Payload must be a list or dict of features")


@app.route("/predict", methods=["POST"])
def predict():
    try:
        data = request.get_json(force=True)

        # Support multiple shapes: {"features": [...]}, {"feature_map": {...}}, or raw list/dict
        payload = None
        if isinstance(data, dict) and "features" in data:
            payload = data["features"]
        elif isinstance(data, dict) and "feature_map" in data:
            payload = data["feature_map"]
        else:
            payload = data

        arr = _prepare_features(payload)

        # If metadata provides expected length, validate
        expected_len = len(feature_order) if feature_order else arr.shape[1]
        if arr.shape[1] != expected_len:
            return jsonify({"error": f"Expected {expected_len} features, got {arr.shape[1]}"}), 400

        pred = model.predict(arr).tolist()

        prob = None
        if hasattr(model, "predict_proba"):
            prob = model.predict_proba(arr).tolist()

        return jsonify({
            "prediction": pred[0],
            "probabilities": prob[0] if prob else None
        })
    except (ValueError, TypeError, KeyError) as e:
        return jsonify({"error": str(e)}), 400
    except Exception as e:
        logging.exception("Prediction error")
        return jsonify({"error": "Internal server error"}), 500


if __name__ == "__main__":
    # Bind to 0.0.0.0 so frontend in other containers/hosts can reach it
    app.run(host="0.0.0.0", port=5000, debug=True)
