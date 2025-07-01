import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class SoilScreen extends StatefulWidget {
  const SoilScreen({super.key});

  @override
  State<SoilScreen> createState() => _SoilScreenState();
}

class _SoilScreenState extends State<SoilScreen> {
  File? _image;
  String? _description;
  final TextEditingController _noteController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        _description = "Soil likely shows signs of nutrient deficiency (Simulated)";
      });
    }
  }

  Future<void> _saveEntry() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/soil_log.json');

    final entry = {
      'timestamp': DateTime.now().toIso8601String(),
      'description': _description,
      'note': _noteController.text,
    };

    List<dynamic> logs = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      logs = json.decode(content);
    }

    logs.add(entry);
    await file.writeAsString(json.encode(logs));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Entry saved')),
    );
  }

  void _shareEntry() {
    if (_description != null) {
      Share.share('Soil Diagnosis Result:\n$_description\n\nNote: ${_noteController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Soil Diagnosis')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('Pick Soil Image'),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 16),
            if (_image != null) Image.file(_image!, height: 180),
            if (_description != null) ...[
              const SizedBox(height: 16),
              Text(_description!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Add Notes (Optional)'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: _saveEntry,
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.share),
                label: const Text('Share'),
                onPressed: _shareEntry,
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Escalate to AgriX'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('📨 Sent to AgriX support')),
                  );
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
