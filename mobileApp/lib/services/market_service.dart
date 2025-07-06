import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/market_item.dart';
import '../models/investment_offer.dart';

class MarketService {
  /// Get file to store market items
  static Future<File> _getMarketFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/market_items.json');
  }

  /// Get file to store investment offers
  static Future<File> _getOffersFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/investment_offers.json');
  }

  /// Save all market items to file
  static Future<void> saveItems(List<MarketItem> items) async {
    final file = await _getMarketFile();
    await file.writeAsString(MarketItem.encodeList(items));
  }

  /// Load all market items from file
  static Future<List<MarketItem>> loadItems() async {
    try {
      final file = await _getMarketFile();
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      return MarketItem.decodeList(contents);
    } catch (e) {
      return [];
    }
  }

  /// Add a new market item
  static Future<void> addItem(MarketItem item) async {
    final items = await loadItems();
    items.add(item);
    await saveItems(items);
  }

  /// Save all investment offers to file
  static Future<void> saveOffers(List<InvestmentOffer> offers) async {
    final file = await _getOffersFile();
    final jsonList = offers.map((e) => e.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }

  /// Load all investment offers from file
  static Future<List<InvestmentOffer>> loadOffers() async {
    try {
      final file = await _getOffersFile();
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      final jsonList = json.decode(contents) as List<dynamic>;
      return jsonList.map((e) => InvestmentOffer.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Add a new investment offer
  static Future<void> addOffer(InvestmentOffer offer) async {
    final offers = await loadOffers();
    offers.add(offer);
    await saveOffers(offers);
  }
}
