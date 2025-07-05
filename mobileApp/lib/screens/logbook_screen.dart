import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LogbookScreen extends StatefulWidget {
  const LogbookScreen({super.key});

  @override
  State<LogbookScreen> createState() => _LogbookScreenState();
}

class _LogbookScreenState extends State<LogbookScreen> {
  List<dynamic> _entries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadLogbook();
  }

  Future<void> _loadLogbook() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/logbook.json');

      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> logs = json.decode(content);
        setState(() {
          _entries = logs.reversed.toList(); // show latest first
        });
      }
    } catch (e) {
      debugPrint('❌ Error reading logbook: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildEntry(Map<String, dynamic> entry) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.assignment, color: Colors.green),
        title: Text(entry['result'] ?? 'No description'),
        subtitle: Text('🕒 ${entry['timestamp']}'),
        trailing: Text(entry['cost'] ?? 'N/A'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgriX Logbook')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _entries.isEmpty
              ? const Center(child: Text('📭 No entries yet. Save a scan result first.'))
              : ListView.builder(
                  itemCount: _entries.length,
                  itemBuilder: (context, index) =>
                      _buildEntry(_entries[index] as Map<String, dynamic>),
                ),
    );
  }
}
