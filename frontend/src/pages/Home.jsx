import { useState } from "react";
import InputForm from "../components/InputForm";
import ResultCard from "../components/ResultCard";

export default function Home() {
  const [result, setResult] = useState(null);

  return (
    <div className="min-h-screen bg-base-200 p-10">
      {/* Top Section: Description + How to Use */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
        {/* Description Card */}
        <div className="card bg-base-100 shadow-lg p-6">
          <h1 className="text-3xl font-bold flex items-center gap-2">
            🛡️ Botnet Detector
          </h1>
          <p className="mt-4 text-base leading-relaxed">
            This project is a <span className="font-semibold">Machine Learning powered Botnet Traffic Detector</span>. 
            It is trained on the <span className="font-semibold">CTU-13 dataset</span>, which contains both 
            normal and malicious (botnet attack) traffic data.
          </p>
          <p className="mt-3 text-base leading-relaxed">
            The detector takes <span className="font-semibold">57 space-separated numerical features</span> 
            as input and classifies the traffic as 
            <span className="text-success font-semibold"> Normal</span> or 
            <span className="text-error font-semibold"> Attack</span>.
          </p>
        </div>

        {/* How to Use Card */}
        <div className="card bg-base-100 shadow-lg p-6">
          <h2 className="text-2xl font-bold flex items-center gap-2">
            🚀 How to Use
          </h2>
          <ol className="list-decimal list-inside space-y-3 mt-4 text-base">
            <li>Download the sample CSV files (Normal & Attack traffic).</li>
            <li>Copy a row (57 values) from the CSV or your dataset.</li>
            <li>Paste it into the big input box below.</li>
            <li>Click <span className="font-semibold">Predict</span> to see the result.</li>
          </ol>
        </div>
      </div>

      {/* Prediction Section */}
      <div className="flex justify-center">
        <div className="card w-full md:w-3/4 lg:w-2/3 bg-base-100 shadow-xl">
          <div className="card-body space-y-6">
            <h2 className="card-title text-2xl">🎯 Make a Prediction</h2>
            <InputForm onResult={setResult} />
            <ResultCard result={result} />
          </div>
        </div>
      </div>

      {/* Footer */}
      <footer className="mt-12 text-center text-sm opacity-80">
        <p>
          Made by <span className="font-semibold">Team Kascade</span>
        </p>
      </footer>
    </div>
  );
}
