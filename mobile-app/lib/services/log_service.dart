import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '../models/log_entry.dart';

class LogService {
  static Future<File> _getLogFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/logbook.json');
  }

  static Future<List<LogEntry>> loadLogs() async {
    try {
      final file = await _getLogFile();
      if (!await file.exists()) return [];

      final content = await file.readAsString();
      final List<dynamic> jsonList = json.decode(content);

      return jsonList.map((e) => LogEntry.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveLog(LogEntry entry) async {
    final file = await _getLogFile();

    List<LogEntry> logs = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      logs = (json.decode(content) as List)
          .map((e) => LogEntry.fromJson(e))
          .toList();
    }

    logs.add(entry);

    final updatedJson = json.encode(logs.map((e) => e.toJson()).toList());
    await file.writeAsString(updatedJson);
  }

  static Future<void> clearLogs() async {
    final file = await _getLogFile();
    if (await file.exists()) {
      await file.delete();
    }
  }
}
