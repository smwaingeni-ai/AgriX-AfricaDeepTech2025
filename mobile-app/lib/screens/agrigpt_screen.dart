import 'package:flutter/material.dart';

class AgriGPTScreen extends StatelessWidget {
  const AgriGPTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgriGPT Assistant')),
      body: const Center(
        child: Text(
          'This is the AgriGPT screen. Here you will interact with the AI advisor.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
