import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/farmer_profile.dart';

class FarmerService {
  static Future<List<FarmerProfile>> loadFarmers() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/farmers.json');
    if (!await file.exists()) return [];
    final list = json.decode(await file.readAsString()) as List;
    return list.map((e) => FarmerProfile.fromJson(e)).toList();
  }

  static Future<void> saveFarmer(FarmerProfile f) async {
    final farmers = await loadFarmers();
    farmers.removeWhere((x) => x.id == f.id);
    farmers.add(f);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/farmers.json');
    await file.writeAsString(json.encode(farmers.map((f) => f.toJson()).toList()));
  }
}
