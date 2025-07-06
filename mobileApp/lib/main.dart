import 'package:flutter/material.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/loan_screen.dart';
import 'screens/market_screen.dart';
import 'screens/contract_offer_form.dart';
import 'screens/contract_list_screen.dart';
import 'screens/investor_screen.dart';
import 'screens/officer_tasks_screen.dart';
import 'screens/officer_assessments_screen.dart';
import 'screens/tips_screen.dart';
import 'screens/sync_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/help_screen.dart';
import 'screens/agrigpt_screen.dart';
import 'screens/register_screen.dart';
import 'screens/market_item_form.dart';         // ✅ If you have a separate form screen
import 'screens/market_detail_screen.dart';     // ✅ Optional detail view
import 'screens/market_invite_screen.dart';     // ✅ Optional invite screen

void main() {
  runApp(const AgriXApp());
}

class AgriXApp extends StatelessWidget {
  const AgriXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriX',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // Core Navigation
        '/': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/upload': (context) => const UploadScreen(),
        '/advice': (context) => const AdviceScreen(),
        '/logbook': (context) => const LogbookScreen(),
        '/loan': (context) => const LoanScreen(),
        
        // Market Module
        '/market': (context) => const MarketScreen(),
        '/market/new': (context) => const MarketItemFormScreen(),      // ✅ Optional
        '/market/detail': (context) => const MarketDetailScreen(),     // ✅ Optional
        '/market/invite': (context) => const MarketInviteScreen(),     // ✅ Optional

        // Contracts
        '/contracts/new': (context) => const ContractOfferFormScreen(),
        '/contracts/list': (context) => const ContractListScreen(),

        // Officers
        '/officer/tasks': (context) => const OfficerTasksScreen(),
        '/officer/assessments': (context) => const OfficerAssessmentsScreen(),

        // Others
        '/investor/register': (context) => const InvestorScreen(),
        '/tips': (context) => const TipsScreen(),
        '/sync': (context) => const SyncScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/chat': (context) => const ChatScreen(),
        '/help': (context) => const HelpScreen(),
        '/agrigpt': (context) => const AgriGPTScreen(),
      },
    );
  }
}
