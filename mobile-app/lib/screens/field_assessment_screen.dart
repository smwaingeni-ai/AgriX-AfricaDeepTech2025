
import 'package:flutter/material.dart';

class FieldAssessmentScreen extends StatefulWidget {
  const FieldAssessmentScreen({super.key});

  @override
  State<FieldAssessmentScreen> createState() => _FieldAssessmentScreenState();
}

class _FieldAssessmentScreenState extends State<FieldAssessmentScreen> {
  final _crop = TextEditingController();
  final _observations = TextEditingController();
  final _recommendations = TextEditingController();

  void _submitAssessment() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Field assessment saved')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Field Assessment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _crop,
              decoration: const InputDecoration(labelText: 'Crop Type'),
            ),
            TextField(
              controller: _observations,
              decoration: const InputDecoration(labelText: 'Observations'),
              maxLines: 3,
            ),
            TextField(
              controller: _recommendations,
              decoration: const InputDecoration(labelText: 'Recommendations'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAssessment,
              child: const Text('Submit Assessment'),
            ),
          ],
        ),
      ),
    );
  }
}
