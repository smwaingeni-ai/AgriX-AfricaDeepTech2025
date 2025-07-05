import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqItems = [
      {
        'question': 'How do I register as a farmer?',
        'answer':
            'Go to the Home screen and tap on "Register". Fill in your profile details and save. A QR code will be generated for your identification.'
      },
      {
        'question': 'How do I get crop or soil advice?',
        'answer':
            'Use the "Get Advice" option on the Home screen. You can upload a photo or answer some questions to receive advice.'
      },
      {
        'question': 'How can I apply for a loan?',
        'answer':
            'Tap on "Loans" from the Home screen. Choose your profile and fill in the loan application form.'
      },
      {
        'question': 'What is the Agri Market?',
        'answer':
            'Agri Market allows you to buy, sell, or lease land, crops, livestock and services. You can also request or offer investments.'
      },
      {
        'question': 'How do I contact other farmers or AREX officers?',
        'answer':
            'Use the built-in chat feature to connect with farmers and agricultural officers within the app.'
      },
      {
        'question': 'Can I use the app offline?',
        'answer':
            'Yes. Most features are available offline including scanning, registering, and logbook. Sync when you’re back online.'
      },
      {
        'question': 'Is my data secure?',
        'answer':
            'Yes. You can lock your profile with a PIN or biometric fingerprint to protect your information.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & FAQs'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: faqItems.length,
        separatorBuilder: (_, __) => const Divider(height: 32),
        itemBuilder: (context, index) {
          final faq = faqItems[index];
          return ExpansionTile(
            title: Text(
              faq['question']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(faq['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
