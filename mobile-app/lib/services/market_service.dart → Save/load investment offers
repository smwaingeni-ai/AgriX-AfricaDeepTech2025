import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/market_item.dart';
import '../models/investment_offer.dart';

class MarketService {
  // File names
  static const String _marketFile = 'market_items.json';
  static const String _offersFile = 'investment_offers.json';

  // MARK: - Market Items

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$filename';
  }

  Future<List<MarketItem>> loadMarketItems() async {
    try {
      final path = await _getFilePath(_marketFile);
      final file = File(path);
      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        return MarketItem.decode(jsonStr);
      }
    } catch (_) {}
    return [];
  }

  Future<void> saveMarketItems(List<MarketItem> items) async {
    final path = await _getFilePath(_marketFile);
    final file = File(path);
    await file.writeAsString(MarketItem.encode(items));
  }

  // MARK: - Investment Offers

  Future<List<InvestmentOffer>> loadInvestmentOffers() async {
    try {
      final path = await _getFilePath(_offersFile);
      final file = File(path);
      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        return InvestmentOffer.decode(jsonStr);
      }
    } catch (_) {}
    return [];
  }

  Future<void> saveInvestmentOffers(List<InvestmentOffer> offers) async {
    final path = await _getFilePath(_offersFile);
    final file = File(path);
    await file.writeAsString(InvestmentOffer.encode(offers));
  }

  // Optional: Append a new offer to existing offers
  Future<void> addInvestmentOffer(InvestmentOffer newOffer) async {
    final offers = await loadInvestmentOffers();
    offers.add(newOffer);
    await saveInvestmentOffers(offers);
  }
}
