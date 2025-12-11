import { useState } from "react";
import axios from "axios";

export default function InputForm({ onResult }) {
  const [inputText, setInputText] = useState("");
  const [loading, setLoading] = useState(false);

   // Use .env variable (falls back to empty string if not set)
  const API_BASE = import.meta.env.VITE_API_URL || "";

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    const values = inputText.trim().split(/\s+/);
    
    if (values.length !== 57) {
      alert("Please enter exactly 57 values");
      setLoading(false);
      return;
    }

    const numericValues = values.map((v) => Number(v));
    
    if (numericValues.some(isNaN)) {
      alert("All values must be numeric");
      setLoading(false);
      return;
    }

    try {
      const res = await axios.post(`${API_BASE}/predict`, {
        features: numericValues,
      });
      onResult(res.data);
    } catch (err) {
      console.error(err);
      alert("Error connecting to backend");
    } finally {
      setLoading(false);
    }
  };

  const normalFile = "/CTU13_Normal_Traffic.csv";
  const attackerFile = "/CTU13_Attack_Traffic.csv";

  return (
    <form onSubmit={handleSubmit} className="form-control gap-6 w-full">
      {/* Download buttons row */}
      <div className="flex gap-4">
        <a
          href={normalFile}
          download
          className="btn btn-outline btn-success flex-1"
        >
          ⬇ Normal Traffic
        </a>

        <a
          href={attackerFile}
          download
          className="btn btn-outline btn-error flex-1"
        >
          ⬇ Attacker Traffic
        </a>
      </div>

      {/* Input label */}
      <label className="label">
        <span className="label-text font-semibold text-lg">
          Enter 57 space-separated values
        </span>
      </label>

      {/* Bigger + wider textarea input */}
      <textarea
        rows="10"
        placeholder="Example: 12 0 1 34 ... (57 values)"
        value={inputText}
        onChange={(e) => setInputText(e.target.value)}
        className="textarea textarea-bordered w-full text-base p-4 rounded-lg"
        required
      ></textarea>

      <button
        type="submit"
        className={`btn btn-primary w-full py-3 text-lg ${
          loading ? "loading" : ""
        }`}
        disabled={loading}
      >
        {loading ? "Predicting..." : "Predict"}
      </button>
    </form>
  );
}
