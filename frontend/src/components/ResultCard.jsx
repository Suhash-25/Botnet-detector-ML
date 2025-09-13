/* src/components/ResultCard.jsx */
export default function ResultCard({ result }) {
  if (!result) return null;

  const prediction = result.prediction;
  const probs = result.probabilities;

  // Map prediction label
  const label =
    prediction === 1 ? (
      <span className="text-error font-bold">🚨 Attack Traffic</span>
    ) : (
      <span className="text-success font-bold">✅ Normal Traffic</span>
    );

  // If probabilities are available
  const normalProb = probs ? (probs[0] * 100).toFixed(2) : null;
  const attackProb = probs ? (probs[1] * 100).toFixed(2) : null;

  return (
    <div className="card bg-base-200 shadow-md p-6">
      <h2 className="text-xl font-bold mb-4">Prediction Result</h2>
      <p className="mb-4">Prediction: {label}</p>

      {probs && (
        <div className="space-y-4">
          {/* Normal Probability */}
          <div>
            <p className="font-semibold text-success mb-1">
              ✅ Normal: {normalProb}%
            </p>
            <progress
              className="progress progress-success w-full"
              value={normalProb}
              max="100"
            ></progress>
          </div>

          {/* Attack Probability */}
          <div>
            <p className="font-semibold text-error mb-1">
              🚨 Attack: {attackProb}%
            </p>
            <progress
              className="progress progress-error w-full"
              value={attackProb}
              max="100"
            ></progress>
          </div>
        </div>
      )}
    </div>
  );
}
