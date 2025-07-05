import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<String> _notifications = const [
    '🌾 Crop advisory updated.',
    '🚨 Disease alert in your area.',
    '📦 New subsidy programs announced.',
    '📶 Your data sync was successful.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notification_important, color: Colors.green),
            title: Text(_notifications[index]),
          );
        },
      ),
    );
  }
}
