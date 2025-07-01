import 'package:flutter/material.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Synchronize')),
      body: const Center(
        child: Text(
          'This is the Synchronize screen. It will handle updates and syncing when online.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
