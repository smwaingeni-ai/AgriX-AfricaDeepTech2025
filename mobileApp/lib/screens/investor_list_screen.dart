import 'package:flutter/material.dart';
import '../models/investor_profile.dart';
import '../services/investor_service.dart';

class InvestorListScreen extends StatefulWidget {
  const InvestorListScreen({super.key});

  @override
  State<InvestorListScreen> createState() => _InvestorListScreenState();
}

class _InvestorListScreenState extends State<InvestorListScreen> {
  List<InvestorProfile> _investors = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadInvestors();
  }

  Future<void> _loadInvestors() async {
    final data = await InvestorService().loadInvestors();
    setState(() {
      _investors = data;
      _loading = false;
    });
  }

  Widget _buildCard(InvestorProfile investor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.person, size: 32, color: Colors.blue),
        title: Text(investor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Country: ${investor.country}"),
            Text("Investment Interest: ${investor.interestArea}"),
            Text("Term Preference: ${investor.term}"),
            Text("Status: ${investor.status}"),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$value: ${investor.name}')),
            );
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'Call', child: Text('Call')),
            const PopupMenuItem(value: 'WhatsApp', child: Text('Message on WhatsApp')),
            const PopupMenuItem(value: 'Email', child: Text('Email')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect with Investors')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _investors.isEmpty
              ? const Center(child: Text('No investors found.'))
              : RefreshIndicator(
                  onRefresh: _loadInvestors,
                  child: ListView.builder(
                    itemCount: _investors.length,
                    itemBuilder: (context, index) => _buildCard(_investors[index]),
                  ),
                ),
    );
  }
}
