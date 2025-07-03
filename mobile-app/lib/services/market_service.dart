import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/market_item.dart';

class MarketService {
  static Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile() async {
    final path = await _localPath();
    return File('$path/market_items.json');
  }

  static Future<List<MarketItem>> loadItems() async {
    try {
      final file = await _localFile();
      if (!file.existsSync()) return [];
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((e) => MarketItem.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> saveItems(List<MarketItem> items) async {
    final file = await _localFile();
    final jsonString = json.encode(items.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }
}