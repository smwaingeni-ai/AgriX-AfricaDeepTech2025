# main_app.py

import os
import tensorflow as tf
import numpy as np
from PIL import Image
import cv2
import pandas as pd
from subsidy_engine import SubsidyEngine  # Now importing the class
from qr_scanner import decode_qr         # Your QR decoder function

# Set up paths
LEAF_IMAGE_PATH = "data/crops/sample_leaf.jpg"
MODEL_PATH = "prototype/tflite_model/crop_disease_model.tflite"
QR_IMAGE_PATH = "qr_sample.jpg"
COST_FILE = "data/costing/advice_costs.csv"

# Ensure paths exist
for p in [LEAF_IMAGE_PATH, MODEL_PATH, QR_IMAGE_PATH, COST_FILE]:
    if not os.path.exists(p):
        raise FileNotFoundError(f"Missing file: {p}")

# Load and run the TFLite model
interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

def predict_crop_disease(image_path):
    img = Image.open(image_path).convert('RGB').resize((128, 128))
    img_array = np.array(img) / 255.0
    img_array = np.expand_dims(img_array, axis=0).astype(np.float32)

    interpreter.set_tensor(input_details[0]['index'], img_array)
    interpreter.invoke()
    output = interpreter.get_tensor(output_details[0]['index'])[0]

    class_names = ['Healthy', 'Maize___Leaf_Spot', 'Tomato___Bacterial_spot']
    prediction = class_names[np.argmax(output)]
    confidence = np.max(output)

    return prediction, confidence

# Run prediction
prediction, confidence = predict_crop_disease(LEAF_IMAGE_PATH)
print(f"🌾 Predicted class: {prediction} ({confidence*100:.2f}% confidence)")

# Decode QR code
qr_data, _, _ = decode_qr(QR_IMAGE_PATH)
if not qr_data:
    print("⚠️ QR not recognized.")
    exit()

print(f"📛 QR Data Extracted: {qr_data}")

# Load and use subsidy engine
engine = SubsidyEngine(COST_FILE)

# Simulated logic: use the crop disease prediction as advice type, and QR data as group
# You may need to adjust how qr_data maps to group names
result = engine.calculate_cost(advice_type="Crop Disease Treatment", applicant_group=qr_data)

print("\n💸 Subsidy Calculation Result:")
for k, v in result.items():
    print(f"{k}: {v}")
