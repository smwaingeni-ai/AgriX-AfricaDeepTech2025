import 'dart:convert';

enum ListingType { sale, lease, barter, request }
enum ListingCategory { land, crops, livestock, equipment, services }
enum InvestmentStatus { open, indifferent, closed }

class MarketItem {
  final String id;
  final String title;
  final String description;
  final ListingType type;
  final ListingCategory category;
  final List<String> imagePaths;
  final String location;
  final double price;
  final List<String> paymentOptions;
  final DateTime createdAt;

  // Geolocation
  final double latitude;
  final double longitude;

  // Investment-related fields
  final InvestmentStatus investmentStatus;
  final bool isLoanEligible;
  final bool ministryFinanceRequested;
  final List<String> investorOffers; // Could be investor IDs or offer IDs

  MarketItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.imagePaths,
    required this.location,
    required this.price,
    required this.paymentOptions,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
    required this.investmentStatus,
    required this.isLoanEligible,
    required this.ministryFinanceRequested,
    required this.investorOffers,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type.name,
        'category': category.name,
        'imagePaths': imagePaths,
        'location': location,
        'price': price,
        'paymentOptions': paymentOptions,
        'createdAt': createdAt.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
        'investmentStatus': investmentStatus.name,
        'isLoanEligible': isLoanEligible,
        'ministryFinanceRequested': ministryFinanceRequested,
        'investorOffers': investorOffers,
      };

  factory MarketItem.fromJson(Map<String, dynamic> json) => MarketItem(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        type: ListingType.values.firstWhere((e) => e.name == json['type']),
        category:
            ListingCategory.values.firstWhere((e) => e.name == json['category']),
        imagePaths: List<String>.from(json['imagePaths']),
        location: json['location'],
        price: (json['price'] as num).toDouble(),
        paymentOptions: List<String>.from(json['paymentOptions']),
        createdAt: DateTime.parse(json['createdAt']),
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        investmentStatus: InvestmentStatus.values
            .firstWhere((e) => e.name == json['investmentStatus']),
        isLoanEligible: json['isLoanEligible'],
        ministryFinanceRequested: json['ministryFinanceRequested'],
        investorOffers: List<String>.from(json['investorOffers']),
      );

  static List<MarketItem> decode(String marketJson) =>
      (jsonDecode(marketJson) as List<dynamic>)
          .map<MarketItem>((item) => MarketItem.fromJson(item))
          .toList();

  static String encode(List<MarketItem> items) =>
      jsonEncode(items.map((e) => e.toJson()).toList());
}
