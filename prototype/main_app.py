# main_app.py
# AgriX - Offline Crop Advisory Workflow (v1)
# Author: AgriX Team
# Last updated: 2025-06-28

import os
import cv2
import json
import shutil
import numpy as np
from PIL import Image
import tensorflow as tf
import pandas as pd
from qr_scanner import decode_qr
from subsidy_engine import calculate_cost
from soil_advisor import soil_advisor_engine
from livestock_symptom_engine import livestock_engine

# ========= Configuration ========= #
MODEL_PATH = "prototype/tflite_model/crop_disease_model.tflite"
LEAF_IMAGE_PATH = "data/crops/sample_leaf.jpg"
COST_CSV_PATH = "data/costing/advice_costs.csv"
FARMER_LOG_DIR = "logs/"
os.makedirs(FARMER_LOG_DIR, exist_ok=True)
# ================================= #

# Load model once
interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()
CLASS_NAMES = ['Healthy', 'Maize___Leaf_Spot', 'Tomato___Bacterial_spot']

# Predict crop disease from image
def predict_crop_disease(image_path):
    img = Image.open(image_path).convert('RGB').resize((128, 128))
    img_array = np.array(img) / 255.0
    img_array = np.expand_dims(img_array, axis=0).astype(np.float32)
    interpreter.set_tensor(input_details[0]['index'], img_array)
    interpreter.invoke()
    output = interpreter.get_tensor(output_details[0]['index'])[0]
    prediction = CLASS_NAMES[np.argmax(output)]
    confidence = np.max(output)
    return prediction, confidence

# Save to log
def save_log(farmer_id, log_data):
    log_file = os.path.join(FARMER_LOG_DIR, f"farmer_{farmer_id}_log.json")
    with open(log_file, "a") as f:
        f.write(json.dumps(log_data) + "\n")
    print(f"📁 Log saved: {log_file}")

# Main app flow
def run_advisory_workflow():
    # === Step 1: Scan QR code ===
    qr_image = input("📸 Enter path to QR image: ").strip()
    qr_data, _, _ = decode_qr(qr_image)
    if not qr_data:
        print("⚠️ No QR detected. Exiting.")
        return
    farmer_id = qr_data
    print(f"👤 Farmer ID: {farmer_id}")

    # === Step 2: Choose problem type ===
    print("🧠 What do you want advice on?")
    print("1. Crop Disease  2. Livestock  3. Soil")
    choice = input("Enter 1/2/3: ").strip()

    if choice == "1":
        # Crop Diagnosis
        leaf_path = input("📤 Enter path to crop leaf image: ").strip()
        shutil.copy(leaf_path, LEAF_IMAGE_PATH)
        prediction, confidence = predict_crop_disease(LEAF_IMAGE_PATH)
        advice_type = "Crop Disease Treatment"
        print(f"🌾 Detected: {prediction} ({confidence*100:.2f}%)")

        result = {
            "farmer_id": farmer_id,
            "type": "Crop",
            "diagnosis": prediction,
            "confidence": round(confidence * 100, 2),
            "advice": f"Treat for: {prediction}",
        }

    elif choice == "2":
        # Livestock symptoms
        symptom = input("🐄 Describe the livestock symptom: ").strip()
        outcome = livestock_engine(symptom)
        advice_type = "Livestock Deworming"

        print(f"🧬 Diagnosis: {outcome['disease']} → Treatment: {outcome['treatment']}")

        result = {
            "farmer_id": farmer_id,
            "type": "Livestock",
            "symptom": symptom,
            "diagnosis": outcome["disease"],
            "advice": outcome["treatment"],
        }

    elif choice == "3":
        # Soil fertility
        symptom = input("🌱 Describe the soil symptom: ").strip()
        outcome = soil_advisor_engine(symptom)
        advice_type = "Soil Fertility Boost"

        print(f"🧪 Diagnosis: {outcome['nutrient_issue']} → Recommendation: {outcome['recommendation']}")

        result = {
            "farmer_id": farmer_id,
            "type": "Soil",
            "symptom": symptom,
            "diagnosis": outcome["nutrient_issue"],
            "advice": outcome["recommendation"],
        }

    else:
        print("❌ Invalid selection.")
        return

    # === Step 3: Apply subsidy costing ===
    applicant_group = input("👥 Enter applicant group (e.g., All, FemaleOnly, GoatFarmers): ").strip()
    df_costs = pd.read_csv(COST_CSV_PATH)
    subsidy_result = calculate_cost(advice_type, applicant_group, df=df_costs)

    result.update(subsidy_result)
    print("💸 Final Advice Summary:")
    for k, v in result.items():
        print(f"{k}: {v}")

    # === Step 4: Save log ===
    save_log(farmer_id, result)

if __name__ == "__main__":
    run_advisory_workflow()
