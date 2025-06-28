# qr_scanner.py

import cv2
import os

def decode_qr(image_path):
    """
    Reads a QR image and decodes the embedded data.
    Returns decoded data, image array, and bounding box points.
    """
    if not os.path.exists(image_path):
        return None, None, None

    image = cv2.imread(image_path)
    detector = cv2.QRCodeDetector()
    data, points, _ = detector.detectAndDecode(image)

    return data, image, points

# Optional test block (can be removed in production use)
if __name__ == "__main__":
    test_path = "sample_qr.png"  # Replace with your actual path
    data, img, pts = decode_qr(test_path)
    if data:
        print(f"✅ Decoded QR data: {data}")
    else:
        print("⚠️ No QR code detected in the image.")
