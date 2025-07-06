import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/advice_screen.dart';
import 'screens/logbook_screen.dart';
import 'screens/loan_screen.dart';
import 'screens/register_screen.dart';
import 'screens/soil_screen.dart';
import 'screens/crops_screen.dart';
import 'screens/livestock_screen.dart';
import 'screens/tips_screen.dart';
import 'screens/agrigpt_screen.dart';
import 'screens/sync_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/market_screen.dart';
import 'screens/market_item_form.dart';
import 'screens/market_detail_screen.dart';
import 'screens/market_invite_screen.dart';
import 'screens/contracts/contract_offer_form.dart';
import 'screens/contracts/contract_list_screen.dart';
import 'screens/investor_screen.dart';
import 'screens/officer_tasks_screen.dart';
import 'screens/officer_assessments_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/help_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => const HomeScreen(),
  '/upload': (_) => const UploadScreen(),
  '/advice': (_) => const AdviceScreen(),
  '/logbook': (_) => const LogbookScreen(),
  '/loan': (_) => const LoanScreen(),
  '/register': (_) => const RegisterScreen(),
  '/soil': (_) => const SoilScreen(),
  '/crops': (_) => const CropsScreen(),
  '/livestock': (_) => const LivestockScreen(),
  '/tips': (_) => const TipsScreen(),
  '/agrigpt': (_) => const AgriGPTScreen(),
  '/sync': (_) => const SyncScreen(),
  '/notifications': (_) => const NotificationsScreen(),

  // Agri Market
  '/market': (_) => const MarketScreen(),
  '/market/new': (_) => const MarketItemFormScreen(),
  '/market/detail': (_) => const MarketDetailScreen(),
  '/market/invite': (_) => const MarketInviteScreen(),

  // Contracts & Investor
  '/contracts/new': (_) => const ContractOfferFormScreen(),
  '/contracts/list': (_) => const ContractListScreen(),
  '/investor/register': (_) => const InvestorScreen(),

  // Agricultural Officer
  '/officer/tasks': (_) => const OfficerTasksScreen(),
  '/officer/assessments': (_) => const OfficerAssessmentsScreen(),

  // Chat & Help
  '/chat': (_) => const ChatScreen(),
  '/help': (_) => const HelpScreen(),
};
