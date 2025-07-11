import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/market_item.dart';
import '../services/market_service.dart';

class MarketItemFormScreen extends StatefulWidget {
  const MarketItemFormScreen({super.key});

  @override
  State<MarketItemFormScreen> createState() => _MarketItemFormScreenState();
}

class _MarketItemFormScreenState extends State<MarketItemFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _location = '';
  double _price = 0.0;
  String _type = 'Sale';
  String _category = 'Crops';
  bool _isLoanAccepted = false;
  bool _isInvestorOpen = false;
  String _investmentTerm = 'None';
  String _paymentOption = 'Cash';
  File? _selectedImage;

  final List<String> _types = ['Sale', 'Lease', 'Barter', 'Request'];
  final List<String> _categories = ['Crops', 'Livestock', 'Land', 'Equipment', 'Service'];
  final List<String> _terms = ['None', 'Short-term (1-2 yrs)', 'Mid-term (3-5 yrs)', 'Long-term (>6 yrs)'];
  final List<String> _payments = ['Cash', 'Bank Transfer', 'Mobile Money', 'QR Code', 'Loan', 'Debit Card'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  void _saveListing() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      final item = MarketItem(
        title: _title,
        description: _description,
        location: _location,
        price: _price,
        type: _type,
        category: _category,
        imagePath: _selectedImage?.path ?? '',
        paymentOption: _paymentOption,
        isLoanAccepted: _isLoanAccepted,
        isInvestorOpen: _isInvestorOpen,
        investmentTerm: _investmentTerm,
        timestamp: DateTime.now().toIso8601String(),
      );
      await MarketService.saveItem(item);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Market Listing')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) => value == null || value.isEmpty ? 'Enter title' : null,
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? 'Enter description' : null,
              onSaved: (value) => _description = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (value) => value == null || value.isEmpty ? 'Enter location' : null,
              onSaved: (value) => _location = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _price = double.tryParse(value ?? '0') ?? 0.0,
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Type'),
              value: _type,
              items: _types.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => _type = value!),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Category'),
              value: _category,
              items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => _category = value!),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Payment Option'),
              value: _paymentOption,
              items: _payments.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => _paymentOption = value!),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text("Accept Loan as Payment"),
              value: _isLoanAccepted,
              onChanged: (value) => setState(() => _isLoanAccepted = value ?? false),
            ),
            CheckboxListTile(
              title: const Text("Open for Investment"),
              value: _isInvestorOpen,
              onChanged: (value) => setState(() => _isInvestorOpen = value ?? false),
            ),
            if (_isInvestorOpen)
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Preferred Investment Term'),
                value: _investmentTerm,
                items: _terms.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => _investmentTerm = value!),
              ),
            const SizedBox(height: 12),
            _selectedImage == null
                ? const Text("No image selected.")
                : Image.file(_selectedImage!, height: 150),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text("Select Image"),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save Listing'),
              onPressed: _saveListing,
            ),
          ]),
        ),
      ),
    );
  }
}
