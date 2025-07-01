import 'package:flutter/material.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  void _simulateSync(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🔄 Synchronization complete')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Synchronize Data')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.sync),
          label: const Text('Sync Now'),
          onPressed: () => _simulateSync(context),
        ),
      ),
    );
  }
}
