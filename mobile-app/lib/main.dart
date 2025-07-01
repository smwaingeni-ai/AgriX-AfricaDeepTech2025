import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/transaction_screen.dart';  // ✅ New import

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
        '/transaction': (_) => const TransactionScreen(), // ✅ Register the new screen
      },
    );
  }
}
