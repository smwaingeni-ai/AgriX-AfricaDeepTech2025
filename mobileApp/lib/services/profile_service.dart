import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/farmer_profile.dart';

class ProfileService {
  static const _activeKey = 'active_farmer_profile_id';

  /// Gets the path to the app's document directory
  static Future<String> _getDirectoryPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  /// Saves a FarmerProfile to a file
  static Future<void> saveProfile(FarmerProfile profile) async {
    final path = await _getDirectoryPath();
    final file = File('$path/farmer_${profile.id}.json');
    await file.writeAsString(jsonEncode(profile.toJson()));
  }

  /// Loads all FarmerProfiles saved locally
  static Future<List<FarmerProfile>> loadAllProfiles() async {
    final path = await _getDirectoryPath();
    final dir = Directory(path);
    final files = dir
        .listSync()
        .where((f) => f is File && f.path.contains('farmer_') && f.path.endsWith('.json'))
        .toList();

    return files.map((f) {
      final content = File(f.path).readAsStringSync();
      return FarmerProfile.fromJson(jsonDecode(content));
    }).toList();
  }

  /// Sets the ID of the active profile (SharedPreferences)
  static Future<void> setActiveProfileId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeKey, id);
  }

  /// Loads the currently active FarmerProfile
  static Future<FarmerProfile?> loadActiveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_activeKey);
    if (id == null) return null;

    final path = await _getDirectoryPath();
    final file = File('$path/farmer_$id.json');
    if (!file.existsSync()) return null;

    final content = await file.readAsString();
    return FarmerProfile.fromJson(jsonDecode(content));
  }
}
