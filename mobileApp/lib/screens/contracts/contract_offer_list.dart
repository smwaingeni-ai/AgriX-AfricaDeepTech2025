import 'package:flutter/material.dart';
import '../../models/contract_offer.dart';
import '../../services/contract_service.dart';
import 'contract_offer_detail.dart';

class ContractOfferListScreen extends StatefulWidget {
  const ContractOfferListScreen({super.key});

  @override
  State<ContractOfferListScreen> createState() => _ContractOfferListScreenState();
}

class _ContractOfferListScreenState extends State<ContractOfferListScreen> {
  List<ContractOffer> _offers = [];

  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  Future<void> _loadOffers() async {
    final offers = await ContractService.loadOffers();
    setState(() => _offers = offers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contract Farming Offers')),
      body: _offers.isEmpty
          ? const Center(child: Text("No contract offers available."))
          : ListView.builder(
              itemCount: _offers.length,
              itemBuilder: (context, index) {
                final offer = _offers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.handshake, color: Colors.green),
                    title: Text(offer.title),
                    subtitle: Text("${offer.cropOrLivestockType} • ${offer.location}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ContractOfferDetailScreen(offer: offer),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/contracts/new'),
        child: const Icon(Icons.add),
        tooltip: 'Add Contract Offer',
      ),
    );
  }
}
