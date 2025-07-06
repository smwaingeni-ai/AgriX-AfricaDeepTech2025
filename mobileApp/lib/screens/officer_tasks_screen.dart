import 'package:flutter/material.dart';

class OfficerTasksScreen extends StatefulWidget {
  const OfficerTasksScreen({super.key});

  @override
  State<OfficerTasksScreen> createState() => _OfficerTasksScreenState();
}

class _OfficerTasksScreenState extends State<OfficerTasksScreen> {
  final List<Map<String, String>> _tasks = [
    {
      'title': 'Inspect Field in Region A',
      'description': 'Check maize crop progress and pest control.',
      'status': 'Pending'
    },
    {
      'title': 'Monitor Livestock Health',
      'description': 'Review cattle health reports from Farm B.',
      'status': 'In Progress'
    },
    {
      'title': 'Verify Input Distribution',
      'description': 'Ensure fertilizer delivery was completed.',
      'status': 'Completed'
    },
  ];

  void _markTaskAsCompleted(int index) {
    setState(() {
      _tasks[index]['status'] = 'Completed';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task "${_tasks[index]['title']}" marked as completed.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AREX Officer: Tasks'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(task['title'] ?? ''),
              subtitle: Text(task['description'] ?? ''),
              trailing: Text(
                task['status'] ?? '',
                style: TextStyle(
                  color: task['status'] == 'Completed' ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: task['status'] != 'Completed'
                  ? () => _markTaskAsCompleted(index)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
