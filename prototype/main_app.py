import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
import os
import shutil

# STEP 1: Define image path
LEAF_IMAGE_PATH = "data/crops/sample_leaf.jpg"

# Optional: Ensure directory exists (if simulating upload)
os.makedirs(os.path.dirname(LEAF_IMAGE_PATH), exist_ok=True)

# STEP 2: Load the TFLite model
model_path = "prototype/tflite_model/crop_disease_model.tflite"
interpreter = tf.lite.Interpreter(model_path=model_path)
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()
print("📦 Model input shape:", input_details[0]['shape'])

# STEP 3: Prediction function
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

# STEP 4: Run prediction
if os.path.exists(LEAF_IMAGE_PATH):
    prediction, confidence = predict_crop_disease(LEAF_IMAGE_PATH)
    print(f"🌾 Predicted class: {prediction} ({confidence * 100:.2f}% confidence)")
else:
    print(f"❌ Image not found at {LEAF_IMAGE_PATH}. Please provide the correct path.")
