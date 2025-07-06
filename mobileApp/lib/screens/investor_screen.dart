import 'package:flutter/material.dart';
import '../../models/investor_profile.dart';
import '../../services/investor_service.dart';

class InvestorScreen extends StatefulWidget {
  const InvestorScreen({super.key});

  @override
  State<InvestorScreen> createState() => _InvestorScreenState();
}

class _InvestorScreenState extends State<InvestorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _investor = InvestorProfile.empty();

  bool _submitting = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _submitting = true);
    await InvestorService().saveInvestorProfile(_investor);
    setState(() => _submitting = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Investor profile submitted successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register as Investor')),
      body: _submitting
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      onSaved: (val) => _investor.name = val ?? '',
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (val) => _investor.email = val ?? '',
                      validator: (val) =>
                          val!.isEmpty || !val.contains('@') ? 'Enter valid email' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      onSaved: (val) => _investor.phone = val ?? '',
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Areas of Interest'),
                      onSaved: (val) => _investor.interestAreas = val ?? '',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
