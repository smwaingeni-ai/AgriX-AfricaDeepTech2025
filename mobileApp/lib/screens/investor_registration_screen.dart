import 'package:flutter/material.dart';
import '../models/investor_profile.dart';
import '../services/investor_service.dart';

class InvestorRegistrationScreen extends StatefulWidget {
  const InvestorRegistrationScreen({super.key});

  @override
  State<InvestorRegistrationScreen> createState() => _InvestorRegistrationScreenState();
}

class _InvestorRegistrationScreenState extends State<InvestorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();

  final List<String> _selectedTerms = [];
  final List<String> _interests = [];
  String _investmentStatus = 'Indifferent';

  final List<String> investmentTerms = ['Short-term (1–2 yrs)', 'Mid-term (3–5 yrs)', 'Long-term (6+ yrs)'];
  final List<String> categories = ['Crops', 'Livestock', 'Land', 'Equipment', 'Services'];
  final List<String> statuses = ['Open', 'Indifferent', 'Not Open'];

  void _saveInvestor() async {
    if (_formKey.currentState?.validate() ?? false) {
      final investor = InvestorProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: _nameController.text,
        contactInfo: _contactController.text,
        investmentTerms: _selectedTerms,
        interests: _interests,
        status: _investmentStatus,
        registeredAt: DateTime.now().toIso8601String(),
      );

      await InvestorService().addInvestor(investor);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Investor Registered')));
        Navigator.pop(context);
      }
    }
  }

  Widget _buildChips(List<String> options, List<String> selected, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          children: options.map((item) {
            final isSelected = selected.contains(item);
            return FilterChip(
              label: Text(item),
              selected: isSelected,
              onSelected: (val) {
                setState(() {
                  if (val) {
                    selected.add(item);
                  } else {
                    selected.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register as Investor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact Info (Phone/Email)'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildChips(investmentTerms, _selectedTerms, 'Preferred Investment Duration'),
              _buildChips(categories, _interests, 'Areas of Interest'),
              DropdownButtonFormField(
                value: _investmentStatus,
                decoration: const InputDecoration(labelText: 'Investment Status'),
                items: statuses.map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (val) => setState(() => _investmentStatus = val!),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Submit'),
                onPressed: _saveInvestor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
