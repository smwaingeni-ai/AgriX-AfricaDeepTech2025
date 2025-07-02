import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import '../models/farmer_profile.dart';

class FarmerRegistrationScreen extends StatefulWidget {
  const FarmerRegistrationScreen({super.key});

  @override
  State<FarmerRegistrationScreen> createState() => _FarmerRegistrationScreenState();
}

class _FarmerRegistrationScreenState extends State<FarmerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _locationController = TextEditingController();
  final _farmSizeController = TextEditingController();

  bool _govtAffiliated = false;
  String? _qrImagePath;

  Future<void> _saveFarmerProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final id = const Uuid().v4();
    final name = _nameController.text.trim();
    final nationalId = _nationalIdController.text.trim();
    final location = _locationController.text.trim();
    final farmSize = double.tryParse(_farmSizeController.text.trim()) ?? 0.0;

    final qrData = json.encode({'id': id, 'name': name, 'nationalId': nationalId});

    final painter = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      gapless: true,
      color: const Color(0xFF000000),
      emptyColor: const Color(0xFFFFFFFF),
    );

    final dir = await getApplicationDocumentsDirectory();
    final qrPath = '${dir.path}/$id-qr.png';

    final picData = await painter.toImageData(300, format: ImageByteFormat.png);
    final buffer = picData!.buffer.asUint8List();

    await File(qrPath).writeAsBytes(buffer);

    final profile = FarmerProfile(
      id: id,
      name: name,
      nationalId: nationalId,
      location: location,
      farmSizeHectares: farmSize,
      govtAffiliated: _govtAffiliated,
      qrImagePath: qrPath,
    );

    final profileFile = File('${dir.path}/farmer_profile.json');
    await profileFile.writeAsString(json.encode(profile.toJson()));

    setState(() {
      _qrImagePath = qrPath;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Farmer profile registered & QR saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farmer Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _nationalIdController,
                    decoration: const InputDecoration(labelText: 'National ID'),
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _farmSizeController,
                    decoration: const InputDecoration(labelText: 'Farm Size (ha)'),
                    keyboardType: TextInputType.number,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  SwitchListTile(
                    title: const Text('Affiliated with Government?'),
                    value: _govtAffiliated,
                    onChanged: (val) => setState(() => _govtAffiliated = val),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Register Farmer'),
                    onPressed: _saveFarmerProfile,
                  ),
                  const SizedBox(height: 20),
                  if (_qrImagePath != null)
                    Column(
                      children: [
                        const Text('QR Code:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Image.file(File(_qrImagePath!)),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
