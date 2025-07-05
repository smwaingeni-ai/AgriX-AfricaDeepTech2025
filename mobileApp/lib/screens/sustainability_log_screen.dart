
import 'package:flutter/material.dart';

class SustainabilityLogScreen extends StatefulWidget {
  const SustainabilityLogScreen({super.key});

  @override
  State<SustainabilityLogScreen> createState() => _SustainabilityLogScreenState();
}

class _SustainabilityLogScreenState extends State<SustainabilityLogScreen> {
  final _farmer = TextEditingController();
  final _practice = TextEditingController();
  final _comment = TextEditingController();
  String _status = 'Adopted';

  void _saveLog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Sustainability log saved')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sustainability Log')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: _farmer, decoration: const InputDecoration(labelText: 'Farmer')),
            TextField(controller: _practice, decoration: const InputDecoration(labelText: 'Practice Type')),
            DropdownButtonFormField(
              value: _status,
              items: ['Adopted', 'Not Adopted'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _status = v!),
              decoration: const InputDecoration(labelText: 'Adoption Status'),
            ),
            TextField(controller: _comment, decoration: const InputDecoration(labelText: 'Officer Comment'), maxLines: 3),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveLog, child: const Text('Save Log')),
          ],
        ),
      ),
    );
  }
}
