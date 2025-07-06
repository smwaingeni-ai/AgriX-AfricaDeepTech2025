import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/loan_screen.dart';
import 'screens/market_screen.dart';
import 'screens/contracts/contract_offer_form.dart';
import 'screens/contracts/contract_list_screen.dart';
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
        '/': (context) => const HomeScreen(),
        '/upload': (context) => const UploadScreen(),
        '/advice': (context) => const AdviceScreen(),
        '/logbook': (context) => const LogbookScreen(),
        '/loan': (context) => const LoanScreen(),
        '/market': (context) => const MarketScreen(),
        '/contracts/new': (context) => const ContractOfferFormScreen(),
        '/contracts/list': (context) => const ContractListScreen(),
        '/investor/register': (context) => const InvestorScreen(),
        '/officer/tasks': (context) => const OfficerTasksScreen(),
        '/officer/assessments': (context) => const OfficerAssessmentsScreen(),
        '/tips': (context) => const TipsScreen(),
        '/sync': (context) => const SyncScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/chat': (context) => const ChatScreen(),
        '/help': (context) => const HelpScreen(),
        '/agrigpt': (context) => const AgriGPTScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
