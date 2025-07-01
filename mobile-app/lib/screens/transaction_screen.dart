import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TransactionScreen extends StatelessWidget {
  final String result;
  final String timestamp;
  final String cost;

  const TransactionScreen({
    super.key,
    required this.result,
    required this.timestamp,
    this.cost = '5 ZMW',
  });

  Future<void> _saveToLogbook(BuildContext context) async {
    final entry = {
      'timestamp': timestamp,
      'result': result,
      'cost': cost,
    };

    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/logbook.json');

      List<dynamic> logs = [];
      if (await file.exists()) {
        final content = await file.readAsString();
        logs = json.decode(content);
      }

      logs.add(entry);
      await file.writeAsString(json.encode(logs));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Transaction saved to Logbook')),
      );
    } catch (e) {
      debugPrint('❌ Failed to save log: $e');
    }
  }

  void _shareResult() {
    Share.share('📄 AgriX Diagnostic\n\n$result\n\nCost: $cost\nTimestamp: $timestamp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Summary')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('📝 Diagnosis Result:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(result, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 5),
                Text(timestamp),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.money),
                const SizedBox(width: 5),
                Text('Cost: $cost'),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save to Logbook'),
              onPressed: () => _saveToLogbook(context),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share Result'),
              onPressed: _shareResult,
            ),
          ],
        ),
      ),
    );
  }
}
