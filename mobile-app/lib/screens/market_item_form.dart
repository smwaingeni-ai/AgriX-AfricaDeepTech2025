import 'package:flutter/material.dart';
import '../models/market_item.dart';
import '../services/market_service.dart';

class MarketItemFormScreen extends StatefulWidget {
  const MarketItemFormScreen({super.key});

  @override
  State<MarketItemFormScreen> createState() => _MarketItemFormScreenState();
}

class _MarketItemFormScreenState extends State<MarketItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();

  String _category = 'Crops';
  String _listingType = 'Sale';
  bool _isOpenForInvestment = false;
  String _investmentStatus = 'Indifferent';
  List<String> _paymentMethods = ['Cash'];
  bool _loanOption = false;
  String _selectedFinancier = 'Private';

  final List<String> categories = [
    'Crops', 'Livestock', 'Land', 'Equipment', 'Services'
  ];
  final List<String> listingTypes = [
    'Sale', 'Lease', 'Barter', 'Request'
  ];
  final List<String> investmentStatuses = [
    'Open', 'Indifferent', 'Not Open'
  ];
  final List<String> paymentMethods = [
    'Cash', 'Bank Transfer', 'Mobile Money', 'QR Code', 'Loan', 'Debit Card'
  ];
  final List<String> financiers = [
    'Private', 'Ministry of Finance', 'Microfinance', 'Cooperative'
  ];

  void _saveItem() async {
    if (_formKey.currentState?.validate() ?? false) {
      final item = MarketItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        location: _locationController.text,
        contactInfo: _contactController.text,
        category: _category,
        listingType: _listingType,
        isOpenForInvestment: _isOpenForInvestment,
        investmentStatus: _investmentStatus,
        paymentOptions: _paymentMethods,
        financier: _loanOption ? _selectedFinancier : null,
        timestamp: DateTime.now().toIso8601String(),
      );

      await MarketService().addItem(item);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildChips<T>({
    required List<T> items,
    required List<T> selected,
    required Function(T, bool) onSelected,
  }) {
    return Wrap(
      spacing: 6.0,
      children: items.map((item) {
        final isSelected = selected.contains(item);
        return FilterChip(
          label: Text(item.toString()),
          selected: isSelected,
          onSelected: (val) => setState(() {
            onSelected(item, val);
          }),
        );
      }).toList(),
    );
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
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField(
              value: _category,
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _category = value!),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            DropdownButtonFormField(
              value: _listingType,
              items: listingTypes
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _listingType = value!),
              decoration: const InputDecoration(labelText: 'Listing Type'),
            ),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(labelText: 'Contact Info'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Open for Investment'),
              value: _isOpenForInvestment,
              onChanged: (val) => setState(() => _isOpenForInvestment = val),
            ),
            if (_isOpenForInvestment)
              DropdownButtonFormField(
                value: _investmentStatus,
                items: investmentStatuses
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _investmentStatus = value!),
                decoration: const InputDecoration(labelText: 'Investment Status'),
              ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            _buildChips<String>(
              items: paymentMethods,
              selected: _paymentMethods,
              onSelected: (val, selected) {
                if (selected) {
                  _paymentMethods.add(val);
                } else {
                  _paymentMethods.remove(val);
                }
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Offer Loan Option'),
              value: _loanOption,
              onChanged: (val) => setState(() => _loanOption = val),
            ),
            if (_loanOption)
              DropdownButtonFormField(
                value: _selectedFinancier,
                items: financiers
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedFinancier = val!),
                decoration: const InputDecoration(labelText: 'Financier'),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Submit'),
              onPressed: _saveItem,
            ),
          ]),
        ),
      ),
    );
  }
}
