# main_app.py

import os
import cv2
import numpy as np
import tensorflow as tf
from PIL import Image
from subsidy_engine import SubsidyEngine
from qr_scanner import decode_qr

# ---------------------- File Paths ------------------------
LEAF_IMAGE_PATH = "data/crops/sample_leaf.jpg"
MODEL_PATH = "prototype/tflite_model/crop_disease_model.tflite"
COSTING_PATH = "data/costing/advice_costs.csv"
QR_IMAGE_ROOT = "data/farmers"

# ---------------------- Check Required Files ------------------------
required_files = [
    LEAF_IMAGE_PATH,
    MODEL_PATH,
    COSTING_PATH
]

for p in required_files:
    if not os.path.exists(p):
        raise FileNotFoundError(f"Missing file: {p}")

# ---------------------- Locate QR Image ------------------------
supported_exts = [".jpg", ".jpeg", ".png", ".webp"]
qr_file = None
for root, _, files in os.walk(QR_IMAGE_ROOT):
    for file in files:
        if any(file.lower().endswith(ext) for ext in supported_exts):
            qr_file = os.path.join(root, file)
            break
    if qr_file:
        break

if not qr_file:
    raise FileNotFoundError("No QR image found (supports .jpg/.jpeg/.png/.webp)")

# ---------------------- Load TFLite Model ------------------------
interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()
print("📦 Model input shape:", input_details[0]['shape'])

# ---------------------- Predict Crop Disease ------------------------
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

# ---------------------- QR Decoding ------------------------
qr_data, _, _ = decode_qr(qr_file)
if qr_data:
    print(f"🔍 QR decoded: {qr_data}")
else:
    print("⚠️ QR could not be decoded.")
    qr_data = "Unknown Farmer"

# ---------------------- Predict ------------------------
prediction, confidence = predict_crop_disease(LEAF_IMAGE_PATH)
print(f"\n🌾 Predicted class: {prediction} ({confidence * 100:.2f}% confidence)")

# ---------------------- Costing & Subsidy ------------------------
advice_map = {
    "Healthy": "Crop Disease Treatment",
    "Maize___Leaf_Spot": "Crop Disease Treatment",
    "Tomato___Bacterial_spot": "Crop Disease Treatment"
}
advice_type = advice_map.get(prediction, "Crop Disease Treatment")

engine = SubsidyEngine(COSTING_PATH)
cost_result = engine.calculate_cost(advice_type, applicant_group="All")

print("\n💸 Subsidy Costing Result:")
for k, v in cost_result.items():
    print(f"{k}: {v}")
