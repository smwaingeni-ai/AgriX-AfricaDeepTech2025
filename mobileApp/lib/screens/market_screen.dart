import 'package:flutter/material.dart';
import '../models/market_item.dart';
import '../services/market_service.dart';
import 'market_item_form.dart';
import 'market_detail_screen.dart';
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

  void _goToCreateItem() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MarketItemFormScreen()),
    );
    _loadItems();
  }

  void _goToInviteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MarketInviteScreen()),
    );
  }

  void _goToDetail(MarketItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MarketDetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: _goToInviteScreen,
            tooltip: "Invite to Market",
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _goToCreateItem,
            tooltip: "Add Listing",
          ),
        ],
      ),
      body: _items.isEmpty
          ? const Center(child: Text('No market listings available.'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text('${item.type} • ${item.location}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => _goToDetail(item),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreateItem,
        tooltip: 'Add New Listing',
        child: const Icon(Icons.add),
      ),
    );
  }
}
