import 'package:flutter/material.dart';

class OfficerAssessmentsScreen extends StatefulWidget {
  const OfficerAssessmentsScreen({super.key});

  @override
  State<OfficerAssessmentsScreen> createState() => _OfficerAssessmentsScreenState();
}

class _OfficerAssessmentsScreenState extends State<OfficerAssessmentsScreen> {
  final List<Assessment> _assessments = [];

  final _formKey = GlobalKey<FormState>();
  String _activity = '';
  String _impact = '';
  String _recommendation = '';

  void _addAssessment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _assessments.add(
          Assessment(
            activity: _activity,
            impact: _impact,
            recommendation: _recommendation,
            date: DateTime.now(),
          ),
        );
        _activity = '';
        _impact = '';
        _recommendation = '';
      });

      _formKey.currentState!.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assessment submitted')),
      );
    }
  }

  Widget _buildAssessmentTile(Assessment assessment) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(assessment.activity),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Impact: ${assessment.impact}'),
            Text('Recommendation: ${assessment.recommendation}'),
            Text('Date: ${assessment.date.toLocal().toString().split(' ')[0]}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AREX Officer: Assessments')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Submit Sustainability/Impact Assessment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Activity Observed'),
                    onSaved: (val) => _activity = val ?? '',
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Observed Impact'),
                    onSaved: (val) => _impact = val ?? '',
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Recommendation'),
                    onSaved: (val) => _recommendation = val ?? '',
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addAssessment,
                    child: const Text('Submit Assessment'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Submitted Assessments',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _assessments.isEmpty
                  ? const Text('No assessments yet.')
                  : ListView.builder(
                      itemCount: _assessments.length,
                      itemBuilder: (context, index) =>
                          _buildAssessmentTile(_assessments[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Assessment {
  final String activity;
  final String impact;
  final String recommendation;
  final DateTime date;

  Assessment({
    required this.activity,
    required this.impact,
    required this.recommendation,
    required this.date,
  });
}
