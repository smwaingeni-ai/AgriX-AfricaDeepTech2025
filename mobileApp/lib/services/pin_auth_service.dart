import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinAuthService {
  static const _storage = FlutterSecureStorage();
  static const _pinKey = 'agrix_user_pin';

  static Future<void> savePin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  static Future<bool> validatePin(String enteredPin) async {
    final storedPin = await _storage.read(key: _pinKey);
    return storedPin == enteredPin;
  }

  static Future<void> clearPin() async {
    await _storage.delete(key: _pinKey);
  }
}
