import 'package:flutter/material.dart';
import '../../models/contracts/contract_offer.dart';
import '../../services/contracts/contract_service.dart';

class ContractOfferFormScreen extends StatefulWidget {
  const ContractOfferFormScreen({super.key});

  @override
  State<ContractOfferFormScreen> createState() => _ContractOfferFormScreenState();
}

class _ContractOfferFormScreenState extends State<ContractOfferFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contract = ContractOffer.empty();
  bool _submitting = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _submitting = true);
    await ContractService().saveContract(_contract);
    setState(() => _submitting = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contract offer posted successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Contract Offer')),
      body: _submitting
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Contract Title'),
                      onSaved: (val) => _contract.title = val ?? '',
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Parties Involved'),
                      onSaved: (val) => _contract.parties = val ?? '',
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Amount (USD)'),
                      keyboardType: TextInputType.number,
                      onSaved: (val) => _contract.amount = double.tryParse(val ?? '0') ?? 0,
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Duration (e.g. 12 months)'),
                      onSaved: (val) => _contract.duration = val ?? '',
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Crop or Livestock Type'),
                      onSaved: (val) => _contract.cropOrLivestockType = val ?? '',
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Location'),
                      onSaved: (val) => _contract.location = val ?? '',
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Contract Terms / Description'),
                      maxLines: 4,
                      onSaved: (val) => _contract.terms = val ?? '',
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit Contract'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
