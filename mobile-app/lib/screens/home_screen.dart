import 'package:flutter/material.dart';
import '../models/farmer_profile.dart';
import '../services/profile_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FarmerProfile? _activeProfile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await ProfileService.loadActiveProfile();
    setState(() {
      _activeProfile = profile;
    });
  }

  Widget buildTile({
    required IconData icon,
    required String title,
    required String route,
    Color? color,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: Icon(icon, color: color ?? Colors.green),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = _activeProfile?.name ?? 'Farmer';
    final region = _activeProfile?.region ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/register'),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: ListView(
        children: [
          if (region.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Region: $region',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

          const Divider(),

          buildTile(
              icon: Icons.camera_alt,
              title: 'Scan / Upload Image',
              route: '/upload'),

          buildTile(
              icon: Icons.help_outline,
              title: 'Get Advice (Crops, Soil, Livestock)',
              route: '/advice'),

          buildTile(
              icon: Icons.book_outlined,
              title: 'View Logbook Entries',
              route: '/logbook'),

          buildTile(
              icon: Icons.attach_money,
              title: 'Apply for Loan',
              route: '/loan'),

          buildTile(
              icon: Icons.store,
              title: 'Agri Market',
              route: '/market'),

          buildTile(
              icon: Icons.handshake,
              title: 'Contract Farming Offers',
              route: '/contracts/list'),

          buildTile(
              icon: Icons.gavel,
              title: 'Submit Contract Offer',
              route: '/contracts/new'),

          buildTile(
              icon: Icons.insights,
              title: 'Investor Portal',
              route: '/investor/register'),

          buildTile(
              icon: Icons.task,
              title: 'AREX Officer: Tasks',
              route: '/officer/tasks'),

          buildTile(
              icon: Icons.check_circle,
              title: 'AREX Officer: Assessments',
              route: '/officer/assessments'),

          buildTile(
              icon: Icons.tips_and_updates,
              title: 'Farming Tips',
              route: '/tips'),

          buildTile(
              icon: Icons.sync,
              title: 'Sync & Backup',
              route: '/sync'),

          buildTile(
              icon: Icons.notifications,
              title: 'Notifications',
              route: '/notifications'),

          buildTile(
              icon: Icons.chat,
              title: 'Chat with Others',
              route: '/chat'),

          buildTile(
              icon: Icons.help,
              title: 'Help & FAQs',
              route: '/help'),

          buildTile(
              icon: Icons.person_pin,
              title: 'AgriGPT AI Advisor',
              route: '/agrigpt'),
        ],
      ),
    );
  }
}
