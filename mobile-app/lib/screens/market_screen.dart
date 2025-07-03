import 'package:flutter/material.dart';
import '../models/market_item.dart';
import '../services/market_service.dart';
import 'market_detail_screen.dart';
import 'market_item_form.dart';
import 'market_invite_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  List<MarketItem> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await MarketService.loadItems();
    setState(() => _items = items);
  }

  void _navigateToAddItem() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MarketItemForm()),
    );
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddItem,
          ),
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const MarketInviteScreen())),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, i) {
          final item = _items[i];
          return ListTile(
            title: Text(item.title),
            subtitle: Text('${item.category} • ${item.location}'),
            trailing: Text('\$${item.price.toStringAsFixed(2)}'),
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => MarketDetailScreen(item: item))),
          );
        },
      ),
    );
  }
}