import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import '../models/farmer_profile.dart';
import '../services/profile_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profile = FarmerProfile.empty();
  bool _submitted = false;

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    // Assign a unique ID based on timestamp
    _profile.id = DateTime.now().millisecondsSinceEpoch.toString();

    await ProfileService.saveActiveProfile(_profile);

    setState(() => _submitted = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully')),
    );
  }

  Widget _buildQRCode() {
    final encoded = jsonEncode(_profile.toJson());
    return QrImageView(
      data: encoded,
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Farmer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _submitted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('QR Code Generated:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  _buildQRCode(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Home'),
                  )
                ],
              )
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      onSaved: (val) => _profile.name = val ?? '',
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      onSaved: (val) => _profile.phone = val ?? '',
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Region'),
                      onSaved: (val) => _profile.region = val ?? '',
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Farm Type (e.g. Crops, Livestock)'),
                      onSaved: (val) => _profile.farmType = val ?? '',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: const Text('Generate QR'),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
