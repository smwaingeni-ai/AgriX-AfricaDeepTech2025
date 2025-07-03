import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 140,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? Colors.green.shade100,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.green.shade800),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgriX Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildTile(
                icon: Icons.person_add,
                label: 'Register Farmer',
                onTap: () => Navigator.pushNamed(context, '/register'),
              ),
              _buildTile(
                icon: Icons.credit_card,
                label: 'Loan',
                onTap: () => Navigator.pushNamed(context, '/loan'),
              ),
              _buildTile(
                icon: Icons.assignment,
                label: 'Officer Tasks',
                onTap: () => Navigator.pushNamed(context, '/officer/tasks'),
              ),
              _buildTile(
                icon: Icons.fact_check,
                label: 'Assessments',
                onTap: () => Navigator.pushNamed(context, '/officer/assessments'),
              ),
              _buildTile(
                icon: Icons.grass,
                label: 'Crops',
                onTap: () => Navigator.pushNamed(context, '/upload'),
              ),
              _buildTile(
                icon: Icons.eco,
                label: 'Soil',
                onTap: () => Navigator.pushNamed(context, '/advice', arguments: 'soil'),
              ),
              _buildTile(
                icon: Icons.pets,
                label: 'Livestock',
                onTap: () => Navigator.pushNamed(context, '/advice', arguments: 'livestock'),
              ),
              _buildTile(
                icon: Icons.tips_and_updates,
                label: 'Tips',
                onTap: () => Navigator.pushNamed(context, '/tips'),
              ),
              _buildTile(
                icon: Icons.chat_bubble,
                label: 'AgriGPT',
                onTap: () => Navigator.pushNamed(context, '/agrigpt'),
              ),
              _buildTile(
                icon: Icons.sync,
                label: 'Synchronise',
                onTap: () => Navigator.pushNamed(context, '/sync'),
              ),
              _buildTile(
                icon: Icons.notifications,
                label: 'Notifications',
                onTap: () => Navigator.pushNamed(context, '/notifications'),
              ),
              _buildTile(
                icon: Icons.book,
                label: 'Logbook',
                onTap: () => Navigator.pushNamed(context, '/logbook'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
