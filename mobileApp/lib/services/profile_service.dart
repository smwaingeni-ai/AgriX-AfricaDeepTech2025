import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/farmer_profile.dart';

class ProfileService {
  static Future<String> _getDirectoryPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<void> saveProfile(FarmerProfile profile) async {
    final path = await _getDirectoryPath();
    final file = File('$path/farmer_${profile.id}.json');
    await file.writeAsString(jsonEncode(profile.toJson()));
  }

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
}
