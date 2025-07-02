import 'package:flutter/material.dart';

// Core screens
import 'screens/home_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/transaction_screen.dart';
import 'screens/farmer_registration.dart';

// Feature screens
import 'screens/tips_screen.dart';
import 'screens/agrigpt_screen.dart';
import 'screens/sync_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/soil_screen.dart';
import 'screens/crops_screen.dart';
import 'screens/livestock_screen.dart';

void main() => runApp(const AgriXApp());

class AgriXApp extends StatelessWidget {
  const AgriXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/upload': (_) => const UploadScreen(),
        '/advice': (_) => const AdviceScreen(),
        '/logbook': (_) => const LogbookScreen(),
        '/transaction': (_) => const TransactionScreen(
              result: 'Demo',
              timestamp: '2025-06-30T00:00:00Z',
            ),

        // Farmer registration
        '/register': (_) => const FarmerRegistrationScreen(),

        // Feature routes
        '/tips': (_) => const TipsScreen(),
        '/agrigpt': (_) => const AgriGPTScreen(),
        '/sync': (_) => const SyncScreen(),
        '/notifications': (_) => const NotificationsScreen(),
        '/soil': (_) => const SoilScreen(),
        '/crops': (_) => const CropsScreen(),
        '/livestock': (_) => const LivestockScreen(),
      },
    );
  }
}
