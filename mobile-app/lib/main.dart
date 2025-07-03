import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/app_localizations.dart';

// Core Screens
import 'screens/home_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/transaction_screen.dart';
import 'screens/farmer_registration.dart';
import 'screens/loan_application.dart';

// Diagnostic Screens
import 'screens/soil_screen.dart';
import 'screens/crops_screen.dart';
import 'screens/livestock_screen.dart';

// Feature Screens
import 'screens/tips_screen.dart';
import 'screens/agrigpt_screen.dart';
import 'screens/sync_screen.dart';
import 'screens/notifications_screen.dart';

// Officer Screens
import 'screens/officer_task_screen.dart';
import 'screens/officer_assessment_screen.dart';

// Agri Market Screens
import 'screens/market_screen.dart';
import 'screens/market_item_form.dart';
import 'screens/market_detail_screen.dart';
import 'screens/market_invite_screen.dart';

void main() => runApp(const AgriXApp());

class AgriXApp extends StatelessWidget {
  const AgriXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      locale: const Locale('en'), // Default to English (can be user selected)
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('pt'),
        Locale('sn'),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        // Core Navigation
        '/': (_) => const HomeScreen(),
        '/upload': (_) => const UploadScreen(),
        '/advice': (_) => const AdviceScreen(),
        '/logbook': (_) => const LogbookScreen(),
        '/transaction': (_) => const TransactionScreen(
              result: 'Demo',
              timestamp: '2025-06-30T00:00:00Z',
            ),

        // Farmer & Loans
        '/register': (_) => const FarmerRegistrationScreen(),
        '/loan': (_) => const LoanApplicationScreen(),

        // Diagnosis Categories
        '/soil': (_) => const SoilScreen(),
        '/crops': (_) => const CropsScreen(),
        '/livestock': (_) => const LivestockScreen(),

        // Utility Features
        '/tips': (_) => const TipsScreen(),
        '/agrigpt': (_) => const AgriGPTScreen(),
        '/sync': (_) => const SyncScreen(),
        '/notifications': (_) => const NotificationsScreen(),

        // Officer Functions
        '/officer/tasks': (_) => const OfficerTaskScreen(),
        '/officer/assessments': (_) => const OfficerAssessmentScreen(),

        // Agri Market
        '/market': (_) => const MarketScreen(),
        '/market/new': (_) => const MarketItemFormScreen(),
        '/market/detail': (_) => const MarketDetailScreen(),
        '/market/invite': (_) => const MarketInviteScreen(),
      },
    );
  }
}
