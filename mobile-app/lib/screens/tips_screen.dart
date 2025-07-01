import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgriX Tips')),
      body: const Center(
        child: Text(
          'This is the Tips screen. You will see categorized farming tips here.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
