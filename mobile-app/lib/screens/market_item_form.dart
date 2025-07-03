import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/market_item.dart';
import '../services/market_service.dart';

class MarketItemForm extends StatefulWidget {
  const MarketItemForm({super.key});

  @override
  State<MarketItemForm> createState() => _MarketItemFormState();
}

class _MarketItemFormState extends State<MarketItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  final _location = TextEditingController();
  final _price = TextEditingController();
  final _contact = TextEditingController();
  String _type = 'Sale';
  final List<String> _paymentOptions = [];

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final item = MarketItem(
      id: const Uuid().v4(),
      title: _title.text,
      description: _description.text,
      category: _category.text,
      location: _location.text,
      price: double.tryParse(_price.text) ?? 0.0,
      type: _type,
      photos: [],
      paymentOptions: _paymentOptions,
      contact: _contact.text,
    );
    final items = await MarketService.loadItems();
    items.add(item);
    await MarketService.saveItems(items);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Listing')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Title'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _description, decoration: const InputDecoration(labelText: 'Description'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _category, decoration: const InputDecoration(labelText: 'Category'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _location, decoration: const InputDecoration(labelText: 'Location')),
              TextFormField(controller: _price, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
              TextFormField(controller: _contact, decoration: const InputDecoration(labelText: 'Contact Info')),
              DropdownButtonFormField<String>(
                value: _type,
                items: ['Sale', 'Lease', 'Barter'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              Wrap(
                children: ['Cash', 'Loan', 'Bank', 'QR'].map((opt) => CheckboxListTile(
                  title: Text(opt),
                  value: _paymentOptions.contains(opt),
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        _paymentOptions.add(opt);
                      } else {
                        _paymentOptions.remove(opt);
                      }
                    });
                  },
                )).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}