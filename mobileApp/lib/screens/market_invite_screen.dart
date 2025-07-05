import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketInviteScreen extends StatefulWidget {
  const MarketInviteScreen({super.key});

  @override
  State<MarketInviteScreen> createState() => _MarketInviteScreenState();
}

class _MarketInviteScreenState extends State<MarketInviteScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _contacts = ['+263771234567', '+260971234567', '+254701234567'];
  String _selectedContact = '';

  @override
  void initState() {
    super.initState();
    _selectedContact = _contacts.isNotEmpty ? _contacts.first : '';
    _messageController.text = "Join us for the Agri Market Day! View listings, trade and invest.";
  }

  Future<void> _inviteViaWhatsApp() async {
    final uri = Uri.parse("https://wa.me/$_selectedContact?text=${Uri.encodeComponent(_messageController.text)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showError("Could not launch WhatsApp");
    }
  }

  Future<void> _inviteViaSMS() async {
    final uri = Uri.parse("sms:$_selectedContact?body=${Uri.encodeComponent(_messageController.text)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showError("Could not send SMS");
    }
  }

  Future<void> _callContact() async {
    final uri = Uri.parse("tel:$_selectedContact");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showError("Could not initiate call");
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invite to Market")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Contact", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedContact,
              items: _contacts.map((phone) {
                return DropdownMenuItem(value: phone, child: Text(phone));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedContact = val);
              },
            ),
            const SizedBox(height: 20),
            const Text("Message", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.sms),
                  label: const Text("Send SMS"),
                  onPressed: _inviteViaSMS,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.whatsapp),
                  label: const Text("Send WhatsApp"),
                  onPressed: _inviteViaWhatsApp,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.phone),
                  label: const Text("Call"),
                  onPressed: _callContact,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
