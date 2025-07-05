import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contracts/contract_offer.dart';

class ContractService {
  static const String _storageKey = 'contract_offers';

  // Save list of contract offers
  static Future<void> saveOffers(List<ContractOffer> offers) async {
    final prefs = await SharedPreferences.getInstance();
    final data = offers.map((e) => e.toJson()).toList();
    prefs.setString(_storageKey, jsonEncode(data));
  }

  // Load contract offers
  static Future<List<ContractOffer>> loadOffers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];

    final List<dynamic> decoded = jsonDecode(raw);
    return decoded.map((e) => ContractOffer.fromJson(e)).toList();
  }

  // Add a new contract offer
  static Future<void> addOffer(ContractOffer newOffer) async {
    final offers = await loadOffers();
    offers.add(newOffer);
    await saveOffers(offers);
  }

  // Update existing offer (based on ID)
  static Future<void> updateOffer(ContractOffer updatedOffer) async {
    final offers = await loadOffers();
    final index = offers.indexWhere((e) => e.id == updatedOffer.id);
    if (index != -1) {
      offers[index] = updatedOffer;
      await saveOffers(offers);
    }
  }

  // Delete offer
  static Future<void> deleteOffer(String id) async {
    final offers = await loadOffers();
    offers.removeWhere((e) => e.id == id);
    await saveOffers(offers);
  }

  // Find offer by ID
  static Future<ContractOffer?> getOfferById(String id) async {
    final offers = await loadOffers();
    return offers.firstWhere((e) => e.id == id, orElse: () => null);
  }
}
