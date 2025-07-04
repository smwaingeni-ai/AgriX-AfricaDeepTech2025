import 'package:flutter/material.dart';
import '../models/investment_offer.dart';
import '../services/market_service.dart';

class InvestmentOffersScreen extends StatefulWidget {
  const InvestmentOffersScreen({super.key});

  @override
  State<InvestmentOffersScreen> createState() => _InvestmentOffersScreenState();
}

class _InvestmentOffersScreenState extends State<InvestmentOffersScreen> {
  List<InvestmentOffer> _offers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  Future<void> _loadOffers() async {
    final data = await MarketService().loadOffers();
    setState(() {
      _offers = data;
      _loading = false;
    });
  }

  Widget _buildOfferCard(InvestmentOffer offer) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        leading: const Icon(Icons.monetization_on, color: Colors.green, size: 32),
        title: Text(offer.investorName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Listing ID: ${offer.listingId}"),
            Text("Amount: ${offer.amount}"),
            Text("Term: ${offer.term}"),
            Text("Status: ${offer.status}"),
            const SizedBox(height: 4),
            Text("Message: ${offer.message}"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.phone_forwarded),
          tooltip: 'Contact Investor',
          onPressed: () {
            // Placeholder for contact feature (call, chat, email, etc.)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contact investor feature coming soon')),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Investment Offers')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _offers.isEmpty
              ? const Center(child: Text('No investment offers available'))
              : RefreshIndicator(
                  onRefresh: _loadOffers,
                  child: ListView.builder(
                    itemCount: _offers.length,
                    itemBuilder: (context, index) => _buildOfferCard(_offers[index]),
                  ),
                ),
    );
  }
}
