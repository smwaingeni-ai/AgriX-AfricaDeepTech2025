
import 'package:flutter/material.dart';

class ArexOfficerDashboard extends StatelessWidget {
  const ArexOfficerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AREX Officer Dashboard')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text('Add Task'),
            onTap: () => Navigator.pushNamed(context, '/task_entry'),
          ),
          ListTile(
            leading: const Icon(Icons.agriculture),
            title: const Text('Field Assessment'),
            onTap: () => Navigator.pushNamed(context, '/field_assessment'),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Training Log'),
            onTap: () => Navigator.pushNamed(context, '/training_log'),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Program Tracking'),
            onTap: () => Navigator.pushNamed(context, '/program_tracking'),
          ),
          ListTile(
            leading: const Icon(Icons.eco),
            title: const Text('Sustainability Log'),
            onTap: () => Navigator.pushNamed(context, '/sustainability_log'),
          ),
        ],
      ),
    );
  }
}
