# qr_scanner.py

import cv2
import os

def decode_qr(image_path):
    """
    Reads a QR image and decodes the embedded data.
    Returns decoded data, image array, and bounding box points.
    """
    if not os.path.exists(image_path):
        raise FileNotFoundError(f"QR image not found at: {image_path}")

    image = cv2.imread(image_path)
    detector = cv2.QRCodeDetector()
    data, points, _ = detector.detectAndDecode(image)

    return data, image, points

# Optional standalone test block
if __name__ == "__main__":
    sample_files = ['qr_sample.jpg', 'qr_sample.jpeg', 'qr_sample.png']
    test_path = next((f for f in sample_files if os.path.exists(f)), None)

    if not test_path:
        print("⚠️ No sample QR image found in current directory.")
    else:
        data, img, pts = decode_qr(test_path)
        if data:
            print(f"✅ Decoded QR data: {data}")
        else:
            print("⚠️ No QR code detected in the image.")
