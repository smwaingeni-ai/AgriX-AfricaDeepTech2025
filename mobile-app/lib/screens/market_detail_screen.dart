import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/market_item.dart';

class MarketDetailScreen extends StatelessWidget {
  final MarketItem item;
  const MarketDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(item.description),
            const SizedBox(height: 10),
            Text('Location: ${item.location}'),
            Text('Type: ${item.type}'),
            Text('Price: \$${item.price}'),
            Text('Category: ${item.category}'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: item.paymentOptions.map((e) => Chip(label: Text(e))).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.call),
              label: const Text('Call Seller'),
              onPressed: () => launchUrl(Uri.parse('tel:${item.contact}')),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.message),
              label: const Text('SMS Seller'),
              onPressed: () => launchUrl(Uri.parse('sms:${item.contact}')),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.chat),
              label: const Text('WhatsApp Seller'),
              onPressed: () => launchUrl(Uri.parse('https://wa.me/${item.contact}')),
            ),
          ],
        ),
      ),
    );
  }
}