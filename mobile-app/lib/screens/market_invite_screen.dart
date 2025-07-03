import 'package:flutter/material.dart';

class MarketInviteScreen extends StatelessWidget {
  const MarketInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invite to Market Day')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Invite contacts to join upcoming Market Days.'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Invite via WhatsApp'),
              onPressed: () {
                // Placeholder
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Invite via Email'),
              onPressed: () {
                // Placeholder
              },
            ),
          ],
        ),
      ),
    );
  }
}