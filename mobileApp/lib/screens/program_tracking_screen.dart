
import 'package:flutter/material.dart';

class ProgramTrackingScreen extends StatefulWidget {
  const ProgramTrackingScreen({super.key});

  @override
  State<ProgramTrackingScreen> createState() => _ProgramTrackingScreenState();
}

class _ProgramTrackingScreenState extends State<ProgramTrackingScreen> {
  final _program = TextEditingController();
  final _farmer = TextEditingController();
  final _resource = TextEditingController();
  final _impact = TextEditingController();

  void _trackProgram() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Program tracked')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Program Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: _program, decoration: const InputDecoration(labelText: 'Program Name')),
            TextField(controller: _farmer, decoration: const InputDecoration(labelText: 'Farmer/Community')),
            TextField(controller: _resource, decoration: const InputDecoration(labelText: 'Resource Distributed')),
            TextField(controller: _impact, decoration: const InputDecoration(labelText: 'Impact / Remarks'), maxLines: 3),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _trackProgram, child: const Text('Track Program')),
          ],
        ),
      ),
    );
  }
}
