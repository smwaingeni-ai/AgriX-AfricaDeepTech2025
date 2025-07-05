
import 'package:flutter/material.dart';

class TrainingLogScreen extends StatefulWidget {
  const TrainingLogScreen({super.key});

  @override
  State<TrainingLogScreen> createState() => _TrainingLogScreenState();
}

class _TrainingLogScreenState extends State<TrainingLogScreen> {
  final _title = TextEditingController();
  final _topic = TextEditingController();
  final _audience = TextEditingController();
  final _outcome = TextEditingController();

  void _logTraining() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Training logged')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training Log')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: _title, decoration: const InputDecoration(labelText: 'Event Title')),
            TextField(controller: _topic, decoration: const InputDecoration(labelText: 'Topic')),
            TextField(controller: _audience, decoration: const InputDecoration(labelText: 'Audience')),
            TextField(controller: _outcome, decoration: const InputDecoration(labelText: 'Outcome Summary'), maxLines: 3),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _logTraining, child: const Text('Log Training')),
          ],
        ),
      ),
    );
  }
}
